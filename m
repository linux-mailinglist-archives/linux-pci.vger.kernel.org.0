Return-Path: <linux-pci+bounces-39527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F926C14AD4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8674D4EB26D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245330EF8E;
	Tue, 28 Oct 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KITFs+Ig"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azhn15010016.outbound.protection.outlook.com [52.102.138.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F032E88A7;
	Tue, 28 Oct 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.138.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655433; cv=fail; b=gpchXXjoZtZE/LxdUP/AQXa0rClt90XRSmZjM/rNhs2R6QiRMgLBpLyHG2Nq2q+S+pm7fPghrnrVFZR9Cv+oRq8xGTub8XJ1HPQiln+7J3lRIRdOxsJmYUzJ4pCdrDJ12aIcmFMuX6+Y9sUJ2ZCEqFxv4PsaIYv9VtNyF1eGcuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655433; c=relaxed/simple;
	bh=6hejbgWPn6hcEKZALJNoSyjqTBU0shVVH6+Q8bAZ2PA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoHiDuJJ7jQ9GcKubLP5OClgZzjuLxNJUtn/80JEH/74sTsyMdiWZrcXP344DeDV9da3pUkXD1XUuNcS8yFCbUciki3S0qPvtqNY1qWup5w34N+oLe4FOymvrKVXh+FUKy1JbmB4W3e6gbyfH2zHljmbzcqS/vtJCt3nEW3t0V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KITFs+Ig; arc=fail smtp.client-ip=52.102.138.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYMX2PJFmT0gWzGNt+n8houPbpH7xgQCRxGvSp5T6Xfbipl6/UFQHApCpigml9xk4TY+km7XBfdO7T/A+UFE01IoNAgSKfu1jeO7LXOrvax6yjd51LOw4Sr+Ys05bHNTYAdtPdOEIVVyOkDvVQnu0Jf4KWdHanIaw+PHljEPuVq8UTl5zRApFTc6hqYg5uc61blDR4Wt9Ru3ywhe5lMbO2r7nO9/Y5YU3CKjVo9EOe29CJBckGF3E/Q0BFohnd0bX40okdmHKbP9fpUfLmp2W8OJkplDNrfQaKvOStDJqXNyfHlGqs/SVP1+pRuxxqQJyWyf2O9P4TjU/J+RGBd0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mXUqaEV5S6b/O0t0qBrRUWn9sswUt2El6JXMNsk/1U=;
 b=dk//N86dzzDz7OAn0URp+akfxyaiAI1wXCfu+Khl4U0OQcUl6kuDm2a+56RoarolE6WEXl7+OrCSDHWR9aiH3Sht3WKnj3fZY4BDKdULUkH2437vkNIyXb5x8xGZ3kLoe2XCZThqrfZCTParaKC7ZMR7eZZ9LsFI+8xyOBJI4FO8u9uEHV6+yG80qViACrHAr+ljiyJlpiQnfy8v+ipHpDyJTOL0IIyoFK7G9AtvkQzxakty/6LsH4kflxWcc/w2UtdBUPu/As2t2c5SuhoRZJcYT6yoFpzo5m9HcvdJ3oGXNUj6QNplV6dn/VW16iOQrkKg94BRdh4bzgp1gDQrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=fail (p=quarantine sp=none pct=100) action=quarantine
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mXUqaEV5S6b/O0t0qBrRUWn9sswUt2El6JXMNsk/1U=;
 b=KITFs+IgUljlCRJX3hL1OYrdZWLpu8o7ZJSzyw/dZmn01EdMmMx8/E/Ci9A177Xly0OXAqtR9FiyQWEgshA49hMmvWjXqhp37fkspvpd7S1EbBfZt9ux1SnyDfuHy36JAvwO66uymBOHd5S9SClvcd5idVl6lvCHtsnR9GbpIqM=
