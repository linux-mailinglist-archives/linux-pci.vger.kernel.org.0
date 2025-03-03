Return-Path: <linux-pci+bounces-22777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A448DA4CB20
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F71896459
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206F2135B2;
	Mon,  3 Mar 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gMUZmKM4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039420F09D;
	Mon,  3 Mar 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027337; cv=fail; b=bSDkTVmOgQB6AMKfpRYiyazS7ee93kgln1yOZJGzOxCpUxMNjpD7J3xPLtf6Iud8X4bMk21k73K6PlycXiBy4ZASErp3uaZsupyjnHUhWuiNJY1cfTqsl3fwqO5LWTUOV2OBOFbL09+2KrvTZI5oUQNMddBvfg1yGgbJnebvuIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027337; c=relaxed/simple;
	bh=lsw8ZXEJaFFxaVImvdtrw4DEtnGdwk3eaz+16gsEdk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V+OkRFQ1JSgUHWZ07blR7xPxQozUOFTyr4Ch141Q7H5fsE+w+oru8KhvtXyUZxyKsDeRIkQt/lMZ54ciFobd/y7GFpVPZerte5LwyYXxOVQ4+rs6DCzSVsFIvOO0FZJRdHKhMq1nTxYZDJhzHhzplTQOk0cXPnpxaDv0OyrcW7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gMUZmKM4; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA/BF9+GtgUPHCYPOWg6Tx3tacdW14lB9jwYW8K13cT0BTGE5jUNvPbF26mNEu3DOJ9Fn5/rTvXLdHe1s9v10jcpFZxtLSPZ4RABPvAJV+eQsETO7Tsxp+SYxUYGg35NUv+c/n9nNdDo6SZ4w03Dmro4tXu9rOOzIx8kNkRJVCGgBpYahFfLtk2fqz0BYLfvPHxzHKNob4xTUUa4H455qHd4q90AA/0OeY/H2Y7jTfYcJABjZwi+gxMxNYog0KigPS8cueMoYJNZ0M5iv6ijkBxtRbXmETiu8//L+XEIJt56wGSSIV/kSKPEG6bj0kS/GLmFbwmJepi1YBfODDxDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Vd7/dS3cBa/jB/3iMXgcxU/4k7sbKFUDpg6aDCTHw=;
 b=KuUGr9xqFjWlfIMAfAMUsv1h2yn/X/DNCFp+kOGGpUhw+bHg+Y0HS4uogFJpAQwiUYqruMi5PP/O7QmkyD+m0kvaMKmXrTxTwVQQvf924q2vli7lTE3x6F0Io5OlQDA3uGXSk/UUHy6/CYsme/YGiuPpFbc1i2ASt15ZXSkZRiXs6nCj6SBf+BHTpnF59eZjB3/6cOCrbOTZo/IGPTBkHRHj66biY/flfTGtrDd+7O0a0G1ajoc8n2x5pgEfcHJmLRb9jHyNpEKxXV1BSeufLPbdBjwlzpF5WEsAc0dHecT4JqbqXkCoBZQJzjvihOO0yXmIjFxsFZbDRCrHRMhtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Vd7/dS3cBa/jB/3iMXgcxU/4k7sbKFUDpg6aDCTHw=;
 b=gMUZmKM4+uU6XOgueluvmCm+RCy7WmYpF2HIUZYICKKUpfi+whQA4DjMcQl/gddhkaTonIojzQc5BdwcgTlfyKxj09DmOCV8Yfr2CetmtJzkWGEh0UPR3tzO+3CBDgUlYSfELs6cwCUALkBJRl1hBrfT4qZ3vcNqpBAW8mleGMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 18:42:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 18:42:12 +0000
Date: Mon, 3 Mar 2025 13:42:08 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, "bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250303184208.GB1520489@yaz-khff2.amd.com>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <Z8WTON2K77Q567Kg@gmail.com>
 <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
