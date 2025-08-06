Return-Path: <linux-pci+bounces-33497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F97B1CF47
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 01:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 137324E0380
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92391C8603;
	Wed,  6 Aug 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3yD00CH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3A2E36E7;
	Wed,  6 Aug 2025 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522181; cv=fail; b=RXFhnxFOkSZjXhdET9Q3Lm0CoWGy87/VxElf3UTJiz3HX7snJ3FVSG8t5xRkKpD3pk4tL1ax9yMH0sIpT5YN0YF2FxFg3jcll3bjhr4sLzF43/dVGBFT9A+EW50p6tJtkBTa6l6fyz+aTEK/9mx3645ug5sUz4yYcUEfCEkJHbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522181; c=relaxed/simple;
	bh=WRRjb0S2UiGdsMQlfvzw/bbcR8NSXuIiMWsPUJtYdp0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=B1PsViaHzgsdI0NYHbvGp+Gb6xPvlGp7C+jB5x+Ll4nN37r4u/Tp7fUZey/Z1ZVXE4a48AIL2Iq10h18eLaTPf7LcyCvjb6IaMKznqGuf/4a1JKEbR7g4m7bAONbm57o6ZEY3aZG1h3dn5FzI5WlFpgvoDSMad8e5aPLC6H0k7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3yD00CH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754522180; x=1786058180;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=WRRjb0S2UiGdsMQlfvzw/bbcR8NSXuIiMWsPUJtYdp0=;
  b=g3yD00CHbekdcVvaLF6Tc60uoClQ+Tn7ikwzlywa02W4ybbARJkest5u
   5abE3qfVPghMGnTlMegG/X1j0g0FYzSi7G03Uqmv4kLPtUl4/SFKeLHCU
   BGSktl1DzZFhnSPGsU++M60fEZzHxMMDOxVcP/FJhmUDixCfAiL90miTi
   yc3NrVGWNLK19nuGUz3DIUz5hEDMNPWd5FBIuvKJ9ButqirP2JZewRiAt
   EMj2o7PKxMTxIelUsJG1bLkZXJ8nlSEdmOm7ov8z78ACPgcYtlXbAsRnE
   +XEnlmBWkYl4a4Pu5kR53L1X89l66V5pPD2IKUB0M11C8QOXvjdm75xFY
   A==;
