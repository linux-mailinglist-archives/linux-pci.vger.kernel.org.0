Return-Path: <linux-pci+bounces-41769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 406DCC7346B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04D3A4E4E2E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181273090E8;
	Thu, 20 Nov 2025 09:41:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4E2DEA8C;
	Thu, 20 Nov 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631713; cv=fail; b=dGVt/KXdn/BbgMhU23BRt5JZgpkiGuw850ewjHiWX9eTJxPdZYUvcJYA1XS8i8LBaVCQkZqNPelfXj/aV+21DZEjK8tPJeqmA9yRcKxTGGTOI6k1hWkm6J7JBmHWwJiuVkiw8HHG6CjkKzvktPRVUbQBg54YTVedVzaZRclvLxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631713; c=relaxed/simple;
	bh=Y+jFVZ6Q2wMsDFp62xulL9GqiNpFQ0tgebmF8xOwp+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz8QbCwu3NPiAYmjBxa72rIfvZnLOw5ZXjdisuaSyzN0jVETQx2ge60UMQALYtvlu3+LFRGUHSuTMySP9GUkGg+MTSjIbFFxNiuec+vBCZx4doH+gH0xBO7JSXOBNX0fClP/NUmS1NEG/+vfXXw+R19S6uT42I9oWsA74esjucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it572eTEBSuy7fEux8W2V2ThnWw+DIoT9cfwyWMb/A6YgVsMdU1SOmNOc5T8yJHOEOWXY4eYkoZs7/wPsh93fTBFarl9xIJ056PXyelGFzSI71wtFv1HrsX+riwNhn9i6f5yZrY4q91u1JPZu4wVut8c5CkzMqc+rMubfJFzj8ZxszEQVlpXy/DrClZxOElLm7KOg/qRY+3XtrL1cIGR6eEGLQhLHx4D2Dm6e1jQI2SQO0SMQAXecPvK4X/0WXgPexrA3VaSgDXr+zDuZLUhrwcHlhRLMGIr0l0Zhpx0Tz0nXv6IO7IAFwSxkxyZd0ngZwGJL4sNb3JTMIRodBDVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+jFVZ6Q2wMsDFp62xulL9GqiNpFQ0tgebmF8xOwp+I=;
 b=FtZYclIK0fGSB1Nw8flIuCeu9bXuQBLRx0BOtFLdDq3u0F4NCDI/XpZvMrpic0wZRpCzXi7h3a+TnDlE0RYEZ0xfbVRzXOjofadwYU+si+JfKTVtpGQGtQzGBUW/ULfMzL5sfO/SXi7Gl89WKtMZNilLEmdYv2GMCk2JLfrQkXPHf7Xc04APwB/AxBYz817Ac9ngsibimHN/YXTd1ZuioJvBlbZ3vZNW31ZEBi0iZ2DcEj6yad748CBN8uz6gG3zxdiQYg6GJgE1HPfQDH8mjxWsiEXexzJ9ryGJr2MgCiQ6lqUcf3EzlHYSd7fbq15ZOGwJNKSF9Dz1MeXOKfR7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 (2603:1096:820:87::13) by KL1PR06MB6847.apcprd06.prod.outlook.com
 (2603:1096:820:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 09:41:44 +0000
Received: from KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462]) by KL1PR0601MB4726.apcprd06.prod.outlook.com
 ([fe80::b54c:6c38:1483:3462%4]) with mapi id 15.20.9320.013; Thu, 20 Nov 2025
 09:41:43 +0000
From: Hans Zhang <Hans.Zhang@cixtech.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>
CC: "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>,
	Manikandan Karunakaran Pillai <mpillai@cadence.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIC1uZXh0XSBQQ0k6IGNhZGVuY2U6IHJlbW92ZSB1bm5l?=
 =?gb2312?Q?eded_semicolon?=
