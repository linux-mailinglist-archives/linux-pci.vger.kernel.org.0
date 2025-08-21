Return-Path: <linux-pci+bounces-34431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14557B2EDA7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D91888964
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 05:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C952D3ECD;
	Thu, 21 Aug 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdZzzHMf"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B342C21DE;
	Thu, 21 Aug 2025 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755051; cv=fail; b=cHkwCZiUA+MBcqMWiMzv6hKYiVW14ARKL8nxiVbgFkmvT+mCgS081HwGnWhua7wRdfl3A6VxUOdPE+hhxXpUwFijcg+HoLoRyTefVpsiO3f/E9UZ50576ehXUNXbVoy23/kIzPOispbg9sJolK19eDY80rqubgXYrsHr8BNJu/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755051; c=relaxed/simple;
	bh=kfaAhlYqapOgPP6A5w4LgAyaKGMBhTCjYpI2SOtrspU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKlJx73iB0sGp3qF1/+FsjkPab7qC+miBcFltmWWP9RQ6KGcOOmt3LmAlbIvhjU62T+Khe91uIxVHsUifH/Od9U3gmOszjP8vM9EPIZ5oLIIYLaB24Wc8ynxodWD74Sw/aUHRc7eqKHKnyMnsyGvU0RNQ9cKZuR4qCDkQLaRXwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PdZzzHMf; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbxInS6ln/3aaINTv1CmK1KNiXm9QLFguYvPy5bO74JBfB9KYWlxkEPdKXu5xFhqCg5v3urXvPg4YbUje6WtleqdyUCmuAJWyOgtpm/DtYn2tgu02Q+IOfMkBPqrTWDrUds/aL5tVRnE2bMVkLJLUVgsXVNpEvrpzzj4Lyq5NPdmC8riHsqE6MmgiQFkqaR/EMuoXBLMGmdzkOkTld2R/olZrWoW87E8yexf7oejpXoC7fvZKxlsOVUmGSMgpywBcP2THGksMyYj3EVkXOqp6154HNnuqDwzdXblKLAbCEFkV0pcGW/bi8lQOmqsr1KXctVjXSQh1qHq83QORL78XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfaAhlYqapOgPP6A5w4LgAyaKGMBhTCjYpI2SOtrspU=;
 b=cIrPy8YoVLBb8TpykVGGsKIiXLneZRZmyZDmk1OY7dnXhGC99WVZ9R9hSO9Nkw8l3FszZFwT2MoWy7mpJP6KGduUGbuzrxgFLJ9F+N2kf+ME9TFjgjpAzrM7hT9eHVXMYAzLi1sozbahPSjvPM3ucP6iXk9DD0YdkzSJz1Fz40okxBExpKouxMKsOdmVu4jSEiBLMKYEo1nya3NGkvw7xXG+uc2JyTUvniI3ut80llNah20QHJF6Wb2IG4G6x44GS7iNkKGFmRa4K4Rd1fYUet6is8BMrcgkeLGucA1gqOhHaeh0MzSI5pdK5CNs4Gq3ojrTUCmY2lrFDJivUVdrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfaAhlYqapOgPP6A5w4LgAyaKGMBhTCjYpI2SOtrspU=;
 b=PdZzzHMfftF2oWeHP1PGF+VUEgTyLybM0Fwd6G772UbCl2cMDjvA3ZFOB0BoE7eLAly4/8T0YUW1MU6ena4Lhg7yYQ4yExhNFGM5ieD387WkCHFJpIrEfL79k7wvNntgJNXKTzT15hNVSe4gtrltpgNLd09Eywt/Ge9yB8xpC2oMzBws3RV9BJjyrYQoA9zo1W4OxM4nmo1r38cxGegqMXJ3PGd9oQngGCmgbwSpHM/VTkNM4/KL9TvFUCy19LH5NtV0Ck9Pcda4AO51PdxOH0Lxl81Q/Fn++h1LXEZZoqZwGBdEM9df8M4BhWaggEXe/AyFVrQaWTIE58Iop9Tj1w==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PR3PR04MB7418.eurprd04.prod.outlook.com (2603:10a6:102:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 05:44:06 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:44:06 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Topic: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Index: AQHcEBJEElOYRUyYLku2WlVlqYn0A7RqXsgAgACIg0A=
Date: Thu, 21 Aug 2025 05:44:05 +0000
Message-ID:
 <AS8PR04MB8833589654705528BB7BA6648C32A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250818073205.1412507-2-hongxing.zhu@nxp.com>
 <20250819192838.GA526045@bhelgaas>
In-Reply-To: <20250819192838.GA526045@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PR3PR04MB7418:EE_
x-ms-office365-filtering-correlation-id: a351caaa-2751-4fe9-6872-08dde075be05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dWRpZVA3aUtOWm50YXJmb1R4UjZiRHRscTkwUTBqQzBDcEtrR3l1VERLbTRy?=
 =?gb2312?B?NFEwZGVnNU9NUHE1OUwwdXY5ZkFzOEYxUm13Q1hZUDVvQzArT1hHZis4UDdN?=
 =?gb2312?B?MEtoTk9tbjZzWHZQMmJ3L0JQNm02SG00dFZZZjZBdC8zT2d6UUQzaDVsRmlN?=
 =?gb2312?B?Y0ZtK24wQTB4OXZkWGtrUzQ4TEx3dFNQSlQvL0duS3E2WGdjOW1vMEswYVk2?=
 =?gb2312?B?OHRITWREdkRuS05vOTE3ckpOZThGZ1plWWZ4QmNQSm4zQy9kNHdsTHBFZ3RB?=
 =?gb2312?B?VWVrbksza1d6ZWVNc3A1K2V1d1RDRWhjbkVpczZWNjRKRk1YRkhUeUQwUnRK?=
 =?gb2312?B?SjBvMDd3UWpEREd2NzNTMENCSVdYbkhidGMveFk0MVBmZ2cwemZxcVVseE9l?=
 =?gb2312?B?bGdWZUh0QlpCVHFtaEVZODl1VEVWZ21GSHdudU9TUzg1Z29JYnJYdktiQTdT?=
 =?gb2312?B?eEFCbmZ1WVN4SUhWSS9WdXRoQlZLdkdXb0R0SXRpRlZxdGthdWlTNUdkSkJo?=
 =?gb2312?B?L3lJYXFoaUdIUUhpclJ0d3NhVmRFZE1scW9EYnF5b1hoc3ZhaGs0WFExcFlh?=
 =?gb2312?B?NmdPTXJlRXFaRm5vSkljWDVlU1dQRDBkN1Eza0xRK1dOZjk1QWdEN053TmRM?=
 =?gb2312?B?Q3MxTmFmTzUwTElnMEc5RDVyZGtzSmtFUFBtcnlCUCtacjBqd3lISSt0cUxH?=
 =?gb2312?B?MURCZmJqK1ZhU01FOWFHZFBoNm0wRkpJaitkZzJLWXNRY1Iyc3pLSzhMdlpm?=
 =?gb2312?B?MVg3OVlSNXdydE1vcWI4UXFTN2lPV25ycmZEeFBWY2UwSEcyY2lDZkhsamNh?=
 =?gb2312?B?UENvTmJpOWNiT1prNUxJdVR6b0FzaXV5V1AyQXRrWGpKS3FuK2hTaHpnc3dW?=
 =?gb2312?B?TU5IVEdmR05FT1E2bVpockN1b0VNRXJEWFJzUDBnZk93eXU4bG5YYzI4Y0Fr?=
 =?gb2312?B?L1dPSzBaNEt5RjM1anFMQ3hUVzI0MXllMDZwYTRJcWhyOE02cU93aWQ0OXRn?=
 =?gb2312?B?MXdUNUMzN3V4MUZ5Y0x5OUszdE9OWkpHUWtycDhEUENEZW11b25yRkZsYnBk?=
 =?gb2312?B?dDVVaHI4YjdzUVNHbGJUUzFMRGJVcEFFd3RPTWRVdVFBL2xHb3hFM3pOMENX?=
 =?gb2312?B?NFdDYmRkVmFrVEtmZXR1SjBwMGIvZWVycEtKclJXR2lOcUVPYXdUTE1KQjEv?=
 =?gb2312?B?amtJUkczeVRpU0Y3Q0VOR1VpVWx0VC9Sc3dtbGcyMDZqSFAreXlibVdyWDBE?=
 =?gb2312?B?V3dqT0pqL3pUTk9EL2hKamZWMmh3RlBLU0x5b3psazR3dVllSFI2b2UvL2tS?=
 =?gb2312?B?cVY0N0twRXRZWDhYOEFwbk5MWXYrd0U0V3BGRytVNzJmYXpCNzVQQlN0NkVi?=
 =?gb2312?B?V3JweHloemFVK1dna0RCV2Z2alFBb1I2WHF3TFY2MjNIUjRlenJuZ0huTitK?=
 =?gb2312?B?SnhDanplU3J2aVpoQ29XYjNRd3hjY3pMeitScDY5NElpVkxadzFEbXpxUTdo?=
 =?gb2312?B?NFZiK3dxNGVDdUM2clg4OFVmTGFPTnRqOEVSUkZQTUhjZEpxRTZTQkxveUhw?=
 =?gb2312?B?d2dzSFF6UjJpMDBVL01jN1pxSlB0UzRsd2l2L2ZZWXFMMkdvYVVscnJGYWlU?=
 =?gb2312?B?akE2T2xRUFZ0T2lKRitXRXVUSmxITTFFdXp5UGtMNFZYQVdXYWovemVHNlAy?=
 =?gb2312?B?MW4xYTk3TklXUUhNejRVenVPM0NXMkFUTmo3TEVPOFhFYXloWDdQb3hLYXJh?=
 =?gb2312?B?ZWd5aXJDWmVQOE1aaXFTVGdsMWN6VUFSZ1c1Y09mNzNYWXhBd2hnOTI0R1p1?=
 =?gb2312?B?U1N3RlZ2cFI5NHV3QVlDU20xZ2FEM1VzVmx6L1ZYTk1kLzVFNG5XWXFHKzdE?=
 =?gb2312?B?R2t6RkRaOUdTSFJyVGxINFV1Q3l5V09BWFpIbzJBSUhiYnpZVHl4MjQxU09L?=
 =?gb2312?B?NUZEOE9FQjRxODhoSUM5dk40WnJ2eE52YXc3amVUTnJvYS9xVzRjZzk0TGs1?=
 =?gb2312?B?cE0yc1Y0MWJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SmJPTzRmZHBGeE9ZSnFaVTBiMEU4RVBJbVcyUmR6SkVHRU0rNVBORjlKdmpv?=
 =?gb2312?B?UlZQdHZmV2k1RFVsWVhUL1RDOUhSeWdleXlWRVEzSUppaGFDYS9VcFFyOG52?=
 =?gb2312?B?bEZXVjMxa0QzTGpxQ2tENUxSRUV0R2dlcWc4WXZoTmJVSENFUUEyd1FPdEcw?=
 =?gb2312?B?dlJkVkV0dWVqQzcwdnF0dFB0UEdkekVDYVRidVd4VWxtNFd4Rkg5L21zVVli?=
 =?gb2312?B?TFpIOGVrZUZxWW5Md21lMnEzeHNrSE9ZNi9Pd2pLYm9zWEJVb3Q0YWt6eStX?=
 =?gb2312?B?Q3haUEdMM0NkQ0l5VG1IWTVFWVRNbWpCRGh3SVdMQWw3d3JXNC84MHQ3Vy9p?=
 =?gb2312?B?cURVa2JLY2E4Q3hkVTRSZ1hDeTltd3lwR2tTSWhidktKVEFHOVROZnp0Mmxk?=
 =?gb2312?B?SjdlWC9xL1lGWlRmQlVvd1Vua2tTS0dPMlRxQndrSkxLYnBNL3N6RExUZGhB?=
 =?gb2312?B?L1JibEwzakNPR1ZIRUxtaldkSldBVElZWDJOelBxYkVuWVIxQ0o0SnJCVkxV?=
 =?gb2312?B?Slc2N2JrSDZhWVhGeWFpemtEYVpxUDRyTWZ5ejZoUXhObENoZ2FhYjBOR1ls?=
 =?gb2312?B?ZllJaGh0YjdTS1RMVnFqSHVRejltK29hUnJJcTZKNmZ0OTI2NU9NTHdiQkpv?=
 =?gb2312?B?TVJhODgvOWJpSjhZdWc3OWllMGFmbXNJcGhVNi9oZmNzRVZrSnhOMlh5dWRv?=
 =?gb2312?B?RU9YME9wSDFyQzNWeVVWZnRFNHdyd3lNUDg5eVlEVzQrMGlBc2VVQTRkYU0v?=
 =?gb2312?B?M29iZE1CVFZrM0VlMzE0ZC9iTnRBc1gzVXZJc0pDNUVqdk15R29za1dKZlVu?=
 =?gb2312?B?RG5NcTJOWC9GbmVMTEZRN1UwNnc0MjVUZUdJbVFEak9zc0tIOWl4RWMyMHlw?=
 =?gb2312?B?ZXc0SWo0UFROY1djWXlqV0h5djZwbGx3SktPTnQ0Z1ZXVWx3K1FFYXlDRnl5?=
 =?gb2312?B?cnp6SzNCTVBFWDhnd0JSY2VzalFjL09Ka3U5bkFmQzU4dkxuNi80WXVWUnJU?=
 =?gb2312?B?ODNnZktxek1Cd1U1R2tzQ2dJdHdROFVYTmdsb1JIb05UUUo4ZDF3ejEvQjBj?=
 =?gb2312?B?aHE3SU5hTTlyRUMxY0V6aFFwSTV1S2ZQQ1Ewb29BWEU1WVRINklFTnZWWkJ6?=
 =?gb2312?B?WWNvK0thYXU4aFBjV0xsV3Y2aHZQbHhpY2habmNyUUFxdnZicC94dnhTcHZW?=
 =?gb2312?B?dDZXY3VlT1FlMHYwTkVtZTBzcW5vZWFpZk9xSE1wTStPMVRHQlQ4S0x3S3dL?=
 =?gb2312?B?WURWZ050Qmg3V3hzTnF5Y0pZcUsvOWN2MmJKWWRZWXdwWEZGQ2xsMlp0QWo3?=
 =?gb2312?B?cUJtRHU4K0hsQVVMNlV1L3RWN2JpQzZ3RmdKT0tESVpMZjBBNWwrWUlESy95?=
 =?gb2312?B?ak9UcnJZdS9IV0xleFl1V205dlFiNmlueGNKNzRvbzZHZzk5Njh0bVRmSk9I?=
 =?gb2312?B?YytXZmtka3BiOWlEMUxSaUM0eVNQNmRaZW5yWnpxS1Y5U1VTTkVWUFZHYzAr?=
 =?gb2312?B?NUo2SWRYV0U3bjFkOXB0NzZGRUt5SU9oZzJ1OUtsRFR1dk83SEpzSWFtSVAv?=
 =?gb2312?B?UmdicEw0U0xyOERqRngvYUpnT2JWNU1EZTFkQzUvRkp0aGNCc25zNzJWdDRL?=
 =?gb2312?B?RFkzTjRHUy9ZQmJMbnJuOUFaMk1iOXltWEpMN0tmZFQ5OWYzYmttSXI5ZjFX?=
 =?gb2312?B?T1c2aStGR0dNWnFyUno1TGgrTld3UHkrdkVBZTZiMVh5VHRXUFhjVXZkdFEw?=
 =?gb2312?B?QVlJdFpvUmFCc3M2ZklKL2JFa3RBK2N3SjFITUlIQnh4amZrdkpHaWsycWla?=
 =?gb2312?B?ODN3cDVnNWFxcmdFa1c0MktWS1drTWttR3l1anEyTmpMWHgwVmdmYWpCWnFs?=
 =?gb2312?B?Tm85OWlNWWxsVUYwc1Y3WFBQVDd4NGdXSE1DUkVBUkpXc1EvZjZqMDRKb1dI?=
 =?gb2312?B?M3VEd1NnMjRIcG9LUnNjR0IwbEI5clRSS1NSRUdGcWJQOWFwNTlpT1Fsak96?=
 =?gb2312?B?S3VuUUo2Z016MU1EdEpYMkdmNTlwTXRCU200UVBWQ3FiYitIOFhOV0Q5RVVu?=
 =?gb2312?B?VzMxT2VFWFFGRnhXNGlMNXBkL3VjWEgweWFBUVd6U25CVW55aXFNUUMwcU5w?=
 =?gb2312?Q?rO+k=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a351caaa-2751-4fe9-6872-08dde075be05
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 05:44:05.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PloN0F+ijdt0l3XDKINKa96A4HAzXwDTuWAS3YwxmeBzI4o1IPo+34pB0gImAl0jYtY2S99f0oP8HAXOo3fANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7418

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jjUwjIwyNUgMzoyOQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRVNF
TkQgdjMgMS81XSBQQ0k6IGR3YzogRG9uJ3QgcG9sbCBMMiBpZg0KPiBRVUlSS19OT0wyUE9MTF9J
Tl9QTSBpcyBleGlzdGluZyBpbiBzdXNwZW5kDQo+IA0KPiBPbiBNb24sIEF1ZyAxOCwgMjAyNSBh
dCAwMzozMjowMVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBSZWZlciB0byBQQ0ll
IHI2LjAsIHNlYyA1LjIsIGZpZyA1LTEgTGluayBQb3dlciBNYW5hZ2VtZW50IFN0YXRlIEZsb3cN
Cj4gPiBEaWFncmFtLiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUgdHJhbnNmZXJyZWQg
dG8gTERuIGRpcmVjdGx5Lg0KPiA+DQo+ID4gSXQncyBoYXJtbGVzcyB0byBsZXQgZHdfcGNpZV9z
dXNwZW5kX25vaXJxKCkgcHJvY2VlZCBzdXNwZW5kIGFmdGVyIHRoZQ0KPiA+IFBNRV9UdXJuX09m
ZiBpcyBzZW50IG91dCwgd2hhdGV2ZXIgdGhlIExUU1NNIHN0YXRlIGlzIGluIEwyIG9yIEwzDQo+
ID4gYWZ0ZXIgYSByZWNvbW1lbmRlZCAxMG1zIG1heCB3YWl0IHJlZmVyIHRvIFBDSWUgcjYuMCwg
c2VjIDUuMy4zLjIuMQ0KPiA+IFBNRSBTeW5jaHJvbml6YXRpb24uDQo+ID4NCj4gPiBUaGUgTFRT
U00gc3RhdGVzIGFyZSBpbmFjY2Vzc2libGUgb24gaS5NWDZRUCBhbmQgaS5NWDdEIGFmdGVyIHRo
ZQ0KPiA+IFBNRV9UdXJuX09mZiBpcyBzZW50IG91dC4NCj4gPg0KPiA+IFRvIHN1cHBvcnQgdGhp
cyBjYXNlLCBkb24ndCBwb2xsIEwyIHN0YXRlIGFuZCBhcHBseSBhIHNpbXBsZSBkZWxheSBvZg0K
PiA+IFBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMoMTBtcykgaWYgdGhlIFFVSVJLX05PTDJQT0xM
X0lOX1BNIGZsYWcNCj4gaXMNCj4gPiBzZXQgaW4gc3VzcGVuZC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDMxDQo+ID4gKysrKysrKysrKysr
Ky0tLS0tLSAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggIHwN
Cj4gPiA0ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBpbmRleCA5NTJmODU5NGI1MDEyLi4yMGE3
ZjgyN2JhYmJmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTEwMDcsNyArMTAwNyw3IEBAIGludCBk
d19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiB7DQo+ID4gIAl1
OCBvZmZzZXQgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURfRVhQKTsN
Cj4gPiAgCXUzMiB2YWw7DQo+ID4gLQlpbnQgcmV0Ow0KPiA+ICsJaW50IHJldCA9IDA7DQo+IA0K
PiBJIHRoaW5rIGl0J3MgcG9pbnRsZXNzIHRvIGluaXRpYWxpemUgInJldCIgYmVjYXVzZSBpbiBl
dmVyeSBjYXNlIHdoZXJlIHJldCBpcyBzZXQsDQo+IHdlIHJldHVybiBpdCBpbW1lZGlhdGVseSBp
ZiBpdCBpcyBub24temVyby4gIFdlIHNob3VsZCBqdXN0IHJldHVybiAwIGV4cGxpY2l0bHkNCj4g
YXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gYW5kIHNraXAgdGhpcyBpbml0aWFsaXphdGlvbi4N
Cj4gDQpZb3UncmUgcmlnaHQsIHRoYW5rcy4NCj4gPiAgICAgICAvKg0KPiA+ICAgICAgICAqIElm
IEwxU1MgaXMgc3VwcG9ydGVkLCB0aGVuIGRvIG5vdCBwdXQgdGhlIGxpbmsgaW50byBMMiBhcw0K
PiA+IHNvbWUgQEAgLTEwMjQsMTUgKzEwMjQsMjYgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2ly
cShzdHJ1Y3QNCj4gZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0K
PiA+DQo+ID4gLQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFs
LA0KPiA+IC0JCQkJdmFsID09IERXX1BDSUVfTFRTU01fTDJfSURMRSB8fA0KPiA+IC0JCQkJdmFs
IDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQsDQo+ID4gLQkJCQlQQ0lFX1BNRV9UT19MMl9U
SU1FT1VUX1VTLzEwLA0KPiA+IC0JCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2Us
IHBjaSk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJLyogT25seSBsb2cgbWVzc2FnZSB3aGVu
IExUU1NNIGlzbid0IGluIERFVEVDVCBvciBQT0xMICovDQo+ID4gLQkJZGV2X2VycihwY2ktPmRl
diwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOiAweCV4XG4iLA0KPiB2YWwp
Ow0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gKwlpZiAoZHdjX3F1aXJrKHBjaSwgUVVJUktfTk9M
MlBPTExfSU5fUE0pKSB7DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBSZWZlciB0byBQQ0llIHI2LjAs
IHNlYyA1LjIsIGZpZyA1LTEgTGluayBQb3dlciBNYW5hZ2VtZW50DQo+ID4gKwkJICogU3RhdGUg
RmxvdyBEaWFncmFtLiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUNCj4gPiArCQkgKiB0
cmFuc2ZlcnJlZCB0byBMRG4gZGlyZWN0bHkuIE9uIHRoZSBMVFNTTSBzdGF0ZXMgcG9sbCBicm9r
ZW4NCj4gPiArCQkgKiBwbGF0Zm9ybXMsIGFkZCBhIG1heCAxMG1zIGRlbGF5IHJlZmVyIHRvIFBD
SWUgcjYuMCwNCj4gPiArCQkgKiBzZWMgNS4zLjMuMi4xIFBNRSBTeW5jaHJvbml6YXRpb24uDQo+
IA0KPiBJSVVDLCB0aGUgcmVhZF9wb2xsX3RpbWVvdXQoKSBiZWxvdyBpcyB3YWl0aW5nIGZvciB0
aGUgUE1FX1RPX0Fjaw0KPiByZXNwb25zZXMgdG8gdGhlIFBNRV9UdXJuX09mZiBtZXNzYWdlLg0K
PiANCj4gVGhlIExpbmsgc3RhdGUgdHJhbnNpdGlvbiB0byBMMi9MMyBSZWFkeSAob3IgdGhlIHN1
YnNlcXVlbnQgTDIsIEwzLCBvciBMRG4NCj4gc3RhdGVzKSBpcyB0aGUgaW5kaWNhdGlvbiB0aGF0
IHRoZSBkb3duc3RyZWFtIGNvbXBvbmVudHMgaGF2ZSAicGVyZm9ybWVkDQo+IGFueSBuZWNlc3Nh
cnkgbG9jYWwgY29uZGl0aW9uaW5nIGluIHByZXBhcmF0aW9uIGZvciBwb3dlciByZW1vdmFsIiBh
bmQgdGhlbg0KPiByZXNwb25kZWQgd2l0aCBQTUVfVE9fQWNrLg0KPiANCj4gQW5kIHRoZSBQQ0lF
X1BNRV9UT19MMl9USU1FT1VUX1VTIHRpbWVvdXQgaXMgdGhlIGRlYWRsb2NrIGF2b2lkYW5jZQ0K
PiBkZWxheSBmb3IgY2FzZXMgd2hlcmUgIm9uZSBvciBtb3JlIGRldmljZXMgZG8gbm90IHJlc3Bv
bmQgd2l0aCBhDQo+IFBNRV9UT19BY2siLg0KPiANCj4gSW4gdGhlIFFVSVJLX05PTDJQT0xMX0lO
X1BNIGNhc2UsIEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBjYW4ndA0KPiAqcmVhZCog
dGhlIExUU1NNIHN0YXRlIHRvIGxlYXJuIHdoZXRoZXIgdGhlIExpbmsgdHJhbnNpdGlvbmVkIHRv
IEwyL0wzDQo+IFJlYWR5LCBMMiwgTDMsIG9yIExEbi4gIFRoYXQgd291bGRuJ3QgYmUgc3VycHJp
c2luZyBiZWNhdXNlIHBlciBzZWMgNS4yLCAidGhlDQo+IExUU1NNIGlzIHR5cGljYWxseSBwb3dl
cmVkIGJ5IG1haW4gcG93ZXIgKG5vdCBWYXV4KSwgc28gTFRTU00gd2lsbCBub3QgYmUNCj4gcG93
ZXJlZCBpbiBlaXRoZXIgdGhlIEwyIG9yIHRoZSBMMyBzdGF0ZS4iDQo+IA0KPiBJIGRvbid0IGtu
b3cgd2hhdCdzIGRpZmZlcmVudCBhYm91dCBpLk1YNlFQIGFuZCBpLk1YN0QuICBNYXliZSBvbiBt
b3N0DQo+IERXQyBwbGF0Zm9ybXMgdGhlIExUU1NNICppcyogcG93ZXJlZCBpbiBMMi9MMy9MRG4s
IGJ1dCBvbiBpLk1YNlFQIGFuZA0KPiBpLk1YN0QsIGl0ICppc24ndCogcG93ZXJlZCBpbiB0aG9z
ZSBzdGF0ZXM/DQo+IA0KPiBJZiB0aGF0J3MgdGhlIGNhc2UsIHdlIHNob3VsZCBzYXkgdGhhdCBz
b21ld2hlcmUgaGVyZS4gIEFuZCB3ZSBzaG91bGQgc2F5DQo+IHdoYXQgaGFwcGVucyB3aGVuIHdl
IHRyeSB0byByZWFkIHRoZSBMVFNTTSB3aGVuIGl0J3Mgbm90IHBvd2VyZWQuDQo+IERvZXMgdGhl
IHJlYWQgaGFuZyBvciBjYXVzZSBzb21lIGtpbmQgb2YgZXJyb3I/DQpUaGUgcmVhZCBpcyBoYW5n
IGRpcmVjdGx5LCBubyBhbnkgZXJyb3IgbWVzc2FnZXMgYXJlIGR1bXBlZC4NCkhvdyBhYm91dCBh
ZGQgdGhlIGZvbGxvd2luZyBjb21tZW50cyBpbiB0aGUgUVVJUktfTk9MMl9QT0xMX0lOX1BNPw0K
IkFkZCB0aGUgUVVJUktfTk9MMl9QT0xMX0lOX1BNIGNhc2UgdG8gYXZvaWQgdGhlIHJlYWQgaGFu
Zywgc2luY2UgTFRTU00NCiBtaWdodCBub3QgYmUgcG93ZXJlZCBpbiBMMi9MMy9MRG4gb24gc29t
ZSBwbGF0Zm9ybXMuICINCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gPiArCQkg
Ki8NCj4gPiArCQltZGVsYXkoUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMDAwKTsNCj4gPiAr
CX0gZWxzZSB7DQo+ID4gKwkJcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQoZHdfcGNpZV9nZXRfbHRz
c20sIHZhbCwNCj4gPiArCQkJCQl2YWwgPT0gRFdfUENJRV9MVFNTTV9MMl9JRExFIHx8DQo+ID4g
KwkJCQkJdmFsIDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQsDQo+ID4gKwkJCQkJUENJRV9Q
TUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiArCQkJCQlQQ0lFX1BNRV9UT19MMl9USU1FT1VU
X1VTLCBmYWxzZSwgcGNpKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCS8qIE9ubHkgbG9n
IG1lc3NhZ2Ugd2hlbiBMVFNTTSBpc24ndCBpbiBERVRFQ1Qgb3IgUE9MTCAqLw0KPiA+ICsJCQlk
ZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4
JXhcbiIsDQo+IHZhbCk7DQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0K
PiA+DQo+ID4gIAkvKg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmgNCj4gPiBpbmRleCAwMGY1MmQ0NzJkY2RkLi40ZTViZjZjYjZjZTgwIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmgNCj4gPiBAQCAtMjk1LDYgKzI5NSw5IEBADQo+ID4gIC8qIERlZmF1bHQgZURNQSBMTFAgbWVt
b3J5IHNpemUgKi8NCj4gPiAgI2RlZmluZSBETUFfTExQX01FTV9TSVpFCQlQQUdFX1NJWkUNCj4g
Pg0KPiA+ICsjZGVmaW5lIFFVSVJLX05PTDJQT0xMX0lOX1BNCQlCSVQoMCkNCj4gPiArI2RlZmlu
ZSBkd2NfcXVpcmsocGNpLCB2YWwpCQkocGNpLT5xdWlya19mbGFnICYgdmFsKQ0KPiA+ICsNCj4g
PiAgc3RydWN0IGR3X3BjaWU7DQo+ID4gIHN0cnVjdCBkd19wY2llX3JwOw0KPiA+ICBzdHJ1Y3Qg
ZHdfcGNpZV9lcDsNCj4gPiBAQCAtNTA0LDYgKzUwNyw3IEBAIHN0cnVjdCBkd19wY2llIHsNCj4g
PiAgCWNvbnN0IHN0cnVjdCBkd19wY2llX29wcyAqb3BzOw0KPiA+ICAJdTMyCQkJdmVyc2lvbjsN
Cj4gPiAgCXUzMgkJCXR5cGU7DQo+ID4gKwl1MzIJCQlxdWlya19mbGFnOw0KPiA+ICAJdW5zaWdu
ZWQgbG9uZwkJY2FwczsNCj4gPiAgCWludAkJCW51bV9sYW5lczsNCj4gPiAgCWludAkJCW1heF9s
aW5rX3NwZWVkOw0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

