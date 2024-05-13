Return-Path: <linux-pci+bounces-7422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E08C41E9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C581F23868
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4A152E0B;
	Mon, 13 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zwkcE44v"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01037152DF7;
	Mon, 13 May 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606999; cv=fail; b=hn+Qj/vcLOWCOyWLYgVKcmfj0nNskxNs8NNby9VfhStNfifNTf+rrCru2jTKNr1MHc6yMTHpU8AIJwirCyk9HcmChhvdvlvxwRSTF5GARsPlSHUFiUeeSknGpXnjsjyTCaBWgOTS3H+tH2/bLOquZWz3hdIrYwYQEz3icaOYEOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606999; c=relaxed/simple;
	bh=0jMBrnc1fClkJrwRxThGmaN2SBM+f6dIn+Uy/+LykKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kH9QLDHrUFqkwomhqA87rApLgoMyEsaLmpQLJnucrnbtzG7r0ura5uPbW05emH+4g2E/+/DkkXu3iG4Ltf9yz0gqHL1Qa3uuLzVrV8dskv4APqbKSxlpplLDkEfFYA+6NosAr1aTJQDIXV1R6H0VLPjss/zCM+wWouuNdNHHKH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zwkcE44v; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feFW8xSCbQy9cTcYy5FFxprPgoFTOT/OhgXavmMBGuuWrNsz0a40Ft9qanCUbzKSmeYbT4Eoz500r0gP24b8znvkeH3kpbSq528wqPwTTLDhQGPllts8vbVB/N9DS3GrsbLMRRWZ3uSB6E2383s6ZoG2sGRbbrH2wk397cv8DisS3CHH6lSP2yZbC7t1vmqIW78LLZzvWr0x0CKYeDMw38bs3EAB3pHUCr3SvmfsrIAToWtWPeK7SxUuYlTpkKL9RWlbd1env9WjKKNg8DseYsdTBvDCoa/pZv4qgNWaTurX4E585RQZgIOla01ElvCGlkvT8afOR7Q/bdjsKFCUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRIUZ2cjxUXm/z/nrxUs+lBqHw8kFAvfVNRqSSw4OE4=;
 b=BZL+tXkRfebR2NmpOOYio/487Vu3ISRGIkE0AUuS3l4MWl0mGuFzvm9zuhM1HfRzveYGICIej8hCR7ISpY7GfIAcbJSyYHDAO4FUP7LOgxS8fOiSUYl2vilA8CXjZSvqP+YD0vTTndlIn2I35lQjRBsASDFeUfgyHbigJR62zhwW101zpivXf8MmLNeljp1P9GwnVFf5ihGbDdKOIUfSYXRrCcgRhk14s2UVnasn1QSbVeyxDe5fSiw6xYcC3I6SFw49co9X6dKtMntWSUADSwcNIRPQwaye+ndjGp8CWJMtclFUrBDlrKq6rz34dB6Pa1QiYErX6uXCEdue64TSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIUZ2cjxUXm/z/nrxUs+lBqHw8kFAvfVNRqSSw4OE4=;
 b=zwkcE44vtGUq/PWTHebfF1ChXCk07cGWUiQsO3ct6RuLihkcphQsSX2Dd5y0VqOKq0J35ZXbxxF5yTsGwUJ/+T4Vfbe+wY3/HTcPqWRxM7EDg9+03STYCU2+GsNLqwGdCu/WMj2aG0zWD3H3vBIHmOw3Rhynt+MTYGtiZ3xyWQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 13:29:48 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:29:47 +0000
Message-ID: <4810bb32-6a9f-4108-8728-da39fd9d81a4@amd.com>
Date: Mon, 13 May 2024 08:29:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/9] PCI/TPH: Introduce API functions to get/set
 steering tags
