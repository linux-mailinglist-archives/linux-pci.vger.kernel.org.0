Return-Path: <linux-pci+bounces-21266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C8A31BB1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 03:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EAC18885B6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1C288B1;
	Wed, 12 Feb 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpqyUCqm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796112F399;
	Wed, 12 Feb 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325636; cv=fail; b=Dy33a83aQBYR4v45Se3wBplD+0bSXtzHBUGKTzc7BxSUfuEW6GmisV0cqDgQLhdjxXfFmX6p1B+z7qbC0Qb3M5vWvsPvcM1rqdQtFELF8SmchGFntoVzLyieXk0lN49fokLuWCzeVctBDxKHRzTlRoj2tA2zJk+IvWSX+O4LmCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325636; c=relaxed/simple;
	bh=arlo15AhsDYQpeVFGpGN3LEyd54ediHIi2UWbyOVszU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bh9EKlEg7NSuxzqYau/IuWxwRYtnzRQ3UU3gDQGvbe3fTGfZAGaohceuIU12tLzvR98r2po/NhP7VTNIS1NklFj7Xsk1FWaPMo+6WsTcHXlyAfzSTj8jaAGkrG5LZRZmDe3l2Bqpf7FaWTGaxlmy/odFNsZLZk8f+NYXn4dNzc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpqyUCqm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739325635; x=1770861635;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=arlo15AhsDYQpeVFGpGN3LEyd54ediHIi2UWbyOVszU=;
  b=SpqyUCqmeS++MsNgeu8bHO8wby2fD0JRl34hND3zbXD3k4eGuaeV509X
   hAKZAgdWTR1THpj5uDoi6MTI6Ydx8tw0nJCu6fkJa6L8S/GXNbM4IYMop
   rjrCK1FqB5VAwcmRPQQJyzobCDYk250Z6qJIKmETFv5euat1rEyQrKUHJ
   y+gn9Bh9rS+gBkkssFi21O5x7pBhFzjrJBHlFFl6+hxmnTczT8MTEmBOk
   luMT1nD01OFSHogS7fvfyXPCSQvs34TN991F5lnS/2X5kj52DERaIHX1O
   862/qeDGdZ+uf5d0cMSbR28QLCQhgJBJf2dhvSpVyC/Xtu9Bl6VW1S5tc
   Q==;
X-CSE-ConnectionGUID: rmnxpwUtQM6vYkSNoRpTLg==
X-CSE-MsgGUID: JOdCA3BaS1uePtflyujc7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="62434023"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="62434023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:00:34 -0800
X-CSE-ConnectionGUID: 5LlP2BGzTBOsJE8JH+g7mg==
X-CSE-MsgGUID: kUfKRYwURtyjTaoEM81jTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117700886"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 18:00:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 18:00:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 18:00:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 18:00:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPz0GPfkLg2alodHMASBa7RKFSjpeUdnQHYsCgtsNSAKIqYyMp6qggUgy/VznGNLctS63S/P2eGSloeDBWr771f7BLykdqjTyAb/NZfFDNyDLC0m7b0FkGFWhBlPQGvzmV6Q+pVoECfakHWEYaVa4t9txqqs/kLD1aiSKopXpd5Q/9dgBBwAGupVLFzW4MLTsD4XT5XdHOrg2iWLyww8GwyUdu01JIhZN3vQGY7ZSZ1XcY8e6orFzaxxe2iSdtOWUqrcUeVBpKaGJSdkAa4oeuluD7QrzubjZV4Oor4JWaUGFqP5wvPr9gzlaI/A7b77gdwp6i/LC6gQO1EicjSHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXIFCF2wUP04VLFLCKhS0GZiLEVGHFCN4wKWrh+ja7M=;
 b=XRQZnvzx5y2b80QMZbzJ7Viej1VJZ52wihwl3DZZI648/w3dFHj8kF0cwWeiMTSqX5/ms0JBoOi3lFmZcAENlIovDbSBgCXKkjzfmXIitdhTcpLbctIFNaeH3zdP54UqaEi8syweaudza5VG8ziYJBiPRwL74VnSDOym4hWE7FYzDY6SekzrGcSI16j/TTA/SCrhOsH8FVT9TQxYRHyF/a1bkiKaHOINKja8YZNJX3WoJ24hbX4ktNsPXqar4oFxYicCIoztd2UDjOgCQlclS+Aw2w9ASYZ8zVUSDkjT+loPDbiG4Mh1QeD8SZzNZgnlXsCC5tU/19KQ88LAepl87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 02:00:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 02:00:26 +0000
