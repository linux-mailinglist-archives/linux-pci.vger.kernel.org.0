Return-Path: <linux-pci+bounces-13441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75769847C0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7483628512C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394B1A76DC;
	Tue, 24 Sep 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yr3ki8cf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C61474A4;
	Tue, 24 Sep 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188474; cv=fail; b=QAKk1AwANWAIr+n7GEe7i1WMyvUXNarZz6WaVVIuikjrB0+gvbAxlnoF57grHiul57hLlj3KG057WASo6SrOimOTL+tlH9uwamJXzCRZE9EN5/ooHu2rJBCzbAEbePflSRlV1384bjF6SlQLZoPrMuZjYDgLDgHU5frhyTwZ1Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188474; c=relaxed/simple;
	bh=yIC2mQmjxvOF56PfKiMY2R9cbSVuVwrzg3qtnHMurzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S7NtqS8H4/PUeDoCyEA7MH5QIskDR39UHPSdyjYJI3u6cQSy9u0qY1ZNd6DGVUwTbChuWpnoxDGmQ2PF475JVYZ2mvcIbGXPdz26d951OItHWHXBSLY0VnaX4QdvxubK+Ctv+WwpWO54JEiDUwUM4v7ezS8nRLMoxe1Fi2Jv3No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yr3ki8cf; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRWPHX/u5/ZM/N27XgxJ3VKx+hThFDLRkE2TKzLRkEtDp0z63AexEDwXvqW2YcP6F2u+5xGIVHlyYv28f8/CQxG1VI2/WlKtCn7XruxJC4J/Wf0nmi3Q3DPECKgCPmuk2i7deYCkCJIpXy1L8N6Q3eVhXTRde0qC/LgOBgE4P93CXQorRwzylPVXeWk10+1UH+Ezqr0Yz6HWmWCHVucMsFIym8dFd5oV9LvopaQmoIpLPRCveiuhe2I3WD1UsElhhNwGXT6964VFO5pACRpjsNSEQn+BPXN32MjE0Dz0VY44pa/ZQcX8TYhIcdAl3ziJfKvYlybffsswGLcTL42mHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tzVLOf+Ad1yWj8YnOWIS8Xtwtg2vttrgUXoONJ7ZbI=;
 b=OJufPYEcfFsh2VGzh3drzBeN2RAB2OT+F/XRSuC1XOVg4hx4jXZAG+iGKN+HH538dWK7cDdIRIBTxxzhWMpBcVSDh8JsNEvXhFd8/LurJ9sBAXQ6zcuUlB49WufutywiNR1sTX3VfKHEIIrekL8aRBN9/qSBMhK1hXEhxIpqLMRZ1dtbC+G2A7pCmyvLaxm+ngkLu2FM3tUt7bX7PBwEkuu8IKAfgWp6Yxt0JtzkrhxX6TGo0ScQuKn3xXCTg8wIYLS/X0pUg9lmZlvSvlsu6hMlzSIZTvOLtpAJAlJUTuq4oD06fxMckLxHxHGLwlmMIMqGUmkskrQrVSAC62CaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tzVLOf+Ad1yWj8YnOWIS8Xtwtg2vttrgUXoONJ7ZbI=;
 b=yr3ki8cf4val+vLh/+Eyh5CtQ2s8YexmVclLbcQ6+2YHT3mBx1cJRRldsHiCPETKHpc55Mzju4YtrJLwgZ8BESo5FEm/sQVdDa5Hpj7VE+ZviTskHDwoiI40ZK3wQzwuZps7lXjn7Qp03Sh3iHWPVfDzzVhlXoWXNUVJkHjEK8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 14:34:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:34:24 +0000