X-ClientProxiedBy: MN2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:208:23b::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: c03ebd8a-04b0-4268-73d0-08dd5a831cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFaazje/7UFu/+vst8ffss0qcGXCPZDLTK8zaznk6gZ6JP7I2Yw8W2ofY1fo?=
 =?us-ascii?Q?DqVefyJgCNW6oCk07rtz+53uMdYlB4PEhEaNlF9EdkEVsaLPbH8hhp+NUxPF?=
 =?us-ascii?Q?acwXP/FO1cccj/z0fp4f1/Fm6UNk8LauLVNUBvNVh+Kw96DgOWbnNX0+0LHk?=
 =?us-ascii?Q?1XaKLTJa9C2Qy5xSQP8noDOxBcyq23sndFT0ehxEJ/WBu9RvYK0pbkqwJVVm?=
 =?us-ascii?Q?9g9Cfr7W1xKVm7HU3ulQo4Tx4giFodPhYvPQMTjTbPqAQ2noBvCmv8LalT1u?=
 =?us-ascii?Q?sDr8BfjvIUXBqk19nCpi1qjWo2G/GjMdl/GnR3ReC9qiiia1yO95hfdNy2Hj?=
 =?us-ascii?Q?v9Ad5WEJAZ7OFvPYf3BBwCFsNKz07BJPodtPd22nx/C5+iEG2C/lGuPLxvIp?=
 =?us-ascii?Q?W89fN3tQKi1zre0gpmI9Uc1LzcDbctVyAgNMs6tazhqQb6nEhx5El2VPrQbv?=
 =?us-ascii?Q?0ctATB9U/wEJDNLKBItuudBxjdZMmzucvJVeU/Tg36jgjw8vJk8Kz8A3fb6d?=
 =?us-ascii?Q?9gSomRADwzVBVpL9Bm81MxA7nnglfywc0P2bYOFHq+Wd4WcotBrTxKJ26Fur?=
 =?us-ascii?Q?BGU2PXBn9RC6NAQX2Q9kCiidmZhJ4bdWtzix8++S4IS4BGKyr2agmLYGAjeW?=
 =?us-ascii?Q?gebAVn7Q+41Vo6Wz+z+s7z0a/ZGryLhuyeekesIzW6JAF6AK3JujdcH4JCK4?=
 =?us-ascii?Q?SV9cINRerzdxAVH8E5Du4qZoBTs6844bfEW38y2txZCrPq+ozm9nrXP8jbvb?=
 =?us-ascii?Q?s0Z0Bo3WNSdnYGx+YqOOe6yIDuR7+1aoFr3NlGc80RyqsLy7jMfW9jdYi/D6?=
 =?us-ascii?Q?/HEmrTUS3QnzU2kPhRPfk/F46fb9AkjD68LynX2buE61+D1dFcoYwfxa6Y00?=
 =?us-ascii?Q?anAtGtM29uEFOhZyFxSZzu7GUyN/FJvG/xQR2zTDdCTKMsPqBfdVA/AZ9Lrd?=
 =?us-ascii?Q?VUCzwVYZf8UGahpT2k2AZvAVyNgFM/mR/cJNO903U7FF1/Vi2IubTZBjAgrz?=
 =?us-ascii?Q?hO7VDexF3H2zV1bicCkkN7oXJVgPQ9v0QvAltmg8jj87+2tSNI3RUNtWcSp6?=
 =?us-ascii?Q?5oTyNcRMxn7LZUdTm0HFXwqcXgG0q4o2v2/1E1Mw/tBHE6kFLOJK1Jg7kHdK?=
 =?us-ascii?Q?oTnxL80te+vsRcEwEWChm/i69KQYw30YUUGm0O6XNDoP3oea7+WmZb5trI3n?=
 =?us-ascii?Q?F+kN7qpqxVu+She2vVYslnh3AqD2yY07VfaxzM4oX6HCyZj/gmnoTQGswX9w?=
 =?us-ascii?Q?Uu5SxCUcYKHJVPxSH5VpMaSCZaZVk4F85iF0Sz/2LO0nmkXfjUdHFZ/OdyMM?=
 =?us-ascii?Q?sNJp9BAkO8e/hNiCmAB+jrLkPSxRvNi3rQ7ESmBEYdbj5fBvgsgoB7pD7stp?=
 =?us-ascii?Q?DfyCY6SqnHKeA4T1Zq7MiAmoPmjA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlGlTZ2rsymvVNpV1KclbRs0S/XeWjhjxOud6EziuNwRO8yNvRjSZ+d96SEf?=
 =?us-ascii?Q?2XiaGdyDT3U5bvuHhN25n4OlQGMQl8avVPKr+xdi+qUM5oNuiuAGp8KoKRFx?=
 =?us-ascii?Q?+6vX1rfhZHKdsnmktxBfBknx234pjFwy9k2ml8twtyidnUm6H/WW/I0j4dqv?=
 =?us-ascii?Q?znMONMp7vbNHJWffGZFKSYoBT4pchEZ7+FLqk4dzf/559EiMRdQ/vcTjdr91?=
 =?us-ascii?Q?6XgzlH9cSYOKPvyEKc2Bxx9hKdU2LtvAggkK8DNicdqr3ZAAk9cxcnTYLbLw?=
 =?us-ascii?Q?XjqpfuQYmgCAsZxDVooVfNSmCtfb8yW1fDDsCCQeK93UPAD0NESnrWFU85aR?=
 =?us-ascii?Q?Q8HcgzGa/JqIO9zOPj2ZIz6/dFrveSmYmYSMs5paPttk3UEBiF/ILohpTsVg?=
 =?us-ascii?Q?Ex6byI42mkz4rzGjdYyJ3jNaLaMwbTbbTA58iDO5uwERzHJMbaRCxyYZ8vhP?=
 =?us-ascii?Q?eE7LVIQ0qAxZtLAzI83A41QdlcXrmwSmHiU6SOFHAqOPy0u0rsonPG4OX0Ma?=
 =?us-ascii?Q?qDHhSZzso1REho3fJpfcGHL/kU7Fk5FlfX2rHeF82g1H1DC3ss9ASIXfAkDe?=
 =?us-ascii?Q?CUHj5xwENRaaGs9Xd+8IR9RtN3XWFDjcd7xAKWj7GA9cl/YSXgmwZQ6FFnX2?=
 =?us-ascii?Q?EVdaVSe9NVZdIbB9n2GChvhxcwHP/GrhSxg8t/ZBT+3SoqL8Rpkk7RNb1ci4?=
 =?us-ascii?Q?bTNUxUAzaxJT5ZXHr7nhf81v5UpwBkZuh5jbrzGRGiuG7zD0vwEJsC38enES?=
 =?us-ascii?Q?99YJ0UllNra3CmJpmBIGl7ly024ymnU/gTt6/OCFkG2U4mjapzWKNa/l/i61?=
 =?us-ascii?Q?DuiCV4IK9tDcE3LasFOwnRhGy50vZcGBUC3T32Xjw6KM/qbG0YHUWua1JzQM?=
 =?us-ascii?Q?9aB3LzltlLWaO9kkhILkjOXyzwXh1Q0ma8+gvv0+n73/BpITDQoVj58XaQ44?=
 =?us-ascii?Q?DbMcFMSLkObbeo8X6oECdAOZqu94ELm5OFUn5IlUbC9G2HWtsZyqR+Nd7PtT?=
 =?us-ascii?Q?gRQFef1TQpDZ1FXOyerOSz5WszE3OPodsFTfbc2OLtc3QNFhUF/YdefICcB3?=
 =?us-ascii?Q?Z9jahiAtRmT9UztK+aU6cQo4fk6h+1hnXNZ0oc4PJFMVpaanixrozvWDoj48?=
 =?us-ascii?Q?Yuva5W1buK6INgfnnR1N6KJ0CGpXxYg/DRsyim42tF0JdwBaLfdRjFGrpE9f?=
 =?us-ascii?Q?WAk2wXaDeXeSXW9SKlK5Fq1p8N5w2FOH6Zb2r7liQ99q3DqgWOuHbIUqDHUw?=
 =?us-ascii?Q?3OplsTz4jQnf9R1Sz/G60aJ4OtkWO50PLbsD1uAOdLfyKtzDLOXDmDwtSbDm?=
 =?us-ascii?Q?3Px4nuOWYzlIPyR36sB7mozcJ7zcpgB7i4LxZuX+Buen2h9tvuW4YGCNA24Y?=
 =?us-ascii?Q?uh0p9GPL8BjWNQtC9d9HoqwwyEy0PS5fBqxM4bhlPzQoZMDrzOlLH0L/W/mx?=
 =?us-ascii?Q?vE3U7kEuXlX87h8lnFks7gpOMi6Dr8QPx13y0LTGzc5AumS5qf0Yuc6/Xkjt?=
 =?us-ascii?Q?HMSJ3fK7FKf3xedb8l+CI20UPO8y46FPJuf7waQbyqiVBZNpxOOoz2NUc46c?=
 =?us-ascii?Q?cPqmvP4w1dvtuWdLO+/LvaKJjyIu9lu6mm4VhfNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03ebd8a-04b0-4268-73d0-08dd5a831cb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:42:12.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRsQJvRWDnJxmPM0vgXIGe3LooX1l8pcOi1tvsGnaBOpGpAwbj7PZs027enBb3h+n1aQTqJaO2zdOwdBWcvFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238

