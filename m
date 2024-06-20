Return-Path: <linux-pci+bounces-9027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7210910963
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399BAB21B45
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5C1AE0B3;
	Thu, 20 Jun 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAt600PY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFAD1AE086;
	Thu, 20 Jun 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896269; cv=fail; b=VMdcBWvTpV+qky60VqJO8VaBBvvlrKyXdIdDvD/Lion6DKM9VzdzhIRDmUx+7pRndn9u/EZMt5aP0RNjXWX0cpVKPNx7cADDkV5vsJwHcdCN0F99/rWrArJL01E7N4WlVsN17++PEmsXvJsDXyqI57lv3wN5AfH51u9OMEElK/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896269; c=relaxed/simple;
	bh=e127u+qQSOGJGPkz/mL+VWi+USmEV7rZTPHon2Z6dTU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lN9WT1SLML6zPPa/B0AiNx4Lq8SXNN2xJ/N3EVjLq15UqPEvdLQvywMjsccSLraSth6PMnvEOsbdq+6u9+MDdDTV3PqwkVxwQELiJ29Xti+yuRqpv7N1U4REjk/CXWGe+Ac6XI+AQ0aabq1g9bWNN2Hi4D98ktbwXCK+zMSysy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAt600PY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718896266; x=1750432266;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e127u+qQSOGJGPkz/mL+VWi+USmEV7rZTPHon2Z6dTU=;
  b=AAt600PYjEPFJ2VZ4eeGKLU7KbSTWtdgaK4dYlHhdjQRnpnqMTdL3BKc
   SwZavzd+kGkKOwv32WjKKMbJuPJP8C7YBCzLRJlZWF7c4AxmeKzJRI3We
   kM8jx0W5YfldWaI7O7Ygd7CVMrlaXK3gionp9IDbTStNEHb7z9fF1IFKN
   Zj3cynW52nCp5bh9wdUfDpvfbvZfvpNXKfJqe95HJYESlXI6oafU6OS6j
   SkcsSXcWKxvKKUSTQk8nOR2NFosILlseJEWjV/6DdHXNBQ1eIWH1j31OY
   v9iuNRpHYou4EQlYX6uYtdlOAsHz1JxxVH1HardPAty+PVDyWDz92zcRs
   Q==;
X-CSE-ConnectionGUID: VfidYy9EQnezHPjYB+rNGQ==
X-CSE-MsgGUID: eMy5cg44SaO9I7FFfanf2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26476699"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26476699"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:11:05 -0700
X-CSE-ConnectionGUID: A3sBKWUaROWzxecLY4zG/g==
X-CSE-MsgGUID: nJ6IfGA6Qwe997xwVMHVPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42965446"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 08:11:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 08:11:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 08:11:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 08:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSjzO/KGmzv5b02ibjj2pvvwBB/QdrkniL7aj4xDaZ+EuO8Fu38PoLQTWh3HoTa5fIyAA50YhCJ8AoeKNcNLrTQFpApLdvDiJgQhxPZiqWDyr3UcW39EzI1GSbp8O40k74vKhjTqtdM1OHitlUpU8DZnWhItDt/fsuRqXwUhPQ+fw6vrCMHVEm/C1oZZ13AMafBorRmTzHa/lWQZPcpO2B/xbdQabIVeCZBnXehepxzTqw63Coor2ym7rPLzG/J1JOcuIDq1HsKM4PuZwnyKjU3ikzhJvqqMPUuZB+5Okn9B3OycAJasTFB40OINogWJ2luUaowBjSeaassa5sh2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJQPIE5v+NhA5ejkANJUh+K9AHIayyVEn2XH9S9E+IQ=;
 b=eb17xFUwmIcAs2mSh3EHRf7XmQleU0W4kpiEMjWmcbYW8WSHIVv2A6MXR2PNEMQhyo80S+oXIogf4UAVVEmWfOTLOOBmPXjZJBtqgF6dz1P+JioRFpC07xJtJfg01RBswM4u5gMldX9asXqQNgA5c2bwiaNREN5XbBFBdU4EdjsxEzSXHLDJH3cGmOYgsmkD3bhUvZ5Hxf/Mx9pCs6psIZdajiQn/AjvI3/QIf2JEkJItjH13twFfdz24QJnOHtBpGN20uaBc5ZKupFDA19Vy8OOrWdgeNfmdeCS3stkDjwFKXyln21cGFB769DqGyMAyuUpvJl10lvzgNCAoS1kTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 15:11:01 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 15:11:00 +0000
