Return-Path: <linux-pci+bounces-34812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF5B37606
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 02:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E11BA0559
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ABF219EB;
	Wed, 27 Aug 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABcWalxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0C30CDB8
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253747; cv=fail; b=Yh4pzCTveNWpGMsAhb9proXNY5AjLv7KDDjX1eoOzDn65zF2x0he30hIyt6yOvvDlzRPDx9NbDc29CAU4CYpzefAwwE4jLqkm6eKpK7cxfJTqKK+KypeWM5ZUKDnut7P3oz5OkOvGSna7cR1mw7GqVwBltZ5ypnKZEWc2dRdi3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253747; c=relaxed/simple;
	bh=jJJZect14hGHQxFhVw7woXZRgluSuKmQKb4ykxK1q3k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pBkws9eppk7qW9zoqOZfwTeGvEJGSE7QChver3CguhnGCOyzCX/JoSyvlj0H6sRwVYoGRlR2O+rLzjqwICjgfLHctqkzV8QPNhFAKhcgDvndW9ljRgs0GFhLYjWaua0HzuAtLTX3uebsctlkwn3D9izW+oCoZzIQoryyR4itc2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABcWalxN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756253745; x=1787789745;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jJJZect14hGHQxFhVw7woXZRgluSuKmQKb4ykxK1q3k=;
  b=ABcWalxNubRNjf5vFyJyvIIfc78Nwzd8fwFxZazTYtV9cBw25SuzDWEg
   lsPEMv8Ex7ab5X9u13uGlU+J6JpF0cuwEErYBeaLzFRC08QcAjoYn2QRI
   SBc+xnOeRuK5ofabTsnxiEaVBU8XQ/C9ZkFerrViO5OkkLpYHnHUveL8s
   zwiTIPmv4fe4hEbOTRTGTw4Fne9G/nIeqqJQ4XzBfn0iK2+F2zufzPHVx
   Gu7cCu24QeThqSotHlhkvCRzYZbqU1kDuPsPKnpUzyxJZj59M/Dgg38LE
   ZL8mas7rt5g4+WBUaum4pYNjtm3hc3wPPOiFSt57AejpHVsFB6tqDaTUK
   g==;
X-CSE-ConnectionGUID: cYPmFnJhQLqZ7iNsKZ6CoQ==
X-CSE-MsgGUID: LLBMDOR1RPaiDLo9kqdRjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69094780"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69094780"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 17:15:44 -0700
X-CSE-ConnectionGUID: Kqu6AXbGQUKL6efsrP8N6g==
X-CSE-MsgGUID: HgoIpO/0S4KfS+E9VSqt+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="175007041"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 17:15:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 17:15:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 17:15:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 17:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTMOqD65BUWSH1Hajd0iLJRuPZ11UkvGE8wCbqeBCZV5nzuHsCQfTLfE5LAX2XKM02c8W2iYyEdBBgVApkXpQSKaxs5NjX+t71LybYp95GVG3v+6VKvboY0qaRmVTQkzs1sH0mgTYYLCC7IeOehZTSEsM+glNpCMfRQB1sIuhR+KSYwnB7kfrve5/kG4/2K8Wb8ByOD3fP7CwfoyWIDtvIAM6EQIfQ8pFlTGmI4MWV/+UNxmBpcuNeNjE3QT+GZOVrL76jUO1wMSEZPNA/ZzctAy9OCT7oZMHTM3gvKEsNZQSplcztSrEU9lbPG50q1izRG5yhC0l1Facn3umlkj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj3qu/Gxz24D0cnGs9z3O5zCs40A7Vpj+pAC9ZSUxWw=;
 b=XkLSmYPc0aoW3p1W6bv3ATrmoRkscOBSyV1JMU3h5voD39tm0j3Vr1tazvOSA8iCpe1HsKaaQl9mwMcVHkdGN8sA+mawL5ebhKpprhNSRHmvCLXL7deD1KLnhJf5Ok/pPMwrPuUw5Xv3piTs6uIeOVTDvCdBZsVnWZ+XDhpgpuPje+7xPxOzYXEb5jI5ukd9hbNhsmg6YkImiYk0zfWyd82xffDo9XCzwQly1KFyrgl+J6tKA70afsV8LYPa15bgt9D2PQxBPR2JsyTCRuEOwpMkJKYtB1V9t0JOup6flU810p+yPkFotbKMqhNK/d59xI6TZzQzQGBxPjo4N1wlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 00:15:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 00:15:40 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 26 Aug 2025 17:15:37 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68ae4e29d23b1_75db1006@dwillia2-mobl4.notmuch>