Thread-Topic: [PATCH -next] PCI: cadence: remove unneeded semicolon
Thread-Index: AQHcWgFdrvp+uXD+X0ix65d/wSwaf7T7T2QA
Date: Thu, 20 Nov 2025 09:41:43 +0000
Message-ID:
 <KL1PR0601MB472685FE5109782EF14C62DB9DD4A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
References: <20251120093518.2760492-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20251120093518.2760492-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4726:EE_|KL1PR06MB6847:EE_
x-ms-office365-filtering-correlation-id: d8106200-8221-4927-fb83-08de281903e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?aHN5cGZ5SjBTT2tOSVhYYnR3VHFaYTNCRERxMnY5WFBVTUxwNDJaMDNQbW9z?=
 =?gb2312?B?eVEyMklSV2VaazhLU3Y2TjAyUjR4OGgrdlY3dzRPRG8xSERmMXV2Tk5YRGQ0?=
 =?gb2312?B?cmdZSzB0SFBZeGR4ZFRNU0hDdUM0UjJpVlh5WG45enlSV3FJK0FMU3Q0MVBj?=
 =?gb2312?B?WVJKVWxTZTRhN0hUam1DYmpSdzNvV1hON012T2hmWVVGeUZLd2xHai9QNmQw?=
 =?gb2312?B?c0ZiM2ozWVRwaGxnZTVYVWlqbzQzRUJFdkZLb3RZa2JURUJhS2VTZVBycEZp?=
 =?gb2312?B?NDh5amxmenIxK2NodTFVcFFZZmY1ZzVhNVZ4K1p2Smc5ZnRWS3pHNStMWEVZ?=
 =?gb2312?B?Z2J6WHZ0VEM3cnN1azJiMjhwbW16VUU4dXBXL2hvNTc1dXZ4RmY2czhEZmZt?=
 =?gb2312?B?eTJldkMrZnRBZTdqeFFsRW5mS0I0aFMvOTNGQXFWbUpiQ1BCTG5wU0EyWWZj?=
 =?gb2312?B?WWJULzEwT1NWWkdmZVQ0Sjd0ak9DTWhiRFJpM1hVL1JpLytNK2pLTXkrWUxO?=
 =?gb2312?B?aE84NXUvKzJyVFFXdDZTTjVrQXNZNS9qQlF0YUVGVkFyWFY3WWdVV0V1Ti9V?=
 =?gb2312?B?V1RRNXJjMWVIajlneFVkZElVWmNoVVJwWTZjZ3JsazdLYVFNY29pZWJzWGFk?=
 =?gb2312?B?YTR5RXF6c3RmcG94ejJ0Zlg5YzJZazhGdmgreGR3TGpCRkl1WGt5b0kyOWFM?=
 =?gb2312?B?QU5tVDBvVE0xYUJrcHdaUUgvOGk2TjZ0ZFJFa0VucW9LSzd3VzMzek1wMC9h?=
 =?gb2312?B?UjlXWDdzMWQxWlY1SlhKYXN0QUZiVFltMkF1bWg5cHZ5RlMreERmR1VSTERx?=
 =?gb2312?B?cjJUMW4zSTZQZVVXQmhnVlZMRmRlU1NMWEpwLzdWRU5jbnJHTStvUmRrUjU5?=
 =?gb2312?B?blM3d2FzYVNqVU5MWTBKMU9UYkJoVkZJclF4RklkWkhhVlpVRFVqL3h3WXg1?=
 =?gb2312?B?K2pWNm5Wc2VQMUV4MkF5RkxkOFUzTkVFVml1cUFWVjdNK29vOTVpV3VHQkR6?=
 =?gb2312?B?V3lmSWkxcStjc0dHa29kQUUrZUNkVDN2aDArbXFnQ2xMT0Y5ZEZGMUt4MkdX?=
 =?gb2312?B?WDlGUXhLUkhxb3hiWjJSYjB5MG1JMExTOC95SitJRUQvN3IzQUhZRUpialNi?=
 =?gb2312?B?aElHZTNCejdmeWV3b0JjTHMycnBZSjlHTnlHUS9iMkIzM21QZWJpYWZLVUI4?=
 =?gb2312?B?QXY4L0FHSGcxVUUyNElGaDdsM1FtSHJLNXc3MTllZDhURko3elhpQUpKWEYv?=
 =?gb2312?B?STc3eHgxcTkrWVc4OHdWQkZsTUNUV1J2YWhPcGZWc3VBcm9mYmZWVnFzMnBB?=
 =?gb2312?B?WmU5aHZNSDdWUklvZjMzYXp2QjdiK0FhdUgvL1Rhd29ORW9NVDNvVnU0SnBu?=
 =?gb2312?B?UFpqa3ozN3BCT2tndmRDd3kvbnNrOVFOWGJ6MW5OSnVLK3N6K1R2M3pFaWQv?=
 =?gb2312?B?S1JkbHZJdDQ3Q3lUNEU1alo2alpIeEM3d0xvUnNaV3NFTEZXb3J3VWU1b2Y3?=
 =?gb2312?B?aEN4RVVqLzQ0d3pqUnNQL0ZTM1BQbDVpb05SRW8rQkdLRGR0d2ozQVdCekNi?=
 =?gb2312?B?dkhNMTNqYUd1WlIzUVE1QjU1WENzUzh3bmNXZ3BONVlUV0FXaUdJaENLVHB1?=
 =?gb2312?B?UTYyU2hhUzBKaGF2alJHUWFYVzRLTzZ1YXAvWFNDRmZneWIvN0RqTUFrOXZ1?=
 =?gb2312?B?ektCOE1Qd2hQWkVDUk1Ec295SFFLWFFZUXZhWUtNUFhCUDgxdW9oaUd4T2ds?=
 =?gb2312?B?cnF5MzlpQXBYN2tWNHl1TXF3TVViYVV2cmVreVBhZGt1OEFIU1JmNWFyK3ZR?=
 =?gb2312?B?UlVlR0RDb1VOSHhPODVXeUVzUDhQVTNlWTJ3Tk1aeERNTGhIdWlydGIwVnJq?=
 =?gb2312?B?S2RoZmlTVkErNG1QTU5XemkwY25lSEIvVVRGdTdjQW1DaVRJTTNMRWRXMnQ2?=
 =?gb2312?B?VUlUNGtFcGR2YjRIdUpCQTZWVHdmV2o1c3FYSjdzQTZ4YlBrVnBGeHRlT2xB?=
 =?gb2312?B?Z2RRaUpLT093PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4726.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SmNIdk03MnpaZ2xIUHp6bnIyTDg1d3F0Zk55RVJHaFFBWWprNEFvR1ovaERk?=
 =?gb2312?B?RDJLcjluYUhLNWh5VzhHV0ZoMTltWjJ1S0xsUFQ4bXg5cy9HRDZtQ3c0OGhD?=
 =?gb2312?B?dWZGRmQ2L2NWcHlqcWg3K1ppYVNGbEI3WVh3NzBleTJ3YkJDSnlNMmd0RjQ2?=
 =?gb2312?B?QmphaHZVR2JDUDNhSWpBSjcrR250T0g0NDNpRjRTRTZZY1g3NHFxTDZYMmtI?=
 =?gb2312?B?Tisxb2RnU25LQkpOVjNWbkZqODFZZy8rTXJUZENKc05zNSs0N3o1M0M3Smw1?=
 =?gb2312?B?RXdyQzZ2NU5pOHlyUU1FQ2FNM2JuK21ubStoeHhGWm94WFNaQjFqQk4weWRq?=
 =?gb2312?B?bXRhWjE0WG01cU1QTnZIelVOUndQUC9RMkFXbVowbXNxTFJrY09RRHlVbE1Q?=
 =?gb2312?B?QU81RGRVTTR3QjM3LzhhOW4zQ0huYmYyYlVsWDYvNmZ5bUR1TDFBejhRRmV0?=
 =?gb2312?B?bExEWGlrSXRNa1B1ZEN0SlR2bFkzUWFCWTBXQmpDRGpZTUVQamxWK1ZDS3dt?=
 =?gb2312?B?SDhEY2Mray9hd29ISWVQcnp4Qmp2OUdJWlMrQzd4MjVnbUp0Y3MxODJlU0ZI?=
 =?gb2312?B?cVUrb2crTXVLV0c5TkcrYmRZb3lrbjRwK0hWNllpbThiTlp4UjdNVTJRcTlK?=
 =?gb2312?B?Y0taamFpOTlrSzVUT0p2RFgrc3Q2KzFRZndZd25kNitpcHNLTE02eDB0b2ZH?=
 =?gb2312?B?UGg4YWdYZENuaFY0Vm4yRklUdEV4aElTKzZmVHFsYjNsWHYyenAvcHBYV1gw?=
 =?gb2312?B?cmgxR3UvdENzUkd0b2t5V1dleWxsVWRsdkw3MHB0ZmdPTmNEb0RNdXVjY2Uv?=
 =?gb2312?B?UFg5QTVESTRxRmUvaWl6ZlJZR254dXBVaGVucXp4MTZZS2xVNldIaWVSV0wy?=
 =?gb2312?B?Mm1yRncySWVLN2dQY0pHWXZwbjc4S3NWUWJ3QUJGN3REV09VNlcvMHIvelYv?=
 =?gb2312?B?amNBVDJweHBMaXVPRzVXekhPaW1KMlM3YkNQYytabUJQcFpLTnFQZFYzNnNh?=
 =?gb2312?B?MXpxaUhXcWVHamE4a2ZSZXFyMitvbmRUVG41czhDV0R2NHV5akkxMGUwdm43?=
 =?gb2312?B?S1ZYK0hycDdjWXhzSzdZd2VqY0Z2NkIvV3dpd0p0YlRsNkJva0J3MHpjaEw5?=
 =?gb2312?B?OWNYT0Qxck9OYzM4RVV3Q1ByZ0Q2OGkzK2dzZVlaN3BPaWRCLzJleHZhTlFn?=
 =?gb2312?B?SWNLU3AyUjhZL2ZxbHNlMzZuT2xPMDBwUzlzNXpTMzl5UmdaSmVKVUVVWVlN?=
 =?gb2312?B?ckZwdXhNT2Iwbk9CcnpmTTFSSG03cFhFVHpoZVMwY0E1UzQxME12N0Y1eW5v?=
 =?gb2312?B?N0FiOHBHSlV1d1dGZnJXMHBoMll4eE5OVUpVRTREQktIS1NpekxJa25JQ0Z3?=
 =?gb2312?B?a1NGVHBoYzF4OGpoTEUramQwS2gzTVBPNG01Ui9TdmR1ellBVWFKNy9RM3Zz?=
 =?gb2312?B?STBPRzRFTFovemxIdDFvMUVXd2ZXNnJDTlJ1T09zOG9nMVAySmw5Z0t4RGxP?=
 =?gb2312?B?aE40RVYxYU1iaWlMS0FWaVNyRTVZTlVzSFkzZXp5dStMQUVyVC9Sci9FQjBq?=
 =?gb2312?B?WWVzOHhWbloyb1hMT3RTcG43ZmVSeTJjMkk3Zm5qeDBYc2UvajBpRzVlU2Mx?=
 =?gb2312?B?WnV3ME9Bc1lHQjU4VmJWSU5oUUtKdVVKUlRjYXNKQ0Q1YTVzbUJXN2NTNEd5?=
 =?gb2312?B?cWJlL1M4eGkxRm93eTAraUovV1lZU1RRcmVpc1o2QWZlZGJHMEZ1MzY4dmU2?=
 =?gb2312?B?U1dvVTZsWXhMcTl3M0tkRE5tSVBwdUVxUy9FOGhDNzdvSGpFdXpISlVXb1FE?=
 =?gb2312?B?alpibWtGKzdPOENmMmQzQWpkUXA3YTB5Tzl1R3h5TkgzVm5tYjdLSzJOUjZC?=
 =?gb2312?B?UVJ3MWdCdllrZlAxRFdodkN2REZLdDdpckJmOWtZTVBRYWxrUHlQZ25RZFpJ?=
 =?gb2312?B?QkFQZW5LaWNlQW85ZDhid1pRZ250cGwwVW44alJwVi9sT1RHYnBrMHZwRVdx?=
 =?gb2312?B?eTZGcnQwYWVIV2V3NzZjcmZIeDdQeHpUN3Nac3lqUlNMUE9nb2hQc3dFZGF3?=
 =?gb2312?B?aVp1djdDVU1OK3FxMGVvSzlhSGYxc2FtekRNOVd2U3Fhc2VydXhxb1ArczR0?=
 =?gb2312?Q?ZeBAp3Jtrf7QI1TdFVc2qAf0I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8106200-8221-4927-fb83-08de281903e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 09:41:43.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SY1BgV7Jtm575SSXVwWYtxUpfejMHh05SSyVfCBnmbNj4YGba0ZyhgTzG5Yx0PFQezlmTl8tcdgH8O0kRK0ztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6847

