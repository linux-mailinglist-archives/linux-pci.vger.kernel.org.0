Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE03254E6
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEUQIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 12:08:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUQIg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 12:08:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D3D374;
        Tue, 21 May 2019 09:08:35 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4E83F718;
        Tue, 21 May 2019 09:08:33 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/4] Initial support for modular IOMMU drivers
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com, bhelgaas@google.com,
        joro@8bytes.org, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <375bd035-23a5-15d0-0629-b11b32a5adfd@arm.com>
Date:   Tue, 21 May 2019 17:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/05/2019 19:47, Isaac J. Manjarres wrote:
> This series adds initial support for being able to use the ARM
> SMMU driver as a loadable kernel module. The series also adds
> to the IOMMU framework, so that it can defer probing for devices
> that depend on an IOMMU driver that may be a loadable module.
> 
> The primary reason behind these changes is that having the ARM
> SMMU driver as a module allows for the same kernel image to be
> used across different platforms. For example, if one platform
> contains an IOMMU that implements one version of the ARM SMMU
> specification, and another platform simply does not have an
> IOMMU, the only way that these platforms can share the same
> kernel image is if the ARM SMMU driver is compiled into the
> kernel image.
> 
> This solution is not scalable, as it will lead to bloating the
> kernel image with support for several future versions of the
> SMMU specification to maintain a common kernel image that works
> across all platforms.

There are currently two versions of the SMMU spec: v2 (which forms a 
superset of v1), and v3 which is the current architecture. Given how 
closely I work with the SMMU architecture team, I'm particularly 
interested to hear more about these "future versions"... :)

> Having the ARM SMMU driver as a module allows
> for a common kernel image to be supported across all platforms,
> while yielding a smaller kernel image size, since the correct
> SMMU driver can be loaded at runtime, if necessary.

arm-smmu and arm-smmu-v3 aren't *all* that much bigger than any of the 
other IOMMU drivers that are also present in a multiplatform build, and 
already share quite a bit of common code, so while I can guess at what 
you might really mean, it's a pretty weak argument as stated.

> Patchset Summary:
> 
> 1. Since the ARM SMMU driver depends on symbols being exported from
> several subsystems, the first three patches are dedicated to exporting
> the necessary symbols.
> 
> 2. Similar to how the pinctrl framework handles deferring probes,
> the subsequent patch makes it so that the IOMMU framework will defer
> probes indefinitely if there is a chance that the IOMMU driver that a
> device is waiting for is a module. Otherwise, it upholds the current
> behavior of stopping probe deferrals once all of the builtin drivers
> have finished probing.
> 
> The ARM SMMU driver currently has support for the deprecated
> "mmu-masters" binding, which relies on the notion of initcall
> ordering for setting the bus ops to ensure that all SMMU devices
> have been bound to the driver. This poses a problem with
> making the driver a module, as there is no such notion with
> loadable modules. Will support for this be completely deprecated?
> If not, might it be useful to leverage the device tree ordering,
> and assign a property to the last SMMU device, and set the bus ops
> at that point? Or perhaps have some deferred timer based approach
> to know when to set the bus ops?

Unfortunately, I believe the old binding is still deployed in production 
firmwares which may well never get updated, and thus needs to remain 
functional (I've already had one report of the default bypass behaviour 
breaking it in 5.2 which I need to fix somehow...)

Rather than just the trivial "export a bunch of symbols which won't 
actually be needed yet", from the title I was hoping to see some patches 
really making drivers modular and proposing solutions to those difficult 
problems of making it work robustly. It's very easy to make it 'work' as 
a proof-of-concept (locally I still have a patch dated 2016 based on the 
original probe-deferral work), but those questions really want answering 
to some degree before it's worth doing any of this in mainline.

Robin.

(now starting to wonder whether this might be my own fault for 
mentioning it at LPC... :P)

> 
> Thanks,
> Isaac
> 
> Isaac J. Manjarres (4):
>    of: Export of_phandle_iterator_args() to modules
>    PCI: Export PCI ACS and DMA searching functions to modules
>    iommu: Export core IOMMU functions to kernel modules
>    iommu: Add probe deferral support for IOMMU kernel modules
> 
>   drivers/iommu/iommu-sysfs.c | 3 +++
>   drivers/iommu/iommu.c       | 6 ++++++
>   drivers/iommu/of_iommu.c    | 8 ++++++--
>   drivers/of/base.c           | 1 +
>   drivers/pci/pci.c           | 1 +
>   drivers/pci/search.c        | 1 +
>   6 files changed, 18 insertions(+), 2 deletions(-)
> 
