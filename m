Return-Path: <linux-pci+bounces-25379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51373A7E239
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83A4165851
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638C2054E6;
	Mon,  7 Apr 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tN1SJa9L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F598204F72;
	Mon,  7 Apr 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035941; cv=fail; b=OOEfZjypSx+sT9NfBGf2I8+B2sQo81ZRqAZGRRM9phXJJZSntXZfg5/+xI/a3/3UShganeKEB9L2RhMgLOqXQV4pskMATOMgi9+zyS14izXBgBVL0DPZzpgDDbTpX2vXC6rDPjoQk8tCD6CDlumOr1pB8ImIUa6UfifBjH8/0EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035941; c=relaxed/simple;
	bh=1SsqcEk7i7V/Y5zcTUe+Szz7K9z7lFWDTl3GP0uXjn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DXJ0lZrx7cA5fbn8+2GecjnrlKDVcHAgGl/2C+6H+oaZFRWzfxElvIUnb2rGCnbOCwP150mNlPUSi1SbEYGTgXB5q6r5KAkfg2pqayJ3rCGMgfzOyUpwPn8mEvKt/kLc0wfT0K+LHYjVn22/yIiASJxMLPiRvjc3Uz24r9QXdIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tN1SJa9L; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz/b2ZnnC59MryHacyefu29aLrgU/N7NkOpLPk+UtbiKmPNuFgwxNdCkGrAkJjD4k/ySDG8BsdtI57Xs313i/YXzJCLPjkPFIs66J2v9wufOqlB/sQDbMeSEkcaEh5igCzbm1/ZoMYq5vmLphWWwZxMC1xAEuvV0pxq4xgO/DqFLSyaexmvlKmDPm58AYwBtnZx+4soB8xO3xnLQOsfcwTbeYpA/MxumQ6a9Kd0rWMUEJGqXpjuTe1Fjfdcb7Okorr1tqThD4vfwRbU4Y/F6LzQwcDZOH/nuun+ajm8YX/GCvK97MUgIoS9KS0VbnmmzNToZdYVJQBHwQsNPSFvidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpTsjRN85kpY7pYEgDBnRjJX5pnGL52Ahdi/llqyHbs=;
 b=mXkympZ5QotTwNGf05DgzHvvdkjwfyGwNmn6mWl9vLkIneq5tSUgVJeZ8R7khN+tQ8kazKozV5xYjxMSlwhZkfnl2VdBNwKbsMjmJrcd1SB9GiH/32an3E+PpFrnxmj2MaxdQFKYC8+bNVOt115rslCspFXBBO6C0m0OhqBpDv3v3B7csWDEdgSa4CIjrQeL3b6KTSFGR9nh+49JUAIQb6DCS3YcyfMLr0whtH+P9WoZOff3EF2hstEHJl2sJL7zil7oI2dpsHVozZSiBhi3RvLrqZvkZLi3+QbrGK0IURkLzrpo5fP3vnPOrEA5RswYt0Vawa3W63YIUX3cqF0F3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpTsjRN85kpY7pYEgDBnRjJX5pnGL52Ahdi/llqyHbs=;
 b=tN1SJa9LYmn5mbatocJMbOta0jCTnLTSr9h6DCsnmYt2kAVmQsmFZFKViDtRj80utfUwNXk+Gx6swy01xabRqillZxP+IX0Zl5UC4EVDFNm/mvQnjpO2KDQlpIAUmfN8gWM2QqZX/WWMuF66mfktjVHBnfAzLd2h6C62kY8UgvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.32; Mon, 7 Apr 2025 14:25:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 14:25:35 +0000
