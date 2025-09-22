Return-Path: <linux-pci+bounces-36617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEAB8F2AF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B2118900AB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020723D7FD;
	Mon, 22 Sep 2025 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iumLRmDq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A75248880;
	Mon, 22 Sep 2025 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522952; cv=fail; b=P3N7/RvzE0j/iFkkv03mWoLzSvGu68NVFPp0pvviE7f18NKWLEV+9iHKzfJJIE26H7p9pWmWmH7cu7JL5NSnqm1Hu1aH9C1JDexH8u8cexYiLQN7Sidxb/5drptdptZjh8ehrP1nZosmBUGYdK8e1tdLImSDyPAEHGS71HNFPKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522952; c=relaxed/simple;
	bh=w30SFJ5ulfWZGuziaR+UYrifCDTJ7FFSN1f2RyApv80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ce5VjiTadA3iJksoqnWhpw3lahqwjFsVOILtI/lGUlDNjCrzeIl9/4kZgsHWtu6UBStieFuWug5A/nwcwJ6JsREvj0sJWKhNRd4OFAp4/g1aMNJCXsu1nT2vO8TdO/L0PwIc1ppqIKD9mP/tsILijSCRk5+gxL9TaxSxZLYWOg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iumLRmDq; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhrnZ3KqFDbhzfE8ehKnPmylnADj918qEik/emPvRl7xwlfDeeti50fXNFa/LyIxEnGtEytwBPphavu6YUSjSdoh2z2oFytcaJh70qbmu8apOrWkdmWmkLABBJEl0vTX3PC48y32W4pJ0wMPNNPEuKKcg5xCKR6eUtn5tQ5rEa0NHtEHoiVm4PWnk4Lqx5i6mMQjTG/pxfnGSb102AZoIsTTCcRjlr9gVSjmzNzuWMaSi6SyxvwKQE/SVlkbabdq3ENExSCHoq4aUX8mF1L2LbykcIIEpES4Izwsmp4LGOuHW94uC0yhc1nkxER7ugNzpoQpMCrYF2+s7E3hHJd8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w30SFJ5ulfWZGuziaR+UYrifCDTJ7FFSN1f2RyApv80=;
 b=Q+8jjXBUIn0n+d/LrD+thFBah44xkSaF33JQ0x23QuLyaATnr1AhuNpqP9+EyuqTP1MDMb+EEUvBkLbqzi+xBAciOPHf8ZD/ichdvRH8vVrfEqwMiEqAi3hgdc2vrLj5EQiFhEpsLLXwjSrCyOfoN1gJ7cFKsu9rtRh7AlHkrdyWrr89ohPOYj3+f1FPtROP/b8sR2pGyI9NjstJJCo5ceQ2ntO2BbIfWGOzI4QgdX2UqWiL3aBj5tgBLLhBYyJHo8dw9YmlhIb8TIVmaRaQP72nUzr79uRn6SrwEosz3jDHunJ8ZSWt79I/1xnvYz2EKlgb5zpxE/83+9xYbvUR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w30SFJ5ulfWZGuziaR+UYrifCDTJ7FFSN1f2RyApv80=;
 b=iumLRmDqysUjQn2/S5yGjbwOvr20O9KiwHLd241bkKzZqaErawY/Li5lwn2RwC/HsWyBnRz4XufiAEmkiqZqNVRaj13iE/MqXaPFGTRfnGr/Ioi6mSAU+EmLc1vP+QuKv0Na6yrTAvFEQPC7XaD5Cs75SHJStcQgXHHi/tLHG8SGZsnMpuMnrApWXfJJ/HrGbR8zZrZmI4+P4JCp/90qUbHYv//r36DtFjkXo0LAZ+HBXQKwMfJ6MFKSo+zam9BS4I38xldwZTCu7VxkMGGXLNAAkyX8Y2sf9DLriBEUWkQTBmkVbhrgxMSCJn5TLctq4UbRlMcKQZQ/AnGY4B/O8A==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 06:35:46 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 06:35:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] PCI: imx6: Add a method to handle CLKREQ# override
 active low