X-CSE-ConnectionGUID: bCDeacYTSu+zl06+V+4E2A==
X-CSE-MsgGUID: 8iLpW+nnQD+cZF8xiNT7pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44444376"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="44444376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 16:16:20 -0700
X-CSE-ConnectionGUID: JJT5hYbSQOGmuAze9W8bTw==
X-CSE-MsgGUID: i2IMbXo3RUuAPSMHFV7xGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="195736198"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 16:16:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 16:16:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 16:16:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 16:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzaPjWPboFz2Zwl9wrLH7B9vCamlyo4F1vjy53QLwjmuwxM7NmxnvxE2rl0YkIsyqzTcw7HsOiTwsSdXhxOTMbknSCQJBP+454rcoFq5ubu3sWk/30ofzeI+AzvtNS8crcwlEsogSu+Z5Dqh4/2aVlq3flYVs0ODaBpCM9vQUwUpYUjKg+BI7g27yziu9rjjbLqLuL8U5OsqhUUA97LGLV8A+vhi7ZtFB9xui2RZr5iGmc8eC4vUAqr8hc7DzT5YQtDA9idbRqs/tpylFbfG/MYyXKooFKp2qxLiQe4aLwJOdLYuTK/AzTfMpj/hvBv+1daV3CdA5NCSAd3JMy/kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjrDiyFSQiCj95p1feM1Kueon/waHG9tmwXUpFDFY6Y=;
 b=JUPm9GytBg6YFOlOTLv7XH5dEkfK6b4U/0wMaC+EFrnadfvFHtmkzUzzEQAxn4ibGCPljbEpQvuEQYcp2VLr8ETLkij4yNBRpqymT1Pi2urmcsibVgavyWiwaGC4aVviGc9UYciXNpqLgLFhTE82pO3npCSLAkTJs0cXhG/XGJiKxyahOOuwRM2hZkNkWutcqIiZr4EmT+XAaSF81I7BYDGOBs+7U/1tNz639mX7ct5e9vawD1o7CFnenHRP3omeDcmg48fH+SX/Zetxi0v12S8E/8yzieF+vTR49eyQz8wwIyh+hVJ6d+tI7AiNufiFIeEkCiWNcHIzXyTSLBx4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 23:16:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 23:16:17 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 16:16:15 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <6893e23f35349_55f0910072@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250806121026.000023fe@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <20250729155650.000017b3@huawei.com>
 <6892b172976f7_55f0910067@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121026.000023fe@huawei.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: e070c7d3-4cf9-4bdb-bfa4-08ddd53f3ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzNrQktjSStiaTVZUkl0S3I5MFpHQVdaK2RUOWI5dzNPOUcrNWN6OVlqMW15?=
 =?utf-8?B?c1NaWnlLeGcvYzRjSUNDaFcwSkFXcy9sbVM0NXVjS29vZ1lzQjBINGxKaUlG?=
 =?utf-8?B?RU1WNFdGazdndmxKSGJyZUlTYWg5SFh0L2NPRzdIQmwzUk0vUFlWTlhhU0Y0?=
 =?utf-8?B?SWxEMVNrQXMxSkI0blM1bHpZRmxTQ09EeGJXUG1hcElQRDJsOFNmZmNEckEv?=
 =?utf-8?B?YlVQY3hLYzVGMWJaYVdtSDdzOW5vY1V0Um9rUEFocDcyK3JKWHExTEhFMzM2?=
 =?utf-8?B?S0dsL0g3NGY4N0kranoybXBDMkp6SWViMXFvWld3U2I5QVNzUVRnOHBVanp5?=
 =?utf-8?B?VlNxdEQ4bFptMDBSM3hLVUtZb0VsajFtakxQSVkyZHRzVGE2WE5NK3lMc1Zp?=
 =?utf-8?B?M2xqbTFsR3k5VHJtMjVyMnQ3Y052ZXdBZzBSbkovbjZvNDB4N3lJbXBaTis2?=
 =?utf-8?B?QlhwT3VKRXRKRzVNeVZxMHYzc2xyV2YrQWNpV3NWQVRtMnhvazN2NjhzREZF?=
 =?utf-8?B?Sk9SUWQxZXhtVzlvNWpMdVlDNzJaNTAvblFlNXBhc3dCSnBjckxsWldBZ0hi?=
 =?utf-8?B?OFdvMkh1c1ljY2tMbWN3Tks5SHpKZWg0aDIwQXhoajJpUGVueUh0M0s4SkU1?=
 =?utf-8?B?c0RsNjZDTTVpN1ZxSWRHNC9CS2o5enBqQ1dZeThOMjQxK0JWZU1FWmdsN1g1?=
 =?utf-8?B?KzJYdDhQRFYwUUMwUDEzMU8xcldOclVsMituYllrUFk4cVdValA5S1c1blZF?=
 =?utf-8?B?UjRhTHVpaW1vZ01pZk1nOE5YbkUxNmppVHJST0FUMjlIUnZkbHNiV2lWdFpn?=
 =?utf-8?B?UTlDOTkxUThBZjVXNW5TejFkR0QzNEM3YUZ3d0JnYlhLR0RjNDQ3SUFSMmpH?=
 =?utf-8?B?WlUvTHFtUkxEQ05vamVUUVA0ZC8veitwcS94Z28rdUdMZGtIcnN6aWlQMXVR?=
 =?utf-8?B?dXRSeUpPQ3ZWUkN6OEJwWThLejRacFI4eFJnVnlOVk5UbkdLWEliSnRHNXB4?=
 =?utf-8?B?RnBoNDFxUWdRbU5iL04zTzlDZEM5Zy9jMDRVUG1HUkdxYjhJMFdHallkaEVt?=
 =?utf-8?B?MEpja3VuOXpPdkZmUmpGc3gwcEVrbnNSSDlBbmozWU5LM0tuenBKWFVyMkY0?=
 =?utf-8?B?bkhUVFN2dlAvUWtZRm5rOUovazJudWN0M3dUNmhxMTF5UFc0bm5tTmpId1FE?=
 =?utf-8?B?OC9hcDNpS1FJUXRhVjlNZXJua3ZUQktiOG43RHRwbzljQ0RHTmpVZmlmVkc5?=
 =?utf-8?B?WWFNWWRpRHphRVJvZHBCT2JzMkcvc1FSTlNPQVI4blhObm1oQ0Q3ZXg3RlY4?=
 =?utf-8?B?VVNHd3Z1Q3BrSU4yVEhERzU0bll3aUdkTmZMbi9xSm1PV2RDMm9sY212QU1i?=
 =?utf-8?B?M1NyenplUkpiVFNhSjh2VTFuUnpOWjVMUGhra2xpQmZNMkRhM0Z6d0l3YWxO?=
 =?utf-8?B?RzhUZXdpVjhaSzZyL29pLzJ6WlQrVFE0SkNWTDdkTmVVTCtIYUdPRTdjSXpS?=
 =?utf-8?B?RHZnOXBzM2dXYWM0Z1NxdnRpdHFPMCtHeUdsQUxxMVJKeGJsZ3Npam9admVZ?=
 =?utf-8?B?VzkyNU5mbGkvbFM1amNvRkN1d0FGTEQwakdnN3czMm8vbkdJQll6Q1FsRG1I?=
 =?utf-8?B?YUlIVmVpblZVVXZSSzdDN3dyYmhZOVRVR25rMFVPb3dZUENQN3JxTDZsT2ho?=
 =?utf-8?B?SGxEbDVWbU5PS2pxSEtQQkgyUnZPWjdFS2JPUEFyRHZYRkcrUUhKSngyMXoy?=
 =?utf-8?B?S3cwMEVCblR0S3BYTElmVkhJRXJEb2FYTnJnTFA3cndxbzNhVlNxNlpkbGh2?=
 =?utf-8?B?YldZUEhaNEk2TFE5cXd1MS9kMTMzbXJmMkQ2bTFjbVpqaXkwY1U1czVKaXMy?=
 =?utf-8?B?Zk9FWWdCd2lGS3haK0JDejZqaDNFaXFZRnZmL2N6a3JRYVFkOWNiU21LV09M?=
 =?utf-8?Q?LaYmbHjLjAQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pRSkdidFNQRjJxTHhpcW80ZWZoMGxrZUhTVlJ4VXBpS1VCZThlWmlsSnE3?=
 =?utf-8?B?SW91TlBaLzB5SlcyV2R0V29SL3JHUlhJdU5GMXRHVUpFaTlUMVN4ZVN0cVV6?=
 =?utf-8?B?U0tybzIrNk1tb004MW5rcVM2SGNIcTRFT3ZpbDA3a1B6M3AzSmZHeEo2YldN?=
 =?utf-8?B?dTlvMjZTMmx4TTg0VkhGNkpwemFOWnRDb1pwRzRienJtVjBGV2d3c1JWN0Y4?=
 =?utf-8?B?dlVnbWNBRFA4bSs1SVZqWWZnc0RsUHNtNTJmZmVSOWpHVnpzQTgzbmtITmh1?=
 =?utf-8?B?UkQ0MEcrTm1La1hPV3o3K29qdWhGWE9QYlNpTklkVkV3ZjZnaE5Ba2lOQjZr?=
 =?utf-8?B?bkp6UnR1Q0RaMDNQK3kzNTFvY2NWY293R2RIWTNDOFpIRjhBMmo1emprdjNo?=
 =?utf-8?B?ckk3RnNOTUVBSklkRzVUbUZNNVh0ZERuYWEwTGhLU1AvZlhsWXBlWEpjNi91?=
 =?utf-8?B?YmMyVHNnNFQ0dTJseHR1SG9zL3NTOUJNeU10V0REMWthQlpNeng3SDhobERE?=
 =?utf-8?B?Y2ZDRXZUbEtseldIMDlucm9rMUpvanZqeXcwMG9Gdzh2QW1YUC9sOXFwblRy?=
 =?utf-8?B?U2ZsbVFwV01Od3BkcSt0b2pwZkpGUnB4V2xQbExycVVWSWNRTDJhdVZaaXRp?=
 =?utf-8?B?SEloYXZtRlh2UGpoNWdsS0x2TXIzbWVMNC80eXlFcW9qazVydWtKNGhBOGtZ?=
 =?utf-8?B?bGZiRkMvSng5SS94NGtBNGRBSEZ2ZnRLMVdXeE5NblFlemt0Vk5ZSEFVYi9D?=
 =?utf-8?B?OW9oTFdoV0VMNHZlc05BcTNMcmhnQmZZVUJkWW56dEg5SGdKN2x1VHcwUlp1?=
 =?utf-8?B?YWxSZ0dHTHJMSitYUlFMTEZrYllpU0g4ck50SjNEWGwyZVNFRzFEb2VqZUdB?=
 =?utf-8?B?WmtzUDdCMVcyRndsemR4MGVESlk4N0RQeTQwTWZYLy9sUEdJY1Y2NG1pVC9E?=
 =?utf-8?B?bmg4MmxEK1BvdnhFUnZSbVowSVpmUGdzalFQRGxKY0Mvc1diaGNPVXZpaWhD?=
 =?utf-8?B?SkpQeTNNQ1drTUlvbEFSTjVjUWZNYjlzNFowa0NpOWJ3U0VYSnY3czMybExL?=
 =?utf-8?B?dG83dEhUSU9HZkNCNGZuNXcwNFZTbDdhZk9HY01wdW9jYmRPR09aOXZlVW9k?=
 =?utf-8?B?VTZ4cVhIWGFScllYdnhTTnhXdXNKRnU3QVJZRGt0ckpWUFhZbzV6ZmhCL0gw?=
 =?utf-8?B?SFZtdzd6T25GU0dtWG1mT2xtQnBtS0I1eWZXQWRpSlNWM01Qb1ZuOXJ5UEgy?=
 =?utf-8?B?cEJEdFZpaVprcUNGcEJLV2pxQjBRTndEQXRTVWs5OUhnV1ExSGlqMG5yVzVN?=
 =?utf-8?B?dnNnRDJCK2JBUmMwNzZLV0ZkNXgyNnErZVgzc3Z0TlRGOThjSmxKYjNNOTJS?=
 =?utf-8?B?RE4xeWlYTmgwMnVTSUFDMys0am9weG9jOVdiYTU5SEJtSjFPajkyZnVaQ0hF?=
 =?utf-8?B?MzhYcERsc1dmdUZHSFN5eE1PQWtKc2daSG84eGJFTkZmMTZkRDZtZHAzeHhD?=
 =?utf-8?B?OTVkaUpqb2hLT1dnbWZOeG1rQW9mdmZ1bHBZd01HYVNYWXlySGF3Z1V2V21h?=
 =?utf-8?B?dmxxNDVIUkExVnRxVWJNQWRKM3hkdW5JUzN0cWxvTzdMcG9Ic1dxT2V3cGJU?=
 =?utf-8?B?KzIvN2ZqZU5ycmVnZkFjZ3pJU2FvRjQyaldzaEoxblpFQjBDUTVoRzJqTTdm?=
 =?utf-8?B?THdJYW9VTys4NHRTUlBoTXVJZWk2Q3JWQ212dFo3K2xIbE5RRFFGQk9hTjds?=
 =?utf-8?B?MnFWbWl3Mzk4Sy80N2FoMTZiMTV3TTZ2RWRKVmM3N0hGbHJPUUM4aURKMThr?=
 =?utf-8?B?MWJrU0JiQzBFbEhUM2c1bzNreEk3cml3UnBtblBVbGg1WEpRbHhRMm5iMjlr?=
 =?utf-8?B?WDAzWSsvcjJNNzZHcVI2QTlWVzF1MmVUOWE2VFVNcUk4MlF4ZWhrNEVWb2Jp?=
 =?utf-8?B?OFFpNVRBVXhZcFZ6SWZ4V3Zyb3NvbGVEeDRZOGkxR25zTURVOHhJclZISys2?=
 =?utf-8?B?RzJ2TjQ1VFhGMGNOOEttWVZUNkVNREFLbm1RYTJlYXRBREZROHdwQXQxd3A1?=
 =?utf-8?B?MXFRMGVheTVieUNLRzZQcjF5MzV3YzFZUUZKZ2RoZGVrVXJTUmdwcFhwaVBP?=
 =?utf-8?B?c3EvVVNMbkpZMjg5eGVWQjlqaytvczZ4ZklQRUs0RDZ4NEpUMnh1SXMxM2Vw?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e070c7d3-4cf9-4bdb-bfa4-08ddd53f3ec3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 23:16:17.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYGeaaytSn55eBjaSdv3CnvzNg8S4PHzz3EEukRCJpMvd+s8uMj1YJpnnR8Qybq3yGZKW+InCDiVYA2YUvORkNZShtx2PG8DSLnuCnku/vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> > > You protect against this in the DEFINE_FREE() so probably safe
