Return-Path: <linux-pci+bounces-35075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3CB3B039
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 03:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BA13AF63B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97DF2F84F;
	Fri, 29 Aug 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6cTze1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF793225D6
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429603; cv=fail; b=kyaejvmldA6aCM1AWXV8VNpq+lptajokRZnnLqpDp7U2f8lL0ayDP/dlA/im1Orayg0BjLOjEKNAKRXyTt2RrLQImAzQjVnPaODXStnnEKh68xK+zCnJ90yT18sXVNItwWDp0ir94vQ8dxYsyvjz5pGpdUVbfKuFXty9CrPpJgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429603; c=relaxed/simple;
	bh=P/VDQUq76PNsir46QYG1i2Cg9oBynKA/g2WLMSdH538=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=bsDc4njoRPmlYkA2ijvGsR2fJrF66RAA8fnYpzyFJQldS3NHRfQsePRXRJWKofafO0QCo2bYxXmqdPKOU6Zk/TSOGbZWO3W+bQxPpRiFPYJtf292jbjagSjZhATi6axy0nkFxT5XQfBLGBHGjU6CmB+JCfLtqN4Z0NpEXIoIiXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6cTze1K; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756429601; x=1787965601;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=P/VDQUq76PNsir46QYG1i2Cg9oBynKA/g2WLMSdH538=;
  b=M6cTze1KOUGOz2sng0lhdjDgTFv8J57e0q3OnCiG1E6/wXeJj0bdSGqf
   qzCxGiHRd7fXdm+0K+OqztiEWSoVw+KRVbiNilEaqwyEArUsWPA04D1Yl
   EEVK98EJ4+ffMKn/aCBNECT/fSq5JxxQ2heVhjOMqgOnm3bq1sjiNE6bn
   9h7dmyvwdoXLft7vPC4PZTXU/0RJvCzUE3MEq0a7SWnWnU8gPMq8781ex
   B1n9SuJUIafbKMHNuUpbRU0zn00iw7S6SebUghXcrRm+liNPVg2qXNJyX
   TrQCMzpmL8ZY113Oh6pskJqZR5b/Ij5sEG2iqYnAOOMSwnoOqmBwIqrSO
   w==;
X-CSE-ConnectionGUID: qafPTW28Qres/iJwkKFjqQ==
X-CSE-MsgGUID: BdVFQyWmR0mWNGQh4s9DkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81304427"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81304427"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 18:06:41 -0700
X-CSE-ConnectionGUID: gvcWtsQxTQOjOT76aWyesw==
X-CSE-MsgGUID: SHLwLz8vT46iTXcjnVfnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169781037"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 18:06:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:06:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 18:06:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.62)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apgxSoF7P/IB8WOJBMZ5akTCMXeDzA3w+A3QBoABFiYYmbf2xyp5WNq9en1Yt4jNA4gzMvzgpUEn+mNpg2qNr5/f3BXY66NoWZO/MFrMLRHSKuedXYK5IqLcdoiRf18K/RruWbUsgJZUOSn7ahoAR3lzIfyEFOlRZcxPzvAsTK2g3chsMSGgKP3BUvbphlXc8EImq5Vleid9JyTUMd8FzwzI3ltxL8vPNTXhFcHYdGsk4R3RwCYiN6+d7fEchdQrCSFmncfgvQ6S3FGM+AYKAwEW2MWOY1NQd3p6cMXuPwU4axAZQjBfSPA4qamkSwV9aV++FMJoueZk9gKfI43+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlu1FIP/b1bs70bYIZ4bb+263TtkgcAKlgm+D7g19/g=;
 b=YtfTGb60tgEtdtQnZW1YftBxhKeOAyieBisjFffRbmENgoXkN5SakXewZRzYv+jQyuQ8UP9XYzbm/XZQBRKUCJ+/m7cGIxyCclW8WZB2+F32YVump10vrlDDuR9/8qEbyjrC6DduC13v6l8e4Fl/wzIVdfmc5vzunCNXZx5K9QIN4hlJmzyo9YPZSzbyN7QskR+lFOpJjOYRv2S2ycrYaTG4i4JU3VW04z9kjCoqTZDV4hHB1XcNcSThfHihr8r/VGechxLCEzSONsmJc4yRrQYqXxH8e9cm8o4p0PcKfFXAICQcbd+UiXZQb1c6u1PEtD3WU01uZ9xSRen55O5FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 01:06:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 01:06:36 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 18:06:34 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
