Return-Path: <linux-pci+bounces-15708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6F9B7B64
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 14:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04781F22A28
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED11E19DF98;
	Thu, 31 Oct 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs6EZuV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7D13A869;
	Thu, 31 Oct 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380222; cv=fail; b=nbf9gbbvLW772Q4EZeNfgrDlTn46sP1dEyLr8XtgNVppyt+pCoHRWlwDl1R0WEi2opoJ3l8+ZZTUxDhPK8Ew1eGN8lC6Lyy3WeP/gexPa8b/VMkmkX8NaADp8iFnAM++pYvzD9T0yzpS/6cjO//5m49ircNOKnDfoBv7Gtmg+/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380222; c=relaxed/simple;
	bh=GwlndCNbpwTjnXuKphd+5LmwqKVdA6UDegTsaq07XaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBlT+xD4YZL3uL8MXjiR906Gxdlx6ugnwnW4Z+ABMKIClk7VnWcjQnBwIGN9mTPZ7eX6Fd6j9NqNXnJujbjCccviz8evtPqW9W5nXmzQACPa1EAhCfmQic3asa0J6RqZGhQGJ4ASNDUalbeTQInJg+ll/2pFjSQloLsi8xO7rwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs6EZuV+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730380221; x=1761916221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwlndCNbpwTjnXuKphd+5LmwqKVdA6UDegTsaq07XaU=;
  b=Fs6EZuV+58w//9C2jKl88TotG26pmrWsn74O5ymSzuXYIL9HRFJDbz5z
   sElK1LZw9INndVriKhI5zoXpO75m3vIESycWd1QYNtIU9Mt7HwRXoF7rh
   31XpbKCAeKK/RbYWl9hvhxgjxU/6nToEhpw9eaItHPxE9rvf4SquPytwB
   2IHsH840uJtMZS5ESnjyQE39bNaTz7F4ybL1QjhHWVev4lR1btc+MnLw7
   mRAH6jPpJvAHVzHAYoz+CAUQFUJFPSumPw66Qk5DVM7XJf6cX4n6qGTcU
   bRCNkbhoa/GotuC3bcd1G3FxFIefADHH/GMq2LAeZHsAO7qnFSKSrabqy
   g==;
X-CSE-ConnectionGUID: V+XAMcY5R26JX6pFT8Q0Zw==
X-CSE-MsgGUID: kso6GASJSeiX7mO19pZu7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30232648"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30232648"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 06:10:19 -0700
X-CSE-ConnectionGUID: tEH1+U33R4eoWxGf0FWgEA==
X-CSE-MsgGUID: X7w563gzQduHsINqnSdjVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86553166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 06:10:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 06:10:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 06:10:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 06:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebuFUqNTgFomQj/pHBndHufmDh/plVTFsDitqTD1X6ZIpiKbht8ZcQOJ0+gny0vSmmH+wRvFp9DuRlDGcnd/RvCk8okqvSlitWSha5oyL+AxW2LPiDjUhlfDXpHSL7ggZj+QphHs/DIanVo0pOCjC6aywtT44RVCLjsH1nRwfjGyxe4K7X9LFt5RGEgSM6wXBQedc36X2rUuy7PZy5//1YKlGcu3Xcb++pqiroGaHzTtSWnkkXRc0BQP9oW1MWIYrJ7p5/vCyoRY2lXJWptKoq/Mq17gmMaJiRkL/5TEVZ6Vsnb5g1rYyW48MTD1PAjEZitHHg2klXm7BoCsTerh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykxQKz/gGBI5uIQnC9KVPZp//ghI+3yzL+h/CeuMYbQ=;
 b=X5tpjdeRq24D5JBxxWbS5Cf6n5/zob/mM95wYekxzpPutq65I05uPgoruW9wlV2ETTWbVUvv00e7OiENuqhwD5cUqqMX1miTTRBPAKQEqW94HAOG3r5OpupvpjRcCwD1sDrszghsSMHyZaXs5lr8x+RfeFyTnRd50U950S1/IpH1Kk8DAM+X/ohxWphoqa5wdsWVyA2/vyEhfdkAbKucrjNWOkTnYUuz2Brw3AWH+myfXWoJXKeI4LbSv8MtkMvhFnyWFYgdP6lCcwTMnfFwCH8bz//boaFDSV91gcGz/e8xxZc6YBw4XP4UNXEWCRBARmGD4ZqPrYtAcl8ItuF7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:10:14 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 13:10:14 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>, "john.allen@amd.com"
	<john.allen@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, "richard.gong@amd.com"
	<richard.gong@amd.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "clemens@ladisch.de"
	<clemens@ladisch.de>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 06/16] x86/amd_nb: Simplify root device search
Thread-Topic: [PATCH 06/16] x86/amd_nb: Simplify root device search
Thread-Index: AQHbJXBT50ZjIdLza0uHiTQFIEI1yrKgh1dggAAnZwCAADIkcA==
Date: Thu, 31 Oct 2024 13:10:14 +0000
Message-ID: <CY8PR11MB7134B6A59681AB84A8DAA4F389552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
 <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
 <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
