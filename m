Return-Path: <linux-pci+bounces-36391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A45B827CC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E559B3BB75B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 01:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7220DD72;
	Thu, 18 Sep 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSt9f5S8"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E18156C40;
	Thu, 18 Sep 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158766; cv=fail; b=Oicbl6FcmmZCXzU18bV4Wbp7HYziFXe336OWFZDh9Wa9cSgNFgpJTQv7MI6z1xdMEGIrEnyBIDnaXlW90f95OMwUv8F38rsySm57nLoH4IH1Q6OE4fmxcetAIZmFtU7e2pAP4zynOlyvexVpLvt8FX5GljUKcfBY5KLjGtCwaNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158766; c=relaxed/simple;
	bh=dB+g0WmD5lt0yryVsU/+0HadIJ+DIISuSTdZgGGxegw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciRZeWHo0SZZenmsT0H3kqWLfPi/MwZ2FuRABs/aYw1fVYWdDi8h1/KqTKeTeAOR1M94UzjtEqXpqsZM8if6k5HfJefc+ks2GmR8lz/U4No1+3LTaMBRGpCkzlo61Bl+T0/0QtSyquSsKNLjF3/oqVHqhiM79IccoSPaedsogOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RSt9f5S8; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjuQVH/UKaI6St+x/ChzallmpOknzYRLwEAzBY+PagNxzUuUWMETCB74uYT/xtILiRcEd/GTLxJB7J1eS6P6CNdsf1s6cJzauKeowb5f/cLTVxKVPgH+jLTxUvREHOFa0mqpOqbu702ZVsNdGUop5fkUsX88fDFfw3jWNiixne020uWdqUG2DAQ6htBkPq8IOj7PD30DIpYQeygzAs2cedXBL8/d/TJ9HzMUVWYpty4hlejPnLzExYLzhKs/6Kv72BWVRNRe5Cp/8RaJFmIKYEUP46IlFkKpCT/Rr54xdblZLrN0D6eepZRuIpm8DmhIXF7PU/wYYEjTIfFC05qPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnWScUDA4s4rVubPM+54BkTeJ+Nh5g1razbUftE1TGc=;
 b=xL3fu/23VNjCMyqd0pestVQzeveuMdlGJhKeGA5pNjsYaM18bI3P75GB06pF9+uhcynGJAnkNqSdCCFiiTW3cFuw9H2fViPouPpyhzovtBJ7NmnKr1wCirpfz24Q/vJiNzw/CnLx9Rb0GEipWa6Q62d7k2ilalsmn5C55h2A4SzufqP8Ro5r0dgPgEshOtMlu3F3DnkVNRPQtGRMHUsol9lhVuXcwiVxrygNrpRBBb1zx7dgquaZhBqFRBaBD2BOUmj3Jp6FvoInCNxRTceSRUu8pxAMuYQCMgojtcKoqyYNBgKmHeJdAD9QYc2t6imc1VXMweDi8WDunNF78j+IkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnWScUDA4s4rVubPM+54BkTeJ+Nh5g1razbUftE1TGc=;
 b=RSt9f5S89KJph9/nyI9PMa769bqcXlx13ZJYsff1aVzIiAHh+qpe1xYprM7KyoAsvqCge/TlgM+0aa2v7s8q7IgYz8hnlePdRYk7Z/UY0dwGPlgSuHTJ0GaTp9XUDFTBg/iFz26T/jz6H4xUvdWuY8b4m6NootLVmnrPpfecO4eK/216JxNNpnoX4PQ8rBUvgSraXhy2/GwuK1KpAT7LbBFdzFYC/NIY/B+wcPqQlWWqwrJ5/BmmVuw92/WP5j2Q9DD6+C2/aETORPW7CjLLkY55MmEGjHuRuS+keEjnbNt3d1WyGgm/W8/xKC7n1pKbceWaYSDddY4v9Ft7sXg/1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 01:26:01 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 01:26:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject:
 Re: [RFC v1 2/2] PCI: tegra: Use readl_poll_timeout() for link status polling
Date: Thu, 18 Sep 2025 10:25:56 +0900
Message-ID: <5148887.LvFx2qVVIh@senjougahara>
In-Reply-To:
 <CANAwSgT615R32WTBzi2-8FYntmaxbmVRLmA3yi+=4ryH43aaWQ@mail.gmail.com>
