Return-Path: <linux-pci+bounces-6495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3708AB723
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 00:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D1283250
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2C92B9B0;
	Fri, 19 Apr 2024 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+cI8FFc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992413D283
	for <linux-pci@vger.kernel.org>; Fri, 19 Apr 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565109; cv=fail; b=uuF3G6nevV57IKTU3pNUzbMZfIauOlfNhB/XAnZQp1Da/4us6EbfTmZ6YEAUA/dI1xTH441rHsYmI/kBMKYUXUTw8uCaC2ga4sTieexNN/8CBcVIuP7alXi/+P/ERYqMQEGE4EHrr7cdblfoCR0fB+zy81z/nucaS/wDulpdMB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565109; c=relaxed/simple;
	bh=5MubOo+6fhZdLZ8QnFWgSmwRnNahHHW3/SD59JU6Y9I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfQV3KvyLPD/sEFa+lE4l7NOf4z/ue0Jl3lyUoDKvnYZKf32qKP0pih0AKxKcEwY6pJqt9YPNd49hzeU98ayuWtmEPfyOIavQaijPrtyd2rfoSA+8D8ubRU7gggi2bXB+epmmADTlgwMCsVPQuqA2Ruj6szjpMksjsIWAFSItAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+cI8FFc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713565107; x=1745101107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5MubOo+6fhZdLZ8QnFWgSmwRnNahHHW3/SD59JU6Y9I=;
  b=C+cI8FFcuOjjwyHFdj8xI9R06UfbwC7dxhJJidwOuBjc1lhOtt+Xuc2n
   uiA6ZnYa0uHyjW6QK+Ch0r19hUTyCpOp5RW/RM+xjxVBzaCejZ981nONU
   kUB/i285sHc4l7F2quFi0+RRUdBupl+CaDHidr8K6bxPrW1hSJ6Io4AZB
   EUeLQW7m5i4L9UzYK9nL5hP4lFPQEGUVaBqZUQiGCLJNTD8SZywuLLfoq
   JQsat/wHuNsxg4NuwvUuptmo/DrEFiiYMW8wUtfx7FUOdBHggGNZR001z
   RMm7VKpzKuRxwdYQwJOoewpvRx9A0HkygaS3W23UZCNmtZT3zZzbQW6bG
   w==;
X-CSE-ConnectionGUID: /mMKm0csSgmxn3B+zymZyw==
X-CSE-MsgGUID: 6fXTOPNaRouiX7YVZR34SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9300779"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9300779"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 15:18:27 -0700
X-CSE-ConnectionGUID: f1u2e+V1Rl+DxC5YdfDzkg==
X-CSE-MsgGUID: YAzf4pYfREKhsWo7zZp40w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28112510"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 15:18:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 15:18:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 15:18:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 15:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+1PbEvlPT0nm4t7FSIMxZFAYNqUbv3u4TVP4OpS6oK0KkjgZWzIT9MSDTmEz7HNbU3WhgzFWuo/DGzkgR5pVcLS/PGEC+AOm3+3If490NWeO9gTM0N47mFtW1RagiN4QL54axzMXRcN5JFu3LXBt1j++xN3aj/LA3ag9H0tH/UWPOqXX/2bmoutN991M6I1ZE6bgmujtCijcnPTcy3u62YvxVkpNet2xQdPKCLeY10QyGTKIpkHFS4XhDXAk0S0FxyaH/YvWdpOLboE32yVgYzWtoGd88rbsousz4/l2lYDOx++ktJwU/RVkSKgX38twmH6GTpcy6ThOtiEPPo//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcuWaiifOpSe/8fKfJAX6e/KIgq3swtgaEAM5yTslMc=;
 b=BfMmli0WjHCyHLRw0MxC1oN6TCa74ry8AvOl9mWW+SJJFbkJCZ+6WO/1GnbjgNQV1DCvZs4Z+0xHDWxKD+SjCZY0wRE9oVzOpj5ZAr4RNi1d/eWGvuZ4aopeP9c4OH17oJ4R6Hdmm3pvfVOk4QUr29ump94lQ68s7ScIsx9jQw+IscrTUEhHU12sGK+58zX80FafsvQsCj8ePKq9pbOQg8cK8y4QesjEXqP/DBmT2gYa4Dg2nmems3M7EuR5zhmHwTAwtx7GhSoM+VLd3SXak0D+6Vmrrr/fGUukF4yn7RTE/VH6+TSuBxLHXuwyL5tvevtaXbwwQFA+D9zzWHfbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 22:18:22 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.015; Fri, 19 Apr 2024
 22:18:22 +0000