In-Reply-To: <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1cd6c4-d7a9-4adf-dfe5-08dde6984d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHk5Wk5DaUVYL202cG9TMllDTWRBSHIreUhnblc3V1QrdUFqYW0zU2k3MTdo?=
 =?utf-8?B?bkR1R0NmZFA2U3ZNNURkY3AxKzI3SVNieTRSWjNhWDB4UERESEtFeW1lVzlY?=
 =?utf-8?B?dmxvNmRCVHZVcXRZSUd5ZXk4Q1pnNVNqWU8ySHpPdlQwczBzVy80bmtzaElD?=
 =?utf-8?B?QWlxUS9idnl5SWErdUJYdUczdEJvbU4zZTFuQVg3aFhQU2p0TlFiSTEvZktP?=
 =?utf-8?B?ZjRDTnlnMnpTYzdNNU1JUzVLUXVUZ2xxL3FzVHdVVEFnVmZSb0ptLzdOK290?=
 =?utf-8?B?Q3hlZkVnREJaQjZ2eXMxajdJN0s3cXY4Y0FwR3d6S3FyaGRrOFkwY1RveGFp?=
 =?utf-8?B?TWtjbVhmb2dpM2tDTUNOYlJpWUJKQmlMU3d1bHc4MXc4WUJKOGxaU2NkaVFr?=
 =?utf-8?B?VE85alBCM2JnbE94QTlpZklPSWE0MitJbUpwd2YwWWlZR0ZuY0dIUE44dzZs?=
 =?utf-8?B?QStDMkhKaWFIZHhiVnRNNHBnVE8vNW1GcC9tQlhzMFN4akRKVmtIanZQWlly?=
 =?utf-8?B?UDA4ZmV0cUZiOW1wUVBmZ3doQUdjOXRiMitSNzA5ZzFGc3hZbWZnYXcwQWxj?=
 =?utf-8?B?UG9PZkw2S0tLS3NxSGVTVndjWExWZXl5RmZIeEdIZHBWdWlnaDVZZTFtTGhM?=
 =?utf-8?B?RXczdWY1OFlQVnRiQzd4aWtwYTE5NkEvRzFPNURseTMvNjRET0I5RHN3dlZy?=
 =?utf-8?B?UlJkTUwrSUd2WE1HVWRIZHBvK2UrZi9BblFCdVE4cUhXYU04VzVSVEh0SU9B?=
 =?utf-8?B?blNneFA2SFJGbDdKUzV0VHQxZ3A4eGpoZlBLT29SdHpmTWN3bm1uY1pvZzNJ?=
 =?utf-8?B?ZkRYeHJSOUlVbUxhSE9nODRTNUdCN3FTVUxNOEVFR3grWDlnc3ByN2pYbEFv?=
 =?utf-8?B?SmQvT0NVVHV6dW1kUmFESS82TnNPbkRVSVlRa3kwNVJuQ2lYVHhob3EwcUV3?=
 =?utf-8?B?L0JrNXhGbmpjL0I2VGo2M240RW80VnoybFdWM2w4aWgvZHJBQjdpU1o0Nmx3?=
 =?utf-8?B?dTJQOUVJM0c5SFBzakN6a2tVMEJNMmlXTU1ISEZtbG9kdmhRVzFCeG9hSTU2?=
 =?utf-8?B?Q2RYSFVhMTEwTjVmTVpkUnpoQ21sRDYxL2V6NlB5MGcyUkxrMGphMnpkMjJY?=
 =?utf-8?B?cnZ1L1FudkZUcTFkNHYySVhGWnhCN1ROajQ2TEhkNUFiMnY3WVcrTHdaWDE4?=
 =?utf-8?B?NWVNVnhpbjZ2WGlLYitqWTVCZ1VLeDdCSXZsQVZoRFZUSXkxK3Zmandyemx4?=
 =?utf-8?B?Y0krZFVOMGordm92TU4rQTNDWXdwcGVvLzNsVzVQakJEZWZKNmpMK3JKYWlY?=
 =?utf-8?B?UzJoTkJybzBnSDNKQStRTE14dFMyS1pKc2NKY3BwVHVORlpHUUoyZTBWOHgz?=
 =?utf-8?B?K3R1Qk5XWnFPZVF6bDdOY3FmcnpQYjNaM3VmeGN1RDJhZ1c3Ni9Jd05iWTVJ?=
 =?utf-8?B?WVNadFRlbkFHdFBlY3NyR08yK3pUZjVkWGxYblcwQmxxWUxHYnptd1Q3TG1L?=
 =?utf-8?B?a0JwbENKSDVCeUllUFV2ZXgzdmlOeWQ1MXViRnN6d3ZxV0tRZStmd0J5NUJw?=
 =?utf-8?B?MXVsdTBoMjQ4TklDYzFXem9FZ2FtWWFMNHVYejQ3VTBOcmRTWm9ZMkFzeThO?=
 =?utf-8?B?QzF4K0tWOGI1cXdnWkxKZ1hiVk9LeGhTbmU2ZXZ0RTFwRGdOV1FjZy9XYzEx?=
 =?utf-8?B?WkxJRVJ2UHl2bFFScW43RHRER2ZFby8rZHFJbVFQZ3dFYUFnU00zNWtuRFhL?=
 =?utf-8?B?WnlJUmgzSm9yZEhNTEg1dGx5SnI2NVp2NTVtREVRT2Z2V0J6Z1drc3dKeW1J?=
 =?utf-8?B?TXBNTTJHVVNqaVo0RCtaalNvTlNjalVFdE8yYzZKVG1mRXJ2QVFsYmhROHNR?=
 =?utf-8?B?L1pxUCtQNUJmWkVwMzJTdjg3SnphQUY1c0V0dk91bkk1UG15K3Awb3pLU25n?=
 =?utf-8?Q?tim5qPOJGXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVuY0lPa21VYWlLMlZQT1JTVDF5ZTFTNWFDdWNEU0gvNG5KQklJd0t0Uy8w?=
 =?utf-8?B?VHkwYUZwTGtpZDZjTWlsa2pBQTZlZkVwa29nbTFPWTR3bUJLaEMwTWRDc1VF?=
 =?utf-8?B?MjdMSW5DMXlYc1dEVitxNnB1eFJoVWpxUW5ZZ21BWm9ydm03T2lzWTBqc01O?=
 =?utf-8?B?bytzaGV5OElvTVpHL0F1ZlJXSkdUd1h4RGRTZWtaQXhXQi9YTVFQOVBEbjIz?=
 =?utf-8?B?ek5IeTVXL20xZHpiWkppMWdWTjJTeXk1WHVBSE1mUzVUVnFtT3BJWVpEWDNy?=
 =?utf-8?B?UFkwZ3htc1FZZUU2UkJ0MkY2cWlVUitFZXhWbXpzZG4wVU1BYkRFYklSMnhx?=
 =?utf-8?B?UlM0Z2IvUkNIR3hlZDRkcGkyMENTaVJvZHR3cDVGOXBONmZxc3d0Zy9LT1dC?=
 =?utf-8?B?MG92bk1Lbkg1STRiKzFBcVBtMkxOWmhmb3UwL3RLM3lHWWRFaGlWeExuVE1T?=
 =?utf-8?B?OUhLSWs4K3Z2eHl1RzhCK0pJRDNGT1cwZHc0c2VST0tva291akRlWnhQR25w?=
 =?utf-8?B?OUFlZVRVeXRXTW1kbm9QUzRxRExsSUpBWmt5Mnk4OTVLUEwrYlBMTTh0NG1Q?=
 =?utf-8?B?eE14di9YSXNvMnRZSUhYR3BsSnVYU3p0YkRiQytXckRLMjJ3Z3h1UmdNRTE3?=
 =?utf-8?B?czRUcENiQmR1OG1KbVBJRVFSTEZacTJjYzQ5eEQxNkMrUUdHVmFmcUd3cHJu?=
 =?utf-8?B?cGhCandxcVZ5NDE5OUxQeWZkeDRnV1lERExBT0pSaDFVZ2NkYmxVQ202VURE?=
 =?utf-8?B?V29jZG52em9HQ3FXeFNUcW9ZNGRCQWZOVDNRK0lFdXBKTnFPSnV6dUdXWWJr?=
 =?utf-8?B?RjlTYkQvSU1pNVVXSHRaZllXdHBBR25TOUhPazdZUW4rVG1aRysvb0Jad2s2?=
 =?utf-8?B?OXF6OFdKdHhvN2RBRzVhWFhDZzA4dFI4MFoxUUdSY0RBblp6ZjJIakd2RkNX?=
 =?utf-8?B?OGk4NUNoNnQ4dTUyQkw2UnBDTjljUVl5NzB5cFlJa216cEhSQUxiV3ZOaFd6?=
 =?utf-8?B?ZitnQldwam5OalEyVEQwWGMvN3FId25ISHlpclgzUGNKNStRZkFrZzAwT0do?=
 =?utf-8?B?VWpsWTJPdTg0SGkyNVhteFJHTUZiY2w5Tmg1VHpwbDVLNG5FbytmVU90eUln?=
 =?utf-8?B?WE12WTBVMVJJQW5waW1CZkpRTXdZdSs4QmRCWWpUdUZ6MXh3R0FCNGptV3Nj?=
 =?utf-8?B?OUxlcENCVENYb24yVlZJTldVVDFrZHhmYkMyRHR6K3U2VEhRNkoxVVIrcnlD?=
 =?utf-8?B?RXVMeUdlQ3ovU1kxVE5JM2VLMlBvS0lVTlh4UkpZa2R2dys2bVhaSzZmdTA0?=
 =?utf-8?B?QTVPbXZ4SkF0Q2trZnA5empjUE1CZjlaNWJ5WlNWeXJUdUJSQ1RDNGdjWldW?=
 =?utf-8?B?ZE1VQno5SFc4UkV6QVN2bjk1R25pbE8vQ3hBM3JpUUliR0J4Z2EwTjBocUky?=
 =?utf-8?B?RU1GMC9VNkV5M2ZmN2lYT2tCL0dqSFFDRVdXeDYyRlZSWHRVTHhWSThiNlJl?=
 =?utf-8?B?VFM0Rk9mUVF2RkRHbnRia3FSVWF0amVyM05ENFBjM0JDZGUxZ1prUjBuenpo?=
 =?utf-8?B?NDU1WG91bk1EUyt4eFpEdmRCbTJOa3dMcis5disrV1ZiUmF0U0dmNUZCdUVu?=
 =?utf-8?B?bzRVRmYvRHlxWGtVMjJsV2U5ZDVwUk9tcHpMbUtkaFpxOStydkVaOTBGN0ox?=
 =?utf-8?B?SEw3L05uanNpRjhIZmYzNmhBQW9rUkxGSW5FUnlUZGN2dUxOVlhUd3ZXZzlm?=
 =?utf-8?B?ZjhoZlNIdDhuZktOUGZBVzVmZ2E3eTc5YmZQVjNyU1FYbTFxSjRnWUpvZmxh?=
 =?utf-8?B?bm8zcExIQmJlT0k1UWtLdk5mRE5RZ1phQkdHd0dRUmQ3ODdUOG54ekF6blBr?=
 =?utf-8?B?MmkwSTAyZVo3Znlyc2oweElxcW1QWjBTeHBIaEVEM05JaGtCUlZFV3Q1bnVS?=
 =?utf-8?B?TTh2NUNpdGFoUFdpVUo2T3Mvb0YyZ1ZiSlJvL3U2WmJ4VVR2VUliM1Y1TFdt?=
 =?utf-8?B?T2Q0MW1Obnp2SXVBL0MwRkROU0RXdW9MNmZPZGMxdzJ5UHRWaTJ6eUo1R0kw?=
 =?utf-8?B?Ym4zdzFYdTlkSWFkbjNINXRlc3BoR05VcFFFVFlNRGMvemhLR1hnSHFCeWpL?=
 =?utf-8?B?azRjbm9ieWN6UTF5RkQ4MXlZd2tOVEdPdHRvYjVYQVFXaU5oOW4vNjVmc2dw?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1cd6c4-d7a9-4adf-dfe5-08dde6984d91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:06:36.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WipDfV9ZWJVgRgYi5Pepj9Vk09P5G4kYLLqppO4kPrcX/ryLr5ZlNSqS5lTLdYrz0qn/xnNY9PR6Cjnyw20FKUZ2Ca2uKkjQ4p9EP6zUKm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +/*
> > + * Count of TSMs registered that support physical link operations vs device
> > + * security state management.
> > + */
> > +static int pci_tsm_link_count;
> > +static int pci_tsm_devsec_count;
> 
> This one is not checked anywhere.

