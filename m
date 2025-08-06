Return-Path: <linux-pci+bounces-33451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D174B1BE89
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 03:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1717618A7159
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34611339A4;
	Wed,  6 Aug 2025 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZi5PCET"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C83155322;
	Wed,  6 Aug 2025 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445534; cv=fail; b=N+78zB/ESdLfr9UhVktSjfMKLdoBRgZVnM2lWudwPkXWcbatUzA9YTwsuviIeqV1ICMeV85HXjw0W0TJ3bLsHWy6fbOQnOEffNJ9HjJjBSbfKQQB0pDRNsdI793IaC2xgthYWh51iEumKWyIATPIJ7Pq2rOJsj2n6lQu9bf54aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445534; c=relaxed/simple;
	bh=SP6thAi4mPGv1KuY/N/tEhiusMmJd/Gu1I3J+0kThJg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=soSi6VUMiPinLE8fPDV9+eB21QIX0PVrvpKpLIHvnsLOswYBBsvyX/z7P3Gd4IZMdlegoIArGTmqSkdWWu84kep8VTY1by7BDXIsljPfELMlXt28Xw6PfHihVPWCwpt1MBq4tCGwAHpc5znEcjtw6tXVaVkJl3Qnzb6PwF2CRj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZi5PCET; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754445532; x=1785981532;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SP6thAi4mPGv1KuY/N/tEhiusMmJd/Gu1I3J+0kThJg=;
  b=PZi5PCET450ExeSs7LZZqqmAkuK2K3JK0nYnnFx/i/doNcV4Lf/f3FaL
   WX5ztnQISfxQcUV3sgl6ps3CrrLkpCP/0Pm/b3FP6nGkRONTqO3MGlQEY
   hnpy/sQ8t3dwG50QgZZfjokkFxF1W7p3+jZFjiUt+RuAxyw9/+1yY6u4h
   S7PwmrnGL4FMiUJbKxx1Usm+7BAMq9uuXg1e1tsv0dcJmrRjv/xTlWYfv
   ztARTdsCF2vOR/Y6rrh40ZL4FtdQwV0CeRyveoamxdv3sNLKoU+AfeqGn
   W4U1M4wPySar/9dOEXciUnLfVGEDHP3OYU8+fvqWsrrvTPLTpdkhpfl96
   A==;