KyBNYW5pa2FuZGFuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBKaWFwZW5nIENob25n
IDxqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEuY29tPiANCreiy83KsbzkOiAyMDI1xOoxMdTC
MjDI1SAxNzozNQ0KytW8/sjLOiBscGllcmFsaXNpQGtlcm5lbC5vcmcNCrOty806IGt3aWxjenlu
c2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBKaWFwZW5nIENob25nIDxqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEu
Y29tPjsgQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPg0K1vfM4jogW1BBVENI
IC1uZXh0XSBQQ0k6IGNhZGVuY2U6IHJlbW92ZSB1bm5lZWRlZCBzZW1pY29sb24NCg0KW1lvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqaWFwZW5nLmNob25nQGxpbnV4LmFsaWJhYmEuY29t
LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KRVhURVJOQUwgRU1BSUwNCg0KTm8gZnVuY3Rpb25h
bCBtb2RpZmljYXRpb24gaW52b2x2ZWQuDQoNCi4vZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRl
bmNlL3BjaWUtY2FkZW5jZS5oOjIxNzoyLTM6IFVubmVlZGVkIHNlbWljb2xvbi4NCg0KUmVwb3J0
ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51eC5hbGliYWJhLmNvbT4NCkNsb3NlczogaHR0
cHM6Ly9idWd6aWxsYS5vcGVuYW5vbGlzLmNuL3Nob3dfYnVnLmNnaT9pZD0yNzMyNg0KU2lnbmVk
LW9mZi1ieTogSmlhcGVuZyBDaG9uZyA8amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaCB8IDIg
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaCBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KaW5kZXggNzE3
OTIxNDExZWQ5Li4zMTFhMTNhZTQ2ZTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLmgNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
Y2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KQEAgLTIxNCw3ICsyMTQsNyBAQCBzdGF0aWMgaW5saW5l
IHUzMiBjZG5zX3JlZ19iYW5rX3RvX29mZihzdHJ1Y3QgY2Ruc19wY2llICpwY2llLCBlbnVtIGNk
bnNfcGNpZV9yZQ0KICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICBkZWZhdWx0Og0KICAg
ICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICB9Ow0KKyAgICAgICB9DQogICAgICAgIHJldHVy
biBvZmZzZXQ7DQogfQ0KDQotLQ0KMi40My41DQoNCg0K

