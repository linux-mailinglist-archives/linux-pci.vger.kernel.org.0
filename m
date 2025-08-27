Return-Path: <linux-pci+bounces-34853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B3B378DC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F37C1F07
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118630DEA6;
	Wed, 27 Aug 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+UJYF7E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E430DEBF
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266702; cv=fail; b=B0eeBfStWcFdxNpIOyhK8iDKwvBvZUNs4e9ZL+1Ok3WDwTYn2oVDcFRzhh+tJiYnX6uprzu6A2q6uLfVtbBKWDKfqpOzjpE2omGYBbVYEVcm2B70nvPZPLCw4uvtMlr1eNI8yukCWg9VIa2/s0o0IbIyWX2dSX/ueh/5EIX22ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266702; c=relaxed/simple;
	bh=AeePjGMWr9bhtCkTSkds1K1LnBYti2vDkKUVQGxK8Ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrXe8zph1L/ZfK/qXHb/vk0nSrvhOXzESK6DrzIVerw72jpElQTTwqSF9Dra0fb27JrQ65V2nP3qMdz+jFc8VGBU7acaemY7CsOudNjViSuW/IezRziOQYFD+/aHk4mkPs0oe2pD2bycFLdhMXYxLO7p4XGalK0U9FQ65TQniDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+UJYF7E; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266700; x=1787802700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AeePjGMWr9bhtCkTSkds1K1LnBYti2vDkKUVQGxK8Ss=;
  b=Q+UJYF7ESIl5IovWKqfE3UzjWsZXHVAPjmJiL6S0J/yr5Ysn5gMeWIvK
   K5JdaTr4xEpdjNuJ0o9gLLVjpSp2kuFcrmvXpfN9eQ6ZoE+5+uBdhWZyk
   icM7QvLPfJlQ4mgvZ0OlDbJ3kU4N4QYo0Trl+IbHv0BCXwVA2dk61eGH7
   MYkWY9uqiA3zXzLCvzPrezSEli0ZJ02BocepYiI9V+YayvUdZeTfR0u9Z
   SvmtorfSiOkBaSd5mIV54QkMZCpfDmouwzSAb/6X77KG9Gn62ULcG5uL1
   30LAqrMF8wS9i8rsV3bqB5+tiz5+y2jTPj83kLVipmcQRmUEAe6qZmqw3
   A==;
X-CSE-ConnectionGUID: 4NzTcd5BQGiAmVU+12qGPQ==
X-CSE-MsgGUID: 0ZFDV24NStOivZ4s+/1c4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159156"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159156"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:40 -0700
X-CSE-ConnectionGUID: o9ZdRHhSRJKa9EtwbZ0Sdg==
X-CSE-MsgGUID: CqqWsjwATS+9jW4YJek3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685138"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYtMX0Yfi+wzxYjhjhjvMAYYiT40Q6p4ckrLcb8oZ/7fmmkQx1MOXFnVAe8PUTpoXKPbkfOe/bHewDXUWnd5CSAPgX5eDl5soS13MqNDhVRdRQFwutowU8PRS/jak4Sr/zuwQ6TSAg4Eo5m2thxtI3dPMWmNzNmdB1Y9vYZ8y6F2CzUOd85g2/Z/FogYnMIMwFfIBRCYeNUa1fWg1w5fxS7tt66uwsdf+s8wwunSluImbqQJgiGbBJvPvuYMbsxKQyS1gZFeYIOdIeuiy8k8ZgnOVutSdRhHBcRKCixLbaYawn/ZMz+i27cQARBAMSPwEFpNu7dDoXCFNShGriGT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HopN5lN2iHSEUClHRmRpZvZqSVdYlivMSCP2drq9njY=;
 b=U0fwHg6wWLpmEGfJ0wtxIIY2Svj3QLF5deJAcqF7GKdg95VpXVPxE85c7cuc06WX0y5YAlMEqwjOBG2A5BKspDiLvWYdg3SEuLCZxoifMJC4NVSkjnWA3N4Bvd0j/PqImR48lj6rKJNoORsJUyQK25cja8jVCRpx9X4mea5HaPIlweQ8+4+ldVIp2q7COe7OfDpC//RztJbmYASH1LyoGgii84acrejT/Dt+3I+xOTf2s21e4vMbGzRz6urUVNR46F7YapUmTNnXTSvlmOKRw1gI11hS632TRRLBTOXLcpkq7eGJCcM0kVwMO1wo+vNHCFutTalJ3BmeN8jHjh4Tmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:35 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Date: Tue, 26 Aug 2025 20:51:23 -0700
