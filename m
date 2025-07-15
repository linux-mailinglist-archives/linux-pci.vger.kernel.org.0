Return-Path: <linux-pci+bounces-32120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B1B051E0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA064A5B43
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 06:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0A2264A9;
	Tue, 15 Jul 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In2CpBJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBE25F790
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561377; cv=fail; b=aEBiGHh2xZIH5sfH0ofG9/SI15qIAx6fTYzro1ybEnihnz6xtpcuUG52OYNFMVBfC1pOrDxTezqSqwXCG0p3/l074sPvh6MffEmAZPNTmHKhjXmIlKQ5EJl7c936XLWUUBfdWvDBIZqZbmsgq+spWUbvMcO98PsTbWlX8WnjMkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561377; c=relaxed/simple;
	bh=GOI/M9Q0+6YeRwQLc9jQ1kgRky1jWTK9NWK2tHMbXFs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pbM2S4/oatwwzpuc+62uU2OLTn07lsJB6yM7//UEUSKULren8AbBgQhVyEbiKTQcrOnOyia7OrLoDNr8Bzm9nuMWUZb9Z/v0kxOKnUApuW/LZBHIMxYsHlp+GiTRg2m8SVBGllPXvA9ILj5y/E3C3oCoekSyHc8WsT3DFPAKCd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In2CpBJb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561376; x=1784097376;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GOI/M9Q0+6YeRwQLc9jQ1kgRky1jWTK9NWK2tHMbXFs=;
  b=In2CpBJb4TpmHoZDKTaXHfzizz6ps7Uu6GtXMiAL4j1nah4E82Mpgxub
   OI8TOTqI4FUYE4fTwVLwyHU5IdaSaDjFd3O1ai+Mx/Wehqhc6c1BvX+S3
   dYloyYJoBQtCJFswGqk7i5O2NbcC3200yqTdCbVc+2GL9I37x6l8kI4kL
   z09Qk/Ne5FnWDH3snQL7IAf3e02hWqyi4Mq12+IVtIIEM+tK2vj/UzZ2n
   /oHmLzX/sgORprK8R6QGuYtBfA94h+8ku6hw5/e7URW9YyMmP2hejgLBO
   t9pZ1RNhnJjW0Q5zlG/Ml1lsEqY6a8q/QzPXdznAT1sc6ZDbdKcXNSE5w
   w==;
X-CSE-ConnectionGUID: PwbKZ9/gQDGxS75ryFGHrw==
X-CSE-MsgGUID: SVApuM5eQkuSkhcokUyfkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54893816"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54893816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:36:16 -0700
X-CSE-ConnectionGUID: vq3p8czhSuqYh7uisque2A==
X-CSE-MsgGUID: NIBNOmSjRJiqNJruM/2tLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="180838745"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:36:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 23:36:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 23:36:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 23:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCAtH5ehwhOg9x/0njGw/PuNfMPv8fQIUz3gLTlA0Qv7Q4hWk+5BqcrFXdvy0NlTXdPg1V2p/LQfbtOReTBfJqcIRIqfO+riZPNE+v5LCez2545+neNKgaOoxTVYcf+NJTTiQ8baRkrvmbhCJk3BUQW7SxNAt7erDKOIki+AGnP8Tjz58Yt4myUnU6+Co/j5wWOZ0huA1DuGuylvivqTlQ5UuUn0+1ctdPs765cXBpqx59jit9jSbfokDwuTm5XI6IL45XtWzrwOrYd2149MZU/hJefbBoAYdRlfaeuTAIttIqR43Jo3v6DX+Cb4fRf0RiEVrhjEF5Z7iy935xPoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g0M3IRcH1BkcC+N2hg4oxmHpiqL5VcRlyBAP2Fvulg=;
 b=n+3dRpYH7QUvWgEfvslPaUOMPLcPnMWz5E+upJA74uTe0upbNri87B/5G5/lUzmpRBw/G3BAtZtZHGBuJndpUJIL1r9FxFYkHcbnHyO7JSkki76YjKcS3uRdXu2chskk5aJnKwjl2nANN227dMKn0cfusG03A8GSVOb7J++HbtZkQUe2dSUfo9qG6k1QI82sAqhnb6Lk6GvAFNXCx8nn+EPmZF+ffrdIwmXFuYsIX6BaFV2kL8cHiiI7c8YAnkmrOFbW0cFuSzWDJH3q4wjFUk24T5DYBye9Z1MgtKrl4nphxR9aWYuORTLfxygKDwZat3raECGsU45+bvx9FHVrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:35:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:35:37 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 23:35:35 -0700
