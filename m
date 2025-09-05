Return-Path: <linux-pci+bounces-35573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E4B46452
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB1716BB99
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F327B50F;
	Fri,  5 Sep 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu4BNMO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645C2868A9
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102777; cv=fail; b=J710fx4MHQDyFOh7FF40Ve2TEzkoYdjQAiH96xhaHyRifEI69J9WJnfi2iGqYzSJOVkAgtjfTp+r7ThooOVAdm5I/HqgWtVWOQZzLYhO28pBTZdg36aY2GsSJ0oTnpHnWnCOurU/laXvWpwe5dKDwHFHFBWFrRzl4Gv1Ef/uCcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102777; c=relaxed/simple;
	bh=/GiFxvatIbMbflJ9y1Kegcmefk4lL8c3dEzxC/t3+1Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aUAwwNCRnIS5gNs5Q++u9TpcdHAMoX6PVPQHDXX4XTZobr7nnHJYSPm9CprXy49LGoRZAeNqhsch3Iod61cOpwZCrLd9jlCsExP/0WP19XssjGvfExLgWVMDvOxzgUerxpOuOcL7aLSOV+a3M3LUNMGEPL/ut3nB9NtYekpzyOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu4BNMO+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757102776; x=1788638776;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/GiFxvatIbMbflJ9y1Kegcmefk4lL8c3dEzxC/t3+1Y=;
  b=Gu4BNMO+uUvArZHL7bK6VozcTTRPnQ1wx4AaIiHuqTMZGrRc6eNVQ42T
   bnov5VDAy/9a1fkcmpm9jpeTobO/0+nBIduy+ToQbgKcbO96XhXWOvb82
   EUZwUL8bUSo9CXRe5BjoKpEURuOcoJVLmlqXFjrRdpwQavSFkdGtxZmMK
   gEbajM5NAXIg0EsVqshizPodDH+DSHoyeOyWtKjoH3YeE0kPr1yDTgKUm
   Di0GMfDwsf1nP/2MSrdGcBd7rgxzEiS2wBjPeLo1Tyqy68CQ5i9zXcIL4
   FBQfze19UqqnbitND4nn3iC7RQ1Gc9eZXFLSDocdzFhGusHmDnFavCW73
   g==;
X-CSE-ConnectionGUID: AknOiogpSZejABw8c5T/Rw==
X-CSE-MsgGUID: zSqPcF+pTDyb5oxHwADvcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70076915"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="70076915"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:06:15 -0700
X-CSE-ConnectionGUID: tmUz+7G6RNmiIK1+GF3WtA==
X-CSE-MsgGUID: uJfuJ9frTkmJ2ehtNIOQgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="172126916"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:06:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:06:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 13:06:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsQBl7tnIgeq5zFKrYgIHyrdg2VbvBjvYNhZZmIbfL8/T04kIPLaBx6z5tKVM9s646fqEPWBqU+GDnHI9tVNiM5X1CSBzrx+8izi2uaFn11RjqILJKAylgUE9x3OopX5eQMjnWZU+wRcRMTIlAZdkoKgr2poeystSAXxS5Jh5o2ZBum76+zdnvAgQy7+T61gij44OnJ7S9X+xUa8l8ELkSoMKxQJDQRnG7d7f0kFnfTeVS72OtGB+4tspOQEPOdc/dudl34/X8S5nI8oLySJN4VNzFn/gyPRHfWsOHFZT8QxQMqhFcIuymlaVcFv8bBs3tyclwh8FhswpQd6VxDeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFjNaWDfE71KPMlgSu6uu4vpbdFNX5rGboBaXYk84Vc=;
 b=x5h29m6rIvrTaFOezcRJWlvuL+T1dgmh9+ESer4OeAGD7509Cv040cQMg3biEkdZtcXiD5bTHDaZf5stWsohyaV0/c7z60ARk7kYJEyn154VjaeCsHEXOzrJmeVqfTb2hs8o3YI60XelDC4y3fU0sv3F854QN0TxUJrNnc2jW4YHkZkmaEkk27MTstMCSyssH2LhtzGf3keGhqiXMSvlwIiVwkBIy/ZwIqtG6I79xkS/Recd3gxjP5DIIIj3seU/54S1C8qCnwttxpcFQXvWqn3dw9V2IrzZOYbI+JFszYIg02Ro/tYnx6B/9mWvh9VtZ3HkgrAFtunOhO8UqJbTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ5PPF183C9380E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::815) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 20:06:07 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:06:05 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 13:06:03 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <gregkh@linuxfoundation.org>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Message-ID: <68bb42ab7e542_75db100a1@dwillia2-mobl4.notmuch>
