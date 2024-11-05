Return-Path: <linux-pci+bounces-16049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F019BCFEE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A051F23600
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A31D968D;
	Tue,  5 Nov 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P64YaKK3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214C1D9669;
	Tue,  5 Nov 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818770; cv=fail; b=O8sQIYfXQYq5N++8F5yPlTLQC5HjoBoxggUDkRKBeBV04g0vOE712sbQM4kzrUj9s3wgrR4zVVc2HXLHFQRmxDTMFCCsIvtzWr5ALbA+AFxZs/3erH1vXZUT7fWp385KjdHVpUWMXiM08nhkUIh2YhqTeZqVkGhwiNS0XnGAnTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818770; c=relaxed/simple;
	bh=DozEQXjISEf4qUIS1VuhI+Qcb6B1PAxbQfnh8V9RU2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtEps10ay05QDRPi2UkOeiU6Z3TDWk22M5J+/khD8apjTzLWtB8/dqp+GN8b/PQtlcIHEmWrhh6SIPS9kpwc1uzmh3upI3nWbV3ZOcZhlI7rlZiyCzIzwBBgT4SItSAbv3AryOjlU6tuG6gB/IgU4sQfywsCUMu0zkP4D1fV3dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P64YaKK3; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZm+KaURDIux2qnXYO1uUyjyiNq4qQFaIZUynRXlq9vJTJNhrqNOxxF3EDjze1rz9dtR49Ycpb3uUFpc2dMmt9HfBRL92MlXIxwxzCjEd+JSGW/41B4iE+sbJOmGDU16XnL+Zp0wGGhD3fpt+71e0uACR8CmBvogjdbl7Zg07//x5oig8nIGQG9gbdyX90gPyDvnOgNu4Riaeo9BM3q9jiNq0FbsyCMsGTN6bo9j70wvZyDNwXYnlrYp8MupXQltSF3Gc55YbKNbGX/xa/WsFXLHBhApkJlP571RJaYDgnI0rGwjpjhUIn74/ht0QQTMykDS8nqnSH+9iMT7URg/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EDniKeOF8kiVDeNZ73n6lz2BvonZ/opuGTa6ETxfvI=;
 b=GXjtY2vLasxQb7AhF1HvrkWZfrpjP4nkuI1ex72CrFup85W8ZAjlixeDw8YeiZrHYbHujO/pu/CZNSwHFAmTLDbnV6ylMeMuFpR7wpDKw8Tr0SGj7HwBTj9KlllaKciowhK0LEjHM5YmonSQZF/MSuX8ZD9gUSOYjPTP5coHIyqZoCTjeZVtCgacRJ/ANrEsjoicb27QEv1UVUj/SrsRzG9xAIkWrLyXaw7j7NZTkbJvP6QlHzMjAj2IEeakX17oBAjxyV0VBmbal6re+A+DpFrX7KU2mUu473n/dVpyujXLyPBI5iDBFS59mudhLIGfweNDB7bPSMZaOegpnIC+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EDniKeOF8kiVDeNZ73n6lz2BvonZ/opuGTa6ETxfvI=;
 b=P64YaKK3Y5vBAaKUVlxn/xbMZ44YWp+cczcx3m5UlV7ZzNg8dYSAgSgMSsTPci8oZg1S4lUAwXzyr7h+fe4CEn1v2LP8JULOW0OWcHA6UZkQPg2y0MD89LIg2WdGXqn1q61r9CO6WkE/AA6sO8VFQrYbiknLf5YeOke/DnD7P2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Tue, 5 Nov 2024 14:59:25 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 14:59:25 +0000