Message-ID: <20250827035126.1356683-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9630e4b2-7e72-4527-d2d6-08dde51d0497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4oJU1hHZSwzL7HrlIeHLaEMsKm6bSJqHB3MSPb52p5MxVIvYrO9GJ74zpLpH?=
 =?us-ascii?Q?2xIGmE4IUTRvQyOe6GYO5GWAEbKtz+fkg+JYMNmaVVKFJ5rQRnBitdijCPGN?=
 =?us-ascii?Q?7B2o6w9UMwfJt1yQ6c3PzjpiLYq7LsS3d1QOzEe7MFQmWmWTJo01YyF2eTAw?=
 =?us-ascii?Q?fWnfMMBrFj/LUe+Y4RGls2GYzHTv6KwefgUXkfK1ao7imFHhwtyS7i6Ug3W5?=
 =?us-ascii?Q?oEDwbzrD2QNGNXF4Iy0i2WRW/6EXkeyQs/LMC7v/GNTcxPiMtnRWbXiWcHUt?=
 =?us-ascii?Q?zz4f4t8lpfBTrcuho3WnWXrTnL2qPM24clJLFg6ToCjTBDeq1Fe2z/1lTE2c?=
 =?us-ascii?Q?+jDs+RODUpzYPZyxWkMYdPeE/XhoA+ovcoHc59B9HxdmyFG9JVvwaTsiJdxV?=
 =?us-ascii?Q?CF0eZ3kJTnf9FtIIdpp44VOcivkBk9JnMbRl0/I/Lv+CqP++nEa2Q4Tgy6Cj?=
 =?us-ascii?Q?E0mCNRkf9+IX0UMSFVNOPRnUnPNRaG1LIjxW+GWkx3AYUm0dlD2WUd7QmNm3?=
 =?us-ascii?Q?hRNsYWjkB+tsk81xCUbnqkPM2RpZtWdaQQWQfJ8u/I5cxxcwiPeP/Iiua5Kg?=
 =?us-ascii?Q?qjetx1FxKQV2XA73zb/nVxMV3cZTapw/ZpBUw28OzJpuC55mU+vlTUjw278i?=
 =?us-ascii?Q?oenimRKFx9l8EnLZkkgSAuqNVQYw4QfmoU+mWaIkTR4C1S/xMcaSacmVNBMp?=
 =?us-ascii?Q?VsvjHEbfgXD5HgoCmf23Ay/oB9K6XJ6GdXvZjxL72j4hBJNFAGCPNjQV4LQ8?=
 =?us-ascii?Q?DV59xD2jffaHrqFOtbCw3/CwNuyZ2ZUQBsoGuGirqFpLX8lgOt2lV7kP7oo7?=
 =?us-ascii?Q?ByrIG6uOluc6ItagGCHS6D2pZFsRbZISrEAFec8aEN1fk+bfkH+t/MroU8RB?=
 =?us-ascii?Q?7ttWwSNO/O2EZ0rPxAq7ox0Y5Ppv5js8hZ5fvqG8rlse7MZeUwXBoS17Fx7e?=
 =?us-ascii?Q?BeTBvw2mGAB3DKaT2CGzV3HymUzOJ94IHsHlDMcF64jDOFO9Aq+/hTrLzL7I?=
 =?us-ascii?Q?AaZdKzUmNoMxK4gBMB4s8v/cnKOi/92pt9EZ4t7a9sVi97rDf5dZutKGGV6O?=
 =?us-ascii?Q?ctCHdLfv1kpygBg5DTLv1lMBbkzu3NzhzhuVxvYlx282VDX2lR0ftVCETu16?=
 =?us-ascii?Q?YcTJr9WqvqX8UtiplxtmYf034IC7SYbcTcTyAcc9gJOAUFxApXFYaHCe0OaT?=
 =?us-ascii?Q?1iFsA79pEoUFqphpl8e3IBacnerQBslcRM3F033H0g+CPX/wZYAzFqH/gZlM?=
 =?us-ascii?Q?iZ9BsoS6jnsgBJbPDFWQV6m3285f+4/f2/QWeVtKj6Gxykq9MG7iSpspODTs?=
 =?us-ascii?Q?+LDP4jSeZIOpzfxalpzNkaxwPoRR1Ljxuxu1NqCwV3PsR/GqlP31bkYbZKnX?=
 =?us-ascii?Q?rsFhmYZGwcPvzBjkDkDsBt9LZ/Fxmgm0yKYEJ68FtvpUVjA3wpi2Qohv+OqB?=
 =?us-ascii?Q?5o22NKnpSXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNa/LqdGVveyGFVk2MTyv/fQPOL0S1s/hMMFUSN0CBb1VEsDi7vG4vZgOOLm?=
 =?us-ascii?Q?yp06rEOCt832/06NyVZOINnppGorIVEQMAtXH3bsgdBKu9RHRAsQBXlvaK59?=
 =?us-ascii?Q?zOo7J0Y742l8qzcUsTUd3Uo9I5B3tI4zUzmdg2+Xk00Ymy5BANyRBs2uCe67?=
 =?us-ascii?Q?1We0BgoPlWDSf/wD2R7XXM4bw535YKDg3DC1WuIszkfwueSwLFN/0GNtEKb3?=
 =?us-ascii?Q?h+kiYU/MFS5qYmEBp8Rt+0bL88rnfXuM/w/6bNn/bbe8cmcqScUyRa/5bEgp?=
 =?us-ascii?Q?I1wJm3E3SlZoGWzL4/3xsBFQ/pSzLwF2ekg9MN/XHzJnpZFqnZooLSDmjoDy?=
 =?us-ascii?Q?+yDOjBNxZqgMJLCWhWox8AKZX2nC1MMQJg5IaBh1nYdvvsUQhEZmaxoliuka?=
 =?us-ascii?Q?eNFA6Z3d8B2HtsXENXMfH3garNfyaZngVnt1NiMqYrubIYdhGBrqr6hqjLmG?=
 =?us-ascii?Q?Vmdn4s++reGAqJIxWByYRvLR3/M5E2Cygtke0eNETDEHXDxQCUGLObDcLB3z?=
 =?us-ascii?Q?vh96uNsmFQqOmAVQZPe8g7XsjxA30I/NHu+uxwbhRRmQ1mRfEwI7pJpIm6C1?=
 =?us-ascii?Q?Q6CDsdVxqrHVwJnX/N7eyQj4Hl5uKaZN03hZqbcKMRuMtclGGHo8pJVnK3YR?=
 =?us-ascii?Q?QAlCuL2GPn7MArqLzI0y9uQk3rMPq/3sTGe1L1j1CVmZB3Pd0ZgVK3L0Jmqw?=
 =?us-ascii?Q?ejYdWkk5/1XKtfPaS9YW5I/MhTd1GwYLS67NjsuleNNQ1idkyqCXqAnA6HQL?=
 =?us-ascii?Q?r39YDnsB7y+3u1XF3281qbpcSDAFC1MZE0G5tBlFzqY8+uDJXLxHSCrxFw6l?=
 =?us-ascii?Q?S/V2FIOZynoBlBQQmhFtrrK3pN80SnqPDLXi8KhT97u1URJrZLhwjuF4hDaS?=
 =?us-ascii?Q?qu7ueqDYoIeTwFDuXpzNagYWzuVbheR+zVjICUepdBDxCf0n72VlY52gfksD?=
 =?us-ascii?Q?Oe33R0Iy6woA9t+GRjyCj/PTb1RSDXMCZ4i++us5SPAxlABd0cMZXLYekcwJ?=
 =?us-ascii?Q?5zJlJgp4auiYhH2a3hA6SSM3roLBT3NmKxqCceXEs/PhQ497YgI2wjFZPbL1?=
 =?us-ascii?Q?ZkCGv4FNsXGlsVau+3wclLiqsvMzmSc/K0lUR8it/oigmaXT0qbcgI/PiKno?=
 =?us-ascii?Q?1IvX56PWFJ9Z75otVMzvKXsdgArGbSDP+2T7DESoFDpBP5JIS4PbIU9HvGm1?=
 =?us-ascii?Q?Bfa6ALbQ8WJGxTK/nHozyUKrLjgF/+zlcqNst8E4nfsVo5dqq61JR9vZEqfY?=
 =?us-ascii?Q?AefB4+lSrsZlyB3ssQkeYjOxbN5hsIWXtk+aZWq0eTc2DSyVxOPaY2kySx6e?=
 =?us-ascii?Q?MVFdGh+8+5LLo/0ot/dk028rlB7A0+msrzW9wXhv6lxZknEHDbQGcyNtNJq4?=
 =?us-ascii?Q?brtVLsCtFk3WQc+w1YM6eIQ4zlybRJ5RsnqeYsBYDthosXflWI+YoOC2kZG8?=
 =?us-ascii?Q?8Ux4Ytyfh4KgCDjjDmj6JJqSNOV3Hbld8ESVlRDd7nOa9CwFlLwzv83L8tNu?=
 =?us-ascii?Q?frzacv6ErJIQGuHAK876rXYOCkjtXY/xqCm3isf9FWjE2InZJVbY3ZmBINSz?=
 =?us-ascii?Q?CEmigSxZ0s9iNke46eQu5Z28BuD3Mxkpp8lWuZkg8BSAOkEaTx86J+7jV3HD?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9630e4b2-7e72-4527-d2d6-08dde51d0497
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:35.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBO/9zESaaRkT0zQrH/ZRrrnWrgwmDFS6IS2bOGuhekCVSIf4RGNunszwGY2Ii1g/OzytIKbv0N6mLvhlRj8XFmA0CR0hXIjWNSbnAX7yZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

