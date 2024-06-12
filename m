Return-Path: <linux-pci+bounces-8694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21C905DFE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87B81C22131
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB082488;
	Wed, 12 Jun 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH8TEM/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29EC31A67
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229171; cv=fail; b=Qzs/wonUZ+Knw4QZFqXfnJjO9bYIu+/cI5tTUCuLDay1flcV9+uwmvMWCKeJHQ54tHD7ImNNOq/QkaljyYRSqsTy5WNqk6/0q3Tis6Ne7z2jwWEF7NseC6104gcZhfS52D/J3S7MU52W5OX2W4qNXQSse80Gi25o1wy4wPpr5yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229171; c=relaxed/simple;
	bh=L8rw8IdKz86hKJZniGHV4VwoX7VRQBI1+aMzaNqC/pE=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fto+FpivJZtbyMS2BnqqlHbTAQkpnlQVWrI65/js1pHEky2JGTjgYxfr77ZyRxYwSD2kIh3VYrbgpUaUQG8V9cKb2GZrCQW13g1a4az9ydkzvLBVQoyEKVs+VaMzuz8ZEzr+icyk5SsUB26hBLO3AxVZD3qEawhuAyQ/SnkTkbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH8TEM/Y; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718229170; x=1749765170;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L8rw8IdKz86hKJZniGHV4VwoX7VRQBI1+aMzaNqC/pE=;
  b=YH8TEM/YM+lqXOoK1h84WJucQ0ZQZh6AF5osJP+8Gc7DVQ6XGZ/vGAON
   sPFoNox6Vd4hTyBcgKMJoO5AiiZb/FmIdb04kQ3u45isbDA2wn/qDXMYj
   PQAmAqtJ3MPVI4gC1NwrzcJa5gY42jDMl/ANAKdOlxBWApfymsnFT8YdG
   Id2M/HGHM6JLc0OsZq1nu2Bs+LytAeqGKOPKzOKmumMD+P98Wop5xjsPU
   GDWEaXOygaZJicWBD5kyhvXN2UvRRGz4F3e6mc+BPjDjPHYZZA8aa2YPi
   xvN5P6HHDG/MPP2GI2iLXvWrSyi9nHxVW5dQOoq2R1kW4W8FG1C4tU270
   A==;
X-CSE-ConnectionGUID: EDd4N1UQT6Om4Fkcbl2rig==
X-CSE-MsgGUID: X0opAncES7KIaFobahUKCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14985375"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14985375"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:52:45 -0700
X-CSE-ConnectionGUID: 9rIu1FycTMeqAOYa5er5kw==
X-CSE-MsgGUID: l1eIhrHvSCOlNGSWzL+t0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39989653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 14:52:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 14:52:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 14:52:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 14:52:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 14:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLJDL9nIDTypTdeasRkgVpYH01qjf8KmfWkBrP0ZogQS0ss7nJfKFCz2f1TPG31LW7f88BUzoSzJwGw31GXoK8fXPGVNArd8ez+U7J2Qaq8+WrxKiGoF0x6U1URgQe3BAs3L1fe8bTP9i/gq9N4lmL8Cbc/IKFCYXd5KUdp434ov8bPqOGjsI/wLsSGerGqsNTURtUT8r7qeVA4km0ztRuUiofqtrrK99OW3V/pbXLPZYTHQl05h4z4s9kqkNSicAQt7Id5DesKAqszkbKWAJStA/XDi7QOQFiDRGDvo1H26sLeUmz7GGdhDNorOyb702U5Lr7rrFGXOEEiU2OnQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a1myk8vnoMjfTc/NACz7tu47KYsLiSH7f9NDaFs6vE=;
 b=ZEH8sdv3uJvisn9MS8Krth9+mbiLGHhyqOy3hQlSka7/0CKiWd6lqnxleO8Hdr69vjJx2u9ESwBjp5lTWx1OIvPgUI2+5DgnvcpCV20HqKIr12Pk8M0W2Fbw67T8FRStHdnYgBQAKw7ygcnG68QzdU2PSa5S8c6rB6/YArPlKAbSaMLrFjRZpsaZgZPeEkoPGL3gAGCLYDOITMEkiVRg1AxfDb9tzE3ftElw+wUAq3Eq3cwDDFZ0lCr0iFAM7IBIYTzP4rKlsTfbrWnL7+OYbecCvyGLYBd0P+PYFnErrIdxHhp5qUqEEcCW2JJCJm/PtgeIvyZFud4aKgpHz5h52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 21:52:40 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 21:52:40 +0000
