Return-Path: <linux-pci+bounces-12296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CB9615AF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4C1C22FC2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3441D1757;
	Tue, 27 Aug 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndb+LTX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD331C6F54;
	Tue, 27 Aug 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780619; cv=fail; b=bSLTUagOwQc4pDQfBDxcNZ4qPfmCuljOgCsyR5qxWfszpnxzG8ktIA8wLH7Zte9Fvlw+iZm52HL9AP/QyZthcN2Ok7ZMraHQC0aRpX6sOjknMi70JlVDZgvaeAAcSB0BTdXmYSELhLgcrjs7ZXRtRyHnUf0+RaIVgJXmeRr47X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780619; c=relaxed/simple;
	bh=uzS4goNjFP/rHoYzJoJhNMg7AUIEjn9Fd/lfrqVrCOI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4rtqMWIvgZVUSYjZFjUZbUm3flr4E63YPpufWjfBXRdk6NsXlNKBcIkEmho5ZN2GoiSrSf1tQ7RBz/f0yhGGEp235m/JVvSDZAvStxTRisSeKBDmIqrKwDBBx+aesZXAdgNcc144L107hqSAP+IqlmiEZhijERod1JHpI5hcWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndb+LTX7; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io9uwOUZQs7RamPg8ciTgfGaCbyFzlOnIPz0XZPiTtLq7CXMk8HAoZKRzWe3BZZKx7HaTvsvEu2ulL8y5U8ZIlejYbMyT0W5HI9M7OhBpUj5dN5kJWVGZE9I674x3zMGBFr+bVN21veu6DYhD4kfyeETHrb1avJ6+Iqiph8xPjoR1IV0tYwKLHc/JbFwMd3+JT2e14oMr7t1LbRbPvHA5JRJQ2VzWBi+0tWPSLndRC1vrNiBOF98+CauCJfq979cLHRcdGLrrm89ScQX3bNQbzAFLjQohYj75PaXNDp5dgiZy2RUTGFAojEooMXWhO2mMfvq3+EU5reOilvFLTrKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6vJE7yCTbdyuLGaptTU2dJ0qphzRwiPG4OXDcHuT9w=;
 b=f/GXBrojPi2er7szI+asj2bgcRrin3UTMBLMhoo8Ol7o/3AlzZ+QES8ngJM1gugcUHa43+OZEUVeU4UznSPo7dQrc1b+gSE6d1hm495TfmMSG7U+u31iHsqb5Xq5T7LbIzzBgb2WyVoPokZCQydenv83whGGdnN9PlgAJuWDX+xFRLW5sl87OgRkd93G4wJ8IO2T0gtf3f8EjRI5VWBHw9yMMELWdoIWHLRO8/lKT6D0L3x1SEJlIXuxREBXFx9TAKXLHNqNtygqvZUae9x8pAGQXMubB/7EZTtLzOHAVNi8kTs1cCdoPlAwM9+5AZSQwPNInEx6BQbeKtK412HyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6vJE7yCTbdyuLGaptTU2dJ0qphzRwiPG4OXDcHuT9w=;
 b=ndb+LTX7LMf+IgGCbSyeQPn00lYNy3X+WcoBm7yXEGtWyuqbBmSO/spEzZ+IaqCZqypfBLTFTt2v/1RJHZEfY2d9wTvLNZXJiT/AXq6GFu9fJmtjEMC7jGqND6+T3xu2gXdrl/WUY/KeImD4MyqNBHRO/9M0a09/ZAINt9RO4J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:43:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 17:43:33 +0000
Message-ID: <1534611c-5e36-413d-b8fe-ac29cccbb10b@amd.com>
Date: Tue, 27 Aug 2024 12:43:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Mario Limonciello
 <superm1@kernel.org>, Gary Li <Gary.Li@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Duc Dang <ducdang@google.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240823195400.GA377553@bhelgaas>
 <f43d44f2-004d-4b67-8db9-2f474c3e6d30@amd.com>
