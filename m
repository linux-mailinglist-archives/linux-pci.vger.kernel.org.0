Return-Path: <linux-pci+bounces-32435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A2B093FC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1959A481E0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B02116E9;
	Thu, 17 Jul 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLFiic1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662820C469;
	Thu, 17 Jul 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777258; cv=fail; b=XPLmpqz3Yn2+rzVudcO67Ka8Vt+XDBWjGfCUx56ljcCo4Ybjffk6om+QoiK0oFXqzmvpHnJWjzF7X0z/1+StkzebL+tMBrzclRt6GNaX8FzXVwVd54VvlETq9ald8mj/1ZYra/rEq5eAIGcsqSFIMVoaX6q4RxBviJ6skA56yfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777258; c=relaxed/simple;
	bh=EX8B3K/PqoUCdJ/Cd++Ps82HmEhkd6aTwWbdfdzymc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNsqx9O/oSHbP14rlnbiUEkUlgy/XEui9hD8Ypln70pLmTzqBetSnkPERkybQd0D2V2fCfy6TLxwTvuXfa9jrlMy9rxozzpHc0mFZhIrivfyrb0wbvngzAvdUJOxV6McL7GBFtnVurZo72esWXiqhNAXMGURCZGNyPn4U7UZWXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLFiic1m; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777257; x=1784313257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EX8B3K/PqoUCdJ/Cd++Ps82HmEhkd6aTwWbdfdzymc4=;
  b=dLFiic1m3aE1MmgkXgaN8XA5Jnkl887C/gYFWIpOzr9Hi3uBB+YZ2gV0
   7pGy3xW5YP/Budh4sWTOK8iChABuQjzs8No96RLjEyIybqz6LqnzA0t0s
   fkR4/PlL/7sFdH31hLIUGbUD2CGO+BnPqelol64OSMksgw+EQuna/Gv1W
   hXPSNFqbZrNzqGuWvLZd4b/Z+8L4pFEnCeFb4G+d5jFm9Ura/tNZ7Ii07
   7f/N80/tRYg6npD6tAmXuQUF597++krVZZMXzARBLCCc3WKED4Jr8yONg
   +Eun9Hc9aK09lN/9yp7q0s9S2Wa65+ZpL7cbqVi9VdQxOIETrsrgWtvX6
   g==;
X-CSE-ConnectionGUID: ChvFWy7YThmMS3jZg3uIUg==
X-CSE-MsgGUID: xyx+4Dd+TFKrvgU/oZj16A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924065"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924065"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:14 -0700
X-CSE-ConnectionGUID: pOaV40LmTLqkTsAN4IwStg==
X-CSE-MsgGUID: cy68rZlBQfGqvX8uApOUJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254620"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkctWpl6Bka6zvGSogMwTiOAC1p9DRDB656SsDJUNe+Q+AAkmEE+J5CJWfUYIISeUKT8Hke8y3Ykfc08IDhool30F0iBm76t4ZZ2tZsRFTR8w8T7YeQwwVA+NdFLwLwJUChGfigBrOpszDD6sBZ7ghM5A1hBVDdVMEdioa8Y6MOaCc9RXe0HEzzfow7JUgZ2tUGzv0fFZZG/ZAY0xWgAoJOnc13tNlAT3xS+ewIBkeGvcyNeYX6Bp17/sELdLzQS8moxH4/tS9fCHwu+THfSx4EkGX2KvwlGD0y537Opo87r1Pbuw9tCj++qfJ+P4D+ztq9ZighprKs4kG9ER3WlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SZaAEDV2QFqnGESpJ/KiraMoi45NMw8+ioxS5MN0K8=;
 b=hPslR3neBoxvr/u3gxI7Gn/2F6RZKPquBnkJX8bR95d6qCdl9Hr+UNNe32HZfEjYI5VlbzC6HjQSlyiXgHhZUa7HacoO69eP5y+RSM7Sa6XJOkm+2SL3puObp337DORxuY1HlCYJutXgmVR7vIT82StciSrk2ZCJ5SQzrpeV718pwsP37uVoOPEHIlvdPUK63pWcrhxCvrBWRbCoUa4oT4RFghMIKeH4LwVH6s/YpJ71eeqj2w1Q4RctDt4lIoWux2IgyjdzCkEIpRBx4BieucJWiqevFA5KpZLD2UHOE3OyrCHaiY7XELf1z+rXZ1M0+ptPA32dDcbW6PrYUw3UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:05 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Subject: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
