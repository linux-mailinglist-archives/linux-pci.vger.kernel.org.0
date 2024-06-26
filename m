Return-Path: <linux-pci+bounces-9309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B68449182C8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458E81F22F68
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC221836F9;
	Wed, 26 Jun 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f4GghCfb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA911850A6;
	Wed, 26 Jun 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409207; cv=fail; b=JrLNj3pnsGzbkWO+gJb9asHHJsdAzSryYcCoI8dLq7jEVNpfs0xQPG9k2fWwKDmvbx8ZiFI7jlFXUK2W4ks3L3RHiIH7001MceKPhS4ncGCHvzTD7gPh7uhc7z1USzU0MXF6LH1VyvbC29gIcZ9AJQoABD5LDDzHiTD3A9of1So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409207; c=relaxed/simple;
	bh=M4HB0t0wYauoC/jZ31op0mwDO67GMXmPulNVCbLFBzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFz4iioRDUUD386l50I9DEURIH0cBwUvTenzOg8l9/v6vDNBGoFZib6bckVY0fCCP/1UmfnaNWD4zvvybg9Z+Oa2wT8YPpPSmbz96MUkVuqzpFPC53OwlSCOfzHmp+EY3SwstEQJLjW1kwLardj9Qu2x2V2Gs6EWQZCOowtwi9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f4GghCfb; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA32gIrT51JYQelzz/ds4vPi21d0s8VsHuwZwDjqmaNEreFmlPOAz5I2iSN304FMl9bKBVXGj5afY2Mze4U2x6WM8ivu8lYDKqa+V3xd5pSEMScCEwmb8CEt/qce7okOUFuHu+gP3Z49/dod0H5QBnihXMt0a54gh5q/WYF/+WrsU9IxceMSRZAStw+z8iThRp7Ye1Rx7gLdpKpH6mvcR5zb3IBMjjVQgdve0bVq+TjkKfgtPPcML64SfORRTdnb/dCcMVrXR5CjGB2ALvptvQVR0jCmg6gtnpxOPaM/vSDWkRCLWbIw/h9I6d7bvJ1JXgbXSyXWFLcFhqGqZontDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLAtXGFxVtCXZRPlXF5DGkimhz4+JqUBDQf2dY26IRo=;
 b=bZexS1TpCFEBIKYh1g/6nLTH+Pl+8AdUDpu52ZDZKoi9iQgkqImdN3+RL8WcuzPkgEFQTiGL3bWkYKKjp4WO+j0gucCl3Mgzq/yMTbBpsIIm8kQQuohGgV0bLSeGCnf5H8L0qC+e+fxjPOGetDgYGhiB7KGValvRZuzS9H08Z8V0eooQhFG+mFIlqkVvyVdjEkG8hK6EKS+yrQLL3w02VAad2qwp4wukiZTOwY7nXGhqrfEoeTvSrH98NrBmAmBVlF1lAht30JDUItW1EElKiG8ikqsSB3QM5qysmVhxZ+YJpXwRp+SG5VEDFITYQurj+h+zHW3KpLSdkwAk0KLtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLAtXGFxVtCXZRPlXF5DGkimhz4+JqUBDQf2dY26IRo=;
 b=f4GghCfbkPYo+Lwz+9mp2QlFeaJn21JmkOmTGQzWzWKzsXAijAaHwyKF1Tsw29ntlfK8BswuDJeiBG7VkuSVQdDSPjmuStMpKOmwoxobfEVnpjIdnOi/rdVVoui6SJzp0+Q/R82z6eepstDJ6an+rx8wSCKmauCttemG57+1hJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 13:40:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:40:02 +0000
