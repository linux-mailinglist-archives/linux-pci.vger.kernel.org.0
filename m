Return-Path: <linux-pci+bounces-16775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016E9C900A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EAB2818A3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2423183CBB;
	Thu, 14 Nov 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="arEEJhfk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918E5674E;
	Thu, 14 Nov 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602748; cv=fail; b=b2xvqjdnMThVdzPNI801kUByxIppd+VQIAgnrRfPpSeC3Vgw6swCFGF6zXxgfSChYHC7SH2LSPLIidXJsRln3P5FH90o/bAgDIHIlCCmmgCN9UIal9PN8KxqSm1NBnjQLaYFXdff3I5pOM0qKKyrRDA6FrMsB1az96uxTd+Zwp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602748; c=relaxed/simple;
	bh=vY4sylF4chT2u1b7cklV4LMGnqqXZ73EEkXOJT0EneU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ocBdkUVe7+ibmV1A1QGrC5pH0mgV0LAryi4TSDEskCP+7V+S+9ZATBasa8uekNcA1ibb7z9UC/2Hp7mV1d1NjnDX2dAyKmBH2Z9pd8QR/SIz+ITvzbCio9uMlErA3lQJ6EHNBiOEdzS6wdIQI5fkGeLkG6exBQHfONoiQZkr/Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=arEEJhfk; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfUvkNIednhKIQiL2NdTUL15cPYiWCCksG6vdOr7xOUXoImi1xJCwiTiibuJ2cKzgTwHvBjHP+HKw7Az4LmBwOISi5JiNDdhdaoV0/IstrzHzYQA38Z/kWEiAexpKo3DZZxui7VCs8n3qOg+2b91hQ/ZCQlZ9YhWj46iN+iJOfrCyrtTZuMRJ227i6B5bYMAyL8o0/b12lLNocuvodjRYoP5JgwC1sJW9hcPe25ijqCbuMIjvrst9zcuugIIGgo+1BIvGpyE4YJY3+sBCSq1gavLrJsB8T7NQFEtMlfDt7GfLs1CseJkg8/i0MW31Ape1bTqORU5iFzZO7IfGinsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmHDg+uLNCsZCItGjekeag72nS3NW5S9+Em49zMBlr0=;
 b=kiXGvxU1gr+wGU0zQG2s70bjhFmgeFO5/L3X0lyY2HAnz8K332ZOe0wNM9Zw6rNfIKsAHpyiUFvGWOjNwSguhDw5YR9xBniMzWynBSFhfyHo8bRhAWBdco0GFpk2ZF7IpVQX7mwrzO0+2iwa/x7OhD45fMXs1UTfT68yWwtH167ehKNktsdwChIRC9eU7CcjTdsfDB65f9VCcnUJfufHS535Vhseloceie3UkrWIeNwJ2zKmS7hkB70KUQx/JcF5nUESNtkj6MEKx+Zu47nOIUD0WOQ2m2PUG3lne7wqpqshsv7CtPeP+ySEyOpSEVMmfXI/OS3KsrA7nwlynb5Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmHDg+uLNCsZCItGjekeag72nS3NW5S9+Em49zMBlr0=;
 b=arEEJhfkF2zDPChiOB8MqkMiTk7Y6rcN17/jfu//lC7CDM6x2dPPJimjx0OIOb7se5ugDkwVKPcGg5VOUsw74i60sQ8IUUIw20GiTpfbcamMTcwY+wPjydQuWonLxpCqumlkOpQxIsCGsI1Hj5BBy6Q/jZvMD1N5cDw42q76s8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 16:45:43 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 16:45:42 +0000
