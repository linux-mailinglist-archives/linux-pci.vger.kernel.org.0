Return-Path: <linux-pci+bounces-2826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE2842C12
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E601F25E55
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980B79942;
	Tue, 30 Jan 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OidC0m1F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80B79946;
	Tue, 30 Jan 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640428; cv=fail; b=kkySfbBqr0r9/tuZ9xVdzIjoZp4s9HKwpe5j8krWNxiiOLKVYPg9rWzU44WsDYMZhYnXzXHni2U9mrM7dooLLjwciIO22HtGc5ZzIRKVYPB8wDFnW+ZyGSsL8EVaCWAuHNJk9pBEV+IaKgzN0GQR3NSEv4BIBtYhqCs77DEttiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640428; c=relaxed/simple;
	bh=H2GibEL824akgEZ3+8lBgL4EhrZXhIp2ODD+AwubvUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afDv1p7oSpcYFXsPuQ8X/2WwQs6j1ysNQhCCidMeKVXq+Exgd/mVsFE+pr7FlHZ1F1quB6qcANWA5CUzyIkqGfI0erXjk/itPXjzvcFnZtoBy8WAz9aLXwfv4umAnLpaD7l0I+iQ45dKe+7KmmiLJDbQmgrQOzl182mb0Yr0tiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OidC0m1F; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHiwCZ+TwynzsGsTC6VXFrPO44FYQXCT7hGL/laSWlLZdvGIgrp32NEl/rGOx5t4vD8lSS4iybFYecujvN9Ttxsf8W8MMQfqmx6Wg7IuYnuNW8qsIQUNMh5gFEufxWwqbqzu6D6RghA7RxHPCOQM6b2Xpig8iuwBsb8nQHeK7nQdYHkzKX75jt8BB6uc9ZNmqY5TpwqQF2zGhMAzvh8iTl7n0NUg3HUsofSJdd2iuNh1uhIUcnfBddz4K/z0O8QR1HBE8F7s+08rAl//HDwz7aN3L/Gklua9IeK3E6oq5zTBWh+f32VdjXq54puMOFwhWjyfHWJk3E0k1t/eTdozaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU27zGLwTk14Ld71GC6gr5w9JUe+y9dKrewjtBw8Q18=;
 b=P0uZzELKPHNyAqsuqoZHYbR7Qu4cAQi8FKGuFZbxRJIaZ3zpBLe9o56j4EUeI2abdjKUeAFU42VCYHu3lffmpQolsDLOakZAgD52tjU74o3aQB03jBNc+hEWxenmpuunOscaged/pHUhIWIV1uujRk/WguCrTlc2Kxu/h4T35Ne9tmT2oNqfBvaiexBV9EVmJdweTh23qX20d6KLWl3t8/CWWJc/Kuw6TZtXM6hiG8FXIYgZoGdujLZ78fBWtzJv7tWA5orTisFUdKlnp1T7UIskGeTDoQnHyfdQDDapsK2GaRETf4AKk8GCnaQYoRHmEG81eU+QSh+NfJdnPq4+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU27zGLwTk14Ld71GC6gr5w9JUe+y9dKrewjtBw8Q18=;
 b=OidC0m1Fm8QVyGPeghyICNOc8ijbLUvpagOeL2YBuTiqgifkibMO/cPt3oJYisiFdk8YngtejdZbgkgJGAVfidG3htN4276wNAEWLw67vPhLUEXaPOclWPtOa0c9TLErf7zNDK6Ygec5AXzmiQt7iqUsexTZb/VyYSHUf6eOPzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:47:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:47:03 +0000
