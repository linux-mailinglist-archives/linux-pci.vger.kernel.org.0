Return-Path: <linux-pci+bounces-39497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CFC13095
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1642E1A2695F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254229AAFA;
	Tue, 28 Oct 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8movcFx"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70D1BC41;
	Tue, 28 Oct 2025 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631017; cv=fail; b=PwLqr1axAaYTUnl0p1/ZNJa8LhhlXs7J2OfqgL5u83B252SRXcfNSzZSfrY8VmDww9vxbKF/rQP/+Sst8QVxCV0E1xGqKH/tC/dtyOfHke1+hVy1linXWQqYVSy7GCsgQQTRyatjH6IBpmQL7QUcWcvr0hwJWyFyEoBHNDIman0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631017; c=relaxed/simple;
	bh=OvqwhkA+BsASdm4ZReAAMf6Dqei8afHq7ogOnJFzus4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UiGzdZ5jFhZ2pfFOagS86UFozi98v8ID8n5XkZcrp5D+eTE4WzRs0k7dK3sr9+wx92eRi5sZ7NcfA5QXQKfoHnjNhrd4+UgyiVM/2DqeH+b3n3zHO5JiLV0LVB49ZPBOs9TYxNMwlu2DquPZUASKKMeAG5bUvG42QWrOgzu0OGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8movcFx; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4rKmu7t46klVUNZjbQMv2rUADOyc6ujD09VEoPNVfPSXXqoWsz9qCrN8265+eeqXhaGQWIhwqhyzsXc9eETBYLRl0BrOkpZfjPD76f1SFjm3MQLU2gjp66AVfTXR5rAcjH17cH4NkWpBsHpmDz6q971VN8RlTx/idUgeLJ6yPrxehFBhmbkg5Z6kSzR+JKVOo17YkXKoEtM4PSgWv1F1A4NfQrquWdkAXyqbq5Xl6aoAiCG+PY0/LCx5ej5f8poK/tXJzWQ5xO5k48iKNJCOpGYpQKJOUnVUqM5pGwVef5szMDLAl/iok50MtoDWktYyPolggOOwLXjJ4uztBV8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvqwhkA+BsASdm4ZReAAMf6Dqei8afHq7ogOnJFzus4=;
 b=gfQM3932pLYe2r8RA19zW0saWrTs7ffwbKCIPh8wSywNmWORqgNjEaNLNWrVim+0ic4VrC0qvVTjRqn87RygXYZX0wBQ4wdUhIdsB6PkmqMg+ny+f7wZQdnV5+tOMYl/8/pVHw9PajmGaRL0wT7+6a4PrdrAmcGQKlAvpI3VDyinwt4iiUcOB8rrrP7SId/vnLGipcR4qWfmjlrCavXTqADhMrFunSEklvkoTXfdGMn5LvQ0EsnYpNkcn93foVzY7UFG+/zNB/9OOoIAyRlrV2ejrTphDadQdxcpVF10xl49ThF3GgUtNcAtTMWrizcgIticcOLdNkEDVsdCyFud1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvqwhkA+BsASdm4ZReAAMf6Dqei8afHq7ogOnJFzus4=;
 b=Z8movcFxZhxp4RALIKLo9CHOLQF8yBrpZrWIepY2kexptXYUiDDaBmGQTOxKztQUPSHxZLKP7tH6yTh55oSzjPyFjPxNtepqABGFZF6ifGCb0eR5yrS+KoEF1wZFpZxQM7oGjWQRCQ1VWZa308MFYB9nUFO9Dtg2GH1Z64et9053UCYflNElCOlEbH9dMN51SL0e9AODrkDqVwW1GmWfm3tLuD1j473fo7fpb6Mi+CUtcJD4JxYyLpW8ZR/wIPYl/4qlyCd+oarCzVOazQYZdwo1cGk08efGsHN5fLqqMqbuJkxT8hem94hYRA0EWFU7FRhwUlPNJ2XeNVUdwMPOaA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 05:56:52 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 05:56:51 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external reference
 clock input
