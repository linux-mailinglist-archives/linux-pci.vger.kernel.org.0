Return-Path: <linux-pci+bounces-36395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28EB82B3F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592B6626569
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A696209F5A;
	Thu, 18 Sep 2025 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZ2xm892"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60C1D61BC;
	Thu, 18 Sep 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164684; cv=fail; b=NZ3YsqjAzpIslpdAuNfASmHo/yQZ7f06gUUugsvd8Exes8tZKK81wEth6D5f1GrmzqaeHrLbBH4UXxRpTwiu0zBNUBnPrRpxdHNHWZ+EfDnJRXk55Q6npo2wZfcMSMXJ9TQMCsxCtZX0cfBPcDTDt7IHa4olcHPF3s7WmcvcFAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164684; c=relaxed/simple;
	bh=p6GVapdNfmMScGFxHqJPGGYYAHveelcEd5wJ/KiQims=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLM3pnLxoBjDmdRNIqAMLTVohTLKA7sOW794PAPnMC6MK98QjZF6O3GYhsIbDnUAqXp2OL8EDvSeCQNOMaInhAcCCzCO/JiW+bkQbrdOrU9AFpNvCptXMa+HXYjradQ08+y102iuh86oPnVvFSH2B4seP9w93vdmg+6lgFKvaEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bZ2xm892; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqTixmUP1LqsLrTjOJpx2y2d8KrNd1zsH5aCFr0+MA9y9meKfvRR7TI+6fKpt2HUDUbsBODHxQyTDpyDs8lKmfanTh2wbjFgWoB+SPiinbRHKTJxrA3Ln4zEO+jPrIRA+J4PuXNnESjNLWG0dW/2ImEO+BICrqcF2dYXP7H2SJLRyCZhp7mh/sllMZaJQrak8KCMgJ6uoD1rXOamWg7GaJDW3pC98inQF0cnempTY0lWCPouixmy0695VBmkZd9Xquun6pKSCO1Xm6/Jk2RTurSG7pm3SYb1deOb7WaKbqA54o8PwNvHBPSNB4mWOwISa9P704/Uf1FgzLy84bhG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6GVapdNfmMScGFxHqJPGGYYAHveelcEd5wJ/KiQims=;
 b=lyl5w9WB7u1fFAfmKi22xYCGyKD3jndfW+ZOaiWOfY+ACUDD8YFUhuYTeSgGwyVWywMenRuCfmrBGVANvv67w0UofRW0PD0jl3TEYWf3g2QAwm+rCz+elfcDkLLOo+anGfvFH9P3Pkve4zoplmE8r3h6gybQ/IatsPop0YW4WD/1IGslfIPJWCjWuF5udqKIM41Mc49/Thg8gJH7OiyLfJ9Xwn4wg1ogQaBoPJdhgEPNPA51qc5+AJ5aWrmoW0oC6XMNCYbS69jpQth0tzYRORFX1KwPtmZjMWKYcv+wEl3GhNn+c3lLp3zmBvby7f/rR6eIPKoaoW7sjwF8NXG2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6GVapdNfmMScGFxHqJPGGYYAHveelcEd5wJ/KiQims=;
 b=bZ2xm892QEg9nvyz6gAXE8FuoJKWbwH1TQymnOMZQoGECKXgyT384jGb6XimOk/11kXjLEZK5KIbsjor6PWIR0Oe4t0zZJ1SE22yK7yoKt+4r4qhYWg3AjT9hef2hrlVdhyVUlUET/i5Rh5Ce58UG7yePYK+U8xo4T/ED8gsV/IJFBmtt8nIs6pokf9mvcSaOfaDd4tDh02DWwHow/KRxKrppD6EQ121+eRp2eZNapM4mQn7Dm0W5NG2CYRIoE1wzD14jDnQq8+zb65oeb03KeZETMBfbHsQEJFYlaGQCUiiDVhmFKCxPn09GNAKljDs8Yn3NKRO3B6WF4mQuMsSCQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 03:04:39 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:04:38 +0000
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
Subject: RE: [PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ# override
 active low
Thread-Topic: [PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Thread-Index: AQHcJ7bT5sIOcs2YO0GP1KGI2O2XXLSX9BUAgABJkdA=
Date: Thu, 18 Sep 2025 03:04:38 +0000
Message-ID:
 <AS8PR04MB883309FC7D8F8052924179768C16A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250917093751.1520050-3-hongxing.zhu@nxp.com>
 <20250917222356.GA1879221@bhelgaas>
In-Reply-To: <20250917222356.GA1879221@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PAWPR04MB9911:EE_
x-ms-office365-filtering-correlation-id: d8f184ee-a2f3-47e6-1b0f-08ddf6601b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?VlB1Tzh5TDJoa29xNEloZFdSbWFRaFFmaWJXM1FIaE9GdTQzZGI5Y2Y5VHhQ?=
 =?gb2312?B?T1QxL0phLzRMaDd1OE1uTnlvcm5yVUV0M1RsRkJ2RTNoUk5kNXBhR0h0K0l0?=
 =?gb2312?B?T3RvTXFSb1NGTzZCSjNvdG41TlZDNW1DRUN5cHEyd1h4U1A5RUp1TTBhcjV2?=
 =?gb2312?B?c01SRjZlNWJqb29oQlNxWC83TU1qWGxhUUNHSVhRc2FxV250VGM2LzFCWVJE?=
 =?gb2312?B?YlRzNVlpY2lyN2RCRm96SklHSW9RT09hUzdxNmptY0JNRXRKSzI2RHdwMEdm?=
 =?gb2312?B?QWR1MW9ObTlwWEpsSC95dGRZOU1IZ1pVWFJFd1FRTy9GbHN2TEF6ZERNRHZ1?=
 =?gb2312?B?eURCNlAzT2pLZ2pjWHVveDVRVk4vSWFuV3JJckxKK0VWM3lwd1VpRzBwSU83?=
 =?gb2312?B?aFE5cnlNYVVSeEdvSEh0RVBmQlQyVGZGL3pJYnYzTUVXRGQvc3FESk5FQkov?=
 =?gb2312?B?MnBteXVnSkZxMnQwZ2tuYndsYjVQd0RLdDRSQkNjZ0FzNVpyTyt5eXpROGV3?=
 =?gb2312?B?aG9nQUxVVFlsc2U1MG52NUIyOC9jbHlmSkZac3ZRRWsreHQ2L1hNMWNaTFFI?=
 =?gb2312?B?WWdjYWpEVTVFNjZoZWtRck1mOUl3elJWSFc4Uzcrc0RHRElhNS9WWWwvY0g5?=
 =?gb2312?B?dkRVMTdtNDRtSlp6N1lkS015TWMzOW1oVmpBUWVVQkhEVHlYSlZmN3ZtdWdW?=
 =?gb2312?B?dEhEY2JVamIvRTF0Q2lrMVp0SXdSS2FaWXF1MlEzai9Jd09qeDRyREVDc0M4?=
 =?gb2312?B?eVRaTkN6bkgwRG12OU9lYjJqMGZhVGJJWGFjRTU1WHNUTmk1Y0RvSVJVSzlT?=
 =?gb2312?B?VURpZWIzQWtyWWhmS201RGYrU2FVc2N4ZXh6am1mNVZFMHllbEg4MklyYjFi?=
 =?gb2312?B?K2tPcFgxb1J4ZDdoZm1NVzRSR1J0YXFadVlaR2RuQnNWeERDSUk4aE82b2ti?=
 =?gb2312?B?bFZhbWV0bXZ3RStUMEdWVk5FVzc2SmtkQ2RqdWtHQmNCbGlaL2dRYmdIWjN0?=
 =?gb2312?B?M01ybjcvOFRtemlxZFkvNmJFVEJNVUFhWHR6ckpPOHZXZTdqRjhTbEtJSW5K?=
 =?gb2312?B?T1hxRHRnNkV0Q0N6c0w2K2dqa01UMEJlNkVSWG0yZ1hNbE9QSmFkNTRIb0Yr?=
 =?gb2312?B?blVhU2FKNHg0WGo0eGZablFiTmpwVUJocVdYaUVSTlppTTBFMC9hdUtkei9G?=
 =?gb2312?B?Wko0U3NOTmN3SitnanBPQVZyZUF3Rm9ybzFvdjZjWk9KbmZoMUE1Ny9jRmNz?=
 =?gb2312?B?OGNxa2pVZDlUMVB0bWhjYURnZS9NWS9nVnNadWU3SWdYUGc0cHBLUnI4MDk2?=
 =?gb2312?B?Y1BlaU1ucStncFBESVhEeGZWNkJtYWZsUEFtdTg2M3UrQkszMG9PS0Y5WnFI?=
 =?gb2312?B?VUd2MXIySHdDRzQ5Wk5TV3R5R25CNmhGMDNNSzdkVDBjcWNTeGxqOGhTblp2?=
 =?gb2312?B?cTlmU1hpN2dXNXpiTkNPTk40WnM4OFlBZEgwcjNCS0dZR0xRUC9sOU1CMjBM?=
 =?gb2312?B?ZkJ0Wk5SWlVWZjY2TmpLVmtPelp2ampGS2lqOUI0U21tS21PSUVSdjVYV01u?=
 =?gb2312?B?TUVXZ2p6dDhISERjeDJXdlZtMGlJdlJlRzVNTUR2WWJyVTBOQndYT1QrUHFY?=
 =?gb2312?B?WnBKdUNiejFHQnZuQUFUTHNyczhpMHc4d2J5NU1aUDUzTDRIZlR6aGNqRlZz?=
 =?gb2312?B?TFpUNnpoV0txcHFRYjE2ZWR4QmYwL01hV0hrdlBSclc5bEJvVjUvY1hHVlNJ?=
 =?gb2312?B?amEwUXEyYzVWUEIrSmxNaFl2WThlUEc5N1JCbE1CeUdva05lY0ZaUS9SU2Qw?=
 =?gb2312?B?TE1LVDROZEhGYzc2V0R4U0p6VkNURkRKVDh6SzJrUVZ3OU5EamxZSFdFdjhX?=
 =?gb2312?B?WHNVZTJUV2hZM3JJcEViRDZLWFlucXJxOS9TOEVmM3pJcm55TTZyaUFSdjA4?=
 =?gb2312?B?VDdzZjczTDRtb2hVNXhZdHVPZ2QwSXQxWjArTW1SWUNnckk3Y2FLdUR6RlR2?=
 =?gb2312?B?c1FzOWJsKzFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Y1cyaHRhRUdXZWpqRXBCRVJDUTVsaVVDbk9YUW1NRFpFVVo1ajV3VWxSMWJq?=
 =?gb2312?B?elpaYVFXWk9aanQ1OS9FYWI1QmRZVkFDV3JJUjJ0SkIzZUo1L2RWUkd6NFdC?=
 =?gb2312?B?ZFovVy9xMTgxelhjemxIdnBvK0ZYTDNBRy9qdVBZS0Y3enJBMVVuYmtpN0lU?=
 =?gb2312?B?VlFsclc5NGZCWkNHRDFWRkZObEhkUUN2cUE1K0RtL0N1aTBGWEpYZzFtZm81?=
 =?gb2312?B?ZUZNd01MaEp3VGJWb3hlSC8rOXlVTmpJNVJlZFpjbUxFZUUxaXRsSHhBaGds?=
 =?gb2312?B?M013NmhNM0R1T2VKNWJpS3NwekN3OXlsRy9RWVpJeWk2SzZLY0QzbUtrbDN1?=
 =?gb2312?B?bDYzVFJVMFVsYjk4OE5zWjZEbVRVaXY2S09YSVVoUnp0eEdEYVU0N3RmRkg2?=
 =?gb2312?B?QURlSTc4VEFsK2pSUDBOOXloM1V1M1V1bmlPTEFYcjc2TzhxU1RCdWQ2bVBB?=
 =?gb2312?B?eUxia0p4cDBBWkxvWW9BSUhWeVVBVytCMmFJSFcxZU5UVWhwOWl1b25lNEt5?=
 =?gb2312?B?Q0g1cWFJQ2hSTmRMcHlBekloWHZndmpSMlY0RTFoS3UrbGcxL3VUR2hSQjIv?=
 =?gb2312?B?d3VDck9GS3o2N0oxLzZYZUdiRXkxMUxnV3lSeUZSb2R5cmJsOXd3UFZxVGUr?=
 =?gb2312?B?aGpvTnBtcmlxb0xFWmkrUzVaMTQ5VG5SWGlCVkp0Uys4SzR5N2w3eUZKVStE?=
 =?gb2312?B?UFBiQ3JaQWRDcGVQQmtLaGhobzhkN3dlS3k2NStEc1FmVzFnVWI1czAxQ2hO?=
 =?gb2312?B?a25GblZTaXl2QTNySHhTb1RXUnpGbS9XUHFSRUxuZ1ZIdlU1ekJnaDM4aWVS?=
 =?gb2312?B?NXNLYXhmZzlaNFcxZ2VSdlJWZTN1amNXcTgvQnhiczZxc3JJYVFPOHRUZ2FW?=
 =?gb2312?B?ajlpNHl6blJXWEdaMzhHWURvTUtqV0dhYW9RaUxuY2E5aTY2cVh3TS8wUDVS?=
 =?gb2312?B?Y2psWnI4ZGtnMlUzMHNsMEMrNTRDMy95U1VpYUMrbzloMS9mYkdkK0VjTmJa?=
 =?gb2312?B?YklLK2QxTVVOdU9odGlKbnRhRkRFamh0alpYT0pUR3N5STFEb2c0TlltY0tG?=
 =?gb2312?B?U3JhaEgzMFVSb3ZTNXloVjk3MWNyZEh1czFHSlIvQ3A4UkIrK3lhbGdrVHNi?=
 =?gb2312?B?ZC9TUTJWMm5jT1RaMHFSdnBjNHM3TVNubDFhalpaOTlIanBVRVM3TE10TG42?=
 =?gb2312?B?czdWQ2RXdCtTTndKaXlvNWwvcHJheVBSMDBNWXp1Q0llcTBVaHdoaU1YcHNC?=
 =?gb2312?B?SkpERHIwTnFLZ2dMR0NQT0J0aGZkbi9QTm0xbC9FUStaUWNneE1CZDhSbU9l?=
 =?gb2312?B?cC9aZkt5dXhGTWNNY1dLYUpjV1RoV3JzYUdGcE5lc2QvWlY1K1h5R0g4NDRU?=
 =?gb2312?B?bDg2YWJJUnJtSUJ4Vm91ZyttUFJ6azFnVjZBSXdMd3RqQXZ3ZXByTkJSeWVw?=
 =?gb2312?B?YUZtMVF2Q25BdXUyV2lvSUREY0dFNlpjcnkzRWcyWmJMbFprdHlhd2Q4MXJj?=
 =?gb2312?B?c3pWOWtnQ2dtMTI2SytXQ0wwZ2UxdHc2ZWJrdUlFVTE2bEZoOENMbklUVnlh?=
 =?gb2312?B?TXhFcnNHbk5samtQMzdsN0ZjOHhYNGFTRFlHVlp2elF5elpQV2UrYllhNnZu?=
 =?gb2312?B?OEhmT0pwY1REN2hieWNmNnNzN2VCZ01aNDZlckFxVCtvbjU2YnVtMnlEMkgx?=
 =?gb2312?B?dGRxS3dtcUh4V1FZeU5zbXZNL1hlNmpjR2hXYVE0UzZGaHdjMDZpRWFqSEtN?=
 =?gb2312?B?MzlIUmZPSE9oVDZHaGdpdmFQdTREREV3VlRjZVp5cFR0di9JdStLWnBiakhn?=
 =?gb2312?B?eXN4N3A2V3IxeWlaeXBmYXlvR0FuV05Bd3BKMzhxYUhZQjNtL21rQ2tZeFB4?=
 =?gb2312?B?SmpUdGtyRmprVzBlR2RhQ0dRK3UyazQyRG4ybUhjZ3VpZENjZGhOSFdSbGEy?=
 =?gb2312?B?NjRBR3Azci9qU2U1QUxvam8yT2dZRnNZcjkxVEZjWU5rdFlsbUh6RkN2VVhv?=
 =?gb2312?B?V3N1UE9ScFdXcnZLUkdpRVI2TzVCeHg4S0thMGlhYW9jSnExcHZDSlN0YTVO?=
 =?gb2312?B?NERGc2lNZWFlKzVNM3lzWENWb3AzMmJ6a29STkdiQTdzNHhyU1VoTGFET1dI?=
 =?gb2312?Q?i0uI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f184ee-a2f3-47e6-1b0f-08ddf6601b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 03:04:38.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHVyVfvhPgfGksMKQ7GyVvg0S3EZZi6GeTecO/ECvTozrmLGGCeKHcIXGMvXFPn9t7hmsdlYuU0eObPB8kXTGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jnUwjE4yNUgNjoyNA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzJdIFBDSTogaW14NjogQWRkIGEgbWV0aG9kIHRvIGhhbmRsZSBDTEtSRVEjDQo+IG92
ZXJyaWRlIGFjdGl2ZSBsb3cNCj4gDQo+IE9uIFdlZCwgU2VwIDE3LCAyMDI1IGF0IDA1OjM3OjUx
UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFRoZSBDTEtSRVEjIGlzIGFuIG9wZW4g
ZHJhaW4sIGFjdGl2ZSBsb3cgc2lnbmFsIHRoYXQgaXMgZHJpdmVuIGxvdyBieQ0KPiA+IHRoZSBj
YXJkIHRvIHJlcXVlc3QgcmVmZXJlbmNlIGNsb2NrLg0KPiA+DQo+ID4gQnV0IHRoZSBDTEtSRVEj
IG1heWJlIHJlc2VydmVkIG9uIHNvbWUgb2xkIGRldmljZSwgY29tcGxpYW50IHdpdGggQ0VNDQo+
ID4gcjMuMCBvciBiZWZvcmUuIFRodXMsIHRoaXMgc2lnbmFsIHdvdWxkbid0IGJlIGRyaXZlbiBs
b3cgYnkgdGhlc2Ugb2xkDQo+ID4gZGV2aWNlcy4NCj4gDQo+IENhbiB5b3UgaW5jbHVkZSBhIGNp
dGF0aW9uIHRvIGEgcmVsZXZhbnQgc2VjdGlvbiBpbiB0aGUgQ0VNIHNwZWM/DQo+IE1heWJlIHRo
ZSBwb2ludCBpcyB0aGF0IENMS1JFUSMgaXMgYW4gb3B0aW9uYWwgc2lnbmFsIGFkZGVkIGluIFBD
SWUgQ0VNIHI0LjAsDQo+IHNlYyAyPw0KPiANCj4gSWYgdGhhdCdzIGFjY3VyYXRlLCB3ZSBjYW4g
YWRkIGl0IHdoZW4gYXBwbHlpbmcsIG5vIG5lZWQgdG8gcmVwb3N0IGZvciB0aGF0Lg0KSGkgQmpv
cm46DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpUaGUgUGluMTIgb2YgY29ubmVjdG9yIGlz
IHJlc2VydmVkIHJlZmVyIHRvIENFTSBzcGVjIHIzLjAgc2VjNi4xIENvbm5lY3Rvcg0KIFBpbm91
dC4gQ0xLUkVRIyBpcyBkZWZpbmVkIGluIENFTSBzcGVjIHI0LjAsIGJ1dCBpdCdzIG9wdGlvbmFs
IHJlZmVyIHRvIENFTQ0KIHI0LjAgc2VjMi4gQW5kLCB0aGUgUGluMTIgb2YgY29ubmVjdG9yIGlz
IGRlZmluZWQgYXMgQ0xLUkVRIyByZWZlciB0byBDRU0gc3BlYw0KIHI0LjAgc2VjNi4xIENvbm5l
Y3RvciBQaW5vdXQuIFRoYXQncyBhbGwuDQpTaG91bGQgSSByZXBvc3QgZm9yIHRoYXQ/DQoNCkJl
c3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+ID4gU2luY2UgdGhlIHJlZmVyZW5jZSBjbG9j
ayBjb250cm9sbGVkIGJ5IENMS1JFUSMgbWF5IGJlIHJlcXVpcmVkIGJ5DQo+ID4gaS5NWCBQQ0ll
IGhvc3QgdG9vLiBUbyBtYWtlIHN1cmUgdGhpcyBjbG9jayBpcyByZWFkeSBldmVuIHdoZW4gdGhl
DQo+ID4gQ0xLUkVRIyBpc24ndCBkcml2ZW4gbG93IGJ5IHRoZSBjYXJkKGUueCBvbGQgY2FyZHMg
ZGVzY3JpYmVkIGFib3ZlKSwNCj4gPiBmb3JjZSBDTEtSRVEjIG92ZXJyaWRlIGFjdGl2ZSBsb3cg
Zm9yIGkuTVggUENJZSBob3N0IGR1cmluZyBpbml0aWFsaXphdGlvbi4NCj4gPg0KPiA+IFRoZSBD
TEtSRVEjIG92ZXJyaWRlIGNhbiBiZSBjbGVhcmVkIHNhZmVseSB3aGVuIHN1cHBvcnRzLWNsa3Jl
cSBpcw0KPiA+IHByZXNlbnQgYW5kIFBDSWUgbGluayBpcyB1cCBsYXRlci4gQmVjYXVzZSB0aGUg
Q0xLUkVRIyB3b3VsZCBiZSBkcml2ZW4NCj4gPiBsb3cgYnkgdGhlIGNhcmQgaW4gdGhpcyBjYXNl
Lg0K