In-Reply-To: <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB5925:EE_
x-ms-office365-filtering-correlation-id: 8d076029-0c8e-4b90-d317-08dcf9ad5b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mlOOUxCpPmW7YRiXEqzMZeq8QVIIPk1U3QOP304R9Qg7x4jV9em48tly0D?=
 =?iso-8859-1?Q?mcezJ++DbNuJD+Lg2c+gT0CJFz1PU/TqIC5d2wzub3qvzHlfcpeV3AZRRU?=
 =?iso-8859-1?Q?Imjf5xBTun7v0KHj2Mm+0ca09OV6DaOCBAHitZom9M/kX1vtn3Ch7ol50B?=
 =?iso-8859-1?Q?TMOklVE2sQX5rtexnMQYQ+IiFEfcCaBVpB3SdrJMFrB6gZcVQGdqZymFex?=
 =?iso-8859-1?Q?r5Q2BHMjGy4FTRvZrUX5hTUZlbyOapZPda4cPwPo64QdWb2madMMOSllcq?=
 =?iso-8859-1?Q?vOzTFyOGDC9rmBHhe77OvcVhHeEypEwoElqh1v5+J38gGyS8UGL87fPGUH?=
 =?iso-8859-1?Q?BS0scwA7TdjaXYAlj3B46JZPT23cMAwdi0/jmo9MEb4sgOCsSZxOzLh7j7?=
 =?iso-8859-1?Q?xV4ObU6JnR9iY13rmtASmJ2LP5RmIKISlVsESkHT49hz51N9vu8kj1b1Eg?=
 =?iso-8859-1?Q?voRpQiNxJhU2xRnHKEWivP0oUCEgVaXCDGyqfSmXCHq37cZJIT/cFxUDE8?=
 =?iso-8859-1?Q?lZj7j+FcVgs5m5SJWRm0VgfQFFaxB+VC1isz0UdtEr/NNRrLbCwfgR0lYq?=
 =?iso-8859-1?Q?0Uvud9dQTcP4YdyMDjgdfpel7AaIbVjffxQPLJDtHhvdrvtf4rxC4wIilD?=
 =?iso-8859-1?Q?se7E8EIJxdTJjh0C98wYBcRPWeS0mR1U0wpZu07af987zbfLAQ9u0jIiQa?=
 =?iso-8859-1?Q?FHwS+bdVmGmRvpeumBoRQmTxwH3wrVH6w3Gr/Hgxosnabgs3ETbxeQGRRJ?=
 =?iso-8859-1?Q?jqjwlxbgCFOqvzCKlyistwgLzVhtDotVNSvS0aN+/EnSHnoOJLYxzYMEJt?=
 =?iso-8859-1?Q?R6dSCJ/gi3eHMsqYQs6/uquEwHCYyPGA+W4EHULKg6WnsKR5pXs458mEeU?=
 =?iso-8859-1?Q?UnezYAn2RJ+pMrK62CMjKszkRfgc1X6BpwAeO8Uh9WsyKQRBVWigdC5Anm?=
 =?iso-8859-1?Q?KhiCR/RbXpdxzZPAbUAK+K0/LXfBn7x8tJEsXRkOOQFtHY6uS3m4yKNT/V?=
 =?iso-8859-1?Q?duI6NFLCjfH0zHI9GiKaEODcKlKWz9NXkJzCLSglF9zRcRUHYC8hU67IkW?=
 =?iso-8859-1?Q?yAqbJVRMTm96iXzRnSapzVTddBJ7ZBhcLJok+suhFH/T40PNLpvSlicF7+?=
 =?iso-8859-1?Q?449kpl7lqapVXxRics5CgUB8qwS4cEADt/pukgivBnEqvROSaqGsSqWbDw?=
 =?iso-8859-1?Q?0hiapZdfrOpQDINiG/nDLzReFhIegRGhA0eo4CkRTd8/scWj374SGbc3rO?=
 =?iso-8859-1?Q?p/Bxy3a9RAk9UEAbgxze7nCItXS3fL4IdFhQew4IV/5OfKojsowb1wpfVC?=
 =?iso-8859-1?Q?pUzd33pBOD+wQKWvJdB0jtm8prPeozqgpitV00a5yn5Ejhasal90ArK9Mx?=
 =?iso-8859-1?Q?K/i6KW49AFFDkojnQ3HZxGWktbL8p/wAWdljhk8qO28F5Cx/CMOc0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ASBDLAYm+d7L7fLlmApHecRuu8c3mBtAGco4pWv1e/wUWvHIc0uv3gzbqh?=
 =?iso-8859-1?Q?FZ/g2h4XEcomkf3+qsHz/Go2r6fIht9xxFQTspwaSp9dTS6LCMWW96Qmmn?=
 =?iso-8859-1?Q?aReEidFhlUwtF5hHyf7LJEwANtfQjAyk8ZGSkMW1jBQQ5h+rZP4jWLUrIx?=
 =?iso-8859-1?Q?Hj5LlmYMEWW3isbWFRenHgQWUK3qal0b/lHGYpEmDvulUVY/SHM8vb566x?=
 =?iso-8859-1?Q?dEX1Ygta7z6mPJJjem7pvOFlgM7udO53F4c0KYYhHubU0D6Lw/hAEZob+7?=
 =?iso-8859-1?Q?pKipNSaoV0/s9M7d/cMCOoJ+ieNCIc5LnT600jRzOZBV8+SIH42YJlbGTn?=
 =?iso-8859-1?Q?i1kbBChxZTLX5ZL7dUSxLQLzz9aXKYE/5lq8mjjBqfRdcvvaVpwSR2ckip?=
 =?iso-8859-1?Q?X/VkNMwhiH+Z4S5MFr7T5KFC/hhrhItij1bAO1DLvR3VEuBRTKpN/e8IlQ?=
 =?iso-8859-1?Q?aNmI3sAGd5bqVMg3ev8wB6tkzVuQ8TokZNX+iVlHwLJtFN5vNtqlmKQbiS?=
 =?iso-8859-1?Q?Nujln77DKEbOcE4Uu43Pt7/q0HWZrfH0wFPzI9DaJwAxC2qImgl0Lc3ulP?=
 =?iso-8859-1?Q?6pMgZtzxnWODt7f43n8GGkSsfnqwP6rUWpue6yXETpjHzUR9wFzIyUtDxu?=
 =?iso-8859-1?Q?v77nfZtYHs+CRHSLRW09RgN76+ggcY/3oo2B5/VRrOsIaKLfdRY7nJ0tay?=
 =?iso-8859-1?Q?0wZgHkcXML7aDIDt5Mboop4uO8v88XzILDH4TvcZJwyrMT2Fa80sSrl8/A?=
 =?iso-8859-1?Q?lMabiKmTnJwEmSvGTNv+2odr45LSm3JthF5eB+ubzav+nnqOeERKbibLx7?=
 =?iso-8859-1?Q?Og57STP1nyPls1eHgnD+pkw6ojmSU4MqBIFf70nFR8aQYpKYODvoT6Pe3a?=
 =?iso-8859-1?Q?sByuoKc2XKVUJghuZPmRFZl6zTHImZdp2hLDgcSPCKnH3sjiXRtBf95eUo?=
 =?iso-8859-1?Q?EFw0FAH0CH0CEaJK34Mg9hrietItm7b1ofxgaHA/nDLTRM7mTYuXBU13nJ?=
 =?iso-8859-1?Q?ckBqT96O/S5NAPHoVXDZzj91myGsZwZPa9lRM0k1QkgmHULafaFymQDZF+?=
 =?iso-8859-1?Q?3k8HCp7j3BRrv5RUK0PWk3D36Igx3ihwLiCJR0zBTWhQX2cN8BshUq/ISL?=
 =?iso-8859-1?Q?g44LWc40e2fH1VYmkLiHhlJPxIH+8JhuQM4jCLjngGdWbUMe0vMhXVPcT/?=
 =?iso-8859-1?Q?AToeUOTmE8t68yYyxrcvyx1hDakc8CDBkD2hrtsIpcdQZ7IcmFsf1ZXwVk?=
 =?iso-8859-1?Q?1WvCNai+vUCUCsniHhgCCvxJO1GffJXHMYxutdpXNfxoaVsdc5wWKcfqvc?=
 =?iso-8859-1?Q?0pcYLoadwJ06SwxyrZwF+JQycCa7jM22MPVkj4pOmpBN8JsRbVa3GsAGd/?=
 =?iso-8859-1?Q?TLZwTJtRxItVUvRPY5HodJWgx5gfYs15jb5TXddp4qTNIQLVisUODpUxOh?=
 =?iso-8859-1?Q?GqOK62NXS8LdGAWRmu9Jkwa+5gU3298CbBlBfkDv4k3hN4svtqQT3R1S3G?=
 =?iso-8859-1?Q?YYSKu9muknGoKMU7fEUpKZvwKDp3RMOlgMQH/czA7mnQ4SWIxjBLQq62Ze?=
 =?iso-8859-1?Q?pxU0pNDy7fsBpt2MU9aDtxacZsvj3qLiaSHklKRgnnXZ5cSE/ELR/b1lXd?=
 =?iso-8859-1?Q?Ox9YrMkGScBHON6e2dJ2IuPiYWWgBariX/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d076029-0c8e-4b90-d317-08dcf9ad5b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 13:10:14.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y/RYW0WRmdQGmKK1JC6VsPsiJkHA3KeJPedemLvvP+BaUxth3ZFHESe+npn7OZmT2s4aJ3u7GTBIdIXBLQaAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> [...]
> > > +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> > > +		return NULL;
>=20
> ...This would try to free() whatever garbage df_f0 holds...

Oops ... I missed this point.=20
Thanks for correcting me.=20

-Qiuxu

