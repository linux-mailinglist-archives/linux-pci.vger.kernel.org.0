Return-Path: <linux-pci+bounces-35792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC5B50CE7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 06:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83BB7AC2CC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA1239E63;
	Wed, 10 Sep 2025 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4eyeCM5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFB1F4297
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479622; cv=fail; b=pZJbMgGSpiNDN749ruNKjkx0PO99h7b3OQHZAxPuyQY691iSVVj9LnuR33sBCfxe37sIBiCy+YaGZCAkfDqaq9BTgFxNgi8vUX9uUMHHiyaEpZhT0JPl6CDvNa7G5FI/Tnj1gHI3Ka3l+rnVdMKPRDamOPiOzl1WSQan3MtFHLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479622; c=relaxed/simple;
	bh=v8fK+002nlE+DCexW9TtrPDILb2l84lGYgjfFi1c+tI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oJeTiOED2LPHOvY7cCVEms9ZWrp0K7EjmDlq68TH4s326JiknkqP61l7qg+7oD8zievReDKCWMQ6d2VrYkJl4/YgwgY50P15uPPAdR5Y5glsl68T5uKplYGjKivQwdQcFd4Bk8RGdzQkIJpw2unvRE/Ssgc4JIXxb2S60PnyLSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4eyeCM5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757479622; x=1789015622;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=v8fK+002nlE+DCexW9TtrPDILb2l84lGYgjfFi1c+tI=;
  b=X4eyeCM5mODdJT028jj5pHBdBQXcphNg+juSNKoA7iY3yBwa00aUyAd3
   1Zh69XRs6zR+EtInPHE+yGP6xUCVIJYh8t2AWsuQ8bQP6wLu/rGj+G17N
   rojMQBkCTIc/3XinOo1RSDk9FhRyaMKNz6+WEmTdFNWefCPic3VQaVjMK
   +oZhPZhaX2O71cLXvzePeaKEo/icck49nPsOp5fHnR0ry1Eppx4HCfXLi
   6yuG0NEBV4zqYS9uFLWlRafGoNIprisjS07PX2nkvY5VEMRTTg/jD3nue
   w8o/W+a3nSXLOAs0Jieyy3YQxcfxRs71qsQCTKJvZfUFZIXAsbI6/4Dm7
   Q==;
X-CSE-ConnectionGUID: hZcHGUFBQIu7QCoOMl5g/w==
X-CSE-MsgGUID: ykiaJZbgR4iJ4ndpjlJzSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82369557"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82369557"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:47:01 -0700
X-CSE-ConnectionGUID: 9PspxPjETYKKf29nehzlGQ==
X-CSE-MsgGUID: sQiiMzBqQy6iMGXXJVnG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="174064832"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 21:47:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:46:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 21:46:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 21:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIsrdBTyOOQ+Pxn7Cuzyy0pPGh0pF5IYDZgCYwrs18tZqQIxoAIgK3a9Irqo6OfVHp85OTLyQt4bBX9i4fKJtvGt0Iydy4yhO5pKVf+b+1hpSL6kC0obUIycHcd0aKYTLu1ivO+xaOxXsPBAjKRy87K34SE9kn4AZHHMDiVyK84o+QEmkcuiDNtAn+oO15VCRD+2bbEvpFyQFQjkSaESAVqVHdgLwmOEY589u44/y+EHPb7ram4KIBO00tfGoe6VQg4BVAkUZnNByolzVD40Jxg3bC9uhRmNhRcYk6pnFQyg3SesRA7iO2oz9mbIty6KiQq0X6SoNCfzldnJwpG5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x5nZy7aTMCwGZAD1O/hr1m8yPh681PY+yjoMJYhRUk=;
 b=TFszq/eZxUjpWFl5m4AHDzhlGLU0/FJLiNIT+4TJdUTIsXbKhgXmQ9JX4RktUTAlCWp5B41AB+AhebDbLcMteoZNYAGzH3bEtsjydFsc+ECWCLDA21I2Ov1/Auf0lhy8xeG/2WL7fPb+c7UeHCNOab49vOV3wrwpjtas2F2q87EsFlxAGzzR+Apf4YsQ+m+xNBp5TT4rc2tgVL52PKNFwq5BBLAcoGpS+PqZC5CKO9vVBYfY5q1Ef36exqppqfvlTN6Ynfeky80OTPbb+x7wP6Ck3HBBP2h5FTxVGlS6xSQaGR2Ljcsbr+kmceMn5S1LHu/azcPevGdJNJrATBiOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:46:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 04:46:56 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 21:47:01 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>
