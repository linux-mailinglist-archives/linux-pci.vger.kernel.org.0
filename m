Return-Path: <linux-pci+bounces-6032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5589F32A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2106428AC02
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2715D5C9;
	Wed, 10 Apr 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M43eoYYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B56158DA7;
	Wed, 10 Apr 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753453; cv=fail; b=UsekCpeDo/t1zTpieCYwT1WcZcylgfOgQry0oXRC3S1PHiloLKxEiX0NnpAOGSg0BRrWeoCw0U+ZwEywl1gaORQ1l123y3ElsftSbOo7CkgvTVL+krJCOfHITLzHRrBKcb0DpAbXwv3eRr1MQOkfQStmtmmeKHtUoby7nC6fiUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753453; c=relaxed/simple;
	bh=JOcbFV/kjgSZqoFvbaBY0xKBBSCOuNliwOxiAuyCUGw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHoTJ2pX7/dXawLhHsygpuFogOj3WBK+qUQdbucsYjs8yBppFdh//hV+yIIOJQFnwYvIbKnmLvOdCLh1cjPkTLZvePRKWI0/Zjw5XZu9HGeTTm7fhEVGfAYddBdAujFXTn5aNCOcq85hlDxQrDQ7GwV1jIal3z3j2nmo+ky1bHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M43eoYYh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712753451; x=1744289451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JOcbFV/kjgSZqoFvbaBY0xKBBSCOuNliwOxiAuyCUGw=;
  b=M43eoYYhL8HUy2heWg21fHVSMFyPh1MA5daRJ6RLelWMnP1quFLmoDv3
   BoFdYNCg7Anpm3E5EuQeOHUxN14h5kNdSosRrZqcel9RzaA7MoUBtPReJ
   b0tfchiZuTj3AHaPDwGjWq5vSjIZxMq45lylLvHvXzYttE3EES3JTDZjs
   u+bfRDQQ1AdXrf8Qp1chaA3LzWaeW6VfBPiJXNda1vpLJyGLWMNJJf5+w
   42HDNYIrQBl+sGCFRu5dAzOtP2Ls/xgg1NeXPoEQp8Vqd1xHM6aQkTOu9
   6CBxYMiwDlNjPWl824aM+r8I2uaOaRBTjAT6yyNENFV4Z4l51U34XJ9m6
   Q==;
X-CSE-ConnectionGUID: RYe5DTwHQny2y2BtaZ+lvg==
X-CSE-MsgGUID: 1l8T3tDyRDmM/yOoGafD7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11079363"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11079363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:50:50 -0700
X-CSE-ConnectionGUID: yNb3WiIUSDyEwHg6xxbzjQ==
X-CSE-MsgGUID: /vPyiK0ESVythebt7RQIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25062577"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 05:50:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 05:50:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 05:50:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 05:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNDRw25TqR+GWuqpwsLA30GIKrrV0DFZynfwqWJKtFlPOd8JmOvJPU3AaY9YxAtrePjhYaynd5KogM0p2e0GA91CXcVR0UZQFimq71PUSeNJEloetUXYx8tIfEGtlZIY4RiZ5Ktg5JZbkGdecl0GCJ52IHd0ALGIsMjxA3wJ//ZNWsl7D7WN2yXI0O+BCQ2citGzsIVAoMKw/g1NreXwS0xMw1kbQQhut+nwT7qXT1IujFvawnbL0mVc3E10QLrmyUX/an2GUEjbli3yybpCCJ8Qcb7liAy7yPTYdnnCnRe18GU0HZ+sfa82d4qvnt22MYUx1je+lyEa1igxCTzM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkF8Oa6Nu2wu3o/g8KX7f9zQftBOBh2DynP1uQKw668=;
 b=HDDsgwWCh/uXyJ3jmRaJq8QkekrefoSpAs3lZUTePU7ly2+1LMveyJaCOfudCgdb3k2EN5FN2GT9r0ltyKbvG0MmKwrnjlDdKIvFu3pZT9m0g9vuEVZxVpOkMylwTSb74UWn14R1kFVXmPt9M6IijAvM3kJrHt2WTSnHxHY803eknZOQzUG8/5q4GbRVenawXF+vCzeK3zSh+k8bAHefk7YUMK35TPNxYDB0KyaNTfqa5IZZXU6Cq1dWvFyu5Xo5RlmPT1M5l/1tC7psr7TGsSZMVDGvJUeU44m1vc5f2mrZSno2Y0GrEFrE2kKib9Yx3e/AE7TP6IhitdtEpze0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 12:50:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7430.045; Wed, 10 Apr 2024
 12:50:46 +0000
