Return-Path: <linux-pci+bounces-27810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E702BAB8B9C
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9197C1BC2340
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAE21ABA2;
	Thu, 15 May 2025 15:54:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021077.outbound.protection.outlook.com [52.101.129.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D793185B67
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324499; cv=fail; b=ougR3V3rpPvEZFIFwY0fPp1fSIm30cbNfzD0n6f3NUMRiZ4mJ5F7ASVkWbg/vst20I+TKPeKN+RdS7UmjpCPY74um+4YzHrJXNvXXm3H1PaXaWjs1w/5uruMM0XneZJdHHlQaRg0ZJ4jUrOuFUPKiKjmiv0dJgU3ZOSnzR4SyH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324499; c=relaxed/simple;
	bh=ibIfymJ9AAT7f8t1kRtR27auCGrE+Bg8hmUVS3Mt3bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU8tOXEKglDmdaMKwzuregLq0oqj0e/jj8MW6q3OU1kFY3Y+eQ7e2a0xKtul4hyZMZoOeFvwRFadmbpnjoKPvVA6+W6W+Z/yxBSEWpSkErk5/rLFD2RXtFOdm8GM26+vI9pwV9yzYqjzaKCYL+iZtlFmLhAaoFA2aqsQxITmo54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVUwJkFiIztjsKwP5l5G10zyjJvpAgJvrMLQGsrGsRVcYKLfR8r5wF165e1UjIj0b/B7vR4xUOISAK4mo9MWrPfmxswlkeyuouUk/mWB8HnvPTaBT2rNBMP25BBI+KxM1VSrSGgTFG98i1RkQWqeqAA2U1FH1ZJ2cWncDaEDZE8tuJoXLl9FScc3FJ+JQevQJAMfe/U8yGuS2FguXsoyEC0Mb+zZ3N5MBCgIX+NIEuXfPADUB+yLvLRw7XGb8Q+Zt/xJHEM5hfX1SzTMiBej4FvSPZ09ipEumGHOy5+2ZUNaoxU740ULKTDDmwVSj4joN12JnxWHZrKAU1LZ6t3COw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibIfymJ9AAT7f8t1kRtR27auCGrE+Bg8hmUVS3Mt3bk=;
 b=xFxN1PQ2Ibs6+H6xQJe8tUecDvocBjyDKiRcXDKvTPIiWv+DpStM6s0ZlQHkyqkQxKSWhYvbWQhmH4/GqxCZDdqzXv/6xBZqVXbFZXmPc4wcfX7QXOlMC+5m//+P5NzN2na8ooz3dthbsEJdgux0VLb9S6IOKN69Ot/IRW0jzAHVf2Mb/v24tLkxB/AbKd/sOutKJLVTiEmrheKXiJjl2AcbK0LkrJPwq6eOTDuq7uHOpVgL1UnuJoPz7DIgLJLCIRPII5KfXcrqmaQaDhZDWHRSKn8VQLmqHCchLWqOQwE3q4m0ZA8A3r1UiCnhIUY8wmABk9Q0Fx5IQ1vdGFCCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 (2603:1096:820:87::13) by KL1PR06MB7287.apcprd06.prod.outlook.com
 (2603:1096:820:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 15:54:50 +0000
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462]) by KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 15:54:49 +0000
From: Hans Zhang <Hans.Zhang@cixtech.com>
To: kernel test robot <lkp@intel.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>, Niklas
 Cassel <cassel@kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW3BjaTpzbG90LXJlc2V0IDEvMV0gZHJpdmVycy9wY2kvY29udHJv?=
 =?gb2312?B?bGxlci9kd2MvcGNpZS1kdy1yb2NrY2hpcC5jOjcyMTo1ODogZXJyb3I6IHVz?=
 =?gb2312?B?ZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ1BDSUVfQ0xJRU5UX0dFTkVS?=
 =?gb2312?Q?AL=5FCON'?=
Thread-Topic: [pci:slot-reset 1/1]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:721:58: error: use of
 undeclared identifier 'PCIE_CLIENT_GENERAL_CON'
Thread-Index: AQHbxa2++1qBMNGUr0KJW0YtpWb3z7PT1uuw
Date: Thu, 15 May 2025 15:54:49 +0000
Message-ID:
 <KL1PR0601MB4726782470E271865672B2079D90A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