Content-Language: en-US
In-Reply-To: <f43d44f2-004d-4b67-8db9-2f474c3e6d30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0155.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: e0dfd0ad-0dbc-48df-6eb5-08dcc6bfc587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjdLM0FoN0pQRnFWK2g2QkViOFhzejh6NHpIOXgwRjFFR3hsdXFtOG0vVnlC?=
 =?utf-8?B?SGg2S01rdFp0QkhiaGdXanR6YkhVQWFQVVZ0L3BZVFdrN3dxQUx6b0Rjb21B?=
 =?utf-8?B?K255bjFVT21neGVESHUyTThIejA5ekJoUG9veithR25pNVBvUzJSWitOSkRT?=
 =?utf-8?B?T2dENkhLaDcwK1EyaUxxTThORi9oNVpjVHRkVlBaK0x4L1dEZlA3N0dZSEhT?=
 =?utf-8?B?NGJNNmd3SlY0T0FHWi9aWlRoVGUyblppSGxwa2hzV0lhZjNTdWE4c0EwTHVT?=
 =?utf-8?B?bmxySU1NRzhWRHlPeklRU1F6ZzMzaWNta3FGaFUwMzROUG1oZ0IvaWNaeWNN?=
 =?utf-8?B?OFNPQkpLdk1zbTdncXR0N2JnMkdPcitCTXZtSW1qaGJGQXVZekhaOEd4QVl6?=
 =?utf-8?B?QlM1UWNvRllYTlVZOGlmTjRiNW1OV1o4bVZ5RDRGVStvTjdrSnhxTjBlYjgr?=
 =?utf-8?B?OFY1Znk3TVY0NnBGV2dkdXRSL3FBZE1qeGtOaFFneG5iUEtKVko4WDhabU9C?=
 =?utf-8?B?MTlOUVNYUWVVWnJKMXJaY3ZPOHREa1ZxZlZZRlJHeFpzUzdwejZ0OEpaUGNQ?=
 =?utf-8?B?QXVFWC90alZYL0RndVlHbWROaHN1d3lUTzd5cmZsT3BzN3RBSmliaTJBWmxp?=
 =?utf-8?B?N2VrQmJESjVIRnpza05LTm01K2JSVms2a3Nhd3FkbGlFQmdBRDRaR3NWVGpJ?=
 =?utf-8?B?aHh6YklBeHY1TlNpUFJPZmxFVnl5b2Jjc3NQa3NxVDhTMXE5M1RCbG5yN3ZK?=
 =?utf-8?B?YW0wQzRtREVKNVpXcThmSUFwbjdyVTZPZE5zNnI1cG15OEx6WGlBbG1lcldZ?=
 =?utf-8?B?Qk83RWZ5cHQxb2N3VkwyL21Zci9mdkFMTmpCOGxkdHp0N2NEK2t3cTZFVEtv?=
 =?utf-8?B?UjNXSDRTVVltNk5nU0ovMGdhN1d4WHFhZUNKSDVmOFdJeCt0Y2YrK0s1SS96?=
 =?utf-8?B?TXNUT3FWamhQNmZBM1JWMTB4VE80SFcyWjlINXg5cXpJTTd4U01rRU51Si9i?=
 =?utf-8?B?VU1vR2VxSkQzeFRPZ0Q0RzJFdWZsNFd0cUxsbGhMQW4vSDFST0M0c280YVZq?=
 =?utf-8?B?QjRFSVZIS1lzM3Qwd3RMa3Q0aFFIaHNsUldHdUlZQlZKYjVseEsxNnQ0M3kz?=
 =?utf-8?B?a3N3T1lXbzhjRkRGMFBTOWJEcTJINUVLcE0za3dXY3FYQ2ZiK2JSdy9WY1I2?=
 =?utf-8?B?UGhTTnlqM2thaGFQNnBFZ3F5eGlXRElVcS8zN2VXWmdhUG54czRVV0UvUnFq?=
 =?utf-8?B?aGtrNzA0QWxJWGlYNDA1VzhmQnN0LzZrc0pQZ1ltaG5PUGZETmg0WGJRTis0?=
 =?utf-8?B?Ymk1ai9oRmVDMEJURUxXTW16NFZKWHNjYktVa0hFRGRBaDhYcnFJSE02emdz?=
 =?utf-8?B?a3Q1ME9qSmlKTlpmWG42VVVPV1FIMmorTDNUTjJqNklVVlZJSDZwYXpZM0pm?=
 =?utf-8?B?RlVGb04zN2RTRW1yaFRTNjZ6MUJKNmJXVlB3d3RJUTNyR1h3cWlRZS9WTk5u?=
 =?utf-8?B?YVNCTFh6Z2drcFIyVjNnaXl1ZXdKR0J2cWx6SmxHUmFjUWdZc3FjNFBPSDI5?=
 =?utf-8?B?RFpVdlRCdGhLVzlqQ0pRdWx6M2lrdnhvalhVOEJRYlQ2c09YMG5UTlpqZnJO?=
 =?utf-8?B?dmlkZDJDTlZmdUM1azZySU1VWmQ3bUJHWnpjRmF2MENwZEQydEFJSkdxNzd3?=
 =?utf-8?B?RkRZRmVCdklpazlWUmhMemN2VnlMdjRlSW8yU245UXlKR2U2UEtYbEFrR2tx?=
 =?utf-8?Q?HatmURu2znVKJFcgEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHl4eW9PcUdwa0JjK0hYZkx1VzcrNlVxU1RLTzdza2w5QTArMUZ4dVFCbVpt?=
 =?utf-8?B?UW41WkdaMWxwQlRiQjlEbk5NQmtPTDNNRDk4TUNyUG13YXoyRWFOU3djTXYx?=
 =?utf-8?B?ZjZOYktmSnRwMmxOUmQ5ZzdIbmhvVFFIQ1E2dUxnenlHdTI2OHZFM0pyb05a?=
 =?utf-8?B?aEpRSUpyL0NFbmVtV2JpZzZZUEQvR2xRVndVelp0MG9CSlgvdjdYVDU5TW9Z?=
 =?utf-8?B?d0ljallrUk1HTkZOQTEvRndHNXR1bENaQTVRK3lLeEtGTnZBNjlmMWJmcmxN?=
 =?utf-8?B?YUJhcEkwSm1vbkgvQmRkT3BJZEc0dHgrU1dZRGJMekpkK1hKMWtTaEtKZnpv?=
 =?utf-8?B?d2c3ZVNDOEp4UzdUYkUyeW5EbjlQcFBEOFFaTnhSanhiUUdOamxGY2VnU3Y0?=
 =?utf-8?B?WVhnVzA1MXB5a09FOUh0OE9VS0lVWTZXZnhvZTRVUkYvOUNqRnZXNWhqMW9w?=
 =?utf-8?B?WlRvT2xvZVRTUnpYa0dlMHRpaEVWbE1wTDVvL0hzbUt3dnVVZHJRS1lQNHpp?=
 =?utf-8?B?R3JIc1pKNDd5bzNhdWJ4UGtFTXkyYWt4UDRldHVyY2I4NTVTUGw1UjhHb0FP?=
 =?utf-8?B?WkREVzVPYUxYZFUrdmxMRSttM0hvTG9VMU1EK05ycHk3dTVsYTIvRUpqVVBE?=
 =?utf-8?B?Y2xUZ3pYb1Q3Rk1FZlFyME11TldaSmRmZEJBb2lJUjBkS3lPYWhwUXRncTNk?=
 =?utf-8?B?WFJWZFl1NTZOTmg0a3pTRGZlWWxZY3hCMWxsZVljSlh6MVVZQ3Vlb3FxS2xI?=
 =?utf-8?B?TVFiVlFzaVBBVkZQQjVxQ3B1QzJpaEN1K29oMXZUeHRJNGJhcE9vTmEwMGd2?=
 =?utf-8?B?VjQzSkxTMUJ5eXJTeGQyN2IzQ0IxNTVqRmhGV1NFY1QrdFM4anFWMFBFa3o1?=
 =?utf-8?B?cSs2bWcrTGhDNkV0WE45ZjIzQWVBRU9QS3RRNTlOMFd6MHdpRTlFY3lPcmk5?=
 =?utf-8?B?NDhsMWdyUndnYTZWU01wTmxUTUdhUHdTRmxxcU5GUXVrczJTZXdUQjRBeUpt?=
 =?utf-8?B?ZURueHdJSUxGSTByRjB2UnBUTjZoRlFzMWxvelk0SnE5bC9LSEV6TEd4SFdZ?=
 =?utf-8?B?M0hWdDlUVEJjdjZ4MHE3Z3BuK1cra0JaNGpJOHBXNmpmSytvcDh3RmdZWWpK?=
 =?utf-8?B?N2ZTTzI2bjJodEFNcE1DMVRybTRENzdnM0k1UmlmOFVPS1ZZQ2VLeUljS28v?=
 =?utf-8?B?YmpCWnNZbkVvUGU3M0NKK3YycnNsYzNqWGQwV0VkZyt3MVhkY0Nsb3RNNVFR?=
 =?utf-8?B?R0NlNnBCMVl4S01ZYVhvblYrWnZWR3ZJQVIzeDA2VW5acFkyc1BWVzJsbGV2?=
 =?utf-8?B?MWkvdTdzT2lOblJGYVhSbEk1Rnl3dUZWa3pHTVJZd2xNTXlyTkdmUVcwNWJJ?=
 =?utf-8?B?Z2FPbEZyMXc4aDFFWE9SN3IrZEh5MUhOeWhVNkRNZS9mYS9qb3E4RVU0Qjkw?=
 =?utf-8?B?SzFHdFpjZGNsYW5qMzMrdllnK3RlM3pmN2NPNlJOaFVYK24wVERVVUFPaW1S?=
 =?utf-8?B?Nm9ONnRNSHlDRE4wVVFSOGRIdWlWdDlLajYrekNMN0JMdXF1dVVmNmcvWW1r?=
 =?utf-8?B?QXNTMEdsbUhRcFdHQXNEankvbGxuV21odjBKZE9XdW1ncXI5V292SEhHZW8x?=
 =?utf-8?B?RDlWNlNFbmcxY3djWmFrR1NsTllvNksrSitjSTJRdEFrL0s0SUJHOTVoV1RJ?=
 =?utf-8?B?NDFwL0VoWXkzbTYrYTRqT3RiMTl3WGVqTTQvZWIzWm85SDlHOHlIN3B0RWQ0?=
 =?utf-8?B?ay9waGZ6SHFZejlmTHZZUkFubnN1S2dpSDFJVFFETHZoUGJFTXhsYno1Ry9L?=
 =?utf-8?B?MXNpUU1Rb1JiYTgwL3MxWHhQdDBLRHF3djJPYkNHOEc5dGdGcUIxM2RHZzJT?=
 =?utf-8?B?WDM1RS9CUW1aT1VWOVFJR29pRnNzQXpCVU94UVMrZ0E3RTVtSXNIMXJ0T1Fq?=
 =?utf-8?B?bmhzOWRiTFQ2dlVHOHhyMWNXdU92Y2ZIOFJ4VytOdDd4SjdLRWltZUFGTXZE?=
 =?utf-8?B?bDgrR3ZpN05ycm5HeFVlaFRRS3NuaU1UUjNHbUt1SFZ0Smg4U1RRY2JXbXc5?=
 =?utf-8?B?NWZsOEtKMmY3R0Fkb0FveFA1NnFLUEUzZWhFdnd1dy9udUFjNW9NRklicEVv?=
 =?utf-8?Q?PcZKuR4MJt/S0SUGvW0ge442B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dfd0ad-0dbc-48df-6eb5-08dcc6bfc587
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:43:33.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejtTUDji3wNRjsg3zZtgmpXPhPhXG+rEFHArnQaKxeyScZnlaMCwTajwSlddY+JviItbaJL4Qphgf6GiADljnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

