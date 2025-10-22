Return-Path: <linux-pci+bounces-39039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCBBFD314
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E5D74FA973
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFF375734;
	Wed, 22 Oct 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3PwMgnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB335773B;
	Wed, 22 Oct 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149358; cv=fail; b=ZP8vXYBfUhkNLHlbkhzhHPAbM/9k+L3WBehSVFZNg0QRkwExnWU4w2p2EjRMWJj4IpB42kCxWAiyC7kiQJjBHPjmUx3YrGNyrd4DGAQYNvgM5kIwORRsZ+lpZCRxEFRFGZGrxSIF/SkRFHG9M75ir7YZWRLWOxKeTRLz0NEdYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149358; c=relaxed/simple;
	bh=5r7lkRQnrIIlzXp2odCdQVQtqFDaPDSmls76hY2PXic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HaSut28QALwMLHvOiYgUGkbWSdLJlYVbXB8SMKTet5gKFKSgTmAq41nhtaF0xKvNm/NSUcgB/Dik5znfkk5ww1evR4+881FMWzKFlxu4FpPDqp76I6KlIUdc2JuY/Ij9dnF43XpymnYVED20bIpADblFfc5vHeFLIykWIie7L30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3PwMgnl; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9pbu15wsZsFi4g30L4O8sBMqQrmMc4CBu/f/e854zXO7jpBUVwJfT1gO1XtIvOfIjWX8U7PAoqEVeWkFmOU+20kOdEXvMpbJKogh35kBQdB4a78dSVwry8SjHXNdDIWYKT4WxD2E1oEvVqXhknNZCQuKbgbZLACJHGFsEsC5qbEuNr8XbXOgFCXrNzckFZf1ZGBq3BPkj/ETx0qptoWZZ8Hb+OouX8wT8zGjUE0BEDuPQcSamnqlKcrYm3RoUO0pXwx89g9Uz5U4jnlbHAwRPGRM9iWQdwFdIMndVovu7vj+BK3ngsc2tOU8r5wSewQcF/yKtC5Bm7QJ4C2v38+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLTULTV7TW0m2kby/AIrdxzM8ZSb5h86gMgyWUh0+1c=;
 b=coRwOHudha58yIYuPl3T/BpcA7eS/04GEJEyV6e1LYQCsxIQ1JSPvgj/dB5WkVKVcdJZgAOhzb6rizVgzlvvqs3vv2mhMV3RMt/jmF9gHCwYEMSpyMMbHRfmxoIC9xowfZ8nLdjJrcd9lxh8ORj+zCjsn4eGxjBEDQtN6+4c9vMscgG4XRYcrcyEh5NKXRQsqzx1M4fvZ2z/HdzUPhLnJPpcvsVeqNiG4New7ekcsQ+OTgeUZgdQo2+l9uyhabbbHCochzv8yWOQXL02mRuCqwx4DHx5r46eCJ0GDdVchM33lpLvZ1KEwGs5U64Ay7ps+vNUC6C/rS9FAWrZaXmybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLTULTV7TW0m2kby/AIrdxzM8ZSb5h86gMgyWUh0+1c=;
 b=x3PwMgnlXrOIMfJEsAKhSi9XW0keREo0W0UFDvMLw/hTk8WO3hGRcjwXcOF27s7vcsGhCRmfRF32whIIYYSpSW16mXli+KKiBdTPk9iMPGhvKbulTtXMCUPAa/cA0JR8myqLm5KvMLojhxZUMKZxGVYpl/K3mPZgJyy9j4fF8gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 16:09:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 16:09:10 +0000
