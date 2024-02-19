Return-Path: <linux-pci+bounces-3726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4485A3B5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5812FB24D7C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351632E835;
	Mon, 19 Feb 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JYkfoEB+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493F2E647;
	Mon, 19 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346735; cv=fail; b=Er9qmx9A5rUqKeDCeUjWVL7o/EU3adRRLprzDKTqa7/QrhbLaod09cXwr9RoNveRnTDjR4Y6x9/tcrhtoD1nH4vT0Yjp8E1K0+QexPJ4b7hW/hH2bdICxEm6VzBuhxi+EaIsxVTslw0ZDFTc6ZComzu7QAiAZf/Ac/hj9EJtFDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346735; c=relaxed/simple;
	bh=Is4lY6G1qFh2OTRe/UGWjH+2ET45xwpGpSI/wF+vWQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWWetss1/hl+IslDwpxMEEdPwwLOsJvO8WUR918crZ9b8XK69Wd+QDWxxIIIfYBPw41klIGCDkHQVkeFg51F3ongykPzYQLbhXG9gmDIdvmdvfHpVNT+t9TEg5m/fxd7IvFW5wltzRk2NRln4ECTyTzgFnhY7KMGRsBPOsEA+1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JYkfoEB+; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH4YYjMpj6VfvfqvNAP56JIf7SOoQNPtsgkKXDA66eJOrcpUUF+/gQGd1WMA7yByGRZwfHcQEmUNQ9bjX3FnQsDwRAGCqC5UtemEu/8onxYCDeq3TUXeu99nPZvjSvqxYY2iUdpJTVX2mSpEocOABVM1wiLOa2WD73+IACdUwdlaN4dfxHNAwAmC8DFw+MDC3MV1DBoJaFjknstDG4U6nexW8dlc1d6JM8JK/fvEXHpjlps7xhOjbwbcME5MNrmSesa0JgW10g5y06t5CYVGZWYD4E++WWhMP1rAHJ3k4LRL0/UeCGjrMxJyStWPPiDIJ/jgdZ/LV4O8H14z/R9WVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQl43IE71pNrbKZ184dB5OesS5z16NU+SBEe8StfGG0=;
 b=E69IlicZ8ICoXd4MR47M6/7rWJobg2NqmoXjNkynqfaT1qKngDFxeuduPaQV6sNA8EDg2HBDeilNBgfnZaVEICslFo6zFk/FqeDNALpXiqU7AyUnsHwcWwxFpYV10mupMrEarlEsPR3E0lFRsF30ezvwEdi7hS8GmkimRY/aShshzEzwcUSq6kOfkyM5oaqdct7ARocsMjTIzIgAmR+pPc4MzB3sDZKmmlrSWbuh7lDIZukKKaZZLYbwStDb5mqgoI3he3IfutSTARMQqThI3KN94+838NGKTuSzoA5XT+xPIMA56MX2U7lK3bSuddYo+2FobX89k3U/eBoeuAadYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQl43IE71pNrbKZ184dB5OesS5z16NU+SBEe8StfGG0=;
 b=JYkfoEB++pDJfNeCDP/CSW1NJkS/AseCq5gB5MO7p/hdSMj157Dxe8waEjwrGUKh+i8ttI9UFTvU5bQz+Ry1LcMn+xhIJMDDHIt+QUs2D6XTcZcojyqoeKh241YFJxWBSLC2NZedPnyYMUds9OV3KxesdQa3eD4xufjrYZtfTSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 12:45:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a%7]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 12:45:28 +0000
