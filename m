Return-Path: <linux-pci+bounces-20934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F654A2CC46
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F403A2D5E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED310E5;
	Fri,  7 Feb 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ysaUHQT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A49188596;
	Fri,  7 Feb 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955123; cv=fail; b=tPSNAwUcIsG/DQTl0h/cROmGoJENkpMgN8phQRr245J33yIplMB2OagHbJClkZzilfwPHdmSNHRS3vN3MzoY1CnIfkYkZE+IR0G6lAcmJ3MiVBgv/MoSsUwbQZHCsO+lSZ9nbP90coYCqSS8Ba6icKjwKy8jkOt2eNYyJKsSX2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955123; c=relaxed/simple;
	bh=bePfgkJ5w7r4kJ/kBCnl/4tZJRxurWVf6Si+MiYvqWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MioLIvIOPRufg7UCtnVrRSJO92Oqy5eO9yRdP5dFUrLRnK0lMa4j42OwnplPYXql2WDkc3ebP1gTzn/A9KrE0kfcnvZ2DoppkBlwaH70ndxW04VnF0QiE4M0R9x5xynkWt2MGvLiCmZee46UJX9pH7iu31loQjeUuoCg7GrmD7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ysaUHQT8; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3vzkCiiXMRo41xzbRPplTTul4p6K/yYWynCMr5S7YgRJzM+P7tQ/EXbjknVK5ZCBPjuCLHMsiFrEP9d/uxS03QC3t+F3fFBlQvZx8XsPhFTLNky7mHzbNrihZYKthDblgrU26q0flHWpsWE1vzJfYOzj0eoo590PQFPRjCHkU6PtAd7g7g5bnPfVDe7D/XDS+xjKjxZRA/fDtwvoeXLJXzIbVsIDx0Uj8JUpFnDS8ARUptWlZEe50noHNxTxiWcgRvGP//JXgf97teCO6HoZhgMIAXos99we1WCw87QfAIjBI5xMOUNleSwtllhQcfgLoukIZ5wog7jyVWU7U8Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bePfgkJ5w7r4kJ/kBCnl/4tZJRxurWVf6Si+MiYvqWc=;
 b=GrUsfaE5z2bFkbohy89TjXAKHcXZE9IcjPI1qyL/+xpxf86PDvjweYufbcUdSFcP8E41gVk53g4VpcqAkC0BPhQbA60+Y6S+TlgSftJXg/gIRBovsOQyhv6Gfm407HHuGITmOL1fT0VTbVC2U0YwBEfHant1SJX4Ex0ejpAhgkZUT0qEfeEcBJ1vSssjH/VNw9Si1w3VRkqqerv2O6V/QP2j2eXduV25tbQTNchJyjtNa9mcAnrOV47TOben5JjD8mbq/hUb4oIbcudjK2X7f/395QSvt8zeLwJ+Lq8qZhWuxZR3RZ2ZzMf4VX6p5Cu0ThFHSdVYzJ1skHB7omORMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePfgkJ5w7r4kJ/kBCnl/4tZJRxurWVf6Si+MiYvqWc=;
 b=ysaUHQT8q1TEE0n1/9FeFWL7dizimBN2kHQcJSr/JS2lcyEzlaxcF4Yrxm9Mk+m6tPpCxnn4bEhbCShTf6ZaWq5ckdOK28yoNOsCOlR3lqViBLWvQ/0ZuFMoEmZUV26olfIpw7d9Fmhu1GK/Hr367G7vRZOWHdJBlRC8/cfG8gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Fri, 7 Feb 2025 19:05:19 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 19:05:19 +0000
