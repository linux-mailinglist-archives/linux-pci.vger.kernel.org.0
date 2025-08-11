Return-Path: <linux-pci+bounces-33807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB65B2190B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0394611E5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0C22A4F4;
	Mon, 11 Aug 2025 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlwBYpaS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8822356CB;
	Mon, 11 Aug 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954087; cv=fail; b=dkU/ruEm6i25iJibs0yVKDSR8VMd3fH23VrgdhPmuXIKcj0X0fVzPIGD2QAETpijKwyDMu7dosJGEru2x1RyEQXlw6xxVv46P7ZST4naA1P+wYbW8QXIq+55r6rDohjT7lGoafWplQAipieYGORrMXwvnLbIbQVYQsA25IXAlq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954087; c=relaxed/simple;
	bh=s3CEM4KYZnM+FIRRHZQvKPQAeCNfoCt/1bKVLzqbahE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=sM+M+AE78Gtsh7nzHuoeCbI9oViwYIiNI1YGjDBwtCG4y3B22d0Ua2QzWzVsuwpDhKwcP+/LjgtTB/o6z+qF9sC2/htDYNev2feFyZyCTQYbrQz2O/J7EHsQrQoVjWfcriujlGu2asOAP19HWfD6I4sa17rNJ8hXcPwxH9roO/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlwBYpaS; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754954086; x=1786490086;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=s3CEM4KYZnM+FIRRHZQvKPQAeCNfoCt/1bKVLzqbahE=;
  b=jlwBYpaScYgcGuAwa7kTMqeG2Qrffd0wb6/zgvd8qkR5vSt04i9LHywA
   EK20PHA/8uccEvIVFE8VIL/nZo+NUfK6ypsXWOQ3huhipR3kFlFoc4UXc
   DMlaz44du3W2D/eNEaUe0E4pUj4vezpM0s2rsICrlpOAMtoFur99+8zJz
   PWz+O+sEm8A5y3afluW2Se0WG+yBZVtcaUGp/suA6XHyXjM6oRnOl++QG
   t6NKfC82pyC0isu3l+O5yPFzZQIGnd4lGE7pG4XppFvy5ls7T1KVdkRua
   mnlp3S9a0Ot1YzIVrQsGFIYTulIC6It3cyWES1z0IBBWIeOACtYPsXb4Y
   A==;
