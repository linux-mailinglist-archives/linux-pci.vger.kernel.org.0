Return-Path: <linux-pci+bounces-21725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F9A39B06
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04941189510B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965D236A61;
	Tue, 18 Feb 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LZ5w4Xj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780E23ED76
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878305; cv=fail; b=I4wq6O1zYl+grrXlGUgiwwf8na9a1EMLqw5o4PGYl7XJaqn8/g46NuLfSzWeCp2SSDfp1zKHuJTeWUFrEEZcRWNGzR+zQGexMy3np6MB0/Mh13t2aCxvo6GYx7KJMpxK+V9ZA6dkuKsWJ97rkjH+Fa3siHh1vsz6wMmy58zwpg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878305; c=relaxed/simple;
	bh=j7VJ6TpLAzEQrl3ojjv0kI9MtHpflAYkVPFzJFrXReo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GwrHXa6/K6135Ctrl7lFS9xAY5BJaQRWlKFugnDZp+NFXNFWYbZtCweTPyYwr+hRfw975FGgBTTY8n5oJcJ1g8INQgstzfksf6/aY9pI2WHc5ezaEGROj7SCaH8Ty09ECEp62Vb+LiBEESR1UKITc/bD7VaijFrcp4FlHWGk8DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LZ5w4Xj2; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etYrswF2Q2UEfPBLluBBheMyekNr9MZ31V+LHOFbr2Hr6bRjCCsfWWK0QM50fOcmChTUPdBdIg8oLGIWKmk7n7XmuX/VSs/JbfnBC9Aox4ty+xF8LKA5JiPnL3p7S2SXfqzyETk1goALdqqzHZLTZc5b5pZdtxvFsz4nZLO2nOQn36os9d7y3IoplnU/JbMMsuKMzbgI7LKJQxndxKYZh6ccmpWTPXG6SIRyWgHo4Ewsma8XXKzt27cjZ/OyNvuZcbySP4PPYVcN1LzRDQbFuVVLUA9ZkgrL+32JZZzq9fvt56us6+QANnA/SJNjCWOJXhnWMpzL9VrbOQbRWYVAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7VJ6TpLAzEQrl3ojjv0kI9MtHpflAYkVPFzJFrXReo=;
 b=lZyz+ndOoaLdm1g1dlokgKEV7ncBLJAE2Tz8QyqaSxgxGbJgvq0RkwhhC9azrdLZ/dX1OR8KG2eCtG13hOSLxHwWFT8UB1OCi48fdRWCORxV/gBCIycSblVuDTPfAgO6Z+7p2WEm7lIp4hxmGMk3ebB/Kgju+hNurM5QKWI+U5M7O+UJ9GPaYDNF79q3m5su0W5sCU4b0HoqXh14bBvH578x2eGeBeNzl8EeWR6I6ohZbWg9OaGZJR37R3Lsyv22grYfm+nApYRU/izxZunAED+WTGGUjTdiLaEBYHLjcyHQ4BiwTboOyX8M9Pyi/TcmxCHcPPXL3OFTJsaz/Z7lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7VJ6TpLAzEQrl3ojjv0kI9MtHpflAYkVPFzJFrXReo=;
 b=LZ5w4Xj242APo3qvoR7u//7lbulcyPJG/vkC+U+QYJ1Ie8sRzhsBeDccY55ZemhvJ3nwOiiY/8pHJAFtbbLTbKB7W0mk8Ka5JGx2G4qAjqd15ygcI1/jwTOgs4dGT72N/aZKG9D8WNMQ5bSpz/GMdMw8Lt9j6T62gZhmjEM2lyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 11:31:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 11:31:38 +0000
