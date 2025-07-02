Return-Path: <linux-pci+bounces-31301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E2AF608D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F5B7B4198
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2B30B98F;
	Wed,  2 Jul 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YUu0oKcQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1C30E821;
	Wed,  2 Jul 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478997; cv=fail; b=uPidyBslqXS0+1XO4A7JO1l23Asli8KL55kK+e0NO2pTGGUdObw6lsdaGhEiNoewlY1Cla8RvrnH9W1tYxlrCDvE+bmy2YJUaBK5rl3NvAOScsDrvjgzQD14KKOgdyg7Yo9W6pVFNTPPZm9/QL0SXdBNMHRLq5NXS/+FgUPNYy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478997; c=relaxed/simple;
	bh=QNDONezPW9cWBasElgHbF8uAe2vIlfkjfRlMuw8YtC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eYPQdbelJjd5SD22yKt6ctrJp7lllmvIo1ku/I15lKWVR8D98DjLgV53wPr3eu0/xBdlVJuxMZEqG80LvL+EOlsms2TfhFK4JmSVTCLEMN+19hWcOOZBOc2fGQN+XhdamcLRY3DDADUbd/kRiWB/LaBWfgzvfVZiU8OIlFG+Wjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YUu0oKcQ; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHFFxw2qC87Ci0J15aMh9til0ubKW01boiHJ757yxFA0ghYghfTO81qLSPtb5n4q/Oks6MuZJGoleUSIIXaNeln7E5OzkiytdIIb1eBrwmnJFSHnYSQ5Py5iZv/9RZeahmHUlnGGWBEfg4gaOF2lUniQKZtRBsY/+x94GrCOFJwRX/Srem+Aa7yqeaPxpfS1n728QhUy3D4tMRKQGnq2r8tZbbbNZ8eMVOa0+C37fM99GqNFo/ULb+i+MovUS20xNBQp227o9ivA3u8VIt92Me8w+Ev/59zRBc2UT0Fl3p7caPPuPM/62tA3bqDClATssbyn6Luel0TfEYb/HNqd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AykFkzh5/H/+OMCpcMqKIKfJAiu2deyZzZ7G7r6uzFU=;
 b=B3iRcxbWcsJUdmJrT+H5DM+JhddQBRv8IrayTScoQSQmgzbXwKfEr5RYbYI8lsxzxV7sJeIOy6lq2GVEt5qlYlFFNheXlxIlzrbVgZtpA0v6Vl9F+LGr/Zehudly57/vWXq642vBnUprFwWo/OC+AIQ9VdFBph896fMKfmNIDyabqMXvE8s5/jP1fLEb6hLi29YbImOiQAjbu/eqsClv4QRDbQ33iy7kiHz3rhsBbanP0C4qQ2Zp+pe5uHhjUso70auO9Xc74o4TLhYoPdESZgiNzhOPt+nfxpYmWpMZ8ZvebXLR/nwRqXu4+3snP0A15/uc4PaKhXtGvoKayTk+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AykFkzh5/H/+OMCpcMqKIKfJAiu2deyZzZ7G7r6uzFU=;
 b=YUu0oKcQ60MMteFN6AL9rE5NUJeWICC7hnVyYWHhOdS1r4dsuHilCBtGQWmlcsAzIHm2TTm4OoG8y5l2z8xn/id4ywJijRQjXZPeklqsOj3LeWwYxEaCh5S9kVujCjxavJeE6xCQ5AXYTg//4nDezpB3eGQ1oF63MycLNOzjFyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 2 Jul
 2025 17:56:32 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:56:32 +0000
