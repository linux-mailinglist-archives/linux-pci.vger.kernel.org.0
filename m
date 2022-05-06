Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E051E010
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 22:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbiEFUVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 16:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiEFUVM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 16:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD464725
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 13:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F497B83945
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 20:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3D5C385A8;
        Fri,  6 May 2022 20:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651868244;
        bh=OmjI2XCL4fTldCAIC0FtoHQghW1E611IMOnivnt6Q9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E357CrUptmg2XtIbr1Up4PiUggZncPkf5F2zRbVysQi4etyne1ypPo/+4e7hWMdF0
         iMYaUj6vTRpLHaotWFUKXE18X+tON8Wqg5peQMaWKf5Yi5+6uzKFNw9IPXgo6EYugU
         qRweyco/GfQRUYg3d0i3cvofjtBJa1B2Y6/YGy7MxFMP6zekUUwkSe6XvTVDiOAxSj
         6hrxaNU3NdVKEIw5Nl9znPIU0jYwoMP5hBiHKyTO325SL+4/ZGIVcQx3jp+1SN2PMa
         g5Mk0qFqh1XMGZ0SyXnUopuHWmAnsXs57L4BkS6hFJx+JZOgY9RK7sORkJHiq+UmYg
         K12j69Y+OpyZA==
Date:   Fri, 6 May 2022 15:17:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220506201722.GA555374@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6bxm5vm.fsf@epam.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Leon, Jason]

On Wed, May 04, 2022 at 07:56:01PM +0000, Volodymyr Babchuk wrote:
> 
> Hello,
> 
> I have encountered issue when PCI code tries to use both fields in
> 
>         union {
> 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
> 		struct pci_dev		*physfn;	/* VF: related PF */
> 	};
> 
> (which are part of struct pci_dev) at the same time.
> 
> Symptoms are following:
> 
> # echo 1 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs
> 
> pci 0000:01:00.2: reg 0x20c: [mem 0x30018000-0x3001ffff 64bit]
> pci 0000:01:00.2: VF(n) BAR0 space: [mem 0x30018000-0x30117fff 64bit] (contains BAR0 for 32 VFs)
>  Unable to handle kernel paging request at virtual address 0001000200000010
>  Mem abort info:
>    ESR = 0x96000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  [0001000200000010] address between user and kernel address ranges
>  Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
> pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
>  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
>  Hardware name: XENVM-4.17 (DT)
>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>  pc : pcie_aspm_get_link+0x90/0xcc
>  lr : pcie_aspm_get_link+0x8c/0xcc
>  sp : ffff8000130d39c0
>  x29: ffff8000130d39c0 x28: 00000000000001a4
>  x27: 00000000ffffee4b x26: ffff80001164f560
>  x25: 0000000000000000 x24: 0000000000000000
>  x23: ffff80001164f660 x22: 0000000000000000
>  x23: ffff80001164f660 x22: 0000000000000000
>  x21: ffff000003f08000 x20: ffff800010db37d8
>  x19: ffff000004b8e780 x18: ffffffffffffffff
>  x17: 0000000000000000 x16: 00000000deadbeef
>  x15: ffff8000930d36c7 x14: 0000000000000006
>  x13: ffff8000115c2710 x12: 000000000000081c
>  x11: 00000000000002b4 x10: ffff8000115c2710
>  x9 : ffff8000115c2710 x8 : 00000000ffffefff
>  x7 : ffff80001161a710 x6 : ffff80001161a710
>  x5 : ffff00003fdad900 x4 : 0000000000000000
>  x3 : 0000000000000000 x2 : 0000000000000000
>  x1 : ffff000003c51c80 x0 : 0001000200000000
>  Call trace:
>   pcie_aspm_get_link+0x90/0xcc
>   aspm_ctrl_attrs_are_visible+0x30/0xc0
>   internal_create_group+0xd0/0x3cc
>   internal_create_groups.part.0+0x4c/0xc0
>   sysfs_create_groups+0x20/0x34
>   device_add+0x2b4/0x760
>   pci_device_add+0x814/0x854
>   pci_iov_add_virtfn+0x240/0x2f0
>   sriov_enable+0x1f8/0x474
>   pci_sriov_configure_simple+0x38/0x90
>   sriov_numvfs_store+0xa4/0x1a0
>   dev_attr_store+0x1c/0x30
>   sysfs_kf_write+0x48/0x60
>   kernfs_fop_write_iter+0x118/0x1ac
>   new_sync_write+0xe8/0x184
>   vfs_write+0x23c/0x2a0
>   ksys_write+0x68/0xf4
>   __arm64_sys_write+0x20/0x2c
>   el0_svc_common.constprop.0+0x78/0x1a0
>   do_el0_svc+0x28/0x94
>   el0_svc+0x14/0x20
>   el0_sync_handler+0xa4/0x130
>   el0_sync+0x180/0x1c0
> Code: d0002120 9133e000 97ffef8e f9400a60 (f9400813)
> 
> 
> Debugging showed the following:
> 
> pci_iov_add_virtfn() allocates new struct pci_dev:
> 
> 	virtfn = pci_alloc_dev(bus);
> and sets physfn:
> 	virtfn->is_virtfn = 1;
> 	virtfn->physfn = pci_dev_get(dev);
> 
> then we will get into sriov_init() via the following call path:
> 
> pci_device_add(virtfn, virtfn->bus);
>   pci_init_capabilities(dev);
>     pci_iov_init(dev);
>       sriov_init(dev, pos);

