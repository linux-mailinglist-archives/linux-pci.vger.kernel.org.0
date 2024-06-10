Return-Path: <linux-pci+bounces-8556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CAA9029A5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5109A281A66
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69ED1BF2A;
	Mon, 10 Jun 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v6mZqu22"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B45B65E;
	Mon, 10 Jun 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049854; cv=fail; b=r4hVR9Ti2pQAFi96LTWmvtrL8A4fUEvzcBkZDUybaqW55bAOBpRpgz6wuesnDEuXGUSxdw7siK/HNR+EwzX3tpzahRyQBtt7HJPvJ8OGLxrgJxsClupAtJ7d3l+suVY+mbE1gI8qAlx3h3gJH1cDWPIcVsvMOyMwONupCsY/wz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049854; c=relaxed/simple;
	bh=wNn8yaF1Dcb1pxpd6rbTp/JjUZUmIYHfjST6yzaGxyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WWZZAu40fUAX02PbvQjEQyEjFaBhftBDcgr2RNfVYNxGEUFwi1SVj7yQXyGNcT4hua4b5wPAyGTJBNjPl+qnLznySWa5TpLUGRi2jsaQdVlTNzS8iDT71HlvtBws5B1U9xR//RcG1WLxDvtjFAJcSl5ywX5UszKVCSUVJ3/yaJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v6mZqu22; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN+KXDDHbYJXGmPPdQCbDfSOfdlGgFkeI+urbuKeyXYOvq5G1XXEP/n0qfnDkMxatktOJ5JB0GEqOTESX9OGjZDJ+6povIgp8D8iSW0FMZ2ltKpgETL6msG67X4BFkIeamQgggJZc6Jvoni4b2UnB6p+SBcow88WvyAz7HfzN8NQ6fhbrUiaRRwrPG55dXnu7DwmMC/jl4LD4nxq9madsTdvy0D/kEsajlIXamkeqfGjgOsBeNBM5JIE4r7A/bxejis+K5ggg+DBo15AaBaZet+2zOF1ivhuWa8h35CfmWjFsw4SLwvG6g7TRgQnWzB37nAhKR5+ZPNL1vnWPeiDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWwFwh40MpdjoimmVFyCs0A9gEmhI5Nmpx8kOmYtfnA=;
 b=O8iR/NUbbxqxqJAbORuG6bv2hRCElIhbyJtGYMLx9FU8/1HM6li22rBrLy7JlcBX9yB6qJe+e8MRXym/3POj0yDxXdYq97cxvWTkXoAekBmr3taRlt2V065eDlpNZrsfMiWnjExYobSIC8I4np6fGxfBoPKdIZdpooivdE1erEBNxZGbaeHbR0eYviDGKORrSSC2mBQU8SYxpqwbVrYpj6xZWAc71PWHXyVJHYfXbMWmv6blL8Govm0Sp/NuP59csh4hEGfsQuU8ydikWRGpKQalmCh2lBgH2qUmUAULbrusa9n1b9g4q0s+32xbMVGH8SWUDdwcEP21mD5vmCJ9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWwFwh40MpdjoimmVFyCs0A9gEmhI5Nmpx8kOmYtfnA=;
 b=v6mZqu22c4QFdhYsD/z2d2QmT0RzX8sMgTkxr7pQZP3Bfg4WXO9ar27g0Idiv+scVnklABb3/XWBC/mNIfr79DaQLLl0oWAWjF1x8pol8TuTmF+/f8/H0eEy4fo5EYMbrR2sLbk5DYKZdHYcw4AvQ0YNa9ReMFy0h2HodFBAAZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:04:10 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:04:09 +0000