Message-ID: <d54e79c3-7a73-4ae8-b773-ae7c96559a31@intel.com>
Date: Fri, 19 Apr 2024 15:18:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240419211400.GA295110@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240419211400.GA295110@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 538e1f9b-e7b3-4c77-da25-08dc60be9fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 5NZu8pbayOifQGom8Q22gzQFCpZubP9dX+HAFpVZgZGKGVP7MFqkMuZxzBTqKoOvCTiinFHX9pnCrd0agXvW/7+ygFQG5X6r6hC+hkYh96wFCu4ZYlg8xN1veTrJLOv9tTOIgMySWtFi4vH5eYtfugRt9uZBvahtNN0tNQBYgFQ9TkVsNjD7gP14pTZY+WbWZN9Fl1v6Aw/dbkXD4F4WWaDT2AWbA8wE3IVFR7tAFNULHiQxK6mbA7izsfVTQmNwq9H+LEHlq6ev8nG4RCCnAaVc71agXvQQepuy6z3ERZn6L+Ax9M1WkhbPXf7WDcsNOMwf2RoqANu3PQek4aN3PKQ5x1XipQV+7FOWubOzpg0GGY4Vq1gd3RwfJNLJWMcoTu0Kec1T1+xpvX0LoJJru5tZ8OMlqsnG2MoZMO2K9yxEs2pdhQLuKzmhnG7OoZTFzYsRMveUJG2znLC330BOxGIhrQwx8oP2csmB94CQss28WQolLF7hrythg5e6rpIgdm+ySwgNADS4xHcFnEv1fiqe9t2YUK54IupEF/xdJejDPm6xqB4T4w6iYdBUelYAYaUD7pzY66j7KmPOFVhCgTRqdx2CUYM4vk1cDef6/oY8pwCqYinjci/zfjHJVYS3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjh2MVlpZHhab1dDaDRtZzVQT1lYc0o1UXdIeXo3a3E0SFhBZ09ZQWdSY0VI?=
 =?utf-8?B?ZXlUcWNvR1ZGb3NNWnlXSjFlTG5IMVo5Y29tTlJPSVRxeVhWMnBLK0d0SUgr?=
 =?utf-8?B?MTVKdFlkNFk3TEkwRzVtSWw3dCtlSkVGSGozdFhJOHM3dlI3OVJ1TWJ5bVdk?=
 =?utf-8?B?MkFBaXJvdmlaaW5BeFJqOFhVK09NTWdKcEExak43T0Z4dXl3M1dpSGgraFRh?=
 =?utf-8?B?bUN0Yis3c2RXd215QzVmVjcxWk11SDIvdTBUaUNmOGw3OXJBSkZCQVZ2RVRi?=
 =?utf-8?B?Qis1N2hjV0RVMit2Sk10Sjk3eWF6eFpHUWNZTFQ1UHhzZmljQUVUMCtxOERO?=
 =?utf-8?B?TmVSN1RnbWZ6bUlKaEdRT1NDMHhjeUtqdURkUmlzREczaHBXTXFsS0JxWjZo?=
 =?utf-8?B?eFNTVllNQ2ZQa2czSS9QUk1KZytKL1hadU55K05iQk1hWFk3VHdVUStxRFpj?=
 =?utf-8?B?ZG5CeWV1ZndUU21vN3JqWkNCdWdOdk9FcjRXUm5pZUZpWEw1OGIvRVp4UE05?=
 =?utf-8?B?Wkt3VjVNM2lRQnZzTW5UdkR0VUdmdWFtMVpsQk1jYmo5Zi8yS2Z0Y3BIU3lZ?=
 =?utf-8?B?VTU3S3dIa3paKzRjVjVleE5HenBVcy9vODYvVDNnUVB6c2Nlb1d5ank1TWhi?=
 =?utf-8?B?c21XS1hpb3Y4Q3JSdFhEQmhCNWl6YXo4NDllaEx2WlViQnoyL05MYUdaZUNY?=
 =?utf-8?B?WXd2L2hobTJ0Y3ljR3dTMFpRaHB6QzF2NGNuWnlicCszUTJRbG9uYmlTUEdF?=
 =?utf-8?B?OEx0Y3g5N2VMU1Q1dXl1VSs0K0ZIMzQ5K093Nzg3aVZKNUh1RmFaOHk0K2Nw?=
 =?utf-8?B?WHRFYUdaMDA4czNlUjVDUzhhQkFXbTZUWnBRZi8vSG43UTJDM0xiSGtoSDRM?=
 =?utf-8?B?SzVUWk9iYml2eDgzNUlJcVlSdWVVWEJCZ1UzbHhhUkQ2eG5nVlN4RmIzQzRh?=
 =?utf-8?B?TFoxa3FGOGZnNmlOU0VzdmZwZE5XRHlnbmZqNjJFT3FOWjVlYm5CNWlENHpz?=
 =?utf-8?B?RmIxZGEyeVpyQmpoODhXZGdzQXUzd0NhZ1p3aytkSVpNbjhxZTJ1dCtJMmJv?=
 =?utf-8?B?bGdZVnBoQ0ZubGVTMVZ2Z0ZZQ21ydXozSC90bzdvMTZsdHZpVHRrdk1aWVFu?=
 =?utf-8?B?UTdRYllOV256b2kwc1FtV1V4aytKYnh4MHpJT0M3NEk2VCsyTEVUcWhNdmJH?=
 =?utf-8?B?RFJtRkkzakM0U3QzMlBpSkwwVGpPVzc1dWZYVFNTMy9FZnRFOHU5SUFFcUN2?=
 =?utf-8?B?WUFHeVgrMVJZWCtUNjBJaWFybFYyZEloMDNyMDJhMERXbXJoUDVXd1Z0K25t?=
 =?utf-8?B?TlVtVEYvYTY4cDRUbkRNM2N3N1pCbW1iSW9xVHpqWjNNaWFOQ2FHSkg0M1dO?=
 =?utf-8?B?b3JicnZ0VGdWamdscnJTakZWS0hFTjh5RDJxQ3lwaGg5Z2c4YVc1c000WnEz?=
 =?utf-8?B?NVEyMWtDNzlaSWR0SEZZYm01RTNHZWR2QVp4ZUtwaTg1NjREZ3dROXI5cXQw?=
 =?utf-8?B?ZTZFYTN1Qkh2c056ajkwZHVzdDVLZWsvZ0NnUGFzb2RscHB6UURVRTM2ZTd1?=
 =?utf-8?B?M2ZBMm03ZWlBSi9tUjRtOGhHWTYrTlF5eE8yN1lJanlnQUhwRS8xN1dXRFlZ?=
 =?utf-8?B?cHRRbm9CMHdlZFZhYzZNM2xHS1k1WVQ3bFZEOWJGeUJIK0doeGx4OWJnNVV2?=
 =?utf-8?B?Mk9iTWxxOWtENnZVNDlidE8yck55azlkQ3pOSDQ3Q0I5VmlxemdPd2hpZ3lz?=
 =?utf-8?B?eUh4SFBmTWRPUzEwUytmUmlXdytpbnlZQUlIRGhMNTJWdURjTUhON2tGeXlR?=
 =?utf-8?B?dG5VT0JpTDN4TXhwM2ZkN2NkdjNoLytRS05xTi90MWwzRURURS82bEw0MDAy?=
 =?utf-8?B?TlZGejMwcjZzbzlndVFTbU1YZDVza1l2MG9jS2pScWJXQkNPTzQ3anRpaG1W?=
 =?utf-8?B?RnorTGRvNTNwSmk4UW1pVkFYRGE4c2hJWVg1TFU0RXVNcklkTC9MOXpQNXl1?=
 =?utf-8?B?Q1FUZFVYN0JYSm9SbWVJZ2NuZHhiYytuQ3VWc05iMnI1ZkFCTWh0c3hVL1di?=
 =?utf-8?B?ajlJSnVmSDVUSHZtdERDOE5EVGZRV3J6S00vQ2RRV1Fma1BOR1dxRTVJTk9x?=
 =?utf-8?B?Z1VsTm5RUnNoOXhpeDd0cVdPSExYeWZYaWxrQktpYjE4aVhWVUdIaytyNEdp?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 538e1f9b-e7b3-4c77-da25-08dc60be9fb2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 22:18:22.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE4+U/xoE2NqBqQpDIZ9YiehdFpSUYcGwtRetqDht9RHcdW14ZOjVJECdIeaEMn/gM2ymeMU6wbjgoKj9ic1FvHbFX2L9qm1bHV+nfMHmLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com

