Return-Path: <linux-pci+bounces-35588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93DB46846
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6581A1BC45AE
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC421EF39E;
	Sat,  6 Sep 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h963Y64Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C511EF092
	for <linux-pci@vger.kernel.org>; Sat,  6 Sep 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124447; cv=fail; b=lqQA3f2zhN3G9AEl3XpwmaUJGPV1lh0Ft+HuTiTyKMf7kL8XHdxyUQV6KlZ1ZPPdXNavDetoeRFpz1ZG4CkC3LF+GMZHGnXVrw5I2cdSiC0yT2ejSHCDIfuh5BkGIlWCAXGotoDr2pq12E8Vd6QXO8WTYr0BQCsohUrxHJ49uu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124447; c=relaxed/simple;
	bh=cX3N2iH2DwMJbVUDuXFq1AcN72JuML03lX7xUnlBjBg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dyw0clYqTj+VrU2OJ/dzoRW2THNTu3Bzc2MIzPHdcsCxUfaXwERPyT+yg8Ze35RX1YcA30zizwqW0IbNVMwOHyDMMhtQKnpdCsBBEnZ2Y1yu2zCoy6D/WscyYeZTkovnUNRydEl5c6NHXolmK6Ji90d8ctPf8uxpLRbDfCMlWtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h963Y64Z; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757124446; x=1788660446;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=cX3N2iH2DwMJbVUDuXFq1AcN72JuML03lX7xUnlBjBg=;
  b=h963Y64ZHYRTh3pC26yHvVbPWNqzk5kms57nalw/B9qEQFaqSX/kx9wU
   NnTyJU+9D4z7Z30TObfGlPnf/JWmvLVKBbiLDrJlbyKlel4AqJTSPIsDO
   zUkb9sr4SyQZu2+Z5TTpcyvuOaxlW4zZPB5Q5cMbOJv372FR1RJRsJCkT
   XMDupEexuEZV78TaEu80rlUGfxz1NrlGLNEvtnnpasQL3Tc7UmcGxC3xp
   puU3/inLj+j6ksdvHN+b++kDD5KxjNVoKy9M4uUnWD6ykeDbLX2x4WJsD
   SnQ9+vyQXWKqosAO3vLksYecRgvQEVuro8zwyVbFM8mTwG+zyAt6QtIwg
   A==;
X-CSE-ConnectionGUID: K8Bvw+51R5er24hxIsw0FQ==
X-CSE-MsgGUID: EN2ji2R/Req/hxqAh6+bxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63116181"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="63116181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 19:07:25 -0700
X-CSE-ConnectionGUID: 5tUkSuwaRtqyk4uYGnU64g==
X-CSE-MsgGUID: u3bFi4tPTUqJgJUeUZCwpg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 19:07:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 19:07:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 19:07:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 19:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ+voUqn9lf1zdunP7LZp86PqHNfxYs1Z0FmYa/yUpt6ALzPRjvAr7V6yCv5uwI0lBNlSD1zSXb5BcnZH9d3rH3aa2gWt+AHPhBKZEeZCIz5ZNg2KqaBKMDwkZDqDjCg5otLQ3eqIFUbF00U1r3OK1ykQk56Cy1yYq0IUpD50wZjjvoCKS2Gix+Lkpxc3ps/5Yd4Cihf21znVZ5wIM+0NOND8wLCgS0gxJJQnvWhpR86m+hvCht0HmvNcvQhpCLvOa7nkOXqJ0rtSBC7VyLOifgfQXg8U22AIDUXxpP42bz3OazqHKf1ySfdBuuHwA7hNGWj6vXY5hQwIWT4rdgofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V8TReWA+mHZu4UUuuzp1QdveJv5Xy1IQSc+E0NkZhU=;
 b=FkzlyM309I2RXlhx56vv0EghQsagZd4HiX89qHUb9r10eJaN7HFaa9MSr1VENi+YcqVFhVFrDeaTvRvvAl1F+9GRgg6oA+hZs+A1nOKYmddhbwGTCCp8cikmaIj8gADTYuFU899F6jIgpIpFaytNzy037cnt7b9fOBOw3GfHUeiv7AHapNDWM2OFTaY7UDYgvEpk9Ltt1QMSBRO2l9WL7MOVX3BhTloFNRJK3c5jHfKVEi7KxktAQziUxr/HDlENz9K93tRq8CcHx8BOuWGbwqJh69XOtXWebKwT6N3yA3Fa3SVQXX6b7cLsxHcVKPNBMx+Ypv1f9UPr6HzVRzEDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 02:07:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 02:07:15 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 19:07:13 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