On 8/26/2024 14:16, Mario Limonciello wrote:
> On 8/23/2024 14:54, Bjorn Helgaas wrote:
>> [+cc Duc, Alex]
>>
>> On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
>>> If a dock is plugged in at the same time as autosuspend delay then this
>>> can cause malfunctions in the USB4 stack. This happens because the
>>> device is still in D3cold at the time that the PCI core handed
>>> control back to the USB4 stack.
>>
>> I assume the USB device in question is in the dock that was hot-added?
> 
> No; it's actually the USB4 router that is malfunctioning.  The CM 
> (thunderbolt.ko) thinks the router is in D0 already, but when it 
> attempts to do a register read it gets back all F's and it trusts that.
> 
>> This patch suggests that pci_dev_wait() has waited for a read of
>> PCI_COMMAND to respond with something other than ~0, but the device is
>> still in D3cold.  I suppose we got to pci_dev_wait() via
>> pci_pm_bridge_power_up_actions() calling
>> pci_bridge_wait_for_secondary_bus(), since I wouldn't expect a reset
>> in the hot-add case.
> 
> As I said it's the router (part of the SoC). The device never 
> disappears.  It's the action of plugging in/out the the dock that causes 
> it to change power states.
> 
> We didn't try it, but I wouldn't be surprised if it could be reproduced 
> with a script that turned on/off runtime PM on very tight timing around 
> the autosuspend delay.
> 
>>
>>> A device that has gone through a reset may return a value in PCI_COMMAND
>>> but that doesn't mean it's finished transitioning to D0.  For evices 
>>> that
>>> support power management explicitly check PCI_PM_CTRL on everything but
>>> system resume to ensure the transition happened.
>>
>> s/evices/devices/
> 
> Thanks.
> 
>>
>>> Devices that don't support power management and system resume will
>>> continue to use PCI_COMMAND.
>>
>> Is there a bugzilla or other report with more details that we can
>> include here?
> 
> No, unfortunately in this case it was only reported internally at AMD.
> 
> Gary who is on CC brought it to me though, and if you think there are 
> some other specific details needed but are missing we can see what else 
> can be added to the commit message.
> 
>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v4->v5:
>>>   * Fix misleading indentation
>>>   * Amend commit message
>>> ---
>>>   drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 1e219057a5069..f032a4aaec268 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, 
>>> enum pci_reset_type reset_type, int
>>>        * the read (except when CRS SV is enabled and the read was for 
>>> the
>>>        * Vendor ID; in that case it synthesizes 0x0001 data).
>>>        *
>>> -     * Wait for the device to return a non-CRS completion.  Read the
>>> -     * Command register instead of Vendor ID so we don't have to
>>> -     * contend with the CRS SV value.
>>> +     * Wait for the device to return a non-CRS completion.  On devices
>>> +     * that support PM control and on waits that aren't part of system
>>> +     * resume read the PM control register to ensure the device has
>>> +     * transitioned to D0.  On devices that don't support PM control,
>>> +     * or during system resume read the command register to instead of
>>> +     * Vendor ID so we don't have to contend with the CRS SV value.
>>>        */
>>>       for (;;) {
>>> -        u32 id;
>>> -
>>>           if (pci_dev_is_disconnected(dev)) {
>>>               pci_dbg(dev, "disconnected; not waiting\n");
>>>               return -ENOTTY;
>>>           }
>>> -        pci_read_config_dword(dev, PCI_COMMAND, &id);
>>> -        if (!PCI_POSSIBLE_ERROR(id))
>>> -            break;
>>> +        if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
>>> +            u16 pmcsr;
>>> +
>>> +            pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 
>>> &pmcsr);
>>> +            if (!PCI_POSSIBLE_ERROR(pmcsr) &&
>>> +                (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
>>> +                break;
>>> +        } else {
>>> +            u32 id;
>>> +
>>> +            pci_read_config_dword(dev, PCI_COMMAND, &id);
>>> +            if (!PCI_POSSIBLE_ERROR(id))
>>> +                break;
>>> +        }
>>
>> What is the rationale behind using PCI_PM_CTRL in some cases and
>> PCI_COMMAND in others?
> 
> We saw a deadlock during resume from suspend when PCI_PM_CTRL was used 
> for all cases that supported dev->pm_cap.
> 
>> Is there some spec language we can cite for
>> this?
> 
> Perhaps it being a "cold reset" during resume?
> 
>>
>> IIUC, pci_dev_wait() waits for a device to be ready after a reset
>> (FLR, D3hot->D0 transition for devices where No_Soft_Reset is clear,
>> DPC) and after power-up from D3cold (pci_pm_bridge_power_up_actions()).
>> I think device readiness in all of these cases is covered by PCIe
>> r6.0, sec 6.6.1.
> 
> Would it be helpful to you to get a dump_stack() call trace to 
> pci_power_up() the specific call flow that needed this fix?
> 
> Gary is able to to reproduce this at will, I think he should be able to 
> gather that using an unpatched kernel to help this conversation.

Here is the kernel trace with a dump_stack() and a printk of current 
inserted into pci_power_up() right before the failure occurs.

https://gist.github.com/superm1/cb407766ab15f42f12a6fe9d1196f6fc

Also the failure is visible right after.

> 
>>
>> If the Root Port above the device supports Configuration RRS Software
>> Visibility, I think we probably should use that here instead of either
>> PCI_COMMAND or PCI_PM_CTRL. 
> 
> I did check and in this case the root port the USB4 routers are 
> connected to support this.
> 
> How do you think this should be done instead?
> 
>> SR-IOV VFs don't implement Vendor ID,
>> which might complicate this a little.  But it niggles in my mind that
>> there may be some other problem beyond that.  Maybe Alex remembers.
> 
> 
>>
>> Anyway, if we meet the requirements of sec 6.6.1, the device should be
>> ready to respond to config requests, and I assume that also means
>> the device is in D0.
>>
> 
> Within that section there is a quote to point out:
> 
> "
> To allow components to perform internal initialization, system software 
> must wait a specified minimum period
> following exit from a Conventional Reset of one or more devices before 
> it is permitted to issue Configuration
> Requests to those devices
> "
> 
> In pci_power_up() I don't really see any hardcoded delays specifically 
> for this case of leaving D3cold. The PCI PM spec specifies that it will 
> take "Full context restore or boot latency".  I don't think it's 
> reasonable to have NO delay.


