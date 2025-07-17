Return-Path: <linux-pci+bounces-32441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B173B0940A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375031885C17
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9030112D;
	Thu, 17 Jul 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqrg+pVT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9D2FF474;
	Thu, 17 Jul 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777265; cv=fail; b=NblJTY7klFJJSVgpUjQmkh2muFVpOI5I1HuLy8hNTKrjL15lhfciJ1aM7qw+TTVQBXZy9QdffbmE1pbtdhn8LiIhP84MrNJAaNeicagZyAjO4q2mddOt9AuI/LoGSXPa1U5UPPylwBL6pj6xCnrAmXkP0gfFJ7cLUmoZSYB/GWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777265; c=relaxed/simple;
	bh=1n5uFYjVgOYuGGtfv43aAnB72guPPkN3jgRdWBfis1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXEZnYZ18IeoWXSCYea2E08MyHwcFQebbayDtZSJrAB2WKT23kcAgFPqfdJH8o12Oe/fY/qQhZHJCRPbp26kaJzD//BGpNLY58qcxk1m58RhdGmzxGEefXlFG5rba1daxNabgknKg9N0M6Iz6Ttoge6BynkhMUlTVIhRRc4Uikc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqrg+pVT; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777264; x=1784313264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1n5uFYjVgOYuGGtfv43aAnB72guPPkN3jgRdWBfis1k=;
  b=Kqrg+pVTZSvGTDfNymJ4nXrEhRjW3ienavMSKpOqu2PFoTt0yfY3OqkW
   PeysehTHd9se5RHEVyNZ/Ag9gBkv6tPZDqXXL/P26YiIW7qbIqclv477G
   6Zhk6Nd5rUjaPhJRlorWviwx1Bdz2tMskH3tPDQMBLfhRV54FIWQGpfSJ
   Vg5vfq23I7pNkK2qdZxckN+j25009Hrel39IOC6piZLY9YMvnYN6RRJ6E
   BP4lje229QeGJUWylKofxe7AE7OIbQ1UTtR8SZcO2uW3M6CtsYv36Q823
   qNGqAyQ6oKBRV/485+Rf4pLPCtNmiwyUFgbQJhCYeaXPzRcaQDJOhzDwo
   Q==;
X-CSE-ConnectionGUID: ds0KVoeHR7qMfg7qURb53g==
X-CSE-MsgGUID: xEumPkzVQyqBQxfQtrBEUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924128"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:23 -0700
X-CSE-ConnectionGUID: bHQV/lJmQVuVOsHgyKBHqw==
X-CSE-MsgGUID: FHRQAiwKR3ep1cPaY4MSmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254655"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXkSrIogHfOwrIVWUOsDdbVmjV2hpwb4KPBKV5CkE5cVzIYNwzmIfahuAXJSUdNcYYxG3xnfhvUD0baRZcsfq/V85gcRyQ99bIw0Xv5BcH2RsizHz7p88PbVmdxRzukeL8Nk1zoRRCN7Fg504H2S5OYaGA/5ZPumsLapuPPEQOjk5f2ymlMz5JistiSGzH1ldHmPOmqf3XoDIwYuQbai2lQSsBN45OzhCF3rc3FGCnLqv92j6Xu0hY2p7k+rtsHVhZ5LxoDGoclmvLob5BygV6M1aAm+TArxKx9zdHgKU3aFt7erjNMy2w87pFMO88W7AxbuYN17YDof8Vgi4vRyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz0tNETggTM5l+QerpAIDxQh8j6v+JVI+Z6R/alIh9U=;
 b=rAUb/wZFg91qKzIC4I5AlJS2GKtvY9KgK5pclYQubW1tMoNKoGIUEpEpaf+aMMs7YGe/RUUxFCy4sW79ApEP4qAwFWN04GZ8tyyD7BkTIvUXNE2lEmxn6d35gtbzYZpxcPSIvzPd31UdCoyjHrRg2N/52RRst4AvvwT+0fXXfTQpuj50tVL0+/MWMGm37TKrsjJRB1Qk47eAFfKU6aH/PUNWVDEiMPNMdko/aWR+4nFx2VYvDTeeRpE6wsfubJZr8DrTQUi9qi5vO+BrMo2Wf+Asf5JsHOJaf7JtuYJvn6NEqOurPHM4O0kkpdMwIsyKICNUM8C0GxTwWAancbyrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:10 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Subject: [PATCH v4 09/10] PCI/TSM: Report active IDE streams
