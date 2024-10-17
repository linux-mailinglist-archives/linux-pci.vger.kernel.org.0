Return-Path: <linux-pci+bounces-14821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40F9A2AE1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0691282263
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08D1DF74B;
	Thu, 17 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uc1KarTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140821DF733;
	Thu, 17 Oct 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186036; cv=fail; b=blM6reP1qZG1sIKofL3JhDUCyEMuyKG1hLjK09RyXNzJ6NraDVNIKxZ2x3HgZ+A8eQHAmQua9IB43HZZtFoRB3AKZxA0wuDpn+FRF++n3V2HhzT/HSMHhESySOu5EsPb2SN7oQTf18lWwyIunxdAEdi4Lcct9O9buqQ6Y6BTEvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186036; c=relaxed/simple;
	bh=/yaWDRpo3gC+tY5QCnnGq568x9R5XhGGTkKpYWVogaI=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=hYdTyGoCy7MaBlbSHo/RBc+B56wrvV24rSFE+/Lu4bvr8hPYdquH84A6wxkrPjcGXQDaX9Gy84tpIvK20VH825Vqm6/QzbAtpvWWUyq2fuHB/1T2JnByyxp9dT0kuEoeyRJf0jxGEbsZfg3jx9wz4JFklfHjgPT7T9M3VAlC23E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uc1KarTo; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2c8ZJkrbdu/EMulCpOW7WRs9T7XIpamp6Z93ELFZyuouHsYn9UpcOU55ZyfhtiJtIhEbYbKTDmS7fQLzBi/6avlPDT9jpNOIse0R3do/vIzww6oYFfEtwZIFetGBo57Bqb9+ErWUTvfF+6SnWLeudNo/O4xSwIK/l2VsNNjL75JSvSzvc1Ym1A+JeOCic+LuiSW47vMyR3cxo+eszA6/fnu/ku6wjdS9sfZ17Ut5i9kkvj9RNkAEZySp87dHoNufTRrWlfCG78Cm2qiVkTlGlwVfcq1E3IUCiMQdFNBp6J5XfQG/JYfy9mkh+SjXJ0C/fSLUzGK3IN0sPUYNyNyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfBXXvZMNgxZ6NDQVNHPxWp7it4JkFAzoIRvKaFv46w=;
 b=DjIbbF2xzLKpP0qnWQ3GPnzWBJCPHBGmrPbE9tU3F1uBnjmazM19TxU2t7P4Mt5gin9nyoWBE1WO3IEAxqoLyr/7NpRSgBq2QZxjPHN/20vg5/tiGco4G884oBPFPxjiNIiPYJh+7D+TcqImI9RMyDKI7VMfElXSGAeLYbpc2FyXreJNNvddsqIZI0s7cR5FcbokYqy4EYgLqeTvWcfWV943L8u2PAYLMXmkyXvLjpxQ2bu475gYaL4iy5J5vmPJ/hyrL/8w4yzM+ZzVNILvuKN4Uv7FWEGtE165hDBLT9fdeFuDyAXb/pIWLw82t4lA3c2tFEEUyYuySQY/9gT/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfBXXvZMNgxZ6NDQVNHPxWp7it4JkFAzoIRvKaFv46w=;
 b=Uc1KarToJdrt3GUwllB0OW10THEunKnHDiHQC7msFe8OHuwnxXK2KycOcEX3DwlORD7jGkgWxX7Lj0xZ90w3NCFJvk/LUsYGp+d/UxaMXKDSfpTxC4NChOiITozue9tDrfuPt1vIMjJVV4mNjl2wv0UySlwNBd6lTeyfTelM80k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:27:07 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:27:07 +0000
