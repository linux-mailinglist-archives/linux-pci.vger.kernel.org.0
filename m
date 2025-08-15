Return-Path: <linux-pci+bounces-34089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85DB27605
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 04:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2E416A9B7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C711294A10;
	Fri, 15 Aug 2025 02:31:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B2EEA6;
	Fri, 15 Aug 2025 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225106; cv=fail; b=cC38UbJqr8LV6xzvXG8K/zUSJ7LCO+csV+JlEnjxitUp2oPCiHo0n0LGQzOAXT/DJ+mMuwjdfscjb+POqBX9H2yDVnZTuRDUb2Ma6qUYWP+eDK3DReZXjgxw963kje2xBuh67D+0UvTKzBLURMz+2AWbWUTYAcby8iZSHxoho+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225106; c=relaxed/simple;
	bh=GmZ1fX0cAroEqg4VGiJ9ifOXW6yW0eLzs3nFG7l667I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsobniyCB1fdkQsJWtHqkfxRR2UaSSvL7+2dIydNGxfst1UjYAq9DYzkLVnxUecGMQrnNKdEPCa2kvaoFRPjoDl8hblnwl2BIFECj9t1mXGF4u6BH5tVqFQtzJKGryzU+iRlHnqKdn37yyFZ0X7n2CmpC0aENTTzKbrniPLhyo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F1XBks3539768;
	Fri, 15 Aug 2025 02:31:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48ggw0tks2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 02:31:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9DVbpnyajlj0EmPBKiDl0VrWtgOc9FH6H7iuesTJEOfre4Qn4ENyQhSxkuV9Dvd3gGrF3YE6FgET18meE2DZxQSECD8xWJAApr/FAike8IwNsA0XMy5NK3LYFBXufsuv1FIeXC2JLgPuFIznhldFEq8Z1r7+iZH5y7/ORhOKqVs52GoMjIVi1+r63f4hUaQQzgd+l30iXbj+JkYb+fmRijSEf340nCM6diLtKuHTf7YzFO/VxClKnYpr65cIGOKxrhmu7Ce3PPGoyu5aiQP380/GqZ/gi6lg/EMZtIrd1eHV+v5Va9ih2o2+W7lLHCKqWThjr/aUDoOaQQJh8j1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmZ1fX0cAroEqg4VGiJ9ifOXW6yW0eLzs3nFG7l667I=;
 b=nahX3oqOq+6VDUj9LY//SSR4/5bgD/L+E5tl1zfDwi6BgyovaWCgeJyhsE6KbWGleGNI/o2ExU5eni5xZCLS8T/lJlR+UXXp8zE3FD+NvXX8OKaWwdTgxgjr/q8/4d7J7MDUYVn67TdGGU4pYpkkyhxusrLlZtVorVNFRUo16W+ew1wnDxEIWukeNwt+IaibJli2mTY98nKJoMiIST8MSh0bg+nB8KyoghN9jTmyGGE8f5bT96op3AatNT/5rkvq4TJqxAHJ10wQQnBCBf5UjJOZgHTT5greXrZHNu0nikBr3PGNQSsgebhz1JGGAjIKJkhNuLDIja60FwPlWMt0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD24E991EC.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::52) by SJ5PPFC15A51B16.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::851) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:31:32 +0000
