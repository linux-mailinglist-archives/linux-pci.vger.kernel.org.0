Return-Path: <linux-pci+bounces-42681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F1CA6270
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 06:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0856F3033727
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05061FCE;
	Fri,  5 Dec 2025 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vOceSu2Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B238DD3;
	Fri,  5 Dec 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764912669; cv=fail; b=pQvC1/CnGetqaxxT8KUXWqNiyttAxi9gY8I9aChI+rTSdA8Z/WefJvE0O11hzizL51wz5SffHSiObERK5ZOgoOQX10CtlTNg8i4KdV+v/45wuu7EuC2ifs1ueyHi62ZsIaKW25lvziC6+o/KDJIIg1LIlt429U6/Fb5zJ+Z0jf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764912669; c=relaxed/simple;
	bh=miiIrkRmVx4PXC/fWMyoz/Cs/4Ud0lBixpE7KwyaLlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ra/5YenvajeTf0M8EhKcDbQc6Mk9rEIXHfMXwNhNIMxTeghXKDcn3sqh0zjJ9Wk2SPFUjLUcrbYwthOQaDAmBS/jks87Qyh9UDK3sat+XL92rVeGaWRZZVhdUjK9t66b7DOp175B/zTNAf8TuJjl4ZQe2Fn6t6ws/B4hC2tarTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vOceSu2Z; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOYKfNRVixcdmplfSHaQhwHvS0rjozhD9NavKBdZsNWYVFu3fviCatvYGFkLK4Lz7iECh1g9YlHbGejuUEPdQo3MibRmGP7S4BUzL9IfdqnrTsCdx/aWxj+yUpYGdhPttd7PT68gMOaYjnUBInOO+6x3z5LwXTA9gcXfvskPBg4rjWYMxnNsLLDJJEFj8jnjS590C6vjmU1QPtfElUVG4nSVOGX23AwTCOehQdhZ4WfFh5s5xVdYzysiuq2STiDvnDezRd9PFoRPpS4E8avBING5zh8bBMJXydrxvFt0PnefeMWfoHD1UMaqBKyO4tAT7nE1yIzDFjJ9cUYK3+XW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSxA4c6n/z9QmK/v+cC6eRbKisIOTfWKBvtHQhDQ4wE=;
 b=BhTBVaUinb9Hff4vJqD7veWJyu7c57LjVk9j2SsiMQfo5UhNHuodsGKGjur9dlO7Ws6I1oLqRmq9WOtIDxQfLQy11OqBCPbaYoEdzp3eYnN5tLjrY4DbTOMm85dHMtDvG1xuVopqcBSnCcLB9JHg3UkHYoFgvAuIe9+wTS/h1Rdcxmk8vg/9MVSH57LpFT9zoadYHS7SXm1nY/YXU/cKDzFXgBYKK2ML9iXAD/41lE7YQBoPsKnAyRiFxoxOojzvaGDgS9Y/Ro1bdjmCTxQ+h7rMb8Sur23H0VK932GUK2lfLjkM2/Q2I7f0lv8+ip5fkyniali8BxlqUGtY/YIG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSxA4c6n/z9QmK/v+cC6eRbKisIOTfWKBvtHQhDQ4wE=;
 b=vOceSu2ZsVjh7N0lQ1o6bXDk5fHbu87/U4lXPDtvpPJp/CmE3JzfqbDud+L60g751At4yrwRB8Hz8ib4boFj2ELLWkI1cpRBkGNOYsFmNtq4HC9wI4It7lgtrwbtLZ1aoGCNOfd5wOaRkU81AlIIC5ri4N8E8U8UGylXqkAKh3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 05:31:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 05:31:04 +0000