Content-Type: multipart/mixed; boundary="------------oaxNO8EGBJE59h5ts0mynRBJ"
Message-ID: <8c34b676-e71a-42e8-96fe-485ffeaa8328@amd.com>
Date: Thu, 17 Oct 2024 12:27:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
To: Fan Ni <nifan.cxl@gmail.com>, Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <ZxE8jn9M7twa4v2u@fan>
Content-Language: en-US
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <ZxE8jn9M7twa4v2u@fan>
X-ClientProxiedBy: SN4PR0501CA0032.namprd05.prod.outlook.com
 (2603:10b6:803:40::45) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 97755ea1-eeb5-4f55-9c29-08dceed0ec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG94bmNnYnorRWJ1R2s1THA1UTQxWlZUeDZIU3RXVzNycnlvZTh2S0MreVk4?=
 =?utf-8?B?QVNyaGRpb09sM29adWFlbVNtbS9VNWRTcmpKbHZtckMzZFg3bGw4ckRkUDVm?=
 =?utf-8?B?c25SNW5KRUFCQmR4RG5GeFF6ZVVacVovN0lVSVI0U09melJXZ2RlRnFLcGJH?=
 =?utf-8?B?eTNsM1RXNEZWRFB4Qy9SWG85ZEZZR1hPbWs3bjVaZzV3eThKTUY2aTkwelFp?=
 =?utf-8?B?cHlrVGRpT2t6NGFlRXV2VTcweEFreUhpTFEwRmsvOTlWUm1PVittWXV5MnJs?=
 =?utf-8?B?c1VLU25HVnkvY2ZGdGVpOTh6azdTMWtvZDdXckJnZWNjWDZGKzMrUWY3c0tX?=
 =?utf-8?B?NGMyM0QwR1hwSldaRHRxNlZTcDZwbE5hNDlONUY3Uys4Y0o0TVRDRVN3d1ho?=
 =?utf-8?B?VEtqSGtGamZhdW4rbktsd3dmY1dHLzdQL0U4eHdZL0VycXFFaFkyRDZjdnZa?=
 =?utf-8?B?ZFo4K2JRUmZHU2tveUppdytCLzZpOHlYQWJ0U3hsK3J2QkVZNVNTdHo2L1FT?=
 =?utf-8?B?eFRrT3FJRVN5ckNHUjRYTW8yRm0xN1c0NzViSEZiNnBTOTgycFVrc0FxVjRY?=
 =?utf-8?B?UllmSnVSbGI5ZEVjSXNvYzAzSDlNVGlQUXdJS1hrVXlqUklGV09kZEgxOXZR?=
 =?utf-8?B?a09JUkpmcEFjcVlqOHNXMHNWd2xoL0hwZzduY2h6THBLYnZuQy90RzNJMktZ?=
 =?utf-8?B?WjV3aHZXcHZldm5IMUZyZHFmZXRxR0NEMGNnS2FBdkpudStJVFpYUHFGdGRG?=
 =?utf-8?B?ZTJRaE8zTGswd1U1UnZyeGFVRWI1R3JpelBnOHR1SGErbDIzQjlQYWM1ZzAw?=
 =?utf-8?B?RzFnNnROUkFrUDJoTC83SGhvN0dyNDdZNmtvemhEU3Z6UzkzK2hZVkNjTVh1?=
 =?utf-8?B?ZFFRS2xwSDZTeGxWdTlQcFRidXJ3dEtpZEpHWVF0dHBESEZOczJldTdUSlN1?=
 =?utf-8?B?Y3o0aTB2NUVkTGcyakgzY1VsOWVqZm9xcTBGeDlyNDNEdi9CTzBkb1VjYWRs?=
 =?utf-8?B?NnFmYlFPeWdETGlBdTBwbXJIWmdQSjRld2FSSDkwdThOd3JCWktGRVRiNXRO?=
 =?utf-8?B?N3psSFVLbVozeVVKVkVZNU5wUkVvOHgvTkZjbWE3Rk1Db2VDdVR2VkxjLzI4?=
 =?utf-8?B?UURtY2crNk1acmxkcVEzRDhyREFGWEZNSDBvano0YU5LNzJtTXNPbEdJZVoz?=
 =?utf-8?B?NUJMNnRoV1BnN0s2Y2pSYXdEQVNyL2NOZ2QvVlRZWG95UXpvSGxJbDVjcEFT?=
 =?utf-8?B?TmJ0SmlpUDVYejhtWEdHTzRNWTRsVXFPUnBKMWVNS3hmUEhuanU2S2h3Q1Nn?=
 =?utf-8?B?RDlyVjBZN2J0ci9ReklKOEJ4OE16dkVabE90bGVaY3JzeXhYK3FDMzdVM0wx?=
 =?utf-8?B?NHV4ZGFJdGprVUlMaTFINEdMN2NBL0UxS04wSUI3VDEyQXpucXRoR0dKUWQ3?=
 =?utf-8?B?TCs1NUg2TldscElaSmZJaW80Tjl2MjBZVlRrYkJxSUYvc2lmTDE2bzV3NEZ3?=
 =?utf-8?B?YUQwUjljSXJWaStNcVJaT2ZjRXJkWkdqSFdtc0RFK3hiais4VzNUeG13Mlh4?=
 =?utf-8?B?QVdmdWxZZzVVM1R4RStKNU01N0VHYUdoNHdSUzFnUkJzeVRKUEZOS1VpdVBY?=
 =?utf-8?B?WGo2N3YwQmZRSW9IZ05NOUJlN2ovZ3doY2Q5cW4zVDdmTXMvVjVGcXRpUEFI?=
 =?utf-8?B?WEVhTkNVWTZyR2NjS04wdHZmNWh1RjVMZk1Wd1FKMHJNdzZDVGV3cndQYVlV?=
 =?utf-8?B?VlVvWGxvMDIwbVA4T3lIYkJTNWUwd3NGMk5STEYrbnRyYkFyVHdYbGYyTkRH?=
 =?utf-8?B?T3Q3WFI1Z2grY1hFRlUwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJZV0FJcERRUVAwMWFPallNa0VobUFuazUvc0FrR2sxZ1pxcVlwbzgyM1Uz?=
 =?utf-8?B?T0FxLzVMRDNySzg1bk1NVHZCaGFGVXBSUFJNZkdWM1F4N0ZZWWRzRlJCOXVj?=
 =?utf-8?B?RzI0V1dsREFxWnFXNDY2NTBIY2dPUlYzV0d3NXVlV0RJRkZDaTBRYVJZMFV1?=
 =?utf-8?B?UUdJWjd0WllrSG1mTnRBOUI2aVpWSUhrVFhFcXV3Q3VIQmFRZTVRK2VsNEVO?=
 =?utf-8?B?SUxHN2VRSVJieWk1dTBzam9ndlNSV1ljeEpVQlZMNW81UGxTdDNSY0ZCQU1w?=
 =?utf-8?B?K3A5RWQ5SlFtSlJLVkVlZEtETDlsZjcxbGZTZCtycDVYVGdnU0NhYi9RSys5?=
 =?utf-8?B?SThJR05uTDZMZkEyL2FDN0VhV1F6bFE1OE4rUi9yeHJOemhPL2JJUGEzeGIw?=
 =?utf-8?B?YVFpQkxjby9EVzFmRFo1Z1E2OWtOc0FJUENuTHFXQVNkZW9FeVQ4L3FoVDBm?=
 =?utf-8?B?cGozMzhiclhORzhXa3JMekZNU3Z5cDFFWHdpckk4Z2Q1Wi9Pb3ovc1poZnNR?=
 =?utf-8?B?UDZBMmc2Y3pzbTNCOVVyNDdFL2t5bjNpcy80WjJ0TjNpQVFsZUdyU3pYZjAy?=
 =?utf-8?B?YWNNa1BjMEZ6blpUTVVrcjRHRWs1dDJCdkxqQ3g1enJDRStxUi9DUzNkSkNN?=
 =?utf-8?B?Sk52dFhWNTlONnBxbjJJenNGaDAvUXRGcTQxTHcrR1VBRkxHRmdiQm80VE1q?=
 =?utf-8?B?dnB3K1p2MDlqS0pJdXlnZU9KQnNwNzh4bnNTckJycXBqUm1MMWovV0VzZFFm?=
 =?utf-8?B?S3JwTzVzWm5qT2tFamJ3Mnh6Z1ZUREdRWld5SGw1NFI4WWgyVDRGa29uNnZU?=
 =?utf-8?B?bXpIU0xlaE8zT0gzd1FvRjhwMGJHL0NvSzV6NGNzSmpVaXlTTlVjL3dKaEtz?=
 =?utf-8?B?YUNsd20wQ09WUDFPSXhsS0wveGdJRG43SmZrcmJrM3ROaU9XaFBxcUVzYmFS?=
 =?utf-8?B?SkNKRml6b2dyMXpTaTNDTDA5QlVXcXZZaE9MbGc0YUJIUWhoR1ZEeURUb1o4?=
 =?utf-8?B?bXBuN2NtZ0ZQa2FSMkk3cm0yRUdLekdsWjNUT3hqalBaVTJpNDVKQnlrcytG?=
 =?utf-8?B?d1lCT2ZpaE83WGJiY3ZZUUhhelZBRDZORkUxSXZOZDRSZ2FkTHgxbENhRmpS?=
 =?utf-8?B?VXZDZXhHOTdQWE54Z1N6ajdqdW1rcjhvNTJsWHRwVVdhRlNDUjJjT2ZVVlND?=
 =?utf-8?B?Y0lESUFXQk5UQjBWZnBUelBWTEV6cmg4OXFmMGhyMjczcWRFZ0I2eTNsc1VG?=
 =?utf-8?B?QmVMTmNGbjJLLzJlYkJVbllMY2YyTElxUFAzYkhPbHgzSERBNytNNzRXR29W?=
 =?utf-8?B?SjhFVExtV0kxSXZ4bU1BWEtYb3FWMCszOEhraHZlWnlvVVU5Y3I2Uyt6ZHRR?=
 =?utf-8?B?b25NNFFMVDZodjU2S25yZ2VlL3RlVS80eXNSSklwT1d0Ym5SbXptbURhUzlR?=
 =?utf-8?B?NW9vcnBHWm5YN09WeEsxYmllVlhucys4Z1NXdHdrRzRhU0JZaHh5M1pnaDZV?=
 =?utf-8?B?VmJWR0lQR1V6ajVUVEFDcFVSeFMxNVFYRmNiM0VjZXJ3K1ZuRDVaeFhlOVV3?=
 =?utf-8?B?ZmlaRGdEbnB0RlhGNTQ1YkRLbUozTWFpWTdYdnhnSDVlS1d0djhmZ1ZlY1U1?=
 =?utf-8?B?SmVOcjcra200QmltSEdHakVocEpTbUtpRjVXckVhMkpWZzhxVmJxZTgyWm56?=
 =?utf-8?B?UkVscmpEaDdPS3dzbnVqVkJ3aytaeWw1VzVMU2J1My9rSmRyVUhJakhBTHA4?=
 =?utf-8?B?SVFKdUpwUEtKZktJVHl0ZDF0TEpPMEpTNFZ2Q2NqMHkwSU5Mb2VzZG9xSzJ2?=
 =?utf-8?B?ejlBSysvZFRPUWM3amZGUU5RL0ExKy80SFM2SVdqd2dSVVJyWDMzRmx3ZU9F?=
 =?utf-8?B?R0tEZUVLUDhCNWRjTko2Y2I4MythdnN1VXRLa1FJQ0RsNTB2QTBEd1huK3Yz?=
 =?utf-8?B?RHNPZy9jdlVsK0NjOFlFZ3VzaGN3YlovN3Y2R0lsYmJhcjhSaUJKRjlvZ2l1?=
 =?utf-8?B?Yjk1NHFua0xhS1I2YzBCSlZEa2U1aHNteE5WekVDQTkzcHNKcTRZbnh3ZTdl?=
 =?utf-8?B?YktBREFLaUk4NytHekZiWjNkZE9UOWFKdC80a2YvOXZrQ09RYVZqb24rdm1r?=
 =?utf-8?Q?GqHip3ra9A8qtJyIUUkDc11/7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97755ea1-eeb5-4f55-9c29-08dceed0ec8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:27:07.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz0G69spAlIUh+MlQDBncivHdiGhVQv/CAAA8vZcVvFy6vWXHHHbvSuZOBz2RFdAMFUCtyKDHphnGE68VaeeIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