Message-ID: <7497d32c-14b0-4ee5-8e0c-70be470bee0d@amd.com>
Date: Fri, 7 Feb 2025 13:05:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
 <Z6UAk_L22eqiWCix@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6UAk_L22eqiWCix@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:806:6f::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: f843f34d-d77f-44bd-3c7d-08dd47aa5d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXBkd0VRU1ZrdkRLWmJWWVRwUWJ6MTVVRWk5L2YzRTFSRldBYTRNUytTaFJI?=
 =?utf-8?B?NzkvaGFscXJ1cHhUeGRDcE1CWVRhVEZYUzdjYUdSWGN1WENadEF0Uk5jWEE4?=
 =?utf-8?B?YlRWSVB0eitQSS9GbTIyUzJyV3VoSXBTYzdkZENOTWxkOU9XRkZYM1VOclha?=
 =?utf-8?B?aDFPOTUyYStieFVMdExuMmNHdUJrOXBFd3VrMjdoWjNWNUN1UVNrNWg4bXky?=
 =?utf-8?B?blBIKzUwYWRadG9DVWhMMS9sdWlpZ1IvYWNweVZjV0EvdU44bWhEVXk5dlY2?=
 =?utf-8?B?NjRYUXg4VmVrK2IrOFFzazl2NUFjN0RtamFYdmltbDRFNDUyZ21vVzNhQk9U?=
 =?utf-8?B?OW1RL3BDeGIxVUpTcTdyZUxlZGFKemNaUGJCVzZ3RDgzdE5WMm5GR3NGZkNP?=
 =?utf-8?B?Y3QxY2tEUDdMKzA2Mk9PYWYzT20xUDQ5aVdSdXljeUhCMm1yc2RtL3JacVZ6?=
 =?utf-8?B?eXR3WEVGUjlHOHhPTjNINkEyQmZWNDgvUzFXTGJBaVMvOUcwQ1VLS2JncnZq?=
 =?utf-8?B?TE8xM0p6Sy9WL2NUMTgzbTN2VUdMQWJZZFlpVDc3N3N6Q3QwZEFCZjBHdGNa?=
 =?utf-8?B?eXdEVE1YL01RZzZQcTdyZVovMGhhSGRNdExuRHc0UlkzM3ZvbjN5M2FBZWtT?=
 =?utf-8?B?aHZMUHVCZlkvdCt5SUpMcE9OVlNGdVZWZnhhTFpTSHdzak4va3Y3U2JCYUVq?=
 =?utf-8?B?TEZBc1RUUzR1STdxNDNKTWg2R2s0ay9SYlcvQVUzNXlPQjJBdlhWYzhvTkJs?=
 =?utf-8?B?OFJ6c000OFpzZ3VBS3drUEl1K1RXRHVjTTJ3Wko1UzVpalhjT094YlVCT2RK?=
 =?utf-8?B?eUNmZFVyMzZzNjNlMVc3YjFScy9oaUtxUVM4WXVTWVZFS1pDOHQzYy9yYTUr?=
 =?utf-8?B?OW1WbmpYRUxQYlJuMFhwK0ppT2NTWHByYjJzUTBFcmliNW51R2lHM01TT0Mw?=
 =?utf-8?B?VXBlcVZMbmhiaWFTYUpxK3pjNm9Wdm0zWk1qQjlkSUoxSlV5aW5DN0txeG5s?=
 =?utf-8?B?VklVeTdNN2tFSFZTdklROWlmMGJUdW5PQ1N6SW5qcFF0Mm1WUzI2V1FQYm9H?=
 =?utf-8?B?RUFvcDZGT0FnTlhRRDcvRDAybko3Y0djZW0yeWxMamFRSW9uMHduYXdBakhU?=
 =?utf-8?B?OGRpNDZMWXNVLzN0c2dCMlZVTFdFZnRHMlNyTHIvMTZRcG12Mnpqb3dmMlB4?=
 =?utf-8?B?ZE1FWDdiMVNPMzMyUWxHbHliRjhDZnVNenlHZEcvMDVuNXMxNWpILzEvNkRK?=
 =?utf-8?B?c2Y2L3o4c00xZ3p0Y1pFdjJFbTI2R0NUZmF4aUtGQnZDenp4djV0QkpIRDB2?=
 =?utf-8?B?SnJHckQySkdvNFBTbFBGd2hOL0JzY00wS1BEelFaeEtuaVlseXhPdUllOHl6?=
 =?utf-8?B?UkM5L0RjZ3hsYVRtamc1YTcxdk9aNUtCa1I3SXVQZmlSVFpTaC9FaVdaanZG?=
 =?utf-8?B?VU9IaTVlaCtZTzMvbDlkZGp6SExqUnFjQU1GRzNUSWdTTFQ2cHlqcTl3ZHdT?=
 =?utf-8?B?OUY0NHQ5WUpNTFhRZWVJU2JvYnZENW1JMjA1STFxYVRHTTVCcWhDR2Q1S295?=
 =?utf-8?B?Z2pMM25laFg3RzdkRlpnZ1RhSHB2WFg4WmJ6WTlDZWtiU0dXNlprVmxyWGZw?=
 =?utf-8?B?eGlzNThsWTRBa1VKbmJwR3AydjRKL1Fod3g3eW5QeE9aTThiUmwwank0ZTBm?=
 =?utf-8?B?YUdaUXRDOHp5UDkvZHdxOFczc3NVQUh1ZUhGWmMvWVFqUlpHeVhOb1JzYkdp?=
 =?utf-8?B?bUVBeUZYb2oyY3VGNDROQ3FXMFhBUDAxZXlvdWdDYy9kOGlueU5iN1JFd1FN?=
 =?utf-8?B?WHp5SlRFN2RUejZPZkVGQUcvNElhUGMvR3hGbUp1dGVpdGhuclNzeDAxRHBD?=
 =?utf-8?Q?I577iKrg8y6f/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXN4UmRmc2k5d0FTSVZCbm5MQTRkL1dwWHJHYVlHRUZJYTVqdWVBY0tGSnE3?=
 =?utf-8?B?S1hkSjRpaTFyMi8vZjVOcTlMNklJK1ZMOUlSSC94MlV2b1NRUDJJSGdUN1Vu?=
 =?utf-8?B?c04rVk4yQUg4cUpXNExLb0tFcnN3Q0h5KzUyaEpGbDc3cHFHNzRSY1lLNDhr?=
 =?utf-8?B?K2RZbXVzUTJIVDZua09wa3Q1QmNhdCt5bWJQQkFFZ0pqSWZIT0lvejNyYUI2?=
 =?utf-8?B?d3Zvb1ZGWXVxRGhUL0hMSy9ncWsxMjVSeGUvZndrdXQrYWtPdE8rMTE5MjJZ?=
 =?utf-8?B?Q09nb1dOSCsrbnhjYTZzUFdDcWZuUUVvdlhpakx5Vm5QMmdkekZPcC9XZlJS?=
 =?utf-8?B?NTJ1YSs4MGRKUWp2bjBEUGRFRXBsblpzUEdMRjNKa080U0hSTWNVdlpvTjFU?=
 =?utf-8?B?cU4ybno4WE9xaTRydGJmT2w1S0RLWW1pY3NSNGZjd2pYZFNHVjQ3S2Y1bUkw?=
 =?utf-8?B?a0R1TTB5TjBGZmUvTWl2SE9JZklIM1E0STNKWkcrZlh1VzNYcHl6OTZKQjVB?=
 =?utf-8?B?eCttdXFnN1UrZFFGZUpkU0YvaUJxejFYTDkzcDh1R1ZnSGlsYW9RcDJ2clNt?=
 =?utf-8?B?WXV2dndqa3FELzM5VndDUjUrY2FNRnRkeE05QVFmUTlRTy9kUmM5RXMzZ3NE?=
 =?utf-8?B?bFJoLzdOalpQMHY2RzJkaDFtdlQ4eDBhRjdnTUVtZ2x0N0toQ1dhUDBWWUhp?=
 =?utf-8?B?SURYL0pqSTZHZ2VDeUpBK3k5bVlnOFI1RnozQk9Yc3Z1dUFsd2QvZFFHSklu?=
 =?utf-8?B?alh6bDgwcHNOakFHa0liUitiaEN6ZUlBdWxFaGZOSEQ2MFBYQUZBZ3F1bmJz?=
 =?utf-8?B?bkV0RkhySUdtcUhNK2hhcXFNbCtPSmpFY2g1YnJPN1F1UCtnQTgxV2YzUzB1?=
 =?utf-8?B?YS95elVuOFk1OTA2ZnlZR2E4OW43VC92b2JYN1ZSR2NRTnAvVDVFblJ3bW9Q?=
 =?utf-8?B?dWNkZUgwVlFGN1g0SXNmc2dvNVlwQlQwVURTSEtLWkRFOUdsUzUzY2s5UTBl?=
 =?utf-8?B?N2wzR1RVd3ZEeGxWNWtGVDd3TE5DS1lRM0tySEtOaVUzc2s3Y3BCQ2JNSzN3?=
 =?utf-8?B?SFNSSU92eE9XazVaK0M4NDQvRC9kUnF1R2VpaSttay9MM3JIekllWUlrVm14?=
 =?utf-8?B?a3pZU1ZQeXVBbGJyajVORUhnYjJjVEVGL3VDdXBEcXQralM0cHhoczBrMXFu?=
 =?utf-8?B?UUUxYzdpVDZSNkZxOTJ1dUJvazNjbGJpc3pSMmNBRmZZMTROeVlVZHVzMG5l?=
 =?utf-8?B?ck56WXV1L2czT1pmdVA3TGtGN2Yzbi9YRWpCZ24rZWF0OWozY1N1Z21vNmds?=
 =?utf-8?B?MVZPTCsyUzJXYU1Ha1BHc3Zjbk1MbFdGeUUzN0xaSU5XcWh1bDEwY3h4NWc1?=
 =?utf-8?B?anAzY2ZxOHpGeERXSnVOeEJWR3dQaTNFeC9pdFh1eWRDZE1FeU9hVDlUV204?=
 =?utf-8?B?d01GcmxnZnBXSkIrRVV2eXR3MTJ6Z0d6ZVB1WVRSbEhRNWJYVWNubjBJZ0FR?=
 =?utf-8?B?QUxTbzRzYXVnVDlxREVXUmM1eGpyK0ZzOFY3TTdLV2syenBSdFpxQzZOVkt2?=
 =?utf-8?B?VG1oWGQ2RGcrcE05c0d6WEpmQVZiTUtJUlNFY0VkbmRqU0R0Zk9CVGNMOVVP?=
 =?utf-8?B?WHZVZWZKT2QwV1VMZFVGVkdWbXpSWHdHREE5cFRXbDYwNlpISFpFdlpPWkRn?=
 =?utf-8?B?SlhjU3VHd1pobUNDaS8vNXVGVmlSdnc4dnFraFQ4UzVRR2ZucW1BdExBbk5z?=
 =?utf-8?B?TWF0M3FSRThJMVVKNGtOTHpCNXlBVENoMHd2OFhDSmtoVTZRQktaaGFaK1hL?=
 =?utf-8?B?K2Y0S0lYdEZ3Tm1aMUJYUkZGMXlFZjhoN05sMElUaXlEd2dMR01ZYlVGRVJy?=
 =?utf-8?B?eHg2M2RvcmpsMmxRWm4yaWlGT1lWaGw4TmM0eWlKUTZHT0t2NFJFNi9BUG91?=
 =?utf-8?B?aFlyb2szb2JlT0xzV0liT2ZnbEVYa3FWRVAyL3dSYnhTSnJ4aFE0eW4zeEUx?=
 =?utf-8?B?UUZRRGtSQS9vUTJLTThObkZBTTg3Mm1BZ1o1akF2OGVHNkdpVE1SZ05yejN5?=
 =?utf-8?B?d1RiYVBtdUhKeDFHUFJVYkhyTm1nMkhEUndwZDBuU1h0b2dGTTFGVExFYVFD?=
 =?utf-8?Q?SaCaeTX80YTj2w6OMJMOYaVFA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f843f34d-d77f-44bd-3c7d-08dd47aa5d54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:05:19.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9m0sKw30EfY6p+GF09x/iM8IjapCUWNOMgFaKKi0TObZ2mhxH+4WJzBjheUSctxow6zLmeULiImcioeRvJlcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334



On 2/6/2025 12:33 PM, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 08:38:41AM -0600, Terry Bowman wrote:
>> The AER service driver supports handling Downstream Port Protocol Errors in
>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>> mode.[1]
>>
>> CXL and PCIe Protocol Error handling have different requirements that
>> necessitate a separate handling path. The AER service driver may try to
>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>> suitable for CXL PCIe Port devices because of potential for system memory
>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>> Error handling does not panic the kernel in response to a UCE.
>>
> Naive question: is a panic actually required if the memory is a userland
> resource?
>
> The code in arch/x86/kernel/cpu/mce/core.c suggests we may not panic
> if an uncorrectable error occurs in this fashion, but simply a SIGBUS.
>
> Unless this is down the wrong pipe - in which case disregard.
>
> I'm still digging through background on this patch set so I may be
> barking up the wrong tree.
>
> ~Gregory
The plan is to panic on any CXL device with uncorrectable errors
regardless of where used. This is to avoid corruption.

Terry