Message-ID: <68c102c525c22_75e31005a@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5aa53c3ngp.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
 <yq5aa53c3ngp.fsf@kernel.org>
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 758c44fa-da2f-4b68-ff0a-08ddf02511da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEZ4WG1oOHRwaEV5MFQ3clQ3R1gwOGRHYUVncWlUaWdtcXY1SU1TcjEvOU5J?=
 =?utf-8?B?RE9SaURpSWNJUnpKYkNXTXc5R0pzaEY4amhJY21yYVJTQk9xcWpqKzkvelFK?=
 =?utf-8?B?TEN2QXJQTm9XQ2NtZm43TVZGWjZxSlU2Q2lXamxMN2xoVEVpdUM2b2pENm9q?=
 =?utf-8?B?SjduWlVvMUh6UkJwemlVbDVqTmtwRW1YcGd2Yml5c1BNVTZCK1hPNHRtNzJU?=
 =?utf-8?B?dnFnYzBna1dVQnNmVEVaYzhOMFdrMFRsVUNhbHlpRGxPbG4rL2UxdGR2Rzd2?=
 =?utf-8?B?WjF6bkhKV3ZZcGNRSHA0aDd0a0pQaGN1SDk2dW9GRWN3YXd3TGFETUVkT1kz?=
 =?utf-8?B?ako5MDMyVnNITGhkWGRJOEhqVExLd1BTZWg4U2piVXFJWCtkWGJSU2hZY0dN?=
 =?utf-8?B?NkZ6b09od01LRllybzFrUjBJSUJ0blVNR2RVL3pMTWtRZkhjMzk4dkMxZFJp?=
 =?utf-8?B?YnVEajlTSXE5cHdlcENKWU1PSU9HVjI1NERub1JTR2MvVS9QclhxTFMxMjRM?=
 =?utf-8?B?NEdBOHREa0wydHdsUit2cUlaSW5rWVlWdVNSVzJzT2xDV0FmVjFqL3ROQVJD?=
 =?utf-8?B?L3FJWnZ5dFdENEI1bllzU1hNVXg0dDBYZVhBZUtiZCtUUkpPdXdZSU83bE9t?=
 =?utf-8?B?STZBS3c1eldIcHRsRjQ5dWd3Y1lMTHFoeURXMnJJbXdPNW5SK01UT0hXK29J?=
 =?utf-8?B?ZmFCVWhyNldCWUtlNzlCSjhjd2kzZExQbHRZWTRoQ3JOUk56RXNBemNsOW52?=
 =?utf-8?B?TFVjdGZDa08yellFdVRGcXIxcmRWa3FaMkUyRGc4ZVZlOFVqeFFXNmlOS1lM?=
 =?utf-8?B?clhqWEZoNUY1RDA0ZlRaQVpHMGxRQkxRcGVTTDhpa3BvTnp0V0NjbkJTUXMy?=
 =?utf-8?B?YktTaXZxRDVoWStGenpid3hzZ2hlRlBpK1hvdGp2WDlTMTB1QXdYUjB4WmpU?=
 =?utf-8?B?T0p2eHdVVy9wL0JaRDdXSTZaeGgxNVEvQzNYSkllS1JKZjhac3pLUjJUTjdO?=
 =?utf-8?B?YWg0a1hOajRtcEViSmljaE8xS2pLOVNGaU4vZm5xYmwvVE5hdUxOSnFXdnoz?=
 =?utf-8?B?Mi96TVhJRWp2QU11NXhicFZ4T2FqTnFnTmhnc0V2VTBnRlM0dmFvUjEvVjg5?=
 =?utf-8?B?MTBpUFZ0ZkhIUHp2SmtZZGlIWlhRV2RCd2hSdDhTeTRyK1VkNkh3NWJ0OUo3?=
 =?utf-8?B?SC9LTDJQY0RRN1ZVODdUNGV1cFE3T3dKVUE4MzVubE9HV21WeUZTMitkMW9D?=
 =?utf-8?B?VTFtdXVUckdHeWF1U1JIQmlDKzVkWVovT3AyU2xKbzluUEYwU3Y2bE52dkNt?=
 =?utf-8?B?U1cwNktPQ0N3a1ZqQUJWOGdPclYzSFV5Y0lRQUZ3UnQvdmNrRmt2NmRIN002?=
 =?utf-8?B?Rm5CVFd0YktKTDdYTVFyZGRyM213bm5JYTlxS3JGRys4ZmlkVWhueS9OWExU?=
 =?utf-8?B?Z3ZFcS9ZL253NzZqd1VqZ2ZHNVAxa2tKK09XaVFFdDhnWmR6VzBIdkNXNlpS?=
 =?utf-8?B?OG9hQWxsS3V1QUxmZm54VkxXV21ySUpPcWRQSG1JbnVJU2UvTnBSeVJlNGd4?=
 =?utf-8?B?SmhSdE9PUTdIUWdmUVRwVGwzSDhDM2lnWjJPNHU4T29YZ2ptSlRuRlZ1NXNY?=
 =?utf-8?B?S2pEVFhYQmM3SjFJYlY2TXMwZGlRRlRCdDY1dUhZU2N3b082UXl2eFVXbksy?=
 =?utf-8?B?ckNZQWhjajlIRTRuOVRsdU12K045MkFiSFFRQnJna3FNWHF6aFc3OUhkdyth?=
 =?utf-8?B?QWViMVl1SnJSMXE2M09HeVBJbVZwM3p0NzNvcWFobmJnTDBOR1pNMC8ycEJY?=
 =?utf-8?B?a0RVM2liYlUySks4RjJLdzVPVXhna2NRb1R2N3dva0txZlJ3TTFwWXpnWnY4?=
 =?utf-8?B?MnRQQnRXdWVWOHZySFVMTnFwamRYL1BCc1RqVzFLeStxa3gvbTg2WEozYkQ1?=
 =?utf-8?Q?Nt57ovUoKW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdabERKM0doL0lLUDk1NmV0UzM5Z0hFZHdLVG5KV1lydUI1V2puYVpLaEk2?=
 =?utf-8?B?c1pmZ1FBa0hEM0UranByZ2dMMmlpekRSUEtXeGlWOHg5ek5qbzNZcEtBdWFh?=
 =?utf-8?B?c2NVOWhJZktkY3g0NnUyaFQ3TkwwN21IL0I0b1ZUTHlNUytRY3c1dlJDMUtR?=
 =?utf-8?B?M25tS3JqeTVHVlB0YTZ2TXFXaFAwQlBGeGE2QlczZzN2Z3pIQWdLMFRQWU9N?=
 =?utf-8?B?VVdseVFVSlRrdTZkdGRKRm1HQm5vV1BhQzZtck50MEFpcHllYXBCV3Z4Z2VZ?=
 =?utf-8?B?dXpkaTh0SWJ5elhDalV3aE90Y3pCWDFGeVpERzIzTWtWUFMyVmsxMVdMZjVG?=
 =?utf-8?B?akJ5WDYwZDNoUTBRbjlJRllmT3V6MWZPNUIyZXBjaStqYTUzN242cjdtd2xU?=
 =?utf-8?B?aEhyNmorVTFyMy9URzhzb0dOSVk2bktTMkppT1czc05uWmxxV0U5YmhXRTJG?=
 =?utf-8?B?dzcvVkc4TFJJTFk4ZmV1Qmlnb25mZUFIbVdmL204c3BYZ1NLYzRMcXQ4bEpo?=
 =?utf-8?B?Y25QZS9MeDhYaUFQaDI1by9aa2RDai9lajNWSjIyOVRRZ1YwdkNwOVcwaUlC?=
 =?utf-8?B?YVNLdHFVaGRNODZjcHBUcTNOZWVCZExJTmxrT1lkVHdiQlFhK2IrZEl4NTl4?=
 =?utf-8?B?Smg0Y0tKL3JhWXRaRTNFSnh6NGl1VE96bmN6TEE5RnZCK0M0RGlVMUhCR3Vr?=
 =?utf-8?B?NmVleFJmcEE5NUNuZ3ZtVHJjc3ZodFFsYWtzT0pleGovTlVtY1B3L2o0QUpM?=
 =?utf-8?B?N09NdEtTS0REenVweGd4UXhGdTZRYWw4dkNBaVdkZ251NFNvWlUxc1l0YjBS?=
 =?utf-8?B?dktQbS9Ga24raDUvNHlwK0x6VGRnT2VLZjUrcFc0cFJCNEtsWGVzSGtZN3VZ?=
 =?utf-8?B?cU9YeVBndXQrM3FDTEJuVHEyZmd0ZHNLQVJLRGZRN3pWTFdWanhwWS9XY0E5?=
 =?utf-8?B?dkRRdGlaU0VWVTFYeUR5VHVvZFZaWWR2NlZBdEJiMitiN1lLOFZWUlpYcXZ6?=
 =?utf-8?B?RUd0YlV5MTJsTmxsVldHY2tQdkorQzZTSFVOdHJJTUV2Q2JMZUhpNk9EdnAv?=
 =?utf-8?B?eUwyVFgwUyswVXJ4VkdVT3d2T0tyNDRqcGs0SDJiNWcvQTB4OEkrSVhNMUVn?=
 =?utf-8?B?Ukc5Z0czdjdUU2NhOGpUY3c5SjdUd3pDOHdOMG5kcEJPZHJ6THIzN1k0LzRt?=
 =?utf-8?B?LzhqL1ZDVHZkZ3dNWWtFQmlYQVZrQnhzVGFzZ0VWMUhneVZyN2xPTGtYRmFP?=
 =?utf-8?B?YU5FbHdCbnVjL2NZWnp1VGh6OWF0c0p5cG1nZm80VlZzV09aV0lKYUNEazV2?=
 =?utf-8?B?SlJxWnpBakZjZERlSnZvYURKd2Y4TVQ5NVdJT0ovUWZWcXpjN3J3UVlDZkE2?=
 =?utf-8?B?c2lMNUsvYi9TbmtkcGVPeFBNSWxVSnJEanRIWW9oYWlObnZFTk85MTVqVjFT?=
 =?utf-8?B?UzQ5cERIR2UwWDIyR281aGdpTkpvOE4xVUhkd1BNU1l3enBLZU85TVU4cTdB?=
 =?utf-8?B?MDVoTkxwOHBMWXBsSWs1c0Q3TGNUb0hVdlZzNURHQUVkbHI4Mm9OTEZnTnhQ?=
 =?utf-8?B?ZEpaMnRxcE5aNmdRQ1h4ZXdGSmZJVUFYOTBtLzh1UnBwQ1hPR3JZcmQ5VXlr?=
 =?utf-8?B?cTFvYjVSNWNUUmU2a3pDVVpZcU0zcE95R1A2NWRJZzdHelZHM3VyVXJRbVFx?=
 =?utf-8?B?aXFoQXVoZk1HL1lqYmllOTJFTlA1SzA4VWMxVENKMTlTWERyMUNhNlJkSTRr?=
 =?utf-8?B?bUtOVjhZZ1N0ajdUWHMzTW1ISzEyQXFQbmtMaFJsdkNENlhDSHFPdmcwbzRG?=
 =?utf-8?B?Z1c3UEppMlNFMTBHb3RjVzMvYVUwZXVmYk1lRWVwb3N3bDJwbGRTVnNSaCtD?=
 =?utf-8?B?Z0VZaWZHTEtwQlg1MzFYNmdIbkFvRUdvUzZ1c2V6UnBhV3NmU0Q0Mk1OeXpL?=
 =?utf-8?B?c0N4WW1MUDlSbEQ4SVlVcWU1d2E5bURieHZvYW9Ed3BYYWRuK2crcXBwYlVp?=
 =?utf-8?B?S2JsNDY5TFEzMmt3YXpqMVNwTGluY0FweFdmWVhDc29ONmJPeElueGljYk96?=
 =?utf-8?B?MlBIZEZZcTBRQ3ltVDBJN0o1MTRNRzlCNzFKM1hYUGVmL3VHRFlmNE9ZLzlG?=
 =?utf-8?B?TXRKR2svKys4WU5xMkdaeFJ2TFgwWE80eXZKdk4yL0VFYW1jd0NmUm5ra25r?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c44fa-da2f-4b68-ff0a-08ddf02511da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:46:56.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJWpmqqT2hcYSRSQzsm8P1GZAdCuXWukFglZquu8zCcU8+dZRbXA2OP2N9uJrhUPZ8N0D4mn4LrphnZF+HJbo4QndZAkliM8OYLaLqSVDwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> > On 27/8/25 13:52, Dan Williams wrote:
> >
> >
> > I suggest changing "pci_tsm_{bind,unbind}()" to "pci_tsm_bind/pci_tsm_unbind" or "pci_tsm_bind/_unbind" as otherwise cannot grep for pci_tsm_bind in git log.
> >
> >
> >> After a PCIe device has established a secure link and session between a TEE
> >> Security Manager (TSM) and its local Device Security Manager (DSM), the
> >> device or its subfunctions are candidates to be bound to a private memory
> >> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> >> Device Interface (TDI).
> >> 
> >> The pci_tsm_bind() requests the low-level TSM driver to associate the
> >> device with private MMIO and private IOMMU context resources of a given TVM
> >> represented by a @kvm argument. A device in the bound state corresponds to
> >> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> >> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> >> it involves host side resource establishment and context setup on behalf of
> >> the guest. It is also expected to be performed lazily to allow for
> >> operation of the device in non-confidential "shared" context for pre-lock
> >> configuration.
> >> 
> >
> >
> >
> >> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> ---
> >>   drivers/pci/tsm.c       | 95 +++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/pci-tsm.h | 30 +++++++++++++
> >>   2 files changed, 125 insertions(+)
> >> 
> >> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> >> index 092e81c5208c..302a974f3632 100644
> >> --- a/drivers/pci/tsm.c
> >> +++ b/drivers/pci/tsm.c
> >> @@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
> >>   	return 0;
> >>   }
> >>   
> >> +/*
> >> + * Note, this helper only returns an error code and takes an argument for
> >> + * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
> >> + * always succeeds.
> >> + */
> >> +static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
> >> +{
> >> +	struct pci_tdi *tdi;
> >> +	struct pci_tsm_pf0 *tsm_pf0;
> >> +
> >> +	lockdep_assert_held(&pci_tsm_rwsem);
> >> +
> >> +	if (!pdev->tsm)
> >> +		return 0;
> >> +
> >> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> >
> > What is expected to be passed to __pci_tsm_unbind/pci_tsm_bind as pdev - PF0 or TEE-IO VF? I guess the latter.
> >
> > But to_pci_tsm_pf0() casts the pdev's tsm to pci_tsm_pf0 which makes sense for PF0 but not for VFs.
> >
> > What do I miss and how does this work for you? Thanks,
> >
> 
> I guess this needs
> 
> modified   drivers/pci/tsm.c
> @@ -44,7 +44,7 @@ static inline bool has_tee(struct pci_dev *pdev)
>  /* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm == ->pdev (self) */
>  static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
>  {
> -	struct pci_dev *pdev = pci_tsm->pdev;
> +	struct pci_dev *pdev = pci_tsm->dsm;

Yup, guess I should have read one more message in the thread before
taking the time go off and finish off v6.