--------------oaxNO8EGBJE59h5ts0mynRBJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fan,

On 10/17/2024 11:34 AM, Fan Ni wrote:
> On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
>> This is a continuation of the CXL port error handling RFC from earlier.[1]
>> The RFC resulted in the decision to add CXL PCIe port error handling to
>> the existing RCH downstream port handling. This patchset adds the CXL PCIe
>> port handling and logging.
>>
>> The first 7 patches update the existing AER service driver to support CXL
>> PCIe port protocol error handling and reporting. This includes AER service
>> driver changes for adding correctable and uncorrectable error support, CXL
>> specific recovery handling, and addition of CXL driver callback handlers.
>>
>> The following 8 patches address CXL driver support for CXL PCIe port
>> protocol errors. This includes the following changes to the CXL drivers:
>> mapping CXL port and downstream port RAS registers, interface updates for
>> common RCH and VH, adding port specific error handlers, and protocol error
>> logging.
>>
>> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
>> -1-terry.bowman@amd.com/
>>
>> Testing:
>>
>> Below are test results for this patchset. This is using Qemu with a root
>> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
>> (0e:00.0).
>>
>> This was tested using aer-inject updated to support CE and UCE internal
>> error injection. CXL RAS was set using a test patch (not upstreamed).
> 
> Hi Terry,
> Can you share the aer-inject repo for the testing or the test patch?
> 
> Fan