References: <202505152337.AoKvnBmd-lkp@intel.com>
In-Reply-To: <202505152337.AoKvnBmd-lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4726:EE_|KL1PR06MB7287:EE_
x-ms-office365-filtering-correlation-id: 8b7d5222-379b-4f91-a8b4-08dd93c8d2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?aW8waWNJTDFJMk53R0EyQkZRZEp6UTNJMnpGUjNpSGthMnh5aGdJSmhla1Zx?=
 =?gb2312?B?UmowLzVabkdOUTgxVzJtOTk4ekJTNncvdWdLV3p5c0dJeW1RRTgrVlcyZjMz?=
 =?gb2312?B?dGtRRDk0cU1mNHhmanA4WXJLYkdqWFZoNkVxczl1NWY5bitNV3NDNTk0UlBU?=
 =?gb2312?B?VGlzVnI5clFiQTVRdENpaitMZ1BQV0I0Z1ptRTFYTFFOaWZQeTN1L0xmQjZt?=
 =?gb2312?B?U2xqazRITFFIRUF1S2h3c0M1cS94ZkxjcEljUEsyUTQ1WGswcUlnMXR1TTYw?=
 =?gb2312?B?ejdGS05OSVE0Zno2QUZDZGc3NE9VNUZuZWZrUjBrdlhTQUw4NXd2T095SkFR?=
 =?gb2312?B?MlFKWmdLdEFDTzZSME8zTVZRTTQwd3lFY25HZldadC9HUFRUWTM4eVR4UXNM?=
 =?gb2312?B?SnpLZlVvd3dmRTRxTC94NE90RG0wbjllR0tWVGpDSE5nNlJjS2JkR0lObmJp?=
 =?gb2312?B?aHlkQ3l6bWRqa0toK2F1eU1SZk84OHBnYm5mSWVReFEvRTRxdkZ6Z3AzaGw3?=
 =?gb2312?B?L29NYU4xcWFtd3BBNEltMXlzYUwzYXdYK0FhUlFqR1oyMFRhN200K1hicnlS?=
 =?gb2312?B?SEswZGFjTTJ0dEt1Um8vK2llZzFZaGU2RnQ0RmFpYzQvV2NuWTlibTY3RkpP?=
 =?gb2312?B?S1RIeUM4R2ZpMTA2NVIwOWZiZVV3VzVHaTUvc3pMN1ZwUk8ybVZhSkRMMW1Q?=
 =?gb2312?B?VjdoUU9Za2V1UHF1c0R3dEpZOFQvWWdiSi9ycmphK0pTV2ZqT3k4VFNpYkZ4?=
 =?gb2312?B?UlJEVnlDeFRFRjdyUXR3dWsyZlB4YUhPRzZlQ2s5aXVvMTUzbVhzdVJwTW5t?=
 =?gb2312?B?Y01ESENqcGN0SW5nOFpROUh1S0JPZCt3QW9CVXpuRzBnNHpVSm0wMXpnK001?=
 =?gb2312?B?NkZNbDZlVlM3dHZDTDRVektCRUd6YTJVbVk2R1Z0UVdIaFlOYjIxbU14Nmto?=
 =?gb2312?B?dlNKaGhQS2dkUU8ybStmN0x6Zlhqc04rbS96RklmN2JWVDlnQ2RFdy9MOStZ?=
 =?gb2312?B?Tnc2QVZ4Q00rV2tWbHdIcHpaSVZFSFlGRzNQRkZ5SkZ4czBCSmVSSzNvck9u?=
 =?gb2312?B?M0RoaXcwSXhsT2x5dUxWVHVxRUEyWTFiRHgyS1FIbU1lSFNCcTZFUHAzOW5U?=
 =?gb2312?B?a01tSlFBdXhGTHRzUGVWSkhRcVRUaFVtVXltc1J3U01BdTlIUkFSRWRvazdu?=
 =?gb2312?B?cmErU1NIcGZKaCsrRlpOVzhSZE4vdHJybW56VFlTd2dTUngwdVdPU2F3OFcx?=
 =?gb2312?B?SjhndW1aWXNvLy90MHVzRDNRVy84SWkvcWp1bmFHTWp0L3ozRUlMSnErZEFL?=
 =?gb2312?B?cUhUQ05DbHBvNUJNNjZ1R0xHcGxZdmxINGh0VEV4RERpYklnbE9NQnp3cnN4?=
 =?gb2312?B?YnQyK1BSUEFVVFpMb2NhYmw2ZWFrR1phalNXT01LODVJWWZvTTZzb0lLb0J5?=
 =?gb2312?B?UVNka0l5Z1pUYzhoNlJxbEg1aEttNkNFMnhNdkdOWXQ4YVNIdWpMa0sxWGdw?=
 =?gb2312?B?MWNVckh4ZkwyYzR1eDlReEU0cXlyTERTWHhSc2Q5VXNXenRsVERMTUs2UDVa?=
 =?gb2312?B?RXZFZUJ6SFJzVzZSSjlEUEg4bHAvVUpuSmdkdkR4QlNlTWYvRThCUTYzM0xI?=
 =?gb2312?B?OC9MRTd1Q1BGbEF4eThiaFBOZzZEOGt5b3BsWHAzTktiWmk0ZTZhQ3hQL2dp?=
 =?gb2312?B?WkdJb2VRdGQ3aXJ5Vk1wMy9VWm1KU2xEdlV6Q1BEZ3Blb1hCblpQekxoVnNa?=
 =?gb2312?B?RnFpSXFQR01GT0hDM1FEaTJBZVJKSUFia1lxVVFRWkVHTWRncXhySDZJeXNa?=
 =?gb2312?B?SEJNNlpFZVpCUnNlenlCZ0JwOXczc2pzc2NQZ2QxWk1DOFlPZGZhb2c1Qmsy?=
 =?gb2312?B?aVhLMVh5N0VhY3RSYVJyRnFYVFlGaldyQVQrSjB2R2FGRkg3T1ZYVkhoeFYy?=
 =?gb2312?Q?m00AcabPpzXw4V0X8SmCKDsls7WqirZu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4726.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MnNZcWxySTFHMlF6cU0xUzRpaEJCRU1WaGhXNFIyelZSdUxBKy8vdUl3MXdo?=
 =?gb2312?B?UGdoR3VQWTlGRGYxNEJjYUcyWFA3WjlLemM4ek1rajZNTENvVU9ldmVLUzRZ?=
 =?gb2312?B?eVc3TktLdTdBSzZJY1g1eFFlNEJ5SmZPOEFkUGpwNDc5ZUZ6K1hhSXhFaEk3?=
 =?gb2312?B?N0RzSkY1VC9qQnVrb0NqQXlMZHhjRW9hWVFBYXJEbnU5aTdEZUlVdzZteUVW?=
 =?gb2312?B?SkRhcng3azBLbzRPSmlvQk1HUEg0RFJSN255K2xCWm05bHVrMGUvaG5Ldytw?=
 =?gb2312?B?cXpLUzBPUkU1Q3lTL3RjengwNytBelRuamIrYVIxcUtVSjVYdk5Gekd6dU9Y?=
 =?gb2312?B?SHNsei9DWlVWc2E1aFdWZEp5VndOY1ZhN2dNK2w5YjFHWmhLdWdrRkxNQmoz?=
 =?gb2312?B?d0c5VUFGenlJTnhPQmhqbzJ1eENhUHpWZFJDbkwyQXpBL1VkUUxvUk1pam9I?=
 =?gb2312?B?WGZpcFBsS2dIN0tjeHE0akNob3E0ODM5cFJ2RG83NEkxS3h3aUFoclU3RjZY?=
 =?gb2312?B?TCtPZU5XUFp3YmhCSFBnbG8zbDkwQnBOS1J5RFE0K3BNVWs5V3Q4Mmx1bmtZ?=
 =?gb2312?B?aWpqK1VUV3FOQkdWeXBCcksxNzB0UUYrYWlOUm8vcW9ydVlwc1d5K2UvZ01p?=
 =?gb2312?B?anZ1c3BLS3FUZ3BLYVBxZC9jWFRrOUxtZVpON292a2Eya29jR01VNlpxdGI1?=
 =?gb2312?B?Z2NnbGNYVDlCVk1veVJ5MlJLdm1VcDUvMmIzQ0c0VTdQLzc0Tk01NWlSOGE1?=
 =?gb2312?B?eC9zQUJSY1RxOVpNeUxla3FJR1JYalBMNnpnaGU0dkRENmU3SlhRazV2M1VX?=
 =?gb2312?B?dGZrWitDOTFQTU5CaEt0TStLOXRQVzY2MDE4OWppU1NMdHJWRXFkNFJVbHZJ?=
 =?gb2312?B?bmt2VWE4UERldC9yYURuZ0w1VmkxZUJpT0RyYlljTjIwUExuQXRneVhwYzRl?=
 =?gb2312?B?dmltUzZ5cHQ3VFJsTy9yVkx0SitRMGFRenMvUDNqZmRYdWVKNmR2Rlc0YkNh?=
 =?gb2312?B?MVUrcDBpYjZVMThyWFBaR0dtdGNkd2RScm50TzF0SzM4UVl1bGNDNU56VFQ1?=
 =?gb2312?B?WktzRzJiL0twMHlqblJGVXlTRHdWbXhpNnJsOUJYZWNJOEswRzNJdi9DeXI0?=
 =?gb2312?B?allJZ1FmK3VIWHBQSXhlU05IV0NGMzJubTh2UkcwK2tKOVJoMHd6ZVNjMzIy?=
 =?gb2312?B?dlBaazAxVGRRTUt5WC9nNTBaMFRXbkFDYXB6emhLZnRWY090U2pIQjcyNlg0?=
 =?gb2312?B?YWRmemtBL3pwQ0pZY0xtRjRrdnA0Z3lVRXQwRVVIN0xUNFFYNkl5ZThEMkh3?=
 =?gb2312?B?TmlnZWNmdk83dWdtVFlNajVOdHo2UDVKb3cydDVER3NySDJmcE1CVVc4cUpa?=
 =?gb2312?B?Q2xuQTN6SG44UllZdjh1MkJHcUIrc3l2WmhzR3lHZml2NUI3clBtK2laYVN2?=
 =?gb2312?B?a2xZT21lcUVBRm02K2JWbVhsL01lMmRibW1TOGNCdWU4Umpsb2plMjM3aTB4?=
 =?gb2312?B?RlRCQnFsZW14QjJrazkyQWQ0UWJOMVE0ZkdVMlVMbGpuYjFyRVBJQlc1U3ZW?=
 =?gb2312?B?OHZxL0xMektTbWVIWDFtTVZmSmFPc2lJRTdrOFVJZ0pwbGRFOGdvd0doMG00?=
 =?gb2312?B?czNJM3lFWEs2TjUwK0ZRTUFocGZmcmlUL04yWHdjZE0xV2d4Ry9vVjZTVVIw?=
 =?gb2312?B?QTZJMGZRMWJwaGxjTzBMSWIrdDZpZ1NtKy9yT1hqTHRHUk1nbUFZNmFOQ0Ur?=
 =?gb2312?B?d3c1RDd4K2ZEYTV0cWROUzhQdkVOZnhBYUdPb0paeHM5RURHZkV1UGsxSVBD?=
 =?gb2312?B?M1c2TDNSZXZyUThvYW11ejVWcEJQZndpRCtuMGxNQWlialN5WmdudWQ5R1M5?=
 =?gb2312?B?LzBYNlZ1QS9SdlVaTU04MlpVcENmL1dKNi9kNEpUcUlLL3NCeFVoUS9UNHF2?=
 =?gb2312?B?MGV0Q0NlRko2dFJUOHpUU2JyOUdPM0ZPRENVNmdIajlacHVzdU1ia2NkYTBT?=
 =?gb2312?B?R2R1WHAzQzlYZVMxQ0d4NFhNYnBWZUxxV0t6Z2U2VzJaU2ZueGR3amNWOGdE?=
 =?gb2312?B?bGMraGZGeU1xWUFNQWNPa041RkhTRVFxRk82ekpLR0VRWFNrcEs2a1NaL1VI?=
 =?gb2312?B?UE1TS1hUWHpZbWpUYkZkbzY2d2xOVkw1RHFzWEF5VERUdXk5ZVpKdXJIUWVI?=
 =?gb2312?Q?DSda9k6RzAp48EC0qf5sN5UaPM8EBm9jVw1LWSokJQ7s?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4726.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7d5222-379b-4f91-a8b4-08dd93c8d2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 15:54:49.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiXR9W2YjwCSTl3DZBeLFBM5egPdYY5q0SYFbkWMjjzMqEcAMwDU96vD61q16MXO9TGzxwg8Gj+eO7jllzQc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

