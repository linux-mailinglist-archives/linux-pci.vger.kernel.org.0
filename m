Return-Path: <linux-pci+bounces-35489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E7B44B49
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 03:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686CB568067
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C9E571;
	Fri,  5 Sep 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNNyLNu1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17B1A23B6
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036411; cv=fail; b=PEgMukqmpcjq4asTuF05E9HK72w8bjU7RsQxr+G/sh49tAz04Kv2l9M1WeILjyRe1ZqC0ByLdV5EXZLdlawNnSKoGOarOboJ7YXQLzBsBxs0q0oTbhUJD72XAR/t80TTO3zWxB76WeZOWvHr/KyAbk4O8w5SaNor4KFH0rpdFss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036411; c=relaxed/simple;
	bh=uzHbzOQrZg95HS/cVZ+cF6sFMg42SufE1hfeasCaPkk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qqvIe2quE22vcB8Bw3pFrlvc/Jg2oZnH8fLGrPS+CwETI+36DuL32XN4z6ftVlbFf5PqZ75/xedbC4pXN/sVCCm2qZbypB5V/mqpkm12RCuYbPlec/rs51tDQBCORmGplkAFrmG3Qg9DwTwzF7cJYM1nlBB+g2+4pkhuhrXkzBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNNyLNu1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757036410; x=1788572410;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=uzHbzOQrZg95HS/cVZ+cF6sFMg42SufE1hfeasCaPkk=;
  b=SNNyLNu1xB4nCCnhVyDw2UKVpQ1qFN8burvRbI3+yc+DYGxXewtDuyKD
   K/4hnSsMLgAIcw55ABOkZnxV+fHUhn/wnNwlD09zII5pfaJDPa0aSPWXg
   +OpveG/ATCBoidqDb7xLxh568Hef7czlanmZ4IJ7+l6VIg8YQJUTdlhvW
   /f3ea1Zd+CCTh21IQEGd7hhuVBHpGyzHySuigjm3Kd6QO9VQEsYmBjQ9e
   yqqYospLDoWVZ+4Af+B2Breove8ZrC6JuUqLBC9nAYAowhkSAc7YM3AIn
   VgmIOqC7L81LH48FmC+Mmw1otHa2WGjxp+kOCqqXbGAwIAWpicD1qYItV
   Q==;