Date: Thu, 17 Jul 2025 11:33:57 -0700
Message-ID: <20250717183358.1332417-10-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7dd1b6ab-9dc6-4b63-615d-08ddc5608584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZrwmhKLt6Pj3mMLNbJihKzQBGpUNWcZvPwDHjLCcs7eu7hLKhCEIupyfj8uH?=
 =?us-ascii?Q?2TEJlrYQMXU+VdBJhtS87mgYb0MsMUQm5MbZCBCU934MnShv9tCsU7oHmnO+?=
 =?us-ascii?Q?BRilm1IIS8e1eup53YInOrEw7ASWRGKJW8rhakBJ7HesAhUPoeYggm027s8Y?=
 =?us-ascii?Q?uKENnmWvN5rsW+gcKLea1Bfjz569ciYt5m9g0mIWQzZnrK7w1VsRY5fIDlAt?=
 =?us-ascii?Q?P4+7kTBkZmjY8RHeD0sN5c5RNa3PDd6TA7ffMqOWEq9T76NOGUEdRBb998w4?=
 =?us-ascii?Q?oGicnxm7tXD/EoiBLYovZW6+ATYE01bAgGFCtKuVHQpYj4zyXCTY19ubye/+?=
 =?us-ascii?Q?WtTLfQhBx9ukKbF+R+1xYuVPoytTA/Yj7b+aCYLuFxM+c+Y7+87spii24SaQ?=
 =?us-ascii?Q?u/X6F4XnatA32B7/ktS19luA6RI3L3HZsKP9+PHVYB5ML9MJJgPvCzEumhJm?=
 =?us-ascii?Q?4+nMMdTNuvFgMbFJI/u1jGkcfKISsA9ZJqowcz+7/fb6L+dXsHWNlzpmBSVw?=
 =?us-ascii?Q?sTctNx6dQom6QlypVyD4lsNm0Y72X+ZwNkYA+DeTWwaIfgkDbSffOUCPNQg5?=
 =?us-ascii?Q?v8dl42HmxZjQrh1wWnZqexURLHImbjKlfMh8aBrhnryOkE8a55mqDiGlG+TC?=
 =?us-ascii?Q?DeqJsEtxnavG39p0peCf0OjHnuGZj4keKx/SUjhzNGvWpivzX2yjB8Eaaxz9?=
 =?us-ascii?Q?K5rLzOBWBrkc0tS1d/HPJRN+5/S1JKUh/UTyAsK7SFWBR0a/aWSl4wpTgoSR?=
 =?us-ascii?Q?kd8faYE4wf2P8wdtjT96RBWenSH5iYvrby6gmcs9Fs+OvVaaoNeuFsaXNcLC?=
 =?us-ascii?Q?yLBWNvRxhyxiW2Tq2i1Ep6nORmvt4M2btkR2M6wffwVyY6twOPO9rXiXmVOr?=
 =?us-ascii?Q?G6es3zUSJyXsTJkM+9AePX56i2XffzlEF7yrved+3A1s0RCHS73Nx+d9wMgu?=
 =?us-ascii?Q?89Rn37P37RIHEdDT/+VTPbhqChZ86fRLOPNmckCRjOcwmBE7sdf7hTkYG+k5?=
 =?us-ascii?Q?J/nXJxp97ACADs6NK47xZ7YKqyDISqx3iUO51N0FdWRkzvxkAeKqrspB/WvC?=
 =?us-ascii?Q?IGC5U8IBSN9SBs8onPJ9CYpplOkNLFUo7OM67QdXAPNrrm7RXbTnaGveDrY3?=
 =?us-ascii?Q?i8XPLnMd4ZiR7JA3aHkvqtx7alLFRxg4UerJ7n0Di+8MWkqkf6GCLQ2FL9/a?=
 =?us-ascii?Q?DkIRVJoWfY5u2S6yeLbdea7biVa1lMzglo65siRnaPd5lRoBxzYBah7pfWKz?=
 =?us-ascii?Q?lMrZgieLCOVsNR/NyTY8bs58P/YVWXJPvCCJBVJZ1YLELqTkgM35+4USMfdz?=
 =?us-ascii?Q?HMyOykGYcjgthq2OuOAM+6NA7zM0LmaY5j53JmmP3R0f2OuhqS0g2J07szlg?=
 =?us-ascii?Q?X2prlS222KqdA2XS4S3Hzxm7ChncT82YAHfEk+kWiQjWI8rdcM7a67WJbhdd?=
 =?us-ascii?Q?LVsQeidbrDY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fM5ZxGWrr00ONeBNGj61bT1vO7jV3AJjKqCdsgIWBEWiE+a2RNQwrUizSh6X?=
 =?us-ascii?Q?PuA0pbE1JHZEjeglexs9E/5y+sHBjiDxOwqU0XoBUHC/22mLRgAr+2JK1HZJ?=
 =?us-ascii?Q?dHWG2fzJYgjoSotDtXPSz49QS1I4tIxL+ermmS0zqdUkkWfjOU0EfVoTLBl7?=
 =?us-ascii?Q?4JcNzAWP+6GnPeOvUGetGUJykXOgHnCtdUbYTb+0dt6vqV29jLx6MtUSBPjk?=
 =?us-ascii?Q?ovWB9LOnhI8NcpFN/8D5H1nYeLaCmW/E/zVphcexrrSu/l/gy1zatVHlqUJ0?=
 =?us-ascii?Q?yjAcpDMH8gt6GHkLfWt4zN7019rm741EDGDfNSJpIDhUQsr1skUsrUTH5d0t?=
 =?us-ascii?Q?moeMMgxv02oOSfN3CPs5JCQg0VC6qs72Qrg3EzWcx15iOoK3KgufFqscmmxS?=
 =?us-ascii?Q?ogy4pc/pYC/x9GYsqxFVgh3SDTCOz/OL2+8Gfxu2WZUMtw+XB4Uz8lz3oqqj?=
 =?us-ascii?Q?LgeT0Ds3ViweAV0aocP0/5JYy6fMKYQLYacTw1r5CZAbeMU5R7rFHaboc1Fx?=
 =?us-ascii?Q?oFH33bil5RJVoUct975PFo1RAefBdnSlydf4QebxSDiCjW6lA0wrz8LQAgOs?=
 =?us-ascii?Q?Z+rMUZRsLr1MCGtl6Ua0YXn2QDDl83mwn8GLk1D0zjE21b7W3H55k3psiYK4?=
 =?us-ascii?Q?0CkLWrDK4vCvmRPcpW6UaOOhJUDN+3+xMTYi5VmetZ8Tz+g6RVlUAPmTyzch?=
 =?us-ascii?Q?BHUsBp5ihnnJax635OApHmgn0aqO57E3mwunrSPykvWoJ2fT6pl7bCz77Kxk?=
 =?us-ascii?Q?3o0YXohoYxzCXZOuWU7WQ797JEVM4gjq4uryG9xS7JVaizVXGRDqYs30+sMs?=
 =?us-ascii?Q?HJ1YnJquzzMBunyZwpi58ABmiqMOhx6fF0zZN2cYNNCqriewVncYQY1o8eEG?=
 =?us-ascii?Q?07JQIYoWMxeucHLIBkHL19ZCYnTIZf3RNBjS4qGuoF7g1HXEeTbYWkQEpaUh?=
 =?us-ascii?Q?/H4kNOpvMQ59PrMGOcf//PTXMTnSUhZGMk+HPZrYfc19VtR4yFlnOo6+m4fz?=
 =?us-ascii?Q?hHlyxrc99LMPw5T/VY+HBYGqqTqUVu+47T/3yAzX4OTtvQpAxttY+KTz5WAw?=
 =?us-ascii?Q?60FN0RuYlUwrnn1tv4OSPRqwrcQTnumJs49j8t3dAM6EP081OTYBnpdRaAKC?=
 =?us-ascii?Q?6GLRX40adAz/zI07umyMXffuqZ8SzV0D7Phlh00waQ2mlq2FVLL5GkiaFqSr?=
 =?us-ascii?Q?+DMKNQ5Sap3iwRLfl2ljM0RcTHEzPRPbvSYzDGzn1MpFODtVOJR8fJ3ix540?=
 =?us-ascii?Q?7Ainzivdcn4fMQa9PROmZWGU9SUwjNm9ZCi7WCWj3x3ehISDWLi+okMf6AkB?=
 =?us-ascii?Q?3uMt65bwUxa8EywPNBNgk1UA1Xh6EJ2MLwIfXgKXiJIPGHthjj/s8B3hm3Zv?=
 =?us-ascii?Q?bY+0F/BXVYK06K6z0JishxN5bGjac7GtQFHv8xfg7fFArKutg8KIyC0i0Wpt?=
 =?us-ascii?Q?ufWFNlN2ehz43RXF9JC5mXKEOB4yH6N6pYpC/LVznNt3O/ZnHqB+24r/Dt/g?=
 =?us-ascii?Q?3teNslahMOOLEKh7gZO53smaakl+ADRHdfBy/6Rva9eeq88jc1z1x9GFwQXB?=
 =?us-ascii?Q?l6D9LavKTEClAiJ9taM9u6trAyhhw5vMGnAYTBcUaZDqQJlCNcpKljzqkL6Q?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd1b6ab-9dc6-4b63-615d-08ddc5608584
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:10.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxNTsT719/pSw6IZ2ySj8PgExazRMPR4DL8ZNMPV21ZTGPuplO6Gtzu9ukw+I6UiA0DSXQTXYXk45V8pflw2OcMXunXqbJtxzNxIUYb1+MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

