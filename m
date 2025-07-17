Return-Path: <linux-pci+bounces-32438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C905AB09405
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAEC1C47F4B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE52FEE27;
	Thu, 17 Jul 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzmsLiA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EC2D3A7D;
	Thu, 17 Jul 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777261; cv=fail; b=Jsdqk+4OiszbwWMw2ckEvq2A/NEfnnL8y5jqyJuuBl8TmZmLbbHsEwUwE8WIDu4e5R3HPW7to/p/3HGhrzSRhOJi1tvUGHYbrnXP8SDnMAQvJL24xCbvolnLYfEHdBPmGWRqq5h2vrpaA2nMml7Uo21MIFtrgNv4QEEhz2HA0Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777261; c=relaxed/simple;
	bh=RmlKBLnyHSkiq5ywj2Yen2jx0miqzBOXBfHeELn/D1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0YxxDA4qoxGaXmgKTzqQsvdR0+0azox4pnELGhF3ACB5xkEG5n4liigQ5pdXxTZOlfLu7H3pWBXKa27iMydMG2NEJcRsMwTBK56dhcpk+JYdUcSKzQy+Hw35bgeKxQyjPDDwki+hPRddxgiWNplvvkKop6pFvJ8GT4FNZEYNGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzmsLiA7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777260; x=1784313260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RmlKBLnyHSkiq5ywj2Yen2jx0miqzBOXBfHeELn/D1A=;
  b=bzmsLiA74CtYZt6WuYHhPufVJcIlRiRpiD4W5zBgY9NPYh4ZbDT0wIHS
   3u/WF2KUwfLat5n+chreZPEFdPVdeJDlkca1CWdbpLmZ8Tx/P0VW0eo63
   zfgLZIvOUlmkhr1vTyFO5RDCLNTIihzmi+x/qEuqU8pGNnpd9KbShTI5O
   Zudv3Bx5tk3LJqE0sYLzSEJbDYCCDmDmNcwPzeffwmOK58DOUTqB3/d/U
   JZ6lbniuvazj9pQPxjE+rNRDm9MR9gxSaqzolty18foohvk2UGN2V+TPQ
   lCZe7YuMXrIOdRPDwAYij2YVCUnA/YXCn0H8gx1gck9ba05x5CvAKrJd+
   w==;
X-CSE-ConnectionGUID: mhwKXQ3bQlyCzIrbG5mZsQ==
X-CSE-MsgGUID: ZnCx8GOmR32tYqfpb6vCbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54945690"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54945690"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:19 -0700
X-CSE-ConnectionGUID: fbK0pCkTQoacquvYWDbsmg==
X-CSE-MsgGUID: CQ+7JuYiSw6ik7xguOfVEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158222621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r08JE/uZPSlAt5STxrp/pnjTCVSZjgd8uQfLZlucAOg/2xP6VHpMK1v9b4HnmEWRRM1ofA8+ti7UUu9EMjHQ0YjZXFbAlEig/b3abKKFykp6TzwZwQV66y/JSK/GJWioJqIkr3DGyV4zBgM2tb1Zc1cQnmybFtg3Ej/E7D5+bX44QsbTLIkj09Er1yDwpRh63JvboAfxXtyfCZ2MNnpWDV4omSA86hKaZYBsc9hNbPPnTNmvlw7zclAyYQ66U9wXbVKGGFNUHsmSyGRga0YUZmNg+MPwUo6sagArfz0K5YDB/7I1cgTxL7rnTYx4Lo9pmiPKIWXHQNctlCAKg2LSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98fRjYcUyxK9V+wwrIxheJ/QlM7URMtMJYC+++WkqFw=;
 b=azCOezFmxZtjz9N4SI+RI+1xD84USNe+znhkEOqJ5e7O7GR7qfwkPyZM2ZKeuRuCo1c7NWnHNtvRRrM7WugD8LtEOt4wZiJocYDnPFp+DGPUckIOr5As2ryyW5hamnsPxRxrpN2dOapVV8qZNBwL5gC21jFxtesyPYol4g1lEZ0O7ICKa79c3m7Wu6pikn1nrct/O6d6wt7jmT9R05pw263dIoaRpckfpqhI1XHDGG9HyTl74b+5VYvE4kOvlNutciQX1hC/8lNCN1gYW9ixWdZY8NRHRCc1CYZLwnyghenOV+kGTb+Z/G+nB1LOWAsCOdgsz2txz2CRM6ff5xftgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:08 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>
