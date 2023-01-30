Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595B3681978
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 19:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjA3SjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 13:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjA3SjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 13:39:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173A34C03;
        Mon, 30 Jan 2023 10:38:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C710E6121E;
        Mon, 30 Jan 2023 18:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E0AC433D2;
        Mon, 30 Jan 2023 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675103892;
        bh=PTMzmxQ4JcPyLK3GX6Ihg8/o4WwLIyzxGJcEQJC4KwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c5Qjg9ucC3+lotDRqBtfnRo2T2uE8zAtlCe6+mH97EjC0NYu+o0tMXQCA4XihyoKu
         sFWZ08a7LEMCQcNZ8LLTyiFknVrP7U8fZeKbz5OmvrcN1S47SXrcfrocehYmzlhlxg
         NNOpmhLtUaQlkCJzu0ZrAn9lH/sJisDRmk/EGC1xC7NoxGQlQBv+hiHMC4/A6TnC32
         ucNo0yHgAN3JwVJgAaRE3vRPEAo1h+UUlypYrPl0UyyS+/d02lR4AB/HQbR8+ihF5d
         uKt7ujmBrDFxUWJT52uWP1PjEg1fN/DMfliuLbrLUDdA/Fn35E1oOpix+QC/ev1+W4
         UDrRr4ksEJgAQ==
Date:   Mon, 30 Jan 2023 12:38:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230130183810.GA1692786@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647de371-fe11-15b4-5e11-8ca43a754180@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 29, 2023 at 04:42:32PM +0800, Baolu Lu wrote:
> On 2023/1/28 1:30, Bjorn Helgaas wrote:
> > On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
> > > The PCIe fabric routes Memory Requests based on the TLP address, ignoring
> > > the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
> > > Enable PASID only when ACS RR & UF enabled on upstream path") requires
> > > some ACS features being supported on device's upstream path when enabling
> > > PCI/PASID.
> > > 
> > > One alternative is ATS/PRI which lets the device resolve the PASID + addr
> > > pair before a memory request is made into a routeable TLB address through
> > > the translation agent.
> > 
> > This sounds like "ATS/PRI" is a solution to a problem, but we haven't
> > stated the problem yet.
> > 
> > > Those resolved addresses are then cached on the
> > > device instead of in the IOMMU TLB and the device always sets translated
> > > bit for PASID. One example of those devices are AMD graphic devices that
> > > always have ACS or ATS/PRI enabled together with PASID.
> > > 
> > > This adds a flag parameter in the pci_enable_pasid() helper, with which
> > > the device driver could opt-in the fact that device always sets the
> > > translated bit for PASID.
> > >
> > > It also applies this opt-in for AMD graphic devices. Without this change,
> > > kernel boots to black screen on a system with below AMD graphic device:
> > > 
> > > 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >          [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
> > >          (prog-if 00 [VGA controller])
> > > 	DeviceName: ATI EG BROADWAY
> > > 	Subsystem: Hewlett-Packard Company Device 8332
> > 
> > What is the underlying failure here?  "Black screen" is useful but we
> > should say *why* that happens, e.g., transactions went the wrong place
> > or whatever.

> > I guess PCI_PASID_XLATED_REQ_ONLY is something only the driver knows,
> > right?  We can't deduce from architected config space that the device
> > will produce PASID prefixes for every Memory Request, can we?
> 
> No, we can't. That's the reason why we need a flag here.

Sorry, I'm still confused.  PCI_PASID_XLATED_REQ_ONLY is a
device-specific property, and you want to opt-in AMD graphics devices.
Where's the AMD graphics-specific change?  The current patch does
this:

  pdev_pri_ats_enable
    pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY)

which looks like it does it for *all* devices below an AMD IOMMU,
without any device or driver input.

PCIe r6.0, sec 6.20.1:

  A Function is not permitted to generate Requests using Translated
  Addresses and a PASID unless both PASID Enable and Translated
  Requests with PASID Enable are Set.