Message-ID: <550c50b8-a4dc-4b62-aff2-c90c398778d7@intel.com>
Date: Thu, 20 Jun 2024 08:10:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vmd: Use raw spinlock for cfg_lock
To: Jiwei Sun <sunjw10@outlook.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: <nirmal.patel@linux.intel.com>, <jonathan.derrick@linux.dev>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sunjw10@lenovo.com>, <ahuang12@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>
References: <20240619200039.GA1319210@bhelgaas>
 <SEZPR01MB4527666DDB8BC7C23B141BCDA8C82@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <SEZPR01MB4527666DDB8BC7C23B141BCDA8C82@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|BN9PR11MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3ac396-157e-4dfc-26bb-08dc913b31fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1U5YXcybWRKWlN2MWd4bU1uSXVLejlhMXhPNmJ3N1EraHB6R2VHeXVhWU9Z?=
 =?utf-8?B?RE1WaDhpaS8yV0pMNUlyQjRGNnhaU0dvTm50ZmYydGFKVmRSWUtIMWU5NFlt?=
 =?utf-8?B?SUU0MTEwZWdTd2tMZC9tZVdibXBKV2VOV3IwSFhaakxsZElqcU9FSklnZ2tC?=
 =?utf-8?B?OFBPSFlPRytsc1Nrc1haUlA0SFFxbXg4T2ovM0I5b250QjN6eWJKaEc3S3Jk?=
 =?utf-8?B?bzF1cHAraXkvbGd0QWRxZUJJMWowK2xITW11dlB5Sk90TTFJNDAvSUxWZW45?=
 =?utf-8?B?cDd6a2NCdUFJcHI5RmZrWXRkYnVrWkJuQVRsUktIQkhGdDVMbzJGdkZqOS9S?=
 =?utf-8?B?ZFdRZlJtZEYzY0lKbzU1UXJmdFkxVW50ZmxDVjFOL2JFYlBwNUdxcVNVZCty?=
 =?utf-8?B?d3pMTklSeHJlcm1IQXhwQWk1Yy9LRk5Mc2M4TTZmR0dMSEhGZ0JsbWtBaTh4?=
 =?utf-8?B?alh2cDJ1Nm4xVG9TazlGbkhCMGQzSUxSc1NqNENONUNIUGY2RURIK1puamll?=
 =?utf-8?B?NDc2TjJRdXVydmpTQzFDUCtmUHRTbUNCdTZXNitFaml3VXNiNnluTGxxa0Ni?=
 =?utf-8?B?NDFQQ1hPRUpKeDh0WFVEYzBDZlRkNkxvU1JtU3AwSXNyVmZ6M1Z6eDZ1QmxZ?=
 =?utf-8?B?QllUZ2wvYWxpR0lUa2MrWEpVMXZCa0dPVzB6eTcrVXlrM0YvRUNEYXlrV0pu?=
 =?utf-8?B?dzE4UjRpZWUwSFBuYnVlODNBdk1zaGF1T0xuRGJUek1vUmIxeUpBZmdlM1dw?=
 =?utf-8?B?QWhMVFM5YVdHQWlPaXo0S3pENHJUYk04V0orRVNaTVE1TXhOWWovdGlsY2tQ?=
 =?utf-8?B?QWFpMVhEZk9rVklYT0svNDBXQlhFLzJDcFR3b2poa0lqbXVkSTNlZkRMeHdE?=
 =?utf-8?B?amVUeGIySDkwTXAvVzFHTlV3cU9XaDBzTzdCYWNkT3YzenVvNVcvWEhPZ2tY?=
 =?utf-8?B?RnRjb0hiUXREOFNRVWJ1Si8vTmt6MnorcXpESU5MWEZvcFYwbmpBTHkrTyti?=
 =?utf-8?B?VmhhdytZeEprZlZqKzUrNjcrR2Q0QjZmMEt4MXBLbzJhVzYxdEY5OWo3RWZZ?=
 =?utf-8?B?VTVaSXlnN0grWlUwUElHNEtqTlRnQjRZejhRWGwzb3BsN2dkWUVLNS9xbmJt?=
 =?utf-8?B?SHloUmQrRGJtNWRqUEJOcmJGV3poc2FBdkJLbUZUbHJ0aFljajlNbVZVbWpt?=
 =?utf-8?B?QUZEazFsUFhjZlJIQXNQZndnaXVWMFBxQjIza08vSStVMTdGTWZiWmZ0OWwy?=
 =?utf-8?B?T1lXeXhsa2JweENYT1ZqZE1oWHFqdnArZFB0UFJ6NUE0TWFwQWFlVEFZYU56?=
 =?utf-8?B?emx3QkROekZEbjliTGlaTStCSEFmMnE3UHhhQW5sM1VZNktveTEyQkRwV05X?=
 =?utf-8?B?WmtNOUQyd3pNbThJWlNHdkNiOUllZjV3UlM3Q3R5ZnVPTnlRdktvUVVleCt5?=
 =?utf-8?B?bUJZVk5ZQUZxVWFwSnFHZFhxazQ0bHBJVGdjNEo3enBqT0Z4TVhCZ1h4aUtz?=
 =?utf-8?B?QXVGODVCQ25ERU80dnA3MlV1MGx1MzlSZFJSTjBiYmpyaHMvOG93WEtIKzBh?=
 =?utf-8?B?WEhiMkRGcFIvZWRxQ0dlWER0bFIvNVFsN3dHRThZYjRyTTE2b0FNZ0JGNXhC?=
 =?utf-8?B?MzNhRUxZQWZmUG5pUW8vdThEY3cwMzRRWGJTaDcvcnNscXdKU1RNUTJBb3kz?=
 =?utf-8?Q?D1YHbjxjH0d4TMzGFLiy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRhOWlYbVc4SFlLQ3Rjc05WbzRHQmpBU29ubUxENWxkTldheVpqLzZuQyt5?=
 =?utf-8?B?QXFyd3l4V0ppUEtIRXBLNWFxckNER2hpYzV1UlY5OHEyVzhmQ0haRUtaRWxD?=
 =?utf-8?B?b3hleWwyakM5clR1SXkvSUVWZ2o2b1paOXB4QmV4VmJqa3lGMzRoWjVkWWhR?=
 =?utf-8?B?U1F0eml0alBEVUhIVCtXeG5FQVc2aHdlTkQwTTUxMUpxQmpjYnhOaFp6cHo5?=
 =?utf-8?B?RkxuMVVkYVNuUkdtTmJpSzQ4OW9ORFVmUDQ2c0xsMDZxeVRDVlZpZkQyUFBW?=
 =?utf-8?B?N0llL2ZsMXc2OE11NE0wVWEwZi9SWGROWjBsWHVxcEIrZTZ2RWl4THZjNGUz?=
 =?utf-8?B?L2Z1TVFwaWsyamxxZ3RBUlpQdktDMjJpd2QwZm53Tlg0RWl4aWE0eGNNNjc2?=
 =?utf-8?B?QVhvNE53RDhHWDRJV0pXWlpWSlBMRVFYVEFSeWl4cWdzblVHajZ2VlFFZmZs?=
 =?utf-8?B?T0pJbS9NZWhLUGRsc090SWx5Ym40NG9TNmplNFVGbjI5ZU1YQ2IxZGZGODZq?=
 =?utf-8?B?S0U0QXlHdkdzYjc2ODlXVzJTZDFmRkhXYXo5bkZKem1rTkZ4KzhLSWNqdHhR?=
 =?utf-8?B?dmZ3eHl6a0dITU1BQlZva3I3WW1Ccm1KU3BPcllXTCtUbkJlQ0d6V0JYdUNo?=
 =?utf-8?B?S3ZLd0RUUi8xMXY2QkFzSkpqOFZJbC9UNTZFQmNiRTR2dTI4M2Z5MEJQT2Uy?=
 =?utf-8?B?aG1Gd1h6QWJ2QUtZejVDRThEdWlQdFhmM0dsNVlnVE9nOUFjWFpKeUhjcSs5?=
 =?utf-8?B?YTI0L1dyR3A3OVRRYW1VbTNwUEozK2VPSWQxKzcvRzU4SndEOUM2aGRrbTN5?=
 =?utf-8?B?RlY0WHBKTkhSMmdMdHZhVHRDcml0ZGdyUGQ2TDhwWVNBb2h6Wjl5dmxHc1kw?=
 =?utf-8?B?YlQ4OW1wTWZBeG4yS3E3UFFpbTlIeXYvRkkvQmVDZGNyS1pYODRkTFFKZDNt?=
 =?utf-8?B?Vk1xWkJxbERIM09LSFpVQ292MXZpaDY3K2tuWkpXbjlodmo4WVdmOEw2MGlD?=
 =?utf-8?B?VzRXa2RQTHQ1THJOb2cvMTdoVEphdEFUVEtOd0puKzE1SG1hS3F4cjVWaWtC?=
 =?utf-8?B?QjYzekdRQXNBd1VLSG82ZWJZL1JhQlRlcUZVeEZ3QlFvbG1aVVVjTWx3QkRH?=
 =?utf-8?B?OEJpWTc3dVNldmhDbGZjY05HVCszVHZSUFF3UTQzOGQ0MjNmTGRlZSs4eE1w?=
 =?utf-8?B?ZzVWZElVd0RlaS85QnZSMVpMUnI1Ny8rTlRac3ZoYyt1cEFYc1VjMWVhUmF6?=
 =?utf-8?B?NzVSbkp3WERUcU1EK1BBZzVoQUs1WE1XYVVjQWsydVRmaW8vemRvY1A4aUZD?=
 =?utf-8?B?a2haSjEwcSt4SHU0RzNlQVBnN1QvOGw5My9UN2JSOUltZHN4VmErR3NrMTN4?=
 =?utf-8?B?dCtsNCtacDh5TE04b1MwdjYzVFN5UnN0cGhwd0RXMTVtL3MwcDJZREwxaUdP?=
 =?utf-8?B?QjZpNCtBOUJwSWtvTmE1Z1lhcG1iRlhQblp3R3FPRERVRzNVZnhhdUd5MThz?=
 =?utf-8?B?U0dDNFVwTjJ3Z1JnS3lIbTU0WW9wZEdJK1FVK3ZuL3ZvUEE3SFpBMnh5RFpV?=
 =?utf-8?B?OVBHU3lPRU8xZFFVenJRY0lJenhRdzA0RWFSU2VEMDg1MmZZUEVhdmZmNU90?=
 =?utf-8?B?YThpMHJjMmw0cURpeWc1Vk5RQXkwbTA5emVTakxjQWtXWi9mVkFrRmhtRGxa?=
 =?utf-8?B?cDhDeERWSGZmQjJvR20rdmdwM0xNTXdwUjA3WnJXckdTNkJxL00rVWtEZmVV?=
 =?utf-8?B?dDZPcjhqVi9BTXI1b0JiZThhVm5NbUl6VTJBVFJVK2pXYTdiclFjRGV6MDBK?=
 =?utf-8?B?NGZFWHRGWTZIdDRRaG9mYVJtL3lWc2JtQm5nQTdpU25KNGRBUkpMMU82eHNY?=
 =?utf-8?B?R1RCcEx3VW1iV0k1REJ6OHpCaTdFZU93cGMzajl1MFZCZDJpL1BuZWVrd3hh?=
 =?utf-8?B?NlRFKzJRdDk3TUN0ZWtUZ1EzNEQ5RStMa09lS0M4TStRejRON3RSMjJpa0E1?=
 =?utf-8?B?UXV3c2NTOThJdUVNWjRnN01rTy9nMUw1bWRLU0xKc0laSHRKZ2N1ZFByUFBS?=
 =?utf-8?B?QzRVSHdabzE2cmk0bTN6eFMyMFBoY0dxQnEycWZ2SlcwVU1mSUZwSUhJQnJY?=
 =?utf-8?B?amROOWhka21GY1ptMVErWGRmSmwyWTB6V05PNDFyKzFDbGRoUlMxbFBWc21D?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3ac396-157e-4dfc-26bb-08dc913b31fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:11:00.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHS1ocAiTYTkoSnRb0wqyHjRvgpHqWKuRF7TMZ7qs7AIGTxvr+ejgDB6Jt8edHZUIlFeFhUaexq16qATJbKRze0fTl3BiqRBYMyhRmK/cis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

