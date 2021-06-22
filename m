Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C13B02D7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVLh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 07:37:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhFVLh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 07:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11DF31B;
        Tue, 22 Jun 2021 04:35:39 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDAF3F694;
        Tue, 22 Jun 2021 04:35:35 -0700 (PDT)
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     Douglas Anderson <dianders@chromium.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, joro@8bytes.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20210621235248.2521620-1-dianders@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
Date:   Tue, 22 Jun 2021 12:35:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Doug,

On 2021-06-22 00:52, Douglas Anderson wrote:
> 
> This patch attempts to put forward a proposal for enabling non-strict
> DMA on a device-by-device basis. The patch series requests non-strict
> DMA for the Qualcomm SDHCI controller as a first device to enable,
> getting a nice bump in performance with what's believed to be a very
> small drop in security / safety (see the patch for the full argument).
> 
> As part of this patch series I am end up slightly cleaning up some of
> the interactions between the PCI subsystem and the IOMMU subsystem but
> I don't go all the way to fully remove all the tentacles. Specifically
> this patch series only concerns itself with a single aspect: strict
> vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> to talk about / reason about for more subsystems compared to overall
> deciding what it means for a device to be "external" or "untrusted".
> 
> If something like this patch series ends up being landable, it will
> undoubtedly need coordination between many maintainers to land. I
> believe it's fully bisectable but later patches in the series
> definitely depend on earlier ones. Sorry for the long CC list. :(

Unfortunately, this doesn't work. In normal operation, the default 
domains should be established long before individual drivers are even 
loaded (if they are modules), let alone anywhere near probing. The fact 
that iommu_probe_device() sometimes gets called far too late off the 
back of driver probe is an unfortunate artefact of the original 
probe-deferral scheme, and causes other problems like potentially 
malformed groups - I've been forming a plan to fix that for a while now, 
so I for one really can't condone anything trying to rely on it. 
Non-deterministic behaviour based on driver probe order for multi-device 
groups is part of the existing problem, and your proposal seems equally 
vulnerable to that too.

FWIW we already have a go-faster knob for people who want to tweak the 
security/performance compromise for specific devices, namely the sysfs 
interface for changing a group's domain type before binding the relevant 
driver(s). Is that something you could use in your application, say from 
an initramfs script?

Thanks,
Robin.

> Douglas Anderson (6):
>    drivers: base: Add the concept of "pre_probe" to drivers
>    drivers: base: Add bits to struct device to control iommu strictness
>    PCI: Indicate that we want to force strict DMA for untrusted devices
>    iommu: Combine device strictness requests with the global default
>    iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
>    mmc: sdhci-msm: Request non-strict IOMMU mode
> 
>   drivers/base/dd.c             | 10 +++++--
>   drivers/iommu/dma-iommu.c     |  2 +-
>   drivers/iommu/iommu.c         | 56 +++++++++++++++++++++++++++--------
>   drivers/mmc/host/sdhci-msm.c  |  8 +++++
>   drivers/pci/probe.c           |  4 ++-
>   include/linux/device.h        | 11 +++++++
>   include/linux/device/driver.h |  9 ++++++
>   include/linux/iommu.h         |  2 ++
>   8 files changed, 85 insertions(+), 17 deletions(-)
> 