Yes, included here for symmetry, it gets used by the devsec_tsm
enabling.

[..]
> > +static int probe_fn(struct pci_dev *pdev, void *dsm)
> > +{
> > +	struct pci_dev *dsm_dev = dsm;
> > +	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
> > +
> > +	pdev->tsm = ops->probe(pdev);
> 
> 
> Looks like this is going to initialize pci_dev::tsm for all VFs under
> an IDE (or TEE) capable PF0, even for those VFs which do not have
> PCI_EXP_DEVCAP_TEE, which does not seem right.

Maybe, but it limits the flexibility of a DSM for no pressing reason.
The spec only talks about that bit being set for Endpoint Upstream Ports
and Root Ports. In the guest, QEMU is emulating / mediating, the config
space of Endpoint Upstream Ports.

If the DSM accepts that interface-ID for TDISP requests then the bit
being set on the SRIOV or downstream interface device does not matter.
So the initialization is only to allow future DSM request attempts, it
is not making a claim about those DSM attempts being successful.

Effectively, Linux can be robust, liberal in what it accepts, with no
significant cost that I can currently see.

[..]
> > +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> > +			     const char *buf, size_t len)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct tsm_dev *tsm_dev;
> > +	int rc, id;
> > +
> > +	rc = sscanf(buf, "tsm%d\n", &id);
> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> > +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> > +		return rc;
> > +
> > +	if (pdev->tsm)
> > +		return -EBUSY;
> > +
> > +	tsm_dev = find_tsm_dev(id);
> > +	if (!is_link_tsm(tsm_dev))
> 
> There would be no "connect" in sysfs if !is_link_tsm().

