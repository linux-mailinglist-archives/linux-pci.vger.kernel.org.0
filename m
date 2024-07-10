Return-Path: <linux-pci+bounces-10088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416792D620
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F9B1C21241
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C81957E4;
	Wed, 10 Jul 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/5zXkkK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E580194C6C;
	Wed, 10 Jul 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628196; cv=fail; b=iURsDDlYeZOo9Ns0P/e7vL0T2Bw2eFTpdw9jFQTWWr0jp8/OMmli70oqNr9Fz6t4/Bp+xIeo5LH6lit5QTCB/5yyvTE6A1ALRWmAlr91ucnAf6FgiUbjdemSNPG7dPMD2+sUjttboy4Um6l0JqW3QTQq1Cbhvs7h7HPccLhyDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628196; c=relaxed/simple;
	bh=BdFLODrh3LprjSfOmZbleMi2XKLI0p4Tbm/kaEs+iaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgJp9vBp11Wv38Ue3gBfHfRLwVrXHrztsBajWj8SkWLc8dvSJA6OInq17t6F7Ht65ATeoqdXEM9DX9u3LQHpsNLd/CtpwO5ixp0905lYnO3K8hSpeTlZ/THHw2H5Etg+iT7rjHyslLHHZpCsHpQ/V/tF8j26RzZdYEeNxIvcv00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/5zXkkK; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5FA/B5pEuObiQtvG1HWSM9ZIN6wQfYJdILkDOoe2TWKR07fPeUvg2C0DlmxdeJ0qUQvMCiyD+bpPqXDtr79Jlx3CpXX/ygy8WoJg9EyNL6Vje6gexuIRbIJitW/A34OOz+ZQqR1T97Hl5f0cC6gvsxaa9G0C1FebAQ6OOubzmyv3oZcELJ2NnI6Z/g9qgkOP6mKAx0RiyDMSNjsUUsw2Pesk74zSUdQ3B/vvYutOHWcxESP3VQqNLFhV62UvV9fq0EXHQ7iwKpNTAi0vx6TR12F1UQTfNKFt3xnw2unntG7mIYqMd39eq7UJyiH4F6F8SaRTwybRtyhGn8ctE5GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU8ToC9oBAtYt9hgwOkwqMvF8PTy8YTrGT9M+24vtp0=;
 b=AQnf7HkzBaEwomt9bv/pqaAv06NQo8lusLAjA2n4uu/RYLcB4xAc2J1rMTp9uDyKqwfwkQG9Li9hYDE1ZyVMULCl+ghWbtmWb4PXLnHJA/jwCZfikh6hgqXFph/gxoo2m4rzQxIYJ5TKphbtg2kkXP3hjGMdz74OJI7leyDl8c4N+nUyuNy3mK2b+5SUd69W22F6T5KKi6cfkjQrKHTNrhqz7apBf32EPRIrX46omVFzYTFQVtli28gNBLiDs90WXN5qSZPWsAj2ek4YWiOrXJwtWQyGAfEvsUka7q7GKfmc6MV39wFzasuWlbecZBDTLl5NHEORyNQJmGSJvQa4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU8ToC9oBAtYt9hgwOkwqMvF8PTy8YTrGT9M+24vtp0=;
 b=e/5zXkkKyXX+4DaPxWoxzxafiLIlL/ve7OjE4+7kLk+toicLfdVg1ily9nfUIEopx+ftbOxr7MBZsSK3IizdiCEO41iWTpZu0F6VkoP1a2kRGLpazZKu54/zUQ0Im/xNUgr3hi3JzWg+YifuHfpRpRvjIFSzQ08cOR+ZRiZ7Uxo=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 16:16:31 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::cb) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 16:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 16:16:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 11:16:28 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 11:16:27 -0500
