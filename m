Return-Path: <linux-pci+bounces-44777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001ED203BA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1970300A917
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635323A35D0;
	Wed, 14 Jan 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVitZOvV"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A53A4AD1
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408587; cv=fail; b=Ib/YHxbiZwxZk7BaLF2ItB13JzoUD+SdbfFSOvhmxL6PWUfDNS+9ZmZvAEp2d79or+KX6xKuyy+7dDVZVuPVF6/2rCeMxZl933fX0SzYfW8tqIbNcJsCbwE+JmLw99LAlVcLpt6iw6YlSVunV5Pikyg+IbYIauPaCSHjYpn49mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408587; c=relaxed/simple;
	bh=z35HFkJFX4djoNtEyFLDwYLXZOfIx7WrhUscbhH1+68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ikz2Eg7nJn29c5PDgmq5TAd4p/EZTt7DeZCmnTQTy0jrZJeaoo9LYkCCtNjv68OhEbR0woqmSChrL2S2Dp0LPg1Tp/Bi50tpXyg0tdg1s5aKQ80SNl3W/gI5mr5rIR3qKKIjHSpL5F1oUgmQmoN4D/N3e4fGMEdVhBWr4yNd3+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVitZOvV; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOLjVa5sbwCLm/689RaVZ6BxS7EQnhp2obmwoIqKnSdnambGJioWe9TN4ITPallvOXT1Y6fS9LFDKGYLGjvYUckoEhXchLat3vA3ExKIH/bQkLaLTFTNwX730FuYyxlrzmUqTfDAv4JMap3XBEdDFmXTIT4ob8L5Jl2nd1B6KyqcbF24irPk/DhUfWI6IM3mHeaTPY5ldfTtUWuWVUX9k+IaJViBpq7rbiMCqKHXxGrsPLfMYFc7ZPXqP78QNgY8wyYArRrZoUgZPwRirV+JAHVnTGMwuqyqS1A+oqgxTOFdv4EUwOE659ewRuKg9GmtfqQhfzV35avnQlR7YI0NCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBO9BnAKlg+/lXnOhDMWisNIblGcs7UtRN5zvI4OaBM=;
 b=ILn0675oPwD8a0zX6MFS+CsSV/QbQTbS2VpfQ07FF7nRGczsYC45iYE5N5ww9MTzB18/Ap+Jz/fpsJT+I/WUpaurZnCQhE4yBmwAyheLIDAoxL6WYolj52UrqlpvWVUOMuk7ixdbgMPayH/k10NQyVZobsPoKfJ/LrwtN1kW9z0JA5XBbNjidN69fYt8geSrL1HUrvC84GybYitAq+21lyqXSUbxroMzjBuaqeVoiZI5Eeb3CpHFHF6nPspnpJtmCkCb4fvHuk0qB7Gli5DeXBM12nIa0IhksPSp347pTHi7EcFtjz4ugemIawNe3RmeehswPHvos2MdIsuTU7gn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBO9BnAKlg+/lXnOhDMWisNIblGcs7UtRN5zvI4OaBM=;
 b=oVitZOvV8GOAs/bYhLlMmiNg3XhY+2CzkyzZt1Q9/IwRQ17T+9prUvRZxFMpgZH8TNbVGNWWizReZ7DZ6Ccs+pgsYPydikuwL/iuNM+DF1kTbEfWcPB9aryceXa72PaN3+/DYEKrEFpYl6wXQpdXou/pSNi/4IEMBXya/3KTjGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 16:36:17 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%2]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:36:12 +0000
Date: Wed, 14 Jan 2026 10:36:09 -0600
From: Wei Huang <wei.huang2@amd.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Eric.VanTassell@amd.com, bhelgaas@google.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
Message-ID: <aWfF-ZNp55n5DHR5@weiserver>
References: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>
 <20260113190713.GA775730@bhelgaas>
 <aWbJX75VdCEOBCgx@weiserver>
 <85b11747-de25-432d-86ab-2c156f6b6976@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b11747-de25-432d-86ab-2c156f6b6976@huawei.com>