Thread-Topic: [PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Thread-Index: AQHcRI+sdyu3yOSCC0+q89YO6Fq+57TRiAWAgAP/8bCAALbngIAA0q7w
Date: Tue, 28 Oct 2025 05:56:51 +0000
Message-ID:
 <AS8PR04MB88339961A776546B78E7267A8CFDA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
 <20251024024013.775836-3-hongxing.zhu@nxp.com>
 <20251024-unburned-lip-6f142d83ed76@spud>
 <AS8PR04MB8833DEEA9CB4CE4968B2B5F18CFCA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <20251027-marbles-tarot-92533cb36e1b@spud>
In-Reply-To: <20251027-marbles-tarot-92533cb36e1b@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU4PR04MB11315:EE_
x-ms-office365-filtering-correlation-id: 85f2c104-6da3-4717-ea02-08de15e6ca94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDhjcVlsRDc4WGZJZU83VDg0RlRpSGgzeXBLMGtCdGwwZXgxUW5icDRqZWZm?=
 =?utf-8?B?b281bW84MmVzbERIVGczdWdFMTJLVDZwUkkxQWVNczQxS3ZEMks2L3R0eERh?=
 =?utf-8?B?RjdVVlhLMHJqWkxGaU8vZUJwYTM1cjZOUFRhRUxxSnFVQmN3dHBMNEtIaE9v?=
 =?utf-8?B?ZU9jSGt2WXBmeGpHZXROcmZVWW5DLy9kUGZ1NlBZWXBLTjdCTDlsTWFKbXlU?=
 =?utf-8?B?TG1Kc2l0Mkt4T2tuYWY4T3BuLzZLd05Cb3JRSXMzV2FhdjVzVExxV0ljOGJY?=
 =?utf-8?B?aDYvMzl4cVRXb0FoMC9vakR2Zlg4YTZMUEVEbUJSWlQvQ3ptRE54WllXVjJE?=
 =?utf-8?B?K0RsNG5HN2VNWlVIVVdtUytXWEVrUWEvQU9KTGlrRXhJQW12eTlRclRVSW11?=
 =?utf-8?B?VWVvWnlVMzZUZ2xHZFVNbFNTeHRkMXVHUmJqVm04TXpHUUVMSHZua2NvVG9P?=
 =?utf-8?B?enNGaHBwVE1zUktYaWp5b09yekFLNGJqaGF0YmdiR0Y4OXV3NDZqbmZ6Slcw?=
 =?utf-8?B?ZXBYOXJjR1FROVhTRGxjMkp4TFROR3dPa2FueThLT21HZTFFYTN3YU00c0dT?=
 =?utf-8?B?QS8yNmhEWmpkK0gzakNvZ2NXTGREYUdTTkUxZHYxZU11S0V0QmlZa0NnNEZv?=
 =?utf-8?B?dDYxQVc5cTV5eHVzeU5hMWErRmVLbTRQVURGbUdmKzdMZ0xPSnVaNG54WnB1?=
 =?utf-8?B?SWZ0bWt4QVgzU1pFM0VJRldSVWV3TkxxaHJRTWduM0JCWFFLb2srTENpRnF2?=
 =?utf-8?B?TEVMMUowRUp6R0xnc2JDYXhpdTJoV2RKaGs2azU3WVk4RERGUkRwaHBhT2Vq?=
 =?utf-8?B?ZllrVHdwV2xvY1hPbmU2cXNkWnlhSVF0MXhIelp1T2tIZzl2eTJ6ZFRYTUlq?=
 =?utf-8?B?d3dhb09OMHhIRVpzY3Z4ZTRQeDlZR2RPTG1NeU1PcWlwWlBkd2NDVGxHMHZl?=
 =?utf-8?B?ek5mTzhjQjcralNSTnh1QlV3T0V5a1lnTjNuejdRRzdYZGhhc2FidjhoT1Mv?=
 =?utf-8?B?cVBFcnBWRUMrR3dVVW5SRjk3RW11eG9JTjVlcTBkNEMvQVRGKy90S2ZQYmsx?=
 =?utf-8?B?Tmh0NkNyRE8xejRrMkJMUWhuZWFhS0xON1o3SUpOVDFGNjJ3L3pCN1ZBaXVS?=
 =?utf-8?B?blNDUjAzLzVkcmt2dThRb0FpZzFrS2lmbEhZd0lGNzlkdE56UmlCdHdLYW9R?=
 =?utf-8?B?WCtxUm95dzFQRFhnNHdUc3Z2WGpJK05BUXpXeGlZaVFtdXNJRUFaKytaM0Nr?=
 =?utf-8?B?M1R0dTJxSGtJTkkxWExtL1o4S3V6U3ZjVkh6SUhueCt3ZHgyMlJZSnM3UldU?=
 =?utf-8?B?VFVmZVJNRFp0T3NEMk9kN0VLdkFCRU1UdktPZ1hTSEdGN3I2KzhvWTdPMGNN?=
 =?utf-8?B?RFhmNTd1SjlDTTg0TzVPUklva0hpUVc4U2FiS1hKa3pYVWlIT1kxOUJyNTlq?=
 =?utf-8?B?S0F5UktDVjRkUVVVZ1BNTHZJZ3hmcXAvS1N4Ui9YUGtKR3NsVFN6bXVxUlNR?=
 =?utf-8?B?ay9pYVNITzNLM1lIZU91Vm5pR1FuZklLTDdDZVFtN3lHakpsYjFJY3hpVFBL?=
 =?utf-8?B?K1dmbnlWK2dBOGg1N1VKMm1yRGNWMWxNTkZBeklKQ2VVZGFVUlJ0ZzIwVSta?=
 =?utf-8?B?WnRoZWtMaDU4OTBWOWhqeDhBcGY2dmRrQTRTVkFPMjBJUUJHQmlYQW1XTCtp?=
 =?utf-8?B?ZzF4SzQzSlJCZlVZclA1MzNnT2RpK2k1Zjh3OXBJcENkUmtYVHJzQmhqRFc3?=
 =?utf-8?B?ZVVPUTJIckhneHRsd2NkMkN6Y3dUYWhXcXVkaFZzOFk4TkZvWnA2d29NaldC?=
 =?utf-8?B?NkFxeXJTYzAzSjBodTBTM1hBcEo1ZmRxQ3dZaEdrWVpUWkxmQU5PVXFIT1E5?=
 =?utf-8?B?M2djNCs0YnhwYk1TQnhvOHpZcTBwT01ILzBDNGlUVmZNaVd4QXgxekcwdThR?=
 =?utf-8?B?UTNZc1E5Qjlva2RGTE55OE5McDlRbElnYWF3RVhibFpEd0JMK0pJRlJFeFRt?=
 =?utf-8?B?WVhpQTRUTmI4TUlBalQ2NnNNeVRYSlk4OE96b1ZaaUtXbDg4TlFpQlN0amd6?=
 =?utf-8?Q?9inrG3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzNzYnBoM0RLc3JKeE9kQllRQTNsM3MzZHlKRldaUDl1OEFsK0RKMFlCL3F1?=
 =?utf-8?B?bFR6ajkreWd2ZGFCbFZCS0VmdmRiM0t5dlc4MGVyUGJQUURFR3B1VG1YUmJ3?=
 =?utf-8?B?dDBYMlNGTUl6ZldOclkrRTRxRkQrTytsbEFBek1jbjRYMkkrOU8rdDZqQ290?=
 =?utf-8?B?WEMwZ3BKZnEvdzI3dklSRjBsUlhvQ2pjazR2cXlHaXVwMWhkd3ZPQ3MraE16?=
 =?utf-8?B?akY4Zis4WEFsZU1LMkFDRlhpVTdGQkgwMmdYd1ltbG41ZHlOaDI3TDlURWxT?=
 =?utf-8?B?d1p5UTBnNkV4RWdqaXVNNVhqNDgya0hGSWc2OVlNeTFIWjFzeGFIR2VIVHRk?=
 =?utf-8?B?ZUNzMm1GK1BnYkJUT0UzZnNZMnRhRTlCaWJRb3pEdCs3eHBwcE9Rc2xrNmdo?=
 =?utf-8?B?blpZYmVpdHoyOUEzK2RVYU00NTcrUndjaE05Z0tYU01iUy81Si8rWjJJeC9T?=
 =?utf-8?B?Nm5BbHkra29ZNEtPQWc0bXQvZ1UzaXhaLysyYXU4WHBkdFBMS1Zhc0UxZlIy?=
 =?utf-8?B?R1hoVndoWjRnQ3QxZUd0TVZtSHUyNDZXS0d5K1gwaDhleVREdHVOMnMrQ29o?=
 =?utf-8?B?am9qQ3U1NEorU1hybkpUZW1rRlBobnVmMElscTlKY1RLaUExWG9tOGpuekly?=
 =?utf-8?B?MTgyeHBweVJNcmY2TlBQS2lrSUxtMDZKT0VpcmlFbzZ0T29pZm5vdTdqV2VR?=
 =?utf-8?B?Z0FPazFyWU5uUzZiSDFhWjdJaHZxb1RhZTVHMkxIYWVFRnlDdml1MUQyZWZs?=
 =?utf-8?B?WWdiaFZSZG9aZCtLQmQ2TG1hS2s4cjR2a08zTjdNZEsvR2dKeER5UG9KYkQ5?=
 =?utf-8?B?RFc3OE5Hc0ZvaVR3OHZ5MzBKTXlIbmszWnB4d012aStvWU53aGcxczQ2WW5i?=
 =?utf-8?B?WWNReVZFaHJ6NENUOUgzUndWZXJMdWRQT2N1MXJtc2hoaVR5OU83dTN0K29l?=
 =?utf-8?B?NS9TVnlBZXFQY2g4dzlZWVRjY1kwWDlub2h1LzZzVU1PeTMyNFN2bzh1U2F3?=
 =?utf-8?B?NlB3OGpNck5yWlE2S2RsbndlUm9kZFFHZERVT29YbDdaa3hjZGVjRWxCdjM0?=
 =?utf-8?B?c25OK0lMT3BjcmhtMmFLNC9Pc2hOZHIrdnROTFlDZjA2dzZwMm45RWRITWtv?=
 =?utf-8?B?M0RlMnVTYjRXak1MOVZ4bXJNUlhKQUI3cVpEaE5XYUFwcXhLRWI5VEs4aGk4?=
 =?utf-8?B?NktvbmNxUkUwa3lGc09KOTUzK05QbGpIUEsxalV5anpjMnY2UXJUV2VTUTNR?=
 =?utf-8?B?N2JIQW94R0sxNExCTlYzZnp2ZzRzbXpiRXBMVzFZWEp4Nk9vZTN5NmZZa2Mv?=
 =?utf-8?B?eExsYkJxWGRRTTVwTmpLdVJ1b0hFTXkvRmtUN3RiRWorZ21tOTNqdk5ra21X?=
 =?utf-8?B?SzhscEwrdUQ4Q1RNQVEyTkM0aS9MRlQzdTViMVlHeEFJOVEvT2MyNUU1MVdm?=
 =?utf-8?B?SHZ6bk9ibGpZNGhpZzhwdEc5VnJnazV2b1A0cEEvOGE1TkpxMzhzaU9pTURp?=
 =?utf-8?B?VEZDcmNLKzBxNkREYkhyWlNIK21uTE54WFVnQWM0S21uU3lwWmlmc1p3SVJi?=
 =?utf-8?B?OVU1WHhucm9tK2lWMjNtRE12VDZMU0Jyb0F2aDBDUVd6Yzd2S2hVR2RFZFFW?=
 =?utf-8?B?WFcwWlkxSEVpc05UY2Fsd3pRNHlFcWhpMFc1YWZWaWRDeDMvdkYzek1KL0l4?=
 =?utf-8?B?SkxiK24zY1NobHpXenRNeGxuWUZyQ2ZZNHJJL1k1Vy9sYWhqTmt0dU5sUDEz?=
 =?utf-8?B?QVBkL0tMTkphTWtBQjRUYTV0QnhGRVEvRmZTVFkyc2p4azhqdC9JTFE4WkZU?=
 =?utf-8?B?aTc2Z1hvRFdnSmhkbXBxcTBHR3lVbVRtQUlueGNuWG9tZ0psaVFHWG00bzQ1?=
 =?utf-8?B?aGIzMU9QTlFaVnhKRTBHUnV6dUdpNFNjUDBSZjQzcjJ5MXZiTUd2U1pPNVVV?=
 =?utf-8?B?YzM5bGJWSzJ4d3JVMnJrVENLbGVhdHFmeHRKRDlQL3g4V0g0aHFCMUJEL1NP?=
 =?utf-8?B?bUpjK2xXNXRGcjZFVnJPOURXRlJvbGtRZ2JMM2ZMSUVtam1PbnMyUVNmbk5W?=
 =?utf-8?B?anhrS0JvY3lrc012Y3l0Q1VQMFE5QkRDL0o0SjdxM3AvN0IzS1MxWFRoRFFT?=
 =?utf-8?Q?omG0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f2c104-6da3-4717-ea02-08de15e6ca94
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 05:56:51.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6DlfcZWxXTefTdLnpwv6CoH9RgUefrxMj+eFSDGKDk2mGKy0pH87YKOyWsbo4r1r1bK/8BVEiTNKWgNJyyQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQxMOaciDI45pelIDE6MDYNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGty
emsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlA
a2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAyLzNd
IGR0LWJpbmRpbmdzOiBQQ0k6IHBjaS1pbXg2OiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlDQo+IGNs
b2NrIGlucHV0DQo+IA0KPiBPbiBNb24sIE9jdCAyNywgMjAyNSBhdCAwNjozNjozMkFNICswMDAw
LCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDog
MjAyNeW5tDEw5pyIMjXml6UgMTowNw0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5v
cmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBGcmFu
ayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+ID4gPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBs
cGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+ID4gPiBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5p
QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGlu
dXguZGV2Ow0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2OCAyLzNdIGR0LWJpbmRpbmdzOiBQQ0k6IHBjaS1pbXg2OiBBZGQgZXh0
ZXJuYWwNCj4gPiA+IHJlZmVyZW5jZSBjbG9jayBpbnB1dA0KPiA+ID4NCj4gPiA+IE9uIEZyaSwg
T2N0IDI0LCAyMDI1IGF0IDEwOjQwOjEyQU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+
ID4gPiBpLk1YOTUgUENJZXMgaGF2ZSB0d28gcmVmZXJlbmNlIGNsb2NrIGlucHV0czogb25lIGZy
b20gaW50ZXJuYWwNCj4gPiA+ID4gUExMLCB0aGUgb3RoZXIgZnJvbSBvZmYgY2hpcCBjcnlzdGFs
IG9zY2lsbGF0b3IuIFRoZSAiZXh0cmVmIg0KPiA+ID4gPiBjbG9jayByZWZlcnMgdG8gYSByZWZl
cmVuY2UgY2xvY2sgZnJvbSBhbiBleHRlcm5hbCBjcnlzdGFsIG9zY2lsbGF0b3IuDQo+ID4gPiA+
DQo+ID4gPiA+IEFkZCBleHRlcm5hbCByZWZlcmVuY2UgY2xvY2sgaW5wdXQgZm9yIGkuTVg5NSBQ
Q0llcy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxp
QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgMyArKysNCj4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdA0K
PiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbA0KPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+ID4gPiBpbmRleCBjYTVmMjk3MGYyMTdjLi5iNGM0
MGQwNTczZGNlIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gPiA+
IEBAIC0yMTIsMTQgKzIxMiwxNyBAQCBhbGxPZjoNCj4gPiA+ID4gICAgICB0aGVuOg0KPiA+ID4g
PiAgICAgICAgcHJvcGVydGllczoNCj4gPiA+ID4gICAgICAgICAgY2xvY2tzOg0KPiA+ID4gPiAr
ICAgICAgICAgIG1pbkl0ZW1zOiA0DQo+ID4gPiA+ICAgICAgICAgICAgbWF4SXRlbXM6IDUNCj4g
PiA+ID4gICAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gPiA+ICsgICAgICAgICAgbWluSXRlbXM6
IDQNCj4gPiA+ID4gICAgICAgICAgICBpdGVtczoNCj4gPiA+ID4gICAgICAgICAgICAgIC0gY29u
c3Q6IHBjaWUNCj4gPiA+DQo+ID4gPiAxDQo+ID4gPg0KPiA+ID4gPiAgICAgICAgICAgICAgLSBj
b25zdDogcGNpZV9idXMNCj4gPiA+DQo+ID4gPiAyDQo+ID4gPg0KPiA+ID4gPiAgICAgICAgICAg
ICAgLSBjb25zdDogcGNpZV9waHkNCj4gPiA+DQo+ID4gPiAzDQo+ID4gPg0KPiA+ID4gPiAgICAg
ICAgICAgICAgLSBjb25zdDogcGNpZV9hdXgNCj4gPiA+DQo+ID4gPiA0DQo+ID4gPg0KPiA+ID4g
PiAgICAgICAgICAgICAgLSBjb25zdDogcmVmDQo+ID4gPg0KPiA+ID4gNQ0KPiA+ID4NCj4gPiA+
ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGV4dHJlZiAgIyBPcHRpb25hbA0KPiA+ID4NCj4gPiA+
IDYNCj4gPiA+DQo+ID4gPiBUaGVyZSBhcmUgNiBjbG9ja3MgaGVyZSwgYnV0IGNsb2NrcyBhbmQg
Y2xvY2stbmFtZXMgaW4gdGhpcyBiaW5kaW5nDQo+ID4gPiBkbyBub3QgcGVybWl0IDY6DQo+ID4g
PiB8ICBjbG9ja3M6DQo+ID4gPiB8ICAgIG1pbkl0ZW1zOiAzDQo+ID4gPiB8ICAgIGl0ZW1zOg0K
PiA+ID4gfCAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgYnJpZGdlIGNsb2NrLg0KPiA+ID4gfCAg
ICAgIC0gZGVzY3JpcHRpb246IFBDSWUgYnVzIGNsb2NrLg0KPiA+ID4gfCAgICAgIC0gZGVzY3Jp
cHRpb246IFBDSWUgUEhZIGNsb2NrLg0KPiA+ID4gfCAgICAgIC0gZGVzY3JpcHRpb246IEFkZGl0
aW9uYWwgcmVxdWlyZWQgY2xvY2sgZW50cnkgZm9yIGlteDZzeC1wY2llLA0KPiA+ID4gfCAgICAg
ICAgICAgaW14NnN4LXBjaWUtZXAsIGlteDhtcS1wY2llLCBpbXg4bXEtcGNpZS1lcC4NCj4gPiA+
IHwgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0llIHJlZmVyZW5jZSBjbG9jay4NCj4gPiA+IHwNCj4g
PiA+IHwgIGNsb2NrLW5hbWVzOg0KPiA+ID4gfCAgICBtaW5JdGVtczogMw0KPiA+ID4gfCAgICBt
YXhJdGVtczogNQ0KPiA+ID4NCj4gPiA+IEFGQUlDVCwgd2hhdCB0aGlzIHBhdGNoIGFjdHVhbGx5
IGRpZCBpcyBtYWtlICJyZWYiIGFuIG9wdGlvbmFsDQo+ID4gPiBjbG9jaywgYnV0IHRoZSBjbGFp
bSBpbiB0aGUgcGF0Y2ggaXMgdGhhdCBleHRyZWYgaXMgb3B0aW9uYWwuIFdpdGgNCj4gPiA+IHRo
aXMgcGF0Y2ggYXBwbGllZCwgeW91IGNhbiBoYXZlIGEpIG5vIHJlZmVyZW5jZSBjbG9ja3Mgb3Ig
Yikgb25seSAicmVmIi4NCj4gImV4dHJlZiINCj4gPiA+IGlzIG5ldmVyIGFsbG93ZWQuDQo+ID4g
SGkgQ29ub3I6DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCj4gPiBKdXN0
IHNhbWUgdG8gImV4dHJlZiIsIHRoZSAicmVmIiBzaG91bGQgYmUgbWFya2VkIGFzIG9wdGlvbmFs
IGNsb2NrIHRvby4NCj4gDQo+IFJpZ2h0LCB5b3VyIGNvbW1pdCBtZXNzYWdlIHNob3VsZCB0aGVu
IG1lbnRpb24gdGhhdC4NCj4gDQpIaSBDb25vcjoNCkl0J3MgbXkgbWlzdGFrZS4gTXkgcHJldmlv
dXMgdW5kZXJzdGFuZGluZyBpcyB3cm9uZy4NCk9ubHkgImV4dHJlZiIgaXMgYW4gb3B0aW9uYWwg
Y2xvY2suDQoNCj4gPiA+IElzIGl0IHN1cHBvc2VkIHRvIGJlIHBvc3NpYmxlIHRvIGhhdmUgInJl
ZiIgYW5kICJleHRyZWYiPw0KPiA+ID4gT3IgImV4dHJlZiIgd2l0aG91dCAicmVmIj8NCj4gPiA+
IE5laXRoZXIgInJlZiIgb3IgImV4dHJlZiI/DQo+ID4gInJlZiIgYW5kICJleHRyZWYiIGhhdmUg
YW4gZXhjbHVzaXZlIHJlbGF0aW9uc2hpcCBvZiBjaG9vc2luZyBvbmUgb2YNCj4gPiB0aGUgdHdv
LCAgYW5kIHRoZXkgY2Fubm90IGFsbCBleGlzdCBzaW11bHRhbmVvdXNseS4NCj4gDQo+IFJpZ2h0
LCBwbGVhc2UgZ28gdGVzdCB3aGF0IHlvdSd2ZSBwcm9kdWNlZCwgYmVjYXVzZSBleHRyZWYgaXMg
bmV2ZXINCj4gcGVybWl0dGVkIGJ5IHRoaXMgYmluZGluZy4NCiJyZWYiIGFuZCAiZXh0cmVmIiBk
b2Vzbid0IGhhdmUgYW4gZXhjbHVzaXZlIHJlbGF0aW9uc2hpcC4gVGhlcmUgYXJlIHR3bw0KIG9w
dGlvbnMuIG9uZSBpcyAicmVmIiwgdGhlIG90aGVyIG9uZSBpcyAicmVmLCBleHRyZWYiLg0KDQpJ
ZiAicmVmIiBwcmVzZW50LCB0aGUgaW50ZXJuYWwgc3lzdGVtIFBMTCBjbG9jayBpcyB1c2VkIGFz
IFBDSWUgcmVmZXJlbmNlDQogY2xvY2sgc291cmNlLiBJZiBib3RoIG9mIHRoZW0gcHJlc2VudCwg
dGhlIFBDSWUgcmVmZXJlbmNlIGNsb2NrIHdvdWxkIGNvbWUNCiBmcm9tIGFuIG9mZi1jaGlwIGNy
eXN0YWwgb3NjaWxsYXRvci4NCg0KSW4gdGhlIGVuZCwgdGhlIG1heEl0ZW0gb2YgY2xvY2tzIHNo
b3VsZCBiZSAnNicuIEkgd291bGQgcG9zdCB0aGUgYW5vdGhlcg0KIHBhdGNoLXNldCBhZnRlciBj
b3JyZWN0IHRoZSBtYXhJdGVtIG9mIGNsb2NrcyBmcm9tICc1JyB0byAnNicuDQoNClNvcnJ5IGFn
YWluIHRvIG15IG1pc2xlYWRpbmcuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+
ID4gPiBJIGRvbid0IGtub3cgdGhlIGFuc3dlciB0byB0aGF0IHF1ZXN0aW9uIGJlY2F1c2UgeW91
J3JlIGRvaW5nIHRoaW5ncw0KPiA+ID4gdGhhdCBhcmUgY29udHJhZGljdG9yeSBpbiB5b3VyIHBh
dGNoIGFuZCB0aGUgY29tbWl0IG1lc3NhZ2UgaXNuJ3QgY2xlYXIuDQo+ID4gPg0KPiA+IFNvcnJ5
IGZvciBjYXVzaW5nIHlvdSBjb25mdXNpb24uDQoNCg==