There are two components to establishing an encrypted link, provisioning
the stream in Partner Port config-space, and programming the keys into
the link layer via IDE_KM (IDE Key Management). This new library,
drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
driver, is saved for later.

With the platform TSM implementations of SEV-TIO and TDX Connect in mind
this library abstracts small differences in those implementations. For
example, TDX Connect handles Root Port register setup while SEV-TIO
expects System Software to update the Root Port registers. This is the
rationale for fine-grained 'setup' + 'enable' verbs.

The other design detail for TSM-coordinated IDE establishment is that
the TSM may manage allocation of Stream IDs, this is why the Stream ID
value is passed in to pci_ide_stream_setup().

The flow is:

pci_ide_stream_alloc():
    Allocate a Selective IDE Stream Register Block in each Partner Port
    (Endpoint + Root Port), and reserve a host bridge / platform stream
    slot. Gather Partner Port specific stream settings like Requester ID.

pci_ide_stream_register():
    Publish the stream in sysfs after allocating a Stream ID. In the TSM
    case the TSM allocates the Stream ID for the Partner Port pair.

pci_ide_stream_setup():
    Program the stream settings to a Partner Port. Caller is responsible
    for optionally calling this for the Root Port as well if the TSM
    implementation requires it.

pci_ide_stream_enable():
    Try to run the stream after IDE_KM.

