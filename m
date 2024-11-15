Return-Path: <linux-pci+bounces-16881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A99CE0C1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F396F28567F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AE1D4342;
	Fri, 15 Nov 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VD12j1cX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7781CEAD3;
	Fri, 15 Nov 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678991; cv=fail; b=BKE2XtahWXV4bVsoW8QkP5tIzgISe89LrixJS3/LLOyHhhXvJPc/x53J3tmhCeG4ztzvNHwufRuv6yO5Y3IYDx7wRoCxrOLuvgaEWbECdctTmn2UssEhmsHbDOysnnHiaMXysgx868v0ckP162WQ0ilsn7EhXN2ceBVTgBBBx3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678991; c=relaxed/simple;
	bh=/iwCfhcb7vAXLlFKKarUKfNCrfdhjTrVjZO74IsUmGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2NsJJClSVm8LTH6OH/cV6FOsmlE3bcJw8TeepxprenOcTROve0ueRpY2I/xu2N3N53pbCUIDrIFQX2EYEfW9clau9k/6yseiyZdWroOF5hsHZ2bpnEtUZxgdcso9rlhn48p7mYTrcsevXEg4Iq+od3MRv03PIPRDQ/MvFK44IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VD12j1cX; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0Ie2l8XHo/W4L2k0bdhl5iv6G0y7SLNlVMNaMsVmTSg/WpVIJrhplckLAZwCxNgChxA6mIAWUZWE73PLP76qJ0Htycie6j9ugdisgLElTgswck7D8ETGVvxiIFsU8Y2ntOMMz7D8hLycLr+/YK5ATwZLceGhg9k7BLygZuZ7nKFGOowwslP4HrXLUnttlOI6nioJUWeIC0sE4W8tULQGgH5CR4HIaTz88QA6xwCa7C2pG0ENcvcaEYCsnOmir/T6EJ1jMGziWE+nYnQ3uxelvPvHlxFNpVA0pq7J3HZP5ToBzyinphtzE+L9zApE6DJXqcIrP44CKeOaaeHBjv16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yoi1C1bYEPoc2T5KrD38JKWPsGvEmW1P60dCt2Roug=;
 b=mhsf5TxPrSSMQOcZLFal0aIE4GUHMU9dQhniZkvUHouRPxMmS1E1v1aYBF+uYfgPt7QbDeKlKIRBnywXlyp+tjBfJnGA3kKTB1JquZksGF6uwH/YiUXM1IZf8stxp+vgRXrR1x6m/jxe+mzK45rSE3Mhz8AQCWSa26OfqGSSYUv6o088cG97GYUN2wyoWEuD1KaLlEYeiZoMM20CJ7pi0QIA/q9Jr5XmEgFXlZW95dI3hBThLdt87VviBAp9hW22JsHN331ewYoMIWap1KyuInpoSvS4miN/H0dgvRhUIVzZf5K28kwQ87Ls2WTm98UrbiT3Sig0xvR/q2a3QX8pMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yoi1C1bYEPoc2T5KrD38JKWPsGvEmW1P60dCt2Roug=;
 b=VD12j1cXzvgqqcGF4Ko+uT9flhB2MkaV3fIEeBoERW5qpilYG/IcvUbI4pt+xMESsrek7hs5BbqrPVMBBRt2wFvXdQ8j19yETDpzRIxYbn0bxEfPRh4U+bjOC3VzwqPPhKyxblRz5O/1OnWmpBqara5/vbJfgMVc0VsJtQyKMlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.19; Fri, 15 Nov 2024 13:56:26 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 13:56:26 +0000