X-CSE-ConnectionGUID: 7OeZM3IkRCKPK38Id0bhDQ==
X-CSE-MsgGUID: aiJdEhUWRjaBwtf4aZpOLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59245825"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59245825"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 18:40:09 -0700
X-CSE-ConnectionGUID: Zl9CTpwCT26T1vdZTKeMNw==
X-CSE-MsgGUID: azaU9NJAT7ylRjrL/sOE5A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 18:40:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 18:40:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 18:40:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 18:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcF6uT+pRjR3fjgYoNT7ZuITfIDGL1PiM5vBdpAvkvfqFeTL3kv+u/pIkVARFtZSAKi9o6aOL3+4Jmj6wsXfcdT/xRcLwaGCbbkGx5XPicun7yLsjE8xIH3MWHqwlMDBunhLRiTApeVJd2wEphuTZOpc6389US+sZ8gt0FSQ1WqPKCuwp5bc+v8wKOiUtAv2aMVkQ5R8dINn0m7bcMekLITyuXLH+hs1Docmu9tO9XxFnVSMcoCb+Cvi20To9hKrJ5hgHTxER4oLMyOwwqU5RdD6iyGW/PfWdwqgPbAIgF/arP2XRlT3ltSQRUx5JqLFoXMrlNeBOedV/O/x0rB+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzHbzOQrZg95HS/cVZ+cF6sFMg42SufE1hfeasCaPkk=;
 b=kG6GCixi+iU2A+cG2aHaYCfCyvd4tpwDh3W2+rTGBEnRK5ygylteGsPgO7064m7EhgNd5Jlsv4GU2H3TR8P5egWb3gokpJ+mRYdhvcNWMWymz2bEgf/D1rkdLCIRIRGSQazqGGatF1b6J5rL7F4bA4YNvqHOMKDMoDzB03TGz57LQ/B2b6NDHQ3ore8pp+IQviFRcAvfzWCAIjHV+SWVjSfenVEECyx+B5uObdpSuCO1b7mK2rCG9026UXsEhKRFvPf4hN6wkFG/5eHPv0eSYZkkjwwYio1Ve5VAL08MJ/OMDSVG3wMZTVnpY7j/G4UdJPrTj2zXmWR8YUB1Q2+R4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 01:40:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 01:40:04 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Sep 2025 18:40:02 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Message-ID: <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6611d312-e831-48ee-cb86-08ddec1d22d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elpET0JpRnhqQ0xoSWRaM0RvTlhVTGE1RHg3N3QrMlBvanI4UWVhbFdtT0F2?=
 =?utf-8?B?elB3MFF0L3gvdnRkZWdHTVFSbHViaDFHTUN6TXk2eWw0cnVNUjBwOE1PUnE4?=
 =?utf-8?B?dGR3eXZhVUdDZlY2Y1N1VElOZUUvSmtQd3gvazVrWHJ2SWx6ZkZ6TGJITUFk?=
 =?utf-8?B?cmdjc0xGRktMRDcwRUVxeTdjdzIxOHk3bGZBNDlmeHVPZnZvRUc1Umk0Yjdq?=
 =?utf-8?B?T2R2dGttekxCeU4rMGtGbnp4WVZNb0NuTkJ1UHdGZ2dSd1ZIaTZSN0Y2QkNQ?=
 =?utf-8?B?VWxlR2MxUnlJZFBsQ1B3Y04vOGtsWmlYS0pzQTdTc3RTVlhqWDNCOUVKK29n?=
 =?utf-8?B?MCtYRVhlb25YNDMvek9uZEc0c0h4TTJwMG9pRDNsWnppb3h5RnArekthQWM0?=
 =?utf-8?B?TVVNZlN3bUFZTDJGS3VUSGRtMllmY2J2V29UYUZnUEM3alQyTm1CQVFrQU1T?=
 =?utf-8?B?TER3OVZIYnp3YjNjdzhlM0tKejBkVWRZV0ZZUDBXbUk2MWZGUHJ0MVlEYm1q?=
 =?utf-8?B?QmN3RE56K096MGhrdU1YUDd1d3VQSDJDYkRrSDVqZVBRVjMveXhPdElsNTZa?=
 =?utf-8?B?a2NMUDNKcWpCUjJjTWd0SWVnUmhzV25EN3dYNXdvYThDTDMyVGhScFltb1g0?=
 =?utf-8?B?L2pIc1NRZ3BvdFQ3anlEZnhqd2cveWo0aVMyaUhxaEpxWVBJRnRIQnV3ekR4?=
 =?utf-8?B?SmFpYm03ZzNaT1dJaC9MV09nclY1UThFb2tJdU1wd2ZCMlFOdnhOR1hMc2xh?=
 =?utf-8?B?V3NQT21kbGZzNWxZcjk4RGNzZzY4Zm9CR2tlVkpjS3BBakhKUGlRc08zeXdF?=
 =?utf-8?B?VUszNHNLQUJYa0VMZGRZMGJwU2hPT2VIQVFiTnlZKzNSMi9yY21TN2hPNlox?=
 =?utf-8?B?L25ScS9jeUExS1hqQzVLWTRpblJvN3NHTUZZckh0aE5rUllCck5BRU4zVkJR?=
 =?utf-8?B?LzcwMXNnZUVHS21TcFoxd3NkbEhlTzlmZWZpMG1oRkJJRUVuNUg1MXFhS1Zx?=
 =?utf-8?B?eVNpT3dhdk1QRXp2bkc4YjNZTUJKZ3lRdWF1S0YxT0s0ZDFYS1llbElONWU0?=
 =?utf-8?B?dE16ZWsrUmVyRTNVODJWczJ0K3VpRVl1VTFFT3lmZExaMkRybEFsbXFtWVlH?=
 =?utf-8?B?UExjTG1sclBBcmdlQi9CcG9uSk9YNzBveVRoazFpTHV5MTRycWJxSVQ2K2pN?=
 =?utf-8?B?ajRRSkw0NTJ3US83eDlJWVcydExmQkw1cEgyWk16NUxQMXZCN2l2L1Q3cTRt?=
 =?utf-8?B?UUU0OVdjeUZxSHkwMmJpdkI5ZWdPMnFxNEo0aDU0VlpSZC9oT1U3Umw3c2VU?=
 =?utf-8?B?K1hyMkJKQUdxRjN1K2lLVzBKYU51dVhCd25KckNKSWxybFczVmVFaUxQZFUx?=
 =?utf-8?B?L25IM1cwY3B3cXdvS0xHVTZndEpDTDVUQkp2Z082d3RubWIwWjVBOGF5bjRz?=
 =?utf-8?B?OU9CTm1ITDdDbHEyb3JmZ1lkeEVmY3lHK1ZlYWE2NFpxbWVxTXBiL3FERXdJ?=
 =?utf-8?B?VWdrMEpheGNJak9LN1dhazZybzJRM3hJVlpkdzZSOWpJUEd1U1BndnFWQ3Rr?=
 =?utf-8?B?Y3A0eWZqUUFJeXhscElrYjJ5enBaa1pCMTlEMGNUVzdLYUt0Ym5KN1kvaExB?=
 =?utf-8?B?N0srYWpXaUNJK0ZDNFZkVXhxK25LdDJnUC92VndXWlhoZWVWNnBtSVhyQVc0?=
 =?utf-8?B?TjRyVE9EbisrNzFrRCtIelY2aGVnU3M3Zk5CZVZKQ0hwOStJMzQxQThIR2lx?=
 =?utf-8?B?RVAxUFBNWUlLNDZaYkVKT0RnWU5lM3duQnAxTnY5ZERwQjdoeFJWLzI5K2JR?=
 =?utf-8?B?WG9Cb3Qya01HZUNWQS9BaDlmWDRTRVkxRTM5SmFlM3Z2QUpkOVAwd2RMcWV0?=
 =?utf-8?B?dzA1d2ZaUTNvU3R1Ymo2MVQycXpKbVU3Q1R4T0Fnd3VBSnlwdVhtSE01Z2tF?=
 =?utf-8?Q?lSmjb57GSn0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUhhcnFBYi9ERUhzSDdFVlJTZVlYMTZURjcyM2lXSVRSdUVnWFF1VEFaQmxO?=
 =?utf-8?B?dWlEeFNPNWUxdmlrWVhsak9sUnd1NGFOaDJVeXY5Nlp6YnppQXV1VHZheHlD?=
 =?utf-8?B?aEQ0cFQ2S1c0K2tHZDdmK3VNNzBKU1RtWXVMc3NBcXVnK2sxaVpIRUErRHRs?=
 =?utf-8?B?Z1lkcDhVaEVEK0UxZ1FjMkM1NmhvVUl3TnBCWEc5Tk5iMGRqcXNxNnBNbStx?=
 =?utf-8?B?NkdVVmxJbWFNaTJCSWxWY3pVNTFvWW5TWExlUWVURE4zclE4bUhCdGJ4VjNS?=
 =?utf-8?B?R05MTjBQa0lYcUt0d3ZET096aUQ2czI4OTFSZ0h6RDY3UHgxUFhJODR1ekhS?=
 =?utf-8?B?Rmkrdzl0NWgyS1FWOUY2cnRVSVhQZmowUUpXRDE5N3FPR0V2aVBQamoyVDZv?=
 =?utf-8?B?VFdZWkd0cnpiVWYrbmczT0xEaFdkVkE5TEVJTldnQ25yWFA3bWxTV3FzVkxt?=
 =?utf-8?B?N0tnNHQ2NHJTNjJLSStUVnFDeXozZGppTlRXc1NBOE4xRnM4ZjduVXVRZVFZ?=
 =?utf-8?B?Mjk1cWovVjhZRnRqSGVDSkFFU1Q1NnNHcXNkUit1YTBxK3E0MUpNUWlRQ2dN?=
 =?utf-8?B?QzJocEZwUmt5NTlZZXVtSWZCRml5bW5MVERML2ZEenA1Qkg2RXU0U0o2WkNT?=
 =?utf-8?B?TWpoUFRZZTg3VTRja3MrYkJiNTRBR0d2MTllVVRjeTNKLzBlM3ZZaEE2RXVi?=
 =?utf-8?B?VHFYSFBmRVl2aWZLR095QjJYcmU4bkhjYzBJVlJvTEU0R2xGbG9MaUErUUxU?=
 =?utf-8?B?NEkrT2dIRDJpYVhzM2ZXRWJvY2g1akp0MGdQK0NXTy9QNE41cVo5b3ovWEtj?=
 =?utf-8?B?QWc3RDl2SldLeTNEaVNaRjRjalRDS2tTV2orU0JxaGFUKzhRUjAxa0dxTDZU?=
 =?utf-8?B?a1JOSDN1dnJad2cxMHFUb1hkbEwxSG9Nb1pxelErWHF2eEVtK2UrVHNRc2lR?=
 =?utf-8?B?ajMyNFp2ZlZpYWtTczlRQ3VteEcvWWhieDFYSHJGVEJOWnBYeW91S0dzWG9h?=
 =?utf-8?B?SjNMeUxOWGFOR1FnQUtoT05NaW9RcTBmc2FlV2QxN2lQNUFhSE9wK0daOFVy?=
 =?utf-8?B?eDZMUDNudFBGUFEyZ3NNYVZ4Sm1meEJNNmtUVGlBRE4wUE5Eb1h1WDluOEhS?=
 =?utf-8?B?N0JOendPZTZlNHkwekxOTnBlZWxwRjRIeXJKcmoxMWNCYUpVZ0gvbS9SZE1E?=
 =?utf-8?B?WHlRT0x6OVYzZWN4U2xaRzA1ZktEbHJneHNjZTZqLzZHR1lMR2R0SmNUaFNE?=
 =?utf-8?B?RTRMbUNKc2hLSWJwbjNRSTN6bDVWRDhkVFRrRVRvUC93dEdCMmlPU2l5Sys4?=
 =?utf-8?B?SmtyKzFUdVVPbktPbkZpd2VMRGV6ZHFOMGdyQVozd1FGdHVtalhRR0tibjBt?=
 =?utf-8?B?TXhIMml6WXlQY3U1OEJTbU9GVGNOOGtOc0taK2FQQW9HemdlNEpYdjVTa3N1?=
 =?utf-8?B?bmt0S3Vxa0doZm91U2VHVGE0MEhoK0lQSzZBbThkOVVHRWFuMGQ4VUtmTUJh?=
 =?utf-8?B?L1FnU3ZQb1owTWhyREk2QWYwR2R1aGtGWnRvKzdtSmlzdGdqRHhWeGowUFZx?=
 =?utf-8?B?S3RJaE1DYW01bldRYlc5RFFBYVlMQzBnV2hTUG1ScFRTblJ5Z05SNk9UL2dl?=
 =?utf-8?B?bndGcW9nR29tRjJuQkVQRmlMN0p4VERMMkR5RWNwd0NnMG4rcXQ2V3pnU0kz?=
 =?utf-8?B?aFRVWng3SGF3TEZyY1ZhVE5UTHJzQmYxL0tkQVZuY1FFbmYwcWwwek1qakh0?=
 =?utf-8?B?djEvOGVMM3ZCOHUvdWtSZXl1U3g3c29MUjVNejVaczZDRGtldjhWUGFzakVX?=
 =?utf-8?B?ZzIwUWQyYkp3K1dHRGl0SHdhQVNWZjBQMkZaeXltRExoSURpQ3h0YXZaREla?=
 =?utf-8?B?TUtXeWVHL2VteTh6T084djloaldTc2dVRDZPZ1JjVGg2WWEzZ0Mxd0MvcWdS?=
 =?utf-8?B?NFVFc1ZEVGdLSnR3cjJmREY1alJXbEtmM2ltM0xSNlRWaWVhMFE5NEorTGI5?=
 =?utf-8?B?aWtyMGZBaFJmSlQ3RDVsS21ZbEErRGlKY1F4Nkh2RGlvVENrcnAyTHFpQTVJ?=
 =?utf-8?B?OW84bzYrRENlbGU0b3VRbTJwZGhFVGlVU292SWVyb3JUK1BXK3pzbTdONjM1?=
 =?utf-8?B?dWRLbGd4ZkVma2ZRblVUaVNxV0h3ekFwVU1yREYvV2M5NnpJZjFJQ01oMnZ4?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6611d312-e831-48ee-cb86-08ddec1d22d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 01:40:04.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLei6DWIJVWMDR0XMJpeIwkhZneNDGS4N638HrKxJH/3T50KFnMRvEq8Ykv2bF9qYMxLSB51FcLqu7Ty7eHnrcvnUc39BGoosFopKskvM+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> +/**
> >> + * pci_ide_stream_enable() - enable a Selective IDE Stream
> >> + * @pdev: PCIe device object for either a Root Port or Endpoint Partn=
er Port
> >> + * @ide: registered and setup IDE settings descriptor
> >> + *
> >> + * Activate the stream by writing to the Selective IDE Stream Control
> >> + * Register.
> >> + *
> >> + * Return: 0 if the stream successfully entered the "secure" state, a=
nd -ENXIO
> >> + * otherwise.
> >> + *
> >> + * Note that the state may go "insecure" at any point after returning=
 0, but
> >> + * those events are equivalent to a "link down" event and handled via
> >> + * asynchronous error reporting.
> >> + */
> >> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct pci_ide_partner *settings =3D pci_ide_to_se=
ttings(pdev, ide);
> >> +=C2=A0=C2=A0=C2=A0 int pos;
> >> +=C2=A0=C2=A0=C2=A0 u32 val;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (!settings)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENXIO;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 pos =3D sel_ide_offset(pdev, settings);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 set_ide_sel_ctl(pdev, ide, pos, true);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS,=
 &val);
> >> +=C2=A0=C2=A0=C2=A0 if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=3D
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_IDE_SEL_STS_STATE_SECU=
RE) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_ide_sel_ctl(pdev, ide,=
 pos, false);
>=20
>=20
> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
>=20
> "It is permitted, but strongly not recommended, to Set the Enable bit in =
the IDE Extended Capability
> entry for a Stream prior to the completion of key programming for that St=
ream".

This ordering is controlled by the TSM driver though...

>=20
> And I have a device like that where the links goes secure after the last
> key is SET_GO. So it is okay to return an error here but not ok to clear
> the Enabled bit.

...can you not simply wait to call pci_ide_stream_enable() until after the
SET_GO?

Are you saying the problem is that the shutdown path needs to do the
reverse SET_STOP before disabling the stream?

> Was it "Do or do not, there is no try for pci_ide_stream_enable() (Bjorn)=
" in the changelog? Not very descriptive :-/ Thanks,

I understand he was taking issue with the comment, but this practical issue
is much more serious. I will push error detection and cleanup out of this
helper, and make it return void.

Thanks for the hardware testing!=