SGksDQoNClBsZWFzZSBtZXJnZSBpdCBpbnRvIHRoZSBmb2xsb3dpbmcgYnJhbmNoOyBvdGhlcndp
c2UsIHRoaXMgY29tcGlsYXRpb24gZXJyb3Igd2lsbCBvY2N1ci4NCg0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcGNpL3BjaS5naXQvbG9nLz9oPWNvbnRy
b2xsZXIvZHctcm9ja2NoaXANCg0KQmVzdCByZWdhcmRzLA0KSGFucw0KDQotLS0tLdPKvP7Urbz+
LS0tLS0NCreivP7Iyzoga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+IA0Kt6LLzcqx
vOQ6IDIwMjXE6jXUwjE1yNUgMjM6MjQNCsrVvP7IyzogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVk
Lm1hbGxhd2FAd2RjLmNvbT4NCrOty806IGxsdm1AbGlzdHMubGludXguZGV2OyBvZS1rYnVpbGQt
YWxsQGxpc3RzLmxpbnV4LmRldjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgS3J6eXN6dG9m
IFdpbGN6eai9c2tpIDxrd2lsY3p5bnNraUBrZXJuZWwub3JnPjsgTmlrbGFzIENhc3NlbCA8Y2Fz
c2VsQGtlcm5lbC5vcmc+DQrW98ziOiBbcGNpOnNsb3QtcmVzZXQgMS8xXSBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmM6NzIxOjU4OiBlcnJvcjogdXNlIG9mIHVu
ZGVjbGFyZWQgaWRlbnRpZmllciAnUENJRV9DTElFTlRfR0VORVJBTF9DT04nDQoNCkVYVEVSTkFM
IEVNQUlMDQoNCnRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvcGNpL3BjaS5naXQgc2xvdC1yZXNldA0KaGVhZDogICBlYmY5ZDJmYWU5OTI1NGZj
MzdmNDkzODRiNzY5ZjM2M2U2NzYwMThkDQpjb21taXQ6IGViZjlkMmZhZTk5MjU0ZmMzN2Y0OTM4
NGI3NjlmMzYzZTY3NjAxOGQgWzEvMV0gUENJOiBkdy1yb2NrY2hpcDogQWRkIHN1cHBvcnQgZm9y
IHNsb3QgcmVzZXQgb24gbGluayBkb3duIGV2ZW50DQpjb25maWc6IGFybTY0LXJhbmRjb25maWct
MDAyLTIwMjUwNTE1IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAy
NTA1MTUvMjAyNTA1MTUyMzM3LkFvS3ZuQm1kLWxrcEBpbnRlbC5jb20vY29uZmlnKQ0KY29tcGls
ZXI6IGNsYW5nIHZlcnNpb24gMjEuMC4wZ2l0IChodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZt
LXByb2plY3QgZjgxOWY0NjI4NGYyYTc5NzkwMDM4ZTFmNjY0OTE3Mjc4OTczNGFlOCkNCnJlcHJv
ZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5
LWNpL2FyY2hpdmUvMjAyNTA1MTUvMjAyNTA1MTUyMzM3LkFvS3ZuQm1kLWxrcEBpbnRlbC5jb20v
cmVwcm9kdWNlKQ0KDQpJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2Nv
bW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBzYW1lIHBhdGNoL2NvbW1p
dCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCnwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KfCBDbG9zZXM6IA0KfCBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9vZS1rYnVpbGQtYWxsLzIwMjUwNTE1MjMzNy5Bb0t2bkJtZC1sa3BAaW50ZWwuDQp8IGNv
bS8NCg0KQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KDQo+PiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJvY2tjaGlwLmM6NzIxOjU4OiBlcnJvcjogdXNl
IG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnUENJRV9DTElFTlRfR0VORVJBTF9DT04nDQogICAg
IDcyMSB8ICAgICAgICAgcm9ja2NoaXBfcGNpZV93cml0ZWxfYXBiKHJvY2tjaGlwLCBQQ0lFX0NM
SUVOVF9SQ19NT0RFLCBQQ0lFX0NMSUVOVF9HRU5FUkFMX0NPTik7DQogICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQogICAxIGVycm9yIGdlbmVyYXRlZC4NCg0KDQp2aW0gKy9QQ0lFX0NMSUVOVF9HRU5FUkFM
X0NPTiArNzIxIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYw0K
DQogICA2NzkNCiAgIDY4MCAgc3RhdGljIGludCByb2NrY2hpcF9wY2llX3JjX3Jlc2V0X3Nsb3Qo
c3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlLA0KICAgNjgxICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCiAgIDY4MiAgew0K
ICAgNjgzICAgICAgICAgIHN0cnVjdCBwY2lfYnVzICpidXMgPSBicmlkZ2UtPmJ1czsNCiAgIDY4
NCAgICAgICAgICBzdHJ1Y3QgZHdfcGNpZV9ycCAqcHAgPSBidXMtPnN5c2RhdGE7DQogICA2ODUg
ICAgICAgICAgc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7DQog
ICA2ODYgICAgICAgICAgc3RydWN0IHJvY2tjaGlwX3BjaWUgKnJvY2tjaGlwID0gdG9fcm9ja2No
aXBfcGNpZShwY2kpOw0KICAgNjg3ICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHJvY2tj
aGlwLT5wY2kuZGV2Ow0KICAgNjg4ICAgICAgICAgIHUzMiB2YWw7DQogICA2ODkgICAgICAgICAg
aW50IHJldDsNCiAgIDY5MA0KICAgNjkxICAgICAgICAgIGR3X3BjaWVfc3RvcF9saW5rKHBjaSk7
DQogICA2OTIgICAgICAgICAgY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUocm9ja2NoaXAtPmNs
a19jbnQsIHJvY2tjaGlwLT5jbGtzKTsNCiAgIDY5MyAgICAgICAgICByb2NrY2hpcF9wY2llX3Bo
eV9kZWluaXQocm9ja2NoaXApOw0KICAgNjk0DQogICA2OTUgICAgICAgICAgcmV0ID0gcmVzZXRf
Y29udHJvbF9hc3NlcnQocm9ja2NoaXAtPnJzdCk7DQogICA2OTYgICAgICAgICAgaWYgKHJldCkN
CiAgIDY5NyAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICA2OTgNCiAgIDY5OSAgICAg
ICAgICByZXQgPSByb2NrY2hpcF9wY2llX3BoeV9pbml0KHJvY2tjaGlwKTsNCiAgIDcwMCAgICAg
ICAgICBpZiAocmV0KQ0KICAgNzAxICAgICAgICAgICAgICAgICAgZ290byBkaXNhYmxlX3JlZ3Vs
YXRvcjsNCiAgIDcwMg0KICAgNzAzICAgICAgICAgIHJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3Nl
cnQocm9ja2NoaXAtPnJzdCk7DQogICA3MDQgICAgICAgICAgaWYgKHJldCkNCiAgIDcwNSAgICAg
ICAgICAgICAgICAgIGdvdG8gZGVpbml0X3BoeTsNCiAgIDcwNg0KICAgNzA3ICAgICAgICAgIHJl
dCA9IHJvY2tjaGlwX3BjaWVfY2xrX2luaXQocm9ja2NoaXApOw0KICAgNzA4ICAgICAgICAgIGlm
IChyZXQpDQogICA3MDkgICAgICAgICAgICAgICAgICBnb3RvIGRlaW5pdF9waHk7DQogICA3MTAN
CiAgIDcxMSAgICAgICAgICByZXQgPSBwcC0+b3BzLT5pbml0KHBwKTsNCiAgIDcxMiAgICAgICAg
ICBpZiAocmV0KSB7DQogICA3MTMgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImhvc3Qg
aW5pdCBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KICAgNzE0ICAgICAgICAgICAgICAgICAgZ290byBk
ZWluaXRfY2xrOw0KICAgNzE1ICAgICAgICAgIH0NCiAgIDcxNg0KICAgNzE3ICAgICAgICAgIC8q
IExUU1NNIGVuYWJsZSBjb250cm9sIG1vZGUuICovDQogICA3MTggICAgICAgICAgdmFsID0gSElX
T1JEX1VQREFURV9CSVQoUENJRV9MVFNTTV9FTkFCTEVfRU5IQU5DRSk7DQogICA3MTkgICAgICAg
ICAgcm9ja2NoaXBfcGNpZV93cml0ZWxfYXBiKHJvY2tjaGlwLCB2YWwsIFBDSUVfQ0xJRU5UX0hP
VF9SRVNFVF9DVFJMKTsNCiAgIDcyMA0KID4gNzIxICAgICAgICAgIHJvY2tjaGlwX3BjaWVfd3Jp
dGVsX2FwYihyb2NrY2hpcCwgUENJRV9DTElFTlRfUkNfTU9ERSwgUENJRV9DTElFTlRfR0VORVJB
TF9DT04pOw0KICAgNzIyDQogICA3MjMgICAgICAgICAgcmV0ID0gZHdfcGNpZV9zZXR1cF9yYyhw
cCk7DQogICA3MjQgICAgICAgICAgaWYgKHJldCkgew0KICAgNzI1ICAgICAgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJmYWlsZWQgdG8gc2V0dXAgUkM6ICVkXG4iLCByZXQpOw0KICAgNzI2ICAg
ICAgICAgICAgICAgICAgZ290byBkZWluaXRfY2xrOw0KICAgNzI3ICAgICAgICAgIH0NCiAgIDcy
OA0KICAgNzI5ICAgICAgICAgIC8qIFVubWFzayBETEwgdXAvZG93biBpbmRpY2F0b3IgYW5kIGhv
dCByZXNldC9saW5rLWRvd24gcmVzZXQgSVJRLiAqLw0KICAgNzMwICAgICAgICAgIHZhbCA9IEhJ
V09SRF9VUERBVEUoUENJRV9SRExIX0xJTktfVVBfQ0hHRUQgfCBQQ0lFX0xJTktfUkVRX1JTVF9O
T1RfSU5ULCAwKTsNCiAgIDczMSAgICAgICAgICByb2NrY2hpcF9wY2llX3dyaXRlbF9hcGIocm9j
a2NoaXAsIHZhbCwgUENJRV9DTElFTlRfSU5UUl9NQVNLX01JU0MpOw0KICAgNzMyDQogICA3MzMg
ICAgICAgICAgcmV0ID0gZHdfcGNpZV9zdGFydF9saW5rKHBjaSk7DQogICA3MzQgICAgICAgICAg
aWYgKHJldCkNCiAgIDczNSAgICAgICAgICAgICAgICAgIGdvdG8gZGVpbml0X2NsazsNCiAgIDcz
Ng0KICAgNzM3ICAgICAgICAgIC8qIElnbm9yZSBlcnJvcnMsIHRoZSBsaW5rIG1heSBjb21lIHVw
IGxhdGVyLiAqLw0KICAgNzM4ICAgICAgICAgIGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0K
ICAgNzM5ICAgICAgICAgIGRldl9kYmcoZGV2LCAic2xvdCByZXNldCBjb21wbGV0ZWRcbiIpOw0K
ICAgNzQwICAgICAgICAgIHJldHVybiByZXQ7DQogICA3NDENCiAgIDc0MiAgZGVpbml0X2NsazoN
CiAgIDc0MyAgICAgICAgICBjbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShyb2NrY2hpcC0+Y2xr
X2NudCwgcm9ja2NoaXAtPmNsa3MpOw0KICAgNzQ0ICBkZWluaXRfcGh5Og0KICAgNzQ1ICAgICAg
ICAgIHJvY2tjaGlwX3BjaWVfcGh5X2RlaW5pdChyb2NrY2hpcCk7DQogICA3NDYgIGRpc2FibGVf
cmVndWxhdG9yOg0KICAgNzQ3ICAgICAgICAgIGlmIChyb2NrY2hpcC0+dnBjaWUzdjMpDQogICA3
NDggICAgICAgICAgICAgICAgICByZWd1bGF0b3JfZGlzYWJsZShyb2NrY2hpcC0+dnBjaWUzdjMp
Ow0KICAgNzQ5DQogICA3NTAgICAgICAgICAgcmV0dXJuIHJldDsNCiAgIDc1MSAgfQ0KICAgNzUy
DQoNCi0tDQowLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlDQpodHRwczovL2dpdGh1Yi5jb20v
aW50ZWwvbGtwLXRlc3RzL3dpa2kNCg0K