Message-ID: <7a8f3595-3efc-428a-852a-d9edc8ebb01b@amd.com>
Date: Tue, 30 Jan 2024 12:47:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
Content-Language: en-US
To: Daniel Drake <drake@endlessos.org>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, david.e.box@linux.intel.com
References: <20240130183124.19985-1-drake@endlessos.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240130183124.19985-1-drake@endlessos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 895835bb-4770-46ad-b2bd-08dc21c3d962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lrWw/tZGvtPFfR/Izce1yNl8OyNXsec0raIyYH6X7+IaqFOUd98XSog2ec64PwWeZogEQalsG9SSA2eAKrNs85cLYfkjDyXONUXmp3eJsljnuDBaT79PnrKzFpAGWRyp3nzR/XTBjVN6DM+9lGylOocwW9AO6/J6kq0CzpN5NBDyyUXqCO7k6advKTq4ScPr6hkZpQaRbxz28fSLs/Mc+gv74cPRNmUQd+it1lVVYzGZePW0RPv5RgwSMrvPA8uZVRrLUdubI5AOAjgkHnUaJbX6fcJMpbHd9zVnS6i+2F973MV5XnKSC4CmmyVpdjo/D//VhHOqt+Tp1ytN54C6nNLbZH13Qrn8ddFHNPZXlslvNnArBugqg0tk/nUBuLMXeiOXO7oSmYOAfBkjF5ylpSZukMtwM3PEgIHz6qHhSSEd+3bbA4GbtD0UF42Krodh8dWl2cX/NaiBEW7l6l5gm4rWJkyRux9UXv0pcHLRmEo+SBdU0VNeM1yNscSs0Y3D7FOEFrfWkRAIkZkFLG07ARdbYr+NDeduKKIL2xsEP6wdPpuzivM7ki9P4QhDK2e70H65ACN8FNTO7OSPIAIKyQN/g3jLNW+DcikmWxr3dnZ1ZzmzWLV3ipITg1FE/SiiS5THdE4be6LFFp9eN7/38lcakZg3IiuuZRmCubSQq30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(31696002)(7416002)(83380400001)(41300700001)(36756003)(86362001)(38100700002)(478600001)(44832011)(8676002)(316002)(4326008)(66946007)(66476007)(966005)(2616005)(26005)(6486002)(2906002)(6512007)(53546011)(6506007)(5660300002)(8936002)(31686004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amc4ZFdIVEZ1Y0JjeHZpdjBxTzhOMzRnZ1REcjB4OEtGTm96RGtvSytVaEd3?=
 =?utf-8?B?R3djU3BGc2xPaVRsMG01T1R4ZUFEWWpVMFJvNTFOVVZ6SGxtY25SaDM0enk5?=
 =?utf-8?B?b0lqY25tSEdwT0RrTjg5WFcwRjJCb0pLbTdTYmU1V21kN0dPOHZDTXNiQzc0?=
 =?utf-8?B?OWMvVlNUY1FJcUVpMk5CMnNma3B1bk4yVTA0NllDS2hKMVpZWUlDRFFONDRn?=
 =?utf-8?B?SzN1N2tZMmpBTkY1elpLTngxeGUzQmVONjc4SklwNVh1YWI2R05XWnNJYTk2?=
 =?utf-8?B?bXJCb1F1cTFpN1BnVG5iWTdrc2grVVV5REptNnU3NVFLVGMrVENYdjBOd21I?=
 =?utf-8?B?QXBuRUNVM2RsNWNXd2hrODlqYVdWdEFQYkt1Yk9WRXA5SzVaVi9zMVJiQUFM?=
 =?utf-8?B?eXZqdGZCUGRYcnZHV3NPWkphNlZ6Qy84SFVFcEx0dWJkZFdvdTRLaVR0UnBa?=
 =?utf-8?B?dmJkZG4rdThhZVFvUHVQSFFCZmtWbG1OWnhsUWtiT1BoWkJDY3NvbldaNUpa?=
 =?utf-8?B?U2tZZ1VmeStiNHdGMlFSUk8yVWJ5TytHb3BSeW9aajJDSTVZOXpmQWJISERS?=
 =?utf-8?B?VUdiUDNCL2lGcGNmWkZKaVo4b1ZRY0kyYzBKKzNrbk00emYrTGV0amdPYmht?=
 =?utf-8?B?L0VlRGtXUEF1RDFLM2w5V1lQV3Q0T1g2Tk5tMHJXNW9IMlJDSXlyR2dmU1Ra?=
 =?utf-8?B?WEkvWEhjcm15NDFRRkdmS2RKNjhZWnRtcTNyUlhrSnViSmNHWEVSS3lGODdp?=
 =?utf-8?B?QzdIaUlFN1QyK2RKd09TMVlIRFJtRlNRUWFmWC9RUXBZcXdUTUJzWUtRaDRP?=
 =?utf-8?B?dzB1MFV3aEUvbkRYbkluR1EwSjlHcmowZDlod1R2MFo2ckx4S0p3ak9GVVAz?=
 =?utf-8?B?c1Izb2trV1YvbjZyQllFSXlPdkJQL2tvMTM4RExXcnZ2YWNBMnUxM2w4dU00?=
 =?utf-8?B?K1FMNXNhRnZ2cVk3dEFGeHN6dnBkVDhlOWo5ckpXZkM2NzlIT2tMYlJEb3kz?=
 =?utf-8?B?RWN5RnJoVGVMcU9ncGhOMjBCNzBxMGNZdUo5eDdGTllNQzk5cDA3eWxobzBT?=
 =?utf-8?B?LzlWL2JJaytOTWd6NjVKR0tEQWJFdUIzVGVGa2ZhMm8rRVNsbTdRd0Z1RmV1?=
 =?utf-8?B?SVZvdHhDdGdTSXRwa3ZNbkNsNEhZOGZ4b1J4YnFCUTFzYXB0RkpuampNMVJz?=
 =?utf-8?B?L1hNNkRCY1RkazZxTXZTN2VSRGc5eFJnM3UzaVJyU2lDWGphaWhPRjIyT21F?=
 =?utf-8?B?Zjk1aUhNWEp4eWd6M0JhUDNDWTB6Z1pJaHpxU2t6M21rZHp1QndxTGNuakx2?=
 =?utf-8?B?RncwQllWQkZGV2ZKVUUwNUpVdlgwVlJ2MkUvN3R5SHFYT2FTYm93SW04Nzdu?=
 =?utf-8?B?U1pWN3plbm5HVE5SMXBsS3Rmbk1rdkhpeFd4c1Y4WUNROGVIem9kVmFPVkhS?=
 =?utf-8?B?aTNERHNUa3B5Nll5NmVjaWZCRGU2YjRFY3VGSk9WRWQ3VzZBdXEyREtObTZO?=
 =?utf-8?B?Y0VqWWJrWDdtRnczUG1wbzFIZnhUQ0gwQ3V5U3B1QmFueTc1S01sVStyTnlr?=
 =?utf-8?B?ZkE4U2NtWmFqNWpaS3RQSEhwMkNSSWpkWEg5dXF3ZExBdGFPU0xmd3c5OHZr?=
 =?utf-8?B?VWUzQlU3RlFSME5MY2lrWXh4MUpPVVdOekxZVUd0Y3U5T21rc3hkNWZXMmJF?=
 =?utf-8?B?a3AyVzlzUjd0NkMvR1FTeWtMb05GUzNzc3dCSHduTWorc0cwRy9tdFpQdFB6?=
 =?utf-8?B?dkYxc0dxVGlUcUhpV3dVcEtTMytnVlRwcGs3Z283eVdxZGJHSllVZmNDcmhX?=
 =?utf-8?B?WkczTDVUanh3N1NsMXdjcms3VFBXNEFZTDl1MTZjS2F3RHVXeCt3R2ZvMktL?=
 =?utf-8?B?UElQZVR6d0hxWTg0Zi96bksvaEx1NVpFc1k3MlkzVjFta25qVWJ2dFBLdm1G?=
 =?utf-8?B?RXhSeVN2dnB3b1R2QmczUk9VMzQvbjdveDBqT1hsTHZiMmF1V0hSQVFaL2My?=
 =?utf-8?B?dzlRcHV6aXFwTklEdVBWMzhxRlorK2doWGJDMjdwb29HRG93Y1UyNlVWeWRN?=
 =?utf-8?B?djZ5UCs2KzQ3QXFjM2hPbUFYaStaeWZ5TFdMa2VGL1dqUk9Wcy9MY3M2cEVR?=
 =?utf-8?Q?a9x+YijE9ul65v/qo7xAKMf4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895835bb-4770-46ad-b2bd-08dc21c3d962
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:47:03.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMxjsgyt6k+PHcruF+EYBTVLxpxkeA3ar0qC3w/4IAQiPJytVXpIve6f6sWAxy/IVsoyb01gZXb0MeprA9qh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970

