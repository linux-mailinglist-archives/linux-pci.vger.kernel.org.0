Return-Path: <linux-pci+bounces-37369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48767BB1A7F
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 21:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98131922EF9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EF272801;
	Wed,  1 Oct 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkUlfLz7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1427146B;
	Wed,  1 Oct 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348694; cv=fail; b=fVy35sHMf2Pp2GO2UQjpXYIrlYmjuSzdtcqLMqEeWSuXgub/FxzcpvQeFUx92RL4D2QLOuCOfmIpfUhZSHEF/hDBFf169hKnInVEZ+ESi24WFiJflPnsMIW4HJmlxJE9JU0uxGRWKd9BFrG9V9RuIn7gxo3Yt9yXnz3lWG/cBe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348694; c=relaxed/simple;
	bh=I64N16KnS9Evo8s06eT1TVA9AedowCmJKtzZY4h2NTs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=m6Ljm/dvO/g84AOfpuu7/Q+yZJ1zlvb5dpcQHmUs2MwK8vtkZYY3ExK+v039oiDEhSR3hj1TAeOEtG3h7yCwbSNluP2Zcd8c2A61xPY82LgxMFKQeEgRRe0tx8N+aKrRQi4/C8vY0r0RAIBC//Jy6xjH/KlHIgNj9Hhwq1EN5Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkUlfLz7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759348692; x=1790884692;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=I64N16KnS9Evo8s06eT1TVA9AedowCmJKtzZY4h2NTs=;
  b=XkUlfLz763MD5aSFBecQRfgr9EgJVvVL6qOh5YvoXZuKNn3ykjwAO7Po
   jtwr186Gr87ZzS3PoVgdQSLmdiTqFNOuQl9GlG8USnU7Qbt/o/Cs0fCg6
   TJT2aA/bl3vKlnmjaTMcOM8EDGgFQuFQH+MpxhfdoqjZnf9lsZFKbpEAg
   zfAiOZM1b31owN0wHIk7xFQWLU0dU46zOGb1lKxAxoALvOL9VewAByfVs
   xMlBl7QbwUhSTEo1K5g86WKZGIUGnHuMP30eWKLBt+MshUmjyTYsBmkQs
   UW+L55d9nGV3d4KZk1efyzmTqUbT6yEMir2KZcJ4hFqCB3eN9t545fMpS
   w==;
X-CSE-ConnectionGUID: 1Uq/PJW3S/Wzx/MoTK4XTQ==
X-CSE-MsgGUID: LT24qtLgRta1pQ393pxTNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79056205"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="79056205"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 12:58:11 -0700
X-CSE-ConnectionGUID: ugdIZ7NXTme7AG0mgP0CGA==
X-CSE-MsgGUID: 0BUTSB0XTFm+aWSs8Iemyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="202597085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 12:58:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 12:58:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 12:58:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 12:58:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETChYUP0jfF2AshC8gBpIJRa5rogGCiweY1btBTLfNWip3Sl0mWCyBPxC2hJn6JFtjYlLKIwCaOHht5nSDNz4Hskb9ngd+weh8PJT0bAbHmW0f308KanwRsM2zqY6r7KwmIih1gSFOxry6QlhvYBo4GayDbrSRsOSNpiqS1m4DJd9OrNoIkBdO7EuZ4QHC8mQwwPdpBu2kf3C+wy3W8jf9hR4uVSsf8yNjcjBWN3R698ygckugCi0fgcYCZj1CIpeA1yo17jlmCi/Cc+/yS8VwBq0Lvdl5h1hoxAUHvhkh1sGbz24Gt9+egrNIaXMlgtPI5SEXZrAZDoG0g3ZWlAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/oyghJyWLBeUIyQDOwHaKMkG2WOpxrSldgf91DSaBc=;
 b=RHpo418SIxVurlOAsO9WKrKbwnEXA2WliolF2gAUXICC4TDaXqQlVaB016Zr1J0HiAG9izfbbK+QrTuoaft7ZRzirCmMvhu2QlGfY1EQRhiMhkX0FaqvTigc++N3PW02MQuwk/0G4PNiQwAii0FgLS987uDlshksz2+xWDGEnsxrT8waGnUqtZhvlJG3jAm/n9umyQ38wt/WsM1D8YW/UTQ6TM07GaBM1++mY+WLqpcZpStIbs6pKinW/8uQ81vAu3YLT3dUjeofJXhC3NuolNT0R8TPCl9cI6l3C88tGaRBeoNTY4el0x6TBvsuSF5pKxxLVdvhcvGEGCTui1E71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 19:58:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 19:58:03 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 1 Oct 2025 12:58:00 -0700