On 4/19/2024 2:14 PM, Bjorn Helgaas wrote:
> [+cc Kai-Heng, Rafael, Lorenzo since we're talking about 04b12ef163d1
> ("PCI: vmd: Honor ACPI _OSC on PCIe features")]
> 
> On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
>> On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
>>> On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
>>>> Adding documentation for the Intel VMD driver and updating the index
>>>> file to include it.
>>>>
>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>> ---
>>>>    Documentation/PCI/controller/vmd.rst | 51 ++++++++++++++++++++++++++++
>>>>    Documentation/PCI/index.rst          |  1 +
>>>>    2 files changed, 52 insertions(+)
>>>>    create mode 100644 Documentation/PCI/controller/vmd.rst
>>>>
>>>> diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
>>>> new file mode 100644
>>>> index 000000000000..e1a019035245
>>>> --- /dev/null
>>>> +++ b/Documentation/PCI/controller/vmd.rst
>>>> @@ -0,0 +1,51 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +=================================================================
>>>> +Linux Base Driver for the Intel(R) Volume Management Device (VMD)
>>>> +=================================================================
>>>> +
>>>> +Intel vmd Linux driver.
>>>> +
>>>> +Contents
>>>> +========
>>>> +
>>>> +- Overview
>>>> +- Features
>>>> +- Limitations
>>>> +
>>>> +The Intel VMD provides the means to provide volume management across separate
>>>> +PCI Express HBAs and SSDs without requiring operating system support or
>>>> +communication between drivers. It does this by obscuring each storage
>>>> +controller from the OS, but allowing a single driver to be loaded that would
>>>> +control each storage controller. A Volume Management Device (VMD) provides a
>>>> +single device for a single storage driver. The VMD resides in the IIO root
>>>
>>> I'm not sure IIO (and PCH below) are really relevant to this.  I think
>>
>> I'm trying to describe where in the CPU architecture VMD exists because it's
>> not like other devices. It's not like a storage device or networking device
>> that is plugged in somewhere; it exists as part of the CPU (in the IIO). I'm
>> ok removing it, but it might be confusing to someone looking at the
>> documentation. I'm also close to this so it may be clear to me, but
>> confusing to others (which I know it is) so any help making it clearer would
>> be appreciated.
> 
> The vmd driver binds to a PCI device, and it doesn't matter where it's
> physically implemented.
> 