Message-ID: <a69dfa26-9ca8-4f3d-ab27-c28f16130c16@amd.com>
Date: Thu, 4 Dec 2025 23:31:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com>
 <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
 <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
 <CAKAwkKvoRW9QE5tt+B59sYYpW5DcGP6f_+0nObzVhw15-KhbNw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAKAwkKvoRW9QE5tt+B59sYYpW5DcGP6f_+0nObzVhw15-KhbNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0064.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4a9bc1-d3e9-4f40-3b25-08de33bf7b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE5EU2txTEtBS2Q4SmthL2UwNldrMGQ3aUdZQ25oU201M3E4UzVBeGphc3R3?=
 =?utf-8?B?bDRjdDlkMU5hWm1tdDRKNEVrc0ZBNzNvWXV1NjJKa3IrRHZ0a2x6OFNUamp5?=
 =?utf-8?B?bk1XRGxHVGIrMHhneFhVQWJQYzhQaitZUG9Nd2hLN2JYOXFCQm4rZWUwcDBE?=
 =?utf-8?B?a3VWMFcyR0JVYTVXNmZ6VXd2Z1AvWXNHSFVBQTFKLzhjZDQ2bWZGRDZGS1VL?=
 =?utf-8?B?U2UrM1BGUDhpTDlXaE5CNW1MbkNwWmtFSGlCWUhScXpmcXU2L3FkTVJzbDVT?=
 =?utf-8?B?TlZRbmNFdTR3ckY3dWViY3JhU0E0WHZZd2pxN1ZKb0J2RG9abVBRSkw4SjEy?=
 =?utf-8?B?QnRkYTU0REhYWkcxVHlPbjkrYXJEcWdraGI0bU0yQjlCTlRGLzlyVG50WjVj?=
 =?utf-8?B?ZXhHSzQxUUtWTWVWT1AydlJpd3dXZTM4cXpNUmRwRFFNWEdudjJJSFF6R1Vu?=
 =?utf-8?B?WmdUcDg5UUllbDd4U1ZxWDBNak96UW9ES3I0YmpyMGUrdEdWQU0vci9veU11?=
 =?utf-8?B?TWIzRjFZYTF6MityS2JBOCtQTFhhUVNsWWREWHpFU0g0eWd2NnVIMmt1SGYr?=
 =?utf-8?B?UjdYSjRSaWs0YWF3UXVvVUdZRnFlRTVpdmNTbmJaUEJyUTRkU3QvY2dhb0U4?=
 =?utf-8?B?ZUxybWlzd0ZRLzZqSDN0eDRWSXVhcGthMVZ0NlBJOWxHWkVNampSL3IrNlgw?=
 =?utf-8?B?TEQ3TnpQbktRQUJtQ25qUUQxV3lnYmo2SlBSUmE2Zk0zQ2JROEhxZXdJcThM?=
 =?utf-8?B?VkdlNkZZMXQzaHVwMnpyZWRVYzZTY3E4SlByc2NoZUJ1QzVrUE9xNEw0Y2NY?=
 =?utf-8?B?VUpHZDVJczdaMDhKVzJFZTBCNGJVMTV2UnFQMTdqM254RVFrZ3pRSDZuM2VF?=
 =?utf-8?B?UTJseEhGSnBPeHBDUEhwQ0ozSW13TkRYcFlZVUdNZ0JxR3I1SGd2QWdQMzZX?=
 =?utf-8?B?UVIyU3Z3MUh0OUgvVGpKZ1hRSUZQcnRPR25oWU9vNEhHbE0rUnZqYlBwcjQz?=
 =?utf-8?B?Z2lGamc5RFkxVVVmeGN0UFFFVTlpRVgvd0VmK2pxcXY2NGF2NE5mWGxaMVhB?=
 =?utf-8?B?N2lNYU9iUEZ3Z1ZIMU5RTkE2bnQzeVh6V1lLRDlCR2Q5NU5na0tkRE9KZVBp?=
 =?utf-8?B?aVhBY1NvWWU5bUxxMEZQeHU1NUVIZ2RYMVQyL1dDK0VOWUxPN3RBSy9DbFF5?=
 =?utf-8?B?ZVh2bjhjb0pseWhpMjhrTGVXQk5GaUY2bkRaSlYvOHJ1dC84a0RRVzFZa0ZT?=
 =?utf-8?B?dTVkbXlPRHZQY3d1N3JzRkhuV0wxWHJENUVzbHRJUVNBdTFVRmNkbW0zNTdw?=
 =?utf-8?B?Q3QxR2tUalVqZkNkSDZDbll0Rmdyb1ZqRHdKV0w0V0NVRy9xRXl4QWs3bC9n?=
 =?utf-8?B?bWhVdmwxdU5MNzZlczhUUW50Q1J4NHZaMURjSFNwOXEwQVhMaGNUVkV4VnR2?=
 =?utf-8?B?VWFPSE9BL3ZvS3NQOGQ1MkFvQnFhcjNLK3c2ZTNObVU3anhpcVhpY2ZDd21M?=
 =?utf-8?B?clVQTDBrSyt1cXIzcjZkMXZVdnNsVS80VlVyQVRXZWh3T04wektZaUxyRDNK?=
 =?utf-8?B?NFJUS1Q4QWN0RlZCNjNBZFRMcGJpclhSWm1hVDllOEg4T0NmU1JWWkNGMGpQ?=
 =?utf-8?B?RTR2T1RCZjg3N2ZDQ0c2QzgvZXJTRllySHJzeHprRkVpNUlCQ0l6MVl3VjRW?=
 =?utf-8?B?V2pFSlhtNXN3MXhWcXR2MDd3Tm5XdTZMV0U5ckJSWXY4Rm1adkRxZGQvOG05?=
 =?utf-8?B?eTlTakRjcjBsMllkMDVZb2creXlucHpNL3AxMkxYY3dsTUxoZnNIZ1dSY3Rk?=
 =?utf-8?B?QW1aSmRKZ1RuQ1FQc2VDTW81bWdEQzRlN0w0dG5wOWpFSjN0V1ZPemlNeGtQ?=
 =?utf-8?B?cXpCNUVLLy91WCt3SG96cnExbzI2QjVDeEFEeC9yVjlQWERRRlhsQzF0YU0w?=
 =?utf-8?Q?jTF5snPlzXXYeGTqkvNRWZYb+dGsvqKT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZldTNrb09ick94K2hBVURSVk5vVG01UkxLZFB6d1U1dWlmRHpoZm9DQWc4?=
 =?utf-8?B?dEtOV1c1Qlh6ZHByNnRubktGck9LdENGUks2NWd3NExWOEdMV1d5SGV4RjJ6?=
 =?utf-8?B?eTIyeStHTWxlZGJMU2VKckczQVlYT2tTNUt0Y2VFMDR6YlRVam95ZUpGVHd4?=
 =?utf-8?B?dlpyMDk0MzNaNi9WdnZEN09RdjkwWEtkY1J1UjNPWk5zVmcyNjk1ZnZ3ck9t?=
 =?utf-8?B?Z1RpekpwdnBKcGo3OS9xYXFvVFM5dFlWRExWMWdPWG5PbGtrY2pYTXpPbC9k?=
 =?utf-8?B?cjZHQzBJTm93c3RGdDFFQ0JEWnlHNStkb0dQUmlIUHM0RGdYRXJIbWdZdU43?=
 =?utf-8?B?TGxMa3Y5MmJFSFQ0bTVMNHhPS09nWGhQWDhLM1BTTkdmc0Nwb3lHc2tobndj?=
 =?utf-8?B?T2NoL2pmVzZWRDdiN2JhYUFrdjN3bXVTL0QzSFlDTEVQSEN3NEVIMmtqRDQ0?=
 =?utf-8?B?UjlLQzJrb1A1NWRlOGo5cVRSOUdFREpPbkkwdjUzUSs5YWs4MU1pckt3allk?=
 =?utf-8?B?TmtjZkpRbzZyVVRkdWZpRGFxRUVmVzgwYXlmTnFHQlZKMnZHcUZyOW9rNkNa?=
 =?utf-8?B?eUNJeVp4NTFad0ZpUklnWGF2cjJGQjA5NGQ3TkliVXdnVWRBVzR6ckVqcHdp?=
 =?utf-8?B?bFhBTTc2cFRVdW5PVUtzVGV3WE04SUh0QjdVRnNsTFpQRVpxV2ZFQ01vZHFH?=
 =?utf-8?B?NDNqVDZ0a2dmU2liVnM1N05qd1NlUE5GSHBMTGNwUGVaSmwvQVk2anlwekpD?=
 =?utf-8?B?bUdzYXViQ0V2MWU2bXBGN0U2b2FON1lrclJ6RDhnR0NoYTRIV3BBOUFuY1l5?=
 =?utf-8?B?K0lDS2FrSjZQRXpDa2JLZkVDejh3MGl2eFhJNXRHMXRub2x6eVJnUTdIQ1pP?=
 =?utf-8?B?S0kwQWk3Q1pjT0tFSDBhQUk4N3VOTjdhY0tJZjh3c2RKLzN5cGF1aWQwT2Vy?=
 =?utf-8?B?Q0FrM2JBNjNtL3UrMEt0RGhQaG1nZ0hzaGF4WWRyQ3NyZG9qTGxNZW5tTEtD?=
 =?utf-8?B?djloQkVpejkrMHFTVkx4aVYwTEE0Qkp4UVNMV0JGdDdxOUhsZ0RRMlNMTTJi?=
 =?utf-8?B?MU1iWjlOakh2RDVzaDhpelZUUEFicStaZzgzdWpPamViQ0R6OXVVaUJJWXI0?=
 =?utf-8?B?Qkxlc3c5V29FYURjR2pvYnZZS2NkNjNobGh4YnJvVnhaOTUveFlieGN6K3pu?=
 =?utf-8?B?ZktyemR5cW1Mc1lHOGtSSTg0WWFFZDZWQ0krak9jTndGdjExTEVxQktkOHhK?=
 =?utf-8?B?OU5NdGdQbnRUR0J6RHlZTWdFeXF0R1Z3ZGxiem5KNWlwWGJlUlU1NVJDd3Jo?=
 =?utf-8?B?eVl4akYwaHBYdjN6WDV2UjQ4eDJncmRCL3JIdlVneG5sQ2tQS1E3Qk40Sm9H?=
 =?utf-8?B?THQyS1BaZkdJbVVHOE9oaEhCbkx2UGRwQTd2Z3VlRXkzREFNM283NmJ4MnZH?=
 =?utf-8?B?RW5FZStlK3lEVm5PTE5TTmlUd1RiQStHYjEvZHF5cmYzV01QR0VHN2wzQzBn?=
 =?utf-8?B?QUY3UUNjbTVwU2xVWDFkZFE5YlY5UjVqNVJ2MTZwZnNXVkxuOTVyZ1l1T2Ri?=
 =?utf-8?B?SjBXbFIrZ3hQek9CYlFGbnVxQjQrdG5Ud2NyRjg3VllyNEJQdEJmOHhLSFRr?=
 =?utf-8?B?YnJYL1NhV1U1bC9tWm5sVnpXYmR3YlFGUDZrdUVoaDVqZVM3YThXUFBmZXI0?=
 =?utf-8?B?aExaaXJsL0xJNjFuUGFwOFA4UWZJMFpuRlhvS3BNUFlZT3A1RkZBL29zSGZr?=
 =?utf-8?B?cHJCVGlvc09sclp0ckIxM29wN1VmSnI0OWlHZnBQTzduSHBvTFpvck9VRTE2?=
 =?utf-8?B?YnJ2V0UyczhWL09Xcnd5d3djdUxHeXVEWE54Ky9rQWhnSXRNNUVyUm1STy9j?=
 =?utf-8?B?Q1duSVFmN24wWDhob1FNeHYvQXJXUFdLMzBONWI3cVBQcGREWU1pY1FaMW9Q?=
 =?utf-8?B?Y2VMVmJXeTExSUIxU3NJU3o1Q29TTDVoU3c4ckluekhGSURjZ0ljYzA3VUMw?=
 =?utf-8?B?ZWFCc2kwN1U1anlJNGZPYUJEeGlQSGQvbE01ejJGMTdrWTRhODh6MGx3ejZP?=
 =?utf-8?B?KzJkaTQ1eTBFS3Q5RG5zRlp4dCtEVkFaQWtLQ015dUtJRm43R2hObXhzOFlz?=
 =?utf-8?Q?96ZNG6qptegKgTFj5lNJjmxO1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4a9bc1-d3e9-4f40-3b25-08de33bf7b9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 05:31:03.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XfR3SIL58+wZH5swiuVG1zGF36OZoPNg3XRa/PzjqiisD2cu6AQT0WrBBVUApzelzxv1qGBcW4+88EiWo2ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918



