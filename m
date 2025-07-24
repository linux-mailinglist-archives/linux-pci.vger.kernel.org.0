Return-Path: <linux-pci+bounces-32859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DAB0FDDC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 02:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5543A733F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 00:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD116D4EF;
	Thu, 24 Jul 2025 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbDWbUQu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D28C2EF;
	Thu, 24 Jul 2025 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315289; cv=fail; b=O889lqjNUEH2WX/pOML/47fqqMROvh99VgI9mDaPEHfeduwCXrmsagmKZFIjngmf2jL2EVG9WCgrwkpTvg8SkpXDVGd0N951Uh+hYtFcwNgx14D7eIp+6MK2kX/h44dtJ6gNmxY3CbBAo5VBkK1L/kwIGGpW/RH/dKTCJZNi+To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315289; c=relaxed/simple;
	bh=mYravlvsTQBNhoAuuw1/zsgHXHBu0jvT6/2v0dXnZWs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Pqcdc7OXkMos1K7qkwMUUgM0jiaCGvN6gVvEvWY3wOhmEnIyeXxSQRnuVE7She5l03VhbXfTPjmj+EA9qDhxOHckToWgUBrgtlq2zW54exugj8CF0xczMih5qOVHpmrdUDKrWhY8kDmrRkoCXhsCkTcvTCoSs5Dacg4Tb8QsBNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbDWbUQu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753315288; x=1784851288;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=mYravlvsTQBNhoAuuw1/zsgHXHBu0jvT6/2v0dXnZWs=;
  b=YbDWbUQu8UdNioIBp+W5aD5FnHYwayPr+144R7CTewv1cNrxzZPNUAXn
   b+939Vd5U6xRFap1xMHQlbREn/9qGizefdvR6OrqU42G7yxtcaueHGJpq
   M7J6MakfY7s37NTXLBjm7UhwWY2HtXfQBUHpKYC35CQtRCe0ZkOYiDioM
   FM37cNB01BpuxH55vjXcQ5gTfYkPrdZKeBqosTxI1BOKS0WeICHPuX7M0
   qfqIxLhq/9In03WY2ttbJHGExyfc6yGxT5QrdAgfHGO7t/1RNu89nDzo/
   OmBltG2in1eSxBwKR2+4JjXQeZpGfFgA8I6j67dCHEIJSkEjgGBu6xrws
   A==;
