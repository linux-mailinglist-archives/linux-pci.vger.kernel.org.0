Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF03C82D4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 12:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhGNKcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 06:32:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237788AbhGNKcL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51AFAD6E;
        Wed, 14 Jul 2021 03:29:19 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FA73F774;
        Wed, 14 Jul 2021 03:29:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Jonathan Corbet <corbet@lwn.net>, quic_c_gdjako@quicinc.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org> <edd1de35-5b9e-b679-9428-23c6d5005740@arm.com>
 <YO65OOScL5vru1Kr@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <255adda2-3b5f-b080-4da1-f3c5d5a4f7a6@arm.com>
Date:   Wed, 14 Jul 2021 11:29:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO65OOScL5vru1Kr@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-07-14 11:15, Joerg Roedel wrote:
> Hi Robin,
> 
> On Fri, Jul 09, 2021 at 02:56:47PM +0100, Robin Murphy wrote:
>> As I mentioned before, conceptually I think this very much belongs in sysfs
>> as a user decision. We essentially have 4 levels of "strictness":
>>
>> 1: DMA domain with bounce pages
>> 2: DMA domain
>> 3: DMA domain with flush queue
>> 4: Identity domain
> 
> Together with reasonable defaults (influenced by compile-time
> options) it seems to be a good thing to configure at runtime via
> sysfs.
> 
> We already have CONFIG_IOMMU_DEFAULT_PASSTHROUGH, which can probably be
> extended to be an option list:
> 
> 	- CONFIG_IOMMU_DEFAULT_PASSTHROUGH: Trusted devices are identity
> 					    mapped
> 
> 	- CONFIG_IOMMU_DEFAULT_DMA_STRICT: Trusted devices are DMA
> 					   mapped with strict flush
> 					   behavior on unmap
> 
> 	- CONFIG_IOMMU_DEFAULT_DMA_LAZY: Trusted devices are DMA mapped
> 					 with flush queues for performance

Indeed, I got focused on the sysfs angle, but rearranging the Kconfig 
default that way to match makes a lot of sense, and is another thing 
which should fall out really easily from my domain type rework, so I'll 
add that to my branch now before I forget again.

> Untrusted devices always get into the DMA domain with bounce pages by
> default.
> 
> The defaults can be changed at runtime via sysfs. We already have basic
> support for runtime switching of the default domain, so that can be
> re-used.

As mentioned yesterday, already done! I'm hoping to be able to post the 
patches next week after some testing :)

Cheers,
Robin.
