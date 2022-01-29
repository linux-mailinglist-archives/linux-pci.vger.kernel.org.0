Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804E44A2D71
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiA2JlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jan 2022 04:41:24 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32073 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiA2JlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jan 2022 04:41:23 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jm8PH3NLqz1FCxp;
        Sat, 29 Jan 2022 17:37:23 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 17:41:21 +0800
CC:     <yangyicong@hisilicon.com>,
        Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Gieryk?= <lukasz.gieryk@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        <leonro@nvidia.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
To:     Saeed Mahameed <saeedm@nvidia.com>
References: <20220117225542.GA813284@bhelgaas>
 <e4483576-cafb-6ba2-a98f-8b7bdcead80d@huawei.com>
 <20220118163054.GA8392@lmaniak-dev.igk.intel.com>
 <b1ad6220-cdc0-1058-6885-9c5b48441837@huawei.com>
 <f0831ca3-3c41-9c11-9e7a-267753f9f1fa@huawei.com>
 <20220119160655.GA166109@lmaniak-dev.igk.intel.com>
 <20220119170920.GB166109@lmaniak-dev.igk.intel.com>
 <dc01508f-34b1-a69d-dbbf-88440a144198@huawei.com>
 <20220121214035.7moslsnar55sqdl7@sx1>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6662d856-3ccb-de92-3d7e-565bc3543d33@huawei.com>