Subject: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Date: Thu, 17 Jul 2025 11:33:55 -0700
Message-ID: <20250717183358.1332417-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72ea6d-7ee3-472b-6f3a-08ddc5608479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DdVp63487oF2hl5OgCcrsmKlsh7usurw5Bz6Gg4HVUJk0LrUs5acupTjumK9?=
 =?us-ascii?Q?2m1YpyGChgoGKalzK5fTXtA5ypGXKu04pLbux7EJATF/b4yahi5VglHlx/jN?=
 =?us-ascii?Q?N8DZspR/IAtMh46fgrXJczr4dufKiGp9SWc/w+JP3HYkpzllmj8MTtwuwsRF?=
 =?us-ascii?Q?UDEaH2N5oXYDxEXeZIIALjwX5Q3/YCMpVGhDU0zf1qhMEjLmhGNJa2veaUkJ?=
 =?us-ascii?Q?BB2zAs01BjR6If8bPFzu6IJltfPz9NqI2b+KDu9OxagmwkCOOuxiTEGFdrDy?=
 =?us-ascii?Q?LHfziL+XbaekqyX00MYTFHmyCwELGkkcrFUdulinfueiS3OhSsLOqwzjPShq?=
 =?us-ascii?Q?tU/EOmF4Q5P3GAHPVo/kv0h3aPT5m0Av5f8bvErhRlDWpfFuvdYUbY3EuTGv?=
 =?us-ascii?Q?aWZiWaGnBX5qAAEvoAvtxAuQ+GeCebWb8NkkNcWO+ZLKetngR1Ycdr3LB3og?=
 =?us-ascii?Q?Q9KMoEyqXerK6MuzSpqk2a6ZWt1HkUAqPzLVNlusvHLfnd510/EH/h1jpR+L?=
 =?us-ascii?Q?Sz6JHWeZRkS18JvyY6WzfvLZyG4wBPhpDQF4H288a90bQelXK1+r861THDVX?=
 =?us-ascii?Q?wfdtV03dIexcGHIwj4TJNFvNZWgsBd2s4VDjaGakspYjFLcFDLz4sHpLu78f?=
 =?us-ascii?Q?ZPI1V9Hn8vb1zKPHAAB2nk5ZhGwqA3n4h0Vf+S0U95hUJYas6INjh6dtTHDG?=
 =?us-ascii?Q?5LwvpZhG6r5L9/bRtsb/Htx0U1+sokVy9V+aeGXpyhZtMs4wALfy+Rgz4Xwj?=
 =?us-ascii?Q?PvAtlwsJv/IlGgR/8DHmEeFQ4HI3EB7iaIYmvhltClsH0bz0eODnMPVqbNDe?=
 =?us-ascii?Q?L/qDZMLr30uYrYxxu0VJhiX3zSAjMRm+Mx3MLYAvCpVh+Jt26IXNBYdWREAU?=
 =?us-ascii?Q?Qe5Ni6GV+LgIURxNRN7lI0kDzM1dK/chGxTVLCP6C4loY6581IsEZw9aWm74?=
 =?us-ascii?Q?8SyxofLVvQzjI8/UBh3o4Dxabzk6AIsA76sALq9udIqPdT2Ln3E7mQGFZqKD?=
 =?us-ascii?Q?+EkCmIipL4Xf2/PwYp0BTJ/BkpHm6796zNAIjHN2D6PSF+tp19atWW2RoboC?=
 =?us-ascii?Q?sujOH4F2nYbDfk68sAFWZsRiB1CoRd/B4NFWYWrIM/7/OfgJtT1j5e+3zVjm?=
 =?us-ascii?Q?fRCnFTY9SYYPCLqakLIV+Ds+KMio9Sv8cucV3HwglcCQeQee+fPIewb5IOTQ?=
 =?us-ascii?Q?HNhTS2RwG7SJ4F6CDnwg7y6GFBbDj0GsGPW19/AekYwpwfZVKURB8tknVyBw?=
 =?us-ascii?Q?rXngzDVamb9LIwUpXkl8TMordQ/TWhJyMBoAbYN5Wb5r+vkrimhCqZZzdrs4?=
 =?us-ascii?Q?GfRPaLjH4P9JA/uqaPe4YP79230icJN3UYmwzrw3IS+4oBcgP4BjCdnjmLEM?=
 =?us-ascii?Q?JESRikDdCsBUirg7hZGq5i4Ql/FeYTE89l/UnF3hux0FE8J7jaat1Gc1TU+u?=
 =?us-ascii?Q?Ln+nUvCwHQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c24lNdAK5qJxd7plSae7IsT9gxKKx1ZfOySSNvt3n48/hX9FLdIj22z+iLp5?=
 =?us-ascii?Q?7KYPvAMnlv9KXgoymotugCau+yvLBXTpWMnQHiQfPGU/aSTibzJMbJgGJ66t?=
 =?us-ascii?Q?qRp5lThzh9IDUeF/xgT5FLTSvqr8XyU3Atuw3/x01RSXqgGXbyRDRh2JtXId?=
 =?us-ascii?Q?U6gZ9K1PhOaCuf45FsCkRYVyJnf1z0DS812NLc1yMe6908ENaGHM8Fk1CQiA?=
 =?us-ascii?Q?ji+Y31oCZ8yq16rd20eX6sPkxMnsxs940iC65unU4GIEvGJQm812Sm7tnUvk?=
 =?us-ascii?Q?XJRA/IDEjzfFyaNRuiIsVhID8P4GISVRMHrzmpETIvY7X8k4/hyJkUcG3ZZg?=
 =?us-ascii?Q?W4XqLMSRFs2a3K+9LAbA6741HNihJq2IN4977iUFXVELF67A0+k/b0nk6T3g?=
 =?us-ascii?Q?i767/nHCD2NX9ApN1hOmdDKi1Ex4EVFw5OtN80U2aKX7QhlrK0jmTJrUepHY?=
 =?us-ascii?Q?P2Y6TahxRgtbQdgLT3Lzytfd4PPAeJqlC6vTG982bRK7v+cJ09mnzZfywZ73?=
 =?us-ascii?Q?Xb/35groiOj8NFtZK5QYMTY002hCsOe89WO0O1TX0BuXMZJKntJVQS2f/tF0?=
 =?us-ascii?Q?qkRJ2UPQwnjwzO9Nw3WmNJXMKfJ9R95RFtfXlgzHJ860QxyEkwTHRhM2GzOR?=
 =?us-ascii?Q?qcxMShNEQE63NAR+LTjRCprcNv9L866Pn/ZOUwqJ/zTex5cxeSNoz6oNdgfR?=
 =?us-ascii?Q?QsrG2DNInIdT+y8kwNp27S2cTo7/zlEBAvLfA2LZraPzx0iHZXu18vsw+gjR?=
 =?us-ascii?Q?D7CYKAzS3jn3wjhvAXKpvMSySLiDTK0bhW+hX89FchxtAHla33vUm6tej3r/?=
 =?us-ascii?Q?rHL1m5PIA7tg6CIEb9Av5tw66vqB5FntA5OTC3Skki1Ki+ocyO8xQ++ITfre?=
 =?us-ascii?Q?Anxn5+Q0EK8GC9x+OXtueDX19twz/RszlunQzfTXJUy8wRcurYd/25cHqmO6?=
 =?us-ascii?Q?x4RDyZWD8VVZhTZnSU7rkrc46+FrcHt42Z3U8cNljuyA0dt31MFdXQQjFvaO?=
 =?us-ascii?Q?refDbRPIDD5NkrC2lxLbt09QbE65lV3d9ZEv5nvP7DgxE1SStPP1Wk7l/2Sf?=
 =?us-ascii?Q?Hb+HIunACWVuG7DkqrFp7OOJfTHuVJHr4//Sl4WWt0/+IQfXCNQqSrjrIPip?=
 =?us-ascii?Q?RcR3sdatdGgby2IByPq2XqJ8oDplni6IsvJE2h2UaMqNa0TsBTERCqW5LiBa?=
 =?us-ascii?Q?QHfNw/qfrL96kF/FDLvkf/3NSvnKFhsCQWi+6Zll6KT1VB2sBuH3DVQQQCWq?=
 =?us-ascii?Q?LE611u1h4Y5GmsiePdfZn4g4xjMV/f7sUF+mU52v1+JfuX/3z5kXHUvVjPR9?=
 =?us-ascii?Q?MbYUEpeVJkBxGZTLjAXl6s3BI/x4jHhkuzEJICc2NSWe8b2ZLD7mvRkth1dx?=
 =?us-ascii?Q?pkxUFLPMMPGd5w+pEA+M7x2emtatrOt+bYI0xynx5igvqZAagzOoU2OgVjwu?=
 =?us-ascii?Q?Azf6bVjsT8rNlnlhmqxNFKFkXVxK1xbyyV8d6y1+yhAH72edNbMgtZIa8AqD?=
 =?us-ascii?Q?a2cyGTVIQZ68E+fLWeqdc6CKgvVzhpqk3NyMQu1WShMR/vGqCFUnlDkPrB2a?=
 =?us-ascii?Q?QmMO/Cp/bqrAg2MtteeXwBthJgEsCCmTv+uvL1yCwW3dQ4HLzPTL4MDxgBpS?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72ea6d-7ee3-472b-6f3a-08ddc5608479
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:08.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Si5bfnG6WcuVawTjtZSNHirOT2Fw3ckvKtuFKylEn4uetMqtR0qWi3ZinUpQifKWbXDuv+7/ihDks8kYEcmPJR1aYX2nN2L+yks90Q2s3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
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