Message-ID: <de0260ed-dfc0-47d4-a8d0-806bbe7b1e4b@intel.com>
Date: Wed, 12 Jun 2024 14:52:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240426213631.GA594688@bhelgaas>
 <9e2feef5-b088-49a6-959e-64c6d02faced@intel.com>
Content-Language: en-US
In-Reply-To: <9e2feef5-b088-49a6-959e-64c6d02faced@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:a03:100::23) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e21cfa-bd5c-491c-6e9c-08dc8b29fb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVczOFI1aHh1RktuQ1cxQ1pidnlZaFVQc1AzdXV6VjhKeGF4WFhNMkZhMkU3?=
 =?utf-8?B?di9RM25jcE8rcno0MmtidnBFTWFTeUJnS0w0dWlWaU9Lc2lPam44eXhraU9t?=
 =?utf-8?B?NExZRzgxMEMyZ2xweFNIcGU2RlNsT0luUDVrZk56N01iUlp1RmtGdHZOTnY0?=
 =?utf-8?B?L0ZsaHNOT0QwTnZYY0xZZll5Y21ZUXJlclJaL3FRQ1d4Qk9Jb25UYXg4bUFQ?=
 =?utf-8?B?Ymw5VFd6S3VUKzJyRGpXbFBoNjhtZDhZdC9LOStzc1UxbGh6Y1RVTUszajB1?=
 =?utf-8?B?bW5MZENiejg2N09OR2NKS1BLOVNNOCtBWk5kd1l0T05LZS9EU1NjeFpLR0ly?=
 =?utf-8?B?M3R5emlKdGFlcmxRSXNzRk50RVhORFl1L2xQSVdkamZML2hBUnJtRzVUTy8v?=
 =?utf-8?B?YzR3dkt3UTEwd0QrZm9JNnNGZjhHT1FYN0pHOVk1a09ZVW8wWk9MOHZ3eHo3?=
 =?utf-8?B?aFIxYmVIaC80ZWNFU3V2TUxPbktrNDFyMEpLY2JtcnlpQnNPRXFvUXBWblNn?=
 =?utf-8?B?WUxMUTMwVVpUZDIycW1lN3gxTEM4WCtuQkMzWGc5YVBWWHl5dWw1a3NNcVZu?=
 =?utf-8?B?eVhuajlTK21aR21LcHEvWG80cFByOU1DM3VIbDFiRU9YVXdURWlBUS83VXF3?=
 =?utf-8?B?TWdiZE81OGFjOXF3eHRHL2dYSkVRdUU5ek9yTS9UbmJNMkMreVY1cG9iYmw0?=
 =?utf-8?B?ejkxN3NvV0lFVjhneE5NWWg1U2U0NXRnb1dBRUZkR1MxQ3ZqcWJ6V2R5Sytw?=
 =?utf-8?B?ZDJvS3doWU9QakJpdEo1VlNha0RhR0RET3VkY1lQbHh5azFxbDBmdU0xakEr?=
 =?utf-8?B?eWpqL1FzYkd0Y0trb3VsTVJJTVRHOVpxOVRUWXdOdUJiUjAxaWxTVFlxMGc1?=
 =?utf-8?B?QkRJRG9hU0pWcUJHR0Z3c29DZzZIOUxwVmZkd3RNWktwRVByK2FQZmkxY0Ja?=
 =?utf-8?B?OHVqbUlUT1FNeW8zc254WmM3M3BmUWxtcWRhaHd5M2R0S1ZXUGtSVzdiOUt3?=
 =?utf-8?B?MDgrRllTaldZMUNJbzNWSWpTVFRKckF2TGs0Sit5cXA1ekZFZkZaVGtjZGRS?=
 =?utf-8?B?c3ltVW9VU1loWXNvN0E5SXdrN0t0NHBYNGxGS1lWY2E4SklzUGhhdkYrd3kx?=
 =?utf-8?B?eENLL0twOFRuTG5vQ1lBWmVHUkJ0Q2llZUxydDk4LzVGc3FZRk5qT0QyMXpM?=
 =?utf-8?B?UnFURlN2dnkzUmZIVzRxeDhCeVh6dk50UUFjNlErQ0YvTEVzRjcwT0lxUWFE?=
 =?utf-8?B?M3Y4RzMwanJMUHVkZHFpbGZyZVN0NXhBellOMm8yUzJwVUl1VDFTSk81ZU5p?=
 =?utf-8?B?dTI0NUwwc29nYlFmSE1zcCtsbEZSNWJCZVkveDV4ZlN3Z2lpdEc1TVhrYngz?=
 =?utf-8?B?d1pFcW45Z2tBMVNEUGpFYjBtZ0QzdjFEem8vbHJScFpQa1NWZHhTaDlLYlRr?=
 =?utf-8?B?WkRkUHorOXJNTm85MEtwM1dlaE1nKzJvcE1JUDVMcjEwRWd6a3ZpaTFIdDVP?=
 =?utf-8?B?Wmk2RXkyVi9yYWJtMlRFUVpTaUw2a2xudmlpUHdwclZrMGE0V0VTNXl0UXJJ?=
 =?utf-8?B?alNXUUgvc1pMTW9XT3c1eFM5Z3N0WkMrMXAvaDArRWpEbVlXUlo1S0VNWElo?=
 =?utf-8?B?TnFzR0pFc2VleWlaTXNXdDRnUGduOWxTemFNOGRVdlJXWVlWSXMvaUF4Ykh2?=
 =?utf-8?B?RHlFSnVTamdaakVTZXp2ODducG1idklYZFF4bXRqZk1KTi9DZnkrNFJEOTVk?=
 =?utf-8?Q?pNzluMskLuW20BleP/tLyc0GnwNZ+/F1NTsm4CW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk04SlpXZ1p2OEY2Y21DTkZLNVR5NzJueW1UeWJxZ2VMM29FdVhyUHlQbUIy?=
 =?utf-8?B?Tk5xeW5rdC9KL3l2Q0dVNGNjaWRLWVRMTEJ1b3drS2dZMUN4eUgvZlpBWTNC?=
 =?utf-8?B?dzcxNGxXUndqQUVNb1M0Zm5QUTIzRDZ5ai9QeDM2RWFpSWpsa1FLNTRpUnRM?=
 =?utf-8?B?dlBzRklkbTFSV0k5bmlRQjdxMExvVStFNmZjYVR6bW1ST3laY1c2cys1cngr?=
 =?utf-8?B?R25pOGJjMlpiaFBPY1hTSVFybnNyUmZEWDVaNTV0ZUVzbzNCeGZCZ1gxaDJX?=
 =?utf-8?B?S25BVGsraFZXWk1zT3VUeUFCWldNUDdSUmVSTGZWc0hFbDNZVDZWUE0xbWti?=
 =?utf-8?B?SXJIK3dHd08wbUFFZlBwMWpOWklZK2ZXeEt3ZlFTbm51emI0bjhOR1JSOVdB?=
 =?utf-8?B?OFZnRHVrNlovb1RYZTNwUmpZd2h6d1lSK0pOY2VXcWt4blpjK1pSUnc1ZWRQ?=
 =?utf-8?B?VnNqQ1F5OFhMR3puT2ZZR2pqdWxUaFFlZVI1S01xR3k5VnZGMVgvdVBJTnpx?=
 =?utf-8?B?S1VCUWRCOHBlUkZIOEJGZmJzdml6Um1ZNUg3bk84aXh1LzI3TnRSbEJDbkti?=
 =?utf-8?B?SGhVcHRoZmNFcEl1RXVDZlRTNWp1L3pkVW80TVV2U2drUkZDSXE3R01MOFVS?=
 =?utf-8?B?dDh0aFdkVUVkVFhmbDRWMmI2VmJlMnp6dlNyblhmR0xERVIwOGNGLzFPcGlR?=
 =?utf-8?B?cjJqUjNoUkhSNTU2UHcrNVVxd1BBNmVvdWJHUU04UXg0TmszMmp3V0ZhV0Ew?=
 =?utf-8?B?anVvd0duOGdzQ0JYemxYUXpRT3pYYXkrZXNTRk0xLzVPRjduaGF5Y0RVRTNn?=
 =?utf-8?B?SDBWYXBkOVZlL0cxSDhORGZCWGZNWUJXN1ZiRFUya0ZtaXhGSEZickxGRVhi?=
 =?utf-8?B?c0JCMzd5WllPWHUySWgxemFMUGkzallqc1hhQWdreTJJQVFXczJKUkYxR0h1?=
 =?utf-8?B?Ty8ybkZ2VzZIOWIya3l2TVdqdDNscGd1N0V5RTlLNG9SMDBOK2U4ZlRvRGE1?=
 =?utf-8?B?UzRvRVBSbENsQkhFYWp6eUlPNG1hNFRsT0RiSmFrRHY3VHZqV254RC9seHRx?=
 =?utf-8?B?N2dCdDdZK01QamVTaDR1SGNiQXVRZWlIcXA1bnRMbGpxYmV3ckdpRlRpVm1x?=
 =?utf-8?B?WXBWZFowcUFQYlJwRUtOUmN0NFJVVjVSbUxiN2QxVC9nSEVmK0hpWWlXd2Ey?=
 =?utf-8?B?Rm14V2dBSjlWenJHVkcvbEF0VE5iY21FODI1anBTckdPcUdQSnM0SEpjWjZY?=
 =?utf-8?B?QWlZcWs5akR3TG9yYUI3SjdsYUp3elFUN2xYUmREcFh3Szl2TGN5bk5JaUkr?=
 =?utf-8?B?a0pFSkVseEUrMnd4bkdDWW9Nb0N4R0ZvYTQvV2J0cWFaVE1lOHN5VDJZck8y?=
 =?utf-8?B?ME5FalQ3NHhYK1J1U0t0MXUrcUw0VHJDdksrT3IvS25zeW5DMkhrTVpmR0ZD?=
 =?utf-8?B?dlFQaS9OWklOK1dENG5vdlVoZ3RsNXFqT2hTNXVvZ1JzTllad3grVkpqYkVU?=
 =?utf-8?B?ZHUyMFdCQzd3QlVFbWRjMTB0WnFvZXA3bUhjbE4zdTliMjBlNUNXMm1zczhS?=
 =?utf-8?B?aThSbkVlSkZLdFRLcXV5Skl2eGErQ1U4SStLeVRjRVVoalplUEZYamo3U2cy?=
 =?utf-8?B?SzlBbkUyWkk4ZkZmMkdQRVRiY0g3MERyM2tzeFdzcU1yUTJybXpBQk1mekll?=
 =?utf-8?B?WEFXTnhaWVZWME9xMGFERG1VN2xPeEpkdUFrYlNmQ3hFMzNVbUtSMGxwblk5?=
 =?utf-8?B?QVNXVkpHS3hxbmJ4bU5GMVloRE5VYTd4OGpLMWN4Z2Y5REl0U2x6WkhOM3Zh?=
 =?utf-8?B?V056OWxZNDJudEFnNUV2N05sdDgwYkszSVM0OWQ2VHcxMWwvSWV6Zm1Vb3F4?=
 =?utf-8?B?aThVWStreDNBclk3MGRyV0ppY0tzUGR2QlV4MXBaOUdSY2pRNDVkVWpOUDRU?=
 =?utf-8?B?WjZZZFMrVmdPc1U2TVNmeGJKQkFXeGhZNTRESk4zUUJEWTNHdW1ieUs1WDh6?=
 =?utf-8?B?ZEEvOVh0cWdVV1h6TjZsV2tycWM2QVhQVENMNWtzd3pmQnJLc1hHd1doNHlw?=
 =?utf-8?B?RWpTckppOXY3Y0QwZXN0czYyNUd6ajREKzlDRGhHdWdnK2gxM1Zpby90L284?=
 =?utf-8?B?dmZHakQ1V2FsZ3lneCtxWkpTOER2UjNjWGxORXkyZTZJSitqOW05dEs5Kzk3?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e21cfa-bd5c-491c-6e9c-08dc8b29fb4c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:52:40.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCb5HGAqMBknZ6HcXkjmnxVLCVDnV9KoGmv1rrBf6rtuFf4reQ2WnnnniYzlVwiqTnnOSCwc5c99j+N5T4sdjUl1SqaYI7tPTxVonhza16U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