On 6/20/2024 1:57 AM, Jiwei Sun wrote:
> 
> 
> On 6/20/24 04:00, Bjorn Helgaas wrote:
>> [+cc Thomas in case he has msi_lock comment, Keith in case he has
>> cfg_lock comment]
>>
>> On Wed, Jun 19, 2024 at 07:27:59PM +0800, Jiwei Sun wrote:
>>> From: Jiwei Sun <sunjw10@lenovo.com>
>>>
>>> If the kernel is built with the following configurations and booting
>>>    CONFIG_VMD=y
>>>    CONFIG_DEBUG_LOCKDEP=y
>>>    CONFIG_DEBUG_SPINLOCK=y
>>>    CONFIG_PROVE_LOCKING=y
>>>    CONFIG_PROVE_RAW_LOCK_NESTING=y
>>>
>>> The following log appears,
>>>
>>> =============================
>>> [ BUG: Invalid wait context ]
>>> 6.10.0-rc4 #80 Not tainted
>>> -----------------------------
>>> kworker/18:2/633 is trying to lock:
>>> ffff888c474e5648 (&vmd->cfg_lock){....}-{3:3}, at: vmd_pci_write+0x185/0x2a0
>>> other info that might help us debug this:
>>> context-{5:5}
>>> 4 locks held by kworker/18:2/633:
>>>   #0: ffff888100108958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf78/0x1920
>>>   #1: ffffc9000ae1fd90 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x7fe/0x1920
>>>   #2: ffff888c483508a8 (&md->mutex){+.+.}-{4:4}, at: __pci_enable_msi_range+0x208/0x800
>>>   #3: ffff888c48329bd8 (&dev->msi_lock){....}-{2:2}, at: pci_msi_update_mask+0x91/0x170
>>> stack backtrace:
>>> CPU: 18 PID: 633 Comm: kworker/18:2 Not tainted 6.10.0-rc4 #80 7c0f2526417bfbb7579e3c3442683c5961773c75
>>> Hardware name: Lenovo ThinkSystem SR630/-[7X01RCZ000]-, BIOS IVEL60O-2.71 09/28/2020
>>> Workqueue: events work_for_cpu_fn
>>> Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0x7c/0xc0
>>>   __lock_acquire+0x9e5/0x1ed0
>>>   lock_acquire+0x194/0x490
>>>   _raw_spin_lock_irqsave+0x42/0x90
>>>   vmd_pci_write+0x185/0x2a0
>>>   pci_msi_update_mask+0x10c/0x170
>>>   __pci_enable_msi_range+0x291/0x800
>>>   pci_alloc_irq_vectors_affinity+0x13e/0x1d0
>>>   pcie_portdrv_probe+0x570/0xe60
>>>   local_pci_probe+0xdc/0x190
>>>   work_for_cpu_fn+0x4e/0xa0
>>>   process_one_work+0x86d/0x1920
>>>   process_scheduled_works+0xd7/0x140
>>>   worker_thread+0x3e9/0xb90
>>>   kthread+0x2e9/0x3d0
>>>   ret_from_fork+0x2d/0x60
>>>   ret_from_fork_asm+0x1a/0x30
>>>   </TASK>
>>>
>>> The root cause is that the dev->msi_lock is a raw spinlock, but
>>> vmd->cfg_lock is a spinlock.
>>
>> Can you expand this a little bit?  This isn't enough unless one
>> already knows the difference between raw_spinlock_t and spinlock_t,
>> which I didn't.
>>
>> Documentation/locking/locktypes.rst says they are the same except when
>> CONFIG_PREEMPT_RT is set (might be worth mentioning with the config
>> list above?), but that with CONFIG_PREEMPT_RT, spinlock_t is based on
>> rt_mutex.
>>
>> And I guess there's a rule that you can't acquire rt_mutex while
>> holding a raw_spinlock.
> 
> Thanks for your review and comments. Sorry for not explaining this clearly.
> Yes, you are right, if CONFIG_PREEMPT_RT is not set, the spinlock_t is
> based on raw_spinlock, there is no any question in the above call trace.
> 
> But as you mentioned, if CONFIG_PREEMPT_RT is set, the spinlock_t is based
> on rt_mutex, a task will be scheduled when waiting for rt_mutex. For example,
> there are two threads are trying to hold a rt_mutex lock, if A hold the
> lock firstly, and B will be scheduled in rtlock_slowlock_locked() waiting
> for A to release the lock. The raw_spinlock is a real spinning lock, which
> is not allowed the task of the raw_spinlock owner is scheduled in its
> critical region. In other words, we should not try to acquire rt_mutex lock
> in the critical region of the raw_spinlock when CONFIG_PREEMPT_RT is set.
> 
> CONFIG_PROVE_LOCKING and CONFIG_PROVE_RAW_LOCK_NESTING options are
> used to detect the invalid lock nesting (the raw_spinlock vs. spinlock
> nesting checks) [1]. Here is the call path:
> 
>    pci_msi_update_mask  ---> hold raw_spinlock dev->msi_lock
>      pci_write_config_dword
>       pci_bus_write_config_dword
>         vmd_pci_write   ---> hold spinlock_t vmd->cfg_lock
> 
> The above call path is the invalid lock nesting becuase the vmd driver
> tries to acquire the vmd->cfg_lock spinlock within the raw_spinlock
> region (dev->msi_lock). That's why the message "BUG: Invalid wait contex"
> is shown.
> 