Received: from BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::8)
 by CH3PR10MB7987.namprd10.prod.outlook.com (2603:10b6:610:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 12:43:46 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::d9) by BN9P222CA0003.outlook.office365.com
 (2603:10b6:408:10c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 12:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=quarantine header.from=ti.com;
Received-SPF: Fail (protection.outlook.com: domain of ti.com does not
 designate 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com;
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 12:43:43 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 07:43:40 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 07:43:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 07:43:39 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SChZUo2338171;
	Tue, 28 Oct 2025 07:43:35 -0500
Message-ID: <eed524b60b43bf22e88c40dd770a6b0bc38c44b9.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Enable support for applying lane
 equalization presets
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: kernel test robot <lkp@intel.com>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <unicorn_wang@outlook.com>, <kishon@kernel.org>,
	<18255117159@163.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 28 Oct 2025 18:13:46 +0530
In-Reply-To: <20251028114746.GA1505797@bhelgaas>
References: <20251028114746.GA1505797@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH3PR10MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d05864e-73a8-4606-6a17-08de161fa155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|34070700014|32650700017|34020700016|34110700003|34140700187;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1h5L3lkSkNxeG1Lc0EweUNWMG51NExKNlJjQWxwTVdFSjJSb2NXTG9QMW5V?=
 =?utf-8?B?VS9Oc0l5MHA3eUpheFhBZmdDalJBZmFUWWpza1BlMDhnRmdCVHpjNjl4SFVz?=
 =?utf-8?B?eHcxelBKVHp3SXhKQUU0MkVXUVJ0alltSVRPd3VMWCtERldKWXdvWVhhTGg5?=
 =?utf-8?B?QWZPaUNsZ1prWlNjWmgvQVFZMWtMaVlNbU96WWkwMENYRThHSkgwSXRZWnJX?=
 =?utf-8?B?enVLWHI2eDFaUHJad1o3Tm9KOTFYV1orZlliUkliZFowTUZGaVJYdGYvNGlE?=
 =?utf-8?B?cGpIRlhpNVV5RktQUUdzNThhY1RBaVQvNDJFQjk4WmpFWEdqWitYMFVlVUtn?=
 =?utf-8?B?VzFVTkh1alR3UEg5TW5IYVk4aWtRUGJBcXBaVzR5cGFQRnpZQ2taalF1TWtz?=
 =?utf-8?B?QWQ4dVQ5SGlnTWIvVWEyNVNKU1JDZktheWN1VHFzNW8weDViWWVnSjQ0NEpv?=
 =?utf-8?B?K2NpU0VyeHdqdHQ2RzQ1WkVEVExUbndNY2E0Z2toSFRrZW9yTllJdFlJWndh?=
 =?utf-8?B?YVR6Y01jd3Mra01sSmwzYmJ0LzFKbDZYeDJ5b1FyZSs4RnUwTkUvMVJ0ZFZM?=
 =?utf-8?B?V0FKcnc2Ty9TT1QzWVhiSzBrYjVzV21lalZIZHUraTNlYWRmcXJUb2xSSU9E?=
 =?utf-8?B?WGhXTVh0YWdhanR2YVdoREd0N3JpYjNGQlFyR09Lc3BYRFJJREExVzgxbTZw?=
 =?utf-8?B?WTVQc2pjcGJMTXRpb3B3dk5zNGNuajl5VXdMaU1NemZvSjBHd0l5YVBFd2do?=
 =?utf-8?B?TzkrU3BKOGxVWTAwSU9LT3BaU3A1NkxuTEQ0dTd2blVIOHJkSnE0Qmw4Zkhp?=
 =?utf-8?B?N2FBMDR4SjZsR3lWV0tqNStBSmx4N1ZucVpkSUwwcEMyY0hlRlBKZGxwMXdZ?=
 =?utf-8?B?S3o1aXNPSkZwK1lWQnp5cEJkQzRMS2gzTTBGNERDOGVtWnJtT0hTOUF3bmRQ?=
 =?utf-8?B?RmhLeTBZUW5tOVVxYXcyM2hVZnZMVldCMGNuVDNuVTFGZDRKcWtEZEFEWXNP?=
 =?utf-8?B?OTN3OG0zSTUyMDFUeGE3d0VCUEtqT1FEQktpRUtJQXQyNmFNZ3J3OE8ycjlF?=
 =?utf-8?B?QytBUVJQd1dmZVliK0RXSFJoV2hnSHEwaGpjZ0kvdGR1TlRNS2tRWnVwRTVt?=
 =?utf-8?B?MDh1RUlyVU9zKzBPWVgvU1JWdjgrWVNIYXZ3Mjh3YTNublJKV1BKU25pd3hx?=
 =?utf-8?B?RmxEK0d4bWw5UTV2LzVMSGtFVVE0RnVHaFZUcVZQMGNnM3hPTDdyNlU5VkJp?=
 =?utf-8?B?TkhYQ0NmZDk1ZXVPeXYwTk90WjNQUFdvODc5Q1lTemRDVDg2SUozN0VmN285?=
 =?utf-8?B?ajQxMm9aaFQ5d2licWc5dVlBSEZUZlk3Y2R5OUZ6NzIwc1p6TTJ2cTkveSt0?=
 =?utf-8?B?VnpFLzlaM0NxY1h5SktMeUNzbEFiWnVWcHhySEVQTlBDdDU4Z3h6MjExYU4v?=
 =?utf-8?B?bTBwZHN3MkpyaUw3anl4aFAxZzdJN3A5MENjc1J2V1I0U0hsTEFTblcyNXNK?=
 =?utf-8?B?aDlXSFVPVEZBMEZ1QW1iNVpMZnBQRmI4VExFcUt2bCtMYXNEZmhRUFR4ZmM0?=
 =?utf-8?B?RjZ6cTVhU29sZlNqMmVCT1FiSVk5L3owZm0xUGgzUUFtYXBOSGZ6c3NDeWFn?=
 =?utf-8?B?WjNoUEJHRnBodFVBUFp0ZG5iQUdrZlNFM2RNa0pueUpCWlFZMWRBbzVYOUFB?=
 =?utf-8?B?SWw1WVFjTUN3djVDNmliTUdQTGkveGxmZDdsY0tNUmNUVzlvMzU4UjJuRmhZ?=
 =?utf-8?B?a2RDMFN1WEFjb1oyNGlyTG83bnBNN3BqMjMzODZOSUFiZW1qaHdTZ0h6RWxw?=
 =?utf-8?B?UFN0NzZuSkZ1akNaNi85TXNHOEZSbFY4dlAzc3R6NCtzLzJCdFJFRHE2bmd6?=
 =?utf-8?B?K1hxYWVST0huVFhTREx6alFacmp4UlphMVowUGdDOWQ1WjZ2amVBU3JoT2Ix?=
 =?utf-8?B?K21zMWNxK2pZRWtFcDg3OTRud1ZKSW5qdlI2VS9YRUM3ekROVXBleDlSYXFI?=
 =?utf-8?B?dmNwMnJESHh5eTlUQUZNY29RK3V6YUVLTHdFSG5XdG9pb3pyMUFHR0lFZ1d4?=
 =?utf-8?B?aHVsb0U3Tkw2cDRwTnhVZ0YxeE9JSDVaZGMyL01IUEw0cUpDRWZvRUhGdDl4?=
 =?utf-8?Q?freiw2XvymhWTve4Da0lDqVgu?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(34070700014)(32650700017)(34020700016)(34110700003)(34140700187);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:43:43.8642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d05864e-73a8-4606-6a17-08de161fa155
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7987

On Tue, 2025-10-28 at 06:47 -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Tue, Oct 28, 2025 at 10:56:33AM +0530, Siddharth Vadapalli wrote:
> > On Tue, 2025-10-28 at 13:16 +0800, kernel test robot wrote:
> > > Hi Siddharth,
> > >=20
> > > kernel test robot noticed the following build warnings:
> > >=20
> > > [auto build test WARNING on pci/next]
> > > [also build test WARNING on pci/for-linus linus/master v6.18-rc3 next=
-20251027]
> > > [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> > > And when submitting patch, we suggest to use '--base' as documented i=
n
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >=20
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vada=
palli/PCI-cadence-Enable-support-for-applying-lane-equalization-presets/202=
51027-213657
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git n=
ext
> > > patch link:    https://lore.kernel.org/r/20251027133013.2589119-1-s-v=
adapalli%40ti.com
> > > patch subject: [PATCH] PCI: cadence: Enable support for applying lane=
 equalization presets
> > > config: x86_64-buildonly-randconfig-002-20251028 (https://download.01=
.org/0day-ci/archive/20251028/202510281329.racaZPSI-lkp@intel.com/config)
> > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20251028/202510281329.racaZPSI-lkp@intel.com/reproduce)
> > >=20
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202510281329.racaZPSI=
-lkp@intel.com/
> > >=20
> > > All warnings (new ones prefixed by >>):
> > >=20
> > >    drivers/pci/controller/cadence/pcie-cadence-host.c: In function 'c=
dns_pcie_setup_lane_equalization_presets':
> > > > > drivers/pci/controller/cadence/pcie-cadence-host.c:205:20: warnin=
g: this statement may fall through [-Wimplicit-fallthrough=3D]
> > >      205 |                 if (presets_ngts[0] !=3D PCI_EQ_RESV) {
> > >          |                    ^
> > >    drivers/pci/controller/cadence/pcie-cadence-host.c:225:9: note: he=
re
> > >      225 |         case PCIE_SPEED_8_0GT:
> > >          |         ^~~~
> >=20
> > Fallthrough is intentional. The lane equalization presets are programme=
d
> > starting from the Max Supported Link speed and we fallthrough until we =
get
> > to 8.0 GT/s.
>=20
> It's poorly documented, but use "fallthrough" here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/deprecated.rst?id=3Dv6.17#n200

Thank you for pointing me to the documentation. I will update the patch
accordingly and post the v2 patch.

Regards,
Siddharth.