Message-ID: <283e6dd9-a8b0-4943-9ceb-3f687013c885@amd.com>
Date: Wed, 10 Jul 2024 12:16:24 -0400
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
References: <20240709161936.GA175713@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240709161936.GA175713@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 052939fd-6a1b-4626-a512-08dca0fba891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmZ4MlllUXVyc0RHZjY5Uk01WE1IeUVvRS9YRTdxcVpYb2I4YWQ4Tk8zMDFJ?=
 =?utf-8?B?TmtlMC9QdnNVWVJISVNDZ2ZKSWF0TnBkSlM1ZFZORjI2WHB0dkdGS1ZsVkov?=
 =?utf-8?B?L2xKZldRemxuV1FiZGNaOS9TM0RLeTlLOWJoWDAvclIvZFZsOW5BcCtnbmtK?=
 =?utf-8?B?cFVjbXJZNWc4RWU1SEFhSUJzNWJDaWhMMnJJZkFYOVdJOGwwditRNVBLam91?=
 =?utf-8?B?emlReFBYZUV6L0NNUXVrbGtadUszK3M4OU9CZlBmU1RFdFQvc3dUWFROcXhB?=
 =?utf-8?B?R3crenNsU21oeU1zQ3N5czZYV0lld1BGTDNMR0tZWEJQaUJRMmtieEI1c3Fj?=
 =?utf-8?B?QzlFOVFtUlpaVjF3QjBWUFhJTnhkYWhVa2szaW9uRWRaNU1PcGdFUnVXd2hl?=
 =?utf-8?B?L1R4MFFDa3B0cDM1cmorWTFER3RoaDhHMjRiL0tSTWpMOTRoMGphTmFUQmwx?=
 =?utf-8?B?ZzFXS2xKNjlaU3pXQ3lKd3pRM1A1U256MW9LYmdYM1JmVm1iRFZNdmF2WjVP?=
 =?utf-8?B?YlBITURWaUMvM1lDYXFSNEdPc3pHT2pxYms1Tks0SXlNYk5hb2dtWEJZZmEx?=
 =?utf-8?B?RXFZcmNLVlg1dE5VdllKMEdYWnY3YjRCTHVWSGdsWDREaXdwYi9CRzVwbzRZ?=
 =?utf-8?B?WmNJK0pZeWRFeWRNVDJqb2RQMmYvSVpud2J3L1A2UGR1Uk5BN2JtTjZZS2F0?=
 =?utf-8?B?V3IzR0FUY0JyN3dBN2FrelNZR01hTnl6aVdadzd0Mys2U1oxRkZTTmF4RFBU?=
 =?utf-8?B?V0R0TG15b3hlanhSNFpDZFgrRHBkV01DaHI1d3BDK21OcFJZQWF4ckdZNGpj?=
 =?utf-8?B?dldKNjA2RUFSSkZvcW9CMGZEcGtJTFB0YWt3dXM0WnRYQi9jeTE1ZXk5RW1w?=
 =?utf-8?B?K09nWkpYdjNnWTlWeHRKUFNpSnp4NlZraUNTM3hGYzBMOEV2SzcyUWZvQkw4?=
 =?utf-8?B?Tisrb2J0T2VWS0RLckdZODljenB3amZzTnVHaTFIaHJyK3hsVXFVU0xCZFdB?=
 =?utf-8?B?NGtQYnpzdFhsWE1VcWJ6QitJVnlGSmFteGlRVHc5UUlNNXFobUNqb1lBayt1?=
 =?utf-8?B?cWMwQmxaRGtZM1NMSUZ5TXE2V3BMdmd1SDM0V3lNWUtiUGlsenN2Y0E4b2VW?=
 =?utf-8?B?QmNGWUlhRUJhb094TWk1VFlIR2dWVTRNd2huemhsNjRQYUlHNmRCOHBLYy9h?=
 =?utf-8?B?V2IwZGdsS1dzTC9yRnZGT3B3aHkxZUNxT1dPZ2U4YWcyR1FWQWNnVjBoRkdu?=
 =?utf-8?B?R0FtRUdlYnZKNTIzQnpvUzRmMTRpRWxMODlFbmxJNnNwV3BZVFlqSzc5MGN5?=
 =?utf-8?B?SUgzWWtsQ3BRaG9hanBreTZiQ0hMWGw4Ykt1QkpHUjlyRXErVm1xRmVHMnBz?=
 =?utf-8?B?YkI0amxhY05Vd2tHT1R0ZGFXanJOTHBXYkVvNGJpMDBMSjJtZzBjcHZxaWpk?=
 =?utf-8?B?NG9raVhNbi9mZ1RFd0FjL2QrTG9hcDFkMlB0QWxtVjFNZ2YxeXhwVkdSSjhK?=
 =?utf-8?B?NWg2UjFGckRtL0FsVlp3R2dLMDFMVm0rVXM0Nm9uVktTcmpFUmJaV1lJRkY2?=
 =?utf-8?B?U3k3OW9LU2c4UXlzTUorVThERGpwWHJrNVluZEFWZHZORHcrV1RDMVNwMGkz?=
 =?utf-8?B?WmFheHNwV0pNSFA2WVlnT1B5UmMrMDg5ZzFkckpROFlQOGJTalZ2YVdZaG1k?=
 =?utf-8?B?YzQvQmU3UWJHZFB5MEczbFcyOTRvcy9heTFvTExDU2pjOVY3Tm5ycjh0eUpI?=
 =?utf-8?B?dldod3dIbncxM1hpN3lKSmNJR24zVHN1bXJCTjFJa21oSWorbk9SdWNRbEtS?=
 =?utf-8?B?MDlOdi8vazN2U2F6V2V1TmZ6dDg5Nk1rSWhkQnFSTHVTU1YxTVdnM2hyRFNM?=
 =?utf-8?B?dWJ6TmhyN1pWQVlLL3VwR3E5QXRveFBmbzZTZmdOM3VYaTlKb2Nob3pzN0pn?=
 =?utf-8?Q?1a7/9ymOzY2UHuTVES6BbpKazsdtJ2yX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:16:30.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052939fd-6a1b-4626-a512-08dca0fba891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

