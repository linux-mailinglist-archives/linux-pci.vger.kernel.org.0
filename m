Return-Path: <linux-pci+bounces-5561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCB895952
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B6B1F2354D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7C13174F;
	Tue,  2 Apr 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPjYWxWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096902E40D
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074237; cv=fail; b=Te1tbWtrV0R/Wbgd+iJijqEUtXDezxpafDVKwvLqKsLFxO78FDaVDjlHCnlVNR/cx4rW9ew6qwqBtdRKEmsTifozTI1B9pMz0zv/A6tnnTPtX65b5h/n3/t8RlCUrtn6bAgfyU+JuC7CZVr8JEQfJbRRGFSnRQPtgG4wX6vfXs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074237; c=relaxed/simple;
	bh=BjA3y9qKq4VBwwYdtqVRBt7x9l1LSGNJIsEMTJAz3k8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6AgCXu+71+vhwDbJPG1Mt3uXvmUt88WHcv+BP9SbOB3ZntFUEbY27FX0oSp9cngLBVUXYpw30oiFOCqH3bkerNB+N+3sy3CXgZ2KM/AnE3HkHE4XDAUvmmLbH3BuJAbThZhjnqS+kEHwEca+9eppWZQdwD0+3xgfenDJMlesJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPjYWxWe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712074235; x=1743610235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BjA3y9qKq4VBwwYdtqVRBt7x9l1LSGNJIsEMTJAz3k8=;
  b=FPjYWxWeAUeX9G+A+A9QfiB5l8+D2QxB9fY9djtNOYgMabPoWFjDI5GA
   72MrYNY3oQ4o5tEm6wcHY6iZifbHhm+vyoyS7nP0+ylWC2fd5fiR3Brlm
   7fRAgtmE1nPhThI9mJ22ojnvNgVpF5BfsxUlN45oZaUzyKqpt0tJcfEwd
   O60C8OG31ad9Frtg3z6S7zlTm/FeAiinfuF+oUq21sc9YB6E5ez1JI8qL
   3LxKFrqgGXSU8qt9hI3zeQdUZN5BUOOL8IQ0Vbv1ATKyhY0jZ5h5+C+P7
   0PEWMWIRQAi1FudXyZL8tFXKU9oAqfBatjHRGmpdLRpbYII6J5WHToJVd
   w==;
X-CSE-ConnectionGUID: a94yP8HeSVSFWRRrRvJvAg==
X-CSE-MsgGUID: UR+jQY8NTdubHfo4HA4Igw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18617722"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18617722"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:10:15 -0700
X-CSE-ConnectionGUID: CLqMG06TQVKhkjVUzEQeTg==
X-CSE-MsgGUID: HV3UpBOUSmWG/p6OyGmKBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18166799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 09:10:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 09:10:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 09:10:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 09:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/srMoQCqIFRN+1Z+JzMVuiDLr0g9j9q9e9QaBhJ+A7gMuR5BF6XNXniI5J1VUIsSDiY11fHY6PFx93i/57ONxW+ooBkdcQ0VbaShgEotVGLF/THeKtmyE6wRFrCI3QBqKw1JH7vZlUfYALxcX0WThCQ6QSGONIJ6RYIa/araayPFY1NX2iWqcCQHq2/BkXXzQ20SmSZlU6FDfJp6w0QNioLvrYWe8ZKnbvazwco0s1C0Z0rq7VJcRIrMMSBYpmASYDN66lVcVLk+bfCcZ8s9yd9D6OvGtlHs3UOEr3t1UUQK1dowaTUNExcDb0KU+koZ7ngpY4D4Jf5IVRDhR+jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz7lk6VktgQ3PZTtmctNduUEd1T1HhRhmgWeryALTyU=;
 b=fkKaObTttARBukZ0/C6xZdZyAAUlJ1nYvAtqtv49+VCJP1/v2cSdDmLDRhak06n1n7cVw45ImHHvAkHVnLiyt5zWTixfC4nF32VqnqA4oWhDrKYdnP4X9hBOHMrPfxk5rrDxpque8eQRxVtu+ZD5uDsnvs22+g2TwQIMfWD4s6GZCkhfF5ml4KEHf+wSe6nddVbw+1yszvm4TYTRRdZlhdu4WBFl4ZKoQCBZmW4w7wJO6OoQpvm0g+cp9iE0S6tC2E302Nq6D0WDEJluH58C9ea+asJUpmHw7Jdc12lHFPvLhN0+j6h0v99aUlHX/QaXu9yzRKA7t6UA6O+s2tjiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 16:10:12 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 16:10:12 +0000
