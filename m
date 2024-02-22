Return-Path: <linux-pci+bounces-3893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3F860555
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA111F219A9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA873F22;
	Thu, 22 Feb 2024 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8WrAset"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56996AFB5;
	Thu, 22 Feb 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639406; cv=fail; b=igGGOxYieOpVVBxOvMVSwLp5r0W4jV2kh+SNZypAqRCAKQWGu3RKvZsJTZuGUoLc/xL1aGascIVmbkE8FQoKKZo/ym16ruDw1i42W1aaclRHmEnggx81pvUOMoz4EhzJPtT2ZeLrlouswV6CvcOKW784uICEs6SsYNkv7FvjWYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639406; c=relaxed/simple;
	bh=DqX2bv6k4NGko7hWnu+sDUgTZRpqtRkyJTKfRMDE6vs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjOYyXR9iYfg+Lwclg5BOkhOyCltsOWzoOGDkVTbAMlbmEsEmXBZ0b83GXZ8J4bM2stYiKJ9+EBNiy+WKZbM5fqX/b3PJhWrzEJ9gq6IIP126zEFdOsRK/GWWQ87awLDYWF3ZUC43FCnt0dE6TrqBAt3g4dG3W4PEtJEX2M2N2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8WrAset; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708639405; x=1740175405;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DqX2bv6k4NGko7hWnu+sDUgTZRpqtRkyJTKfRMDE6vs=;
  b=T8WrAsetwVhsfOXBNF5bzdlv74/tWfcnon08CO3ts2zOJt4H1gRQpKM5
   I4Rldt2cL3xPp52cp7QBCdAMsVY/P8t0Hlb/J1PHUndYmvXj36espeJKw
   3dhfYT1VEIQEHI0XYawrHCowv+1XuJkx/b2erTXizwnbUrH502O3mgCf9
   nlh3JGcMkqxKmryNI2uaU3Uny6nKSRjPnUJW6smVbgvTZvPEM+7KglsUt
   VYjxLwesRcn7HzZZ51QPaKIlj9e86zjY43ki/ZxvSHqi8F7uQENEzFaRe
   GoMy8Hm9N3W0sWTQvpY8iaLLSo35HWQSWScL3BHSfHtzbOSKc6cwwYiZZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3061002"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3061002"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 14:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28776865"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 14:03:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 14:03:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 14:03:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 14:03:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBs+Q8ChEUt6VHNiZdJGmEzcfTYDHelrIV2qK2Se70G3kSEXvul5fX8rMNsOB/xoFYrn2iNnRbEmqfvK22atq9BbRV79Q4UcF5VQf2o6f9H1j1tipo3y49kHT5JhM7W+7Vr7BZqDv0BCkAgbTT1ac+r74Tv2EuTjcdRKO69+VmWW+tY9nVH1wjCID8nGc1dGFXdJJOrHRUwzs5rDhrouOIV8TMoT3bgmjqFqVB+SkDUJxT+bl19EU/nN4oGIW/PwqFPIEBv6hVYUij1+s3zDPfEhTFRWzC+zqyV09YtQXObjYeE7D1qDQfJfDjyJ4v67hryqv1O7tbMc+j3YauOR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0ctWq+92067oyQs1Bt+2HOhuTeZAuVZTAcYSftgA0o=;
 b=O4zxHuQskICTI/jS8qp9FqJ3FSV7wfFK4ErJWGCCvn4QPcVKfcDwiX4Km+DAdehj60EsV+wBhOIbZ+zSUG+ix+wHW+bgXbioO/KtNZdsZNI9cmCOVY1c3+gXe6xfdV22TsDZ5xb27OBpq2I/XgKUwxwyU9+voK6yPGOd4E1qFbOI178eBpJzP3ud8ebUo3fB56BIp4hpeiQOdZqHNOP/K0IMZEAqhXLDYeJ48Mn+/aoL/t5A1EeBwawVTlSiSlxdhASVDAcS5ZNw15w79UQvcP4dETiytk7ylc1kdJ/6ryhsq5mFlqYaLflyiEQ0TAtIEqMgPzvgcPJtBm1H5dGxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Thu, 22 Feb
 2024 22:03:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 22:03:15 +0000
Date: Thu, 22 Feb 2024 14:03:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Marc Herbert
	<marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
