Return-Path: <linux-pci+bounces-40793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32426C499BC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56160188CD3D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640730216A;
	Mon, 10 Nov 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jy+o4kJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F063009EA;
	Mon, 10 Nov 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814076; cv=fail; b=ITB2vx63yU8xZ5gw9vHsKG2yyPg27K5dXfG+HtQfqlhGCFDiLZTVILInzgMX8FDTmCitmWsyia1GkScEeAveF5i/CMvRxLbLNNVqmAMb0cakbeQyvsgKFgKL95AcwfLUue9wLp+bGvL4ZmXKEAStJHm9ldkaSDqjLHNlQpk+C0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814076; c=relaxed/simple;
	bh=0sos2Ez4AY+vSl+Tax/Wi4Z8J7QduZL0Re46Z8p9eKU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=F2O77mbJV4xx7z4o9jEVDgPgxmHT1ru+B6PCN+39XuslBz4wCQ+kSPJ1scVjnBkwvEqTtEq3bsoJkRuhqOklpsEqpTUnKtJxkYPZbWuAQXxjtUfwoj5EB2/4B7z0Z5yepcXJntVHwG8MOa7weEI/FXr7Z0nOvndBytHRUn2YbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jy+o4kJ8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762814074; x=1794350074;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0sos2Ez4AY+vSl+Tax/Wi4Z8J7QduZL0Re46Z8p9eKU=;
  b=Jy+o4kJ8UB3t3oGPXgOlq1V6tTDoEJ/V3VukNMAx4Y3LfzVimZF90Vef
   rRd40QWGfTkQRZC9pHRAPJF3gWNx142gW0Uyu9kYxK0+d2E5fvCadFPOu
   DA4ZGLT5W6fXvhh/9ZTYdNj5M0IATfPfmf5D6iIu6kgskZ3ZpSrPyYg6h
   5yY8pp2VmCq0lqR2VkIqTL+qIBEJ5jy3lc6EPNVk5XrUitaMwlNuBp0Aj
   uw1X3FeeOFOFR1Z1MuOa1vvw/91miT1QWe7N68vij0eZJtTtqAP8QI5Ad
   x1sSujiJwyY4UG0hD/qyX6AvHGO8GFTTBcSQ5btcPItseWaLQykQZK37d
   w==;
X-CSE-ConnectionGUID: OMKjyAx8R1SvCjxHzTWLvA==
X-CSE-MsgGUID: qyG/BdCfTwmZ6tBw49a9kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="90341922"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="90341922"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:34:33 -0800
X-CSE-ConnectionGUID: tJ25cxe5RnquxPOuFzgeVg==
X-CSE-MsgGUID: zotyXG1fQ7mKRS8Ivvw4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188627801"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:34:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:34:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 14:34:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:34:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQKGjg95T+sR1sKEXK5Nmk9NjZyBEMa5Cp2gl2fFDL4mOg9kZ38k6+Wz9nBSF5ZsesOA7v7fRo8OhAnYX8eIy9DkIEd4VZqf4XUk8u6Nly8s6oJ1IqwDok82gfK9AEcLG5RDU8FBeVDqnOdaR+YAIatBcWmhFwHzuiracbE/w/uc9asYmH0n5dKw+f+PUZ5uKUOugAWIXdbBKVbORPO3IvdilMbHt1F6Q2tEqVivEMZnelsXl0Ej6seR6WM+0rFIBEAH8nrMR3GgQtYbL/smz/xkvY/+3yxwEy8xs4VtkPt3VWhqetIWYayKG9BZycxUGlJxXv8ssDugx1btoE8i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/fY7tvI5R7rAsEHMgLP+uXYW8XH0Rx4cWFzDnIBSGk=;
 b=idSS6RT2a0hXEwpeFiqvydw0q+Fv12diy8EWMi7BB16vGZY2vY7lhB/if1RLLUaDDnZ5GSTKtTYDWuYdceOonoWaavs0FtTsL9Fc5G/jsiosLd3JLn8AKrDnDQA4Csf66kgWj23luhAvwhrup0zf9BPjREFoTHP90lVTHPeE1YQq4Np9etGa6mAcwjLysMricxbHgodEQhDkQQL0phB/EVoz3S53TbkIjBfr+eWRtQD4WYq1lXnlEG4ZbjFcWKQ4rIikvvCPnqiRYTwFTsPtfxBc0Dh2vXe8o2csR58tiN03kOIVaunjrxvTX2iFVZpX9NUjFw4eROIttPlkIIf/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 22:34:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:34:24 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 15:34:22 -0800