Date: Tue, 5 Nov 2024 09:59:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 11/16] x86/amd_smn: Fixup __amd_smn_rw()
Message-ID: <20241105145920.GD916505@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-12-yazen.ghannam@amd.com>
 <20241104143212.GWZyja7AqB07hVa__h@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104143212.GWZyja7AqB07hVa__h@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: a316875b-281e-4092-0626-08dcfdaa7077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pNC+wH/I306bpD3ayMqg4/G9awuW0a3ORzgn5YyYYu/D/BMeAwqbXc+exOYO?=
 =?us-ascii?Q?VFVCqrvdaApwbFerr+jKsBXbA7ZU+7C++d7rqBqZ1MVMAc5HrgJQj3xi8ZRG?=
 =?us-ascii?Q?gjAFUAYvS2uS4Riu27v26knlpNHTzcusdmcZaLAlUu5WYjDiiZ0o038GzwEC?=
 =?us-ascii?Q?4eZy91Cz59rrBIiV118yk12aUbJmRoRsBcGioWKrGJ4aazswiDq969JsHd3t?=
 =?us-ascii?Q?wjYqisxhtGjc+MDDDR9gq2KPubEYgUApXXfJfC25FAWODhRNMa1JGQUaBI0r?=
 =?us-ascii?Q?0jt+qe8BKmluM9UJM7Yiq3wsYKGrednGZA5qevCPtndIkrEPdipB4hrivaiC?=
 =?us-ascii?Q?tR8w/HQeGuyVj7OunFLQaOI+3tFp/fMiU33NDP3wBCTitj+C2i8wwi3kZBh0?=
 =?us-ascii?Q?81yYjdU7iU2j5Z2wzcL+Bo1ulKWj4ECy1JwctlUdmVpELxKNaQwhXdEIdL/f?=
 =?us-ascii?Q?af90y4QjouFwrIQkQ+25KC/kasN0HEGkdv0sHjBzBzLTz2ZWRhtXz0gj7Qc4?=
 =?us-ascii?Q?25mGiWl80ByXKa0EGW1v1Y/YCwXdicGt8qWkKbr5fPYfPfNn/tBoAFKZ7mPD?=
 =?us-ascii?Q?OYtHNtw6Qmd3hN+ml80fnatR2w+yjT1UGuanv4uUrvlMBnCqQ2li2rFwqees?=
 =?us-ascii?Q?7YAOMEaLvvpn1NvYQ5+r3OxJVPNvyIjGEQSCQwfczMZG93rM6QHTCOEz7joU?=
 =?us-ascii?Q?SoSM4j9B3OvuTgDSHh54KvusoJk/d0BogwscmMldDoopLFA97Ko35JvCNOmA?=
 =?us-ascii?Q?8ZQvFVnrJHV1O3R0BOZFHGOznctZUOr8r5lOGznBSirx6vGGikkf6M7B3Mmv?=
 =?us-ascii?Q?lWKWZa7q4JGQvEfIcThjuc7DbNajetLSIqSxGEn92B+ARlDEhzgnBLJ/d1I+?=
 =?us-ascii?Q?LCXclue+z9DyG0EIaPwTpLZCPmdZTu4mGldUeyslwhNEG+QtXD37VAuZYa9S?=
 =?us-ascii?Q?m2+RZavQ+hFeKHpJNoaATdxi3okLJSrmzul64SvbLYvC93kLLstGbAkL3nTt?=
 =?us-ascii?Q?2KAFH0CevkRnRygwhj13uGIJRQFmDVK3MUbdXAwXdvG7euBJigol+nEZ3u63?=
 =?us-ascii?Q?7pPUzG2qL4zio82YzcU9Fg058T1uJ50d+BYfxBczenTnzgJg20M7RqBsTCzf?=
 =?us-ascii?Q?nbw39FMPzpC0nF+rAxQHu0cC1nDaAL6zW3E3Jacs0ISRFTQnerxep5c9AnFJ?=
 =?us-ascii?Q?tHG0FRTKktnjDNcLCxzlwqyhp5/BVjPbuUCW1hYa3zcOjOZs0n3m4nKsLFTl?=
 =?us-ascii?Q?6Df36EMc1C98gnsDCMAHY75ZmIjZnfHUGDQE5D81Vzw2aZKlE3biW4j6ZBKF?=
 =?us-ascii?Q?hGUD3Ce4s2XXbnEzialF/vgj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTKFqf5qBVUUQJhKbu+iqc3AWjyksO4z6UHB6q4a9t8AiCcBMxRBNwrbX1Pj?=
 =?us-ascii?Q?ETDQGZn29/neJ/vk/suj+6xkEkA3fxMJ1zOg/n+dJ1OWb/ShkE2qVbC8i72g?=
 =?us-ascii?Q?v7aE+QB+Kq0g6Yq+tS3KWIMy2RpEe06fcAze2T9YCr0RT+PDDR+rmrTTCiZ7?=
 =?us-ascii?Q?yrWa/vMQxlVSxyx+8p3loxO3cYdxtwmx8un8F6HxsQboJor1uUAchZ/IgWJY?=
 =?us-ascii?Q?cuYJnWRVcFKl9c6nlemy6C82AEkPvCrTMuRSvN/B6Z9lWHjLDsCxYjR/X3Wx?=
 =?us-ascii?Q?5FpP9wTRYS/AJUDnhZhfqQRv3Fa5Me0j/Gwcuze/SkbH/rvOEB2ugS0uC3qi?=
 =?us-ascii?Q?iwQtfyno2A4B2X1pE7lnrKoTxyA8ZIKvfiS0N+ayAy1mV+aa/t3fD+eXstmn?=
 =?us-ascii?Q?OIHdDJpvPEt9HvdEa+WL4kx6cpRO0VWJm4E5xRbA93u/HB4KSZQ7fX6U3L6q?=
 =?us-ascii?Q?cprnQ9Ojh37UyWkso/86NQKQRzSsV2wbhLzlCu9+417LTdJU40uhHXvB4jGB?=
 =?us-ascii?Q?nPirlT+zB8qbdaWaMNNuA+qXpeKIDaP5M8rjb9iSl6IYwKb8iIafXK9JXgO/?=
 =?us-ascii?Q?APZJfiaSa7BHYjqn5mj4paAdVRg8jcyLMVSg0rR8944H9XBWtSqJ/80Pitps?=
 =?us-ascii?Q?NTcGsBqWKCwxM+VPnKoc0qWVAL1eazNrybdmNU3ox9zUAmsHyRRUobH+b58P?=
 =?us-ascii?Q?vjpWn+4QSVIuLf/IBeYM5ywr5m/T+n/uBLlK6VHs2rHdOsAHZxhKGGAzXRXY?=
 =?us-ascii?Q?PS98I5akDo1sbVHOUu7KkLZxjD97lBjYiuZAiZdSPQV6V+iD8v+mja7Tz/04?=
 =?us-ascii?Q?jL8lAojXHK3gl56dOY602V4QewxdpzouZp19vGLSu3akPE1+BRyVe2hF0e8i?=
 =?us-ascii?Q?sZTrxKqX7V0a/ldhgY2sHRbX2HIRtLJ2RWzbPAbfRjqjt0+7l3YhHf5Xhdie?=
 =?us-ascii?Q?SFxylvBAHcShA6wwmW7vd4Vy93K1Pl9PWDKMDjkQWMW82yGt7LxTknhm9cQG?=
 =?us-ascii?Q?29Yj91LCK/QSObGD0IyzySpHkZi/I1txTv7TH01gc7ZA3nxBII6xOnrR43+M?=
 =?us-ascii?Q?zMmY6ljbnbYCP+OSNgcaP3CifxhkiPCSGKDeZaevw9zea326FJ62Z+hkHVwf?=
 =?us-ascii?Q?NrQyLb/sqjkAsmnWt+j57I+Y+f9mzKJY2iORhncRoO8DXFxSG01NG5n1xtO+?=
 =?us-ascii?Q?xRULmE8Qainl4Tt6I9Nsrc+L/d+WBxSIU0FvzVvWYSpS2KIMRX5BNp/p6sQV?=
 =?us-ascii?Q?ArBVLrYA+8FjPQ4P0CGql0bWaN2DviOVauQUFuMo5oCQCLRMveROG/o36dMp?=
 =?us-ascii?Q?08PXNV9V+5GNiHjKFCrMS6iu+CE/UC/znforyYHv1ho56InkofMh9vzBe1iR?=
 =?us-ascii?Q?o3BpRZowlHC+FB5cDnKeSGymYX+i5vg3CQExz3Vs0oKFPCS9xF6u6y1glkKC?=
 =?us-ascii?Q?tJQgJUe6MWEH4AihoJ2vTpaIRTbIQV1nEU4jSgDctEF8K49ydWXIeT7Aa1OK?=
 =?us-ascii?Q?vV0RCc/60v/rEdTlyA4dnHzBsZQ36Z0L1J8xews0nhGYyq1HLhOphEWOF1nO?=
 =?us-ascii?Q?5vEPhCZRwGzY40t/UZZh9orc4PQNXMH5RwLAHAZ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a316875b-281e-4092-0626-08dcfdaa7077
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:59:25.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njj88dnMx1cKNQN3r7l2IpVIDf5PSIRoJUUrTKamC0cn3sPNAspgtZNTgsE2N0zX1/83yh0zk8uebPd7KOa7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

On Mon, Nov 04, 2024 at 03:32:12PM +0100, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 05:21:45PM +0000, Yazen Ghannam wrote:
> > Subject: Re: [PATCH 11/16] x86/amd_smn: Fixup __amd_smn_rw()
> 
> Needs a more descriptive title...
>

Okay, will update it.

Thanks,
Yazen