Message-ID: <65d7c4a17f351_ca001294e8@dwillia2-xfh.jf.intel.com.notmuch>
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0hmD+7iSKKexpUccvMUtjNpd9fHo3vRrshD_s=rb5Vq_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hmD+7iSKKexpUccvMUtjNpd9fHo3vRrshD_s=rb5Vq_w@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d958e02-b7a6-4f92-8bb7-08dc33f211f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUrBXif6w0B9Jy1Zw4p9D4N2ZaNhGgQBAXcND8aBISpWo3N3uA/HHd9LuP/5rCdELrJlYQ3o6LvBcroYGy84Mfgf4giTJ7nKhVNGGK1xNq/3cp+AXjtiE+vMCDnkqvFux1djEqZO/yZYiQy3CijKMSKNgL2gRzum3NygxFUsfwnt6yLM2XG7R0deI5K62vj+MV4aKJjAaKmiQMWi+Cp3nz4B1sw4VsDhkLD+DIE0n6qYqcI12QPwC5TntYlexXiZnJbQFjzBf3itcJ+QBZCy/AElR35fFkI4NzNbXnaD9KrUHglWB/rnx+HPr6F9vYTa2Fpq9sqmNmH+yD/uePuI0rxJz/ciNuwG6xlDFmYr84Xny2InWJ9yeIWvJTiPxjLSmBPca6kFcFzWz5G4xc8PX/Yz8xsvjNELkvtcPMhtyffzeNn2YFRw+sJTb3chdAOpOEI7Kx8X+HPaJUGCfuuNhJN8Q23d+4GSz8u9sUN4Igyofy3ktn2TKcAgp3dua38NcDUkjJrk4D28m5gYRSuPjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZXNkhxVXVLdUlqUThNNmJKYTRCdGtwcExHSDJ0bVcxOGNRQkg4NkVvVkZX?=
 =?utf-8?B?Rk9ZN0w4ek5xZ0xHTlkwSFo2ckFneDJBZ3dyc29VRVRLMVdyZThQNERDODhK?=
 =?utf-8?B?NFd6SjVVQm9KNERzbDhmb3YvMFhJeC9ZcTFaUThtaTRpaUUxellzdkFCYnBD?=
 =?utf-8?B?alB4RjBuTHkxNG9MaEEraFVrcDBlWllQbU9BVDZBWXF3TEROUDE5Wm5SNjln?=
 =?utf-8?B?bi83Z25qNFk3NzhOZDdOSVh5RTJENDM1aVNCYjc3WVVSbWhBazkveUhRNWtU?=
 =?utf-8?B?M2JKK1k2WDVtWXZHOG5rZkdvQjJtc2pKYkNtS3lWcUpvWkxSVzJKVmwzZXZ0?=
 =?utf-8?B?NktLdEpVUmE5dnpoWWhMLy9kL0JhRUZ6N0ZPZENhV1BFVWozc0lJaUdTVjZu?=
 =?utf-8?B?Y2tIQ0RnU3ZaeDB2eWxZd0tYb3ZGWHZLNUxvU2J5emQrYXBoeWFveEFLV0F0?=
 =?utf-8?B?clpPdllWUVpPb1J5MTlLZW5SU0JkbDB6dFpzS2YwRjg0YUJvWUwvWElpNWlh?=
 =?utf-8?B?Q3N3d2IrT1ZFOUtjMUd0MFE0bWdVeVRLOWczWEFVQ3E2MmNxRlhDY2t6aU1D?=
 =?utf-8?B?Zkl4U0cxY0tpYUZWVDRVUUlPMFFNOGtYeW1CaTVlblZmMTNpT21JR3RRSjRm?=
 =?utf-8?B?Yml3MTJrb3pVamtxUDVGQi93WTk4K1F1RHVhTnRyK1FMNUlDQndTamtKNmNV?=
 =?utf-8?B?NGVPTXhFUHcrKzRHYXVNNG1Od3YyUGlSNVFWdkhHYlh5UXRFWitndDJ4cHdu?=
 =?utf-8?B?bXJpekVPaE9tUmMycGR5SmdJSWd1Wjg5TSszdnhXbmRvZkhSRzVkZVBpYmsx?=
 =?utf-8?B?QkJGb2JsajMxdzEyK1VwdnkwOHVSVTdjSGVPOWlXNStyNFBNWUpwdTIrRmZU?=
 =?utf-8?B?SmdyRmdLYk5sbE0yRlN4UzdGTE1JNytqQ0pJTERLVjBLNWZBc1lFd0ZwZXpE?=
 =?utf-8?B?SWh0Ylg1VEh0Y2RsOWRwTTRuc05FNHlnVE9VMFkvNXlzUHVockJCcmwwMHVh?=
 =?utf-8?B?Z1B1UjluZDN1TUlOTmVXakJEVVB5V3ZQRU42OEpBMmRxWVFibGkwY3luOG5a?=
 =?utf-8?B?YzV5UmMyb3FsV3VVVnNkKy91Tkx5dytmczhhZ2lhQ0I3RmFKSXpld0dmY2w0?=
 =?utf-8?B?WmJLM2lyNXlhVEM5QlNTMjh0U2ZYaHViekQ4MFVVSHBLS2VzT0c0UHNIdkxl?=
 =?utf-8?B?N2JlLzZCSmMxcnFZNjBVaHUwa3JvVUFIUlRPY2tQUldvdzM1cE11WmdBU1Bs?=
 =?utf-8?B?YWZvWFlBVUkvcVB3elYrc21INkR4Q1JHa05ZaDFrRlVJd2xTRG1ST0pybnQz?=
 =?utf-8?B?QWtzTTJrYXFpWVNPck5kZ2FoTzJvZndNbEJ1OGZvZWc1K2lyWFZHalNxOExX?=
 =?utf-8?B?NWNqTHNPZThYSlFrWHFZcWNzYmFRY0EyOHM4M3ZtYld6ckl1cmRGa0VOeVBx?=
 =?utf-8?B?NVF5TmR6VTMxby8vTzRzM2pkK3B5SnI4WHdYb1ZNQWk3TkZaRitGMkEyZTNV?=
 =?utf-8?B?QWtpcXpUUDhaRFg1SW1OUWZoTTZXcGxWS3pYQkVCdDFhNDhzUFNOaERaOWtM?=
 =?utf-8?B?Q2tCajdjNkNCNFRBbGpjc2cyWHBMVlBwK01SdkZacDhxMWJVTDRkME5JRFEx?=
 =?utf-8?B?R0htbEoxR3kwNGtZVlhFWTBBbVBlVU9yOTBzb0pCaDJvY2tPOGJUdWE1bFJv?=
 =?utf-8?B?MUJZd2xlbmhhSk9ma2pndW14L293Qld2YmxGWEZYTkx4QVJrbXVCb1pxdW9q?=
 =?utf-8?B?a2NFSEwyTHV2K2k5VEEwM3dWaDdyZkNQV25ZZW1wMU9vUW0wVEJWTW96Ym11?=
 =?utf-8?B?S24zMWJLcU10b0pXdUxLcldXQU1tTkMxOWlTOXEycE9VTldmL1NtdFlVaXFQ?=
 =?utf-8?B?N0gzcS90eFJIaHF6b25QcTU4OFZEcDFKanBBTDA2TExRbFp5MGxGMkVGTTVU?=
 =?utf-8?B?bHFrVEkyRDlLZGFzTzRLbW90a2xIS1dnTE8wSVl3TElPamg4YTZieHp6MVNY?=
 =?utf-8?B?a0lLNmhHVEdKS3lQU3NwRUhaVy93TldZUTJ6T3dnUXAyMzNKMWhrejZ4UUlV?=
 =?utf-8?B?Yk1CMlhRdGdwYmhKczQzSkVIMTJsWkdYSDMvSEZ2UE1TQmJyc08yTW5pUWcv?=
 =?utf-8?B?WkU2akltNTFRK1Q1V24zQVdnVVc5MG0vN3cxVnFBcmg2aEt6QnhtRFcyY3Bx?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d958e02-b7a6-4f92-8bb7-08dc33f211f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 22:03:15.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nitWXAvOupNbvTPBZ4fLBzCMMgYnfFfCugYrlBe3XmL5JYtib5rxLw4lt4kAIFbRTVVa6KX7Cp81vu5YMcKcrhyEi6gMEs/m3emn0/jDKgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Thu, Feb 22, 2024 at 9:40 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > It turns out that arch/x86/events/intel/core.c makes use of "empty"
