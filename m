Return-Path: <linux-pci+bounces-35660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA9B48BFB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B01643A3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48061E0DE3;
	Mon,  8 Sep 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbWJS41v"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24075315D57
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330400; cv=fail; b=LFimd+5EOk1JQcqGbvgA5cqJM0NI5sjcT9CDGg8FODiaH5awDT4osPa4+8AhKFSXKgD5ZO/D+reBQ52EY6tPoIp4FyrHbRBAWs2LR2DFV0outPY6GZI14hToCDPS46cSZjZ6kUV/w9s2WgziapsG8Q8pVAvmBeRHC+tsBsOuFrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330400; c=relaxed/simple;
	bh=kuVseVWadgHqSK4Wvr15xwjOHQfjrRPihwG+8OFbkk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6qzT1uqQoXUNosksA7gCCa6MRQkZRqaCTw+B+eqYLddOVZ8nmQdmBd2uLSx8SF/mLKk1vvDaaVH88c8ZLakrPFyKqmZ6wcE5xRNhOU22x6BCauaNXcr0c5Do0ozEgvyySJmpogYQENkWOLl22X/RZ7FZStInUImeVMKPexuLlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbWJS41v; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iesdKSHEDdPb17M6THYP4JsIlflPHAEKh7nBGrLaRwvWizHFxsMbcvO3h0rhE8TQrCIabtQU+fBb/59poHxKFWp1igMQywVzl2633zGz9AM1/1lwtSD70642R14dESMEJjKmW7BcEN4sLidrSJOeg5UKBbEEqxzhlx5AMFJFjeVtxbQhdkNwbreMpGA9NrsYV7Is16SmR8jEz0diEbABs9cHQr9i4vcJYjf2PSjzfmVflhU5BVf1iVd4xlypcjAhUn/hqzhZDy7poe777PshFA6h6Swiny/Udk5jbXmcmf9lu59SsXb082Rahyd6OcweoKdEcumbkVS4xPEeWfrzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hXe/06pdEEXD5RruuKHwDmpSO6wqzt2sIRbRarXabs=;
 b=rXCvUrqP5z1E5brCxj4zMql4KS68mYKsfYVRPUI17V1p3zqIwYx76Ky0x1yasAUncet97n9yg8pXOlPGwsg+BgvZCP0PKAYc9ngL4iUW4ZA4kRFvqKp+SB7YKI5hiFSJNqyTW7YJRxPBbSImojJxl5AQIC3g4xyPki15e3yuLanIcFEP892IeiMWBIJdw/IewDhN8m2kzoyLEkfgg4emLv9T+iPH5m5HvWhq5s5ZDE61QbNjxsrnFOehafsMZhl4/IXAbmU4kZ7D1I//MTTWwU8UW6aNJX+jJHXOAsz6UBVlWvIuuJrVEftmXhuZY1RCHSyZeJeTHeVA27UrquTfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hXe/06pdEEXD5RruuKHwDmpSO6wqzt2sIRbRarXabs=;
 b=TbWJS41vrZi9eKC78JYFSl1YzNcl3N2vYuYccwZXSZzabZyeaeyUb+amqIpkbQJi01Ume+eVQ8MH88HEHuWqNLQldm4a+OINsdm4Cy0xvL7wnHQW7KKYDTiGaVK8Wrn8AfyNzCYnk/aa/d+vgZyccZAghAlOkRwPGpZfnmWBgRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:19:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 11:19:56 +0000
