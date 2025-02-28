Return-Path: <linux-pci+bounces-22604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A89A48D19
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 01:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E1B168F02
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20E276D06;
	Fri, 28 Feb 2025 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWs2Xv78"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50717E0
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701776; cv=fail; b=XsIzSd2f7AOt9c9EXlxrxmdYNj2bbIMoMXbB9tg9lF3Vkrpekwm8JllZbWUI1rKKwpEXpaD4pLGRu45AQWF9tmARkMmq/hbfUSPeIqvkCrlOOH0YDkMxrl+lFWsZGlkraI8Obd7Utmq55xmRcMyvgOocuIebXlEBNO0VbtldOHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701776; c=relaxed/simple;
	bh=43bvA4+TznCPLdR5RF6TmnOzsb0nGiwxOQ1m93WrFdk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWqeh41WRVG7B/4edj44nZEu5VJiCbCgwsrUgjpRmY9poNPf8eejNsa/A1sowtCmGOdF0oExZgX4OXzCRi1oqrnQQ0ZowYlg60e3qxGx44RrvVWp+BKDAEa3p1aFTezjW0ofdm5P2HGRZYxHKinsAcOnfxeiaVIxhT49/vvSeFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWs2Xv78; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740701775; x=1772237775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=43bvA4+TznCPLdR5RF6TmnOzsb0nGiwxOQ1m93WrFdk=;
  b=mWs2Xv78NHrinUXMAGGc5Y4EylfXpEL2kAyYnqJvbQgGCgMkYTHRtjiv
   u2H+Hfj/ARDaVNby4sL9Uz38prOB69Dooq0Tt/jNmVzY1fOfQ1Z3hVjzj
   O7R5dvLhAC1PrI1PuHrTznkCP4EClZ80uZFGPirL2PzwEwFb8MlYWydDM
   xT4nuGoFgzrX+xz3b3eXyzXUL9TtkcGOYmCsku3LNY/yBkoozuUDiBq0N
   xiJZJQYvaWvnJvXDWrN1LI0t3rx6NFLmtSfi6E2nmjoap25Y0G/GYZZ7P
   EGVXRKPhNSRvakEQQbZFkMRQAA3LTKxCx84i14usb5rdPwNspanwGCRMw
   w==;
X-CSE-ConnectionGUID: 77bxWYRMSP6UrdxiZkL73Q==
X-CSE-MsgGUID: M7X/HDw5QW+5AXEMAfnxDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41499517"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41499517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:16:14 -0800
X-CSE-ConnectionGUID: R9yYCqNASYWcAecF1Z0cMw==
X-CSE-MsgGUID: ytXVFh23S2qkhifCP9rPYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121306959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:16:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 16:16:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 16:16:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 16:16:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqetfgLuM9UmIcpINYWQ5HS3Z6krD1DnPpU3JptvzujjojM1k/I2q+gSS1nrd0BaX4XJ17F3kZBwZzPYfil6BBFGSwrcXJO5dIFXjPKdr3ioEgQEnyW7HOzrIAAVllCXGQJcCog+EzyiAVbEzROyeoeSCvtAmDsfQ/meGzkx0g2bTiTKDcvS25V495YqWyXf8eJfUMOrcHOxqMzmK5F8anXMXHNTQPISatFABaCj67xE47taKOUJfwfTKO+4ZWlPZXcONhnuwhtMWCpLYJoeDo4gyd0C0H3cskQYnkZgwvcU2Woj3KhQUuGJT+6+pWFdmUOuLGqvod4VCnKqGJN/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMnNcjHY4U6fH4rl9jz4j+EhuPEn69ACfmdIR1qzEsE=;
 b=aJlZ1MrvXwwNoWYIaXKlGHFtO16YUQ3YpT8h6d4Sqwb8i8YmF2LapOLzQQeUH/iRaD8qOTGuWPeBdDpVbEi4GH5fi8wXFlrLeGA32mIMCNUIIZjwc8xIfbQWqITnur6xLDZq7Wi/TO5QOWBfbrSRmYZyw1mgLoruX7UDpyI/ldOVhTRddFfASW2LpIXlG7TBKs8D/jVUC/k7V1y34yALgKQdPhX02CL8Xyx0kUFiKVheMguK3c+eIL0vr29mf9NDx7nsBCQx7orb/P/TOkjp4x07wS4n1CegBISRry4ob+gsu0UtKM0bC4UBngjZISIiUOYbMxntb1OtJJESY6cXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 00:15:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 00:15:29 +0000
