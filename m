Return-Path: <linux-pci+bounces-40794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDEC49A01
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57EC188343E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587B14F70;
	Mon, 10 Nov 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYQDO7l4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811523A9B3;
	Mon, 10 Nov 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814397; cv=fail; b=q/dDgLDz2bU3Y97q/KEYMCGLigNfBeB3uJ47CJqrbBSverZ627dKFDCksKp06zOEUT3Hy3IY3c2vK7G9slpQNhP6d5YICu8x/6fx7DFoharbKABtQVbdMJaK8RNwIVIIbOghuO5IzY1pt06TCB+4YhJ3TxiLlpGrPsrEcTHk/eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814397; c=relaxed/simple;
	bh=WQN3gcohos6DT4c3E84OoCKT9ox568EeDMKYm/MCcUs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=IICiuPQiodlSsWRWgzMHwj/LrAFP0pncOgk49XixM9sCmh1OJPSqbnpb2Sg6JEA7IYlsc+3Jzi9/8keDTtKqfQLO9tCB9HY7ef0b0PDuXkzesSe/2s0xFtTL9CmDG1v11+BbPT8SsU/wce5XfejHEE6dG3P2DqyE6CcX7vkYDsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYQDO7l4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762814396; x=1794350396;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=WQN3gcohos6DT4c3E84OoCKT9ox568EeDMKYm/MCcUs=;
  b=RYQDO7l4bbXAl5czwnpBZ50aJUE42Gq2gIzb1OhQ9ShBwMZHVZ43QV3J
   YyFU4ObbSHzJ4r1mrtE0gGhdcJisjye7hwx8NBFKYQbCGTro0akoeL/7j
   NZQy+kZw25FXnyQw1/+p55BgPx9hIRtBIIrq9TbsNAwqHhlrexIOYxlRc
   /OyqU/y9b0e1KiZ78c6vgXLDavJlrBDHiSkjSTbW+2MXK4ONTiP9bxest
   M/2Ovm8Zt/W1qpCgrxVP7cCXU5HhM8KNszW2LvjP6jr3LmVFbuE1Ii0jN
   LK35kkTni0/gOJpp74jXyDBXiscX+iVudCyw91qh2AY7cesa+tGUjvkg+
   Q==;
X-CSE-ConnectionGUID: XqFP/iBoRUyNgZJuchB/5w==
X-CSE-MsgGUID: VUTQiyZ4SOOTlPBNkEC7wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68731116"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68731116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:39:55 -0800
X-CSE-ConnectionGUID: x68JnzczSCClhMJKucbp/g==
X-CSE-MsgGUID: dqCHuHk+QUKjmzVnW76nPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="193177211"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:39:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:39:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 14:39:54 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:39:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5A8Kw9zPMzEvHvf/GLVzMeoe24ln1m1cEwZ1LZurph34ybxOW5u1hBupU4coIJUP3OtI7GQtFhWjRB9NPUscBnO9dqbiKOmV9OwKls4k1w7jZDbjlQaSgCA3huQL01O6LfxFL3BCK3jwXN3rsLWAjcQqw+AxLnxUgHvq+ZQnLg8cXYSQNFM+46Vhn1kWoi7JlrM8Vxo+V/jSA9oMXt+9L65Yo5x7BU5Iy1Lq1aE0UEpal8s4DO1TYPW0e189k/JKYXDATfD85ywLcdWieVP906LAHtdMxXX4XQJ+Fv7+UQE1pR1K8YSL1LWMeUX+jSctJg6N8hmYZlCxMZXtiKmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYQQRTTwhIpILzk4qUPL0/3tidIyFP555d2ioaOEv7Q=;
 b=gkt6iBW6KoCfYcWKXL0+4ANF3OZECrqn/8AO6rVivY3N7jDC6p5WW1jBR/GiCTLum0aqoRdeTPWke1sLWI2PHFpQ4Td5WGZs2NVSH+aTepVMS8rY5NEB2lNtT91Eu2KdRqyzMi2aWH3+/qn+7Yj4i40EXw7ZM97/Nu4Q6yrQu0AIvFNREipoSfV+ZYcxDcCIVOfUJ+PEVdKYay/fd96U/bCgLNpGHYmz9LRWHpOFImc9YxFslZ7rGCePo648/YCqq9Jhm58MhPb3oYhPvQKe8jFJiGpfSKdKW+Yi/9pE9pbzY7dVEHN/Z5p0qN9oDla/AG93ZMBflurM5Q2ZtOaEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:39:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:39:51 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 15:39:49 -0800
