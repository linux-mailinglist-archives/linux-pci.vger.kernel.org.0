Return-Path: <linux-pci+bounces-42799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D99CAE389
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 22:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C87C30399BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D02DF128;
	Mon,  8 Dec 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z8Fyc8Tg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4E281341;
	Mon,  8 Dec 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229320; cv=fail; b=ngDEINN3kHW4SkiEzhfEK2CgFZcd/4k/sbI0PwCfcbTort7TjG21N/3cjtLKhhozTskSLFP7beALLHNRwCFyPbSLsX3a9SfouwBoJHgefNU7MOkUIsaOtr2+fciRJ93bUTprZ33XPpwmGo18CYJhdIGfHrRcM/zNN+Agq0Sb0Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229320; c=relaxed/simple;
	bh=OPmzdP05ziibY+mN+nv6ZEYvfjgZnDJpx5I9KpGXAgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbmlVpU92jTzTALT8p07LfgJfMVazVRRjZA0Vr9cjVHCxMxlOORJNN6FgZ12Tsje2/9NWKMnpDraxMJ0oR/jJ+Qbi1gjaCscq8ELVcTcQK2z0URpPPezP/XAZmMQRTMf4UgmjtZuaVc1Cf+RLYevZeWT9Q2ZBJYuQ+JAzVC4ikk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z8Fyc8Tg; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCZJSza9DAt7QgSGquwiWsx+kaTBRe+iBJs+sYOUAMD1tGLew56+pxPDXjl4Idzy8hV6m4uuSHANy1sL+D1uW2L6vB4q7qm4/WtJV9tyiGkZ7mIUoEiu5KK9MfRy4AheX9K0ObXHMUKXSCkuVVi8YfGxRUEu2jIeJz7aDt6IjPrNB9h/GlW43ux34NanPDdJRaA4Ohx7GwEmHuET0OZwADJI6CsnXQX634l4qOTOr7yyhvskBc6y7MO/+waeI/mXYNDUlkQTxP5DOSUA98fNKKDt6cjk6JXiuW0ymkGtJcFq0zyuH21FUK5lxfjGNtqqGkh/JZ3sXPJQj567Qo6LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPMXznIYxJ8hBQD5qjkU3OyJ+VFKvWDCbbN1n0siWs0=;
 b=QIT0v6C9OF3asnOHqh3e/kNQ8SKnqwklyyWynM69mfIUB+HN+kO7fiWm2oqgN84ViuU2OvnMZm8Hw+LcOYzOD380O9/sMaFjkwGNh+eK8DERvbt701FwbmG0NoljbWtzJWZ4XuboSntQAVMeYUkNvz6AQXWYeyclxnDkHON0i0lPF4oktinyDa5WTeJQdjYZ5B6AFlPQtWIcF1byUX0m9SBB/9uxxnGk9Pn4RuFPUoFUcX/ftts6XWCAX3oa+awjEmS2MEMGacoMMtwF/B6ir8wyfGVnBefJpCFHdk/KbJ3HV5gyrQtErEYnJ7GH2S9CRFOFg0LoJs5L2bI/SkQ+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPMXznIYxJ8hBQD5qjkU3OyJ+VFKvWDCbbN1n0siWs0=;
 b=z8Fyc8Tgu3fhU/RctPf/shmt6roOd6EdbU1BjXV3ZEBPkrS37Aq1Kw9veIRH3Oop/ZgUL0S4QkokoYTQKIfPvHj8CZAiA093Dv80zUlCPkq2rtfbULRLfLjF9VcA6fq6gSoWYuCYGwGxSiWevYmgZiQt74ipVZrSAgb7Gzqu6RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 21:28:34 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 21:28:34 +0000