Message-ID: <c2f5b7c7-44d0-44d4-b837-0d689b22a1ee@intel.com>
Date: Wed, 10 Apr 2024 14:50:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann
	<daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <ZhZC1kKMCKRvgIhd@nanopsycho>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZhZC1kKMCKRvgIhd@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5868:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3WSRxaMvVpsBuEeykKg3h7DuKgBKr+fGGwOhA15/bojE1FAX2sW+bX89L2lxYPKv1bzJmOgvHJWuwKhhyYzJaaNDMeKoBD8orBSIL7F09tRqynvLyPJoHho+fDIoyBN9mdtJBYbsilZW4xxwEIehqL4acejVngGPpxvpmznl/LODZxGSAfprgH+0XMPA7zSFQeeXcQJi25jgDxnVrxBadGqPGELPnHNGW08Td//JMuQbrucTasxMovtwpgUU1flnw+khmuTa+E55dlNS+0fMLkPBoRgSVro/9wO3jsPKPOWT/zyoBb988MsvGiCeoa4cOFqoXy8+TcXGbzZ/ty1MU84EkmP6n6eFDPCV5q5OsvwMsaKreeJbhA+Kf3CEFxlEJ+nDWD2nSwTl3FkDIq6bVGXmE+XSG/KVIt2Pl13P+qEyOVO6QfLhSaoLjPDoMl2kc+gU89qVREUKRCEOf+AuOU3OxP7AWQ42eXmzgl0iOoM0Wuv4cnOGb02luqLFkGm9XZ+pIkcEG5bDAijvZkZkiZw+cqcN85RYTqbjdw8cRoYlahOuiGrevZQ2yj1F0n8TxOvI3zjTW4bbI0XQUSXXntp+KuR4E6nSktJX9tBc5HmM6PNx/Jn98ShxB3RDedqUK2/6D9b6JjlnvLOOC257NZIYI1eh0lfxqYc8xjvA4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpPU244blpEYkdOUWkzalNyWTEvZXFuaklNb1MyQ0s0d2tIc0UySkpwd3hG?=
 =?utf-8?B?SUVWeHZyNWdjN0IvL1JPbW1tSlEzK0Z3bGs2TmtSRjJIbW9NaWFodVpMMUNV?=
 =?utf-8?B?L0FacnVSLzhqdDJyMjljbHNuVnBjWk5weVBqemZFN3FaVWZ0U0R5L2lsdU90?=
 =?utf-8?B?RW9vZk1rN3k5a1dBRE13SVRQVVZsOENic0krYU1VeEVzUHF3eFZBbVAzZ25x?=
 =?utf-8?B?Z2IyWVdvQVhYTWFoSks1Z0RUbkVWRERWNzRkaFYxYytCdENjSHZPNkpxeXEz?=
 =?utf-8?B?bmlZNE1GQVBjZnRPbjZIZVI0UDFnZURkZjI1STMwVStVWnJ4QkwwWFMrUWRn?=
 =?utf-8?B?TGlhMUYzZ3NEWlM2TG10bDJSTjVUTEJlYmVaZmJxVEJqWXhyOEIwcnVSVjND?=
 =?utf-8?B?RzdEM1FLcmY1RnQ1UGFDdllyOW1hNjkwTlU2Y0h1M21TUG9VVkxIaXUrSjdD?=
 =?utf-8?B?bDZVcU1veEdBcVV4RzBmb3BvWTJrYUt6b0s5eFVqbUxmNnZVRnA0dzVMNERS?=
 =?utf-8?B?bWRnOU9OOHhxOFQ5ZmgzSXhldVRWdXhxNG5xNjIxWXdwS0dmeWZwRlhuazE1?=
 =?utf-8?B?dmpWY3oySWpHRjB0MDViTThUdGVob2lVYmpRQm85VlQvYTNoV2JjWHB3b0ww?=
 =?utf-8?B?WE55NkNrQ3E4bnNqaHhCSi94Z256UUp2MDFtUS8rYXFMRTNZRk1xNGU5Smpq?=
 =?utf-8?B?dEFvTGJQYWIzTVRxRStBdmpzNnl2WXBFWmM5NTErYjUrS2lZd2UxOTZlR0Fn?=
 =?utf-8?B?ZWZoeXVmY2Mxbisxb2tHOHk1Q3JQSTJGMlZLUEN0MFp4bDhaWEtobEx4MjZ6?=
 =?utf-8?B?SzZEVThzWlVuWjY2bUFkRlp3WWx2NzQxZGljaUNoQzBXRTFsRDVNdFV1OEFr?=
 =?utf-8?B?WHpUTmU3WXMzTGY2cjFPaUowNjY3N3hEWGE5WUgyUVd0dW9WZTYxUmI0V0dj?=
 =?utf-8?B?OFZXQnV3cURlT0pkaGVQWVptY2xjbXIzYkFMUlFHYkM2cTErem5XOGNUUGtv?=
 =?utf-8?B?Kzc2czRMQmx5OFlXekg2bzZKdUlKdGFrSmVqYTcwMjlXQ1o2Y3o0QlBtUjh3?=
 =?utf-8?B?QitjRGVtVGI2dHBra0ZJTXcwUnpkZVorSjFrNUJGOUMyS0pKQ3pjMDU3UGds?=
 =?utf-8?B?eCtjNlBTc1B6RWJLQWtHTGw0eXBodW5aNFZRc0x3VlhYQzFZQVRzUnR4c3BM?=
 =?utf-8?B?Wi82RzN2NmdwV3JFM1lvY0lYa0VhU0haREQ4ZURlVmRlT1JkdGkwMUd2TGUv?=
 =?utf-8?B?Mk1MYzdmV3Y1dFJlTUI1UlhUUUliYXJ6QW8rRE5zaWpBMUEwK09aQ2NwRWZ3?=
 =?utf-8?B?Zk00a0hyWTVKWUZ0NHIyK09IR2lOY0wvaFNMOVU5WXNGTytGYVFjZXY5Y29V?=
 =?utf-8?B?Mm44Z3k5bCtXQ1NwLzNXT0JSUnkycy9wU213VFM4b3h6WXVsZ0I2cWI1eFYv?=
 =?utf-8?B?UnUvdjNyRVlEMzlYdmt4WU1HVzU3K0ZOOTJWWUkxMStweHFlem1yVHlBcTZN?=
 =?utf-8?B?MFYyWWx1T1dLa0t4bjhDcGpCUUNZdzVkWWVmaFlYVmV4S0U5QktXV1FaVFFr?=
 =?utf-8?B?c3B1RlE2UjBEaFBYNEV6TnJrYmNqbythc3BmU2NBR0h3L3pER3BBSFZORWZt?=
 =?utf-8?B?V20vckgzcmM4M1FqYlhadng1cVJHZHovTUp6dXpVUFNKcnQzTW8zdkorMHIz?=
 =?utf-8?B?bng2RldhaC9POTVDRWtGOUcwZU1aWHRFMFB2QWtIZzAwUXIxK0RrZFlLRVJi?=
 =?utf-8?B?bFdvZytqK253YjBHSEJqT2dHTFIzRWhzdTI4dkx6TG03N0poMGd0THJQcjBt?=
 =?utf-8?B?a2NaU2dSWGJRRXUrbXh0enh1ZVNIRXhUNkF3OHg3Rk1TZjhJM2NhUFErWlI3?=
 =?utf-8?B?SUljRjREdHRXMWRpNTVabjBHbU1wRzRFbXpWc01qNGF2N05yditJQkRDQkpR?=
 =?utf-8?B?aFhjYnAwNWZiQi9qM3FYL2lMNmF2VXJxV2d1SnNTRStaRXdadkM0eTBob2lp?=
 =?utf-8?B?a0EyZnByNGlTMFJaZENOTGJGK21hQWFQMTlIM3A0eUNoSVRHM2JJKzNxZ2po?=
 =?utf-8?B?c3AyWEI4MmFTajEzMUlFRXNKeE9vNFZPRXJCWnAyQXZCWXczeVEzdTdyQnpv?=
 =?utf-8?B?dGMyUHVKOG01K1Qyb3RMU0tPLzdBalA0M0FSMDNSZzY1ZDZDblZObWNMcUhY?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da6b9b6e-be7c-4917-888c-08dc595cd6f7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:50:45.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VioZ9CAtHNErL0V3N/4gTA/GGnwsHOsqN5JGJ7TT9wRBL5Hui6IjdqYBnlTvlf5/e2/oxWTo8x4+2J7v6Errxussm5eWjZSs95j98YI3xL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

