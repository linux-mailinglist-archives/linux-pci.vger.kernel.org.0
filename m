Return-Path: <linux-pci+bounces-45016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0389D2AAAE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 04:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965AC304F179
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4526056C;
	Fri, 16 Jan 2026 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPQe3fYL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931118FC86;
	Fri, 16 Jan 2026 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533702; cv=fail; b=bHCmzdpcTR0xFOCvc9oWQTGSLHVoKV3uGQWCgE2zpNpZvCbZmme42J8hCuwHgHyxf03Ze4HFrLR4YwTOzVkB2J7ppfiNVI0CYyOX82LKZcCFsOjb43mchUT1JzLD3QSu4rHt13SlaX7o5dvo/lfPNbeJqJIg2ff8Hn8j/gDbpcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533702; c=relaxed/simple;
	bh=bq/HGNJUIbZy1GOlTSVmmART8T5Gp7cCUNRr4DuZXEY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WqYJFzpHAvfp4++umqLd/lTeQjAaZ44z4w0+eu447/vb0kXTxA99IG7rkCMriDKnMwwkUNMIyaBGL2YKFnZPKtFrPtzaQRqDF3m3JYBhxYzHXnF+Jk4qUCKM7aBSzKTEdwG5Ls4rCJMalg6hNNrtUpuua+Vc8IqYREEtVYKgitM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPQe3fYL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768533701; x=1800069701;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bq/HGNJUIbZy1GOlTSVmmART8T5Gp7cCUNRr4DuZXEY=;
  b=cPQe3fYL0oxt975fnmRGzJL3tm9DNsrj+p4ZMLGhQPXi7ILZLSsPe2D4
   qzw+psSZzz1ZtM/HZQOvubD2eb7RHotWfPi5cKchscoKXj1Z17y9h4Qxm
   HBqjyXMcXhHxdfeLbziOEfV8ZPYVJwuiO8CEMUAet5Xk0BVkDN609zVT3
   L8x+06Iv2btl4sDifRkWCBVdaqyrzHnJrqolKWF1qkaCsvhBRUMn3O219
   VmKGs4Ot9pDXU+Kt8FprvoAnyAhQCVkuWoibfCyqsCiTurVDB3OEG0j8K
   DhhO2tVX4PDSU5VY4jRyvkfLXeM2hcytz2b9w3Gi+yZG3eOaS1y/SYY7o
   A==;
X-CSE-ConnectionGUID: UgaiKCbiQxiUg+gI0xRUYw==
X-CSE-MsgGUID: lee+1aeTTqWgtFKWOvIvKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80963744"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="80963744"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:21:41 -0800
X-CSE-ConnectionGUID: weCpPyK3SgCESSSbNMAkcg==
X-CSE-MsgGUID: +uRGiZDjS7OIgqdc2oCK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209993329"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:21:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:21:39 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 19:21:39 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBId397HI9ywCKTgS7m/+u+A9BxaZN93Ell8lh8AAr7ki15h0//UjTa/VSQhpgDuVjdyU3FOrzADAjc0ay9N6r3bVQ/JOMPhXjQd0UplcKudMi4Q5H9AyzX0YLFyR5PQL/UfZNSZLexA8+zp0PXF9EFGIdZ8BnSPsOSCkaGrvs2Qqbi6jIp0B+kdi3CzCQIUZEY56tRzqvytPzra3zmFSvqTJnXgx/lWmmnCCt7CC2vz6Hn/5gmKJLJxlKccer0XUynsBP2XebYniKqVEuXq5tD4FNDZpDvIt2a18J5Dhg1HYod7GRTD7gode0rcbZxlI2bbZjSGLm5j3ztRBscelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoXH4zvfAkrigCU/9iNzMQUBpYMBK0MzDi0zGVQuIik=;
 b=yQggUrJWNWHOdDeX5JftrF4AdIytrtZe2V713wQmgLqZl9V/2wkL2+5xy7+lCNEh0oqW5plENEbwnRuARNzZmDDCSsGHYelt9xYqk66TtG5bI0+2Y5pqwKXc4636AUNcA8cY/lHhBluGjHLi5ElMVHbG/xiTM0z81jEPthmNrvCB2VKxIBjikPxEjmMULa6CcjLiW+rZmmD5kZfL2/hYglEpSw5BhliF1CO+U02ymw+l5ul2/kiUuJRlAx9zP/W+Ns+i48FqDQHpdJ/phRFLeTBEhpAbyvyXOr4nAQfrfhJWhp5Xj4sN1t3miymp98tRcFKzwkO29grvBO+apusINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:21:35 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 03:21:35 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 19:21:34 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <6969aebe3dc82_875d10017@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114182055.46029-19-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-19-terry.bowman@amd.com>