Message-ID: <e4b83900-2012-4cd4-8461-aad11b714745@amd.com>
Date: Mon, 10 Jun 2024 15:04:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/9] PCI: Add TPH related register definition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, bhelgaas@google.com,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com
References: <20240607164212.GA850739@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240607164212.GA850739@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dfee72-75a7-4748-1a86-08dc89887dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdEV2Y2b1NlL2FWM1R4Tjl1ZHAxbjVWendERWJ1Z1lCcVBKM1hCcGtNcEgr?=
 =?utf-8?B?ZUx2SjhiZWRWaVdCd3F5QzhHYVRlaGxGTjUrV1U5TXhKSHFvdjN4WngwK2pZ?=
 =?utf-8?B?bmVTenUwaW0ydVFJTlRicjJycHQ4cnA1RFNvRGQ3VmMyRnk3dU9sUUZzcmRE?=
 =?utf-8?B?QnU0eS9jenZHRXkvMFRkNlRYd3MxbFJybjdIcWNJTUx5SENMZFdzTEYyNS9F?=
 =?utf-8?B?VFR0WWN1NCtwa1dRWWxwSlNHZTFqVUhQWEc3Y2pKanJlaTZJbTRqTFlKallZ?=
 =?utf-8?B?YVBpaUl4ODJLbnA2c0ZwNzhsejVoNS9wTTl5UU8xMmRNRVpuT0t1eHVSYjha?=
 =?utf-8?B?MmErOUIrUFZWYTJBMndyVkMzMTdkc3ZGK005MHJpM2U0OU5Yck1LcmNTREVU?=
 =?utf-8?B?bTU5NjRjZXVYK0pOUy9hQmNRSDQxMEIrY0tDZDlYMkJKK0dLT3lKWGhTR3F3?=
 =?utf-8?B?a29SaWxyc2UzZmhRVHgrUEtSWjJXUHZHbllHS3ErUTN4MXVKeERWU1JFeGhs?=
 =?utf-8?B?anYxbDN3Q3pTNUF1bXMrNnlRNmZsWnU5LzVHcEIyRWN0QUNwa0xIM3U1Wnlw?=
 =?utf-8?B?MFVKbUNUT0EyOGVrR0txVVJ4V0I0L040OTdrbkJVZk1DcVVMR1V4UDFZaWNI?=
 =?utf-8?B?ZStvS1g4ZmNoVzZ3UGI2OW5iT09hRm5EOVQvKzlhd0RFYWFsTlk5MGdLNjlr?=
 =?utf-8?B?eWNQWWtBbWQ2b1JydUdTZlpxNzZISjFpZjdLeEFQQXZxZ3RMVEpTUENKY3Yv?=
 =?utf-8?B?THJpNU5qcG9KSTU2SlViZy9LMGdYbHhTV3o1SFZpMkRoYitxUXl1WkRtSHBa?=
 =?utf-8?B?NzFHV1RYTVJreVpUdTQ3TkNSQmxhQ2pyZE1DTUl6OHhsUmFwK0Q1Y1B3NHZN?=
 =?utf-8?B?ZjZYQjFONTY3T3dLUHRPcXFGQithanZ0aDNOY1RBTmxvTStPMExtWUsyT3Vy?=
 =?utf-8?B?ODBmUzh3eGpXczFjRXpubDIzeDNJcEdGQlZOQlMrWmFXWkVCU3JzUmdmR25D?=
 =?utf-8?B?bEd0Sk1tRFlvZXBLNEFPU243aEpUdHdpeXlTdWg2T1BTeUNVNWJodlJEN050?=
 =?utf-8?B?eUJKK0doS2hkcWFoZSs5cEJHM01YZ2duNEVjTmZIbDQ2SitaMWhaZkRTWkVO?=
 =?utf-8?B?ZUxDcDFJUHRyWnVFR01Jdnd2VFhvYjh0QmFBOTRSV2NHTjgvUzh1QUtEdDBZ?=
 =?utf-8?B?a2tSZ2sva1lQaE1UbDhsSWxXR0VBWWJDMmNOcXFGVi95S1l3ZzNyL1UxeUZh?=
 =?utf-8?B?MmNhZ0FyZnp5R09QTzRnZXlWS3ZHa2xsQXY3WUVXL0J4WHZYMkorMEhva0xX?=
 =?utf-8?B?NTJuZndvSGd5ZVU1aGVnOHYrUEhTSVZTVVYwR0xLVmx4ZGhicjVuZWs3eWFB?=
 =?utf-8?B?MDJlekRkVFVEZG9iVXBmVmY3SXpLeittUGp0OXp2TWRYVkY5Ulk0WlJsRWdz?=
 =?utf-8?B?U3R6cXVLQ2xCVWdnVmsyc0Y2QzgxWUo0Y2oyMGFkMWIzWWM2aVk2cWZWOVVJ?=
 =?utf-8?B?VVF1amMvZXZ2d2k0dnNzM2U0Z2YyMitmclBaWUx1R1l4SGFlcTR0Y0hpNkli?=
 =?utf-8?B?U1RuWnA2VFpMb3ZsTzNhckRDUmFCK2I0N2VuUlpuSWpnVndtckxXSkdySUhx?=
 =?utf-8?B?S3M1R2ZPYjBGblVheTdQNHZiUldaKy9SMlZ0eU9VRnN3a3BlRm5pa3hmVFh0?=
 =?utf-8?B?aU53MGdOTkZFeWlMMjQyb2U4QVY1b2FKbHo1MzBQSGFsVGI4VVMwZ2F4cG50?=
 =?utf-8?Q?WzmtAX/sAnA23MhSSXZovFcEHgibTpNXO0VpRL3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHpCaGdvSE56b05xRUY0SVJ6Zk54bUZRN1JXR2RtZW9tdm5qbkdPWDZRWTcv?=
 =?utf-8?B?Zis4bi8wTzA1ZHZJcFBqV3RKR01TVXN6TFVlSGE3cldvYUxvNENZaER4Q1RM?=
 =?utf-8?B?Sk9jcVNGWkZsc0NNNUFIMWhvd0dHK1VsSU5YaE0xN21ZcFRNa1o3TG5TcVdL?=
 =?utf-8?B?aWNQMm1MVjFYNjdmWW5vSzF3cUJIUXp1dEFuTVJxRnlpYnk4YTYrZkdWVDF6?=
 =?utf-8?B?ejRWMzNnRS85MjNsNGZGVzdYenBXR2JGL0h0d3R6clc0YlRock5nS0l0OHoy?=
 =?utf-8?B?N2FGQlliRGx5Tk0xSlJwMEpxLy9nTjBJSERrcS9rOXR1bFJQaG5uV3MvczN2?=
 =?utf-8?B?YlVjWkZIbXpCMDhOVS9kTXhJR3dyOFZ6SXRTdmtKeXNZb0g4dklSTXpZU2M2?=
 =?utf-8?B?eWVqa0MvYldNa2YxZkEyRHlpeXRjZkVjTStKN1c0MDZxbHNTTkM1VG5tOVlW?=
 =?utf-8?B?dk14YWVtSnc3VjlkY3lBWmQ5YThsU01LVlZLcHNOaE9XOUg4SUZaN1R4ZytO?=
 =?utf-8?B?YkxreUdmMTVVczBZd3ZUQ09BZnR1MlN5THEvTEFIZ1dURnBSckQ5R0VpNHk4?=
 =?utf-8?B?eFRFeFNOQUhuNFNVTGRLQ0dwdEJNcGwvOXUxSTdlQmF1ejR4N2VKaStTWVlo?=
 =?utf-8?B?UnB5M3M4YnZNL0RrcE9uWEE5d1B5WFhpSnNlbS9rYjBqWFpNcEZtQW5SUlk2?=
 =?utf-8?B?MDczSFkvdWp4dHMxMGR5SURzUTlDeDd0ZG53ZE53dThQOTRZaHlyd2tKL3hl?=
 =?utf-8?B?V0s3TW81ZEkwMTh4L2RRSnJUMkJnWkVwSVJsVVp1WlpSRk5yV29IME5Dc21k?=
 =?utf-8?B?dGQ2VDkwdWFJT2MzNzU0NjlFeXBMRXB5QTVxcGlZNWt5OFc1aC9KYlBHeGNE?=
 =?utf-8?B?bG5WZUZsbXNGMjh6RHhxbVcxS1NGbURrV3BubXBYSnMvQ1ErVkVRZXpnUDE3?=
 =?utf-8?B?aE1TN1RLYmhmV0hyblNJMGkrai8rN3VyWVJvRGxwa1lKZUZDNXQwYm9lN3dZ?=
 =?utf-8?B?b3NaTFJsOG1RbjNPUm16NGNKenY2TXFzUDNXVG02eThRdVZmYVdTQ2F4dE1K?=
 =?utf-8?B?WldzMUp3eG0zSG5tMUh4MS9FVDFoTFFHNEtMWHpQWTVnczVoTEhtOXFiRnhZ?=
 =?utf-8?B?TklObGplK00xZG9PNzhsSXFBTXNQVWZxQTVFOTlaVlV1QWtvU0J3SDRNVVN1?=
 =?utf-8?B?MlN4eThwbE9RaS9od2tvQ1k0UlRneFlpanE2d0hrRExoVlNWT2tJQUJOTGVj?=
 =?utf-8?B?Sy9lRFRmQlhXcnJlYXlZYzR5Q0M4UFcxMktKT045aTh3UXZZQzgxdWYrQ2Nl?=
 =?utf-8?B?bUFTcXZrMEEyYXpRNGJyMk52Z2JSSm1MU21iMTdLQk1FalVxb29EWHBmRkMr?=
 =?utf-8?B?Nk9vaHdaZ0FxS3FTWEZPSlVvcHRPeDJvVW0vajZHblJKMThHV2szTkh5Rzda?=
 =?utf-8?B?T2NFbE5EQ3AxallRUWZUbHpudmRJWjV4VDVxbnhSTWE2YklFb25zM2NtNmc4?=
 =?utf-8?B?ZWtEclExS2RsdUg2TEo2NDlwVHNtOEM5L2V3U2xVbVpvT0VMbmNPcno1cG9T?=
 =?utf-8?B?em13cWJBQ25FRkVVR3dKYjBPaER3QUd2dGk2Yk5wOW9pOFlGYUJyOHAwa20x?=
 =?utf-8?B?ZXhDU3AwcUhUQ3dMSGZJdkJqT1VlYnVyNEh5L3NyYlQrckZaTDl4UXplSGZ2?=
 =?utf-8?B?bmtCdWVVWmxyQWpuZ3duTjlpenNmMTJ6Y0NVWDZIN0YwaW5iSHFJSzZMZ1Zm?=
 =?utf-8?B?Y3BnSUZTRDhPV0d6T3NzOExYQkJqWU5BNkFQa0Z6Ri9FSnhRV1lyZE9mR0ha?=
 =?utf-8?B?QVlkaGY5bWlWTHhjdzhiUUxnYktiYWtVR0FLbmt2cXNLSGcvM2JubHR4akkr?=
 =?utf-8?B?S0czQ3lUdW8rQVZrQ1M0RGpMU0JQTU1CYVRUNzd3TERMYktyaXJvWC94dUpM?=
 =?utf-8?B?MTFmcktrRWRSU2lIZ2J2U0VKY3FWRlYrR1drbm5uUFdWWDFnUXJLei82NjNF?=
 =?utf-8?B?c0FSTXFvaitRT3F0K1JyQTJaSDQwVXlIU2t6WFlyMEhLRUdpSnA1QW5pUHQy?=
 =?utf-8?B?cllUV29LSENSa3JkMFQySXdFa3JOaFhFaFVxNU1xaVp0OGw2R3JBSVhLSFh2?=
 =?utf-8?Q?c+hUZBk3OzMT6Tov33jXSgr7w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dfee72-75a7-4748-1a86-08dc89887dbb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:04:09.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxgbcsTuqqOpj1/u32veHvAOrhGWLldUnJICX7yqWJppHJKfjbdaiZBJ8Aybqs1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811