X-CSE-ConnectionGUID: oxxNoDkfQW+ZFoglC62rlQ==
X-CSE-MsgGUID: f0f5SLOqR82Vjl4wS2nK9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67021281"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67021281"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 18:58:37 -0700
X-CSE-ConnectionGUID: Q/JjS1GDTnGzCiBzzv+Lcg==
X-CSE-MsgGUID: paAk/PChS8qazlb4p/zEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164177062"
Received: from unknown (HELO ORSEDG902.ED.cps.intel.com) ([10.7.248.12])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 18:55:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 5 Aug 2025 18:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh5N/0ecg7ybmhj32RxTq8vDtc2Uv/OnLUBIe1fCdyxudz0CmyqYFusBq0rw9mQfJk28RUBmfR7LcrNQWekOQCc4RUsV9y3LnJ9delyu3vsGkdt3o08KunVysUuOf4dEr/1fzOSslA07TyOlUprpwMKReF8uEBnDV9MvLIsdi+KGPcCVn+UvUX113gfq8x03kCtlr3NpRB7F0t2WK/2j8SJqrR2V5WsHSr9awMQobT7a6F5ps4ff0xoaeLhDrf3ayuSqgb70ymuTvUy0mOmRcUKPqhb2rmuFHehJ7jNQK+pEyqq6OLojoXZs01nco+GPc/383uPQMspRYSWAsSIt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiKpljkKLWclgnUNPZ+Fcwwz/mmuL69Lf6JgSfSgHxU=;
 b=ctzkBijrD2Yg5BxxfhgtjttBxOg/RJmWsF0LUd+zYotVbCuxfC8Gpc5kjbZDUVXdeDckEOmxz6FdTSuV3CWZmYJJaZnLGu9XNiccuTTufHXrnGcbfR4omVVZ8Ww4PdPmI/rCDrGcHGRCvsP2AWkPtf1YsaciTC+5/9Cm9kORMjB7R8oMeAuOYYqeTFP7OnBJ1S/2OMj1BqGk5BL/SU2Y0W7y35QUZFcRut0pP91tHmAjP+v4c9SqnzyYxgSja3UJFNZiUFnfdUbMQqsaRmsMvQHMOjMc6x4lRKGheRvRyJnZImNLctqhjjXV+P2UYLzfdf/bMvrP+m4DufQ5io/GSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 01:35:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 01:35:48 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 18:35:46 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729155650.000017b3@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <20250729155650.000017b3@huawei.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: f92bcde3-c134-4be5-d053-08ddd4899200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUNlbzQ1cUhuUXFicVk5U09oUjFBSWNyZnhaem1BRW5kOEtCck8zLzBEZEdy?=
 =?utf-8?B?NHFjQ0g1Y1RRUGh2U2ZQc2pvOE9lTTlDK2t1eG15MmZmcklOc1owamFxWDAz?=
 =?utf-8?B?MnVPS1FzN3R1SFQ5NTVRQUVEczdPWmJiek9UbGgyUDR3VVRXODQ4cXRJZ0li?=
 =?utf-8?B?Z2ZObWNMSlhiMTk3UnR5UEF2VkMwYzM4bnA2YUhYMzBCcGNTK0xhS0tGZzVB?=
 =?utf-8?B?Y2xvZDRKaFNuOEhkNFIyRllvRTF0NGZnazhhRGVCOG9QQ0tUR21sTm5Pc0dG?=
 =?utf-8?B?eUtKTEZYVVJ3VloxUTBqRmhpSEJZa2FlOTJ5M05sRmZNSEtjemUwV3o1dTdH?=
 =?utf-8?B?V1pmdzRRMzNRSXFWTVZXTVhsMHNlYjIyZm1VK0w2bDE2b3YrTDI4bWdwdm0z?=
 =?utf-8?B?ekJxb1pjd2hOQXg4ZHBpUWlXZDNvVnZTeUFUTUxoZ0dZZzdiMHZ4SDloNk5k?=
 =?utf-8?B?Tmc0QU1nVFdhOTNSd1g1WE9TV3hHcGMwd3N3MHc2dXhZSnl4aHFRQ2VBZkJP?=
 =?utf-8?B?MUJvMVRMYlZ4ME5DMzczSUlUOFM3ZkhyQTJlcUM5cjlKQ05mbnF3dVJ6YU5P?=
 =?utf-8?B?b1FnclNPVS9teDEzdFJpTmkrcGJwSXZSNHNwRTJreU1qekdYMG9PWmdKUElY?=
 =?utf-8?B?VC9XNUJvdGQvNEQ0VldVY2lrVUlaZkg5bkNzenhvUGRJZmVPTmhGRVZkM1dq?=
 =?utf-8?B?T2lYZU9CcHI1RW1XcncxdXU5eGtkZm5HQ2dkbHlJNmFUVEprdDBubWVuRnln?=
 =?utf-8?B?OHhMbUtLd0p6LzFBOFowaS9tZ2s0NExLck5aUS9weEtNNHFIWDkzYUFlM1Ja?=
 =?utf-8?B?dHp4cWZpK0RUNCtVcXlRblFRejBnc3RzNDJidDBRVnRPS0RvR016c1hTZXE3?=
 =?utf-8?B?cWxXVGpzcjhtQWdMbm1pYzRLdmozQmJHOWhBQUFjQzBMQlBlb3U0WXNkRWU0?=
 =?utf-8?B?emE2RWplZTNaNUpPdE5GczQraElDeVZoeFNLSzJlYU4xbTJoVktuSHMxc1d4?=
 =?utf-8?B?ODB6Zit1eGJ4UERJZEo5M05KbWNQem9Jd3ZkQUhkNzBLYlEwcHN0WHhlSHFQ?=
 =?utf-8?B?VHJTaTdvcnhabk1VeEZRKytRQmlXTXNiYXFTVnJpbEpObE8zeVd6b2VmeVND?=
 =?utf-8?B?d1d4Uzlhb2JQSnlBY2JJNXBRUnhKRk5ORmNnYmc4TTFidStIYWdPTjE2OEc4?=
 =?utf-8?B?SmJzQkd6SGpETnJudE5VL004TWJrTzhOT3dFVzlHc3RqK2IxVFNnbFJQTThM?=
 =?utf-8?B?WDVhZDhVTXh1MmNialJCNXJDZm9NY3R5cXJuNFI1S09qUWw4Z0d5OVJIclNm?=
 =?utf-8?B?OHo3OUVBRXRlc3BnemFWL1dCeDU1ak5TVW15MVRNMjlyYWRRYlY1N0RybmpZ?=
 =?utf-8?B?eW1uMFZlUmU0Z0hQOFEzQkozSlBGVlhkanlhR3dheldrejUwZi9oajFYbFNO?=
 =?utf-8?B?VXhKckhiVDBqOVVmRi9CTlBJRXRsYmh1d25ETitpRlVLcDhWUUpOSERYVjF6?=
 =?utf-8?B?ZHh1TGhWQ2VNbUFIRitiSlJ3VVdESUlFTzY3WGVrUU5KdFlac2hLSkMrUGN6?=
 =?utf-8?B?eFA3VGlVM3c4U2hSeHFzMjdiQVhGMFloaTRQSVJLWUdOR3dpc0IxbTlvbVY1?=
 =?utf-8?B?NE1jUGh6Njc4SUEzTys5QjQzNHdCSmtKUmRpUWdBZzZySXUxZ2NBd2JldUFK?=
 =?utf-8?B?Q21KRU43YlBMRkhFRnFJZk4ycThhTlpIMWhiUk5DVGFTbkN2T0dMM2FWT0h4?=
 =?utf-8?B?b3NCNmFiQVgvQzB0RExOSTJybzVhWGVRdFFuRnRNTUpJM3lDV3Uza2dXUWVD?=
 =?utf-8?B?cUtuektLc0c0N0dtVXB4ZHo1ZHVVc2NHQStQZWgxQjRPNEtZbFF3WFJKaTE4?=
 =?utf-8?B?OEVVRUFRdG9YMHlhTm9pbUJXU0NhWW5NS3JBQWQ0MFZETUFxME82a0tDQnJk?=
 =?utf-8?Q?aYtT6qQvd9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dXYXZpZElrWjN0M1ZUTmdqdk53Vjk5b0ZDeGN4MUdkWHZuRjYrQittcmF1?=
 =?utf-8?B?QTdVUU9uY2tTNzM5Y2JTRmdxTkNKak02SFJRSXBiL3I0LzdyaXo5U1ZrdWd4?=
 =?utf-8?B?QnhlV2puQTR4TXhjcEk1bGFsWUVWb0ZsbklvTVNpdTVLWnJXOGtzeHpob21U?=
 =?utf-8?B?VzlHZ0lMQ05RaitFR0x0TzFkbzlLYmpRVlpubEQzQSs4cE9VVE8rQVJ1NVls?=
 =?utf-8?B?QXBKMGl4SFBkREdxOEo5UmZCQUNRamlwdkQwcXhKK0ZuVHdDZ21jcFlNcjJX?=
 =?utf-8?B?NzN6bkFiclRBaHBGZnFGRlVQZkpvUjg0bmVTNFV6dVkwWk45V0lpZWRXazJW?=
 =?utf-8?B?VjhaWHM0U2lIYXc4R1VrVnZSUHNDNU1KbEpGNmJQV2xGQnl2TThJUlNGd0RU?=
 =?utf-8?B?UXhlWHlMeTZycENkVkZEZHJTd0pnc291K1VFRGh2WThKbEJBZ3dkVEtIQkFE?=
 =?utf-8?B?QlVWblEvRGFaelRSMFo2YVRPSlIxY1d4eUE4RzRNM3ZJWUQxUGFTdE1hQ1Bl?=
 =?utf-8?B?UWhsVnFvM1dLcjQwTm92S2lGY1hFU2YvTm9ic3hkdXl2OFNjU2hUOGo5OHFj?=
 =?utf-8?B?N2ptdWFDSVhWRGpNNEdzZURkYW9DczhkajlRL2FseFYrR1NtUzRxZDNWZlV0?=
 =?utf-8?B?T2xBTFVhOTBkdzEycHpUMmx2anhYOVdqaE5DMmVHakt2Y2twWURQYmNheEpy?=
 =?utf-8?B?ZE1QWXkrOWpSTnAxUENZRDFhQk1saEJWc1FVaE1lOUZjL3ppMEcwT245Vm4v?=
 =?utf-8?B?U1VqanFUZHoweGpQSm02aFFoZnEySEpWM3JxbUFUcklCck1rUFQzMG5zNE9T?=
 =?utf-8?B?dzlVY01yTzduS2phd1NrMUFUMCtiT3Zycms0Y3JGNFZDN1E3ZElhMXYyVWkw?=
 =?utf-8?B?ZmFQUTVYdmRCZWNTWEN4dVREbkVpQlYvakVXMklCNU5STlBmSTRvWE9jOGNL?=
 =?utf-8?B?bkYvTGJwTFVBa1BpdlFTeUxic05qQm1veGFsc01NdG10Tzc3UUliNVBjOXQ4?=
 =?utf-8?B?SHV6M0hWekhXSnZ1RTQxdUVCeVNHT2Y0am44UVdGVHJHaXJhd0xhRWNnOERK?=
 =?utf-8?B?YzlTeitCYm9SOEhwZ1RrRm5abDVTaTNXeEdZU1liL3FjYTZHTmxPSkZFU0F2?=
 =?utf-8?B?L1EwaHRTNjVua0p3Rzd5cm91ait1aHpZTTluZmRaWnpxVWMxNldUNHFwSTVx?=
 =?utf-8?B?TktyVDBEUHBuTmtxaXlkUEVDdXc0Y0N3ZDBTd2doQ2RMY0JwU0tleGlEQnZQ?=
 =?utf-8?B?R1IrbDhEV3haQnd0VmUrVHQ3bkNhUEQzSFRqaWNmUXBpM1gwZ05DQm1DNWlL?=
 =?utf-8?B?dGJIZGY0OXIxRjFaSHBRY29rdTl1ZURyTzlJWURGS2ZxYUNZd2EwV3gyUzhK?=
 =?utf-8?B?UXFkWWl2OVUxM0JKWGVvNWNjU3VvUytLS0N5SG9pOGhPb0JUc0pzNUlTVUcx?=
 =?utf-8?B?bHBaOUt3dkJTMjlyUlhQcktrMWNYWCtQNlBpQXdZcmZTNVAzcXM3bVJVckNE?=
 =?utf-8?B?VmtzVStwUi9xTGNNelM3WjRaY2NOdFNSVXplamNUTUNZek9sYm9seGNIY2ls?=
 =?utf-8?B?SWt3UHcrL3J0Zlg5cFV4QzlEUlVGNVFPUFBob0NyeE9EcmtEL3FyUGRxdDdr?=
 =?utf-8?B?Qnh6eGdIL21DLy9YdW5VN0ViVkdjWUxxTUhzWHAwMmpIWng4WEx2WnhObmc5?=
 =?utf-8?B?OVIxdlMxVi9sdFk0OWJUN0huaStCb093a0J2S1plUnBuM1dzdGRUY2h6Vy95?=
 =?utf-8?B?bUlTNnBMUDVvNXZLK1N5MVFpbzdFMEdpSkR2WHVGdElCY0ZKRFdqY2c5OUQx?=
 =?utf-8?B?eGhROXl4YTZYblpoTWcrYVJSRmFhYzhyWm5MREZwSW9oVEZXcEt4bXU0WFhl?=
 =?utf-8?B?Ry8vVTl5RzZEOGlzbnRvODMvV1BaL1d3Y1VtYWtFQ0w1VFJHL0dQOWo5QmJ1?=
 =?utf-8?B?M2llSHBoQTZYNnpZUlJ4ZytxQnByOFRHaTZyczlCeWtGWHdDNnJJamd0RUU4?=
 =?utf-8?B?RmMwaWZaYjFpNjhlTlpOMnk3M05mWElrOGNvOVhySXN2Zmo0YVM4cmlQY25J?=
 =?utf-8?B?cHVWUVgwa1pVUGZuYm1SVXdya0NqT2ZnVUZVSEpSWkdubnVqSDJrZzlhckw3?=
 =?utf-8?B?Q3BNS2RNRzF3YzhhMEUrWi9zM3pxcko1TlNRSnpmaUlKeDJTcEVnWlVobFlE?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bcde3-c134-4be5-d053-08ddd4899200
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 01:35:48.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sTG5RXIvlFjBpN2XqIO6w/ZagkwSy1nPnj90kiQYWSv7fCQDEuueTlYg5kwo4IgDjs2V673L6UeqGTchUXKy8Yv4g7Mjhu/+uPkQBadoHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 11:33:52 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > protocol definition builds upon Component Measurement and Authentication
> > (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> > assigning devices (PCI physical or virtual function) to a confidential
> > VM such that the assigned device is enabled to access guest private
> > memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> > COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> > to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> > Userspace can watch for the arrival of a "TSM" device,
> > /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> > initialized TSM services.
> > 
> > The operations that can be executed against a PCI device are split into
> > 2 mutually exclusive operation sets, "Link" and "Security" (struct
> > pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> > security properties and communication with the device's Device Security
> > Manager firmware. These are the host side operations in TDISP. The
> > "Security" operations coordinate the security state of the assigned
> > virtual device (TDI). These are the guest side operations in TDISP. Only
> > link management operations are defined at this stage and placeholders
> > provided for the security operations.
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem
> > synchronizes the implementation relative to TSM
> > registration/unregistration events.
> > 
> > Thanks to Wu Hao for his work on an early draft of this support.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Various things inline.
> 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..0784cc436dd3
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,554 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > + * (TDISP, PCIe r6.1 sec 11)
> > + *
> > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > + */
> 
> > +static void tsm_remove(struct pci_tsm *tsm)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	if (!tsm)
> 
> You protect against this in the DEFINE_FREE() so probably safe
> to assume it is always set if we get here.

It is safe, but I would rather not require reading other code to
understand the expectation that some callers may unconditionally call
this routine.

> > +		return;
> > +
> > +	pdev = tsm->pdev;
> > +	tsm->ops->remove(tsm);
> > +	pdev->tsm = NULL;
> > +}
> > +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> > +
> > +static int call_cb_put(struct pci_dev *pdev, void *data,
> 
> Is this combination worth while?  I don't like the 'and' aspect of it
> and it only saves a few lines...
> 
> vs
> 	if (pdev) {
> 		rc = cb(pdev, data);
> 		pci_dev_put(pdev);
> 		if (rc)
> 			return;
> 	}

I think it is worth it, but an even better option is to just let
scope-based cleanup handle it by moving the variable inside the loop
declaration.

> 
> > +		       int (*cb)(struct pci_dev *pdev, void *data))
> > +{
> > +	int rc;
> > +
> > +	if (!pdev)
> > +		return 0;
> > +	rc = cb(pdev, data);
> > +	pci_dev_put(pdev);
> > +	return rc;
> > +}
> > +
> > +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> > +			     int (*cb)(struct pci_dev *pdev, void *data),
> > +			     void *data)
> > +{
> > +	struct pci_dev *fn;
> > +	int i;
> > +
> > +	/* walk virtual functions */
> > +        for (i = 0; i < pci_num_vf(pdev); i++) {
> > +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> > +						 pci_iov_virtfn_bus(pdev, i),
> > +						 pci_iov_virtfn_devfn(pdev, i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +        }
> > +
> > +	/* walk subordinate physical functions */
> > +	for (i = 1; i < 8; i++) {
> > +		fn = pci_get_slot(pdev->bus,
> > +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +	}
> > +
> > +	/* walk downstream devices */
> > +        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> 
> spaces rather than tabs...

Fixed.

> > +                return;
> > +
> > +        if (!is_dsm(pdev))
> > +                return;
> > +
> > +        pci_walk_bus(pdev->subordinate, cb, data);
> > +}
> > +
> > +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> > +				     int (*cb)(struct pci_dev *pdev,
> > +					       void *data),
> > +				     void *data)
> > +{
> > +	struct pci_dev *fn;
> > +	int i;
> > +
> > +	/* reverse walk virtual functions */
> > +	for (i = pci_num_vf(pdev) - 1; i >= 0; i--) {
> > +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> > +						 pci_iov_virtfn_bus(pdev, i),
> > +						 pci_iov_virtfn_devfn(pdev, i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +	}
> > +
> While it probably doesn't matter can we make this strict reverse by doing
> the physical functions first?  I prefer not to think about whether it matters.

Actually, me too, and in that case I also want the downstream devices to
be done in strict reverse order. So, I do not have a use in mind where
this matters, but changed the order to physical->virtual->downstream and
downstream->virtual->physical for the reverse case.

Oh, this is missing the potential case of SR-IOV on multiple physical
functions of the device, so added that too.

> 
> > +	/* reverse walk subordinate physical functions */
> > +	for (i = 7; i >= 1; i--) {
> > +		fn = pci_get_slot(pdev->bus,
> > +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> > +		if (call_cb_put(fn, data, cb))
> > +			return;
> > +	}
> > +
> > +	/* reverse walk downstream devices */
> > +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> > +		return;
> > +
> > +	if (!is_dsm(pdev))
> > +		return;
> > +
> > +	pci_walk_bus_reverse(pdev->subordinate, cb, data);
> 
> Likewise, can we do this before the rest.

Fixed.

> 
> > +}
> 
> > +/*
> > + * Find the PCI Device instance that serves as the Device Security
> > + * Manger (DSM) for @pdev. Note that no additional reference is held for
> > + * the resulting device because @pdev always has a longer registered
> > + * lifetime than its DSM by virtue of being a child of or identical to
> > + * its DSM.
> > + */
> > +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *uport_pf0;
> > +
> > +	if (is_pci_tsm_pf0(pdev))
> > +		return pdev;
> > +
> > +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> > +	if (!pf0)
> > +		return NULL;
> > +
> > +	if (is_dsm(pf0))
> > +		return pf0;
> 
> 
> Unusual for a find command to not hold the device reference on the device
> it returns.  Maybe just call that out in the comment.

It is, "Note that no additional reference..."

> > +
> > +	/*
> > +	 * For cases where a switch may be hosting TDISP services on
> > +	 * behalf of downstream devices, check the first usptream port
> > +	 * relative to this endpoint.
> > +         */
> Odd alignment. Space rather than tab.

Hmm, clang-format does not fixup tabs vs spaces in block comments,
fixed.


> 
> 
> > +	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> > +		return NULL;
> > +
> > +	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> > +	if (is_dsm(uport_pf0))
> > +		return uport_pf0;
> > +	return NULL;
> > +}
> 
> 
> > +/**
> > + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' initialization
> > + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> > + * @tsm: context to initialize
> 
> ops missing.  Run kernel-doc or do W=1 build to catch these.

TIL I do not need need to create a Documentation file to reference this
file to get kdoc build warnings.

Fixed.

> 
> > + */
> > +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> > +			    const struct pci_tsm_ops *ops)
> > +{
> > +	struct tsm_dev *tsm_dev = ops->owner;
> > +
> > +	mutex_init(&tsm->lock);
> Might as well do devm_mutex_init()

Hmm, no, this is running out of the driver bind lifetime of @pdev.

> > +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> > +					   PCI_DOE_PROTO_CMA);
> > +	if (!tsm->doe_mb) {
> > +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (tsm_pci_group(tsm_dev))
> > +		sysfs_merge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
> > +
> > +	return pci_tsm_constructor(pdev, &tsm->tsm, ops);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
> 
> > diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> > index 1f53b9049e2d..093824dc68dd 100644
> > --- a/drivers/virt/coco/tsm-core.c
> > +++ b/drivers/virt/coco/tsm-core.c
> 
> > +/*
> > + * Caller responsible for ensuring it does not race tsm_dev
> > + * unregistration.
> Wrap is a bit early. unregistration fits on the line above.

True, fixed up editor settings to automate this.

> > + */
> > +struct tsm_dev *find_tsm_dev(int id)
> > +{
> > +	guard(rcu)();
> > +	return idr_find(&tsm_idr, id);
> > +}
> 
> > @@ -44,6 +76,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent,
> >  	return no_free_ptr(tsm_dev);
> >  }
> >  
> > +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> > +						 struct pci_tsm_ops *pci_ops)
> > +{
> > +	int rc;
> > +
> > +	if (!pci_ops)
> > +		return tsm_dev;
> > +
> > +	pci_ops->owner = tsm_dev;
> > +	tsm_dev->pci_ops = pci_ops;
> > +	rc = pci_tsm_register(tsm_dev);
> > +	if (rc) {
> > +		dev_err(tsm_dev->dev.parent,
> > +			"PCI/TSM registration failure: %d\n", rc);
> > +		device_unregister(&tsm_dev->dev);
> 
> As below. I'm fairly sure this device_unregister is nothing to do with
> what this function is doing, so having it buried in here is less easy
> to follow than pushing it up a layer.

I prefer a short function with an early exit and no scope based unwind
for this.

> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> > +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> > +	return tsm_dev;
> > +}
> > +
> >  static void put_tsm_dev(struct tsm_dev *tsm_dev)
> >  {
> >  	if (!IS_ERR_OR_NULL(tsm_dev))
> > @@ -54,7 +109,8 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
> >  	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
> >  
> >  struct tsm_dev *tsm_register(struct device *parent,
> > -			     const struct attribute_group **groups)
> > +			     const struct attribute_group **groups,
> > +			     struct pci_tsm_ops *pci_ops)
> >  {
> >  	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
> >  		alloc_tsm_dev(parent, groups);
> > @@ -73,12 +129,13 @@ struct tsm_dev *tsm_register(struct device *parent,
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > -	return no_free_ptr(tsm_dev);
> > +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
> 
> Having a function call that either succeeds or cleans up something it
> never did on error is odd.

devm_add_action_or_reset() is the same pattern. Do the action, or
otherwise take care of cleaning up. The action in this case is
pci_tsm_register() and the reset is cleaning up the device_add().


> The or_reset hints at that oddity but to me is not enough. If you want
> to use __free magic in here maybe hand off the tsm_dev on succesful
> device registration.
> 
> 	struct tsm_dev *registered_tsm_dev __free(unregister_tsm_dev) =
> 		no_free_ptr(tsm_dev);

That does not look like an improvement to me.

The moment device_add() succeeds the cleanup shifts from put_device() to
device_unregister(). I considered wrapping device_add(), but I think it
is awkard to redeclare the same variable again vs being able to walk all
instances of @tsm_dev in the function.

[..]
> > + * struct pci_tsm_ops - manage confidential links and security state
> > + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> > + * 	      Provide a secure session transport for TDISP state management
> > + * 	      (typically bare metal physical function operations).
> > + * @sec_ops: Lock, unlock, and interrogate the security state of the
> > + *	     function via the platform TSM (typically virtual function
> > + *	     operations).
> > + * @owner: Back reference to the TSM device that owns this instance.
> > + *
> > + * This operations are mutually exclusive either a tsm_dev instance
> > + * manages phyiscal link properties or it manages function security
> > + * states like TDISP lock/unlock.
> > + */
> > +struct pci_tsm_ops {
> > +	/*
> Likewise though I'm not sure if kernel-doc deals with struct groups.

It does not.

> > +/**
> > + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> > + * @tsm: generic core "tsm" context
> > + * @lock: protect @state vs pci_tsm_ops invocation
> 
> What is @state referring to? 

@state was removed with v4 of the PCI/TSM series.

The kernel-doc for 'struct pci_tsm_pf0' is now:


/**
 * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
 * @tsm: generic core "tsm" context
 * @lock: mutual exclustion for pci_tsm_ops invocation
 * @doe_mb: PCIe Data Object Exchange mailbox
 */
struct pci_tsm_pf0 {
        struct pci_tsm tsm;
        struct mutex lock;
        struct pci_doe_mb *doe_mb;
};