Message-ID: <736af6b3-52c0-4b3a-bab1-07e04eb156ce@amd.com>
Date: Mon, 19 Feb 2024 06:45:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Daniel Drake <drake@endlessos.org>, david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux@endlessos.org
References: <20240207084452.9597-1-drake@endlessos.org>
 <20240207200538.GA912749@bhelgaas>
 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
 <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
 <9654146ac849bb00faf2fe963d3da94ad65003b8.camel@linux.intel.com>
 <CAD8Lp44tO_pz_HZmPOKUQ-LEQT=c856eH52xWL9nBtAtJwjL1g@mail.gmail.com>
 <CAD8Lp46dPtE12ai8srt9Bz3awnkkb1LZz_7FQuF57M=LaUSaCw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAD8Lp46dPtE12ai8srt9Bz3awnkkb1LZz_7FQuF57M=LaUSaCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 84372b42-29e2-4c17-629c-08dc3148a69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bJZpSdCl5jz3gIvI99JOuuW0ktt9GedVRVlDGyH9D15Om+1x1sXTwaKv4X4cZ6P4nbsJ7ScJUJlR0x8TP9qYC/xjEgSrwuatFsk6fJBR+XfuhCZ1jcbZV8kpIzsKF0s4KxckdkN6uaKFYjB3GMOhN1tr5cBiVKwRikV+7QCWm2cvJtV9lpiUtTSNXpLLGm2mjrcB//fCVc4AgpKG+s/oaD+006ZZj/b5zSuNfvJJR4zpGJGZ4hJ74dYYsNM5KmsGu3R0x5Z5AOM3VVEHfuZzQaOA1eLiWhwVnvukgZWHut+rYJ4d4eaL46FFHx3/Ak9uHE18lAO4h/tt0yYPokxxvp+jLOQSIW6Tm+RhlPEn9NhN0ljQA//2wOte957AON2mPKpMMBeNt2uM7tI0UNu6dNKsOLg2z+4/MICveTFMzUazv7PPfcECbl01Fn4zJj2bUoDM2TRfSXzFP3FLn+HQs75rjJTWYwPTJcTpQ1EvB5po3OwNtY7U0r5l65X34KeSywYc/t8+JzBeJEmz3j8gprTx9//DDzJUMK4xzHgrHiU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1JiMGZ2b3M4NnllNHVNd1h3WGV4bGhwWFVLN1pDbTE0Wk1qQkYxbnVOTVVF?=
 =?utf-8?B?WFFBVXNFaElBVnNCb1g3VjFaZGRGVXBIMVpnNFVxWnlabUFTbldyVTBrdGxi?=
 =?utf-8?B?OW1RMzZDV3ljT1Exa1RRUDZIV01UZFdvQTdDeXRFNE1uUG9sSkwrd1dGOFFW?=
 =?utf-8?B?WVppOCtwalBmVVhqNzVZOHNnNmV5RVpVcC95cmtoK3F3SDdqRmdOWFU5ZVI5?=
 =?utf-8?B?VkpLeHZpS3JDM09QajgwamVxUDg0ME9KdVNTd2RoYjlPL05Nend4ZzJMcTNQ?=
 =?utf-8?B?dVljVWNadFc0c1Z6L21sVnFLL2RneG5RMGJFRVZRcDQ5UDdOTzFncEo2dW9p?=
 =?utf-8?B?aEtTa0VueTBLVFhleE84NzZ3b25uaGY4ZExxYzhxN0drTTRIdDg1UkE4VDZP?=
 =?utf-8?B?RmR4L1laK1E3Y1NQSGRiWjZaTFpSY0RTSE1uUTF5Z3IzNzV3bkI2TmxTaVVZ?=
 =?utf-8?B?K21rYjRPSTg0MUdIM21FMG1JbFpBd3FXeTF1OXdJdVhNSzNjWUFUUHFKT1RX?=
 =?utf-8?B?QjMzYjBUVXhNai9haEppVVFvSFYzeTI3dTFvQzN4RnA4MXlUOHR1UjgwUnBp?=
 =?utf-8?B?K1FERkNQVlBuZG5RTGdCOFdtbGxzYlRRYUU3ZVdGVjRZYnFnTjRMaVZHMmxH?=
 =?utf-8?B?djBRZXVRcC9JWE5wRkpnek1kRTd6ektpQUdXSklrNFU2amd1R2k0eHJqbGJr?=
 =?utf-8?B?ZUVXVlRqeGl2SlIxd2EvL1p1S0J4WkZLQm1jbUlqZDkzOHhsbjJ6Rnh3VS9t?=
 =?utf-8?B?S2VqN29jZFpTZnJnMkxkdmtrUW4xd25EZ0JoZU1xVmtITzQ1ZTN2WkNPTHpQ?=
 =?utf-8?B?R01qbzVMTHc2R0ZQU2xJSXAxWnlRRkZSWWkvYVZNaUdCYzhsZFpucWQvQ1Na?=
 =?utf-8?B?N05PeVZmUnJsaGZaZjVnWTA4UFEvaEhrc01uRXQ3RkI3NXJ5dHcvcldITlFP?=
 =?utf-8?B?czhJOTUzUWtFR21kSyt5M1RoOUVmeS9qbStLaVdkeFBEYnNlZThIdVhWY3M0?=
 =?utf-8?B?azdFVFlnL3NwZGcvWTZvOVp5aFhtRHdrUldwUXU2eFd0Znc5d2lXS0J5VktN?=
 =?utf-8?B?cE16THByeDNVbE40MHB4NUdrSWJtRkRvYmdkUjlwcnNSYnBiVUQvcGFheGIr?=
 =?utf-8?B?V01wUXlJc2o1QktHR1ZnczcyME5uNDcrMUQ5TXR0OXF0bm45cURXaUR6WkM0?=
 =?utf-8?B?RUE5eDlPTTE3NnAwYlZpRlQ1Q0dPTzh6eVIvejBZaFV5SGtvcVhxQ211SmU5?=
 =?utf-8?B?UVZNMVVvdUhSOGZDUUp5eEFuR0NXUnB5Nmw3MUpxNVpmMTNINVYydDFzVlB4?=
 =?utf-8?B?MURXSEplZDFmOXdXOVZPSVZqTWVJcmVTRWFHY0o0d00zK3pBdjRtQXJUOFVG?=
 =?utf-8?B?MTQwcnM1akdmM2RqTGZUdU1RK2liY0tBYlZUbkJTTFJrdlh1bmg0VEExV2FM?=
 =?utf-8?B?alNQeVlpdk9GRlV5aTJOWEc0Z0gzNi94RHNqMHFsNzl4ZnlPdUU5UDVWMHNY?=
 =?utf-8?B?VUVOblY5NEJsU3BUQkRYbytQVHpGN0RWaG9OZkVnc25RME84STZsSGw3dXNz?=
 =?utf-8?B?a05DWTlEcjlwdVJvZTlaeThzRXk0dkcwZjIxbTh0MU9XWFJ0WHltV1Y0Q2JZ?=
 =?utf-8?B?aTJ2SS9CTE9GVDlWaHh2bHlTZ3lEby9ueURqSXROeHBjUEl1Zk0xOHFYa21L?=
 =?utf-8?B?YWpoUGkxajVaL2FjNytyTThZRmFsaGpGWEErMVNwUzUvQTRRMTc3SlVZTnIz?=
 =?utf-8?B?em82MzRSUXlxVklpd0R2NWFRaDd0T3RmVlNyb2pkeFUrOHQ4cE9xV1dSL3di?=
 =?utf-8?B?V0pxKzh6cVRDbHBoV01vWmdyejhYamFtUC9GbXRpZThtUnpQZXZvZFl5MkF1?=
 =?utf-8?B?c1hkd0pnb2pzZ05TclMwa2EwS2VxWXBGa0NKUFJ0NTZKTkpELzg4ZitMMmtS?=
 =?utf-8?B?Q1RHcTR2ZlRmTkxtbWZGMGVMTFZrZlIrN2ZWQ0srTXpuaG9US1U0M2ZGRk82?=
 =?utf-8?B?NTFLL1ZwWkZFdnVNc084KzMzVmJFQlM5cnFXUkdsajg0OXlDTi84akRwU0RN?=
 =?utf-8?B?MjczUnd1VEUrYUNLZEo0dTBoSnNUU2luRlE0dCswQ05jdGdmR1k5d3c0NnN3?=
 =?utf-8?Q?XpFiw8izfQh+HG66AuEPApgdI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84372b42-29e2-4c17-629c-08dc3148a69d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:45:28.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jklx46Cmx0uk1vK3/xTgToq5xu2hsJhgKf3qIpRUpYuKTEJCUB32WJsc7Fabu7Z9J00iG5gIISF8L/wrigX4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