Message-ID: <89bf0d37-5b13-4527-b9de-a2773e0259f4@amd.com>
Date: Wed, 26 Jun 2024 08:39:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Schofield, Alison" <Alison.Schofield@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "Robert.Richter@amd.com" <Robert.Richter@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
 <6b1bf5ab-0005-4c88-99ec-92edca828f44@intel.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6b1bf5ab-0005-4c88-99ec-92edca828f44@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:806:126::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: df3efb0a-c28d-4f34-325e-08dc95e57af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|376012|7416012|1800799022|921018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1BZGJvRlV2QjJYZlNFVXloYnlhUGN3MXpkYVJOT0ZHajlGK0lsejNuTDcz?=
 =?utf-8?B?Q3JjcXEwS0xQTjJFVGhVMk40OHpTZ0k4cmd3eEFrR3R2YmxGbDNZaDJ5YWcz?=
 =?utf-8?B?NE9DVytXQjJURmx0bU8zL3hId0xqK1RBRlZkQkZxMXZIa0NMREZUVHVzck9Y?=
 =?utf-8?B?dXdiYzdiVHV4ZStOM2Z3OVVTWWQ3Y204cjFEQmgxNEV5bzlFQitkU2hGZkFu?=
 =?utf-8?B?Q1FYU253VTYxQTlQbE9Hd09CVW9rcTJwUFViamg2MlByZzNGRUYvVTk2V1NU?=
 =?utf-8?B?WWFuNWhnaUtqOUhlNm5oWHRuVGkyL2VyQjNwQ1BxTEd2Ny8wZThEVEk4ZzV5?=
 =?utf-8?B?V2VrNTJCV2owbUJmRFJUTmJMYVhpVTFZNTBBVDlsbjNHZE5GMzh4eGZjcjBP?=
 =?utf-8?B?ZjFPRXhKMmc5bTM5Tlh1a1FaQ3NNd2VWZlFnNm9QcXZjdURWYWpqUDY3b2FG?=
 =?utf-8?B?UHZZNzFFZmx0VjFxUC9MRHErUXJQY29OdE1VRGpPNUhESk13SXR6S3ZxenF1?=
 =?utf-8?B?b2sxYUJTVmJ5SlY3djZySzJsMXplSGVrck9zTjNHUWFjRTU4UnFqUFZpSXZN?=
 =?utf-8?B?cEppS0V6T3g2c1lRVUpjaVVULzNkcER3SXdaRUtqcnNuUVZyMmtadXp0QlIz?=
 =?utf-8?B?YUVGNEd3OHBDTTZxUXAwVGtJUDliMlFSaG9vVW1OZlVIZldtNnpwYkYwVlpt?=
 =?utf-8?B?MENkZlQ2QnJIQU9va215alhSQmgrZGIxZ2tzakxOU1pqSnlNU2RmU2sxeGM3?=
 =?utf-8?B?TWxmaVdXUllzbTlsVE8zRHdMTUIzc3pVQkFzcWFmSDRWdS9JVHMzUTl2b09G?=
 =?utf-8?B?cFdvcmNVam81NDliUVdKU3EyZUdzaGswdHJMZTlkbStheVNvb0pQM3k0c2VF?=
 =?utf-8?B?dkkzUk84MHBVM1c5eW9ZMm1SSGdGa0tJaHhydGtPL29JaW85d25kYmdxZmN3?=
 =?utf-8?B?SGcvc2R2c3lsN1hKdUZDdjZRbGpBWjlUbEpWZi9SYnJ5ZUdYMU1SU09hVytT?=
 =?utf-8?B?akdIclE0Qm1FMWdGSGQ4a1V5WmNnSlovM0FrQnN2ZmF4TWc4ZElwL0NHSEtE?=
 =?utf-8?B?dGxNeUZBRERtWXZVT1BsdEhxOFZlS0g4azdVOVlEQVNlTm1xZFJVWFdkN1Rw?=
 =?utf-8?B?bHE3UktKYkNQSzU5KzRHYkVKVTBSM2U5ZUpWMnQzOVp4dWxVSkZHQlJybjl2?=
 =?utf-8?B?Y2FDYjJIZmNwa1FpQlBJTGI5RW8zUUFkRWRnTEREcUx1V1h1aEJzVUc2RnZW?=
 =?utf-8?B?MHFBYS9RNGxWSHkyN0hBOXpwM1gxeDBaK09VdjkvK2M0amh6MHpNVXVFblQ5?=
 =?utf-8?B?NlI4RVhSNitGVGJMc3VWbXFQL0xEU3o0Z1lHTldkcDkrYTdPQXNkMXlNRjhn?=
 =?utf-8?B?QVJlSG1FUmp3UUpIbkpzUTlVMmw1OUxTRGNKbFpBQS9Bck54SVFoR3h3ejR0?=
 =?utf-8?B?VEE2MnQ0VnpGelEzTUZub2tFai84UDVoMWJDWCs5Tjd6T2VOWHQ5NDlVWmpG?=
 =?utf-8?B?WW4ycEdZUU9mN1dIb1J6K2ptWmE1REtYcmVMS2RxVXpYM2J1RVJnamZYSGtq?=
 =?utf-8?B?WStzZEhxYzFSck5uQ0pnSmtEbWR4b085Mi9UckM2WVg0RXlGUFZnYVB0UHgv?=
 =?utf-8?B?UW0xaldHK1h4L0R2YjFrY0wyNVQ0OVZReFR1T1RLdTFZeDhmeHI3a2F1S2Mr?=
 =?utf-8?B?NmZmTk9ERnJyT2JCNUg5eFNzT1g2THdlaFBhMzJ4NTUxWXBYWlVDeUgrL2U1?=
 =?utf-8?B?RXJ2WkdBWGRtVnFFaTgxeGZpRllVY3l2WXk2NVdid0I4N053NUE2U09adTVR?=
 =?utf-8?B?dEh5V2wrZ2lSb3NyOFlZSEUyVDNMRXZwRS8rRUt6eDBKcXhoL2lEZXdCNXBT?=
 =?utf-8?Q?uWE4tr2bS82B1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1AyVnUyU3FMbENSa2dzTTFPdGRteERueEh3b3VWTXJWZ2ZwSjJSaU43V1Jy?=
 =?utf-8?B?aEFRZVNSMUdaRXpWWjVsekR4cDhDZXVSWmpvV2xpWGdnU29pTFFIbi92MVFr?=
 =?utf-8?B?L3B6Y1lEb0ltYzNIbHlGSHlBRFg0b3R4TWUyb0lLN0dSVGhsQjh0M2JHYzl4?=
 =?utf-8?B?M21IYjdWbVZUb1FGV0FvOEJhbUlMVGFmZW52bVh4RDhsMFVFc05TcERQVEdZ?=
 =?utf-8?B?WkYzOVNXc3JtWEhkUXJ4dVVmRmJRdXcydCt6OE9OMVU1YVpBVHYyWTRtOWhV?=
 =?utf-8?B?S09UaUtnWmxDTjRGZGN1MmQzY1VKS0xmU0tFcWtvUTVNb2kvZmhGWkorOXJ5?=
 =?utf-8?B?U3pKWkFFS2lERFo3NXhQN3JLYk5qRU5OYi9JYkMxWCtKWHZnZGhlVDBUUDFU?=
 =?utf-8?B?Z1VkaXk2OXF5c0ZtVzVST1lseVV2dmwrOTgvZTgrd0JvSC80aml3ZzBtNUxB?=
 =?utf-8?B?UWM0ZWtLK0J1UzNkNnJ2WEVLOXNWVWppZ2ZleTFRQWZhRXh6bTVIWW50STlm?=
 =?utf-8?B?Qmx2QmJDUjZpbnhkekRBWHgzM1BvWXIxb1NwSkJ2UEhDanJIVmFCbnhEYzhH?=
 =?utf-8?B?VjZMWm85Q3FjakVpT1duSTRuY0V1OGY5WW9SalYvS2F2WE9MdEx1OUdYdm9m?=
 =?utf-8?B?QzByQW5rMC9sWW9lcHJ1S2VjVThHS1BscE1RSElwM1h6S1RlempJQ1lJeGw4?=
 =?utf-8?B?MkdERTlZNG1IZ0twa2dkZlpaeDZYcVVXU2xMVkdRUURTM0NhRm9xTkNNR1JX?=
 =?utf-8?B?YVhQU0w1dEJGOHE2OEJHWHhyTUdIanUrR2FQMWhGRFRqTDBxdU9CNG41NSts?=
 =?utf-8?B?SUkrd2hlditYQzJFb0ZJZFNMRE5vSnpCRmxPcURFU0FoaDF5MkNjeTdyZm9u?=
 =?utf-8?B?Z0wyUktqZXA2alh2Z2NDTUhwV1VqOGFlbG84NVJhWjJJd2pqbUdWNmplNldM?=
 =?utf-8?B?ekh1d2dVVExZM0NpZEhLMXV0RlI4UnVzMExZaWZQdUJyUWlxeXRRZWlFcXRr?=
 =?utf-8?B?Z0xRamhuQ2g2bVlyN1dwOERFdEVWSWltZDI4L0ZubXVGd2txK0RGWFpUcG9Z?=
 =?utf-8?B?SzRKdUpadlpINTMvalRaRFAzdVlaU0swNk1EaXdqYUsyQ3ZsaEV4YzEvRWJG?=
 =?utf-8?B?U3FJN0dUWlRRNmU4bXR5ZHFVblZYRGN1YkNCaHhqZXovVk04NW14RDZiVHQ4?=
 =?utf-8?B?cnJKQm9PUUJNNWtxOXk0cGlMaDVaa0FCSEcyR0M0VEo3ekVpeDhBMEtEWC9U?=
 =?utf-8?B?UVppbm1Odld6b0Q1Z0hnNlRFSC9aMzJBb2kwVWllNUJlWmErM01pT2t3VTRX?=
 =?utf-8?B?TFdoTjZlb3ZMdXRvSFJMaDJZTU56UUtVSnQ0QlY4cG44MGVQYWY5bXRGbWtV?=
 =?utf-8?B?VmxVdlQzWWUzWlRaWVBwVWJLaDhFdmFIVTkrU2dXQkVBWWI4WlBQam9BcG82?=
 =?utf-8?B?ZGlZVG9Ta3JtT1JvTEtIVDBDd1F5OUNIbWdFMmk1Q0Z5ZlhOVUdVMXEzUzVR?=
 =?utf-8?B?VkVkbm1ZcjRSVE1TRFp1ZEFRTDNuVHBMUUl3eGw3WEIxS3I3MGJBbnBVdVlY?=
 =?utf-8?B?UFFya1JMRDRqTnJBNzZoR1BMeEY4bzdyemxNTEFoTlVERFNQcjFObm05NlR2?=
 =?utf-8?B?Wks1aXlEN1M3YW9vNnlyTExDdDlpRERIRmVkRUhvaFNJVit3UVcwRUhEeXdt?=
 =?utf-8?B?d3Q3ODVTWit1L2VEM0RpWFhmSUQ2WCtvR3BQV25HNDhBQW0rWXdvRUg4RGZU?=
 =?utf-8?B?c2hYd3cyREcyRERwRkF5VDVDdmFlZ0ZCK1dxc25YMnozWWhJbUpzUkV2RGJi?=
 =?utf-8?B?YlZxWVZlc3FaRUUzV293cmlTcVFpL0dtYWZ4U2J3cllvaGRiSUMvUzVRbmY3?=
 =?utf-8?B?bzRJNzVxQlhqSmNxbjVNTFRsbFlISjRQcmlaVTRPZHgwakNJbVV5NlpzK0F2?=
 =?utf-8?B?THhvQnVtOWF3b2M2NDZQRUZHNEkwemw2UllLdnRON0hPNEJtZEhRL2pLckIy?=
 =?utf-8?B?eG1pVlBGTU0wN3lxTVpDaWRUT2V1TUpOS21jTGFRcS9tdHVOM05oRjA5UG1l?=
 =?utf-8?B?Y2YvZnpsUmdlcTBaaUNSVkZGVm1OODZpOGZ5Qlk2Q1JWQWgwQ1dXTHBrazNE?=
 =?utf-8?Q?jbUz91HzDA26WJiK1qgj9hr9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3efb0a-c28d-4f34-325e-08dc95e57af3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:40:02.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH67sAKGs2oiHPB31gHBuChnF9haDtIFoFf0r255U78gq0qySd8VLP0JcDEEbCMEWzl/1kVZSzSnrC9DVniHkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378



