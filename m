Return-Path: <linux-pci+bounces-34019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D3B25933
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98A9A02EA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB18204090;
	Thu, 14 Aug 2025 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfWW0s8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA472FF658;
	Thu, 14 Aug 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135647; cv=fail; b=h2uaUUd7QvGbIAOFdeJQk6yB6wkRt9ZaWe0RzyC9dPVTJVZDS9jfxxAUYyk55/zlyNgLzSMezM4wmwxA+ssOMMcbyttjsYm36X/8FMpgToVzxX+pyd7c3kmzvG2IkyhqmrPO+aISUnolDXlCO7NvnxIaIDOoHEEJsCDMAcXIuJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135647; c=relaxed/simple;
	bh=NGqCfZfmDHdokmb/Jxr7KhezP48fyB7Ljpm3bkS9UP0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lso3E6w7EAZYbsxciNuW9Ou8odisfqrGJN9Y0hs3XYcwlL8CclWEo/+ONBPqXoN4OFoswxfxu8c8vHvvaEl/zC6ZBSDCMenq7m4DbCzxkWYCGRV3wVv6mO86og1jG3dTld7wAW55UC56hN+gtvdOxXDRg8sQbmDzh1eR2yy78i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfWW0s8c; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755135645; x=1786671645;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NGqCfZfmDHdokmb/Jxr7KhezP48fyB7Ljpm3bkS9UP0=;
  b=cfWW0s8c/uWI8jNHWU5GUFo2Cwm50rBUlkFf1SFWWV+qWoc3xnV5CRb6
   N1yKbJdPCNVeZePVXzfeCxBxHyWmBZl1knciz4LKrsIjplrDbo9wT0v/0
   wITBSvC9LQlr0F/yuDwapZTb5M+G9YxY0e497sXFm9X+IUdFdnzIk2Zpv
   xaaOeuCnNeQnizRZmcZALUbqOO3A/dkMh3JQLC+8j9f2yE8Pn/LJxRn/l
   /ccjV+8gUKiKfvkj1kKRE2wdp6pxKt7v8p0AGg6+hsKW2H6odbRZ6m3UG
   aarhlZABUMh4qhTQxODXiojc76h9Okxzy/XXAfZHtkp9xyNZSzmCLa4Qf
   A==;