To: Balbir Singh <balbirs@nvidia.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<peterz@infradead.org>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Kees Cook
	<kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andy Lutomirski
	<luto@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Message-ID: <6912767eb60ac_1d9810070@dwillia2-mobl4.notmuch>
In-Reply-To: <d6ad21dd-82f1-486e-8a0d-b007b39b4d32@nvidia.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <d6ad21dd-82f1-486e-8a0d-b007b39b4d32@nvidia.com>
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 7deb052e-38f8-4a71-1d62-08de20a94cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzY3Z3Z1SDRkTnI0L1NJRU52OW1MM08yaGlncGsvTDcyOFUwUDgyNWdHN0pK?=
 =?utf-8?B?c2JFMWIxOEc5OVRLYkxrNnBDV29FcnN1a1BhUjU3eWFpNVdoV00xK0dFdUtY?=
 =?utf-8?B?YmM4d2x6bjV6UzE3NmZpeTBFM2U4ZlUzbks4NTMyQTBFTmpmektxdll2ZUtR?=
 =?utf-8?B?Vy8vMVpuT2s3aE9lQzZ2YWJDVWt5ZU1hRjh1ZU96cEl5MUJGdFFRb3ZEOHJC?=
 =?utf-8?B?cUw4dHRLVkk4VG1UUnZkTzUyZnJHc0J6NDJKQ21RQ25BTncwa09zbmlRdDZG?=
 =?utf-8?B?cnliNTFGWGVKWlZjbUI4bm1SNHFObHBBRVNRZ3JuRzYrdnQyb3cxMlpoUFZD?=
 =?utf-8?B?L21YbUlvZUVHU092OVNUWWhQZG9sbmVOdU9rVzVKWjZkQ3ROS3pVQ1lBQ3B0?=
 =?utf-8?B?T3JHYUl3T3lDTnVVS1BmYk16Qjh3a09Kb0YyK3lxZndpUzM4KzZEK3pIWmtr?=
 =?utf-8?B?NUpZN0o5YlFRS0t6aG41NGR5cFVOZVJhK0JxODFFS1MrZHJiRTJySEZQVnZF?=
 =?utf-8?B?ZHhubVg2aEN0QXY0YkZLRjFtVEpIenhERzZDcUdnZTNOeWRVc2JkbzhpYnFj?=
 =?utf-8?B?Ui9lTnYxak9BQVVzK1R2Q1BVL04wblQwWkFaZW94M3Y1Sk5LaUNKa2dYTk9y?=
 =?utf-8?B?U0hQdmZydEl1UDI3OUYyVHIzbkJVSFFGdk5SU05mclh0Y1YwRVQwNVZUNUJv?=
 =?utf-8?B?RXd2WktkS3RHUDdMamNwWEJhWlVuRkZlVUNUZlpMN3pONGE3YTAyUlpGenFp?=
 =?utf-8?B?MXdKZ0JteGg4RXJLcU9BSFBva3FWamhHVmc0dENvWHlkUkFpWFdwUmwrQVla?=
 =?utf-8?B?VkIzV21RTm91bWdWb2gwdlNMYlR6VkxsV25LYUtpN1FaYzlCQTcvaUs2bVlk?=
 =?utf-8?B?aUljOUx3YjVSVFdXZW9DVlNlMjVzbVlDVGpXOVpRNFJDV2xTc0ZESlhjdFY0?=
 =?utf-8?B?UXI5NTUxWDA4WkZXWUoyYmU1L3JKM0IyaStHQWp6Tm5VQjE2TWE3OEZ0UmxW?=
 =?utf-8?B?eEJaQTVhdStNN1QyYkFMOStiMnBHWGNyK0tndkNRVlIzaEVPWFVHMEdKNGJz?=
 =?utf-8?B?VWtKZm9KV2tEVk0rUWdjVVExd0t5enREY2VRRTFQYUxMSGFUYWo0YXROcCs3?=
 =?utf-8?B?M3BvMzBjS1NvUm5NcUY5blFTbElDOTIxS0lvSDRKYlNlS0l1Y0VqY2Via0hx?=
 =?utf-8?B?SmdIYWRYaUJTMEIyMHltdS8yVUhzc2NpWXA3cWVRcTFrRnNOeU9DOGJONk5J?=
 =?utf-8?B?a1NaWFFXVmRkY3h6MzdWMHhnMk1IamM3WnlJUEo4YlVNQVBJVjc0clgxMHRS?=
 =?utf-8?B?cjl0UWNIVjdhZFhkTzVJRG5uQTFrcXdDamM2ME9OalQ4WmV3TFdhVlRJUisy?=
 =?utf-8?B?eG90Ulo1S3hyWmp0UnM2L1dnT21VNmNsa0ZMbVdqdGpVOWdZaXVPMjFIUHU5?=
 =?utf-8?B?cEg3dlFzbGdnTTNqVkFhZk5SNkdJRFZ0RmRzWjBFMlp2d3JkNEZLb2JXZi9N?=
 =?utf-8?B?aENmcnRkc01SZzdSbUd0VE5rb0xWOU9FY25vSUgzVWgreldJZ2QwaVpPZXRv?=
 =?utf-8?B?dVNaSjB2WHhaZEFOM1BJRCsrOXBpakNxNE11QURFY1M5T2pwSjhZaW5qUFB1?=
 =?utf-8?B?T29nZzBmd01HS0pzMkdUbHM3eStlQzJxdGNqR21ROGIxbGxkSGZCRXR5MUdy?=
 =?utf-8?B?eXVzaFVMdTB1SnVNZmZQbHBWbzdZZDVZS1hud3A1K1lBT1JkMzdCRGlvYVlo?=
 =?utf-8?B?ZENldEJudzZhYzlWU2U2bXpWU21wQmM5WWxlN2tOUEJCM29nSzVVbjVNcnhF?=
 =?utf-8?B?bHV5NDV6YmFWc1VNb3ZaUXYzSTRwckJMclhhZkJURG1rSTh6TkxtSlQzOGdP?=
 =?utf-8?B?cnljeEpjRGEzWThoSkNQVmw1SlowWU9BRVNsdjY1MnFYbzJCQ1dIZVY5czNY?=
 =?utf-8?Q?pO24X/xacNyPQi0s9gDEPRlwcbw8p0HC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVOd3BSaXpvWlNaQ0FzSjE4YW56bTBYL3ErbElXd1Ixa3NvUGgvTkZkVERN?=
 =?utf-8?B?YVlwK3ZQRjRRZjZXRjdhVGVoSlZGMFJOL1ZDUTZ0ci9TanYxNlpaVlVNQytv?=
 =?utf-8?B?dWc5NlNwVGxtOStNNVc4T3ZCSjc1TTJURGJpTm5mV2FRbGxyVXZSR2NReGZa?=
 =?utf-8?B?V2JrdFpTMllQQ2ZRazYzRWRrK3dHdFBGakxxNCswbkJNRnRCcmFoT0pvS001?=
 =?utf-8?B?Ni9NK1BZdnpsb1o2ZEpsR1dyaitocVRQOFlZbHoycXNJMFFrS2I1YzNzQmti?=
 =?utf-8?B?VTNQVU5oeUczVE1mWkVKMS9iTmNPUm8vNzk2RzZCZ1RzTFFYSzE1Q0dKbWly?=
 =?utf-8?B?ekhTMFVENUR4QlA1Q2tIUXZHbHJiN2x4eWZxS1hxN1ZlcnpZbDUxQU9BeFNB?=
 =?utf-8?B?UmZmSms2Mmo0VW9PajI2N2pJUXhwTjRRWFE1RmdsR25HSERZby9DUWhCUnJE?=
 =?utf-8?B?NXZHUDQ1NGtEVVNrREdsQnUzamRmMGpuOENFNjlNa25DR0ZhdVlPL25hM1h0?=
 =?utf-8?B?V0Y3ZGFTWUlGSitzWFVUeEhlajZlWTZDaGFiMlhRUHJEbWxXUFdydklFVy9E?=
 =?utf-8?B?UFJUMmx1R0lsWlhlT2xQWDl2RzBvVURXRmI2bndPNmNxc1RlbUNKUkhQVVV1?=
 =?utf-8?B?MHlON2FQbHM2cEIxUVZmRUszNWRnQ0ZiUnNuMzNmSlREa2ZKUHlPM2pGVkg0?=
 =?utf-8?B?Q0FBeFVITUFRcFR3TG9WcjJZRjJZaktrN01MaHNScUxPSWk0dWJVajJ2dGdt?=
 =?utf-8?B?N1FBa1BHUXRQeEFxQ3pVdTBYUUgvbDFDdmV3em80RElnMFArTnRwUGMvMStM?=
 =?utf-8?B?dW1uRHVGVjNsSG1GM0hSdm9GMy85dXo4dVhJQ2t5REU3aXR3c2RUUHAyYnk2?=
 =?utf-8?B?QlVnbnlublZZaGlUbE1BWHN6VVRuVUZVT3lZQ2duOHNncmtNd2x3Y1pOeTYv?=
 =?utf-8?B?MFZHQTNpUjg5d3NCdVgzN1ZKY3czcFA3SkdiVzlCenE2ZUU5UEV2R0hDelBs?=
 =?utf-8?B?YW4wUGhZQ2VBeldTOXZLOW5zV0MreHZiaFltVWhuUWJSYkFGMWJDMWVRRVVQ?=
 =?utf-8?B?cEJYTmZ4K0x2Z2NzOHdOWVRaYkMvNVRUdmlBNC8zNFpmcTVuRzRjQk0rNFBl?=
 =?utf-8?B?QWR2WGVoQWN6TzBmSGVQR2lNeTVId3pURGVRY1ZlNkxGODJ6bDJVdmNrZHNJ?=
 =?utf-8?B?aWZJK3N3OUVpTXpjZTRkOTMvS3JpNW5CWHRLd3lvalpQZTNkZGswWUpIdnEz?=
 =?utf-8?B?UmpWTFpKWVJOdWtlVG42ei95U01aOVlvUm1Pd0JqTnd1SVFBT0FBMFZXMUpZ?=
 =?utf-8?B?VnNwWTVLSW1wdGFTSkZpaG1aSFh3Qi9ubkVoa0NCOEp5eVl3YWxoZVRhVVFR?=
 =?utf-8?B?OEthTElYQmxsWUx1bFlZMW81aGwzLzhyVExVRVN5bDJQcm5tdDN5QWxtdGQr?=
 =?utf-8?B?UThnT2RXdzhUMXFRSWNBZE9tTUdNYVF4elhKcVoyQVR5RnFYT2swVkdTbWNY?=
 =?utf-8?B?N1RPQjIrTTByMnV4MlVIMTFnYmg3ZFYrbW4zYXk2MXFCYnNXTWlVYmR5TWt3?=
 =?utf-8?B?Z0xSNDNSVjdFVjVLblNwMXM1T1AyUit0Nk4rZXRRR05sc0Q0RDJ1MitBSjBR?=
 =?utf-8?B?bHlwdVp4Y0xKdXBISXNUSkdHSUxxb1JreGRaMXVFWXYxQVZYa2ZXTkIyNzhT?=
 =?utf-8?B?cWYvOEdPVkZ1VnNZN3BXbU5UQlFPY1lGZWJxL0FWYzZrdlBMdUFSdXlZb1lq?=
 =?utf-8?B?Y0RlT1k0YmNITWRqNnZNcys0QXorMTNHK1BYZjVMaGlNek1hczRNUDB5QmJE?=
 =?utf-8?B?VkNRLzVPVW10Z09iREhON0dqcFBua2orSVdtTjk2S3JjZWNDSFc1Q1lQTDFv?=
 =?utf-8?B?aURsUDRBUElVbGU4SVhKanFtK1lkRWFubHYyK2JFRHRaR3V3N3FIdG9NazNO?=
 =?utf-8?B?WjJQcGYxOUVHcDVXSEtPV0dPQXVUYUxhbE5GT29CRldxRXdna1dnMHFpeEp2?=
 =?utf-8?B?Qjd1MGEwWGZqblQ2OXZnNXk0VXBtRG9ZczcyYUNtK1RGN2JSYTZxS0d2WWZn?=
 =?utf-8?B?Q2o4a1F1Qm9TWi9nY3NsV3RWRU02NzlKZHo0QlpKeHorU2RVWldMeU9IOHlF?=
 =?utf-8?B?SmR5SS8wUHBQcWNJSVQxekpJcUFqbXd1TWxZWVhXSGdHa2x1ZWxlU1k5WVd5?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deb052e-38f8-4a71-1d62-08de20a94cf4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:34:24.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTRPWcjAAP3zL2dgAx/DvOtsVQxlnWz4IbYrzA4JJbMj5fEYv+37IdipGyXyKI9DAUFakHNPFYDBBb2r/ykjSZojh6IIGJdC063q+rSee1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com

Balbir Singh wrote:
> On 11/8/25 13:32, Dan Williams wrote:
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
> 
> P2PDMA requires ZONE_DEVICE, Most distros have P2PDMA enabled, you mention
> smaller devices - are you referring to kernels/distros where P2PDMA is not
> enabled and only ZONE_DEVICE is?

There are 2 considerations

- Occasions where P2PDMA is disabled, but ZONE_DEVICE is enabled.

  I started looking at this after a report about CXL failures with KASLR.
  I do not have the kernel configuration for that end user report, but I
  can only a imagine it was indeed a case of CONFIG_PCI_P2PDMA=n and
  CONFIG_DEV_DAX_CXL=y

- Occasions where ZONE_DEVICE and memory hotplug are enabled, but ACPI
  does not publish any hotplug or CXL memory ranges, and BIOS did not
  find any large PCI devices at initial scan.

  In this case even the default 10 TB padding is overkill and more address
  bits could be consumed for KASLR entropy.

