Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D213C2989
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGITYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 15:24:42 -0400
Received: from foss.arm.com ([217.140.110.172]:58602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhGITYl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 15:24:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3396531B;
        Fri,  9 Jul 2021 12:21:57 -0700 (PDT)
Received: from [10.57.33.207] (unknown [10.57.33.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38DD3F66F;
        Fri,  9 Jul 2021 12:21:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Joerg Roedel <joro@8bytes.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0a2042ff-1604-d32d-35a7-d4df8f591459@arm.com>
Date:   Fri, 9 Jul 2021 20:21:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOaymBHc4g2cIfRn@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-07-08 09:08, Joerg Roedel wrote:
> On Wed, Jul 07, 2021 at 01:00:13PM -0700, Doug Anderson wrote:
>> a) Nothing is inherently broken with my current approach.
>>
>> b) My current approach doesn't make anybody terribly upset even if
>> nobody is totally in love with it.
> 
> Well, no, sorry :)
> 
> I don't think it is a good idea to allow drivers to opt-out of the
> strict-setting. This is a platform or user decision, and the driver
> should accept whatever it gets.
> 
> So the real question is still why strict is the default setting and how
> to change that.

It's occurred to me whilst hacking on the relevant area that there's an 
important point I may have somewhat glossed over there: most of the 
IOMMU drivers that are used for arm64 do not take advantage of 
non-strict mode anyway. If anything it would be detrimental, since 
iommu-dma would waste a bunch of time and memory managing flush queues 
and firing off the batch invalidations while internally the drivers are 
still invalidating each unmap synchronously.

Those IOMMUs in mobile and embedded SoCs are also mostly used for media 
devices, where the buffers are relatively large and change relatively 
infrequently, so they are less likely to gain significantly from 
supporting non-strict mode. It's primarily the Arm SMMUs which get used 
in the more "x86-like" paradigm (especially in larger systems) of being 
stuck in front of everything including networking/storage/PCIe/etc. 
where the workloads are far more varied.

Robin.

> Or document for the users that want performance how to
> change the setting, so that they can decide.
> 
> Regards,
> 
> 	Joerg
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