Given this implementation makes no restriction on number or type of TSMs
the "connect" attribute could theoretically be visible and a
"!is_link_tsm()" instance could be requested via this interface.

This is the case with the sample smoke test:

http://lore.kernel.org/20250827035259.1356758-8-dan.j.williams@intel.com

[..]
> > +static void pf0_sysfs_enable(struct pci_dev *pdev)
> > +{
> > +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> 
> IDE cap, not PCI_EXP_DEVCAP_TEE.

??

> > +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
> > +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",

IDE cap is checked here.

IDE is not mandatory for TDISP.

> > +		tee ? "TEE" : "");
> > +
> > +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> > +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> > +}
> > +
> > +int pci_tsm_register(struct tsm_dev *tsm_dev)
> > +{
> > +	struct pci_dev *pdev = NULL;
> > +
> > +	if (!tsm_dev)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The TSM device must have pci_ops, and only implement one of link_ops
> > +	 * or devsec_ops.
> > +	 */
> > +	if (!tsm_pci_ops(tsm_dev))
> > +		return -EINVAL;
> 
> Not needed.

At this point pci_tsm_register() is an exported symbol, it is ok for it
to do input validation and document the interface.

However, given the realization in the other thread about
tsm_ide_stream_register() not needing to be exported this too does not
need to be exported and can assume that ops are always set by in-kernel
callers.
 
> > +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
> > +		return -EINVAL;
> > +
> > +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
> > +		return -EINVAL;
> > +
> > +	guard(rwsem_write)(&pci_tsm_rwsem);
> > +
> > +	/* on first enable, update sysfs groups */
> > +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
> > +		for_each_pci_dev(pdev)
> > +			if (is_pci_tsm_pf0(pdev))
> > +				pf0_sysfs_enable(pdev);
> 
> You could safely run this loop in the guest too, is_pci_tsm_pf0() would not find IDE-capable PF.

I think it burns a reader's time to look at the top-level loop that
always runs in the guest and realize only after digging deep that the
whole thing is a nop because IDE-capable PF is never set.

Also recall that IDE is optional.

> > +	} else if (is_devsec_tsm(tsm_dev)) {
> > +		pci_tsm_devsec_count++;
> > +	}
> 
> nit: a bunch of is_link_tsm()/is_devsec_tsm() hurts to read.
> 
> Instead of routing calls to pci_tsm_register() via tsm_register() and
> doing all these checks here, we could have cleaner
> pci_tsm_link_register() and pci_tsm_devsev_register() and call those
> directly from where tsm_register() is called as those TSM drivers (or
> devsec samples) know what they are.