> > attributes.
> >
> >         static struct attribute *empty_attrs;
> >
> >         __init int intel_pmu_init(void)
> >         {
> >                 struct attribute **extra_skl_attr = &empty_attrs;
> >                 struct attribute **extra_attr = &empty_attrs;
> >                 struct attribute **td_attr    = &empty_attrs;
> >                 struct attribute **mem_attr   = &empty_attrs;
> >                 struct attribute **tsx_attr   = &empty_attrs;
> >                 ...
> >
> > That breaks the assumption __first_visible() that expects that if
> > grp->attrs is set then grp->attrs[0] must also be set and results in
> > backtraces like:
> >
> >     BUG: kernel NULL pointer dereference, address: 00rnel mode
> >     #PF: error_code(0x0000) - not-present ] PREEMPT SMP NOPTI
> >     CPU: 1 PID: 1 Comm: swapper/IP: 0010:exra_is_visible+0x14/0x20
> >      ? exc_page_fault+0x68/0x190
> >      internal_create_groups+0x42/0xa0
> >      pmu_dev_alloc+0xc0/0xe0
> >      perf_event_sysfs_init+0x580000000000 ]---
> >     RIP: 0010:exra_is_visible+0x14/0
> >
> > Check for non-empty attributes array before calling is_visible().
> >
> > Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Closes: https://github.com/thesofproject/linux/pull/4799#issuecomment-1958537212
> > Fixes: 70317fd24b41 ("sysfs: Introduce a mechanism to hide static attribute_groups")
> 
> This is not in the mainline, so linux-next I suppose?

...or at least it will be shortly. Greg notified that it is currently in
driver-core-next:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=70317fd24b41