Message-ID: <da8f57cb-0631-4368-b192-22e63fd2a504@amd.com>
Date: Mon, 8 Sep 2025 21:19:49 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, gregkh@linuxfoundation.org,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a1poo3n1f.fsf@kernel.org> <8be9cd2d-6a13-40ed-97af-0a6129b2756b@amd.com>
 <68bb44634e595_75db10066@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bb44634e595_75db10066@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:10:111::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd061df-f36b-466d-f70d-08ddeec9a3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2ozcnVxdExNM0t5OWcxRlRDclE1UW5aZ0ZLanFKUmZaSWUwUHFUNVlyTi80?=
 =?utf-8?B?VytaVHFsV0NRMC9TQUdIR1RYNGV5OHk1Z1g0UmtiMDhIa00vNWIwUlFoeHBS?=
 =?utf-8?B?Rm5KUXoxbEhBOStHaitDOGU5VHNqM3hGbVJMYldJVzhKcEJiazh5TjdPMUlB?=
 =?utf-8?B?eXdSN1phVHIwL1hMLzhpTXd6WFF3R3NpQ0daNFJrMDZGR3I1UHE2YTBuK25H?=
 =?utf-8?B?ckhmVzMyV3F5M0JyWSs0R1V2bnQwazd6SGYxTy9xVlg3ZUIvY2xJNHFCVkxP?=
 =?utf-8?B?TVlEalIrV1JKbWlxMmNSSWtwY054Vnh0aTF5R2o4cE96YWhXSEhpdmUyYUVT?=
 =?utf-8?B?Z05pLy9pc1R5WDBCSzB0UTV0eGRHazVCeTdTTUhwRi81Ni9rM1JkQVVldDB2?=
 =?utf-8?B?dWhaR014T3czUE9sODZpK3NidzdpM0pJeHI2bUcyTWxRa2czcmk2eUdrbnVw?=
 =?utf-8?B?ampoNmptaFJTZElEVlR0cW4wSS9YaktsU0I1aEd6TFQ2ZSs1Z21ab1lVRy91?=
 =?utf-8?B?UGwxWjBrNWNBdENQWitqYm1raTJEQ0VyNjZPWllORHN1K0NOQ2YycFA4bTZ1?=
 =?utf-8?B?VlF3b2RVMXl2Szg1ZlM5c1dGTnlDd1pPQU9uREN2RkluL3ZUOUpITlAyY1RW?=
 =?utf-8?B?M2NFRFkzMldBQ1UybTdHYnhvK0c2MGxYVXI4T0RDV3lpci9tZExscE5sQ3Fj?=
 =?utf-8?B?UDdpV1VUdkZNUFlMdGFsRHI2aUFzanI2RElHUm5mZTNlSlRuT3ZvQ3o5TkFW?=
 =?utf-8?B?eTYxamNJMmp0L3dtTnNDVnY0VVJvUjI0dXREbXRPMmJuYkFQblRIcTdTa3c3?=
 =?utf-8?B?ZjA1YWw1S2RTWDEvVGJkYnZoblJYY25rKy82MnRLNXZwMWcxVEVpR1pQQi9S?=
 =?utf-8?B?TFFFeE1iT3Q1L3EyVVBTUU0wSHRFcmpXTUduK1NVb1FDZzd6ZStHTG9YeFZK?=
 =?utf-8?B?TE9ESExaem1DOWVVaU5jT2p1WWNDeVd2TDg3K2lKeW9RTUhhN0lncXJVRHZa?=
 =?utf-8?B?T3AwczU4TGl6R2NncmhpMDFrQlNpS000RDAxQlIzNXNJYVJQOXFDNnZjS2RX?=
 =?utf-8?B?cnd1MmRvamhEMUUrYVJOcUZKd293YllMeXNETEkxU0Z5ZUYvaUlySUYxcmF1?=
 =?utf-8?B?VTROaUNHOWZyWjdaTEZyU3g5QkZRSjB2WElodHZDS2lZQVpjV291Sm1pTW1B?=
 =?utf-8?B?djV5L0p3VmFOVUo0T1V3WHNLRHptWUl3dkhBVS84cEl1RDhUOStBTEt5M1c2?=
 =?utf-8?B?a1VvcDBDOFZPclR5MnlXK0FuVjBZOGdaZ1ZTTkhiV0ZNOXA0Z3R5ZHdXM3cz?=
 =?utf-8?B?amU3TkgxRXUyS253QllXbUl6c1QyQU1WOWpjYUhCOUVNdUFrNS9vbWRmbVl6?=
 =?utf-8?B?SWJDc2xrRDg2VURJaFZFQVNFNjRmRzdpdlplYUM2TzgvSktTZW1ZVG0vMUJt?=
 =?utf-8?B?Q3hPMG40Zk5kZHlLdy9lMHQyTGlmQ0VSblBYc1ZJZUZEWmNJclpuZUNYbElE?=
 =?utf-8?B?Ui80ckpTTzYxdDNNdFc3NExMZ01rZmxmaW1ma0VFU3p3ckdtbHIwR1RYZGxL?=
 =?utf-8?B?Um1pNEQ1dVFFNS9qUmk0ckFPNVJSOHVEVndsb3BZWW9tTUhVcy9yS0ZrbDRv?=
 =?utf-8?B?VkljeWw4ZGI4Y3N4dHQwaUxyUk83QzlHM0xBL2tCejJ1cW9Nc2lVTjBxRXJi?=
 =?utf-8?B?UElmUHBsbDdxT0E1TXBTam9jOWVtRjZoWkttUkJFOGNqbTRYWGo3Z3hwK0hQ?=
 =?utf-8?B?ampPUC9uclVxZjNGbmpPRUFLbHAxUFp3Q3NxbkF1WHdweUwxdkdIeEUvNkZJ?=
 =?utf-8?B?c0JxODN3YmNNWUVHOEVBSGZmQlJRT3BtaUNYTURJSnEzbHI1RUpIQ1VyUWhR?=
 =?utf-8?B?MzZUdlI2eHppWTBwUXhEcGtFOG5oYTNyMmVNY2I3Q0RyYU11cS9IK2VwNEpj?=
 =?utf-8?Q?9esV30/VRiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDErTENUNWYvUzhtZGd0V1J4RzZHQllmcFM5U3pPTTN1SHFSRTRuNlNnelZx?=
 =?utf-8?B?aS9sUVdiYTZrb2t5cDArMHc5SGt2c0RzUWdGdFd1TjZ4NThaUVlUSlpyMjkr?=
 =?utf-8?B?NUZTVk54VklldGZSWTBIVCsrelloOHFTcGRqVVlORU52QTBIMFlxa0xRdkpS?=
 =?utf-8?B?ZlJKcGFkaXBEK2VJaFpHbWJYY1p5bWs3S1kyc2xkY0d5ck5NWXkvWkJ6ejN2?=
 =?utf-8?B?aTBRTlMwc0o1bnFPV0ZnenBpa2dqbWxJMCtra2VEVzFWbm4rTkorN1hSM0pX?=
 =?utf-8?B?Q3RTKzB4U3B4S2tuZHFtbmNlZlZJMDM1bnlsaG9ua3JmL0xNOVpacTJvdTNr?=
 =?utf-8?B?T3IrT3FSRFJmRURYMlJYQmRBbUppS0I3U2plSDJrYTJaRm9TQWFYcnk1Kyt6?=
 =?utf-8?B?Z2p3OE04eHlnVk55SHRSWm8vK1ZDQWkwTit5R3JlMlc4aFc0ZE5TRTBRVlBa?=
 =?utf-8?B?ZmdPanJnVU9KaXQxRWtXdXNRNWg5dngrSVBTWjJTby9xamd4MGFkdUZidWFW?=
 =?utf-8?B?WG5ScjNHUWZsQ0pVaXlLeWxkK2JzTFNWR1ZPNEhVUVVicC9YZ3ptNHRtREhG?=
 =?utf-8?B?Zmdwa2FzVnhOd0RuSkZMYW1oazRQTHArU0NNM050cFZ0R0ZCT3psRUZHZ3d0?=
 =?utf-8?B?TzdCbVp5TTAydEthZGgvQzdDZGVhNE5neDBadFlqUjRUcDdGOXZFVVp6bkJI?=
 =?utf-8?B?dXR1WGtHTjI1OHhoZUlTZ3hUbllkbG9SUTZJbWhJNXBOQ1ZDV0ZSU1MwRFYz?=
 =?utf-8?B?THQzUzZlZ3hyWjlubEVTZmhLckJsVExSczlKWXlnTnlISTZPbEdXWm04cXFU?=
 =?utf-8?B?KzBuTm04MStJd0dqdEVZY1pBcU1FYTRCYmJLU2RrUVAvZFNSeDFYMFVRT2h2?=
 =?utf-8?B?TkY0Z3Z2a2tpMTBxVEo3ZWdWM0gxa2dsVDRjRnp4dGVuek5hL21YOXpHR0Nh?=
 =?utf-8?B?d1BmZHdiZE5odi9NV2VuV083R3hVcEY4Y01way9uV1lubEFSbHpLUDMzai9u?=
 =?utf-8?B?Mk5ISEdGdEw5UjRpV1JIU3VGalRDK0tJOVhoV04velRWZ0dXQS9WaVZkU1pi?=
 =?utf-8?B?Ynl2ZXQyb3Y5MnRLRmtQTktHRkx4dzZ6RjlRNVErUnRzT3FPUUUxblNEZG9V?=
 =?utf-8?B?cTV0akRvZGwxWHYrN1I1YnBpSzJvaTN2Nzg2Ry85OGlNM3RJTDM3RU5GclIr?=
 =?utf-8?B?WS8yUWVOd0dFTDh0SllOOVZGS2FLSVBzRUlEenRYK2w0QnhXZUZiS2hOMDFw?=
 =?utf-8?B?S2lnZlVzVGhSQ2tzTFQ2WDJLRFBFSzJsM1BxdDlaSjliYU9NSWtCZHQ5QmMx?=
 =?utf-8?B?d1VndVRUbVlIVUlJdEpYS25ZUXh5cGZvSmZlUmFjQnZ2eERvb2FTNnFtck13?=
 =?utf-8?B?d1JmZkR1TEI3ZVV6anp4aG5xK29SOG04UEluK245ZFVXaEl0N29SLzROWi9p?=
 =?utf-8?B?cWQvMkJ2em03R2R4TjNpQ3VuWGlTTUlzSXNSc2R2NE93djZ4WlFkQzFkUzZi?=
 =?utf-8?B?dGRiS080MzgwZ2lTTkljSnJBSlhYNTZZOGQxWnBMUHdqdGJmY09tdHhLNzNv?=
 =?utf-8?B?cFluN25rSDlCWGpCMUt2dkl4OVV2Ly8xcmJUYUkvMkJNNExvaGt0SGJEclVM?=
 =?utf-8?B?QnNTZkJ1Ui85b2N5Q3VpKy9zbWFyeHR6MmYxbSs1OWdzR3VFMFQ5N3ZTalFC?=
 =?utf-8?B?NngvaktDcW1BZTRCVms0VlVnbUp3VGJGSjJrWjZVRnVNbDcyaGp5d010QXhw?=
 =?utf-8?B?ZC9KbDd6RUxOZWNwQTdScXY1L0hQT0xmeU1BbG9xUHpUNmxsdmtlRmE0WTd2?=
 =?utf-8?B?RDVmREs1QmZ2V1lsbUFFWDcxeUJsY0JYUkR3US9XOEdyNi9TRFBkSHZrSUd1?=
 =?utf-8?B?TitiZTBZL1Q5TjNwYW1Ld2RrRUlOZUNxa2VESFZMc0QwajdHcDROSXJWNEZD?=
 =?utf-8?B?djJwWHlCQk1qcDc5VHR2amdRYkZxQUZtYmY4ZGl0V2U3ZHc2aldCMG5pYnZt?=
 =?utf-8?B?NFV6cjU5Z3dRcmR5SmwzczZ4VTkzVWpXWjJTdjRsT3FUM1IxVzBSbExyT2pj?=
 =?utf-8?B?bjlScFZBME5ObEpILzdHTncyS3V5SjlWZ3p6Uy9KUURGMTR4cGUyT1ZwcnlL?=
 =?utf-8?Q?eECSSFxsVjVOLIz33N5t0Xkec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd061df-f36b-466d-f70d-08ddeec9a3a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:19:56.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ7uXhC6E/bMnmAFosoo/W2d/hoFujgLextXLaw7Rd+L27dINeJM6fXgQJSbqgjPXWBDh2MQnJN5D6jnbXfSaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991



