Return-Path: <linux-pci+bounces-39166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57595C02528
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D007D4E20B6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FE28314A;
	Thu, 23 Oct 2025 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMxXg/SK"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2EA278761;
	Thu, 23 Oct 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235760; cv=fail; b=iysg9T6zZ6/IZzzWJi+7BWAk3VR/P3s2SYdkYvSXnKVloxyC6oO+iWB9G0zwThgsDjuxMvMMsK3DIVclqI+/1jYJAvMlVyDproOJbcmMMK3OkyUH8kcxCjiMADFTfUTYhEjLFuaneKJ0xsbneTrBHZsTUgFiCpNvZmq6RJdCPjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235760; c=relaxed/simple;
	bh=WsD7oaMxb4ea52kgZ7kPp0wKQVAXQhhJnKjhwtnVmkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hep8XiAYCeiJrHr3roE0tYDCZQMl5Q/TkXpdUO93xRoKc6UME4u6VoMLL2IDylS3oPl2vrVt7Zkt7B5MTCrz3+8tdq1BFnMJumlVaxqfvTxpOFrqm1RHJCpY1heyYM5j7xgeNhndsCW2FRVHxAHD0FiKYJTlNwDlzUa15JC72WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qMxXg/SK; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCrkGZwNMBWlvRX6M4wqn3L6Yx2PqtLPzpNouyMVqjiB+zHvG6U8I2A1LBdiM8mXDjGWMEQbK7pcNjG0vJue9R5s10UOkkJQNFf182WYAZEyxauv7RDDZOENbZP6ADa71XDb7Z4tYKVS4p4pynPZc/9tzFnOGWUYA5orFe5z+U4JLyxN4v/ZC+FkrDC1Awk1qHs0U15G9zJZRkAXaBUJrMGxp5Vp4hXRPdVhX9+0bKLikHcZj3MnLuIXvON4HqP8XNXL4rFjsUEeyOwFKICMtol7A7y/a1ZF+KzHiZS4R2foIrKQcdAwrTmktB+R4TiEjxcKNsOJhhpHX24Oio5kaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udrxk/z2IjBAezu7mjTFOr2dv8Elrb0NCcgynU4j+mM=;
 b=f+l1lzosr8LXVYHL5pw0jvJomWVFvp6+sVUDpRkUdLRvxsa8P9mweooHiI32PdxNm9dsOAZnfKlLJkSZKaPlCyl4wIlPJehsxGENW+0rg5miZ1RR94KpCOwQFYxLbZMNX0MBrfX9tsFqMZb/l9ijbAl96N+qXScEvUGWLIazKpdjLoEVdUVGPkrRa69M/Dqf6xyThOA0N1iV+9G9ghOBNxpq3R5vk4AEDtgdp0EjnaBjEYiWmcayOgSkL2GTQEB8muNLbFKGHOfZcaZMeYTbiYc9oHvHXpgbyBkz5sbP18T0iJHIGkwUeranqmtCI9vcdygwheRLpNRmUkGAuhw/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udrxk/z2IjBAezu7mjTFOr2dv8Elrb0NCcgynU4j+mM=;
 b=qMxXg/SKCDtTnVR7cOSbdQl1/PPmeHpDp0Zli0kLnnO6CC0l4y5SVViQVSbmsFI+jCBkKc0jLSE4MUtH7rz0NRP9MH0fvOVvORrDkr2xJ95g2K2Qmm3o3ukThgR7UQ4tOITkN60aqfd7UEwpFdiwpFHiwcn00niviWrnA6he58c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Thu, 23 Oct 2025 16:09:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:09:16 +0000
Date: Thu, 23 Oct 2025 12:09:06 -0400
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
Message-ID: <20251023160906.GA730672@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
 <20251022011610.60d0ba6e.michal.pecio@gmail.com>
 <20251022133901.GB7243@yaz-khff2.amd.com>
 <20251022173831.671843f4.michal.pecio@gmail.com>
 <20251022160904.GA174761@yaz-khff2.amd.com>
 <20251022181856.0e3cfc92.michal.pecio@gmail.com>
 <20251023135935.GA619807@yaz-khff2.amd.com>
 <20251023170107.0cc70bad.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023170107.0cc70bad.michal.pecio@gmail.com>
