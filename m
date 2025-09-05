Return-Path: <linux-pci+bounces-35571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EA3B46444
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A47A3A9608
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99129C321;
	Fri,  5 Sep 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV2LMjHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707C2C2ACE
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102612; cv=fail; b=ScGJqdrlM14qAeAiY7zIZ/Lomfrj/xTB7eB1NqfvPwnvNKqQu6ISidOscFEGaRxkqiEeCjmnosN9nvL/Wzb+9nGk/gWqcMF81TBBh6V/3ZeLjdvWKPRxO7Z6te+kEcOWqVxKWmDA2IWnFFxoTXDz47Zhy6VXQXfnOcjvDdnakLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102612; c=relaxed/simple;
	bh=pdNZ0T0BafFJCVelmgX6q3E9eW2gF8Re5hGY6xDia9c=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EreIA4SmWwZ1l5WDr3DDf0CbVFmC0DeKRbDpDqDX3ni39mX4oW6l96rGD8K5Mqu/cr6G3S4R2dF2vfi5QnoUHpmlBrQdNdq90ZJkZN6V+ARzdb1zTJOHgjLWTRd277o2mj6jShb4vvBonzLhFS1DvwILWeKJt6d7mFf196L+ZyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV2LMjHl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757102607; x=1788638607;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pdNZ0T0BafFJCVelmgX6q3E9eW2gF8Re5hGY6xDia9c=;
  b=HV2LMjHlLN0v+bBoE9Vzflf+0NTLiifKvIRB87Kwuw6VtRigjEyJu0lh
   E+O9BOU3RIaP1OWwcK+WzP/NSszQ5yH8aEIrQp3D3qjjRpeC6n/s2Q0YL
   Ra51tMK89UadiE/HZA52ukdCzGqlSE/8hWMP80hcH/WO4CiF1KqMQEzjO
   hTPGtuTQ6QiFws5OaNN5yIX8TVEcZ35fAE9xzFW248moRRfIoQPLjhzPm
   8zZcocIN8I3ZrF88kEAHa/a1dh4j/uhYNnHqReDEduHB0Jy31vCEFb3uC
   iSwfwg6Aa8ib9dhDWRRriLJutmn5rK83GLewSMv+mNLRLWN0ne2pI2inw
   g==;
X-CSE-ConnectionGUID: yKQxi2H6TgeKUKzRY8scTg==
X-CSE-MsgGUID: n/Xk6u/PS7uLjoZqiaLPfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59397169"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="59397169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:03:23 -0700
X-CSE-ConnectionGUID: 9xFcp/baQLS0ux1n27rPMQ==
X-CSE-MsgGUID: eF38bglMR/24qSoFwUkuEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="209412208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:03:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:03:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 13:03:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH2pKAW/JNFhuzU970mQLeEkKH1wvOmQzIf2jpBob8WyLkxXD+YfKYC0mTCp/s4JnQRpInwc8yhHuiH8bCj3vA/REx5PMjDiovkYIsleZSfe4oE2NNDMKwwkUkwq8uQyL5s9HvGOS+ikO1Rg8RvfrHRMrHRKiZ58/uICVzpPUD2s76nLHmvqPvm3Z9p2wrU9SvrCN/+WxRONYRA75tdW7P9PNNMc2witSACpAPDulD8cKZDnwNhAqJ/99yJKv+QhUyq/5KJGdMD4Fx64IylckNohrvOMlBvuWPUwjwCLWkdnhEmaHhgBSihH6IolRGbYRfLRno193+OI61LIjgpeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MThIys+GAMdODYecoo9rw+SSd5NL1Rv2v7/etExGA4k=;
 b=d9JOrJBZjZqP9m+40fl9+l25r5d7Qomj0f665EFkFUW1MHkUnmocqNLi+uryFxoIExi1qezKOSfJl5Wb1vrle8V1Ky3BW+Wv/9zpsvJERbs/ULP5Ye9BrwyLQ5wX+D1SVSQUp+k3bNVTxs19wt445FuPYTMu+LS+aRs3fmIa4o4DDM3RtfcD7MoKoxcu+QMCejGcQV+seCSZhzgWp7rB5ZdniPf9YcP+tgLck5hBh1o0aWgFXpqB9Q0yv7XPv2blpb3FGO+5IkYVEk6HTYyRQa6RsXIZvm1thKmG5fHvXUSnV8OXP1u5W6VKyNYkLySuzTyU69wkMfwdvVPpAwi8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ5PPF183C9380E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::815) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 20:03:19 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:03:19 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 13:03:17 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aik@amd.com>, <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