Message-ID: <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com>
Date: Thu, 14 Nov 2024 10:45:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
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
 <20241113215429.3177981-4-terry.bowman@amd.com> <ZzYbHZvU_RFXZuk0@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzYbHZvU_RFXZuk0@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3fa4a8-8e1c-41ba-93d5-08dd04cbc75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elpnR3pvY2ZWY3A1YVY4VjVNWVVxSFc2Q2pxL2tzTlVvNU1KMVkzdWpLM0M0?=
 =?utf-8?B?RG9mREVzZnRELzJ6cEcwdXhpZGR3eVd2aXhzYXM3ZUlqWFpKMHBrMGw1NzlT?=
 =?utf-8?B?amJWV0lBV0dNSTlta28xaVRTcU9QRWg4UUFkWXFXUUxYWW9sTjNrSS9raTFw?=
 =?utf-8?B?VlFqYXNxZjFwVHpZYlpEWGxONVBtVnVYQ0FQNGl3UElHNG9KNEVNOGN0WXhZ?=
 =?utf-8?B?d29YZWtaNW5mTmw4TU1TaXJXdThPdVdQZElNcS8yVGN5R1BjL0pZOTJONFlE?=
 =?utf-8?B?d2JNWW1MQmVUcVY1UjRGVDZKZ2JRWWxIV0JDdTJPMEFTUWFJc2J2QTVoMXkv?=
 =?utf-8?B?dFFkZXNaRWM1eDJqYTcrTzc2M0oyb0hzTjFWcnhjeUxvZk9NQmNOSk42azg5?=
 =?utf-8?B?dXRVWERyL1Z1WmRyTHRnb1cyL2RFbGhoTzJrTWo5bmxOakgzWkRnK1BmTzdP?=
 =?utf-8?B?S1IyVHZsOGVWdEgwcFYyMlQrMmFnbzFSTGVWMDdGaEJiUDNmK05RV3NHRkxm?=
 =?utf-8?B?OFI1MnZlN25NSi9laUFqdXBMdmE2d3ZzOWdiYVdpRTVaZytZU2FsZ2VRNnps?=
 =?utf-8?B?M3VxOWlaelVsYWpTREQyRHV6WnY2WlJGVnlpZFJzNE9DajQ5MUlLWlAwOE9I?=
 =?utf-8?B?TkZGMnRPRGNSbFkwRXc0OGRKVjlGbWo4d3dlMzFYWTM3TXM2Y2IzY0wvSkpO?=
 =?utf-8?B?cGxBZXl5dnFWMUhpZXZlQmUyUWZHTS9xemUzL3k4RjJ3TzNMRmFoZURIbHgw?=
 =?utf-8?B?bDBSdk95cnptTXN5WERGZkgzUmpqSlBubU9DczhkMFhHdGJnSjV3c2pocWI3?=
 =?utf-8?B?Y3JLZmxtS0Z0L3NMU1RRaXFXNjB6QTFScFJvY1JpZENrRXR0K013VERoL1R6?=
 =?utf-8?B?TUN4Ni9ZTHNZOURCZW5HbGZmZ2VjK3MyZmVJelYya0lQYTZFUTBzLzBqVFVN?=
 =?utf-8?B?MExSVk80RHh3YXptcE1TMWRnUEUyQjNDMmVTR2h2d1IwUVBGN245bUtCMG05?=
 =?utf-8?B?MlpuMGNaU3pvVXliaStOVHdOL3A3aVlhd0ZPT1MzZ2ZLUW4wMzJFUWNWUWJl?=
 =?utf-8?B?czMrRURlMFpHOXYwWDYvYU9qaHdBdWMvekdGdis4NVR6QU5vZjJBcHZUNzE1?=
 =?utf-8?B?R2I1cTdlTklzYi8yTWZmaHp6Y2hVb3I5UnJKcDlJbmdNdUJBYVd2ak9xaFpI?=
 =?utf-8?B?OGRTbit2dXpMV3Y0Smd0a3plbmRmWDZGRDJVSXVob1hQdW1aeXNjeDRHcUZT?=
 =?utf-8?B?K2pZcC9iL291aXN0c0NWUklXeTN5YVZzVFFDQUxCbHlkUXFkTk9uQW5LK2FT?=
 =?utf-8?B?aUtLLzRaSE9FTG1MbVkvL21QMEtUenJEMXR6K3FXRWtEanBzNWVvUi9ZV25H?=
 =?utf-8?B?c1paaU5tUURMYzJpK0p0bytWV01Xb3dGMnREeFl4bGRPV2FCSUNQRE1mK3R3?=
 =?utf-8?B?c3NNcHBZMkZlSHYzS0hvcVE4N3FNekc2NHhGc3NaUi9BaDQrOTNoVzFxbVZN?=
 =?utf-8?B?VnJvU3hUcm4xQlp3VG5DYWNyNHh6bmJNdHN2ZEc5N1pqMmRtVlNYbU5JRDZt?=
 =?utf-8?B?UnJLeGczQUNwV3NJOFRpUHBJd3d1a0gvd3JuSG1WR2ZySjdrbFZqcENSM1R4?=
 =?utf-8?B?VEFiUHA3eVZJYy8xbllOdlBKRGw1UlJrYVRUaS9yQ3grdHZidjFCVlcrYXdY?=
 =?utf-8?B?Mll1OGRmMlpVT2tjK1EyaUhiVnBjSlQ0ak9xT0x0MmFJMEFwL2xQUS84WkJN?=
 =?utf-8?Q?ppFjQW0CiLtMS6q0xNfOkvRfwMq9/CMBQu0CpcZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9vM3hCS01GdytUM2FmTlVsN2YrU3Z4Q3Z4OXdJcFlCc0dVS1dHekZyaWd6?=
 =?utf-8?B?ajZjYlpwQ3B6RFMxd2RnSXV2RUYxeWNuQXlQUnpYZnhCcGNvZmgzNWExRWls?=
 =?utf-8?B?eitZR241Z0NqMWFvblF6allpQkNvUWMxWmNIZTdDL0tPY3NENTdQSzRZbTN0?=
 =?utf-8?B?b1Jna3MvYlRiOXdDdUVHdWw3eU5sQU1SYlpCTzdEblVwT0NEZ3Y4SWh2dWVq?=
 =?utf-8?B?WEVqOFlzZGd0Sm9nblgvMVlBNzBxTFJOQ1VUSVkvV0dQNDdRbGNobW9oa0Nt?=
 =?utf-8?B?U3lVRXdwVTJkQy8wUG05bjBCZDFYakEyT3ViQ09kQkR0SFppQXgvRU1paWpJ?=
 =?utf-8?B?OFBnSTc3bEF4aFdrYkxyNlAyNThCU3ZxYlliRm95SkxTUVlCL3libitWZ2RI?=
 =?utf-8?B?a1FiWk9YVDEwQXJ6dzhVZlE2M1VDOXA3Ty9Db3RDQTZEMG1wckxzTXFQMGJh?=
 =?utf-8?B?dTFUVWZiSkxudkJBR3JCSmNqMk1xRDBzdXVjYkZXUENDdWY1RnBQdUZ2TFNk?=
 =?utf-8?B?WmNrUHlDK0orQzdNQ2hjd1RXckpZK3JITTdIbXMzWVFzK3RtcTZyc1VjQXpG?=
 =?utf-8?B?d0NqL1NZcFdvNEpSbzJBR2VkNG5mdjBVSkNsQkhoalFnSEdHRHRkV3FyV3Vs?=
 =?utf-8?B?MGlEbDdwbGQwQXd3eU1IWE1DblBEcEd1bTBRdG1XTjNVWlZMMUhnNENHY2Ri?=
 =?utf-8?B?Q3d1aTZMeHNUZXZnakhLRmY3ZXRwbUdTSlFDRm5IMWJ3ZDRYT2k2eUJkK1ZI?=
 =?utf-8?B?bWI2cldlVXR1MjFBRC82Yi9HNTVKSkoySjMwWFNuQ2JUdUR4akJ3WEFqNVN0?=
 =?utf-8?B?ZDY3KzQrczlCRlQrVUxzYVh6ZUhoMStjT24zdmJFRENTNk9rdXllWkUxdXJr?=
 =?utf-8?B?SERpbG5qL1FkS0svaWg2RFN6Y1ZOR1RjZE5PSUFYbC9PN1hIVE5KeU5pUEF4?=
 =?utf-8?B?eDEwRTFyZWYrT2dnelhJTjFyT1cvVktKbGFaN0hZWEEyWUlBRVl6enkrV0NZ?=
 =?utf-8?B?YXl0dUQwVFFwYnh5OGp2aXJvbGFhTU5qSEo3VWxYT0l0cDZ0dnRacnJhS2VF?=
 =?utf-8?B?UmtwcVphOHhrUTRKZWFmWFVFcmk1SVVZMFRzRTR4eWtpN2UzRVR6cGpXWUJo?=
 =?utf-8?B?K2ppa3BoY1BVaTRUVjdMWEExZEViU0JpSEwvcFNuRzlYTzZVZEV1cFhjRXRH?=
 =?utf-8?B?TmppcWFQUWMrTzJYZkNJVTNWRWhFRHlCZGpLUGhWT3dNQmhnZkp3SVFESWta?=
 =?utf-8?B?TEtzaWE2eitLbGlpSi9pOW1mdmJMSDFxc0c0OUF2aGYwWFYvSjl0enFBWVlK?=
 =?utf-8?B?TmNxajVldjdSb1YycVNNK2JSdmFsN29USkdXTVlyVC82ZHlmY1NFRm5ZUm5k?=
 =?utf-8?B?UndmL1hxelhmcjNCNmF5R0dqcnd4UVltM2NhQVFiYVlCU0djcjUzc0pycndV?=
 =?utf-8?B?RjFhU1NwY1JMRHRsNHB5VFRHVVptcUVrQVNGZzN5dCtKOVVzRzJ0K2JQSzg1?=
 =?utf-8?B?cmRLbHJqcEtxajY0LzdSdjZ0clR2QkJ5WnVVb3h5REpKMjJuK2NsSXFjL3Rl?=
 =?utf-8?B?Y2hkeFhIVXNaQ1lpK2ZYQkVlVFNVeFIrd0JBOG10Zityb0VWcVlQMlRkUE8w?=
 =?utf-8?B?MXdEbWo4RldsMXVsUm9NSWV0dTZ6R2FPM0EwR2hBTnFJNTRGSnhXQ1Z2eEJ0?=
 =?utf-8?B?VmtnVVo3SWF4ckhFaVNDNllyNThFOTJFT2d1Nmd2elcrdkF5anBqRGtuNWhF?=
 =?utf-8?B?YW9scVBUd1dVY0VTOGpWWVBYNkI2QzAzM2JQTVJkQmFzeksxZ3pDNi9Hb05X?=
 =?utf-8?B?V1dDamxWaFU2OEU2YUtHdHU4MUJHM0lkRm9qK2l2bHV6bFlIcUJsdVVVK29k?=
 =?utf-8?B?MnU4UXZ3cTNiRkhXZlMrYTBXMTBBamlXekE1ckxaemtkQ3Mzb3RpdHFCR0kv?=
 =?utf-8?B?a2ttUG1vYWRBVDR2aHB5RHVkL3llQWZTOGNxT09kMEFycEI2NVA5TzJUU2Ja?=
 =?utf-8?B?WU41L2dpVXNvRWpkZ0xWam1PS0ZmR3FreEpYRkhBUHdsbHhoejlISy9WMzlG?=
 =?utf-8?B?WW13Z3ZNQnRneXZZbHIvN3JiQ2dSNXhkTWFKNUNOcVp1ZkNPajNFUDg3Ukl3?=
 =?utf-8?Q?iKQWd+ehk3Wwh2SHM3weZf4m8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3fa4a8-8e1c-41ba-93d5-08dd04cbc75f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:45:42.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dNRhlCOifwVniKMgTxLcQXYB6KcP9Whel8oh7k62vhbzvY7WyUr0QPt32fnDqWu65NKSYdqqSM6r2bR4mxdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