X-ClientProxiedBy: DS7PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::25) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fa32bd-9f48-44fb-da18-08de538b0748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wg2Pzl4fXVVDPBfNfgvpfU2hoHirA95rMWf6Q4GGs6Mp1FutIcAShzO8aS1i?=
 =?us-ascii?Q?93urb2PWXTYnrU2Cxq7jo1Vhe1XxBXObNd9IZbaCQ7CxqplDU8ms8BsJb5Oi?=
 =?us-ascii?Q?im2QIGhq86koKdDGaX1kVo6hE1xvZXV1xZxdHz+pWQkz1ghA2SJHfHRMtteQ?=
 =?us-ascii?Q?Nv63cfY2jVwPd+TthrVM6SPn2T9TJ1PnTy2jQu0PA1X04zzPMSmxLA432eFq?=
 =?us-ascii?Q?18cluVK9Mw4eFfhbtzlOjTvEGFFpstnbhw69JLQo28ZeIdCq1EHWv302tJel?=
 =?us-ascii?Q?G1KQ/32y01vhydeoAatisxFOCxru8eqaI9FJgv1PEnzXPI1fL7turPPa42My?=
 =?us-ascii?Q?OGsRuQTsIZXBS5Tk0LGit+JAv2DPWDU7YXtH1L+tCE2ovF+lyK4ZmprHYGTO?=
 =?us-ascii?Q?F+p2d+mZOcry+s3dRTsdDTRqoG7G8ZfiLJYAsanciSN/0zBEh8ffxKtlXgkB?=
 =?us-ascii?Q?yIuJxV/zyiM3OptGI27mpR/0MOePrhvv51AT162BiPD6mxwO9yCJKVZ/0PYH?=
 =?us-ascii?Q?YT0vsnhdHDCJurvYx+HL7mtM9AygvA30MJPolPZio2iU7bSpdP+jV+716D0H?=
 =?us-ascii?Q?sKdodCtO2MSIeXRpnAYNgRix9pm1Cp/4y3BbLKG02kjDIjrYCPxw1hqKZUck?=
 =?us-ascii?Q?UjhJny5wXKeEDVoHMsQuuoQur4LfyKXQqbftB71qlJ0vBT6Ig07xmaZH9tTy?=
 =?us-ascii?Q?WVu3y87zxRTWSRwHsNexGLIcu7Su+bMQWykyitU3tymqP08QWLzecOWe9Q7y?=
 =?us-ascii?Q?Jp9dbfxSOIUh9gOKtUyF2bHjuNeLTXuFCXbCaJmXarMfOB5JBSi5NH4o0TC0?=
 =?us-ascii?Q?NQgvIFXpGWrijKggjCuEEtbbnPlbH7cOHWu0RoaadBy9GiwKrH3ezz1I5ay4?=
 =?us-ascii?Q?/jGNwZuFN3yiU9ygFscjYljaWcwDszsvLFJr304DL8wUaEwLmTQBYbr/hFAs?=
 =?us-ascii?Q?kVSagIRqiSwNmRUU2cUx7kO7CLvAYdWU5RqxdDsVJY+izmudQD/BVSsO56eD?=
 =?us-ascii?Q?biMaDosUwxRKH3rOamTuM+mRgLB8XeriOp5GCRj87sYDEyFM9jp5lQ1rKDGe?=
 =?us-ascii?Q?BhWOti6Ua1b20rR8Cq9eraI4Mb15s4lclI49mX0o2H+ixl0cEGwdQveVYxZ2?=
 =?us-ascii?Q?6Lfghz3GL6uG1Jr3panTvB4aXZXmdiQnyVVWAtkV40/yraw7UrUCecMjBLe0?=
 =?us-ascii?Q?hJTqP0naGcyW3rPy2C5HU8zCEJfeyu7fLrh0thN0YYo6Vuj9uy6gVb9gMSuC?=
 =?us-ascii?Q?BSEDXBvPBqn2hHCucKuvVO/NWUUTz2V+40FjRjjbWnARM97FDLTPOglQpYVr?=
 =?us-ascii?Q?Uyoa77eJSEz/irKo+B7QTcskIQ+J1jcUKdACoBLNTVmspgtFpkuNTwk57cbm?=
 =?us-ascii?Q?ShISnQ5F6T1lCVb5l5XUs/5RWhHrJ1oYW1YsqnRBtqdoAgWSZYtx1zaXE37B?=
 =?us-ascii?Q?f36urV8BUmW8cQQzuQJWQCfhSPA9IW/Gxgpz+mZpO5Iczgq8EkdQEhqTgdru?=
 =?us-ascii?Q?r90o61IPnwLmcRB0WJV/szCqIklblYa7cVo2EAEM1LIV4dbV2gIuz3HYDH06?=
 =?us-ascii?Q?V7LCox1cLgudydFWL8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKUuBQJaVJAGFylcKBsoCRIXrGTc/RHgEV29dAHeq8iV+T6cakXPGuUY5fKy?=
 =?us-ascii?Q?nehjbEy8KmedY9rDBWpdVivWEGaHJiNtM8S4aYmFv+ryDkWeaQKpdETAZ8Fo?=
 =?us-ascii?Q?5LT3OPkCofgoBzxminMWuKo3nyAvLZ6bkgU/J34mZQckiZMvcCi312DuvCfR?=
 =?us-ascii?Q?qPne94P2clMZqUBD7mxRfNrNRK1hMe0FYXzoqexNIrH+rSK/FBOXyknxFiRh?=
 =?us-ascii?Q?AIh55Y5uoNsZYSl6NG2M8BHTXN2zbHD8mYG4518KI3VWabW0Z43YUSpZT0DY?=
 =?us-ascii?Q?2/npAOu0fP171elibn0QlCjUPMTsDOZouIcx6MgXju8Vzl3LAA/SOFCqpp7p?=
 =?us-ascii?Q?q4TfyjPSfn6jH8EipWfCakDjYknuWi9WIsb2f+ww9nUm5ifyvYMH2dE+sdgC?=
 =?us-ascii?Q?PRpmVk/7St9aMEmxUx/lXTMSES4GpgEda6gG5dMx+Amq16v2fsqe4+TWllks?=
 =?us-ascii?Q?Dc4D3wblmGsDAuy2+aypeNVs5NfS/hOLj76JcEZTkn98BK5FYDoKdPYk04Qv?=
 =?us-ascii?Q?XQgkM5u/rHWPXYNNO+iyjl8L2nH9CulyI35QlNT/3AucUYuGaKKEOUxXciGW?=
 =?us-ascii?Q?bwh+j/zqiAYOOeHkFrPf0P42n23Q1AAMwFGhknQVntea4/zW1ddHllInjpFo?=
 =?us-ascii?Q?rEB8RqAp92SDSCm2iPe1XRBtkcoK3pEILvMo1gfiJl4bD+73ZHVltibYnlgR?=
 =?us-ascii?Q?DCY8e7z097PUHIDjJVX0xCAtq4QC5IC9kzMFTd4OlRGPfGzFV34qo6Yre7++?=
 =?us-ascii?Q?+E89BLC/g/GYoYwShksl1PsitjZOc73T9238mdr49M5VTqbbzs1pUuup7yXF?=
 =?us-ascii?Q?VFpANa+UDSuacNtTZRsRXa8YoTlB7GBzWJTeLkz2HogyJ2/5qtxkY4xxZNG8?=
 =?us-ascii?Q?hUHWAo+3rJI14aE/+dZ8yKXaENvnPic2FuzcQvVYZ1bdkG5m7ZyFEFLgGYvl?=
 =?us-ascii?Q?T8KuGP3AZIB99QWK59stxhhcH3YC2eflmA1ocK55NzrmFIWSSFpDaxtiaWK0?=
 =?us-ascii?Q?4G1MBRv6JKtmKZnUb1J+Z2JhsVs6NClcWAdKxwwDJzzp3Ol5hyg2WkK8D/Du?=
 =?us-ascii?Q?lq12WbtPdwmmb9APgZmKpCkHt6z3b3PJySrpdjYYqDtb/C76J2LoqmlQB1Uf?=
 =?us-ascii?Q?ivlUhFssEZdHo/UczXHuptHoMm6odQ9ezwubXtSdbxaNlUu2wtYlBReISfW0?=
 =?us-ascii?Q?SULronP2MIAfn3AIg55GaRYTdS8T5+4DGczPK1Yrica+UfCaYtmK6Xidtteu?=
 =?us-ascii?Q?5doV+zXD8+tqDZRDSt0NU88WOHZ01u9ng4L2JUenpKn/Yed1FeLRzRq2/Mnv?=
 =?us-ascii?Q?6lKLm9hWsorggbj58VqgGKpeC3RSDMpEZzujoVqEaoPiBJxaF0SLRudryMba?=
 =?us-ascii?Q?g87sNqlM+DaHQOsDzuqx6WhrUP2q1yuqxbkq8cX3630wY6m9vsWjY4H3tIqD?=
 =?us-ascii?Q?UPIjCBFK7R71v9c7GcHrhp/TqTsaGT9Qx+SoPVSQ5NifFwqKqf8xwvg93Jd4?=
 =?us-ascii?Q?2QlyMym+q/wndO0c1aEWaOc0Gme9f0oIZ3Y7Hz1BRVA5soUKSVm2zwdgUPvF?=
 =?us-ascii?Q?RYIgevezlGn2PkXP50Kv7hsZwgDp4b41hfiOfvj3iknSl9gzrC1kwUNrHOR/?=
 =?us-ascii?Q?Ncq6lGUF54sRQgEJp4DtVG1G6f1HN27mMDy1FYHB/LmBku24Mr5lEN84U//7?=
 =?us-ascii?Q?cH9Gz/fLnOvMYmSBsI2Lrlr0q4Mi9/NAB255Qk/hhl6nyGP3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fa32bd-9f48-44fb-da18-08de538b0748
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:36:12.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+5q5E8Tu5XGWa8hRFlxHKEm5Yt1D+HFJ6UCacSB2yF/1dJWOuS8LZnthlNOHbmm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