Message-ID: <68bb42054dd8a_75db1009b@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5a1poo3n1f.fsf@kernel.org>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a1poo3n1f.fsf@kernel.org>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ5PPF183C9380E:EE_
X-MS-Office365-Filtering-Correlation-Id: 015f298c-cd4f-4a2a-bfea-08ddecb74248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkdMOHZyRE5IVS9Ic0oyOTF4Y0lydnFVMXNaT0cvNGhyT2M2OGJiOGhESGh0?=
 =?utf-8?B?bm00c29qR3VZUExyVzRLTVp1RFVVbnBDU1pQNzloUERFS2wyMjVWdWc5Y0Fx?=
 =?utf-8?B?N2duTUFkaVJGNWNPaEVOUlplZGkyNEtKNHBobzhMWVRMeGpucVdwcUNGVlVh?=
 =?utf-8?B?V1h4aXk1N2g5RGRrMWdlODYxSEM1SEIxd1UrSExpaTNEN1c2TlZYSW9qSEls?=
 =?utf-8?B?MkUweURvS3c0Q2oxazcwd3ZuL2grZ3RlQ0VrT0xyaDJ3dmUwT1c0N2grQkYy?=
 =?utf-8?B?SXFDTldUTHl6SmRrVFlwUXV0MmxNWXE1ZEpWRzNUc1lTcXgyczJIR24rZ2da?=
 =?utf-8?B?a2d5N29jYU9pNFJuNUdyQTlHL0ZBUzdaRnNrTW52TnEwYjQzS2pKdUx4NTVy?=
 =?utf-8?B?dXR1b0VxYzRuVnp5cjZtVkFDRThMM1FaN200WkpjWW9ZTUZDaGEyK3FzVXZO?=
 =?utf-8?B?eGR4T1hFU2RVUWFSTDlmYzVNVXBWR3U3ZFdpenFGTGJ3alkwS1lZUldOdFE1?=
 =?utf-8?B?Y2xjRTl6dm95MXVHWFAvWGNWSU1tKzh5d04ycno4Y0hQRk9PNGNVK2NmM3hX?=
 =?utf-8?B?YSsvbXgrVEJ1TVA5dURNc1puMGVYTmxPbGhQM1k4aGszUXRsTUZqb0IreS9U?=
 =?utf-8?B?VVBEaGhUclQ4M2cwQ0V3QUhyME9ac25aQjhiWkJTY25IbndpWE8zUUprbSs2?=
 =?utf-8?B?NVpYOGJlU0xIMjg1TTJGVlJRTnRuN1ZhRFpLTDMyMHNpSnV4UEdHSExWSzZS?=
 =?utf-8?B?WWdMT2V4SWFZbGw3cThzOGkyZDdoRzBFcnF2b25ESGttVS9WNlkwck1VLzNB?=
 =?utf-8?B?SHRiOG5Ua0haOTIvQkVIWVlabWFwOXY1UWxjcmF3b2tiRXNZMW5oTVBOOVNV?=
 =?utf-8?B?TTRxdysvaTNSaHZ1RjFiYllqWmg0RTJkZjhyTEFQVFkyV2xNdDZIUE9vQlNO?=
 =?utf-8?B?TmZodFJZMk81RmRKSGwyVmpabWNXa09CRWJHS2lxT0hzNmZQblBmb096N21U?=
 =?utf-8?B?Tjl0RDg4WDdyS2diMEFSTXh0Ylc0YkgzQnA0bHJQdFM3VWRJcjU0cEdDcVlu?=
 =?utf-8?B?dmdYTk1uSzhHRXZsZ3dVb3MrbXVoOFNpQzhBMUp6WEVYNXV2Q01lQjZ0MjBs?=
 =?utf-8?B?Wm9kUlM1ZUx2YitPYVBlZDBxOUJYSTJtSGRyZ2lXbzNmSVFMOUVtUldVT1c5?=
 =?utf-8?B?eUpyRGdIVEJvR2krT09scmhYOU5RV1pZU3Z2L1dmY3IrUTNvK0crZDlBNXlQ?=
 =?utf-8?B?OXA2VUlMQkxXeXFaemMxK3lsbjJ6a3ZxQW01L3FsdUJyWFNPWGE1MFY3VThW?=
 =?utf-8?B?dUxWMGtId2ZlbGFuS3YzQkZOUzVZaGY1Z1FFMFRWbjFTUHdmN2RMRFJRZDY2?=
 =?utf-8?B?cVQ4SExYb3E2Qk1SODVkazZXRjN2bDlDY0tBNmZxVWZKbld6a0d3TXBmNVgx?=
 =?utf-8?B?Y29RUzJuclYzeitiOUduWnJhSGYyU0RhaG91WnBrVVQxRG1waUZ0bHRmeUtn?=
 =?utf-8?B?dmVaZXNLTERmNU1xb0xtTW9nazNVcVZMa1A3aTBGMjBsdWJ3TCtlbGdZQVIr?=
 =?utf-8?B?K1R5MHR5ZXBFbU00WjdNR0I4TzFnYWVlWDZmQUdNR0Fzbll5d1I0d0dEZkN1?=
 =?utf-8?B?S2hOZEU5a0FqRXJzZVM3Uzk4Ri9nL2JtYlVwR09NR0tVeFZvTDc4ajZsdnJm?=
 =?utf-8?B?WXhUV1p5MXYwU01yRWtzQ2k4blhiWlphMVUyMDB2N25hQjlDYUJOYmJadnho?=
 =?utf-8?B?YzNHOW9nb1RLdU5ibzVHT25wM1NSUnNqUVoxUVlHNEhhOHhjMFFuTDFMa0ZZ?=
 =?utf-8?B?VXd5VTQ3UlByU1pBYmlscWdCVDBDSzM1eWh6ZTI5R1luNU14UDFuVFN2a0Mr?=
 =?utf-8?B?NU55anNlR0dOZS93aFNvc3VhQkhCeXNFQUw4Q3NobC9xVXNLT01uRndGLyt1?=
 =?utf-8?Q?D+8aTadhLLw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aER5eWUxVnM5Q0JQRzVNTmp5RWlpM1dsbVU5OUZWWHNtOGlwcUdaYnNJbjRO?=
 =?utf-8?B?dlhBYjdsYlJxanNtYnlOVXVneUtEQXFZb25tOWprbm1ra0l2YVpNdiszMHE5?=
 =?utf-8?B?M1hSc3E5R01rQkFIeHE5eUNFdU9VT3UyQ1RDQ093SHVRR2dDSW1Vd2dyYlFw?=
 =?utf-8?B?UG5MTXlxdmtkdFlrd3RVV25KOFBMWEpEVE5UMm9HUzNLc2hxdlhSMUhhV3I1?=
 =?utf-8?B?b2daUXRGd3RtTHZDV1Z5RFYvdEs2ZlVPTVZpZE9wVFZsVzhwMnVCazRqQk4w?=
 =?utf-8?B?aWt2QXY4VHhWRGErWTdQS1hmZEdkUnlGUFc5a3Y5MHhCenRwdDkyZU1xbDZy?=
 =?utf-8?B?aTB5azZsOVViMEZoamJDS296WkJGVE5HNkVCanlxeVMwenZxRVozUnJSQXdm?=
 =?utf-8?B?TW5wbCtreVRzd3QrYlhUVEg4T1JsOVU0eE5Cc0xWY3BMblZDb3NUbmxRQlBU?=
 =?utf-8?B?MWF1TVZvU3Z1N3VCNHM1cXpiTkZkMG5MeHU2bmNQY2lja0xTSGlXd2ZuUGov?=
 =?utf-8?B?Yzlya1ZvZnJYK0lEZTFTem1PZUt3d0VwMkZqUzU3NjVPVnZXeVhCOENFR0Qz?=
 =?utf-8?B?V0IzbzliQVVhcWJlSExXMkxZUmsrbXVjbGlXVmxlb0FDeEp6NVU1ajdtNVpy?=
 =?utf-8?B?QlBtbHlVa3NqOExuNUp2cVZlZzZZdXBjUHpPTHNJeHVCQ0cvU2xFS05LcEFi?=
 =?utf-8?B?c2owQlhCcGFJUGZ2cStsRkgwWmt4V2J3bzhGTWswMDF6UitkUjh2KzE1bFZG?=
 =?utf-8?B?Q2JEbTRoNTNkdDZ1Z242TEd5QldCMUhZbUxTOGtPa0hLMkVQbTJqMFJia1VU?=
 =?utf-8?B?ZkRqYVNSdm5mZXpqd0dGMDNkcUhJeW9zclBPcThGZURGQUE4T3Bob0duSjQx?=
 =?utf-8?B?UVcwdkhNVHNLUndaVVdNVjdjejY0YTNuRlJ4SUVlZkN5YXdCM280MmlJOUdz?=
 =?utf-8?B?MjFVMDJ5eGxFWWpEaWdMMjNvVWIySkt6R3ZwUVpWUThzU0JkRUJZbnNyTFp6?=
 =?utf-8?B?d1V2MzRoU3BDVWtGeTZvM0hFY2VJdWRROTR3Qi9xZDhsNmRuNUhFNlhIUU1R?=
 =?utf-8?B?ZklrYWRtYXlCanJMRDdhbVFuQUsyYmI4VVRnSzZnSVRTWnFVR0U0TlNvWUVp?=
 =?utf-8?B?bk9laVlsK3cvYmpSc2dCZy9mVE9WaHU2L1A0Vk80bHpxMmtuUmxVcERrS05K?=
 =?utf-8?B?K2EwRlJyUkRmVDdOUVdVYTRtT1VnUXA0c0JFQVIvV2dEM3JSaFRSS0F5UXNO?=
 =?utf-8?B?Ry9Oc0hLRDVBN25KWE9FYXZGRFN6TGNNNjBlaEZKN1VWbXB3RTl6L3N1aFZh?=
 =?utf-8?B?VTJzeUE0L1BreW1WK3dSbndGMWE4MHVUK1hjWnJ4SUFZSHNKWGRRYzJvSm1M?=
 =?utf-8?B?Zzc0MVpLekNRc1VRY2RTdkEyOTNlZnh2dGJLS1FlTW9iaEJMRU1XQzNWMEFG?=
 =?utf-8?B?K0tHa0hlbGNCaVJteC9HY2FvNkxUR0NxeDBzaTNZVlVTU01tY1ZJYVoyWU9W?=
 =?utf-8?B?a3VFNVNYanJLUG41Y3c5WGllaXNFbHA0djlaK3dnK3gxZXdTWlNTYTZxZ2hR?=
 =?utf-8?B?TElSVEJkNnpxMHM5c1E5emxuK3lKNC9aOHBkUGYxa0hvb2hiOVFISFM4QTBJ?=
 =?utf-8?B?Qk1HN3dFd3AzS0kwQ3B6aGZXM09OczJ0WDhTSjVXNG9RZTBNdVYrYS9mUmg5?=
 =?utf-8?B?SS9laXpjRGhwVnBXZmlXY0J0dFJLSXdjWkJ3RE5SVHdBQmhPeGJtNVZvaStq?=
 =?utf-8?B?Z3grKzZoV3QrZ0RoUU52T2ZPUXJNNDNDS0tZZ1ZzeURuc0JYM2VQelliVlU2?=
 =?utf-8?B?dzB1VUc1M1VpWjBVNmdnQ1g5V3paaXZiMVBqQ3kzQVlJR3d3NitHSWVnSEhx?=
 =?utf-8?B?bTdic1hKQTJqSjA4SmZYUEk1NmxKdXVJaDBza3lkb1g0YzJTYWhLanVyS2Er?=
 =?utf-8?B?STVlUklEVzE2SkxaWlBpS0Y0aUFPaFlpQkI3cktjTVQ0KzhaNGVFOTVIcm9J?=
 =?utf-8?B?ZjI1eTJ5a0s5RnJMQjRMMzcwRnhuU0NNMU1STHBKWHRyRDVJS2hlazR5MFFG?=
 =?utf-8?B?ZGRocXVXUWMxMFBCU1BDQ3Ixc1RHVkFNNUcxQ21pamdmK0VwRTFueHg4bTBL?=
 =?utf-8?B?eWh0enBkdG5lVG0xQ1FsTWxmNzEzbDVsRmhJREdlUlBCWSt4b3Nvc0lGU05h?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 015f298c-cd4f-4a2a-bfea-08ddecb74248
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:03:19.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5PPDQh4HS+1/Bb2Y9tUW4OKiN31VSs1xjbh96TOMeAl49BOFMJmrBxK+Gwe9oJ1py9nAiLMkOke02QqtSgf2ibvBB16ULeF5E+oGbjWv8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183C9380E
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> ....
> > +
> > +/**
> > + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> > + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> > + * @dsm: PCI Device Security Manager for link operations on @pdev
> > + * @ops: Link Confidentiality or Device Function Security operations
> > + *
> > + * This structure is wrapped by low level TSM driver data and returned by
> > + * probe()/lock(), it is freed by the corresponding remove()/unlock().
> > + *
> > + * For link operations it serves to cache the association between a Device
> > + * Security Manager (DSM) and the functions that manager can assign to a TVM.
> > + * That can be "self", for assigning function0 of a TEE I/O device, a
> > + * sub-function (SR-IOV virtual function, or non-function0
> > + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
> > + * DSM).
> > + */
> > +struct pci_tsm {
> > +	struct pci_dev *pdev;
> > +	struct pci_dev *dsm;
> >
> 
> struct pci_dev *dsm_dev? 

Sure.

> > +	const struct pci_tsm_ops *ops;
> > +};
> > +
> > +/**
> > + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> > + * @base: generic core "tsm" context
> > + * @lock: mutual exclustion for pci_tsm_ops invocation
> > + * @doe_mb: PCIe Data Object Exchange mailbox
> > + */
> > +struct pci_tsm_pf0 {
> > +	struct pci_tsm base;
> >
> 
> struct pci_tsm base_tsm ?

Works for me.

> > +	struct mutex lock;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> > +
> 
> 
> Both the above will help when we have names likes
> 
> dsm->pci.base.pdev; vs dsm->pci.base_tsm.pdev;
> 
> and tsm->dsm vs tsm->dsm_dev

Sounds good.

