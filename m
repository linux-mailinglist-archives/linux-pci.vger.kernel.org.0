Return-Path: <linux-pci+bounces-44684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39553D1B9C1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF86A3005307
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC102320CA7;
	Tue, 13 Jan 2026 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i/oYY8F9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A62E266C
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343913; cv=fail; b=msNYWC+IHNN4S7OXmbgV3H8Yj4begijdeM3wbbhCPmEvuh9BAXmNRjvd7e4izTzjpr/wW19fl7PbhftXcLOutUWHAFx23H4626yusVhOuajSyH8rxyigZh8n4FvbK5LAKtwP0FZ3dB6ikpVUdFcCvSAXx8DkzMg9UwbDTWX/diU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343913; c=relaxed/simple;
	bh=IUnOxa/5Wk03U4kO3dIWoTQIYgV6C/nNywZ1MsWzJ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0k7nTZm+09Uww/bW0JgA0yuT6JsWwht6ZxUL1E89pneO0d7uEb7MHuOhsCRJwBGAhAaIFFCkYqX7qLhP5RFTaBjdoKh8KJx6UqReS8/SGxEF8YArYLit3owXB3BCLoKbJMVVsJZ8r3Vx8J+3p/QPEU11hhX7/rZ5BJbj3oF0jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i/oYY8F9; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lb4QfAfsWmCTNBgGNhiiO5BvY9/GeFE4MfxBfpIoKvTfKmIAlOfgNq1I313RtaSfUoCxRyWMqU8jIEPBfn0g/UiO7Q8xPZ/PvZaRHHpXnt3+ELL+pFTjHhsLV9jWGmfgtZO3mEVOgp9gJ8AZj6O0nSxBmmF4MehCEXCFfLF07juChMd3bh8Typo5YBcIPRjFjNaezN2Hrcl0TOA+0pxB3kDJhXWdXVOH/Rpi0KNMuA5WBrRhD9ecWiBj8R//zPIp50M99gCTcZOtJeGl69Hjl6IWC1K1b+0/xNX8KLeA976HE3v9cN18bZR36KCd2vYnyiEN3RK1buh3ALtiNt67AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1Pabp8IPvzkN6M2NHs2bm6IFBaPpDx++uRPLqM/fO8=;
 b=mqx5fg1eZ+HxfsK+qruTu7YnGE6xzVQf5KOxTmneGTxh0sE4xzIbcY42eQiBswvoKK0HJbrDtCV+aPzdsgdTaA/xkCu+GqNoQUv0gekb/4TXl6oyr06WqCtzwPMcJ1T0HFIZiRZgfCbVpfAlUCLZxHRYPVon0nrwUFeIvRMnBKelrNQvZFmmxJ8QFanzlMv6FP27ZlanJXG9g17vWY4UYP0M4uErf52k0ODWcAK42WemRZ7Ph6jsEJ8dNG0DNiHaoul0KQ1LVY2VoZGvPekKrtyUpntgyyaruVtdooHCw/OtkxJ69vw7sKHSheVf02sPiQIXuub6d8xi95egWw1WFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Pabp8IPvzkN6M2NHs2bm6IFBaPpDx++uRPLqM/fO8=;
 b=i/oYY8F9pOYSIw9408NfZkINWFzACdQYGcnlq/NcIZElSI+n133TUq/fGdmlXBYsiFMKiNcMLu9S8cvTIatLhEyt0x0p+CvvKJi3l4R+IwVM8VYwPZqdAcXgRckyLTAMAx9TwV+RcUk3UWdL4egMyjEwZ+vzHFU00SsaXcI3ZDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 22:38:26 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 22:38:26 +0000
Date: Tue, 13 Jan 2026 16:38:23 -0600
From: Wei Huang <wei.huang2@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, linux-pci@vger.kernel.org,
	Eric.VanTassell@amd.com, bhelgaas@google.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
Message-ID: <aWbJX75VdCEOBCgx@weiserver>
References: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>
 <20260113190713.GA775730@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113190713.GA775730@bhelgaas>