Message-ID: <0f0d74ca-a4f5-4cf0-850b-bb00126cf71b@amd.com>
Date: Wed, 2 Jul 2025 12:56:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/17] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-7-terry.bowman@amd.com>
 <8d0949db-fa5d-4e8a-a904-61cb78ccb176@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <8d0949db-fa5d-4e8a-a904-61cb78ccb176@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:f2::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: a2815f5c-0efa-47c2-7222-08ddb991c74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkU1a3dUMHpwd0szOXVIS0txdS9scDFTU044VnVkSE9lYUo4bTM3a01DSjRo?=
 =?utf-8?B?cmZvWVFyelBmQ1BWckdHU0VBM1F6anhvNDc4eHpRZStZMFlybG9IdStGM2lu?=
 =?utf-8?B?bTVIRnFoOXMyWCs3Z3Bib0NQSmkxclZVRVFUWkQ3L0l6eGlLYUVqTDBHa0F2?=
 =?utf-8?B?NURXSlJ3eXVKWWJ1M2p4Z05jRkh2eGVPeEh5dEhkeERTcTdzQWcvbDdNcE5j?=
 =?utf-8?B?c0tNY1FJZzllRU9IZkNLdlBiaE0wM2hBaHExNnNqdDFzRmRHNUZNMnZzVWU2?=
 =?utf-8?B?V0Nod215OEJBVUNFc1MxU09hb01SeGRnMlVwQzh6eWVXa1VwM3VNMTY3cFhZ?=
 =?utf-8?B?dk1FNktjUGNwOENDTGlERWpYK3dkK1ZlMS9lSHNxak9Fc2Q2WXNaMkxmWkJq?=
 =?utf-8?B?c2l5bDRkSTlwaGdTUFVWanBtclFGYjIyNXJQdjhZOW1zcEw0WHA5R2hqWUxK?=
 =?utf-8?B?RkdTNE41eGlJK0J1MzBIT3lmWXdlRWh4WjNWQVFwTDlNL216RG5OVS9xOEZ4?=
 =?utf-8?B?dEFOKzQ3Q1lVTUhBVXBlQk5nRDlrUXZOYXByeFh1R1BXOEtYUStpblBzeTky?=
 =?utf-8?B?cXY2elYvUm5BSkttOXFrZGhRa1FFTnZSOVA0cStSN09NSng2N2JFYUxvdDhL?=
 =?utf-8?B?aHVneTRab2lrS1U1eUMxZVBWZ3RFQlY4VGNnNHdPODZRYlhlNnRuMlBmMWFU?=
 =?utf-8?B?d1pPVjdpem5iVVhqNGkyNjRKVmlpdC8wb1RFRkhIZjBHUzNKRXZkcExkNUs1?=
 =?utf-8?B?S0NucGNDL0I1bGVpOXo4TStEdFRreWNsWTFOb2RqenZNaCtrcTlDeGhtT0Zu?=
 =?utf-8?B?dm03RkhBcXZWSTFiN1NtUVNkcmtyV09XNVlESk8za2dtcjkwendwQXpVZ1VI?=
 =?utf-8?B?a0lCK3dqSlFFbWxvMDAyYmxObEpONjIrVnpIZFBXWXB3aitBNjE1d1lyK1ZV?=
 =?utf-8?B?cEhyT28yVUJDNWFIVG83RWtEdGE2bVB1MnJMaWJBQWhXb2tqRnliTTJubXBQ?=
 =?utf-8?B?VHA2VDRBcm5lQTF2ZmpuZzdKdS9vTXBsQ0NRZHNSK2pFc3VhSXFNNDRweXNI?=
 =?utf-8?B?YzFwWi91cFNleXRYYWhXOU1lOUZkb0U5Y0hnRXl5TFpPNS9DNEl0N3djc1Zm?=
 =?utf-8?B?d0JRZStMcm1JdGY3OFBkYTNvS2dmR0NaYWY4UlhlcHR4YUd2WEl4d1FSQzht?=
 =?utf-8?B?eEowVjNYZDZWY3VwSFd1a3EzN1B6YUpmRFpNam9qUGhOWjhDam0zejh5clFS?=
 =?utf-8?B?dE1VWlByLzk3QVhhbWM1dExjYmtKbE4wN1AvVzdUUFNrYkRaamIwcVdSR0xz?=
 =?utf-8?B?WDNRSG12dEZKbUtJQW90Q3FjY2FLOW1PYkhLTUJzcVJZRGpLZVcraktLZUNr?=
 =?utf-8?B?OXFGbzcyRWFoTkRCUW5QWUZzcVg3TFVYbDVFaXgxN2tNWHlMSWY4VlM4ZmJp?=
 =?utf-8?B?dFRzZ3dlVUJ4SHMzd3FPbGswRy9YVThQME5DSjB6NklRSnppZGZvM2lTbGFK?=
 =?utf-8?B?Y3dxSnplYXlCTzNMek9PNXRBUXFaWVdJSTJHVVZ2WUlhb3R0Yk1aeGtLUXR0?=
 =?utf-8?B?V0oydG5OOXZmTVpnaWxHQ1JjVjFidFY3cVkwL3Ywc3RJQUdYL0JiSWhiR1Jm?=
 =?utf-8?B?blJOOU1nQXhWTzdSclpFZ0NDZTJVN2xJanVtRDlZMlJmK3pWbGlGV04rY0di?=
 =?utf-8?B?QXh3K2M5aDhzMXhCZEZRRlE0VXhCSjRYSzhPNHd0SmJDaDFYS09hT2pvV0Z2?=
 =?utf-8?B?amVrWTJUSEVYam1CbUxUMk9aVTZFcisvdzB4Mm9qR1ltc3lBV0dkZ3NnWEpy?=
 =?utf-8?B?T1cwNlBxN2FnakZ0dWhpbGNzNDN6V3FYVjk0Wm40U0NUMHVwQlBzOWJQQTd6?=
 =?utf-8?B?WS9kZVNQcDNLMVZvV1Rhblg5TWgwOUw1cXV5NDloOVVib0hYSmtEVUFtdEdR?=
 =?utf-8?B?K1pyd3IrbFVQbDNaQis5MUVGNW4wTi9iUEV5Ti9qOGdPNitETzYvY2FpbGN2?=
 =?utf-8?B?UEFkRHpzQTN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VCTjJhRHhYakV0bThUeFRvVVQvbDgvbkJBUUxUdEVDaGRTY0F1M1BMWS9P?=
 =?utf-8?B?dDJTaVcwbHhteER2b3J0Z1FGbTVHNTg4Q29vQnJqbURuNnUwNWNXeUNlT0Rm?=
 =?utf-8?B?M2Z1THVkZmkwRXVDbk0wdFpLVUNCTE1yTVFBZ0RTUVdXN00reCtTQ2gxekFm?=
 =?utf-8?B?cTBscTNrYVVMZFYzQWpsTlVjUTl3RzdFUGt1cXlzK2JHL2xCUkhaQ215YzZP?=
 =?utf-8?B?R0loWm12TVdwVW5LV0piWEpoeWU2d1VpajV5ZDgxRG5POWtTUUhaVFBYVzll?=
 =?utf-8?B?SkhCTzgzc204WXNXVWc4YkwxRUdmQ3RkUlF6TW5pbVhMYnREUlhGZmN5VjJB?=
 =?utf-8?B?cEZXK0tkSHp6dUlYcWZrTWFoaHdpeTlWVjFVSG5RSTdSMUN1QjFuWExzaUxW?=
 =?utf-8?B?Qk5JQ0x2cHNua0R2bWFERGVFaXU2b2dkeloxajYzbkpKd1JrbVR2R21scXJm?=
 =?utf-8?B?Vk45MGFWY005TlRqYXh0WW1XRWFKbFE4N1RrRDJDSVlUZ1dSUHRyWjBYQlcz?=
 =?utf-8?B?Y2g3Q0ZqYUtVSTJ1NGU5Z0xjWGx5bHRoL2VvT09ZVXRPdnM5REd6K0djSS82?=
 =?utf-8?B?TWVUcFYrQTdBK3ZaaWVZSi85ZGZpMVFqbmppQnNqbmJES0pFOEtPa0oxN2pI?=
 =?utf-8?B?b2NOZXlFejRZTlZNREVqK2Z2VE12ekdVbzFpQ1RmeWZNSU5rOXFKbUZSd0VS?=
 =?utf-8?B?T1BqSlAzN3VYU2c4VzF2WGwxNWpsUnZKWm9lR28rekFuaFVkMlNSM1NmUnlG?=
 =?utf-8?B?S01iSGRzcm53SHlQclVlVHgxM3pwY1ZRUFBvRjNxODI1NFpBbDBLbTNqQ3R6?=
 =?utf-8?B?bmdveVY3OEdaVkRDTUc4ZkRKa01tU2VCZEpHZnQyZ2hxMGE4WFlub0MxaDZ1?=
 =?utf-8?B?a1J2OGhMdTVRRWczSWdvNkNPSHpHaHhMVlEvc0FFQzY5SHFiTC9KdjFPeitC?=
 =?utf-8?B?Sll3Uk9Xa3gvT3hkZjVQdTNYOThtSmxtYVMxN3dKQ1N2TkltOEEzdHRrNk1x?=
 =?utf-8?B?Q3BpSU5nM2d1dDNXL01aMTRpclhLSjc2L1JsdWhkSExxT1RTaVhIY05iQ3pN?=
 =?utf-8?B?alZWc2Rpb1dMcU5qSlVjZENuUm9leTBYaUp1bEJHSlNRM2xMcmVZZWk5OXRE?=
 =?utf-8?B?YUJoa3hyUGE4SEpFZFhlSlAyUVdwS1I0TnoxVHEzYXByY0YrNEg5MDJVc0xl?=
 =?utf-8?B?MXhJa1JIL21VRFNyaldwbC8yTWRjQmJ6UGFiQlljQ1AxaXU3a1pnVjY4MGJJ?=
 =?utf-8?B?dFlaNmZQWU9OTDFkWHdSYlRQVlR6aU81TDVHWk5ndU1qVFQzNDYvSDh1b3hR?=
 =?utf-8?B?NWdCaWNERXEzWW5hSi9QazEzZy9jaW1uTzJqOTlmMGQrU0w3cWZFNXFuZ1V1?=
 =?utf-8?B?MWh6TWx2UnhneWZqUmFpUkV2RTkxNlRoQ0VDd1dSWFRKUzNCMnErUjl4aXVZ?=
 =?utf-8?B?WDVkMWhDWmdPQksyakt0WmttN29EaGRuK3FiYTZCcEZla0ExWnB0QjUzL0Ey?=
 =?utf-8?B?N0V1Rm5qWGhBWHZFMnp1RW1zb2QvWDFaNmVIT3poRU1sUmZrZi9IMjE2NGFu?=
 =?utf-8?B?d3pvdDB0L0E2cFI3QjNYdldIUjlyMzZiU2w5d3U0Z1FqZk1Bc3BDOGZHZU85?=
 =?utf-8?B?YkhvbFZDM2Rhb0hZT3ZIZ3NHNkRqOXRDdGtNRk1sWVYxSWU5V3hwY3lTOUg4?=
 =?utf-8?B?TEtndmVWTVNURUVvNE9PVFlWbFJGb1JJOXIzZEdTZUo2Vm1DVnV3R2R0OVZr?=
 =?utf-8?B?c2VHZjVLbG95SHpzOGgrdHB2YW1PbDFBY3BRcnVNMHBrOE1wbWs3eGpPeFlB?=
 =?utf-8?B?S3JVUG02OHZMdkRMVUxpYm1XODZTa2hSS2pJUFFxaEZBMmV2SkEvc3FLZnQr?=
 =?utf-8?B?R3M3elhJUlM4RTVRWW4zWXFvRDdnTklUakZvdmg5UlQ3WU1jZmhQejViZHly?=
 =?utf-8?B?dW5sb0dsVmZuc09vRTVLbkhMUS9vemFCbjhIWXR3YkU2ZkpvU3BhdmV4REE1?=
 =?utf-8?B?T2g3a0J6dnZOU2ZrUThtdVNKNDRIekUvcmlldklveHNtOUpzdnhLYXU4WE8x?=
 =?utf-8?B?ZW9XbU9POFB6WHJlYkNTWXpTMTRWajVJVjdEbEd1azF3cGJUS3krQ0lDbXZp?=
 =?utf-8?Q?yOuDx4mujNYu1gLB7oR185uY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2815f5c-0efa-47c2-7222-08ddb991c74a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:56:32.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwX/aJ6DxAvFEB2trNsm8Zx4eLdiE9wMH+UE/BVfddew6ZVIVHYjKO61rSjg/1yMqrKnqsGsehWIwLHr3FkEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224