In-Reply-To: <80d568a9-f9a7-49b2-ac46-f3b4879c5066@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <80d568a9-f9a7-49b2-ac46-f3b4879c5066@amd.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 678bfce3-cf20-49ec-b2c4-08dde4fedad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVRHaUs1YSswQXdZMnhoV0gwTVFVTXA5bXhmTzYySGVXTVZ2WURoSy9CbU0y?=
 =?utf-8?B?STRTWS9hd3VVRWNYZ0ZPalVNMEZlUGh4UFZTNDduMVpvVVVNTjFsSWlCbWpP?=
 =?utf-8?B?OXR6R3NkaTdac1FrNVRtdVRLMDMvUjFJVEpVMUpPUnNiREZSY1krMzdxTnVw?=
 =?utf-8?B?Mm1UNTFVb2xZZVBDRXBaQmU1dnRNU0lRMHc2eFFxYXU1WmQxblJEYzhjSUFY?=
 =?utf-8?B?Y2Iyc3JzdzZiVzZBUmdZMTBDZlZiQ3Y0STdhUjVsRkx4M2l2K2R5bXp4eGZB?=
 =?utf-8?B?MFV0SnhKbGpFa0xSeUNRS2dKMFpZWkhIMk9zeER3ZFYxLzN5VE1QQlJyZG44?=
 =?utf-8?B?TndQRTB3SU1SREZCcjlrcllPWlF5Nk1Cdkt4cGJTRHJFRE9Cc2pieUtISGwx?=
 =?utf-8?B?YXpJTlR1R3FCNVMyR2tDWFhGaXJ1bUp6YWp0eDZPOUtyb2hZa0xXUHNvMUVH?=
 =?utf-8?B?Y3U5cUswZFAyc0krSi96NE1jMkR0Q0dieWpjRHJVTlBZTGV1UXU3TG1WMWhD?=
 =?utf-8?B?cFBVLzBBNDlXM295aGFYcjB5MUtrdkErRXJiaDRVQXJBZ1o2NS8reTN6bWQr?=
 =?utf-8?B?NThKMGJKTmdrL0djUDJEREU0RDZUMGwxTU9wSVk0UysxTGtDZzVaenp0WXR3?=
 =?utf-8?B?VzdudkNXU3cyck1zVDBweUJtcDA3T1ZJTnp4SEZFb21iVHVUVWh4LzJ6dEhx?=
 =?utf-8?B?S3B0T1ZEVTNPdlIwOURCbmFrSFdoQytHVU1SV2tFRzN0Z1ZuTXNPQzUwQmJF?=
 =?utf-8?B?TGtWbVpUa0w2dTNzRmRaVlVNaEQvUDVkamErdy9DMStXRGhZczdGdk1ENmUw?=
 =?utf-8?B?NVBlR2RROW9EZWtXMHR1cUNGL0VhcjdMVEZBOXVNVjNrMWN4R0ErYUgrLzZv?=
 =?utf-8?B?Yi9ITDdKclpaNWVDRFYzWTVRUjBpVkIrRmtHK01jN1l6SzhvaTlpOUZPKzRx?=
 =?utf-8?B?NDNkeHFpT3FYU2YzN2JITXgrQlcwbFVqMHN6V25xOU1PM0VHRThhSGt6cTJh?=
 =?utf-8?B?WGxaNzI3eXZHT21HV2hNc3JmY3hxSjBjclFHczN3MWNIZHBjVlpvcWJNTDht?=
 =?utf-8?B?ek9qMnpWb0JDdEZnWDdRdDdLVFV0b2JnR3ZVYnB4YmpmUVZLS0ZlRGh1RXcz?=
 =?utf-8?B?YjJjcXVTZTcvVkpRRnlCOWFyVUc1cGhJaXN3WG9uQmo0Nnc0VGkwUmF0THhF?=
 =?utf-8?B?SG9oQ0taOTREYXNtWklJdndwQmg4VlZoU3FUaUgvbFVIS2NXSkFpU29hODNV?=
 =?utf-8?B?MGl4QTBmOVpxclZoeWtmYVJVU1pvbSt2WDN5ZFpIUllGZWVVY1ljT0szOGpi?=
 =?utf-8?B?b081Y2ZsNEFjNFBzanhxNG5URW1QdlZrdndjUlJOTk9BS1RxallqMTV5YVhu?=
 =?utf-8?B?VEgwOXN4NkcwdWxlc1p5UTYvRU9EKzk0QzFzdWora2x4WHBqS0Y5dGk1bDZF?=
 =?utf-8?B?WllDU3d4TGV2WSszL3g3RUFueDE2RXErcFUzcVF2cmFRUEFhVFRyR296MjlZ?=
 =?utf-8?B?akp6UG1BSnYyTWxTOXJ1SmdUdVo2ZzFSZjgySDJNbjRYWUJiaHZLWDlVNHUv?=
 =?utf-8?B?SGtoWThDcUE3T1Z3QllUc3c3KzdreHlwWWIrdG5ZQ1dTSFdNbWZ6SzJCbDBE?=
 =?utf-8?B?MmVmRHlhQVc0ZU9vbW1lQlpGd2ZvWTE4QldIVStsOEhkOEMzM2FSOHNWQUh5?=
 =?utf-8?B?M3Bva2dPVjV3dDFENmpRU3h3NEFMK25JR2J4aGp4OThDeVV6Ui95ZDdzdGlL?=
 =?utf-8?B?ekJkSUFTa2VvNGNmc1Y2SzA4VzZBTzQxdEFxT2ZuMWZQSmJIclVDZUc4VHVk?=
 =?utf-8?B?dWlPcS8ya3FqQzdvdTg1dmhqbFp6THZsY1BVcE0xWFVSKzhVcktBL3pUOEVX?=
 =?utf-8?B?STZPWU52RXF1UGlpSTZxYzl6MWZVSHlOd0Uza3JSdVBYT3VMQmc2Zkw1ZlZk?=
 =?utf-8?Q?iFosdo+kcq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pXcUpjdkF6Mk9ZTWJuQjI0ZTlGTHl6eTN6QXlubzBDYWk0dFNmemluT1VY?=
 =?utf-8?B?eUdVc092bGYrajF6VkpieE1uVk15Y3lxbm1HenA3dG5YZWdJaFJ6NzNUQk04?=
 =?utf-8?B?L0lkaVR5MHJYSE9hQzNiRFhienRDM2h0ZHVMUFBBY2x0VWFvZGZPSUJBczcz?=
 =?utf-8?B?Zm9BU1dyS1E1Wk9Cd1VZTEFWUGFIZk14aDFrRzluRy91U2lFSFVOeUpvbUFm?=
 =?utf-8?B?V2JiTG9jUEFMdWpXdm9QZ21JN214cHlSZ0RzclluQ3B5Ynp4bzZFL2ltc0Vu?=
 =?utf-8?B?YXB3aHA4RHNYVE1NQXlTa3RMTlRlZFh4TzQ1OFR5K2Zyeld4L0g0dGVqYnhZ?=
 =?utf-8?B?STBYUnFFMDdmTk8vV2tmUmRha1hrWDduU0gxSHNxNExlRGJLeUp0d2d2Wkxn?=
 =?utf-8?B?NnlSdnFsZXVtSmVRaEVjNGQwMk5UTW1iU2pUTyt6SC9vK1JrOGZ5MHVCOUJ1?=
 =?utf-8?B?MXR1b3JXLzcvKzFNMllYZW9zQVZEc01JaXh0RDUyRXlMSTM0OWIrdk9ndkQx?=
 =?utf-8?B?aG5ZMXdKakNTc2NRSU9CbDBrOG5wRjQzcWxvQlptUXJzQndVU2RkUkxBdUV4?=
 =?utf-8?B?RGRxTTk0NnlaTXRCcHpabE1pamlrNGRiWFJ1bk5YdGxSdEhFSXlxVWEySTVG?=
 =?utf-8?B?ZkFUS1BKZGZ2MmxVMWhoWmNBdkJHVFU2NDhQV0VXaEljYW4rbGJ5YmJVaWI3?=
 =?utf-8?B?NjhLL0NRTnUyczFzbmgzZ0xEZUJtVDJoQVFvOGlCdEJPOG5JSnVQQngwT2Fh?=
 =?utf-8?B?cHFOQ21xUmszeVFqUGpOU2R5Nk5FSGV2L0dTblBycm5ubEsvMVhBK3lYM2d0?=
 =?utf-8?B?eDZ4YTlQdXd3MzVEeEdwbzhXeldQRmZ4N0xlWHBqTkNRSmx4NWFIRHpXQWR4?=
 =?utf-8?B?NlJ3NjlncjNsNExHcjZMdG85U0VOd2hzbWxFblp4V05YRlQ5N2N5OXdCUEh6?=
 =?utf-8?B?a3BNUndqc1VxdFQwQmlYY2gzRkc2akh0R05BN0VVclM4VFFlcm5zVHRBNDlN?=
 =?utf-8?B?eVV6OElSNjZNdnFaMkVkaEMzZmFvRXRoQVVtZ1RGYVFkU0hlL3Q1amNaT0No?=
 =?utf-8?B?Y0xJbEFPbE92aW9xQ0tzbTdBdG1mWHhpNkkwODQrK3VSQUtEci9ETXJBc2Fa?=
 =?utf-8?B?VDFDcDU5ekVmb3l3cHo3SjN4UElNaUVoMVp3ZVpWU1dHWUVjM3hRSktVWFY3?=
 =?utf-8?B?OEFSSmNENnByMitSYyszVDd0SDVKWXhFRUhlYkNjRjlDclJaN0NrYlZGNnBm?=
 =?utf-8?B?ejJ0Rzg5cy8vYnZvRGZXQU54QkFBMkpLeVFQZENLd2I3dWFic3hCMm5Jczkr?=
 =?utf-8?B?d3VwUmgvMmx1YmtTdUU2aVhNeUF1bDg2a2tJYWlDNS9JTXBFOFp1ZVlTVWtV?=
 =?utf-8?B?bDdoWkZ2dzRTQnpTU1ZuYU1XR1M5ZTJOa2ZMa0ROUEJRZUoyUWNiNHY0aHAx?=
 =?utf-8?B?RWJVcmxKc3E1Y0N5MzVVV2dPaGlOZHBmVm9NM3dSM2lFTlQyczRxL255amZs?=
 =?utf-8?B?N05Va1lYTEJOT284NWdiRkJ2MGpVTkhHVjdOa1ZrU29CNUE0aVpTMTErakps?=
 =?utf-8?B?eGhWUGJ3d1d6c1hrZXdEcTlDU3p2UThWeDNwUlZESVdDWmd1RGxxajVha1pZ?=
 =?utf-8?B?RjZTVUJBU2FkVW5PZ0lPYUFmL25ZYlQvQUJ0ZFY4c0U0QTFYSFVHMkJsMGN0?=
 =?utf-8?B?WWdYQ2VHWGVueTZlWnJOZ3g4ek4rN3hONCs1dmswUWxFblY1N0FnK05HOGhR?=
 =?utf-8?B?bmd2U2ZVdHY2cmhLaER2RFFhQjlmQmFIVTh3K2hUa2QwbjMxeGpBeG01bDR1?=
 =?utf-8?B?QUwrRDZxWE5aTzVEK3cvTi9NbTFhWHU5NXR0Zng5VlhVVGtrdFFRZWk3NklO?=
 =?utf-8?B?amJBSzNIQlZ1ZFl0K041Q0xiRzZ1b29FS0VTSXNwd201T3ZYY0FVbjIzUW5N?=
 =?utf-8?B?VVMwU3QycGJBaGprdVo5cU1ZdXFoaTNCUFJKeEU4Yzc0Zy9lalBuNFlmdmxl?=
 =?utf-8?B?SEk5ZTlKWmpMczBKNytwdkd4SDhhL0NWUUZUVmdyMUtkNzJOdUYyOW1uVjBU?=
 =?utf-8?B?ZWorNkJzNHFCd0U2QzRTay9OZHZkNUtrWXN5aDhLejVDMVhaa3BMbG9Sbjlj?=
 =?utf-8?B?alBXZm81azJhOGF5RmVGcUNOSlpWQnYzL3ZocWR2Y0JGNjc0bnN6NXh2RHlI?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 678bfce3-cf20-49ec-b2c4-08dde4fedad1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 00:15:40.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIBjcG0/hj1dOlPYwHfJ3uA+hdD53ZVovBDmI1D1a3tr8jxGhvehe8gTXXa3YxBTMmJq524Gf8QUCECtBkv7Pt/8RWSozyi9KytLh3l15RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 0c662f9813eb..5c3f896ac9f4 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -135,6 +135,20 @@ config PCI_IDE_STREAM_MAX
> >   	  track the maximum possibility of 256 streams per host bridge
> >   	  in the typical case.
> >   
> > +config PCI_TSM
> > +	bool "PCI TSM: Device security protocol support"
> > +	select PCI_IDE
> > +	select PCI_DOE
> 
> select TSM

Yup, already in v5.

> etc.
> 
> but this is kinda wrong as it is quite bizarre to call
> drivers/virt/coco/tsm-core.c's tsm_ide_stream_unregister() from
> drivers/pci/ide.c's pci_ide_stream_release(), i.e. "virt" from "pci
> core". imho the caller of pci_ide_stream_release() should just call
> tsm_ide_stream_unregister() too, and so on. Thanks,

So I agree it is odd, and I orginally did not have this tie until the
DEFINE_FREE(pci_ide_stream_release, ...) proposal. With that I want to
allow for TSM drivers to teardown everything associated with IDE setup
with one scope-based-cleanup helper.

It is not a mid-layer because nothing requires a TSM driver to call
tsm_ide_stream_register(), but if they do register it then the PCI core
helper will handle cleaning it up on error along with the rest of the
resources.

