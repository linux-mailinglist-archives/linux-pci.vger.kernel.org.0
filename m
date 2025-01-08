Return-Path: <linux-pci+bounces-19491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508FA052A0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 06:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A562A188886A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1219B586;
	Wed,  8 Jan 2025 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hY3ukN9j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E1199FAB;
	Wed,  8 Jan 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314238; cv=fail; b=WQbgwbqrUQFfMsP4ruSDefyKRBeAcjeNfYLcamrCa+7kEoOuqIcg+in7fVpSBrRBm3x/RZBDASYsOIuCpBVfa/WIPZ9qWFCquYgkuHmjdCReiDzQPQDQYIQkP4lHlK4gTt+jve5Ya4xEKWfi/Q/n/6/8XRsKBA2IbdE2FxaDDRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314238; c=relaxed/simple;
	bh=8hoNo/wYu2OuAH76mcD/GjgxvMg36xhad1V2Ov6WaRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofAffr30grQq1GrfOEuaN6XnwvfJt0dgKSAfEeVmN/2hlNCnGsmxpk6fsygpw3cRUpz712HHCu4D9asFABf7anrf3N/nOGa2qvhtFZDFLpQfIua9Uj03ma5M2Xmi0YcHh3rnob8Dg1n8vCnKs2EHtUpegxar1ZQ119Lx3cRQqCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hY3ukN9j; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyUjMs5dpiQyqDyG8d5rwrMGasqFs++ywxRrdtVefV1b9qFAhsP5Fu8RFFm7XN7X90fC3P91Zkgnx3OTE8fjfk3G0/CQLSOafsY46Fpzne+jp46eN3DOHzKuLNN3yU1GMVwMjAsA9J/oj3qrEvYlc2XEQxZouXTNOU8NBDk62h8MAHzG106IxUDB5l4YNXna3KeiFszJaBWpA010E4kl4/zhshfOvMy55rnDpxKIUfbM8IkjK+QyHywHIEKcwUxGKc6r+I/lO89p7xQ47I/HAeNx1YY2OdotkuVRG/1B2BMWWdLW28mU6UGVRPu1jAWh7NDEU6TcA7yLHe8I8RrlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRhXtYhzBW06yCOFUHeW0DFaJmkQ5e0jVJwC6SEksQM=;
 b=Wz/ZlsOJQvv1lzAwl2yBqsa0BnDe/VYBOUze/48ivCiDjfX5BlorIYGRq9t9/xQcpguQnUOzJQJzSmwtJA0qTInbfVLUf+8m5iOUodwy9AaL9RrLby2GLReOU1aOhXzH5QGKtkVx4Qo5v74xbSLhf3eTuEvsXCpauIm03FjS7Zm40oc7Qg0NrVlmgaYFOtqXZBT5bGpWXtniohdxs15/sWezKQhMdqcI3PXFmKc69ivaVe6kyC0Bl7mEB91itrM0zG9XOdvAK1cpzY26VyKcQ6FuMnzmaw8dmhaERibx+opGZhYUtaBbxxrtZGmAdMml9kh5ioidIzgCVSXCVQ9/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRhXtYhzBW06yCOFUHeW0DFaJmkQ5e0jVJwC6SEksQM=;
 b=hY3ukN9jt4zRuVci1VD/wC6qz9G5J27MDepKvZsPjj8qMcIHe0SyaP396eOwcM+c5eO5b90dUMzEKKVNdBqqzjH/ds9cNOamjVbBrK0By8X5q+/ZoL2Ob7dhcLK0SENBkzgRXOxqDTIqmbByyrsQwZpsELuwVzixqKb3vJCxTBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Wed, 8 Jan
 2025 05:30:30 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 05:30:30 +0000