Message-ID: <97a53556-4e01-40ed-80da-0369f401ceda@amd.com>
Date: Mon, 7 Apr 2025 09:25:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during CXL
 Port cleanup
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-17-terry.bowman@amd.com>
 <20250404180427.00007602@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250404180427.00007602@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f941d5-02cf-44f0-ca72-08dd75e00f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkVrU0I3R1h0VmowdFltUUdSZFVmRnpmTE13eUo4R1RWRUp4NFN5Z1JGNnhk?=
 =?utf-8?B?MXp6RjVDQjg3NXY1V0NQOWhveGFzSEZueUVzaUNDRUd0cmxMZ01EaURXMU80?=
 =?utf-8?B?UmxQL1FEeWhma2EvOFNFZmxLei9xcTg2T2JFRW9CazN2eVllY2szVC9LQmpS?=
 =?utf-8?B?cG9ZeUpud1FVa0diQ0VaM04zUUV3Z3ZSbFY0dkwxcjhJSEs4UWFSYlVBMHA4?=
 =?utf-8?B?cm9xbFpwRFFwVE9XcktzaC9lTUVSMm1NSjQ5WDVUS2hRdzI4Z0F4dWQ1SnhF?=
 =?utf-8?B?Y0VYUldTelBLMnBEQXJPNU1ubVloaG9TSll0S0l2RzVRSUpIdFRRWFdiNGV6?=
 =?utf-8?B?NHVuS0pRM3FCT0luYlFTcnZncCt1WXI4SHpOdlVjREZJSVoxcWw2NDgra1Na?=
 =?utf-8?B?YUc5cUtPMUNoSlVBZVFPNnQ5UGxPTXBvSkxxQlBFVTN3UXR1NE9jUE5PME5t?=
 =?utf-8?B?OEowdlVmQWw2cURTeGhqU0xOcG52QmNOWmlNTkgwcVJkMFh2N0hEbWR4TkFt?=
 =?utf-8?B?a010VzN2enBEbDN4TTgzVFdFbmpIV3VodDBZSVhhbmx4SlBFelpSaVpkTjFK?=
 =?utf-8?B?Wm5OQjgwelFGMTZVMkpnWEQ4aEJwdDFPZ3VXODY2VnR0VFVTTGFTVHhwUHNL?=
 =?utf-8?B?Z1NsaEF4NmZMRUtiZEdVQ3oyK1RmYWVORjBlSFZiR3FkWmpCM3ozbm9mREM4?=
 =?utf-8?B?NlY1RzJoOGYvT3o4VWp4d1JJVUkzZTB5TEo0aWhuL0RmaHZEVEJvdEdoalZw?=
 =?utf-8?B?L2wzUS9YOFV6aDJELzd3SzdnZzROaWNUSUlhTUZsWlE1OFJ5dzhKUEhkeDZW?=
 =?utf-8?B?bDB6TUNoUnZKME5nR25DcGxSdFFOT082ZWR3YytoUmtXRzYwU2FTUkYwd3hD?=
 =?utf-8?B?aDJsU002RmhtNmhrUDFOcWxRc2dqODN6MEh6Yk9qelVoTWlZN3FQWkdoMkcw?=
 =?utf-8?B?WGlxa0JMWHFuTWsyV1FQNmpSUmRMV1pFZHlwOGowcExlTjQvODVrUllCUmJB?=
 =?utf-8?B?T3YzblRRTW9vdnVVUnBxbUVJakdHcHIwVVB3NzJYM1c5ZmlZR0lJR2k3YTZE?=
 =?utf-8?B?WDVxZlVDY1AvczJNVm83dlVVZkx5eVlldEdWRFdYUmFVaDA3cHA1NWhNZnVI?=
 =?utf-8?B?bktqL3lNSndKbHE0NlBReG45ZkRUQ2hqKzlNYmFrdU1kTFQvckw2UmxaaUFu?=
 =?utf-8?B?dEZMR05vbXZrL1J5ejBBY1B4RXNDS05kZ28xeCtSazFMNndTdWVuL1Rac1J1?=
 =?utf-8?B?eWcxMkoyMlY1cityUTJFSWUrQlUyNElVZVBaNGdLbFZmbkxDcS9WczJneDFG?=
 =?utf-8?B?RnpjYVdEWTl0VTF1U1FPWFZFM0JwTWN3bWdIMXkrcjFCM0VlN0EwV3R0Y3R4?=
 =?utf-8?B?Mm0wRWl5WG84VlZWbFNNMVcxZklyWHcrZWErWVoxcDZXeURiOHRyb1V4TjBh?=
 =?utf-8?B?Z1Y5QnNGVnYvaStiVTlYNFV3OE9aeTY5Q2l0cWRIWGJLKyttK0tHYll3cGdY?=
 =?utf-8?B?c0tMNjErMDdxY2lsSlpnTzQ3b244LzR3RjBGSCtBSUs1MFR1RjRCRkd4RTcr?=
 =?utf-8?B?MmFCK1NpNThybnJlalVvV2pUT0ZVd3ovVWRTQ3pTbTBtcmFpWHFha1gvb3Fl?=
 =?utf-8?B?cG9lNmVqVGtHUWNrOTFsN2l3OW5ETjFnVFRaRGlqMWRac3hIMzlVWXQ4RmFQ?=
 =?utf-8?B?R1l5WE0zKzgxVWRZZTVqMEFZY0t4K1FiODlwS3dEbDlKUW5KL1JObFAwSFBJ?=
 =?utf-8?B?aitqb1kzL3ZVdXIvOTE4QXR4Wi9qWHYzanFJRlpTYzI0WndVWVBFKzdjQWIw?=
 =?utf-8?B?S0Z6UGJXY1ltNkF4bEljWncwK3VaNkx2Y2NOZXhlQlJHSzRxeVF3YzRGZFN6?=
 =?utf-8?Q?elhFezxvLIJx3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di92a0FRalBQcUFCbC9EVENlK1Zwall3a0lCVjMxSEh2alUvSEYxd3dlVDQ3?=
 =?utf-8?B?ZzNMYnh0Slpva3JlNVV5dmFzUU5uaGVVWHRySEZtQlBNOWhUTlZFZk9vekVS?=
 =?utf-8?B?ZTZ1RThIWTI5RU5BV0h4c3M2RnFYNHJneFJtaHk4d2RVRGJoQVlCa0JJNlpJ?=
 =?utf-8?B?K0ZRckZFck8yWjVVcnpFdXF1Vm44V1Y2amthTUpkOWExT1VRYTRuYzcxVTBt?=
 =?utf-8?B?SDNJRXlrbWVKUEdHUVpjVi9SVnA2T2xobkNoNVVROGdjVW05dzZKR0RqbVpk?=
 =?utf-8?B?ZURmd29Gc0EvTDJ0d3hiTjZDcGlWcElObEQza2lSODhCUW5XYUN3cXlFbU8v?=
 =?utf-8?B?cElZUjRsTTFBdG9mT0ZHYmprTGNvYnVmV05hSUpTdzYwRG9uQUxNaW1IQUxG?=
 =?utf-8?B?Z1ZwWXNrVi9Fa3hNNi92NEI1cHRlZm5wT01NR3B2NUIyV3FsQm1jTjFnaklG?=
 =?utf-8?B?WDR0T2N3RXVtZTYyeE54cy9HdElNVHFKZnNzY01peUhYVTU1aDEzbmNxSkx2?=
 =?utf-8?B?cUxGbEhSa1pkY0RKSzU0ajBDVlkxbmJXUmIvYnhnbmtxVHFPcVRPdFVDUmJi?=
 =?utf-8?B?cDFid1RJSW1lQ1czZ0g4UThHODc3aEdLNjY5bHlMWGhLL1FyOWdEZVhEMk5P?=
 =?utf-8?B?MDREMDRtSmFrWmtESThJSTl3eVQvQk5scHpJK0VuZlArMSs2MG50S1NRZjR0?=
 =?utf-8?B?NWRrVC9mbDZEdmZ5ZHRONnFzQ0RXSkJURDROVDVTUDdnWXQ3eEhPWGw1WjhN?=
 =?utf-8?B?aE1YVkF4NFRKa014YnlMZUNadFFtRUJhN2JwRjZYQ1Nyb21uakVaUHgydVhr?=
 =?utf-8?B?bzRHR2tRV0NabmtRZit1dS94M1hGREphTFdiTVRzOTlyMmZrdnB4MU9RdHVQ?=
 =?utf-8?B?VXROOXkrWjJSa2xNOWc3Z1lNa2xHZkduazlld01nUGVRNGdKeksrMlJIc05G?=
 =?utf-8?B?NW03bTdGYTZtVloxRjU1dllRQ2pNa1FDMlZ5b2FKaGp3ekkwOWZRMm5hS3lP?=
 =?utf-8?B?Q3VwelhnbDJzSyt4djlrUGZXVE1HSWJnazNWQlNNczVPSGF3Y2RqZTdjLzE1?=
 =?utf-8?B?cXN2a3pXdWxSR1ZVQUZaZlV1WE0zSVBIQk44UjV6ZFc3bjBtY28vQVNmRTRM?=
 =?utf-8?B?MmdlTW0yTUthY25lRVBDVm9WL3dodHBBRXFPdHBuZ1Qwc2gvQXBkdlZQaW5R?=
 =?utf-8?B?VzZobXhHc3JlYVVtQno4bmo4YTZ5Wkl3eTNpeXJHdVFBRVY5Ty93bU1iQkcz?=
 =?utf-8?B?T2VhQkJWdHk4ME9mcStybnBKQnlXbmVkNk1TRGdjYVJDaWE4Q1FHdGF2SmhB?=
 =?utf-8?B?aDJrUnJ4dGsrWkxheWxBc1o1MSt5SWpXOVpKc0ZCV2JWdlFhejVJVGRNVExD?=
 =?utf-8?B?dHc1bkcyV2JMYzVBc0dpQmNFMGt5ZzNQRmlwZFAybVA1M1llQlJRRWZHbGRw?=
 =?utf-8?B?YnZ2cmQ1SXpOUjM3cDlNSm1FcEpDclQ2U2grK2xPT1NNbyt2a3daYTZaTWpE?=
 =?utf-8?B?bzl0aHdxVTBjOVZmUi9maXJJeTlGQ1FNbkV5OUlzRkErZmhLOGk2R2FHd0F2?=
 =?utf-8?B?OE9ZYnRaS09McnN3RFQ2ZVJ0bUVxc25Bb1hrbmlmbjdaNzI5N0Z0M3MrQXhB?=
 =?utf-8?B?NGxzbGpkOU5TZmtCRm84T20wZTVEbVF0QnJsQjhZZWFOR0hTWEdCeDlyWWlU?=
 =?utf-8?B?UGQyVC9QbmZ4ZktoREhvaFZaRVZ3WTdCZ0lIckFxdzBjY3c2MWt6cnBzRktY?=
 =?utf-8?B?eW1sazRXM3hpei84SW13VUZraHVzVGVKZUoxelF2dkhuaFhXbXlJQmZHQWEy?=
 =?utf-8?B?WVBzOFp5eWpOelBDT21rUUsvSmxKaDl1OWlsbVJnNlR5Yk4xL0M5MURtb1da?=
 =?utf-8?B?aGJENGduL2MwOWFKc3dPWUpEQVVaSGg1aWgyRUZsZTRlN2gvZk9jejhhbzRI?=
 =?utf-8?B?N013cVc4bGIrUmxWbEpCQXZyVFExSlJYdjJnbjJ4UTZEdGI4LzNuTGVwR3Nw?=
 =?utf-8?B?VmdTTlVlSVhicnNqdEZtQWsxTUxMMVJHWTVSMHJrbTFGc2c0ODJZcG9zWWVC?=
 =?utf-8?B?M0srb1dDMVFJNHY2L2pIa3dTTzNZaExVa3BQM3YwOVo5MkJFSXc0a3g2KzYy?=
 =?utf-8?Q?PfIzc/enfi24bIn0PdhUERpXs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f941d5-02cf-44f0-ca72-08dd75e00f83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:25:35.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q07uor8JMauAGYNiVEm6nCyO7JxftZWsmNRRB/5tOtydOAyzwQ9+97bhi+wPR+5S1S4laM1TY8znnXhYXjQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047



