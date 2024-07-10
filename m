Return-Path: <linux-pci+bounces-10125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9CE92DC16
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4ACCB25B69
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63414A605;
	Wed, 10 Jul 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lSZG81PL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41725143740;
	Wed, 10 Jul 2024 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651796; cv=fail; b=Hsv5CEdK6uuzwMhAbTxxs9wnqjI50a4dxGuM1aCQZ1PeMMQQZHEgmeuOuIPJnBcya50VrAxQtL38oIS0JdgbkFYOAXDpUVDYcCZklPYzHMTubFW2zNb3Lc4I9lb0GQwgyiyYqHxYlLZATqu8o5qVUO9k5mzxqncVRdywtotF5Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651796; c=relaxed/simple;
	bh=B++4k6xniOfPpg67/N5GHCNFJODzxWSlvbQVwv+ZwhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DDTJPh6SRvLTJHIeopkaLKPY98yS8y/UoMUWqe+UfRZ5m2L9aOs2c8m4sfmL4Nbj/eU1QmZBzMRXycw9koUVs42spFgZxUrV+pF680lWBmTiZ7O07q4h4rNwCEcxNfj09f0UU+yB8KykCt1A8QjwP2QzK/wp7cGhvXYUBJbFNz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lSZG81PL; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFjziPCpeIto/IOPakF2mJ3dp7sT2nlb7Ln92rzWaFBasBeW2om7x79orsXBmHR5fshFGHT518Gnj/qF4KGyhTLnkn6if42rBX3whMHFehKY8Yb38HVUAF4ggJ6qtqoAx9xuPJZmCCnpM5MUOdBkUG5kfgzMRmEZQ+CMQi5FCwsn/CyTyX7Bv4n/i4Zbr2B/sh76S1Scv641C3QFne0qTIkL/pz4k1Ieutj+c0AWv99xCP8qhOfShwZXWGVpANtHAKxFCcOysscLJMLBbvl//gBUlgTK4OL8dGSsrv1uAQuBQy5/uIs6ktnxRqnuCeiy5zQwpReXQrvZj2fI2Mel7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsdP2zMDPwbNwHRwQXGfim/gzq/Av4l/UGXnrzhvkAg=;
 b=AhaBE3yAXbRD3gXL8663twwPpU31eQDf7QW7v6rka7BhccS+eqCc8RsscbKlo7HzWTSCiGCCyADxCN4jXMQXwc6znCtxWmSSHyylRzhyWRIoM/cbnCrQYFGbcRZgjh1eVKOI8vCVQIMBe0P6PCETASLj+3T/LRefc4CWz3NN6B4mXwwSaKabDww+jcZm+MywdmDdTcDebJkFoAbwl7rlIpTQ3mwyTC7Cb8h0v2Hwu77bdm44CtmCobkyYJTuzaag0LU9Az2g1QJCxylN5BvMpe5evVy5cLBYQuCp0KeCTY/fa+QLWaYOGbpiqM0s8E9KEOrD54EjX3NiuUufzUnXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsdP2zMDPwbNwHRwQXGfim/gzq/Av4l/UGXnrzhvkAg=;
 b=lSZG81PLIQVafVuamAtUVVSIXhe0+zsoP7VgygCnRuVgBi2oaVgU1w0LhfkMNEtQu1vG8eKDKtMmMPw/0A9Y3xAUGo13l5+v1tUPls3Td/D7VfUwEY0m7P4q9U0PBR+e0kY750vZfaLgVbhmui+Fv7yag5D6mjBPxxdqFBQGmSE=