X-CSE-ConnectionGUID: k6XcYzWSQfmhhNoC5pSshQ==
X-CSE-MsgGUID: 78+LUTvBRFuXUEkFf6P2cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55762429"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55762429"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 17:01:27 -0700
X-CSE-ConnectionGUID: zjSvLOCcSP2TFEqlgkWyXw==
X-CSE-MsgGUID: VhEl3EKnQHSHNri2fG2wZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="165415966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 17:01:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 17:01:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 17:01:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 23 Jul 2025 17:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIS12eRTj9upjXupmBaG+MyEa/kK8wqLJMl80bUJ3YrwtWGvsxd3nn9jz3+/LM+6OL8HNSXJszYqFK0n3bp5Sv+ItqafyT2ZUJUJR76U3F50Z9xikWEmO2Gi4/4gl+FDoRQGCJrKG2IdGaGcRPNib22ndKwhHs1QTzNSq2eXV3Bgwa0Z82bT36pcHwRl0AZ/jcF3SAEnzs7ceyeD5O2jJcHMM/d7iUn/q2wWOULNXkDN93yRDG7tewKtQF9EMNwl44Y9/Ds1oGS9ZSQvGq7uMy7A949MD7mnRcvQ4AcrPRLo2scjBag3gqTNjj8T/KRm+JrbEjtdnlu4hkcnWYB9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Vl9nfrodBNali7ReZnt+ioeU3GWfYkCa8YlOGxkuw=;
 b=GhVKfVFbgsPAV9y+YqtfeMApxr6rMZ6u7xShCG+FaPKTi0kq5kafyNXiyLX8sSETubOUQmgT8rhK2E4Iu17O0qnoCQS4qc1HG0zxQjtshfnnwiJZU14Bn38++xq4xwRNE1r8qa+WmFlg35FaqRuUD9unGBQfoh9104JILr831uwFPGincGdWPecg9qygMdo5RKQTwWxakFa2XYLPk6ZyhK8Vmlry+ChF25qTDX1SjLZ5spp3ZaLRyd8UnzGWpmX2L6XEcVNjZYjYTwEK7BETdvlbh/IFZrTH9iaikyj+aCEK9kzRF4gLHIKzTLjFZPhrAeRa13O5+Qs6NcHtYzk1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 00:01:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 00:01:22 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 17:01:20 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <688177d0553c8_134cc710028@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-5-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a9d9ab-6d65-4e1d-e8f4-08ddca453950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzdaZ09ZQjFkSXhOM3Q5U1g4c2p1dngzKzA2RHozaHcwdVlHRHBGc1dSekFE?=
 =?utf-8?B?amdGUkdYVmd0YVd4aXpGYng5M0pMSy9reWkxZ3NmVE5tQklPRGNhc2NsbGZI?=
 =?utf-8?B?bU10ME5yTUZ6K2lOQk1oNFV0a3pyV2kzU2ZlckE5ZW5qVTRCanlrOHE3MlFT?=
 =?utf-8?B?TlJsaFhFMHBuSHFNUUMweEJXR3lhcnRuVWRweHVjZjdQekowdUY3UnBJTEN1?=
 =?utf-8?B?dklPM0FLZUJwanhCSXdGNzRjUjkrSDFjbTJ4UmQ5azFwZTR1MmkvaEpzMXFP?=
 =?utf-8?B?SDMzeHFPWnkwcHYwWkpITURDUkdQanpYb0cvY1NHcTBiYjY4cHZhdERVRXpi?=
 =?utf-8?B?ZWhSZmxoL3F1enlGbEg1OUR4UE12N094U1JmWVl3V0phdXJxNHpXMC95bCtR?=
 =?utf-8?B?UTVNYk55UkMzMDU4YkwyeXdUVlhpSWJsK2NWS0ZMbitTZGJqZHU4NGJNbDF5?=
 =?utf-8?B?aVpSTHZBa3FFTXNDNFc0VkdBeGFMY3dQUmkrYmJzNk80QW1pVUUyNTAyR0Fp?=
 =?utf-8?B?eU93UTBwcUVTa2QvVEs2eDNvWE05Ny9aRWQwNUlEakg2b1dRckhJQWxrSktt?=
 =?utf-8?B?ckVDYnJNSm5wNkhWVHNROEt4Z29OamFOSE9CT2dqYWR0VWQ4S0lKYmIwRWpM?=
 =?utf-8?B?cG80TlBXUnEzTEtTZFVkMGNqYzJaYW9Od0d4b0VsbGpGVGFrbTZ6QWJHUHJ6?=
 =?utf-8?B?cXNIMTgwc0FBL243R2RtUGVEci96RzR3UWowNG9kMnpYemd5aUFKcVczR0pX?=
 =?utf-8?B?V2J1bHdIdnRvajNqeGVqc2VHellWNVRUQVhaYVIxUTlwakdOK3JEZGVxNWZP?=
 =?utf-8?B?dS9sRnRVbllVWkJtQ1YzSGM3QTNVYTF2VDNPaWFyTEhuK2svZ0IvV1pvRWpF?=
 =?utf-8?B?Qk9UTzl1M200dzVuckhCdlBhNlpXZ1RoNjJ4RGdlQ3I1cXNHZ2lQNDB5R3ZT?=
 =?utf-8?B?eDdoSk1DK3hqNjdpR0dvVmZ6dmt5SEs5U084YXM5cXZzVEJXd3c1TEd5WWlL?=
 =?utf-8?B?eG9Ta3F2RzR3WndPY0xRTkxqUXFhajIzcDV0d0xJSzQzQXFqcnJYQ1lNb3VL?=
 =?utf-8?B?eG91WnhYMlhEem1iaTZ0Y0ZLaHV1MWQ5K0x4eXhubzJXMTRCRFlxeHZpUGlo?=
 =?utf-8?B?a2dPUFlyZ3dnOGVRb3RDcUVQTlJJdUEwSnlvNGJvMHRYdGZrQVV2b3ZsRGFw?=
 =?utf-8?B?VUxwZmpPWFI2ZldJNXhnZW1RdUIyVHZpZ1VaT1NvSVY3NXNNSmZFNUpnRDNJ?=
 =?utf-8?B?VEpXdnNMWnROOStnZ21YWWZKSHlQSWdoOFJQbW5KeDZTQnJQZ3R4RngyQTNy?=
 =?utf-8?B?ajEzbHhTMHFZWng0SGQ4UkhEL3hodERkWjhKMXVhckxCZFY2S2NGZE9tMGFK?=
 =?utf-8?B?MENjNGxidURlTE8xNEcwajEwOUFwQlRCamN4QTBRMUtNeW56NXZUU0RkY0ZF?=
 =?utf-8?B?cDdyRWlQQlBWOXExcm9lRS8zcWJvVCtnZE4wTWs3NUJ4N2VtVlJ3eUtrWS9k?=
 =?utf-8?B?Z1d3NjJXR0ZHeVFIakwycklPMEJORmtnRFV0bitxMGd3dUczMHNxbnRPREhV?=
 =?utf-8?B?VEpiWEI1SHlWVGpNZXVRMnZHcVhITDlCVWYxanNMazVPWUd4dW1wblVEb0Vz?=
 =?utf-8?B?OVNCbWdnZk4vTUlSc3c1a2ZWZmJRaDFkUmhseEtjc3Ixa0RuRmpBTm1BMXF4?=
 =?utf-8?B?Zzg4NGNUNXEzWkpra0VTcUViZW9uaUhyN0I4SnpPYVVZbmllWkRTVDUxRnAy?=
 =?utf-8?B?TjdQdzFNZUFiVUpiRklLS2wyQWg0RVhMUWV4VXhzdmNZSlpQWjBvOWtVV0xz?=
 =?utf-8?B?Q3RtWGdSdjA0R0JudHkyYlk0cVFicHpIak1WZE9jaGRhcDVmeHVvQThOcWd0?=
 =?utf-8?B?aUl2OW1iQjZhaWQ5OXkreEh1MFlBcFoyOWQxdTdrZHI0YXNTSkFUd09wUEl4?=
 =?utf-8?B?WFNpclROYnBmZzZmUFpvRjRFUGtRTUV2T1lJMEw5RFJpUUJ4eS9ZeGhuOGVD?=
 =?utf-8?B?WHRWNEdFUUpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEt0dnZJQW0ybFpSMVhsMmlURmJMYVNnM3d5NmMzUE50UUhDMTU4RitHYmEz?=
 =?utf-8?B?c2puZXMyZEhwS3V2ejFRTXdNdklNdlhyNW5IWUMzS3VhSGpJVEdkSGFiTFpq?=
 =?utf-8?B?d1hoR2pnemJrUFpQZnptQ3VxemFFTHV2RDBidm5DRzN1NmNwU0hsQjAzVFp6?=
 =?utf-8?B?L21kekR4QzhLdXFXYUxIdVVrYmUzVG5zMWRMVlJhWFMyMTdkMU1aVlR4djNZ?=
 =?utf-8?B?NzA0VVBYZUxySDd2Yi9PSGc5ZTVzQUdxbHhNdDlXUDl3YTFiSFNNZjFLbUpN?=
 =?utf-8?B?YnFnekgybDRYME5NQUxYN0MwVmY5eXhQN25mOFBBU1FlbkM0L2d3S0huYmtw?=
 =?utf-8?B?c2Nhb2xtUjg0bExPajFQdUloWHhhNzdEc0diUXI5ME15MjMwZ2QrYmg5aElX?=
 =?utf-8?B?U3ZKUmdRY3JrVVV5SDYrVXpuS3d1SGpzeUtPazVqZDZ1dzhpU215ZTIxTlNm?=
 =?utf-8?B?MnZDc3drV3MrQ3NsTTl0M1VybUJnbTVRVkt0OUpkVDBWSWYwb0FWRUJhNCtq?=
 =?utf-8?B?WUpnd0EwTVA5MkRZLzk1OVhvTEY0YkNveHBDOWNOQXBBWGtQd09nS0xOYWZo?=
 =?utf-8?B?QWVrcmlkQVQ0cHZJZU9ERjVaY2t0YVk0SC9vMFVzMFhsbE1FZ1QrUEFPQmJZ?=
 =?utf-8?B?ck5hREsyb3htR3FZNkR6aWx1UmF5c1liNDAxVWFlREx1b3dMcTJCM1QxOHp5?=
 =?utf-8?B?ZG5tdUpKb1hVczI0NVV0UHdyb1NiTEF5NjliRW1MMkdhNE9BNTlQZG1MU1Qx?=
 =?utf-8?B?UVJqWHJTQ2VRVG9CNnFBeWlXbkQ5cjEvOUg5VU5SeE9uZmxSa0swKzFXN2xr?=
 =?utf-8?B?ZEMzWkFkcGJ0anNxMHVCR0hLSm1zSXhzeGR4cE1QN1g5Qk0yZlNTWWtCUXVn?=
 =?utf-8?B?RnRqSlViV0Z3ZXJqY2g0RE5OSkJtb1ZZSTRHNWxPWmJEQ0lnSkp6RHJiN0c0?=
 =?utf-8?B?WVlMNFJ6QUhGQ3ExbTdpcFptM0tkTGVCMm9rWTEzNUIyanJ3ZW9HN1RwZFZs?=
 =?utf-8?B?VG5leklKdXJwQU5lTW1TVTgzM1NDeFdhMmprcGozMHVDSU85ZWo1SldPR1dF?=
 =?utf-8?B?SWhXN2MrR0RLdTVWdTlFSjI0emRtT3ZrQ3VVR3ZXUUhEVlRla1ZFb2NFVTNo?=
 =?utf-8?B?dnVaMWY0UlY4M0dzQTl3VVpOTGxZUURNcDI0Vm94VkNpeWNxK0FWOTN3UGtZ?=
 =?utf-8?B?aFRpLzRpcFliWFJhcTBINGQrWWZVYktsZWxpeHl6a1hwMHd6ZEhQMk8wMEhj?=
 =?utf-8?B?NWpyRE9EVmJaZ1lJdU9Md0ZUMStPNGZ2dno4L0hRS2ZibmZwN3FudDZkV2N4?=
 =?utf-8?B?Q2dORnFNM2kzMWdJL0V5U2JYaEtlenpsbHhSNG1tNHFRRnZwQkFLUEJnMVRC?=
 =?utf-8?B?YkUrVEIweFlrbXpkc0IrS0ZIOFNTTHQwT0x6elRmY2U4dHI4QzlDakgySVRX?=
 =?utf-8?B?Mk9RWUQyM1ZqZnhSaEU4QWNRMGI0RzFFWUhIcC9xTVJyR0ErUFlrRXRJNTZp?=
 =?utf-8?B?MFdUN3kyNVk5QTFWdlVQRXBIV1FnVkVsM0wrZDIvU0ZLOGlkaEp2ZVJJWUQ2?=
 =?utf-8?B?ZytkdWZILzAzUkh6VTdyODJoMER4cUhIeWdHSVpDS2xJckRVUHJKWlJGTldu?=
 =?utf-8?B?eXdKTSsxLy9CSU1zUHpWN3VFczlzekhyRWhQNTBwZnpDTTcwVXFrMnFDaS9M?=
 =?utf-8?B?TENOSzJiNXJoSFlsUjlVaVFtS0R1eGpZeGQ5NzhpZVd3L0dlVk5IWHdXRW94?=
 =?utf-8?B?RUM1WFpLWFZWRlgzNlFNekdWd2VuRUlaQUxRajdaNDYwY3VXQytpWTJlSXZw?=
 =?utf-8?B?N3NuZDBUQmY3elB3dUsrbnhyOW5WQVZzUzR0eExTZitHYnpSd2V4TVVKYTNu?=
 =?utf-8?B?YmhUNVQzOGFLU1E5MUJIL0M5S1k0MitEWVJzQnloUEEzdGY0RlFMaXF1bmRQ?=
 =?utf-8?B?TDNOWUZBSE9hZ3BmMmJOb1NNMzNaV0NMbGIzMzV6OHRHMS9lYkt1eGt6ZVpC?=
 =?utf-8?B?RGRTTnEzcVp3SkoxWVlaZWdIYUxRZDFBUkN5eXpld3p2TlBEUnc3MVdqTDE0?=
 =?utf-8?B?NVkrYzRpMTB6YWp1NTRWRHZua0hkcitpZm1YdFVHdmYxeWRJVkNxVTEzSDNG?=
 =?utf-8?B?anBjVGlEcHM2TzFNTXBTdmtvS3EvTFJscmVYdCtmSXRsamRuZjhHaGI3MXdV?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a9d9ab-6d65-4e1d-e8f4-08ddca453950
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 00:01:22.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FYeDpJU0HB0cJ70wS1KLPtyOzOZ/Ly+hkeblIehj5G9Eo+eb/gh7WP966GCSRLFYQX4JDObhQMWAp9bac7UvQwTqCymdEpOFGrJLwWZkTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL AER error handling logic currently resides in the AER driver file,
> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
> using #ifdefs.
> 
> Improve the AER driver maintainability by separating the CXL specific logic
> from the AER driver's core functionality and removing the #ifdefs.
> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
> new file.
> 
> Update the makefile to conditionally compile the CXL file using the
> existing CONFIG_PCIEAER_CXL Kconfig.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

[..]
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e2d71b6fdd84..31b3935bf189 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -12,6 +12,8 @@
>  
>  /* Device classes and subclasses */
>  
> +#define PCI_CLASS_CODE_MASK             0xFFFF00

Per other comments do not add this updated in the same patch as the
move.

When / if you submit it separately it likely also belongs next to
PCI_CLASS_REVISION in include/uapi/linux/pci_regs.h defined with
__GENMASK(23, 8).

Otherwise, with this change dropped you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