X-CSE-ConnectionGUID: lCsvWaLERjG6Y+7t4pmlLg==
X-CSE-MsgGUID: yCMA65OgTqeSuyQzXbk71w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="45023575"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45023575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:40:44 -0700
X-CSE-ConnectionGUID: j1hP/qidTkaH66Oj436omA==
X-CSE-MsgGUID: 9pxKiJSbTGO0qr75UxPdQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171082336"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:40:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 18:40:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 18:40:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 18:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcpu0a7aD41QaofQRb3819VHAKecYzbewvpqLOmNULMGvCULXtNJlzIJLt1+ZYvgR94j0EJlH20W5EIry61/NtxihFRU54aaO9yP6LoHCWz3xzpqtbVZGuwwnKrc8oBofxC1zeRZ4mTR+z8vPH4ZPbNBJprdOE2KHszfaECY/Y8H3iGfxPVwZpN1+mB5OBHcnIOOogJ1DUCwyJbA/UHZrMrqo7FE8+YeqM79uh36LvdncTfhKq9rlUKO4Ul9uJ3STBnjM1+16HSqzYjjj7H4wSSrFyXiFNeCysL7HXbroiqQvic3s1e0/vhcci9yJ9ako6+uy/+FcY76mWeiqF0IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxJKUiHmUs0wcRF+IxKFmOVR8vbJ+m8it0rHd+Y+FW0=;
 b=f39GtRcmF+ocqBgcRJdDy7M7Pa5abkc8nQ8Ja1YBqHCwLgad4RUfggTRF1WQ5z8vKova9TxbG8+9sBAntv0rBGrSMrrbb4PUupx4Q4XYSw8DKGkXfC+ao1rXkHveW9QmtZGFm2Wl8HEK4IGYSQXadAb29+iKQrdLLkB2MOK2rtnc7xwWWOrjLMHPtyKa36fCbjL2s6vaNon2lhgL3vV4Kq04zMz4RmPPikyZ2ZsRd160Tct8vEfKRb57TI1jI8Zh+g4He7vjtwdFqwTLzDjIbxmKOzSF2YLFGK5nao1KRaDLCMLW139RZeEnwAC8hrdUg3lcUVwGD+KByVgL601sCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 01:40:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 01:40:41 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 13 Aug 2025 18:40:39 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <689d3e97760ba_27091004f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <7b6782da-1318-4dab-8230-e59a729f8f11@amd.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
 <7b6782da-1318-4dab-8230-e59a729f8f11@amd.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: a6755da7-f0e0-4072-ea80-08dddad393dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW9FckZOTndobU5FQ3oyMWdhdmlzTEEwMjlxV2haMFpZMFhxZXRPMk9Fb3Jk?=
 =?utf-8?B?UVFnNkJvMjBLZzlRRjlSSHpwWFNyckVnOXFNMklEZktiN3l1ZUVlL1QybWxj?=
 =?utf-8?B?eHZxeVVoM1RLZ3FBNjhmRE8zbnN5WXF6ZndJQnVaWUkyQUwvOWdsMVdQWlFl?=
 =?utf-8?B?eDkrY283UjJtQ0p3YUd0cDVjZDVPT3RCNVV3bUtiNjhPQmRMS05kdUt0TGcy?=
 =?utf-8?B?SEt6dzNjWlZFT3JWL2hxcjNDOXhIQXQydmsvTVRkV3Q0Y05ZRmlyRlNWcGdz?=
 =?utf-8?B?Y0RSSnRxYTNIQXl6YlpLRE1NaGx5ejk5TGtnQ3puekp2NkVKU0c2RWFHWGda?=
 =?utf-8?B?OVJMUzM3ZnA3NVJGQlpQejNLV3dHa3FIZEI2Q3lqbGZQWkZkR3hucU9VYVRw?=
 =?utf-8?B?bWErbVpkWXlDYW95OUprL3dwTk9xVzQ1YVBzbjRDcWhrZkZZNHpiVFVTTXMr?=
 =?utf-8?B?UUtLU3B1TEk3RG5WSG1RdVVMRENpUWk2NEZ2ajhiMFN3MjQvQXRzL0hMSmc2?=
 =?utf-8?B?UFREK0x6OHk1dkpJaFphSXdjN1dkQlJvTE5uOTdDUDZmL0IrQmJPZnoydXdE?=
 =?utf-8?B?RzVSa1pGYTNsYkdrSXVlR2F1aEZTaEJQd2E0WHpVclpQVGlEMjVKY21qWW1y?=
 =?utf-8?B?UUxYb1Y2a1BUSHpTNWppUHkySXVXVU4vUjVQakxxa08wMHphWTF1UHplcU00?=
 =?utf-8?B?c3A3QVlINXdzOHk5dUs5ZHNiWFNjWUY2ZTlDUG10WnFpVmt0N3R3N3FLQUE4?=
 =?utf-8?B?bm5vOUJvSVNEMnIxWk5URnNMZGFsbEtqUktZaWVQcmtJTXVJeDVFRTBnQjU2?=
 =?utf-8?B?cUMwZmErck5MZDNJN28wY0xuSTRWNUZJdUw2YktWbk9NcFNFcTFiVHJ5RHdu?=
 =?utf-8?B?N3dkK0pXR09TMW5POW4za1ZkYlJUdnZRY2FCNWtMdFVWZTdjQ0FHdTllM0xG?=
 =?utf-8?B?UEl4LzJ1ZHhPSGkwL29iYk0yVHpaNkhTem54b3B6RFB1RG5iV2o5RWdMaW9F?=
 =?utf-8?B?MTRQWWFaWjlhekE0TVAzT1lVbXRPZnB5Vm1JVFR1VStMVE54dzk3YmIvbWtp?=
 =?utf-8?B?d3FoRm1oUmhFL1BPV2FtbDFlcnoyME54VDJ6NUJYemY3bHZYRGVveTlJclRH?=
 =?utf-8?B?WkUwU1FSRXhjYTZLeU5ZVnpQaG01K3hDOVc3bjNraTRSVWh6QldwelhQVXBI?=
 =?utf-8?B?Y28xdGY1Ykk5WU1pUW1OMnI5THdNZ29VU0hFRlFHb0RLN2VodmtHMzdTTGtt?=
 =?utf-8?B?Zk9XaHlncVNZN041T3FiYzg2SHQzbjRRN0NMNVVhbkJBc0ZETFlyUjJHUUFJ?=
 =?utf-8?B?Zkw0Q2d4Y2lKeHVLKzRPc1pYNjJBZjdTVEdRT3dURG83aGkyNWladUpCV3Qv?=
 =?utf-8?B?RGRZa3hKSjVmaGFNQUtlcTVDK25PTEkrcU0vQnZFa0xCSnpnVFFXc1A4L0Vh?=
 =?utf-8?B?ekI2cnFaMDNHV21WTkY1ZHVyODhsSG5XVVVVQ3FPSFZsMWtDOG93d0ZpV1dI?=
 =?utf-8?B?N0RjQU9wMDM5dU5jZ1NVK3ZydUdCTVVNQlZXY3daaVpnTW9sV2JxbEZkSXVV?=
 =?utf-8?B?NzdHdkY3WWhsMUJBcHIxdTN0SWVPN1h6b2dWQld1dHBicXR1UUNtQlNFQUh4?=
 =?utf-8?B?UHp0RlhKTGl5RmN3MnRaSkRjWlFWUGlkd2VoZGR6VStGd3JhUGlYQmp6dnE2?=
 =?utf-8?B?cHhMN25yNVRQanlHYXhSRy9EUk04VlRTVnNIUWl3S2JtTzNHb3F4eXRIRGQr?=
 =?utf-8?B?NUtXTy9PeVhycUJDbFVrRmdSVDFJbXAzNUxvQjFpYXo5VWxGN3dGdVZIMlNI?=
 =?utf-8?B?TWN3Z1I3UmhWakhFSDRKczQzQjVVR2hwS1Q5SVZmdDdBaExmaDFTNnBmeDh4?=
 =?utf-8?B?S2F0UjZKcFpzcTg0cHBYbVdoSkFsSEpJa2k5MlJpakVVWktQOTZ1eWFnS051?=
 =?utf-8?Q?CwMgZezK654=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV6bkUrMExvUGpOMWV5NGU2VFdaVDN4K0ZzakJwc1lLLzdYQ24zazZLNmI3?=
 =?utf-8?B?TEtVVzR2T0xpOS9aMnRtaSsyVkFTL1R0UWE1NkZwQlhpT2pQL2VBY01hZGhV?=
 =?utf-8?B?akJOMldvTzVER01KVDdhVTFLM3VXTjRqMTVXcjkvd01xWFdEeFZDZlZBdkxv?=
 =?utf-8?B?ZUpjY3RiS2FocFlaL2laWlQyNDFQM1BUaGpaL2d3ZzJyUWEzeWsrakRnMXNM?=
 =?utf-8?B?cWVMeVBDTmxkYmpoMnU1bmZHdWkwczBza0k4T3Q4T2J0eUVkLzUranYyNjRN?=
 =?utf-8?B?VURhMXpNSmVLRWovN2NIaVNtVDlrcTdsYlByYnBIbHV4LzZ4RkNKeGJUNjJS?=
 =?utf-8?B?enppWmxGNjQwYllDelBKd2FsSFVISC9VRlBvVVEzbTJMMTV0b2JNT2wvMnhN?=
 =?utf-8?B?eCtOeU1EaTRlNDZ1ZURuL3pOVnlFTEs2Q0Vwdm5qeVZrT0hlOGJTOE13T0xi?=
 =?utf-8?B?ZTA5dmxHT0pNbnp2MTZnS0dDV3NzaEdPVDIxZXpvQkl5OGJudGpjYnZmTWFJ?=
 =?utf-8?B?SFNMSTJRcHFJUmxTdE1vZFE5aVJVQUltRnd2SjdXYTZUMmNtbVhEbC9OQzR1?=
 =?utf-8?B?YjB6Mm5RWk1NWit6aldQTUU1bG5vZTgycjVEWUhPMCtnbTcyYU1YeGpPQ05P?=
 =?utf-8?B?OVpxNThjczF6U1kyZXFSd3l1Tmt5ZHlYL2FsMzJGaHpva0N6QTVFd0I4VU9u?=
 =?utf-8?B?WE9EdERkczRnN1oxa0N3dWxoako0VERMWFBOVVE4WXRSMFIzSjh4Ni9IMVV2?=
 =?utf-8?B?bk82WUVqdlZnM2tNMERVaUlrN2tUQ0ppYUZlZHBicVdhdWdZQU1VVFlTcVJB?=
 =?utf-8?B?MUs1bkxVcVlwSUNOMldKZUxkWFNFTC9iNld4b1EyVEIrZGd4SGoxZkh5RkNR?=
 =?utf-8?B?Y0R0eUpMODhtWmYrcDlaUkROQ1ZKS1NkajU0TzdkY3czZ1ovaXc2cFJyTWdG?=
 =?utf-8?B?MGNqM25MSW54d2FwaS82MzMwV2hPVnh3SCtKOU5tTWJkMEJqY0EvZ2cwc2Zs?=
 =?utf-8?B?VldsU2Z2Yk4ySGloNmFqcTRhbU12MGdzVnBBN3NNTStRNTB6R2c0UTZGMlNz?=
 =?utf-8?B?VzJqei8wN0RmZ3UySVlpLzNtZm5XNTJKZnhZbXhnYTI3Vkh4ZTNuTkJkd1Jq?=
 =?utf-8?B?QnVFejZmMmJlRjM1YlBSRVdJc1djazRnQm5Ra0J0YnZBQmtUdFVnY0M3VkND?=
 =?utf-8?B?dnJKTTErMXVldC9CdUJ3RlI3TDNIWnZ5MVNZM09RMFg5ek5YaFhMOENjMy83?=
 =?utf-8?B?U0owcVRiOEdpSlZYMXNGY2NpZVh1V0tnbmxpNzFHR2kyczJaeTdYeEUvaGtn?=
 =?utf-8?B?NEJ2aUlQSFZua2RTWFBqclVyak9GYmFVckM1SjF6ZkVqcklqUzFsd0lva2xw?=
 =?utf-8?B?V09ZN1I5QXVpMFJyb0x6Tk0yMjdJcHIrR1k3b25oRUw1TnBlaEV4Qy9wQ01U?=
 =?utf-8?B?TW5OR09WcW9KelF6V2k4ZDdRRHpRd2hXa2tJcEVoOVhCOE8zaXQ0VzIrZkdk?=
 =?utf-8?B?ZjdOVFFLclBmTU1XcjNtYkJaRlFPWWRNazV2VmhTVHlEdEo0OCs1UVgrT3g1?=
 =?utf-8?B?TlB2NTFmbm9yUVBidjVPTzU2Ujg0NTZuZ0pneXVYMFVyUVExSHFJRG0xSEJD?=
 =?utf-8?B?TXFnT05yakhzSDNxYmE0UE9DOUVlb28zZzhLUUMzaDg4NWJ0OVA3VVJVYTh2?=
 =?utf-8?B?YVh1K0NzN1J1N0prZXZVUFJLOGpwWi9qWUFQc2RHWUFwRENWc1A1bHRHOU1Z?=
 =?utf-8?B?WHhiTVRDMnJRVnM0NzhQZG5uYldsb2NLMHpmYkhVK01CaHlKT2VOTWNxMm5C?=
 =?utf-8?B?ZGZZWk9WcXI4K2JCZUFYREl2a0VpWjNoZ2l1NjIyVys5NEVNYmR3VnNveUl3?=
 =?utf-8?B?T0ZGUnJQSW44ZVdqQVBxanIwam1ldUo4M1VlUGhwNTJCVXZYdWpTSjk5RVA0?=
 =?utf-8?B?SklCZEYzTW9zT09yaGV4TndST3ZuVHhHZ29NR1A2ZmYvM0MyRi9ORWwwaklF?=
 =?utf-8?B?bUpWVjZrdWtkL1pUd0FBLzNtK3BBZ0tBQzViSno1QmpPUVkxK3pFTlNvZ0l3?=
 =?utf-8?B?SXBoa3ZzVXY1dUFkT0FkUno4dWNJb0t5UVFHM09FeU9OcDh6SFZLWllZZDNk?=
 =?utf-8?B?RUZxa2JRMk9sd0dFcWx4QjUwY24ya1FzREpNbDZxdjZFdWg3VTllU3pZNjFK?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6755da7-f0e0-4072-ea80-08dddad393dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:40:41.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdssOokB12DJCQjcbgBTPuPhXaQ9eX9vML//WOA63L1IG1LTFPspF6EVR67etjMZKqcgdXc4IJrSzH/ZV234IOTe5/aIiyULOaqg8mwB9x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 18/7/25 04:33, Dan Williams wrote:
[..]
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..0784cc436dd3
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
[..]
> > +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> > +			     const char *buf, size_t len)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	const struct pci_tsm_ops *ops;
> > +	struct tsm_dev *tsm_dev;
> > +	int rc, id;
> > +
> > +	rc = sscanf(buf, "tsm%d\n", &id);
> 
> Why is id needed here? Are there going to be multiple DSMs per a PCI
> device?

The implementation allows for multiple TSMs per platform [1], and you
acknowledged this earlier [2] (at least the "no globals" bit).

[1]: http://lore.kernel.org/683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch

[2]: http://lore.kernel.org/b281b714-5097-4b3a-9809-7bdcb9e004dc@amd.com

One of the nice properties of multiple tsm_devs is the ability to unit test
host and guest side TSM flows in the same kernel image.

> I am missing the point of tsm_dev. It does not have sysfs nodes (the
> pci_dev parent does)

The resource accounting symlinks for each each IDE stream point to the
tsm_dev, see tsm_ide_stream_register().

> tsm_register() takes attribute_group but what would posibbly go there?

Any vendor specific implementation of commonly named attributes.
Contrast that with vendor specific attributes with vendor specific names
that the vendor specific device publishes.

> certificates/meas/report blobs?

Perhaps. For now, I want to just focus on the mechanics of the getting a
TDI into the run state. The attestation flow is a separate design debate
one there is consensus on getting the TDI up and running.

