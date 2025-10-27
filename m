Return-Path: <linux-pci+bounces-39483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A1C12173
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53533A3F95
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD951DFE22;
	Mon, 27 Oct 2025 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+uoOq49"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7894502F
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608751; cv=fail; b=kqfXjjTS3vhBjvNbP2ytdRzTU8piQowgBDIOmTrG+5aTWs5rX5y1YOTtGJN6/F1SGoMq5s+ycmX4MLc/8ekyWZNDf/PdxjL85Kd3qIQlVnBallyOTt8ABk5G7s6G950VDc8YJiJw2BtSVhlU9Vu/PJ3FIFHwOXRoGd62NtOHi3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608751; c=relaxed/simple;
	bh=UVFHIk9J9c/dT6SFZgBhe2SvQkIq/DGR+w0ddXq29VY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NiZsCMCCY2hI6xfSMrL8MQ+BjhJ2gjUwOqKZMxiiUsp6lOug5g/zzia5LIimuCLt65aGAL82hCT5WzmDfoi23OLOjPa0yeeTBtUehYTF5ZWZWzKRy68AxAY0orkFITcCJSlfTn6iVn1xW69WPr8t6rprKxTaZb6mytc2wylTa9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+uoOq49; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761608750; x=1793144750;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=UVFHIk9J9c/dT6SFZgBhe2SvQkIq/DGR+w0ddXq29VY=;
  b=L+uoOq49BWEK0Dvl3BxaRylFwXED+aChgm0/A9aDNiaoW5M2T1b1mjHb
   wiwT/FkhAZqbR8TI1w+JTb+c9bEom9sBRJtpjIkuBa/F/mjHQzIsaE55L
   ZUTYYn126gy3VUXXl0ue26/+pJY8JijXJcda5w5flOtU8NtPOltU9+bGh
   LqImmQeCBVQwRIhuJ5tSykqisyKXXeyQ4hKMJ7LSRdI1fYmRd23B9aXj5
   OnMu15v51UVq5o5WMA742zC3M05rwUT6WBbj23MC8tXAPcmE5luMHQd6C
   9iIyjNBCgYMl9tiBNv2momxPFQhZnK6Kkbd4p8s9lGOySWUuiecoohNuV
   A==;
X-CSE-ConnectionGUID: CgL8ehZtSdukbI5XICR6qw==
X-CSE-MsgGUID: 4VOMsUQxQmGu2yivgn8s4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67344052"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="67344052"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:45:49 -0700
X-CSE-ConnectionGUID: 3u8vt65BQO6hwkhDjUILSA==
X-CSE-MsgGUID: ftPHckN6RBqKBMv/fEghvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184887830"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 16:45:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 16:45:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 16:45:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 16:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW5W4j+BaiywieupX90SbrBDQbS/dtE4zPMn6mVlOratXIAV78dkB2zREEmqvnPQgvy3Ds522q4PWohL8z7zWSAanw+xI2fV01By3RqUe9Ax0TQpMsKP/rAiOd6dujtzwk7iu/+o1/AZk85bRBd+xy7K0AGyv/GjilHYg8GmJAY8VeVBL3EeLLDi77t7vXM+DeuuscVUiYsmXNJ3Tv7DHPia1w/APwfOKS6ih3RwDQkmSjyzyh8Zsxv0Bk5Rn92tPJqmPeTPxRWV0N6saQxwGGj67BAM/xHQ0A0EJKW88cwDKhZt4EdiegdNPjqqrQsngGeWsH0UOqwJLwLaGCGP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUINNftwZobmsjNJWjYwZrnZm8BcqSBZA2l7xPZkJdk=;
 b=rlD1qUx70JCfXwqdOKk8p24WyqrAXTeyAljQ5+doYWXnYOkLxX6LG2qlo4iqe5xQ8gt1rXRhYB3EfGYP2aYknT2tu3O4q7x3Yb6qIwhNN8WbiYY83hR1gyUQam27IGGOVF5yCcxJ9I7E1RoZnvZczSWU4Ltotfskw5U0bdwvKE0im4zFsfUxe41MJ5jOGnGXcxPqiJvmUOch/O9aJ+CuZIQi45XBGU9AP0uszGbrTw7L1rTSDHKgrAf6o9j0gF5yCKGqXfaAega5YVBJUmkiClB5r/WOmoctrYePCplA0nWYTBAg4zU0vl5Y9vyMb1winhF9N3NuYaOGyzzc9FMR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF0D0CDCDB9.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 23:45:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 23:45:44 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 27 Oct 2025 16:45:42 -0700