Date: Thu, 17 Jul 2025 11:33:51 -0700
Message-ID: <20250717183358.1332417-4-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3094ec94-c3e4-4587-7e37-08ddc5608237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bWquOWIth5T3j8BBHUthmaWIbgCrwF8hr4tKifGrrw0DYtkioPd3P7TQU5h/?=
 =?us-ascii?Q?x3QW8Bz8E/5rnLZWEH+0VH2S2yaVzrqh1MWVZLv8+kdDa42GMNw3MqqW1AW6?=
 =?us-ascii?Q?JaLhguGdVLtynQyOh3MOdCijPI6s4sNvvVQ8jjlWkX1VFgYmSQmMs6IoD9dQ?=
 =?us-ascii?Q?itMWzreIeF8MaR3R8Q8b+2FgP/1Yy7fUmTm4N6yFkPbiqSXCj1BtYt7OiBbQ?=
 =?us-ascii?Q?Q9reJAeQFa7x51WQ8ZeiGWWePuXkJLo2tjNN3IY1JVsP7Ph8KCwvWeQRMt7W?=
 =?us-ascii?Q?4rdiyM/EgeoAWB3bJ9Btcq4jZcxcTpRsxgK6vgOlhwK3PRDH7MMq+H2MHrWk?=
 =?us-ascii?Q?FTSH9PnleTEQcHKSQrJH5rIiBVX/dRTHEQhT+SAqcUOzQj4tUj0eE8XLTQFs?=
 =?us-ascii?Q?nWhUQCrKvT5hG4T0RRmQSiSq5Uc3MOm0H/sU1jkj9fCtgp8pljJpiLlDORCw?=
 =?us-ascii?Q?/94iwFrK4bGM6/ZoYdbml3/mayM8e7IdGEE0Vx3Ng3KPYHTIqp4w/r//rd7O?=
 =?us-ascii?Q?VsJMYlGXdACRw7yGppkWUhreS96k5corYaCUR3wmcJVQecclGy0wGHl+HDyQ?=
 =?us-ascii?Q?ozbaWRG1KcRFrJPk8rqN2nwBAdbBhR28zwWe0pJF2zrbG82C+3Tth32JnJ+q?=
 =?us-ascii?Q?mDsGGrVShyfK2DOBMgEgBxHsHeHfEqD1YvQcp4sl4CNqUE8cEms82kgnK9Vj?=
 =?us-ascii?Q?SuX1ru3KHBhU6I/RDjKfTx1HgKYDIdrkRe9HAMqy/nWgF0Hj3P7cDKEfqT/s?=
 =?us-ascii?Q?ISDyihEuapAszdLdmAEJqAV6IKwxvQ8atbVTBPcwi+REyyXQ5YGqExXViP48?=
 =?us-ascii?Q?xuGCy8DNbCm6qEYeP/+PPWLkAnWihcWtRUq2ICkpbYi1yRkeUDfbUosrGifk?=
 =?us-ascii?Q?B+E4V3fu6tYl6TU66746BsBVNqPsOqGPCrWvyedoSppxhJGwdmLF0QK+qsxv?=
 =?us-ascii?Q?tzF7i4YLzrznegvmyPtQ3tK1nSqmHnPrVqz4bjcGad7tIuH2FQI2HN9XnKIN?=
 =?us-ascii?Q?58NhDLb2NRZHypbHnRmt1nEsoXRQM6csgAm4YulvADeNrV/BDdrP4q39UGsU?=
 =?us-ascii?Q?jKtmZEWF6PgO29/XHJCKd8+nRmEB66SooDfSMujdXb0WlmHtG5TQMAz1K6rq?=
 =?us-ascii?Q?BDJSjoPZnq5xc7uYQ70Cm1H4VDLHxlkEFx3w4ClTZP+HIdEGtOpZn8edZPN0?=
 =?us-ascii?Q?wnhkAHh4W3ANjgOY+2I+wHTbMfHngDRxQXtf0rArK8JB+xL/f7M1loJ3b/mZ?=
 =?us-ascii?Q?a7zK1GDpQiKuzAvySYmNssFr4mFwMlsQEJq/sj4K+jC/yuxVlsFOEtH41pEI?=
 =?us-ascii?Q?32N6otAWQaRxyWABEtepxma0cm1/Yb8dj/Wyr3fNm4fcmnMtrD/Yr2KmCGbT?=
 =?us-ascii?Q?qBrEA+TZtpLPWMPSEVNSMY+QXDVNr4FZrbfiEB5kgfWRUzclsfcxWQsBx7ir?=
 =?us-ascii?Q?ctpJl89bHQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ef/KtdXrpSHP8ut5ZAet9P9QoqVOjwnk+Edx3xbLxWTPaX8noc6Q1yhAgw9Y?=
 =?us-ascii?Q?0lZQQuoOaR376tXvHnbzH85JdMHkTHOUjYt3TUa0/EunzDy1xz47FZ3EelMY?=
 =?us-ascii?Q?wikgZ349Oo+CixUwMCVJ6Hy7y1iV3bwnRypzkiOqRocMvqVTexUgs0Gd4qmZ?=
 =?us-ascii?Q?rQAXrLshxGJ6VnH+CmZfYLHuzm0I3PWBEOSn2PXnD6jjOYdbeBqpnfLkQGSu?=
 =?us-ascii?Q?Jbfqn0ogjRkMkd7zRRG/N1innlCAjUytXGIdiyAHO7445bGxth5GiAkjGNFU?=
 =?us-ascii?Q?6ES7+25OSLxs9oAD+DOUiJ/r0jGA9nuURkyoh317Yxya9mT8GBijcVflk3kh?=
 =?us-ascii?Q?GueQ26aj30XBFXtHRJZ8FiJUIO8dmW8X7JsJztBbvBspH8qBdsHr8FvtS1HX?=
 =?us-ascii?Q?2YJO4wMU0m6NW9Pdj2oMwdeDz66gYjuPdTKpnjoN/SInLF1eCtGWEVuwag5N?=
 =?us-ascii?Q?gqDNtrIwVhwAkcDjbv06CLpX8OGTnm+ylFqZxsuyod0QGB/nQ4ERGDOk2pk1?=
 =?us-ascii?Q?cxcT8HSJ9VzOH1odpWPjKYhjnX+E5UjNAw3xo6bP+ZzjpiHRhmh81hjWuaxS?=
 =?us-ascii?Q?EcufSVOw95fehDpwSMrqS98i7RMXod9UGaMWGNuV1lumifapNzemWcpk2Nv2?=
 =?us-ascii?Q?i0zOwPWXROG93Ma1CX00O1i3Hf6CCS8b9sb43vTSba3qqrqghXyNgM/dqlAu?=
 =?us-ascii?Q?FQr0cUoqi8XdveLhEN5f9cGOjJVPicY0FXbJCi8iEDkxMnWn9lmXjhVgbY+0?=
 =?us-ascii?Q?XZ2ssbB5lpYW7w/aVSK3qTmN+TqC2LP6kUvbaY2StHNRBc9ha5ORWQi4krcO?=
 =?us-ascii?Q?/UF4sJYr72lghGgQYL0E8yAa0dnW35/aSG9Uxs4PT75tyBBLYemhwEymugco?=
 =?us-ascii?Q?G/w3bHM15gFFzqmypULYdfjCC6svdnxSUNHch4BWE6q1tHWCERtPUthIa1vp?=
 =?us-ascii?Q?9K/32JBE54R6KZH5GWxMdXTWa7JOWa6i0/M46GbFLtd5xHcRXZAHCpOfU6fA?=
 =?us-ascii?Q?0WsEfsMzhWPfjLrPte1ywnK1oyHz11YATDHIaP5ZsRp5kI48/u93T86NCZx/?=
 =?us-ascii?Q?ggSUqX69VpHOuf7zJSbLDKcKL/DQDhFGoV46hTsGqR3wVv8jfse/NCvSKQyo?=
 =?us-ascii?Q?IM5OFN4YLZ8XsorwoKOgz2uNUZ/8oQVJZGhjrKggbDet5Qh4pao5R9rHA/8Z?=
 =?us-ascii?Q?IwQTMclkKmydGyXG3vgtUpYwVUzUm+VojfUlLzkqcyqNRNIWMJK0zehsONV7?=
 =?us-ascii?Q?Z7uSTDXQ7iKqPJ+UcEhU42htmC5+MokmOwWFV/+kklFhaS8M8ukBu0XlGM6s?=
 =?us-ascii?Q?f2JIyLSpr/m9SnO4d//W5Q+/mOFqqJOsx74oaaue/Jlqd6/bxvR0rYHYdvBr?=
 =?us-ascii?Q?Yg7VwGxVh4ucW9uqfiEL+wVPMyuwg1WDOFb21s0RLarFjOsPmAEHmNKRtxxP?=
 =?us-ascii?Q?9IzHI8Zy7Kduz0P0ohtbL76a58BUdMGRlpJPvif86+aXznBN9pJ+f+I2MU4O?=
 =?us-ascii?Q?I0fFx6LvXufPK+e3RUp8Wcq9jV2XclfkKTGfm8DYvt83/zBzd1caRbet9oda?=
 =?us-ascii?Q?ucBRGuA2bfEH35Zi65V/s3+ozmICfc63sudx5vsA3g1NCqwejY9aSfZsvVjf?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3094ec94-c3e4-4587-7e37-08ddc5608237
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:05.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S7ShVZBTRRwU0X64dvPkiB2lVXUZ2cNU0Ct1QLYBFPjsM3XNBeJ6SSbuWmR8yfRc8N41zUV5nxzSIJd8GrDt733nCeiv8WmCooowqBwMQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
Security Protocol (TDISP), has a need to walk all subordinate functions of
a Device Security Manager (DSM) to setup a device security context. A DSM
is physical function 0 of multi-function or SRIOV device endpoint, or it is
an upstream switch port.