Date: Wed, 22 Oct 2025 12:09:04 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux@roeck-us.net, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	platform-driver-x86@vger.kernel.org, suma.hegde@amd.com,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251022160904.GA174761@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022173831.671843f4.michal.pecio@gmail.com>
X-ClientProxiedBy: BN0PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:408:ed::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cefc68-d230-4ebe-ef11-08de1185560e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCZ5ZmmbMcmXy6ZsWkqbEHPnOS8XkJwf7mNer52E8xERjF2VyCe4NU54tSMu?=
 =?us-ascii?Q?IL1sO+GIE7ypGvCUZ/t+5OBzJHL/+x6o5a1GqfeBFnVlW0QZEsq5hI+TIwIq?=
 =?us-ascii?Q?DdO9FDXPoo7r4CKqozYc1YH1pN8JuIWz9ZgMQkIPvmywrIUgAPS4GJ9OcKve?=
 =?us-ascii?Q?CPfXa87D47VoUbMdoclx8zjHFWg5oyMfCDgoLaxMTS112WXkrSlNHMWfxaqS?=
 =?us-ascii?Q?3zrsu4A/bCNw6PsReO+ZDCJKI04jhk8uAG7G7ykrbs23yVHRwwC/yuJsBz/C?=
 =?us-ascii?Q?8HSWPYdW6opZVMUyCLEZ1+k2XMvEzGqgNJoIYLsE0nk5oee7m1dTr0UzU8kQ?=
 =?us-ascii?Q?1h708gx1eCaO1g4dca/N+XVzHbijcqcew8mcZ21f3G+gKKQIcrR6AX/mcItk?=
 =?us-ascii?Q?wF9vo/dSVJszHZkQ1mOpkngQStEbuHFc/KNqnlR0oCk6BLpJGCpy/7XFo/pV?=
 =?us-ascii?Q?gfJPe0WRvb6posIQOtnPkehmYSMzfOQgAh4QypLzwuP/3VWb5ic5v0dxeZ57?=
 =?us-ascii?Q?+pxKFFMSGn4Ou+O4x2u1dicQvCAwD4xtUA7UkffulbcLWG0k/WO8Rbl9KHej?=
 =?us-ascii?Q?VdYmb6b/2b4dSQbWvNMI/q4Bj4UH+eKZIvVBTJn53JgeZ6JQnKTI1S5gZwep?=
 =?us-ascii?Q?jPwR18vUYViei88OUxNYZcicHFs1c0tteJF92I8QGis33aUDvpTm2Z6djQEN?=
 =?us-ascii?Q?P0CAX7gAiacg/haeps38YXnWyv8d5GaBorusWg+3YGfPDz2AyHxsmZm3a3/m?=
 =?us-ascii?Q?Z8WITuu6QJSeY2lwsfFq/0YjsjpcdSaSQLCDqB1lyk2ThnpgRtOJRBPv1EU/?=
 =?us-ascii?Q?G/TsE/r3XNjFTfr29pG80gFVfNCD6Ko/bjVfuYfCvFD5nIYLn4XH+PuwPjTz?=
 =?us-ascii?Q?XjJGoUMs1yUHuYFtgVevqxCOhtODIboUplV/De0hNmPd7rGzsg1Ak0TvxHr3?=
 =?us-ascii?Q?rLQir2lHs0cEGN/3CT8ZXZ4trDEmRPKOL+r+51DrxXP0BdYl8rueRzmITvqp?=
 =?us-ascii?Q?tKCDyx9cbf+fqOTt25cfgHa1Blebjvl5X/IGeQj1BgAbvzfx6/lkdZN/omuE?=
 =?us-ascii?Q?FviBsosC/ME89Dsa++6i/EvYHMJrPJ5OfYf0QFqIskbJQpe88tKLUp1PbBnV?=
 =?us-ascii?Q?MwtqwxFzIyX/avgztc8js6Qq76fghmTi7qa129BkgJKh1RzQ+gCRBFBTXt1Q?=
 =?us-ascii?Q?21+gwmQ9u4+wPBdOLlqUsyH/oBL+mjY3OTEz56ZYXK3WM2H8OAV6qFxvCykz?=
 =?us-ascii?Q?JO5Ftbm/jVuVpSiHNMKMR53al+rDBKcQy6qxNxdKHeE0LwnMwx1KzulSSRLD?=
 =?us-ascii?Q?CmuJsiSExCIMn7uMW4Ax6zkn2aWKoDn7G+4Xyl0W/lwzdGZqRwA7dhfm8v5b?=
 =?us-ascii?Q?sDEXk3GviWYMDYJoobG5sxF1eK/drwHBCMio7mYJ6eR7XM8jLL9+opkZG8RT?=
 =?us-ascii?Q?lXp/ekR+w14gnzMkE8AJxgg/YVmLPyNV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJ8A1InAt8oSPd7Vt0vbHE59ibdmRBiIFpx1YiRIHa8PoXdqHqU6SDr7mjlC?=
 =?us-ascii?Q?LPjDy3O1VuBmY0+3wnPk8yDmIF38iyuUIYlLEYhoBeCSRZXOfXAPBMnL+5TC?=
 =?us-ascii?Q?X7bXkMqTy/tPoQ+W8jPTyq1iwWtjwCK4xt0udB7OA9LKUils8RVuAglarEFL?=
 =?us-ascii?Q?Zyuk53nBO9kWryUUTllKeD504lP0uu0FgJtjceIUHrRfLrYYqdpf9SVUSfKP?=
 =?us-ascii?Q?70bjKXtaQ2KeKEH78x6k8ozA+R0rweWkFP2Mst+RHibo8wXJ4L4SV9BhWL3A?=
 =?us-ascii?Q?o07Z+MSk3VQHQdJY8ZsKVQpykzheAs77LXGbXfIRcTFXdwvFFpQ1x0kRKn+d?=
 =?us-ascii?Q?2f9Macj2rZF+jfwoWGWKAV7WfrYsxhaC7lbz2MsfN1CGxoTxSp4JM6aLLyrm?=
 =?us-ascii?Q?erQ3eGYsOMqtKsbjaKLcrNmLLJhxezt9tadHqKYA5MblB2rXvTGsJUKb+uHJ?=
 =?us-ascii?Q?ypf2y2stUD8b6Qvlt1KeJOPeEw+mnu191uaWbJNJ1r0xQ8TAc3anihFc30m1?=
 =?us-ascii?Q?35ITfecI+vijnAknyHZJKoQmZ6IVDWs6DPRMEJ/CB7OGZkdlFT/Y6ITZzBBj?=
 =?us-ascii?Q?Jg7nL4oxLpGiMojq0o2oQhnG7wFXrfjBZV1XgbJPrM65CUZKgW2+2315oOWF?=
 =?us-ascii?Q?Qu6/8gYLRRB6Q5G4LLC3CbrYD3k8A9ULzzIlTKac6TBig9y3SR2tDZCgle3w?=
 =?us-ascii?Q?E1FurduUpk1mRQraOdZgSHR8cH8zytrVsCiib5+nqx6z2W97+w+lpdAynblK?=
 =?us-ascii?Q?c48MQGveUjajML9MpsjOiZhzQRIJIgiZvx3POIxEX6mi5e7GZU1dD/Stm6I4?=
 =?us-ascii?Q?FxL4iRNCBBzXAQ2M5FAzeNb1v193ZbKf9ukl/EKGP8BmmRrxZTfoaFQ7wmp5?=
 =?us-ascii?Q?tVmLBYU0WMgyQwgQ7kmztwy48lR4N5Zz/QX/5Ok6kFHTSH5j0gyRFwzd8ES5?=
 =?us-ascii?Q?D7GziY1XQRncgB1UuDSr88bLiAxF54cIYDhhANm2sOELeoOVXvrg3A3UbcBb?=
 =?us-ascii?Q?peVL9Fw8DlCBWPqPJcSlaiW10w1v+V+eum4prpWAgtaw4pPuncT6kJgG5DTO?=
 =?us-ascii?Q?Q5LNZHHxz6DSaFQ9MJXrHXPTIGXDHXXfHIOrlzwlJmXaTiukkA/zgUC7ixAM?=
 =?us-ascii?Q?ep+d9re5h5rq5H4tIPvL9Dkvj1HKt7WkarU4I7l70fCOo+nRXWNKHrYq2tTQ?=
 =?us-ascii?Q?hdpE+4elQxQvJYOCSdVKjzIPlpIUPcBCDK3/XYWuodoqTrMOn39h1oAzAbdV?=
 =?us-ascii?Q?rhWiWbKgt8IS00aydHT3dk0+9w072jZ88DZB/BT7Ybw3yuap7b56tL4oUNDV?=
 =?us-ascii?Q?zi9lTNLVtPcPpmqxz3rmsTG/OkzyIN3at/ReFqI2GzGMltP1DseHFlSnQMFJ?=
 =?us-ascii?Q?dOqsBiu59YjeeFZs7RkeqRA5r84VbsGFHueoVLnisEAqAuDzDBXhA6C0jGl+?=
 =?us-ascii?Q?PgkcLl+diYVNGv5zKCc9uemYFEd10FCXA2/jYS3jRx1NCvt+k9pnzJ10y9pH?=
 =?us-ascii?Q?71ziEfbDFYRooXcqB4w4Yzj6Xvv2NLNW+LBQss4/uiOp2Z6/U8xlO3vMIJMF?=
 =?us-ascii?Q?4wS+8qeG3otTtVgC0ndE0tA3Le9VF2JCRYL21vXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cefc68-d230-4ebe-ef11-08de1185560e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:09:10.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtrC2Q+oeAU8SNH2mLsgv+ri520h4d7KUet1rmfWSvb8zTEFHhHHGNM3VcFebnq0L6KlO+pwxAS+8WapYbF21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