To: Michael Kelley <mhklinux@outlook.com>, Dan Williams
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>
Message-ID: <69000426e1537_10e21003c@dwillia2-mobl4.notmuch>
In-Reply-To: <SN6PR02MB4157A61D1497F3F205E1A845D4FEA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251024224622.1470555-1-dan.j.williams@intel.com>
 <20251024224622.1470555-2-dan.j.williams@intel.com>
 <SN6PR02MB4157A61D1497F3F205E1A845D4FEA@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 1/2] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF0D0CDCDB9:EE_
X-MS-Office365-Filtering-Correlation-Id: 195bd3a7-4162-4d87-ae62-08de15b2f23e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0lYY09qNDJlaUk5YWR6MUsxZGNYTVYrNnlZTkp4TUwzaERRUVVVMXFyWUZk?=
 =?utf-8?B?NjFFUmVLNFMyQi81UzZoVVB4T1owL3daWmtMN251NkVHWHNxTGpRYjZDUUhK?=
 =?utf-8?B?TnFQVXI3VExkUkJDVnFjTmdzclZZUmVTOVhid2I0M1FhUktVODVSMy9qRllM?=
 =?utf-8?B?Q2tRTk5HMTBPRnFpVDVncFFvT1dLT2VBOTdnUVNWYk1jMklURHQySHJ0WlQ4?=
 =?utf-8?B?ZUlEeDBXcXNnWDhjM3BuVlFzVytSM3N6ekpXRk12NkJ3K3NsdGNncEkwWkpZ?=
 =?utf-8?B?d1gweVRKdnRKcFpOTGhoV0RmSmZ5aFp3aWZsNyttZFVsYjlzNlVRckFrSU1y?=
 =?utf-8?B?cEFjRnh2VlczUUc5aG90UVg2VG5RTWdrS001Z3NZYVJoRUw3OGNWc3B4WmV0?=
 =?utf-8?B?NlBsdkQrYXMyWkJDb283Z1dBQ0pRaE1HcDVzUjFPL2NTNHMyZTZYeUp1K21L?=
 =?utf-8?B?Y0RRdm9YQXV0Z1RDRTBtbFFDVzRQT2pUK0srREJuenJsNGVJLzJmeVVvd3Ba?=
 =?utf-8?B?N1VyWm1mV3JLRWRLUm8vTnB3dE9uYXNZV3lJSXRBM3BuWWpsOElYYWdHZXJ5?=
 =?utf-8?B?bFpxOGdoUFVCWW1pbnFIUmRkcG9YQzV4YTJ6TExub21ZN0gycm5hZ2J3MGdY?=
 =?utf-8?B?RVorbjVyQThpNVBTOHltR2JzVWtxbWR1UWx5OWM0bWhVNnpwNkptTkdlb0Iv?=
 =?utf-8?B?UW5PalZWK1BBdG5ibDg3KzBOUXVaWDlDbjVSWkxtVWJmN3NRRTZ4dDhsL0R3?=
 =?utf-8?B?RWkzRmpjQkJvdHJhRHFGcDQ1R1BEajFFcUJoMS9ud2d0QVh1aW1WeEpZUERq?=
 =?utf-8?B?Q0FBRU9CamxrWmVtY212OGI2ZmY0Z0Z0TXRjbkpCWmtnd25wY1dMTnNVWWVi?=
 =?utf-8?B?MDNjSU1pcExKWFMyQ3NDWnRpalpEOUNUdkNOTklkM3Q5SkhCazN6UU5HRnpN?=
 =?utf-8?B?Yzk0aGdXa0FhR1h1SWQ5ajFKNThUTWpqQmJqaTR5MU9JOVUzMVZwWWlmZCt3?=
 =?utf-8?B?K0J6R1lPbExwS0tyM0phTHlST3R3L1hzZXYxRTNZMnV1eGo1KzRSY3VHd3or?=
 =?utf-8?B?K2g3WDA5RXpONVNzUXVaSGQya0ZSdFEvTEoyNDV6eFdxUHZPOXZoZXIvcEM0?=
 =?utf-8?B?M0ZhMXBQeEs1OTRQQnZQQTNVTEVVamp1dVlQNEFtdVgxQzhJVnRicDBYNC9q?=
 =?utf-8?B?VWMrMHVlUklQQmUxb3ZDKzNjWXBxaUdRbEY5RWtLeU1jS0hWZTFudFJ6elFz?=
 =?utf-8?B?ZytNK050ZzA4NDZXekNoT01LZ0NqVzFPSmU4NFg1eU5qY0NrL1dZRUZWSm9Y?=
 =?utf-8?B?SWdXTlZqMEg3WkJjRURQZ2RWRE9Md0t5WjA4QVpHZC9sSE4zUGRsMXlMb1Vt?=
 =?utf-8?B?Z2lRczBCK1RjeTMzLzUwYmxlM3BRUEcybzFDcjA4aEtibzN3b01CZ2ZPVS9J?=
 =?utf-8?B?aXZRTkdsbDhmS0lTUzdGamxodStRbUJncjVzUVdiNm0waElLYlpXNXpnZFN0?=
 =?utf-8?B?dy92MXBDS1ZRZ1FFajVaTzhpNGhhQ1pOSE8zbEhud1hCaTZURzVoNjZUZmJy?=
 =?utf-8?B?bVQxUkoyOGlUVW5XM296czFYVnc5V1UzSUN2NWlESDhWeW9yWC9VN3U5NTdt?=
 =?utf-8?B?c0hMNUYrTEFDK1lrMXh6ZVI2cEZMUTVJazJOYmVreTNOZlAyR1Z5T2JWaEs4?=
 =?utf-8?B?Uy9WMTBFaWM4a3NWcyt5bkhFTFo1UVovMzE4WDhwM0M1WnVsRUZWcTY1K3VF?=
 =?utf-8?B?YkRBNXFIK3AvQm9laDlTb3MvS3puQ0FtaHZmY2MwdlVxM1QxbWVhZ2dTbXRI?=
 =?utf-8?B?NnNyTy95N1BKY0pxRzN6aktiL1Z1RlJCRjNlcHl0ekdEdXRBYzJwMHpDUG1L?=
 =?utf-8?B?YjQ5bkVUL1QvWWxyMDRLcVRKKzA4QWhrVXFZN0c3aHNjQ1hWL0NhT2ZHejl4?=
 =?utf-8?Q?PuOrRu5g/Lg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVlZc1o0N1RGSXdDYUZTQUY5OUw3YVZrUW16ajdxNnpVOCtsdWt2elc2dFEx?=
 =?utf-8?B?b0pDVzNJU1NNWElqZGg3dmFBZTNGbnRCQWdCV3N4d203dWV6OGY5MVcxZ21a?=
 =?utf-8?B?bU5wenBiRmQ0YnMwajdZdkhrajdvOGFrandyYUlzRjAvWDdzQWZkT3UvVi9i?=
 =?utf-8?B?bERyUjR6clhRdW5yWXlodE9hbERwOFJ0eWZVQmphWEIxQ2Jid2tpN0d3eGZJ?=
 =?utf-8?B?eHhmSVJyb2xpTE1lMWJXWU9MY09kQmV4WW9PUFljb0h2MnpSNXpwa3hRUGxY?=
 =?utf-8?B?SHlEelJRQWdoVmpPVjVCc1p0YjFaOHVHU1BXd3dOOVNQRE9tY2ptbFd4Vjlq?=
 =?utf-8?B?TWhWYm81Nm50UDZidmNtUUFYN0RUMEt6MHJ5QzBvMnM5RUJqcmZrSE5ETzJu?=
 =?utf-8?B?eUJWRkVuMjZUaFV6eGhhbFh0VDErSU1hWXFQUjJZZlNMSWV2dlJyK2g1TGxU?=
 =?utf-8?B?NjB2MFZEUlB0dFZLbTBrRmxqSWhpcWw4c3NTWkJoc2g1eTlwUTB0V0pOR1VL?=
 =?utf-8?B?dEVrQklEZ0ZJci9GdkJjYWpTam93dmN2dkJjYnQ3NitiaTJ1MUkxblkyNC9x?=
 =?utf-8?B?YzRrOGsvK0VUWjY2cjgvUWhZSXhBOXpONTR6bzAvMmpIdDZiNFIzaS9iZ3RJ?=
 =?utf-8?B?WlN5UFVKcVVKRjk4TG44OW9IM3JoaGF5QjRZalpoU3FOTzBGMU9GRGxSVHQ4?=
 =?utf-8?B?QmJrV1VhRXgxUjRYMGNQRVJ5SFZ2QnNTaGlsbi9XUzFuRjdLNmhVZzQxbTIr?=
 =?utf-8?B?Wlo3VnVPb2h3NUpLb1FVRW13SUVRNzBDUDVnaHZGckhUV0RPY0JqbE5zQzJm?=
 =?utf-8?B?aUhUdW4yalNHTHVMSTBxZlJ4RHB3c0NJdDlEd3BTaDUzNmVCNi9KYVFrcGU0?=
 =?utf-8?B?RVo0MDhhS1FDK0JYS256MlAwZGZrMGQxelowZ3BZOTM2ck04VitPWTNYTFBw?=
 =?utf-8?B?K0ZqaVZoN0hEcWw4ZXpQWGFpSTF0bzY4eUJ6cThURTJUWFBuUnhicU9Lc3pT?=
 =?utf-8?B?NFFCcysyVkMyZW4rZGsvd3dsRlF3M1cvVHZValhWZnlqbE9SdUJXeGhqME1Q?=
 =?utf-8?B?UHpQQ0NzNzZnR2VmY1oxZkFoNldpUWhBNmZzS2Q2MVE4Sm5Ea2UxVUs2Y08y?=
 =?utf-8?B?WnJ6NDA0cUV5TEtmRHdKclYzM09xd05RSUtwTElROW5tR0hoenFIQk5CSWlx?=
 =?utf-8?B?aFNZSTVLN2hscC8wWklscWFSRG81Z3QyVk9VK1FRUEEwRE05MjV0RllkRXEx?=
 =?utf-8?B?UlF1UkZERDdYcVJzN1FGV2t1MGVpZGxSaXp4ZkhIQkd4dUdKWmcwK3F5UjVj?=
 =?utf-8?B?aXJ5VC9tOVVNMzZMcG9vSDNUVmJtOC8wVG1BNFljMUp6ak1COEtOS1M1TXpu?=
 =?utf-8?B?WElyTy9CU01lS01hdDdiTUZ3MUNsdlhnTUNqZm5VTkNXMVgwQTV6aG0wKzVE?=
 =?utf-8?B?VFlmTURhRmk4Q1Z1M05ScFN4cjQ2S3NPcVVpUE9CQnF6VFlQbVpjakVSSFhB?=
 =?utf-8?B?aU9yY2NrWWRFVEEwY3NkQVI2YURaYWFxOVVKZ3V0N2sza3EyRmwwenpidVA2?=
 =?utf-8?B?NHlFazNqcmZQbkJoWElPMTJpNkptUy9CZ2czQ0toVWRqWmNOZk9lem5PaTQr?=
 =?utf-8?B?bTdsSUIxbEhGM0luYzUzUm41RmcyUjk0UFNZSWlNeUt3VGFlN0FGaFNzR3BC?=
 =?utf-8?B?MnphdVloVVpGNFV2ZFQyWERKalNuYXlJNXI3Y2FwbEdETzdJOWdoWmVWSmly?=
 =?utf-8?B?REhsU0tZdXJaeEo4Z2pIcUg1QzZudWsxWUI0TXFDR3ptVHdFZlp4ZERTUjlT?=
 =?utf-8?B?K3FOWnpoZUpVYzlYV2I5Vmo5aHFEbXdtakwzaFhaRCtqK1VWVjdzV2doMGJs?=
 =?utf-8?B?WUpnbmNSYUQwSTgxR2hmNlZvdXJKUjE3eHhpcENnSHNOc2JhblBEcXREQkJx?=
 =?utf-8?B?QWMzUUxTZ3NaOG9qeHE1b0N0WCtpUjZJa3JKWXpUYzNVRFNpUngrNkdqdzFu?=
 =?utf-8?B?VmZReUR3bVJYeTNjUDNvRVpPV2dLbEw2K0VzTlplZFFEQ0dTT3ZUSmgvY1hn?=
 =?utf-8?B?SmRDYzNaYUNlcnlHc3NsWFVIc0U5aG15bFd3QzFLTGQ3YUVjOTNBSGU5ZDhn?=
 =?utf-8?B?Vm4wVVlaSWdRZU9YbEVnWXlNdlpuQzB1SHB1Q0pGWlpCMVN0S2MyVUZTTXZQ?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 195bd3a7-4162-4d87-ae62-08de15b2f23e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 23:45:44.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZCwH/nZtmcSGhRqdDFBS2aOfr9+XCxsu+fE2UJCcurWPCyip4pkkodNS89SJXBkf0ubN0P3I8hgsyoyKQDf8c2dJObLu7ssa9cLkuFKsHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D0CDCDB9