Subject: Re: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db0fd4f-572f-45b8-49b2-08de54ae5a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0xWY2xGLytHa2V3N0NxMUpOb0d5elhjU0U4MXBtRGhnN3h2bmRlaCs1SjQx?=
 =?utf-8?B?QUZrRXFDenY2RjVyVTNpT0tSL2F1bzllaFRCTGsySFpkalFqTlhXQUxBSjJo?=
 =?utf-8?B?Q3hRZVpZMWhEbzZnaTBFSHZMUitWNlJSMTNmVmNoT2xQY0hJeEdMdFNjUVQw?=
 =?utf-8?B?K3p1VTNxUURTODBxckx3ZlNTanlqRTJrYUMzV09FM2NuUE5kRkxNa3VmVjRm?=
 =?utf-8?B?QmcrSmg0VWZ0MFkvbkwrcVMvZHJESWU4MHNQRFpHRm5yak1FT2Z6ZGVrUTJu?=
 =?utf-8?B?WE9WQ2xDb2wzVUZDdkxEYmhKblA4M21uN3RpS0R6YVg5K2VISysxRStNK2VI?=
 =?utf-8?B?ajJmTzYwY3V2NThSdmthNnQ4UWI1SVFwV1V5YmZuKy8yRVlBenRrZUFYazF3?=
 =?utf-8?B?dW9URDRaSC9ZdkFQb0wzcDA5TmFrQ2tZa1R4SXg0dFZkRXdhN3VnOUZtS0VX?=
 =?utf-8?B?ZW5YaVJqRXJETU5zcVVmMjNzNmJzaHdkVnFNQ2JoZlVrTW1xenpDbmQ3d3p4?=
 =?utf-8?B?TU9Ic25MbVZvak1nK2FaR0ErS1ZiWG03R2lCZFZMM29XQmNpYWswR1EwTjg3?=
 =?utf-8?B?SkxUeHhmZzFDeXlaaHlrdzB1VDUvTkErOE1MeXhUN1I5QVNYcms4eUV4UDZ1?=
 =?utf-8?B?eDFYQzRyYTJYUzJLVXVoNXZWNE05Sk5pOUJZamtRdHk5Tks0VzZ6RWlpZ3c2?=
 =?utf-8?B?TnJyY3gwbEN2anhtSWF3UkNEaUJSVWpoVTBZMTRpa3pDeUhUQVN1cUlrUWlJ?=
 =?utf-8?B?dkJHMG53dmRUUC9RWXJmYXhkcjg2bjNsTmZkVEo0UUs2UUtyOGtxUWdYakFD?=
 =?utf-8?B?MXhiRTYyNHBHUnFqSHdPYjNSVXljUGpsOWhDa3o1aEZGYTNQbTUxUlIvU2VF?=
 =?utf-8?B?ZnJKWExPQ2l4SEFsYVA4ZUk5QldQdFhuaU9zVHFRck1LZ2FSQ29Yem5aUFB3?=
 =?utf-8?B?WDVLSkRRY0xPSXRtSHNxWnVyRjBJV2xSMnpYaVlJTnQ4Q2VhSmdPYW45QnN6?=
 =?utf-8?B?YWo3cTE5YkVhT0pCRmlqajZXMk9VRVdYQUFNdS9IWmVMRDJvNmhoUk1KTysy?=
 =?utf-8?B?YjU1ZnlrYXAyUDRtVnphOXJVQXNyd3FOT0tPajVxNU5zM2RDTVN0ZzF1c25h?=
 =?utf-8?B?dmZEV2o3b1Q2aUZYN29DVE9wYWRHSG8wUDVIazN0L1dYdjcwd0pWbFlTbFcw?=
 =?utf-8?B?bXkzSjFndG4xSXBjTXJHWlFaaEkveWNJaEk1RkxZeWlSTlJ4RWJLbGRqR2lE?=
 =?utf-8?B?T256cVZENDI0YkxzTVlGWDB1QldWRVRPTE5saE5KdGNyMFZlL05HRnBQdVZr?=
 =?utf-8?B?WXF5UVc0RE5WbCsyMTBFd3labE12MWsvYWtFVUp4OVVzV0UvMU9XZm9YTnFq?=
 =?utf-8?B?eUZNV3ZBelhWSk9LUDNkV0JyNEpSNDVOcURQczhuOWJjd3FyVStXVE5FV29H?=
 =?utf-8?B?aVR1T2tEWmRCNGNvbk4reDQzRzhnaElYYWVFLzFtcVFTcjFlNGNEV0hhL3li?=
 =?utf-8?B?d3NUVUFVZzhxSTlFdGVOUm5KMHBuVCsrUWNtSHNzdVl4NzVlS1M3K2U2Ully?=
 =?utf-8?B?ekxiUS9LVWVHRExJN0tTL2padXZTUkZrVnk5bnpTaDBhVTlEZjJWUDRWcVZQ?=
 =?utf-8?B?UVp3Z0pZQ1hJbTNzTEhvSnUycDFmMkdZQW1HM3laZnF5eDd5bjd1QXlrRlh3?=
 =?utf-8?B?aVpMOFBmc0lwZW5JcVAvNDQwWTVzWHFrcWMwTlNQRHJXY3oxRWFXbVlxSUM5?=
 =?utf-8?B?U2lRbEhnS2l3TGJsdTB1K3RVVHlpN2dYMUpoYUxBVndrTWs4Rmw0LzFCT0dl?=
 =?utf-8?B?M2JMbEtuYTFDK3FlelNsQUdjelBQRGtLcW9yS1BrUFBiMXhSSUxqeUFjdFVW?=
 =?utf-8?B?U0M1NE9pRE5pZXp1QS9QUjFZU2NxN1A1aVNTa2dUYk1sSnp0ZTkrSjRZSlBt?=
 =?utf-8?B?eGpZMEpRYmJ1bUU0YmovbWJnc0tzMVpiZnIzVFpvTHZxR3A5VTBQTE5zdW1U?=
 =?utf-8?B?OEM0U3JwM05lem5NWUlRRTlKeTNJaE5vNThnRGgya3htNmxsa0tjVUtCOUtG?=
 =?utf-8?B?ekdab0tkQWsrdTNwYmJpSFNJcnpQd1c0QU1rU3p2ODkySjh3eHExbTJ4T1FG?=
 =?utf-8?B?YkcrZ21lRnpjNXppUExZazQ3V3VTMkd6S1dyQlh5K2dhQnBWQ3lsbkQ4d1Vu?=
 =?utf-8?B?anc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVZMDlhTUdCc1NhZG5jNlZFcU5vVGFuZUJxV3FTQVUrRlNOMVFxZG9sZDlv?=
 =?utf-8?B?dUgyR3dFRmxBRjZ1ZS9EeEcxQ0FLQ3ZjeDhiWTRSOHcxZHhkNENuNDZLU2kx?=
 =?utf-8?B?V2kxbzdXSjI1aFVFVUNrcDV2UnRGUG1aeHB6bndPU2xlWnNmMHVVYWp3V21D?=
 =?utf-8?B?Q0ZBNkgzU3hCbnp3MGRDOUY1MVlFK2kvOTVzRi82SGthcWcra2cyN0VnbUpi?=
 =?utf-8?B?YlFQM2NDY01DZ3F0U3dtQWkyWVNuUjcvYlNBWlpQWmNNRmUrNGlxeFJTZXB2?=
 =?utf-8?B?Ni9tdnZ3V1pJZ2x5WUcxTC84UE5BZXpQdlk5bW11TGc3UEV0R3B4blVCRmk4?=
 =?utf-8?B?V3Jmdmwvd0trY3B2ZHJrcHkxRHBJYUNiWTB1ZDhQM2l3VDVxTzZMWjYxYm93?=
 =?utf-8?B?VE9QbkxieGVJQmdRNHRLVElzaWJHdjdHQmhrSTFYcWpEV1N2eno1eHo5bTNI?=
 =?utf-8?B?aTNuYzVwL1c5QVZEL203aHQwb2Q2K1dNTDl1MlQ4T1l0L0hqZ3RhNHlKV0dF?=
 =?utf-8?B?L25rZFo3c1BodkZEcW9kUEo1OVRkVHRGK3RMMnZYMmxZeE9RRkZYZmxWc2Z2?=
 =?utf-8?B?WEQyRnhvVFdRWlV0YStZdnA2TkhTalBiMUtwMDRuNC9XUmR4MXFKaElLK1FT?=
 =?utf-8?B?SWFCL2Vrbkh2VWwrTExZYnlxbGVjeGhJT1lidHVWb3RwQnZCWTFXU2oxTDVJ?=
 =?utf-8?B?Y2RkVjE3UmNNeTJSdko2RDlGT1Fvd2dEYzV0SzRoYmVCeHh6d0o4L0NqTVdu?=
 =?utf-8?B?M3QvR2M3a0pxTm92QkFZQittT09PMVpiN2ZCSlhaMjJkY0pwNmZCV1ZueVE0?=
 =?utf-8?B?TE4vcHBLY0duUlMyTjJqaHBCL1JDUVVOSkI0S2ZQc2djLzBiWWlVRGsxa080?=
 =?utf-8?B?VDJWQ0JUbU9obzVNanZhTFRLTWhVTzh2UnJ0K1JpNVZjd3lBNmxkQ21Pa1Jq?=
 =?utf-8?B?WEtNN0IwTDNKcWJqRHp0QTNsVkxUZVFnUXFmc2x5ZTlpM25mYWFRZVVRQ25t?=
 =?utf-8?B?aTM2ampSYjNqUU5BTGZFbCs5SUE0Wjh5N3lqMHVyRVhPbGdRZTVvU1VqWCt5?=
 =?utf-8?B?MXdBcm0yOG9SNkZLenNTUHNlWmxHTVR0a1VXZ3cxY2llQ1Iwa2h1Z0VEb1BR?=
 =?utf-8?B?QjQ0MGZPSldsUTlpNmgyNDM1ZTN6WkNIcGx5YjNUZG1WMzNoR29mL0ZYek9F?=
 =?utf-8?B?K3B2MUFUQjFzaVpkczVidHhrVENqcS9ac0dGS29IcDFmcDBtWW5nczdjdlJi?=
 =?utf-8?B?TmhUS1dlTEkyV25SalU4eXhRL2NYakhtaHYzWkRsdTBjOGlnelhmM2lXNS9Q?=
 =?utf-8?B?SjBpSlJ1c0EwZmVyWndSVHgwbC9BUTFsZGpiQzI4MmNuVUcza3llR0ZaNTB3?=
 =?utf-8?B?K08yRGh2N0xvRHpHc0pMbUh0NFhpakdicEFOeng2VFlUWm1udEhRdk1YTXRh?=
 =?utf-8?B?NjR5TU1YVzZKbGE1RGcrQmE1Y3BveWFWZkgxUlg5YXVFNjZHeDd5bTJucUNP?=
 =?utf-8?B?ZVgrellocDJpMllPbGk0akl6VmhjbTAycXdSVnpjUVZCck5ZQjh4UDQwM2lH?=
 =?utf-8?B?NDB4ZWlVRmR1b3gvb3FKZVQ1K3cvRGN1K3k2bHNXZWpEaUQzOWpjb3orZG1n?=
 =?utf-8?B?Ty9za0tpbWJEV3dhWGdFL2FTc1hyYy91U2JxK09sUjBVb3FSQ0MydnI3NHJi?=
 =?utf-8?B?eDJyVzcvblI0QXdkd0gwMzlJTzNWOUUwaWpGc1k5WkgxbzZtYVlqVldLT0dp?=
 =?utf-8?B?YzdJd0IvbXV1NTdoait3b3lUZVJtSUhIMVNRWGE0Y3JXai9NMkU0VjFZdUxq?=
 =?utf-8?B?M2h4aUc1MWFiQkh3Zm5pMkZHbHVTRmlKWm1TUzNLd05OR2pIL1hWaERTM0Uw?=
 =?utf-8?B?OHlZd1R2Nm5qT1hqTlJwSVNhdTlLNEdyRm51czlNTUZRaUxESURSN21hSkQ2?=
 =?utf-8?B?cTBxNHpYVjhVZFFZME1PNkVqTFZ6ZTA1S0Ewb2F2WUtlalFheFB4NzZzN01t?=
 =?utf-8?B?N3Z4aEZCOGdqRUszVjArT1RKS2FGK2dJZXBCRngyWjViWGZ2ZTluY1BwTG5y?=
 =?utf-8?B?RGYvWkwwTVRzUFlhWFp5d2t1UHRlYzdmL3lOdmNOd1FRWXdEZnB1WmYwdllI?=
 =?utf-8?B?WGpOZnJQeVJKYjhTbWVkdDFKUnZaeWo5RkN1MXMwMU1jNE54VG5rZ3RZOFI5?=
 =?utf-8?B?a1Nnd0tZeFR3cHR6UmtOUkJKWklSelJGYmVua2d2aTNPcWRVVWdJeisraG1V?=
 =?utf-8?B?T216Z0JFdzN2NlErNDdCblZFOHI2dlVqVlNwYjFVZk9yOVlDOVlkMkhxSEdK?=
 =?utf-8?B?b2RGK2ZTREN1azJDeE1OZ0FFQ0pLWUpZbVV6Z3UvbllwNkppd3ZFd1ZFYlM3?=
 =?utf-8?Q?xf64JS2bctIX3RsQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db0fd4f-572f-45b8-49b2-08de54ae5a9e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:21:35.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYhdTE33f5n4wp7GavnK7MOOtiukGzpLjm7GDW3psmJXlnltpjIffPiceXk8c3x6emh65kZIMeYcx3odGBw2S3adqmcUDfyS/IccJRGwiyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Now that cxl_switch_port_probe() no longer walks potential dports, because
> they are enumerated dynamically on descendant endpoint arrival, remove the
> dead code.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Terry, the reference patch I sent was based on 6.18-rc4. That means it
was missing this change:

   3f5b8f7f34f6 cxl/port: Remove devm_cxl_port_enumerate_dports()

This cxl_walk_context move, which was not part of my original patch,
also does not appear to be needed, so this patch can simply be dropped.