To: =?UTF-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
	<dan.j.williams@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>, LKML
	<linux-kernel@vger.kernel.org>
Message-ID: <68dd87c8866f9_298010093@dwillia2-mobl4.notmuch>
In-Reply-To: <2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <d58dfdf5-0058-a03f-dd75-5afb8ae69e04@linux.intel.com>
 <68dc7b5389621_1fa210090@dwillia2-mobl4.notmuch>
 <2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4244e672-4040-4506-cbea-08de0124d472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkhSUFNmLy9CQ3VZWkJMWXpJbFFYRTMwSDM4VUtUa1JMTlJnQm5PbHFpTTR6?=
 =?utf-8?B?RVBxc3FEOEdkYXVpblE2TFBwbHEvdWczQy9MM2JTbjExSC8vRGVQNVZyeGg3?=
 =?utf-8?B?MUlCam11aGV5aWQ5RzJlcU5wQUJ1UG9YNDNnUzY1VTZKL1FTRnM1dUQ5NlJP?=
 =?utf-8?B?R1hxeGp0eCt0Y1ptUUo1Mmd1ZlJBUVM4MUlyc2Z5WXRSOVVMQ0xZUXVKM1Zx?=
 =?utf-8?B?b2hDWWFhaHFBYk1BZlRjZDl4VHBNYWcwQldNQmhTQTFBNlVnWHdhTmw2T01z?=
 =?utf-8?B?akpuV1hFUXh1MHZkeDZ5dFMzZzZZazdMcnBlNE1KTFRvRFJvMi9YM0hOUnlt?=
 =?utf-8?B?aklXZWRhZ0VnWm8xRnp3Z0VTK2g5L3hUdy94T2JoQmhoZmJhbGh1SmhMaUUr?=
 =?utf-8?B?dEtuRnBRMU11Vjd1RVIzeSt5QllEenljZXNTZzZ0NGh0c1BOZVZVTExYOVNy?=
 =?utf-8?B?dTEzWU5hRml5Ympkbng5bUxFeGNpRUl6YXo1QVZkcE8xdzBBQmU3WTQyUTJH?=
 =?utf-8?B?M0JEZmFacklPcnhyYVFMaER4UXpETWx6ck8zMFhZLzltS1FHMmk3UHVuMjAz?=
 =?utf-8?B?N0tvSmlQRFluckNCZHhWbDhzR1RRb0p3U0g2YVdVb2dpdUx4U3dQaTBnbUhQ?=
 =?utf-8?B?dVZRWlVCUVdlTXNSNHhOcEdOTmEySVdvV2s3bit2QVUzMFdKK21xbnJxcEs5?=
 =?utf-8?B?MXpIaW5Td3N5aktVZzdEZlgvcmh2MTNKRm1KYkJQVTdDcHBrdU1FTW8rZTlw?=
 =?utf-8?B?Qnl3ZnBmV2xNTCtFcmRKNDB2dUxJM25yQUNJSDZJT1ljRWhqbm8xMW5ZRFdV?=
 =?utf-8?B?UjZwcUFMVTJ4d3RFeElwVTAzV3ZZNUprY3lQUWRCWHovTFRmZENOOGRwNXJJ?=
 =?utf-8?B?OFk0ZDVpQzdRUDc1VUU5QzVpeERmZFYwK1pKRmdDRXlKdHNyeUFQTTZNcE5z?=
 =?utf-8?B?bEVXRm0rT3o1cTd5K3dxYjRpYnl1dnliUks4bnhaMkJ4b25qd2JwUlczYVA1?=
 =?utf-8?B?UC9HWHArczNwZnI1MnNDMjZhcHBaU25QdGFDSTEreWlkcjdKTTJrKzc2QTVP?=
 =?utf-8?B?THFBYjErYW5CSFFNWGF2ZWZWZW42b0FVK0NDMDFqbDFqNTN3cnBBWEFGSStu?=
 =?utf-8?B?VnEyZVFrNzlPalplTWZ3OGNXS3k4bVhHcGRXZzRHOHhhZnZxM2N5SDE3dXNh?=
 =?utf-8?B?eXZhUm9Mc1FtdzlXcmpGWmxOTTFNYTBaQ25nNmZHd2d5R1lRMXVCVkx4Q0g0?=
 =?utf-8?B?UGFpd0FjUDNJTTV0cWwzVTFuOE0wL3hQaTFHMTl4eHRPc0VUb0o5bGo5OW1H?=
 =?utf-8?B?ZEI3dnJtanVqMCtpdGVpK1B3Ny9LOTFWeXA1cU5FRTF2U0d0eTdFZWF2aEtQ?=
 =?utf-8?B?WTJwbUhSVWd1K05VeFc0Z3VvOUs4NnRlTEt5bGtTZk5hL0tnd1pUdi9yQVlM?=
 =?utf-8?B?OWoxSEFPWHpyYzIvNUN1RWlzSDFZTS8zT0pjWGFrUVV3S1g5MlVJazNxNEg2?=
 =?utf-8?B?cVNhOWV3Y1EwdHJPUkVnWGVmdFVITjBZTFVRa056RnNxU2RpVUtwa2lydDdp?=
 =?utf-8?B?aktxek81c2JiV0VVcjU0MUpCM3RYc1krR2JTMFpSeGl0aGpJcmp6dEpjd25q?=
 =?utf-8?B?SGVlbEZNMk5UWjRlanplbWt3Sk1EdVdVUUpnWTRrVmNQWXRmbkNZR0doUElk?=
 =?utf-8?B?R1pHaE9zMWs0YUZWU1JidXFVMVdSbzJCMEpPWHM0K2lDRHdwOGZvQ1hkbUNm?=
 =?utf-8?B?a3ZFMnl5M0VTelV5UGtPV2h4TC9SNGZNZ1BWaVBBS2xvcnVTQTltbFk4cEZG?=
 =?utf-8?B?amRnTURYcHNuMExXajR1aVo0YWNQYldFY29iaDg5NW5CMnpFK1A5OWFuc1Z0?=
 =?utf-8?B?T3hLeHZXSXlHOUQxQ3UwU0pOMy9FemlNdTJXRE42aVY5ZWg4Ri9aUVZsb1NC?=
 =?utf-8?Q?7aNQ+8GMp8gRVx0ChmN6jmh2yHDPkH/c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpzZ04rdUxrWmFHaElaZExTU2ltMGp3OXdiTTRod0M1REMxQkJXMk1LS0c4?=
 =?utf-8?B?RjB0YkJBR3oxaUFuWEsyaGQyWFczK0FvQ21NR0w5TTl6SzNTRTZHME1pZ1BZ?=
 =?utf-8?B?bWNGeXprek9NbUU1Z2tiS1VmcWlGM2RzNlpaUzBlbkhHczZ6RDJzUHUxLzVY?=
 =?utf-8?B?cTlXdmxqMEhMcXZCR3ZEV0xQZjhtM21YbzA3TFJ4eVdJZExMMXZ1ZXl0R0lB?=
 =?utf-8?B?djFiZktUT1JzRzZFcEUzTmMreGREWVRSM1NxcEpvRVVoOEd1MkNLcFNYSkNj?=
 =?utf-8?B?UHN6MlNVdVhOL2dhR3VQaS9KT2NyNlhYaHl1U0pjRFJTaEswM2srSXNQNlRj?=
 =?utf-8?B?eGpTZGFsZkVYNHVpaGFpV3hOUjEwb0s4VUwwTTJ6bVh0K3JZZHpNQXQrMmhj?=
 =?utf-8?B?VmZkUWZDSXZpTVA0bTYxNk9wQUVycDJkT25QWWE4Z05kMW9HQVBNVXFQTEZ5?=
 =?utf-8?B?SjVlZ1MwQy9zajF5ZW9xWjRoK3FZYm40eHJOMmJqZVN0UzlUWjVOSlZOYXlI?=
 =?utf-8?B?OXgzWGdocmR3WkZ3cHNUV2E0U1p3TmREN1BOcHZRWkdsdDdsVzRWWFVjY3Jj?=
 =?utf-8?B?V0lyUGNabDB2ZkxLVHg1UUczcG1mdDRLV0NoakxFeEFpcGhIcExTQmREOGdn?=
 =?utf-8?B?aG5mSUVNZWUzc3VhT2ZyUGoxMTlNODRYVlNMdjRIV0JTWDh2UG1sMC9BcHkw?=
 =?utf-8?B?N1FPVm9FNkxnTUd5QURkRHQwdC9XbGxlUW9neUV3Rk1JQ2FDbUFqR2poVzE5?=
 =?utf-8?B?dER5MjNlU1VOWTloVWd5R2VQYmRpbUZwMFRhU01qOTgyd29zZy9RYjdlS1FB?=
 =?utf-8?B?RGtxMlhJRzJuT0huR3Q1OEtKeFpNTWhlaVNSeFd6N0tLSzZRVy9IQVNFQ3I3?=
 =?utf-8?B?d0Q0TTlQVVJMVThGWDVLWVBqWmFWV2c2OFk3YlVvU3Yyb2F3RXBacEZ1Y3V6?=
 =?utf-8?B?M1hjdk15WkFmQmYxM1U3WGZDRHFod0dmalBmNUxTcGtGbW4xakRSVkRDc0pI?=
 =?utf-8?B?eXZqeHkzTENrQjJlZjdxMEJoSHJNNmpjRFNSd1JRNFF5bWRLUjlHSUg2V0JO?=
 =?utf-8?B?TnFpRE5TKzRacGR1NExkbXcwTWVuNDd1M0JrRStSWHJYbUlsMEhpSXF2TUZs?=
 =?utf-8?B?YytDQ1h2bDVPcHNOZXVTUHBwcWZHeXplZGkxa1ovOUp1M3ZRbkFNMHAvMm5X?=
 =?utf-8?B?U1MrRE1SQzI3dE5TeGNtUnpTdjJjaUJxWHgwcll4Ym9JZEpUUDZ3bW9kdlF2?=
 =?utf-8?B?aUhFWk9jcjllODhCNUIrTkNJOGJ0TDdnK0NkT3pkaGJXaFlGUjMvRkhualNW?=
 =?utf-8?B?SWFvQWxVSHY1TjdMOWU5WVdLb3pXYzVYdlpSRktmMGNucmJ2MFIwdUdiM3BY?=
 =?utf-8?B?T1VxRzRyWHlTenJETk9FNlpYYkZaOUN5czlxK2hJdGwrMks0bVd1cCtLcXZs?=
 =?utf-8?B?T0N3THRlbHN3TzF4Qk4xbVljK3hDSkxZRkE5azcxYnpPZEFrNC81N3hWVHQ0?=
 =?utf-8?B?V3BERlFBbVBuVUpGbWYyODFaWXVRN3UyeUp3cy9mekxEMGFyem53UFJMaHVp?=
 =?utf-8?B?QVBQL3J5YjRxWVRDQ05XajNnMjRkQ1F1bkxKelJpdHUvUmQ3L1FFS0hVdmp3?=
 =?utf-8?B?Y2crV3dTOEZoT3Z6VEdYdytwSjRnVngwZkwrZStaMzltWDU2dnA2RjVTTStz?=
 =?utf-8?B?UDg4UWhzTC95L3FsVTVZOTdpREJlMjhzTWtsNFFpTy9qTjlZUGQxMzF5Vllh?=
 =?utf-8?B?ZytsbkFGVXRtMlRGb2RjUnlDamk5UTlETkpWUnRjNmx5cnA0M3BTbnQrMk5L?=
 =?utf-8?B?RkdHTHE4bTZpY1oyd0lSMnNYSU5kS055SUQzVFpFYTE2aVV6ZkVNcUppYVEz?=
 =?utf-8?B?Q1hxT0EreGpRcXV0elJzbSswbTY0ajBscUY3dVJrTTFxRlBjbmNHTE4rZ1dr?=
 =?utf-8?B?ekp3ZVRFczVXdk05aWhoNmhlQnNsVlFHbmV3QkVBWkVDbW4zbTdDOXR5VTB0?=
 =?utf-8?B?ejA1V2cvR3FBd3pHY0xIa0JlQkFLWC95c2lDTEo5RXd1T3JETWdSbWpmeTll?=
 =?utf-8?B?MTY5bHo0TEVMM1hXR2d3dnVnb1pxbzEzd0FVV29VN3RVaDhmSWViQkJzczdw?=
 =?utf-8?B?S3BSQ2xhQXNVTlFxTkNLeWJCSUgzRGh4STk5OWdhalRRTVZHQ1VSQVdveHlX?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4244e672-4040-4506-cbea-08de0124d472
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 19:58:03.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8W7ekWI3u5FkeigNR0tlPktEDn9Ere2o3V4LKvenw7K00A4ukXj+R8ONfdfvn9FMn2eI5xVvEgi6ytDnIo7Qtt0Lfb7CwZFsH68dBmCuhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com

