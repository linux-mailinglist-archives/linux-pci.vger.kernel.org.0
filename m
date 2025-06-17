Return-Path: <linux-pci+bounces-29942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25185ADD3DD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A605D4045D6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88A2ED153;
	Tue, 17 Jun 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQM7VA1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65412EE5E1
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175590; cv=fail; b=fqM/x9d/UAve8qig9o5Llcx0dJEzThi5qGTFJdqhkcuWsqN7TABeNqWmEF6UVig7ixOUFEAk1JrAEy3aeyL0YDO7cBoexduksI7V3Es57HN76vgLcFBwkbXz+gSqFsRCD3vvevtEdkyuoPyM90Tfd3UMIBBCtzjyTwQKnS1M1yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175590; c=relaxed/simple;
	bh=xPXt4tzROjm6qlS719Jbc1gzLKM8ynmfFOL5L3UjjKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SdihyBUqVKc9Qy2jps46qJ4M/nwPcJr6snQYaG0fePX6c/f1NrQcLUnP+HorzyC4X56qL6k7kL3JI3fEoxwyZULjx+TvoPvmAnVzxhJLlGAtx8/X60SaFuBSVzW/exB9RX2dKRAYCIR2yi+a5BXNU1dBVhWKGgou5vpQQ06LheM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQM7VA1L; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNwcX5TZnn4QWnGjGoNHHI8mcU4J3CbDXzuYqd+R8Gi87Hqqkn+XqsFU6mt1n/+Uj0flfWf+33TSZD4On5MSW3SjEn44Po2u8wWGjKDWsnZjJFFUP28ToNXMIJ+q/WRQKVuz469Dx458nlSGMw2gUL9+oaq4ZK9FBR2mklptzkWLMc7NV9WFUEuhu2chFujfyGtup8K4OevKa/w/ZGVHYrKFcxVB6Gojt76BGgW+tlHTnUjmbDe01ijxxUfgL5fxMnDLQ9bc+0eDWhonjMCT+utk/7i/YpWpwzuIWyIJ7z8eKYR9RGhK+DkIBz8Xe4FCoMNXfOKJolxvMDx7bbn3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDPjq/zsrGVOq5o/bOCxa+SzyJJZLUnfDeRuTygIHO0=;
 b=EKoA9bSu0KjRpJzJK0BTLns2dZ7Eb/DjOV5H8SnT0Cgk6tRAXXhjSiHC9+5VOY2KPSwqi0ZcizaKljz4tb8+Vlzsg/1Mq7RnclQTuOYtuvSl4QtSmoTwt8c3kiT/vDtMf6JSWfl3ykaQJGyztxB4HBlDhNW17P+BVMjJsl1Ti1koro+jG6py4GoG7ksa1Mk5Xp4gOSnHocdVhJRnD/5K2NpG3US1coRw8u+TrIHu0DbBsJK2VAaMpMY5Rf8zhZsHyIZI4RuULKAvRmrZGauaiI0wcJeamNOPcZzssYFqbSzTiExwN5/g7i4VJN62+uD4SWQIc795Zmt0BEzGabrYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDPjq/zsrGVOq5o/bOCxa+SzyJJZLUnfDeRuTygIHO0=;
 b=MQM7VA1LA19IicUQXNsi8aDOsJMFv4D1LLnfkFplveIR7k0kIthDErDugCEmM8JyPFfU+ydD9XIfojMsgoYVptkCZrlqotck/i4YwAeezSTYMob5mQhfpK1vgoZlQskJTFHu8dwwHYDUKxDJO95emowg5EkqLiTXqI6M6OyI52/S/DbaqKM8RvhC/Y/yyv0WxKuguIMM0+R87vRJBlFGtwRkuELALkw92bR2szZdHKNlxPdaehiYV4wR3xt1vyojV86rs2XvmmsY+UxiCzP1z/K9UJRjMSZpq63rYkiTn5g6ZZT+NWKllOLMZ2A1aXiRMfKJ4OXo7j/MfAiy13qtGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 15:53:04 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%5]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 15:53:04 +0000
