Return-Path: <linux-pci+bounces-18111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4F9EC9C9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7979C1889D1B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C61E9B25;
	Wed, 11 Dec 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E9b0XXjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946D1E9B03;
	Wed, 11 Dec 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910975; cv=none; b=kA21/anM++MVxuEH1x1gb47YdgH5kuUAacVuAE+L3s9AJGJdHe8I2mzrBVjqts6PgllYa98CUCutZQlotUFSOc0oEuQR+fMQET9Ve5EYOixYXClVJnJu9HrkbaIA5SKJDJueeyjQcOXDjnlNvcFF/9gzCyRbCapUcAhXpiraq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910975; c=relaxed/simple;
	bh=vzPp+O2rRDV0a46T2HyzmNiSyANmull7vJkaBGKyX70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cezbbjAWVkSmf1hv7tKFQf0+/pm11pTrbtGKLZeheLxcC/kcMQw7kstOMW6Fsfx9rRHORDaALe/AlikaEJ8g+O/1JGCGNrDe3HbvriipN9Li2ew/TtlcNbIbTPCulmrA7BjYaHNn1AfRusrUHNgTjuDm6UBbng1LUZz9oXbKnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E9b0XXjH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB2BLHc014615;
	Wed, 11 Dec 2024 09:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjU/LANEE5RWda4GxeR232cbezpmoOllBJp62dg6bdg=; b=E9b0XXjHJjFqWUQ7
	Eh730lNhfgxCnHythLqrLRyZi9grQXCaWHv2hWJuTAFskRHz5CvcUehMAmbY2qSP
	7SAPVdter2iOojU0AHanrYzylImLGq3YQf16k1vEswq/qkFAxwAbDJe90ouuSpxU
	xH1PO1fJsRWQ7Zw4PAHvLf/GjW0D3Y0Hl2ZInytSGo4cT//ZKjei7Kt4BQ2OhV6b
	KUwPgBlXl3wZBhxGB/+AGoIyaUyfxQIoGFaM7NpNPkDCQBt+J0uV+Q2f2RroSGaI
	yzgBGHKS3KP0bpROqfHp5aubsgJt4+qRryc+H+fqOR/2XQgfFd2qNsPgmUI796Uy
	qbDzHg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ee3ncmst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 09:56:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB9u6DU018284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 09:56:06 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 01:56:03 -0800
Message-ID: <c5c9b7fc-a484-438a-aa97-35785f25d576@quicinc.com>
Date: Wed, 11 Dec 2024 17:55:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
To: <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konradybcio@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hhox-qiAjd3RHclDYeH-_Ud-BEBIXyIk
X-Proofpoint-ORIG-GUID: hhox-qiAjd3RHclDYeH-_Ud-BEBIXyIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110074


On 12/10/2024 5:55 PM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
>
> This series reworks the PCI pwrctrl integration (again) by moving the creation
> and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev() APIs.
> This is based on the suggestion provided by Lukas Wunner [1][2]. With this
> change, it is now possible to create pwrctrl devices for PCI bridges as well.
> This is required to control the power state of the PCI slots in a system. Since
> the PCI slots are not explicitly defined in devicetree, the agreement is to
> define the supplies for PCI slots in PCI bridge nodes itself [3].
>
> Based on this, a pwrctrl driver to control the supplies of PCI slots are also
> added in patch 4. With this driver, it is now possible to control the voltage
> regulators powering the PCI slots defined in PCI bridge nodes as below:
>
> ```
> pcie@0 {
> 	compatible "pciclass,0604"
> 	...
>
> 	vpcie12v-supply = <&vpcie12v_reg>;
> 	vpcie3v3-supply = <&vpcie3v3_reg>;
> 	vpcie3v3aux-supply = <&vpcie3v3aux_reg>;
> };
> ```
>
> To make use of this driver, the PCI bridge DT node should also have the
> compatible "pciclass,0604". But adding this compatible triggers the following
> checkpatch warning:
>
> WARNING: DT compatible string vendor "pciclass" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> For fixing it, I added patch 3. But due to some reason, checkpatch is not
> picking the 'pciclass' vendor prefix alone, and requires adding the full
> compatible 'pciclass,0604' in the vendor-prefixes list. Since my perl skills are
> not great, I'm leaving it in the hands of Rob to fix the checkpatch script.
>
> [1] https://lore.kernel.org/linux-pci/Z0yLDBMAsh0yKWf2@wunner.de
> [2] https://lore.kernel.org/linux-pci/Z0xAdQ2ozspEnV5g@wunner.de
> [3] https://github.com/devicetree-org/dt-schema/issues/145
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (4):
>        PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
>        PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
>        dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
>        PCI/pwrctrl: Add pwrctrl driver for PCI Slots
>
>   .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
>   drivers/pci/bus.c                                  | 43 ----------
>   drivers/pci/probe.c                                | 34 ++++++++
>   drivers/pci/pwrctrl/Kconfig                        | 11 +++
>   drivers/pci/pwrctrl/Makefile                       |  3 +
>   drivers/pci/pwrctrl/core.c                         |  2 +-
>   drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++++++++
>   drivers/pci/remove.c                               |  2 +-
>   8 files changed, 144 insertions(+), 46 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f
>
> Best regards,

