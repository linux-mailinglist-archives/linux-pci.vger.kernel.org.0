Return-Path: <linux-pci+bounces-39737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1FEC1DD5C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CD3A57DB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8442AA6;
	Wed, 29 Oct 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeyPCtGn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597D2E7BAE
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782141; cv=fail; b=KZCv/fnADC8q9t17K6bmdTKfhbT4wjeB6tCpAW6tluHqkIixdcHC95xSAQ4B7Y7hRyaxVVGp4RTMubUaYjodrG/eep/sv5fZ+r1SYCIX4eJ3Kq8aEtRdxZ8AjziK68bGu7OC70lCXQYYayJ4xs/sxFVCy4nYgqP43Fw/DaN2I2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782141; c=relaxed/simple;
	bh=4j9+0HYD/yo4l6nykghUYVn78jvG9GAkAH2RF0mn4rg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=rjx/1WxdbbfFQYmUtRafLboIwtdL8a5qCHmK+T1fOJMGlQJDclB0FoKpo1CzE8b8sKNehWQhDja4wUHs8Fa6NZkzV1+ejW5bWLTiJX4PuPLsKJ7y887uVVF0ZKpgYYFKeVYUeMI42BKw0dGUlf6Fy7vZSYZvbWCZKqqAKRPPsew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeyPCtGn; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761782140; x=1793318140;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4j9+0HYD/yo4l6nykghUYVn78jvG9GAkAH2RF0mn4rg=;
  b=DeyPCtGniYAaTCIC3snGGdOxHXSgD56D0f/NoBGJIN7viD2Tv+aQ19PE
   AnKfLh7ASw1p9LG1+oo5Ci+1EQagwyqnTy0TSDi8rkFnw2tlTdVmVQ5D1
   ejPV2qzc6N1uhCJCcb2bfEJ+G37Khkm4qB89nrRHhKdZ3CHpT+laKACN+
   z0p97e0lw/mUgDf4e0g/vVfOmv3jGdco8vqUDldqa5RFkTgHZPxPVOAfF
   unBBR4nbemdYwZL2+yo6d6GSzR1h2sh12Z25ehVI9UMEhjTW+2jKymjjT
   PIzugIAdESjNp1fHfOt64BJxwyIh2WqVt9slw1jH/WopH4lhLnGSuX6D0
   g==;