Date:   Sat, 29 Jan 2022 17:41:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220121214035.7moslsnar55sqdl7@sx1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/1/22 5:40, Saeed Mahameed wrote:
> On 20 Jan 21:16, Yicong Yang wrote:
>> On 2022/1/20 1:09, Lukasz Maniak wrote:
>>> On Wed, Jan 19, 2022 at 05:06:55PM +0100, Lukasz Maniak wrote:
>>>> On Wed, Jan 19, 2022 at 06:22:07PM +0800, Yicong Yang wrote:
>>>>> Hi Lukasz, Bjorn,
>>>>>
>>>>> FYI, I tested with Mellanox CX-5, the VF also exists after FLR. Here's the operation:
>>>>
>>>
>>> Please disregard my previous email. I missed your point.
>>> I take it that the Mellanox CX-5 also violates the spec.
>>>
>>> As for using pci_disable_sriov() I did a test to get a backtrace for
>>> deadlock:
>>> [  846.904248] Call Trace:
>>> [  846.904251]  <TASK>
>>> [  846.904272]  __schedule+0x302/0x950
>>> [  846.904282]  schedule+0x58/0xd0
>>> [  846.904286]  pci_wait_cfg+0x63/0xb0
>>> [  846.904290]  ? wait_woken+0x70/0x70
>>> [  846.904296]  pci_cfg_access_lock+0x48/0x50
>>> [  846.904300]  sriov_disable+0x4d/0xf0
>>> [  846.904306]  pci_disable_sriov+0x26/0x30
>>> [  846.904310]  pcie_flr+0x2b/0x100
>>> [  846.904317]  pcie_reset_flr+0x25/0x30
>>> [  846.904322]  __pci_reset_function_locked+0x42/0x60
>>> [  846.904327]  pci_reset_function+0x40/0x70
>>> [  846.904334]  reset_store+0x5c/0xa0
>>> [  846.904347]  dev_attr_store+0x17/0x30
>>> [  846.904357]  sysfs_kf_write+0x3f/0x50
>>> [  846.904365]  kernfs_fop_write_iter+0x13b/0x1d0
>>> [  846.904371]  new_sync_write+0x117/0x1b0
>>> [  846.904379]  vfs_write+0x219/0x2b0
>>> [  846.904384]  ksys_write+0x67/0xe0
>>> [  846.904390]  __x64_sys_write+0x1a/0x20
>>> [  846.904395]  do_syscall_64+0x5c/0xc0
>>> [  846.904401]  ? debug_smp_processor_id+0x17/0x20
>>> [  846.904406]  ? fpregs_assert_state_consistent+0x26/0x50
>>> [  846.904413]  ? exit_to_user_mode_prepare+0x3f/0x1b0
>>> [  846.904418]  ? irqentry_exit_to_user_mode+0x9/0x20
>>> [  846.904423]  ? irqentry_exit+0x33/0x40
>>> [  846.904427]  ? exc_page_fault+0x89/0x180
>>> [  846.904431]  ? asm_exc_page_fault+0x8/0x30
>>> [  846.904438]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> As can be noticed during FLR we are already on a locked path for the
>>> device in __pci_reset_function_locked(). In addition, the device will reset
>>> the BARs during FLR on its own.
>>>
>>> If we still would like to use pci_disable_sriov() for this purpose we
>>> need to pass a flag to sriov_disable() and use conditionally twice. It
>>> would look something like this:
>>>
>>> static void sriov_disable(struct pci_dev *dev, bool flr)
>>> {
>>>     struct pci_sriov *iov = dev->sriov;
>>>
>>>     if (!iov->num_VFs)
>>>         return;
>>>
>>>     sriov_del_vfs(dev);
>>>
>>>     if (!flr) {
>>>         iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>>         pci_cfg_access_lock(dev);
>>>         pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>>         ssleep(1);
>>>         pci_cfg_access_unlock(dev);
>>>     }
>>>
>>
>> It still leaves the VFE uncleared. So after reset the hardware IOV state is unsynchronized
>> with the system as we've removed the VFs already. so you may need:
>>
>> static void sriov_disable(struct pci_dev *dev, bool locked)
>> {
>>     struct pci_sriov *iov = dev->sriov;
>>
>>     if (!iov->num_VFs)
>>         return;
>>
>>     sriov_del_vfs(dev);
>>
>>     iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>>     if (!locked)
>>         pci_cfg_access_lock(dev);
>>     pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>>     ssleep(1);
>>     if (!locked)
>>         pci_cfg_access_unlock(dev);
>>
>>     pcibios_sriov_disable(dev);
>>
>>     if (iov->link != dev->devfn)
>>         sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>
>>     iov->num_VFs = 0;
>>
>>     if (!flr)
>>         pci_iov_set_numvfs(dev, 0);
>> }
>>
>> I'm not sure this is correct as we disable VF not through PF driver
>> and whether these PF driver involed need to modified after this
>> change.
>> (Yes through pdev->driver->sriov_configure() we'll also meet the
>> deadlock problem but that's the next step question).
>>
>> With your patch based on 5.16 release when doing FLR reset on VF's PF
>> of Mellanox CX-5, the log says that there's a resource leakage and
>> leads to several calltraces. I paste the log below.
>>
>> Perhaps Mellanox maintainers could help on this.
>>
>> Thanks.
>>
>> [  435.211235] mlx5_core 0000:01:00.0: E-Switch: Enable: mode(LEGACY), nvfs(1), active vports(2)
>> [  435.327158] pci 0000:01:00.2: [15b3:101a] type 00 class 0x020000
>> [  435.333197] pci 0000:01:00.2: enabling Extended Tags
>> [  435.338936] pci 0000:01:00.2: calling  mellanox_check_broken_intx_masking+0x0/0x1a0 @ 4328
>> [  435.347174] pci 0000:01:00.2: mellanox_check_broken_intx_masking+0x0/0x1a0 took 0 usecs
>> [  435.355224] mlx5_core 0000:01:00.2: Adding to iommu group 49
>> [  435.361639] mlx5_core 0000:01:00.2: enabling device (0000 -> 0002)
>> [  435.367917] mlx5_core 0000:01:00.2: firmware version: 16.27.1016
>> [  435.611252] mlx5_core 0000:01:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
>> [  435.628931] mlx5_core 0000:01:00.2: Assigned random MAC address 72:51:df:ba:6a:1e
>> [  435.636824] mlx5_core 0000:01:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
>> [  435.744665] mlx5_core 0000:01:00.2: Supported tc offload range - chains: 1, prios: 1
>> [  446.080370] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): 2RST_QP(0x50a) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x7ea02d)
>> [  446.094054] infiniband mlx5_2: destroy_qp_common:2599:(pid 4328): mlx5_ib: modify QP 0x000504 to RESET failed
> 
> 
> BAD_RES_STATE       | 0x7EA02D |  2error_qp/2reset: invalid qp number.
> This is the source of the resource leak, all others are failing as side
> effect to this.
> 
> This is due to mlx5_ib trying to unload on the vf, most likely due to this patch
> doing sriov_disable() on PF flr, and 2 seconds later the PF driver sees that flr
> and starts the recovery see below [1]
> 
> I think you are doing something that wrecks the VF pci access, where
> the FW can't properly find the resource in the VF host memory and then
> causes the domino effect...
> 