In error scenarios or when a TEE Security Manager (TSM) device is removed
it needs to unwind all established DSM contexts.

Introduce reverse versions of PCI device iteration helpers to mirror the
setup path and ensure that dependent children are handled before parents.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/bus.c         | 38 +++++++++++++++++++++++
 drivers/pci/bus.c          | 37 ++++++++++++++++++++++
 drivers/pci/search.c       | 63 +++++++++++++++++++++++++++++++++-----
 include/linux/device/bus.h |  3 ++
 include/linux/pci.h        | 11 +++++++
 5 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e75e1bce551..d19dae8f9d1b 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -334,6 +334,19 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
+static struct device *prev_device(struct klist_iter *i)
+{
+	struct klist_node *n = klist_prev(i);
+	struct device *dev = NULL;
+	struct device_private *dev_prv;
+
+	if (n) {
+		dev_prv = to_device_private_bus(n);
+		dev = dev_prv->device;
+	}
+	return dev;
+}
+
 /**
  * bus_for_each_dev - device iterator.
  * @bus: bus type.
@@ -414,6 +427,31 @@ struct device *bus_find_device(const struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
+struct device *bus_find_device_reverse(const struct bus_type *bus,
+				       struct device *start, const void *data,
+				       device_match_t match)
+{
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct klist_iter i;
+	struct device *dev;
+
+	if (!sp)
+		return NULL;
+
+	klist_iter_init_node(&sp->klist_devices, &i,
+			     (start ? &start->p->knode_bus : NULL));
+	while ((dev = prev_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
+			break;
+		}
+	}
+	klist_iter_exit(&i);
+	subsys_put(sp);
+	return dev;
+}
+EXPORT_SYMBOL_GPL(bus_find_device_reverse);
+
 static struct device_driver *next_driver(struct klist_iter *i)
 {
 	struct klist_node *n = klist_next(i);
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 69048869ef1c..d894c87ce1fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -428,6 +428,27 @@ static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void
 	return ret;
 }
 
+static int __pci_walk_bus_reverse(struct pci_bus *top,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata)
+{
+	struct pci_dev *dev;
+	int ret = 0;
+
+	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
+		if (dev->subordinate) {
+			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
+						     userdata);
+			if (ret)
+				break;
+		}
+		ret = cb(dev, userdata);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 /**
  *  pci_walk_bus - walk devices on/under bus, calling callback.
  *  @top: bus whose devices should be walked
@@ -449,6 +470,22 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+/**
+ * pci_walk_bus_reverse - walk devices on/under bus, calling callback.
+ * @top: bus whose devices should be walked
+ * @cb: callback to be called for each device found
+ * @userdata: arbitrary pointer to be passed to callback
+ *
+ * Same semantics as pci_walk_bus(), but walks the bus in reverse order.
+ */
+void pci_walk_bus_reverse(struct pci_bus *top,
+			  int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	guard(rwsem_read)(&pci_bus_sem);
+	__pci_walk_bus_reverse(top, cb, userdata);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_reverse);
+
 void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
 {
 	lockdep_assert_held(&pci_bus_sem);
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 53840634fbfc..7a4623f65256 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -282,6 +282,46 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
 	return pdev;
 }
 