In-Reply-To: <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5a4e2b-449f-4a23-b148-08ddecea1967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWxNSGpxODFjemhBc0Q1bWNxaXN6SzdFaHREYjV5QmVKb1NXeFc3ZGYrcUVS?=
 =?utf-8?B?bzJvRjA5Smo2WitpUmNNYkdGTzd0Yy9wZ2RMZ0haZUM0ZmwwTjBzRzNHTW15?=
 =?utf-8?B?bUJRcFl5ZU1SbFBGWHkwOHZzOE9xL2M4VWFLOHNmd05Ra1hDRUQzMnZubTJU?=
 =?utf-8?B?Y3JEOUF5Sy9vWHl4K3oxR2VzNGd1NFNUbVBJSzdOcFVGNUpna2lET2pGczBE?=
 =?utf-8?B?U2lyVUl2bU50YXp4MWphVkYxWGw4b3RaK1U2NEY3VGdURGwvY1BpL1g0V3FI?=
 =?utf-8?B?dHV0RldqV2ZJdzJRRnFKWjNaSjZteGs3OGIxa2ZHT0w5aUhqbFVWVGduZytI?=
 =?utf-8?B?S29BMEFJa215Y1UwUFAxT2pnQWVVVHUzUUhBWC9JenZDeENjUGM3dnBmSVFI?=
 =?utf-8?B?N1Z2OTJQSTM2bmNrOHpoYlozdXFOekRWRkpPZEtlbmQ5WFcvZE90SjM3bjRZ?=
 =?utf-8?B?aU5YKzRzeGZmQlhRQXRiQ29FOFdEdWpqM0VTYlpUU2dleVlONEtVd0FQSjJC?=
 =?utf-8?B?LzRmS0U1bGkyYU1vYVNXMDB3NjJJTFRha0E0emJzdUlyVzBjcXl0c1FtQlky?=
 =?utf-8?B?bTVTOVE4Q2NvUk1CL2FBWlNGbTNkcU5CMGlpekhYR3BLMEV2T2hBNlBhd2RP?=
 =?utf-8?B?djdtTDMvZTV1SzgyWjg3V0JNUlpoWFdNSmZUbS9LU0xpQm9zZVlPVng1VkZu?=
 =?utf-8?B?dWVnWFlLSytpOGt0MjkwZVdTazNKdzFZeEN0MlpVc0daaWlZemk2RXk1akt4?=
 =?utf-8?B?T3VkaWJ6WEhuaWVKL0lzZlF0MmFGbGtHdE4rcWxaSnFmS2s3RHUwc0pkMTFR?=
 =?utf-8?B?a0JFcHpwVCtjYnVvU3VvUWR1Q29KWmk4NVpLTzN1SHdkb1h0VkFtZWF4R0lG?=
 =?utf-8?B?NWtIRDl0MEZtWUNLN1hzZi9qQ0gxUnF2TTNzTitSUUJ2azV2Yy9JWTVKQXh2?=
 =?utf-8?B?K3VlVVVuaXlhY0NKdmRrZUJvSU5VRk9NcEpGZkRGNS9jNGEyaStRanVoUVNn?=
 =?utf-8?B?eC9vQkF6WnhEMjdDRWR3dEtZN3EzSjJQekZyQVdRK05ZZGxSZzA5bjQ5Tmlh?=
 =?utf-8?B?Uk5jaTdVbTNMWnltdlZkK1VjYUtGaStvN0ZxcUtmbkZUWVp2UytlNEtlNkMr?=
 =?utf-8?B?Znc2cXdrR1FOTVBqNzBMd0FkVFFVUCthSEw2WlJRT01lVDU3TFNNYzUxckxX?=
 =?utf-8?B?dHd0RjlQaWpwWm5UU21pL3MwaHhreTI5MVIrbTFvSHZ4THVJcFo1U0xGeEp6?=
 =?utf-8?B?bWYyQXFJbmhQRjJQSUs2V0tadVRKcjJucHlUU2x5NC9PTENPclJWZENBUExk?=
 =?utf-8?B?VXN4STYrRXRlSGJ4WXV3azJMTGMwYmcydlFTNXQyMjZ0MWIxbldDd3cxQTNC?=
 =?utf-8?B?akl5a2lNWi9FUFFKbmNtbk9SWVZoU1VXQ1ZBcmdTaWp5TEJzQ0RQbWdWaVB0?=
 =?utf-8?B?eTVlUmhPVnlXU1BCcjdtVDA5R0RER3NaZmVtejRka1FaM3REdjlTK1dnRmox?=
 =?utf-8?B?cGV0ZDNyeWo2Zmp1TFZLa1pQRnFaWjhGYWRjdDdTTnBZcG5sK3JHSytqaE5P?=
 =?utf-8?B?Y254L2t5K21kYzJDc29iSkNZTCtDZHNuVytXYlQyNm1zeWs0eFpOQVlyU0VY?=
 =?utf-8?B?U2RpVkc5MjBrN3NvZC9GaHJycGg4RFdZSExvdHRGaExqRlRseHNwbU5FMnpI?=
 =?utf-8?B?Sjk3SklOVVZTcmo1QXRvOHdJT0NpU1ZtYjZoRGxCcE5UODZBei9jcGcrczZU?=
 =?utf-8?B?L3ZEbk1FWkNUNFg2elZRTEM4a2lrd2lPZ0xWSTJNTmhzTDAreURPZGtRTkVN?=
 =?utf-8?B?bUV1R2JNNTFTeDdCVDRqK01iL2d2K1E0SHJLVVVoZjllMmFTMnRwT01rVnRp?=
 =?utf-8?B?ZWVpU3phYWRJemhEVEVraVBOTitGZWhOemtsK3U4ZE5WQ250T2JvUzh5MERP?=
 =?utf-8?Q?ohFXwLmwEfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmMvUUhDdm9vc091NnI5bU5ENVBBQXNTRDVweTdyMU1EcFRLSHpBSStKRGU5?=
 =?utf-8?B?SDlFdm40OE1wNGp4dUhFZmQ3ZTZua3U4bys1cVBxU0ZFSlZLVmVUQjVCaU4r?=
 =?utf-8?B?UGZGY0ttK0c3N2Z4TUl6bldmeGIzUHhLMWNqWXRIVlY0aTFDN3ZTUFlVbUNG?=
 =?utf-8?B?TFNpWENCQUxuYi9wZER4NkZEMXBORmxQaldpdFFkT1BucVVOeERZbmdOS20v?=
 =?utf-8?B?QzJQUUpMTmljZW9NZ3JpNm9LbEpzdm41SGRMeFFETWxWRndaUFcrVC9MNnZB?=
 =?utf-8?B?WldUYmF1S2o2QkNuUDFSbE1NSUlCYzlNL3JQTzk5MDJrSWdCNXo4MU1XS2Ny?=
 =?utf-8?B?TVVqYW1FMXY1eGV3TkZWZWRCSUZRMVVmNTMyRmlsM2s4VlVCWXJtQmsxSjVR?=
 =?utf-8?B?Uml6UXhBRVUwS2lzbVo4NmlqQVJyajlRMVlCaDhkOWc4dXpMMnFWNi9peGR4?=
 =?utf-8?B?cnREWU9jQSt3bm1KWWljZDJsbzlwOEZOZEJOTmlCV2xxc3ptalNDSUV4cSs2?=
 =?utf-8?B?MDY1UGllYTVOMlpnNWo0Nk9hbXROTmZ1cWlLRVNmWEZNQTB0OHVCbE1QUlZL?=
 =?utf-8?B?QnZwUjV1bzN0WUwreEE0TDY4RWpqVEhMQ1ZubVhzZEFzUTArSUxJSTlyTTRH?=
 =?utf-8?B?SWhXV0puU3Z2NGx5V1BDc2NNN3JlbDZRMklQZjFjYXlVUmRzRVRrNzllaFU1?=
 =?utf-8?B?cE1OOXMwL2VZZjJ4NEExdEE2T0NJL0NObEFYa01QWVg2MEtIclVDdDAxL3lB?=
 =?utf-8?B?ZDg3MjBFUTBuK1RMVlJiYWJtb0ZPcEhyYTE5UjROYjhieW84K2tpQXh1eW5T?=
 =?utf-8?B?Uzd2OGZGVmJsK01iemM3bkdwUHdPczR2SUpTdStLN3RoVjV5cWFSUjB0NlRE?=
 =?utf-8?B?UUVjS1UybXAyaHdqMXBYOGJQbjFLVHNWMHpBTEdhVk1qbkJEZWd2MTRwSVZl?=
 =?utf-8?B?UmFUSHJSMGFtR3dGY0FEOG1RL0I0MC9RM2thZFRYam14cVZoSmZ5c0JMcDJZ?=
 =?utf-8?B?WE1LVkR1LzVuditVeU4rdFFxNDNzaW9SWDg4eUlSc28yaVNLS3ZSekpNUWRj?=
 =?utf-8?B?ZUN4MWxDUThzYkt6UDEvTnRKYndXSk9xSHJXVzhjcGMrV0wzeGMxbDM2NERZ?=
 =?utf-8?B?QkVzbjYwSmhqaUNyQ1RnanMwWSsrbTB3YWxrVFVIVXMzNmtxNzYzaUJwOGox?=
 =?utf-8?B?VVJqdVJqQ0RMWG1MdTE3ZnV2amgrSVgwUUsvbnlEUTJtUUlLc09kWnNLOXRN?=
 =?utf-8?B?V0ZEV0xqcThFZXA2cTZmbVBPTTlaWVErd0tDc0h0Q1FxbWM2N0FBdHBGWmdZ?=
 =?utf-8?B?YlFGQ1RGbkJqbjZHUXVIZWpQZnUvV3p0bzZJNHJ1Rk11Y0hObkxKZGVVZWp4?=
 =?utf-8?B?SmM5aHJtaGtKczgyQjRzNmRGVFFkZEdydzJ1UUI1SlpBTnpLbHJhR2dCWUhk?=
 =?utf-8?B?ZTdZb240eVV4cmxiWlY5VW5IVFhEKzBHbnMwck85ajhiRVIxZ2lVYmZvcEFF?=
 =?utf-8?B?QnMxeUVEeHpuRVRKdlNldnRFZU5uc2lkSXRmZWErZXIvMEVQeHU4RENiL0h6?=
 =?utf-8?B?YXI2cVJoWDRESkk1cG9sajhlekFOSUZ0bkorbDR5TW5rTkY2dzZjcmtiQU9T?=
 =?utf-8?B?cjFYdkhram94QmtkTDVUNG5oSW0xbXFqYXZMMmxZYVRVRkVTbE5SYkQ1V3dT?=
 =?utf-8?B?NGs2SUNXMm53R1BlaDBDYllYdEthUW1nZFlqaWFNMEcrVG5iNUJIMW5NbFp4?=
 =?utf-8?B?OFBScHpHVVBJU3E2Zm0wQm9Td1hMWHN6elpsOUJ3TXNZUTlWU0FEY2kvdVc1?=
 =?utf-8?B?Q1l6b1ROV2NoV2RuTUs1aXFIYVVMNnVoUTZnYkFFT1BWU2kybDF1cDlheVly?=
 =?utf-8?B?ZGdiTUg5Q2VBRG9oY25SK0dUWC9FNHlublgzckkvbDROZUc0UU5xcmVhWDVO?=
 =?utf-8?B?L0RKc2tySVF5MUQzMm1VWUdZU285SHYxbVU4Qk1VbTZNVnZVbGx2N2l0bHFw?=
 =?utf-8?B?VUtjYXJXckZiUDNoR0xWQ0txcllZSWRmTjhNTGZVRmhDRE1pemtGRHNXNWg3?=
 =?utf-8?B?UDlhSFpTV1JvRjlJTWViY1Z0SjN6bmdON2dQWHJqUGF4b3J0aURpWnBpYVQz?=
 =?utf-8?B?TnlLU3pXOUhUNjlHU3hzbHdYZzUyemNHKzlRcVphVzZqNVdSQ0h0QXVkRWMv?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5a4e2b-449f-4a23-b148-08ddecea1967
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 02:07:15.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbYZm7QF01d3s1LkRkJQ9LuluBSfCzsijzftcNKJmQopyxb8Qn8Sem9r6t0xRMHrEPeLSIZPcoafLfIzhXGH0lmjlrLImqqWX1k9wiEJN5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > TDISP without IDE still needs to do all of SPDM (Component Measurement and
> > Authentication),
> 
> Support for PCI_DOE_FEATURE_CMA_SPDM says that then.

Right, the TSM core looks for that (PCI_DOE_PROTO_CMA) as part of
connect because it needs that either for TDISP or IDE.

> >and the TDISP state machine.
> 
> I'd think PCI_EXP_DEVCAP_TEE is set on something which allows
> START_INTERFACE_REQUEST and some SRIOV devices may not want to allow
> this on PF0. I am likely to be wrong here then. Hm.

PCI_EXP_DEVCAP_TEE is the only way to identify TDISP capable devices in
the guest, right? So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
or a guest-side TSM tunnel to a DSM, that can affect the TDISP state of
this function.