On 4/4/2025 12:04 PM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:17 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> During CXL device cleanup the CXL PCIe Port device interrupts may remain
>> enabled. This can potentialy allow unnecessary interrupt processing on
>> behalf of the CXL errors while the device is destroyed.
>>
>> Disable CXL protocol errors by setting the CXL devices' AER mask register.
>>
>> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
>>
>> Next, introduce cxl_disable_prot_errors() to call pci_aer_mask_internal_errors().
>> Register cxl_disable_prot_errors() to run at CXL device cleanup.
>> Register for CXL Root Ports, CXL Downstream Ports, CXL Upstream Ports, and
>> CXL Endpoints.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> A few small comments in here.  I haven't looked through all the rest of the series
> as out of time today but this one caught my eye.
>>  
>> @@ -223,7 +238,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>>  	struct device *cxlmd_dev __free(put_device) = &cxlmd->dev;
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  
>> -	if (!dport || !dev_is_pci(dport->dport_dev)) {
>> +	if (!dport || !dev_is_pci(dport->dport_dev) || !dev_is_pci(cxlds->dev)) {
>>  		dev_err(&port->dev, "CXL port topology not found\n");
>>  		return;
>>  	}
>> @@ -232,6 +247,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>>  
>>  	cxl_assign_error_handlers(cxlmd_dev, &cxl_ep_error_handlers);
>>  	cxl_enable_prot_errors(cxlds->dev);
>> +	devm_add_action_or_reset(cxlds->dev, cxl_disable_prot_errors, cxlds->dev);
> This can fail (at least in theory).  Should at least scream that oddly we've
> disabled error handling interrupts if it is hard to return anything cleanly.
>
> Same for all the other cases.

Ok. I will add a dev_err() for errors returned by devm_add_action_or_reset().
>>  }
>>  
>>  #else
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index d3068f5cc767..d1ef0c676ff8 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -977,6 +977,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>  
>> +/**
>> + * pci_aer_mask_internal_errors - mask internal errors
>> + * @dev: pointer to the pcie_dev data structure
>> + *
>> + * Masks internal errors in the Uncorrectable and Correctable Error
>> + * Mask registers.
>> + *
>> + * Note: AER must be enabled and supported by the device which must be
>> + * checked in advance, e.g. with pcie_aer_is_native().
>> + */
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +	u32 mask;
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>> +	mask |= PCI_ERR_UNC_INTN;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>> +
> It does an extra clear we don't need, but....
> 	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> 				       0, PCI_ERR_UNC_INTN);
>
> 	is at very least shorter than the above 3 lines.
Doing so will overwrite the existing mask. CXL normally only uses AER UIE/CIE but if the device
happens to lose alternate training and no longer identifies as a CXL device than this mask
value would be critical for reporting PCI AER errors and would need UCE/CE enabled (other
than UIE/CIE).

-Terry

>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>> +	mask |= PCI_ERR_COR_INTERNAL;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
>> +
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>>  	/*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index a65fe324fad2..f0c84db466e5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -101,5 +101,6 @@ int cper_severity_to_aer(int cper_severity);
>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>  		       int severity, struct aer_capability_regs *aer_regs);
>>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>>  #endif //_AER_H_
>>  