On 6/25/24 21:54, Li, Ming4 wrote:
> On 6/18/2024 4:04 AM, Terry Bowman wrote:
>> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
>> does not implement an AER correctable handler (CE) but does implement the
>> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
>> in that it only checks for frozen error state and returns the next step
>> for recovery accordingly.
>>
>> As a result, port devices relying on AER correctable internal errors (CIE)
>> and AER uncorrectable internal errors (UIE) will not be handled. Note,
>> the PCIe spec indicates AER CIE/UIE can be used to report implementation
>> specific errors.[1]
>>
>> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
>> are examples of devices using the AER CIE/UIE for implementation specific
>> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
>> report CXL RAS errors.[2]
>>
>> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
>> notifier to report CIE/UIE errors to the registered functions. This will
>> require adding a CE handler and updating the existing UCE handler.
>>
>> For the UCE handler, the CXL spec states UIE errors should return need
>> reset: "The only method of recovering from an Uncorrectable Internal Error
>> is reset or hardware replacement."[1]
>>
>> [1] PCI6.0 - 6.2.10 Internal Errors
>> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>              Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv.h |  2 ++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 14a4b89a3b83..86d80e0e9606 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>>  	u32 service;
>>  };
>>  
>> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
>> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
>> +
>>  /**
>>   * release_pcie_device - free PCI Express port service device structure
>>   * @dev: Port service device to release
>> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>  					pci_channel_state_t error)
>>  {
>> +	if (dev->aer_cap) {
>> +		u32 status;
>> +
>> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
>> +				      &status);
>> +
>> +		if (status & PCI_ERR_UNC_INTN) {
>> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
>> +						   AER_FATAL, (void *)dev);
>> +			return PCI_ERS_RESULT_NEED_RESET;
>> +		}
>> +	}
>> +
>>  	if (error == pci_channel_io_frozen)
>>  		return PCI_ERS_RESULT_NEED_RESET;
>>  	return PCI_ERS_RESULT_CAN_RECOVER;
>>  }
>>  
>> +static void pcie_portdrv_cor_error_detected(struct pci_dev *dev)
>> +{
>> +	u32 status;
>> +
>> +	if (!dev->aer_cap)
>> +		return;
> 
> Seems like that dev->aer_cap checking is not needed for cor_error_detected, aer_get_device_error_info() already checked it and won't call handle_error_source() if device has not AER capability. But I am curious why pci_aer_handle_error() checks dev->aer_cap again after aer_get_device_error_info().
> 

Hi Ming,

I agree this check should be removed. 

Regards,
Terry