Given that the platform TSM owns IDE Stream ID allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the Stream ID.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
 drivers/pci/ide.c                         |  4 ++++
 drivers/virt/coco/tsm-core.c              | 28 +++++++++++++++++++++++
 include/linux/pci-ide.h                   |  2 ++
 include/linux/tsm.h                       |  4 ++++
 5 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 2949468deaf7..6fc1a5ac6da1 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,3 +7,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
+
+What:		/sys/class/tsm/tsmN/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		and matches the same link published by the host bridge. See
+		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index cafbc740a9da..923b0db4803c 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -5,6 +5,7 @@
 
 #define dev_fmt(fmt) "PCI/IDE: " fmt
 #include <linux/pci.h>
+#include <linux/tsm.h>
 #include <linux/sysfs.h>
 #include <linux/pci-ide.h>
 #include <linux/bitfield.h>
@@ -271,6 +272,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
+	if (ide->tsm_dev)
+		tsm_ide_stream_unregister(ide);
+
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 093824dc68dd..b0ef9089e0f2 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -2,14 +2,17 @@
 /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -140,6 +143,31 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_tsm *tsm = pdev->tsm;
+	struct tsm_dev *tsm_dev = tsm->ops->owner;
+	int rc;
+
+	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj,
+				 ide->name);
+	if (rc == 0)
+		ide->tsm_dev = tsm_dev;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct tsm_dev *tsm_dev = ide->tsm_dev;
+
+	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
+	ide->tsm_dev = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 89c1ef0de841..36290bdaf51f 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -42,6 +42,7 @@ struct pci_ide_partner {
  * @host_bridge_stream: track platform Stream ID
  * @stream_id: unique Stream ID (within Partner Port pairing)
  * @name: name of the established Selective IDE Stream in sysfs
+ * @tsm_dev: For TSM established IDE, the TSM device context
  *
  * Negative @stream_id values indicate "uninitialized" on the
  * expectation that with TSM established IDE the TSM owns the stream_id
@@ -53,6 +54,7 @@ struct pci_ide {
 	u8 host_bridge_stream;
 	int stream_id;
 	const char *name;
+	struct tsm_dev *tsm_dev;
 };
 
 int pci_ide_domain(struct pci_dev *pdev);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index ce95589a5d5b..4eba45a754ec 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -120,4 +120,8 @@ const char *tsm_name(const struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
 const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
+struct pci_dev;
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
-- 
2.50.1


