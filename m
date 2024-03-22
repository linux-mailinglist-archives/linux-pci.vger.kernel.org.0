Return-Path: <linux-pci+bounces-5026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D08874E5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF791F24328
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4582898;
	Fri, 22 Mar 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUTAGf9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095C81750
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147420; cv=fail; b=TwIS+fAo1IDasPG1yzwlH2Or+2wzN+5ITXU2mLtPYyC3yX6LRPuIu23a/1WBYdglcyV7F7UQqxia6ID45G7Dvh+xDQstVEYGJ3ZYiJNq4bdY/49O2LOxtIMT+fmI/UUR0CQIauS/s3xyGbyrgDH2BqHa+U56wEdzJjBGdsEc1wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147420; c=relaxed/simple;
	bh=npxVIDRjcpZ8d9LuD0UcmNRGZBvuzISc6bOX0O10hFU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pGFJ4YV7vYlinQdhV+5sgHg5COwTFHlrXbGqz1nUVLJ1HwV94+R5aN/K298klTYHJ6Yy7hMPuwdWiwEvbw1JtJmqeEIuv26bjCRbF84j7E/rcHVcZVZzFXPGS7sE2UDMFvoOgql59XL8ZHeEmKY/Zd1/ghuMnjT8niKCMwpyiuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUTAGf9h; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711147418; x=1742683418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=npxVIDRjcpZ8d9LuD0UcmNRGZBvuzISc6bOX0O10hFU=;
  b=cUTAGf9hDRthN3SsCGtxwvRNqtj0ZqzMvKW8RYWWSnTWXlNdWgZNAnSP
   GcqMsEW0lcD+xSqetew+uUKa+jEuq6J8/O/Ot43ehQcdR1K9H8dL0us0i
   KhU0uWpydcXeY0w1ah4fIhj09hylqfGK2iaShX3XW8eJw7dK/Fg5aET0K
   zUAgwAye0GKT+eVPWSz8BS/IrEp61VLCMdmrERaaRbrmUUwS+Y/j+fPuo
   E+piICmLItw1kOMcSUV9JJ06/bPzb54IVt+r/Jntbv8OhnBjECPiN2eHA
   NwfmkCHJPKUzXJnxdqOYr6LkrvToPRvpIJ+mTHgudH8EIH45rTZsS/++R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6327516"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6327516"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 15:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19732121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 15:43:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 15:43:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 15:43:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 15:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2vjxjT0hBDJVAnTt3JbUqbBpVAjAIqiHJA5LL8ZRrtgJ30SCNZCelGRrocewZnVadWg8giIOFqctPW4DQpRw6NfDvvinU6HYpzf1AAZbiTXErvz+Qe8Nc+L13n7wPsGFVDNas5phUiIKxfQFqHqVpNK/zwANiY1rtxbe1+zcCJTG/tRKzKr9MoM5CVwyk5kPfzyWcOUo6B49uQ/l4M23twOuOjTb6UfEYFSlWBGgknInj5xBlzhfKOnNqFY3hp4dJSdtmM2oO1rQjNIVl/XWSjSzNJa5sQ5VnazbFK7XmPecOVIgDOMmG84JyC6loXVjCXDqGlVHN6oHlNghLcM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9n8M1nrp3np+sdIeWGloLeTOGjMxHWXr6wwTMfOX9A=;
 b=nqi4C6+8L94dzjf9avSZug+g4nCH/+e4yJB8paAU0pnclLmL04qV/crZFFDpy+pVFTncULKtQ/DNq7gS6LdIZTuWgobKRZo4Xf4cdmZBIpV3ABEj6/eoFFOXreWEu8vdTxcAkRctH4nNhLHmAriOL6R63J2G0CCgBy1CU3XXCq6wE2mHerstz1cqH0/mlFF4XuHOwK+SiPpXMFuSVHU5g01cxw0MeAz9BbLvvrTMUnOAcywh4Dlcp20iGWoSIhOCceZvfsmhShrq2jKZV1XkSJa3EJOFduPsevgwCFMx4mA0rN4/n95uXQFkyj9kP/pyrO7mBHLECCqr1Ev3/a9KiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by LV3PR11MB8693.namprd11.prod.outlook.com (2603:10b6:408:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 22:43:33 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 22:43:33 +0000
Message-ID: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>
Date: Fri, 22 Mar 2024 15:43:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
To: Bjorn Helgaas <helgaas@kernel.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
CC: Kai-Heng Feng <kai.heng.feng@canonical.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <linux-pci@vger.kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
References: <20240322213719.GA1376171@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240322213719.GA1376171@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|LV3PR11MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a21a47f-3b2a-48fb-9f40-08dc4ac180fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KP5UTvK4pWAeLU6RBfwm2MRod/rhQdtcAEB+7d6GVwjzL+Nc20UbOy5usNP7TU5ZOmiPyDWObXutOdR77EVrNXrfWdziqfbovC9mRNXtZ1ihRCcROvAlwDmt4JPNPqlBdQBNrXGUyDo+3nVfhSaS+0IREBR3A949k9aFVeW6eDvTtAyGVJOWQTW5bAJaJc4j7Hb+CDjYoosxuklEf6zMdlO9TlwuBRT8pXhkibl7V9G/MRC+GdlfgdH+2aFm6jCIDdLt3I0WPMUYHXCEmta7VkP2fVwux4CIBaBI9VPELyKhd9i4WbjL+zaFXRgw08zs8x89tgjSoZ0evhcanLmu7i67EB07EM1CO3kxC142lJt5I+uI/GI1Ay5LPIi6eaIwAPW5wZXtoNMLNEE5XumVjRXcDoZ6pIwDEvSEnoj+wC97xf4G8hqUJGb5/jMmLZCzHEVycYsg+nbIPMwvv/RPbyhZaWhyT4+hvyozpLOmStbDQixmRJWgOumZRghHpgC6t9OmkiQtCzy6tGgSvZh5kIEz9ZhfAnXNvQXZGfWf/WqXftSKtLsX+S+unaBGNanqNaKOZgjciTLYGPg34Sl8LRx7sTh1AbXlhjvcafNkVUzYM9/OmGKdP+E/9o+7KrbpIhW6cBf+/vin8fkpkaFzhkyG6lqIWN/MxxljoCgerXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ttSGhVM1gveW9KVi8xOEJCU0ZIWHd6dnNXVWFyekl3cHBVU0drZFFNRG1R?=
 =?utf-8?B?UTdkM1R6SGpPaTJZenA0Wk15ZnYrR2FtSWlOSk1tUGRoa3JDcFJWM2dSYlNK?=
 =?utf-8?B?cWRTQ3A2L2xKSHRxN2diQ253MVJ1NW9ZQWllNVo4TUtDQ2VHQk5JQjZ6U3dI?=
 =?utf-8?B?c3h0MVU3eWpkaklRQzA0SGtEMDZqa1J2UlBUSUhtSkdoWnozQUpTaHFMcmlq?=
 =?utf-8?B?S2ZwdnpMZS9Gd0I2NnIxVFpxNDhCS21aTmhodGY2RlloU1JqdkEyUWR1YWFq?=
 =?utf-8?B?UklFaUhWdDR1bVZtNElZbEhmbSttQWVBN0tpWXNqMDZidFpLTXU5cnU4WElR?=
 =?utf-8?B?UUoxc0dwOUlheC9ENVFkWnpvOXRRc3ZJb3IybHZwTWpLSEVMTnNQZ2g3Y1lU?=
 =?utf-8?B?RE1VV1g0QUd4d0c4dU1CSnZJYXdBZjlCV1liTko2ZkxuRTB0K2tqai91cFkr?=
 =?utf-8?B?blBhYnRkQWx3ZS94MGZpbE1WMkRuOWdyWjFjc2N6N3pjMjk2Y2E0NG9tcmpK?=
 =?utf-8?B?Y09pSy96cHZmTEx1QnZuMm1EY1J6TjJ1VStVZGQwZkRLQmJNWDZhd0dBQjZ0?=
 =?utf-8?B?bWI4R0hmcnZPK1llVHd3UnpUdk5yOWJSNzh0dHgwMjMvZnc4bGZEb2VMVnB1?=
 =?utf-8?B?UzFQZjc4TDFYMHg3eitmWGRBRGVmeTRERjNLL3J3Vi9JQno2Z2M5Z0xFV2VX?=
 =?utf-8?B?QXVkdFBTSy9Sdjl0WGM1akxjN3JxQWZZMzErak5NWlppYlNjaWIwazZFZmoy?=
 =?utf-8?B?VVkyQ1NQemU4VUhlSUlKWHNFL0tWRnJGb3o2ajMzR21hUWtwcDFKUVc5N1ZR?=
 =?utf-8?B?MUFLandySm13RWRCM1ZzSVRianZlK1l0ZXd3M0hZM2M5UHo0S3hFbE1IQmRx?=
 =?utf-8?B?M3lpbHhST0RzL2ExUUIxWlBxSlQyM245TEdVeE5oTEJGY3RYb3ZDK0xPMzlG?=
 =?utf-8?B?SnE0L2ZtdGNNODZKaCtVM2twcXZYK1dFUExDeXBkNU95L0xSZU54Tks0Zy8r?=
 =?utf-8?B?S3UwaGIxdkF1TENoeW1yanFRcTFqZ0tVTzVVc3VwaUVzbHU5djUwcm1TVTRJ?=
 =?utf-8?B?VUpKZXF5SEFpL3loR0NpZVJKdU5wWmVyWWhDWGhEcWkvZWlOL2lTUk9RT01U?=
 =?utf-8?B?L3F6M1BlbFpERGNycGJpU2hBQ2Zrd0hBVkttK25tc2Q2YVNVT0JEczl4b0M1?=
 =?utf-8?B?UEFZOEhNcENRTTV4Y0pjY1VqeG5Cd2Uydmc5ZGhxOGZxSWUvQk9JOWl4czhJ?=
 =?utf-8?B?R3NZK0hWcUkvNzJrTVU3UVFQa3lwcWpCSjI4ZVk1R20zMk16MHA1SmVRODQv?=
 =?utf-8?B?SGRRL1oxU1dVSmpNZXVnTnZYc080d0M1VjFHNnlPUTgvaVk5MStObVR3Q0ha?=
 =?utf-8?B?Mm1CTFBBQmFyeUFSVHF3QWJNOGRFajZuOUU5eVd2aVhwQStmckVmWnN2TmdD?=
 =?utf-8?B?eks0ZEJwRTVFNkVsQ1UyMStWa2xIbmxZUXMrdWsvZVVtL3Vwb3FUNkRQWmNP?=
 =?utf-8?B?TGlMRncwRXJGYTdDUFU4aU9CU2haRzJnRzVhVWRLRW13dWdNREZRK3pOWnRQ?=
 =?utf-8?B?UHBQNE9zYzRpdm1tdnE5cFRvK0VIT3BlZGNjUUtwd01xUmR0bWExSXoweXdC?=
 =?utf-8?B?OS9XU0hndk1YWjkxNDZEMmFNZU0wTXBhdkNlVjZ5bDhjdDZDSXJiWllIZW5U?=
 =?utf-8?B?MCtCQUx4aVFFcnRMdDh5R2EzVUJCYytPdnhwa0lCNXFQRWxZZCt3cXp0QUpZ?=
 =?utf-8?B?K2R3TXBNWHJvOFdUbjFzRXRHelp4blE3S21pdG5QeFIzcExEZnZtSEt1bGcx?=
 =?utf-8?B?YnhoQmNEL1gvbVNTeUsrL0NYRms4cVZ2czlqc3F4TUxwbXo1aDJ6eDZBbDE0?=
 =?utf-8?B?em9IYVdXMGpuU0htMVZjNE1iSStVUlNYTWZnMk11dWZQYndXZmVqZ3U3ZWVS?=
 =?utf-8?B?OTJ6S1BTdXJPSlJOeENWcWxhbUY5RHpIQUMxZi9Tc3o4TkM3VS94MVprQnhR?=
 =?utf-8?B?S3dLcnY4emNtTysvWFJuWnZuMnlESzhaQ09kV1BiNURwNzI2ZWhqYlBRdk9S?=
 =?utf-8?B?TnlOQnJMU1kxd3BCRHJCeEl1bWlHdjFiSnI2ZWkrd2ppZGpmMlVFOENwaElG?=
 =?utf-8?B?T1BoeSt0ek0rY1NJbU1ZQVVxU2NaeDI3OUFDMXU1bjNxejF3cHlQWHNsU0g5?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a21a47f-3b2a-48fb-9f40-08dc4ac180fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 22:43:33.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aV/tMdKprGhdd4bAIj0AW4kOa3BPYKr+kfMcDj7mhUkceKj0djMCxWFzFMoiedhtbeTTD73jnTcjTPr4Wx2I2tTnooABP0jIoSnPZENnMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8693
X-OriginatorOrg: intel.com

On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
> On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:
>> On Fri, 15 Mar 2024 09:29:32 +0800
>> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> ...
> 
>>> If there's an official document on intel.com, it can make many things
>>> clearer and easier.
>>> States what VMD does and what VMD expect OS to do can be really
>>> helpful. Basically put what you wrote in an official document.
>>
>> Thanks for the suggestion. I can certainly find official VMD
>> architecture document and add that required information to
>> Documentation/PCI/controller/vmd.rst. Will that be okay?
> 
> I'd definitely be interested in whatever you can add to illuminate
> these issues.
> 
>> I also need your some help/suggestion on following alternate solution.
>> We have been looking at VMD HW registers to find some empty registers.
>> Cache Line Size register offset OCh is not being used by VMD. This is
>> the explanation in PCI spec 5.0 section 7.5.1.1.7:
>> "This read-write register is implemented for legacy compatibility
>> purposes but has no effect on any PCI Express device behavior."
>> Can these registers be used for passing _OSC settings from BIOS to VMD
>> OS driver?
>>
>> These 8 bits are more than enough for UEFI VMD driver to store all _OSC
>> flags and VMD OS driver can read it during OS boot up. This will solve
>> all of our issues.
> 
> Interesting idea.  I think you'd have to do some work to separate out
> the conventional PCI devices, where PCI_CACHE_LINE_SIZE is still
> relevant, to make sure nothing breaks.  But I think we overwrite it in
> some cases even for PCIe devices where it's pointless, and it would be
> nice to clean that up.
> 

I think the suggestion here is to use the VMD devices Cache Line Size 
register, not the other PCI devices. In that case we don't have to worry 
about conventional PCI devices because we aren't touching them.

Paul


