Return-Path: <linux-pci+bounces-31316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930DAF643F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C9A3A7F97
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3123ABB6;
	Wed,  2 Jul 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q0EskcyR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D21EC014;
	Wed,  2 Jul 2025 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492488; cv=fail; b=aLyW2V9bwdr6ipVxrf4/JCSqr6bylSI8Sfy2gpykcqospa98S+qJ7j3J5wie3rZAbKjrd/ZSn09ZPjc/CjcoXdZaFPF+/EYBANZBCVP06WB09T8XXAQkKsgnBRDgqeOY7uxMo/imO6BUAab1RMWqr6Y4BxkGQuVy1v1lPKGNIWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492488; c=relaxed/simple;
	bh=eQJXytFTwoO3Ixpyf2WJ276ZwynTeem1ndxv3QaV42o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6IyaYqgrrzUnQzOLA3k+B8bMgm206EkT6N8F2dX+QOo9nm9Q6RQexh9Ym5ceRHE9GT05sHpfwiV01pZsLuxJ5DVs5L8a6V7z3qMm7vTo0/UEYos35G3oA75dQHlAYczXgWYV8iVxNzqe0Gfa8Jnb51dY+RfZqdegsfsswvWTLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q0EskcyR; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDaZwRIpB/M3jG2qS3V2Cgr5TNbOOdeBLY1GST5vQIGIcz7R3XWHTEY+pVynMxgloOuN+E8ySiYu7ZHLAnqGmRjViFzNl6ZCDj+sa8zwr1Exs/2nFNW5hHZ2MqSJhrlNa/e4pgdh73TGdyQAupiXgJOBuDEX0kQM995qKG8aTlarHUMh+u29RW1NjdI4VWKZP9BC6iYYHRYO+ykrq+dn5gO8WB/Fjf8nRAVJZyY7fZuUCxpNmU/mmtvfSmDVlUVckYgVQg+5r1oOEVHjeeWmqRuUdtP1Z3W3sFeDUt95rNIVNpNzq25QMkodUqmYJsJODGJv2ExY53oYPqG30Bn5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZitaPXKzQ3YcjWAyWfEh9a1feGFrhchDexoycDEID5o=;
 b=Cr/VifAd9iZnrBjcw3RmvL38TaqLNF24iP/5U0R712pF80YqKPE50Jlm2loAoezSyuiv1W8eTnwVVXW+ZRscewda+VLyC47A+rrv/xcbIJLQcl99h+xyPxJS6pZRbfq8sCfFgAnyzVIn8DqWTx+PX+qhQRX5Fbhi1Bhr1lNGxVIbFabUec7nA2YZIvSxkL3VF3Vxmz41GcNws+qkgZpIVOX6FgkF+PKDKxDESY5Yi9wcErPqnXxHwro3wzp2cOtXQAUGx8bf6UhFRbcyQrIDKScBTzqMukwzoCoF+hUpLk3T78uifOtfaUmCzrnMBJjJ8Xnp15A/Acvp4NrK2OBhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZitaPXKzQ3YcjWAyWfEh9a1feGFrhchDexoycDEID5o=;
 b=q0EskcyR1y15FYzcsDyhyiVkKbNUf3/Gl1sks3x3HcMHe0tuuHE7UDeMmm4/5InT5ONY8MhV3lQGJZQGUMxABvibKWkybY6HRPjfEhiTcGS/bRVS6Y8CJTg5su9FNbywJyRjA1xuLYc/N0jMxMbWtzoSDl/yXpl16IbSStVsCgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Wed, 2 Jul 2025 21:41:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 21:41:23 +0000