Message-ID: <6b1a0d73-5800-44ca-a28d-f2cd7e3ef1bb@amd.com>
Date: Wed, 8 Jan 2025 11:00:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] x86/amd_nb: Move SMN access code to a new
 amd_node driver
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Suma Hegde <suma.hegde@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
 <20250107222847.3300430-10-yazen.ghannam@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250107222847.3300430-10-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 305254d1-5b3f-4611-b20e-08dd2fa590b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUFHbUVsNnBPbUFDQWcyS1pjV3Rxc3AveXRVamxxQUd5QjJvWHJYOXJMT2lw?=
 =?utf-8?B?aUc4Z3U3bnFhTHBzcHBpbFhJK0Z2Y2ZDYzNxRmJkWHFQK2s1RUNYejlhTHNl?=
 =?utf-8?B?MENyZlhnMGhRRko0VFV4VUs0OHVBOTB6NWpwNGNwYVE5cUpoZWQ4T1gxRHJv?=
 =?utf-8?B?TGNPcEdRUEZuZTQ4K3VISVd0SmVXQnNucjBoV2N3N3dxM01wMmZWaGJoMnZT?=
 =?utf-8?B?NlduS3VXYStvY3dhSnFoa3IzOEFIZnkyc2ZUZXRZQzhVTmJPZGEvYTBTVDJL?=
 =?utf-8?B?TlRPcG9Vd1ptWm96ZE1abTR6aVRjQ21Ga3FrZXlSZWVJSFNWanZ1ZXo2Qm8z?=
 =?utf-8?B?Zi9QajRjMldzVDhFN3BVU1BBR1RRUkowd1Z2R0I0aDRuRUg1T1ZBeFd4MUw2?=
 =?utf-8?B?RUlqT3puZkIvMCt1NTdPZ3RFZGVKcDhuTXkwSjBhYWtQSWpSeitaZFMxWlJ0?=
 =?utf-8?B?aVJRbStTQ0lyZWQ4VlhuT2pyUnpuTjUvcWZteTRReWk2VHgwVndFTE1FU09l?=
 =?utf-8?B?TVp1eFljeEMwZTBZbmZmWEpaRlZXUnhsdnlTb2ZXaG1NQU4xaG5tdmkzOXp1?=
 =?utf-8?B?a1MxdFcvcGpaUEFNYThPTVdDaWxGbmJUYmM4eHZJdEkveksyMlBlNGkzZGp5?=
 =?utf-8?B?RXhrY1ZHaTBxZ0dMUlVPUEwyTkJWaWIwZlZuNlp4NG53KzhibFFMR1lVcVdE?=
 =?utf-8?B?RjdpUS9aYklSV01PTGxNc2V4V1JRSHgxeUk2djdmSjdUMHQ5d01jd3c3SEsz?=
 =?utf-8?B?YVgrS2JYeFNGS05jaVhmWENmazE5K3pXeHB0ZFZmR2xLS0gyQVNCcWl2cVZ4?=
 =?utf-8?B?aDN1R3liQjRDU2xMSW1tZVh4UUVhTUF2YkJzTklhTWJ0YnNnbm5Ob1RISDhL?=
 =?utf-8?B?UFlQZGFXZ09tUmI0YlRDK2Q5eEFHNzczM29mVjc5cForbm1oWmRXQVh6bzQ1?=
 =?utf-8?B?RmRYVEZDVGtPblBCZmpOR3hENjljVGdNbzgvQ0g3WTlZeTl1VlRkSGdZczZG?=
 =?utf-8?B?eWlwR05qMCs3QUs5U1NBdjIzY3FsdStPY0IxK3JwamxSTkNnNjNrSVlNOXAy?=
 =?utf-8?B?UUE1d2FmUHM3bVI0NWkvQkhmNHdlbzI2RnQwNzFCS2xUNmdhSEd5bWcvSXoz?=
 =?utf-8?B?WURub25vamJXd0IzS04wZHFCNk9ocVpubmRRWldlV3o5L1BuSlJoTHpTb0lq?=
 =?utf-8?B?Y0pzNm1UN2xvSDNwaTFzcDJLYW1VQnZQUERYYnY3OERQVDQ1TkZHZUwyOFVj?=
 =?utf-8?B?MEpLRVBnQmlsdU9wQThoQWtQUVN4OWZSQ1B1eUJPMkdndlBLTXNCeVB1TEtG?=
 =?utf-8?B?aExDOE9iRUt3bjV1VUdaUDYvUFlkUTAwY1NaRVJiU3BSTHQvMGNRL2FTWVVV?=
 =?utf-8?B?QVFxMTlpdWptWEhjYmdMR2tRSXlNL1NDUnVuL1liMFQ4UHZGRGlQNlFybGts?=
 =?utf-8?B?ZEVuV3QwdXpWTUU3azlQbjU2OWx2NTlhRU9rNFdkcFkvejJBR3RCUlpoUWlp?=
 =?utf-8?B?NUVwWnpSVGpSUWhTQ2tBaS93a0xRcmZTR09Pd2xEZU43S3cwTVNqN05LeWoz?=
 =?utf-8?B?eVdJQU9vTERuVDNpV0JRZkJLem1wVWYvNk55ZkJ0TTNmOHUrOVRhKzByVGp4?=
 =?utf-8?B?M1VGWmRTOEJHQmsrUXVlN0xwcFR3eHd6ZHlPRE11azJaZHp1bmVFUjhnb3NT?=
 =?utf-8?B?dXAxZm1JRUIwL0NrS01GV3dGOW5RR2FZU1VUWEdqY0luNmhrUXlPUDJPN0ZZ?=
 =?utf-8?B?eTd4YWltZ3V5elhHalNYMVdmTjd2VUdURUExTUd3bE56NGtJdGFrMjhLdUVK?=
 =?utf-8?B?Um93WFZ1NHd0Y0IzR0NBN0dCUzdxZk5SVnhGOW5yRU45RzBHMkp2N3BzUWZi?=
 =?utf-8?B?SHNST2NxR2ZEN1NjSmJXOENWbkJ2K2FYMzBGODF6cEZpUFBJTCtHbDVPOUdu?=
 =?utf-8?Q?8askSkkIgDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzlTWFYwNnQ3Ujd6bTA0N1ZEWUxxTHltZ2daM2htVW9Mdmh6ejV5Y0JzZTdk?=
 =?utf-8?B?NHNnL2dHZTNRTGl1NTVkRjJHY3NWYkhaRk9PMWtoelpkaG1RN0tDOCtQVWxm?=
 =?utf-8?B?UUd0QmtiYTR2TURFREZ0WnZucUdVNTBUZGsxaFp5N1N3ZFBqN0Z6RHJJMmUv?=
 =?utf-8?B?ZTMyOElPME1NNGhRZVQwWjRLWGhiYjY3MmhYbUVOVDc4REtDN3BiU2w5Mk1W?=
 =?utf-8?B?L1RIeGh6U0FrZUxwLzRnZENDU3Bta09CYnVDTURYbW0zRmxQRUNHOSttK2hv?=
 =?utf-8?B?NGM1L1dLNkVPNDMxdnlLZm1kSVBDRllhTHNxZ2N5WWpYcExUUkVSeU1NN1dh?=
 =?utf-8?B?THhCUndpemRnWG92SG9jb01vRTNRUTZwdUszZ28rMVBTYUZwZVJQNU9Oa1VZ?=
 =?utf-8?B?YXBta3AzQzBuMml5V0EwWmFGVDVnZ1BDaDJXcHp1K3Q4REVzR0xLcXFJZGFI?=
 =?utf-8?B?RjdGNDJxYWRPRlpya3ByTlJXZXZsV2xZb0pITWE4UUJELzNuRUg2OG1icnU2?=
 =?utf-8?B?RWNFeURRaGxZVXRVT3g3emtSdytmMzY5ZDUzSkZ3ZjdicDllL3ZlWDdoaXd3?=
 =?utf-8?B?M3FlRmppL21GSkNkbEY3UDdzVEZnWVg5ZS9mZE5CaGNLWmIva0tNdnN5Tzl0?=
 =?utf-8?B?bEFTOWV3RHJmSDBQT1FYTUtVeVNzaWpRa1lTemZtczM5SXdYUjRYcHNML2w2?=
 =?utf-8?B?eHpKZ1ZyKzdRMFRyT3dHZFJkMlNHN3FEL2JrL3B5SnlZTFBaa3lxRnZCV2Z5?=
 =?utf-8?B?OS8yKzhubnNwcEtEQWllWU95eW9WUzFCeG1Qa04ybURvZk5ZbmNlNkQ2VXZC?=
 =?utf-8?B?eDNOL09XVHhMVXlXQnpaMWUzS3d5RlhwZGxGQUQ4OTNQamh1SXIxcTE4T1pG?=
 =?utf-8?B?SDI2d0hMK1NVOFNubGp3WTh6aXFyS1d0eis1blh4SUZKSGphTEZ2TmxocldS?=
 =?utf-8?B?NUNlTm5KQUFrb2tNQ1VPaG4xQ29kYlRNRXcvSHRia3F0c1VIV3VEWDlPR2Iv?=
 =?utf-8?B?QzdHbnNwK0NveFBuQVdGcWhaUmwwVkRxRjNsRWs3cXd6cU12OTZjbVRFUGRB?=
 =?utf-8?B?SHE5SWp6YTYvcG12YTZ2c05YenIxU01mVFZxcFVlUUxYZ0lld28rMC9LL29q?=
 =?utf-8?B?ZElWV2FJa21Da2FoNEMvWUNxSXA0WkhGUm0vTk9lWUhzcHBTYWI2S3JWYTlS?=
 =?utf-8?B?ZEZ4ckp4UWRoU3dBZlFCRVZNYXRnUUdDS2NIZVIxMWFxWWhibmNUaWYvWVNw?=
 =?utf-8?B?S3l6Zm1mdkxQU0h3Yk4vcUNFYkJMN0tiZ3N2N1Rad2dBL1NRUTU1bmlRcTJW?=
 =?utf-8?B?MVk2K1ZmRlBkZnNMcWJ2NzZkYnMvdjY4RDJ5VHNJSlZldm1ISVBRblovcVVy?=
 =?utf-8?B?STZ6V0hYZHhtMkNNd0FSbWMvcWRwSmxBVyswNlRwdjBXMG5JbUdyQlJ6cndN?=
 =?utf-8?B?L3UvRlRxVmJ0MzFsRUlDaThzUTZMbWg4bEpkQjF4MllRR2s3Q3pibWJKZzhT?=
 =?utf-8?B?TDZYUEp1ZmJ6TDdjdkp5VjdrcFZEYnUwYkIzc1k1WWt3ZnJid2xHMk5VdjA3?=
 =?utf-8?B?Z1JZaUY2MWlUVEkwaVRHOVpLNjhTREJROUo5Mm5vVFEwWVNra3htRFZONEZt?=
 =?utf-8?B?aVQyZ21UdERUYmpxTTIzeGN5K09ta2F6VTZlR0Q5aTZlSGFwMFlzT0JEOVNa?=
 =?utf-8?B?aHZrcE80ajQ2ckpBUW51WTFmbGNTM2Zkd1Nnb1lpYkRpSS9LTHhCdnBuZ21j?=
 =?utf-8?B?ajBQbUR6anR2enBRZFJ5VVU2cUMxSzV4Z2pKc0JuYmFtTnpQREU4SW5UR0x1?=
 =?utf-8?B?aXh2ZUwyZFkrbUo3RkhycFExenJFWEN4UjBSejc3VkFOZ01PTm9FcDFJU1E4?=
 =?utf-8?B?UDB2WXgrNFRuc1NRc3R1WUg4b1V2YkhHUExHSTMxMEFpTTJTd05kMG5KUmQr?=
 =?utf-8?B?UThmWjdHQ1BRNjlnY1JRc3dpMlNSd3pmNHBjYWdjSFp6WWRLamZnelcwNXZW?=
 =?utf-8?B?Ti9RQ3VjZlRBMEhBK2N1eWwvVHI4Q2REKzhJMTZ4eEFtb095VTA5bi9SV0J5?=
 =?utf-8?B?Mzd1NE1LdlFIeUM4cDV0M1NreXdWQkdIcUZCVk8xdlpEVG4yRFJOeEpvZmdJ?=
 =?utf-8?Q?MH+jOa9BZryb/+QxvwMCpS5Wy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305254d1-5b3f-4611-b20e-08dd2fa590b5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 05:30:30.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLQCZimaYsUefmId1Gs/I4zoplQRtCI3iQvii/j/Z+ZSVWVuc6bwC/qQQoh9Eq0YWmvmN1Tpp0peIIGmZ28kKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993