Message-ID: <5cf66eb2-6820-4514-9d5f-1a7c4228cff9@intel.com>
Date: Tue, 2 Apr 2024 09:10:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kai-Heng Feng <kai.heng.feng@canonical.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20240326210841.GA1497045@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240326210841.GA1497045@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|MW6PR11MB8411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igg0UVJH54B+rHYdqZ2tNyKlqwMlgBFK+MXRvvzN86urgKwrsHromi4YVwWdoK4kOpy2W0mqqf/ZRWXFRFJF+Lv0VNhZlxQGeG+c17wV3rl5Ws45FRv9sHJR8td8HnvbR1HsWA8hCREVQhLxvD5CWym4e+p51pw+uCYR32JzT28hVeWYAYg8/QxMr4wDZIcDGkySRu6qzQXa5y+Pek+DzXnq1iZkY0qllAQGmqcBBL/odM4bAdJaRVqa5Schoo3LlUoBLojtgc1F3FOvE0SmE8chjHBmTavUyeQig923TQQ9OY07SAVa7unuZg2T/8N+921W772V7PA4pWSJ9ODhZQoBPZ1guA8lLAR4Nb9hCXX36t2z4Ke8TBIOEsZJc70+aVDMB5lBqwBZBOgG7q0ffw4WE5/djdzZ3y1S1xuHn/qplWCvIzdcFaX3lFzMzXF6yVkcHBwxn4q+LPwq9WXCeZ5SG0lrJCOBqalhSRMMw8QctGb0f479pSo6t6ibOfxkyUJGwqb4peIoPiq0JflOUZzFqLGLkZ8RdV5gau3EE9uT5+hUed5TYWNwSTPY8xmA/KAwY8tmBKFj8rHzRgBOliEbXc6mRfR/RcTmUpmEyLodsrZ3hriIGBq+5OQnCfPkkFyMuS52faPQFE8bn7rQbzDaMLGKgSaGBSC1uSFniCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBIY3JMb1FwT1JOYjZEc0tZR3dGdkEyWGtnNmRwVmtFL2wrWVFpZG1rYjFZ?=
 =?utf-8?B?WkoxMEkzU3R4WnVEb2lJdmVVSTlhUWIzOEdOeE9CT0hUclV2dzhZK1hCYmVM?=
 =?utf-8?B?VTBkQ2dkOG1IMDFBU1FnYUxmNW9wQVdLWGZuRjJFNTRJYVVyQVFWaG41ck9Z?=
 =?utf-8?B?TWhqMDVTL1JkdjBYczFrazBCTjlpbENFYnUxNDRkNVFVTnZZeFp0Mk5IZDZX?=
 =?utf-8?B?NCtRQ1hqQkNQTHY1YVF6MkxneE5rYTFTTEFpRE8xK3lrM01pK1lTSUxjMU5z?=
 =?utf-8?B?MXVleTNBTndXQTlLazl6dHVzbk8xaytKdjlkazB0M1BEcFU1T0toSXErd1li?=
 =?utf-8?B?WTB3c1J4RVZsL3ZQRGtjMjRmQVlTWUZMNWZQTVhhWHBRNWxoRzRnOFFwNjNp?=
 =?utf-8?B?R2RuT2lVRjJPRHk2d24vTmJxSlV0L2JtQ2V2cllCaWJkZWlOQjRVKzhaL3hI?=
 =?utf-8?B?cVArRm1KeUpWLzVqY2RadlorQU1xbmVPSER4QlFyWEtaRFhHOG5Ta0V4SjND?=
 =?utf-8?B?ZFh4R25heVI2SnFoRFN0Q3dkMDRkZlc2NUNaZG42UklDcVZMK0VBZXBjOWht?=
 =?utf-8?B?a2t0bWxLekdXYWxMNmNpVlhJU1hKRU1vVWJ6Z2NqRUhIL292aHl1azBJYm1i?=
 =?utf-8?B?SkJhV3d0eXY0cHdtc1VmRkY5YkVybkFRQ0NkbU5zUVNiaFlDdmNtMnBwd3Av?=
 =?utf-8?B?UlljT29sclJuT3l2dkZJeS9TMldaWW9LZUdHWTBEeHUwYUZqNmpqdTI4eU1Z?=
 =?utf-8?B?QUZwUlFxbEpUVEVKdmF6ejBKdWpIekozSnpaODV1RVdJS1R4M2o2eFN2NlhN?=
 =?utf-8?B?RFdPYXNaYXorKzBPb21Cd2s3c2pKaVR6NXpzUVVNazZkUmNzenFjc3hFd3NZ?=
 =?utf-8?B?b1BIcDNRSnBaYWV1ay9oRXplUmxSQ3NTQkNpUmM4emlXVSszU1FtbC9KRmt6?=
 =?utf-8?B?TWwrTWdNOGx1NlVTZmE1cDR6NFAzejlHbHNBczZEQkhrNXZUZVczRDFVQlVY?=
 =?utf-8?B?YXlDK0hWZEp5L0Q4MFAzSXNabVpWbkJ1OVFxcWF3WGl1VGtudlh1bHkra1hk?=
 =?utf-8?B?SVZiZXVYc2xOb0RGTjdkZ0hNUHJsRUZ4SnJ6RityZDdrY20vOFYyT2xBdUZL?=
 =?utf-8?B?dmxIeEZINW05VURqUXhMY2FBbXNacGl0Yy9jckNIMmp2cHNiejhRMWNZakNO?=
 =?utf-8?B?Yk9pUThqNXZDOW5ZMTJPNW9FbGpqL3FYQldHUEY4UE4ya25MZWY1TjNCMUVH?=
 =?utf-8?B?dGs0cXVvUFEwcUdnc3Z4WnVSTnNGSXUvellvQTdKRWVmbUhrVXRHWTVhWU4y?=
 =?utf-8?B?VnhGMlV5L2ZUdkl0WUZ2NmcwVHJ1dEM4THd3Mm9mdW5aaDhJR0ZBdlhXZE1L?=
 =?utf-8?B?QjJVU09WT0lkK0RLUHQ1N2QyNW90bks3a1pQd3E2cTZpb3VNTUFGQzN5bFQ0?=
 =?utf-8?B?YnRwRy94SlJhNFhjM1cvbVhyMUYvSnU1d3F4elo3eHZoSHcwQUJZeFFCLzRC?=
 =?utf-8?B?Q3lTU2hxWUpVb1VBVjNxU2ZNWWgwQ1JSMk5pZUs2eGdTZmhBWmwxQXlKY3hH?=
 =?utf-8?B?ZHFIclpSUVpNZTMzWlNWazdudi91UktOczhXdDVNNFhRTE51ajhTQnBXRTdR?=
 =?utf-8?B?U3dGZnZpSGUvMHZSdlg0MUx3RW42bGhJTmpTaVFONC9FdlhEKzhQdFpJOXlS?=
 =?utf-8?B?aUg1a0NySThydDBTOTUvT3Fua2dvcVpkQlRyNjhYaGVWRFV2ZkExTEtRc2FP?=
 =?utf-8?B?NlNHZ2lkcG51Y1RwbGk0cUNMYzVvM0d5VmJJOVA0cVFVYTVISzhMUGVHdFhF?=
 =?utf-8?B?Q1RYeXFEZ29vTXQ4S3R4VExSblFxNk9LUlBRUGpscnkwSmI0ZlhRZXAyVXda?=
 =?utf-8?B?QmcyYW85UlFQWWJ2TXRQSjE2dmNNZldsUjZVeWJ5bFpGNUV1aTJlMDIrcG4y?=
 =?utf-8?B?UHUyV1FlOWp6NnlaZDZlN1U4Mys3QzZ2ekpWdllWd29LNGRIWWhvb0dxU3NW?=
 =?utf-8?B?ZjRCRU1TNHVCSDV2WjFwNCtDWHo2b0VuK01iRGQ4QUdZZ2JvR211V2tBVW9K?=
 =?utf-8?B?bEdCTjlOaXVXVThKRi9uZ09MRjErSmJMNEh2S0NMd2RxdHVKaEhwUjJTZTVI?=
 =?utf-8?B?WTFjUG5qTFJXTjVqc2FOVWttN0xubjkvWkFrRFB2WUQ0cXVwVkJ5SEZZMlZR?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b88b65ec-1b9b-4324-5144-08dc532f603a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:10:12.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DWBavNL27LHjvyloQUzZzz7ZZRYkb3mXwds19UrC7+JFBeA+bXGzcV8xxRzS4r+0VHK/9KsLHF4wuLj2uf6U52H/PEKWGwM+qxYDNj7lUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com