To: Simon Horman <horms@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, bhelgaas@google.com,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-6-wei.huang2@amd.com>
 <20240511201554.GV2347895@kernel.org>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240511201554.GV2347895@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0147.namprd02.prod.outlook.com
 (2603:10b6:5:332::14) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3ce379-1149-476f-1d98-08dc7350c26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pVbmU5Mnhtb1pYemFsZUp5NDdKSXMyRmlqMHVKcnczcEFkQ2VabG55NC85?=
 =?utf-8?B?STFsWDZMQzlEbmxPQ2xVdk96cXJhWDZzS0llSXdHOGkzWEdaSDJJejVzeW9R?=
 =?utf-8?B?Ulo1c2FCMjFiWnM5TTRwSTZEUm9zT2xXRFRxUUNXQ0RiRlNOK1JVays2QU10?=
 =?utf-8?B?dHVlOVdNbTNVUU9leVc0aktYN2U3NVhtNWYwMlNidXNOUVNEb1FtYVB5UXho?=
 =?utf-8?B?WC9wVmNqS3Jxa2pBNCszaEkzZ1Q0RTF3NEdCbDF4cDZ2emVHbTl4MVR5VUs2?=
 =?utf-8?B?dTgreVlQYURxU0RvVm1wZExPMS9kVDczNFZVRkxLZDVlMkpVRVZya2ZpRHNx?=
 =?utf-8?B?a3ZkMExyaDNEM3p6M21wVGZ6ZHVYQWs1N1lYdHdVMTdvcDFPUVg3dzBrRWVK?=
 =?utf-8?B?UEtFOWlaVmUxZDNUN3pZUDJvb0NYbXZCa21MZ0hFZitndys0L2NrRmRnTTk0?=
 =?utf-8?B?U2hFTStNdnpUS2NRL3pMcEtsaFJJSHY5dzBBSnQ3cXNIcC9vUC9JVjl5Wmtk?=
 =?utf-8?B?UTFyZTRoaWlWSjdWSGJQYXk0QnhGbjJ1RXluRHJ6SGJSK0ZzVWxBTFdYL0Ew?=
 =?utf-8?B?alVTdEJ2QkMxR0g3TWlndFlTL1hJa0IyQmdWYjQxNzV3dVRxRERjZ1ZRWE1J?=
 =?utf-8?B?YzI4RkVPSTR2L0xTRDA0UlZiT1Q0c0JHMWI5TldGMkdNamRmR1dJekUzckZi?=
 =?utf-8?B?U1pha1dkWnhmU2RRYk56a0tROWVOQ0ZHc2YvTkp5U01pRjlBQ0txWUVUWGVO?=
 =?utf-8?B?d3MxUHRobVJnRE1iY1lvWVRFSzdRWnpMeVlPQTFIYUl5VmhNR0xrYVA5b1Jk?=
 =?utf-8?B?YmZ6d0pkMEhoWTdsdTB6M2pYUkl4c1ZzMW1LNEZMWG9nRWhLTzVHZTRUb3dm?=
 =?utf-8?B?QmVoR0lHT1BHRDViOWJMQVd5ZmdKa1BFZFhqUGI5YzIyWnY1eHYwNEZ1QjZP?=
 =?utf-8?B?cHVyTWJtcFFMWGdBYnBodlN5MFZNUnNSWC9QL0tVc0UwZG1HNnlQd3N0N3Nz?=
 =?utf-8?B?K25GTGZDV09oWml5eGxGMUVUa2ppZGhyYUl2cUJIbjVYSC9yVzBWdkNQNWdK?=
 =?utf-8?B?L3pVajdZNVF4RWFkSmpkTW12b1kyME0yRHA1QlY3U0t6MUhEa3p6M2p5MkZj?=
 =?utf-8?B?ZmFnWHlnUmVlZDcva2kwM1lFcXE1cUlkU0xaVndVczJKd2JxZWw5TElCT29L?=
 =?utf-8?B?V3BjaEs4WWxTWmlyMnVrTDN4ZjZsYmFvR2NONmlGME8rK1Zub1Y5eG42c3l0?=
 =?utf-8?B?Y3FRQXFrend0OTRaajFLek43ZXVJT2o0WGhWRFhPbjJhNkFaWm81dy9DckJw?=
 =?utf-8?B?RWkwU3lvT1BXSVZJVmNKdDJFcXc1K3ZPQlVXZ3A5d0w1TTZwS0hmVldpNERY?=
 =?utf-8?B?U0FlSzdEbkNkSlhjdjhkWHBOYWZBaEpkQ2dRcW5VU21WQ3JJa0RzSEtnVGwv?=
 =?utf-8?B?SVo5Yy9xUG5ZS3Rzd0MyWTBiblJ1K1F5V1dPUnJFYzNQOWQyOFh2MjE3Sk5J?=
 =?utf-8?B?RkFGUWl1NitCaEVBc0tTT1lLTk5sSHpDMmc0UE9FcUUybWpnODE5RGNHclJk?=
 =?utf-8?B?dkdVSTBNTXFZVjE0U09ka0ZCbFdxbVhBdjZlU3hXOGJlMktoekxSbGZoK3dU?=
 =?utf-8?B?RjVHWWRmOVJxalpWTjhybXRpT0hMa3NaUEwvTnMrTkk1cWpNbnB5bWUya1l6?=
 =?utf-8?B?VmVIR2dxZ0JoN29ES1d0RExwNFdwcWp0ZUFIMjlVR3Q0SjNNR05iTmRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0xGRmlMaUdJNVpwVVBlQ3FMdW55K1F4S3dNZFEwR0FFMEZpcWlMUHRBNThm?=
 =?utf-8?B?Z3EvU1g1b3ROMUc1Vlh2SVJBNHZZS3R1azl6TWZDVFBJNUh1K2FjMk5EemlV?=
 =?utf-8?B?MU80R1h5eVh6L0ducXVYUEptOVZCZlhXRVBLWFBzREJEZTF5YVlqbXNFa09q?=
 =?utf-8?B?bE1pbUdSMFJseFlxTlF3M2syeG9NbExGdTEwbkJhRGdsNHM1ZldvbUV0c2p6?=
 =?utf-8?B?d2NjdjNjSGZSb05KcDR3V1ROam1pQkxUOHlENDhGSU5vKzJsWWVBc3dHQ3BP?=
 =?utf-8?B?TWZxelRoZWdPZ3dvQXR6NUt4aW1QcFUyWWJvQ1BBQUJXcGVQeHJoRlBENVgy?=
 =?utf-8?B?S1ZqaEFBY2QwbEJUVEI1d2c1eVlJNWVRTENFTnBkNFZjdEo5SlBRM1VrRzha?=
 =?utf-8?B?dXdNN051U1JLcldTamNObE5wbnh4M1VmV09FbFBnMXVEUlpFNlB0SjFzOHZt?=
 =?utf-8?B?NU15aTVnU1NKNjdqZjZCWTNGZTRvVFRXWFVrY0JkTVZxQlBZUmgrdU9DMzU3?=
 =?utf-8?B?SHFLOHErbitndkRySVlnVVIvcHE0UnB1WU1ObE1VSWw3Q2tNTnAvU3VmRHoz?=
 =?utf-8?B?MFN5S3FzdzlGUjdvbHdXNWVtZlJTZWhOUkJaZFA5TXd1bXN1Z3NIMm5Bazlv?=
 =?utf-8?B?VkI1dzR6SEVOQlJTWW04dUU1Y2lKSEdKbXlUeDF4TWpFZTFrSE12MkFHMGRF?=
 =?utf-8?B?MTkySFBiU1V0OXA2SFF1Wml4M3lUOW9KNkRENlhIM29EVXhYQThRSEpJcWYz?=
 =?utf-8?B?ck9rV2hqdW9yVzNnTnFlYmY1Z1hYT0N0MTlJc3Bnd2dZSUIwa1dFZmFBQ1ph?=
 =?utf-8?B?MzcwYkpxTmxxamNMLzdXdVpySkl6ZHFIcWNZYmNrZkY4cE1XOU9TVkczVTdL?=
 =?utf-8?B?TzVnbFRVWVlrbnhGaG9wRzF2NlA2NWZSNmJXTDlmb0pLSytyL2Z4VmU5bTFT?=
 =?utf-8?B?K1g3QnlJeFlUL0tHTElYM0hCN1dWUE12UVZwUlZMYjQ3U2NTS0tVckRHTWp6?=
 =?utf-8?B?TUs2WlFzSVFJUUtGK0tsR2VwY2hqNFh1ZDBwMVBEaGFJWjFUd0FuYm9KdlNG?=
 =?utf-8?B?KzZDWnI1S2o2SjJoSXNXKzdHeXBDYVdEWGYxd3o2dEhYZ1l5YmZ6RVFNM2hO?=
 =?utf-8?B?ZlpTWlhhelhsQzJydWRZcVJGV3Y4VDRxUllKOHlHVmV6S1BpRy9wem8xV2lk?=
 =?utf-8?B?aUJGMkR3L3RjL0RmdUJmR2pHckR1SUJkcHBWTmNvYXlFZFBkY1F5dkQvWExI?=
 =?utf-8?B?cHk5ZGdYczhCL1BHWk1LNG1RckxQUVRzemVGSWJPTXFGVFRBM2VyejdQc2dP?=
 =?utf-8?B?MnVqdkJ4NG13d09OUW1jZnZhYzlhQi83dTNLUXBqVnlZTndaYWprNWN1SllN?=
 =?utf-8?B?c3IwcVdqRW5NbXB4bnA5SXoyN21NS3U4YmpmVXVhVVNuUGJYOVZ6QjRtbnZV?=
 =?utf-8?B?eTdBRkducm10YkZVWmJwWjlpbW9CekFOQkM1Y00yNXVxeGtLRFp1aUdleHoy?=
 =?utf-8?B?djB1SVRBSEpzb3Nnb3l2M2RwOUZHU0F1TXNTeXJRbjRVeHY0V3d6eEFDSCtZ?=
 =?utf-8?B?Qm4rWmloSU1zcm10NjUwRXN0VGFPNFJ0QzVUaDJJaFRSQlBER0VTVUdsbFpw?=
 =?utf-8?B?R2dxK3UrQis5V1V3eDl1RnNtTnpDRjI5ejh3UFFBcnVOcEJQL2xlOVRtNlda?=
 =?utf-8?B?eC9NWnh3WFlHR0ViMWs0TFJHNEZZQUVVNitiK09FVUtZN1dlc0hmMXVqckZ4?=
 =?utf-8?B?QkpHRXl6TUxXdWk0TGUrN0hJa0NnYWp6Ky9JaVMzSVdHeGtDZFlMa2svbG1o?=
 =?utf-8?B?dFlRQ0MxVmpWOHc5SmdMay9PZENPRlNOMVdKTW9xWDZxaUFVOGFGUjdYTGdn?=
 =?utf-8?B?WkxKZVlwL1VPSS9JTWhwNit0NllpeFQ0dVRsdWtacEcyRHRKTjJsWnBjQXI5?=
 =?utf-8?B?ZGFVNTFpSHlIaS9xeHNWUmc4c2Rxd200WGE4amplY0hCNnlsYzhSUU52NEEr?=
 =?utf-8?B?c3RsZ0pwZ1FqQlVPa1JKWTVHMzZRTmMza2tHM1M5eFdDdVIvakg3STV2NGN6?=
 =?utf-8?B?QWZzdWkzMWlXUVlxTndGdWJtdm13S1VZQVAwZFNxdkY1UHd0N3ppdjNUMExs?=
 =?utf-8?Q?1rwE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3ce379-1149-476f-1d98-08dc7350c26b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:29:47.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfTwkLYwRGbmERyYdbuA+5m867z6Izp3p2mKZ8mj1Fn24MTmAnV2nG1MpPOGFWSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215