Message-ID: <5093abf4-27d5-48fb-8668-c59f56a76ad3@amd.com>
Date: Tue, 18 Feb 2025 12:31:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
 <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
 <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
 <97e803f4-f00e-4fb0-8ed8-714ea9960e5a@gmail.com>
 <e098c309-e89b-4135-b5f1-dc8629445bc7@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e098c309-e89b-4135-b5f1-dc8629445bc7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3ad9c6-014e-4c2c-c10e-08dd500fcf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZhbEt3dlo3cWpsaGJOQWJhMXNiUmRQN21MQk1uOFFWK3BCeHZGQTd1Sis3?=
 =?utf-8?B?NklUT0NJWXBlUGY1WFJNZHZRQUFRNFV6d29OM1p6aGk0Qk5ROEM3T0pFc0hD?=
 =?utf-8?B?TGFDRW9tZWdmLzl0eUdoMzh3c080c3BWR3NKMVpTMzYyWnRuU1ZCUUptNE1l?=
 =?utf-8?B?Y0h2c2FtSC9Idk5GazNuc25OUFhTUkQzY2E3eEFzYXVzR0N6QkMxd0ZXYWtz?=
 =?utf-8?B?TmcreUxwTFNYZzV0NmhLRUFDRlc3bnp3dlFlU29DNmxRdWNYLzFxT01EUzJh?=
 =?utf-8?B?ZnBPQmtBK2l5L0JkbVQ3bSt6UnFNSitkbklKMlVIbEpJeWtBU1BPamFtWFBQ?=
 =?utf-8?B?ekY1enFZSTd0Zm5MZmFGYjQ2RmhuRlhQWmFaNlJPMml0UXF0SERGVGMzc2hL?=
 =?utf-8?B?dlpVSVZmTUVHRTA3QkJBZW4zMmZCcFd1clVsTTMzdEt0WjNBYVorRkY1eExv?=
 =?utf-8?B?Q0pseVJja0hOUDF1cHYwMTI5RGphQ3NEeUVGY3hxUExWZTVCang3MzR6a1hz?=
 =?utf-8?B?Z3lsaDFPYXdtTzBvOWRKazRsUEtSTzcxOHAwbko1cGU3SkFtMkZyNmQvM255?=
 =?utf-8?B?OUEwSFkxU0FiZVZEVUZCT0pBREx6VHA5Qm1iVjRzR29MRitWd1VGUTZFUVRa?=
 =?utf-8?B?QlVwN0F6ZmI5ZTZkY1hiRVV3L09yQm9NdERNUkNZdlNQRnlDcGEwU05FaHpo?=
 =?utf-8?B?bmZweExNSy9wak4wSHAvV3FGU0p0MWNUdDlQSnAwWXR6V2Z3K2dyb2R1WG1w?=
 =?utf-8?B?bEtFcy92QkN2R3gvT2d3enBsd1d5cmJpY0VTK1RmOTg3NXNEN1M3WEhQdFdW?=
 =?utf-8?B?OVdoRWlWVWZRZVczYnh4NEx5MVBuSHJ6dlE1TnFPUEZDZng2SUpuT3NiY0Zo?=
 =?utf-8?B?eGhIWGNkUGc1NGI4MStYTlZXL1JQb0ZidkpoV2dUTGxuMnBURWY2WERaMnRr?=
 =?utf-8?B?Y0JmNHNQUTVsMG04bzc2VWI2V012SExNeit2eHFoWlZZQWZyejBxRGE3TDEz?=
 =?utf-8?B?ZWFnR0dLZWM3bGpxNzVxWll6eVNRblBsR2szRmc3VTNUMVUwY1Z2bU0xalNT?=
 =?utf-8?B?ZEtid1p0Y09PaUI4UzJEREsxVTVXVk5WMElmNlArR1BlTFdKVzhPYytxZENG?=
 =?utf-8?B?VXJ2ZFdoZ3ROanp0L2g0Uy9ablJ0K2pYeU5qdElkaFB6cjY0dUhDdlprUzI1?=
 =?utf-8?B?bzF1TDdERG5CTmtWRFRDUlBqdlFCTThBNVU4aCs5S2VkZkpWMGNBQUc3NXA5?=
 =?utf-8?B?SFFSR3Bqd2RibVRaUWJXcUFsbGNsbXFFWlhac0NNRmpFTVl0Mmk0NmZ3dkNp?=
 =?utf-8?B?eHdsNXpsdXlQMTBzd2svYmhrNWxTSURXa3BHcS9nbElhTDVCZFNjZWZWaG5U?=
 =?utf-8?B?RnJYM3huOTYrcXNka3R0cy8rcTdIK2g1SmExRm5IM3BlaFg4NXRYbmJvY1RI?=
 =?utf-8?B?MzBicmNkVno4dTRYa0JUVXhRMmxBbW9GRm5jaXBNZU41eE5sVHQ4T2ZNanFO?=
 =?utf-8?B?TVZUOUN5dGd4a2tERTFIZFN3djRKS3E0QVpxa01DOHlET1lnamJNNVAvSGt0?=
 =?utf-8?B?NWF2MVRLTHZHSU85MTBqVXZ1ejRadWxCY2crUmlWVUhGSjRuRXY4b3dXZklZ?=
 =?utf-8?B?MnNvSEo0cEhFVExDV29hS0g3d0NwNS9veGxZUUhvL2pNVCtYQ3dsQWlwdFpB?=
 =?utf-8?B?ODR1cVdFbFNNS0k5b1pGd0tPM2thYldjYjFHZHhoYzg3cjY4VVppc1RCUjMy?=
 =?utf-8?B?L2FnZGhCUGFpRFhBQWhDZFV5YWowYWh4SG0yYzRDellURSs5LzRmcS9BbUtO?=
 =?utf-8?B?VXZLc2h5UWpNaGNYMXg1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01wV3IzM0ovYVl2bVprVHFlM0FvMkdWcHZDN2FtanFpUzlwQXpIenV0NjVv?=
 =?utf-8?B?cGxJaVptdVJMbXFZbDBidkVIc2Zab2ZJRGpGMlRaSkNkeGRjZHRIOWVkZldO?=
 =?utf-8?B?cFl3c2xTWW5Tci9Xc1R1TCtwcUs0Q3hJSVVheTQ3QWlIS0FaSko3U2Jicm1L?=
 =?utf-8?B?Nzd0UWphUjFmcTYvTFZEWWtMd1VMVHpIOVRhdmZmaGFFUjVNbm5oWW9iNjlz?=
 =?utf-8?B?VTlIcnRIVEo5dXloSC9EQTJ3Z01CQnFLV3RTVDMvUHhhdFA5M3ZUOUI0dDU2?=
 =?utf-8?B?N2hCcUppRU1iTm5RTkllMTFldTVDZzY3eDlXZTIxSEpOZVI4OURHVTZ2amRs?=
 =?utf-8?B?VnFYNkJkdWtvZ1BOUC9kbjNHYnl2TUhtYnJJZHlYekRmZ1lxN1J1a29YWGEw?=
 =?utf-8?B?RTdlVWYzV2Z3MkoyWUl1VWx0QitPczVBRVNsdk41Y2tDRHB1NzB2TXord2cy?=
 =?utf-8?B?amI1NW93YTFNeS9ETldweStSK2gxQ0o0c0h2eXRWQkhlWDVjUHB4K3VTVm1Y?=
 =?utf-8?B?REJ3NkN1RUdUMFlLcUpBYnozbmI0TXdBVkxPaFAwczZZRUJyL3FhSFg4aGpq?=
 =?utf-8?B?eWpoeG50cGVpME1lMkYrbTFnVERLekxPKytlMUFDV3Z4TndudEJ2YUZ4dUVK?=
 =?utf-8?B?TzlQVGVwSjgwKytOMEtiSERuQU9pM1ZVSFJRQlNwcDRKVUgvZ3B6VUFPRHJF?=
 =?utf-8?B?Q0NjcEQ1MW5pZGUvU1F1cFhGTWx3NnUwNG5vbHN5QzZVdGhtUGFkeGxQYnVu?=
 =?utf-8?B?R1dUeTRGNFRpb2hCbU50WVNoc3FURmswM3V6TitKc1VDSDVnbmgxZW1RbDRy?=
 =?utf-8?B?dk1ESTJSRG9GalJ3Q0krRy9OSHVGL0dPdnEvNUdaUUU5K1MwNTBCTFJNTFJx?=
 =?utf-8?B?Y2gxZWpKMUNJNlgrWks5SnhQNzNoRUgwNG9COG8wUVFaeE8zc3lmVDUrMDF4?=
 =?utf-8?B?SUdMWUpJKzJuVXpqaWJYSGpOOFpCcTFKMkZqUkFvOEt5bkI4MGxtakhWSXhj?=
 =?utf-8?B?aG9qNmVyUlloK3dlcTA5YmdYcC9zM1dFcWJQME9Sd3hJSU84ZFB3MENEZElj?=
 =?utf-8?B?RXJRVnFBbW5YalBsa2RhMm42OEhEalA1RCtyNTBJNWlJcFFhMWNwNHJCWFY4?=
 =?utf-8?B?Vno4Z2dvVHFLNFovd29mVml0MEdBKzQ0OUJvMHVhVExYZTlZaFI3eEI3MUN4?=
 =?utf-8?B?N1J6NHdVR3VyckRzT1UxWVBzdkx2Y1lWdC9QTStrV2VVRkQyYjBWcUVGTnRs?=
 =?utf-8?B?cUErSWc0eUkvMmVqaUFrYXJQUzBIZ1FqSlFsNklxQWtVNVN0dGJIbHI5NWdC?=
 =?utf-8?B?WkdOU3doS2tYWmhxMUZJc1p4MFlWaWFVTVVTY0JNbHZiZUNidkcrcCtmOVVK?=
 =?utf-8?B?a01JVG01SXg4MGgxemVnMnZGZ0lCUllVSGFlT29RbFlEY3BPTGl2ME5tWUp2?=
 =?utf-8?B?WUpLVkJsQkhtZkhZSHFTU0hmVkl1RS9KcUNBNi9jNHBpdm45Wm9iRmFFQ0Z4?=
 =?utf-8?B?ek00WG5nd3pPdUxUYTdaMUNSUGIvQ28xaHkzOHBaeWxZTCtLaEpzaTB4dnJI?=
 =?utf-8?B?bm9WdFJKNXA1Q0UwRmxKZVJXTXMvdXkyNGFMQnFyVXNOL1d3cm41VDFaMVBY?=
 =?utf-8?B?Rm1kVWpRTy8zdnQ4M2M0Q21VMnJlK2NKbkpRQkFQL1lzMmh1OGRjbzM2eC9S?=
 =?utf-8?B?bHloYStxSWV6UlN4QTh4Y3l1R2cwSEllVnMzL256NkJidmhnWGxtdXJXUTFM?=
 =?utf-8?B?YW00YUZnMk5URVpRTTZiQmhadW5YMXoxV0llZ0h2SU5sNWR5NjZwemdxZ0VV?=
 =?utf-8?B?c2Jic3FSOHhLY0ZWVnh5QjNZM0dQeTJEdFRkQkQ3a2dVeEl3Unp2T0Fnc055?=
 =?utf-8?B?OGpqdm1PbTBzY1hCVGJnWVdLb0VqQnR4WklWbW5IZktqczJpK0k5RzBOQm02?=
 =?utf-8?B?K3NIZHZxTzdlRW42NEJhNTFWOUNNM0FHVTFWdmNTb0dpb0tEOC9DT2dtU0Fp?=
 =?utf-8?B?NkVxVlJ0cVcvbktqVG1nNldsRG0vbndNMFB3LzVyZUorV1JzYjczSUM5bGdO?=
 =?utf-8?B?cWd0a1BwaWNQQWxJYkt4VEhnQWRDcHR5bVY2Ylp3WGVveTdnS1NreWRLU09Q?=
 =?utf-8?Q?k9yS7MTxfZSprK9cdkS3D8Bad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3ad9c6-014e-4c2c-c10e-08dd500fcf03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 11:31:38.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0oolRi7tr2dEnzXcRCz59kpAfoZbQ721JpO6P8VGoN7pMVhF6O/lMV0uYyPTM9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