Message-ID: <26c176a9-aa68-95de-7157-b3669d5bb404@amd.com>
Date: Tue, 24 Sep 2024 15:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-2-wei.huang2@amd.com>
 <a660f2be-55a2-eca3-bfb3-aa69993f86e5@amd.com>
 <87111ebf-9cfd-4e14-9c03-05aa65330070@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87111ebf-9cfd-4e14-9c03-05aa65330070@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:10:100::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aee82bc-48dc-4252-3ea7-08dcdca5fc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHcvVmY0RU1JZFduZU5yNUtqL0ZUNXpXZ1o5TzBIai8vVzhVQWVsSDdsbXZI?=
 =?utf-8?B?ZEZsS0l3aXpHdGw4clhRQ3RBQyszTDUyNG1OaWwyTFBCSkM4QlJVNzF4dm5h?=
 =?utf-8?B?b3pzdWJzcXZlc1RLOURBSXRBU0hPR2k3cEJTRllxTUlVWjJOQUNnYVRreXNU?=
 =?utf-8?B?Y3hjUkJCdnFMZy9sbUd4Y2thdDNobVNzUWZZSGV0aVdwWmJjUjhiWWR1d0lv?=
 =?utf-8?B?dnY3Unc3dGVaeXNKakJlQ2N6bDRKSytvczREem5XWEZHWnErOEZrVGcwSDJ4?=
 =?utf-8?B?dVRrU1c4ZlNNbjNEenpVSHNPZVZ6VWhJekRSVXFEU3g0bXZzNUdUdTBrSWdy?=
 =?utf-8?B?TThzMzRTalRyWkVZUHVmSGkxRE05YlNXWWFIQ1Q1c0tWa3FvWEprdEFsNWZu?=
 =?utf-8?B?V29CbW1vUlVzSjRaenVDd1hnVE4yUDRoY1plcnMrWGFFOVhxempJY2t2Mm5x?=
 =?utf-8?B?ajYzbzUvclV3R0ZvNkd4QzRNSDMzOWtyRmFDeEp6NUdvTlQvMkFuQVZTM2Va?=
 =?utf-8?B?RjlUcG1nRUl1a05rM09ER1VwZFN6UG5ETUtyYldGVkE5NDJmUjdhS1JPb2Z3?=
 =?utf-8?B?WDVzeG81UFNnTHJodld4UHcvMUV2S3NBa0lvMU8xbTVoOWEwZmEzQ2w5SGhs?=
 =?utf-8?B?bzU3NCs1MDcwUUlYdElwRHAvcThQMkZIaFkyRzRnNGpMaEdaWTIvbVdVcmdG?=
 =?utf-8?B?U0hzMGVabW5wa1phOEM5dXZmdmp1N2ZzMlcyWlhjVUN2YXpFMTJMbGpvcmhp?=
 =?utf-8?B?TVpEc0ltZlpVT1V0K2pWQUJEaG82VktXV1J0Y1hBWEY2K2lBb3V0T0J1dS9Z?=
 =?utf-8?B?TXlwRDk1aUt5dC9MUHJBd0ZSMEVRM1dtdC9qcGtuWWFRWG5qL09WOXkwOFU0?=
 =?utf-8?B?eS9uc3ZoNmdqemI5bDhVN01ORlRPc3poWmsySElDMVZadGV1RzB3M1FNMzF3?=
 =?utf-8?B?UFczenYwK2FqTlpnZ1hpcGN5NEYwcndQc3pLYWV2VzkzUVhPNUxoRUdDa3Bh?=
 =?utf-8?B?WWVNZWFkcnc0Wkl2MmVaeW9mVDVSamJkR1lOSnpiUjBQaFQ0RU41end6bW9R?=
 =?utf-8?B?b1lEMnFjeDdOMkNIZ2gzbVdSS3VTU2srYTludXVuMURFWFNiZGR3MVpFUTlv?=
 =?utf-8?B?TnV2Rk5qWEI5Rm40SXdvRjc4ZXZISTJPdFN6M3REYW1xZ3diaTdWMlJaNWVW?=
 =?utf-8?B?eEJSNDNwdzhTT3REa0pEQzdwNkxtaVkxOEMzaUZ2eTBJZkZnNkpmT0pEZ2xQ?=
 =?utf-8?B?TVRucXZqaVIyekUvSms0MUw3NVRCRXpLRDl0Tjg2Z2RmUmdaM0xpY0JORXB4?=
 =?utf-8?B?cDdZRlMzTk9EaVdIeXJXQ2x6MGNoQng4ZDBBTDNhTWJCSnhmQkdPZUY3eGw2?=
 =?utf-8?B?Y2FoMzBuc2c0bkxuSHg0Y0Z2UkFuTE9BeHlyUkZGallVS0lKS05za0ZkSHlj?=
 =?utf-8?B?bktxMWVabEdWU242dXM0RDIwVll3OEovQzdPb2o5VzJKZkpjb1lKSTdUTm42?=
 =?utf-8?B?MGNyT1dKNUdUNHFTMisvTTczWnlOZmFWbGpndVhCYytpMjNsclNoM2wzeXRI?=
 =?utf-8?B?eS9Dbkt1T3BtTDhRWnJORjNIeUE2cHVOclg5aGFtYzFMUWJHaDgvaC9tOFVN?=
 =?utf-8?B?NUtTb2lFNFVkTTZZWVNqblVaS1RRVXRrYStHaU1HaEpOYnd1bDIwdnV4R3Bl?=
 =?utf-8?B?QUQyL1VWMnk3bHBZUWNVbm01c1pQc2VmZ1FDdmd0dFVvYjZlRExNWmVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXIyMUpMRWhESldRQm8xMlIzb25XNC9peG84eUhQc1d5a2lLRWdTZmVqdzBO?=
 =?utf-8?B?aHkyd0NQMjNDdkhMS1c1elhEVEkwa2xYOGdmNWdobHhCeFZmNzR5NXA2M1dN?=
 =?utf-8?B?WDdTRDJZVFpvL3NzN2taUVNOYnJuQVZyZU1JUE9kellxT29tWkZJNmV5M0Ft?=
 =?utf-8?B?WngzWkxkZW10Tk8zUk5sNHVoQmd2S2Y1ZFlNdUF6ZmRSV0xBU2lnRnIvQUNx?=
 =?utf-8?B?ZHlaMzZTNzNGeGlkaEdzbTd6c1BTS2hMQllrczg1TU1iSStnV3grazc2YUoy?=
 =?utf-8?B?N1h2bVJOeFZMSWdVazhGTHJrUXJDUkVKSkMyemZsS0RUV0dLTS83cmpLUkVF?=
 =?utf-8?B?dDNSUG5kOGM2OGc2VldvMW1jemx5enpIUTVpWlVYZTJWVkhva3RrbVQ3SkNL?=
 =?utf-8?B?eDlNalVhL2JFMVFCYlFXM25DUWlxU1N1dE5Dajlhb2poYkRaV20vVmpkaXNp?=
 =?utf-8?B?d091d2NSS29LZW0wOXZIQUNzSkIrUXNHc3h4cUhtWWFOSmw4NmtRVTEyM1V4?=
 =?utf-8?B?d2RXTmhNaEQ0L21mRDhDeVdVQkpDWW1pQmpaTFlCN2lkR2ZodndMYldzSmZ6?=
 =?utf-8?B?bmRleW8vY0oxY3YvY3UySFY4YUFZRjRjcFlreXl5d2luQUFEVFl2eEx2blhn?=
 =?utf-8?B?L3ZFRktlZnVLcWZpMG1tSzYzTXA2RGJaWjhDeFpISVZQZCthM2wvdG41dWxN?=
 =?utf-8?B?ei9DRm5mT0U0UU9aYVBDa3BUVlhEWFE1N0NKeVdaQ1YzdVFKc2RVUVIvOWVy?=
 =?utf-8?B?M1VidWIwOWg3TmdxSnh6eSs3QTludXV5ak5ieVkyYTV2K2pGNDQ3S2V5Z3hz?=
 =?utf-8?B?RS9OOXlpWkpQd1pMNW1wT0NjbVA1U3V2TnB0YW4wb2lpL2hRQi91ZCs1SU4y?=
 =?utf-8?B?amYvdC85QUltczZORjB6RW5QeEI0bTVHY2FSUHVTaGZ4ckwxclZHRk5VWWdU?=
 =?utf-8?B?dENmQ3h0N0hGZlpEcm81dXAzaVEyd2p4RUFOM2V4d0tZNm1ySkJISTlLc3pO?=
 =?utf-8?B?T2E3dnd4RE9reUN1VnhtTUhoSFd4R2Q2cWhqQlVIZXYwc3BYUGRRTUYzRGZn?=
 =?utf-8?B?aU5TYmtFT1hIL0dJSEZVVDJnSHFBbVN2L2hGUE1jVWpFMUsvVzFpcXY2VWo3?=
 =?utf-8?B?WlBoN0VBMW5LZFNySmV4S0g3d3BlaWpwWlNaNlZ2Q2UvRGQ1M3pvRG8ybUk2?=
 =?utf-8?B?dWQydVhJNHZvTDBaeGF2TG12TkFqQ1RCZU1zL3NSR0hWeWJrM0JHbUN3SDB1?=
 =?utf-8?B?WmsrUm1aYmNKNHJCU3BjbmFZb1Z3cWZGUmJPdGg1WVN6YnBCUExma2pJUjRM?=
 =?utf-8?B?amtVQ3VhWkcwUS90MzZ0aDJUV21IQ3pRbHF4OEhEa3RtS0tnVElDMkUrVDh6?=
 =?utf-8?B?ZXQyMk1XeVdDVXltMXpWSEVEK0pHb1QvVlo5TU9pU0JQcFRPNlpWSmt1SGxi?=
 =?utf-8?B?czEwRFdsRnY2cjMxV0pXQkNBSDdXc01UcFVYdkhJYnp4SjlmdERtQjJwZHZp?=
 =?utf-8?B?bGx6WUV4WmswcnhWSmtScmdXZ3RkUDJ1R2FKRmgyenNxVm9YamR2OWdVQjE5?=
 =?utf-8?B?WER5ajhYNHpVL2wzNVB6VEFPcHh1ZTQveWdvVTk0QW13Q1piUGd1UjZzL0FK?=
 =?utf-8?B?WENqWEZnR2tDWnBjTGdpWUJyQk16UFU2MnE4TnkyZVFORjZ4RWhDL2syYm1I?=
 =?utf-8?B?ZU93bklsVTIrK1VDcUlwREs3c1lnTVRHUko4aGtpY0dhaFpLeUdSYkJjV3Iv?=
 =?utf-8?B?ZHhhMDdVMm9RTFU1RytiTkhMZDRrM0puZE53NjdvQWtIbEhZbjN6MStyL3VW?=
 =?utf-8?B?VFBlZ1lxeDY3RlNDZkFnUVhSU3g3WCt6cXFHUWQ0L2ZSeVJGRk1lMmM1VEY5?=
 =?utf-8?B?UGlVU3Z1SWMzbWhQc1ZhZHNHUjQ3TUFYcmFab01JelFQZlB5ejRObXpRcnlV?=
 =?utf-8?B?VnJ6M2FsSW9IL2krQTVSU1FtKzBKc3NVMEVxalFvSC9oZ3ppUi9tTDZaNGc1?=
 =?utf-8?B?emE4bmt0elljMC9UVHI1MHorZkhaQUEwdjlpV3NsOVh2eFRRdmEvbG95Lzg0?=
 =?utf-8?B?b0k2aFlITVI5NmVnaUxXMTF3dmRFWmZkVmlHelNJVk1ZeUMyNTlMSHZ3M2Vp?=
 =?utf-8?Q?vV+sqq8kUWm71MR0rCiWaJsj/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee82bc-48dc-4252-3ea7-08dcdca5fc41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:34:24.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idZ7SMywL/Y1ZRgSDzvsXIB3CdCrxRWNh9QqLOt5zkYeDQ0ZZm3qeiW+qSmFE9TsVFlu79HfaYz6arkkjmU1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303