X-ClientProxiedBy: DS7PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:8:2a::17) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7bcfd1-4678-487a-3787-08de52f47799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ofyI0lNa50TZBSd4ksGaaZ5UkU/LLX0WZ7FgVeaUybwQl8BALkU9wh/ugbHl?=
 =?us-ascii?Q?WsqCsv3b8gVNN3Fz3vfTA0NH8ij0+6qYzz1C7NOTkOCDDVr/Cf3aWgO9qnZm?=
 =?us-ascii?Q?WVm8ZxjtIhCGLdNWNCWnisjZ9ush57Hnk7ek0sO+zmBoE0Ai83Z1b4FAYW3v?=
 =?us-ascii?Q?oR1nEb26QM0FQMfvP3G9MZnib5snRrVgW9IMBJszHt2z1hEe78SnIMz5l+G0?=
 =?us-ascii?Q?/+U7IZi9SzNiquiXD1boHM1aHidZNsjZU1rojMfCzL912wQTrkD/DBvjQhmT?=
 =?us-ascii?Q?288v5sDma75+wxGrodVab3urPtwE1O6pivWooM9KD8iha5GkAYRFQtPK+r9X?=
 =?us-ascii?Q?iVkrPrwn+c/WJgwE2TSIhOwoUcUD2zTS1k5FxqcdU5tZP7YEhEn8wjRyySra?=
 =?us-ascii?Q?LmGJZK3V61N+9dpRV1XIOqy8otW/qUgRSDqalLuHOcWoC1OjFCzOlpqsVE8O?=
 =?us-ascii?Q?m7mPbmbSkRLGBkw2VT1P30gDttmV1l/x7zOsy74hKzb8qhhWQhTINkViaOFG?=
 =?us-ascii?Q?IbE4t7E9dRDnhs641GDPQr0nIsfjP7QHoqs5XXTaK91IsrFuS63qAA6wjxcz?=
 =?us-ascii?Q?IsQlzUoMyXijafBuesXVyjrxARmkOP1WO/v9w0QX2rxnL/CV4U0PXS3NntjD?=
 =?us-ascii?Q?jYKKLCmgxCjTG38z8TGAftd4KLoau5XPePwit9Nn8fgjSpRbr2vmloXqp2i5?=
 =?us-ascii?Q?CR3StYRIdr7R6lLAvPFpqXrE7ouPMVE1uu+gaOAmkTBOPp+xLBGz1/ONN1Gi?=
 =?us-ascii?Q?r/NiUr9z/EojQzpNaNjNDJ+QpInCFn72Hbezbg+q45BWZk4e2GXjxE34ViBX?=
 =?us-ascii?Q?ZlW6vM8GLChu2iQLs/fzpHCxfqQLnU6A/bVP0qpgNT/ZV6FIvD8r3/MWIEib?=
 =?us-ascii?Q?g6Z+0Mmyb1c810TgAwnsHfkQ6kR1Cg5/ymZ4qw223diFIrqXujQE5Gp2WSBk?=
 =?us-ascii?Q?qXH55XGP7iRD3kbBC0UtZrmfPb5YjzkYQVhWDPKSodFdbx86/lwDLZxtvmV2?=
 =?us-ascii?Q?0+UX/DLIgwNReWRFVIsvx5DJ1tAy13NTSLyMKVZ0SDuu1UqFd7XpX0UVzBWh?=
 =?us-ascii?Q?qgArzS6BezEVez7kgOMMyfSL5YR9YaXkWUQAIP8i/UUNs1I8tZ12vkqV4Q23?=
 =?us-ascii?Q?DjCt9PiwN1lQNvDqcLONFyXarbhKkoNkjFYyquPcfkJOGijVjgJUOiRb+uuO?=
 =?us-ascii?Q?o02060i8enYWdYk/5x//zhtAMvVeziD43epEf+JJb6+zdH2+qwkSue3bBeDw?=
 =?us-ascii?Q?JruAAxwR9nF+I0kJ2rJ6RMkr0hSdXqBT5MoOwg8KM4U+Amyl1LidrKD4MPx0?=
 =?us-ascii?Q?B4JVHOGOCbdkZquXnAXTBVLdpDdXUgYby3ShgPvxHp5PYaOK0Yz7Yu3vVM6+?=
 =?us-ascii?Q?o1WsymZNA5G2a1Bzlp3jcg92oQiefoFCw2XNvkokZBissd3b6gqblnw88yTJ?=
 =?us-ascii?Q?Nz+kPnPaCK5jYUM50Mw/Q3cxB4X9BIZ6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjqGV6BzTP/ln+5YFrUOmMy7IKuVHX5B1AVkk3glH8mM2mo7uHTEborHyVoj?=
 =?us-ascii?Q?gajYNDitVXKWTzEcgbX2ToQfLtlqup9/JnxWITKNAZQ1ym2BFVM/NBPGbfkb?=
 =?us-ascii?Q?QQB/N7i6NljLpbAlXGdvMuMu5sI/PWKZN1fe4H90RWNdN0tqDgZZ1STMAMAq?=
 =?us-ascii?Q?oIPIiUXjf0oHYKsy2HKcagnyBmmJM1tX2VeTUhy6lEYDtEI+1xNtZ3mlH9+a?=
 =?us-ascii?Q?PicLiVPoxIHHEvaIUxpOgm0jJHqNLf+8hXlAq2/e10exwq3mZ973+5RBOohj?=
 =?us-ascii?Q?dbkqLtgj2ZjvU0hcKU9I3fxRGBtH3Xmh2UmOIloV9lMvK7BbQ1bJA7oOTphZ?=
 =?us-ascii?Q?kBO6I4yVLbomfEehWZZYOCoUW1ALD/xI/304x35P/oqI1txLqKuxqcqUljNE?=
 =?us-ascii?Q?MEz3shyuYOHZ+BtVkAdR90nzuFaT6Fr88IZCocFX69XaiMmNdDNQz6NwQjHz?=
 =?us-ascii?Q?nAl32tYihh4KyVkrbbyJGxa9BHW7U6pZ30nm6Ia1eRybShOzsSp47j4yZ4W6?=
 =?us-ascii?Q?8U7jCqFugfkqfA7fozgvJ0dpDxXQH2qdZSy2xSZV1ljH+5ZS/z5NZ0M78kED?=
 =?us-ascii?Q?lNmob2887oMtcgR3yfpIlAt5QQ2+L/zZv5/hpO1PROFRSuLuOElF5qnUklY7?=
 =?us-ascii?Q?Yns6qbaw7xqJwx9trVCsWjo3vFB6eCsxzFhhYV4BvFPbF5KRXVUkIclvlpRt?=
 =?us-ascii?Q?IkT6beRyncz98tFdjs/oiwbClSdQTMBW/JAaTlXP4Hh5KWv3sLp0V/KIlduG?=
 =?us-ascii?Q?iVfwN9s7iL4Pk+QlQ/1FWaH4XGCXcWOd7RTdJM8Its0sVtwVSJn4AcHuY4nW?=
 =?us-ascii?Q?i2WZnbGkhXGIEvZsHufTA88QP2mzAJQ5JXS2cXxAKzmZku3Ra/yiKpSHyG5u?=
 =?us-ascii?Q?IkJXy/kpyEJ61V2b48ackm7/fVF+YUHXpGpKBtOJVuj+ghgSUlPRH3xwPs95?=
 =?us-ascii?Q?ObVI5CEIigOWCHFQ9ZqFp/I9LYfi5WSOgD2S0jZtyXNSirhJzGW7Z99gzXmx?=
 =?us-ascii?Q?EU+ZjTCMNq5Vrp0vQ81pVCvusESJiNDve5N8CNlOKMMyPB5lVER4BSL5fTxU?=
 =?us-ascii?Q?dPqgFiHdsTPRHaqLd0PyuMwkQShJPgwhBJe/0NlakDpH/6GJadnPdgelhHcj?=
 =?us-ascii?Q?5DyM6doB3oCZPNMGuyGnyEdEyNTUo1C63blv8NoST3RFR04l3zf5MXQbTPt0?=
 =?us-ascii?Q?KSZyTL6w+Ckdi6qJmRnEdAu7zjS0Ne+BxlxblI6toHYV5LhKKNIxRSGBYrgR?=
 =?us-ascii?Q?r43Ahejvf2DzNPgS105fvtmbk7to6N1sesWvs1WKUgrs1JStW4hnVW9e5ZP/?=
 =?us-ascii?Q?lCHibVu1Kdlvc28rNwv4yfXzjFYETL1gkHlIHbB0OvkwmvLWSx/Jkb/JANYB?=
 =?us-ascii?Q?FGFbnklgFIHfNiqwRfqQ2tNgnU7PfTRcvSTozKHvRupiDdM9HEa6fcsLUbSw?=
 =?us-ascii?Q?GXQGMKdpGSzQgvK96VmJwlLKwThikSN0fscjXhHIGehY1/nZV8mKDWWPjnLb?=
 =?us-ascii?Q?7Ficoqh62fQatQUy6/ZYVeR3Tpr3qG4hhqm8okRjrfnekceaC7x/Me7NArh9?=
 =?us-ascii?Q?/vG/VuiDj6NMjuQWpRvuZlwK6guLTTtILJu9Hqkpgn8Y1zq5j5GFU4XlqO7Q?=
 =?us-ascii?Q?7UvUeMiM5/lV9RHfo1piYNXYd8yROxePzGTrclpUZlMCo74abP3KGjH70zmW?=
 =?us-ascii?Q?w3QVOc0YQmTEN+/qFh6/VT/7YmsvziMroZhEtZHa07QYH4YB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7bcfd1-4678-487a-3787-08de52f47799
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:38:26.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDK3JXGPW5/q6Za+Ac7w+V5IOxbKta6v/jKYjcJv+o2SDhj8yjAFg+Rjoj/7TtgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