Ilpo J=C3=A4rvinen wrote:
> On Tue, 30 Sep 2025, dan.j.williams@intel.com wrote:
> > Ilpo J=C3=A4rvinen wrote:
> > > On Sun, 28 Sep 2025, Xu Yilun wrote:
> > >=20
> > > > Add Address Association Register setup for Root Ports.
> > > >=20
> > > > The address ranges for RP side Address Association Registers should
> > > > cover memory addresses for all PFs/VFs/downstream devices of the DS=
M
> > > > device. A simple solution is to get the aggregated 32-bit and 64-bi=
t
> > > > address ranges from directly connected downstream port (either an R=
P or
> > > > a switch port) and set into 2 Address Association Register blocks.
> > > >=20
> > > > There is a case the platform doesn't require Address Association
> > > > Registers setup and provides no register block for RP (AMD). Will s=
kip
> > > > the setup in pci_ide_stream_setup().
> > > >=20
> > > > Also imaging another case where there is only one block for RP.
> > > > Prioritize 64-bit address ranges setup for it. No strong reason for=
 the
> > > > preference until a real use case comes.
> > > >=20
> > > > The Address Association Register setup for Endpoint Side is still
> > > > uncertain so isn't supported in this patch.
> > > >=20
> > > > Take the oppotunity to export some mini helpers for Address Associa=
tion
> > > > Registers setup. TDX Connect needs the provided aggregated address
> > > > ranges but will use specific firmware calls for actual setup instea=
d of
> > > > pci_ide_stream_setup().
> > > >=20
> > > > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > > > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > ---
> > > >  include/linux/pci-ide.h | 11 +++++++
> > > >  drivers/pci/ide.c       | 64 +++++++++++++++++++++++++++++++++++++=
+++-
> > > >  2 files changed, 74 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > > > index 5adbd8b81f65..ac84fb611963 100644
> > > > --- a/include/linux/pci-ide.h
> > > > +++ b/include/linux/pci-ide.h
> > > > @@ -6,6 +6,15 @@
> > > >  #ifndef __PCI_IDE_H__
> > > >  #define __PCI_IDE_H__
> > > > =20
> > > > +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> > > > +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> > > > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> > > > +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> > > > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> > > > +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> > > > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> > > > +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> > > > +
> > > >  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> > > >  	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> > > >  	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> > > > @@ -42,6 +51,8 @@ struct pci_ide_partner {
> > > >  	unsigned int default_stream:1;
> > > >  	unsigned int setup:1;
> > > >  	unsigned int enable:1;
> > > > +	struct range mem32;
> > > > +	struct range mem64;
> > > >  };
> > > > =20
> > > >  /**
> > > > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > > > index 7633b8e52399..8db1163737e5 100644
> > > > --- a/drivers/pci/ide.c
> > > > +++ b/drivers/pci/ide.c
> > > > @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pc=
i_dev *pdev)
> > > >  	struct stream_index __stream[PCI_IDE_HB + 1];
> > > >  	struct pci_host_bridge *hb;
> > > >  	struct pci_dev *rp;
> > > > +	struct pci_dev *br;
> > >=20
> > > Why not join with the previous line?
> > >=20
> > > >  	int num_vf, rid_end;
> > > > +	struct range mem32 =3D {}, mem64 =3D {};
> > > > +	struct pci_bus_region region;
> > > > +	struct resource *res;
> > > > =20
> > > >  	if (!pci_is_pcie(pdev))
> > > >  		return NULL;
> > > > @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pc=
i_dev *pdev)
> > > >  	else
> > > >  		rid_end =3D pci_dev_id(pdev);
> > > > =20
> > > > +	br =3D pci_upstream_bridge(pdev);
> > > > +	if (!br)
> > > > +		return NULL;
> > > > +
> > > > +	res =3D &br->resource[PCI_BRIDGE_MEM_WINDOW];
> > >=20
> > > pci_resource_n()
> > >=20
> > > > +	if (res->flags & IORESOURCE_MEM) {
> > > > +		pcibios_resource_to_bus(br->bus, &region, res);
> > > > +		mem32.start =3D region.start;
> > > > +		mem32.end =3D region.end;
> > > > +	}
> > > > +
> > > > +	res =3D &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> > >=20
> > > Ditto.
> > >=20
> > > > +	if (res->flags & IORESOURCE_PREFETCH) {
> > >=20
> > > While I don't know much about what's going on here, is this assuming =
the=20
> > > bridge window is not disabled solely based on this flag check?
> >=20
> > Indeed it does seem to be assumining that the flag is only set when the
> > resource is valid and active.
> >=20
> > > Previously inactive bridge window flags were reset but that's no long=
er=20
> > > the case after the commit 8278c6914306 ("PCI: Preserve bridge window=
=20
> > > resource type flags") (currently in pci/resource)?
> >=20
> > Thanks for the heads up. It does seem odd that both IORESOURCE_UNSET an=
d
> > IORESOURCE_DISABLED are both being set and the check allows for either.
>=20
> I'm a bit lost on what check you're referring to.
>=20
> If you refer to the check in pci_bus_alloc_from_region() added by that=20
> commit, now that I relook at it, it would probably be better written as=20
> !r->parent (a TODO entry added to verify it).
>=20
> > Is that assuming that other call paths not touched in that set may only
> > set one of those flags?
>=20
> Presence of either of those flags indicates the bridge window resource is=
=20
> not usable "normally". There's also res->parent which directly tells if=20
> the resource is assigned. Out of those three, res->parent is the preferre=
d=20
> way to know if the resource is usable normally (aka. "assigned"), however=
,=20
> res->parent check can only be used if this code runs late enough.
>=20
> To me IORESOURCE_UNSET looks unnecessary flag and would want to get rid o=
f=20
> it entirely as res->parent mostly tells the same information. But I don't=
=20
> expect that to be an easy change, and there's also the init transient=20
> where res->parent is not yet set which complicates things.
>=20
> But until IORESOURCE_UNSET is gone, it alone can indicate the resource is=
=20
> not in usable state. And so can IORESOURCE_DISABLED.
>=20
> The resource fitting code clears DISABLED (while sizing bridge windows)=20
> before UNSET (on assignment), so they have different meaning even if=20
> there's overlap on the consumer side depending on use case. The resource=
=20
> fitting/assignment code cares for this distinction, see e.g.=20
> pdev_resource_assignable() which only checks for DISABLED because, well,=
=20
> we're about to attempt to turn UNSET into !UNSET.

Thanks for the details!

> > Otherwise, the change to mark the resource as zero-sized feels a better
> > / more explicit protocol than checking for flags. IDE setup only cares
> > that any downstream MMIO get included in the stream.
>=20
> If this particular code here runs after resources have been assigned by=20
> the kernel, please check res->parent to know if the resource is assigned=
=20
> or not.
>=20
> I'm considering adding resource_assigned() helper for this purpose as=20
> res->parent check looks too odd and may alienate developers from using it=
=20
> if they don't know about the internals of the resource management.
>=20
> If the bridge window resource is assigned, it should have the expected=20
> flags and IMO it's useless to check for the flags (if flags are not right=
=20
> for the bridge window resources that is assigned, we've a bug elsewhere i=
n=20
> the code).
>=20
>=20
> As a sidenote, there are lots of !res->flags and !pci_resource_len(...),=
=20
> etc. checks which are often custom implementations resource_assigned(),=20
> they all are landmines that make my life harder as I'd want to make=20
> further improvements to resource behavior.

A resource_assigned() helper sounds good to me. I will fold that into
this patch for now, but feel free to pull that out and merge separately
if you need it in other places.=