Received: from DS4PPFD24E991EC.namprd11.prod.outlook.com
 ([fe80::1b9f:260e:5332:3a03]) by DS4PPFD24E991EC.namprd11.prod.outlook.com
 ([fe80::1b9f:260e:5332:3a03%8]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:31:32 +0000
From: "He, Rui" <Rui.He@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Chikhalkar, Prashant"
	<Prashant.Chikhalkar@windriver.com>,
        "Xiao, Jiguang"
	<Jiguang.Xiao@windriver.com>
Subject: RE: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Thread-Topic: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Thread-Index: AQHcDP9f25lxQMSLe0e0vbFoJx8HyLRinCYAgABUX6A=
Date: Fri, 15 Aug 2025 02:31:31 +0000
Message-ID:
 <DS4PPFD24E991EC6BCD98A674667D0D7AB39634A@DS4PPFD24E991EC.namprd11.prod.outlook.com>
References: <20250814093937.2372441-1-rui.he@windriver.com>
 <20250814203612.GA346111@bhelgaas>
In-Reply-To: <20250814203612.GA346111@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=b7f69c0e-f5f8-4163-be0e-68f864b1f358;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-15T01:38:10Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFD24E991EC:EE_|SJ5PPFC15A51B16:EE_
x-ms-office365-filtering-correlation-id: 412110c9-b813-4891-3944-08dddba3d8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|42112799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dytraGRmTUs4cHpreGw5SVBmNGFieVdsYitiUG96cUxpTi9qVWllcjhxbkJN?=
 =?gb2312?B?STNLSytlRk40ZGRRYjhqUkZ0am4yODJjc2FMRCtHS24vMGp0bFVZTW9aenZi?=
 =?gb2312?B?cHp0WmlhZ2N1UHVCM2RVMTI0WEdHTktvYkxiN2VxTSs4Szk4MVFIRG1SaDYz?=
 =?gb2312?B?dkhZc2VXdU9HVGdLTEZLS2xxelE4QTFwTE02MEFzQ25ndzFMVGkzKzRqc0Mr?=
 =?gb2312?B?MnRsTjNLWHNpK3Y4cm81WlRQdFR0dTlCM3hLOXprQnBKTDRKZG9UZGJWSlZt?=
 =?gb2312?B?bHFDQy9JL2puaS9oR1J0azFGZVNPN1JtSzh1cDJYYlJIRUZBT2MzZ0pQdnhh?=
 =?gb2312?B?c2p6anhJSlZ5cDZFZk1aRTdoMDdaT0NVQ21Qd05mbHNsemtxZGpxR202eFRp?=
 =?gb2312?B?NjBVUVp5em0vemJMVzJ3RW5EVURMZUlQSTNjM1RObDJYOHU2dFhPbGdBc0hi?=
 =?gb2312?B?eEpjUG1NVmE5UUQwSXp6T1VHdzRQYURGcTlKT2dsRHFGdEIvUGZSOHZQNVVn?=
 =?gb2312?B?azN6OWx6RTRLTTl2TkxIRjJrRTNzbGY3UHFGSElnbVMrQUhxWXg4NjAvRjI1?=
 =?gb2312?B?SytBa3hZTEZsRTNnemtRRURpenMzdFFQQjJYcjlha09zQTRJRjFpMUVnSzYx?=
 =?gb2312?B?dENiY2JhemJuVzF4T0lHYmU2SmxoZVJvZ1JKZUtPQ1hwbkRpMkdGN0tCTi9z?=
 =?gb2312?B?M1BzSEhTUzlpWnpHRU9GSUNjZDcvZjFwR290SnBwS3dub0hMeGJHR2V1Wmds?=
 =?gb2312?B?ZFRDSE5lcXZjZ2d1NDlQdTg1dVhmeE5XUXRMVGkyakJDV05NS3FpK0E0cGFh?=
 =?gb2312?B?YURnaW80NEVGajhWbVkvdERjQW9Eb1RKU0szejB5Tnp4aGZxbEw3R015Y3Y4?=
 =?gb2312?B?bW5udzFXbUNWNDBEN1phZEJoaVRVcE5iR1dVb3oyK1RPckltR1dUQ0xmbGxC?=
 =?gb2312?B?VFhtZmxYTWV5VFIweG1HRVY4ajQzczRldXZTVVEva3FseVRQOE9aNlovOTBs?=
 =?gb2312?B?MmorSWNpSUpVcFY0RHRqVW1OVDZiRjl4UmhTcitrSnlTMDhQa1BobTM1ZnR2?=
 =?gb2312?B?OE92bzc1RUlmbGl3YmJSUU1adFU0MmxZV3JTQnlJY0xHVWNPUHd3Yk9sSVd4?=
 =?gb2312?B?cEdVOGxGZ3RjWTUxQXJOWkxMTi9TMTA2UWxDWDliSDJhWnRqL3FwMGtZVkxI?=
 =?gb2312?B?NjlkdVRFcEtoSERtRmhZMzRCU0VmQnlWVGR2MERQSENKcml4ZHlYY0VwT1ZW?=
 =?gb2312?B?dnZhWno3aDJQZWRoZmQrdzJLU01PWHJOSGRPSEJvb3d1eVQrYk5GcDVJR0JK?=
 =?gb2312?B?bjNUVDMyVnIwckxrMHhjR1JHWVAxbndDbWtGclBsTXB1SjhkZGpYVmVsYkNl?=
 =?gb2312?B?SFczUkNWZ1Yyd2RWVDliaEp6amQvRjRyRVI3Uk9BRWFNZ0NaSU1CYlBva1Zp?=
 =?gb2312?B?QW94Rm1qRzJTZzZWa1F4UlRvQlJUV2FyYktzMmptZzVzZVJ6RlVjRW4xaGZX?=
 =?gb2312?B?QW5BUDlzcHFDazZkMnFMZm94NTVNbUNteHcybFNnUis5V3FTSEl6WjFXRGNP?=
 =?gb2312?B?Y0tWL291SGU0a2xKaDRudDUwKzYzZ1lNRDI0RUFhUmdmQy9tV1ZwS2c3UFVR?=
 =?gb2312?B?M2lPakxiVi9EOEc2b0FrZDArK2FWWWJhQVRmeDZucDlqME1wR2hGMzFWUmg2?=
 =?gb2312?B?cGFBR1ZJWE12VHppVC94bmxTMjBaVW8rTWVDZE40N0lMRWZueGJlSDN6UXRp?=
 =?gb2312?B?SGpMVTUvRStUK0laM0d1YkUyQjBPRTZiNm1tZWRDUkdpRW14TzVkQm1xL09U?=
 =?gb2312?B?ZjNwRmVISjZLSkJ1aWlHY0c4b09DNUk4dG5pY21YWUJSeHEzejVkWVBIUlRO?=
 =?gb2312?B?RE9UVG05TjdNME91ZzZyZzhsSW9VRmttUE1CdnRtd0JWVkJiNURCdVo1ZmFR?=
 =?gb2312?B?RERJMGNEQTF2WndNT2hpcW13a29JM1doTk5mVWtnR3V3NXl0RnM1WXNya2tH?=
 =?gb2312?Q?X69UMNdh/SolE4ZUoFXHiQspV4p04s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD24E991EC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NjBWdXl1aCtXVk1pOGN2dTNHUFFucjZxMTkwZ3JkKzRHYlp6UHRyK005T2t3?=
 =?gb2312?B?aS9NZExsNFhkZXF0VGszNERVSENUcXBhN2ZjNjErTjVQbjJMbXpGRG9VSWlT?=
 =?gb2312?B?bXlRSzY4YVo0Zk9qb21nU2QwWWJKS3ZoN3EwOGdBU1JFY21VWTZNR1RZc25r?=
 =?gb2312?B?aWNqdWZnaGthdnRkeTM4a0Jxb2lwTGRkZmxjV1FGV2VZdHlQS2ZEUDBhZUtj?=
 =?gb2312?B?cVNMWlRzWXFQdTJ2ZElpazNCaHlWSUJScm96bTdGa3FFYXIyNXZ3cmowU0Zi?=
 =?gb2312?B?cVkxVzVJb3hlaXZZSGUwT0g3amk5S2J2V1J1eUI4ZmtnMVk2SEFuSDF2b0hB?=
 =?gb2312?B?VExjM1k5cjJIZ213Vk1EbzkzUllKWE9aUFl2TEVlaEI5bDg5VzFRZk9QbEp6?=
 =?gb2312?B?L004dEZUNXZwYWZxcDZ3Ui9kVmJFd1NrbUZVcEhLcy9NcDMzck5rajNIUVBv?=
 =?gb2312?B?NjJJV1k1ZHp2TTRxSXMwMmdmajM1QmJ0dDNBVTBEOFRubERxQW8wVHNOb2Qy?=
 =?gb2312?B?UEVUZzBvSnVsNXdCWG43U1NybGFOWWpmMzBpUzBPUVFKTjBRMWhSazZDZmV0?=
 =?gb2312?B?b0RROW9UZmVLVVlXM2hLLzllQUZrdTZkS1dsbWk4YmNYcHdyM0lvZjNlSU96?=
 =?gb2312?B?VjdWQ2ZyRlJib2FJNVZaVFZPZ3dVMWxTMWFRNm5CZTIwbC91UEdWMEh5L1Ir?=
 =?gb2312?B?NDh6SUpBdURVKzVUTGREeG5HVHRybW9RenNMaVhKZVdBbVY5aTZaVllwSnov?=
 =?gb2312?B?UEZpQVRuazhWb2g5MlE5TkFOSnV6cWZRZVdhR1N2SDl4K09ZeDJSeURhOS8v?=
 =?gb2312?B?dkJaRXhUTzZ3c041QkRCZmh6YnVYbW5DN3ZDaE9lWkF1MzhreWpCTjZFVGhv?=
 =?gb2312?B?cWgvZWd4UEFXTlBsYW1Xbm13eG9aUUFrNnBlSjBsdkovNmRZdHZUeXNDeUpT?=
 =?gb2312?B?cFRCb3kvSTZFUFpLWHdNdzUxQm42bHYwTzVBRUZaYkZxZlN0cStDTzM1WnRI?=
 =?gb2312?B?em05YzlIbURXMktuYXprZzA0YTNjZkduTk9EUTZXNURaVTJxaGN4WFQ4NVND?=
 =?gb2312?B?YjlYQ1VVbWdhQVZkLzFCcWNIYzY0QnowRS9SL0JkQjc4eHpuWTJZVWVNUnFk?=
 =?gb2312?B?RWJYYnRvUDFnOExwL1BIS2hpUWdtMko3YXAwRmZvM1hGUlVpaWxTMUdleCtx?=
 =?gb2312?B?TVlYRlVMNFczRWlaNHdEV2F1dTBRVDBBUjdUVzEzOUsxakdCNnI1UFBVcHdT?=
 =?gb2312?B?a3Y2aytWcUdSUjBTVFE3VjJlR3dMN3V6OFRuK2c3MnpvTnBraG9QbHdqRzNE?=
 =?gb2312?B?VnNSSUpkT3dqSlZRbVR6WU9hT01JdiswOFFNQlpEcGc1aHFxdzMxb0o2L3Z4?=
 =?gb2312?B?TlZ3M2VONWVDQ3ZEblY4SlZZMW9vSUpBTmtxUHdabVFwUks5V3VGWWJBS3ll?=
 =?gb2312?B?ZGp6MTFNV2wzMmhuUHZNWU9YWVVOUmJqWTRmTHlIRGVJNUtnc2NYSjE3ZHhJ?=
 =?gb2312?B?Qk9UMko0ZzRZYU9KK1VDRFhWNVVmNGE2ZWxZWUZjbkZqbCt1T0tFSUVyazNt?=
 =?gb2312?B?WjhRcG8yWmp3V2xCeWZBRnhnVThYTXBWczloRTVxOWhUWjd6UGlQSFpjTEhk?=
 =?gb2312?B?VEQvRkZQK093Z3ZSRDYyUmVVUTJmbmtJUDBBYlREZkZnTWlyZmIxMDJrZWIv?=
 =?gb2312?B?QmlBNVdVYnZSMHRmNkZhSFFyNzBWYzhURU5UaG5uTGUrWGpYU1FIWGlLVUlE?=
 =?gb2312?B?ZUVUa3gvVWo5UGwxMmxpNUo5WncybDFWVDJ4QlRsMVh3aDZoOGxRV2t5Um1v?=
 =?gb2312?B?SXVackZyU20xdW44M1A2NHFrNjBlWVFpYXZ3S0tJRHVUekFNZGkyQVJMZG1C?=
 =?gb2312?B?MDN6T3NjRkU0NmNkRlpMV2h0K1ZuSk1lN29vTWVBOXAwQk5MNFhYakZwcllq?=
 =?gb2312?B?bk5McmZVcTdlTU1MQm1Gc0JNQU9HOHpjMzVSZUNlOVhDc1hEaExMeDN5V1ZM?=
 =?gb2312?B?Qm9hTDZKa21odDMySlkweGlTSWlkbllEVC9tUDFxdXhZTmhiWVcxTnZqbnVo?=
 =?gb2312?B?TDhUbGd5T1c5cC9BcWR1SlFBVG1KT0ZsOHVaN0pWcTdVRkhRTk4wT1VGRHZQ?=
 =?gb2312?Q?P0V013bRYDfhdx3dah+uF+bXJ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD24E991EC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412110c9-b813-4891-3944-08dddba3d8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 02:31:32.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBBFKHuGesQ7VEp/wOY63QbyNa2MqZXlZ1UN2Q84pW6m1VqsOGBfqCxj19xziPcixAUJbm+sjUQUKSoC7bGm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC15A51B16
X-Proofpoint-GUID: u_J7MXmwmXZTDPxaX6IFqWUlSJwLl2KM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDAxOSBTYWx0ZWRfX5cv19jyz2AXy
 EFyQUXPQyfnk/nZwIDFM6Qn9QYZP1qPSlKCMZW3tyOlMcuRBGY9UtJgrK5RAXKs88xbQyRgreQM
 srd69CaSbKyNpY07n//mP04i6NdAJHU1V1brU6Yl/2xYwt2YDkmcavfeXhWR0mL+SKj1y5t2kJX
 Puf73Sn6BnfbMv+ViB1PPo0L7Tftv94YIDLGPMNp8PWS4rlBUd0WV5GwgbUy1F6rExc/jpVdFRw
 pUltSs2Ap8SB2wuAmbJMc08Jv5MwCC1Znaur+L/H44vbQVyoofi7c3mAwSYEWKhtA9f6x2J8TsV
 gh29DQGSXelFf8RXmCpGXiDhVWGSuSyq6HOLUOvP8xSv7zWsZ/CVMSiVcSfc+Y=
X-Authority-Analysis: v=2.4 cv=fN453Yae c=1 sm=1 tr=0 ts=689e9c09 cx=c_pps
 a=u5dsIULuETbLzBEmpZKeDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=1XWaLZrsAAAA:8
 a=7XtudCS_05bs0Wgd1IUA:9 a=mFyHDrcPJccA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: u_J7MXmwmXZTDPxaX6IFqWUlSJwLl2KM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8
aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI1xOo41MIxNcjVIDQ6MzYNCj4gVG86IEhl
LCBSdWkgPFJ1aS5IZUB3aW5kcml2ZXIuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IENoaWtoYWxrYXIsIFByYXNoYW50DQo+IDxQcmFzaGFudC5DaGlr
aGFsa2FyQHdpbmRyaXZlci5jb20+OyBYaWFvLCBKaWd1YW5nDQo+IDxKaWd1YW5nLlhpYW9Ad2lu
ZHJpdmVyLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIHBjaTogQWRkIHN1Ym9yZGlu
YXRlIGNoZWNrIGJlZm9yZQ0KPiBwY2lfYWRkX25ld19idXMoKQ0KPiANCj4gQ0FVVElPTjogVGhp
cyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gT24gVGh1
LCBBdWcgMTQsIDIwMjUgYXQgMDU6Mzk6MzdQTSArMDgwMCwgUnVpIEhlIHdyb3RlOg0KPiA+IEZv
ciBwcmVjb25maWd1cmVkIFBDSSBicmlkZ2UsIGNoaWxkIGJ1cyBjcmVhdGVkIG9uIHRoZSBmaXJz
dCBzY2FuLg0KPiA+IFdoaWxlIGZvciBzb21lIHJlYXNvbnMoZS5nIHJlZ2lzdGVyIG11dGF0aW9u
KSwgdGhlIHNlY29uZGFyeSwgYW5kDQo+ID4gc3Vib3JkaWFudGUgcmVnaXN0ZXIgcmVzZXQgdG8g
MCBvbiB0aGUgc2Vjb25kIHNjYW4sIHdoaWNoIGNhdXNlZCB0bw0KPiA+IGNyZWF0ZSBQQ0kgYnVz
IHR3aWNlIGZvciB0aGUgc2FtZSBQQ0kgZGV2aWNlLg0KPiANCj4gSSBkb24ndCBxdWl0ZSBmb2xs
b3cgdGhpcy4gIERvIHlvdSBtZWFuIHNvbWV0aGluZyBpcyBjaGFuZ2luZyB0aGUgYnJpZGdlDQo+
IGNvbmZpZ3VyYXRpb24gYmV0d2VlbiB0aGUgZmlyc3QgYW5kIHNlY29uZCBzY2Fucz8NCg0KSSdt
IG5vdCBzdXJlIHdoYXQgY2hhbmdlZCB0aGUgYnJpZGdlIGNvbmZpZ3VyYXRpb24sIGJ1dCB0aGUg
c2Vjb25kYXJ5IGFuZCANCnN1Ym9yZGluYXRlIGlzIGluZGVlZCAwIG9uIHRoZSBzZWNvbmQgc2Nh
biBhcyBbYnVzIDBlLTEwXSBjcmVhdGVkIGZvciAwMDAwOjBiOjAxLjAuDQoNCkluIG15IG9waW5p
b24sIGl0IG1pZ2h0IGJlIGFuIGludmFsaWQgY29tbXVuaWNhdGlvbiBvciByZWdpc3RlciBtdXRh
dGlvbiBpbiBQQ0kgYnJpZGdlLg0KDQo+IA0KPiA+IEZvbGxvd2luZyBpcyB0aGUgcmVsYXRlZCBs
b2c6DQo+ID4gW1dlZCBNYXkgMjggMjA6Mzg6MzYgQ1NUIDIwMjVdIHBjaSAwMDAwOjBiOjAxLjA6
IFBDSSBicmlkZ2UgdG8gW2J1cw0KPiA+IDBkXSBbV2VkIE1heSAyOCAyMDozODozNiBDU1QgMjAy
NV0gcGNpIDAwMDA6MGI6MDUuMDogYnJpZGdlDQo+ID4gY29uZmlndXJhdGlvbiBpbnZhbGlkIChb
YnVzIDAwLTAwXSksIHJlY29uZmlndXJpbmcgW1dlZCBNYXkgMjgNCj4gPiAyMDozODozNiBDU1Qg
MjAyNV0gcGNpIDAwMDA6MGI6MDEuMDogUENJIGJyaWRnZSB0byBbYnVzIDBlLTEwXSBbV2VkDQo+
ID4gTWF5IDI4IDIwOjM4OjM2IENTVCAyMDI1XSBwY2kgMDAwMDowYjowNS4wOiBQQ0kgYnJpZGdl
IHRvIFtidXMgMGYtMTBdDQo+IA0KPiBEcm9wIHRoZSB0aW1lc3RhbXBzIChzaW5jZSB0aGV5IGRv
bid0IGNvbnRyaWJ1dGUgdG8gdW5kZXJzdGFuZGluZyB0aGUNCj4gcHJvYmxlbSkgYW5kIGluZGVu
dCB0aGUgbG9ncyBhIGNvdXBsZSBzcGFjZXMuDQo+IA0KDQpPSw0KDQo+ID4gSGVyZSBQQ0kgZGV2
aWNlIDAwMDowYjowMS4wIGFzc2lnZW5kIHRvIGJ1cyAwZCBhbmQgMGUuDQo+IA0KPiBJdCBsb29r
cyBsaWtlIHRoZSBbYnVzIDBmLTEwXSByYW5nZSBpcyBhc3NpZ25lZCB0byBib3RoIGJyaWRnZXMN
Cj4gKDBiOjAxLjAgYW5kIDBiOjA1LjApLCB3aGljaCB3b3VsZCBkZWZpbml0ZWx5IGJlIGEgcHJv
YmxlbS4NCj4gDQo+IEknbSBzdXJwcmlzZWQgdGhhdCB3ZSBoYXZlbid0IHRyaXBwZWQgb3ZlciB0
aGlzIGJlZm9yZSwgYW5kIEknbSBjdXJpb3VzIGFib3V0DQo+IGhvdyB3ZSBnb3QgaGVyZS4gIENh
biB5b3Ugc2V0IENPTkZJR19EWU5BTUlDX0RFQlVHPXksIGJvb3Qgd2l0aCB0aGUNCj4gZHluZGJn
PSJmaWxlIGRyaXZlcnMvcGNpLyogK3AiIGtlcm5lbCBwYXJhbWV0ZXIsIGFuZCBjb2xsZWN0IHRo
ZSBjb21wbGV0ZQ0KPiBkbWVzZyBsb2c/DQo+DQoNClNvcnJ5LCBhcyB0aGlzIGlzIGEgaW5kaXZp
ZHVhbCBpc3N1ZSwgYW5kIGNhbm5vdCBiZSByZXByb2R1Y2VkLCBJIGNhbm5vdCBvZmZlciBtb3Jl
IGRldGFpbGVkIGxvZ3MuDQoNCj4gPiBUaGlzIHBhdGNoIGNoZWNrcyBpZiBjaGlsZCBQQ0kgYnVz
IGhhcyBiZWVuIGNyZWF0ZWQgb24gdGhlIHNlY29uZCBzY2FuDQo+ID4gb2YgYnJpZGdlLiBJZiB5
ZXMsIHJldHVybiBkaXJlY3RseSBpbnN0ZWFkIG9mIGNyZWF0ZSBhIG5ldyBvbmUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSdWkgSGUgPHJ1aS5oZUB3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMg
Yi9kcml2ZXJzL3BjaS9wcm9iZS5jIGluZGV4DQo+ID4gZjQxMTI4ZjkxY2E3Ni4uZWM2N2FkYmYz
MTczOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ID4gKysrIGIvZHJp
dmVycy9wY2kvcHJvYmUuYw0KPiA+IEBAIC0xNDQ0LDYgKzE0NDQsOSBAQCBzdGF0aWMgaW50IHBj
aV9zY2FuX2JyaWRnZV9leHRlbmQoc3RydWN0IHBjaV9idXMNCj4gKmJ1cywgc3RydWN0IHBjaV9k
ZXYgKmRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gICAgICAg
ICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgICAgICAgIGlmKHBjaV9oYXNfc3Vib3JkaW5hdGUo
ZGV2KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+IA0KPiBGb2xsb3cg
dGhlIGNvZGluZyBzdHlsZSwgaS5lLiwgYWRkIGEgc3BhY2UgaW4gImlmIChwY2lfLi4uIg0KDQpX
aWxsIGJlIGNoYW5nZWQgaW4gdjIuDQoNCj4gDQo+ID4gICAgICAgICAgICAgICAvKiBDbGVhciBl
cnJvcnMgKi8NCj4gPiAgICAgICAgICAgICAgIHBjaV93cml0ZV9jb25maWdfd29yZChkZXYsIFBD
SV9TVEFUVVMsIDB4ZmZmZik7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