Message-ID: <ed865f72-8fcc-40ff-afa2-0ed895332126@amd.com>
Date: Mon, 8 Dec 2025 15:28:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251208180624.GA3300935@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251208180624.GA3300935@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: c10b963b-8814-41fd-6b47-08de36a0be26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3NuNmZLQUNQWEVCZnRoNE1ueEdtTU5ySGRybXEwS2RrWkVJc3ZQb2dxVWVy?=
 =?utf-8?B?aUhJT2dlV0hkMVFIdnZCaEppQlc2OS9TMVFGV1VsdUVaNHhtQkNKQWZySnJF?=
 =?utf-8?B?L0RuOGNrVHBzMW9maWFvak9SV3FCbkEyV0w0NjFDSHFHS2d3RFBweEpSMkZq?=
 =?utf-8?B?OVpvanFhZEJIOXlSTjl3Z1c2VEpHTEQwZnRoZmNzOVVEdzYwTEJRQnQ3SFJq?=
 =?utf-8?B?QzVJRDZlemFTdWhQMDhhenlRQndaRitnNUx5SStmWHdhaTA0OWNoVTdJdUpr?=
 =?utf-8?B?RGVvVHJ6TlE2SlFhYnRjTWF6cit5SnZubWpQdkk0ajdEWmhuaFFTRmRIU2NZ?=
 =?utf-8?B?cDNHUXpYUlpSbC9CdHdTcDdUd2Z1NkJJRDYxdHdyVXdNS1k0NFBHK25XTC81?=
 =?utf-8?B?eEJremlCcjNsK25RVFJBd09KdXhLWXp4cGRlQjlZVTkyK1JLSFYyL3Bqd2cr?=
 =?utf-8?B?dWMyK2VXVkpQTjBxeE95c3BYMEMxVVJhUktwNHE4ZUNWQzZ2R3I3RWhkeWh6?=
 =?utf-8?B?ZFpmY1hzb1JQbjRIZUdmbXY3bjBEMWNZU0xDMzVRdEE4OWdNZDNVWU9Qc3ZY?=
 =?utf-8?B?bW1PRWpDYjJ0eXlRVjZOR3Q3N0MxTGo0emJHM2gvdDlTTmhIeHI2aVFsajVI?=
 =?utf-8?B?dCtTSHJoVnZqUkU0dXJ3dWpYYlNRZ1IxRGpXTXptUDFuTEl1aFBvcWhHRVFp?=
 =?utf-8?B?NmlFSGcvNDFDMXdrejIrMWtlbFZQd285U0lQdi9aMHU2TUt2QjA2YWtsbkRh?=
 =?utf-8?B?MDJKclhCa3FxS1JrNXhOZnplMHE4M1NsM0hXZUl1R1NKNU9IMVo2cW9tSkRq?=
 =?utf-8?B?S2l6aGsvTkVKcTBrS0JxbUozVHhsNDJjZW5wTTMydk55bzZDTzFoQlA1Z01C?=
 =?utf-8?B?Sjd0TW5iRUhkOFBBTVBlTmFpTWlQckxoWVVDU3kxSjdYTTNMMWhjVUtWbUNm?=
 =?utf-8?B?cExIS1cxem9HUjkrWCtTalE2aEpRYjQ5ZE11cnVCVkcyZVc0eVNRUjFtMnpO?=
 =?utf-8?B?NUNCaWtoMng2SCtBajZLTlZEU1NxcktZWkVRdlM4T01XZTIvR04zd0tsQ01y?=
 =?utf-8?B?TVNPbzN2Wmc0N3VKNU1ZWlZPajNYMGFPUVdzTFNLbEV1VWVLSXY4VDB3cnRP?=
 =?utf-8?B?RzNWQ3VtZFJMZEZnVUpXbnRTbWpzeUZBZW1sVDYwWmNkSVRVZWlxNE9QM2Yz?=
 =?utf-8?B?L0lqQW95L3VwU0lBNmRJUEJzaEhNbUZOditKTW9aZWw2UU5IeTc4RGJianB1?=
 =?utf-8?B?dVgrUHVXcysyc3BGa0RSeDJjbDdPemMxb2lmT1ZXQ2d3eVZPQjVsVlhSVG14?=
 =?utf-8?B?cEhPbzBHR0pBN2xEMTUyeVppNVFta0FtVzRoYmYxMTV3OXBkL1Rvd25YN1M0?=
 =?utf-8?B?Q0RIRm1zZjd0WHdHV1lXcnFBTC9RcGQ0ZWpCZldmUTZrL0NnYmNUN3JKMmhy?=
 =?utf-8?B?Y2NFQXR2YVZJam9LRTNRZDJkTXZZRTNHUEllbGFldHNFMWNmdng3N090eHAv?=
 =?utf-8?B?YzU4eGN1ditzWFdoTEZiSzRlV25tV1hyblFrU05BNEVNeVJjTnZveW41ZUtK?=
 =?utf-8?B?Y3ExdURsYkZuRXArMGxMT2JudG45V2pLK1Npck8xSEZ3SFpLanpVNUJaVUpG?=
 =?utf-8?B?cDNzaXBLMEhId3pCOVdrU2YrS2NUZVlFNkF4VkZqblNrVUR1Wm5SMll4clFO?=
 =?utf-8?B?cXhVRzVuRno3by9MNlBoYUp2dmF1MWJNL2xoQUpqOS9IS0MzNGphekhuWkQr?=
 =?utf-8?B?Tm9rNWlvcGlzTEJEbFpPSXJqOGFSeTJNY2h4dks3eGoraGkzTDVMdDNSK3Fz?=
 =?utf-8?B?R01TRlA3dmN1M1llM0x5c3VmazErazczVzEyMElBZVh3blVRUFdtalRkd0h0?=
 =?utf-8?B?bVdsME9oS1k0bjlDbDhFOWxkbHRXVVhNeTdhcTYwUnAyajEvVk1EVDZTalgz?=
 =?utf-8?Q?l04TYfvGCA/y60P7w0p1fTSrm2n5c0FB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znlkb2sxaXcwYml6ZTJNL2V6d21CZ1ByaWVtR3M0bU5oamViUlQzNEZTMWVN?=
 =?utf-8?B?VUNvMFMzV0JOaUFpMFRFOElPaGIwSXBkelVHQTRXYzk3bHBodWFYSjVkSUxo?=
 =?utf-8?B?VEtLeW9mRFI2UytpRVhwNGx3RjlRR0hLenQ3NkxiekRTcnhINGh1c0VLajVv?=
 =?utf-8?B?Ty9ic1FycldFR3pDaTVNTzNNc2d6dEY1d1Irc1ZGSUdSaFlIRlN0V2kyM1NG?=
 =?utf-8?B?ZUY4WHVZNnVRalgwdzFKaXk1OG1wSFBNVmNPZ1pqeGpMTGtOcEMvS2lPdkpL?=
 =?utf-8?B?Z2J2bDk2Vjh4T2RvQWpEUjcxU2pmNCsvcnVZenpDay9jUkNpM0kvbEoyZXlZ?=
 =?utf-8?B?T0ljZkM5bC9tYlBzU2VnSVN5RS9jSWs3UEt2RkFpRUUvYXFDcnJRUjNoWXdH?=
 =?utf-8?B?VEhSTGVlUGVGejB1d2YvUlRjWWMxVXR2QVRydUQwY2ZWbUZkejFvdzFweXJj?=
 =?utf-8?B?Q2R3Z3FLTDREcW5VNS9Cd3J3eWNXUUIwWHgra1JtVGNFdFlQdnMyWldTaXVo?=
 =?utf-8?B?Vit4Ums0SnZtaHR0NEF5bk56TkVTSmw0YnJveEpkVU1BRHNuKzBzWFc4Vis1?=
 =?utf-8?B?MVk0MmdZSmZETzFzTzNnN3htblQ1VmpERWtZaUhVMTVmb3RVbUZNL1E4Q3dw?=
 =?utf-8?B?Q2hRbFZkeGFSaWUxQm9UMkIwQ2xvWkkrTjcyZEY1aUUxM0VsSjVFZzBEQU9P?=
 =?utf-8?B?SVFtWUl1QzhOb3Z3K0dMc3NMaEJJQzdZNzV2akxod25QeGxmSGNuY05GUUh5?=
 =?utf-8?B?UVhnTkFqVi9lTk5lcE1tUzlTQjA2NXdYbFRCVDlLYXBzWndTL2pNUHorN2ZN?=
 =?utf-8?B?TGVNTnVuRkxFTnFTOE9SWFVpK0huUzV3RVptMDUwQ0pxbE1MajErM2RuL2R6?=
 =?utf-8?B?NG5XckNrYkZMQlRqb0FDZGs0alpsMFJLQnRJRlE0dmNyUXBySlFObU85d0pp?=
 =?utf-8?B?Ym9GVktHQlJ0Y1FNaFZuVGpkTnZRTDNaNFpHNlF3MFg4bVVnWFBZRWlMQXB5?=
 =?utf-8?B?NkZSUHBYZWhWT05SQXJWWnZ0TnRaUTUyN29qVlhMOVREMTR6c0llMXhuMDJR?=
 =?utf-8?B?ek9NeXhYK3BoQzl4SFNBWUQ0NTZnTFVOM1ZRSnVXVXd1SlFDUnBzK0dwZzFD?=
 =?utf-8?B?N2VJZ1p1T2Q2T0tielg3a1FKcG9rVVhCWXhiZ0hPd20xS0xjRklxZitGczd0?=
 =?utf-8?B?dTBLaFVwa3dVdVd1WEVaeGZTSWQ3VVdXc0NxUkx5QnlqT1NBR3FaY1ZwNkMz?=
 =?utf-8?B?TlJ2dzJ2MFlkS0hlYTJqWXpKZk80WDREdHpQbkErQUg5MWtQYUpsYVpyQTlB?=
 =?utf-8?B?c2R0dGM0eVU5Z3djUWlXMSt0eFRCVlNNTmpXcitmZW1xZ240aWRRaytKNnJ4?=
 =?utf-8?B?NXc0S1BXSXhtUm8waE5aZHpvU2tlSFRXaWZkWUtNT09hL0F3eklUUlpMU08x?=
 =?utf-8?B?RXc1U0ZGUlBoajRHMHcrUGFkeDU5ZWFKRjh5SEtteDQ1SnNzMFRPRlhXOGhY?=
 =?utf-8?B?YWlwZjVVay9SakF0VVlDczJuUjg4Y21wdXo4NzdPUzlDZ2kxazZoMzIySVZs?=
 =?utf-8?B?N014a1hTTmhOTGd0Mm5Ka20rMmZBdWlYOUVWYmg5THFNMVRLVnd3Mjd0ZEdr?=
 =?utf-8?B?RWFqY3ZBZ2VjQUNMdy9vMC9UREYzcjVJdnVBc2cxdlZ5Z3R5dkVjcTBzWTN4?=
 =?utf-8?B?K1dLVkxoNUcrUlR2RU15NjVnWVBqM1kvL1FGbmludUNNM1dlSTgyK2J0czg3?=
 =?utf-8?B?aXZrMlhnQmp3N1FnRVpKakxJMlU0TVZWQUpycDhCZDRUNEN6QVowdTZkWmdm?=
 =?utf-8?B?WFFRMFN3aEVsNkpzaE1qSVBMZEFJcU9wZ1FxclJvc09NSy9YMHFzT3JvcFBs?=
 =?utf-8?B?TGxvdXUzdFFzMHA3ZEs1SU1RRmxSZU9SdlEwTFZwZm05blp0VG9qbWpIZy9i?=
 =?utf-8?B?Q2U1K3FOSnZoajlENXIxUGwrZmVsWnpUUFVmMDVCeGV3THlITW1mMWQ2dDly?=
 =?utf-8?B?SVNHTmY0YlgvU3o2Y25hYTM3VDhheTQ1elRRdUJocjRQS01Kem0vc1Q5OTg1?=
 =?utf-8?B?RTM0Y2c3QllBb29Ta2tINmhSMERZNFNnNFROYnNjVkYrN2RLT1REbUVybHVo?=
 =?utf-8?Q?sSorms8OCoy8IWjkZ3R8NmR2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b963b-8814-41fd-6b47-08de36a0be26
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 21:28:34.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlSq6KWLfXBHpt+lH9coCnpiGRr6VcKFj47TXO0kj/E7Cqz1bESBpY8tDqMWQdqHo1c4d4RrymN+eIr0UtjuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