Ok

>>> we really just care about the PCI topology enumerable by the OS.  If
>>> they are relevant, expand them on first use as you did for VMD so we
>>> have a hint about how to learn more about it.
>>
>> I don't fully understand this comment. The PCI topology behind VMD is not
>> enumerable by the OS unless we are considering the vmd driver the OS. If the
>> user enables VMD in the BIOS and the vmd driver isn't loaded, then the OS
>> never sees the devices behind VMD.
>>
>> The only reason the devices are seen by the OS is that the VMD driver does
>> some mapping when the VMD driver loads during boot.
> 
> Yes.  I think it's worth mentioning these details about the hierarchy
> behind VMD, e.g., how their config space is reached, how driver MMIO
> accesses are routed, how device interrupts are routed, etc.
> 
> The 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
> Device (VMD)") commit log mentioned by Keith is a fantastic start
> and answers several things below.  Putting it in this doc would be
> great because that commit is not very visible.
> 

I'll look at it and work it in (either replace this overview or add to it)

>>>> +the VMD is in a central location to manipulate access to storage devices which
>>>> +may be attached directly to the IIO or indirectly through the PCH. Instead of
>>>> +allowing individual storage devices to be detected by the OS and allow it to
>>>> +load a separate driver instance for each, the VMD provides configuration
>>>> +settings to allow specific devices and root ports on the root bus to be
>>>> +invisible to the OS.
>>>
>>> How are these settings configured?  BIOS setup menu?
>>
>> I believe there are 2 ways this is done:
>>
>> The first is that the system designer creates a design such that some root
>> ports and end points are behind VMD. If VMD is enabled in the BIOS then
>> these devices don't show up to the OS and require a driver to use them (the
>> vmd driver). If VMD is disabled in the BIOS then the devices are seen by the
>> OS at boot time.
>>
>> The second way is that there are settings in the BIOS for VMD. I don't think
>> there are many settings... it's mostly enable/disable VMD
> 
> I think what I want to know here is just "there's a BIOS switch that
> enables VMD, resulting in only the VMD RCiEP being visible, or
> disables VMD, resulting in the VMD RCiEP not being visible (?) and the
> VMD Root Ports and downstream hierarchies being just normal Root
> Ports."  You can wordsmith that; I just wanted to know what
> "configuration settings" referred to so users would know where they
> live and what they mean.
> 