Message-ID: <2c747d35-6793-4f0c-9351-a5be1ba44e7b@amd.com>
Date: Wed, 2 Jul 2025 16:41:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-10-terry.bowman@amd.com>
 <20250627121741.00002f2a@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250627121741.00002f2a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c747100-71fb-481d-24f1-08ddb9b130a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVZNSmJqZUM5bERSMjR3SlM3clRBeFlTVHpXTFdLVndKNGQvMFJJRG5DaHJL?=
 =?utf-8?B?WlFaMngvb2RueFVuenYxMW9TKzEvck5QYjBqUUtvUnJZSWhnS2lmSDYrVVYz?=
 =?utf-8?B?U0M5NWp6NTdkYTdLbDhaNDkrbVlMakVMcGo4UkhoazFCNks4NGxlVkw0ZXpB?=
 =?utf-8?B?cUk3TFNvTEdmczkrZHVvelFzTVBnMjVuWkxWb2wwNENTS0NDVTFxQ3htTXhP?=
 =?utf-8?B?VmdXdmhnVjYvaU54QVNBczZHNlJ5LzU2bHB4VFV3Wm9kclZVOFNzNlRPUTZ1?=
 =?utf-8?B?ZFJhU25OVzVwQUg2L1padWJRVW5lZ3hCVE1sTTRCMW9WVG5ZYUlKdmhSWHF5?=
 =?utf-8?B?WWMrQitUYUkrNHhTZDFkd0JlVG43TGZ4UU9NTUdRU09OR2NYMDhaaDJuQWVE?=
 =?utf-8?B?bkk5dzVONXI1aXNrbmUyVEczUFpXNmFnTm9aVWhvcENXTEZRL1RYZ1o1b0RY?=
 =?utf-8?B?NTZoY3Q3K1FoZmNBbGxsNU1oZ1lvRVA3RTNYSW5ERnpLN1BWUGV4QU9QYW9B?=
 =?utf-8?B?c21rdjh2T25pc29PMWlWZVJEY3dxbmF2cml0eHdZejRQQnAyMjhMakFsaVg3?=
 =?utf-8?B?dTJkb2VzQVdZZExQcnhYZ00zZG1tOHVMUVhFT3lKNTl1ZXEzVXRWL29pejRQ?=
 =?utf-8?B?alg0ekN2bERVc04vN2x3RU8vM2sxcjJZU3Z6M3lJZFdWN1IwdVgyUjFZbVpO?=
 =?utf-8?B?TDVnTUJQdkZmNXBKSFA3RzVqcjlMVC9aM2xYNGhNeHhmeUNoR1FITWxsNzBP?=
 =?utf-8?B?NDRiT29Vb3JmRHFzYjc0NFhyWGR2bUxWSU5rRHkzdVpvRkZ5dFh4dXQxbmdx?=
 =?utf-8?B?a0RzTHhNb2o3K1QrZHArLzR6VDJsTmpuaXBMTDZZYlpYK2lYa0lpcklSdmRn?=
 =?utf-8?B?alBNdUZPelZuK3VLRUF4a0QvSThNMTdWZVNCamFqR2VlVHIycjBIaVRRU0FV?=
 =?utf-8?B?VkYxSHVlM3grL3N2Wm95aVhMcmQ2Z1R2azdncFFIVE9pL1phbjJRYStoM2Qy?=
 =?utf-8?B?cjY5b2k2dWZta01GSWlRbEMyUlp3alNrQlR6ck5sc1F1ZXN6MEFuTlM4bHdD?=
 =?utf-8?B?YU1qa3FRdm5wb0JTM3pjVUNpLzdkczEyM3VnbHFkSDZHalVsUHZuSWRtNUxj?=
 =?utf-8?B?OVFVYmNoMU4yR28vQWVQS2l3SkVxQU5LMDhBaWZPSWhBa2VtSjdzSU94ZWJ2?=
 =?utf-8?B?YndNR0dsK1I4V2puZTB6QUsyc2dvQkNteXE3WFhJcjZoeTNydWF5TFRUZDFv?=
 =?utf-8?B?and4Vk9UY2d4clppcGNNYXdLb05zNi94MHZuUUdlYWFaSFVUa3Ywc1ArQmR2?=
 =?utf-8?B?UDlEd1BmM1ltMW5kSlNuUWJWVmZnc2VWdVYyUDBhNHhrWVMydkpGZlRtdlUz?=
 =?utf-8?B?Z2YxRFNERXIwbXVmVDVWcmh5aHZ3bG44ei92UHdldVcreHl0ODV0Z21VUDBF?=
 =?utf-8?B?cWc5SHZJaEFSODg2MHg4VzZCV0g1cFQ2YnQrSFpzdWFVSUVWOC9NNVNxbHdj?=
 =?utf-8?B?YldpSzFCalEyU1IzVWxLa3NObTRyKzJOQXBpWHBRVTBoMGFhY1RVWXdpaDg5?=
 =?utf-8?B?eklHcTlDQ1RHTmlheUdoOGE0VTcwaTJvNFFKUXhZeVNUbFFUeXpwWk10ODFZ?=
 =?utf-8?B?ZXhENUlrb0E4eWlwaVdxczg1KzFZZlBDMmMxR1VWNVduL3BzTGRqWE1FMjJa?=
 =?utf-8?B?eUpCdTM2b2hSQXlDbTVuUmNiL216VlZhVHhNSEpGOTRPbmdZTHhUSVdCTkpI?=
 =?utf-8?B?UXV3RjRzaVZCS3RFaEVMeW5NUkVFbzY2NUo4UTgyYmtneVhTTkZMdCtsZVd0?=
 =?utf-8?B?aXlIWWxhZmFEQ2ZLMnhuK1pJTWZyc3RMTksvNVBCMUNxZHdob0xJdkdCNUhl?=
 =?utf-8?B?Y0Q1NjBpQzZ6SmlJczU0VUtCbS9xallndkRZNkZGSGtCWUJYMzZ2UnZnaWQy?=
 =?utf-8?Q?XZ3DRjcDSkA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZLSDZWZWhKZ0h4OEZkTVY1U2QvZFdoYWpZSUpQcHJEck84QnFFd0VBK043?=
 =?utf-8?B?TXphcWlOVVpXdlRwTFdhVzgvNkRXeHNlYnhqNGhEeHowVUgrcXBEbjlyR3FK?=
 =?utf-8?B?YWY2NktXV3EzeXNBMFgzVlNGcVlmWEJPVnNGM0hSOUlKY3dkR2owbk1QNERI?=
 =?utf-8?B?ZGpFME1nZ25ES0xPMGZ1OXA3MWUwbUwySWFSblNWVkovVEJveEFCVzlNaVkz?=
 =?utf-8?B?OHo5em5jdTM0WHN2REFWTFRMdXNXUmtZakt3UEIrYjIrNDhvU0JZQ25Zak1T?=
 =?utf-8?B?c25KYldjYlVWd21QWnJETHdhdXZRYzJEL2c4dWcxdEJvUlppK1VGeXNvNUtw?=
 =?utf-8?B?Z00xaWVFV2RONXF0YWVGak0rNVdwQTdKN1lQZHhFc1BJWWVQUlAwQWRJZENP?=
 =?utf-8?B?ZUYzSFVOdFJYRW83MVMzTkFZS0dJbFZBTXl6TGpHcEdONUtNSzhORWVYVytF?=
 =?utf-8?B?a29VVVc2bHM5SUhXbnIzeWFXWXVXb1NEbEFDSFNObEJHK2lVYXZ2SW5wVUV3?=
 =?utf-8?B?YU9xMVRNSEJ4eW5WUml2M1lsNDh2UGYvRVh3V1RWWlkvR3gra0lwTEN5ajBh?=
 =?utf-8?B?K2xweEU1UHVYaldKLzVkb1Bnb0E5NkFnUUlRTGlZMmJVcGhuRkZDV1QwT2pq?=
 =?utf-8?B?UXdabGV3S09QVTFOUTZibDZYczhad0dXWndGVS9ERjJOZWtQN0NqU1lKeGlL?=
 =?utf-8?B?aENwY1QwbTAvUTkrTEYwY2lZaWRzU2RVR3RqWkl5aW8yTWlUL05xY0FwQUpJ?=
 =?utf-8?B?N1lXYU55QU5nZ0JPQmJjd0d6U1hPYWFuWGdIZWxWTmtTWmVaTENWeFg5RFp3?=
 =?utf-8?B?MnlyUGNCeUUycDVwVTFyMVpoTDhIekVXRU9rUFZmTk1Fek1XbFZUTGowd01J?=
 =?utf-8?B?VkNtV3pHRjd0N1FQUDRzUGl1ZSs3S1ZQc0RYMmVoaDZoZlljVnBMRlhwV0ZC?=
 =?utf-8?B?R1dvU2w0WndGY2pIWGJKeUF6YVgrSmhGYk9vZXNGRXU2SzMvTDJsZjhmcS8v?=
 =?utf-8?B?ckdUTkwyZmhJRmphL2ZPZmJHRFFkNkQycGJRVjd3Q2dUcUFoRkR4Z21vWDcy?=
 =?utf-8?B?S1djYzFmeVcraG5maGdMRXhaR0REYW9OajB0WWtiSWU4Z1lQbkxuS0ptUEIy?=
 =?utf-8?B?ZWZFTVhhbG1Id0FjN0ExbC9wcDh4UTVLYkZldmNpZzBwaUtINS9xLyswdWN5?=
 =?utf-8?B?am5IUThmTTVxd3o1eGNsa1Z0S2FncTJYRkFMYVFRTzhld2pObWFGOU5WU1px?=
 =?utf-8?B?ZnFlcnl4K3FCamVJUmZKM2xFdlZCYzNVYVRrK1ErdEdoVmI5a0xlQTZVcEt2?=
 =?utf-8?B?b2Z5cTZPUmRWWHJudzNIUm9FMDE3QmxDV0I0YjZJTUlmMzRacG9ROFJINFhU?=
 =?utf-8?B?QWRmbk5RSklSY1JWZFp6dkFBNzQzdVhFS1FYSzFUeXhEOUJyV3NyenBkV0dl?=
 =?utf-8?B?RmdaUjZEb0RsR1h6RkZ3ekhpVmp5dVBkYUlzekRxWFUwZzFmTVBUVnVxc1ph?=
 =?utf-8?B?dkZwTDUwOFR1WWwzNSszV09ORkxpMklxclg0V1FhZWg1Z2JFYUNVR2EwSVRK?=
 =?utf-8?B?RERIeHpJMXBNZW9rK1FocUF0bEdqNHh0QTZMVy90cFV2d2hYbEd4MklXMTdp?=
 =?utf-8?B?R2lmc2VDRnFMK2hrVHVqcVZ4bjQweFduRitWeVZ1MHhFOUx3bkZuUEFVdENV?=
 =?utf-8?B?eVJDakN2ekllb0dLa1pJWDZzeWo3WUtnbmUrd2NGUFZVQzI0Tyt6MmRzdmpp?=
 =?utf-8?B?RTR2YVJXSWxxWHVuWWRGcEVkQkNiVTNyL0hPUmsvNGV1L2d2MHRaWVJsZVhn?=
 =?utf-8?B?L0xtNk9SUUpSWGZYOTVkN2FzWEQvcEtCM2dseUVPTitqd0kxbUdwakZWQWh5?=
 =?utf-8?B?T1lOUmhpdjBpUWUvaU5KVkN2WXRHQWM1bXRyUTY4RGpEQ2tzUGV4c04yZTlS?=
 =?utf-8?B?cHJOd3NXRHF5V2Z1M0MvN0EzZ0JIMHF2Z2wyN0YxSk5FU0gvaHd0Zm4zTnhM?=
 =?utf-8?B?OEZwM0lFMk1TL3BhREM0bzNyVU5CdXlYZHdjSW1HUUdxclVzTnpaQk9GUDMv?=
 =?utf-8?B?dnk3Q1gyNy9qMDIzS3pCTGpJYzRrTzBvMjg5ZG5OS3F2UkxOYnVzd1ErWUhl?=
 =?utf-8?Q?ImD6uSdRdbLhQaZU044ivH+l/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c747100-71fb-481d-24f1-08ddb9b130a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 21:41:23.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tecCC1KVNo4cPoGzGrgmrr5+hjsVffnxG3/aHvzsfrUw1IYXvqosT9a8K5G4nqIa9oinHFj3x1lNVw4xju1lNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599



On 6/27/2025 6:17 AM, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 17:42:44 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>> mapping to enable RAS logging. This initialization is currently missing and
>> must be added for CXL RPs and DSPs.
>>
>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>
>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>> created and added to the EP port.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> One trivial comment inline.  I'm not super confident that I follow exactly
> what is going on here so more eyes needed.  However I think it's fine.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks.
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 021f35145c65..b52f82925891 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>>  
>> +static void cxl_switch_port_init_ras(struct cxl_port *port)
>> +{
>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>> +		return;
>> +
>> +	/* May have upstream DSP or RP */
>> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
>  A lot of port->parent_dport in here. Maybe a local variable for that with
> a suitable name to describe that its the next port in the upstream direction.
Ok, I'll add a local pointer to make it more readable.

-Terry
>> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
>> +
>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
>> +	}
>> +
>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>> +}
>> +
>> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *dport;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &dport);
>> +
>> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
>> +		dev_err(&port->dev, "CXL port topology not found\n");
>> +		return;
>> +	}
>> +
>> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
>> +}
>>


