Return-Path: <linux-pci+bounces-36641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98446B8FB73
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D347AB1EA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE0C134CB;
	Mon, 22 Sep 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NkZXuuHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7D29408;
	Mon, 22 Sep 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532706; cv=fail; b=Z3mhBNgRCuws8W+tHzBiTRDevSaiDwbFxF+4K61mcoW2dPqJLtXJS0OUpNQ4W3fMDQb5GEoUWrU+bPX+cWdcS3yWoCKRMaEn2DvpGFZSUIdcmtLH9+WlSM9bA87etVK0VCnRvEdB+BNGoSsQekGk2rutDMBFPJzwM0YDKYsDE08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532706; c=relaxed/simple;
	bh=1oEatSfRvwp4Uinl7XEjnAiQ8pCnUWllf3qmgBtAd4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UU9+gNOCXCSGd7lVxZkR8O4Sy2H/iTcn933hni4/SV/xB1Ev6EazXHknuILlicnxiuYoF9l7zhoANlYnPFTyDAEdI03mCAzzABhlewxpS60CkRtZyP9Qqa2OrJ/DH2vDK1g2TXW5WvWw99w40dA88d9b+MjjTaWc5ZFLF/EVq7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NkZXuuHb; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTQ1YWr1ASZkXdeayNuMg2EKbgMHuMmRGQ+BRJXF3gneFbhub2oBDuUnx3lWxTDoUlgN0NM0BQHycwzScbElST1CLLai9m+qYmA2vie1bT6Xro3a8Dg4JtFpsQPKBrWo2ZL8cTB+++FYV8+LjQW6Ku/8654e1goL3CttTETCpUTqFMTiwRAfTnKByFFAlKBGLdsB5Radli46NR04bG8xWtg8nTpXnQbN4IYWZLElzQJZuN1pWf9THqdwpOTdWHZkNvEA0CnqKBbGaOTCmeYme9TsfrXCWTyV6yzlRA1x8UCOJditJdnfKRgTFk7RRAYOlgoW4KDyFq8vYpFt3NUECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oEatSfRvwp4Uinl7XEjnAiQ8pCnUWllf3qmgBtAd4k=;
 b=pecv2gWrxQW0x5NM2cj+pniktu4UGdaSn2rLug5QPK4pKNh6ZnbPI0h/ObXEUC8mgmXZOqMHUF09O9ksgFyMrU1ANFRcBkDQN89m+QbmrMZHeTvyEZx3xvGsv3UcRyg0OmwgxCcCk3QBuehqnaDLOtDhL76poxCxDw+/GiARp3hLQFDmwqEDpjB1n+5OW6NwUqXK/JMka128jL16q/z4zJOOZBqeU+Po5dWFtSB5H1VXiWGz2KolrCxvJD5bnVC3rzdyxZL6fF5kolGu/AOFAIo15SRmog1fSOIybtJUDoslcTQDDhjdHr7mZKPsXMj78PFxh/t8uA3iJzrk5tMx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oEatSfRvwp4Uinl7XEjnAiQ8pCnUWllf3qmgBtAd4k=;
 b=NkZXuuHbCm99lO0E8RmzhKfp5QNRVvOTmgEzZo223tByhFt12PHoA55E+gwk8m7D9JtRzJoUwoas0TzK1VOmOx7Quuq+k8eRcMJ7ZKBefFZVIEUCr4Mwot93F9JuUwxA2c/QfSnvVpAdragjxv5feQmg0/t+Aza65HeE1VrUwg6uAihMXzEPfyNND/xVLET0PSo7Qc4uNYZNYrR10JI0NHIIbOm0NewcEkeovofhsNthpAC16XM1CQZv33wtg0YSzlZWSyVgup3wjPajTiBDsfwKbZi3s5ogBvRvCGqyGn+xOsMZ4ZQx0ZtPQie5MGi9mizfx34AGKpyqEJi0J9t1w==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Mon, 22 Sep
 2025 09:18:20 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 09:18:20 +0000
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
Subject: RE: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
 existing in suspend