Am 18.02.25 um 10:58 schrieb Lazar, Lijo:
> On 2/18/2025 1:33 PM, Christian König wrote:
>> Am 17.02.25 um 17:04 schrieb Mario Limonciello:
>>> On 2/17/2025 10:00, Alex Deucher wrote:
>>>> On Mon, Feb 17, 2025 at 10:45 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>> On Mon, Feb 17, 2025 at 10:38 AM Christian König
>>>>> <christian.koenig@amd.com> wrote:
>>>>>> Am 17.02.25 um 16:10 schrieb Alex Deucher:
>>>>>>> There was a quirk added to add a workaround for a Sapphire
>>>>>>> RX 5600 XT Pulse.  However, the quirk only checks the vendor
>>>>>>> ids and not the subsystem ids.  The quirk really should
>>>>>>> have checked the subsystem vendor and device ids as now
>>>>>>> this quirk gets applied to all RX 5600 and it seems to
>>>>>>> cause problems on some Dell laptops.  Add a subsystem vendor
>>>>>>> id check to limit the quirk to Sapphire boards.
>>>>>> That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.
>>>>> I suppose the alternative would be to disable resizing on the
>>>>> problematic DELL systems only.
>>>> How about this attached patch instead?
>>> JFYI Typo in the commit message:
>>>
>>> s,casused,caused,
>> With that fixed feel free to add my rb. It's just that the Dell systems are unstable even without the resizing.
>>
>> The resizing just makes it more likely to hit the issue because ti massively improves performance on the RX 5600 boards.
>>
> As a workaround, from the thread, the most reliable one seems to be to
> disable runpm on the device.

Yeah, really good point. Actually trying to fix the underlying issue is my strong preference as well.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>> Alex
>>>>
>>>>>> The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.
>>>>>>
>>>>>> Do you have a specific bug report for the Dell laptops?
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>>>> ^^^ this bug report
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>>> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
>>>>>>> ---
>>>>>>>   drivers/pci/pci.c | 1 +
>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>> index 225a6cd2e9ca3..dec917636974e 100644
>>>>>>> --- a/drivers/pci/pci.c
>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>>>>>
>>>>>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>>>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>>>>>> +         pdev->subsystem_vendor == 0x1da2 &&
>>>>>>
>>>>>>
>>>>>>
>>>>>>>            bar == 0 && cap == 0x700)
>>>>>>>                return 0x3f00;
>>>>>>>


