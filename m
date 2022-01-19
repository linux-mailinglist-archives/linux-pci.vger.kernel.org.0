Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98D3493ED5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbiASRKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 12:10:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:48389 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243695AbiASRKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jan 2022 12:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642612249; x=1674148249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czIXLfz+xFZ4go4OnoVtPqF0Qw4jHbKF0keWTKNiebA=;
  b=awucI4upt90w1JOLVs/iSAECRb91OUEUKRN3no82s5S293+bBtX7PVug
   zpeDE74cBbOfdLu7Di9tPxtnz+Tgqg3ojTsb0+gZx8xB9/rZp0UFJGE2b
   sqrjok82oa6FPVHoPAwuYTg7UYXMua4CLl3ofGG2wtJll593lDPbb6LdJ
   HcElaKZOaHrK3J9sHpWaoyHHugBG73EWoXohp575FurKwahvEoJMZH1Fy
   C3d0gxaDMwDFRDMUJEnUc+FNf4vGoIL44vbRaPHL+/OZt8SVI9t9FToJf
   hw+L7yh4bKsSc/qsb4++LC6I4ZnKZJTphGi08uk724olv6gkMEPSlixXW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245074403"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="245074403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 09:10:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="532375959"
Received: from lmaniak-dev.igk.intel.com ([10.55.249.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 09:10:46 -0800
Date:   Wed, 19 Jan 2022 18:09:20 +0100
From:   Lukasz Maniak <lukasz.maniak@linux.intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, yangyicong@hisilicon.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
Message-ID: <20220119170920.GB166109@lmaniak-dev.igk.intel.com>
References: <20220117225542.GA813284@bhelgaas>
 <e4483576-cafb-6ba2-a98f-8b7bdcead80d@huawei.com>
 <20220118163054.GA8392@lmaniak-dev.igk.intel.com>
 <b1ad6220-cdc0-1058-6885-9c5b48441837@huawei.com>
 <f0831ca3-3c41-9c11-9e7a-267753f9f1fa@huawei.com>
 <20220119160655.GA166109@lmaniak-dev.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119160655.GA166109@lmaniak-dev.igk.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 19, 2022 at 05:06:55PM +0100, Lukasz Maniak wrote:
> On Wed, Jan 19, 2022 at 06:22:07PM +0800, Yicong Yang wrote:
> > Hi Lukasz, Bjorn,
> > 
> > FYI, I tested with Mellanox CX-5, the VF also exists after FLR. Here's the operation:
> 

Please disregard my previous email. I missed your point.
I take it that the Mellanox CX-5 also violates the spec.

As for using pci_disable_sriov() I did a test to get a backtrace for
deadlock:
[  846.904248] Call Trace:
[  846.904251]  <TASK>
[  846.904272]  __schedule+0x302/0x950
[  846.904282]  schedule+0x58/0xd0
[  846.904286]  pci_wait_cfg+0x63/0xb0
[  846.904290]  ? wait_woken+0x70/0x70
[  846.904296]  pci_cfg_access_lock+0x48/0x50
[  846.904300]  sriov_disable+0x4d/0xf0
[  846.904306]  pci_disable_sriov+0x26/0x30
[  846.904310]  pcie_flr+0x2b/0x100
[  846.904317]  pcie_reset_flr+0x25/0x30
[  846.904322]  __pci_reset_function_locked+0x42/0x60
[  846.904327]  pci_reset_function+0x40/0x70
[  846.904334]  reset_store+0x5c/0xa0
[  846.904347]  dev_attr_store+0x17/0x30
[  846.904357]  sysfs_kf_write+0x3f/0x50
[  846.904365]  kernfs_fop_write_iter+0x13b/0x1d0
[  846.904371]  new_sync_write+0x117/0x1b0
[  846.904379]  vfs_write+0x219/0x2b0
[  846.904384]  ksys_write+0x67/0xe0
[  846.904390]  __x64_sys_write+0x1a/0x20
[  846.904395]  do_syscall_64+0x5c/0xc0
[  846.904401]  ? debug_smp_processor_id+0x17/0x20
[  846.904406]  ? fpregs_assert_state_consistent+0x26/0x50
[  846.904413]  ? exit_to_user_mode_prepare+0x3f/0x1b0
[  846.904418]  ? irqentry_exit_to_user_mode+0x9/0x20
[  846.904423]  ? irqentry_exit+0x33/0x40
[  846.904427]  ? exc_page_fault+0x89/0x180
[  846.904431]  ? asm_exc_page_fault+0x8/0x30
[  846.904438]  entry_SYSCALL_64_after_hwframe+0x44/0xae

As can be noticed during FLR we are already on a locked path for the
device in __pci_reset_function_locked(). In addition, the device will reset
the BARs during FLR on its own.

If we still would like to use pci_disable_sriov() for this purpose we
need to pass a flag to sriov_disable() and use conditionally twice. It
would look something like this:

static void sriov_disable(struct pci_dev *dev, bool flr)
{
	struct pci_sriov *iov = dev->sriov;

	if (!iov->num_VFs)
		return;

	sriov_del_vfs(dev);

	if (!flr) {
		iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
		pci_cfg_access_lock(dev);
		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
		ssleep(1);
		pci_cfg_access_unlock(dev);
	}

	pcibios_sriov_disable(dev);

	if (iov->link != dev->devfn)
		sysfs_remove_link(&dev->dev.kobj, "dep_link");

	iov->num_VFs = 0;

	if (!flr)
		pci_iov_set_numvfs(dev, 0);
}

Whether this is better, I leave to your evaluation.

Thanks,
Lukasz

> Did you test with or without my patch?
> 
> Here is the result with my patch for the NVMe device in QEMU:
> 
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -s 01:
> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: 0010
>                 VF Migration: offset: 00000000, BIR: 0
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > sriov_numvfs
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 1, Function Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: 0010
>                 VF Migration: offset: 00000000, BIR: 0
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > reset
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: 0010
>                 VF Migration: offset: 00000000, BIR: 0
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -xxx -s 01:00.0
> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
> 00: 36 1b 10 00 07 05 10 00 02 02 08 01 00 00 00 00
> 10: 04 00 80 fe 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> 40: 11 80 40 80 00 20 00 00 00 30 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 00 03 00 08 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 10 60 02 00 00 80 00 10 00 00 00 00 11 04 00 00
> 90: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# cat reset_method
> flr bus
> 
> > 
> > [root@localhost ~]# lspci  -s 01:
> > 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
> > 01:00.1 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
> > [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
> >         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> >                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
> >                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+ 10BitTagReq-
> >                 IOVSta: Migration-
> >                 Initial VFs: 16, Total VFs: 16, Number of VFs: 0, Function Dependency Link: 00
> >                 VF offset: 2, stride: 1, Device ID: 101a
> >                 VF Migration: offset: 00000000, BIR: 0
> > [root@localhost 0000:01:00.0]# echo 1 > sriov_numvfs
> > [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
> >         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> >                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
> >                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
> >                 IOVSta: Migration-
> >                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
> >                 VF offset: 2, stride: 1, Device ID: 101a
> >                 VF Migration: offset: 00000000, BIR: 0
> > [root@localhost 0000:01:00.0]# echo 1 > reset
> > [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
> >         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
> >                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
> >                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
> >                 IOVSta: Migration-
> >                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
> >                 VF offset: 2, stride: 1, Device ID: 101a
> >                 VF Migration: offset: 00000000, BIR: 0
> > [root@localhost ~]# lspci -xxx -s 01:00.0
> > 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
> > 00: b3 15 19 10 46 05 10 00 00 00 00 02 08 00 80 00
> > 10: 0c 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 b3 15 08 00
> > 30: 00 00 70 e6 60 00 00 00 00 00 00 00 ff 01 00 00
> > 40: 01 00 c3 81 08 00 00 00 03 9c cc 80 00 78 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 20 00 01
> > 60: 10 48 02 00 e2 8f e0 11 5f 29 00 00 04 71 41 00
> > 70: 08 00 04 11 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 17 00 01 00 40 00 00 00 1e 00 80 01
> > 90: 04 00 1e 00 00 00 00 00 00 00 00 00 11 c0 3f 80
> > a0: 00 20 00 00 00 30 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 09 40 18 00 0a 00 00 20 f0 1a 00 00 00 00 00 00
> > d0: 20 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [root@localhost 0000:01:00.0]# cat reset_method
> > flr bus
> > 
> > On 2022/1/19 10:47, Yicong Yang wrote:
> > > On 2022/1/19 0:30, Lukasz Maniak wrote:
> > >> On Tue, Jan 18, 2022 at 07:07:23PM +0800, Yicong Yang wrote:
> > >>> On 2022/1/18 6:55, Bjorn Helgaas wrote:
> > >>>> [+cc Alex in case he has comments on how FLR should work on
> > >>>> non-conforming hns3 devices]
> > >>>>
> > >>>> On Sat, Jan 15, 2022 at 05:22:19PM +0800, Yicong Yang wrote:
> > >>>>> On 2022/1/15 0:37, Bjorn Helgaas wrote:
> > >>>>>> On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
> > >>>>>>> On 2022/1/14 0:45, Lukasz Maniak wrote:
> > >>>>>>>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
> > >>>>>>>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
> > >>>>>>>>>> As per PCI Express specification, FLR to a PF resets the PF state as
> > >>>>>>>>>> well as the SR-IOV extended capability including VF Enable which means
> > >>>>>>>>>> that VFs no longer exist.
> > >>>>>>>>>
> > >>>>>>>>> Can you add a specific reference to the spec, please?
> > >>>>>>>>>
> > >>>>>>>> Following the Single Root I/O Virtualization and Sharing Specification:
> > >>>>>>>> 2.2.3. FLR That Targets a PF
> > >>>>>>>> PFs must support FLR.
> > >>>>>>>> FLR to a PF resets the PF state as well as the SR-IOV extended
> > >>>>>>>> capability including VF Enable which means that VFs no longer exist.
> > >>>>>>>>
> > >>>>>>>> For PCI Express Base Specification Revision 5.0 and later, this is
> > >>>>>>>> section 9.2.2.3.
> > >>>>>>
> > >>>>>> This is also the section in the new PCIe r6.0.  Let's use that.
> > >>>>>>
> > >>>>>>>>>> Currently, the IOV state is not updated during FLR, resulting in
> > >>>>>>>>>> non-compliant PCI driver behavior.
> > >>>>>>>>>
> > >>>>>>>>> And include a little detail about what problem is observed?  How would
> > >>>>>>>>> a user know this problem is occurring?
> > >>>>>>>>>
> > >>>>>>>> The problem is that the state of the kernel and HW as to the number of
> > >>>>>>>> VFs gets out of sync after FLR.
> > >>>>>>>>
> > >>>>>>>> This results in further listing, after the FLR is performed by the HW,
> > >>>>>>>> of VFs that actually no longer exist and should no longer be reported on
> > >>>>>>>> the PCI bus. lspci return FFs for these VFs.
> > >>>>>>>
> > >>>>>>> There're some exceptions. Take HiSilicon's hns3 and sec device as an
> > >>>>>>> example, the VF won't be destroyed after the FLR reset.
> > >>>>>>
> > >>>>>> If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
> > >>>>>> exist after FLR, isn't that a violation of sec 9.2.2.3?
> > >>>>>
> > >>>>> yes I think it's a violation to the spec.
> > >>>>
> > >>>> Thanks for confirming that.
> > >>>>
> > >>>>>> If hns3 and sec don't conform to the spec, we should have some sort of
> > >>>>>> quirk that serves to document and work around this.
> > >>>>>
> > >>>>> ok I think it'll help. Do you mean something like this based on this patch:
> > >>>>>
> > >>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > >>>>> index 69ee321027b4..0e4976c669b2 100644
> > >>>>> --- a/drivers/pci/iov.c
> > >>>>> +++ b/drivers/pci/iov.c
> > >>>>> @@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
> > >>>>>  		return;
> > >>>>>  	if (!iov->num_VFs)
> > >>>>>  		return;
> > >>>>> +	if (dev->flr_no_vf_reset)
> > >>>>> +		return;
> > >>>>>
> > >>>>>  	sriov_del_vfs(dev);
> > >>>>>
> > >>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > >>>>> index 003950c738d2..c8ffcb0ac612 100644
> > >>>>> --- a/drivers/pci/quirks.c
> > >>>>> +++ b/drivers/pci/quirks.c
> > >>>>> @@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
> > >>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
> > >>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
> > >>>>>
> > >>>>> +/*
> > >>>>> + * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
> > >>>>> + * Don't reset these devices' IOV state when doing FLR.
> > >>>>> + */
> > >>>>> +static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
> > >>>>> +{
> > >>>>> +	pdev->flr_no_vf_reset = 1;
> > >>>>> +}
> > >>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
> > >>>>> +/* ...some other devices have this quirk */
> > >>>>
> > >>>> Yes, I think something along this line will help.
> > >>>>
> > >>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
> > >>>>> index 18a75c8e615c..e62f9fa4d48f 100644
> > >>>>> --- a/include/linux/pci.h
> > >>>>> +++ b/include/linux/pci.h
> > >>>>> @@ -454,6 +454,7 @@ struct pci_dev {
> > >>>>>  	unsigned int	is_probed:1;		/* Device probing in progress */
> > >>>>>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
> > >>>>>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
> > >>>>> +	unsigned int	flr_no_vf_reset:1;	/* VF won't be destroyed after PF's FLR */
> > >>>>>
> > >>>>>>> Currently the transactions with the VF will be restored after the
> > >>>>>>> FLR. But this patch will break that, the VF is fully disabled and
> > >>>>>>> the transaction cannot be restored. User needs to reconfigure it,
> > >>>>>>> which is unnecessary before this patch.
> > >>>>>>
> > >>>>>> What does it mean for a "transaction to be restored"?  Maybe you mean
> > >>>>>> this patch removes the *VFs* via sriov_del_vfs(), and whoever
> > >>>>>> initiated the FLR would need to re-enable VFs via pci_enable_sriov()
> > >>>>>> or something similar?
> > >>>>>
> > >>>>> Partly. It'll also terminate the VF users.
> > >>>>> Think that I attach the VF of hns to a VM by vfio and ping the network
> > >>>>> in the VM, when doing FLR the 'ping' will pause and after FLR it'll
> > >>>>> resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
> > >>>>> methods. The user of VM may not realize there is a FLR of the PF as the
> > >>>>> VF always exists and the 'ping' is never terminated.
> > >>>>>
> > >>>>> If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
> > >>>>> until no one is using the device, for example the 'ping' is finished.
> > >>>>> 2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
> > >>>>> it into the VM and restart the ping. That's a big difference.
> > >>>>>
> > >>>>>> If FLR disables VFs, it seems like we should expect to have to
> > >>>>>> re-enable them if we want them.
> > >>>>>
> > >>>>> It involves a remove()/probe() process of the VF driver and the user
> > >>>>> of the VF will be terminated, just like the situation illustrated
> > >>>>> above.
> > >>>>
> > >>>> I think users of FLR should be able to rely on it working per spec,
> > >>>> i.e., that VFs will be destroyed.  If hardware like hns3 doesn't do
> > >>>> that, the quirk should work around that in software by doing it
> > >>>> explicitly.
> > >>>>
> > >>>> I don't think the non-standard behavior should be exposed to the
> > >>>> users.  The user should not have to know about this hns3 issue.
> > >>>>
> > >>>> If FLR on a standard NIC terminates a ping on a VF, FLR on an hns3 NIC
> > >>>> should also terminate a ping on a VF.
> > >>>>
> > >>>
> > >>> ok thanks for the discussion, agree on that. According to the spec, after
> > >>> the FLR to the PF the VF does not exist anymore, so the ping will be terminated.
> > >>> Our hns3 and sec team are still evaluating it before coming to a solution of
> > >>> whether using a quirk or comform to the spec.
> > >>>
> > >>> For this patch it looks reasonable to me, but some questions about the code below.
> > >>>
> > >>>>>>> Can we handle this problem in another way? Maybe test the VF's
> > >>>>>>> vendor device ID after the FLR reset to see whether it has really
> > >>>>>>> gone or not?
> > >>>>>>>
> > >>>>>>>> sriov_numvfs in sysfs returns old invalid value and does not allow
> > >>>>>>>> setting a new value before explicitly setting 0 in the first place.
> > >>>>>>>>
> > >>>>>>>>>> This patch introduces a simple function, called on the FLR path, that
> > >>>>>>>>>> removes the virtual function devices from the PCI bus and their
> > >>>>>>>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
> > >>>>>>>>>> state.
> > >>>>>>>>>>
> > >>>>>>>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
> > >>>>>>>>>> ---
> > >>>>>>>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
> > >>>>>>>>>>  drivers/pci/pci.c |  2 ++
> > >>>>>>>>>>  drivers/pci/pci.h |  4 ++++
> > >>>>>>>>>>  3 files changed, 27 insertions(+)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > >>>>>>>>>> index 0267977c9f17..69ee321027b4 100644
> > >>>>>>>>>> --- a/drivers/pci/iov.c
> > >>>>>>>>>> +++ b/drivers/pci/iov.c
> > >>>>>>>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
> > >>>>>>>>>>  	return max ? max - bus->number : 0;
> > >>>>>>>>>>  }
> > >>>>>>>>>>  
> > >>>>>>>>>> +/**
> > >>>>>>>>>> + * pci_reset_iov_state - reset the state of the IOV capability
> > >>>>>>>>>> + * @dev: the PCI device
> > >>>>>>>>>> + */
> > >>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev)
> > >>>>>>>>>> +{
> > >>>>>>>>>> +	struct pci_sriov *iov = dev->sriov;
> > >>>>>>>>>> +
> > >>>>>>>>>> +	if (!dev->is_physfn)
> > >>>>>>>>>> +		return;
> > >>>>>>>>>> +	if (!iov->num_VFs)
> > >>>>>>>>>> +		return;
> > >>>>>>>>>> +
> > >>>>>>>>>> +	sriov_del_vfs(dev);
> > >>>>>>>>>> +
> > >>>>>>>>>> +	if (iov->link != dev->devfn)
> > >>>>>>>>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> > >>>>>>>>>> +
> > >>>>>>>>>> +	iov->num_VFs = 0;
> > >>>>>>>>>> +}
> > >>>>>>>>>> +
> > >>>
> > >>> Any reason for not using pci_disable_sriov()?
> > >>
> > >> The issue with pci_disable_sriov() is that it calls sriov_disable(),
> > >> which directly uses pci_cfg_access_lock(), leading to deadlock on the
> > >> FLR path.
> > >>
> > > 
> > > That'll be a problem. Well my main concern is whether the VFs will be reset
> > > correctly through pci_reset_iov_state() as it lacks the participant of
> > > PF driver and bios (seems may needed only on powerpc, not sure), which is
> > > necessary in the enable/disable routine through $pci_dev/sriov_numvfs.
> > > 
> > >>>
> > >>> With the spec the related registers in the SRIOV cap will be reset so
> > >>> it's ok in general. But for some devices not following the spec like hns3,
> > >>> some fields like VF enable won't be reset and keep enabled after the FLR.
> > >>> In this case after the FLR the VF devices in the system has gone but
> > >>> the state of the PF SRIOV cap leaves uncleared. pci_disable_sriov()
> > >>> will reset the whole SRIOV cap. It'll also call pcibios_sriov_disable()
> > >>> to correct handle the VF disabling on some platforms, IIUC.
> > >>>
> > >>> Or is it better to use pdev->driver->sriov_configure(pdev,0)?
> > >>> PF drivers must implement ->sriov_configure() for enabling/disabling
> > >>> the VF but we totally skip the PF driver here.
> > >>>
> > >>> Thanks,
> > >>> Yicong
> > >>>
> > >>>>>>>>>>  /**
> > >>>>>>>>>>   * pci_enable_sriov - enable the SR-IOV capability
> > >>>>>>>>>>   * @dev: the PCI device
> > >>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > >>>>>>>>>> index 3d2fb394986a..535f19d37e8d 100644
> > >>>>>>>>>> --- a/drivers/pci/pci.c
> > >>>>>>>>>> +++ b/drivers/pci/pci.c
> > >>>>>>>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> > >>>>>>>>>>   */
> > >>>>>>>>>>  int pcie_flr(struct pci_dev *dev)
> > >>>>>>>>>>  {
> > >>>>>>>>>> +	pci_reset_iov_state(dev);
> > >>>>>>>>>> +
> > >>>>>>>>>>  	if (!pci_wait_for_pending_transaction(dev))
> > >>>>>>>>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> > >>>>>>>>>>  
> > >>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > >>>>>>>>>> index 3d60cabde1a1..7bb144fbec76 100644
> > >>>>>>>>>> --- a/drivers/pci/pci.h
> > >>>>>>>>>> +++ b/drivers/pci/pci.h
> > >>>>>>>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
> > >>>>>>>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> > >>>>>>>>>>  void pci_restore_iov_state(struct pci_dev *dev);
> > >>>>>>>>>>  int pci_iov_bus_range(struct pci_bus *bus);
> > >>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev);
> > >>>>>>>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
> > >>>>>>>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
> > >>>>>>>>>>  #else
> > >>>>>>>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
> > >>>>>>>>>>  {
> > >>>>>>>>>>  	return 0;
> > >>>>>>>>>>  }
> > >>>>>>>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
> > >>>>>>>>>> +{
> > >>>>>>>>>> +}
> > >>>>>>>>>>  
> > >>>>>>>>>>  #endif /* CONFIG_PCI_IOV */
> > >>>> .
> > >>>>
> > >> .
> > >>
> > > .
> > > 