On 1/8/2025 03:58, Yazen Ghannam wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> SMN access was bolted into amd_nb mostly as convenience.  This has
> limitations though that require incurring tech debt to keep it working.
> 
> Move SMN access to the newly introduced AMD Node driver.
> 

There are couple of nit-picks (see below), but aside from those, this
looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> # for PMF and
PMC drivers

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> # pdx86
> Link: https://lore.kernel.org/r/20241206161210.163701-11-yazen.ghannam@amd.com
> ---
>  MAINTAINERS                          |  1 +
>  arch/x86/include/asm/amd_nb.h        |  3 -
>  arch/x86/include/asm/amd_node.h      |  3 +
>  arch/x86/kernel/amd_nb.c             | 89 ---------------------------
>  arch/x86/kernel/amd_node.c           | 90 ++++++++++++++++++++++++++++
>  arch/x86/pci/fixup.c                 |  4 +-
>  drivers/edac/Kconfig                 |  1 +
>  drivers/edac/amd64_edac.c            |  1 +
>  drivers/hwmon/Kconfig                |  2 +-
>  drivers/hwmon/k10temp.c              |  2 +-
>  drivers/platform/x86/amd/pmc/Kconfig |  2 +-
>  drivers/platform/x86/amd/pmc/pmc.c   |  3 +-
>  drivers/platform/x86/amd/pmf/Kconfig |  2 +-
>  drivers/platform/x86/amd/pmf/core.c  |  2 +-
>  drivers/ras/amd/atl/Kconfig          |  1 +
>  drivers/ras/amd/atl/internal.h       |  1 +
>  16 files changed, 107 insertions(+), 100 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 290989ab9f72..27a5bc2fc49b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1122,6 +1122,7 @@ S:	Supported
>  F:	drivers/i2c/busses/i2c-amd-asf-plat.c
>  
>  AMD NODE DRIVER
> +M:	Mario Limonciello <mario.limonciello@amd.com>
>  M:	Yazen Ghannam <yazen.ghannam@amd.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 094c3be81a8d..5e0333534abc 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -21,9 +21,6 @@ extern int amd_numa_init(void);
>  extern int amd_get_subcaches(int);
>  extern int amd_set_subcaches(int, unsigned long);
>  
> -int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> -int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> -
>  struct amd_l3_cache {
>  	unsigned indices;
>  	u8	 subcaches[4];
> diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
> index 419a0ad13ef2..113ad3e8ee40 100644
> --- a/arch/x86/include/asm/amd_node.h
> +++ b/arch/x86/include/asm/amd_node.h
> @@ -30,4 +30,7 @@ static inline u16 amd_num_nodes(void)
>  	return topology_amd_nodes_per_pkg() * topology_max_packages();
>  }
>  
> +int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
> +int __must_check amd_smn_write(u16 node, u32 address, u32 value);
> +
>  #endif /*_ASM_X86_AMD_NODE_H_*/
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index e335d89ddad7..11fac09e3a8c 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -15,9 +15,6 @@
>  #include <linux/pci_ids.h>
>  #include <asm/amd_nb.h>
>  
> -/* Protect the PCI config register pairs used for SMN. */
> -static DEFINE_MUTEX(smn_mutex);
> -
>  static u32 *flush_words;
>  
>  static const struct pci_device_id amd_nb_misc_ids[] = {
> @@ -59,92 +56,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
>  }
>  EXPORT_SYMBOL_GPL(node_to_amd_nb);
>  
> -/*
> - * SMN accesses may fail in ways that are difficult to detect here in the called
> - * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
> - * their own checking based on what behavior they expect.
> - *
> - * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
> - * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
> - * can be checked here, and a proper error code can be returned.
> - *
> - * But the Read-as-Zero response cannot be verified here. A value of 0 may be
> - * correct in some cases, so callers must check that this correct is for the
> - * register/fields they need.
> - *
> - * For SMN writes, success can be determined through a "write and read back"
> - * However, this is not robust when done here.
> - *
> - * Possible issues:
> - *
> - * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
> - *    *not* match the write value.
> - *
> - * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
> - *    known here.
> - *
> - * 3) Bits that are "Reserved / Set to 1". Ditto above.
> - *
> - * Callers of amd_smn_write() should do the "write and read back" check
> - * themselves, if needed.
> - *
> - * For #1, they can see if their target bits got cleared.
> - *
> - * For #2 and #3, they can check if their target bits got set as intended.
> - *
> - * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
> - * the operation is considered a success, and the caller does their own
> - * checking.
> - */
> -static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
> -{
> -	struct pci_dev *root;
> -	int err = -ENODEV;
> -
> -	if (node >= amd_northbridges.num)
> -		goto out;
> -
> -	root = node_to_amd_nb(node)->root;
> -	if (!root)
> -		goto out;
> -
> -	mutex_lock(&smn_mutex);
> -
> -	err = pci_write_config_dword(root, 0x60, address);
> -	if (err) {
> -		pr_warn("Error programming SMN address 0x%x.\n", address);
> -		goto out_unlock;
> -	}
> -
> -	err = (write ? pci_write_config_dword(root, 0x64, *value)
> -		     : pci_read_config_dword(root, 0x64, value));
> -
> -out_unlock:
> -	mutex_unlock(&smn_mutex);
> -
> -out:
> -	return err;
> -}
> -
> -int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
> -{
> -	int err = __amd_smn_rw(node, address, value, false);
> -
> -	if (PCI_POSSIBLE_ERROR(*value)) {
> -		err = -ENODEV;
> -		*value = 0;
> -	}
> -
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(amd_smn_read);
> -
> -int __must_check amd_smn_write(u16 node, u32 address, u32 value)
> -{
> -	return __amd_smn_rw(node, address, &value, true);
> -}
> -EXPORT_SYMBOL_GPL(amd_smn_write);
> -
>  static int amd_cache_northbridges(void)
>  {
>  	struct amd_northbridge *nb;
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 4eea8c7d8090..95e5ca0acc90 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -8,6 +8,7 @@
>   * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>   */
>  
> +#include <asm/amd_nb.h>
>  #include <asm/amd_node.h>
>  
>  /*
> @@ -88,3 +89,92 @@ struct pci_dev *amd_node_get_root(u16 node)
>  	pci_dbg(root, "is root for AMD node %u\n", node);
>  	return root;
>  }
> +
> +/* Protect the PCI config register pairs used for SMN. */
> +static DEFINE_MUTEX(smn_mutex);
> +
> +/*
> + * SMN accesses may fail in ways that are difficult to detect here in the called
> + * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
> + * their own checking based on what behavior they expect.
> + *
> + * For SMN reads, the returned value may be zero if the register is Read-as-Zero.
> + * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Response"
> + * can be checked here, and a proper error code can be returned.
> + *
> + * But the Read-as-Zero response cannot be verified here. A value of 0 may be
> + * correct in some cases, so callers must check that this correct is for the
> + * register/fields they need.
> + *
> + * For SMN writes, success can be determined through a "write and read back"
> + * However, this is not robust when done here.
> + *
> + * Possible issues:
> + *
> + * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
> + *    *not* match the write value.
> + *
> + * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
> + *    known here.
> + *
> + * 3) Bits that are "Reserved / Set to 1". Ditto above.
> + *
> + * Callers of amd_smn_write() should do the "write and read back" check
> + * themselves, if needed.
> + *
> + * For #1, they can see if their target bits got cleared.
> + *
> + * For #2 and #3, they can check if their target bits got set as intended.
> + *
> + * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
> + * the operation is considered a success, and the caller does their own
> + * checking.
> + */
> +static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
> +{
> +	struct pci_dev *root;
> +	int err = -ENODEV;
> +
> +	if (node >= amd_nb_num())
> +		goto out;
> +
> +	root = node_to_amd_nb(node)->root;
> +	if (!root)
> +		goto out;
> +
> +	mutex_lock(&smn_mutex);
> +
> +	err = pci_write_config_dword(root, 0x60, address);
> +	if (err) {
> +		pr_warn("Error programming SMN address 0x%x.\n", address);
> +		goto out_unlock;
> +	}
> +
> +	err = (write ? pci_write_config_dword(root, 0x64, *value)
> +		     : pci_read_config_dword(root, 0x64, value));
> +
> +out_unlock:
> +	mutex_unlock(&smn_mutex);
> +
> +out:
> +	return err;
> +}
> +
> +int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
> +{
> +	int err = __amd_smn_rw(node, address, value, false);
> +
> +	if (PCI_POSSIBLE_ERROR(*value)) {
> +		err = -ENODEV;
> +		*value = 0;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(amd_smn_read);
> +
> +int __must_check amd_smn_write(u16 node, u32 address, u32 value)
> +{
> +	return __amd_smn_rw(node, address, &value, true);
> +}
> +EXPORT_SYMBOL_GPL(amd_smn_write);
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 0681ecfe3430..592fb9d97e77 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -9,7 +9,7 @@
>  #include <linux/pci.h>
>  #include <linux/suspend.h>
>  #include <linux/vgaarb.h>
> -#include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  #include <asm/hpet.h>
>  #include <asm/pci_x86.h>
>  
> @@ -828,7 +828,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
>  
>  #endif
>  
> -#ifdef CONFIG_AMD_NB
> +#ifdef CONFIG_AMD_NODE
>  
>  #define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x10136008
>  #define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x00000080L
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 06f7b43a6f78..cb97d7bdae31 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -78,6 +78,7 @@ config EDAC_GHES
>  config EDAC_AMD64
>  	tristate "AMD64 (Opteron, Athlon64)"
>  	depends on AMD_NB && EDAC_DECODE_MCE
> +	depends on AMD_NODE
>  	imply AMD_ATL
>  	help
>  	  Support for error detection and correction of DRAM ECC errors on
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ddfbdb66b794..29465088639c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2,6 +2,7 @@
>  #include <linux/ras.h>
>  #include "amd64_edac.h"
>  #include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  
>  static struct edac_pci_ctl_info *pci_ctl;
>  
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index dd376602f3f1..ea13ea482a63 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -324,7 +324,7 @@ config SENSORS_K8TEMP
>  
>  config SENSORS_K10TEMP
>  	tristate "AMD Family 10h+ temperature sensor"
> -	depends on X86 && PCI && AMD_NB
> +	depends on X86 && PCI && AMD_NODE
>  	help
>  	  If you say yes here you get support for the temperature
>  	  sensor(s) inside your CPU. Supported are later revisions of
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index cefa8cd184c8..d0b4cc9a5011 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -20,7 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
> -#include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  #include <asm/processor.h>
>  
>  MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
> diff --git a/drivers/platform/x86/amd/pmc/Kconfig b/drivers/platform/x86/amd/pmc/Kconfig
> index 94f9563d8be7..eeffdafd686e 100644
> --- a/drivers/platform/x86/amd/pmc/Kconfig
> +++ b/drivers/platform/x86/amd/pmc/Kconfig
> @@ -5,7 +5,7 @@
>  
>  config AMD_PMC
>  	tristate "AMD SoC PMC driver"
> -	depends on ACPI && PCI && RTC_CLASS && AMD_NB
> +	depends on ACPI && PCI && RTC_CLASS && AMD_NODE
>  	depends on SUSPEND
>  	select SERIO
>  	help
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 26b878ee5191..941b7753dd78 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -10,7 +10,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <asm/amd_nb.h>
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> @@ -28,6 +27,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  
> +#include <asm/amd_node.h>
> +
>  #include "pmc.h"
>  
>  /* SMU communication registers */
> diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/pmf/Kconfig
> index 99d67cdbd91e..25b8f7ae3abd 100644
> --- a/drivers/platform/x86/amd/pmf/Kconfig
> +++ b/drivers/platform/x86/amd/pmf/Kconfig
> @@ -7,7 +7,7 @@ config AMD_PMF
>  	tristate "AMD Platform Management Framework"
>  	depends on ACPI && PCI
>  	depends on POWER_SUPPLY
> -	depends on AMD_NB
> +	depends on AMD_NODE
>  	select ACPI_PLATFORM_PROFILE
>  	depends on TEE && AMDTEE
>  	depends on AMD_SFH_HID
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index 06a97c533cb8..7f88f3121cf5 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -8,13 +8,13 @@
>   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   */
>  
> -#include <asm/amd_nb.h>
>  #include <linux/debugfs.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <asm/amd_node.h>

You can adjust the first header inclusion to maintain alphabetical order.

>  #include "pmf.h"
>  
>  /* PMF-SMU communication registers */
> diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
> index 551680073e43..6e03942cd7da 100644
> --- a/drivers/ras/amd/atl/Kconfig
> +++ b/drivers/ras/amd/atl/Kconfig
> @@ -10,6 +10,7 @@
>  config AMD_ATL
>  	tristate "AMD Address Translation Library"
>  	depends on AMD_NB && X86_64 && RAS
> +	depends on AMD_NODE

the above "depends on" can be updated to:

depends on AMD_NODE && X86_64 && RAS

instead of new "depends on AMD_NODE"

Thanks,
Shyam

>  	depends on MEMORY_FAILURE
>  	default N
>  	help
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 143d04c779a8..f9be26d25348 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -18,6 +18,7 @@
>  #include <linux/ras.h>
>  
>  #include <asm/amd_nb.h>
> +#include <asm/amd_node.h>
>  
>  #include "reg_fields.h"
>  