> The pci_dev struct itself has *tsm now so this child device is not
> that. Hm.

This tsm_dev is not a child device it is the common class representation
of a platform capability that can establish SPDM and optionally IDE.

> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> > +		return rc;
> > +
> > +	if (pdev->tsm)
> > +		return -EBUSY;
> > +
> > +	tsm_dev = find_tsm_dev(id);
> 
> When PCI TSM loads, all it does is add "connect" nodes. And when write
> to "connect" happens, this find_tsm_dev() is expected to find a
> tsm_dev but what is going to add those in the real PCI?

sev_tsm_init() calls tsm_register(). Userspace catches the tsm_dev
KOBJECT_ADD event to run:

echo $TSM_DEV > /sys/bus/pci/devices/$PDEV/tsm/connect

[..]
> imho "echo 0 > connect" is more descriptive than "echo 1 > disconnect", and one less sysfs node.

That makes it a bit too ambiguous for my taste as connect is "connect to
a tsm of the following identifier", so, for example, "is '0' a shorthand
for 'tsm0'?"

...and as I say that I realize disconnect as the same problem.  I will
update disconnect to take the tsm device name just like connect for
symmetry, this ambiguity concern, and in case multiple TSM connections
per device might ever happen way down the road.

[..]
> > +/**
> > + * pci_tsm_constructor() - base 'struct pci_tsm' initialization
> > + * @pdev: The PCI device
> > + * @tsm: context to initialize
> > + * @ops: PCI operations provided by the TSM
> > + */
> > +int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> > +			const struct pci_tsm_ops *ops)
> > +{
> > +	tsm->pdev = pdev;
> > +	tsm->ops = ops;
> 
> These should go down, right before "return 0". Thanks,

Sure, makes sense.

In practice @tsm will be unwound, but might as well not make it a
valid object while it is awaiting to be freed.