Message-ID: <7e1085e1-e6d8-4593-9299-3b4e273ff1f4@amd.com>
Date: Fri, 15 Nov 2024 07:56:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com> <ZzYo5hNkcIjKAZ4i@wunner.de>
 <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com> <ZzcLe3tDPa6TYs1h@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzcLe3tDPa6TYs1h@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:806:127::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ee6e02-583f-4b20-bd1d-08dd057d4c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0piQnVwTHF3RDlBaWhHME8wV3JXTkpETXlDZUJkbllIR3VySnlBcHQ2OHV0?=
 =?utf-8?B?alM5cHdMTEFOLzRodURiNWhHT29ONk9yU1dDbExGeFJXTkhMajR2SFdoa3Q0?=
 =?utf-8?B?Y2lROFQxUDRVR3o3TEk5NFVGQW80VDg5c3M0UHhpTitVSWY5TExoMkM0RGhs?=
 =?utf-8?B?WHozWDMrSUgyem1jMXFHdUQyNjRuQ01RTW1XQnBueEhNc3FQYTFjWk1GNXRL?=
 =?utf-8?B?V29Db0drZ21raU15T09FVUlHdEw1N1VZRHUreWV3YzFTQnFqSG5UQ2tjZ3pr?=
 =?utf-8?B?bDRMaTljRC9oRVRUQnlmS04rUW8xUnE5K2d1MnJqem81V1BsRHlHQTJpSDFO?=
 =?utf-8?B?VitNb3JHWkQxVmJEbUxoYW9HQWFrTDVGSUZYcTlXT0dWUG1FU2ZhVjVSWklx?=
 =?utf-8?B?ZnhzcExLQi9pTGlEM2VxUk5rSjZIMHpjSW5USTUxblFaR2VWZkMzdEZaWG5u?=
 =?utf-8?B?d1c1RC8xVFlrMEIyZ214em5QcWxENnlZQ3Y3MWMzMEIxZmdLUWR4QWJyNDJD?=
 =?utf-8?B?YnI4NjlCbnVsamg3UUk5RDF1OFU5OG9UOTl5Q2U2c2hjY002a3RodndSaDFK?=
 =?utf-8?B?ekF5QVNRMTI5TTFCYktqY0VzNDcrdzN0VGtSNFJhUzNsQnlzYTRhKzBXNzM0?=
 =?utf-8?B?eXMzNlQ1Qy9kanNzRDQvNy9nQlR4bXVyWXI1YUc2S0U5L296bGs3MCtFV3Vw?=
 =?utf-8?B?WVhjOEdWSk03V1pGNjhYb2dLN0FFaWZHc0xMMEYvSDIzTlFSekFQV3ZrMmhM?=
 =?utf-8?B?WUg0eFlWMldKWVordHd2UmRjQ1g3REFCRkdxSURYblc2VDBUSkdLMVF2dnZD?=
 =?utf-8?B?cksxakxiMjBHTUlTeG9xaVlOQUo1UWNOeEgxZStRSnNFUVlFUXhyMXoxVHJS?=
 =?utf-8?B?SG13MitkWmtYTmZ2L05Uei9YNVZVdHhnK0hnOVdKczVnUXp0UkdlSDVDc1lV?=
 =?utf-8?B?REh4dGVMajZHdFordC82dkZ2L1ZSMTA2U0Z2WDRtam1Hb3BPdCtkNmplbjY1?=
 =?utf-8?B?TDBlNFNaaUUrRExoUlBRWi9paWRySWdDbmRWWHQ4UzFZcHo2MXorTTZVSjNM?=
 =?utf-8?B?WXo0c1RxT1d0VWhON3FPWWFyZXAwKzJUNjhWa0FPTW82TlJTWk1YVDlTbEwr?=
 =?utf-8?B?THNCNGUwR1VnRU9peElqb2NuVmdIS3k3WXhDYWZvNi9LcHI5ckpUS0l4WjJD?=
 =?utf-8?B?dzlzU3l6dUN5SVJtMVdLcGIxcWlFS2M5b3Q0c2RLUUJhQzVpNkVwdlFMSUdU?=
 =?utf-8?B?MUdZRGVKTHhFbDJucFIvbzkycWRLbXMwUERMUVJ2RHltK1RxWGhCcEJwMmRm?=
 =?utf-8?B?Rnl5WVNVdzh2dHJZL1RwOVlKaVZadGk5cGhyeTFpamJoOEtFR01MeU84ck1J?=
 =?utf-8?B?UE9qVkl0clNETGlZS2Q2Y0IyRUlLaDl0QnNTTGhNWUM3L2ZhZkY1TlA3Qk40?=
 =?utf-8?B?dnZGL0hhZXNLdk4veFkxbnJpS1owTFRRNytlK3pyb1VlamZGNWRORzF0V09p?=
 =?utf-8?B?VzJkKzh4OHJZRnFsRWVBbDJzY0hrQjdhcTZpamNQQ3krQktIbGdHZXdMc3l3?=
 =?utf-8?B?OHJpenE5ekovbTlSemQxVzBnNWpNWHpjS3Q5YkhnL2dkcHJWdjZPby83Ni9m?=
 =?utf-8?B?NW9KeGx6NVV2YjR2Qlh6VnkzMEtKMTBESmRNNVVsTlV0M2Q4NzMxV1NUL2hY?=
 =?utf-8?B?Qml0anpVcDlsR2V1ak55TzFDcGYvRVFiZXdJYzEvaGF1NG11ZmNRU2Q5eGhs?=
 =?utf-8?Q?z5aFVzwBc7w0g1WrpBECSUSdBNLF2ptd73Ur/gi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2hPTlVtUWI1WTlMMEN3M3g0WnRzMnJ2RGtIOFZYMEgxTEluSncyMEFNMDZm?=
 =?utf-8?B?Zis1Wmg3SXFqeW51SENybHJzYjIxOTY4RURwWFdLM2ZwcStleW5jb0t1aHFM?=
 =?utf-8?B?UFcrY0NQUVRROEtxa2hiYkZVWFZWck5QMms0NTF1cndtMVlUbmhMcHlWWFkx?=
 =?utf-8?B?dW5CRlBmNnY5dTh5UVB6RXZsVWt0dDl0eU5EbXFJb1R1blFsc2pTM3I1ekZI?=
 =?utf-8?B?a21FRk8xUm5ES0ZWUEZLTkNHZ0pMbm9PWDVqYUR4aktNakR3RXIwdHJwdk50?=
 =?utf-8?B?OWovL3lrTlU0d2Z5eXNQUWQ1VnhOVUdidnVtekc0amM0T2tWMjFENlVKMTFa?=
 =?utf-8?B?cjMveVcwQUVDTzVMNmZUc2NqcDNlMnFOeXdma0szeGR6OGVsV3lLYnVkSVlj?=
 =?utf-8?B?S2laUUl5TUROZHJVMi9Zc01OMGZHQmdBdVNiU3VJYnBPYWJWKys2NkpYTWY0?=
 =?utf-8?B?cFNnaVNmTDBBdVBQWnBBREt1d1RoY3kxWVAvT1JiZ21rZnVoakxoUThob2xv?=
 =?utf-8?B?WWh3Smw4SGxqbW92VTJ4OTlxUHF0bG4zRWQvZG44eUZsNnhSdTF6U3hvRjQ3?=
 =?utf-8?B?eDFHZHZUZlhZVEZyZERYNGN2bTlqcG94YkdLelBHemZleWlhT0F3cXVOanox?=
 =?utf-8?B?MkNBWkN2dUVqcUlDSzQwWUpCWktDby9qZ29XN0h3YkhPNDFhQ2JNeDlLaHRj?=
 =?utf-8?B?a2dJUytRTHQ5TWE3Z0ZlTEFEQVhDUkRIczQzeW9VQ0NwcUpLM29BNXRlVmJL?=
 =?utf-8?B?TUJQUEJQT3RJdGVYMkF4bHVZSHhHVXpiL3Iyck1QdUVlZUtxWXpSL0svOHAr?=
 =?utf-8?B?OUo2ekFUVFgwZE5sRTVOcmR0S1lPRDVJdVprVk9ubFV3MTM5N0szanBMQWRq?=
 =?utf-8?B?eDNSMFdOOEFVQVZvOUQ3UkI4WWhqZERwbS9BU1Axc0pQUWlpd2FNbmNsMktQ?=
 =?utf-8?B?MlFGTmNBTXNqK0ZuZ2dFRTMwQnQvb084MG8vRk13blhMSCtvN1lnMWU5bTU3?=
 =?utf-8?B?MHFaZ2E4WXo5WUxadk5WdUgyOXk5cDJhNGkzcWZOVmsrUU5BYUNMUC9GWXJD?=
 =?utf-8?B?U2JWYW4zUzI0TGExR2tsMXFVT1BXVDFUV3pVcE1DaXZZdDZRSC9QU3hPWm42?=
 =?utf-8?B?YW9DZm9DNjlWOTk0SFovRUhoNXlFUEhCMkkyRmNNUTd5OGNENEhQQ1JXWHJX?=
 =?utf-8?B?OW1ualJGTWJTczZkU3Y4ak5MMlJYSTFWMlo1aWpjdGJaOVc0QnY4bjNHaUJH?=
 =?utf-8?B?Z0xmcDB0K3ZQWFlTcWtUVGEySkVBLzUzbFBHdU9GbWJlWXNwYUE5QmpsbzdE?=
 =?utf-8?B?YVIyN1owU3pTc1A3ZWlyc2dmeGZNL2t6anJLeC9kdktVc2ZXZUlrS0V4aSta?=
 =?utf-8?B?QjdGZG41SlkvVmE2OStDcFV4Ui84Q0lRa2hiblQra0NTRklYNnhZTXV0WTJx?=
 =?utf-8?B?Z3UzZmZlRXVqZit3ZGZ6dVUrc1BFSmF2UmFiMTFxY056T2JjcVRKbTUxRy9T?=
 =?utf-8?B?dmdodFgrdjFPVUZ6WkN4ZE5CbU9mdzR3emxjNTZxWDE3MGorTXBLaHh5cmZk?=
 =?utf-8?B?TVYycXZDTXRZUldxWjcwd0M1M2dqQlN0VkN4YUlkbGRSeGtOd1NONmQvL1Vh?=
 =?utf-8?B?TENFRUZIMnp4TXoxYjVxaVB5bEFHaEdFV00rckpKQ0tJU0lPL1NIdW04eWtx?=
 =?utf-8?B?UGkzVEZjL1lEMSt2alVXMldVdmxvWFJIMzJpbFNHbENLR2Y1SmI5bHB5dnMy?=
 =?utf-8?B?eHViVXhFbXVIWjNmdi94a1E2K2RBa0dWcHE0bU5sUTdEWmdKOEU4b3JGcW9N?=
 =?utf-8?B?eEhsYjI1bTBTallLbE4xWWpCRXhDc0dpc2ZCMzIzYVVER1lEdC9uMm1wd0t2?=
 =?utf-8?B?K2Y0alJ2akVJKzdFUStVYVZIVWNQK05QOVBsckNjdzNyRlFHcFpGakFPWHZq?=
 =?utf-8?B?SUZ6Qm1uNVVGTTdzWm5BN3NETkxaRnlZci9NZ24rQlBSWENOQmJHM0t0bjRh?=
 =?utf-8?B?cEI2RGF6S3VhTVZiMFRWaVRuTTdyTUZ4TlJEdnF3SFltNDM4VEVJaStWeHRW?=
 =?utf-8?B?UGpzZGlFQ3hDMC90NHBjeUI4VCswMWRKOXpIOTZ6ci9EalJNTkc1TEtvRFdo?=
 =?utf-8?Q?p2l+HxMR9H4e1RiMPOvbZqcAa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ee6e02-583f-4b20-bd1d-08dd057d4c60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 13:56:26.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXeF7PVEGt3rqUCbaXyqA/AoOYTbSo/ucIEHNq5fCzNyYm1ae/UwY/f6xWR4Qf2d4PuecGWowDKGSoWRVnLEcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004



On 11/15/2024 2:51 AM, Lukas Wunner wrote:
> On Thu, Nov 14, 2024 at 12:41:13PM -0600, Bowman, Terry wrote:
>> On 11/14/2024 10:44 AM, Lukas Wunner wrote:
>>> On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
>>>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>  
>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>  {
>>>> -	cxl_handle_error(dev, info);
>>>> -	pci_aer_handle_error(dev, info);
>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>> +		cxl_handle_error(dev, info);
>>>> +	else
>>>> +		pci_aer_handle_error(dev, info);
>>>> +
>>>>  	pci_dev_put(dev);
>>>>  }
>>> If you just do this at the top of cxl_handle_error()...
>>>
>>> 	if (!is_internal_error(info))
>>> 		return;
>>>
>>> ...you avoid the need to move is_internal_error() around and the
>>> patch becomes simpler and easier to review.
>> If is_internal_error()==0, then pci_aer_handle_error() should be called
>> to process the PCIe error.
> You're absolutely right, I missed that, sorry for the noise.
>
> Thanks,
>
> Lukas
Thanks for taking the time to review.

Regards,
Terry

