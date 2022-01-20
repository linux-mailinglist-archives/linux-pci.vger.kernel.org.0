Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF08494EB7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 14:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiATNQY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 08:16:24 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30290 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiATNQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 08:16:22 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jfjg93lr7zbjxh;
        Thu, 20 Jan 2022 21:15:33 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 20 Jan 2022 21:16:19 +0800
CC:     <yangyicong@hisilicon.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Gieryk?= <lukasz.gieryk@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        <saeedm@nvidia.com>, <leonro@nvidia.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
To:     Lukasz Maniak <lukasz.maniak@linux.intel.com>
References: <20220117225542.GA813284@bhelgaas>
 <e4483576-cafb-6ba2-a98f-8b7bdcead80d@huawei.com>
 <20220118163054.GA8392@lmaniak-dev.igk.intel.com>
 <b1ad6220-cdc0-1058-6885-9c5b48441837@huawei.com>
 <f0831ca3-3c41-9c11-9e7a-267753f9f1fa@huawei.com>
 <20220119160655.GA166109@lmaniak-dev.igk.intel.com>
 <20220119170920.GB166109@lmaniak-dev.igk.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <dc01508f-34b1-a69d-dbbf-88440a144198@huawei.com>
Date:   Thu, 20 Jan 2022 21:16:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220119170920.GB166109@lmaniak-dev.igk.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/1/20 1:09, Lukasz Maniak wrote:
> On Wed, Jan 19, 2022 at 05:06:55PM +0100, Lukasz Maniak wrote:
>> On Wed, Jan 19, 2022 at 06:22:07PM +0800, Yicong Yang wrote:
>>> Hi Lukasz, Bjorn,
>>>
>>> FYI, I tested with Mellanox CX-5, the VF also exists after FLR. Here's the operation:
>>
> 
> Please disregard my previous email. I missed your point.
> I take it that the Mellanox CX-5 also violates the spec.
> 
> As for using pci_disable_sriov() I did a test to get a backtrace for
> deadlock:
> [  846.904248] Call Trace:
> [  846.904251]  <TASK>
> [  846.904272]  __schedule+0x302/0x950
> [  846.904282]  schedule+0x58/0xd0
> [  846.904286]  pci_wait_cfg+0x63/0xb0
> [  846.904290]  ? wait_woken+0x70/0x70
> [  846.904296]  pci_cfg_access_lock+0x48/0x50
> [  846.904300]  sriov_disable+0x4d/0xf0
> [  846.904306]  pci_disable_sriov+0x26/0x30
> [  846.904310]  pcie_flr+0x2b/0x100
> [  846.904317]  pcie_reset_flr+0x25/0x30
> [  846.904322]  __pci_reset_function_locked+0x42/0x60
> [  846.904327]  pci_reset_function+0x40/0x70
> [  846.904334]  reset_store+0x5c/0xa0
> [  846.904347]  dev_attr_store+0x17/0x30
> [  846.904357]  sysfs_kf_write+0x3f/0x50
> [  846.904365]  kernfs_fop_write_iter+0x13b/0x1d0
> [  846.904371]  new_sync_write+0x117/0x1b0
> [  846.904379]  vfs_write+0x219/0x2b0
> [  846.904384]  ksys_write+0x67/0xe0
> [  846.904390]  __x64_sys_write+0x1a/0x20
> [  846.904395]  do_syscall_64+0x5c/0xc0
> [  846.904401]  ? debug_smp_processor_id+0x17/0x20
> [  846.904406]  ? fpregs_assert_state_consistent+0x26/0x50
> [  846.904413]  ? exit_to_user_mode_prepare+0x3f/0x1b0
> [  846.904418]  ? irqentry_exit_to_user_mode+0x9/0x20
> [  846.904423]  ? irqentry_exit+0x33/0x40
> [  846.904427]  ? exc_page_fault+0x89/0x180
> [  846.904431]  ? asm_exc_page_fault+0x8/0x30
> [  846.904438]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> As can be noticed during FLR we are already on a locked path for the
> device in __pci_reset_function_locked(). In addition, the device will reset
> the BARs during FLR on its own.
> 
> If we still would like to use pci_disable_sriov() for this purpose we
> need to pass a flag to sriov_disable() and use conditionally twice. It
> would look something like this:
> 
> static void sriov_disable(struct pci_dev *dev, bool flr)
> {
> 	struct pci_sriov *iov = dev->sriov;
> 
> 	if (!iov->num_VFs)
> 		return;
> 
> 	sriov_del_vfs(dev);
> 
> 	if (!flr) {
> 		iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 		pci_cfg_access_lock(dev);
> 		pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> 		ssleep(1);
> 		pci_cfg_access_unlock(dev);
> 	}
> 

It still leaves the VFE uncleared. So after reset the hardware IOV state is unsynchronized
with the system as we've removed the VFs already. so you may need:

static void sriov_disable(struct pci_dev *dev, bool locked)
{
	struct pci_sriov *iov = dev->sriov;

	if (!iov->num_VFs)
		return;

	sriov_del_vfs(dev);

	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
	if (!locked)
		pci_cfg_access_lock(dev);
	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
	ssleep(1);
	if (!locked)
		pci_cfg_access_unlock(dev);

	pcibios_sriov_disable(dev);

	if (iov->link != dev->devfn)
		sysfs_remove_link(&dev->dev.kobj, "dep_link");

	iov->num_VFs = 0;

	if (!flr)
		pci_iov_set_numvfs(dev, 0);
}

I'm not sure this is correct as we disable VF not through PF driver
and whether these PF driver involed need to modified after this
change.
(Yes through pdev->driver->sriov_configure() we'll also meet the
deadlock problem but that's the next step question).

With your patch based on 5.16 release when doing FLR reset on VF's PF
of Mellanox CX-5, the log says that there's a resource leakage and
leads to several calltraces. I paste the log below.

Perhaps Mellanox maintainers could help on this.

Thanks.

[  435.211235] mlx5_core 0000:01:00.0: E-Switch: Enable: mode(LEGACY), nvfs(1), active vports(2)
[  435.327158] pci 0000:01:00.2: [15b3:101a] type 00 class 0x020000
[  435.333197] pci 0000:01:00.2: enabling Extended Tags
[  435.338936] pci 0000:01:00.2: calling  mellanox_check_broken_intx_masking+0x0/0x1a0 @ 4328
[  435.347174] pci 0000:01:00.2: mellanox_check_broken_intx_masking+0x0/0x1a0 took 0 usecs
[  435.355224] mlx5_core 0000:01:00.2: Adding to iommu group 49
[  435.361639] mlx5_core 0000:01:00.2: enabling device (0000 -> 0002)
[  435.367917] mlx5_core 0000:01:00.2: firmware version: 16.27.1016
[  435.611252] mlx5_core 0000:01:00.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
[  435.628931] mlx5_core 0000:01:00.2: Assigned random MAC address 72:51:df:ba:6a:1e
[  435.636824] mlx5_core 0000:01:00.2: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
[  435.744665] mlx5_core 0000:01:00.2: Supported tc offload range - chains: 1, prios: 1
[  446.080370] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): 2RST_QP(0x50a) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x7ea02d)
[  446.094054] infiniband mlx5_2: destroy_qp_common:2599:(pid 4328): mlx5_ib: modify QP 0x000504 to RESET failed
[  446.104036] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_QP(0x501) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x25b161)
[  446.118092] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_CQ(0x401) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1870ad)
[  446.132028] ------------[ cut here ]------------
[  446.136629] Destroy of kernel CQ shouldn't fail
[  446.136648] WARNING: CPU: 37 PID: 4328 at drivers/infiniband/core/cq.c:345 ib_free_cq+0x16c/0x174
[  446.149991] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  446.189868] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Not tainted 5.16.0-pcie-iov+ #14
[  446.197833] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  446.206661] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  446.213591] pc : ib_free_cq+0x16c/0x174
[  446.217410] lr : ib_free_cq+0x16c/0x174
[  446.221229] sp : ffff80006172b5f0
[  446.224527] x29: ffff80006172b5f0 x28: ffff008009880000 x27: 0000000000000000
[  446.231632] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: 0000000000000000
[  446.238734] x23: ffff0041495b0000 x22: 0000000000000000 x21: ffff00413f3c0800
[  446.245837] x20: ffff00413f3c0928 x19: ffff00408d4bf800 x18: 0000000000000030
[  446.252939] x17: 0000000000000001 x16: ffffd9e776fbe8a0 x15: ffff0080098805d0
[  446.260043] x14: 0000000000000000 x13: 6c6961662074276e x12: 646c756f68732051
[  446.267145] x11: 43206c656e72656b x10: ffff205f2b8c5a28 x9 : ffffd9e776239854
[  446.274247] x8 : ffff205f2b5e0000 x7 : ffff205f2b8a0000 x6 : 0000000000025a28
[  446.281350] x5 : ffff00af3faf39b0 x4 : 0000000000000000 x3 : 0000000000000027
[  446.288452] x2 : 0000000000000023 x1 : 16e32808cb35d300 x0 : 0000000000000000
[  446.295554] Call trace:
[  446.297989]  ib_free_cq+0x16c/0x174
[  446.301463]  mlx5_ib_destroy_gsi+0xac/0x110 [mlx5_ib]
[  446.306507]  mlx5_ib_destroy_qp+0x64/0x70 [mlx5_ib]
[  446.311372]  ib_destroy_qp_user+0x7c/0x19c
[  446.315450]  ib_mad_port_close+0xac/0x164
[  446.319444]  ib_mad_remove_device+0x88/0xdc
[  446.323608]  remove_client_context+0xa4/0x100
[  446.327946]  disable_device+0x98/0x170
[  446.331680]  __ib_unregister_device+0x54/0xf0
[  446.336017]  ib_unregister_device+0x34/0x50
[  446.340182]  mlx5_ib_stage_ib_reg_cleanup+0x1c/0x2c [mlx5_ib]
[  446.345909]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  446.350254]  auxiliary_bus_remove+0x30/0x4c
[  446.354421]  __device_release_driver+0x190/0x23c
[  446.359017]  device_release_driver+0x38/0x50
[  446.363268]  bus_remove_device+0x130/0x140
[  446.367345]  device_del+0x184/0x434
[  446.370819]  delete_drivers+0x54/0xe0
[  446.374466]  mlx5_unregister_device+0x40/0x80
[  446.378803]  mlx5_uninit_one+0x34/0xd4
[  446.382536]  remove_one+0x4c/0xd0
[  446.385838]  pci_device_remove+0x48/0xe0
[  446.389744]  __device_release_driver+0x190/0x23c
[  446.394340]  device_release_driver+0x38/0x50
[  446.398592]  pci_stop_bus_device+0x8c/0xd0
[  446.402670]  pci_stop_and_remove_bus_device+0x24/0x40
[  446.407699]  pci_iov_remove_virtfn+0xb8/0x130
[  446.412038]  pci_reset_iov_state+0x5c/0xb0
[  446.416114]  pcie_flr+0x38/0x130
[  446.419329]  pcie_reset_flr+0x40/0x54
[  446.422976]  __pci_reset_function_locked+0x54/0x80
[  446.427745]  pci_reset_function+0x4c/0x90
[  446.431738]  reset_store+0x70/0xc0
[  446.435125]  dev_attr_store+0x24/0x40
[  446.438772]  sysfs_kf_write+0x50/0x60
[  446.442421]  kernfs_fop_write_iter+0x124/0x1b4
[  446.446845]  new_sync_write+0xf0/0x190
[  446.450578]  vfs_write+0x25c/0x2c0
[  446.453964]  ksys_write+0x78/0x104
[  446.457350]  __arm64_sys_write+0x28/0x3c
[  446.461254]  invoke_syscall+0x50/0x120
[  446.464988]  el0_svc_common.constprop.0+0x188/0x190
[  446.469843]  do_el0_svc+0x30/0x90
[  446.473145]  el0_svc+0x20/0x90
[  446.476186]  el0t_64_sync_handler+0x1a8/0x1ac
[  446.480524]  el0t_64_sync+0x1a0/0x1a4
[  446.484171] ---[ end trace d334416dff5120e3 ]---
[  446.488831] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_CQ(0x401) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1870ad)
[  446.503029] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DEALLOC_PD(0x801) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x31b635)
[  446.516961] ------------[ cut here ]------------
[  446.521560] Destroy of kernel PD shouldn't fail
[  446.521570] WARNING: CPU: 37 PID: 4328 at include/rdma/ib_verbs.h:3498 ib_mad_port_close+0x138/0x164
[  446.535170] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  446.575038] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Tainted: G        W         5.16.0-pcie-iov+ #14
[  446.584386] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  446.593214] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  446.600144] pc : ib_mad_port_close+0x138/0x164
[  446.604567] lr : ib_mad_port_close+0x138/0x164
[  446.608990] sp : ffff80006172b6b0
[  446.612290] x29: ffff80006172b6b0 x28: ffff008009880000 x27: 0000000000000000
[  446.619393] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: 0000000000000000
[  446.626495] x23: ffff0041495b04a8 x22: ffffd9e7794f8920 x21: ffff0040ed5978f8
[  446.633598] x20: ffff0040ed597870 x19: ffff0040ed597000 x18: 0000000000000030
[  446.640700] x17: 0000000000000001 x16: ffffd9e776fb5f04 x15: ffff0080098805d0
[  446.647801] x14: 0000000000000000 x13: 6c6961662074276e x12: 646c756f68732044
[  446.654903] x11: 50206c656e72656b x10: ffff205f2b8c60b8 x9 : ffffd9e776239854
[  446.662006] x8 : ffff205f2b5e0000 x7 : ffff205f2b8a0000 x6 : 00000000000260b8
[  446.669110] x5 : ffff00af3faf39b0 x4 : 0000000000000000 x3 : 0000000000000027
[  446.676212] x2 : 0000000000000023 x1 : 16e32808cb35d300 x0 : 0000000000000000
[  446.683314] Call trace:
[  446.685750]  ib_mad_port_close+0x138/0x164
[  446.689828]  ib_mad_remove_device+0x88/0xdc
[  446.693994]  remove_client_context+0xa4/0x100
[  446.698330]  disable_device+0x98/0x170
[  446.702062]  __ib_unregister_device+0x54/0xf0
[  446.706400]  ib_unregister_device+0x34/0x50
[  446.710565]  mlx5_ib_stage_ib_reg_cleanup+0x1c/0x2c [mlx5_ib]
[  446.716293]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  446.720639]  auxiliary_bus_remove+0x30/0x4c
[  446.724804]  __device_release_driver+0x190/0x23c
[  446.729402]  device_release_driver+0x38/0x50
[  446.733652]  bus_remove_device+0x130/0x140
[  446.737731]  device_del+0x184/0x434
[  446.741204]  delete_drivers+0x54/0xe0
[  446.744850]  mlx5_unregister_device+0x40/0x80
[  446.749186]  mlx5_uninit_one+0x34/0xd4
[  446.752918]  remove_one+0x4c/0xd0
[  446.756219]  pci_device_remove+0x48/0xe0
[  446.760125]  __device_release_driver+0x190/0x23c
[  446.764720]  device_release_driver+0x38/0x50
[  446.768971]  pci_stop_bus_device+0x8c/0xd0
[  446.773048]  pci_stop_and_remove_bus_device+0x24/0x40
[  446.778075]  pci_iov_remove_virtfn+0xb8/0x130
[  446.782413]  pci_reset_iov_state+0x5c/0xb0
[  446.786490]  pcie_flr+0x38/0x130
[  446.789703]  pcie_reset_flr+0x40/0x54
[  446.793349]  __pci_reset_function_locked+0x54/0x80
[  446.798118]  pci_reset_function+0x4c/0x90
[  446.802110]  reset_store+0x70/0xc0
[  446.805498]  dev_attr_store+0x24/0x40
[  446.809144]  sysfs_kf_write+0x50/0x60
[  446.812791]  kernfs_fop_write_iter+0x124/0x1b4
[  446.817216]  new_sync_write+0xf0/0x190
[  446.820947]  vfs_write+0x25c/0x2c0
[  446.824335]  ksys_write+0x78/0x104
[  446.827723]  __arm64_sys_write+0x28/0x3c
[  446.831628]  invoke_syscall+0x50/0x120
[  446.835359]  el0_svc_common.constprop.0+0x188/0x190
[  446.840215]  do_el0_svc+0x30/0x90
[  446.843516]  el0_svc+0x20/0x90
[  446.846558]  el0t_64_sync_handler+0x1a8/0x1ac
[  446.850894]  el0t_64_sync+0x1a0/0x1a4
[  446.854539] ---[ end trace d334416dff5120e4 ]---
[  446.903110] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_UCTX(0xa06) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x15555)
[  446.917110] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): 2RST_QP(0x50a) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x7ea02d)
[  446.930787] infiniband mlx5_2: destroy_qp_common:2599:(pid 4328): mlx5_ib: modify QP 0x000505 to RESET failed
[  446.940726] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_QP(0x501) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x25b161)
[  446.954736] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DESTROY_CQ(0x401) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1870ad)
[  446.968832] mlx5_core 0000:01:00.2: mlx5_cmd_check:782:(pid 4328): DEALLOC_PD(0x801) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x31b635)
[  446.982795] ------------[ cut here ]------------
[  446.987400] Destroy of kernel PD shouldn't fail
[  446.987417] WARNING: CPU: 37 PID: 4328 at include/rdma/ib_verbs.h:3498 mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x8c/0xc0 [mlx5_ib]
[  447.003359] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  447.043229] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Tainted: G        W         5.16.0-pcie-iov+ #14
[  447.052577] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  447.061406] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  447.068336] pc : mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x8c/0xc0 [mlx5_ib]
[  447.075102] lr : mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x8c/0xc0 [mlx5_ib]
[  447.081866] sp : ffff80006172b7e0
[  447.085165] x29: ffff80006172b7e0 x28: ffff008009880000 x27: 0000000000000000
[  447.092269] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: ffff008009880000
[  447.099372] x23: 0000000000000080 x22: ffffd9e70116cfd0 x21: ffffd9e701163d28
[  447.106474] x20: ffff0041495b0000 x19: ffff0041495b0000 x18: 0000000000000030
[  447.113576] x17: 0000000000000001 x16: ffffd9e77771be14 x15: ffff0080098805d0
[  447.120679] x14: 0000000000000000 x13: 6c6961662074276e x12: 646c756f68732044
[  447.127781] x11: 50206c656e72656b x10: ffff205f2b8c6748 x9 : ffffd9e776239854
[  447.134884] x8 : ffff205f2b5e0000 x7 : ffff205f2b8a0000 x6 : 0000000000026748
[  447.141986] x5 : ffff00af3faf39b0 x4 : 0000000000000000 x3 : 0000000000000027
[  447.149090] x2 : 0000000000000023 x1 : 16e32808cb35d300 x0 : 0000000000000000
[  447.156192] Call trace:
[  447.158627]  mlx5_ib_stage_pre_ib_reg_umr_cleanup+0x8c/0xc0 [mlx5_ib]
[  447.165046]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  447.169390]  auxiliary_bus_remove+0x30/0x4c
[  447.173556]  __device_release_driver+0x190/0x23c
[  447.178152]  device_release_driver+0x38/0x50
[  447.182402]  bus_remove_device+0x130/0x140
[  447.186480]  device_del+0x184/0x434
[  447.189954]  delete_drivers+0x54/0xe0
[  447.193600]  mlx5_unregister_device+0x40/0x80
[  447.197938]  mlx5_uninit_one+0x34/0xd4
[  447.201671]  remove_one+0x4c/0xd0
[  447.204972]  pci_device_remove+0x48/0xe0
[  447.208876]  __device_release_driver+0x190/0x23c
[  447.213472]  device_release_driver+0x38/0x50
[  447.217723]  pci_stop_bus_device+0x8c/0xd0
[  447.221801]  pci_stop_and_remove_bus_device+0x24/0x40
[  447.226830]  pci_iov_remove_virtfn+0xb8/0x130
[  447.231168]  pci_reset_iov_state+0x5c/0xb0
[  447.235247]  pcie_flr+0x38/0x130
[  447.238460]  pcie_reset_flr+0x40/0x54
[  447.242106]  __pci_reset_function_locked+0x54/0x80
[  447.246874]  pci_reset_function+0x4c/0x90
[  447.250866]  reset_store+0x70/0xc0
[  447.254252]  dev_attr_store+0x24/0x40
[  447.257898]  sysfs_kf_write+0x50/0x60
[  447.261545]  kernfs_fop_write_iter+0x124/0x1b4
[  447.265969]  new_sync_write+0xf0/0x190
[  447.269702]  vfs_write+0x25c/0x2c0
[  447.273089]  ksys_write+0x78/0x104
[  447.276477]  __arm64_sys_write+0x28/0x3c
[  447.280382]  invoke_syscall+0x50/0x120
[  447.284115]  el0_svc_common.constprop.0+0x188/0x190
[  447.288970]  do_el0_svc+0x30/0x90
[  447.292269]  el0_svc+0x20/0x90
[  447.295310]  el0t_64_sync_handler+0x1a8/0x1ac
[  447.299648]  el0t_64_sync+0x1a0/0x1a4
[  447.303294] ---[ end trace d334416dff5120e5 ]---
[  447.307952] mlx5_core 0000:01:00.2: up_rel_func:90:(pid 4328): failed to free uar index 17
[  447.351101] ------------[ cut here ]------------
[  447.355699] Destroy of kernel SRQ shouldn't fail
[  447.355712] WARNING: CPU: 37 PID: 4328 at include/rdma/ib_verbs.h:3688 mlx5_ib_dev_res_cleanup+0xc4/0x150 [mlx5_ib]
[  447.370701] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  447.410571] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Tainted: G        W         5.16.0-pcie-iov+ #14
[  447.419919] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  447.428749] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  447.435678] pc : mlx5_ib_dev_res_cleanup+0xc4/0x150 [mlx5_ib]
[  447.441406] lr : mlx5_ib_dev_res_cleanup+0xc4/0x150 [mlx5_ib]
[  447.447132] sp : ffff80006172b7e0
[  447.450431] x29: ffff80006172b7e0 x28: ffff008009880000 x27: 0000000000000000
[  447.457533] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: ffff008009880000
[  447.464635] x23: 0000000000000080 x22: ffffd9e70116cfd0 x21: ffffd9e701163d28
[  447.471737] x20: ffff0041495b0b70 x19: ffff0041495b0000 x18: 0000000000000030
[  447.478838] x17: 657266206f742064 x16: ffffd9e77771be14 x15: ffff0080098805d0
[  447.485942] x14: 0000000000000000 x13: 6c6961662074276e x12: 646c756f68732051
[  447.493045] x11: 5253206c656e7265 x10: ffff205f2b8c6cd0 x9 : ffffd9e776239854
[  447.500147] x8 : ffff205f2b5e0000 x7 : ffff205f2b8a0000 x6 : 0000000000026cd0
[  447.507250] x5 : ffff00af3faf39b0 x4 : 0000000000000000 x3 : 0000000000000027
[  447.514351] x2 : 0000000000000023 x1 : 16e32808cb35d300 x0 : 0000000000000000
[  447.521453] Call trace:
[  447.523888]  mlx5_ib_dev_res_cleanup+0xc4/0x150 [mlx5_ib]
[  447.529270]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  447.533613]  auxiliary_bus_remove+0x30/0x4c
[  447.537778]  __device_release_driver+0x190/0x23c
[  447.542375]  device_release_driver+0x38/0x50
[  447.546627]  bus_remove_device+0x130/0x140
[  447.550703]  device_del+0x184/0x434
[  447.554175]  delete_drivers+0x54/0xe0
[  447.557822]  mlx5_unregister_device+0x40/0x80
[  447.562159]  mlx5_uninit_one+0x34/0xd4
[  447.565892]  remove_one+0x4c/0xd0
[  447.569192]  pci_device_remove+0x48/0xe0
[  447.573098]  __device_release_driver+0x190/0x23c
[  447.577694]  device_release_driver+0x38/0x50
[  447.581944]  pci_stop_bus_device+0x8c/0xd0
[  447.586022]  pci_stop_and_remove_bus_device+0x24/0x40
[  447.591049]  pci_iov_remove_virtfn+0xb8/0x130
[  447.595386]  pci_reset_iov_state+0x5c/0xb0
[  447.599464]  pcie_flr+0x38/0x130
[  447.602678]  pcie_reset_flr+0x40/0x54
[  447.606323]  __pci_reset_function_locked+0x54/0x80
[  447.611092]  pci_reset_function+0x4c/0x90
[  447.615085]  reset_store+0x70/0xc0
[  447.618473]  dev_attr_store+0x24/0x40
[  447.622120]  sysfs_kf_write+0x50/0x60
[  447.625766]  kernfs_fop_write_iter+0x124/0x1b4
[  447.630189]  new_sync_write+0xf0/0x190
[  447.633921]  vfs_write+0x25c/0x2c0
[  447.637308]  ksys_write+0x78/0x104
[  447.640696]  __arm64_sys_write+0x28/0x3c
[  447.644601]  invoke_syscall+0x50/0x120
[  447.648334]  el0_svc_common.constprop.0+0x188/0x190
[  447.653190]  do_el0_svc+0x30/0x90
[  447.656490]  el0_svc+0x20/0x90
[  447.659531]  el0t_64_sync_handler+0x1a8/0x1ac
[  447.663867]  el0t_64_sync+0x1a0/0x1a4
[  447.667512] ---[ end trace d334416dff5120e6 ]---
[  447.672291] ------------[ cut here ]------------
[  447.676892] Destroy of kernel CQ shouldn't fail
[  447.676904] WARNING: CPU: 37 PID: 4328 at include/rdma/ib_verbs.h:3936 mlx5_ib_dev_res_cleanup+0x118/0x150 [mlx5_ib]
[  447.691895] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  447.731764] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Tainted: G        W         5.16.0-pcie-iov+ #14
[  447.741112] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  447.749942] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  447.756872] pc : mlx5_ib_dev_res_cleanup+0x118/0x150 [mlx5_ib]
[  447.762685] lr : mlx5_ib_dev_res_cleanup+0x118/0x150 [mlx5_ib]
[  447.768497] sp : ffff80006172b7e0
[  447.771795] x29: ffff80006172b7e0 x28: ffff008009880000 x27: 0000000000000000
[  447.778897] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: ffff008009880000
[  447.786000] x23: 0000000000000080 x22: ffffd9e70116cfd0 x21: ffffd9e701163d28
[  447.793103] x20: ffff0041495b0b70 x19: ffff0041495b0000 x18: 0000000000000030
[  447.800207] x17: 657266206f742064 x16: ffffd9e77771be14 x15: ffff0080098805d0
[  447.807309] x14: 0000000000000000 x13: 6c6961662074276e x12: 646c756f68732051
[  447.814410] x11: 43206c656e72656b x10: ffff205f2b8c7240 x9 : ffffd9e776239854
[  447.821514] x8 : ffff205f2b5e0000 x7 : ffff205f2b8a0000 x6 : 0000000000027240
[  447.828615] x5 : ffff00af3faf39b0 x4 : 0000000000000000 x3 : 0000000000000027
[  447.835717] x2 : 0000000000000023 x1 : 16e32808cb35d300 x0 : 0000000000000000
[  447.842818] Call trace:
[  447.845252]  mlx5_ib_dev_res_cleanup+0x118/0x150 [mlx5_ib]
[  447.850719]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  447.855063]  auxiliary_bus_remove+0x30/0x4c
[  447.859227]  __device_release_driver+0x190/0x23c
[  447.863825]  device_release_driver+0x38/0x50
[  447.868076]  bus_remove_device+0x130/0x140
[  447.872154]  device_del+0x184/0x434
[  447.875628]  delete_drivers+0x54/0xe0
[  447.879274]  mlx5_unregister_device+0x40/0x80
[  447.883611]  mlx5_uninit_one+0x34/0xd4
[  447.887343]  remove_one+0x4c/0xd0
[  447.890644]  pci_device_remove+0x48/0xe0
[  447.894549]  __device_release_driver+0x190/0x23c
[  447.899146]  device_release_driver+0x38/0x50
[  447.903396]  pci_stop_bus_device+0x8c/0xd0
[  447.907473]  pci_stop_and_remove_bus_device+0x24/0x40
[  447.912501]  pci_iov_remove_virtfn+0xb8/0x130
[  447.916838]  pci_reset_iov_state+0x5c/0xb0
[  447.920916]  pcie_flr+0x38/0x130
[  447.924131]  pcie_reset_flr+0x40/0x54
[  447.927777]  __pci_reset_function_locked+0x54/0x80
[  447.932547]  pci_reset_function+0x4c/0x90
[  447.936538]  reset_store+0x70/0xc0
[  447.939924]  dev_attr_store+0x24/0x40
[  447.943570]  sysfs_kf_write+0x50/0x60
[  447.947216]  kernfs_fop_write_iter+0x124/0x1b4
[  447.951640]  new_sync_write+0xf0/0x190
[  447.955373]  vfs_write+0x25c/0x2c0
[  447.958760]  ksys_write+0x78/0x104
[  447.962147]  __arm64_sys_write+0x28/0x3c
[  447.966052]  invoke_syscall+0x50/0x120
[  447.969784]  el0_svc_common.constprop.0+0x188/0x190
[  447.974639]  do_el0_svc+0x30/0x90
[  447.977939]  el0_svc+0x20/0x90
[  447.980980]  el0t_64_sync_handler+0x1a8/0x1ac
[  447.985316]  el0t_64_sync+0x1a0/0x1a4
[  447.988961] ---[ end trace d334416dff5120e7 ]---
[  447.993669] ------------[ cut here ]------------
[  447.998264] WARNING: CPU: 37 PID: 4328 at drivers/infiniband/core/verbs.c:347 ib_dealloc_pd_user+0x94/0x9c
[  448.007872] Modules linked in: bluetooth rfkill xt_addrtype iptable_filter xt_conntrack overlay dm_mod ib_isert iscsi_target_mod rpcrdma ib_umad ib_iser ib_ipoib libiscsi scsi_transport_iscsi mlx5_ib hns_roce_hw_v2 hisi_hpre hisi_sec2 sbsa_gwdt hisi_zip hisi_trng_v2 arm_spe_pmu hisi_qm hisi_uncore_l3c_pmu hisi_uncore_hha_pmu uacce hisi_uncore_ddrc_pmu crct10dif_ce rng_core spi_dw_mmio hisi_uncore_pmu hns3 hclge hisi_sas_v3_hw hnae3 hisi_sas_main libsas
[  448.047740] CPU: 37 PID: 4328 Comm: bash Kdump: loaded Tainted: G        W         5.16.0-pcie-iov+ #14
[  448.057088] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
[  448.065917] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  448.072845] pc : ib_dealloc_pd_user+0x94/0x9c
[  448.077183] lr : ib_dealloc_pd_user+0x3c/0x9c
[  448.081519] sp : ffff80006172b7c0
[  448.084819] x29: ffff80006172b7c0 x28: ffff008009880000 x27: 0000000000000000
[  448.091922] x26: ffff00800e8c00d0 x25: 0000000000000000 x24: ffff008009880000
[  448.099025] x23: 0000000000000080 x22: ffffd9e70116cfd0 x21: ffffd9e701163d28
[  448.106128] x20: 0000000000000000 x19: ffff00414927d080 x18: 0000000000000030
[  448.113230] x17: 657266206f742064 x16: ffffd9e77641d550 x15: 0000000000000000
[  448.120333] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  448.127435] x11: 0000000000000000 x10: 0000000000000bb0 x9 : ffffd9e77641d820
[  448.134537] x8 : ffff008009880c10 x7 : 0000000000000000 x6 : 0000000000000001
[  448.141640] x5 : ffffd9e701141da8 x4 : 0000000000000000 x3 : ffff0041396fe400
[  448.148743] x2 : 16e32808cb35d300 x1 : 0000000000000000 x0 : 0000000000000002
[  448.155846] Call trace:
[  448.158280]  ib_dealloc_pd_user+0x94/0x9c
[  448.162271]  mlx5_ib_dev_res_cleanup+0x90/0x150 [mlx5_ib]
[  448.167654]  mlx5r_remove+0x54/0x80 [mlx5_ib]
[  448.171997]  auxiliary_bus_remove+0x30/0x4c
[  448.176161]  __device_release_driver+0x190/0x23c
[  448.180756]  device_release_driver+0x38/0x50
[  448.185007]  bus_remove_device+0x130/0x140
[  448.189085]  device_del+0x184/0x434
[  448.192558]  delete_drivers+0x54/0xe0
[  448.196204]  mlx5_unregister_device+0x40/0x80
[  448.200541]  mlx5_uninit_one+0x34/0xd4
[  448.204273]  remove_one+0x4c/0xd0
[  448.207574]  pci_device_remove+0x48/0xe0
[  448.211480]  __device_release_driver+0x190/0x23c
[  448.216075]  device_release_driver+0x38/0x50
[  448.220326]  pci_stop_bus_device+0x8c/0xd0
[  448.224404]  pci_stop_and_remove_bus_device+0x24/0x40
[  448.229431]  pci_iov_remove_virtfn+0xb8/0x130
[  448.233769]  pci_reset_iov_state+0x5c/0xb0
[  448.237846]  pcie_flr+0x38/0x130
[  448.241060]  pcie_reset_flr+0x40/0x54
[  448.244706]  __pci_reset_function_locked+0x54/0x80
[  448.249475]  pci_reset_function+0x4c/0x90
[  448.253467]  reset_store+0x70/0xc0
[  448.256853]  dev_attr_store+0x24/0x40
[  448.260499]  sysfs_kf_write+0x50/0x60
[  448.264146]  kernfs_fop_write_iter+0x124/0x1b4
[  448.268569]  new_sync_write+0xf0/0x190
[  448.272301]  vfs_write+0x25c/0x2c0
[  448.275688]  ksys_write+0x78/0x104
[  448.279075]  __arm64_sys_write+0x28/0x3c
[  448.282980]  invoke_syscall+0x50/0x120
[  448.286714]  el0_svc_common.constprop.0+0x188/0x190
[  448.291571]  do_el0_svc+0x30/0x90
[  448.294871]  el0_svc+0x20/0x90
[  448.297911]  el0t_64_sync_handler+0x1a8/0x1ac
[  448.302249]  el0t_64_sync+0x1a0/0x1a4
[  448.305894] ---[ end trace d334416dff5120e8 ]---
[  448.363136] restrack: ------------[ cut here ]------------
[  448.368601] infiniband mlx5_2: BUG: RESTRACK detected leak of resources
[  448.375187] restrack: Kernel PD object allocated by mlx5_ib is not freed
[  448.381861] restrack: Kernel PD object allocated by ib_core is not freed
[  448.388534] restrack: Kernel PD object allocated by mlx5_ib is not freed
[  448.395207] restrack: Kernel CQ object allocated by mlx5_ib is not freed
[  448.401879] restrack: Kernel SRQ object allocated by mlx5_ib is not freed
[  448.408638] restrack: Kernel SRQ object allocated by mlx5_ib is not freed
[  448.415401] restrack: ------------[ cut here ]------------
[  448.455025] mlx5_core 0000:01:00.0: poll_health:795:(pid 0): Fatal error 1 detected
[  448.455107] pcieport 0000:00:00.0: AER: Corrected error received: 0000:01:00.0
[  448.469914] mlx5_core 0000:01:00.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
[  448.479792] mlx5_core 0000:01:00.0:   device [15b3:1019] error status/mask=00002000/00000000
[  448.488196] mlx5_core 0000:01:00.0:    [13] NonFatalErr
[  448.494415] pcieport 0000:00:00.0: AER: Multiple Corrected error received: 0000:01:00.0
[  448.502452] mlx5_core 0000:01:00.1: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
[  448.512324] mlx5_core 0000:01:00.1:   device [15b3:1019] error status/mask=00002000/00000000
[  448.520726] mlx5_core 0000:01:00.1:    [13] NonFatalErr
[  448.526951] pcieport 0000:00:00.0: AER: Corrected error received: 0000:01:00.0
[  448.534176] pcieport 0000:00:00.0: AER: Multiple Corrected error received: 0000:01:00.0
[  448.619235] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8192 of flow group id 19
[  448.630750] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 21 of ft 262149
[  448.641277] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 20 of ft 262149
[  448.651794] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 19 of ft 262149
[  448.662309] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 18 of ft 262149
[  448.672830] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 17 of ft 262149
[  448.683417] mlx5_core 0000:01:00.2: update_root_ft_destroy:2127:(pid 4328): Update root flow table of id(262149) qpn(0) failed
[  448.694843] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
[  448.703993] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 16 of ft 262148
[  448.714516] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 15 of ft 262148
[  448.725033] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 14 of ft 262148
[  448.735564] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
[  448.744714] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 0 of flow group id 11
[  448.755936] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 1 of flow group id 11
[  448.767145] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 2 of flow group id 11
[  448.778352] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 3 of flow group id 11
[  448.789558] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 4 of flow group id 11
[  448.800770] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 5 of flow group id 11
[  448.812049] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 6 of flow group id 11
[  448.823261] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 7 of flow group id 11
[  448.834471] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 14 of flow group id 12
[  448.845774] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 15 of flow group id 12
[  448.857072] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 16 of flow group id 13
[  448.868370] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8 of flow group id 11
[  448.879579] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 9 of flow group id 11
[  448.890788] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 10 of flow group id 11
[  448.902087] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 11 of flow group id 11
[  448.913382] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 12 of flow group id 11
[  448.924675] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 13 of flow group id 11
[  448.935980] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 13 of ft 2
[  448.946072] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 12 of ft 2
[  448.956160] mlx5_core 0000:01:00.2: del_hw_flow_group:644:(pid 4328): flow steering can't destroy fg 11 of ft 2
[  448.966249] mlx5_core 0000:01:00.2: del_hw_flow_table:507:(pid 4328): flow steering can't destroy ft
[  448.975395] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 0 of flow group id 8
[  448.986526] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 1 of flow group id 8
[  448.997647] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 2 of flow group id 8
[  449.008768] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 3 of flow group id 8
[  449.019890] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 4 of flow group id 8
[  449.031013] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 5 of flow group id 8
[  449.042135] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 6 of flow group id 8
[  449.053257] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 7 of flow group id 8
[  449.064380] mlx5_core 0000:01:00.2: del_hw_fte:605:(pid 4328): flow steering can't delete fte in index 8 of flow group id 9
[...]