You want AMD graphics devices to do DMA with translated addresses and
PASID, right?  pci_enable_pasid() sets PASID Enable
(PCI_PASID_CTRL_ENABLE), but I don't see where "Translated Requests
with PASID Enable" is set.  We don't even have a #define for it.

I would think we should check "Translated Requests with PASID
Supported" before setting "Translated Requests with PASID Enable",
too?

> PCI: Add translated request only flag for pci_enable_pasid()
> 
> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
> Enable PASID only when ACS RR & UF enabled on upstream path") requires
> some ACS features being supported on device's upstream path when enabling
> PCI/PASID.
> 
> However, above change causes the Linux kernel boots to black screen on a
> system with below graphic device:

We need a PCIe concept-level description of the issue first, i.e., in
terms of DMA, PASID, ACS, etc.  Then we can mention the AMD GPU issue
as an instance.

> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>         (prog-if 00 [VGA controller])
>         DeviceName: ATI EG BROADWAY
>         Subsystem: Hewlett-Packard Company Device 8332
> 
> The kernel trace looks like below:
> 
>  Call Trace:
>   <TASK>
>   amd_iommu_attach_device+0x2e0/0x300
>   __iommu_attach_device+0x1b/0x90
>   iommu_attach_group+0x65/0xa0
>   amd_iommu_init_device+0x16b/0x250 [iommu_v2]
>   kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
>   kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
>   kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
>   amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
>   amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
>   ? _raw_spin_lock_irqsave+0x23/0x50
>   amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>   amdgpu_pci_probe+0x161/0x370 [amdgpu]
>   local_pci_probe+0x41/0x80
>   pci_device_probe+0xb3/0x220
>   really_probe+0xde/0x380
>   ? pm_runtime_barrier+0x50/0x90
>   __driver_probe_device+0x78/0x170
>   driver_probe_device+0x1f/0x90
>   __driver_attach+0xce/0x1c0
>   ? __pfx___driver_attach+0x10/0x10
>   bus_for_each_dev+0x73/0xa0
>   bus_add_driver+0x1ae/0x200
>   driver_register+0x89/0xe0
>   ? __pfx_init_module+0x10/0x10 [amdgpu]
>   do_one_initcall+0x59/0x230
>   do_init_module+0x4a/0x200
>   __do_sys_init_module+0x157/0x180
>   do_syscall_64+0x5b/0x80
>   ? handle_mm_fault+0xff/0x2f0
>   ? do_user_addr_fault+0x1ef/0x690
>   ? exc_page_fault+0x70/0x170
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc

The stack trace doesn't seem like it shows a failure, so I'm not sure
it's useful this time.  If it is, we can at least strip out the
irrelevant pieces.

> The AMD iommu driver allocates a new domain (called v2 domain) for the

"v2 domain" needs to be something greppable -- an identifier,
filename, etc.

> amdgpu device and enables its PCI PASID/ATS/PRI before attaching the
> v2 domain to it. The failure of pci_enable_pasid() due to lack of ACS
> causes the domain attaching device to fail. The amdgpu device is unable
> to DMA normally, resulting in a black screen of the system.
> 
> However, this device is special as it relies on ATS/PRI to resolve the
> PASID + addr pair before a memory request is made into a routeable TLB
> address through the translation agent. Those resolved addresses are then
> cached on the device instead of in the IOMMU TLB and the device always
> uses translated memory request for PASID.
> 
> ACS is not necessary for the devices that always use translated memory
> request for PASID. But this is device specific and only device driver
> knows this. We can't deduce this from architected config space.
> 
> Add a flag for pci_enable_pasid(), with which the device drivers could
> opt-in the fact that device always uses translated memory requests for
> PASID hence the ACS is not a necessity. Apply this opt-in for above AMD
> graphic device.
> 
> At present, it is a common practice to enable/disable PCI PASID in the
> iommu drivers. Considering that the device driver knows more about the
> specific device, it's better to move pci_enable_pasid() into the specific
> device drivers.
> [-- end --]
> 
> --
> Best regards,
> baolu