Thanks for the analysis and sorry for the late reply.

My test is rather simple.

echo 1 > sriov_numvfs # enable 1 VF
echo 1 > reset # trigger FLR

Both PFs' net are down and VF is not used.

>> [  446.104036] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_QP(0x501) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x25b161)
>> [  446.118092] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_CQ(0x401) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1870ad)
>> [  446.132028] ------------[ cut here ]------------
>> [  446.136629] Destroy of kernel CQ shouldn't fail
>> [  446.136648] WARNING: CPU: 37 PID: 4328 at drivers/infiniband/core/cq.c:345 ib_free_cq+0x16c/0x174
> ...
> 
>> [  448.363136] restrack: ------------[ cut here ]------------
>> [  448.368601] infiniband mlx5_2: BUG: RESTRACK detected leak of resources
>> [  448.375187] restrack: Kernel PD object allocated by mlx5_ib is not freed
>> [  448.381861] restrack: Kernel PD object allocated by ib_core is not freed
>> [  448.388534] restrack: Kernel PD object allocated by mlx5_ib is not freed
>> [  448.395207] restrack: Kernel CQ object allocated by mlx5_ib is not freed
>> [  448.401879] restrack: Kernel SRQ object allocated by mlx5_ib is not freed
>> [  448.408638] restrack: Kernel SRQ object allocated by mlx5_ib is not freed
>> [  448.415401] restrack: ------------[ cut here ]------------
>> [  448.455025] mlx5_core 0000:01:00.0: poll_health:795:(pid 0): Fatal error 1 detected
> 
> PF driver detects the FLR here or at least some fatal error on the pci, but below you can clearly see the VF "mlx5_core 0000:01:00.2" is still
> trying to unload, which means sriov_disable hasn't complete ! So why did
> the PF FLR already before SRIOV is clearly disabled?
> The only conclusion is some sort of error happening on the PCI due to the
> change in behavior of sriov_disable(), which can explain the AER in the next
> line :)

Not sure. I tested again once the machine booted up, but with the same result.
Maybe I need to check whether the PCI link is ok.

Focus on this patch, does PF driver of mellanox needs to do something in the VF destroying?
The PF driver may not realized the VF is going to destroy as we're not destroying VF through
PF's ->sriov_configure() callback.

BTW, the mellanox doesn't reset IOV state either on a FLR resetting, is it intended as a feature?

Thanks,
Yicong