On 1/30/2024 12:31, Daniel Drake wrote:
> The Asus B1400 with production shipped firmware version 304 and VMD
> disabled cannot resume from suspend: the NVMe device becomes unresponsive
> and inaccessible.

Has there already been a check done whether any newer firmware is 
available from ASUS that doesn't suffer the deficiency described below?

> 
> This is because the NVMe device and parent PCI bridge get put into D3cold
> during suspend, and this PCI bridge cannot be recovered from D3cold mode:
> 
>    echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
>    echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
>    setpci -s 00:06.0 CAP_PM+4.b=03 # D3hot
>    acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
>    acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
>    setpci -s 00:06.0 CAP_PM+4.b=0 # D0
>    echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
>    echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
>    # NVMe probe fails here with -ENODEV
> 
> This appears to be an untested D3cold transition by the vendor; Intel
> socwatch shows that Windows leaves the NVMe device and parent bridge in D0
> during suspend, even though this firmware version has StorageD3Enable=1.
> 
> Experimenting with the DSDT, the _OFF method calls DL23() which sets a L23E
> bit at offset 0xe2 into the PCI configuration space for this root port.
> This is the specific write that the _ON routine is unable to recover from.
> This register is not documented in the public chipset datasheet.
> 
> Disallow D3cold on the PCI bridge to enable successful suspend/resume.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
> Signed-off-by: Daniel Drake <drake@endlessos.org>
> ---
>   arch/x86/pci/fixup.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> There's an existing quirk for this product that selects S3 instead of
> s2idle because of this failure. However, after extensive testing,
> we've found that S3 cannot reliably wake up from suspend (firmware issue).
> We need to get s2idle working again; I'll revert the original quirk
> once we have solved this D3cold issue.

Is this the only problem blocking s2idle from working effectively on 
this platform?  If so, I would think you want to just do the revert in 
the same series if it's decided this patch needs to spin again for any 
reason.

> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index f347c20247d30..c486d86bb678b 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -907,6 +907,32 @@ static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
>   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
>   
> +/*
> + * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
> + *
> + * On this platform with VMD off, the NVMe's parent PCI bridge cannot
> + * successfully power back on from D3cold, resulting in unresponsive NVMe on
> + * resume. This appears to be an untested transition by the vendor: Windows
> + * leaves the NVMe and parent bridge in D0 during suspend, even though
> + * StorageD3Enable=1 is set on the production shipped firmware version 304.
> + */
> +static const struct dmi_system_id asus_nvme_broken_d3cold_table[] = {
> +	{
> +		.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
> +{
> +	if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
> +		pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
> +
>   #ifdef CONFIG_SUSPEND
>   /*
>    * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but