Date: Tue, 17 Jun 2025 10:53:00 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aFGPXDfOkjiy_6HH@ddadap-lakeline.nvidia.com>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
 <aE0fFIxCmauAHtNM@wunner.de>
 <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com>
 <aFBs_PyM0XAZPb2z@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBs_PyM0XAZPb2z@wunner.de>
X-ClientProxiedBy: DM6PR02CA0165.namprd02.prod.outlook.com
 (2603:10b6:5:332::32) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb8fdcc-652f-464f-d2f2-08ddadb70b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRCAzktd0rivOKYI1AvZkNC7wjFAqlEWVgUeOgcjvVl8xu6z7NioT4xNQTmB?=
 =?us-ascii?Q?jOBYh0HGo9ktCp85IK0A4FZHJq8hbxK01kytEi2tjjH6RhIB7ACY5QJV2yqY?=
 =?us-ascii?Q?TOHksUeTSY715asJKBVINBVH0DiCd6o05ffy4gQx5GPt2X6gnUXFdslze9y6?=
 =?us-ascii?Q?cR6+45Id1oGgDhfmFWbEWFpNSVZ4+AQKFAJrgR4fp5ZBlyZL5aLLxnNyJmW9?=
 =?us-ascii?Q?rmH0ITzA8umnckiYmIoMKL/TY+i5cVUoacHkcQ7ki1ax8vXPQyRP55QlcHiW?=
 =?us-ascii?Q?/G6hP/0O6mihWyDjCSPjR6QtCVEZj4aYFR6ScVeXGSYGgy3tfBaUq02oI7Ik?=
 =?us-ascii?Q?tZFQT8eRAOYMgkyA7vNjM7sJuHJoIeqIL28Gt3dMI1V9ikMKOCdhFLhRobY6?=
 =?us-ascii?Q?rdA0QzgLoK56Fyx1c+FPP7A5EnQx/HMGHstaAt1iaQOVYmwZDIHGAzuz1rtT?=
 =?us-ascii?Q?v9CvQquZil+wPzmpGc9gfrARAE/ip72vMdd0DUzS04m8KbPks9oPWLvIl6p3?=
 =?us-ascii?Q?oU4p5z4Mz1EwyqRu+zfc0233x4Gst3xbgRsXJK15iMaQzAFB1NO2ULSb6jmM?=
 =?us-ascii?Q?WYjZbU3rNS2u7igZOAqFKBaHCinx1pfX/6KBdx5LYn1g7X6cusAqibqb4xgp?=
 =?us-ascii?Q?L+Ss1R9dvl2kkRT+B1EYge/AnVP2pQ9FSsT494zYcrt2wuBRnBKyXfcG3l6/?=
 =?us-ascii?Q?5HHJeWYUGkb1jMH2BjnVBGU8DoFc45CmVX6a3uJvRWI+osYJYTHUKKnhSetc?=
 =?us-ascii?Q?ORE8XK4YRl5q0ZQS52xEPgJcuON6w4Eh/dnZyYEBL4UWSUsM8e5lblbePpIO?=
 =?us-ascii?Q?1UHoHhVKrp0cpC79Ky6rTHevij8QO+h9uk3SsiSRPYL5MHLsMQp24CJTuQbo?=
 =?us-ascii?Q?iMUlb2dff+HzW2N3VIKjgvdYLG1bLQoc/j5Jne03jrVjf5DuBmnSMoIzkjTO?=
 =?us-ascii?Q?B+92ClfzOzpGAYwr0+r8sgPaArXdXUN2wslGDJcWDFshGTynpZSSeX6CMjvL?=
 =?us-ascii?Q?RcYg8P+ektTYhm8+Um4hbRVDxAB/B0QS3GLhmb7ofn2rGuw3w5AB+o+C3Y2H?=
 =?us-ascii?Q?+eWylSClvapldloHBYewceewCHoVcIVq1rbOKxwa3badWF1Xh9vc9STsE/TG?=
 =?us-ascii?Q?ha9WmJgoQqke1tICTky+gtiQ4EYdO/rGSFd+mAMQjvEOL0V4jkPwFN8H4AS/?=
 =?us-ascii?Q?Ys60FbXidas3dVDcReCkd/UN3MxX8KkXoOkwaNeO1RwcTqj5sBpY2M+6ZXRb?=
 =?us-ascii?Q?XMe0BmFfFGRhdfAHB+jGmToaXQlPfR05JirxX89eHimohDaGgpGXGH2Hbm50?=
 =?us-ascii?Q?N77vzy1jdeTJN3iH+Ldg4Xp7jILcH6KClz0kNBhoqQVFXA2GJqWikqtrxg5y?=
 =?us-ascii?Q?/Ji9ziLyDKfdR4yvXGigLV/7v1MFBDERhT9dMEcsD73Yubqc2FeBhP7ofW63?=
 =?us-ascii?Q?lBdPkOxRkzg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rj87Zf6jSyirecZrJO585w355krxa92sL4RCaLG9SBaqOS/xRJac6qWWbVo/?=
 =?us-ascii?Q?UkuMVfNA+sKIudnrDSIkHQ7c29sbL63+g5sJ3mKGZ3jp7WDgM1woerGZkxxG?=
 =?us-ascii?Q?tYEXhsp6eKN9/KD00aDyoXpzwE2QqEWJco3WGGLaZohS/cdh9VKUm+/tnsnE?=
 =?us-ascii?Q?myc1ux5bhbf7aEvLVoaqCXaYfDHYPdW1XjBWWIndv/4qZOv6C/YdDxGwdmKe?=
 =?us-ascii?Q?pNq6dQNcsfGJd+7Qs0R7US/MnpIJKdSFUfuXxugKuqnoRNSyrNZ6VTMzvZXR?=
 =?us-ascii?Q?HafTvgQ3+GXdcMwP5b3lRfkHmr9Sz4d6VKR4FpaH+0XhA7CWXbAZkKhpN3sx?=
 =?us-ascii?Q?pwpVJG+IDY3Yg60rVd6HZHVdyI1TMjQqztbCL0PH+a1pjS8zSCgYf+U+rvqh?=
 =?us-ascii?Q?iiGR1YOl1xLebOqUKM5LeENs7VnrSNcq+hCSQuHQM2T9WthxHpL4wvO7i5OZ?=
 =?us-ascii?Q?cJxX8GNpfs0bJ4QEhWuWeCwHMht+34CqNzw2thZNNaL4pBSik4lJa8spU3pe?=
 =?us-ascii?Q?ir+sHjr7cvJ0xkPQXUeQLmXumPsumHm9oAMrI7WGrh0wSFLeBMkIP4rIy8hv?=
 =?us-ascii?Q?uvF9HFaLuKdI4g1223j9u9qT7Ykd2dvkLDzIhocyS9kU7uzqs37DjP3gshLY?=
 =?us-ascii?Q?CubgRbFbe3BiYhqiuu69c9ZDZ4o7H8Mtcm0oJN/5WlciPKg3YVfEqVRMe6C6?=
 =?us-ascii?Q?SInXmBlvYgf+B6W51mFHkO85whmJhogdIXz+j/lvTAZB4RViEXjdz0hYYnvB?=
 =?us-ascii?Q?RgaC6YMU13SXwT0d09iTcU5LYoadd0Ujbt3VygOVXmZAXkcxrNeAplrmzt3h?=
 =?us-ascii?Q?CNgGrlGbDwuAuzS4Q2NFk5omjRvH8afjTCB5UISHeV1XWfwSm89GExuUJPhC?=
 =?us-ascii?Q?TUXg5lM4s5H119jdNKeRhcnwSek+xS2Q3zdl0fTeSEHB0Z1nywk/0YFZbv+e?=
 =?us-ascii?Q?iQeMMGjjVp/q05UQ4bgYEUD6/qrsQIjW5tVm5fuMTZwFLq9qfxsxIrRkI/HN?=
 =?us-ascii?Q?UTCTlqZ/1mZvlcddwRRl1zclTqsrV2+V5ZhOQt9M56gzAvcy6rEQeSbSnW5P?=
 =?us-ascii?Q?UrHzAVVrtOWNumpxQABIAgODquypGo7yN37dfQcxvKyuJ5PIqL/m577UAwaI?=
 =?us-ascii?Q?TG2MtV37hp9be+P3Z3zOKcOvJk639DGCXhvU7Qw5FfakmGN1ReCvDXG7kfL+?=
 =?us-ascii?Q?SNQaoE850WUZfAGLja+OiFFDIY9M/aa66eFc4JC314NP8/cXNRMd2Lvp5HHb?=
 =?us-ascii?Q?wcteLHRY7czOGuZQu76EK4JqsYrn0MhTqI9nMQknlQiLOk+r/sKyKMpUJdWY?=
 =?us-ascii?Q?rb2/2/5PHI1XuywHr5Cffnyy1DDXk5OQKwx1YDqiTGd1j/vR/saEufiYD2fn?=
 =?us-ascii?Q?JW/Nk2sksnTMJvbH9HnBBMKkSNDn8PkRTkX62XEzXC2eOzFvyu5kAR07Ycu9?=
 =?us-ascii?Q?RS9O+I6S5QBTFU6QmeG5xYoNfymnsdgpun0JzM7qegPlxOYEn/KrYsk3bznz?=
 =?us-ascii?Q?axzWNySmFKM3ExFeUR0F5fm58RpeWyKJnNLeZIXQdcNLQ4rjjMI//8AFAX0m?=
 =?us-ascii?Q?1HYgjrvnaBUyKvhXVGijvioeexd1Hk/WQYBhqIJ1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb8fdcc-652f-464f-d2f2-08ddadb70b96
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:53:04.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mo9cUYnHeiGgW8Ffsf0IK90ImSzIgNQ8yZlkEc0FzimoFuo8/gbeH4OljKT0ejk3FU2i2ILSiQ5ouX+nndLJcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