On 4/10/24 09:42, Jiri Pirko wrote:
> Tue, Apr 09, 2024 at 10:51:42PM CEST, kuba@kernel.org wrote:
>> On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
>>> This patch set includes the necessary patches to enable basic Tx and Rx
>>> over the Meta Platforms Host Network Interface. To do this we introduce a
>>> new driver and driver and directories in the form of
>>> "drivers/net/ethernet/meta/fbnic".
>>
>> Let me try to restate some takeaways and ask for further clarification
>> on the main question...
>>
>> First, I think there's broad support for merging the driver itself.
>>
>> IIUC there is also broad support to raise the expectations from
>> maintainers of drivers for private devices, specifically that they will:
>> - receive weaker "no regression" guarantees
>> - help with refactoring / adapting their drivers more actively
> 
> :)
> 
> 
>> - not get upset when we delete those drivers if they stop participating
> 
> Sorry for being pain, but I would still like to see some sumarization of
> what is actually the gain for the community to merge this unused driver.
> So far, I don't recall to read anything solid.

For me personally, both as a developer and as an user, any movement into
lean-FW direction is a breeze of fresh air.

And nobody is stopping Nvidia or other vendor from manufacturing
Advanced FBNIC Accelerator TM, that uses the driver as-is, but makes it
faster, better and cheaper that anything you could buy right now.

