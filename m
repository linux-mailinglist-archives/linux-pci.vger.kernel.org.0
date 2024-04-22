Return-Path: <linux-pci+bounces-6547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C978AD937
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B8A1C20B24
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1544C73;
	Mon, 22 Apr 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtOyhr1I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C044375
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829170; cv=fail; b=AUbVcrz8Wfbh1UCR3dEmHbc0yG2KmUad+qtYhDpYMumfMyqaLhXzas2maQbjdarZVyOmR0yXmdzGvYJ7IfZiKMVCnH6Tl4Qvx6igmWgPmcF1BV2ohMzBbXqt+s8eQcYlzY1fbvaxLwrUwWFHNYp3sr0atEHuM49qovGxeS8dcqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829170; c=relaxed/simple;
	bh=4mO3YtdFuSUMJHE3sG/3IZtMm19iENuPhhbQCMojEB4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n3HTuZMDxDED7ShTLcooE0NK3AcfF6c9OyelyxGTQiUfJbOLL0TQE7FMaiMbNVznVghKkmOt7u/B+ZBbpyTLIvOa8fI3aDlmmFatN4FxDDNCU6Q44yiVVZ2okdmfn/iKJQhpm7pMdrDiiwkwFcQaLRCkP9lsNpBSkoRM+NJ4hF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtOyhr1I; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713829168; x=1745365168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4mO3YtdFuSUMJHE3sG/3IZtMm19iENuPhhbQCMojEB4=;
  b=JtOyhr1I6+QXxaNpwDoj6rsKT42HxdHYtbs/verK7B0y7JUywTSeP7ib
   KoQMxl5WS+oRYIO2e8Gl7NMk9o6BR/yQMkgkvnNrfNubGjNQP7EM7bKgV
   xBkRJ/EyirchIVk1lvsvtToUdKwZnB1Xy+0ZVq3gWFod3V6qnRT/MS4YP
   d2u/zxb3uLuahRPl6xYpllg44SOZa4RCZr5Bc3ceVHRfojKzUYerVX1Nl
   /8TEv50b9XIZUQeezeDX+H2h1ViFTdqq15sbSSPVsFime03MWsKwyVTsx
   yBOJBSU1nFeGkMdVQ5rrj1ZuTfDpl2HGH3leXI8RKbWywoEyuZOySIdg7
   Q==;
X-CSE-ConnectionGUID: mCtwUTk5RHay8N5k9F5J6g==
X-CSE-MsgGUID: PFtEX/aQQUCDfOB5RLnq5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20796095"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20796095"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:39:26 -0700
X-CSE-ConnectionGUID: FJ0u4RXcR1WNFubuVZtjvg==
X-CSE-MsgGUID: l3jGr61tRhe6Fi1GOP/Ozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28688597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:39:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:39:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:39:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVQmQvg+HT5FRiQG/Vsv9bs9lyRSisAR0tHdVeAs3Y5whPJ47ZGmepX4SXUvZ2VF15QK+RrP4diYAxf2f8tYGjGDjM2Md0l0O17lYHceNXsF9pn5QBw2bQjFdtD768PQ4X6uWaDxVVxg/5n8GWVXno742Ei1pbIshwzRk/T5KLqko3Nskmj83LGkbRWAWc6ntso2A4mbgkV9y1YVCvJOxekYW+t4BLkrMBiy5Qv7M5mX+FQjdcDDhYdEoLUEWK8snxJr9lyMaK09wFdCTL7yEfl8EofgBNUz8AiEhK8/7VcaOB5qKrt5e0a7shfxxKT4IOHIyPqFknFd3Ywhjhr47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8WFoKkKnPxBjRCTA/3xTXWV0+n1hXTrM7HT8VoADJU=;
 b=BY1h/Nq4H1mCx86xIWmrA6Qgd0DmJgQef/ltPJdFy2rECy7fbOrciNxdNSCCIAELbc5uw7zctXNejSPan4VUA9TAqcNyvbIap27utCc9VV8ileeDLpnbIA0dkWndE9rgLB9yZTFhK2YMox0FaCFl6ZSfWpAtUOqWajbPaDSediiQ619aX4z08B0srhBUeJTu9hQo7P3FRZwiiNnd4Tg3C9NDnGQrDOI4jPhEyXQcV0+PUdNMn/FU15ByI0Gb5PvMaL7c3mYCYpVSDyrmRBbJLdLrDvZE7myCAK6ChU7qUMbc+/RwKdy/hJNVdIJBgIk7NZ+aNEqNkVfM045xRqXC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 22 Apr
 2024 23:39:21 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:39:21 +0000