On 2/19/2024 05:35, Daniel Drake wrote:
> On Fri, Feb 9, 2024 at 9:36 AM Daniel Drake <drake@endlessos.org> wrote:
>> On Thu, Feb 8, 2024 at 5:57 PM David E. Box <david.e.box@linux.intel.com> wrote:
>>> This does look like a firmware bug. We've had reports of D3cold support missing
>>> when running in non-VMD mode on systems that were designed with VMD for Windows.
>>> These issues have been caught and addressed by OEMs during enabling of Linux
>>> systems. Does D3cold work in VMD mode?
>>
>> On Windows for the VMD=on case, we only tested this on a BIOS with
>> StorageD3Enable=0. The NVMe device and parent bridge stayed in D0 over
>> suspend, but that's exactly what the BIOS asked for, so it doesn't
>> really answer your question.
> 
> Tested on the original BIOS version with VMD=on: Windows leaves the
> NVMe device (and parent bridge) in D0 during suspend (i.e. same result
> as VMD=off).
> 
> On this setup, there are 2 devices with StorageD3Enable flags:
> 
> 1. \_SB.PC00.PEG0.PEGP._DSD has StorageD3Enable=1. This is set
> regardless of the VMD setting at the BIOS level. This is the flag that
> is causing us the headache in non-VMD mode where Linux then proceeds
> to put devices into D3cold.
> This PEGP device in the non-VMD configuration corresponds to the NVMe
> storage device. PEG0 is the PCI root port at 00:06.0 (the one in
> question in this thread), and PEGP is the child with address 0.
> However in VMD mode, 00:06.0 is a dummy device (not a bridge) so this
> PEGP device isn't going to be used by anything.
> 
> 2. \_SB.PC00.VMD0._DSD has StorageD3Enable=0. This VMD0 device is only
> present when VMD is enabled in the BIOS. It is the companion for
> 00:0e.0 which is the device that the vmd driver binds against. This
> could be influencing Windows to leave the NVMe device in D0, but I
> doubt it, because it can't explain why Windows would have the D0
> behaviour when VMD=off, also this is a really strange place to put the
> StorageD3Enable setting because it is not a storage device.
> 
>> On Linux with VMD=on and StorageD3Enable=1, the NVMe storage device
>> and the VMD parent bridge are staying in D0 over suspend. I don't know
>> why this is, I would have expected at least D3hot.  However, given
>> that the NVMe device has no firmware_node under the VMD=on setup, I
>> believe there is no way it would enter D3cold because there's no
>> linkage to an ACPI device, so no available _PS3 or _PR0 or whatever is
>> the precise definition of D3cold.
> 
> Checked in more detail. In Linux, the NVMe device will only go into
> D3hot/D3cold if the ACPI companion device has an explicit
> StorageD3Enable=1. However, in VMD mode the NVMe storage device has no
> ACPI companion. Code flow is nvme_pci_alloc_dev() -> acpi_storage_d3()
>   -> return false because no companion.
> 
> The VMD PCI bridge at 10000:e0:06.0 that is parent of the SATA & NVME
> devices does have a companion \_SB.PC00.VMD0.PEG0
> However, the SATA and NVME child devices do not have any ACPI
> companion. I examined the logic of vmd_acpi_find_companion() and
> determined that it is looking for devices with _ADR 80b8ffff (SATA)
> and 8100ffff (NVME) and such devices do not exist in the ACPI tables.
> 
> Speculating a little, I guess this is also why Windows leaves the
> device in D0 in VMD=on mode: it would only put the NVMe device in
> D3hot/D3cold if it had a corresponding companion with
> StorageD3Enable=1 and there isn't one of those. What's still unknown
> is why it doesn't put the device in D3 in VMD=off mode because there
> is a correctly placed StorageD3Enable=1 in that case.
> 
> Daniel

Tangentially related, I've observed from multiple bug reports that 
Windows will apply StorageD3Enable behavior to all storage devices in 
the system even if "only one" has the property.  I would speculate that 
the logic for Windows exists specifically in the Microsoft storage 
drivers but is a "global boolean" for those drivers.  So perhaps when 
VMD is enabled the Intel VMD driver is used instead of the Microsoft 
storage driver so it doesn't have that logic.