On 4/26/2024 2:46 PM, Paul M Stillwell Jr wrote:
> On 4/26/2024 2:36 PM, Bjorn Helgaas wrote:
>> On Thu, Apr 25, 2024 at 04:32:21PM -0700, Paul M Stillwell Jr wrote:
>>> On 4/25/2024 3:32 PM, Bjorn Helgaas wrote:
>>>> On Thu, Apr 25, 2024 at 02:43:07PM -0700, Paul M Stillwell Jr wrote:
>>>>> On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
>>>>>> On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
>>>>>>> On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
>>>>> ...
>>>>
>>>>>>>> _OSC is the only mechanism for negotiating ownership of these
>>>>>>>> features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that 
>>>>>>>> _OSC
>>>>>>>> only applies to the hierarchy originated by the PNP0A03/PNP0A08 
>>>>>>>> host
>>>>>>>> bridge that contains the _OSC method.  AFAICT, there's no
>>>>>>>> global/device-specific thing here.
>>>>>>>>
>>>>>>>> The BIOS may have a single user-visible setting, and it may 
>>>>>>>> apply that
>>>>>>>> setting to all host bridge _OSC methods, but that's just part of 
>>>>>>>> the
>>>>>>>> BIOS UI, not part of the firmware/OS interface.
>>>>>>>
>>>>>>> Fair, but we are still left with the question of how to set the 
>>>>>>> _OSC bits
>>>>>>> for the VMD bridge. This would normally happen using ACPI AFAICT 
>>>>>>> and we
>>>>>>> don't have that for the devices behind VMD.
>>>>>>
>>>>>> In the absence of a mechanism for negotiating ownership, e.g., an 
>>>>>> ACPI
>>>>>> host bridge device for the hierarchy, the OS owns all the PCIe
>>>>>> features.
>>>>>
>>>>> I'm new to this space so I don't know what it means for the OS to
>>>>> own the features. In other words, how would the vmd driver figure
>>>>> out what features are supported?
>>>>
>>>> There are three things that go into this:
>>>>
>>>>     - Does the OS support the feature, e.g., is CONFIG_PCIEAER enabled?
>>>>
>>>>     - Has the platform granted permission to the OS to use the feature,
>>>>       either explicitly via _OSC or implicitly because there's no
>>>>       mechanism to negotiate ownership?
>>>>
>>>>     - Does the device advertise the feature, e.g., does it have an AER
>>>>       Capability?
>>>>
>>>> If all three are true, Linux enables the feature.
>>>>
>>>> I think vmd has implicit ownership of all features because there is no
>>>> ACPI host bridge device for the VMD domain, and (IMO) that means there
>>>> is no way to negotiate ownership in that domain.
>>>>
>>>> So the VMD domain starts with all the native_* bits set, meaning Linux
>>>> owns the features.  If the vmd driver doesn't want some feature to be
>>>> used, it could clear the native_* bit for it.
>>>>
>>>> I don't think vmd should unilaterally claim ownership of features by
>>>> *setting* native_* bits because that will lead to conflicts with
>>>> firmware.
>>>
>>> This is the crux of the problem IMO. I'm happy to set the native_* bits
>>> using some knowledge about what the firmware wants, but we don't have a
>>> mechanism to do it AFAICT. I think that's what commit 04b12ef163d1 
>>> ("PCI:
>>> vmd: Honor ACPI _OSC on PCIe features") was trying to do: use a 
>>> domain that
>>> ACPI had run on and negotiated features and apply them to the vmd 
>>> domain.
>>
>> Yes, this is the problem.  We have no information about what firmware
>> wants for the VMD domain because there is no ACPI host bridge device.
>>
>> We have information about what firmware wants for *other* domains.
>> 04b12ef163d1 assumes that also applies to the VMD domain, but I don't
>> think that's a good idea.
>>
>>> Using the 3 criteria you described above, could we do this for the 
>>> hotplug
>>> feature for VMD:
>>>
>>> 1. Use IS_ENABLED(CONFIG_<whatever hotplug setting we need>) to check 
>>> to see
>>> if the hotplug feature is enabled
>>
>> That's already there.
>>
>>> 2. We know that for VMD we want hotplug enabled so that is the implicit
>>> permission
>>
>> The VMD domain starts with all native_* bits set.  All you have to do
>> is avoid *clearing* them.
>>
>> The problem (IMO) is that 04b12ef163d1 clears bits based on the _OSC
>> for some other domain.
>>
>>> 3. Look at the root ports below VMD and see if hotplug capability is set
>>
>> This is already there, too.
>>
>>> If 1 & 3 are true, then we set the native_* bits for hotplug (we can 
>>> look
>>> for surprise hotplug as well in the capability to set the
>>> native_shpc_hotplug bit corrrectly) to 1. This feels like it would 
>>> solve the
>>> problem of "what if there is a hotplug issue on the platform" because 
>>> the
>>> user would have disabled hotplug for VMD and the root ports below it 
>>> would
>>> have the capability turned off.
>>>
>>> In theory we could do this same thing for all the features, but we don't
>>> know what the firmware wants for features other than hotplug (because we
>>> implicitly know that vmd wants hotplug). I feel like 04b12ef163d1 is 
>>> a good
>>> compromise for the other features, but I hear your issues with it.
>>>
>>> I'm happy to "do the right thing" for the other features, I just can't
>>> figure out what that thing is :)
>>
>> 04b12ef163d1 was motivated by a flood of Correctable Errors.
>>
>> Kai-Heng says the errors occur even when booting with
>> "pcie_ports=native" and VMD turned off, i.e., when the VMD RCiEP is
>> disabled and the NVMe devices appear under plain Root Ports in domain
>> 0000.  That suggests that they aren't related to VMD at all.
>>
>> I think there's a significant chance that those errors are caused by a
>> software defect, e.g., ASPM configuration.  There are many similar
>> reports of Correctable Errors where "pcie_aspm=off" is a workaround.
>>
>> If we can nail down the root cause of those Correctable Errors, we may
>> be able to fix it and just revert 04b12ef163d1.  That would leave all
>> the PCIe features owned and enabled by Linux in the VMD domain.  AER
>> would be enabled and not a problem, hotplug would be enabled as you
>> need, etc.
>>
>> There are a zillion reports of these errors and I added comments to
>> some to see if anybody can help us get to a root cause.
>>
> 
> OK, sounds like the plan for me is to sit tight for now WRT a patch to 
> fix hotplug. I'll submit a v2 for the documentation.
> 

Any update on fixes for the errors?

Paul


