Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E863B0BCC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhFVRss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 13:48:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3301 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhFVRsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 13:48:38 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G8YTv621Sz6H7Gp;
        Wed, 23 Jun 2021 01:36:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 19:46:19 +0200
Received: from [10.47.89.126] (10.47.89.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 22 Jun
 2021 18:46:18 +0100
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     Douglas Anderson <dianders@chromium.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <bhelgaas@google.com>
CC:     <robdclark@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_c_gdjako@quicinc.com>,
        <iommu@lists.linux-foundation.org>, <sonnyrao@chromium.org>,
        <saiprakash.ranjan@codeaurora.org>, <linux-mmc@vger.kernel.org>,
        <vbadigan@codeaurora.org>, <rajatja@google.com>,
        <saravanak@google.com>, <joel@joelfernandes.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f3078ff2-97a6-6029-b584-1589ed184579@huawei.com>
Date:   Tue, 22 Jun 2021 18:39:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.126]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/06/2021 00:52, Douglas Anderson wrote:
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
> 

JFYI, In case to missed it, and I know it's not the same thing as you 
want, above, but the following series will allow you to build the kernel 
to default to lazy mode:

https://lore.kernel.org/linux-iommu/1624016058-189713-1-git-send-email-john.garry@huawei.com/T/#m21bc07b9353b3ba85f2a40557645c2bcc13cbb3e

So iommu.strict=0 would be no longer always required for arm64.

Thanks,
John


> 
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