Hi Lukas,

I added comments below.

On 11/14/2024 9:45 AM, Lukas Wunner wrote:
> On Wed, Nov 13, 2024 at 03:54:17PM -0600, Terry Bowman wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5038,6 +5038,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  					 PCI_DVSEC_CXL_PORT);
>>  }
>>  
>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>> +{
>> +	if (!pcie_is_cxl(dev))
>> +		return false;
>> +
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>> +		return false;
>> +
>> +	return cxl_port_dvsec(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
> This doesn't need to be exported because the only caller introduced
> in this series is in drivers/pci/pcie/aer.c (in patch 05/15), which
> is dependent on CONFIG_PCIEAER, which is bool not tristate.
Ok.
> The "!pcie_is_cxl(dev)" check at the top of the function is identical
> to the return value "cxl_port_dvsec(dev)".  This looks redundant.
> However one cannot call pci_pcie_type() without first checking
> pci_is_pcie().  So I'm wondering if the "!pcie_is_cxl(dev)" check
> is actually erroneous and supposed to be "!pci_is_pcie(dev)"?
> That would make more sense to me.

I see pcie_is_cxl(dev) is different than cxl_port_dvsec(dev).They check different DVSECs.[1] CXL flexbus DVSEC presence is cached in pci_dev::is_cxl and returned by pcie_is_cxl().
This is used for indicating CXL device.

cxl_port_dvsec(dev) returns boolean based on presence of CXL port DVSEC to 
indicate a CXL port device.

I don't believe they are redundant if you consider you can have a CXL device that 
is not a CXL port device. 

[1] - CXL 3.1, 8.1.1 Specification, PCIe Designated Vendor-Specific Extended Capability (DVSEC) ID Assignment
> Alternatively, just return true instead of "cxl_port_dvsec(dev)".
> That would probably be the simplest solution here.
>
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -443,6 +443,7 @@ struct pci_dev {
>>  	unsigned int	is_hotplug_bridge:1;
>>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>> +	unsigned int	is_cxl:1;               /* CXL alternate protocol */
> I suspect the audience consists mostly of CXL-unaware PCI developers,
> so spelling out Compute Express Link here (and omitting "alternate
> protocol" if it doesn't fit) might be more appropriate.
>
> Thanks,
>
> Lukas
Ok.

Regards,
Terry

