Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2165A254DE
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfEUQHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 12:07:45 -0400
Received: from foss.arm.com ([217.140.101.70]:37874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfEUQHp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 12:07:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF7F15A2;
        Tue, 21 May 2019 09:07:44 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A22B3F718;
        Tue, 21 May 2019 09:07:42 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC/PATCH 0/4] Initial support for modular IOMMU drivers
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, robin.murphy@arm.com, joro@8bytes.org,
        will.deacon@arm.com, lmark@codeaurora.org, robh+dt@kernel.org,
        bhelgaas@google.com, frowand.list@gmail.com, pratikp@codeaurora.org
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Message-ID: <2379c1cf-be1b-503f-7dbc-51110650e91f@arm.com>
Date:   Tue, 21 May 2019 17:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Isaac,

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
> across all platforms. Having the ARM SMMU driver as a module allows
> for a common kernel image to be supported across all platforms,
> while yielding a smaller kernel image size, since the correct
> SMMU driver can be loaded at runtime, if necessary.

It can also be useful if IOMMU drivers want to rely on components that
distros usually build as modules. I have that problem with virtio-iommu,
where the whole virtio transport is usually modular.

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

Another problem is module unloading: if the user calls rmmod on an IOMMU
module, we have to ensure that endpoints aren't performing DMA anymore.
It could be solved by declaring consumers of an IOMMU with
device_link_add(), so that device drivers are unbound before the IOMMU
module is unloaded.

Thanks,
Jean

> 
> Thanks,
> Isaac
> 
> Isaac J. Manjarres (4):
>   of: Export of_phandle_iterator_args() to modules
>   PCI: Export PCI ACS and DMA searching functions to modules
>   iommu: Export core IOMMU functions to kernel modules
>   iommu: Add probe deferral support for IOMMU kernel modules
> 
>  drivers/iommu/iommu-sysfs.c | 3 +++
>  drivers/iommu/iommu.c       | 6 ++++++
>  drivers/iommu/of_iommu.c    | 8 ++++++--
>  drivers/of/base.c           | 1 +
>  drivers/pci/pci.c           | 1 +
>  drivers/pci/search.c        | 1 +
>  6 files changed, 18 insertions(+), 2 deletions(-)
> 