It looks like this only happens when CONFIG_PREEMPT_RT is set so I would 
mention that in the commit message (as Bjorn mentioned). I also think 
thsi level of detail is helpful and should be in the commit message as 
well since it's not obvious to the casual observer :)

Paul

> [1] https://lore.kernel.org/lkml/YBBA81osV7cHN2fb@hirez.programming.kicks-ass.net/
> 
> Thanks,
> Regards,
> Jiwei
> 
>>
>> The dev->msi_lock was added by 77e89afc25f3 ("PCI/MSI: Protect
>> msi_desc::masked for multi-MSI") and only used in
>> pci_msi_update_mask():
>>
>>    raw_spin_lock_irqsave(lock, flags);
>>    desc->pci.msi_mask &= ~clear;
>>    desc->pci.msi_mask |= set;
>>    pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
>> 			 desc->pci.msi_mask);
>>    raw_spin_unlock_irqrestore(lock, flags);
>>
>> The vmd->cfg_lock was added by 185a383ada2e ("x86/PCI: Add driver for
>> Intel Volume Management Device (VMD)") and is only used around VMD
>> config accesses, e.g.,
>>
>>    * CPU may deadlock if config space is not serialized on some versions of this
>>    * hardware, so all config space access is done under a spinlock.
>>
>>    static int vmd_pci_read(...)
>>    {
>>      spin_lock_irqsave(&vmd->cfg_lock, flags);
>>      switch (len) {
>>      case 1:
>> 	    *value = readb(addr);
>> 	    break;
>>      case 2:
>> 	    *value = readw(addr);
>> 	    break;
>>      case 4:
>> 	    *value = readl(addr);
>> 	    break;
>>      default:
>> 	    ret = -EINVAL;
>> 	    break;
>>      }
>>      spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>    }
>>
>> IIUC those reads turn into single PCIe MMIO reads, so I wouldn't
>> expect any concurrency issues there that need locking.
>>
>> But apparently there's something weird that can deadlock the CPU.
>>
>>> Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
>>> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
>>> ---
>>>   drivers/pci/controller/vmd.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index 87b7856f375a..45d0ebf96adc 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -125,7 +125,7 @@ struct vmd_irq_list {
>>>   struct vmd_dev {
>>>   	struct pci_dev		*dev;
>>>   
>>> -	spinlock_t		cfg_lock;
>>> +	raw_spinlock_t		cfg_lock;
>>>   	void __iomem		*cfgbar;
>>>   
>>>   	int msix_count;
>>> @@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>>   	if (!addr)
>>>   		return -EFAULT;
>>>   
>>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>>> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>   	switch (len) {
>>>   	case 1:
>>>   		*value = readb(addr);
>>> @@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>>>   		ret = -EINVAL;
>>>   		break;
>>>   	}
>>> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>   	return ret;
>>>   }
>>>   
>>> @@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>>   	if (!addr)
>>>   		return -EFAULT;
>>>   
>>> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>>> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>>>   	switch (len) {
>>>   	case 1:
>>>   		writeb(value, addr);
>>> @@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>>>   		ret = -EINVAL;
>>>   		break;
>>>   	}
>>> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>>>   	return ret;
>>>   }
>>>   
>>> @@ -1015,7 +1015,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>   	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>>>   		vmd->first_vec = 1;
>>>   
>>> -	spin_lock_init(&vmd->cfg_lock);
>>> +	raw_spin_lock_init(&vmd->cfg_lock);
>>>   	pci_set_drvdata(dev, vmd);
>>>   	err = vmd_enable_domain(vmd, features);
>>>   	if (err)
>>> -- 
>>> 2.27.0
>>>
> 