pci_ide_stream_alloc()
  Allocate a Selective IDE Stream Register Block in each Partner Port
  (Endpoint + Root Port), and reserve a host bridge / platform stream
  slot. Gather Partner Port specific stream settings like Requester ID.
pci_ide_stream_register()
  Publish the stream in sysfs after allocating a Stream ID. In the TSM
  case the TSM allocates the Stream ID for the Partner Port pair.
pci_ide_stream_setup()
  Program the stream settings to a Partner Port. Caller is responsible
  for optionally calling this for the Root Port as well if the TSM
  implementation requires it.
pci_ide_stream_enable()
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
Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge |  16 +
 drivers/pci/ide.c                             | 422 ++++++++++++++++++
 include/linux/pci-ide.h                       |  70 +++
 include/linux/pci.h                           |   6 +
 4 files changed, 514 insertions(+)
 create mode 100644 include/linux/pci-ide.h

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 8c3a652799f1..c67d7c30efa0 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -17,3 +17,19 @@ Description:
 		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
 		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
 		format.
+
+What:		pciDDDD:BB/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a platform has established a secure connection, PCIe
+		IDE, between two Partner Ports, this symlink appears. The
+		primary function is to account the stream slot / resources
+		consumed in each of the (H)ost bridge, (R)oot Port and
+		(E)ndpoint that will be freed when invoking the tsm/disconnect
+		flow. The link points to the endpoint PCI device in the
+		Selective IDE Stream. "R" and "E" represent the assigned
+		Selective IDE Stream Register Block in the Root Port and
+		Endpoint, and "H" represents a platform specific pool of stream
+		resources shared by the Root Ports in a host bridge. See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index e15937cdb2a4..cdc773a8b381 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,6 +5,8 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/pci-ide.h>
 #include <linux/bitfield.h>
 #include "pci.h"
 