In support of system administrators auditing where platform, Root Port,
and Endpoint IDE stream resources are being spent, the allocated stream
is reflected as a symlink from the host bridge to the endpoint with the
name:

    stream%d.%d.%d

Where the tuple of integers reflects the allocated platform, Root Port,
and Endpoint stream index (Selective IDE Stream Register Block) values.

Thanks to Wu Hao for a draft implementation of this infrastructure.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge |  14 +
 drivers/pci/ide.c                             | 427 ++++++++++++++++++
 include/linux/pci-ide.h                       |  70 +++
 include/linux/pci.h                           |   6 +
 4 files changed, 517 insertions(+)
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 8c3a652799f1..2c66e5bb2bf8 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -17,3 +17,17 @@ Description:
 		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
 		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
 		format.
+
+What:		pciDDDD:BB/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a platform has established a secure connection, PCIe
+		IDE, between two Partner Ports, this symlink appears. A stream
+		consumes a Stream ID slot in each of the Host bridge (H), Root
+		Port (R) and Endpoint (E).  The link points to the Endpoint PCI
+		device in the Selective IDE Stream pairing. Specifically, "R"
+		and "E" represent the assigned Selective IDE Stream Register
+		Block in the Root Port and Endpoint, and "H" represents a
+		platform specific pool of stream resources shared by the Root
+		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
+		details about the DDDD:BB format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 05ab8c18b768..4f5aa42e05ef 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,8 +5,12 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/pci.h>
+#include <linux/pci-ide.h>
 #include <linux/pci_regs.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "pci.h"
 