To: Mike Rapoport <rppt@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: <dave.hansen@linux.intel.com>, <peterz@infradead.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Balbir Singh <balbirs@nvidia.com>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Andy Lutomirski <luto@kernel.org>, Logan Gunthorpe
	<logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>
Message-ID: <691277c542497_1d9810070@dwillia2-mobl4.notmuch>
In-Reply-To: <aRA5-wgo6bm_TA74@kernel.org>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <aRA5-wgo6bm_TA74@kernel.org>
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1095be2e-32ff-4295-30e9-08de20aa0fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEplTU9KbWJ2R24wTXA5YmE2Yk1Gd3p4Y01VQ21DckxzOHUxRTZRQ2hZSktt?=
 =?utf-8?B?TzRpTG43OHorNWkwdEdiRVhVUHRrK1RKZk5YejBDYldvd2Q4cmhUbyt4Mnpz?=
 =?utf-8?B?ckJrWWdsNTdLSVhIVVdHNFI3Y0E2cG5LazB0Vld2cDBFYXFmUDB0VlA3dyto?=
 =?utf-8?B?bFl5QVljekJhNDFSc3VjWE14ejZNaTgyeDZET0I1ZllWUW53bUpvVWc5NWN4?=
 =?utf-8?B?Q3BlSmJieWdEYmZpTS9SU3ByQlFnR1grOGtOL2plMU1hZkFSclRMWlVKejRB?=
 =?utf-8?B?NGxpb2FEbHZ5SEhNM2poN0t5OVdFQ3QxS3pmR3NwNXV0R0ZOZ2UyUG0zRVRK?=
 =?utf-8?B?VStvbW5YU056dUlmT3k0eG1DdmpTTDRBQlQrSUVSRG8yeWMyZS8xb1J6U3li?=
 =?utf-8?B?SXNESUU2alVKRVBmdHMzMklsRkt3d29JZzNFZklETmxtSUNkODllcEpaWTRY?=
 =?utf-8?B?aWhIVlhBVUFzVG1mKzh1T0ludFVQOTV0T0sxeUpFTml4UmFDM0x5ZG5FVGpu?=
 =?utf-8?B?ckhHK2hSMDlCeHlLVmdWOUxhSVRkT0tndzExelMwSlJhVTlRREp0Q3B4YnlG?=
 =?utf-8?B?V0JqM2RhUDU1OVhBNGl4azgyc0djNGJ6M01ENVhESnJGTWJIeTBpc0FYTkxM?=
 =?utf-8?B?d0NWdEdFSzRjSWg0VThXR0hZTnprY3hoN09VcVk1L2NvSzBxZGJGYzhvM3ph?=
 =?utf-8?B?dHE5aU03dThKSkdyMzJNcFQxUzUxZ3AzOW56K3YxTjBWam9kRlFiWXFnUFdX?=
 =?utf-8?B?VjhSdDZOTytnRVlsV29DeHRhRG1oVUZPRERra3pHT1gvd1dabWJWUVRoNm80?=
 =?utf-8?B?VkhKOW9wdFFqN0phdjdWb3A5RlhQdHVkeXh5WFNXUmk0M1ZDbGVvQ2VtV3BT?=
 =?utf-8?B?WXFKRHZHYmwrTENQVG5MRnh5U1A5bkVZamhnUEJLVHhRYllKRmhraXZCN2tB?=
 =?utf-8?B?VU1IOFZvQm82cWl3OTQ1WHVSclRCY0VYOFNnWnM2bENiNGErdjc5RkFWd2xK?=
 =?utf-8?B?K1o5RTdhcGt1U3RwOTU3eXRnS3NkQlNJQjNMQUtPOHZpTjRZRWs5cHUrUUVZ?=
 =?utf-8?B?MTZ5SmpBK29mQktkYjhQUm1oVS9WS29ud25xL0ovalgzQk9YZ2Q0TEFXbEto?=
 =?utf-8?B?ZUFNSDZwTHN3ZHNaUC9zeTY4MG5PWkpmYVR6a2tSU3hTMlJFeE1TeUtCYi8r?=
 =?utf-8?B?ZGw5eVZyenBOWk5IR2VHSkFJNW1Kd0lvSVp0eXI0ZzBQUzdJUkNSNVZDWWJ6?=
 =?utf-8?B?Rmxma29SU1JDVkM5YUJWMnBtaTNnL0lZaGp5NkQ1UlkxRXhIb0JablBnMHFo?=
 =?utf-8?B?b3Z3WFdYTElvSGp2M2NDbkxta0M2SmFxcDVrUHg3TnBSeVQxL2JWbTdwU3pV?=
 =?utf-8?B?d0xac1FZdEVKK2YrbnNwZWVoUmh5cE1hcERDd05RZzlXeFFOd2NpRGd5MDRE?=
 =?utf-8?B?YzZ1TVpmVFF4cEIxWnMyaXNxS0VvRmtQUjRaNCtwVGVyUjJxOE1adC9vYnd5?=
 =?utf-8?B?c1pBcGVla3R5NzRnMXAyY1JNSGZ3NTdHd1JuZGIzd082UnB5UEVQdlRvbWV3?=
 =?utf-8?B?dFlDSU5kaE01VGlnTzJXUmx2ZWk3b0s3R3Irc3JMNXV6ZFlNaGVJakVLa09O?=
 =?utf-8?B?SnJyL1ZUdlAwTE9KT2RsbUZGQ2E3YzBMNkV6R3BkWHZSRHBGNFZiRWVkZkwr?=
 =?utf-8?B?bUpTNWU5RU9iWnNxUXV4VnJHRHU5b0wxamJ2TWVoaHJ0dFlsMkE1cE5RRGdK?=
 =?utf-8?B?Zno0UzhRT0dYdUNVeG4wUmNKT211dUxDUVNqY2U3RmpuLzd5SWp6dWhtQy9Q?=
 =?utf-8?B?UVZXUU9FOUFrelR4aDVaRzZ4SFVKRW9xU0orQUp5a0dtc1VqZENieHVKdll1?=
 =?utf-8?B?V1kxVWF6ZS8vSHNGNWV5cXhmVGNRMFE4OTYvWTQrbmV4WWxZN0xUOThNd1gz?=
 =?utf-8?Q?08tb+5TA4E71W+c5GS8Lu93wYJVQzRDX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBZVDZYam56VDh1aGp0cDRqQ1ZOM2hETm9ZbndBbUpGeHI3N3psM2dyYzA4?=
 =?utf-8?B?ZE0yMG53M0diZVpUQUxEVzhoM2h5T1NqTk9TZWJlTXBoR3BkOGR6RXdZRDd6?=
 =?utf-8?B?dXQ0SE9hL0J3NldWRWJhTHNneUpCbW9MZk5uY1Jwb0U0MWtkbUJHRkJMbW1v?=
 =?utf-8?B?NWNQZmVPZXAvUis2NVZEOUpiV1o4akZxeGlKU0lkOFV1c2pnQ01KNFA1Tk9m?=
 =?utf-8?B?OWJYMG52U0JYZW1WNVh3MHhaczdKSWVpdGFJc0h3MC9WR3dqelhIcVUrTVpZ?=
 =?utf-8?B?RlVVaE1RWWZORmxmcld6MWt0UUt2endLU2JNRDdXUUxVb2xHM0JTa3luMVkz?=
 =?utf-8?B?d1NTUmd6ZG8wS0JDVm91ZGFBakNnNXpPRENBUkZVbmpTL05UbGQ0VVVrNEgv?=
 =?utf-8?B?ejVzZHBkMkQ4YjBwTm9uM20xNVdWZloxeXpVYVg3TVBhWlRBWkZnNzd0R1Jq?=
 =?utf-8?B?RUZQUHBjRmhTcERKNHVjU2JNM2Z3N2pSVEpJL3g3U01VeFB1amN5UHJaWXAr?=
 =?utf-8?B?bEd0N1pUdzFhb2thbGlqcUppTDd2eExVVTYrdk5xTUtPYk5yaURSZVBjaytu?=
 =?utf-8?B?ZkZkL2U5MlB5cFFuYjMrVW9rVHl6eTFUZlJCRkRLTUlZSzlqYURmL3RZdTl4?=
 =?utf-8?B?dm1TeFc4clQ4QWZ0TVVrOWgwcS8xbzJUTDhlYUQxOVZkZUptMUNscmpaWXY3?=
 =?utf-8?B?dWlqeFVGVEdERC9NSC9zelc5K0JSSjFOZXBDL1EvNVpIN0FTYTJhOVowZXl2?=
 =?utf-8?B?RTR4bXlWNE1CNXF4NXRGOTZVZkYrU0VPZUROUTVCeGkwQk9KY2VEcmJ2UTZj?=
 =?utf-8?B?Zm03ZSt2d3ZmWGdCNnFjYXhqSysrVFJwenlZTzhmOWdEQjlVV2hHd3A3Q3dF?=
 =?utf-8?B?SHo4Q0ZUOEVUQUFyU3NFNm1xUWQ5dTJNVlFNSm9QNHNuT1RPZ2YzeitOMUZL?=
 =?utf-8?B?cXNQdjdvYVFMQWlkTWtqMnA2TWdnMWpITjRMVHBodVJSTlRRckk0aDRndWpj?=
 =?utf-8?B?ZjJCRkk2REJ1SjA1b2lkUzNMM0hvTmh2RHl2d1BMY0crV3BoVWhLNCtRbE9H?=
 =?utf-8?B?TjliZFl3RndjTnE3ZFM3QS9wUU4rZitieEZWR1R2M0wxV1JMWXpPQWhKcmFx?=
 =?utf-8?B?YTZoalZ3QUJOZ2d5VDdCdFVncGt1dGx3QTNRaCt0b0RmYzBNNGxGRnpnZW5r?=
 =?utf-8?B?S2JTa1hNR2ZGWmw5c3JmeTNvdkE0dU9XbjN0dnZIMjRSRldZQzdWYWNtQUhD?=
 =?utf-8?B?WnFzTlMyMmlvbDA5YnpzbHZVNTBkb1pMZzhka3ZXVG9wYU1LUUo5VS9SOTF5?=
 =?utf-8?B?WWRKL01Ja2ZQT1Jpa1RZVVQ1c0pHcStFc1dYR3ZjZjRRemtGa1JWU2YrdzJD?=
 =?utf-8?B?T0pkTTVvdXluaWd6NUJVNlo5aGc5eWFCV0N4K1VsK2VOQWJVbVJraDV5a2ZT?=
 =?utf-8?B?MHByNWI3SGFhNkd1Q0dRSnVzN2lmS1hSVVdxQzMvUEdMK0ZEbEdjNThKN1o4?=
 =?utf-8?B?b2VLZlFOMktGRnZjMGx0UXRqcGxCMkk5dnJsY0FjSkNuVGVhNlNMYm92S3Q2?=
 =?utf-8?B?MUsxOFdTMjhBaGVDSzdvYzRTc2lNR001YzhYcnRWcmJEMnF5aEpaVHo3Nzl6?=
 =?utf-8?B?VW9sRDN3L1NaQnhFQlZZUWxmWWtXdFBra3M5MHNsbnFNUDV1eEF1clorbUhL?=
 =?utf-8?B?bS85OFM0bE5qU2ttYjFyRXNKZndzVG5LUXFlOXRFTkZxbzJhOUFMUXhOc1px?=
 =?utf-8?B?MnY2djdFd3diRndUV0Zob0svSmY1ZzZuUjhmTkNjRmc4ak1GbWFZU0diMzh6?=
 =?utf-8?B?N2p2WkVqOTdzVDMzZFp1RUJETkdVQ1pIQy9kNzlkdGpsQ2xFdUx4aTVKaGdy?=
 =?utf-8?B?MkU2RmRIM2t0S05HYWRhNHVweWo0UDdDalFmZkdFM0FmLzZaVFZidlhnV0Zm?=
 =?utf-8?B?S3Q5bFVPZlUvQm5hZ1RxUHRMUTZTTDdENXVDZ1F1RVAwTDhyelFpMjFrVzZT?=
 =?utf-8?B?NEwzaWJ2aWRxdERjdzlCbTNNQ2RRVVpRR05DQm5KWkljUnhrbjJ1Nk56WldI?=
 =?utf-8?B?aEEvbmtTc0FTZWQzNTRrSk5GSUtHajRJNytIclFVbDg4QUJHY1ZaSkF6RTdz?=
 =?utf-8?B?R3M2cWJ0eWZpa0thSDRzSUtJcjRqNEMzZUhTVy9rOWkxbElRdjE0eGh3alFY?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1095be2e-32ff-4295-30e9-08de20aa0fbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:39:51.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfGiOATMCWhR62QoA3jZGJqDUDi5kreMsLaFBhuAmc+u1KUvzqcXpxLWPa+xBidhmbILZjMy9AFQu/5z51DEIndlZOMIrnDMxQ9b1mMONcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