I am not opposed to a front end for the TSM drivers to have a:

pci_tsm_<type>_register()

...rather than

tsm_register(..., <type-specific ops>)

...but that does not really effect the backend where the TSM core
interfaces with the PCI core especially because they called at making
the "tsm/" sysfs group visible.

> (well, I'd love pci_tsm_{host|guest}_register or pci_tsm_{hv|vm}_register as their roles are distinct...)

I pulled back from "host" / "guest" or "hv/vm" when you and Jason
highlighted this non TVM case:

http://lore.kernel.org/926022a3-3985-4971-94bd-05c09e40c404@amd.com

So the names of the facilities should match what they do, not who uses
them. A Link TSM manages sessions and physical links details and a
Devsec TSM manages security state transitions and acceptance.

[..]
> > +/*
> > + * struct pci_tsm_ops - manage confidential links and security state
> > + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> > + *	      Provide a secure session transport for TDISP state management
> > + *	      (typically bare metal physical function operations).
> > + * @sec_ops: Lock, unlock, and interrogate the security state of the
> > + *	     function via the platform TSM (typically virtual function
> > + *	     operations).
> > + * @owner: Back reference to the TSM device that owns this instance.
> > + *
> > + * This operations are mutually exclusive either a tsm_dev instance
> > + * manages physical link properties or it manages function security
> > + * states like TDISP lock/unlock.
> > + */
> > +struct pci_tsm_ops {
> > +	/*
> > +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> > +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
> > +	 *	   operations
> > +	 * @remove: destroy link operations context
> > +	 * @connect: establish / validate a secure connection (e.g. IDE)
> > +	 *	     with the device
> > +	 * @disconnect: teardown the secure link
> > +	 *
> > +	 * Context: @probe, @remove, @connect, and @disconnect run under
> > +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> > +	 * mutual exclusion of @connect and @disconnect. @connect and
> > +	 * @disconnect additionally run under the DSM lock (struct
> > +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> > +	 */
> > +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> 
> Why not pci_tsm_dsm_ops? DSM and TDI are used all over the place in the PCIe spec, why not use those?

Because the acronym soup is already unmanageable, please lets pick human
readable names for major concepts.

> > +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> > +		void (*remove)(struct pci_tsm *tsm);
> > +		int (*connect)(struct pci_dev *pdev);
> 
> Why is this one not pci_tsm?

Unlike probe/remove which have an alloc/free relationship with each
other, connect/disconnect operate on the device. That said I think it is
arbitrary and have no real concern about flipping it if you can get
Aneesh or Yilun to weigh in as well about their preference.

> > +	/*
> > +	 * struct pci_tsm_security_ops - Manage the security state of the function
> > +	 * @lock: probe and initialize the device in the LOCKED state
> > +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> > +	 *
> > +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> > +	 * sync with TSM unregistration and each other
> > +	 */
> > +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
> 
> Why not pci_tsm_tdi_ops? Or even pci_tdi_ops? pci_tsm_link_ops::connect is also about security.

On some of this feedback I can not tell if you are asking for
understanding and asking for code changes and find the current naming
unacceptable.

In this case for a major concept I want a name and not an acronym. I am
open to better names if you have suggestions, but please lets not use
acronyms for something fundamental like the split between TSM
personalities.

> > +		struct pci_tsm *(*lock)(struct pci_dev *pdev);
> 
> pci_tdi?
> 
> Or why have pci_dev reference in pci_tsm and pci_tdi then.
> 
> > +		void (*unlock)(struct pci_dev *pdev);
> 
> 
> So we put host and guest in the same ops anyway, what does it buy us?

Identical lookup mechanism pdev->tsm->ops as there's no need to waste
another ops pointer.

[..]
> > +{
> > +	if (!pci_is_pcie(pdev))
> > +		return false;
> > +
> > +	if (pdev->is_virtfn)
> > +		return false;
> > +
> > +	/*
> > +	 * Allow for a Device Security Manager (DSM) associated with function0
> > +	 * of an Endpoint to coordinate TDISP requests for other functions
> > +	 * (physical or virtual) of the device, or allow for an Upstream Port
> > +	 * DSM to accept TDISP requests for the Endpoints downstream of the
> > +	 * switch.
> > +	 */
> > +	switch (pci_pcie_type(pdev)) {
> > +	case PCI_EXP_TYPE_ENDPOINT:
> > +	case PCI_EXP_TYPE_UPSTREAM:
> > +	case PCI_EXP_TYPE_RC_END:
> > +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
> 
> PCI_EXP_DEVCAP_TEE says nothing about "connect".

[You already said "Thanks," above and then did not trim your reply, so I
almost missed this, please trim]

PCI_EXP_DEVCAP_TEE indicates potential presence of a DSM.