On Tue, Jan 13, 2026 at 01:07:13PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
> > Hi all,
> > 
> > We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
> > following problem:
> >
> > 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
> >    obtain the steer-tag of the CPU. According to the definition of
> >    the DSM method [1], the cpu_uid should be "ACPI processor uid".
> 
> > 2. In the current implementation, the ACPI DSM method is invoked
> >    directly using the logical core number, which works on the x86
> >    platform but does not work on the ARM64 platform because the
> >    logical core ID is not the same as the ACPI processor ID when the
> >    PG exists.
> 
> PG?
> 
> > Because the ARM64 platform generates steer-tag based on the MPIDR
> > information (at least for the Kunpeng platform). Therefore, we have
> > two option:
> >
> > Option-1: convert logic core ID to ACPI process ID: use
> >           get_acpi_id_for_cpu() to get ACPI process ID in
> >           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
> >           use process ID to get corresponding MPIDR, and then
> >           generate steer-tag from MPIDR.

In my opinion, if this is achievable in your BIOS/ACPI, it is clean vs. Option-2 and preferred.

> >
> > Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
> >           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
> >           BIOS/ACPI use it to generate steer-tag directly.

This solution requires you to change the ECN and ratify it (as suggested by Bjorn below). The implementation can also be complicated.

> > 
> > Option-1 complies with _DSM ECN, but requires BIOS/ACPI to maintain
> > a mapping table from acpi_process_id to MPIDR.
> >
> > Option 2 does not comply with _DSM ECN (if extension is required).
> > But it is easy to implement and can be extended to the DT system
> > (ACPI is not supported) I think.

If you plan to revamp it, one (wild) idea is that ST retrieval can be extended to support:
  1. ACPI _DSM
  2. DT
  3. Vendor specific

After that, your MPIDR solution can be plugged-in under (3).

> 
> Sounds like this would be of interest to any OS, not just Linux.
> 
> Possibly a topic for the PCI-SIG firmware working group
> (https://members.pcisig.com/wg/Firmware/dashboard) or the ACPI spec
> working group (https://uefi.org/workinggroups)?
> 
> > [1] According to _DSM ECN, the input is defined as: "If the target
> >     is a processor, then this field represents the ACPI Processor
> >     UID of the processor as specified in the MADT. If the target is
> >     a processor container, then this field represents the ACPI
> >     Processor UID of the processor container as specified in the
> >     PPTT"
> >
> > [2] git diff about /drivers/pci/tph.c
> > @@ -289,6 +289,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> > 
> >         rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> > 
> > +#ifdef CONFIG_ARM64
> > +       cpu_uid = get_acpi_id_for_cpu(cpu_uid);
> > +#endif
> >         if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
> >                 *tag = 0;
> >                 return -EINVAL;
> > 
> > 