> > > to assume it is always set if we get here.  
> > 
> > It is safe, but I would rather not require reading other code to
> > understand the expectation that some callers may unconditionally call
> > this routine.
> 
> I think a function like remove being called on 'nothing' should
> pretty much always be a bug, but meh, up to you.

...inspired by kfree(NULL). Potentially saves "if (tsm) tsm_remove(tsm)"
checks down the road, but yes, all of those are obviated by the
DEFINE_FREE() at present.

> > > > +	pdev = tsm->pdev;
> > > > +	tsm->ops->remove(tsm);
> > > > +	pdev->tsm = NULL;
> > > > +}
> > > > +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> > > > +
> > > > +static int call_cb_put(struct pci_dev *pdev, void *data,  
> > > 
> > > Is this combination worth while?  I don't like the 'and' aspect of it
> > > and it only saves a few lines...
> > > 
> > > vs
> > > 	if (pdev) {
> > > 		rc = cb(pdev, data);
> > > 		pci_dev_put(pdev);
> > > 		if (rc)
> > > 			return;
> > > 	}  
> > 
> > I think it is worth it, but an even better option is to just let
> > scope-based cleanup handle it by moving the variable inside the loop
> > declaration.
> I don't follow that lat bit, but will look at next version to see
> what you mean!

Here is new approach (only compile tested) after understanding that loop
declared variables do trigger cleanup on each iteration.

static void pci_tsm_walk_fns(struct pci_dev *pdev,
			     int (*cb)(struct pci_dev *pdev, void *data),
			     void *data)
{
	/* Walk subordinate physical functions */
	for (int i = 0; i < 8; i++) {
		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));

		if (!pf)
			continue;

		/* on entry function 0 has already run @cb */
		if (i > 0)
			cb(pf, data);

		/* walk virtual functions of each pf */
		for (int j = 0; j < pci_num_vf(pf); j++) {
			struct pci_dev *vf __free(pci_dev_put) =
				pci_get_domain_bus_and_slot(
					pci_domain_nr(pf->bus),
					pci_iov_virtfn_bus(pf, j),
					pci_iov_virtfn_devfn(pf, j));

			if (!vf)
				continue;

			cb(vf, data);
		}
	}

	/*
	 * Walk downstream devices, assumes that an upstream DSM is
	 * limited to downstream physical functions
	 */
	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
		pci_walk_bus(pdev->subordinate, cb, data);
}

