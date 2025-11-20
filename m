Return-Path: <linux-pci+bounces-41714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB07C71EF0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 04:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7CD0346E08
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA7288C0E;
	Thu, 20 Nov 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMKoq7B2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE59247DE1;
	Thu, 20 Nov 2025 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608238; cv=fail; b=VLr9LdP1s6WrZ0RUf/xBtBs9S/54BBDRwB3HcvszP8AVdySNdVmmqRgcOBfpK88TPeAs1dmyjTV7FbwyZzQCSmpCBeuR3ZaGT3cX9S2OTz2aGP4LWg2fC0o0vi3M7Z+xZjwDxFumXuIbFzlKDvsl6ekwryKjLwrL0sBEMBgq7Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608238; c=relaxed/simple;
	bh=WfNCebIWSTI7KOQ4AC2EG70jPqnWadfCwgIQFcQr+LU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=r2EZTArp0oGB2HEypv+2LGchQEUjZ/CnvIlfQmdlcyNDfCLDiWPt84G4MFpleHq6OUSJdzOZ/Tc3UT3iHnFLvSSKnZNQ2n4L5gm0oY4MTatybgeJL2533lnl5yrONYT3OGUDFjrOcpmnfQeUPuHt7iFHkS1BQzLWWO0KWoy9FYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMKoq7B2; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763608237; x=1795144237;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=WfNCebIWSTI7KOQ4AC2EG70jPqnWadfCwgIQFcQr+LU=;
  b=TMKoq7B27jvfR42r7BSH/2tJLA9aKNy8aNfcPanp8iSkv1MBS05olOKW
   HnAjBaqJ0u50NRx2H3gMUgiLAKliHv0umGz3f2oKW7mTYfS5cAPEVdJGn
   zPhF6ABF7tAN+1HdpioZ9JfxooN2CSdu0TlBexGdr/doOSfymugdrs5Ug
   cGoM+5tBjxW9eqmC4IKm9nr4MmucZupnUHBjEFIY0m+7Qhz3RKJPsPlt8
   v166iMyHNLvcnSUwxUOPPS3hKWqXTp0VfUh2o7OlV2HenwGfuJKrw30yN
   wDHzz7VVlefVvhda+yzuslkc02hbl6Yg7hMGqm75tXz2xdmZ5i4LRuJnB
   g==;