On 12/8/2025 12:06 PM, Bjorn Helgaas wrote:
> I vote for a subject like:
> 
>   PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
> 
> I think stuff in drivers/pci should have a PCI/... prefix.  "CXL" is
> really its own major subsystem, not a feature of PCI.
> 
> On Mon, Nov 03, 2025 at 06:09:44PM -0600, Terry Bowman wrote:
>> The restricted CXL Host (RCH) AER error handling logic currently resides
>> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
>> conditionally compiled using #ifdefs.
> 
> s|the AER driver file, drivers/pci/pcie/aer.c|aer.c|
> 
>> Improve the AER driver maintainability by separating the RCH specific logic
>> from the AER driver's core functionality and removing the ifdefs. Introduce
>> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
>> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
>>
>> Move the CXL logic into the new file but leave helper functions in aer.c
>> for now as they will be moved in future patch for CXL virtual hierarchy
>> handling. Export the handler functions as needed. Export
>> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
>> Avoid multiple declaration moves and export cxl_error_is_native() now to
>> allow access from cxl_core.
>>
>> Inorder to maintain compilation after the move other changes are required.
>> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
>> inorder for accessing from the AER driver in aer.c.
> 
> s/Inorder to/In order to/  (or just "To maintain ...")
> /inorder for accessing from the AER driver in/so they can be used by/
> 
>> Update the new file with the SPDX and 2023 AMD copyright notations because
>> the RCH bits were initally contributed in 2023 by AMD.
> 
> Maybe cite the commit that did this so it's easy to check.
> 