References:
 <20250831190055.7952-1-linux.amoon@gmail.com>
 <23013855.EfDdHjke4D@senjougahara>
 <CANAwSgT615R32WTBzi2-8FYntmaxbmVRLmA3yi+=4ryH43aaWQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebdc353-dcda-4f7a-5a37-08ddf6525391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak5ZTy9acEpmamw4TXJtN1VFUm1Ia1RZcGtNMU50aVN1ZEdCQ1ZkeVRzZ056?=
 =?utf-8?B?RzdIQm9vV01MMkJvNzVPb0NZTU0zQXp6S3I2NVJjN1RiQVBlRk9aVFZaL3kw?=
 =?utf-8?B?eDVaU2Y4Ry9IUVpOY2F0UGczTW5DVEUxVnQ4YkFlSDVZZ3dNSmRUY2xjVXRI?=
 =?utf-8?B?UVFkWllTMndLem8reUpBdTNUK1Nyd0RXV3hLR2ZCMmpoeDZtVVFua2dPTnJr?=
 =?utf-8?B?a2UrY0FBNHJqS0FuRkFxTkxBYW5Ga0p3M3pQZ3JuZ1FkU09jNlQycGJRYURo?=
 =?utf-8?B?ZWFqdFdWRmdrS3FheUlwOW0yNzVrdVlzc2ptTytnU1U5YUM3ZXdWdWdHWHZP?=
 =?utf-8?B?YWFud01zWWpFalhBV0FzaGIyVUp6ZVYyZjZNc3cySmltbFZiQkJMRWwxS3Rq?=
 =?utf-8?B?L0phazFWWWRTRVJpV3RTOUlEcFJYUWhEalJVNnBCdy8xa2toWmlHSE5zYWZP?=
 =?utf-8?B?VFkrc1FDMjNDa2VRL2h1TDQvTUFLeTl6bFdVWUd2TkhwNGZOWDkzZDhCWVV0?=
 =?utf-8?B?L1FXcjBHRjcvSE9vM1FjMUVLRVcrVWJyT1ZiTmx0YWJ1ZUtVYTd1aFhvOHVn?=
 =?utf-8?B?WFRSbUFWR3UxMGZ4cEMyZDlmTnh5MUtOcFphaE5tZUF4NFM2UXpaWm1JcEkx?=
 =?utf-8?B?SXlOdWxQS3kvWGVZSkJpbzlNZStpMW9yemZsdkFSUGhNTzZ4T2hvbll1WDRF?=
 =?utf-8?B?K2FNT0RpYmc2NzJOaXBiUnJCMU52VEROY2FoUnhoRUhsYXpOU3dvTmV4NURF?=
 =?utf-8?B?RFVvemRKUk5nSld4N3hoVklZblk3cXJiNXRLY2xBZHhBZkp1eFdwK29qK0x1?=
 =?utf-8?B?dng0amk0RDdJbTF2cmoxbHA2NzE2bVhpQW1UMGdoaGpiTUVqMDVLUCtUSk01?=
 =?utf-8?B?QVhxNFJNWXNYYzJwMzUrenNCQXc2dGdhalc2STcvdTBFVDVYS3NmOWZNeHlO?=
 =?utf-8?B?OEJPQkRlWS9vdnVQWHErYVo3VUgxNGx2ZWx5bnJ6WGRpRkRBQVZpQUlwc0hh?=
 =?utf-8?B?KzU0bFBLV0xFL3FTM1NQT21vZDd3QkVVWnc5OVFYcHVnNDdFa1dIdVVPTGRM?=
 =?utf-8?B?bnB6MUp4MVkxekVFb1Q4VzVmY1FoQkZYUGNXSGo5bHgxVlFqdWJUbFlwTE9t?=
 =?utf-8?B?RTJWZzBsNUxuLzlxSWx4OWtvbWdCQkIzZElkdnJvT0hVbCtvUkExYi9PZmNR?=
 =?utf-8?B?ZlJkMFVNVTBCdnVpeDBJc0xFUGVvRHFjQ3J4TkN0VnI2NWZLd0dKWEV3ZEUz?=
 =?utf-8?B?YlgycjVIczRtN3QrRElIZnNwTjZ1NU9Oa2FpUTBGU242QUdjNTN1RkNyNmlB?=
 =?utf-8?B?VXZIdnY2MmdYZ09mbXdOd21MdUVKVUYrU1dmeXZqNzVqWHMvRmNkQUdUUG16?=
 =?utf-8?B?OGJwQUkyWHh4OXZlaml1bzdid2h3a01MZnh5Q1VEc3MwYUorbFcyUVM0VDZl?=
 =?utf-8?B?blhVcUt3ZDlDSEdqbnIrVHpBdjJhTzAzSEdocjArd3JhakYxNjN4QThMOWdI?=
 =?utf-8?B?WEpldlpKaVlGQ1RxZVJGSlVpVHorVDFBNGdWaW1ZL1ROVE50ZUxHM3hKM2Vv?=
 =?utf-8?B?UmNlQXhuVjZCdmozNVVGY2trT0FINkw4N3Z0VUxSVDJNMkFWOXNhWjZYc2Ji?=
 =?utf-8?B?by9uKzE1NmpWMHI5QUNhY1FGVHJNQUVIZTV2c2g4dWV3N2ltRWRLU0t3bzk4?=
 =?utf-8?B?TDdSYiswN3dRN0pqM1NUS05JQVZBNlFVbGFWNktndEVSUDk3TnFjT2VNbUtQ?=
 =?utf-8?B?M2t0cGFWYWl3bU12ejZwaktQeW55NUdMSEJLVnBYOEZ0MnZTdnJ3NGN6ek5D?=
 =?utf-8?B?UUljVldMZkF3V1czS25Ma3djQXNpRDJHUjBwb3ZNbU03Y0JXTm02YmVZei9I?=
 =?utf-8?B?Y0VaSTBEYzJHc2hKSVd2aUZocXRCendoM1ZFNlFkYmViNjdSSVI2Yi9GWHgr?=
 =?utf-8?Q?pg08p4B90Kg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhBblcxMUhOT0VlRlJkei81R3NHYXBSNFJTZXB1TzQ3VEVnaDFHYklTZVQx?=
 =?utf-8?B?Y0JYa0NjcW1rVkRBRnp1bDJhMUJVejZhMmJRZEJDTUJTUXVrdXZuZjF5REdz?=
 =?utf-8?B?UlE5RVBqelJEN2dyUEVkb3h0QzF3Nk5FVUc4RXhQVjE5SkRmRm1kTEZ4b2RO?=
 =?utf-8?B?aTVDa0dVNnBqSHNoT0FYRGgwMEV2YXpCUGdqRDBFazZrZzFreXYrOTlaQ0M5?=
 =?utf-8?B?R2NuY3MwNXFuZnFrb3d0ai8ybmNTVnIzUWlObjVnUEV0ZkNKN05WYmFTMEh1?=
 =?utf-8?B?aUZWUlZ0dGt0TXYvclZEcTB3NGZneWI3YUlFb1hPazV5b0lkNGhyYXRKcW1J?=
 =?utf-8?B?K2ZCQlRBU2tLSGxJaTNENTFIeWZ0NnZlOXVIWWdtbzk0R0g4TnM4dDBWMThG?=
 =?utf-8?B?Q2pldGJyS3YwemUxSU95bkltTHpIUkY0Mk5CSTNUSkRDNGpTN1NidHdESURq?=
 =?utf-8?B?bERCNXlaaTByOUxXRXBNUUl6VGhsQk9xN3ZpN0RRZ3Q3eW1YaGpPd0dFcDI2?=
 =?utf-8?B?M3pFd3pHenJWTzNUdms3S0hhQ3NCSUh6RWRuRzJCWFdZQkRJUVJic2RTYytw?=
 =?utf-8?B?Y3FVR3VaME42V2YwVGVFNmJMTTNuZkJNblJiNmxRdkFHZ2hRRWIxeHh5ZTNo?=
 =?utf-8?B?MVEyWGFPL2NxVzlQRThlcVVLWExBQ0lwYlcyclRmVHpBRjhIalNad2kxTjBs?=
 =?utf-8?B?cHRqQWRNK1A4ZUJRbTFCZlZWZFdkVktLMlZsY1p4TEc3MlY0NzVWQU0rZnlQ?=
 =?utf-8?B?ZTlLWWFZbS9PdUFDdit5VTlpR2s1d0VhcVM5eGRVd3NFNGlaemlETTd1MHpO?=
 =?utf-8?B?d3B1U3ZSaHJ6L09IVXlvRjFVTGRPcnZNVmZQNnQzSzB5Z3ZVSDhhRW96YU9J?=
 =?utf-8?B?eXQwaGJacHhSQUVJU0x1cTRTdVJFS3psb0NQRGdacDVSbUhmYlhNTVl1UUc0?=
 =?utf-8?B?ZDRnY3BpVXFkZ1VsRWdaSHhxWFYrME9SNFFKUjBnQ1k2YXR3dFNzQU9mWE1O?=
 =?utf-8?B?TVZtK054RUcwenJITDBTMlArOFRJTmYrZHVQdXRxdEhWV0pwNDNMdGxTYXpR?=
 =?utf-8?B?MUNxOWZramdQdXI3NWErRVRqTW9NR2RoSVMrNktZZ2pxdFlYZC9OclVQaHpT?=
 =?utf-8?B?WG0xbkVSUmowTSt6WVlva2M0VmRmeE9HUTBzcXZJYXRwdkZzUTBGOVVxUXI2?=
 =?utf-8?B?YzJISm0vY1lvaklPRCtiNjlLM1ZVbjRsUlBTLzA2S2pYUnNDNEZFMnJpRElE?=
 =?utf-8?B?RjVFTFBRR240K3pvbHNBUGErRTlmdXR0elNDakZnRUZoTlNtU0U5TUo3ZzBQ?=
 =?utf-8?B?RmRWdkFKYlNpbldpWlNpZnhPbE1zZmw2ODRjWkZ2dXBvd040T3ZQdFRrQm9x?=
 =?utf-8?B?OVFyUnpUSTd1K0M0RjFkcFYxVGlXakw4dXBTYUU5eXdGM0dZL25oTTJNeUZu?=
 =?utf-8?B?NFNMM09xSmpBL0VTQ2xmS2pMd3BBQTd1R3k4RnhDZUFSYzJhWXkvOWozMzdM?=
 =?utf-8?B?a2l2REMzZ00rZlBlZzkvWFI0Q3ZZMVF5c0h3NXJJTmpFeHU3OEVabTQvamcw?=
 =?utf-8?B?Vy9YVDBVWWhZY2pJc2dRWjdtWENWSEl6SXhrekhHOHZhQUZ4cDhDT3AvdzZk?=
 =?utf-8?B?N1JLVWJkelMvWnltRFF5dUF4RTBHSUZkM3JkaFhEYlhLV05kWTd4cy8vQ0xX?=
 =?utf-8?B?cEZXcnpKeHgxRjNIQ0dIK01FV3RuRDhteVdPVkoyY0ZtbjZoWktNYnhpV01u?=
 =?utf-8?B?NVR4bmRnam1HTk9lOWk5QW1wQk1PZGdGTDR1NDZPa1JVczBtWGlqZjNPZFpv?=
 =?utf-8?B?emJLNzl6aSsvYk42Z2hmY2ZRVGk0cG1CampYc1A1MDNzS0NTQTNZU0Y1OXA5?=
 =?utf-8?B?S3hQRzVLR000b2xiZkVzZHdOWS9SNlFzcGFFN2RmNUxtMEV3UTdDOWsxZUVR?=
 =?utf-8?B?QitTMC8zbFpYWDdobEZIdm94QjhuRmxUVjU5RGpJbzFYQjBiaWpsYVFhYnI5?=
 =?utf-8?B?SEFGVElJTWRtNkVJQUxOaXhuWU5nZjVFeGJJVTl2VW9oQXRXYjNDcG5hM2ps?=
 =?utf-8?B?SnRKbFpnVmxTRklLMHl2a252UThOVnI2K0pwclFRRHd4MWhkRktoQnlNWTVj?=
 =?utf-8?B?QjZDUW5ITUFQS2ZwRVJTMnk1Rk14Sjl4amZ3OTR3L3pjZTdMWkJFbENNenpl?=
 =?utf-8?B?b0ZoMGpseE02Y3pDZGxyZDlpVHBja0t0ellmTTBtRnB0VDZPOXFLWXdrTldK?=
 =?utf-8?B?K0xCQkdrVGFYeHIzc294WHJJelZ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebdc353-dcda-4f7a-5a37-08ddf6525391
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:26:00.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxxSLcJ5aCf3ToV5ISsWZUnpd424WS+fwUxhliCSSYYmwPpHk6AbQq0Ieb63+t38uFNkU3AI5Nd6VhUigGT9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124