X-ClientProxiedBy: BN1PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:e1::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: b4457f6b-dd94-43a3-094d-08de124e83d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxenqRFkU3E3Y84+hFlCV1gbCgS/xSe75ft2TSEz3WaMeH1+CYHzxub5gK0Z?=
 =?us-ascii?Q?Tb0LLDeKJP+Q/I47OvEwGEBZLOwHSP2oo7O0032vt1PK39+Q6Q3ZOIhJnPps?=
 =?us-ascii?Q?FYRFusc/yiaXxd60mQnrpeXNK9fKYpPV053iBfPX+UzaNPrKnmoVxdHomJIT?=
 =?us-ascii?Q?YSAJNv/Hzeq6bYF0o92XR4Jx0MGAEK6qIly5vFQsCEQP1veT/LcDNkHxXt7t?=
 =?us-ascii?Q?Qd70qF88vpeSCUA1Ywurm1DWoWqlaBYTjmcIkjgug/p5L58xC1Ecj/m4RSS5?=
 =?us-ascii?Q?mkKePbUt2xNXdgV6WENMQ+3BlaOt87supumWysfn9qknEbtjOg6jDvt3oStA?=
 =?us-ascii?Q?SYA1xPmstD7oB0jBWRsYfAJBu3kkCL/AOK/1VhWfUXTVRQ4GxdkczxxEgNDC?=
 =?us-ascii?Q?FJ1Ttvr4HFUTqqLkQ+gd59e0wX2P3QRXdf1Hqo8TA4QZ2F0k0pET8clIUfaI?=
 =?us-ascii?Q?+TN1iV9nulrQK/b92iz/5MYXyrY4GRMG+umnaSQQwkwd32PUwNtgf49wkTIi?=
 =?us-ascii?Q?RslvBFp7JnZHCmq2W9Dry5q4B2693faI5tFpGs9se7F2OCxyyX0cPktRZRd9?=
 =?us-ascii?Q?gx3foGJG+/Z2hBxueC9ljBtLhdP3+PTGZbgtSvJnfjN611ejLYg/54AOu0la?=
 =?us-ascii?Q?pBXpA6LtnwYT5soxapJOx7YIdNxe5j15WNyRghVj45CPVDDZGZakT2YToEud?=
 =?us-ascii?Q?asvmEhk893GSSqXr2ZuLKRUCiUMsk31GacatdM2b3uhp6zCeDnxc9TwVXm6W?=
 =?us-ascii?Q?4jfi/L8CSnEJIfwDOlxdZV+Xv+if86wR/7TmVjRqAdQ5q8dlZVHuM8ZuoYfa?=
 =?us-ascii?Q?6jRMkDjolfyiNsdeF1hu2bh/8xNI7y2icXoxw8Y+gFHH76Rv3Ec3fX53Kq+Q?=
 =?us-ascii?Q?zLFpujri3z+RU785yaiiEiCSNCHWkyFra5WwveN1Efh2ZOuNgWXqGHJR01dw?=
 =?us-ascii?Q?2z7lxipiUhpTi8uvPCE/xLBs94HIFSm07Ytz+eiYkCRAta3h5dl2jU5eaHI2?=
 =?us-ascii?Q?wZvLzWWwzHxdc6woyJcWdLlvI+kXRdYhkde+JMtusWhgPieW8VGLJGvy3aaO?=
 =?us-ascii?Q?HI7gP8M7ncCZgJgMu8dIohr4FpQnJISfW24ctTjofDSqmlnRuLkWtc9cAdPP?=
 =?us-ascii?Q?ZMt+9mbbkT41R3QFKLUXpOGWklzfnOvt3eKd8u22clw8vWUZXudwHzpGnqox?=
 =?us-ascii?Q?MjhuUlMt13flvDNX5UKFAjG6Ob8HVbIDbfyfr3vLnqeTuZydiqhf89tzeAsn?=
 =?us-ascii?Q?1DNUsjvem4A/uWs/p/3McGWFKN2jsoqzBuXCI76XzEq2dRJkm3rAkj9zI0lY?=
 =?us-ascii?Q?3pqoaxtdxYpT56O8IuQycYQq7BwhP3yqk7w4JDhX/oqGTn9VjYv5jGmrtfoU?=
 =?us-ascii?Q?/QEiVlNVVU9mJ4WPpe8prxF2vFnnuCvc/YNRoLioNCkwzymGdzGmg32K2cPE?=
 =?us-ascii?Q?Q9FHpVJo6TMXNxtWKqTjNJVgs+jIyZKQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ruyWjEoHSg3GdxuuYeAYf/bNhzNseXUG3yS4PScwchMKma+JLJYsMve9KXy?=
 =?us-ascii?Q?Tz/gi4iwHNwXb6S3/yUGOUfJn1jtffXJqidumJopNB2kl1LNcJLbPnQnvgII?=
 =?us-ascii?Q?dO6F0G8fb62VwPZZ9W7pFz+0g12i7FUUZs5uroWnYOQyAhBma+2n8QS4TzIQ?=
 =?us-ascii?Q?e2h5sfhj9PJuZT7Rm+x21STbazqKHQXxLLJ2GbIU9NFJBqkIqyugFp38xktF?=
 =?us-ascii?Q?XFs4fvflIYs88PogwEEA5W56GPlDx7wqc2FX1gFZv38Zt2mkl9YH4vSzAd/r?=
 =?us-ascii?Q?koI7QN2+fgGFNfcetfyAWe8FFX3fqcQ7f86Ti0XlJfyMEDvfeEuorSaXjD7e?=
 =?us-ascii?Q?h8OGapQLYhogmTEwvqhzGvS3iPt10CgFl2s5nE2vmFuj/MFZe1ebQ5WG5siG?=
 =?us-ascii?Q?eydky88fNu3L3jLs0XO6QWDDez4eAkFKeULWHXGs9rXC9Q0Ix6wCu1OxLJdz?=
 =?us-ascii?Q?8uKggJjHdnDSmuPS8Ev85kP6qv8bVlCX8QZf+Pe9vaJ8zu0Gyc3YzQOBXlSO?=
 =?us-ascii?Q?wHw8i4o73YLlhZ7XA+7DCGkQ4lpbj4jXvTAULUsZM3mv/ozxyOQYe4a3JxYb?=
 =?us-ascii?Q?D7UL57GzjSphmUDsGdMoiMFZI6oCi188DEgEpyy/MkZu5Ssx2ljxfo1rv2Xy?=
 =?us-ascii?Q?6Hi8j4l5hKB28xWxomAN8ZIZWoEwsrWLJwDCdut3njZFiuejNibJwoWEfdc/?=
 =?us-ascii?Q?OJZejMY2j1Yb4AM1c48AWoD/UjmM1P8YMTsAO8+Maq32RdXAkHXo6yvTCP4U?=
 =?us-ascii?Q?qdVMvbAY39vW/0gdBZ+yoEw2S4L0SPFWSWx0RaZ7xBW7qlEk9Hb1GYfO5NCt?=
 =?us-ascii?Q?OORAiUoNjpJR4ZupWWtL5UFM/gt7zsEvxoB2CmMnoyJAgP5p24eSp3j30OaH?=
 =?us-ascii?Q?+gfb4R1wEUDI9ZaORLVsmLNm1nelhUZHvY13WyGLE+3HIQHe+awWy7Wox55n?=
 =?us-ascii?Q?be/91ZNOEJg0SLOCNrHQrOsSivd5wCZr0NR8D3fxuNOdFfFz1Rwy063W4H1v?=
 =?us-ascii?Q?PaHFbCXir35sEhR5TCnZImgCuAmZr1HhvcGubuIfJ9EA1knh0aOZTLywH6XN?=
 =?us-ascii?Q?Vd9/qgD7fn5HVqXKTWggilbLcwYpLdKmIbVBS/fnQa/ZsDXtdiz8HPe6b3fO?=
 =?us-ascii?Q?gLLnoGiv1/MMVscIgLgWvo9LQVRV6Y2ceqEMxlxcg6pnUok0b9/gSTwMuIaV?=
 =?us-ascii?Q?QejmVTGlSwp24gMCQdD5+AAZqyMRgCWqjm6u6DEbtdfotjfNeOlF75gt3bta?=
 =?us-ascii?Q?HAoZYd4napYDuCJ4zNM7mVDlV3hmveyFSekm4QIQe/WDcBMalbDmSMWwJNwn?=
 =?us-ascii?Q?/5eiH7X1rhxbQb64s7elAdMQjniaNU8fpgVoAEjBYN6yaLkDMWOyt/JzHFCS?=
 =?us-ascii?Q?Cnta465ASQ5NTK4vHCUTla5ntNZt+jcoN0lXgt3XbRb+8yJPlw/7QE/ja5A7?=
 =?us-ascii?Q?3JjxXTjBhtrAcIppGM+iGhmvMKsFBbhevTh3jd2XJLo/YaZXvD2o5RQoiB11?=
 =?us-ascii?Q?c1DjA8xgnhAjWap8JicPYFECLCbxMZZdUw1e50w3rktbUuHfS2PXusKU+ei5?=
 =?us-ascii?Q?2X15Bwh4P0T2Pr84Az/FMJRpw0WWLiDks4qrRNCK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4457f6b-dd94-43a3-094d-08de124e83d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:09:16.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmLPJ5iUFZ8TF7clUIwRd8qvsJ5vuLY9OENqhORX2Tyg2G/eQTL3lJTJXeP0iYz1rKBt84yJ7GAnbLcbWY8JDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