On 6/9/25 06:13, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 3/9/25 01:13, Aneesh Kumar K.V wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>
>>> ....
>>>> +
>>>> +/**
>>>> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
>>>> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
>>>> + * @dsm: PCI Device Security Manager for link operations on @pdev
>>>> + * @ops: Link Confidentiality or Device Function Security operations
>>>> + *
>>>> + * This structure is wrapped by low level TSM driver data and returned by
>>>> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
>>>> + *
>>>> + * For link operations it serves to cache the association between a Device
>>>> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
>>>> + * That can be "self", for assigning function0 of a TEE I/O device, a
>>>> + * sub-function (SR-IOV virtual function, or non-function0
>>>> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
>>>> + * DSM).
>>>> + */
>>>> +struct pci_tsm {
>>>> +	struct pci_dev *pdev;
>>>> +	struct pci_dev *dsm;
>>>>
>>>
>>> struct pci_dev *dsm_dev?
>>
>> Unless we start calling pci_tsm_pf0 instances "dsm", I'd keep it "dsm".
> 
> The per device data for the physical function 0 responsibilities is
> called pci_tsm_pf0, the actual device that plays the DSM role in the
> TDISP specification is dsm_dev.

ah ok, this makes sense if we uniformly call DSM => dsm_dev and TSM => tsm_dev.


> 
>>>> +	const struct pci_tsm_ops *ops;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
>>>> + * @base: generic core "tsm" context
>>>> + * @lock: mutual exclustion for pci_tsm_ops invocation
>>>> + * @doe_mb: PCIe Data Object Exchange mailbox
>>>> + */
>>>> +struct pci_tsm_pf0 {
>>>> +	struct pci_tsm base;
>>>>
>>>
>>> struct pci_tsm base_tsm ?
>>
>> It is usually pdev->tsm->... so it has "tsm" in the value, having another "tsm" is hardly useful imho.
> 
> It only shows up in a few places. I think it is ok.
> 
>>>> +	struct mutex lock;
>>>> +	struct pci_doe_mb *doe_mb;
>>>> +};
>>>> +
>>>
>>>
>>> Both the above will help when we have names likes
>>>
>>> dsm->pci.base.pdev; vs dsm->pci.base_tsm.pdev;
>>
>> What type this "dsm" of in this example? Currently it is pci_dev which has no "pci" member. Thanks,
> 
> True, not sure what Aneesh was thinking here, but that does not really
> change my view of the above renames.
> 
> I do want to stop spinning this patch based on trivial naming issues. I

base/base_tsm/tsm is trivial but  dsm vs tsm is not that trivial, these are quite different entities but the above s/dsm/dsm_dev/ fixes that.

> think at this point everyone has had a chance to weigh in with their
> preferences. I know I have picked up some from you, Aneesh, and Yilun
> against my first choice.

Fair point. 
> Let's please stop quibbling with the names post v6 unless Bjorn raises a
> specific concern.

Alright. I am getting used to these anyway. Thanks,


-- 
Alexey