+static struct pci_dev *pci_get_dev_by_id_reverse(const struct pci_device_id *id,
+						 struct pci_dev *from)
+{
+	struct device *dev;
+	struct device *dev_start = NULL;
+	struct pci_dev *pdev = NULL;
+
+	if (from)
+		dev_start = &from->dev;
+	dev = bus_find_device_reverse(&pci_bus_type, dev_start, (void *)id,
+				      match_pci_dev_by_id);
+	if (dev)
+		pdev = to_pci_dev(dev);
+	pci_dev_put(from);
+	return pdev;
+}
+
+enum pci_search_direction {
+	PCI_SEARCH_FORWARD,
+	PCI_SEARCH_REVERSE,
+};
+
+static struct pci_dev *__pci_get_subsys(unsigned int vendor, unsigned int device,
+				 unsigned int ss_vendor, unsigned int ss_device,
+				 struct pci_dev *from, enum pci_search_direction dir)
+{
+	struct pci_device_id id = {
+		.vendor = vendor,
+		.device = device,
+		.subvendor = ss_vendor,
+		.subdevice = ss_device,
+	};
+
+	if (dir == PCI_SEARCH_FORWARD)
+		return pci_get_dev_by_id(&id, from);
+	else
+		return pci_get_dev_by_id_reverse(&id, from);
+}
+
+
 /**
  * pci_get_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
@@ -302,14 +342,8 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       unsigned int ss_vendor, unsigned int ss_device,
 			       struct pci_dev *from)
 {
-	struct pci_device_id id = {
-		.vendor = vendor,
-		.device = device,
-		.subvendor = ss_vendor,
-		.subdevice = ss_device,
-	};
-
-	return pci_get_dev_by_id(&id, from);
+	return __pci_get_subsys(vendor, device, ss_vendor, ss_device, from,
+				PCI_SEARCH_FORWARD);
 }
 EXPORT_SYMBOL(pci_get_subsys);
 
@@ -334,6 +368,19 @@ struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 }
 EXPORT_SYMBOL(pci_get_device);
 
+/*
+ * Same semantics as pci_get_device(), except walks the PCI device list
+ * in reverse discovery order.
+ */
+struct pci_dev *pci_get_device_reverse(unsigned int vendor,
+				       unsigned int device,
+				       struct pci_dev *from)
+{
+	return __pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from,
+				PCI_SEARCH_REVERSE);
+}
+EXPORT_SYMBOL(pci_get_device_reverse);
+
 /**
  * pci_get_class - begin or continue searching for a PCI device by class
  * @class: search for a PCI device with this class designation
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index f5a56efd2bd6..99b1002b3e31 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -150,6 +150,9 @@ int bus_for_each_dev(const struct bus_type *bus, struct device *start,
 		     void *data, device_iter_t fn);
 struct device *bus_find_device(const struct bus_type *bus, struct device *start,
 			       const void *data, device_match_t match);
+struct device *bus_find_device_reverse(const struct bus_type *bus,
+				       struct device *start, const void *data,
+				       device_match_t match);
 /**
  * bus_find_device_by_name - device iterator for locating a particular device
  * of a specific name.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3fac811376b5..b8bca0711967 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -575,6 +575,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
+#define for_each_pci_dev_reverse(d) \
+	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
 static inline int pci_channel_offline(struct pci_dev *pdev)
 {
@@ -1220,6 +1222,8 @@ u64 pci_get_dsn(struct pci_dev *dev);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 			       struct pci_dev *from);
+struct pci_dev *pci_get_device_reverse(unsigned int vendor, unsigned int device,
+				       struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 			       unsigned int ss_vendor, unsigned int ss_device,
 			       struct pci_dev *from);
@@ -1639,6 +1643,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_reverse(struct pci_bus *top,
+			  int (*cb)(struct pci_dev *, void *), void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
@@ -2031,6 +2037,11 @@ static inline struct pci_dev *pci_get_device(unsigned int vendor,
 					     struct pci_dev *from)
 { return NULL; }
 
+static inline struct pci_dev *pci_get_device_reverse(unsigned int vendor,
+						     unsigned int device,
+						     struct pci_dev *from)
+{ return NULL; }
+
 static inline struct pci_dev *pci_get_subsys(unsigned int vendor,
 					     unsigned int device,
 					     unsigned int ss_vendor,
-- 
2.50.1