On 7/1/2025 6:04 PM, Dave Jiang wrote:
>
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_proto_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing with
>> a call to cxl_handle_proto_error().
>>
>> Update cxl/core/native_ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver. Add check that Endpoint is bound to a CXL
>> driver.
>>
>> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
>> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
>> will return a reference counted 'struct pci_dev *'. This will serve as
>> reference count to prevent releasing the CXL Endpoint's mapped RAS while
>> handling the error. Use scope base __free() to put the reference count.
>> This will change when adding support for CXL port devices in the future.
>>
>> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors. RCH
>> errors will be processed with a call to walk the associated Root Complex
>> Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for the
>> RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Maintain the locking logic found in the original AER driver. Replace the
>> existing device_lock() in cxl_rch_handle_error_iter() to use guard(device)
>> lock for maintainability. CE errors did not include locking in previous driver
>> implementation. Leave the updated CE handling path as-is.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Couple minor comments below. Otherwise
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Thanks Dave.
>> ---
>>  drivers/cxl/core/native_ras.c | 87 +++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlpci.h          |  1 +
>>  drivers/cxl/pci.c             |  6 +++
>>  drivers/pci/pci.c             |  1 +
>>  drivers/pci/pci.h             |  7 ---
>>  drivers/pci/pcie/aer.c        |  1 +
>>  drivers/pci/pcie/cxl_aer.c    | 41 -----------------
>>  drivers/pci/pcie/rcec.c       |  1 +
>>  include/linux/aer.h           |  2 +
>>  include/linux/pci.h           | 10 ++++
>>  10 files changed, 109 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
>> index 011815ddaae3..5bd79d5019e7 100644
>> --- a/drivers/cxl/core/native_ras.c
>> +++ b/drivers/cxl/core/native_ras.c
>> @@ -6,9 +6,96 @@
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>>  #include <core/core.h>
>> +#include <cxlpci.h>
>> +
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static bool is_cxl_rcd(struct pci_dev *pdev)
>> +{
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
>> +		return false;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.2, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return false;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.2, 8.1.12.1).
>> +	 */
>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) != PCI_CLASS_MEMORY_CXL)
>> +		return false;
>> +
>> +	return true;
> return FIELD_GET(PCI_CLASS_CODE_MASK, pdev->class) == PCI_CLASS_MEMORY_CXL;
Ok.
>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_proto_error_info *err_info = data;
>> +
>> +	guard(device)(&pdev->dev);
>> +
>> +	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
>> +		return 0;
>> +
>> +	if (err_info->severity == AER_CORRECTABLE)
>> +		cxl_cor_error_detected(pdev);
>> +	else
>> +		cxl_error_detected(pdev, pci_channel_io_frozen);
>> +
>> +	return 1;
>> +}
>> +
>> +static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    err_info->devfn);
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device (SBDF=%x:%x:%x:%x)\n",
>> +		       err_info->segment, err_info->bus, PCI_SLOT(err_info->devfn),
>> +		       PCI_FUNC(err_info->devfn));
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>>  
>>  static void cxl_proto_err_work_fn(struct work_struct *work)
>>  {
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	while (cxl_proto_err_kfifo_get(&wd))
>> +		cxl_handle_proto_error(&wd.err_info);
>>  }
>>  
>>  static struct work_struct cxl_proto_err_work;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 6f1396ef7b77..ed3c9701b79f 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -136,4 +136,5 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +bool cxl_pci_drv_bound(struct pci_dev *pdev);
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index bd100ac31672..cae049f9ae3e 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1131,6 +1131,12 @@ static struct pci_driver cxl_pci_driver = {
>>  	},
>>  };
>>  
>> +bool cxl_pci_drv_bound(struct pci_dev *pdev)
>> +{
>> +	return (pdev->driver == &cxl_pci_driver);
> Maybe () not needed?
>
> DJ
Ok.

-Terry
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_drv_bound, "CXL");
>> +
>>  #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
>>  static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>  				  struct cxl_cper_event_rec *rec)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e9448d55113b..8d78d882bf78 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>  #endif
>>  
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 29c11c7136d3..c7fc86d93bea 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>>  void pcie_link_rcec(struct pci_dev *rcec);
>> -void pcie_walk_rcec(struct pci_dev *rcec,
>> -		    int (*cb)(struct pci_dev *, void *),
>> -		    void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> -				  int (*cb)(struct pci_dev *, void *),
>> -				  void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> @@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>  static inline void pci_no_aer(void) { }
>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 8417a49c71f2..5999d90dfdcb 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -287,6 +287,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>  
>>  /**
>>   * pci_aer_raw_clear_status - Clear AER error registers.
>> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
>> index 846ab55d747c..939438a7161a 100644
>> --- a/drivers/pci/pcie/cxl_aer.c
>> +++ b/drivers/pci/pcie/cxl_aer.c
>> @@ -80,47 +80,6 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>  	return is_internal_error(info);
>>  }
>>  
>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> -{
>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>> -	const struct pci_error_handlers *err_handler;
>> -
>> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>> -		return 0;
>> -
>> -	/* Protect dev->driver */
>> -	device_lock(&dev->dev);
>> -
>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> -	if (!err_handler)
>> -		goto out;
>> -
>> -	if (info->severity == AER_CORRECTABLE) {
>> -		if (err_handler->cor_error_detected)
>> -			err_handler->cor_error_detected(dev);
>> -	} else if (err_handler->error_detected) {
>> -		if (info->severity == AER_NONFATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>> -		else if (info->severity == AER_FATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>> -	}
>> -out:
>> -	device_unlock(&dev->dev);
>> -	return 0;
>> -}
>> -
>> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> -{
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> -}
>> -
>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	bool *handles_cxl = data;
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..fb6cf6449a1d 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>  
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 24c3d9e18ad5..0aafcc678e45 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -76,12 +76,14 @@ struct cxl_proto_err_work_data {
>>  
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 79878243b681..79326358f641 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1801,6 +1801,9 @@ extern bool pcie_ports_native;
>>  
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt);
>> +void pcie_walk_rcec(struct pci_dev *rcec,
>> +		    int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>>  #else
>>  #define pcie_ports_disabled	true
>>  #define pcie_ports_native	false
>> @@ -1811,8 +1814,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> +				  int (*cb)(struct pci_dev *, void *),
>> +				  void *userdata) { }
>> +
>>  #endif
>>  
>> +void pcie_clear_device_status(struct pci_dev *dev);
>> +
>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