To: Christoph Hellwig <hch@lst.de>, Lukas Wunner <lukas@wunner.de>
CC: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>, <linux-pci@vger.kernel.org>,
	"Yaron Avizrat" <yaron.avizrat@intel.com>, Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>, Jean Delvare <jdelvare@suse.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Keith Busch" <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Alan Stern
	<stern@rowland.harvard.edu>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, David Jeffery
	<djeffery@redhat.com>, "Jeremy Allison" <jallison@ciq.com>
Message-ID: <6875f6b72057a_11344100f1@dwillia2-mobl4.notmuch>
In-Reply-To: <20250715061309.GB18672@lst.de>
References: <53abe6f5ac7c631f95f5d061aa748b192eda0379.1751614426.git.lukas@wunner.de>
 <20250714134502.GB11300@lst.de>
 <aHUSE1Q1V-A-OiUv@wunner.de>
 <20250715061309.GB18672@lst.de>
Subject: Re: [PATCH] PCI: Allow drivers to opt in to async probing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6309826d-af46-4e97-b520-08ddc369cf06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0NhNG4wN1F1Wm1nb21NMm4rNUMwTDM3UkdvM0Nlb2xlakIzOVFjSXltTDhs?=
 =?utf-8?B?OFNLOVdTV2xST3ZPRENDNjJMeWNMSlVmb1JkY2dkZlFVOXZpbnZDbEJsRlNV?=
 =?utf-8?B?VHk3NzlRTFA0ZXNNU2RwMjVLT0lOdFVqL3lEanZmREZnS3VXUkRFdEtBSE5y?=
 =?utf-8?B?bWY5UlIrWFM2bUg0c1VnQXpjYS9FQ0hmVm5XSFZTaXpRS2pGamFNeWZwbTRJ?=
 =?utf-8?B?MVJyVDlGRTBETithbWlEWmljVG5BVUNsY3dTM3pkd2x6b29oQ2RuUEhQN3gv?=
 =?utf-8?B?TEJjWGV1ekFMbzN4NWZPZTJXald1ekVzY3pOT2NUTjRFY0pRcVNTekgzWGg0?=
 =?utf-8?B?VmVpbEYwa083ZkhQREErOGdSWFBrTG0zWWJTZi9HL1FuWjdGU1N3bGNWTHFr?=
 =?utf-8?B?WHVsZTY1aUZUZW5VNEZkTGN3QmN3NUtvRkVyRCtSbmp6VHVWQ1BQL0Rtdlc2?=
 =?utf-8?B?Ui9YUDRUL1pGK0Z0SFVRdUp0alowaG4rQkovS0JlY2tOc0Q3WWlnK2ZXYXUw?=
 =?utf-8?B?SHpFRHhvYXRhS1lvUjRDaWxKTVBaa1RoaWZIcHowMWV0R3hTT2FQcWNkcXdy?=
 =?utf-8?B?QWcxRlF0RERhUm9vWitYd3RQKytTZlJzR1FNUWxNNkIvRSs2d0pvbTdXSjNS?=
 =?utf-8?B?dFJXQjhCQ0puMVRkR01iYzVPZkhjM0NlL0hNQmg2UXRLa3pCSmJWenVKcGZk?=
 =?utf-8?B?aUFvZlRtcGtraEp5MnFlaDhuK0ZObFlORlBXblFnSm1JUCtSYS9kWUt0WUVh?=
 =?utf-8?B?Ym9uYWVicmpsZnN5OTkyWmVILzg4SHBBNTVKMVJzdVZJUXNMdm5SWG5PZmlK?=
 =?utf-8?B?SkFrRmw3N0NrNERYbzRSSVlWSTR5UGVGM1hSTC9wRHdVOTAvakdlaGdtaG92?=
 =?utf-8?B?MDBUT0NZcVFFTkdrR1FsRlRZMUNzaVpKN0Z3TklkaE91K3FGZFovMU1LL01Q?=
 =?utf-8?B?WkhXMEZLU29Td2lGdTBJSWFJeTd4NHZpaGdpUWh6Vk5pbTZhYS8vTVNpOTBI?=
 =?utf-8?B?T3VpWjJxdGVHTllld2NiNkZ3S0RoUXJkbWs5RkUyUlVPL0FJYlBxaEJQMGFX?=
 =?utf-8?B?THdUalBFelk2QnhlM2kvcFE1b2E0bnEwSjIyVFI0d1UwUnNoOE1SclIzeU1Z?=
 =?utf-8?B?a00zbWk1aHZEaW9EdEhTZ21EOVRsVTdEWHExNEc2dE1kWi9MWko2WlBiRkln?=
 =?utf-8?B?Wk9ZNi90dEF5L0JQcmVPTTJNbzBPK1JBaGRUdHpqRDBtUEs5WGVGMnNHUWw3?=
 =?utf-8?B?VTZyUjcwSGxUSmRVRWU3VHFINzhuSjM0RlJDZEN4L0xTQmpNeXVjaVBqWE8w?=
 =?utf-8?B?T2IveGVtRkE2QzVSeFlOWjhZNGlGbnpMSmcvK2RYQkpRZ2pCTDFkdlRwNUty?=
 =?utf-8?B?Q0NHQldHQUEzaUNndVB5Ti8zSUZHaXUvWlVDOGRYVkQxd21OOHZUMlJZdXZh?=
 =?utf-8?B?M1lLUU5McVFxeDZBTXZxUmxJNmRkOHZDTlU5bUxnakZ1eGxYWmdodU90bVFB?=
 =?utf-8?B?NEIrM3lOclJVbnRvbU5WQlIzZEJIOGxRUm02Z0NVR28xK2p6WVVpQnBTeUND?=
 =?utf-8?B?TEJYL1ZScHBPN1Y2alJYWlBSaUs3NjdaT3ZnYVZSVWZkUm9RQkxTck1OUUhj?=
 =?utf-8?B?ZEdjNmR3RCt1TDZMUW85aG02cGxLK1ZjRW53cXVLbnRlczJYWWxIYUYvMS9K?=
 =?utf-8?B?TDh4a3dQSlljTmZKdjBLdGp5OTEvSHJnT1ZBVm9Jako5TWdkSHJ5bThvTWUx?=
 =?utf-8?B?WDVKV2x0L1NRb3VSMGhUUXBRNWZDRkE2MVkwbXU0bys0bFI4M3pMNzd6YmlS?=
 =?utf-8?B?MXkrVFljWFQwbTdFUjVHVHZSL0VLNEwwWGpmMGVhN1VEVTFrNUQ3Vkg2Z01S?=
 =?utf-8?B?TjR6YllHV1I2VHRwWFpWT3dmN05qMUppQlFrRzJhS1NCbWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThockRJbXNlRXZjYjJUdzN0VFVlTDdwUXVzK2M5MFUyL2JpNVRKVEtSV0Jy?=
 =?utf-8?B?bGZLeFFxb3dFZEpVSEZvNG45UzNTQ21hdmpJeXMrQzdKSkdCT1pGOGEzVVVl?=
 =?utf-8?B?dDRhVGlleGExWitLUEIwQlhZNmVseEtJUHFWeUQwQmNjMU5ndm5JcEhoT3lT?=
 =?utf-8?B?dng4VVlEUkZRS3hyOUFsZ3ByaU9NOE40bUsrNWRnQWVFalZ2R3dScW9IZkJT?=
 =?utf-8?B?cTF4aVlkeU5tcnhVYmRHTkFCRFlsamdxT0Q5Vnc5a3dycUg1TTRXbXhTai8r?=
 =?utf-8?B?VjVueHoyVGlxaFRkQzMwbXdqNXJYUmQvK0hCQXJCcTdDYWtaV2RkeHd0Zmln?=
 =?utf-8?B?aGxhNXJsSlFWRXFzeVN2bmUrYWQ5eFBNZkI4Qm01UDIyN0J5M3pBb0lRZWJR?=
 =?utf-8?B?eTh1QkFsbWNRK1lVNC9DUE5oUnlvY2w4MUVCZ1MwdXdWbVBsSWtuVmFxUGo0?=
 =?utf-8?B?MU9iRGdxZVVsYWx6YmJhYnU5M05GSUJyWHhscHlYMzJ4NzlOZVBKYnZzWVJv?=
 =?utf-8?B?Ym94aC91VGZuRjhBcGhWckwzSzhpa3V3MWpiU1dRYlZQWDBHVHF5UlhSY3Jm?=
 =?utf-8?B?T3FheEU3NlhuVVNOUVk3OGorU1U4Rmg4d1BCNlNBM2xUNUg4OHV1aXc4KzEw?=
 =?utf-8?B?MjhVSmxEVy9WSDcvU3hmcFYzaFVyeTZFdmEyV0dDQlJ3NWVwZnc1cFdEbTlm?=
 =?utf-8?B?T2R3WmthbTYza3ppMFdVVDNrN2Q2UzlRbWVQNHh5K1YzOE5OQUxQa1ptVEdX?=
 =?utf-8?B?Q295ZW8zWnBxUXdJYmpVOFNqOTFCMzN1K2tCK1Z1RVlGNlVTS1dPeW9BWTky?=
 =?utf-8?B?UnlXcTlrdHoyK1daNzZaNS9PdHNTR3F5dHFvNkloRHhlNjM1VjFNWGJsVFBY?=
 =?utf-8?B?azk1RjhWUUZqNU1oYm15ZnA3TjJIbktKTW5zbENuOG5EY2RjQml3MkxIZk9L?=
 =?utf-8?B?b3p5N2h1SDh2Y005TTN6UGhFMkNQWkRIODFEcFZxU09NTnRuQ01zRlpZc3M2?=
 =?utf-8?B?UTJielJiaWhLYnRHYlc0eGZqVllJcWFBUlVmMkszS1JjNUpPR0k5ODlEWTQx?=
 =?utf-8?B?dk1CYkpUbC9SRVFwZytKUU1wSy84TDNrRmpERUY4MWpZM2d6bTBNY093YTB3?=
 =?utf-8?B?Smg1cTc2LzlKTit0QjdqYzRuT0JJRWdTdFptZ2cvYm01NENvemNNN0Fpdmkx?=
 =?utf-8?B?Um9ndUgrYU0wTlFvbU01ZWQrVG50UDZUL0hZZTVoSjZ1T0srSHRGaXF3bWU2?=
 =?utf-8?B?ZUl3bTJ1Z3BZUVRmTzR4Um9SSDRKcHRhWnJkSzJPWm40WFhhZXh2SnJZTW45?=
 =?utf-8?B?N1FIUjlWb1FxVDIzUXlpVlFGVXMxT3FFWHZUTVpnaTBLQnAwWlVpSUV1RGVn?=
 =?utf-8?B?MUFPeWdJYmZYRVM2QVVETGdoMitKODVjc2RYN1RXTFd4K2lFZ2ZmT2pHaTA1?=
 =?utf-8?B?RWhCaloyQzRUdHJuNEtRZFhFRDJGQ0lmalovU0JFWkZXWEtEV09oYlFsVllS?=
 =?utf-8?B?aUJESERkNk42Qnh1SG1RWWZqaktFNWtuT253NU5lUkNqSmthTlhMbGlPeU1Q?=
 =?utf-8?B?SXM0ZHI3WHNjQm9vNTNDU1krd3orSDgrNTNwVTY3VndIdGcwYTh3NHdDd0Vk?=
 =?utf-8?B?aFI3ZDc4ODVmakJxT2d0UjVyVml2T3VpUjhneVQzKzdZOEt4di9WWUpNcjZx?=
 =?utf-8?B?TTZGaHNXcDc4eU9mOU5LWHdyZ3dvNDU5SThoMFAyNnlvRXdOcUovL3oxb0M3?=
 =?utf-8?B?TGxxLzNxKzhQMlM2ZmFtQnNnRlIrZSt0OXBVQXpPZGw0YXdxVCtJR20vRHNa?=
 =?utf-8?B?Y0d1RFV3cmpxN0Yva1pMckhKdEd2K0p5ckRBVmxtem5peDZBL0dHeElvNkVP?=
 =?utf-8?B?ZitoVzROMmJyamZkNGozNGYwVzU5bFhPRXRWbGVuZWRoeHhsSVR5VDNWTVdT?=
 =?utf-8?B?cXpSTjlwMU9YR2RjdGtJeEFxY1ByZEs2ZWlMSWU3UDRBREJLK0x0SVJneDJx?=
 =?utf-8?B?YlRVb05YT2NyTUtIS1BiYkxiSU1SSUJ1Wk5Ydmx1c1hPNHpKb2VydkYyWHgy?=
 =?utf-8?B?QklZVjRudXVXUVJSVlUwSHFpNWIrTjN2SGVCVnRCL1ZkdWVZY3FNM2dBRnIy?=
 =?utf-8?B?cUM1OTE2eXRBUWlqaTJmUW9meXRmdjVUZmFTbWEwM3QrN2ZHZ05JWGtwSlUz?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6309826d-af46-4e97-b520-08ddc369cf06
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:35:37.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adFYZdtFoybB+MvLRfouU1NR06lCtDLN1Xm2HCCcPyhvdgsGmxCqXnzCAfdlxbzYzegnrFS7NFnaTlLfKnbmCqyLkySzf+c8/0weYp1lLP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com

Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 04:20:03PM +0200, Lukas Wunner wrote:
> > I guess what happens in your case is, *after* initial probing has
> > concluded and user space is up and running, a driver is unbound
> > from the device and another driver is subsequently re-bound.
> > E.g. "nvme" is unbound and "virtio-pci" is bound instead.
> 
> How?  This is a non-modular simply kernel running on kvm.  There
> should be no re-binding, and binding nvme devices to virtio of course
> also doesn't make sense.

I too could have swore I see async behavior with cxl_pci. I believe this
patch is only affecting async behavior when the driver is loaded before
initial arrival of the PCI device.

For the typical modular driver case the late arriving driver also
arranges async probing. Lo and behold on current upstream:

[   13.002750] __driver_attach: pci 0000:35:00.0: probing driver cxl_pci asynchronously

...so this patch is only a change in behavior for built-in drivers
loaded before PCI initial scan afaics.