@@ -23,6 +27,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
 	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
 }
 
+static int sel_ide_offset(struct pci_dev *pdev,
+			  struct pci_ide_partner *settings)
+{
+	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
+				settings->stream_index, pdev->nr_ide_mem);
+}
+
 void pci_ide_init(struct pci_dev *pdev)
 {
 	u8 nr_link_ide, nr_ide_mem, nr_streams;
@@ -88,5 +99,421 @@ void pci_ide_init(struct pci_dev *pdev)
 
 	pdev->ide_cap = ide_cap;
 	pdev->nr_link_ide = nr_link_ide;
+	pdev->nr_sel_ide = nr_streams;
 	pdev->nr_ide_mem = nr_ide_mem;
 }
+
+struct stream_index {
+	unsigned long *map;
+	u8 max, stream_index;
+};
+
+static void free_stream_index(struct stream_index *stream)
+{
+	clear_bit_unlock(stream->stream_index, stream->map);
+}
+
+DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
+static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
+					       struct stream_index *stream)
+{
+	if (!max)
+		return NULL;
+
+	do {
+		u8 stream_index = find_first_zero_bit(map, max);
+
+		if (stream_index == max)
+			return NULL;
+		if (!test_and_set_bit_lock(stream_index, map)) {
+			*stream = (struct stream_index) {
+				.map = map,
+				.max = max,
+				.stream_index = stream_index,
+			};
+			return stream;
+		}
+		/* collided with another stream acquisition */
+	} while (1);
+}
+
+/**
+ * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
+ * @pdev: IDE capable PCIe Endpoint Physical Function
+ *
+ * Retrieve the Requester ID range of @pdev for programming its Root
+ * Port IDE RID Association registers, and conversely retrieve the
+ * Requester ID of the Root Port for programming @pdev's IDE RID
+ * Association registers.
+ *
+ * Allocate a Selective IDE Stream Register Block instance per port.
+ *
+ * Allocate a platform stream resource from the associated host bridge.
+ * Retrieve stream association parameters for Requester ID range and
+ * address range restrictions for the stream.
+ */
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
+{
+	/* EP, RP, + HB Stream allocation */
+	struct stream_index __stream[PCI_IDE_HB + 1];
+	struct pci_host_bridge *hb;
+	struct pci_dev *rp;
+	int num_vf, rid_end;
+
+	if (!pci_is_pcie(pdev))
+		return NULL;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return NULL;
+
+	if (!pdev->ide_cap)
+		return NULL;
+
+	/*
+	 * Catch buggy PCI platform initialization (missing
+	 * pci_ide_init_nr_streams())
+	 */
+	hb = pci_find_host_bridge(pdev->bus);
+	if (WARN_ON_ONCE(!hb->nr_ide_streams))
+		return NULL;
+
+	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
+	if (!ide)
+		return NULL;
+
+	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
+		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
+	if (!hb_stream)
+		return NULL;
+
+	rp = pcie_find_root_port(pdev);
+	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
+		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
+	if (!rp_stream)
+		return NULL;
+
+	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
+		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
+	if (!ep_stream)
+		return NULL;
+
+	/* for SR-IOV case, cover all VFs */
+	num_vf = pci_num_vf(pdev);
+	if (num_vf)
+		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
+				    pci_iov_virtfn_devfn(pdev, num_vf));
+	else
+		rid_end = pci_dev_id(pdev);
+
+	*ide = (struct pci_ide) {
+		.pdev = pdev,
+		.partner = {
+			[PCI_IDE_EP] = {
+				.rid_start = pci_dev_id(rp),
+				.rid_end = pci_dev_id(rp),
+				.stream_index = no_free_ptr(ep_stream)->stream_index,
+			},
+			[PCI_IDE_RP] = {
+				.rid_start = pci_dev_id(pdev),
+				.rid_end = rid_end,
+				.stream_index = no_free_ptr(rp_stream)->stream_index,
+			},
+		},
+		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
+		.stream_id = -1,
+	};
+
+	return_ptr(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
+
+/**
+ * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
+ * @ide: idle IDE settings descriptor
+ *
+ * Free all of the stream index (register block) allocations acquired by
+ * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
+ * be unregistered and not instantiated in any device.
+ */
+void pci_ide_stream_free(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
+			 pdev->ide_stream_map);
+	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
+			 rp->ide_stream_map);
+	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
+	kfree(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_free);
+
+/**
+ * pci_ide_stream_release() - unwind and release an @ide context
+ * @ide: partially or fully registered IDE settings descriptor
+ *
+ * In support of automatic cleanup of IDE setup routines perform IDE
+ * teardown in expected reverse order of setup and with respect to which
+ * aspects of IDE setup have successfully completed.
+ *
+ * Be careful that setup order mirrors this shutdown order. Otherwise,
+ * open code releasing the IDE context.
+ */
+void pci_ide_stream_release(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+
+	if (ide->partner[PCI_IDE_RP].enable)
+		pci_ide_stream_disable(rp, ide);
+
+	if (ide->partner[PCI_IDE_EP].enable)
+		pci_ide_stream_disable(pdev, ide);
+
+	if (ide->partner[PCI_IDE_RP].setup)
+		pci_ide_stream_teardown(rp, ide);
+
+	if (ide->partner[PCI_IDE_EP].setup)
+		pci_ide_stream_teardown(pdev, ide);
+
+	if (ide->name)
+		pci_ide_stream_unregister(ide);
+
+	pci_ide_stream_free(ide);
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_release);
+
+/**
+ * pci_ide_stream_register() - Prepare to activate an IDE Stream
+ * @ide: IDE settings descriptor
+ *
+ * After a Stream ID has been acquired for @ide, record the presence of
+ * the stream in sysfs. The expectation is that @ide is immutable while
+ * registered.
+ */
+int pci_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+	u8 ep_stream, rp_stream;
+	int rc;
+
+	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
+		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
+		return -ENXIO;
+	}
+
+	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
+	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
+	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
+						   ide->host_bridge_stream,
+						   rp_stream, ep_stream);
+	if (!name)
+		return -ENOMEM;
+
+	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
+	if (rc)
+		return rc;
+
+	ide->name = no_free_ptr(name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_register);
+
+/**
+ * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
+ * @ide: idle IDE settings descriptor
+ *
+ * In preparation for freeing @ide, remove sysfs enumeration for the
+ * stream.
+ */
+void pci_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
+
+	sysfs_remove_link(&hb->dev.kobj, ide->name);
+	kfree(ide->name);
+	ide->name = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
+
+static int pci_ide_domain(struct pci_dev *pdev)
+{
+	if (pdev->fm_enabled)
+		return pci_domain_nr(pdev->bus);
+	return 0;
+}
+
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	if (!pci_is_pcie(pdev)) {
+		pci_warn_once(pdev, "not a PCIe device\n");
+		return NULL;
+	}
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pdev != ide->pdev) {
+			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_EP];
+	case PCI_EXP_TYPE_ROOT_PORT: {
+		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
+
+		if (pdev != rp) {
+			pci_warn_once(pdev, "setup expected Root Port: %s\n",
+				      pci_name(rp));
+			return NULL;
+		}
+		return &ide->partner[PCI_IDE_RP];
+	}
+	default:
+		pci_warn_once(pdev, "invalid device type\n");
+		return NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(pci_ide_to_settings);
+
+static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
+			    bool enable)
+{
+	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
+}
+
+/**
+ * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
+ * settings are written to @pdev's Selective IDE Stream register block,
+ * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
+ * are selected.
+ */
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+
+	/*
+	 * Setup control register early for devices that expect
+	 * stream_id is set during key programming.
+	 */
+	set_ide_sel_ctl(pdev, ide, pos, false);
+	settings->setup = 1;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
+
+/**
+ * pci_ide_stream_teardown() - disable the stream and clear all settings
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ *
+ * For stream destruction, zero all registers that may have been written
+ * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
+ * settings in place while temporarily disabling the stream.
+ */
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
+	settings->setup = 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
+
+/**
+ * pci_ide_stream_enable() - enable a Selective IDE Stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Activate the stream by writing to the Selective IDE Stream Control
+ * Register.
+ *
+ * Return: 0 if the stream successfully entered the "secure" state, and -ENXIO
+ * otherwise.
+ *
+ * Note that the state may go "insecure" at any point after returning 0, but
+ * those events are equivalent to a "link down" event and handled via
+ * asynchronous error reporting.
+ */
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+	u32 val;
+
+	if (!settings)
+		return -ENXIO;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	set_ide_sel_ctl(pdev, ide, pos, true);
+
+	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
+	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
+	    PCI_IDE_SEL_STS_STATE_SECURE) {
+		set_ide_sel_ctl(pdev, ide, pos, false);
+		return -ENXIO;
+	}
+
+	settings->enable = 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
+
+/**
+ * pci_ide_stream_disable() - disable a Selective IDE Stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Clear the Selective IDE Stream Control Register, but leave all other
+ * registers untouched.
+ */
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos;
+
+	if (!settings)
+		return;
+
+	pos = sel_ide_offset(pdev, settings);
+
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
+	settings->enable = 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
new file mode 100644
index 000000000000..cf1f7a10e8e0
--- /dev/null
+++ b/include/linux/pci-ide.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#ifndef __PCI_IDE_H__
+#define __PCI_IDE_H__
+
+enum pci_ide_partner_select {
+	PCI_IDE_EP,
+	PCI_IDE_RP,
+	PCI_IDE_PARTNER_MAX,
+	/*
+	 * In addition to the resources in each partner port the
+	 * platform / host-bridge additionally has a Stream ID pool that
+	 * it shares across root ports. Let pci_ide_stream_alloc() use
+	 * the alloc_stream_index() helper as endpoints and root ports.
+	 */
+	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
+};
+
+/**
+ * struct pci_ide_partner - Per port pair Selective IDE Stream settings
+ * @rid_start: Partner Port Requester ID range start
+ * @rid_start: Partner Port Requester ID range end
+ * @stream_index: Selective IDE Stream Register Block selection
+ * @setup: flag to track whether to run pci_ide_stream_teardown() for this
+ *	   partner slot
+ * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
+ */
+struct pci_ide_partner {
+	u16 rid_start;
+	u16 rid_end;
+	u8 stream_index;
+	unsigned int setup:1;
+	unsigned int enable:1;
+};
+
+/**
+ * struct pci_ide - PCIe Selective IDE Stream descriptor
+ * @pdev: PCIe Endpoint in the pci_ide_partner pair
+ * @partner: per-partner settings
+ * @host_bridge_stream: track platform Stream ID
+ * @stream_id: unique Stream ID (within Partner Port pairing)
+ * @name: name of the established Selective IDE Stream in sysfs
+ *
+ * Negative @stream_id values indicate "uninitialized" on the
+ * expectation that with TSM established IDE the TSM owns the stream_id
+ * allocation.
+ */
+struct pci_ide {
+	struct pci_dev *pdev;
+	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
+	u8 host_bridge_stream;
+	int stream_id;
+	const char *name;
+};
+
+struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
+struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
+void pci_ide_stream_free(struct pci_ide *ide);
+int  pci_ide_stream_register(struct pci_ide *ide);
+void pci_ide_stream_unregister(struct pci_ide *ide);
+void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
+int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
+void pci_ide_stream_release(struct pci_ide *ide);
+DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
+#endif /* __PCI_IDE_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d3880a4f175e..45360ba87538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -544,6 +544,8 @@ struct pci_dev {
 	u16		ide_cap;	/* Link Integrity & Data Encryption */
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -613,6 +615,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE
+	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.50.1