Sure, but, its easiest to attach the patch here.

Origin was https://github.com/jderrick/aer-inject.git
Base is 81701cbb30e35a1a76c3876f55692f91bdb9751b

Regards,
Terry
--------------oaxNO8EGBJE59h5ts0mynRBJ
Content-Type: text/plain; charset=UTF-8;
 name="0001-aer-inject-Add-internal-error-injection.patch"
Content-Disposition: attachment;
 filename="0001-aer-inject-Add-internal-error-injection.patch"
Content-Transfer-Encoding: base64

RnJvbSBjYTkyNzc4NjZiNTA2NzIzZjQ2ZjNhY2Q3YjI2NGZmYTgwYzM3Mjc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPgpE
YXRlOiBUaHUsIDE3IE9jdCAyMDI0IDEyOjEyOjU4IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gYWVy
LWluamVjdDogQWRkIGludGVybmFsIGVycm9yIGluamVjdGlvbgoKQWRkIGNvcnJlY3RlZCAoQ0Up
IGFuZCB1bmNvcnJlY3RlZCAoVUNFKSBBRVIgaW50ZXJuYWwgZXJyb3IgaW5qZWN0aW9uCnN1cHBv
cnQuCgpTaWduZWQtb2ZmLWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPgot
LS0KIGFlci5oICAgfCAyICsrCiBhZXIubGV4IHwgMiArKwogYWVyLnkgICB8IDggKysrKy0tLS0K
IDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2Flci5oIGIvYWVyLmgKaW5kZXggYTBhZDE1Mi4uZTU1YTczMSAxMDA2NDQKLS0tIGEv
YWVyLmgKKysrIGIvYWVyLmgKQEAgLTMwLDExICszMCwxMyBAQCBzdHJ1Y3QgYWVyX2Vycm9yX2lu
agogI2RlZmluZSAgUENJX0VSUl9VTkNfTUFMRl9UTFAJMHgwMDA0MDAwMAkvKiBNYWxmb3JtZWQg
VExQICovCiAjZGVmaW5lICBQQ0lfRVJSX1VOQ19FQ1JDCTB4MDAwODAwMDAJLyogRUNSQyBFcnJv
ciBTdGF0dXMgKi8KICNkZWZpbmUgIFBDSV9FUlJfVU5DX1VOU1VQCTB4MDAxMDAwMDAJLyogVW5z
dXBwb3J0ZWQgUmVxdWVzdCAqLworI2RlZmluZSAgUENJX0VSUl9VTkNfSU5URVJOQUwgICAweDAw
NDAwMDAwICAgICAgLyogSW50ZXJuYWwgZXJyb3IgKi8KICNkZWZpbmUgIFBDSV9FUlJfQ09SX1JD
VlIJMHgwMDAwMDAwMQkvKiBSZWNlaXZlciBFcnJvciBTdGF0dXMgKi8KICNkZWZpbmUgIFBDSV9F
UlJfQ09SX0JBRF9UTFAJMHgwMDAwMDA0MAkvKiBCYWQgVExQIFN0YXR1cyAqLwogI2RlZmluZSAg
UENJX0VSUl9DT1JfQkFEX0RMTFAJMHgwMDAwMDA4MAkvKiBCYWQgRExMUCBTdGF0dXMgKi8KICNk
ZWZpbmUgIFBDSV9FUlJfQ09SX1JFUF9ST0xMCTB4MDAwMDAxMDAJLyogUkVQTEFZX05VTSBSb2xs
b3ZlciAqLwogI2RlZmluZSAgUENJX0VSUl9DT1JfUkVQX1RJTUVSCTB4MDAwMDEwMDAJLyogUmVw
bGF5IFRpbWVyIFRpbWVvdXQgKi8KKyNkZWZpbmUgIFBDSV9FUlJfQ09SX0NJTlRFUk5BTAkweDAw
MDA0MDAwCS8qIEludGVybmFsIGVycm9yICovCiAKIGV4dGVybiB2b2lkIGluaXRfYWVyKHN0cnVj
dCBhZXJfZXJyb3JfaW5qICplcnIpOwogZXh0ZXJuIHZvaWQgc3VibWl0X2FlcihzdHJ1Y3QgYWVy
X2Vycm9yX2luaiAqZXJyKTsKZGlmZiAtLWdpdCBhL2Flci5sZXggYi9hZXIubGV4CmluZGV4IDYx
MjFlNGUuLjRmYWRkMGUgMTAwNjQ0Ci0tLSBhL2Flci5sZXgKKysrIGIvYWVyLmxleApAQCAtODIs
MTEgKzgyLDEzIEBAIHN0YXRpYyBzdHJ1Y3Qga2V5IHsKIAlLRVlWQUwoTUFMRl9UTFAsIFBDSV9F
UlJfVU5DX01BTEZfVExQKSwKIAlLRVlWQUwoRUNSQywgUENJX0VSUl9VTkNfRUNSQyksCiAJS0VZ
VkFMKFVOU1VQLCBQQ0lfRVJSX1VOQ19VTlNVUCksCisJS0VZVkFMKElOVEVSTkFMLCBQQ0lfRVJS
X1VOQ19JTlRFUk5BTCksCiAJS0VZVkFMKFJDVlIsIFBDSV9FUlJfQ09SX1JDVlIpLAogCUtFWVZB
TChCQURfVExQLCBQQ0lfRVJSX0NPUl9CQURfVExQKSwKIAlLRVlWQUwoQkFEX0RMTFAsIFBDSV9F
UlJfQ09SX0JBRF9ETExQKSwKIAlLRVlWQUwoUkVQX1JPTEwsIFBDSV9FUlJfQ09SX1JFUF9ST0xM
KSwKIAlLRVlWQUwoUkVQX1RJTUVSLCBQQ0lfRVJSX0NPUl9SRVBfVElNRVIpLAorCUtFWVZBTChD
SU5URVJOQUwsIFBDSV9FUlJfQ09SX0NJTlRFUk5BTCksCiB9OwogCiBzdGF0aWMgaW50IGNtcF9r
ZXkoY29uc3Qgdm9pZCAqYXYsIGNvbnN0IHZvaWQgKmJ2KQpkaWZmIC0tZ2l0IGEvYWVyLnkgYi9h
ZXIueQppbmRleCBlNWVjYzdkLi41MDBkYzk3IDEwMDY0NAotLS0gYS9hZXIueQorKysgYi9hZXIu
eQpAQCAtMzQsOCArMzQsOCBAQCBzdGF0aWMgdm9pZCBpbml0KHZvaWQpOwogCiAldG9rZW4gQUVS
IERPTUFJTiBCVVMgREVWIEZOIFBDSV9JRCBVTkNPUl9TVEFUVVMgQ09SX1NUQVRVUyBIRUFERVJf
TE9HCiAldG9rZW4gPG51bT4gVFJBSU4gRExQIFBPSVNPTl9UTFAgRkNQIENPTVBfVElNRSBDT01Q
X0FCT1JUIFVOWF9DT01QIFJYX09WRVIKLSV0b2tlbiA8bnVtPiBNQUxGX1RMUCBFQ1JDIFVOU1VQ
Ci0ldG9rZW4gPG51bT4gUkNWUiBCQURfVExQIEJBRF9ETExQIFJFUF9ST0xMIFJFUF9USU1FUgor
JXRva2VuIDxudW0+IE1BTEZfVExQIEVDUkMgVU5TVVAgSU5URVJOQUwKKyV0b2tlbiA8bnVtPiBS
Q1ZSIEJBRF9UTFAgQkFEX0RMTFAgUkVQX1JPTEwgUkVQX1RJTUVSIENJTlRFUk5BTAogJXRva2Vu
IDxudW0+IFNZTUJPTCBOVU1CRVIKICV0b2tlbiA8c3RyPiBQQ0lfSURfU1RSCiAKQEAgLTc3LDE0
ICs3NywxNCBAQCB1bmNvcl9zdGF0dXNfbGlzdDogLyogZW1wdHkgKi8JCQl7ICQkID0gMDsgfQog
CTsKIAogdW5jb3Jfc3RhdHVzOiBUUkFJTiB8IERMUCB8IFBPSVNPTl9UTFAgfCBGQ1AgfCBDT01Q
X1RJTUUgfCBDT01QX0FCT1JUCi0JfCBVTlhfQ09NUCB8IFJYX09WRVIgfCBNQUxGX1RMUCB8IEVD
UkMgfCBVTlNVUCB8IE5VTUJFUgorCXwgVU5YX0NPTVAgfCBSWF9PVkVSIHwgTUFMRl9UTFAgfCBF
Q1JDIHwgVU5TVVAgfCBJTlRFUk5BTCB8IE5VTUJFUgogCTsKIAogY29yX3N0YXR1c19saXN0OiAv
KiBlbXB0eSAqLwkJCXsgJCQgPSAwOyB9CiAJfCBjb3Jfc3RhdHVzX2xpc3QgY29yX3N0YXR1cwkJ
eyAkJCA9ICQxIHwgJDI7IH0KIAk7CiAKLWNvcl9zdGF0dXM6IFJDVlIgfCBCQURfVExQIHwgQkFE
X0RMTFAgfCBSRVBfUk9MTCB8IFJFUF9USU1FUiB8IE5VTUJFUgorY29yX3N0YXR1czogUkNWUiB8
IEJBRF9UTFAgfCBCQURfRExMUCB8IFJFUF9ST0xMIHwgUkVQX1RJTUVSIHwgQ0lOVEVSTkFMIHwg
TlVNQkVSCiAJOwogCiAlJSAKLS0gCjIuMzQuMQoK

--------------oaxNO8EGBJE59h5ts0mynRBJ--