On 3/26/2024 2:08 PM, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2024 at 08:51:45AM -0700, Paul M Stillwell Jr wrote:
>> On 3/25/2024 6:59 PM, Kai-Heng Feng wrote:
>>> On Tue, Mar 26, 2024 at 8:17 AM Nirmal Patel
>>> <nirmal.patel@linux.intel.com> wrote:
>>>>
>>>> On Fri, 22 Mar 2024 18:36:37 -0500 Bjorn Helgaas
>>>> <helgaas@kernel.org> wrote:
>>>>
>>>>> On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr
>>>>> wrote:
>>>>>> On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
>>>>>>> On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel
>>>>>>> wrote:
>>>>>>>> On Fri, 15 Mar 2024 09:29:32 +0800 Kai-Heng Feng
>>>>>>>> <kai.heng.feng@canonical.com> wrote: ...
>>>>>>>
>>>>>>>>> If there's an official document on intel.com, it can
>>>>>>>>> make many things clearer and easier. States what VMD does
>>>>>>>>> and what VMD expect OS to do can be really helpful.
>>>>>>>>> Basically put what you wrote in an official document.
>>>>>>>>
>>>>>>>> Thanks for the suggestion. I can certainly find official
>>>>>>>> VMD architecture document and add that required information
>>>>>>>> to Documentation/PCI/controller/vmd.rst. Will that be
>>>>>>>> okay?
>>>>>>>
>>>>>>> I'd definitely be interested in whatever you can add to
>>>>>>> illuminate these issues.
>>>>>>>
>>>>>>>> I also need your some help/suggestion on following
>>>>>>>> alternate solution. We have been looking at VMD HW
>>>>>>>> registers to find some empty registers. Cache Line Size
>>>>>>>> register offset OCh is not being used by VMD. This is the
>>>>>>>> explanation in PCI spec 5.0 section 7.5.1.1.7: "This
>>>>>>>> read-write register is implemented for legacy compatibility
>>>>>>>> purposes but has no effect on any PCI Express device
>>>>>>>> behavior." Can these registers be used for passing _OSC
>>>>>>>> settings from BIOS to VMD OS driver?
>>>>>>>>
>>>>>>>> These 8 bits are more than enough for UEFI VMD driver to
>>>>>>>> store all _OSC flags and VMD OS driver can read it during
>>>>>>>> OS boot up. This will solve all of our issues.
>>>>>>>
>>>>>>> Interesting idea.  I think you'd have to do some work to
>>>>>>> separate out the conventional PCI devices, where
>>>>>>> PCI_CACHE_LINE_SIZE is still relevant, to make sure nothing
>>>>>>> breaks.  But I think we overwrite it in some cases even for
>>>>>>> PCIe devices where it's pointless, and it would be nice to
>>>>>>> clean that up.
>>>>>>
>>>>>> I think the suggestion here is to use the VMD devices Cache
>>>>>> Line Size register, not the other PCI devices. In that case we
>>>>>> don't have to worry about conventional PCI devices because we
>>>>>> aren't touching them.
>>>>>
>>>>> Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE
>>>>> for every device in some cases.  If we wrote the VMD
>>>>> PCI_CACHE_LINE_SIZE, it would obliterate whatever you want to
>>>>> pass there.
>>>>>
>>>> Our initial testing showed no change in value by overwrite from
>>>> pci. The registers didn't change in Host as well as in Guest OS
>>>> when some data was written from BIOS. I will perform more testing
>>>> and also make sure to write every register just in case.
>>>
>>> If the VMD hardware is designed in this way and there's an official
>>> document states that "VMD ports should follow _OSC expect for
>>> hotplugging" then IMO there's no need to find alternative.
>>
>> There isn't any official documentation for this, it's just the way VMD
>> is designed :). VMD assumes that everything behind it is hotpluggable so
>> the bits don't *really* matter. In other words, VMD supports hotplug and
>> you can't turn that off so hotplug is always on regardless of what the
>> bits say.
> 
> This whole discussion is about who *owns* the feature, not whether the
> hardware supports the feature.
> 

I'm not disagreeing about who owns the feature :) I'm trying to find a 
solution when the data that the driver gets is wrong.

> The general rule is "if _OSC covers the feature, the platform owns the
> feature and the OS shouldn't touch it unless the OS requests and is
> granted control of it."
> 

The code is fine in a bare metal system, but completely broken in a 
hypervisor because all the _OSC bits are set to 0. So I am trying to 
find a solution where the hotplug bits can be set correctly in this 
situation.

> VMD wants special treatment, and we'd like a simple description of
> what that treatment is.  Right now it sounds like you want the OS to
> own *hotplug* below VMD regardless of what _OSC says.
> 

What I want is for hotplug to be enabled in a hypervisor :) The slot 
capability register has the correct bits set, but it doesn't make sense 
(to me) to use a register in a root port to set the bridge settings. 
That's why this patch just removed the hotplug bits from the code. 
Everything is set up correctly (as far as I can tell) in both bare metal 
and hypervisors if we omit those 2 lines.

Does anyone have a better suggestion on how to handle the case where the 
_OSC bits are incorrect?

Paul

> But I still have no idea about other features like AER, etc., so we're
> kind of in no man's land about how to handle them.
> 
> Bjorn