@@ -24,6 +26,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
 	return offset;
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
@@ -89,5 +98,418 @@ void pci_ide_init(struct pci_dev *pdev)
 
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
+int pci_ide_domain(struct pci_dev *pdev)
+{
+	if (pdev->fm_enabled)
+		return pci_domain_nr(pdev->bus);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_ide_domain);
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
+	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
+		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
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
+	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
+
+	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, settings->rid_start) |
+	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, pci_ide_domain(pdev));
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
+ * pci_ide_stream_enable() - try to enable a Selective IDE Stream
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered and setup IDE settings descriptor
+ *
+ * Activate the stream by writing to the Selective IDE Stream Control
+ * Register, report whether the state successfully transitioned to
+ * secure mode. Note that the state may go "insecure" at any point after
+ * this check, but that is handled via asynchronous error reporting.
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
+	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
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
index 000000000000..89c1ef0de841
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
+ * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot
+ * @enable: flag whether to run pci_ide_stream_disable for this parnter slot
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
+ * @partner: Per-partner settings
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
+int pci_ide_domain(struct pci_dev *pdev);
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
index a7353df51fea..cc83ae274601 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -538,6 +538,8 @@ struct pci_dev {
 	u16		ide_cap;	/* Link Integrity & Data Encryption */
 	u8		nr_ide_mem;	/* Address association resources for streams */
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
+	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
 #endif
@@ -607,6 +609,10 @@ struct pci_host_bridge {
 	int		domain_nr;
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
+#ifdef CONFIG_PCI_IDE
+	u8 nr_ide_streams;		/* Track available vs in-use streams */
+	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
+#endif
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.50.1