Got it, will update to reflect that setup/config is through the BIOS

>>>> +VMD works by creating separate PCI domains for each VMD device in the system.
>>>> +This makes VMD look more like a host bridge than an endpoint so VMD must try
>>>> +to adhere to the ACPI Operating System Capabilities (_OSC) flags of the system.
> 
>>> I think "creating a separate PCI domain" is a consequence of providing
>>> a new config access mechanism, e.g., a new ECAM region, for devices
>>> below the VMD bridge.  That hardware mechanism is important to
>>> understand because it means those downstream devices are unknown to
>>> anything that doesn't grok the config access mechanism.  For example,
>>> firmware wouldn't know anything about them unless it had a VMD driver.
> 
>>>     - Which devices (VMD bridge, VMD Root Ports, devices below VMD Root
>>>       Ports) are enumerated in the host?
>>
>> Only the VMD device (as a PCI end point) are seen by the OS without the vmd
>> driver
> 
> This is the case when VMD is enabled by BIOS, right?  And when the vmd

Yes

> driver sets up the new config space and enumerates behind VMD, we'll
> find the VMD Root Ports and the hierarchies below them?
> 

Yes

> If BIOS leaves the VMD functionality disabled, I guess those VMD Root
> Ports and the hierarchies below them are enumerated normally, without
> the vmd driver being involved?  (Maybe the VMD RCiEP itself is

Yes

> disabled, so we won't enumerate it and we won't try to bind the vmd
> driver to it?)
> 

Yes

>>>     - Which devices are passed through to a virtual guest and enumerated
>>>       there?
>>
>> All devices under VMD are passed to a virtual guest
> 
> So the guest will see the VMD Root Ports, but not the VMD RCiEP
> itself?
> 

The guest will see the VMD device and then the vmd driver in the guest 
will enumerate the devices behind it is my understanding

>>>     - Where does the vmd driver run (host or guest or both)?
>>
>> I believe the answer is both.
> 
> If the VMD RCiEP isn't passed through to the guest, how can the vmd
> driver do anything in the guest?
> 

The VMD device is passed through to the guest. It works just like bare 
metal in that the guest OS detects the VMD device and loads the vmd 
driver which then enumerates the devices into the guest