On 5/11/24 15:15, Simon Horman wrote:
> On Thu, May 09, 2024 at 11:27:37AM -0500, Wei Huang wrote:
>> This patch introduces two API functions, pcie_tph_get_st() and
>> pcie_tph_set_st(), for a driver to retrieve or configure device's
>> steering tags. There are two possible locations for steering tag
>> table and the code automatically figure out the right location to
>> set the tags if pcie_tph_set_st() is called. Note the tag value is
>> always zero currently and will be extended in the follow-up patches.
>>
>> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> 
> Hi Eric and Wei,
> 
> I noticed a few minor problems flagged by Sparse
> which I'd like to bring to your attention.
> 
>> ---
>>  drivers/pci/pcie/tph.c  | 383 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-tph.h |  19 ++
>>  2 files changed, 402 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> 
> ...
> 
>> +/*
>> + * For a given device, return a pointer to the MSI table entry at msi_index.
>> + */
>> +static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
>> +					  __le16 msi_index)
>> +{
>> +	void *entry;
>> +	u16 tbl_sz;
>> +	int ret;
>> +
>> +	ret = tph_get_table_size(dev, &tbl_sz);
>> +	if (ret || msi_index > tbl_sz)
> 
> While tbl_sz is a host-byte order integer value, msi_index is little endian.
> So maths operations involving the latter doesn't seem right.

Thanks, will take care of it in the next revision.

> 
> Flagged by Sparse.
> 
>> +		return NULL;
>> +
>> +	entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
> 
> Likewise, there seem to be endian problems here here.
> 
> Also, entry is used on the line above and below in a way
> where an __iomem annotation is expected, but entry doesn't have one.
> 
> Also flagged by Sparse.

Will fix

> 
>> +
>> +	return entry;
>> +}
> 
> ...
> 
>> +/* Write the steering tag to MSI-X vector control register */
>> +static void tph_write_tag_to_msix(struct pci_dev *dev, int msix_nr, u16 tag)
>> +{
>> +	u32 val;
>> +	void __iomem *vec_ctrl;
>> +	struct msi_desc *msi_desc;
>> +
>> +	msi_desc = tph_msix_index_to_desc(dev, msix_nr);
>> +	if (!msi_desc) {
>> +		pr_err("MSI-X descriptor for #%d not found\n", msix_nr);
>> +		return;
>> +	}
>> +
>> +	vec_ctrl = tph_msix_vector_control(dev, msi_desc->msi_index);
> 
> According to Sparse, the type of msi_desc->msi_index is unsigned short.
> But tph_msix_vector_control expects it's second argument to be __le16.

Will fix

> 
>> +
>> +	val = readl(vec_ctrl);
>> +	val &= 0xffff;
>> +	val |= (tag << 16);
>> +	writel(val, vec_ctrl);
>> +
>> +	/* read back to flush the update */
>> +	val = readl(vec_ctrl);
>> +	msi_unlock_descs(&dev->dev);
>> +}
> 
> ...