static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
				     int (*cb)(struct pci_dev *pdev,
					       void *data),
				     void *data)
{
	/* Reverse walk downstream devices */
	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
		pci_walk_bus_reverse(pdev->subordinate, cb, data);

	/* Reverse walk subordinate physical functions */
	for (int i = 7; i >= 0; i--) {
		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));

		if (!pf)
			continue;

		/* reverse walk virtual functions */
		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
			struct pci_dev *vf __free(pci_dev_put) =
				pci_get_domain_bus_and_slot(
					pci_domain_nr(pf->bus),
					pci_iov_virtfn_bus(pf, j),
					pci_iov_virtfn_devfn(pf, j));

			if (!vf)
				continue;
			cb(vf, data);
		}

		/* on exit, caller will run @cb on function 0 */
		if (i > 0)
			cb(pf, data);
	}
}

[..]
> I agree it's a slightly odd construction and so might cause confusion.
> So whilst I think I prefer it to the or_reset() pattern I guess I'll just
> try and remember why this is odd (should I ever read this again after it's
> merged!) :)

However, I am interested in these "the trouble with cleanup.h" style
discussions.

I recently suggested this [1] in another thread which indeed uses
multiple local variables of the same object to represent the different
phases of the setup. It was easier there because the code was
straigtforward to convert to an ERR_PTR() organization.