On 7/9/24 12:19, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
>> x86 due to the alignment being overwritten in
>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
>> make it work on x86.
> 
> Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
> added, but likely it was for some situation on x86, so presumably it
> worked at one time.  If something broke it in the meantime, it would
> be nice to identify the commit that broke it.

No, I don't have reason to believe it's a regression.

IORESOURCE_STARTALIGN was introduced in commit 884525655d07 ("PCI: clean
up resource alignment management").

There are some interesting commits mentioning 884525655d07:
5f17cfce5776 ("PCI: fix pbus_size_mem() resource alignment for CardBus
              controllers")
934b7024f0ed ("Fix cardbus resource allocation")

It would seem that 884525655d07 missed updating the bits in
arch/x86/pci/i386.c. I don't think a Fixes: tag is strictly necessary
because I think the issue would only start to trigger once the default
alignment is updated in the last patch of this series.

As far as I can tell, it only breaks in a certain corner case that's not
really possible to trigger yet. The corner case seems to be the
following:
* Only on x86
* The BAR has been set in firmware
* Alignment has been requested via IORESOURCE_STARTALIGN
* The IORESOURCE_UNSET flag is set
* Only PCI_STD_RESOURCES and PCI_IOV_RESOURCES resources (not bridge
  windows)

I think the reason this hasn't been seen until now is that it's not
possible to request IORESOURCE_STARTALIGN alignment via the
pci=resource_alignment= option. That option instead sets
IORESOURCE_SIZEALIGN, and in that case it works fine.

After the last patch in this series that changes the default alignment,
we will be starting to use IORESOURCE_STARTALIGN on all
not-sufficiently-aligned resources, and the corner case would be more
likely (rather, possible at all) to trigger.

My commit message is overstating the severity of the issue. So, how
about I make the commit message less scary:

There is a corner case in pcibios_allocate_dev_resources() that doesn't
account for IORESOURCE_STARTALIGN, in which case the alignment would be
overwritten. As far as I can tell, the corner case is not yet possible
to trigger, but it will be possible once the resource alignment changes.
Account for IORESOURCE_STARTALIGN in preparation for changing the
default resource alignment.

> Nit: follow the subject line conventions for this and the other
> patches.  Learn them with "git log --oneline".  For this patch,
> "x86/PCI: <Capitalized text>" is appropriate.

Thanks for pointing this out, I'll fix

>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> RFC: We don't have enough info in this function to re-calculate the
>>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
>>      alignment value seems to be intact, so just don't touch it...
>>      Alternatively, we could call pci_reassigndev_resource_alignment()
>>      after the loop. Would that be preferable?

Any comments on this? After some more thought, I think calling
pci_reassigndev_resource_alignment() after the loop is probably more
correct, so if there aren't any comments, I'll plan on changing it.

>> ---
>>  arch/x86/pci/i386.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
>> index f2f4a5d50b27..ff6e61389ec7 100644
>> --- a/arch/x86/pci/i386.c
>> +++ b/arch/x86/pci/i386.c
>> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>>  						/* We'll assign a new address later */
>>  						pcibios_save_fw_addr(dev,
>>  								idx, r->start);
>> -						r->end -= r->start;
>> -						r->start = 0;
>> +						if (!(r->flags &
>> +						      IORESOURCE_STARTALIGN)) {
>> +							r->end -= r->start;
>> +							r->start = 0;
>> +						}
>>  					}
>>  				}
>>  			}
>> -- 
>> 2.45.2
>>