We called pci_device_add() with the VF.  pci_iov_init() only calls
sriov_init() if it finds an SR-IOV capability on the device:

  pci_iov_init(struct pci_dev *dev)
    pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
    if (pos)
      return sriov_init(dev, pos);

So this means the VF must have an SR-IOV capability, which sounds a
little dubious.  From PCIe r6.0:

  9.3.3 SR-IOV Extended Capability

  The SR-IOV Extended Capability defined here is a PCIe extended
  capability that must be implemented in each PF that supports SR-IOV.
  This Capability is used to describe and control a PF’s SR-IOV
  Capabilities.

  For Multi-Function Devices, each PF that supports SR-IOV shall
  provide the Capability structure defined in this section.  This
  Capability structure may be present in any Function with a Type 0
  Configuration Space Header. This Capability must not be present in
  Functions with a Type 1 Configuration Space Header.

Can you supply the output of "sudo lspci -vv" for your system?

It could be that the device has an SR-IOV capability when it
shouldn't.  But even if it does, Linux could tolerate that better
than it does today.

> sriov_init() overwrites value in the union:
> 	dev->sriov = iov; <<<<<---- There
> 	dev->is_physfn = 1;
> 
> Next, we will get into function that causes panic:
> 
> pci_device_add(virtfn, virtfn->bus);
>   device_add(&dev->dev)
>     sysfs_create_groups()
>       internal_create_group()
>         aspm_ctrl_attrs_are_visible()
>           pcie_aspm_get_link()
>             pci_upstream_bridge()
>               pci_physfn()
> 
> which is
> 
> static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> {
> #ifdef CONFIG_PCI_IOV
> 	if (dev->is_virtfn)
> 		dev = dev->physfn;
> #endif
> 	return dev;
> }
> 
> 
> as is_virtfn == 1 and dev->physfn was overwritten via write to
> dev->sriov, pci_physfn() will return pointer to struct pci_sriov
> allocated by sriov_init(). And then pci_upstream_bridge() will
> cause panic by acessing it as if it were pointer to struct pci_dev
> 
> I encountered this issue on ARM64, Linux 5.10.41. Tried to test
> on master branch, but it is quite difficult to rebase platform
> code on the master. But I compared all relevant parts of PCI code
> and didn't found any differences.
> 
> Looks like I am missing following, because how SR-IOV can be so broken?
> But what exactly?
> 
> -- 
> Volodymyr Babchuk at EPAM