On Wednesday, September 17, 2025 4:45=E2=80=AFPM Anand Moon wrote:
> Hi Mikko,
>=20
> Thanks for your review comments.
>=20
> On Wed, 17 Sept 2025 at 08:51, Mikko Perttunen <mperttunen@nvidia.com> wr=
ote:
> >
> > On Monday, September 1, 2025 4:00=E2=80=AFAM Anand Moon wrote:
> > > Replace the manual `do-while` polling loops with the readl_poll_timeo=
ut()
> > > helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> > > during link bring-up. This simplifies the code by removing the open-c=
oded
> > > timeout logic in favor of the standard, more robust iopoll framework.
> > > The change improves readability and reduces code duplication.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++----------------=
--
> > >  1 file changed, 15 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/control=
ler/pci-tegra.c
> > > index 3841489198b64..8e850f7c84e40 100644
> > > --- a/drivers/pci/controller/pci-tegra.c
> > > +++ b/drivers/pci/controller/pci-tegra.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqchip/irq-msi-lib.h>
> > >  #include <linux/irqdomain.h>
> > > +#include <linux/iopoll.h>
> >
> > There is already an iopoll.h include in this file, so this adds a dupli=
cate.
> >
> Opps, I missed this in rebasing my code.
>=20
> > >  #include <linux/kernel.h>
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > > @@ -2157,37 +2158,28 @@ static bool tegra_pcie_port_check_link(struct=
 tegra_pcie_port *port)