X-CSE-ConnectionGUID: LR2dvM5nTieiu9GwnuOvYw==
X-CSE-MsgGUID: Wf9luaZVTsad9em9WLMbfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65605067"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65605067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 19:10:37 -0800
X-CSE-ConnectionGUID: cfvFGj18QbqkKiLBbNtx2A==
X-CSE-MsgGUID: CNhg78IfR8SfvvpF8mb60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="228553860"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 19:10:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:10:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 19:10:35 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 19:10:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I74G75xsWONQDfzG0SRgF1xvmpjrunI2yzBZOzX6O/DH6uwhv9Mb6rMKjJhks4neW7qvZsFed66hs3rB28rNJ62ARa8sKET7a9ppJM95iuXgzRggKGsvQT0aBH6sQtJFTSkVjEtk2H5Czyct/SfxypTAmGByF6ufiN7DPBw7TsZG9y1P6gOR47jS5BZQbQr0jHz5C+B+7xucnmaOnfp6TbcQ7841PZTcGOlJkWqFbUd1Artdc3/KH8hnh1tLsMo+JtlFupR9v2PfjcB0Q5yaDkL4T2nZw1fMP+3coiBJFJrx8WIRr8xoXnDxSg/2HOW/0z0YT104BUnUQSPXU5ldPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UOJ0kY83+PpPigbc0KoU2o48HjcztyEgdYddElc17A=;
 b=S/tkaA9EhD3D5X5IuWyzbRoYwM3jek0dCq0IUHJw/WVWGfiZU+ISEJmheVf7QKidyY6oGlUqlP9PomLDaM1tYAJTbwteiewz8orxp6q5Qh2P9/v3BHkh81kMAIr2XMwQlhzr60XIza4FapH9slUwHU6L87zpDDefy95G2sWazj2cdwlcY89mueAJ2wlyramkxs70bKOY7QADK+uJhtmkMfP4O+QeMilLKbBHdxIjKLwxGBdyEQrg28rWBmfKa45P6pogYVT7vBnS91HOHaZGr2Js+1ECrvgyNNVS+WXmPAe8DCmMbAfNB+37tVqAD7s0HAEpil97oR8WpTZkf0ETbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8147.namprd11.prod.outlook.com (2603:10b6:208:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:10:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 03:10:34 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 19:10:32 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691e86a8a1cb5_1a375100fe@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-26-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-26-terry.bowman@amd.com>
Subject: Re: [RESEND v13 25/25] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 945b854c-9dd8-4a8f-89ca-08de27e25eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXVKRWMyckdET04vUkQ3Kzg4WkNCRU1Cck9VcHVMeXNvNHB2NVM2VmZYQVFY?=
 =?utf-8?B?b1RuUWFzWWJEOVdLK3FjWXhWVkdIV0k1SG53Uk5lV05QckhrQmVEcWdleGpi?=
 =?utf-8?B?SldwV3pubko4eWtINE5UUytIeDdMSHRMK0NPdEtpclNMaGhhVWhtNmx0TFlK?=
 =?utf-8?B?bjlYdGxPaEN1VklaYzBkQWQ3eHIxdk1ETGlwTk10eW8rSElXQ2tKam5TZzdw?=
 =?utf-8?B?WXFBNHRFV3k1Z2ZueXhib3UvdlVyMmNLanQ0TWJJZm5PYlVyZWZBM3l0K05G?=
 =?utf-8?B?Rkh1aFhwM1gvd1BQZWZnZncrVWsyak5jcEdiUkpwVnUvN0dNc2hQUGUyZksz?=
 =?utf-8?B?VzhpQUlBYkNPdlVUdjNLZ0RDR1FrMGNhVEpSZ2s1Zy9heXRIKzc1M0JZaWxZ?=
 =?utf-8?B?UTczT0toNWNYV0ljYlhmQ3dzOW1EZzYvbTI5NnVoSnNVa2hpQXlZM0tyR0dG?=
 =?utf-8?B?M1lySmR0V1pxc2dPMHJjYVpMdmNxTkxZVDE5WTVta0ZUWUxFUktiT1JxeXBY?=
 =?utf-8?B?dE02SGFsV1dJbnpqSWhUWUthNkNLZnhvWG9TSFQzUXBiWWFrOGZ3aXVqVS9E?=
 =?utf-8?B?MGZhaXNqbElESkVyZWxuK1N6NlpTQitnYVpDcERXd0svUUxIaDRJVk1sMkc5?=
 =?utf-8?B?YllNc2hKNDVncFZ4bTFlVjEvTjRnVzJvYStOekJUelpUOVVQK3greDRhQ01o?=
 =?utf-8?B?TzduVGpyNkFDWjlGdktGeDlSL2dlZWxFSjBnZ2VUTUtiR0FkT3psVnFXeXZ6?=
 =?utf-8?B?U3NUSTlaTEh6NFRnNWx0VkJQbGVjMWNNajNaYkpIRUxKaWtxWkp5eDJTbUla?=
 =?utf-8?B?WVBQMHhLUVEwTTJKbG55c3Urb1dIMi9jN215VG1pMWNzUEZNVDFaZkUzNHky?=
 =?utf-8?B?WU5KRlozN0E3b2ZMblBVZDR5TmRWM0dnd0F6MUZxcUNkZVpOV25iSzhuaFRZ?=
 =?utf-8?B?WXp6OU9UVzE2K3UyWEx6MWViYlFONDZZMERDek5lTUl0Zm13TFBWU0p0U0JU?=
 =?utf-8?B?QnBMNE9iWDErVE1hSldBVEUzekNnaytwYk9JRXIrcWo2ckx5a0psZU56UTFx?=
 =?utf-8?B?VTU2cG02NzA2L1VTNmE0dUxsaVJEdTlMSlRyeUttL3JSRWVVQTVST3NjSFI5?=
 =?utf-8?B?bk84azFBbEJkK0twYTFOUVlqb2dpNGlHem5zYlloKy9tZUw4RkxuNjlVa1Q1?=
 =?utf-8?B?N2lVdFBzcFVGRzVpZEt0cEFvQWFQVDYvQk1UNHI3RGNFVEQzTXhYMksyMFJo?=
 =?utf-8?B?OVJZTWplWEpXUTdxMkd5VnJveGMvajRHNVlxY1dzZTN1cEFFaERGSjd0am1Q?=
 =?utf-8?B?czR5UXcxQjZjckRCV0J6OXM3bEoyVVpBbXBOSWdMNTJDMEEyZk45aGRXZUIr?=
 =?utf-8?B?WDZQYnpraGlERkoxb1lBaklzY25vd2xCNVVkRlo5NHdqU2hVSmtGZTJ2R2U3?=
 =?utf-8?B?Ry9xV3d2aFpWeGNrM2l5bFlZWlZYSUVTSk1YNEQyOCsyblFHUFNZY1VqUkg1?=
 =?utf-8?B?OFM3N1VFbThuWncyOG9wcldCbzlZSVIrMFhsK01xWHJYTDJyWlhSNGFlYnlh?=
 =?utf-8?B?ZWZtT2Q0bElaMlY2cFpscmJRMjBEYVNQUWNhWDI2MndxNUtINW0zeEZCWkNn?=
 =?utf-8?B?NzErbXRscTk3S09yQzRZbnlEdWMxL045Nk1RbXpDR0tldVU1UWgvZ2xyMGxX?=
 =?utf-8?B?VzBCYkFNVitUWXNGN0NTRmtoVUM3R3JMVTBMaU9RbGRNREVEWjhZUGUydFpT?=
 =?utf-8?B?RlFkZWNVZDljWUNBalhpc2VaNzc4cGlPdlpaV2JyUFdvU3FzWkNQczg4U2to?=
 =?utf-8?B?YWNYeU5rK21PU09ldFdDWnhGazRORDk2a3JwMkpja1k1U1dYcitkc21VcTl0?=
 =?utf-8?B?ckMrOXBJWGFyeis4R0k5Y3ZYQktWZzEveXJkSVdwajZxcjQ4Z1hWVFc4YlBO?=
 =?utf-8?B?SkNOZm8rY0hLNVJNWjJVYjhubC80L0VLT25vekYwYkhQQUJjWHhwVzJ0Yi8x?=
 =?utf-8?Q?vjyeROmuNJ5ThVWZ2LYqEJj0kxEEKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVJQWgwT1VlSTB5MXFHc0I4V2tLMnovY0RlWGEwTE1QT1BTdUcxRjJOTzA0?=
 =?utf-8?B?dFJ4R2pJZ3BpcjU1VmZpRDhwaFRMZkpKVmtSZzNyUFQvMkZBdWdXZGpVVjM2?=
 =?utf-8?B?S0x1cUZCU0o2NGxoaUZHbWFwM3ZkNDBhUE5WQlMxS2ZUeG5Ra2tEOW9UUVFI?=
 =?utf-8?B?ZHUvdnl4RU16Q0hLZkIxVkVDNHprNllBSHFCZFVWekVzNXVzcy9DU21xdVNE?=
 =?utf-8?B?UFNMc05RRjgzWHRsQnNzTkl6MlNZK2IwaXE5S1h4R2plMHA0VHhQc1E1NGpB?=
 =?utf-8?B?d0w1WFVTemlOdXBsdVZOb3lOWlZ6cnNlQjVUZzRnVlVITzhZcGJXT0pxZ0xH?=
 =?utf-8?B?RW13TEdKeTh5ZkQrdDVIME50b1ozS0w3S1RBWG9QVzlKYjJETFo4eXZkU2Rx?=
 =?utf-8?B?Q3gySE9kWnBtQVJGOG9xMVZLZDFxblV6Z2d4S20xT0wvL3Y1TnRKK1E3ek81?=
 =?utf-8?B?RTgzVGlkeGUyUWlHY2N3YVFqTEU5cjI3eGNKS1prblBRY24zUUNoK2g3Y0h0?=
 =?utf-8?B?V2FWdWZ0clptRFB2c3hnM2FFMUJFMCt4cnJJaUJHbXhuOEs1bW5Mc1d6U0RK?=
 =?utf-8?B?NXU4WHBLQVVveWJWVG9CUXljeTNQQUxXRjJQekg4OVFONGwxcGpRdzFXUUtr?=
 =?utf-8?B?MUkrOU5peUNnU1dwNmJ6NUxaVTZ6MmdxL3pISUN5bmpWemFzaXc2YmZpcUVk?=
 =?utf-8?B?OVJDMkU0MExJWWVndU83TEY5UHl1Y2RsYWprVHVTMnlTQVpBL3kya1AzYmZa?=
 =?utf-8?B?bFRMUWpZMkJzb2R0azJvUVRLVHR1VlVIdS9xWm5CN0xBRFptcEVwVlpIUFE0?=
 =?utf-8?B?NTQzenFvTzA0MVNyR2Q1MTZIa0R4cEVnbEoyakdBNElhSytsL1ZKc082Ymh3?=
 =?utf-8?B?Rjdrazg5dzRoeldveXBCQ0FGSEgyMUVOeldsYkxGbWllOVVWdE9kOS81WU9T?=
 =?utf-8?B?NWZNdEFpM3hweHBhRXJpNTZTMlVVZU43NGxscnY5L2w4TEs2bTQ4bUdqZXRq?=
 =?utf-8?B?YWQzQlFWMCtlcHJmOGowSmE1YkwreEEzcVhkQUFVV3R4YldDY0dDQjFGTzZW?=
 =?utf-8?B?RTRWamE3WCtZWEJTZXNITkVuckZxUVVEMkNKaDFJdVYrNklDSWVsUE9Xc2tj?=
 =?utf-8?B?ZGNxUFFDc2hNNklGRGVDKythVFVBQXZQeWJFNTlMVlNiZFNIb0hPM0VNb0hW?=
 =?utf-8?B?UzlkZTkxbjk0OGg4ZFF0bWU2cnM4eUtNQTZrZ0hsU256NlZiQXZhb1RQZzZU?=
 =?utf-8?B?RTJJOFF5UERmOFFnbjBpV2xMZmZpWm5zeFM4U3pCNnZjclZjVkwvSEd4U1dw?=
 =?utf-8?B?UkpwSHZaZnl6bmVYVW0yeVRkTGlXUXBCVWhTUG1WNXRPUWlQVzYyY2E0ZThi?=
 =?utf-8?B?MW9Cc2pteDlxZ1VWMEY1V3RvZ2VITFdLOG9MSnY4bUU3MWlhOWNITXFuSUJ5?=
 =?utf-8?B?YnNmQzc4ci9mbkhLaFJwYUFyVDhEZHVnSWZabzN6MWFXTkMrak1OQjJUSHNn?=
 =?utf-8?B?V1o5Z0lUdHBmUXlVVEdXQ1l5MmhBQUhMUkw2WU16ZVpGeTJDOFdvVEdicTdK?=
 =?utf-8?B?R3BsRkxVY3RRWTV6bjg3MVg0SFNEMEZEcE1GWkNMckR3OFlBeXo2Mlg1Vndt?=
 =?utf-8?B?YnRsZXBWUEpHNlVXOXcwWjFidmxHLzFwdUhEa080NnJ1K21ueTB4bG95NTR6?=
 =?utf-8?B?MldHTkttN2g0V1BBL1QwVFB3SW9RbEs5Y1FQZ1FZcEhGY05GWE1UQkpYMFIz?=
 =?utf-8?B?SkwrdFFGV0FKbkRYdWRKWW9wVGNDNTJYTDROMERHRWQvRjdRVkU2RGlTbmR1?=
 =?utf-8?B?VmlneEdQS05jL3NZb2JpS25BbUVGZnpsVXExOUZ2YTZaeUxJTU5nNmxoYVVN?=
 =?utf-8?B?bTBJcXhvdk1nOUNqaloxeWJrazhZdDVXQWZRWUdra25JUHo1dTI3RldlQ2Jw?=
 =?utf-8?B?TDlCdE5zeTRiVkdmNGpJdTZWL3Z6M1JoS1JOeW5EWEJidXlXeWlmb1pCVTJi?=
 =?utf-8?B?cUJFWFdSTXptMFlXekc3a1AwcG1EbGFoMjkyYmt1NUxSWTFVNTdCRzhVcnUr?=
 =?utf-8?B?L2lkNXRaaHEwbTd2N3VKYkI4aDU3R0k1R1hVdXNISGNlKzFtK2tiWGIwNnRI?=
 =?utf-8?B?Y3N3M1ZiY2l1QnRBcjRhYjMxeHlyRjBrbkJIbnF3c1duN2hiZVFZRlVPVHdY?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 945b854c-9dd8-4a8f-89ca-08de27e25eb7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:10:33.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxMyE0vihcn3AXwwMW8Ot/PfYqCE8cKhIA7Tw5CeNKx1T9nLpd6kCjbc6PYmXoJiYu0aN/PvEZybqYSUuSwkWPSIYnWx4S8Jmzi47fnzPzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8147
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> During CXL device cleanup the CXL PCIe Port device interrupts remain
> enabled. This potentially allows unnecessary interrupt processing on
> behalf of the CXL errors while the device is destroyed.
> 
> Disable CXL protocol errors by setting the CXL devices' AER mask register.
> 
> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
> Add to the AER service driver allowing other subsystems to use.
> 
> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.

This comes across as too much special case sprinkling.

If it is just the cxl_port teardown case then the simple answer is only
enable interrupts at cxl_port::probe() time and disable them at
cxl_port::remove() time.

Can you clarify the exact nature of the unwanted interrupts because the
PCI core does not manage AER interrupts in the same way. It only ever
enables interrupts for root ports, so I am confused why CXL needs to
manage interrupts on a per-dport basis.

Maybe cxl_mask_proto_interrupts() is misnamed because the device is
never enabled to send interrupts. I think is just mask AER events,
right?

In any case I think this belongs right next to the code that maps and
unmaps dports. The endpoint case should be handled by the endpoint probe
and remove handlers.

Also, if this is really a problem this patch should be moved earlier in
the series before the kernel starts unmasking these new event sources.
Otherwiwse, a bisect run will start hitting spurious events if it lands
in the middle of this series.