On Wed, Jan 14, 2026 at 11:52:50AM +0800, fengchengwen wrote:
> On 1/14/2026 6:38 AM, Wei Huang wrote:
> > On Tue, Jan 13, 2026 at 01:07:13PM -0600, Bjorn Helgaas wrote:
> >> On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
> >>> Hi all,
> >>>
> >>> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
> >>> following problem:
> >>>
> >>> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
> >>>    obtain the steer-tag of the CPU. According to the definition of
> >>>    the DSM method [1], the cpu_uid should be "ACPI processor uid".
> >>
> >>> 2. In the current implementation, the ACPI DSM method is invoked
> >>>    directly using the logical core number, which works on the x86
> >>>    platform but does not work on the ARM64 platform because the
> >>>    logical core ID is not the same as the ACPI processor ID when the
> >>>    PG exists.
> >>
> >> PG?
> >>
> >>> Because the ARM64 platform generates steer-tag based on the MPIDR
> >>> information (at least for the Kunpeng platform). Therefore, we have
> >>> two option:
> >>>
> >>> Option-1: convert logic core ID to ACPI process ID: use
> >>>           get_acpi_id_for_cpu() to get ACPI process ID in
> >>>           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
> >>>           use process ID to get corresponding MPIDR, and then
> >>>           generate steer-tag from MPIDR.
> > 
> > In my opinion, if this is achievable in your BIOS/ACPI, it is clean vs. Option-2 and preferred.
> 
> Yes, it's achievable for out BIOS/ACPI, and we will adopt this option.
> 
> > 
> >>>
> >>> Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
> >>>           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
> >>>           BIOS/ACPI use it to generate steer-tag directly.
> > 
> > This solution requires you to change the ECN and ratify it (as suggested by Bjorn below). The implementation can also be complicated.
> 
> Indeed, and it may take a long time.
> 
> @Wei, I have another question:
> The cache is hierarchical, for example, L2 or L3. Does the DSM mode support the specified cache level?
> I checked the ECN doc and there are "Cache Reference" fields, but the kernel code don't enable them.

ECN does provide the "Cache Reference" field as part of argument2. Our platforms don't use it and don't plan to use it soon. You can explore the use cases if your platforms need it.

I want to point out that PCIe TLP header doesn't have a field for cache level. So no matter what, TLP header will stuck with 8- or 16-bit STs.

> 