> > >       value |=3D RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
> > >       writel(value, port->base + RP_PRIV_MISC);
> > >
> > > -     do {
> > > -             unsigned int timeout =3D TEGRA_PCIE_LINKUP_TIMEOUT;
> > > -
> > > -             do {
> > > -                     value =3D readl(port->base + RP_VEND_XP);
> > > -
> > > -                     if (value & RP_VEND_XP_DL_UP)
> > > -                             break;
> > > -
> > > -                     usleep_range(1000, 2000);
> > > -             } while (--timeout);
> > > +     while (retries--) {
> > > +             int err;
> > >
> > > -             if (!timeout) {
> > > +             err =3D readl_poll_timeout(port->base + RP_VEND_XP, val=
ue,
> > > +                                      value & RP_VEND_XP_DL_UP,
> > > +                                      1000,
> > > +                                      TEGRA_PCIE_LINKUP_TIMEOUT * 10=
00);
> >
> > The logic change here looks OK to me. This makes the timeout 200ms (TEG=
RA_PCIE_LINKUP_TIMEOUT is 200). Previously, the code looped 200 times with =
a 1 to 2ms sleep on each iteration. So the timeout could have been longer t=
han 200ms previously, but not in a way that could be relied on.
>=20
> You're right; the original usleep_range(1000, 2000) had a variable sleep =
time.
> To replicate the worst-case behavior of the old loop, the
> readl_poll_timeout should
> use a delay_us of 1000 and a timeout_us that matches the original
> maximum duration.
> Since the previous code looped 200 times with a maximum 2ms sleep,
> the correct timeout is 400ms, so update (TEGRA_PCIE_LINKUP_TIMEOUT * 2000=
).
> or increase TEGRA_PCIE_LINKUP_TIMEOUT to 400.
>=20
> Are these changes ok with you?

I think the code is fine as is. Before, the shortest the timeout could be w=
as 200ms, i.e. there should be no situation where we need a timeout longer =
than that, or otherwise that would fail randomly depending on the sleep dur=
ation. So I think the 200ms is correct here and the only change necessary i=
s the removal of the second iopoll.h

Cheers,
Mikko

>=20
> Thank
> -Anand