>> [  448.455107] pcieport 0000:00:00.0: AER: Corrected error received: 0000:01:00.0
>> [  448.469914] mlx5_core 0000:01:00.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
>> [  448.479792] mlx5_core 0000:01:00.0:   device [15b3:1019] error status/mask=00002000/00000000
>> [  448.488196] mlx5_core 0000:01:00.0:    [13] NonFatalErr
>> [  448.494415] pcieport 0000:00:00.0: AER: Multiple Corrected error received: 0000:01:00.0
>> [  448.502452] mlx5_core 0000:01:00.1: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
>> [  448.512324] mlx5_core 0000:01:00.1:   device [15b3:1019] error status/mask=00002000/00000000
>> [  448.520726] mlx5_core 0000:01:00.1:    [13] NonFatalErr
>> [  448.526951] pcieport 0000:00:00.0: AER: Corrected error received: 0000:01:00.0
>> [  448.534176] pcieport 0000:00:00.0: AER: Multiple Corrected error received: 0000:01:00.0
>> [  448.619235] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8192 of flow group id 19
> 
> VF is still having hard time unloading due to the invalid QP above in the
> first mlx5 "fail" log line
> 
>> [  448.630750] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 21 of ft 262149
>> [  448.641277] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 20 of ft 262149
>> [  448.651794] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 19 of ft 262149
>> [  448.662309] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 18 of ft 262149
>> [  448.672830] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 17 of ft 262149
>> [  448.683417] mlx5_core 0000:01:00.2: update_root_ft_destroy:2127:(pid 4328): Update root flow table of id(262149) qpn(0) failed
>> [  448.694843] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
>> [  448.703993] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 16 of ft 262148
>> [  448.714516] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 15 of ft 262148
>> [  448.725033] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 14 of ft 262148
>> [  448.735564] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
>> [  448.744714] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 0 of flow group id 11
>> [  448.755936] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 1 of flow group id 11
>> [  448.767145] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 2 of flow group id 11
>> [  448.778352] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 3 of flow group id 11
>> [  448.789558] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 4 of flow group id 11
>> [  448.800770] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 5 of flow group id 11
>> [  448.812049] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 6 of flow group id 11
>> [  448.823261] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 7 of flow group id 11
>> [  448.834471] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 14 of flow group id 12
>> [  448.845774] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 15 of flow group id 12
>> [  448.857072] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 16 of flow group id 13
>> [  448.868370] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8 of flow group id 11
>> [  448.879579] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 9 of flow group id 11
>> [  448.890788] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 10 of flow group id 11
>> [  448.902087] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 11 of flow group id 11
>> [  448.913382] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 12 of flow group id 11
>> [  448.924675] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 13 of flow group id 11
>> [  448.935980] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 13 of ft 2
>> [  448.946072] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 12 of ft 2
>> [  448.956160] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 11 of ft 2
>> [  448.966249] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
>> [  448.975395] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 0 of flow group id 8
>> [  448.986526] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 1 of flow group id 8
>> [  448.997647] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 2 of flow group id 8
>> [  449.008768] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 3 of flow group id 8
>> [  449.019890] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 4 of flow group id 8
>> [  449.031013] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 5 of flow group id 8
>> [  449.042135] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 6 of flow group id 8
>> [  449.053257] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 7 of flow group id 8
>> [  449.064380] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8 of flow group id 9
>> [...]
>>
>>
>>>     pcibios_sriov_disable(dev);
>>>
>>>     if (iov->link != dev->devfn)
>>>         sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>
>>>     iov->num_VFs = 0;
>>>
>>>     if (!flr)
>>>         pci_iov_set_numvfs(dev, 0);
>>> }
>>>
>>> Whether this is better, I leave to your evaluation.
>>>
>>> Thanks,
>>> Lukasz
>>>
>>>> Did you test with or without my patch?
>>>>
>>>> Here is the result with my patch for the NVMe device in QEMU:
>>>>
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -s 01:
>>>> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>>>>                 IOVSta: Migration-
>>>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>>>>                 VF offset: 1, stride: 1, Device ID: 0010
>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > sriov_numvfs
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>>>>                 IOVSta: Migration-
>>>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 1, Function Dependency Link: 00
>>>>                 VF offset: 1, stride: 1, Device ID: 0010
>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > reset
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>>>>                 IOVSta: Migration-
>>>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>>>>                 VF offset: 1, stride: 1, Device ID: 0010
>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -xxx -s 01:00.0
>>>> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
>>>> 00: 36 1b 10 00 07 05 10 00 02 02 08 01 00 00 00 00
>>>> 10: 04 00 80 fe 00 00 00 00 00 00 00 00 00 00 00 00
>>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
>>>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
>>>> 40: 11 80 40 80 00 20 00 00 00 30 00 00 00 00 00 00
>>>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> 60: 01 00 03 00 08 00 00 00 00 00 00 00 00 00 00 00
>>>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> 80: 10 60 02 00 00 80 00 10 00 00 00 00 11 04 00 00
>>>> 90: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> a0: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
>>>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>
>>>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# cat reset_method
>>>> flr bus
>>>>
>>>>>
>>>>> [root@localhost ~]# lspci  -s 01:
>>>>> 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>>>> 01:00.1 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+ 10BitTagReq-
>>>>>                 IOVSta: Migration-
>>>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 0, Function Dependency Link: 00
>>>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>>> [root@localhost 0000:01:00.0]# echo 1 > sriov_numvfs
>>>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
>>>>>                 IOVSta: Migration-
>>>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
>>>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>>> [root@localhost 0000:01:00.0]# echo 1 > reset
>>>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
>>>>>                 IOVSta: Migration-
>>>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
>>>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>>>                 VF Migration: offset: 00000000, BIR: 0
>>>>> [root@localhost ~]# lspci -xxx -s 01:00.0
>>>>> 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>>>> 00: b3 15 19 10 46 05 10 00 00 00 00 02 08 00 80 00
>>>>> 10: 0c 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
>>>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b3 15 08 00
>>>>> 30: 00 00 70 e6 60 00 00 00 00 00 00 00 ff 01 00 00
>>>>> 40: 01 00 c3 81 08 00 00 00 03 9c cc 80 00 78 00 00
>>>>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 20 00 01
>>>>> 60: 10 48 02 00 e2 8f e0 11 5f 29 00 00 04 71 41 00
>>>>> 70: 08 00 04 11 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> 80: 00 00 00 00 17 00 01 00 40 00 00 00 1e 00 80 01
>>>>> 90: 04 00 1e 00 00 00 00 00 00 00 00 00 11 c0 3f 80
>>>>> a0: 00 20 00 00 00 30 00 00 00 00 00 00 00 00 00 00
>>>>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> c0: 09 40 18 00 0a 00 00 20 f0 1a 00 00 00 00 00 00
>>>>> d0: 20 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> [root@localhost 0000:01:00.0]# cat reset_method
>>>>> flr bus
>>>>>
>>>>> On 2022/1/19 10:47, Yicong Yang wrote:
>>>>>> On 2022/1/19 0:30, Lukasz Maniak wrote:
>>>>>>> On Tue, Jan 18, 2022 at 07:07:23PM +0800, Yicong Yang wrote:
>>>>>>>> On 2022/1/18 6:55, Bjorn Helgaas wrote:
>>>>>>>>> [+cc Alex in case he has comments on how FLR should work on
>>>>>>>>> non-conforming hns3 devices]
>>>>>>>>>
>>>>>>>>> On Sat, Jan 15, 2022 at 05:22:19PM +0800, Yicong Yang wrote:
>>>>>>>>>> On 2022/1/15 0:37, Bjorn Helgaas wrote:
>>>>>>>>>>> On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
>>>>>>>>>>>> On 2022/1/14 0:45, Lukasz Maniak wrote:
>>>>>>>>>>>>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
>>>>>>>>>>>>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
>>>>>>>>>>>>>>> As per PCI Express specification, FLR to a PF resets the PF state as
>>>>>>>>>>>>>>> well as the SR-IOV extended capability including VF Enable which means
>>>>>>>>>>>>>>> that VFs no longer exist.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Can you add a specific reference to the spec, please?
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Following the Single Root I/O Virtualization and Sharing Specification:
>>>>>>>>>>>>> 2.2.3. FLR That Targets a PF
>>>>>>>>>>>>> PFs must support FLR.
>>>>>>>>>>>>> FLR to a PF resets the PF state as well as the SR-IOV extended
>>>>>>>>>>>>> capability including VF Enable which means that VFs no longer exist.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For PCI Express Base Specification Revision 5.0 and later, this is
>>>>>>>>>>>>> section 9.2.2.3.
>>>>>>>>>>>
>>>>>>>>>>> This is also the section in the new PCIe r6.0.  Let's use that.
>>>>>>>>>>>
>>>>>>>>>>>>>>> Currently, the IOV state is not updated during FLR, resulting in
>>>>>>>>>>>>>>> non-compliant PCI driver behavior.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> And include a little detail about what problem is observed?  How would
>>>>>>>>>>>>>> a user know this problem is occurring?
>>>>>>>>>>>>>>
>>>>>>>>>>>>> The problem is that the state of the kernel and HW as to the number of
>>>>>>>>>>>>> VFs gets out of sync after FLR.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This results in further listing, after the FLR is performed by the HW,
>>>>>>>>>>>>> of VFs that actually no longer exist and should no longer be reported on
>>>>>>>>>>>>> the PCI bus. lspci return FFs for these VFs.
>>>>>>>>>>>>
>>>>>>>>>>>> There're some exceptions. Take HiSilicon's hns3 and sec device as an
>>>>>>>>>>>> example, the VF won't be destroyed after the FLR reset.
>>>>>>>>>>>
>>>>>>>>>>> If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
>>>>>>>>>>> exist after FLR, isn't that a violation of sec 9.2.2.3?
>>>>>>>>>>
>>>>>>>>>> yes I think it's a violation to the spec.
>>>>>>>>>
>>>>>>>>> Thanks for confirming that.
>>>>>>>>>
>>>>>>>>>>> If hns3 and sec don't conform to the spec, we should have some sort of
>>>>>>>>>>> quirk that serves to document and work around this.
>>>>>>>>>>
>>>>>>>>>> ok I think it'll help. Do you mean something like this based on this patch:
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>>>>> index 69ee321027b4..0e4976c669b2 100644
>>>>>>>>>> --- a/drivers/pci/iov.c
>>>>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>>>>> @@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>>>          return;
>>>>>>>>>>      if (!iov->num_VFs)
>>>>>>>>>>          return;
>>>>>>>>>> +    if (dev->flr_no_vf_reset)
>>>>>>>>>> +        return;
>>>>>>>>>>
>>>>>>>>>>      sriov_del_vfs(dev);
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>>>>> index 003950c738d2..c8ffcb0ac612 100644
>>>>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>>>>> @@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
>>>>>>>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
>>>>>>>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>>>>>>>>>>
>>>>>>>>>> +/*
>>>>>>>>>> + * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
>>>>>>>>>> + * Don't reset these devices' IOV state when doing FLR.
>>>>>>>>>> + */
>>>>>>>>>> +static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
>>>>>>>>>> +{
>>>>>>>>>> +    pdev->flr_no_vf_reset = 1;
>>>>>>>>>> +}
>>>>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
>>>>>>>>>> +/* ...some other devices have this quirk */
>>>>>>>>>
>>>>>>>>> Yes, I think something along this line will help.
>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>>>>>>> index 18a75c8e615c..e62f9fa4d48f 100644
>>>>>>>>>> --- a/include/linux/pci.h
>>>>>>>>>> +++ b/include/linux/pci.h
>>>>>>>>>> @@ -454,6 +454,7 @@ struct pci_dev {
>>>>>>>>>>      unsigned int    is_probed:1;        /* Device probing in progress */
>>>>>>>>>>      unsigned int    link_active_reporting:1;/* Device capable of reporting link active */
>>>>>>>>>>      unsigned int    no_vf_scan:1;        /* Don't scan for VFs after IOV enablement */
>>>>>>>>>> +    unsigned int    flr_no_vf_reset:1;    /* VF won't be destroyed after PF's FLR */
>>>>>>>>>>
>>>>>>>>>>>> Currently the transactions with the VF will be restored after the
>>>>>>>>>>>> FLR. But this patch will break that, the VF is fully disabled and
>>>>>>>>>>>> the transaction cannot be restored. User needs to reconfigure it,
>>>>>>>>>>>> which is unnecessary before this patch.
>>>>>>>>>>>
>>>>>>>>>>> What does it mean for a "transaction to be restored"?  Maybe you mean
>>>>>>>>>>> this patch removes the *VFs* via sriov_del_vfs(), and whoever
>>>>>>>>>>> initiated the FLR would need to re-enable VFs via pci_enable_sriov()
>>>>>>>>>>> or something similar?
>>>>>>>>>>
>>>>>>>>>> Partly. It'll also terminate the VF users.
>>>>>>>>>> Think that I attach the VF of hns to a VM by vfio and ping the network
>>>>>>>>>> in the VM, when doing FLR the 'ping' will pause and after FLR it'll
>>>>>>>>>> resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
>>>>>>>>>> methods. The user of VM may not realize there is a FLR of the PF as the
>>>>>>>>>> VF always exists and the 'ping' is never terminated.
>>>>>>>>>>
>>>>>>>>>> If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
>>>>>>>>>> until no one is using the device, for example the 'ping' is finished.
>>>>>>>>>> 2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
>>>>>>>>>> it into the VM and restart the ping. That's a big difference.
>>>>>>>>>>
>>>>>>>>>>> If FLR disables VFs, it seems like we should expect to have to
>>>>>>>>>>> re-enable them if we want them.
>>>>>>>>>>
>>>>>>>>>> It involves a remove()/probe() process of the VF driver and the user
>>>>>>>>>> of the VF will be terminated, just like the situation illustrated
>>>>>>>>>> above.
>>>>>>>>>
>>>>>>>>> I think users of FLR should be able to rely on it working per spec,
>>>>>>>>> i.e., that VFs will be destroyed.  If hardware like hns3 doesn't do
>>>>>>>>> that, the quirk should work around that in software by doing it
>>>>>>>>> explicitly.
>>>>>>>>>
>>>>>>>>> I don't think the non-standard behavior should be exposed to the
>>>>>>>>> users.  The user should not have to know about this hns3 issue.
>>>>>>>>>
>>>>>>>>> If FLR on a standard NIC terminates a ping on a VF, FLR on an hns3 NIC
>>>>>>>>> should also terminate a ping on a VF.
>>>>>>>>>
>>>>>>>>
>>>>>>>> ok thanks for the discussion, agree on that. According to the spec, after
>>>>>>>> the FLR to the PF the VF does not exist anymore, so the ping will be terminated.
>>>>>>>> Our hns3 and sec team are still evaluating it before coming to a solution of
>>>>>>>> whether using a quirk or comform to the spec.
>>>>>>>>
>>>>>>>> For this patch it looks reasonable to me, but some questions about the code below.
>>>>>>>>
>>>>>>>>>>>> Can we handle this problem in another way? Maybe test the VF's
>>>>>>>>>>>> vendor device ID after the FLR reset to see whether it has really
>>>>>>>>>>>> gone or not?
>>>>>>>>>>>>
>>>>>>>>>>>>> sriov_numvfs in sysfs returns old invalid value and does not allow
>>>>>>>>>>>>> setting a new value before explicitly setting 0 in the first place.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This patch introduces a simple function, called on the FLR path, that
>>>>>>>>>>>>>>> removes the virtual function devices from the PCI bus and their
>>>>>>>>>>>>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
>>>>>>>>>>>>>>> state.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>>>>>>>>>>>>>>>  drivers/pci/pci.c |  2 ++
>>>>>>>>>>>>>>>  drivers/pci/pci.h |  4 ++++
>>>>>>>>>>>>>>>  3 files changed, 27 insertions(+)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>>>>>>>>>> index 0267977c9f17..69ee321027b4 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/iov.c
>>>>>>>>>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>>>>>>>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>>>>>>>>>      return max ? max - bus->number : 0;
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>> + * pci_reset_iov_state - reset the state of the IOV capability
>>>>>>>>>>>>>>> + * @dev: the PCI device
>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +    struct pci_sriov *iov = dev->sriov;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    if (!dev->is_physfn)
>>>>>>>>>>>>>>> +        return;
>>>>>>>>>>>>>>> +    if (!iov->num_VFs)
>>>>>>>>>>>>>>> +        return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    sriov_del_vfs(dev);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    if (iov->link != dev->devfn)
>>>>>>>>>>>>>>> +        sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +    iov->num_VFs = 0;
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>
>>>>>>>> Any reason for not using pci_disable_sriov()?
>>>>>>>
>>>>>>> The issue with pci_disable_sriov() is that it calls sriov_disable(),
>>>>>>> which directly uses pci_cfg_access_lock(), leading to deadlock on the
>>>>>>> FLR path.
>>>>>>>
>>>>>>
>>>>>> That'll be a problem. Well my main concern is whether the VFs will be reset
>>>>>> correctly through pci_reset_iov_state() as it lacks the participant of
>>>>>> PF driver and bios (seems may needed only on powerpc, not sure), which is
>>>>>> necessary in the enable/disable routine through $pci_dev/sriov_numvfs.
>>>>>>
>>>>>>>>
>>>>>>>> With the spec the related registers in the SRIOV cap will be reset so
>>>>>>>> it's ok in general. But for some devices not following the spec like hns3,
>>>>>>>> some fields like VF enable won't be reset and keep enabled after the FLR.
>>>>>>>> In this case after the FLR the VF devices in the system has gone but
>>>>>>>> the state of the PF SRIOV cap leaves uncleared. pci_disable_sriov()
>>>>>>>> will reset the whole SRIOV cap. It'll also call pcibios_sriov_disable()
>>>>>>>> to correct handle the VF disabling on some platforms, IIUC.
>>>>>>>>
>>>>>>>> Or is it better to use pdev->driver->sriov_configure(pdev,0)?
>>>>>>>> PF drivers must implement ->sriov_configure() for enabling/disabling
>>>>>>>> the VF but we totally skip the PF driver here.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Yicong
>>>>>>>>
>>>>>>>>>>>>>>>  /**
>>>>>>>>>>>>>>>   * pci_enable_sriov - enable the SR-IOV capability
>>>>>>>>>>>>>>>   * @dev: the PCI device
>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>>>>>>>> index 3d2fb394986a..535f19d37e8d 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>>>>>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>>  int pcie_flr(struct pci_dev *dev)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>> +    pci_reset_iov_state(dev);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>      if (!pci_wait_for_pending_transaction(dev))
>>>>>>>>>>>>>>>          pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>>>>>> index 3d60cabde1a1..7bb144fbec76 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>>>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>>>>>>>>>>>>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>>>>>>>>>>>>>>>  void pci_restore_iov_state(struct pci_dev *dev);
>>>>>>>>>>>>>>>  int pci_iov_bus_range(struct pci_bus *bus);
>>>>>>>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev);
>>>>>>>>>>>>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
>>>>>>>>>>>>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
>>>>>>>>>>>>>>>  #else
>>>>>>>>>>>>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>      return 0;
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>  #endif /* CONFIG_PCI_IOV */
>>>>>>>>> .
>>>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>> .
>>>>>>
>>> .
>>>
> .