On Mon, Jun 16, 2025 at 09:14:04PM +0200, Lukas Wunner wrote:
> On Mon, Jun 16, 2025 at 10:05:48AM -0500, Daniel Dadap wrote:
> > On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
> > > On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
> > > > Ideally we'd be able to actually query which GPU is connected to
> > > > the panel at the time we're making this determination, but I don't
> > > > think there's a uniform way to do this at the moment. Selecting the
> > > > integrated GPU seems like a reasonable heuristic, since I'm not
> > > > aware of any systems where the internal panel defaults to dGPU
> > > > connection, since that would defeat the purpose of having a hybrid
> > > > GPU system in the first place
> > > 
> > > Intel-based dual-GPU MacBook Pros boot with the panel switched to the
> > > dGPU by default.  This is done for Windows compatibility because Apple
> > > never bothered to implement dynamic GPU switching on Windows.
> > > 
> > > The boot firmware can be told to switch the panel to the iGPU via an
> > > EFI variable, but that's not something the kernel can or should depend on.
> > > 
> > > MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
> > > switched to the dGPU on boot, but the kernel is now unhiding it since
> > > 71e49eccdca6.
> > 
> > This is good to know. Is vga_switcheroo initialized by the time the code
> > in this patch runs? If so, maybe we should query switcheroo to determine
> > the GPU which is connected to the panel and favor that one, then fall
> > back to the "iGPU is probably right" heuristic otherwise.
> 
> Right now vga_switcheroo doesn't seem to provide a function to query the
> current mux state.
> 
> The driver for the mux on MacBook Pros, apple_gmux.c, can be modular,
> so may be loaded fairly late.

Yeah, that's what I was afraid of.

> 
> Personally I'm booting my MacBook Pro via EFI, so the GPU in use is
> whatever efifb is talking to.  However it is possible to boot these
> machines in a legacy CSM mode and I don't know what the situation
> looks like in that case.
> 

Skimming through the code, this seems like the sort of thing that the
existing check in vga_is_firmware_default() is testing. I'm not familiar
enough with the relevant code to intuitively know whether it is supposed
to work for UEFI or legacy VGA or both (I think both?).

Mario, on the affected system, what does vga_is_firmware_default() return
on each of the GPUs? (I'd expect it to return true for the iGPU and false
for the dGPU, but I think the (boot_vga && boot_vga->is_firmware_default)
test would cause vga_is_boot_device() to return false if the vga_default
is passed into it a second time. That made sense for the way that the
function was originally called, to test if the passed-in vgadev is any
"better" than vga_default, and from a quick skim it doesn't seem like it
would get called multiple times in the new code either, but I worry that
if someone else decides they need to call vga_is_boot_device() a second
time in the future it might return a false result for vga_default.)

> Thanks,
> 
> Lukas