On Wed, Oct 22, 2025 at 05:38:31PM +0200, Michal Pecio wrote:
> On Wed, 22 Oct 2025 09:39:01 -0400, Yazen Ghannam wrote:
> > Can you please share the full output from dmesg and lspci?
> > 
> > Also, can you please share the raw CPUID output (cpuid -r)?
> 
> Not sure which "cpuid" software you mean?

Many distros package a "cpuid" user space app that will print and decode
the x86 CPUID feature bits.

> 
> As for lspci, obviously a single northbridge, no surprises.
> 
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] RS880 Host Bridge
> 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780 PCI to PCI bridge (ext gfx port 0)
> 00:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 1)
> 00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 3)
> 00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 4)
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 41)
> 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) (rev 40)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
> 00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (rev 40)
> 00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
> 00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
> 00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor HyperTransport Configuration
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Address Map
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Miscellaneous Control
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h Processor Link Control
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
> 02:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03)
> 03:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6315 Series Firewire Controller
> 04:00.0 IDE interface: VIA Technologies, Inc. VT6415 PATA IDE Host Controller
> 05:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 10)

Yep, looks good.

> 
> And dmesg from a working 6.12 kernel. I cut it at "run init".
> 
> [    0.000000] Linux version 6.12.31 (test@localhost) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #3 SMP PREEMPT Mon Jun  2 00:01:52 CEST 2025
[...]
> [    0.072051] CPU topo: Max. logical packages:   2
> [    0.072052] CPU topo: Max. logical dies:       2
> [    0.072052] CPU topo: Max. dies per package:   1
> [    0.072057] CPU topo: Max. threads per core:   1
> [    0.072058] CPU topo: Num. cores per package:     4
> [    0.072059] CPU topo: Num. threads per package:   4
> [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs

As you mentioned, the kernel topology init thinks there are 2 logical
packages. There's probably a corner-case or quirk that needs to be
addressed for these older systems. 

We should figure this out, and the CPUID data will help with that.

If there's no clear fix, then we can go back to counting AMD nodes by
searching PCI space.

Thanks,
Yazen