Mike Rapoport wrote:
> On Fri, Nov 07, 2025 at 06:32:15PM -0800, Dan Williams wrote:
> > Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> > is too narrow. ZONE_DEVICE, in general, lets any physical address be added
> > to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
> > or EFI Specific Purpose Memory, but also any PCI MMIO range for the
> > CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
> > 
> > A potential path to recover entropy would be to walk ACPI and determine the
> > limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
> > smaller systems that could yield some KASLR address bits. This needs
> > additional investigation to determine if some limited ACPI table scanning
> > can happen this early without an open coded solution like
> > arch/x86/boot/compressed/acpi.c needs to deploy.
> > 
> > Cc: Balbir Singh <balbirs@nvidia.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
> > Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> >  # Helpers to mirror range of the CPU page tables of a process into device page
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 3c306de52fd4..834641c6049a 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -115,12 +115,12 @@ void __init kernel_randomize_memory(void)
> >  
> >  	/*
> >  	 * Adapt physical memory region size based on available memory,
> > -	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
> > -	 * device BAR space assuming the direct map space is large enough
> > -	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
> > -	 * to the physical BAR address.
> > +	 * except when CONFIG_ZONE_DEVICE is enabled. ZONE_DEVICE wants to map
> > +	 * any physical address into the direct-map. KASLR wants to reliably
> > +	 * steal some physical address bits. Those design choices are in direct
> > +	 * conflict.
> >  	 */
> > -	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
> > +	if (!IS_ENABLED(CONFIG_ZONE_DEVICE) && (memory_tb < kaslr_regions[0].size_tb))
> >  		kaslr_regions[0].size_tb = memory_tb;
> 
> A stupid question, why we adjust virtual kaslr to actual physical memory
> size at all rather than always use maximal addressable size?

My understanding is that KASLR wants to maximize the known unused
portions of the physical address space to incresase entropy. So a policy
of always excludie max addressable size == minimum entropy. At least
that is my view from 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on
most x86 systems"), someone from the KASLR implementation side could
correct me.