>>>     - Who (host or guest) runs the _OSC for the new VMD domain?
>>
>> I believe the answer here is neither :) This has been an issue since commit
>> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features"). I've submitted
>> this patch (https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/)
>> to attempt to fix the issue.
> 
> IIUC we make no attempt to evaluate _OSC for the new VMD domain (and
> firmware likely would not supply one anyway since it doesn't know how
> to enumerate anything there).  So 04b12ef163d1 just assumes the _OSC
> that applies to the VMD RCiEP also applies to the new VMD domain below
> the VMD.
> 
> If that's what we want to happen, we should state this explicitly.
> But I don't think it *is* what we want; see below.
> 
>> You are much more of an expert in this area than I am, but as far as I can
>> tell the only way the _OSC bits get cleared is via ACPI (specifically this
>> code https://elixir.bootlin.com/linux/latest/source/drivers/acpi/pci_root.c#L1038).
>> Since ACPI doesn't run on the devices behind VMD the _OSC bits don't get set
>> properly for them.
> 
> Apparently there's *something* in ACPI related to the VMD domain
> because 59dc33252ee7 ("PCI: VMD: ACPI: Make ACPI companion lookup work
> for VMD bus") seems to add support for ACPI companions for devices in
> the VMD domain?
> 

I've seen this code also and don't understand what it's supposed to do. 
I'll investigate this further

> I don't understand what's going on here because if BIOS enables VMD,
> firmware would see the VMD RCiEP but not devices behind it.  And if
> BIOS disables VMD, those devices should all appear normally and we
> wouldn't need 59dc33252ee7.
> 

I agree, I'll try to figure this out and get an answer

>> Ultimately the only _OSC bits that VMD cares about are the hotplug bits
>> because that is a feature of our device; it enables hotplug in guests where
>> there is no way to enable it. That's why my patch is to set them all the
>> time and copy the other _OSC bits because there is no other way to enable
>> this feature (i.e. there is no user space tool to enable/disable it).
> 
> And here's the problem, because the _OSC that applies to domain X that
> contains the VMD RCiEP may result in the platform retaining ownership
> of all these PCIe features (hotplug, AER, PME, etc), but you want OSPM
> to own them for the VMD domain Y, regardless of whether it owns them
> for domain X.
> 

I thought each domain gets it's own _OSC. In the case of VMD, it creates 
a new domain so the _OSC for that domain should be determined somehow. 
Normally that determination would be done via ACPI (if I'm understanding 
things correctly) and in the case of VMD I am saying that hotplug should 
always be enabled and we can use the _OSC from another domain for the 
other bits.

I went down a rabbit hole when I started working on this and had an idea 
that maybe the VMD driver should create an ACPI table, but that seemed 
way more complicated than it needs to be. Plus I wasn't sure what good 
it would do because I don't understand the relationship between the root 
ports below VMD and the settings we would use for the bridge.

> OSPM *did* own all PCIe features before 04b12ef163d1 because the new
> VMD "host bridge" got native owership by default.
> 
>>>     - What happens to interrupts generated by devices downstream from
>>>       VMD, e.g., AER interrupts from VMD Root Ports, hotplug interrupts
>>>       from VMD Root Ports or switch downstream ports?  Who fields them?
>>>       In general firmware would field them unless it grants ownership
>>>       via _OSC.  If firmware grants ownership (or the OS forcibly takes
>>>       it by overriding it for hotplug), I guess the OS that requested
>>>       ownership would field them?
>>
>> The interrupts are passed through VMD to the OS. This was the AER issue that
>> resulted in commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
>> features"). IIRC AER was disabled in the BIOS, but is was enabled in the VMD
>> host bridge because pci_init_host_bridge() sets all the bits to 1 and that
>> generated an AER interrupt storm.
>>
>> In bare metal scenarios the _OSC bits are correct, but in a hypervisor
>> scenario the bits are wrong because they are all 0 regardless of what the
>> ACPI tables indicate. The challenge is that the VMD driver has no way to
>> know it's in a hypervisor to set the hotplug bits correctly.
> 
> This is the problem.  We claim "the bits are wrong because they are
> all 0", but I don't think we can derive that conclusion from anything
> in the ACPI, PCIe, or PCI Firmware specs, which makes it hard to
> maintain.
> 

I guess I look at it this way: if I run a bare metal OS and I get 
hotplug and AER are enabled and then I run a guest on the same system 
and I get all _OSC bits are disabled then I think the bits aren't 
correct. But there isn't any way to detect that through the "normal" 
channels (ACPI, PCIe, etc).

> IIUC, the current situation is "regardless of what firmware said, in
> the VMD domain we want AER disabled and hotplug enabled."
> 

We aren't saying we want AER disabled, we are just saying we want 
hotplug enabled. The observation is that in a hypervisor scenario AER is 
going to be disabled because the _OSC bits are all 0.

> 04b12ef163d1 disabled AER by copying the _OSC that applied to the VMD
> RCiEP (although this sounds broken because it probably left AER
> *enabled* if that _OSC happened to grant ownership to the OS).
> 
> And your patch at
> https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
> enables hotplug by setting native_pcie_hotplug to 1.
> 
> It seems like the only clear option is to say "the vmd driver owns all
> PCIe services in the VMD domain, the platform does not supply _OSC for
> the VMD domain, the platform can't do anything with PCIe services in
> the VMD domain, and the vmd driver needs to explicitly enable/disable
> services as it needs."
> 

I actually looked at this as well :) I had an idea to set the _OSC bits 
to 0 when the vmd driver created the domain. The look at all the root 
ports underneath it and see if AER and PM were set. If any root port 
underneath VMD set AER or PM then I would set the _OSC bit for the 
bridge to 1. That way if any root port underneath VMD had enabled AER 
(as an example) then that feature would still work. I didn't test this 
in a hypervisor scenario though so not sure what I would see.

Would that be an acceptable idea?

Paul

> Bjorn