Message-ID: <c6dafda7-c151-416c-a6f7-0c142b228b85@intel.com>
Date: Mon, 22 Apr 2024 16:39:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240422225255.GA419484@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240422225255.GA419484@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SA3PR11MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b525abe-82c1-4eb3-fbf8-08dc63256f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0VTMEI1dnlqM3kzSVB6Z24yeHpjRWIzVnkyZUJlTEVoamxBN0xreE9kVklC?=
 =?utf-8?B?aCtyd09PVEl6OG9DbnlXeHI3ZWNLZ0hFWGJHUGNHT2lHTndNZGRDQnFHRkxw?=
 =?utf-8?B?RVZ4dXJWRXAzeDZCZVV2aGg2Y3RTWktQTFBpbjhsSWFWOHVIUllnM1ByNEQx?=
 =?utf-8?B?blVIYm9sQVFYS2VhWHRkWWs5OGdPY3pxeFIwSmFYTkcyRnFvakU1a0pkTCs4?=
 =?utf-8?B?S09UYTVEVXpuSlVvN0xob0hMUHJqNklIL3padnJWcXpLc3ZEeUt3SUs1WmV2?=
 =?utf-8?B?Vkd4WW5qcUJYRGlNZjBQUEkwbVJhZEtCL2kzZ0MvN3lGMGtlTVpKQmlSZEFP?=
 =?utf-8?B?WUJyRnc4Rzk0TjZoN0daRytSdEtFUGxTb1hIYkdrRy8vY0JGR2JiSWZiOStT?=
 =?utf-8?B?Q25DVWpGYmc5eTdoYXozZG15RjFSY2VWaEZNVHZib3haYk5vTGs1b3hMV1pk?=
 =?utf-8?B?WitRb2JjU0F0Sm5GL1RhSFFGc2lKT1JSOUhXMUhxTU9iU1VIYU53VEExMk1j?=
 =?utf-8?B?cWErYk9vMFljRHFzZzRZWU5IUnZ0c1I1aWtVV3ZqT09CYlpUSlBjNXBnN1ND?=
 =?utf-8?B?ZEN4dzJVSzJTSGZwdEhEVnVXU0JCc0NjdiszRC9raWdRaHp5Z3o1TmlOcngr?=
 =?utf-8?B?dUJJZDM3V0swdW5ZK3dzZ1A2M2xYOFR4eWJaeEpqZjFDYUs0a0o2eHo1d2F5?=
 =?utf-8?B?d0VMYSsvUElsQXhCcTVjT0xwako0SXVpRDdiZ3R0L0JRbzd6dlp1Rm1TdTlU?=
 =?utf-8?B?QWsweXpIUmRxWWFqcjVlVFRGMTBvTUZFb1NhU1gvWjJoeE4zOGRrdU5FRVVM?=
 =?utf-8?B?YnV4TjliYWozS3llV3hKTngyYXZuTU9yeThYblpuYmExWjZaUFNzTFJ0MkRC?=
 =?utf-8?B?SnVWZm5acDhDSS9BanlSU0tTaWRiM3QxditVKzJubzRyNXZpOEhWZHVaQ1l1?=
 =?utf-8?B?MGNKQUVidmtWVlFxU014VjBFcXU0cCtyQmRSbk04dEpQUE5ndnVycDhoWjRt?=
 =?utf-8?B?SmZOaFRkMnhVcElIdVZKek81Z20rZnRXVThBbit0OTVkaldtM2ZudFUzMXZn?=
 =?utf-8?B?WHNMemhILzlmaThzcGwxdG9IY3JseE5kcjYvUldvZG5rUlhRYUdUWlFiVzRw?=
 =?utf-8?B?bjg0SUdpM2RPblRERStWdmdQMEl4YXp4NWZLMVhEL0lqMHltRXZrR0QrYU5J?=
 =?utf-8?B?NWM4SG1YdGlMVW93TDM4aUdLdlVkU3l2QXNHWERRZnBwQjVyNDJINEVjK2VT?=
 =?utf-8?B?QTAyTmtSK09RVVZjZ2dsdjBLQk5RWldhazhieHM0TEpMeVNpS0t3T1dRN2VX?=
 =?utf-8?B?elJFU2diNU85NytPWFFSQzVHNWVRL0tDVXNtMFVlSWZReCs3VHlOQmx4RCtl?=
 =?utf-8?B?L2VQYk40bzVNc1pIcFNkVlJEakJhUGZYa3FWaUNVS2VFWVBvUVE2Q0dsbnRW?=
 =?utf-8?B?SmV0ZkI3UVhJeHVscXg5TmpWMFpZKytuTENXWWt2aG02dFc3OWpxdVo4aXZH?=
 =?utf-8?B?YlJmU0tJUzlPRmQ0eDJma3QvdHMwQkpxeUhzNUR3dGdOeXQ2ZUNPQlZwUGVD?=
 =?utf-8?B?anFOWklRN21BeDJPVGNOZXE2TVlydEc1UlpTNVUzSDA3YThSaGlUTEFaalR5?=
 =?utf-8?B?NWN1UEhFQzh6TUlISmtST3VmTlhYSW1BVUd5b3Q2WHAxaGFETGtEOVV0bmdK?=
 =?utf-8?B?VVB6KyswUzUydzUyY05zeU1oQVlCcW9rUTVvdmxjR2M3ZnM5TE5tVWkrRUJJ?=
 =?utf-8?Q?5mw2XeWNMgefR08GaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZ6bGNqZy9ESHdxU216ZzhwZThNb3ZYWitVQTcwaVhGRTRvS1pEc2xVUlo0?=
 =?utf-8?B?bDMyaWxzVjI0amg2T3BkVmgzdmJmdFBBdkM2MWpyMFErbFArbXVxQU9iUllz?=
 =?utf-8?B?UVZvQzQySkdzNmNIVEM4SThmazZkbzR2SVBNTEk4a2hyeHZ1K25ZdkVhVmt1?=
 =?utf-8?B?T2NweUV4ajVRaCs4NnJnZDdhZkFZQ25CeGdpcjdZckkvdWROY3NPK2RZeG9L?=
 =?utf-8?B?Ky90dnZOckVZcVlGOHJFM0ZEMm5BZ2JCblJhSlVnSVRhUzVVWUlvUEJ1YSty?=
 =?utf-8?B?ZmlBZkthTStpWGlldW12dmRpRkRaRFV2dndTZFBXUWpTaFNvSW1ubHEvOGlC?=
 =?utf-8?B?UW4vODJFUGwzdW1sRFZvRVhXRWxEdFVDQjArVTFKanFPc0xITXBuWWs4b3d6?=
 =?utf-8?B?SVo3NXJ2QmVhUkJ0SkNZT1UxVG8rTlltSG1uclA4TytxeFdXT01tcHZiajYx?=
 =?utf-8?B?WnpYVFArcjk1MFZ2NVUzWVlBWmU2SlBQZmdvT3FrKzk2TEpIaC9NS0o4d0l4?=
 =?utf-8?B?QTYxWVFpWXIzZ3Y2WmV0WmhMNUVqK3M1MjU4Q2ZZTXpJUHZJaXNNanl6VFNy?=
 =?utf-8?B?UnZSU0oyWWJkZGI4UCt2RUl1SnJRMWdUajZ2RGNlZGFmUTdzUC95T1NWMC9u?=
 =?utf-8?B?UFliMzZNR3R2RVhhZTV3ZzZRbHpWdGprenpDb0lKeW5YTGExb09PYVFmZ2JF?=
 =?utf-8?B?SkdIWUZwYTVCZldCZmRLb1hNK04vRXdKalZBL25nY1g3WHdzWTJMdldBMDJz?=
 =?utf-8?B?M2x0K3c5dnVOQ0NyT1crYjAwb1ltMkFsQVV4L2ErQnJvN1dkZGdoK2hwU0Jq?=
 =?utf-8?B?anJQdEk1MG9PZlpvZzhGK05CMlhhak9aMFRTZU1hMHRMcWMvMXVSU0ZEcThW?=
 =?utf-8?B?NWVwbXNqc0xmVHFkRkpCUWdsMmtYRTJuck0xSWRCaVZaV3BRMkxzb0RESUNi?=
 =?utf-8?B?T21oM1VkOUlGcitlQkNQU0Nqc0dSdm95VkovZTZVMUNaM1ZEOHZLSWxqRm04?=
 =?utf-8?B?dURkS2lLYnA3bUxjQWM0bTUrdk0xSG5zV2YwZUdoMkQ0aGthbCtkTW5wMGJi?=
 =?utf-8?B?ZmpxWFpuUmZqVGlGTC9NMmJoVHZNaG1KZmpWVnVNNVJ1LzFjZVE2dWY0dS9D?=
 =?utf-8?B?V0xWS0hFdWZ0TDJiWVVBU3VMYTVObzR2Z015bWVwVW1LQTRUZXNHMWpzbFAv?=
 =?utf-8?B?TE1rZzVwRU5ON0REUFFJbXJZQWQ1YWFqZmZ0ME01UlBhY0hQWmhsNWhHOUpM?=
 =?utf-8?B?dkxOSFAyN0hWVjM4L3VVRldsNzBUbE9mSlRWcksxaklYSEVpay9FdEFZSHAy?=
 =?utf-8?B?RzBxR1RCa3htYVBqVmhOUUtVdHFDNVRJNmRReUhRajhYejhWZWlYWWlzR280?=
 =?utf-8?B?RjhKNmhKeHVIWjRhdEJGQnMzVlZlQVZLVGF6am1wUFBmUnNtVnJxM1RLNWZ6?=
 =?utf-8?B?MXozZ21TZ0w2MjkwODV4L2pjcVhoa2JCL1NYUEl1MEpiVDB5NG1rSmgzaU51?=
 =?utf-8?B?dk1xcHVKSGg1UEo5QjQ4Qit3WHhMSXhRTEVVR0lkdEp3UHY2bGZYN2dWZFQ5?=
 =?utf-8?B?RDUxOU4vdjVjSnBqNVlHdjFFSXVwUU5qMEJKdlUwNndsT0lJNkwrRUJXNEJX?=
 =?utf-8?B?cHFra2pIRU1CM3VsSmhDWGhENXQ5Y2x1akxsUStjZVVjNi9tUjFIK2x0SXV1?=
 =?utf-8?B?YktiSXJnU3ZMSVp3dzk5ekhQMUR1U3FkTWpKcWRmbUI4VUJuOXc0MTN3ZFhm?=
 =?utf-8?B?VUxxSmJyVGl1bEhTN05tS1NiWWVvZTZpV2xCcWFmTzBVeGp6OU5OWW9rSEVV?=
 =?utf-8?B?MUlkVThYdUpxc3QwRldqc0VpbnBuOTBnbU9Yem03Z2pIR2dkRzE5NXptc3FE?=
 =?utf-8?B?a3R3VXFOUlVrQkFPSGJjRFN5c0VRZ3I2c2pzUVJZMEI0blY2anduSyt6Y2J6?=
 =?utf-8?B?QS9RSzJweStkL3hicFYvSE9jcldQNkZua2pweTZuQXFTaVdpWmkxNGZrV00z?=
 =?utf-8?B?NlhxV09EbVZaVEZjVVMxYm1xcW15YUs1dFVhWTdMdk02WlVtc05MQnZmZ0dy?=
 =?utf-8?B?Szg3dlJWeWdlTjBsU04yRE5vMTdRNi8vSWFJSnBuWmJWMmo1ek5xQ2Vrbm05?=
 =?utf-8?B?SktmZHpudzd2R1hpWUVSbmQ3ZDdDK25QWDM4cE81WVNDRkw2TVd3cUhzeHdJ?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b525abe-82c1-4eb3-fbf8-08dc63256f41
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:39:21.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haHFMZ9+CsJi2FFK3SXfJUSqLy9S5B29FsR37KBhcSCF4s0/quoOoZkv4ToN6Gm8q//I7nkrI/lazB0MyyW/71Z/OnritCySSkd/Em+fQQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
> On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
>> On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
>>> On Fri, Apr 19, 2024 at 03:18:19PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/19/2024 2:14 PM, Bjorn Helgaas wrote:
>>>>> On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
>>>>>> On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
>>>>>>> On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
>>>>>>>> Adding documentation for the Intel VMD driver and updating the index
>>>>>>>> file to include it.
>>>
>>>>>>>       - Which devices are passed through to a virtual guest and enumerated
>>>>>>>         there?
>>>>>>
>>>>>> All devices under VMD are passed to a virtual guest
>>>>>
>>>>> So the guest will see the VMD Root Ports, but not the VMD RCiEP
>>>>> itself?
>>>>
>>>> The guest will see the VMD device and then the vmd driver in the guest will
>>>> enumerate the devices behind it is my understanding
>>>>
>>>>>>>       - Where does the vmd driver run (host or guest or both)?
>>>>>>
>>>>>> I believe the answer is both.
>>>>>
>>>>> If the VMD RCiEP isn't passed through to the guest, how can the vmd
>>>>> driver do anything in the guest?
>>>>
>>>> The VMD device is passed through to the guest. It works just like bare metal
>>>> in that the guest OS detects the VMD device and loads the vmd driver which
>>>> then enumerates the devices into the guest
>>>
>>> I guess it's obvious that the VMD RCiEP must be passed through to the
>>> guest because the whole point of
>>> https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
>>> is to do something in the guest.
>>>
>>> It does puzzle me that we have two copies of the vmd driver (one in
>>> the host OS and another in the guest OS) that think they own the same
>>> physical device.  I'm not a virtualization guru but that sounds
>>> potentially problematic.
>>>
>>>>> IIUC, the current situation is "regardless of what firmware said, in
>>>>> the VMD domain we want AER disabled and hotplug enabled."
>>>>
>>>> We aren't saying we want AER disabled, we are just saying we want hotplug
>>>> enabled. The observation is that in a hypervisor scenario AER is going to be
>>>> disabled because the _OSC bits are all 0.
>>>
>>> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") is saying
>>> we want AER disabled for the VMD domain, isn't it?
>>
>> I don't see it that way, but maybe I'm misunderstanding something. Here is
>> the code from that commit (only the portion of interest):
>>
>> +/*
>> + * Since VMD is an aperture to regular PCIe root ports, only allow it to
>> + * control features that the OS is allowed to control on the physical PCI
>> bus.
>> + */
>> +static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>> +                                      struct pci_host_bridge *vmd_bridge)
>> +{
>> +       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
>> +       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>> +       vmd_bridge->native_aer = root_bridge->native_aer;
>> +       vmd_bridge->native_pme = root_bridge->native_pme;
>> +       vmd_bridge->native_ltr = root_bridge->native_ltr;
>> +       vmd_bridge->native_dpc = root_bridge->native_dpc;
>> +}
>> +
>>
>> When I look at this, we are copying whatever is in the root_bridge to the
>> vmd_bridge.
> 
> Right.  We're copying the results of the _OSC that applies to the VMD
> RCiEP (not an _OSC that applies to the VMD domain).
> 
>> In a bare metal scenario, this is correct and AER will be whatever
>> the BIOS set up (IIRC on my bare metal system AER is enabled).
> 
> I think the first dmesg log at
> https://bugzilla.kernel.org/show_bug.cgi?id=215027 is from a host OS:
> 
>    [    0.000000] DMI: Dell Inc. Dell G15 Special Edition 5521/, BIOS 0.4.3 10/20/2021
>    [    0.408990] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
>    [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
>    [    0.412207] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
>    [    1.367220] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
>    [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> 
> We evaluated _OSC for domain 0000 with OSC_QUERY_ENABLE ("Query
> Support Flag" in the specs) and learned the platform doesn't support
> AER, so we removed that from the features we request.  We don't
> request control of AER in domain 0000, so native_aer will be 0.  AER
> might be enabled by firmware, but the host Linux should not enable it
> in domain 0000.
> 
> In domain 10000, the host Linux *does* enable AER because all new host
> bridges (including the new VMD domain 10000) assume native control to
> start with, and we update that based on _OSC results.  There's no ACPI
> device describing the VMD host bridge, so there's no _OSC that applies
> to it, so Linux assumes it owns everything.
> 
>> In a hypervisor scenario the root_bridge bits will all be 0 which
>> effectively disables AER and all the similar bits.
> 
> I don't think https://bugzilla.kernel.org/show_bug.cgi?id=215027
> includes a dmesg log from a hypervisor guest, so I don't know what
> happens there.
> 
> The host_bridge->native_* bits always start as 1 (OS owns the feature)
> and they only get cleared if there's an _OSC that retains firmware
> ownership.
> 
>> Prior to this commit all the native_* bits were set to 1 because
>> pci_init_host_bridge() sets them all to 1 so we were enabling AER et all
>> despite what the OS may have wanted. With the commit we are setting the bits
>> to whatever the BIOS has set them to.
> 
> Prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features"),
> the host OS owned all features in the VMD domain.  After 04b12ef163d1,
> it depended on whatever the _OSC for the VMD RCiEP said.
> 
> On the Dell mentioned in that bugzilla, the domain 0000 _OSC said AER
> wasn't supported, and 04b12ef163d1 applied that to the VMD domain as
> well, so the host OS didn't enable AER in either domain.
> 
> But other machines would have different answers.  On a machine that
> supports AER and grants ownership to the OS, 04b12ef163d1 would enable
> AER in both domain 0000 and the VMD domain.
> 
> I don't think we know the root cause of the Correctable Errors from
> that bugzilla.  But it's likely that they would still occur on a
> machine that granted AER to the OS, and if we enable AER in the VMD
> domain, we would probably still have the flood.
> 
> That's is why I think 04b12ef163d1 is problematic: it only disables
> AER in the VMD domain when AER happens to be disabled in domain 0000.
> 

That's a great explanation and very helpful to me, thanks for that!

>>>>> It seems like the only clear option is to say "the vmd driver owns all
>>>>> PCIe services in the VMD domain, the platform does not supply _OSC for
>>>>> the VMD domain, the platform can't do anything with PCIe services in
>>>>> the VMD domain, and the vmd driver needs to explicitly enable/disable
>>>>> services as it needs."
>>>>
>>>> I actually looked at this as well :) I had an idea to set the _OSC bits to 0
>>>> when the vmd driver created the domain. The look at all the root ports
>>>> underneath it and see if AER and PM were set. If any root port underneath
>>>> VMD set AER or PM then I would set the _OSC bit for the bridge to 1. That
>>>> way if any root port underneath VMD had enabled AER (as an example) then
>>>> that feature would still work. I didn't test this in a hypervisor scenario
>>>> though so not sure what I would see.
>>>
>>> _OSC negotiates ownership of features between platform firmware and
>>> OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
>>> device advertises the feature, the OS can use it."  We clear those
>>> native_* bits if the platform retains ownership via _OSC.
>>>
>>> If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
>>> the domain below it, why would we assume that BIOS retains ownership
>>> of the features negotiated by _OSC?  I think we have to assume the OS
>>> owns them, which is what happened before 04b12ef163d1.
>>
>> Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
>> then all the root ports and devices underneath VMD are visible to the BIOS
>> and OS so ACPI would run on all of them and the _OSC bits should be set
>> correctly.
> 
> Sorry, that was confusing.  I think there are two pieces to enabling
> VMD:
> 
>    1) There's the BIOS "VMD enable" switch.  If set, the VMD device
>    appears as an RCiEP and the devices behind it are invisible to the
>    BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
>    the devices behind it appear as normal Root Ports with devices below
>    them.
> 
>    2) When the BIOS "VMD enable" is set, the OS vmd driver configures
>    the VMD RCiEP and enumerates things below the VMD host bridge.
> 
>    In this case, BIOS enables the VMD RCiEP, but it doesn't have a
>    driver for it and it doesn't know how to enumerate the VMD Root
>    Ports, so I don't think it makes sense for BIOS to own features for
>    devices it doesn't know about.
> 

That makes sense to me. It sounds like VMD should own all the features, 
I just don't know how the vmd driver would set the bits other than 
hotplug correctly... We know leaving them on is problematic, but I'm not 
sure what method to use to decide which of the other bits should be set 
or not.

These other features are in a no mans land. I did consider running ACPI 
for the devices behind VMD, but the ACPI functions are almost all static 
to acpi.c (IIRC) and I didn't feel like I should rototill the ACPI code 
for this...

I'm hesitant to set all the other feature bits to 0 as well because we 
may have customers who want AER on their devices behind VMD. I'll do 
some research on my side to see how we enable/handle other features.

If it turns out that we never use AER or any of the other features would 
it be ok if we set everything other than hotplug to 0 and print some 
messages similar to the OS stating that VMD owns all these features and 
isn't supporting them?

Paul

