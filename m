Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C83BDDE8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGFTRB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 15:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231727AbhGFTRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 15:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B79260FEE;
        Tue,  6 Jul 2021 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625598861;
        bh=QlBKfCu996qP5JenUg1J68Cu2xyoSjshlo1u0WQ5l4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TU5TtD5UIfY0r+aXmb18IJawcVy9481TeWFSQOFYJdeGslFF5REp8bH73BojUcAOS
         WlHc4LPuYi7chvxRgoEbHiUmVBJCPC7C5tF6pdGMxY91712ZIHIFWEljUXECaizwR+
         koaeta5RgZiHx0Sss+0r3QJAYmQBlDDtVdoZp0FeXJcOVflgaIqK1qCkplXl/uW0BS
         LCRRvULfQJWTmzcODhL8YcjXYnyWkDWBHwYJN74M0CyF9fd7kjSS4G13Z+1zJxm7S+
         SxqHpxzj/Vqq6tNxTCJBSiyuyZK+lbgOtwblLLeGRCpsIt4FpxqITodwMfqKGzStS2
         aVPLPXphc2cDw==
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, heikki.krogerus@linux.intel.com,
        thomas.hellstrom@linux.intel.com, peterz@infradead.org,
        benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
        dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
        grant.likely@arm.com, paulus@samba.org,
        Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Jianxiong Gao <jxgao@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
        Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claire Chang <tientzu@chromium.org>,
        boris.ostrovsky@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jgross@suse.com, Nicolas Boichat <drinkcat@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
        Tom Lendacky <thomas.lendacky@amd.com>, bauerman@linux.ibm.com
References: <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org>
 <20210702135856.GB11132@willie-the-truck>
 <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com>
 <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
 <20210705190352.GA19461@willie-the-truck> <20210706044848.GA13640@lst.de>
 <20210706132422.GA20327@willie-the-truck>
 <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
 <20210706140513.GA26498@lst.de>
 <bb32d5a6-2b34-4524-e171-3e9f5f4d3a94@arm.com>
 <20210706170657.GD20750@willie-the-truck>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <e1c026c6-22c7-8979-4941-de9cfab3863a@kernel.org>
Date:   Tue, 6 Jul 2021 12:14:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706170657.GD20750@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will and Robin,

On 7/6/2021 10:06 AM, Will Deacon wrote:
> On Tue, Jul 06, 2021 at 04:39:11PM +0100, Robin Murphy wrote:
>> On 2021-07-06 15:05, Christoph Hellwig wrote:
>>> On Tue, Jul 06, 2021 at 03:01:04PM +0100, Robin Murphy wrote:
>>>> FWIW I was pondering the question of whether to do something along those
>>>> lines or just scrap the default assignment entirely, so since I hadn't got
>>>> round to saying that I've gone ahead and hacked up the alternative
>>>> (similarly untested) for comparison :)
>>>>
>>>> TBH I'm still not sure which one I prefer...
>>>
>>> Claire did implement something like your suggestion originally, but
>>> I don't really like it as it doesn't scale for adding multiple global
>>> pools, e.g. for the 64-bit addressable one for the various encrypted
>>> secure guest schemes.
>>
>> Ah yes, that had slipped my mind, and it's a fair point indeed. Since we're
>> not concerned with a minimal fix for backports anyway I'm more than happy to
>> focus on Will's approach. Another thing is that that looks to take us a
>> quiet step closer to the possibility of dynamically resizing a SWIOTLB pool,
>> which is something that some of the hypervisor protection schemes looking to
>> build on top of this series may want to explore at some point.
> 
> Ok, I'll split that nasty diff I posted up into a reviewable series and we
> can take it from there.

For what it's worth, I attempted to boot Will's diff on top of Konrad's 
devel/for-linus-5.14 and it did not work; in fact, I got no output on my 
monitor period, even with earlyprintk=, and I do not think this machine 
has a serial console.

Robin's fix does work, it survived ten reboots with no issues getting to 
X and I do not see the KASAN and slub debug messages anymore but I 
understand that this is not the preferred solution it seems (although 
Konrad did want to know if it works).

I am happy to test any further patches or follow ups as needed, just 
keep me on CC.

Cheers,
Nathan