Date: Thu, 27 Feb 2025 16:15:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67c1001e8ae57_1a772941@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
 <67b9252c8cac0_1c530f29484@dwillia2-xfh.jf.intel.com.notmuch>
 <Z7xRzVrR0t6ap3+y@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7xRzVrR0t6ap3+y@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c51c3c-7809-4294-153d-08dd578d01df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3VNgVtRvdEp/4hVwHFEkLUESPD/fiX+/6pzO+aGtdqEs314EzEDQ0k3h4fg?=
 =?us-ascii?Q?RhKsQdNNWtsRb1B7utxii7lVJHINBzBGBCDNczlK9t1cDvmN0JZebrlYRFGy?=
 =?us-ascii?Q?HcztR439cEbL4Y/y74AW8RqnlOG+E1L0IVsiBIY8qrTC0Rhze4BaFCUNC9RK?=
 =?us-ascii?Q?6it5oYd3V8lPL1BOQsnarU0KnaRjR4N7in/pnMsA73HjtfC3s2TGMuHvLmIz?=
 =?us-ascii?Q?xLqhqVMhNKm8+DZEMjfrOvIX9fOb2mgpx2GC88adinTDc/qGQdyDCgvdhbwz?=
 =?us-ascii?Q?Uz7dPL0X4HGy3oyeqwKUfYtQA8Gft+TF7Tpmvo/T3s6OAK9rh/lsraCmBHdD?=
 =?us-ascii?Q?cDhjGxd3uHjQTHSWQYWtAc7wxJTbjejcBOdudfqabnybxolUnj4eenNH3vjz?=
 =?us-ascii?Q?CMdhU9AOKDKK+4OymER5x/z1CsNjzWs6MjrELxGdkX6fYIkeYY1dmsjuCEMR?=
 =?us-ascii?Q?OQo2eK5ZErrskVjTgyTEUUcqW01HPUDjD9RijtcXxDYrd+JUHf4RGSwrrFNv?=
 =?us-ascii?Q?Fb2YrvQX7QSNsb7joe1caeBC4wp5ZVveSDL5oe46aedpke/S9j8znw7bzOBi?=
 =?us-ascii?Q?PvmpyRleqAxP1LC2i8QYRGCPZUu5f/kcwbay97qD3ZsNxGchQJRVkonLLUWH?=
 =?us-ascii?Q?uNDshLpHiUXE5Lm4wnGYnQo9KyA/Q0TRIOQRgwOT46zijeNoTXe2V2EHktaP?=
 =?us-ascii?Q?E+A4kQNhLASowZFNi+eePGWCsMHOg7MvyEyELT05CZjPfnUrVeT5JEaokLG7?=
 =?us-ascii?Q?9TNMVwBWuzRYYVsfRznFmPjlsrWil6Iyr1Jy8gD5Xyin0H4ElGPueb+hBEfn?=
 =?us-ascii?Q?SR+T6gC8FyT90yCc1195edsLDV7yuHpAGLRpDiGcUlSj5fo5i/nkKhdRC32E?=
 =?us-ascii?Q?EhmOsrUoIGSuKuc5DsuI1ncnMuzH6epOohK2Ami9kp2vg3utCxPk8Gtc/XtT?=
 =?us-ascii?Q?KSUv+L6RZ/DZvdByOs0MdsgE9ZAPhhMcBVabHr1PAzDCwfH2P0tASQlg7POV?=
 =?us-ascii?Q?WYMpLDD+8gVJVIaepcczVUPSi2me/AVi3+QEURNKqMtaDTSE6LH0MBALC9nb?=
 =?us-ascii?Q?r/FS3MdHAfcV50Y4leybTsEXlG7D7G3s0OKWF8d1w76rR0pxbxrqu+B9TH1k?=
 =?us-ascii?Q?eL2eWgqu0pjtufl8kNp62LNE892jF5v15zKmbX2HG3YklKvlQs3dqbrqAFD/?=
 =?us-ascii?Q?hLbYkzBh6kkbo95Ib9BPIO2Q1VvVIhNanU5eJqdksnUvp5/46CHz2LSVuBYK?=
 =?us-ascii?Q?vMqONn+aZZvg3EHnoet3/kwfHgIpQD8EUb2t7SXeydNglYZdN8KIy+jW3gRx?=
 =?us-ascii?Q?AR5343gN7kahuk6QgebD4Uybdym9spzueMLmyFtGj83F0P7yc/9TXBsKeqWQ?=
 =?us-ascii?Q?1IN7PSYbAfPdOLbITZ/YNFsPI6Fq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Q36Ugk642GAVFvDQSRzlVLYF6fk4tk29nDDPY2G4ZGm8+3l0SWjcDSWKynr?=
 =?us-ascii?Q?EMKU+gXtEGP3+VFgEIKSJejxgzjlwYzs/jVnxGWaLEO9dYcyJoAKwdzwyJwr?=
 =?us-ascii?Q?L1Tme3daXI3zo8+JZDrF9nyn4eQszJNwM+/d+pGQR3pXjDDq8Gq5tEOeEqTp?=
 =?us-ascii?Q?eZgDMJvCZZ+mFzAExenYr2zC3H1iZw5KivsUbPYxTyWHLtHUTyo1SNE7rqds?=
 =?us-ascii?Q?2Z4s3kCgkYqiumJsdDYHxbroyh5C8HdzjY7onsfHEQQLs5/1g0jO5GBiXS8e?=
 =?us-ascii?Q?jRuKZEdGbYVM4seaE5LBr4vk6MWng2grPW3aIov3D//2ennLrYignC2PFfjq?=
 =?us-ascii?Q?KV58IyM8Uip0gtM7oWS6J40s/5GlKNbskhZLsgyF7uhwegb8qFIjDhWiFeEU?=
 =?us-ascii?Q?+XeImqIeZCCyyYnZ6ZXRk/gc3bN8sXSW/f3TQv1G8cr7oiNJ5Hi7rBmB1EOx?=
 =?us-ascii?Q?JLcoOAivJYFIq0H15OQy5vvHRltBdNCs0heI2Ut2vmwznmnJ6tOapMgzqDHy?=
 =?us-ascii?Q?KBZ5Skc/L6GWHh9UOi6kuGXGboa+VcDhXc8yKCrPbTNIDjCkniCYZmwEq+4M?=
 =?us-ascii?Q?qwXkARVJpH6VK/w0YpfOf4/ziMwbdZ9qDRD8kTNpdYWBOG5u5YSZcch1zUHF?=
 =?us-ascii?Q?nd99Ww0jmP6ep/9+JGhT9hAoP4z8RgqpEGtV18B+TI9OaKtDHqLXnG2rn3ha?=
 =?us-ascii?Q?FlX1GEiwZeO50RbEgiUsthPAe6H8pX9dvTfYah10TQHmwd+iIa6SiOLrKp0R?=
 =?us-ascii?Q?qeWPjGumngr4ZU5Ou2lJ0ILAOyhlG6G6Uo/MDZSavTJ6OdP9sDqZk0jUZLwX?=
 =?us-ascii?Q?UWn7UfF/lE7iGuMq/saLTZOkmXRFZPKosZ3aAtQmNFf0tNPtPk9gaLk3h7tt?=
 =?us-ascii?Q?QhVttUi4WMPo++FBF39bTfkt+1T/waktOlFtxfFYqfj6jUYWAPzJPLfhV6DG?=
 =?us-ascii?Q?9cOgKLLPQw+aWTqJwiQBCCxjzgxOkDrO1EXBT04PjABFi/dvT9aviCd/JheW?=
 =?us-ascii?Q?PrwHPpUNQm9mbrAFoeDq5zpzo/dNkhXUs03bkD6JgBy7A0q2TGmZaBVASgKb?=
 =?us-ascii?Q?pn88FEkrOCKxOxKGK8X9eNfyUKMtRDE7rZIiIJTYT+cYHDSocler6dSPQa9+?=
 =?us-ascii?Q?3o5crXW9VWODMJEamB7fzVuowf0C4odBqNFlLJqLEBPcCJnmHQCpS1h1XYxx?=
 =?us-ascii?Q?wIHRrpomo2RMEZC8zlL3cEGC5LmK9zgAUuG9epjMTl72pR7R1zEZJjwpsSeV?=
 =?us-ascii?Q?70hdd4X1N4CEOs9NjiS5O2x/PtDVemZIX0fUdR9KP+FVLorLfBVAM6XD5Dql?=
 =?us-ascii?Q?YVa7/klMqNFirrn9+MeX1kQCmPWUrIhiCToUauBTTyIfKh9VvjBhdT21dTts?=
 =?us-ascii?Q?xPibVxj5WCKpnZYP7hgxbjcO9bXxIS0LoPM3SNfjPnEPsZi5gSJW2CQJLpG6?=
 =?us-ascii?Q?boZUSDkuuR4G+W0UlvsRIV/Vx7takRbgZmjrc4XXxIuVqwoZpg3ybn698cj3?=
 =?us-ascii?Q?Z1EKRmwPlJCcS3MIiG9PPHApzr7zWefAhqaDFpO8Td7O6Z+NQxY75yxjJF5O?=
 =?us-ascii?Q?utiNS1L5vAj84cZbfCtoow1Bn6iCSWlzqc6/RWgtGwO0S53+ZleY/7QnDWuZ?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c51c3c-7809-4294-153d-08dd578d01df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:15:29.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkFKUSw6oLsdmU3HvxVeTcchmrVaDvj5trUBKRsAZfaf8HTGK8kCS2e5HND3/uUQxakyr6bG8+5VixOOW5g350oc1YaiTX62CCtrazc87Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Fri, Feb 21, 2025 at 05:15:24PM -0800, Dan Williams wrote:
> > Xu Yilun wrote:
> > > > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > > > +{
> > > > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > > > +
> > > > +	lockdep_assert_held(&pci_tsm_rwsem);
> > > > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> > > > +		return -EINTR;
> > > > +
> > > > +	if (pci_tsm->state < PCI_TSM_CONNECT)
> > > > +		return 0;
> > > > +	if (pci_tsm->state < PCI_TSM_INIT)
> > > > +		return -ENXIO;
> > > 
> > > Check PCI_TSM_INIT first, or this condition will never hit.
> > > 
> > >   if (pci_tsm->state < PCI_TSM_INIT)
> > > 	return -ENXIO;
> > >   if (pci_tsm->state < PCI_TSM_CONNECT)
> > > 	return 0;
> > > 
> > > I suggest the same sequence for pci_tsm_connect().
> > 
> > Good catch, fixed.
> > 
> > [..]
> > > > +
> > > > +static void __pci_tsm_init(struct pci_dev *pdev)
> > > > +{
> > > > +	bool tee_cap;
> > > > +
> > > > +	if (!is_physical_endpoint(pdev))
> > > > +		return;
> > > 
> > > This Filters out virtual functions, just because not ready for support,
> > > is it?
> > 
> > Do you see a need for PCI core to notify the TSM driver about the
> > arrival of VF devices?
> 
> I think yes.
> 
> > 
> > My expectation is that a VF TDI communicates with the TSM driver
> > relative to its PF.
> 
> It is possible, but the PF TSM still need to manage the TDI context for
> all it's VFs, like:
> 
> struct pci_tdi;
> 
> struct pci_tsm {
> 	...
> 	struct pci_dsm *dsm;
> 	struct xarray tdi_xa; // struct pci_tdi array
> };
> 
> 
> An alternative is we allow VFs has their own pci_tsm, and store their
> own tdi contexts in it.
> 
> struct pci_tsm {
> 	...
> 	struct pci_dsm *dsm; // point to PF's dsm.
> 	struct pci_tdi *tdi;
> };
> 
> I perfer the later cause we don't have to seach for TDI context
> everytime we have a pdev for VF and do tsm operations on it.

I do think it makes sense to have one ->tsm pointer from a PCI device to
represent any possible TSM context, but I do not think it makes sense
for that context to always contain members that are only relevant to PF
Function 0. So, here is an updated proposal:

/**
 * struct pci_tsm - Core TSM context for a given PCIe endpoint
 * @pdev: indicates the type of pci_tsm object
 *
 * This structure is wrapped by a low level TSM driver and returned by
 * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
 * whether @pdev is physical function 0, another physical function, or a
 * virtual function determines the pci_tsm object type. E.g. see 'struct
 * pci_tsm_pf0'.
 */
struct pci_tsm {
        struct pci_dev *pdev;
};

/**
 * struct pci_tsm_pf0 - Physical Function 0 TDISP context
 * @state: reflect device initialized, connected, or bound
 * @lock: protect @state vs pci_tsm_ops invocation
 * @doe_mb: PCIe Data Object Exchange mailbox
 */
struct pci_tsm_pf0 {
        enum pci_tsm_state state;
        struct mutex lock;
        struct pci_doe_mb *doe_mb;
        struct pci_tsm tsm;
};

This arrangement lets the core 'struct pci_tsm' object hold
common-to-all device-type details like a 'struct pci_tdi' pointer. For
physical function0 devices the core does:

   container_of(pdev->tsm, struct pci_tsm_pf0, tsm)

...to get to those exclusive details.

> > > > +
> > > > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > > > +
> > > > +	if (!(pdev->ide_cap || tee_cap))
> > > > +		return;
> > > > +
> > > > +	lockdep_assert_held_write(&pci_tsm_rwsem);
> > > > +	if (!tsm_ops)
> > > > +		return;
> > > > +
> > > > +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> > > > +	if (!pci_tsm)
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * If a physical device has any security capabilities it may be
> > > > +	 * a candidate to connect with the platform TSM
> > > > +	 */
> > > > +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
> > > 
> > > IIUC, pdev->tsm should be for every pci function (physical or virtual),
> > > pdev->tsm->dsm should be only for physical functions, is it?
> > 
> > Per above I was only expecting physical function, but the bind flow
> > might introduce the need for per function (phyiscal or virtual) TDI
> > context. I expect that is separate from the PF pdev->tsm context.
> 
> Could we embed TDI context in PF's pdev->tsm AND VF's pdev->tsm? From
> TDISP spec, TSM covers TDI management so I think it is proper
> struct pci_tsm contains TDI context.

Yes, makes sense. I will work on moving the physical function0 data
out-of-line from the core 'struct pci_tsm' definition.

So, 'struct pci_tdi' is common to 'struct pci_tsm' since any PCI
function can become a TDI. If VFs or non-function0 functions need
addtional context we could create a 'struct pci_tsm_vf' or similar for
that data.