Ok

>> +++ b/drivers/pci/pci.h
> 
>> +#ifdef CONFIG_CXL_RAS
>> +bool is_internal_error(struct aer_err_info *info);
>> +#else
>> +static inline bool is_internal_error(struct aer_err_info *info) { return false; }
> 
> This used to be static and internal.  "is_internal_error()" seems a
> little too generic now that it's not static; probably should include
> "aer".  Maybe rename it in a preliminary patch so the move is more of
> a pure move.
> 
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>>  	u32 mask;
>> @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> 
> Not sure why these EXPORTs are needed.  Is there a caller that can be
> a module?  The callers I see look like they would be builtin.  If you
> add callers later that need this, the export can be done then.
> 

pci_aer_unmask_internal_errors() is called by the cxl_core module later in 
the 2nd to-last patch. I'll move the export change to the later patch. At 
one point I was trying to avoid changes to same definitions multiple times.

>> +++ b/include/linux/aer.h
>> @@ -56,12 +56,20 @@ struct aer_capability_regs {
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>> +#endif
>> +
>> +#ifdef CONFIG_CXL_RAS
>> +bool cxl_error_is_native(struct pci_dev *dev);
>> +#else
>> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> 
> These include/linux/aer.h changes look like a separate patch.  Moving
> code from aer.c to aer_cxl_rch.c doesn't add any callers outside
> drivers/pci, so these shouldn't need to be in include/linux/.

I'll remove these from here.

- Terry