Thread-Topic: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Index: AQHcG9/1u0f50jbABE640+M7pBCkeLSbt/EAgANRQBA=
Date: Mon, 22 Sep 2025 09:18:20 +0000
Message-ID:
 <AS8PR04MB88335CEA526C3B5E957EF0C88C12A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-3-hongxing.zhu@nxp.com>
 <p4hqjnhpih2uy5hzf7llrd3ah7ov6sijkuqjecpvv5j2iqrsji@kxj5xwb7a5p4>
In-Reply-To: <p4hqjnhpih2uy5hzf7llrd3ah7ov6sijkuqjecpvv5j2iqrsji@kxj5xwb7a5p4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PA4PR04MB9248:EE_
x-ms-office365-filtering-correlation-id: 19ee9a8c-3321-4c38-3e0f-08ddf9b8f910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFdmSEp2bGI1SjdVUEtnR2FBUHhGVUFUQ09mSzRJY2VLbHJLKy9rTElKU1F3?=
 =?utf-8?B?Q0ZzSFpBRWxjcTlyNW9QakFaYUEwQjJmUDl2U1dmeUR5dnBMLytCajB0MFpu?=
 =?utf-8?B?eVpzc0lwUHNsWFdXdFJTMnhTZHpXdDc5cG50Q1lnMXowNkZjQWVZc1lIOGw3?=
 =?utf-8?B?SXoxZVZjaFNHQWsvaXNDMlNhcldVQnYxbVNDeEg2YjMwN0pIRDBqT3I5NGZu?=
 =?utf-8?B?aVJ2MmFXWTVBSGd2SmtKN0pIMmhnSWhTRUUyVnMwTlRQVlduN1Zwa0krbStn?=
 =?utf-8?B?S2ZOajVoUXBKeVdVeS9HRmxKQXNYMUs1U2ZZR1hWOXAwZkJiaUFWcmk2bkFw?=
 =?utf-8?B?ZEFBdTVxT0FSc3hFVlJsUzFFRVRhM051VmdlUXBMa0NneWxzditOa3hSRHFq?=
 =?utf-8?B?VlRabHVtUnpqMm9WZ2k5NmNxRjFodFB0VEhiOUN1WG1qdTN1Q1JpODF4L2dT?=
 =?utf-8?B?UEMyS01hc0RlRWVJRW9LS295TkRwLzFldnF3aTVqMGVEc0c1RjJGcEVXOFNZ?=
 =?utf-8?B?Z1lJVGZYczlmaWdoUEhDaUNFQVN2UFFMbGV3TndXdFNiZ0ZCUVZCR0ZDWldF?=
 =?utf-8?B?WEFuVXdJS1NFenhNMEFvNHExRVpsKzd0TXpSUWNjdXdpcklGZm1rOVhBanF5?=
 =?utf-8?B?NndtSmpTd1BKOEZTS1NZTkcwNGpkSmFaYlRoY2MxSVN1enA0YmFLZ3RreGtw?=
 =?utf-8?B?ZFRTdGxieWtuWEJLWjMvZUVNdWc0QkJ0SXZBUGpxTi9WbWZOWG9KREd6dWxW?=
 =?utf-8?B?akJmVGQybEMyR0xRalcwWDlTMCtCdml2aGp1U0FYUm95a1FjTWtLYnVidVdx?=
 =?utf-8?B?elp0TGNhdHd6WjkwMENMNVFFd2U1VjFibWtDVmJCa1hnWTFUNzF1bk40eHEx?=
 =?utf-8?B?ZE1Ld3NIM1FGQUNIR0pKSUZXNFMzWkQ0NG1QRVY4U3QvSDFvbExvZy9aRmNr?=
 =?utf-8?B?bE5qamp0SnJjalJJczNULzZaNDRDS0NYOVBkdzJ3cDRBc0QyZDFlS3JhSU4x?=
 =?utf-8?B?ZjFtb0pVTVVLY3ZSNG9KM2RvUEpHT2dabUxvSlRnaWkxaFN5TmpwRVUrcGdY?=
 =?utf-8?B?ZzlLcktXZnY0MnpyL3F1dzdHRkxaTWJxRlpvUk1zWmw5NkRtZHpwejRkMTgr?=
 =?utf-8?B?RUF6dVNOdFNQMHc2RUhQTmsvMWU4Si9sMTVWaVloMEcrMitwaHlqdUY3UlRK?=
 =?utf-8?B?R2QzV1E3QUk2MkZDeGVVVWQrMjlwVTdaUitoSENNWHhaaE1XdDBBSXBXMU1v?=
 =?utf-8?B?N1c3RUhIdlhudjIrUEl0RlZNUmh3YVdrb21HRGl0Vmp5bXk5cEU4c2hDZ1Ew?=
 =?utf-8?B?QjY0a0hGbFlqLy92dTIwNUkzSXlwMko2ZnV4Q0NsQTErMEczUEpqSEFKeXlW?=
 =?utf-8?B?SWE2cHdwdkUrbCtoS2xQcmVicnQ1ZXMzc1YveXgrajJ3OExLUVd4bGQyYlJq?=
 =?utf-8?B?RjRzeGdtcWIrU1huTVdvQmRqUE5VQ1ZlZDgvT2JkQmlqc0IwU1d1SEdFMklZ?=
 =?utf-8?B?RVo2VFY3QzZHUURmMi8wRU9TcWlmRml3VDVmQXNQVFdITUxnbUdlKzc1R3d0?=
 =?utf-8?B?UE1VSnVJTUcxMXpjQWN0RW1Sb3FiYTA3RHlpeG0rdjNuVm04Si9VTlB2WTY1?=
 =?utf-8?B?Qkk4VlJDMXhlcXFPd0FlUXNBdzdKLzYxRFplTHV1bnhTY2dISkYzRnhGS2Nh?=
 =?utf-8?B?d2xSMlIwOHFRUjdBZnNjWXJuTm90bXJ2ViswdGpyT2o5bG5CQWNXOFhnczkr?=
 =?utf-8?B?eEYyNkkvcVcwRkZWaVQ2RlV4S0R1aTdoUVQraDNrRnVoSUlPL3pPOUZjWDFt?=
 =?utf-8?B?VmhmRnI1NlNFYUI0amVONDlRUkN5QndreDJRNzhZV1dSbnBDZ0poQTgwOStU?=
 =?utf-8?B?UGpXcUpEYlNlalV6U05Keng3VFlUeDNNcVUrbFhoZTBWWDhZRDIxZGhtSTVo?=
 =?utf-8?Q?Li6BImjZbkE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjVDN2tBbGhnR2xVaGZDS3Zpc0NLSHVZRWZmWTFqMzQrSTE4Wnl5M1NqamFW?=
 =?utf-8?B?dythN2tVYm5zU0VtdVdpcmQxWktDM2JCLzIwWWZoZVE2MVpQL2VFOVpJSW5Q?=
 =?utf-8?B?TlNNdGNKTFd1L3pGS2pCQjdyUk05NlBQcGYyanZNN0Z6ZXpXTy8xRmxaUHRz?=
 =?utf-8?B?dWkzT1h3UlNOR1FDU3djN3JSeG4wTHk1SHgvbTlTeEZRNE5SeE5SUWxnVnZi?=
 =?utf-8?B?ZFNjdy9MVlEyOGxIYzg2bFJ3ODZmU28xaVo5M0NHUXoyd2xOR1N1VXhRMXpn?=
 =?utf-8?B?bTVLL1poRlA1Q3VJQ0ZlUFpmOXBQekxycklDQ2pWZ3VMYUZ1WkJ5d2M5K01F?=
 =?utf-8?B?a3VMbThuRUZ5eXdGbGdJMnhWMDRWUWxuMVlxSkFKY3ZMTW1jeUhSR1I0TXA0?=
 =?utf-8?B?S0QrT2xncjNHazRjM21oYTFiNlVCemZyRWVaenJQMWFrU2pMR2tzT0ozS3hQ?=
 =?utf-8?B?d2pGNFlZMmc0M2xhaDBaUDZhNDN0L0R3WExCcVRVTGJYTW1CTW9yVXkyZW1r?=
 =?utf-8?B?S0NNYjBsdGd1RCtaUW9nT3RDd3dMMzB1RlFmN1FXSVBtdWZzWEJLditZajdF?=
 =?utf-8?B?a2hYTzJSTzZTbXNaWFQxeW1iNXRsWVpQZWVCRm83Zm1lQVZxakMyTmM5eWZK?=
 =?utf-8?B?b0VLejFGeURxMFBlOEtOZEptNStVbEZMeGN1K3A4L2NUVzMyS28zZkw5Y2My?=
 =?utf-8?B?SUdINTBZYk5PZDREMXNtRm5mdC9jeEszVXZJbkFFU2krWXp3YkFET25IdHVD?=
 =?utf-8?B?MmZzN2xoQXRCK2I4dVZTQnd6Q0FnK0tiMEs1TjFUeGFMSDY4UEhMa1Z6SFll?=
 =?utf-8?B?UkovaGc2T3JuNjV3NnFaMXg5dzFDQ3RQb1ZvN2JoZFlRY1FEaExxNmhpbGJT?=
 =?utf-8?B?S0IrV0ExeS9RdHJ6Z21LSE5wRWN2bXZhZXhmbnJiVzhNL1VKdlkydlJiVUhz?=
 =?utf-8?B?VklGdy8xb3BnazBQakFsYmdCYllUK1orOGVQNExhVXpUZmpFMCtXR3hJZm9x?=
 =?utf-8?B?YVc3MDVnZWJYSE5Pb2ZwTXR1dUlVUWZuKzJXNnl1T2lyUnVWNWlsaGs0Nlc2?=
 =?utf-8?B?ZWZWTUVES2lBT3UreHRQR2hyMlBnQy9QMUNHbkh5Ukdqd1BhQ0Vra280NlpR?=
 =?utf-8?B?V3h1Mmw0NXJPVk1hcXdDSVlXTlI2YXdXS28xaGs3Yy9MS0t1Q2ZPb2xwRk5L?=
 =?utf-8?B?WEt0cE0vMGU1Z0RaN0NwR0xqc0k0VjJkV1dhR0s2NGlIWDB3a2pBSXVuRUFZ?=
 =?utf-8?B?aFZoRmkvRVN6ekwwdnJzdjZuSVNiVThOci9qSHA4eDRmVDVVR0V6YWFuSjFo?=
 =?utf-8?B?d1J4QnVrdDdRZTBSWVV0Vm9ITk1oWlJWWTlKOXNPekhLUmFGVUZ6R09tdG16?=
 =?utf-8?B?Yjk3dDZnZmtUK2tvUTZFeU8xM0V2YWlTV25qMkI2OGRxbWh2TlZ5ZjBXYnNi?=
 =?utf-8?B?b0l6Q2ZLMmtSS3J3cUR6TXF1bjZYMHgvQXBDVVhvWlRjaFZuY1B1YXZRbWhD?=
 =?utf-8?B?Z291d2pXa245ejVuRll4RzB4UkpZQTNUR3JiclJBQkQvcXk0cjA1NGttbWlI?=
 =?utf-8?B?UEprN2szb0hDSTJuSzZoNmFEZHRxZGtSbjc4V2luMnpkS1d4ZERRZXQrbUlG?=
 =?utf-8?B?K2VCREIxbEZ0QnN2aWtvNDdxQWxWSllsMWpDZlF2WE16ZWdFN1pLemxJekpZ?=
 =?utf-8?B?cXYvMXdZR2tsRUduUlYwdFFWZ2VSSG9pYjlsTk8rN3lhaUUvNTgwenZ6bStj?=
 =?utf-8?B?cmU5YXcvQ0VjZjlDZXlNMGxNVVVlZ0E5U0RLUmhpVXJSMW5JYlJlekZ1RUQw?=
 =?utf-8?B?aGpMRzh1QnN6UVp6MGRlaWoxN205NXZaeFEvSEhOdzF0VjFncURyWm1FeVNK?=
 =?utf-8?B?cE9yeVJLNWJhRHp5Q295OGRQcmpWQzV6WTBTTTRoaVpjK2NnQ3VBV21sWUNT?=
 =?utf-8?B?Qk9ibk95bzJQYlByQWZjNnFxQWRNRjZBT1BEaVlINEppZkFjTnFuVFNrZ003?=
 =?utf-8?B?bjhLNjkwTGR6TElLYzcyZjlWTWVOa0tVVnFjTFpCT2gyM0VlQkpYR09GTS9w?=
 =?utf-8?B?VHhmblZkMHdzbFVpVnllZUg2dUlrTzJsWkJ0eEVMazh2SUM3Y3hsVjRjN1dK?=
 =?utf-8?Q?kM9Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ee9a8c-3321-4c38-3e0f-08ddf9b8f910
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 09:18:20.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZW+g9cgZqws7TEZnnNu8dCmbNkpHCUYViTAg13BdP64PBhjOuycVa/rngIyKNXphU0W7RdpogsJ9imUbOTrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIgyMOaXpSAxNDoyOQ0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi82XSBQ
Q0k6IGR3YzogRG9uJ3QgcG9sbCBMMiBpZiBRVUlSS19OT0wyUE9MTF9JTl9QTQ0KPiBpcyBleGlz
dGluZyBpbiBzdXNwZW5kDQo+IA0KPiBPbiBUdWUsIFNlcCAwMiwgMjAyNSBhdCAwNDowMTo0N1BN
ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBSZWZlciB0byBQQ0llIHI2LjAsIHNlYyA1
LjIsIGZpZyA1LTEgTGluayBQb3dlciBNYW5hZ2VtZW50IFN0YXRlIEZsb3cNCj4gPiBEaWFncmFt
LiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUgdHJhbnNmZXJyZWQgdG8gTERuIGRpcmVj
dGx5Lg0KPiA+DQo+ID4gSXQncyBoYXJtbGVzcyB0byBsZXQgZHdfcGNpZV9zdXNwZW5kX25vaXJx
KCkgcHJvY2VlZCBzdXNwZW5kIGFmdGVyIHRoZQ0KPiA+IFBNRV9UdXJuX09mZiBpcyBzZW50IG91
dCwgd2hhdGV2ZXIgdGhlIExUU1NNIHN0YXRlIGlzIGluIEwyIG9yIEwzDQo+ID4gYWZ0ZXIgYSBy
ZWNvbW1lbmRlZCAxMG1zIG1heCB3YWl0IHJlZmVyIHRvIFBDSWUgcjYuMCwgc2VjIDUuMy4zLjIu
MQ0KPiA+IFBNRSBTeW5jaHJvbml6YXRpb24uDQo+ID4NCj4gPiBUaGUgTFRTU00gc3RhdGVzIGFy
ZSBpbmFjY2Vzc2libGUgb24gaS5NWDZRUCBhbmQgaS5NWDdEIGFmdGVyIHRoZQ0KPiA+IFBNRV9U
dXJuX09mZiBpcyBzZW50IG91dC4NCj4gPg0KPiANCj4gVGhpcyBzdGF0ZW1lbnQgaXMgbm90IGFj
Y3VyYXRlLiBBIHNpbmdsZSByZWdpc3RlciByZWFkIGNhbm5vdCBjYXVzZSBoYW5nIEFGQUlLLg0K
PiBJJ20gZ3Vlc3NpbmcgdGhhdCB0aGUgbGluayBkb3duIChMRG4pIGhhcHBlbnMgYWZ0ZXIgaW5p
dGlhdGluZyBQTUVfVHVybl9PZmYNCj4gYW5kIHRoZSBhY2Nlc3MgdG8gQ1NSIHJlZ2lzdGVyIChM
VFNTTSkgY2F1c2VzIGhhbmcuDQo+IA0KPiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/IA0K
VGhlIGFjY2VzcyBvZiBMVFNTTSBpcyBub3QgcmVsaWVkIG9uIHRoZSBsaW5rIGlzIHVwIG9yIG5v
dC4gRm9yIGV4YW1wbGUsDQogdGhlIExUU1NNIHN0YXRzIGNhbiBiZSBhY2Nlc3NlZCB3aGVuIHRo
ZSBsaW5rIGlzIGluIHRoZSB0cmFpbmluZw0KIGFuZCBub3QgdXAgeWV0Lg0KDQpQZXIgdG8gdGhl
IGRpc2N1c3Npb24gd2l0aCBCam9ybiwgdGhlIG1vc3QgcG9zc2libGUgcmVhc29uIGlzIHRoYXQg
dGhlDQogTFRTU00gaXNuJ3QgcG93ZXJlZCBhbnltb3JlIG9uIGkuTVg2Lzcgd2hlbiBQTUVfVHVy
bl9PZmYgaXMga2lja2VkIG9mZi4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2lteC8yMDI1MDgx
OTE5MjgzOC5HQTUyNjA0NUBiaGVsZ2Fhcy8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
PiANCj4gPiBUbyBzdXBwb3J0IHRoaXMgY2FzZSwgZG9uJ3QgcG9sbCBMMiBzdGF0ZSBhbmQgYXBw
bHkgYSBzaW1wbGUgZGVsYXkgb2YNCj4gPiBQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTKDEwbXMp
IGlmIHRoZSBRVUlSS19OT0wyUE9MTF9JTl9QTSBmbGFnDQo+IGlzDQo+ID4gc2V0IGluIHN1c3Bl
bmQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiAN
Cj4gV2UgbmVlZCBGaXhlcyB0YWcgYWxzbyBhbmQgeW91IGRvIG5lZWQgdG8gc2V0IHRoZSBmbGFn
IGluIHJlbGV2YW50IGdsdWUgZHJpdmVyDQo+IGluIHRoaXMgcGF0Y2ggaXRzZWxmIHNvIHRoYXQg
aXQgY2FuIGNsZWFubHkgYmUgYmFja3BvcnRlZC4NCj4gDQo+IC0gTWFuaQ0KPiANCj4gPiAtLS0N
Cj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMzQN
Cj4gPiArKysrKysrKysrKysrLS0tLS0tICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuaCAgfA0KPiA+IDQgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IDlk
NDZkMWYwMzM0Yi4uNTdhMWJhMDhjNDI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTEwMTYsMTUg
KzEwMTYsMjkgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNp
KQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlyZXQgPSByZWFkX3Bv
bGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLA0KPiA+IC0JCQkJdmFsID09IERXX1BD
SUVfTFRTU01fTDJfSURMRSB8fA0KPiA+IC0JCQkJdmFsIDw9IERXX1BDSUVfTFRTU01fREVURUNU
X1dBSVQsDQo+ID4gLQkJCQlQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTLzEwLA0KPiA+IC0JCQkJ
UENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+ID4gLQlpZiAocmV0KSB7
DQo+ID4gLQkJLyogT25seSBsb2cgbWVzc2FnZSB3aGVuIExUU1NNIGlzbid0IGluIERFVEVDVCBv
ciBQT0xMICovDQo+ID4gLQkJZGV2X2VycihwY2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3Ig
TDIgZW50cnkhIExUU1NNOiAweCV4XG4iLA0KPiB2YWwpOw0KPiA+IC0JCXJldHVybiByZXQ7DQo+
ID4gKwlpZiAoZHdjX3F1aXJrKHBjaSwgUVVJUktfTk9MMlBPTExfSU5fUE0pKSB7DQo+ID4gKwkJ
LyoNCj4gPiArCQkgKiBBZGQgdGhlIFFVSVJLX05PTDJfUE9MTF9JTl9QTSBjYXNlIHRvIGF2b2lk
IHRoZSByZWFkIGhhbmcsDQo+ID4gKwkJICogd2hlbiBMVFNTTSBpcyBub3QgcG93ZXJlZCBpbiBM
Mi9MMy9MRG4gcHJvcGVybHkuDQo+ID4gKwkJICoNCj4gPiArCQkgKiBSZWZlciB0byBQQ0llIHI2
LjAsIHNlYyA1LjIsIGZpZyA1LTEgTGluayBQb3dlciBNYW5hZ2VtZW50DQo+ID4gKwkJICogU3Rh
dGUgRmxvdyBEaWFncmFtLiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUNCj4gPiArCQkg
KiB0cmFuc2ZlcnJlZCB0byBMRG4gZGlyZWN0bHkuIE9uIHRoZSBMVFNTTSBzdGF0ZXMgcG9sbCBi
cm9rZW4NCj4gPiArCQkgKiBwbGF0Zm9ybXMsIGFkZCBhIG1heCAxMG1zIGRlbGF5IHJlZmVyIHRv
IFBDSWUgcjYuMCwNCj4gPiArCQkgKiBzZWMgNS4zLjMuMi4xIFBNRSBTeW5jaHJvbml6YXRpb24u
DQo+ID4gKwkJICovDQo+ID4gKwkJbWRlbGF5KFBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAw
MCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0KGR3X3Bj
aWVfZ2V0X2x0c3NtLCB2YWwsDQo+ID4gKwkJCQkJdmFsID09IERXX1BDSUVfTFRTU01fTDJfSURM
RSB8fA0KPiA+ICsJCQkJCXZhbCA8PSBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlULA0KPiA+ICsJ
CQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gKwkJCQkJUENJRV9QTUVfVE9f
TDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+ID4gKwkJaWYgKHJldCkgew0KPiA+ICsJCQkv
KiBPbmx5IGxvZyBtZXNzYWdlIHdoZW4gTFRTU00gaXNuJ3QgaW4gREVURUNUIG9yIFBPTEwgKi8N
Cj4gPiArCQkJZGV2X2VycihwY2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkh
IExUU1NNOiAweCV4XG4iLA0KPiB2YWwpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0N
Cj4gPiAgCX0NCj4gPg0KPiA+ICAJLyoNCj4gPiBAQCAtMTA0MCw3ICsxMDU0LDcgQEAgaW50IGR3
X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+DQo+ID4gIAlwY2kt
PnN1c3BlbmRlZCA9IHRydWU7DQo+ID4NCj4gPiAtCXJldHVybiByZXQ7DQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChkd19wY2llX3N1c3BlbmRfbm9pcnEp
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaA0KPiA+IGluZGV4IDAwZjUyZDQ3MmRjZC4uNGU1YmY2Y2I2Y2U4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBA
QCAtMjk1LDYgKzI5NSw5IEBADQo+ID4gIC8qIERlZmF1bHQgZURNQSBMTFAgbWVtb3J5IHNpemUg
Ki8NCj4gPiAgI2RlZmluZSBETUFfTExQX01FTV9TSVpFCQlQQUdFX1NJWkUNCj4gPg0KPiA+ICsj
ZGVmaW5lIFFVSVJLX05PTDJQT0xMX0lOX1BNCQlCSVQoMCkNCj4gPiArI2RlZmluZSBkd2NfcXVp
cmsocGNpLCB2YWwpCQkocGNpLT5xdWlya19mbGFnICYgdmFsKQ0KPiA+ICsNCj4gPiAgc3RydWN0
IGR3X3BjaWU7DQo+ID4gIHN0cnVjdCBkd19wY2llX3JwOw0KPiA+ICBzdHJ1Y3QgZHdfcGNpZV9l
cDsNCj4gPiBAQCAtNTA0LDYgKzUwNyw3IEBAIHN0cnVjdCBkd19wY2llIHsNCj4gPiAgCWNvbnN0
IHN0cnVjdCBkd19wY2llX29wcyAqb3BzOw0KPiA+ICAJdTMyCQkJdmVyc2lvbjsNCj4gPiAgCXUz
MgkJCXR5cGU7DQo+ID4gKwl1MzIJCQlxdWlya19mbGFnOw0KPiA+ICAJdW5zaWduZWQgbG9uZwkJ
Y2FwczsNCj4gPiAgCWludAkJCW51bV9sYW5lczsNCj4gPiAgCWludAkJCW1heF9saW5rX3NwZWVk
Ow0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+Cv
jeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