Received: from SJ0PR13CA0119.namprd13.prod.outlook.com (2603:10b6:a03:2c5::34)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 22:49:50 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::aa) by SJ0PR13CA0119.outlook.office365.com
 (2603:10b6:a03:2c5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 22:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 22:49:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 17:49:48 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 17:49:47 -0500
Message-ID: <a9c7ceb4-264f-4464-9f22-597d24f74f33@amd.com>
Date: Wed, 10 Jul 2024 18:49:42 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<x86@kernel.org>, <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710212406.GA257375@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240710212406.GA257375@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b53c2cc-2e8f-4504-67be-08dca1329b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUJwc3o3S1RnWml2dG41Szl5SDFYUHFiYW4yV0FYazY4TVF3U0Q5UTFtN0cr?=
 =?utf-8?B?NGlmcDY0LzMrR1N3RHIvODFpalpwazFselRMalhmbTBlaHhkSGlCeWMyM3NJ?=
 =?utf-8?B?YmhweHFvV2M1ZmdYVHhxci9aR2kzM09pWlVhNDkwSkdscmdPT3MyeVI1Mm5D?=
 =?utf-8?B?VjRNa0RyNUNodk42T3ZYalp1UjVlZFdpY1c2MXZUenJvQlZxRGxBeDlYb1BQ?=
 =?utf-8?B?SDIzaTVOdCs1MlFxMmZjOHNscnVDdmxCQTVqU0JrSTVjMkFDNVpKTU01ZFFP?=
 =?utf-8?B?d3ZhZWxybk9kZ3lwMHAzWDNQRVA5RUthc0ViSU9HK2pVNys3RngxTWk1dFU3?=
 =?utf-8?B?SWpiM0FKNDRXdTJLOVdwZ1Vqd2YxNUptbDM4MnZLT3RSWUttbm5vc000QW9u?=
 =?utf-8?B?U0Y5Vjd5SG94eVF6OFB2dnY0TW1walFhM0lNKzh0UEtDSmdLRldlU25WT3l2?=
 =?utf-8?B?Rks4MFZ0SHAyUEVIdDV2dENmQnNrWFVXSzZMdzY1cTRuM3VWZExDSWdlMWhu?=
 =?utf-8?B?Tkl2MFYwbFNmWG5BYVhrdXlycUsxSk5uZ0dROWY3emMzdy84UlBEN3Fsbk9B?=
 =?utf-8?B?SzlUc0xuSHpwUzhXc0ZpR1U1azMyRW1NaFRwbVRUNUs1UUZZak9taDdaM0Zt?=
 =?utf-8?B?RGJudHV2MFF6R2pXZnhvOWtXYmtickE5aDBSQy9DRlhZV3NxaE5zc3lNdCtB?=
 =?utf-8?B?bjRrdkpETUJTa1ZRbXZXTGN0UTN2djJnVi95bE5DQnlPd3R6MUpsVDdGTW9I?=
 =?utf-8?B?MkF3TThkeVE3bEZmMGs1aU5ReVRTOXFqL1dZTTAvbFJ1aG5Cb1d3L1BVOHUx?=
 =?utf-8?B?K0JpYVJKRDY2TFRMRnlNcTdVQUZndk5JeVVpRUZLMXJiZm95NGxHU2VoREFr?=
 =?utf-8?B?RmJpQms0TDhBZ1dBQnlkSDhIMHJsWlo2eWU4NHlSZjQwcmR1TWdkUFZIaXp0?=
 =?utf-8?B?SGdvRTdsRTFsd2pQVVI1RDdDTjhabTZlWE4xTzNOdWtJVDhKOHBObDAwN1oz?=
 =?utf-8?B?V0xkTzcwYzdqMnNkQmdmVUVSOThVSUs5UFRzWC9zVUJDM3Z2L3FIa3hwNWhY?=
 =?utf-8?B?amcwSzRxazIrcGZKUGNwN1hkYjFldk01ak9WTXpra1o0SDREV29vVGo1dW1u?=
 =?utf-8?B?cThHcGlVYktqSnhCemN5TDRwQ0ZSaHNXbFpSdGxGZDBoc3VJckUvVmczMm5u?=
 =?utf-8?B?UzE5bmx2NXk0bU0rM1Btb3dZV2lKNTEyWXNLdlpjRDhCOVM2L2IxL1djMHdR?=
 =?utf-8?B?R2tSVE04dndHTFQ2SURCQXdjZXcvZEdrNFdFc0VrUzJ4OWg2cHZYbkxBMU1C?=
 =?utf-8?B?c2hKb0U5Y0JzMStmUlpBaEVLdnl0T3E3WnNHbEJPQmNlajkxYkw1YW5sV3NL?=
 =?utf-8?B?TG44MFVUeE1VMXgrcnZPZ2ZnZlQ5dW93blBnejdpVUlYa09pZzM0YW5MY3FX?=
 =?utf-8?B?NE1zZ29hRVExYmxFWGU1dHJyYzM4cFptSnRFbXlsZmFzWUZoWGxTSHh1bVFO?=
 =?utf-8?B?MlZqZEI4akRTTlhZcFlLMDNoTkluMEw3Q3Z3dzg0RTVoaVpYaXJrcWtscHBs?=
 =?utf-8?B?VEl1VS95UU1laS9rU2t2OXk5SkRFZFJ2WWRaSCtnS2x5VWhhYjBkOUVqZWho?=
 =?utf-8?B?YUtqZ0JadDdHRDFqVExaNjdLbDJLQ3RmQUs2TXZSRE10QTVnQUFkQW9DTUNF?=
 =?utf-8?B?Y1lvYjBJOGZPUXJiWENBVmYvR2dvaTVqSHdMT0RPbWREaWw4NjlyTmp0L2xY?=
 =?utf-8?B?OUFwMW5Ba2I2M0NiV3VuVUhscWZ2MndGS2JPNmFSUTlaV3hPMUFJU2tVMGpB?=
 =?utf-8?B?emJYUGZDbFgxU0xXYmdCQisvNkRlM0FTaTcwa09LbVd0b2JWRk1iQ3FsRUcv?=
 =?utf-8?B?MURIQXJCamZwcUJKQ3V6bDhER1YwZ1JtSy9LWlJNVWJrMURBWkxsV0JWTDRx?=
 =?utf-8?Q?cl58hnw2lWm6t+sxBAidSOt1CDZy2hix?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:49:50.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b53c2cc-2e8f-4504-67be-08dca1329b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423

On 7/10/24 17:24, Bjorn Helgaas wrote:
> On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
>> On 7/9/24 12:19, Bjorn Helgaas wrote:
>>> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
>>>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
>>>> x86 due to the alignment being overwritten in
>>>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
>>>> make it work on x86.
>>>
>>> Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
>>> added, but likely it was for some situation on x86, so presumably it
>>> worked at one time.  If something broke it in the meantime, it would
>>> be nice to identify the commit that broke it.
>>
>> No, I don't have reason to believe it's a regression.
>>
>> IORESOURCE_STARTALIGN was introduced in commit 884525655d07 ("PCI: clean
>> up resource alignment management").
> 
> Ah, OK.  IORESOURCE_STARTALIGN is used for bridge windows, which don't
> need to be aligned on their size as BARs do.  It would be terrible if
> that usage was broken, which is why I was alarmed by the idea of it
> not working on x86> 
> But this patch is only relevant for BARs.  I was a little confused
> about IORESOURCE_STARTALIGN for a BAR, but I guess the point is to
> force alignment on *more* than the BAR's size, e.g., to prevent
> multiple BARs from being put in the same page.
> 
> Bottom line, this would need to be a little more specific so it
> doesn't suggest that IORESOURCE_STARTALIGN for windows is broken.

I'll make the commit message clearer.

> IIUC, the main purpose of the series is to align all BARs to at least
> 4K.  I don't think the series relies on IORESOURCE_STARTALIGN to do
> that.

Yes, it does rely on IORESOURCE_STARTALIGN for BARs.

> But there's an issue with "pci=resource_alignment=..." that you
> noticed sort of incidentally, and this patch fixes that?

No, pci=resource_alignment= results in IORESOURCE_SIZEALIGN, which
breaks pcitest. And we'd like pcitest to work properly for PCI
passthrough validation with Xen, hence the need for
IORESOURCE_STARTALIGN.

> If so, it's
> important to mention that parameter.
> 
>>>> RFC: We don't have enough info in this function to re-calculate the
>>>>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
>>>>      alignment value seems to be intact, so just don't touch it...
>>>>      Alternatively, we could call pci_reassigndev_resource_alignment()
>>>>      after the loop. Would that be preferable?
>>
>> Any comments on this? After some more thought, I think calling
>> pci_reassigndev_resource_alignment() after the loop is probably more
>> correct, so if there aren't any comments, I'll plan on changing it.
> 
> Sounds like this might be a separate patch unless it logically has to
> be part of this one to avoid an issue
> 
>>>> ---
>>>>  arch/x86/pci/i386.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
>>>> index f2f4a5d50b27..ff6e61389ec7 100644
>>>> --- a/arch/x86/pci/i386.c
>>>> +++ b/arch/x86/pci/i386.c
>>>> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>>>>  						/* We'll assign a new address later */
>>>>  						pcibios_save_fw_addr(dev,
>>>>  								idx, r->start);
>>>> -						r->end -= r->start;
>>>> -						r->start = 0;
>>>> +						if (!(r->flags &
>>>> +						      IORESOURCE_STARTALIGN)) {
>>>> +							r->end -= r->start;
>>>> +							r->start = 0;
>>>> +						}
> 
> I wondered why this only touched x86 and whether other arches need a
> similar change.  This is used in two paths:
> 
>   1) pcibios_resource_survey_bus(), which is only implemented by x86
> 
>   2) pcibios_resource_survey(), which is implemented by x86 and
>   powerpc.  The powerpc pcibios_allocate_resources() is similar to the
>   x86 pcibios_allocate_dev_resources(), but powerpc doesn't have the
>   r->end and r->start updates you're making conditional.
> 
> So it looks like x86 is indeed the only place that needs this change.
> None of this stuff is arch-specific, so it's a shame that we don't
> have generic code for it all.  Sigh, oh well.
> 
>>>>  					}
>>>>  				}
>>>>  			}
>>>> -- 
>>>> 2.45.2
>>>>
>>