On 9/23/24 21:27, Wei Huang wrote:
>
>
> On 9/23/24 7:07 AM, Alejandro Lucero Palau wrote:
>>
>
> ...
>
>>> +/**
>>> + * pcie_enable_tph - Enable TPH support for device using a specific 
>>> ST mode
>>> + * @pdev: PCI device
>>> + * @mode: ST mode to enable. Current supported modes include:
>>> + *
>>> + *   - PCI_TPH_ST_NS_MODE: NO ST Mode
>>> + *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
>>> + *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
>>> + *
>>> + * Checks whether the mode is actually supported by the device 
>>> before enabling
>>> + * and returns an error if not. Additionally determines what types 
>>> of requests,
>>> + * TPH or extended TPH, can be issued by the device based on its 
>>> TPH requester
>>> + * capability and the Root Port's completer capability.
>>> + *
>>> + * Return: 0 on success, otherwise negative value (-errno)
>>> + */
>>> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>> +{
>>> +    u32 reg;
>>> +    u8 dev_modes;
>>> +    u8 rp_req_type;
>>> +
>>> +    /* Honor "notph" kernel parameter */
>>> +    if (pci_tph_disabled)
>>> +        return -EINVAL;
>>> +
>>> +    if (!pdev->tph_cap)
>>> +        return -EINVAL;
>>> +
>>> +    if (pdev->tph_enabled)
>>> +        return -EBUSY;
>>> +
>>> +    /* Sanitize and check ST mode comptability */
>>> +    mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
>>> +    dev_modes = get_st_modes(pdev);
>>> +    if (!((1 << mode) & dev_modes))
>>
>>
>> This is wrong. The mode definition is about the bit on and not about bit
>> position. You got this right in v4 ...
>
> This code is correct. In V5, I changed the "mode" parameter to the 
> following values, as defined in TPH Ctrl register. These values are 
> defined as bit positions:
>
> PCI_TPH_ST_NS_MODE: NO ST Mode
> PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
> PCI_TPH_ST_DS_MODE: Device Specific Mode
>

OK. I found the issue. I was using PCI_TPH_CAP_ST_DS for the mode 
instead of PCI_TPH_ST_DS_MODE.

That change confused me.

Apologies.


> In V4, "mode" is defined as masks of TPH Cap register. I felt that V5 
> looks more straightforward:
>
> V4: pcie_enable_tph(dev, PCI_TPH_CAP_ST_IV)
> vs.
> V5: pcie_enable_tph(dev, PCI_TPH_ST_IV_MODE)
>
>>
>>
>>> +        return -EINVAL;
>