> 
> btw:
> Kconfig description should contain:
>   Say N here, you can't ever see this device in real world.
> 

Thank you for keeping this entertaining :)

> 
>>
>> If you think that the drivers should be merged *without* setting these
>> expectations, please speak up.
>>
>> Nobody picked me up on the suggestion to use the CI as a proactive
>> check whether the maintainer / owner is still paying attention,
>> but okay :(
>>
>>
>> What is less clear to me is what do we do about uAPI / core changes.
>> Of those who touched on the subject - few people seem to be curious /
>> welcoming to any reasonable features coming out for private devices
>> (John, Olek, Florian)? Others are more cautious focusing on blast
>> radius and referring to the "two driver rule" (Daniel, Paolo)?
>> Whether that means outright ban on touching common code or uAPI
>> in ways which aren't exercised by commercial NICs, is unclear.
> 
> For these kind of unused drivers, I think it would be legit to
> disallow any internal/external api changes. Just do that for some
> normal driver, then benefit from the changes in the unused driver.
> 
> Now the question is, how to distinguish these 2 driver kinds? Maybe to
> put them under some directory so it is clear?
> drivers/net/unused/ethernet/meta/fbnic/
> 
> 
>> Andrew and Ed did not address the question directly AFAICT.
>>
>> Is my reading correct? Does anyone have an opinion on whether we should
>> try to dig more into this question prior to merging the driver, and
>> set some ground rules? Or proceed and learn by doing?
>>
> 