X-CSE-ConnectionGUID: 408+z7HqRY2oWswYRdqFMw==
X-CSE-MsgGUID: bRugwihKSt+a29+kgAWv0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57175319"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57175319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:14:45 -0700
X-CSE-ConnectionGUID: ranIIbuFRZWTpjc+ml4crQ==
X-CSE-MsgGUID: bQru1NmlRG2/YaIcN6R4ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="203217917"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:14:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 16:14:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 16:14:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 16:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhfWkzx4g9oGAVjgzTtOXJAu063GCRb53ZSUwqOThhfbeB9D2WxfdagCVVl7gJXq94NpWLTNY2v+mQFLul9b8St6X8pgaHyxi/QHVCj8D613cfzeni6S6TAExgfFfVI+8de9pog4K2N72rrfT88mIDD5vMFKTot/T0bzHnhgZdaxHzZB13qk3PfwKxf1BDd/slRIHJW+IElH3xXVsRmOqP+fj2IvQ0Pkn8Oggj2N+T/q3dKdFyMU4tCL1qyBz/UZBdgKJoYxbfxUIHhTNrtfQUH+/ho8mF5kHpca7ORClH+mph1cHh4Rnxoed6M5os0IkNReclKZMcuoAnuaCdA0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtE2q1NDlWTXeUjkbMJ+uyjdz3WauYp6hJsaxOmGJok=;
 b=NJEWpDSlT21rwqxw+FD9fRF/k9TSJVzL0jWknrsS3RgDWzSedB0TGkK3dBUjromBinPl3ixp5SR3fBfUhNLyDkGarDJnZJvNEjbLPI4QBm6HUMiE41Cr8QCNloyU4TRtwUBLnRZdCqPzezh6rP5LlBbwzY/oSTpXW+iMOkuwVIhVuVe981SKHoa/N4ByxcMytmu1Z6+d7KGtLlBAcY6LsYrc1rFzqnWAnUDVDbIbPQ6nVn1eZkbPsKbFUoswSIxj3o6Uxwgwd3rD6eJcddH3J4OIzpzBwkHukAjYP9U04p1TJajMlcgUd7Ruky0tkwN8kZ72tAAK8Mhnl/RnC34WrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7602.namprd11.prod.outlook.com (2603:10b6:806:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 23:14:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 23:14:37 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 11 Aug 2025 16:14:35 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, Alejandro Lucero Palau
	<alucerop@amd.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <689a795b1194_50ce1004d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <a490e34b-10f9-4ac4-a053-5d45222ea58c@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
 <d8aee8c3-55cf-4aec-afc1-21773759d193@amd.com>
 <a490e34b-10f9-4ac4-a053-5d45222ea58c@amd.com>
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a1e664-ffbc-4a7c-cb7a-08ddd92cd73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlFCTkVDZG1Ta0JCSEkrL20ydTB2b0F1eFF0Yi8wamhja0hpYnBPOEJUUzNn?=
 =?utf-8?B?QnZlSW5QRlRuTW1ZNDR2akUrTEtBL05zSXgwU3pXRWNPZVhOQzVYaVpWQ1gv?=
 =?utf-8?B?QTVMbTN2Z2Rya2NSZU1tZ2dpUGU2V0NlNDcrOEx6UG91T0tMYWhVWkFwT2k2?=
 =?utf-8?B?eWJiNlQ5eGlIWTlQMEg3MFJ3Q1dyS1h4UG9oeHFFbmxQYmpqY1NiVGlUdTk0?=
 =?utf-8?B?eFU2N2t3MGw5NDJ1UmxDRFFoeVMraWZFMnIveEkrRStGNlFUNno4S2ljZ0dp?=
 =?utf-8?B?V1B0ZWtGcWdyWFVUVmZyZldKTDgzQjV6eE9sVWJrN0dyMlRiaUtMTnpTa1Ex?=
 =?utf-8?B?RlhzRmppcGMvRnU3bW1lVzErVHVNZk0zNm1lM1ZaSmsvVmk5OE9USlFxVk5Y?=
 =?utf-8?B?OHVCSkRtMjRzL3ZhQ3U3a1pYejArWHNhK0JLZnF5YUFQaSsvbmRDbXp2T1B2?=
 =?utf-8?B?U2Y1V2oyNnpqZWoyTVYzYytEUEhVa1NRWG00MmFZRFJnd2NocmJUWXVabG9N?=
 =?utf-8?B?ZzFqWVBNaS8razVKRXozcm42cWZUM015MkR2VWE4N2hrQUJlR1BhOW5tcU1j?=
 =?utf-8?B?ZngwSGdBTkppdnQ3anU3MmFzVFE1SHp3M3BScG1IUHBFSkJRamNLNGRUaUVC?=
 =?utf-8?B?MHk3d2tNZEZwSmgvRkp0T0RmaXlTcGtNYjNHRjFGamovbkhyQkdreTEzTER0?=
 =?utf-8?B?c3pRRjR4Rjh5RThpYk5Ybnd0ZmZyRVlUTGlhdjZLZXlidFVvUE15ZEh2dWJs?=
 =?utf-8?B?WGl3alMrODRIL0hGRkVUcnBPUnV5YUVKRHBLVjBlQWRMODJSNlRGb0h5LzBN?=
 =?utf-8?B?bUNXNnVsYmFUZmNRSS9xYWtxclVWQmtxMisxK0VkQVNCUEdPZXRRTWQ0QXRO?=
 =?utf-8?B?WlFjM3hDaEZOamVqczl5VDZnNnd1WGxSS2kvSFllUzhNeDZIUHRmMVd4Y0FD?=
 =?utf-8?B?L1pzcU5scjVCdWlUNjJHMTcxWmx4R1dGTWU2bmV2MUxpZFVMQlR1b3ZKaGpO?=
 =?utf-8?B?bEw2V3dCemVFWFl5c25PZjhpVldma2FYTHcyQ1ZmVnBKTmpES1Zhb3U5TzBC?=
 =?utf-8?B?d2I0UnRFSkRVQUZUa0pFZ3RZN3YrVTFpcWpaUnl5TDFsWTVtWUduSTJMcW9z?=
 =?utf-8?B?dm9iNzk3SjJuRlNYN1U3RDZ3b3R0aDliS1M5d0p2RVVCbUErOVkyZW9OeVdT?=
 =?utf-8?B?S1RUREc5cWRKMWVNMjZxcWxCUUFGYWtWUTByeDBBYU1VR1UrU3NoQ2NmSisr?=
 =?utf-8?B?NytxU3hYQ0pndTQ0NGplWkYyZUJ0ejcwWlN2a3RGalBadzFqU2RWMFU5Nldp?=
 =?utf-8?B?OTF5YStDc3N0RUJ6TFkzajV0S1FXSkFGb2I4aFkwcDJ3bUdLZXNUR09aSGNM?=
 =?utf-8?B?WHJTREx0bXI4WGdybnVlQzNqYUo0cDk4Wkx6dkJYbGZDTm1BL2k4aXQxOHV4?=
 =?utf-8?B?eHlHczZGUkptaHhFcG1sL2J3VmdXdEx6YjRFRmd1aFduM2Y0UjIrSGhTMWpN?=
 =?utf-8?B?S0ViNnhVd3pZczdaMEhSd0lOZEhzdnczK0tVV2hpMkRMS0ZxWWJmZ1lnZnNr?=
 =?utf-8?B?Z0FSaXNESk9PT01SekdiT1dBdTlaYXdKbzV2ZGVuV2JCcU9FRms4bmZ6NXp5?=
 =?utf-8?B?bityS3pJcHltdTBkTzNkakNqNHo0bGxUQVZrOU8zN0w0RWpvbnNWZThRQmtB?=
 =?utf-8?B?NHR1dWFRdnVpR1pMS25oWmFSWTZ2TE02MWVpenc1VVl6aVJBdEJWTm0wVW94?=
 =?utf-8?B?QnI4Qyt2anVGbGplQWk5TzgwdUlYQUh0SVF1Q1lOajNxZjNrVU83d0x2b2xY?=
 =?utf-8?B?YVNSdFU3cEwxdkoraXlBMXZlQXdMZGEvVTFTMFdMTkZ2WFQ0cVVpYlBHMXhk?=
 =?utf-8?B?RFpybGN0bC9pdzNuWXJkSFkwbjg4NU44dFZzelBLRm9NNzVsN1QrTnJlaUlu?=
 =?utf-8?B?T2htOHlMUWlwYldwbmowRjNLL1BBRWRIdDY1L1M4SWhTdExjZEd3R2NOaVl0?=
 =?utf-8?B?T3pGVDI0SGxBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXd6VyswVFNFVFNUQ2FRNXhraFZvc25VRllZYWVuTHpOODR4elA1bTF0RHhY?=
 =?utf-8?B?RUh0c1BmVVhUaDBlNlhlaEovTW1naVFBMnVhcWFkM0lEQ21Xdk9tcmJUaDNO?=
 =?utf-8?B?ODg4S3Z2L2g1RTRZTDNQOFd4NVRic1crS0FMMktjczZwWC9UamVWV3FtL0JV?=
 =?utf-8?B?VGFDazhkQm9Qc3RoZk51SWRIODlJZWZ1RDNUZTk3QWtOZ2h4dStDUzEzS2tS?=
 =?utf-8?B?djYrUUR1TG0zVVVtVjNBNnlyeGlsZWM3L0RtM0ttOVF3dGlHT1JoVUZEOTlK?=
 =?utf-8?B?L2JyQ1o4NGVWYzEzNzIweEhFWUZiTUZsVDJoZHVoNjZ2Y1Z4TzRXaUZCZkZv?=
 =?utf-8?B?YVREZDZQejk1bk1pckxTbXVPeXB5ZFV3Z1pPZ2NYN3BOWkpFMDVidU5RdW5z?=
 =?utf-8?B?Ly93THJBMlNQZkZjMitjWlp3ZWI2RkcrcisrTGREOVpDS2l1NEZXQlQxVDUy?=
 =?utf-8?B?b0k3YUVBbXJFbytVbXhUR3ZSK0VrV1NRNDFjWS9GendhbTJ2YzFCdHRaQ1Fj?=
 =?utf-8?B?bysyMFNUb29ZbG9zbUtWMFRlaVlRUlNIMnI1T3JsREQwbjBYakg2bzc0Uk5T?=
 =?utf-8?B?bW5ZUG5qaFlxZ0pSQVhkVXBKS2JZY1VHUDhQNEN1VjdUNk5EQ0RrRXR1ZWNT?=
 =?utf-8?B?TjQyOHBWVTBueXlWelZYVHRUdU9hYk5FL3dPKzh2Y0NoUUFjQkJ6Zm1hMmhF?=
 =?utf-8?B?QzNNa1FXQVM4L1pnYXRWaUh5RytsN0pHMXNxRUhRUW5UcEdzeVNNemNjcVFp?=
 =?utf-8?B?U3pRWXZoTkw3LzNrRUViRC84ZW9hYUR2MXloK3dSdytnMkRVZ0pvV3pwODk3?=
 =?utf-8?B?MGNnMVdjem1LcDYzU0t1aC8vTjJWc21aZ2duUEZCc3YxRHR5Ykl5cEhYOXZY?=
 =?utf-8?B?TUl0S0MxTHlPMlM4bFkxZWRpV1dsSTNhdG1URDRtWE01Vm40UmtrK3lNK3VB?=
 =?utf-8?B?TkNwbVFjbFNKeVZ2Q2FSMS9LODM2Q0NjOFFiR0oxQ0RLT0JhMWd1TUU4RXd4?=
 =?utf-8?B?eDR4Z3lDWkY1eERxWUNDdjYzQkt3N1E0SkNtYTRManVGR3JmMUNBbVhobUFr?=
 =?utf-8?B?RGYvbElJYzhUSGpXOXp0cmdRL0JEWVExVnM2NHljZUhKcHBlMGNXWU1sdlNO?=
 =?utf-8?B?bU9YbDBneWVpSmN3WVhmRlVyUzdoZU52cWRRRDEyM1BDVVJWTzlOTkJYRDJw?=
 =?utf-8?B?UDVGaEhOYjFiOVNXV3AzckJaMllIZCthbk9DWUg2eDF0RllkR1dSOC9PK0RK?=
 =?utf-8?B?cjJSSVJIK3RpRXZ6SDFJYUxqUjFxYzZhdG9iOFNkTVphVFBoc2x6N3hrNkFr?=
 =?utf-8?B?N3lZZ1BuVmdYVHBnZG9Cc3pMMnlNamp2OUNGWkhxSFlHUUFjdFoyYjh3RWNT?=
 =?utf-8?B?MmJSN3hSQStzakUyZkxES3Y0UEFPUlo0UnpJdDBTUlRzbmF4WDF2Zk9mZnFZ?=
 =?utf-8?B?TnpPV25zTk1WTEVsajdRZG00eUN3QVFFQlhvZ2JuQjNwd0hWOEtpTy9PTEo1?=
 =?utf-8?B?WlhicENqb2tYQ3hDVGZIWnNHV0doWFpidlRGTXl3LzYyVVF3WjBVL3RhV1dp?=
 =?utf-8?B?QjZwbGQ3RTlhVU8vRitoVzBNMXA3cngxNWpqV2hoVVpmNHNmL3R1U3NwZkVk?=
 =?utf-8?B?TW0xNkQvWklReU9hSE5UL1drMEdCQnM3bk9UOXNPa1o1Q1hPUnhFeUJJWGkx?=
 =?utf-8?B?azdRQ3c4bHRjTjJPVm9GeTZiR09aNm5tcWd6QjNKYzZMeGRiUEVwcEhuemcv?=
 =?utf-8?B?Y2VNajFNY0E5WWdvNHdWQld0OG9VTlpHMnh6M0hUOW0waGdGT0g4RWxkaFEz?=
 =?utf-8?B?Nk40NWU4SzY4ZktjWFp5dzhKWjJwejdoV3pud3dlcWw0ZWNpL25TN2pGc2Nn?=
 =?utf-8?B?RmhwamxEN2QybUhiNWpGT0tIUzMvVE5DdXcrTnJOcGpzaUM3a0JjbG5EbTZy?=
 =?utf-8?B?c25YVGFmS0YrRTFxb2taeklyZEpEdDEwUS9KcDZOMmJNeXBmUjYyMVFRT0xN?=
 =?utf-8?B?a0I0bTU5R0hxdDd6UTdSV1RJRDhKRU5BUVF6WVNJbkJZaG1nZmdLSjdIYzYr?=
 =?utf-8?B?bVQwUFdyaUlWQUNsOTIxTE1DMUVOQXZyOUEzcnpGZVY2VWxWZ1FpZHI1NVdl?=
 =?utf-8?B?dWdGQW03d3Z5Sm9XR3pEYWlyTzhaZkNIV0c2cG1laVdCV2RmZXBITSt0VWJX?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a1e664-ffbc-4a7c-cb7a-08ddd92cd73b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:14:37.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajVkV8AlOLC0NNtlcbyV1k6hrRauortVSogfkul7uiEnNkb5pI/QSumvvd45/P+ODR9gv+PuZm4nKkMDZA5twLMWSo43WGYAa5Fyrl0z6Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7602
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
[..]
> On 8/9/2025 5:56 AM, Alejandro Lucero Palau wrote:
> > I come here after Dan suggesting to use this functionality for ensuring 
> > the CXL device functionality is on, and it would require to inspect the 
> > status instead of just the capability being present. Maybe I'm confused 
> > because I remember some patches from Robert Richter dealing with 
> > checking link up for enabling downstream ports, but I think the goal 
> > here is different.
> > 
> 
> Hi Alejandro,
> 
> I agree in large part. We need to check for training complete and any change 
> in training needs to be reflected in is_cxl(). My understanding is this 
> will be be added later in a following patch series. 
> 
> Dan, can you add your thoughts ?

Training completion is implicit in the fact that the device can be
targeted by configuration requests. DVSEC 7 absence means you know that
CXL is disabled. It is true that DVSEC 7 presence is inconclusive for
whether the device supports CXL.mem or CXL.cache. I have seen some
implementations hide DVSEC 7, but that can not be relied upon for
is_cxl() purposes. CXL.io support is not interesting.

So is_cxl() should probably indicate (CXL.mem || CXL.cache) because the
presence of those needs CXL subsystem infrastructure.