On Thu, Oct 23, 2025 at 05:01:07PM +0200, Michal Pecio wrote:
> On Thu, 23 Oct 2025 09:59:35 -0400, Yazen Ghannam wrote:
> > Thanks Michal.
> > 
> > I don't see anything obviously wrong.
> 
> Which code is responsible for setting up those bitmaps which
> are counted by topology_init_possible_cpus()?
> 
> I guess I could add some printks there and reboot.
> 

The kernel seems to think there are 6 CPUs on your system:

[    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs

We don't seem them enabled, but they may still get APIC IDs. If so, then
the IDs would be beyond the core shift of 2.

APIC IDs b'0 00 -> CPU0 on logical package 0
	 b'0 01 -> CPU1 on logical package 0
	 b'0 10 -> CPU2 on logical package 0
	 b'0 11 -> CPU3 on logical package 0
	 b'1 00 -> CPU0 on logical package 1
	 b'1 01 -> CPU1 on logical package 1


Please try booting with "possible_cpus=4".

The "number of possible CPUs" comes from the ACPI Multiple APIC
Description Table (MADT). This has the signature "APIC".

Can you please provide the disassembly of this table?

You can use the following commands:
1) Dump the ACPI tables to binaries:	"sudo acpidump -b"
2) Disassemble the APIC table:		"iasl -d apic.dat"

Both commands are part of the "acpica-tools" package.

[...]
> 
> BTW, I forgot to mention that I have a second seemingly identical
> board with same BIOS running Phenom X6 1090T. It is not affected.
> Not sure if this is helpful. I haven't tried swapping CPUs.

Can you please share the dmesg output from that system? And the ACPI
table too?

If the BIOS is the same, then I wonder if they hardcoded 6 CPUs in the
MADT then mark the extras as "not enabled" on parts with lower cores.

Thanks,
Yazen