On 6/7/24 11:42, Bjorn Helgaas wrote:
> On Fri, May 31, 2024 at 04:38:34PM -0500, Wei Huang wrote:
>> Linux has some basic, but incomplete, definition for the TPH Requester
>> capability registers. Also the control registers of TPH Requester and
>> the TPH Completer are missing. This patch adds all required definitions
>> to support TPH enablement.
> 
> s/This patch adds/Add/
> 
>> +#define PCI_EXP_DEVCAP2_TPH_COMP_SHIFT		12
>> +#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
>> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
>> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_AND_EXT	0x3 /* TPH and Extended TPH */
> 
> Drop the _SHIFT definitions and use FIELD_GET() and FIELD_PREP()
> instead.
> 
>>  /* TPH Requester */
>>  #define PCI_TPH_CAP		4	/* capability register */
>> +#define  PCI_TPH_CAP_NO_ST	0x1	/* no ST mode supported */
>> +#define  PCI_TPH_CAP_NO_ST_SHIFT	0x0	/* no ST mode supported shift */
> 
> Drop _SHIFT and show full register width for PCI_TPH_CAP_NO_ST, e.g.,
> 
>   #define  PCI_TPH_CAP_NO_ST 0x00000001
> 
> The existing PCI_TPH_CAP_* definitions don't follow that convention,
> but the rest of the file does, and this should match.

Will fix all of the above in V3.