On Mon, Mar 03, 2025 at 01:20:21PM +0100, Rostyslav Khudolii wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Rostyslav Khudolii <ros@qtec.com> wrote:
> >
> > > Hi,
> > >
> > > > Rostyslav, I would like to ask you, do you have patches / updates for
> > > > enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> > > > adjust my lspci changes for new machines.
> > >
> > > Pali, sorry for the late reply. Do I understand correctly, that even
> > > though you have access to the ECS via
> > > the MMCFG you still want the legacy (direct IO) to work for the
> > > debugging purposes? I can prepare a
> > > simple patch that will allow you to do so if that's the case.
> > >
> > > >
> > > > So what is the practical impact here? Do things start breaking
> > > > unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled?
> > > > Then I'd suggest fixing that in the Kconfig space, either by adding a
> > > > dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those
> > > > must-have pieces of infrastructure.
> > > >
> > >
> > > Ingo, thank you for the reply.
> > >
> > > The way I understand the access to the PCI ECS (via raw_pci_ext_ops)
> > > works, is the following:
> > > 1. If CONFIG_ACPI_MCFG or CONFIG_PCI_MMCONFIG are enabled - set the
> > > raw_pci_ext_ops to use
> > >     MMCFG to access ECS. See pci_mmcfg_early_init() / pci_mmcfg_late_init();
> > > 2. If CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled - set the
> > > raw_pci_ext_ops to use
> > >     the 'direct' access to ECS. See pci_direct_init(). The direct
> > > access is conditional on the PCI_HAS_IO_ECS
> > >     flag being set.
> > >
> > > On AMD, the kernel enables the ECS IO access via the
> > > amd_bus_cpu_online() and pci_enable_pci_io_ecs().
> > > Except those functions have no desired effect on the AMD 17h+ family
> > > because the register (EnableCf8ExtCfg),
> > > they access, has been moved. What is important though, is that the
> > > PCI_HAS_IO_ECS flag is set unconditionally.
> > > See pci_io_ecs_init() in amd_bus.c
> > >
> > > Therefore I was wondering whether we should add support for the 17h+
> > > family in those functions to have
> > > the direct access work for those families as well.
> >
> > Yeah, I think so, but I'm really just guessing:
> >
> > > Regarding your suggestion to address this in the Kconfig space - I'm
> > > not quite sure I follow, since right now the kernel will use
> > > raw_pci_ext_ops whenever access beyond the first 256 bytes is
> > > requested. Say we want to make that conditional on CONFIG_ACPI_MCFG
> > > and CONFIG_PCI_MMCONFIG, does it also mean then we want to drop
> > > support for the 'direct' PCI IO ECS access altogether?
> >
> > I thought that enabling CONFIG_ACPI_MCFG would solve the problem, and
> > other architectures are selecting it pretty broadly:
> >
> >  arch/arm64/Kconfig:     select ACPI_MCFG if (ACPI && PCI)
> >  arch/loongarch/Kconfig: select ACPI_MCFG if ACPI
> >  arch/riscv/Kconfig:     select ACPI_MCFG if (ACPI && PCI)
> >
> > While x86 allows it to be user-configured, which may result in
> > misconfiguration, given that PCI_HAS_IO_ECS is being followed
> > unconditionally if a platform provides it?
> >
> > Thanks,
> >
> >         Ingo
> 
> So it seems that the config option that needs to be enabled is
> CONFIG_PCI_MMCONFIG.
> The MCFG kernel support depends on it (aka not compiled when disabled).
> With that said - the IO ECS question remains. Do we want to support it
> for AMD 17h+ or
> it's not required anymore?
> 

Hi all,

I'd say it is not required (nor encouraged) anymore based on my reading
of the AMD docs and PCI Firmware spec.

The possibility for direct access is still in hardware for backwards
compatibility. But this doesn't mean that it *must* be used. And it
seems that it shouldn't be used, if possible.

I'm for the option to address this issue through Kconfig.

Ros,
Is/was there a reason why you didn't have the MCFG/MMCONFIG options
enabled in your kernel?

Was this a side effect of trying to build a minimal kernel or similar?

Thanks,
Yazen

P.S. Sorry for the late reply. My mailbox is missing Ros's reply to me.