X-OriginatorOrg: intel.com

Michael Kelley wrote:
> From: Dan Williams <dan.j.williams@intel.com> Sent: Friday, October 24, 2025 3:46 PM
> > 
> > The ability to emulate a host bridge is useful not only for hardware PCI
> > controllers like CONFIG_VMD, or virtual PCI controllers like
> > CONFIG_PCI_HYPERV, but also for test and development scenarios like
> > CONFIG_SAMPLES_DEVSEC [1].
> > 
> > One stumbling block for defining CONFIG_SAMPLES_DEVSEC, a sample
> > implementation of a platform TSM for PCI Device Security, is the need to
> > accommodate PCI_DOMAINS_GENERIC architectures alongside x86 [2].
> 
> There's not a [2] tag anywhere below.  Presumably it should be the "Closes:"
> link?

Yes, good catch.

> > In support of supplementing the existing CONFIG_PCI_BRIDGE_EMUL
> > infrastructure for host bridges:
> > 
> > * Introduce pci_bus_find_emul_domain_nr() as a common way to find a free
> >   PCI domain number whether that is to reuse the existing dynamic
> >   allocation code in the !ACPI case, or to assign an unused domain above
> >   the last ACPI segment.
> > 
> > * Convert pci-hyperv to the new allocator so that the PCI core can
> >   unconditionally assume that bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET
> >   is the dynamically allocated case.
> > 
> > A follow on patch can also convert vmd to the new scheme. Currently vmd
> > is limited to CONFIG_PCI_DOMAINS_GENERIC=n (x86) so, unlike pci-hyperv,
> > it does not immediately conflict with this new
> > pci_bus_find_emul_domain_nr() mechanism.
> > 
> > Link: https://lore.kernel.org/all/174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com [1]
> > Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Closes: https://lore.kernel.org/all/20250311144601.145736-3-suzuki.poulose@arm.com 
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > [michael: maintain compatibility with userspace that expects 16-bit ids]
> 
> Is the above line spurious?  It doesn't seem to belong here.

That was documenting the change to make the @max argument to
pci_bus_find_emul_domain_nr() be U16_MAX in the Hyper-V case, but yeah
no need to note that in this case. You did not edit the patch directly.
I am ok if Bjorn deletes that on applying.

If you want a respin Bjorn, let me know.

> > Cc: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Tested on x86 and arm64 VMs in the Azure public cloud with
> multiple Hyper-V virtual PCI devices in each VM. So covered
> both the "CONFIG_PCI_DOMAINS_GENERIC=n" and "=y" cases.
> Did manual unbind/rebind of vPCI devices multiple times so the
> domain numbers would be freed and reallocated. All was good.
> I did not go to the trouble of simulating a domain number
> collision.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>

Thanks, Michael much appreciated!