If there was already an alternative device_add() like this:

struct device *device_add_or_reset(struct device *dev)

That handled the put_device() then you could write:

struct device *devreg __free(device_unregister) = device_add_or_reset(no_free_ptr(dev))

...and help that common pattern of 'struct device' setup transitions
from put_device() to device_unregister() at device_add() time.

[1]: http://lore.kernel.org/688bcf40215c3_48e5100d6@dwillia2-xfh.jf.intel.com.notmuch

[..]
> > > > + * struct pci_tsm_ops - manage confidential links and security state
> > > > + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> > > > + * 	      Provide a secure session transport for TDISP state management
> > > > + * 	      (typically bare metal physical function operations).
> > > > + * @sec_ops: Lock, unlock, and interrogate the security state of the
> > > > + *	     function via the platform TSM (typically virtual function
> > > > + *	     operations).
> > > > + * @owner: Back reference to the TSM device that owns this instance.
> > > > + *
> > > > + * This operations are mutually exclusive either a tsm_dev instance
> > > > + * manages phyiscal link properties or it manages function security
> > > > + * states like TDISP lock/unlock.
> > > > + */
> > > > +struct pci_tsm_ops {
> > > > +	/*  
> > > Likewise though I'm not sure if kernel-doc deals with struct groups.  
> > 
> > It does not.
> 
> Hmm. Given they are getting common maybe that's one to address, but
> obviously not in this series.

CXL could use it too...