Thread-Topic: [PATCH v3 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Thread-Index: AQHcK2n4X37yD/4cF0GB+dWIEVxOULSeuPQAgAAGOlA=
Date: Mon, 22 Sep 2025 06:35:46 +0000
Message-ID:
 <AS8PR04MB88335C37FF8000CB275FC40B8C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250922023741.906024-1-hongxing.zhu@nxp.com>
 <20250922023741.906024-3-hongxing.zhu@nxp.com>
 <hsmebnz6opoj45zztdd2svmdtrwwwrngjaidpltbunnkdvvdqz@lhyejtlwkkes>
In-Reply-To: <hsmebnz6opoj45zztdd2svmdtrwwwrngjaidpltbunnkdvvdqz@lhyejtlwkkes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB8403:EE_
x-ms-office365-filtering-correlation-id: 339ae3e6-1e41-43c6-aa2c-08ddf9a2432e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TC92VnBkV1RDRVlKRFF6MXlVTWthMEFBZFR1MUh3YTdZbFZCMWp2WnVDSE14?=
 =?utf-8?B?Z1R5eDZYVFdiOHZPVDQ4RG5rN0p4enVSS1VtaDU5TFZqMGNwcWdrM0hRNWpm?=
 =?utf-8?B?SlRtcWRKbkQ0dklJaFVoT0toMHRsb21ERyt1a0hNL0gxUFRNTlR1VkxjekE5?=
 =?utf-8?B?MmtPZXpsTzFmWFd3S0psam9rYWpiQ1plMzlVSmpRU1c0citGYnd0OU9LV2pZ?=
 =?utf-8?B?T2UvT1NJYnJieFE5WmVEejdYdGlvSUg2QnUyVStIcHBwOGZ1Sk10TUhaM3RI?=
 =?utf-8?B?aXJPOXEwaW9pbVpONnVCOWhPRUpxa3VkbWdZbjBJdGFvNnVIN3N2b3FYaTlU?=
 =?utf-8?B?ai9yZXRvaDRGT3NxOU5RNExsdnNNT0pNUzUvUHpxWjF0WnRuaWFxTmorU1hy?=
 =?utf-8?B?d0VkMklkdkFHLzdoZXRrSzd1Q0MxRkVBdWExUlJvZmxHT1FxNGRvQmE1djRz?=
 =?utf-8?B?YzFkYmxkNms0RUlrNlpuNGJ6MDZGdmpxbGRnZ05HVE5CRS9WTHlpYStUdXA2?=
 =?utf-8?B?M0F4MkRJUkFBdnVLSkFBR1lEMzNSa3N0TFVFZko5dmhyeFlJK3RkVnI3RGhT?=
 =?utf-8?B?Z1ZaMVRXNWxIaFpYQ3l6TnNhWU5vR1kvN0RoNEVpVi91NFFBeEx0K1d2ZFVi?=
 =?utf-8?B?U0RrT0g5eDZYM0JSTVFXZmxQRktHcThkTUZLRkRRNUgzRUc2YlUzTFhqSk83?=
 =?utf-8?B?S3dnTU9sL3I2QndKWDlsSFFoRkJVNFV0MEtJdUt1cldnNFFWSStBMjQvQ2dz?=
 =?utf-8?B?dGFqaGFUOGUyS0xDRGFqZld5VThvS3NjTzRHMXRzK2JjT1AwZkNzcWs0ZGRL?=
 =?utf-8?B?NGtFQVZlUEFGOXk5d3VGWGRCNktKVGplMGUzTllXdkpyajU2cDdpajdMZFZQ?=
 =?utf-8?B?NW4zZUhUQWxPcVY2UDYxYXZ3K0RNZHlTTzFHZndLYVFzTzN6eUlxUHpyWXBE?=
 =?utf-8?B?MENIZ3NobE1MMHRyV1IxZ3lwckFXWnpDS2NUWGQzSzg5c0dBSFdSaXBGM1BE?=
 =?utf-8?B?VE81LzFVME9PaGE3S2gySkk0cmFiRUcvcUxYdHFkcUpvdWd0OUhkMkVZWUFR?=
 =?utf-8?B?TVJyRE9BakxKdWZ0K0MvWU9nMEFYL3Z6MW8xWk9ONXpyM0pEdnFVb1MvNDVo?=
 =?utf-8?B?MVFJYVRSUVVuZmJXTmpoNURneUVyOGMwNGJQV1RDdkdCRThuMXRSTEVnUWdH?=
 =?utf-8?B?MFk2RDJHeTVuc25hZW1waEhoNlVYTVBVQTJDQzFHdU9nMk9hVkpZa0ZGN2NE?=
 =?utf-8?B?WXh0UzZhcEtGQlJFaGlyWndrM0w1SXpqaEtvRmlqMTJFSXJiUW44ZEZON202?=
 =?utf-8?B?MU52R3JxYWlsWmkwMFE1RFhzSDRtQ3k4ZU1kL21yMEtpbVA5TzdiRFlUenhn?=
 =?utf-8?B?VGZCV1o2TldHcVVHbEUzZ3QyZGlMOGFtUlRDREJFQ29kckpTTjQ5VmZYVlB5?=
 =?utf-8?B?cGZwN1ppR2pHbzc0c3lXY0RPWEdQblJBRWI0WHp5eWYxV1RnWnZQU1lUeVBo?=
 =?utf-8?B?U2VUc1NjTjhPY0Flb2tkYUtGVHBFSU5heDZHdlozYWU5Z3l3VGlrODhyQjM5?=
 =?utf-8?B?eWFSMXYxWGt1WW55RnhtK016UGUzQStUM0J2SDgycjY2YWdmWkFSZ0htd05S?=
 =?utf-8?B?QlBMblNUTGl2NEVCVHJ2bkc3NkpiallvUStRdjlTbTNkZGN0UkdNaXR6OFlX?=
 =?utf-8?B?d3FVdTVaSXBjVmtCY2ZxcEcxRTNHcmlWOE1WaXY3M0NEeE9VNWRWVXhpWm1y?=
 =?utf-8?B?K3loWEZLUEpCbW9ZYXUvS2lTczJFTHpVQ3hmaFZYSkhFT0hOWXI3TEttOUI0?=
 =?utf-8?B?Y1U4SVBkSWp6MkJYcjZ5Y2hkb3lXZ0lQanNlazgrRHc5aXhtbzdWVi9NU2tq?=
 =?utf-8?B?YnNrRjNZN1dLSmJsWlZGeHRhS3U2SnJhV0xxMGt1bDJVS3M4Y3ZLcmFkWWl3?=
 =?utf-8?B?UExDeDJYL2JjblVhUzlsL2FhbWFsOXUzOVc2V0tSdkFLWldkZHFmZ2toUXlx?=
 =?utf-8?Q?qAyCZrAP5S60CCm/91KzYXjtK1BOiA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?allvOVNNb2R3di9sK1Y0RzdDRWZmVThPcWM4d3FqdmpydXhsY2pHYWN3cFk2?=
 =?utf-8?B?czZUSUJvV3BMaXhQY0owNnJqZUFZdk80Nmw4UXVpTjlLNld2U01nSDIrZkhS?=
 =?utf-8?B?UmRZVHQ5Q3liZCtnQmJwU0xMcTRpengrYUtJVEljZVc0UmppM1crMERsTUpQ?=
 =?utf-8?B?Q1hma1YvSHN1NWFLVENCREJpbi9QcEFVNFI0UWdRbFlJMEVsV3pqMXlqMkQ0?=
 =?utf-8?B?R0daN09nYUVQSTRqdk1Nc3VmWnNKWHFocmJOaDNYS2YyeEMrVGVSSzNDcnUz?=
 =?utf-8?B?dmcxTHRoSkVEVTI5M0xRcFh6WnRra21RUFhTUzhLdjFxcVQybjBvWksvK21O?=
 =?utf-8?B?dTYrMVlsVEJBdGtOTTQzdjlPa2NVZ0tnWXNDYjRHTktRUlBKeWxGU0pxV0FX?=
 =?utf-8?B?MnF5M0V5ZFlXR05UTjhSaGhuMEJEaWpaMGhnWW50cTNjQXdjWlVFbWg1OW9Y?=
 =?utf-8?B?WGlxUUJXSTh2UEFUQ0J1ekpxUkZ2empPYjQvbkhsL0NUVmtNVlZOdy9iSlp5?=
 =?utf-8?B?UEJ6M3UzZmpyR1gwaUxwanlsbk42aVdJK1lDcmJmTU95ZmtFelF2cnZXSnVJ?=
 =?utf-8?B?K1RPQ3Y4STNrelJheWx4a05TajFBTVRSOFBpZ0VDRXlyTmFXQ0swYnNnbzU2?=
 =?utf-8?B?MGUwakwrKzZ3YzJjaGljYUhwTURuaE9WUXR1a3R0RzhGNWtIYng3R1B2OHhH?=
 =?utf-8?B?VjNPTmFERUFqZTQ0eURuS1gxK29leWdyMFhGaFlyRWZ5VmdUaWxoeW9mZHFa?=
 =?utf-8?B?OS9MQjZaR1ZlemxsbHJqcUgwZWFKU0tYUjVzam5xempHN1pGMWxTM0tUSnAv?=
 =?utf-8?B?Vm15NGJMcDAycmZsSDZrcGQ5RjZqaTc5czA5TU5Vb2E2YjBibWt0ZXdnSjJw?=
 =?utf-8?B?L2dpTEVwbG1WVzZHSUt2NGFrdXRKRmVzWXJZUkY5Ym1SMjBodmw0UmFpMU1w?=
 =?utf-8?B?c1pjWnZsYjE3a3B0Rm1nekZTUzRGVytKVkpvanU5MjVkZEkwbWZDQis5S1hk?=
 =?utf-8?B?Q2tJQUNTVXgycTE3bFZRL0JFcC9ETEdVNmpJbFpnajUrS2RZb2NxbGRZd0hn?=
 =?utf-8?B?cWxJeUYzeXZKZkRHVm5ua0U3T2RvMkgxcGkxRExRd3VuQ1U3MVNqN2x2L1o0?=
 =?utf-8?B?WkJzb1VWSHo3cStIbE9kak0vNEExaFlUalNCaVVZci9zdDFBaUhPcnByYUd6?=
 =?utf-8?B?TUdlM2VXR1Ivd3crUzc5WnlxYzcvZG9tV2h1MTRQZStVc3pQYUg1RGZwRXRY?=
 =?utf-8?B?bEx3RkxKOTZibDBUM254UFcvNWRFNDBYTGEyRWdSZ0U2cXN4Y1dqNi9kTE1L?=
 =?utf-8?B?T2lqWnhraWVLeHNWMU5sRi9TSXBBL09CK0xFa3FuM1pYc0NrNTEyaERaWHQw?=
 =?utf-8?B?YW0zTzRsblNpenhlVzFvWHhJanFiU050YzNGYjdVc0NNQ2tzQ3Jhc2g3NVJk?=
 =?utf-8?B?dTFiYmprTTNxc3VhWURvdnYyTWpYanZjT01MV3B6bTBZYTRDRE1ieXJKMllo?=
 =?utf-8?B?NTZET0ZqN3JTOUtqMnh4dVJSbkFlTHZrRmpGcEp3RitBTmNUYTFQalJwN0to?=
 =?utf-8?B?Y2p6cHBaZkZXcXdQK1RXbVZCZEZJNlNhUVQyWldkNkxONFBCSmVub3BIbEVZ?=
 =?utf-8?B?aEZGUUtGaE5pZzJGRExTLzFJdWFxaFF3cTNHSVJZaDZyc0VycFhmcHF0T2tC?=
 =?utf-8?B?MUZFREpmR0tRdGI2U1hVQjNIcHlEc2JNK2RSOEFUNi9GSC9wMVdiajltc0Qx?=
 =?utf-8?B?UWxKYk9qSlBrMXV6VDVPSE1VOWN2bXh1OW90Nlc2TDAxUVB0OEd1bG1oZHdV?=
 =?utf-8?B?MFFibFZnSHJRMHpzSWNVR211WjlZYXEvL1NiR0FLdWc1UHA2c0tFTG1jUWFD?=
 =?utf-8?B?RjJyb2FaWUNXWmNuY3BYY3JBd3RJcWxkOUtXY1QrRzVjOU8vcytSbHovTVg4?=
 =?utf-8?B?c3dwTC9KaDlORll6SEcyVEhteGZrZ0N6aCtsWjVRQTdWb1lRS3Fzb21UY2NP?=
 =?utf-8?B?dmRMSU9PdkRDRzFGSlFjU3B5bUhCSWFGSzNkVnpNb1FQWVNtcHRzc3c1aFRt?=
 =?utf-8?B?WkxicG12Y3hQcjFCSWtKN3EwZFBEb2ttTXVyc3QxOTFMV1llNXVWUllZWGR0?=
 =?utf-8?Q?EduY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ae3e6-1e41-43c6-aa2c-08ddf9a2432e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 06:35:46.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8gcqRPbKFS38EnB76+vHedw2ydzLBPFg4Zk3oSPTy4v8Ur+1fyT/oB08O6Cuc6F84PFF1H5dcS9mQGAnTTIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIgyMuaXpSAxNDoxMw0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBQ
Q0k6IGlteDY6IEFkZCBhIG1ldGhvZCB0byBoYW5kbGUgQ0xLUkVRIw0KPiBvdmVycmlkZSBhY3Rp
dmUgbG93DQo+IA0KPiBPbiBNb24sIFNlcCAyMiwgMjAyNSBhdCAxMDozNzo0MUFNICswODAwLCBS
aWNoYXJkIFpodSB3cm90ZToNCj4gPiBUaGUgQ0xLUkVRIyBpcyBhbiBvcGVuIGRyYWluLCBhY3Rp
dmUgbG93IHNpZ25hbCB0aGF0IGlzIGRyaXZlbiBsb3cgYnkNCj4gPiB0aGUgY2FyZCB0byByZXF1
ZXN0IHJlZmVyZW5jZSBjbG9jay4gSXQncyBhbiBvcHRpb25hbCBzaWduYWwgYWRkZWQgaW4NCj4g
PiBQQ0llIENFTSByNC4wLCBzZWMgMi4gVGh1cywgdGhpcyBzaWduYWwgd291bGRuJ3QgYmUgZHJp
dmVuIGxvdyBpZiBpdCdzDQo+ID4gcmVzZXJ2ZWQuDQo+ID4NCj4gPiBTaW5jZSB0aGUgcmVmZXJl
bmNlIGNsb2NrIGNvbnRyb2xsZWQgYnkgQ0xLUkVRIyBtYXkgYmUgcmVxdWlyZWQgYnkNCj4gPiBp
Lk1YIFBDSWUgaG9zdCB0b28uIFRvIG1ha2Ugc3VyZSB0aGlzIGNsb2NrIGlzIHJlYWR5IGV2ZW4g
d2hlbiB0aGUNCj4gPiBDTEtSRVEjIGlzbid0IGRyaXZlbiBsb3cgYnkgdGhlIGNhcmQoZS54IHRo
ZSBzY2VuYXJpbyBkZXNjcmliZWQNCj4gPiBhYm92ZSksIGZvcmNlIENMS1JFUSMgb3ZlcnJpZGUg
YWN0aXZlIGxvdyBmb3IgaS5NWCBQQ0llIGhvc3QgZHVyaW5nDQo+IGluaXRpYWxpemF0aW9uLg0K
PiA+DQo+ID4gVGhlIENMS1JFUSMgb3ZlcnJpZGUgY2FuIGJlIGNsZWFyZWQgc2FmZWx5IHdoZW4g
c3VwcG9ydHMtY2xrcmVxIGlzDQo+ID4gcHJlc2VudCBhbmQgUENJZSBsaW5rIGlzIHVwIGxhdGVy
LiBCZWNhdXNlIHRoZSBDTEtSRVEjIHdvdWxkIGJlIGRyaXZlbg0KPiA+IGxvdyBieSB0aGUgY2Fy
ZCBhdCB0aGlzIHRpbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jIHwgMzUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggODBlNDg3NDZiYmFmLi5hNzM2MzJiNDdlMmQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNTIs
NiArNTIsOCBAQA0KPiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfUkVGX0NMS0VOCQkJQklUKDIzKQ0K
PiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfUEhZX0NSX1BBUkFfU0VMCQlCSVQoOSkNCj4gPiAgI2Rl
ZmluZSBJTVg5NV9QQ0lFX1NTX1JXX1JFR18xCQkJMHhmNA0KPiA+ICsjZGVmaW5lIElNWDk1X1BD
SUVfQ0xLUkVRX09WRVJSSURFX0VOCQlCSVQoOCkNCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lFX0NM
S1JFUV9PVkVSUklERV9WQUwJCUJJVCg5KQ0KPiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfU1lTX0FV
WF9QV1JfREVUCQlCSVQoMzEpDQo+ID4NCj4gPiAgI2RlZmluZSBJTVg5NV9QRTBfR0VOX0NUUkxf
MQkJCTB4MTA1MA0KPiA+IEBAIC0xMzYsNiArMTM4LDcgQEAgc3RydWN0IGlteF9wY2llX2RydmRh
dGEgew0KPiA+ICAJaW50ICgqZW5hYmxlX3JlZl9jbGspKHN0cnVjdCBpbXhfcGNpZSAqcGNpZSwg
Ym9vbCBlbmFibGUpOw0KPiA+ICAJaW50ICgqY29yZV9yZXNldCkoc3RydWN0IGlteF9wY2llICpw
Y2llLCBib29sIGFzc2VydCk7DQo+ID4gIAlpbnQgKCp3YWl0X3BsbF9sb2NrKShzdHJ1Y3QgaW14
X3BjaWUgKnBjaWUpOw0KPiA+ICsJdm9pZCAoKmNscl9jbGtyZXFfb3ZlcnJpZGUpKHN0cnVjdCBp
bXhfcGNpZSAqcGNpZSk7DQo+ID4gIAljb25zdCBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcyAqb3Bz
Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTE0OSw2ICsxNTIsNyBAQCBzdHJ1Y3QgaW14X3BjaWUg
ew0KPiA+ICAJc3RydWN0IGdwaW9fZGVzYwkqcmVzZXRfZ3Bpb2Q7DQo+ID4gIAlzdHJ1Y3QgY2xr
X2J1bGtfZGF0YQkqY2xrczsNCj4gPiAgCWludAkJCW51bV9jbGtzOw0KPiA+ICsJYm9vbAkJCXN1
cHBvcnRzX2Nsa3JlcTsNCj4gPiAgCXN0cnVjdCByZWdtYXAJCSppb211eGNfZ3ByOw0KPiA+ICAJ
dTE2CQkJbXNpX2N0cmw7DQo+ID4gIAl1MzIJCQljb250cm9sbGVyX2lkOw0KPiA+IEBAIC0yNjcs
NiArMjcxLDEzIEBAIHN0YXRpYyBpbnQgaW14OTVfcGNpZV9pbml0X3BoeShzdHJ1Y3QgaW14X3Bj
aWUNCj4gKmlteF9wY2llKQ0KPiA+ICAJCQkgICBJTVg5NV9QQ0lFX1JFRl9DTEtFTiwNCj4gPiAg
CQkJICAgSU1YOTVfUENJRV9SRUZfQ0xLRU4pOw0KPiA+DQo+ID4gKwkvKiBGb3JjZSBDTEtSRVEj
IGxvdyBieSBvdmVycmlkZSAqLw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteF9wY2llLT5p
b211eGNfZ3ByLA0KPiA+ICsJCQkgICBJTVg5NV9QQ0lFX1NTX1JXX1JFR18xLA0KPiA+ICsJCQkg
ICBJTVg5NV9QQ0lFX0NMS1JFUV9PVkVSUklERV9FTiB8DQo+ID4gKwkJCSAgIElNWDk1X1BDSUVf
Q0xLUkVRX09WRVJSSURFX1ZBTCwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJ
REVfRU4gfA0KPiA+ICsJCQkgICBJTVg5NV9QQ0lFX0NMS1JFUV9PVkVSUklERV9WQUwpOw0KPiAN
Cj4gVGhpcyBzaG91bGQgYmU6DQo+IA0KPiAJaW14OTVfcGNpZV9jbGtyZXFfb3ZlcnJpZGUoaW14
X3BjaWUsIHRydWUpOw0KPiANCj4gcmVmZXIgYmVsb3cuLi4NCj4gDQo+ID4gIAlyZXR1cm4gMDsN
Cj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTEyOTgsNiArMTMwOSwxOCBAQCBzdGF0aWMgdm9pZCBpbXhf
cGNpZV9ob3N0X2V4aXQoc3RydWN0IGR3X3BjaWVfcnANCj4gKnBwKQ0KPiA+ICAJCXJlZ3VsYXRv
cl9kaXNhYmxlKGlteF9wY2llLT52cGNpZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9p
ZCBpbXg4bW1fcGNpZV9jbHJfY2xrcmVxX292ZXJyaWRlKHN0cnVjdCBpbXhfcGNpZQ0KPiA+ICsq
aW14X3BjaWUpIHsNCj4gPiArCWlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrKGlteF9wY2llLCBm
YWxzZSk7DQo+IA0KPiBKdXN0IG5vdGljZWQgdGhpcyBkaXNjcmVwYW5jeS4gJ2lteDhtbV9wY2ll
X2VuYWJsZV9yZWZfY2xrKCwgZmFsc2UpJyBpcw0KPiBlbmFibGluZyB0aGUgQ0xLUkVRIyBvdmVy
cmlkZSwgdGhlcmVieSBlbmFibGluZyB0aGUgcmVmY2xrLiBCdXQgb25seSBmb3INCj4gaW14OG1t
LCB0aGlzIGhlbHBlciBpcyBjYWxsZWQgYXMgaW14OG1tX3BjaWVfZW5hYmxlX3JlZl9jbGsoKS4g
QnV0IGZvcg0KPiBpbXg5NSwgdGhlIGVxdWl2YWxlbnQgZnVuY3Rpb24gaXMgY2FsbGVkIGFzIGlt
eDk1X3BjaWVfY2xyX2Nsa3JlcV9vdmVycmlkZSgpLg0KPiBUaGlzIGlzIGNhdXNpbmcgY29uZnVz
aW9uLg0KPiANCj4gTWF5YmUgeW91IHNob3VsZCBqdXN0IGNhbGwgYm90aCBmdW5jdGlvbnMgYXM6
DQo+IA0KPiAJaW14OG1tX3BjaWVfY2xrcmVxX292ZXJyaWRlKGlteF9wY2llLCBib29sIGVuYWJs
ZSk7DQo+IAlpbXg5NV9wY2llX2Nsa3JlcV9vdmVycmlkZShpbXhfcGNpZSwgYm9vbCBlbmFibGUp
Ow0KPiANCj4gVGhlbiwNCj4gDQo+IAlpbXg4bW1fcGNpZV9jbHJfY2xrcmVxX292ZXJyaWRlKHN0
cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpDQo+IAl7DQo+IAkJaW14OG1tX3BjaWVfY2xrcmVxX292
ZXJyaWRlKGlteF9wY2llLCBmYWxzZSkNCj4gCX0NCj4gDQo+IAlpbXg5NV9wY2llX2Nscl9jbGty
ZXFfb3ZlcnJpZGUoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkNCj4gCXsNCj4gCQlpbXg5NV9w
Y2llX2Nsa3JlcV9vdmVycmlkZShpbXhfcGNpZSwgZmFsc2UpDQo+IAl9DQo+IA0KPiBhbmQgcG9w
dWxhdGUgdGhlIGNscl9jbGtyZXFfb3ZlcnJpZGUoKSBjYWxsYmFjay4NCkdvb2QgcHJvcG9zYWws
IGxldCBtZSBjbGVhbiB1cCBjb2RlcyBhcyB0aGlzLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+Cv
jeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