On 12/4/2025 9:10 PM, Matthew Ruffell wrote:
> Sorry accidentally sent the message.
> 
> The nvme was still in state 0 / PCI_D0:
> 
> [  109.801025] mruffell: vendor: 1d0f, device: 61, state: 0
> [  109.819542] nvme 0000:90:00.0: mruffell: Current PCI device.
> 
> /sys/bus/pci/devices$ ll
> lrwxrwxrwx 1 root root 0 Dec  4 23:24 0000:90:00.0@ ->
> ../../../devices/pci0000:7a/0000:7a:02.0/0000:8d:00.0/0000:8e:01.0/0000:90:00.0
> 
> All of these devices are also state 0. Interesting.
> 
>>> I have a relatively ignorant question.  Can you reproduce with kdump and
>>> a crash too?
>>>
>>> I don't actually know if you configure kdump and then crash the kernel
>>> (say magic sys-rq key), does pci_device_shutdown() get called in order
>>> to do the kexec?  Or because the kernel is already in a crash state is
>>> there just a jump into the crash kernel image location?
>>
> 
> I did check this. I triggered a crash with magic sysrq, and
> pci_device_shutdown()
> was never called. It never printed out my debug messages from
> pci_device_shutdown(), instead it just oopsed and booted straight to the crash
> kernel.
> 
> Thanks,
> Matthew

OK so to me we have two options that you proved both work.

1) Call pci_set_master() during startup.
2) Drop pci_clear_master() for the kexec case during shutdown.

I think we need comments from Bjorn here on which direction is safer 
generally speaking.

