Return-Path: <linux-pci+bounces-27096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC37AA766C
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE935462C94
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD882571DF;
	Fri,  2 May 2025 15:49:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023118.outbound.protection.outlook.com [40.107.44.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76E26AD9;
	Fri,  2 May 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200963; cv=fail; b=m9ZywLZfSSTb5plQlRGP4QaEqbn/Z3BCsOouVGqWKj7cs52uGPLtZ6TEJlUEghVuGR8lRgAjyra9Y5p2fg6FhtD6vZMlwjxNp7+C6x0ZA/e1xK5dJbz/jXzjGFcdYX6lhC7cZ/zJZ0DDhcJAqj3H+LwJVGwyZE4XepvrXUBvXsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200963; c=relaxed/simple;
	bh=xk9vF9Aa/FjgJnGm+EOTRpEXuYl8ObaiUhPUQ+uUR38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIGBnoF206t8mHmU/XZsKFZAZM5SteVrDBfZG1i+22FnM25fXPc4rsqVFiox4cjLxN6ze4AUhiupMZXpuNrhT0qCkZod5OVpdcGoD1XuHHdbxqTVQe+XG3QaENGXq2GrcCgXdEhf1Zh9pS9hmpf5OybQxvfzPihFY4LS6XVR1qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJQqCHiJvUf6S8zI9P1YGBj5RexP4YisBtUzI4LRgSKXN/WygHyFsi0plTWzAwItwZJumrGwrlDpKPfA2JRMcwLXWJaKa25GzBlxKn/fD3i4zTRNZmJRHeGr0u4OLM6WrnH+i6CD3d/UjqpxsBwIL31EnP3lSc3DoZ0ZEVTF5vGU1wSyLEn7CxyYO8uli3vMAriwRfJazzk4hBMe6ApvD4M2dhpnYN+KlDqJ61sYlP0rMAO1zjS4/nI0cZ2+/CfFqGe534NEDc26xcYxSCpHY+38j9ELt8IFu2GVTsnEMLnrjuKTeh4x2LNCkzPj65CaD7LE5j/+962zlM6JrNgNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsEl9t3CUVg7XG6WPIfaoIfTAU23UqPqL79CDwuHhUU=;
 b=AwyIlVNoYhOoqOE05QwLsEMd3f4W36QTMOUsyIMi2+cZ5nVNGw/orOFNNbxtEQ7nC7alIJwAZwAvI/PjwtDGFf0YpLtDi5/jmDjOFO9JVeEz7jP//6HbNbQjfBY/nEPXdDJ23iAG6GcPShlYWrCNMn2IA1hF+Shq2JCROorsBApXtJh6KwTuPLe5soBrtgpl2Ty770/qfFQd1R+dG8uw58enWxf4M5OtMQDVSc9BJV71VVONqujbedaRrLrVVwWBWivsa3vntuBpJp7EgJPq+qWUeYpvL4u+mO2y9vghSCO6J0eATA0tVQUorDU+FH2Wwyk4MXsakHPGGtYqJkuHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=grimberg.me smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) by TY0PR06MB5561.apcprd06.prod.outlook.com
 (2603:1096:400:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 15:49:13 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:28:cafe::ec) by SG2PR01CA0165.outlook.office365.com
 (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 15:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 15:49:11 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 94B2140A5A01;
	Fri,  2 May 2025 23:49:10 +0800 (CST)
Message-ID: <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
Date: Fri, 2 May 2025 23:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 manivannan.sadhasivam@linaro.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250502150027.GA818097@bhelgaas>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250502150027.GA818097@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TY0PR06MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: ec418daa-6104-4bfb-80eb-08dd8990e20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S21uWDZHUzZ6MjUvZjZmMTVZZ2kxS09xODNRNW1aVlhFbDVrVlJUb0FNd1lC?=
 =?utf-8?B?dmhZS0JxblBnaFEwRmpjSUhFdXdEZXFPL29Zd3o4azdBRktwaW9XMGZXMzR1?=
 =?utf-8?B?YTk5SzhFYTVGNklMaEtyUjg5b0JtdUNKMzZFUDQvL3FEV3RRTXJZUTJ1andk?=
 =?utf-8?B?UjEwMmNuSVUwdGhDNWI4bktMcCtIdE1SMTUxUm9XUXJ6MzVUZzNRbmIrSDBY?=
 =?utf-8?B?SHNNa2VVMjRlK3hkeWtUZ2poSi81N3p0Qm1ma0toeFVTZHZBSEhoekpwamo4?=
 =?utf-8?B?TFNxZEhDYjBQWWtvL295aFMweVgxY2dLYTNsditpYytaQU01MDhFMENZWDdL?=
 =?utf-8?B?S1ZKRkdCMlEwejZUdTBtc2hZNkJZMnNvM1RrYlZPNDlwVlluNUJIK25ZVnlV?=
 =?utf-8?B?RU1KVkFYd0s4YndZRkpJbldjNjk5QWtnY01HS3kzVGRLcGU3TmFyRnRjcUlV?=
 =?utf-8?B?aWVEb1MwNTMyWVVxUW9oOW00aUIrTVFJeGF3ekJSMXdJRkN3UUVNeTFWeVZ2?=
 =?utf-8?B?dlU4Y0N4Tk5sTUVZZ2ZhbVQzSWM3dWlDWExzREhINTJsU042RWRHU3V3ZzV0?=
 =?utf-8?B?VWFZbjdMOVFtWmFORFc1enNQbFBVbGpPL3I0K3o4cmJSZEFsekYwaXpnVU9i?=
 =?utf-8?B?eDVGMlZoN3hNaGhYNjNoK1FVSUFNdTRxZ0o3R1gzSXhMbURRZWhheTRUSzlF?=
 =?utf-8?B?VkVoZEMwTjZRcE5NZWJ4N3ltbDhOSnd0dG1kYitPcFVLb21QUlMyaENpUHNQ?=
 =?utf-8?B?My9wcUZBK1VXTk5XUzl3TnpXWnljNElrK01FRzllVjhaR01ocDlqWEI3bkNr?=
 =?utf-8?B?bjdMNCt3UC9WMEFoK0o5ek5MelFqQXh3OURrUWxIMGRGTzNZa3BmYVI5VnFz?=
 =?utf-8?B?SWk5bjU5enVHakRBMmpsbUJRNkdDamxsSDN5VWVaeFg5TWxETXk5SlRGbFVs?=
 =?utf-8?B?SkRtd2xZbk1xZmR6YjRFdytRMVlLMjY5TldyMnMrKzlFQkxPUExtdHg1bzhF?=
 =?utf-8?B?MFBvVFJHM1ZOc1BFU2NMaDJjQytwTlhvRGFOUTJYckNLMDRGVHFrTXBiditB?=
 =?utf-8?B?Y2R3M21UdG12bUdEai9mZDBVeGxZNXdHaEdEOUpiQndkQkpHbGRQUGw5NHlT?=
 =?utf-8?B?L3FWYktDNWs5eUhuZ3hVM2t6V2xsL0ljYWkvSFVtbDh3U1JORU5yWlcrMGpD?=
 =?utf-8?B?R0ptLzlCcmJyME5ISUM2SVdCaUFJWG1xOEl1TERGL3pOT0h5amczN2JqS3FE?=
 =?utf-8?B?aWM1dlhFUUtweHBab2paRFdqcjdsakhYb2V2cnVOTGZzSngyRGdYT1NJUEpS?=
 =?utf-8?B?cEY0L2FLYWZIcmRBcGg4bGdRQkp5VFhqempncGc2S25GT003SjFuVitNeTJi?=
 =?utf-8?B?WnJpK09YNFBHeU1WZTBwMXpPNWRyWUlYdGdBZWpDdm9nMGpxa0lhQ2NTeVB4?=
 =?utf-8?B?a01RY1pCWXBPQ3NQYU8xWkJvOW1JSlRXbXNvb1lNTnNWTjkvVTE2Z1crUkVu?=
 =?utf-8?B?WkQ2UXR5ZFFwSzNvNHVza2w4YncwTjlnWVFMSFlOR1BHcnY0WnNnKzRUb3RT?=
 =?utf-8?B?OCtUSFRDSnMxaXA0QXRDRkdVTzN0NGIvdndmUk1STmRtbGNlSEprYlNmdHgx?=
 =?utf-8?B?bDZwRFJwNEFvZjR4cVlYbnNabUxMQ1hYd3Z3VHdpcEp2dUR1TjR0bkRZUHF1?=
 =?utf-8?B?YmVWczNObFBjL0l1aUw4emNUWmVmSGRhRGF1d2w1djhOcjVISlJMTFNXYjBY?=
 =?utf-8?B?TWY0SUZzQjhDT2NCdE05NEZ6T3pWQXM3L1dXcWJlYmJBbURzL1FEa3BKRS9W?=
 =?utf-8?B?Vko0Y0RRRWUveUVmNHJYVFQvcGIxTWhVR2Y4SVBnZjNkdlVmQUhrL3drUzRQ?=
 =?utf-8?B?UWNQM25vbDJ3TkZDTTIzMWE0QjZocXVjSkU0blJmMTY0b1d2RTFJWXdYa1BV?=
 =?utf-8?B?RlI5Y2FnYW95dXFXbXBxdTVaZmVmRVkzZXgwOUZiNzJvMGZ6VitrQW1BNWxO?=
 =?utf-8?B?TWw2ZEhCQlVYWjVGcXBwdit3K09xVTJ5OWtzTGpzd3krampBa0NDK0xTakcz?=
 =?utf-8?B?dmluWXYrdml0VGFGNFFYL2UzUVduSGQvdi9qQT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:49:11.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec418daa-6104-4bfb-80eb-08dd8990e20c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5561



On 2025/5/2 23:00, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
> 
> CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
> dynamically regardless of the config.
> 

Dear Bjorn,

Thank you very much for your reply.

Yes. To reduce the power consumption of the SOC system, we have enabled 
ASPM L1 by default.

>> NVMe controllers fail to release LPI MSI-X interrupts during system
>> suspend, leading to a system hang. This occurs because the driver's
>> existing power management path does not fully disable the device
>> when ASPM is active.
> 
> I have no idea what this has to do with ASPM L1.  I do see that
> nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
> janky and racy).  But this doesn't explain anything about what would
> cause a system hang.

[   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: 
calling pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
[   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: 
pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
[   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM: 
calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
[   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM: 
pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
[   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling 
sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
[   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy: 
pcie_phy_common_exit end
[   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: 
sky1_pcie_suspend_noirq
[   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: 
sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
[   92.505619] [pid:916,cpu7,bash]sky1-audss-clk 
7110000.system-controller:clock-controller: PM: calling 
genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
[   92.520919] [pid:916,cpu7,bash]sky1-audss-clk 
7110000.system-controller:clock-controller: PM: 
genpd_suspend_noirq+0x0/0x80 returned 0 after 1 usecs
[   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...


Hans: Before I added the printk for debugging, it hung here.


I added the log output after debugging printk.

Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
Our hardware is in STR(suspend to ram), and the controller and PHY will 
lose power.

So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe 
controller will be turned off. In sky1_pcie_resume_noirq, the PCIe 
controller and PHY will be reinitialized. If suspend does not close the 
AXI and APB clock, and the AXI is reopened during the resume process, 
the APB clock will cause the reference count of the kernel API to 
accumulate continuously.

Additionally, since the controller and phy lost power, and pci_msix_mask 
was executed after sky1_pcie_suspend_noirq. The place for hang is to 
write PCI_MSIX_ENTRY_CTRL_MASKBIT.

static inline void pci_msix_mask(struct msi_desc *desc)
{
	struct irq_desc *irq_desc = NULL;;
	printk(KERN_EMERG"[HANS] fun = %s, line = %d irq = %d \n", __func__, 
__LINE__, desc->irq);
	irq_desc = irq_to_desc(desc->irq);
	printk(KERN_EMERG"[HANS] fun = %s, line = %d irq_desc->depth = %d \n", 
__func__, __LINE__, irq_desc->depth);
	dump_stack();
	printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", __func__, 
__LINE__);
	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);  //   SOC hang
	/* Flush write to device */
	readl(desc->pci.mask_base);
}



[   92.542027] [pid:19,cpu1,migration/1][HANS] fun = __cpu_disable, line 
= 317 ...........
[   92.550148] [pid:19,cpu1,migration/1][HANS] fun = migrate_one_irq, 
line = 120 ...........
[   92.558410] [pid:19,cpu1,migration/1][HANS] fun = 
irq_shutdown_and_deactivate, line = 325 ...........
[   92.567711] [pid:19,cpu1,migration/1][HANS] fun = irq_shutdown, line 
= 308 ...........
[   92.575712] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line 
= 67 irq = 94
[   92.583449] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line 
= 69 irq_desc->depth = 1
[   92.592142] [pid:19,cpu1,migration/1]CPU: 1 PID: 19 Comm: migration/1 
Tainted: G S         O       6.1.44-cix-build-generic #242
[   92.603702] [pid:19,cpu1,migration/1]Hardware name: Cix Technology 
Group Co., Ltd. CIX Merak Board/CIX Merak Board, BIOS 1.0 Apr 14 2025
[   92.615953] [pid:19,cpu1,migration/1]Stopper: 
multi_cpu_stop+0x0/0x190 <- stop_machine_cpuslocked+0x138/0x184
[   92.625876] [pid:19,cpu1,migration/1]Call trace:
[   92.630490] [pid:19,cpu1,migration/1] dump_backtrace+0xdc/0x130
[   92.636409] [pid:19,cpu1,migration/1] show_stack+0x18/0x30
[   92.641891] [pid:19,cpu1,migration/1] dump_stack_lvl+0x64/0x80
[   92.647725] [pid:19,cpu1,migration/1] dump_stack+0x18/0x34
[   92.653209] [pid:19,cpu1,migration/1] pci_msix_mask+0x5c/0xcc
[   92.658956] [pid:19,cpu1,migration/1] pci_msi_mask_irq+0x48/0x4c
[   92.664963] [pid:19,cpu1,migration/1] its_mask_msi_irq+0x18/0x30
[   92.670970] [pid:19,cpu1,migration/1] irq_shutdown+0xc4/0xf4
[   92.676626] [pid:19,cpu1,migration/1] 
irq_shutdown_and_deactivate+0x38/0x50
[   92.683583] [pid:19,cpu1,migration/1] 
irq_migrate_all_off_this_cpu+0x2ec/0x300
[   92.690807] [pid:19,cpu1,migration/1] __cpu_disable+0xe0/0xf0
[   92.696554] [pid:19,cpu1,migration/1] take_cpu_down+0x3c/0xa4
[   92.702302] [pid:19,cpu1,migration/1] multi_cpu_stop+0x9c/0x190
[   92.708218] [pid:19,cpu1,migration/1] cpu_stopper_thread+0x84/0x11c
[   92.714482] [pid:19,cpu1,migration/1] smpboot_thread_fn+0x228/0x250
[   92.720749] [pid:19,cpu1,migration/1] kthread+0x108/0x10c
[   92.726147] [pid:19,cpu1,migration/1] ret_from_fork+0x10/0x20
[   92.731894] [pid:19,cpu1,migration/1][HANS] fun = pci_msix_mask, line 
= 71 ...........

> 
>> The fix adds an explicit device disable and reset preparation step
>> in the suspend path after successfully setting the power state.
>> This ensures proper cleanup of interrupt resources even when ASPM
>> L1 is enabled, preventing the system from hanging during suspend.
> 
> Maybe there's a clue in the 600 lines of debug output that I trimmed,
> but without some interpretation, I have no idea how to find it.
> 

You can also view this webpage. I have placed the log during the suspend 
process.

https://patchwork.kernel.org/project/linux-pci/patch/20250502032051.920990-1-hans.zhang@cixtech.com/


> Unless you see similar problems on other systems, I would suspect an
> issue with the SoC or the SoC driver where you do see problems.

I will test it on RK3588 after my vacation, that is, on May 6th.

However, the SOC design of each company may be different. Our SOC PCIe 
controller and PHY lose power after STR. This is determined by the RTL 
design.


I used the patch I modified myself. The NVMe SSD enabled ASPM L1 and STR 
worked properly. Or it is normal that Mani's patch (which was not 
accepted) works.


My patch:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..2243fabd54e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3508,6 +3508,8 @@  static int nvme_suspend(struct device *dev)
  		 */
  		ret = nvme_disable_prepare_reset(ndev, true);
  		ctrl->npss = 0;
+	} else {
+		ret = nvme_disable_prepare_reset(ndev, true);
  	}
  unfreeze:
  	nvme_unfreeze(ctrl);



If my reply is not sufficient, please raise your questions and I will 
re-capture the log or explain it.


Best regards,
Hans