Hi Mani

PCIe3 is able to link up after applying your patch. Slot power is turned 
on correctly.
But see “NULL pointer dereference” when I try to remove device.

root@linaro-gnome:/sys/bus/pci/devices/0003:00:00.0# echo 1 > remove

[   38.752976] ------------[ cut here ]------------
[   38.757726] WARNING: CPU: 1 PID: 816 at drivers/regulator/core.c:5857 
regulator_unregister+0x13c/0x160
[   38.767288] Modules linked in: phy_qcom_qmp_combo aux_bridge 
drm_kms_helper drm nvme backlight pinctrl_sm8550_lpass_lpi 
pci_pwrctl_slot pci_pwrctrl_core nvme_core phy_qcom_edp 
phy_qcom_eusb2_repeater dispcc_x1e80100 pinctrl_lpass_lpi 
phy_qcom_snps_eusb2 lpasscc_sc8280xp typec gpucc_x1e80100 phy_qcom_qmp_pcie
[   38.795279] CPU: 1 UID: 0 PID: 816 Comm: bash Not tainted 
6.12.0-next-20241128-00005-g6178bf6ce3c2-dirty #50
[   38.805359] Hardware name: Qualcomm IDP, BIOS 
6.0.240607.BOOT.MXF.2.4-00348.1-HAMOA-1.67705.7 06/ 7/2024
[   38.815088] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS 
BTYPE=--)
[   38.822239] pc : regulator_unregister+0x13c/0x160
[   38.827081] lr : regulator_unregister+0xc0/0x160
[   38.831829] sp : ffff800082ad39e0
[   38.835238] x29: ffff800082ad39e0 x28: ffff67874a4b1140 x27: 
0000000000000000
[   38.842563] x26: 0000000000000000 x25: 0000000000000000 x24: 
0000000000000000
[   38.849895] x23: 0000000000000001 x22: ffff800082ad3a88 x21: 
0000000000000000
[   38.857220] x20: ffffb72b1c7de2b0 x19: ffff678740f60000 x18: 
ffffffffffffffff
[   38.864545] x17: 2e30303030646231 x16: ffffb72b1a68d54c x15: 
3030303064424337
[   38.871867] x14: 000000000000000b x13: ffff6787402b6010 x12: 
0000000000000000
[   38.879200] x11: 0000000000000000 x10: ffffb72b1a689fe8 x9 : 
ffffb72b1a689bc8
[   38.886525] x8 : ffff678740e5b2c0 x7 : ffff800082ad3a88 x6 : 
ffff678740e5b2c0
[   38.893849] x5 : ffff678740e5b2c0 x4 : ffff678740e5b2c0 x3 : 
ffff678740e5b2c0
[   38.901172] x2 : ffff67874a4b1140 x1 : 0000000000000000 x0 : 
0000000000000007
[   38.908496] Call trace:
[   38.911019]  regulator_unregister+0x13c/0x160 (P)
[   38.915856]  regulator_unregister+0xc0/0x160 (L)
[   38.920600]  devm_rdev_release+0x14/0x20
[   38.924634]  devres_release_all+0xa0/0x100
[   38.928845]  device_unbind_cleanup+0x18/0x60
[   38.933239]  device_release_driver_internal+0x1ec/0x228
[   38.938606]  device_release_driver+0x18/0x24
[   38.942998]  bus_remove_device+0xcc/0x10c
[   38.947122]  device_del+0x14c/0x404
[   38.950705]  device_unregister+0x18/0x34
[   38.954738]  of_device_unregister+0x14/0x20
[   38.959041]  pci_remove_bus_device+0x110/0x1b0
[   38.963612]  pci_remove_bus_device+0x38/0x1b0
[   38.968094]  pci_stop_and_remove_bus_device_locked+0x28/0x3c
[   38.973907]  remove_store+0x94/0xa4
[   38.977494]  dev_attr_store+0x18/0x2c
[   38.981263]  sysfs_kf_write+0x44/0x54
[   38.985037]  kernfs_fop_write_iter+0x118/0x1a8
[   38.989607]  vfs_write+0x2b0/0x35c
[   38.993107]  ksys_write+0x68/0xfc
[   38.996519]  __arm64_sys_write+0x1c/0x28
[   39.000552]  invoke_syscall+0x48/0x110
[   39.004411]  el0_svc_common.constprop.0+0x40/0xe8
[   39.009244]  do_el0_svc+0x20/0x2c
[   39.012655]  el0_svc+0x30/0xd0
[   39.015805]  el0t_64_sync_handler+0x144/0x168
[   39.020283]  el0t_64_sync+0x198/0x19c
[   39.024052] ---[ end trace 0000000000000000 ]---
[   39.028897] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000000c0
[   39.037932] Mem abort info:
[   39.040823]   ESR = 0x0000000096000004
[   39.044691]   EC = 0x25: DABT (current EL), IL = 32 bits
[   39.050161]   SET = 0, FnV = 0
[   39.053316]   EA = 0, S1PTW = 0
[   39.056557]   FSC = 0x04: level 0 translation fault
[   39.061585] Data abort info:
[   39.064554]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   39.070190]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   39.075395]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   39.080861] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000889f93000
[   39.087484] [00000000000000c0] pgd=0000000000000000, p4d=0000000000000000
[   39.094467] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   39.100903] Modules linked in: phy_qcom_qmp_combo aux_bridge 
drm_kms_helper drm nvme backlight pinctrl_sm8550_lpass_lpi 
pci_pwrctl_slot pci_pwrctrl_core nvme_core phy_qcom_edp 
phy_qcom_eusb2_repeater dispcc_x1e80100 pinctrl_lpass_lpi 
phy_qcom_snps_eusb2 lpasscc_sc8280xp typec gpucc_x1e80100 phy_qcom_qmp_pcie
[   39.128882] CPU: 1 UID: 0 PID: 816 Comm: bash Tainted: G W          
6.12.0-next-20241128-00005-g6178bf6ce3c2-dirty #50
[   39.140480] Tainted: [W]=WARN
[   39.143540] Hardware name: Qualcomm IDP, BIOS 
6.0.240607.BOOT.MXF.2.4-00348.1-HAMOA-1.67705.7 06/ 7/2024
[   39.153273] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS 
BTYPE=--)
[   39.160421] pc : pci_remove_bus_device+0x120/0x1b0
[   39.165341] lr : pci_remove_bus_device+0x110/0x1b0
[   39.170261] sp : ffff800082ad3c00
[   39.173676] x29: ffff800082ad3c00 x28: ffff67874a4b1140 x27: 
0000000000000000
[   39.181004] x26: 0000000000000000 x25: 0000000000000000 x24: 
ffff67874cb2caa0
[   39.188334] x23: ffff800082ad3d88 x22: 0000000000000000 x21: 
ffff6787458f00c8
[   39.195661] x20: ffff6787458f0000 x19: ffffb72b1c5e88d8 x18: 
ffffffffffffffff
[   39.202984] x17: 74616c703d4d4554 x16: 5359534255530079 x15: 
6d6d75642d676572
[   39.210311] x14: ffffb72b1ca01098 x13: 0000000000000040 x12: 
0000000000000228
[   39.217638] x11: 0000000000000000 x10: 0000000000000000 x9 : 
0000000000000000
[   39.224964] x8 : 0000000000000000 x7 : ffff678740d3ebc8 x6 : 
ffff678745584b40
[   39.232296] x5 : ffff6787411c64e0 x4 : ffff6787411c64e0 x3 : 
ffff678741256679
[   39.239626] x2 : ffff678740e5b048 x1 : 0000000000000008 x0 : 
00000000000000c0
[   39.246951] Call trace:
[   39.249469]  pci_remove_bus_device+0x120/0x1b0 (P)
[   39.254399]  pci_remove_bus_device+0x110/0x1b0 (L)
[   39.259326]  pci_remove_bus_device+0x38/0x1b0
[   39.263801]  pci_stop_and_remove_bus_device_locked+0x28/0x3c
[   39.269620]  remove_store+0x94/0xa4
[   39.273209]  dev_attr_store+0x18/0x2c
[   39.276972]  sysfs_kf_write+0x44/0x54
[   39.280735]  kernfs_fop_write_iter+0x118/0x1a8
[   39.285305]  vfs_write+0x2b0/0x35c
[   39.288808]  ksys_write+0x68/0xfc
[   39.292221]  __arm64_sys_write+0x1c/0x28
[   39.296258]  invoke_syscall+0x48/0x110
[   39.300119]  el0_svc_common.constprop.0+0x40/0xe8
[   39.304952]  do_el0_svc+0x20/0x2c
[   39.308365]  el0_svc+0x30/0xd0
[   39.311515]  el0t_64_sync_handler+0x144/0x168
[   39.316002]  el0t_64_sync+0x198/0x19c
[   39.319766] Code: f9414aa0 d503201f d2800101 91030000 (f821101f)
[   39.326029] ---[ end trace 0000000000000000 ]---

Thanks,
Qiang