X-CSE-ConnectionGUID: hnSqeHWoSHiLda6MrbRz1w==
X-CSE-MsgGUID: hYGaaTP8RimgUZ10RwF8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74206635"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="74206635"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:55:40 -0700
X-CSE-ConnectionGUID: AtQM9i4yTlGziRNbcxCn9A==
X-CSE-MsgGUID: VzJSUd29SGaSI7lb6yhBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216657876"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:55:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:55:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 16:55:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 16:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMkDZ29HbUFogS+oeKqPZOe5zBRgnwC6dqBYQLREOKbcDlMiqH37Not28sVbvVMdxiR+ix14Bg8juefquvl1k98xSBoI0QjtEhDh/fvyAxjgyJbCO2NsReAFaI2Bcj4RkYVlLlqefT+7cFK8ItSxv4I0WYL3AlhhfGlwREKYvySJvG5U1Wc/GSURPQSYVIiYIGam7GqQ6svYdsQ+Jmp9yh/mwoh29Za+HtvmuyincIaTXLuUOS6SaCB+ae+tOjsr5+24V7k0Gbwd+CoqfBdry+nGm1Dn2/OKE+Foh4hxOwrrwXJmrOQ3DoVNL8I7E+dKKfQ1NXjeL4+H5KeBBYEY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxBPeueSEJO//Zpr7qTgr1+7AUlAgBsLef8dQGXumZk=;
 b=dzy/kFSfBqO0EBF4M8oz7yHiyY6dqIMDEZusQKNH2U/A4hbKs5Wl4/ok4H6voCq+NLC3RpoQnvKVHcZjZK9hIHz9ubL7iBc6cz7LTLia0Tu0hPGJaWNAP6KCBzhGfcq7P2qTGDWxeJDEPPugcfJUlIEP/1/pbuqyiV7UEXe1YOn2fx8Z9nG0x/h/ZzweSJCzls1xTn48o3dd/SUJXakuX0yn/bsd3IdI9A9uORib+zA9nYsvMlFdH727KLnRTZTflkXWDEqWjFVgEw2xFikGuMcrGkDHLb43SibkOGQNb9bQHfRhKLLiPHMMjS2L0bse7B436TyNx3BsF6GFuKCCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 23:55:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 23:55:36 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 29 Oct 2025 16:55:35 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <6902a9771bd6f_10e91009b@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029134204.00005e76@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-3-dan.j.williams@intel.com>
 <20251029134204.00005e76@huawei.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: d32430b3-b075-48b4-f529-08de1746a7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmxwRTdUajRMbGFuL0R5VVpnblBlR0p1VEl3Q3hlblpEbmt0d3pnQnhuWW9G?=
 =?utf-8?B?K3V6WGpJU1RiUG9oSmZ5NFhoZDluT0F6bHFPREdzSVp1UCtraU9leXQwZGRa?=
 =?utf-8?B?amVETWZzWWIvNUNleFBjamlkR1Z1ZE5icFNsSm9tYjByS2hacDhTMWJCYzdH?=
 =?utf-8?B?b2RNTHRYM0JpbWNEQVViSnE5dDRWcWZzRUZvemsydDRlLy9RRzJqdlI5Vys3?=
 =?utf-8?B?eWtSaDZoeG9FNTlzcit4dXJ6ZlAyWG01ZzBaRTA5enViSnN0TEpuNzRpZXNU?=
 =?utf-8?B?TVJ1eTVpZ0NtUzdtSmt6WWppKzc2VnBCUGN0L1grVWZqTXJwV0M5UklYN2hk?=
 =?utf-8?B?WjRKckNSRFljbXZvWGx6NmNxREdCNE9qcGE2bEtaTkt0eTRFRUtPYXdyaHdR?=
 =?utf-8?B?T1NIVDZ4UmFVNENnckFFelp1M256RlB2RTAxTFpaRVV1K3FZamNNcHZSRENR?=
 =?utf-8?B?UWg4cStvVkNPZ1Z0dHlSVlFjS1EzUk9PcGFEL0R5M0VoakFuUnB2bklENXRa?=
 =?utf-8?B?ZnNUbWxYRCthamgyQUphWExVbHJMcFNqK2ZEM2t6S3ZTTjhKMGxNL0RtM0c2?=
 =?utf-8?B?RldNazFSN0hhb1lNZEU1aHBZdU53QXZYOS90NnpmLzB4dldPZ045dzlzcHBR?=
 =?utf-8?B?cXZidWVwaldzNmUyR2xqWGtvNUNodmJLcFdYRXl6MnVMR2xYRkNDR1poc0ZU?=
 =?utf-8?B?ckVyQVlrU25qMndGenFmUzNFMUtwTGRrS0dGMjU0YWRSZm5CQzRuREtNOW9O?=
 =?utf-8?B?S3ZFbXVReGF1a0VnUEJRc1pQczF4dldSMVU1WjBRaVU4UU1yM1hXT0dELzhE?=
 =?utf-8?B?Si9KTWsxVDJSS2Z0SE12dHU0WjNSSVFubjRxdWxzS2VocXpvajlCdG9OQzJ3?=
 =?utf-8?B?aGN3Si9jTnJvM3B4M2tvYWxpbHdnaXg0MEZja2U4akllOFNLQTBBd2FWc1RY?=
 =?utf-8?B?UFVPNkhFR1JEdHBxbGgwRzNqM2lXaHJ6bjQvUjYxa1c3eSs3dlBNM1g4VEZF?=
 =?utf-8?B?TjBETmhTYjAvS3JPQlBHa3ZFUDVpZjEybU5rT3dTTUsvL0U1SXhKbjFJWUd3?=
 =?utf-8?B?NHhKOU1nTmpOUTNzcmU4Z215bUdnNkJaeG1WeE1YOGFPTytPbmZYL3ZhM2dk?=
 =?utf-8?B?dW5CMW9rRHZkQ05GbncxK1gxMnA0cFFWQTZTd2VqUlBaK2hXNXdoS3FOMXJn?=
 =?utf-8?B?M1FDckx3SnZrMGVZbEM4SmM4M09adlFrL2hNSzNIQUFhYjcwOEUzY0ZMM2ty?=
 =?utf-8?B?T0VodVlnR0V2c1ZoMHFraVZvUTNGZzkzcFR1dWJGK2pzWE5LcHExc1IyclVC?=
 =?utf-8?B?MUtwOUNEU1NmVUpRRlRSSG5Jakl2Q1R5Q3JuL3phRWUybzhRS1FLdXFRVTVs?=
 =?utf-8?B?QjZObVNXdXExVU8rRmdzZUZnMTB3Q3BnNXJsdlNiMEthaGY1ck1ucUdpYktK?=
 =?utf-8?B?SkZpT1FaQmFRejZTanpiVklkMlJjLzUxWlcraUk4ZnBDVGxnVTdqWU9YRXlL?=
 =?utf-8?B?SlB1NGVXcENrRk1TZG1iOVo1TXd5OUxOTjhNbWpETDArZkU0eTVnZzNNMjJ4?=
 =?utf-8?B?UENVWXByMm50cWwwUUZnQ2RXU0FaNWVyV1RqT0UzWm5XMVNzclRKNTNhVGpk?=
 =?utf-8?B?NnNOMkIzU1ZnVmdlQzlSeW5Kd3FvOFNhNDhNajJHNGR5VzMrbjhXcC9WSGds?=
 =?utf-8?B?SGJmNnZVOU4wVHJ5OS9XVms1anFBWUQ2L1BhTHhKcGlCdEFXS2FrTTk1YUYy?=
 =?utf-8?B?OWV4UHdiUXcvRm1KVDVPWE0wU040SEF1NjN3UGVObVRNOFREaGlkcGNSMVp4?=
 =?utf-8?B?YjdVY0VNakM2T2k5anNZWWlRWHBndkgrWU1Ia3B3N2IzeThPWU5Sam5XZWNo?=
 =?utf-8?B?QWk2OCtMK1NvZnpQMGsvb0g3WVh2R3RaVHVaZzhkUVYxNmdjamlQMkJsK1pI?=
 =?utf-8?Q?vkV4QXq0yjB4W3VK8z4XybK/Gcad7nb+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdmWXhJRUFoOWVPSGxJc1FqMERaT0U4d0c0dzBOaTBUZ3BMek1xMGF1a29G?=
 =?utf-8?B?ZW9xb01Nc2FVNVBYN1dQZW9Ib2N5MnpkK2pEOWQrZGM0UitWZFFjblgyQkhP?=
 =?utf-8?B?SnYxdExJbUduVjNFbmFpdCswR3M4UjhYM3BBNTB1TE9xMVF5ZmQvV0RnQXk1?=
 =?utf-8?B?ZVJvQnBFSEN1MUNtQzJyOVJFQjdHVHllcytTMlJxQjJZbzBoYUhYZmNYL2I1?=
 =?utf-8?B?dkdSRzluK1EvZ1BwTkh4aGhVNlQ2eG9nT1k2eHlvaEZudmtKelBaSFlYS25O?=
 =?utf-8?B?aG1WS3NvYmxHQUlhczI0YkRZeHpZL1VJM0p2ZXdKYjdFakNyRk5iODNLRW5Y?=
 =?utf-8?B?TDl3NnNEQ2pjczNkUHBNdU5xclFlNTQ4SDJyVUhrQWJYRU5jQTVWaEpMZWRy?=
 =?utf-8?B?Nm5WQUNHQ1lGc1l5bUZzZVF2eUM4TkdURlREWk9oMmRmNTluVUYxM2RYbVdh?=
 =?utf-8?B?Yks4c2ZLaDgvREloQWNuanlJL1ZCeXJRWGx4QVFUWHJGeXYxV2NWUnUwRVl1?=
 =?utf-8?B?cGZhT2IyNC9vWXVPbmgvcjAxek95M3JiTlR0RnZ1V0RhQWs0UWNjUzByMzJR?=
 =?utf-8?B?YUZYU3FKczFoNkNxb1BRY2FlWlpRTk91bUFseVFqWGFkcnR1T0xaeEY5NzBU?=
 =?utf-8?B?UEtRRlRTdzJiVnZQaFh2OGlxU1g1aCtDOVRsdkx2L3BWSS9iZHcwY3lvY0pE?=
 =?utf-8?B?WUluN1lsVWdUMUI3Y0JHR21IMGpJTTlHYUlFcXVtb3o2RE83YlZWbytMd3l4?=
 =?utf-8?B?V01od3RlaE9XZitKOWdRWnpuWlgyMjFYa0J3U1l0Zmp1RWdBMUZBcWdtUmJa?=
 =?utf-8?B?RU5RWWwvelhmL3RRSmdsdXp0eVRtZHplUGJYdjlnQnNISUd1cVJkWEorTUcr?=
 =?utf-8?B?NExZbWN3S0x5NXl1UGpYbFBGbFVKTU9BZGxFVGh4b3RYYTErNTVyQS95eVF5?=
 =?utf-8?B?Rzk4czlEMWdrbFdlaWFZMTNoRTVHaFAxaUczdDZrQzYvZ2RoUGFRK21JcHVI?=
 =?utf-8?B?d1JnSGNwdEh4NTdJcE5vNUhJU0ExZmlmVndBYzNwQWdESXlEanlndDNWRmpl?=
 =?utf-8?B?WmdxNkhLY1hCQW1vWDBjK3dsUndxd2FmbXRZb0tRdU9uY0JFNjVoSXhiMUNa?=
 =?utf-8?B?SXdycnp3cEZvcXFtcGVGRmZueTRXV3lmYnEvS2E4MW1yNW9qVnhnM0lOSmFB?=
 =?utf-8?B?UmRqTlhEbDFWYk51bUJJN0FyNkJnQ2xZS1J0bUZDTFYzQVl6WHdJblhHSUFs?=
 =?utf-8?B?cFUvMTRhcU9FL3MvVi94T0RPdTgreER1MWw5ZDh0TGlaQWphMXh1Zm8wRWNq?=
 =?utf-8?B?Y0xLQkVlMk1qTFJuUWxYN2hxYzZxenhCME0zWVVGcmJMM3h6a1dmS3NZN3Zn?=
 =?utf-8?B?RlZDVnY0QzBvL2d6bmk2Vmk4aVBLQVYvdkR6bmw2U1hnQy8wZU0ySXF2MmZ5?=
 =?utf-8?B?SFhNT2pKa3YzNmtNd0FKR2tHK0tjTHk1L3JlS1JIUFlRQnZSL0JrNDd2V25x?=
 =?utf-8?B?VmQyL1hlU2FkdHhUS1RSL2ZBMWZzd2I1cmYxeUl4emJHSEpIRW1tM2xxK1Vr?=
 =?utf-8?B?OE0wQ3NMdmVTU0tzQzZqUllEQzV3M25TcjNTV0JLdVlkNmJ4M0FLUXd2VUdm?=
 =?utf-8?B?dDVwRGpyRjNtM1ZJVkswV1ZNamprSDJVa0UwdzFhcE80SW0yWkxQaHJ2TUQy?=
 =?utf-8?B?QTFxS0twWVJuMmJzT25GbWtudDIzQXF1LzZqcXNHTDBLZkxMbytnT3dUN3Zy?=
 =?utf-8?B?WkNqUjdYRjVTU2dGTXU1MkNiM3RILzJNUWxJZXgrZ1MvcDVrbFRhbHpoaXly?=
 =?utf-8?B?QkQ3MlBjTUxkdWYzVHhzZW9XWHV2cE44RDVsekM3RllXUDQ2RHhYcjZQbEha?=
 =?utf-8?B?Zk5hOUJMdUNuMkpGSVpYVi9rMHp3OTl6bG5FOUMrQ0JDVko2Sy9JSXZLQ1pm?=
 =?utf-8?B?Tm1wb09LZkd5SDVaN09BdnhFZHQyQjBCNFoweFhPMnVZbmtsUWJDeEdiUTZJ?=
 =?utf-8?B?U0U1KzBqY3Y5SmV3VlZyM3NJbkxUbW0vYUw2enNTeDByV0Qzai9FU1pTVStF?=
 =?utf-8?B?Q1UvZDNnTEx0M3JpZkVYK2ZzWWt5akxUSUwvTlNsSnB0bmphQkc5SGZzdDAw?=
 =?utf-8?B?UHdPeFN1SzhUdHhUYXpTMnRlR0Q3MFN2QVZlMnBVdzIrRnlud2xWT29Ea2Rh?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d32430b3-b075-48b4-f529-08de1746a7f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 23:55:36.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTaPeKgAV6Pamgj3cb6cGLSrJ/c5uBw/CfsYKc5z3eZLqk5udA/7ZA0AQEbJBrjnMXFpyF1wO+h9KKFcywKCviGYFct//ALCNTuPFa9GbsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..aa54d088129d
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
[..]
> > +	if (val & PCI_IDE_CAP_SEL_CFG)
> > +		pdev->ide_cfg = 1;
> 	pdev->ide_cfg = FIELD_GET(PCI_IDE_CAP_SEL_CFG, val);
> will give more compact code. Entirely up to you.
> 
> > +
> > +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> > +		pdev->ide_tee_limit = 1;
> likewise, could just use FIELD_GET() to save a line.

I like it.

 2:  8c22a857d384 !  2:  3ed9e3c6372d PCI/IDE: Enumerate Selective Stream IDE capabilities
    @@ drivers/pci/ide.c (new)
     +                  return;
     +  }
     +
    -+  if (val & PCI_IDE_CAP_SEL_CFG)
    -+          pdev->ide_cfg = 1;
    -+
    -+  if (val & PCI_IDE_CAP_TEE_LIMITED)
    -+          pdev->ide_tee_limit = 1;
    ++  pdev->ide_cfg = FIELD_GET(PCI_IDE_CAP_SEL_CFG, val);
    ++  pdev->ide_tee_limit = FIELD_GET(PCI_IDE_CAP_TEE_LIMITED, val);
     +
     +  if (val & PCI_IDE_CAP_LINK)
     +          nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);