In-Reply-To: <71d8abc2-82b1-491f-9075-d5259e83f9e3@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a4itk3n9f.fsf@kernel.org>
 <71d8abc2-82b1-491f-9075-d5259e83f9e3@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ5PPF183C9380E:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cec562-9630-4b97-6287-08ddecb7a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlM4MU43K0ZCeTFhWGxQeWVUejdtd2pyUlhCRzZNemdrYU9TZG96dEViTTdG?=
 =?utf-8?B?UHAva29BSXhhQnNBNGppdXRaZG5heXQ4MzNzWUNIMll4WjFLSHV4YlhiSEJX?=
 =?utf-8?B?Qzl0cVMwdFpZemo3U3ZmZFNmVzd5STBncFZqM25QNzVZRTA5VVpUeFRkRi9U?=
 =?utf-8?B?U282dVJSM3g2cHVXV2o5bU1ubXZPY1ZmczUrd24zQ054T05PbFRaL29Qbmhp?=
 =?utf-8?B?c3U2Q0Q1bm5nRkJ1Y1RZRzkzN0tOeE52Nld0YmpEYy9VclZ5U0lOaDAyV25k?=
 =?utf-8?B?Z0xTdWU1QWp1OFRmMXFaazYrb2NOclhUN2pXRDhOaDFsc0srRWdGcFN5blZy?=
 =?utf-8?B?QXdvWmVEUGMyR0tNUFJyVzNpb0RBSkZidFRORG1yQjBtSVZxMzdZU3YzeWpv?=
 =?utf-8?B?ZTNwTjRLT2ZXNDF4Nzlid1F5Q0NDbEdvTGQ0OGZ6ZDM0UWIxcXdLVmllTS9L?=
 =?utf-8?B?Qm5PQmpGczdHK013TWkzc3h0U0ZxZGJaZUtHcWNaSnFVZUlhS3hsOXRiN0Jm?=
 =?utf-8?B?elBoVFh5STJDY1pjT2swQmJSTWV4ZjFUbnVLSXR2cUo2K00xTDlPUHdKeVNl?=
 =?utf-8?B?UTVvOEpOZG9VcXlxTGJyelF3TlAvVnhkcFJyMWdxejI0UDVHbnhRaWRWQ3o3?=
 =?utf-8?B?UTFyWjVFbHNZeGR4cVZVemI4Q3VqWnMvNisxK3ptNWJRSC9qQ2lBMmcrYjJh?=
 =?utf-8?B?VlpWSzNvaU1XaVF3ZlgwUjlrQm9ab2E1ZGlsS2ltaFZJYzFTMTBHU2RlNHN1?=
 =?utf-8?B?OUZSbitqOXRmdXhIbnFiV1lHaklYTHIrVTNPNlU5aTBpbll1b0l2YjNnYkY1?=
 =?utf-8?B?bWozNzhjSEt6ODFFTlJMSkpxcjQrNm9EbnlNZlJ0RUtZVDFSdWdaOVplNW1X?=
 =?utf-8?B?Q3l1ekovcFROVVZVS1VISndONXpoN0xoYXBWa2JaRC8yTXVWU3RQb2xvZXEv?=
 =?utf-8?B?VXhaK3VqWXp0cjE4bkhkdFVRdHE3bGRvYmZlWUdnMlZ0aGN2d0JDaVdNaDBK?=
 =?utf-8?B?b09UMUtBTVF1dWh6U3ZNUE9QazNNdmhVZjVrdXdxZjFhN1BkRXZpZ1d2VUZK?=
 =?utf-8?B?K0NIU2tvNDhHaStRS2NVTkphTVhtLzFJWnhEY2JnUWFwTDVrSzFNc3dzanRR?=
 =?utf-8?B?NGdubDBYZW9EUm5zeVJ5bWNYNmkrblpzeS8rMVpnZ2t6VmJuU0tld0hGRUdP?=
 =?utf-8?B?anZSL2NsYTBKVUhTUGlHZWxRMWdMaDlVZDd3K2RURlNlcjVaOC8ycERKQS9R?=
 =?utf-8?B?NE9WN0VCY0FvUm1yMHFveWduQTZlVFQ0ZHlQclhUcER1NGJrbDdDRVhZTEQx?=
 =?utf-8?B?UXowQlY2RDhjcGU3ZklNTzJVcmdwOWhtQ1prZ0RQK1BsWTZROFM3ek1NdUZ4?=
 =?utf-8?B?bzNHeldyMU0rYUp1ZXdicFNzNUxwV2txVHNsWnZiZ3dTS0wzYURNYkVqaFRR?=
 =?utf-8?B?R1N0czhKYTlGeURJQXJoaUszUi9MTEFuMk5rZXpNTVBkbmg4QUNFQmFUN2JC?=
 =?utf-8?B?M1FueFZDb0Rmc01kSVA3STFNRGNKQjZNSzZTYUx5VWtrcGlrNXJhOS9NK1VX?=
 =?utf-8?B?aW9GTmpWTm5BM1Vsc1praVpUMzJ1SGVYTWtRRDdlQm94MGdPTDk1eHQ5VUk5?=
 =?utf-8?B?cDc1OVBXbHNnK3hnNEZFTFNnZDNtbWExSlYxMmVQTE1LckJNRlRVNENlVmFu?=
 =?utf-8?B?V3dpalhrUmZBanJpaW8vdlhKTzBqNmdQQ1BIdXhndWZaZkpUeDBmMWJWbFEw?=
 =?utf-8?B?QjVHV1AvNWtxY2xCdjFXVmthZXE3WUQzSmJXaFhveXlRSjZTcUUxZWlTUHcv?=
 =?utf-8?B?Ym1kUDJ1S3dNd3ZxU1RKRXl2Lzc1RUhYcGYvWE1ZWHl5MmV1Y280TThCbzQ2?=
 =?utf-8?B?UURCZUZBSGxEMVNwekJielFpakhsK0R2bTFsV2NvOGxtRjBRK2NtNDg4djdJ?=
 =?utf-8?Q?oPfBxd/Lz8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHNLT0dET21kVDAvdGZXbFdEaFV2SVhCS1VaU0MveGF4OVZ3L2w2bkh6dmJa?=
 =?utf-8?B?YW9pbU9IOUlCVnpObVV3QXRXckZMWVFCR0NWZXRKQ0NyTE1BY1daZ3pDNWth?=
 =?utf-8?B?VFFFdzFjMFU4SUpmWXZzNlBLaDEybXIxQ1B1U3k2MldSSE96QUF2R09PSGVM?=
 =?utf-8?B?OEdKNkpHdlFpR2Y3Ry9odFZ0K0pPWEVpc3hlM3krNWhkeG4zUGRDV0RUUkNV?=
 =?utf-8?B?dGVoMWYyd011VFUyblFwUVQ4TzlxcTVMdVh4Y1JHdWxrSWNuQkRsNTdxOFh1?=
 =?utf-8?B?dFBjVlFrcTBvWkhodG9mK05NME5QaklQeFAzd1pTZUNLbzI0dDFCeUhJcTRY?=
 =?utf-8?B?Umk0N0t6OS85VU04enpVSXpncDJiVHptRkVJcThZSm5Cc015d3BJaDNBVEMz?=
 =?utf-8?B?d090V1ljclNjUDI0ZFVGenJNWlcrSHo5ekJRV1dOY01NbHVaQ1h6Vk1Bc2hM?=
 =?utf-8?B?NDFyTk5uZVk4bGVlK1lOdmt1ZTIwYkZOQkRSUHh3RUhtMENlZ3JRNDBUWFp2?=
 =?utf-8?B?WkptdnF0SUpaTjlXQ3JoUWhtK2Q0VGJHZVcyVTVWYUlaMTVnWldEbXUxb0Ex?=
 =?utf-8?B?Y2ZYTWlqRXZlZWJ3ZG05dnM0c1M4ZmVmMWlLd09hbFJjRUtvUVFvNUdWNXlt?=
 =?utf-8?B?Y0ZYS1owSzIrRHE1eS9CWko3cEg5b1k3bVB3QTJGYXFzWUVtNjBMQ3o1Qm9s?=
 =?utf-8?B?OG5vN3FXb21HT3JEb2xseGlPMTVwMll1eEdaNjMzbnFnMm9FdzVYblRmVUY4?=
 =?utf-8?B?R3MzNTdacDI3c29qekdCcVJia3ZqMFo4cWJCWk5HMzk3dlFOaDd1TkhIelFE?=
 =?utf-8?B?TGx3WUlKUmF4ZUJQQ2xsRkFYZ2V4cHFYbE83NXJBaWZiYVd6TXpnZGtTUisw?=
 =?utf-8?B?eEdwS2xwUitFRFRaTzJRVXc3VG1RRmcxZktta1pMTGNkU0Y5OUFablpNQjNt?=
 =?utf-8?B?ZHQ0N1FLOGF2aEIrWjQ3RUpPMVh0cTcvVzF2T1JwVFRwY28wNjM0TXNZWGYw?=
 =?utf-8?B?OXl1UVcxRXdMclhUYnV5NDhZUnlHMHBhVmh5TXVacHR3L0h2NkgrbTZqWXBZ?=
 =?utf-8?B?Vk4xUy9IUUVobmdHUmJYaHR6T2NwTVpsd1N4cjFSeWowN2IyY2NvN2RodDVJ?=
 =?utf-8?B?aThIQVhYWi96Q0N1WldOZ2dTaGJqVzNQQkhZdEw3RXJYNUQ4a2xqc05RN0JN?=
 =?utf-8?B?eU1tRmZSeEZzdElMZkM0ajhrSzRpb2hxd2pVVFpPRGpjL0IwaHZxN1N1ME16?=
 =?utf-8?B?MVYzRUxEWkVCNnBNdHd6d3VyNzZsa1J3VGZTQmhDOUhRd0NEOGhnVFZYN0ph?=
 =?utf-8?B?UHdDRFJ6blR0ZzVSN3IzTlc4U05CbTkwZGdqUEs5WmUvQm9aaW9nRDdwTlp1?=
 =?utf-8?B?VWdPVDQ4RDJOa1ZIeml2TEwrWmZKY1pLRHowM0Rnc1BXTVh2TkRBQldIVzAy?=
 =?utf-8?B?WDR1dFVocDEySnE5MHhYZy8yNWdmQW1KOG1RZDhXaGlJc0ozenZxK0pVby9Y?=
 =?utf-8?B?RnZUMDhadUdQM0YzWWp4ZHlTdEhxN2ticXoyTGRIU2xtMm1iWHFIcTZxcXZH?=
 =?utf-8?B?ZmFCMysyQmdhaEpKbXZOUzVxeFZtSjdMb3ZVd0JEa0pBNjVpQlZHTlh3YzRD?=
 =?utf-8?B?NjMxell6RmV6TkhLV25hbkoyT0FTZUJBT3RmVVdsVVp1RVdSbDVFckZBeCs1?=
 =?utf-8?B?VXNCTjN2c2NMaGM2Nms1emtzdFdDRFl5b1owRVVEOXRUZG5nUVUwV0RaTmpy?=
 =?utf-8?B?U0VxclFNbWpMdktQVlZveVpHYTZHN1FsTUdHM3RLRk1BT2loSGhoNlZpWWJh?=
 =?utf-8?B?akNvc1RnZkkycEpJSmUzZFNDTllQdFFlQ2tkdEpOOHJRSERrVTFiRjRHRVF1?=
 =?utf-8?B?ZzdhOG9adXNXV3VlcTFIRjhsazBvZzA3UThwV21rQXZkWml6VXo5dzZ6Y2dm?=
 =?utf-8?B?T21lQ01oQWoxMnRIMXc3VmFZNWJwT2JJQ1hNOHd6b1Y4cGtiTzRZYXNHK3Jm?=
 =?utf-8?B?a3d4QjZldTdlZTI3R1VMazVzWFJFemJGeWUzc3F3SXZhZkpQM0cxcEpDekdI?=
 =?utf-8?B?TUFKKytvb0tsVlVDTGRLWHhSOUFXa1JKeFZhOFNLMGRSb3hwM1Q3L1JSeUJj?=
 =?utf-8?B?UEtVUmNNSFlVWWlucHdEVG9kekFmcGVlRnMxZHkvN2tucHk1WWFoZXpka3Zl?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cec562-9630-4b97-6287-08ddecb7a569
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:06:05.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx1jlCR+RlWU9sgvh0hwQQ/mriuqlCnl/fUNZErYoaQsbz+AuNNibbB4VVrGlG04U8DrR8CoufWS/NU9zaQ4o1LFVtEqjiJ+aD+t8ztEw0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183C9380E
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 3/9/25 01:08, Aneesh Kumar K.V wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> >> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> >> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> >> protocol definition builds upon Component Measurement and Authentication
> >> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> >> assigning devices (PCI physical or virtual function) to a confidential VM
> >> such that the assigned device is enabled to access guest private memory
> >> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> >> CCA.
> >>
> >> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> >> of an agent that mediates between a "DSM" (Device Security Manager) and
> >> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> >> to setup link security and assign devices. A confidential VM uses TSM
> >> ABIs to transition an assigned device into the TDISP "RUN" state and
> >> validate its configuration. From a Linux perspective the TSM abstracts
> >> many of the details of TDISP, IDE, and CMA. Some of those details leak
> >> through at times, but for the most part TDISP is an internal
> >> implementation detail of the TSM.
> >>
> >> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> >> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> >> Userspace can watch for the arrival of a "TSM" device,
> >> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> >> initialized TSM services.
> >>
> >> The operations that can be executed against a PCI device are split into
> >> two mutually exclusive operation sets, "Link" and "Security" (struct
> >> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> >> security properties and communication with the device's Device Security
> >> Manager firmware. These are the host side operations in TDISP. The
> >> "Security" operations coordinate the security state of the assigned
> >> virtual device (TDI). These are the guest side operations in TDISP. Only
> >> link management operations are defined at this stage and placeholders
> >> provided for the security operations.
> >>
> >> The locking allows for multiple devices to be executing commands
> >> simultaneously, one outstanding command per-device and an rwsem
> >> synchronizes the implementation relative to TSM
> >> registration/unregistration events.
> >>
> >> Thanks to Wu Hao for his work on an early draft of this support.
> >>
> >> Cc: Lukas Wunner <lukas@wunner.de>
> >> Cc: Samuel Ortiz <sameo@rivosinc.com>
> >> Cc: Alexey Kardashevskiy <aik@amd.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > you dropped pci_tsm_doe_transfer from an earlier version of this patch
> > in this series. Any reason for that?
> 
> yeah, me, it was rather useless wrapper.

...but then you did say ok to bring back later.

> https://lore.kernel.org/r/68ae4a0c45650_75db10016@dwillia2-mobl4.notmuch

The type safety of to_pci_tsm_pf0() probably has some value. Yilun has a
user. You are free to ignore in the SEV-TIO case, it's just a library
helper.