Date: Tue, 11 Feb 2025 18:00:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <67ac00b78e492_2d1e29486@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-9-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 247a8b12-2726-406e-8b58-08dd4b0904c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i43dZ3u7xSF6IB3mBrjVvlCQq73FMqtc/DxYrwCxn9DVaqPjXy5uuMM1F9ky?=
 =?us-ascii?Q?Qq1dbJme5k2JVVXxfaozfnulNcC/6MtLR+TccpSfVdFG/O5TbM7F8KKzsKEE?=
 =?us-ascii?Q?cpbuRBC/nguS+ZfNU/FICybOFtyVpsNAYX8cNH5mzpFBgtAibNoQPtHClcKX?=
 =?us-ascii?Q?xapC7oHtWwZm814UIXVTOxu3DIbfUr4RpDgMaP2AvSKvoCtxgrsxDkfeSWsk?=
 =?us-ascii?Q?fBaXMSAAAEGiIFzrWJhRkjP1ehvgRvg6JbwLQAdG333qMoqjkKnvh+sRrlE9?=
 =?us-ascii?Q?JxkzxvKqmRydQaLpO9pac5oVdHGv/MXrbnGgXEfg5/gBbK6L8QvS1/3uIja2?=
 =?us-ascii?Q?AdJKlfuuJSscyllr/GqrzV2cG4HbI7bILwiMwKNXkeYJpT6nhjC/z5gdYnJJ?=
 =?us-ascii?Q?xBLGbp1DDnYGO1Xp1ArKruk2UFS95zlgkj+zICaq4O5nGxfPVZrkGP8ZA9v7?=
 =?us-ascii?Q?bd0FFiYBTk+OHTuPIkKu99lwARpvHXXzXkGW85iQeFiG0cBMhFhklJF/w7rv?=
 =?us-ascii?Q?/HDQ64ocQrsPDDdqU7J8HPj0MGahfBd+NJ5piXQRM+OE8w7aiYq5ZK4AoVQB?=
 =?us-ascii?Q?7yaEvkQKfUf/cHPkT5WDS4ZHP9LJ6isbgKVaLynOTtmbkxtrmYrvqOe5e474?=
 =?us-ascii?Q?TO9Rg3sFu2jgYLepQunU/iSlpRrFVuDwTa7XpKcobQrwmYsIxqZ0coEYaZR/?=
 =?us-ascii?Q?C2PyromLziOxFg9hhuDZ9K8/6JqE/uKQ7tyic7QscJ/tscuj8Ha8uf1BAv5g?=
 =?us-ascii?Q?IaUdq3UL6AZ75D2mafyxNk49WHD1ONpfHadW61CHS9zt6LvY9VhXBvu6oYbY?=
 =?us-ascii?Q?yq4DBpmmuR2jNxapyP28B5Ma4lIH/1itajsv20QuK/+rH6QqIs7hBEuKj9sQ?=
 =?us-ascii?Q?wKu0avH1xc0kytvCM5tHtdMhRKPKNsab4qmga0PAS4sKm8YlRUYCVpv68BQP?=
 =?us-ascii?Q?gftzCBuFzKcoV2KNFYwjO6sRct1fYKGTurip/8lwGqn5ULWGAd1Pkm4MmQSZ?=
 =?us-ascii?Q?byqoD5uybV/jqDcig+KyXxmkfg1l9WsigHp67VtuzrINpt3ek1oZaKcn0rA8?=
 =?us-ascii?Q?Q85jVIXxBfc9ARR+cAS2yCwplQjKmRLatwFFdk6XWLugpNYxNybfoJgCWoKM?=
 =?us-ascii?Q?HLs/BLmAITM86y2f5UomxdG2UDuEdKjSt3njSO8/wzXE/BW2acKNKX8bP3HP?=
 =?us-ascii?Q?EJTxt3j2O9DoihIaHHqbRrGuykgpSwcI4iKapZE5hKTRR+J7vlUe6K/X+bsS?=
 =?us-ascii?Q?ubYVY+IMcjqjTmOGp88EdN/PLo86C7to4c5I0scvmYva0hxiT6i56fPikgTh?=
 =?us-ascii?Q?1c+Kyquv57Icd+/barn6uOOxGn0cvvvTJ0NGftlGRuH51Ue//0NVx7fXk53R?=
 =?us-ascii?Q?IKZN+9B8cN157L7WLqPlQ3w7D1u2ForNQ3XxFT2Co6lLt7AEgJ7cI/JerUPs?=
 =?us-ascii?Q?dmIFQBWH8fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCKNk+QTODH8bI587mAh50oh4bnsi1PsAZ7sZUozzKLiyj0TtRbsAsG0rtaG?=
 =?us-ascii?Q?H4dfbTNoqN3kewiSpqHFClGNGiHJeMI6/q+fOM9u04vjw3P4eK847e/iIaDy?=
 =?us-ascii?Q?AOHjHsqI8l4upKoEk0l1/90b2mzDj5G1iaXM8zv0kb17ssAl+uPH0gAAhVSm?=
 =?us-ascii?Q?5l5Nw0B5Jsh2MFovbYAgpIbGNq+WKoj+TOQ/I/nDmP+61dVwjhEDIpZbIc2a?=
 =?us-ascii?Q?5Fg4Aop5p6gwXKe72BaaOTMVZ0GsjLIM9ewXk+2aJ6QmtYkOAFKt1GHWqvTK?=
 =?us-ascii?Q?n5KinUve58x38ustXDsPfLEkLTbdNQmbidz9N/ECOUAdLcgMUYv+hhaVNBXY?=
 =?us-ascii?Q?Vrz/tYQkdj1M4CJdVuFVGygjrOzMdqsPo5nyeKAEx29ETkz1rdxlJguDD/v7?=
 =?us-ascii?Q?VbCIy9ZNZxoBR7YZo/pECCas8A/1vOB7CV5HhDmfX9x9994WxhB8fHy7HkeE?=
 =?us-ascii?Q?Vzkai8XTd7uTQF0VKp9bCan6cb2Dm72p5tCJQF+0S7cMiKCdQmjZmPWHt7RS?=
 =?us-ascii?Q?1nroCljDk2/A1UADKM2hMTYRDL2/RoIT98kXYYHjnrjP9jgRANkBFXpLsyYE?=
 =?us-ascii?Q?wic1k0fJW9RKjYMlsCgK1x+6ztbDSyIb58nIff8C12sD1eskSvzK0tEc/1a/?=
 =?us-ascii?Q?GG6FWlydfCreL9RLPgzOUCxW4I4r7QyKYMYz1TNcEaJeUPVEJ0LwI08YFl6A?=
 =?us-ascii?Q?QbWHYwoVfp/FpFUO1xhFzeXaXirrpdgNp4MQxHn1z9rCJaIXipqHWxD0VmpJ?=
 =?us-ascii?Q?Wdc5vIt9GXi6Hm631LFMUETNSZ/XbMhwTYND2UhmADzjOcHYg4fcDAak0pOr?=
 =?us-ascii?Q?PLnOzOJj8kRPF6AVVwLqMT6A7SJJVZAWhd4sJBbwYrTKAi8RoixKRahLU4Zd?=
 =?us-ascii?Q?jmxpUyTXPJYwRrEwNIb5H+WFDuoTuo2io1XnZ3H3CfBqSTwEjPO8ODKieSWM?=
 =?us-ascii?Q?JtdAStxpNQokC9rMHE3b9lpHaD0g7Cdo/7tfmyw98Q6QnYDVJh5Q80/tjGzH?=
 =?us-ascii?Q?7EnTPPkNbWl8t0jC3UGuteKwESzCtUFHUz4Ikjidrz300zS2FWJLPN2nEyVF?=
 =?us-ascii?Q?jMy7mPYlb2jj6pkn7K7QNsJ8GCWBW2OjCl8Tpccqsz0W8+HG2bhwnh6oO6p4?=
 =?us-ascii?Q?DR2lli8OP+S9aoajox+n+kbQGf6+AqKACC//SoZFiR2DPB9iNZd7SEp9+2Uc?=
 =?us-ascii?Q?JSiOETG/WXqJbMWVifVKzCrXq+VlCmFmlg9vmHZiSvR8QmE05zcCBHKUJ50N?=
 =?us-ascii?Q?D379mN2Fsmt1kItRguPTrip5w63QcWnXfLN84D8gD+B4nWGdtfGAL5tOrlsd?=
 =?us-ascii?Q?c/vDDgRgo2bqkk3oDYQT7pU0Zk5f2gSZr0Qw6dt0cwq+S4xMhXH8QWHWIIdJ?=
 =?us-ascii?Q?/vWFtSHmGA9XJP1006dIDeAtXAT0TYOM+Rk726UZyTm07nGBF2K5ssZpz672?=
 =?us-ascii?Q?UuTkp7+wx4IVA6ANV0m8LDhRx9Z9L21DFlDTbJL01SkSWtOXpDEDdygwT4na?=
 =?us-ascii?Q?8MEWV3qCPWMHhh6HbHXWLgttA9i84Q5kw7tL89GLFdLB64AvqOirkK4to508?=
 =?us-ascii?Q?OBBbMrX/57dWCh09H6rbWG8z4wNUKrF+zpjk+VnJNeykce1TUv0C0zLJsglG?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 247a8b12-2726-406e-8b58-08dd4b0904c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 02:00:26.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yu9V8tjChLYMVk330+93l3EPH1pMiYoYTvDOq8Gu9gkFdDlIZCcK6Hzy29o8SG4Manj1sQUoviGkxMeEKIvvp/gfV4oFFMSKgsh58DZm5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping RAS
> registers check if the registers are already mapped.

Yes, now this sharing makes sense, but the ras_init_mutex +
cxl_init_ep_ports_aer() approach to solving it is broken.

> Introduce a mutex for synchronizing accesses to the cached RAS
> mapping.

In this case, especially for VH configs, you should just be able to map
the RAS registers once from cxl_endpoint_port_probe(). That will
naturally only be called once when the first endpoint arrives, and will
never be torn down until the last cxl_detach_ep() event triggers
delete_switch_port().