> 	pcibios_sriov_disable(dev);
> 
> 	if (iov->link != dev->devfn)
> 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> 
> 	iov->num_VFs = 0;
> 
> 	if (!flr)
> 		pci_iov_set_numvfs(dev, 0);
> }
> 
> Whether this is better, I leave to your evaluation.
> 
> Thanks,
> Lukasz
> 
>> Did you test with or without my patch?
>>
>> Here is the result with my patch for the NVMe device in QEMU:
>>
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -s 01:
>> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+
>>                 IOVSta: Migration-
>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>>                 VF offset: 1, stride: 1, Device ID: 0010
>>                 VF Migration: offset: 00000000, BIR: 0
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > sriov_numvfs
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>>                 IOVSta: Migration-
>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 1, Function Dependency Link: 00
>>                 VF offset: 1, stride: 1, Device ID: 0010
>>                 VF Migration: offset: 00000000, BIR: 0
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# echo 1 > reset
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>         Capabilities: [120 v1] Single Root I/O Virtualization (SR-IOV)
>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>>                 IOVSta: Migration-
>>                 Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function Dependency Link: 00
>>                 VF offset: 1, stride: 1, Device ID: 0010
>>                 VF Migration: offset: 00000000, BIR: 0
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# lspci -xxx -s 01:00.0
>> 01:00.0 Non-Volatile memory controller: Red Hat, Inc. Device 0010 (rev 02)
>> 00: 36 1b 10 00 07 05 10 00 02 02 08 01 00 00 00 00
>> 10: 04 00 80 fe 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
>> 40: 11 80 40 80 00 20 00 00 00 30 00 00 00 00 00 00
>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 01 00 03 00 08 00 00 00 00 00 00 00 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 10 60 02 00 00 80 00 10 00 00 00 00 11 04 00 00
>> 90: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> root@qemu-sriov:/sys/devices/pci0000:00/0000:00:03.0/0000:01:00.0# cat reset_method
>> flr bus
>>
>>>
>>> [root@localhost ~]# lspci  -s 01:
>>> 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>> 01:00.1 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy+ 10BitTagReq-
>>>                 IOVSta: Migration-
>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 0, Function Dependency Link: 00
>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>                 VF Migration: offset: 00000000, BIR: 0
>>> [root@localhost 0000:01:00.0]# echo 1 > sriov_numvfs
>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
>>>                 IOVSta: Migration-
>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>                 VF Migration: offset: 00000000, BIR: 0
>>> [root@localhost 0000:01:00.0]# echo 1 > reset
>>> [root@localhost ~]# lspci -vvv -s 01:00.0 | egrep "IOV|VF"
>>>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>>>                 IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
>>>                 IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
>>>                 IOVSta: Migration-
>>>                 Initial VFs: 16, Total VFs: 16, Number of VFs: 1, Function Dependency Link: 00
>>>                 VF offset: 2, stride: 1, Device ID: 101a
>>>                 VF Migration: offset: 00000000, BIR: 0
>>> [root@localhost ~]# lspci -xxx -s 01:00.0
>>> 01:00.0 Ethernet controller: Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>>> 00: b3 15 19 10 46 05 10 00 00 00 00 02 08 00 80 00
>>> 10: 0c 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00
>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b3 15 08 00
>>> 30: 00 00 70 e6 60 00 00 00 00 00 00 00 ff 01 00 00
>>> 40: 01 00 c3 81 08 00 00 00 03 9c cc 80 00 78 00 00
>>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 20 00 01
>>> 60: 10 48 02 00 e2 8f e0 11 5f 29 00 00 04 71 41 00
>>> 70: 08 00 04 11 00 00 00 00 00 00 00 00 00 00 00 00
>>> 80: 00 00 00 00 17 00 01 00 40 00 00 00 1e 00 80 01
>>> 90: 04 00 1e 00 00 00 00 00 00 00 00 00 11 c0 3f 80
>>> a0: 00 20 00 00 00 30 00 00 00 00 00 00 00 00 00 00
>>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> c0: 09 40 18 00 0a 00 00 20 f0 1a 00 00 00 00 00 00
>>> d0: 20 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
>>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> [root@localhost 0000:01:00.0]# cat reset_method
>>> flr bus
>>>
>>> On 2022/1/19 10:47, Yicong Yang wrote:
>>>> On 2022/1/19 0:30, Lukasz Maniak wrote:
>>>>> On Tue, Jan 18, 2022 at 07:07:23PM +0800, Yicong Yang wrote:
>>>>>> On 2022/1/18 6:55, Bjorn Helgaas wrote:
>>>>>>> [+cc Alex in case he has comments on how FLR should work on
>>>>>>> non-conforming hns3 devices]
>>>>>>>
>>>>>>> On Sat, Jan 15, 2022 at 05:22:19PM +0800, Yicong Yang wrote:
>>>>>>>> On 2022/1/15 0:37, Bjorn Helgaas wrote:
>>>>>>>>> On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
>>>>>>>>>> On 2022/1/14 0:45, Lukasz Maniak wrote:
>>>>>>>>>>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
>>>>>>>>>>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
>>>>>>>>>>>>> As per PCI Express specification, FLR to a PF resets the PF state as
>>>>>>>>>>>>> well as the SR-IOV extended capability including VF Enable which means
>>>>>>>>>>>>> that VFs no longer exist.
>>>>>>>>>>>>
>>>>>>>>>>>> Can you add a specific reference to the spec, please?
>>>>>>>>>>>>
>>>>>>>>>>> Following the Single Root I/O Virtualization and Sharing Specification:
>>>>>>>>>>> 2.2.3. FLR That Targets a PF
>>>>>>>>>>> PFs must support FLR.
>>>>>>>>>>> FLR to a PF resets the PF state as well as the SR-IOV extended
>>>>>>>>>>> capability including VF Enable which means that VFs no longer exist.
>>>>>>>>>>>
>>>>>>>>>>> For PCI Express Base Specification Revision 5.0 and later, this is
>>>>>>>>>>> section 9.2.2.3.
>>>>>>>>>
>>>>>>>>> This is also the section in the new PCIe r6.0.  Let's use that.
>>>>>>>>>
>>>>>>>>>>>>> Currently, the IOV state is not updated during FLR, resulting in
>>>>>>>>>>>>> non-compliant PCI driver behavior.
>>>>>>>>>>>>
>>>>>>>>>>>> And include a little detail about what problem is observed?  How would
>>>>>>>>>>>> a user know this problem is occurring?
>>>>>>>>>>>>
>>>>>>>>>>> The problem is that the state of the kernel and HW as to the number of
>>>>>>>>>>> VFs gets out of sync after FLR.
>>>>>>>>>>>
>>>>>>>>>>> This results in further listing, after the FLR is performed by the HW,
>>>>>>>>>>> of VFs that actually no longer exist and should no longer be reported on
>>>>>>>>>>> the PCI bus. lspci return FFs for these VFs.
>>>>>>>>>>
>>>>>>>>>> There're some exceptions. Take HiSilicon's hns3 and sec device as an
>>>>>>>>>> example, the VF won't be destroyed after the FLR reset.
>>>>>>>>>
>>>>>>>>> If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
>>>>>>>>> exist after FLR, isn't that a violation of sec 9.2.2.3?
>>>>>>>>
>>>>>>>> yes I think it's a violation to the spec.
>>>>>>>
>>>>>>> Thanks for confirming that.
>>>>>>>
>>>>>>>>> If hns3 and sec don't conform to the spec, we should have some sort of
>>>>>>>>> quirk that serves to document and work around this.
>>>>>>>>
>>>>>>>> ok I think it'll help. Do you mean something like this based on this patch:
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>>> index 69ee321027b4..0e4976c669b2 100644
>>>>>>>> --- a/drivers/pci/iov.c
>>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>>> @@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>  		return;
>>>>>>>>  	if (!iov->num_VFs)
>>>>>>>>  		return;
>>>>>>>> +	if (dev->flr_no_vf_reset)
>>>>>>>> +		return;
>>>>>>>>
>>>>>>>>  	sriov_del_vfs(dev);
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>>> index 003950c738d2..c8ffcb0ac612 100644
>>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>>> @@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
>>>>>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
>>>>>>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
>>>>>>>> + * Don't reset these devices' IOV state when doing FLR.
>>>>>>>> + */
>>>>>>>> +static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
>>>>>>>> +{
>>>>>>>> +	pdev->flr_no_vf_reset = 1;
>>>>>>>> +}
>>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
>>>>>>>> +/* ...some other devices have this quirk */
>>>>>>>
>>>>>>> Yes, I think something along this line will help.
>>>>>>>
>>>>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>>>>> index 18a75c8e615c..e62f9fa4d48f 100644
>>>>>>>> --- a/include/linux/pci.h
>>>>>>>> +++ b/include/linux/pci.h
>>>>>>>> @@ -454,6 +454,7 @@ struct pci_dev {
>>>>>>>>  	unsigned int	is_probed:1;		/* Device probing in progress */
>>>>>>>>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
>>>>>>>>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>>>>>>>> +	unsigned int	flr_no_vf_reset:1;	/* VF won't be destroyed after PF's FLR */
>>>>>>>>
>>>>>>>>>> Currently the transactions with the VF will be restored after the
>>>>>>>>>> FLR. But this patch will break that, the VF is fully disabled and
>>>>>>>>>> the transaction cannot be restored. User needs to reconfigure it,
>>>>>>>>>> which is unnecessary before this patch.
>>>>>>>>>
>>>>>>>>> What does it mean for a "transaction to be restored"?  Maybe you mean
>>>>>>>>> this patch removes the *VFs* via sriov_del_vfs(), and whoever
>>>>>>>>> initiated the FLR would need to re-enable VFs via pci_enable_sriov()
>>>>>>>>> or something similar?
>>>>>>>>
>>>>>>>> Partly. It'll also terminate the VF users.
>>>>>>>> Think that I attach the VF of hns to a VM by vfio and ping the network
>>>>>>>> in the VM, when doing FLR the 'ping' will pause and after FLR it'll
>>>>>>>> resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
>>>>>>>> methods. The user of VM may not realize there is a FLR of the PF as the
>>>>>>>> VF always exists and the 'ping' is never terminated.
>>>>>>>>
>>>>>>>> If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
>>>>>>>> until no one is using the device, for example the 'ping' is finished.
>>>>>>>> 2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
>>>>>>>> it into the VM and restart the ping. That's a big difference.
>>>>>>>>
>>>>>>>>> If FLR disables VFs, it seems like we should expect to have to
>>>>>>>>> re-enable them if we want them.
>>>>>>>>
>>>>>>>> It involves a remove()/probe() process of the VF driver and the user
>>>>>>>> of the VF will be terminated, just like the situation illustrated
>>>>>>>> above.
>>>>>>>
>>>>>>> I think users of FLR should be able to rely on it working per spec,
>>>>>>> i.e., that VFs will be destroyed.  If hardware like hns3 doesn't do
>>>>>>> that, the quirk should work around that in software by doing it
>>>>>>> explicitly.
>>>>>>>
>>>>>>> I don't think the non-standard behavior should be exposed to the
>>>>>>> users.  The user should not have to know about this hns3 issue.
>>>>>>>
>>>>>>> If FLR on a standard NIC terminates a ping on a VF, FLR on an hns3 NIC
>>>>>>> should also terminate a ping on a VF.
>>>>>>>
>>>>>>
>>>>>> ok thanks for the discussion, agree on that. According to the spec, after
>>>>>> the FLR to the PF the VF does not exist anymore, so the ping will be terminated.
>>>>>> Our hns3 and sec team are still evaluating it before coming to a solution of
>>>>>> whether using a quirk or comform to the spec.
>>>>>>
>>>>>> For this patch it looks reasonable to me, but some questions about the code below.
>>>>>>
>>>>>>>>>> Can we handle this problem in another way? Maybe test the VF's
>>>>>>>>>> vendor device ID after the FLR reset to see whether it has really
>>>>>>>>>> gone or not?
>>>>>>>>>>
>>>>>>>>>>> sriov_numvfs in sysfs returns old invalid value and does not allow
>>>>>>>>>>> setting a new value before explicitly setting 0 in the first place.
>>>>>>>>>>>
>>>>>>>>>>>>> This patch introduces a simple function, called on the FLR path, that
>>>>>>>>>>>>> removes the virtual function devices from the PCI bus and their
>>>>>>>>>>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
>>>>>>>>>>>>> state.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>>>>>>>>>>>>>  drivers/pci/pci.c |  2 ++
>>>>>>>>>>>>>  drivers/pci/pci.h |  4 ++++
>>>>>>>>>>>>>  3 files changed, 27 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>>>>>>>> index 0267977c9f17..69ee321027b4 100644
>>>>>>>>>>>>> --- a/drivers/pci/iov.c
>>>>>>>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>>>>>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>>>>>>>  	return max ? max - bus->number : 0;
>>>>>>>>>>>>>  }
>>>>>>>>>>>>>  
>>>>>>>>>>>>> +/**
>>>>>>>>>>>>> + * pci_reset_iov_state - reset the state of the IOV capability
>>>>>>>>>>>>> + * @dev: the PCI device
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +	struct pci_sriov *iov = dev->sriov;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +	if (!dev->is_physfn)
>>>>>>>>>>>>> +		return;
>>>>>>>>>>>>> +	if (!iov->num_VFs)
>>>>>>>>>>>>> +		return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +	sriov_del_vfs(dev);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +	if (iov->link != dev->devfn)
>>>>>>>>>>>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +	iov->num_VFs = 0;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>
>>>>>> Any reason for not using pci_disable_sriov()?
>>>>>
>>>>> The issue with pci_disable_sriov() is that it calls sriov_disable(),
>>>>> which directly uses pci_cfg_access_lock(), leading to deadlock on the
>>>>> FLR path.
>>>>>
>>>>
>>>> That'll be a problem. Well my main concern is whether the VFs will be reset
>>>> correctly through pci_reset_iov_state() as it lacks the participant of
>>>> PF driver and bios (seems may needed only on powerpc, not sure), which is
>>>> necessary in the enable/disable routine through $pci_dev/sriov_numvfs.
>>>>
>>>>>>
>>>>>> With the spec the related registers in the SRIOV cap will be reset so
>>>>>> it's ok in general. But for some devices not following the spec like hns3,
>>>>>> some fields like VF enable won't be reset and keep enabled after the FLR.
>>>>>> In this case after the FLR the VF devices in the system has gone but
>>>>>> the state of the PF SRIOV cap leaves uncleared. pci_disable_sriov()
>>>>>> will reset the whole SRIOV cap. It'll also call pcibios_sriov_disable()
>>>>>> to correct handle the VF disabling on some platforms, IIUC.
>>>>>>
>>>>>> Or is it better to use pdev->driver->sriov_configure(pdev,0)?
>>>>>> PF drivers must implement ->sriov_configure() for enabling/disabling
>>>>>> the VF but we totally skip the PF driver here.
>>>>>>
>>>>>> Thanks,
>>>>>> Yicong
>>>>>>
>>>>>>>>>>>>>  /**
>>>>>>>>>>>>>   * pci_enable_sriov - enable the SR-IOV capability
>>>>>>>>>>>>>   * @dev: the PCI device
>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>>>>>> index 3d2fb394986a..535f19d37e8d 100644
>>>>>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>>>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>>>>>>>>>>>   */
>>>>>>>>>>>>>  int pcie_flr(struct pci_dev *dev)
>>>>>>>>>>>>>  {
>>>>>>>>>>>>> +	pci_reset_iov_state(dev);
>>>>>>>>>>>>> +
>>>>>>>>>>>>>  	if (!pci_wait_for_pending_transaction(dev))
>>>>>>>>>>>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>>>>>>>>>>>>  
>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>>>> index 3d60cabde1a1..7bb144fbec76 100644
>>>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>>>>>>>>>>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>>>>>>>>>>>>>  void pci_restore_iov_state(struct pci_dev *dev);
>>>>>>>>>>>>>  int pci_iov_bus_range(struct pci_bus *bus);
>>>>>>>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev);
>>>>>>>>>>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
>>>>>>>>>>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
>>>>>>>>>>>>>  #else
>>>>>>>>>>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>>>>>>>  {
>>>>>>>>>>>>>  	return 0;
>>>>>>>>>>>>>  }
>>>>>>>>>>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +}
>>>>>>>>>>>>>  
>>>>>>>>>>>>>  #endif /* CONFIG_PCI_IOV */
>>>>>>> .
>>>>>>>
>>>>> .
>>>>>
>>>> .
>>>>
> .
> 
