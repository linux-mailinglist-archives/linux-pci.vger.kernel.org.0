Return-Path: <linux-pci+bounces-25603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44004A836D3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 04:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CC318949FD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 02:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1B1E9B3C;
	Thu, 10 Apr 2025 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICaPPzGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA61E9B2D;
	Thu, 10 Apr 2025 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253157; cv=fail; b=V9hbvRATRgIakGn+/zeqx3md6z0XnXfUWvoQzoR619JvADPTW2OOAE1aa6eFTQrGP6IoNIktkGx1tkc8kZ5JCKGIxmhL1PXQhNcpymcpjn1KT4m5g8uWbVlToRtANvjQ8Tt7KlL1JvaXuR5B+dfr6OP6oHOss+dVL5m+rOAwzu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253157; c=relaxed/simple;
	bh=K0SzvFzdUta7z2lv+ZtQS4Appfa4McbZEsxL9ONCqNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AzOYP6fH36Djq56Sx7vKNxdAlo4w6ebnzx1P2sNje1z9JPCLB4bxlfBOKPkD4RA8r3boTrHMC+ee9feynm/oylLPKlz1a01RW07ja/77T6a6M4A045LCfh0tfLhiwJabSSAfkXsCJ3+pq12T4rj7i9Ouxry3BfMuxbmezRycdoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ICaPPzGs; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHbZO0QjampmKRHqSNWd99J6Ym/5R+hLL/iSiQncjUJPwPD3cJJSCOoOuX3hx1Onf10tGfL29ShH3Fpa25OA2cmRkr9VsajPonirTN4DmHRJkpIIr/nxme5TcSaz3HiQ7GtFbJCS3XWlKTbknJeZ7FvWgv0FbFPv/M6b/93i+8nGhIrKUmqCNqIrGh/riYiBAqqsid6WpHK1FG1kUideUxuMvHqPUeVpPB/bKMLgJOI1Q5tCfp9AgCOn6jtuiELudS0U1dY6sFdMFyTtG68s1mZ8QOimYHTnccsIJuz6bbF1svzqr4Oc8pMVuqAQxn0tl9O5jsD5YRL+9p74mCtWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0SzvFzdUta7z2lv+ZtQS4Appfa4McbZEsxL9ONCqNw=;
 b=jJKrRK83WDC9J8J++XQeRa97+3mOXDOfcAURZ81ssnbqrmzZ6Xj+esiXuwslGIOyGUkyYxS7wa9lbStR012Q+9Tas2y5eMXmrr3PHvQXoSMYM6fsmB3C7PwXFByKvc4JgRML8ZP8R1rtkqZjKd96ZDjIDnFsxuVEW3Qy8MtrSTKaMuCeclIAdNPefHRz3H//uKVQ1GmFYmLTScuFpBAbj2sl4QxlshUajM2485DREPIG++2TKR/Supk0SdGEXfLvF1IaWHTUXF450ZUhrAhy6O6ZCw2N65/pBOrXdzSdvmy4IhFlyVc1ADoLffAMiuBSyxL8jHDlB5zAtd/JjAsHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0SzvFzdUta7z2lv+ZtQS4Appfa4McbZEsxL9ONCqNw=;
 b=ICaPPzGswZFsovedW00z/zaMUvlIhZ3+4LNTztunTpREdq/r5pYzpHrgnbCUqCtmxYvsKxNPZO+AS5he6zF0j0Zp9rxCek5dwY2i6o3vvKfbiWziwF8cJeEQnxrXmsaR1x8u14LGJgomDSOMMKBlk4LnS1uehMfFW0Aptrl2J1bTMBsvbkZi//jfnOuZuBdg1vhDIBztlA/Rb08WlXFXeTg9hZs25T8DS9ndT7dNhN8+rcNo5T/kSsIwWngv1uEGvjWEm3NhOLflDXJ46B61u6VYS/oALcHLLboE5uUQr0h/PriOD58gVldv8CP+CSJtbPlcUGo2lgyXo4z3OzoYdw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9725.eurprd04.prod.outlook.com (2603:10a6:10:4e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 02:45:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 02:45:51 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
 ready
Thread-Topic: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Thread-Index:
 AQHbn44DKK1oo7avrE6ytacDA3gL7LOP/LQAgAAFMnCAAIO0gIAAxEXQgAfaDNCAAnoMAIAAn9+Q
Date: Thu, 10 Apr 2025 02:45:51 +0000
Message-ID:
 <AS8PR04MB8676221C998474EF5A9B94288CB72@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
In-Reply-To: <4qrfkx3ckywcbk7qbjplal5j7v6sjs3zebeehe5dnrgjz2ej2t@krdwjb4xm2sx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DUZPR04MB9725:EE_
x-ms-office365-filtering-correlation-id: 30a48bcc-4531-4cb1-0d51-08dd77d9ce82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0l2OVg1aE84RDlJQm83SnhUOFlyMGRsR3NpOXpoczNUK2w3bnBkczBnNHNx?=
 =?utf-8?B?aGs1a21aVm9OK1FzbWw3Rmpvc1FNWWp5c3ZHMWllSmcwSTA5UVZ3d3BMempR?=
 =?utf-8?B?OW96MmdwWmpKZmdBNlFlajQwYnFLZWJxZU84djNPMCszZEt5dThjRVgrV3Vp?=
 =?utf-8?B?WCtDZm9Ldmxqanl2ak1sMXJYYWJ2eGhQN2lsQXpCS0lhdksxWmgwdUs0NmJK?=
 =?utf-8?B?NC9RbVFxRXp1a0l6QTRDWCsrd0gzUVFHTHR3SlBadE5QaXZ6Sm4wR3BhWXpk?=
 =?utf-8?B?MVlNZlNtLyt1ZVhSOWZFbjA5TDk1YjhKRVJCRDJxWi81NkNCL1NDTlNiNVdB?=
 =?utf-8?B?bzZScXNQeEJ3cTRzWk5jR2FwVVlRYW5BRitJKzEyL3B5ODVmK1hoOEdza1Nj?=
 =?utf-8?B?b2JyZzhBR2dPWE5FWmFGSnNyTUZrdE5kRHlGR3B4SkN2b3JsQkVsSCthL1I2?=
 =?utf-8?B?K2tqdm8vNDFKRnRIZ1UzMFlqcWthRHJPNHBVQVdzdXVyYWpqaXFKSXBKNzBQ?=
 =?utf-8?B?MWVUODMzd2lGekJncnJIT2VYRmQ5dlJ4Njd3cDlGajVxS21VMk1QMWk5Mncz?=
 =?utf-8?B?RXRZQmZxTWZZbVBKTFZoM1BPdkh4QjVadWNnUHBqN091TXc2VVRQS2w1cXZx?=
 =?utf-8?B?Q0VKekZ4VUhiOHdaM29XekpWYWg3MmxTeEJtaW1wclRUbkZOdlJQckVCYkRr?=
 =?utf-8?B?MWc1cEVtWkxoNnFlL1k0SzFnWS9IdmRXdzd5dTh6TFZHZlpjZDBzbDVaNVRO?=
 =?utf-8?B?cis5UWFDQkNZQUcvMk9kaGd0OWV6emhXTmFlWlBJbGFDNEdwaHBLdGxkaVhR?=
 =?utf-8?B?aXZQaWExUDNJOU9FZlhjWEJSL0Uybm44RldLVnpxMnFlMldTNmlKWXVZSVhH?=
 =?utf-8?B?anc3SUtOZmplNmZ4NUxUQWJtRnN4U2M3S0FuQ2NTTnE0WkxCdzlNenh4R2d4?=
 =?utf-8?B?YlpOeHYwZ3ozVlJQY2JGN2lqSG5OeS8rL0JFa3A3VWN3VTlaWFQzYW9KT2h5?=
 =?utf-8?B?MXBtV3FMUGpzQWZNM3lCMHFTRm1FWEpYdGdNbFBKSEtNMEwzYkdGU3RDQ0Fp?=
 =?utf-8?B?MXBScmN1Y0ZLWlFVWGZ1YkltdU53VEIxSlpuSVhxRGNXZmNkbGtEaDgzbzJE?=
 =?utf-8?B?bFovQ2RURkNaODR3ZlhpM1pGdm9PdXMyekg0NGRnSFZhWFRaNzMvRENCWGd3?=
 =?utf-8?B?aU5YY0s5ZnFGdnpXMzA5OGk2Y0JYNWg4cFhTa2NvekFyY3RqQ1VqdnBvcEw3?=
 =?utf-8?B?YWxKWGluc2tyOER6T1R5cWVOODdGNXlpRjMyTXVvWjdCM25WampEd3VDN1gz?=
 =?utf-8?B?STViZGlZdEViNTkyakNYUno2UHdMcWw1SDNaNUduVStneTRROVBpMEs1M3Zl?=
 =?utf-8?B?a3lKOEJkVW9HdzNYMnlFVmc3NjZBMFdBdlFCK1FlWnVrU2F1dWdPWDlSd051?=
 =?utf-8?B?NXU0T2xCckZGem1WT2l2dUlJNVdaN1B5QldLU2xGKys0citIMHIrMzAzY2Rr?=
 =?utf-8?B?MERVL3hhVmExU2Rva0ZTZ1pXNVVsT2cyS242ZnhNSkVQa1VBWU9rdEMycFcw?=
 =?utf-8?B?OXRvbzl3cjBrcnU5K3QyODZBOVhjOUpXYURaV0xvNWk5dDBiNlNNejd0Tk5M?=
 =?utf-8?B?NVdIVG1rMVVGZ3Vac2FtU2xGRVVWLzRkVnNZQmdEdXFISGVzK1JPNXVYSll3?=
 =?utf-8?B?ZkRUMTRmWjZGTzFYZFovcFR1ZldRclVxSVI0dzhjd2VqNE5jczVwRnV2OVJB?=
 =?utf-8?B?K01SWTg5encrUkxGSnVQaFZJR0hhejRqb0RCLzNtZWgzQ3pmRjQrVHdhczZm?=
 =?utf-8?B?UzFKV1g3RTA1bzhFQjFwdnA1RnlwQ1VGOUsvcXFseHdhOVBXd3gyMUhQc1Z0?=
 =?utf-8?B?bm95c0hHa1JiOW1YeThVWUdsWUg4TE5pdXpDM1YveUtLMHZ3SFFCdTgzODho?=
 =?utf-8?B?b01aU2l0d0tkYmRKTVVXSWVsb3Q2SkxVV2pUTkVxYk5lMjhPM3k5MHdtMmxr?=
 =?utf-8?Q?F5Gd0To+A3FM5RQvcL3lrF5o3s4RgM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0NzK2lCN1Rkcm5Sck1EeHdHVnN4dWIzdlFoU0xWd0dReDdmaEw1NnNTazFY?=
 =?utf-8?B?ejRsaHY5N0FMYWJpNUFQdWlCRWZaVGVoSnFsM2liR0FPM3grMkNuNnY3YTBu?=
 =?utf-8?B?VEhkaGEvMXMvTGtBSVhxWGVORGQxQmkrbVVNOTdPZE93RW1WR0hrQlV2cWF2?=
 =?utf-8?B?Q01vTW5zelNqakJ2NnVBMmNmeEZzRDFqMW9PQlRCaXlwNHUyY3J0NForMFJW?=
 =?utf-8?B?YVoyMmk4MmVKd1duYW13bzNnYmtuTmE5emgzVjhOUzViQ3ExNHA0MUM2azV2?=
 =?utf-8?B?blQwTzZoTXpGZ1dXaHlrUGNuVlQrNWtUSmV3T0tqdFhHbjE3YTFpa2daT3BF?=
 =?utf-8?B?YWRMT2YwQjZ3VDNvYVZ2UGFONmhCaWoxajd5czI5eFdLYnZkcWdUdzlXZjNj?=
 =?utf-8?B?czV5YnlCS2h6MXdPcWFReDArbFJiY0pueTN2R0o5cEJFcjh5eFdDamh2TXh2?=
 =?utf-8?B?NjQ0TmRyOTlKRUVWdjVIaDI1ZVJLSUxFOU9QOWh6a2I1anJ1OEZUQ3A3NmJU?=
 =?utf-8?B?YTZPaURWbHlKaEFNeDlmd2VTM0dzTW00UmdReTJ1MFZHM1ZwSG5wZ3FKZjAw?=
 =?utf-8?B?dnZWMDVyd3Q2cTBwVUVrK3ZQM0JFQUlwS0xXRUtPZnNoMDVNS3ZkOVhpQ2dj?=
 =?utf-8?B?NlA0SG9KTHl1VFF6TVJlOURXY0VEcGFnU1B5Wk1sOVFTeUNaVi9VY1ZxOFI0?=
 =?utf-8?B?bEE0MExCMjJib3B5K3JXZnlUQjZCbUtJUlhJdnM2cEtXNEdkU2hGOEwrWVNX?=
 =?utf-8?B?dDhLSUhRMUFyL2p3YnFwT1hYMEFyWndPSDJ5bmZyVC9nSmhxUC90TU9uLzc4?=
 =?utf-8?B?Sm5rL2RtWmNYbXBLUjFtdUo5cUZROHg5emtGVUd1UW5lZ0hSWmZuS1pqOTJC?=
 =?utf-8?B?clA3Rnp5dndSaGo3MTRtUEpqTm04a2FpVG5ySGZUSDBhSU1TNEl2WUkreUF5?=
 =?utf-8?B?ZFpydDJzK1p2Rk94cUIxdGtwYndUOHpIMjdCSFM3VjdZUWs0T2Zaa3plN2ow?=
 =?utf-8?B?UUdFTGxrWkxMUzJidHBMYlIzbkcydnQvOHRBb0JtRTZWOVNrWWVZZUFtRzFt?=
 =?utf-8?B?TmxBNmtLa0daT1p3TS9CcU1DYW1uc2QyNm1iTG5iOXdXNkkybU1BRE9JZ1Y3?=
 =?utf-8?B?c2RTNXR1eGFuSjFKK2NpSjhWN2hLaUF1T1lqL3lIZSt0eVQveDZsRmJDdS9h?=
 =?utf-8?B?Ry9TckxUNnNENmExeS9ybjV6VlViZCtULzh4SVlGQUtMWHpkdHdpK2FYbytR?=
 =?utf-8?B?alFrcGhVbzN0T3JhemovdVplS09nbFlGdmw3c0ZmeHJCTldzZjVlRitCblM2?=
 =?utf-8?B?VXhMTlFBZ1ZBUnZRRDJVcDlhTFBFYXJOZWwvdXd3ZXdhaTB6MXFURG55MDBH?=
 =?utf-8?B?NFZsN3JyUTkrV3RRc1FNMVU3MFc5aEhWN0w1YUtWUnF4b1I5VnpvdDZabnRQ?=
 =?utf-8?B?MmUvR2ZtSURiV2lnUmdZbC91S3FwNTZEeHJRNWh2LzB0OUV3eFB3QVlzTm4w?=
 =?utf-8?B?NXNYaHNsZ1doUy9YSnUwYVczbHE4SWtaaUc4SmxWVy83ZlltaWg3UW5IQVQy?=
 =?utf-8?B?ZjVxL0Rwak1EbVJudGlXd3crc0lwSTE1THNrRTF0Nm0vcFZ6Y3lvQnJ3bTla?=
 =?utf-8?B?U1BKWUR0RWEzVHVtQmZuaXEwcVk3MVJFQ3N0SFFueTdWUVNDZTVyWGpEWFhi?=
 =?utf-8?B?bVhUZUpkRGdCVHRDVjJRSENPaTQxTkRSb2RGZUg4bFNzNmtZWkNsS1cwdkx0?=
 =?utf-8?B?ekg2WkdzN0k1L080Z2VIckNsQ0lrTHdEZXdUT2tyd3FvcWRCNVFMZTFMaE5s?=
 =?utf-8?B?ckNnQ211SDNIT2RJTmkySVcwdWZqMXUrc1IwNGc2djRYeXQ3Z1R3aDZsZ214?=
 =?utf-8?B?VnV6aWVlTWMvVm9sRS81Z2ZKWkhJbWlUVVgzcFJmWWkrcjd1Z2d4S1FmYzBW?=
 =?utf-8?B?aThOSHpIYkF4ZGROdFpjcDR1WTdJZ1pDK3JNM0JwSm9HUzhXNmlwWlNjZnJM?=
 =?utf-8?B?ZWJNY2w2clR2bTUyK2l2ZWFlbzRkREdwdkNRQ2d2MGJYdGVSay9LNnc0a3BF?=
 =?utf-8?B?RllaaElmbC9zTHVLUU5sZ3Z1U0hCUndCYW10ZTlZZS8wWkdTRHNId3J0QXpu?=
 =?utf-8?Q?mspzsnSQq+JRNQ4iZnStdjvNy?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a48bcc-4531-4cb1-0d51-08dd77d9ce82
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 02:45:51.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD+HbVKo9a4emT5eIiP2GZjbjQs3aze0EvQNvXbrPs6RWITjz10+9wdoD9cbQmhcGnVL6DcMhmEjeImvgD5KBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9725

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDEw5pelIDA6NDQNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29ya2Fy
b3VuZCBpLk1YOTUgUENJZSBtYXkgbm90IGV4aXQgTDIzDQo+IHJlYWR5DQo+IA0KPiBPbiBUdWUs
IEFwciAwOCwgMjAyNSBhdCAwMzowMjo0MkFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSG9uZ3hpbmcgWmh1
DQo+ID4gPiBTZW50OiAyMDI15bm0NOaciDPml6UgMTE6MjMNCj4gPiA+IFRvOiBNYW5pdmFubmFu
IFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+ID4gQ2M6
IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4g
PiA+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207DQo+ID4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDMv
Nl0gUENJOiBpbXg2OiBXb3JrYXJvdW5kIGkuTVg5NSBQQ0llIG1heQ0KPiA+ID4gbm90IGV4aXQN
Cj4gPiA+IEwyMyByZWFkeQ0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhh
c2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+ID4gU2VudDogMjAyNeW5tDTmnIgy5pelIDIzOjE4DQo+
ID4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBD
YzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0K
PiA+ID4gPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwu
b3JnOw0KPiA+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiBpbXhAbGlzdHMubGlu
dXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMy82XSBQQ0k6IGlteDY6IFdvcmthcm91bmQgaS5NWDk1IFBDSWUgbWF5DQo+
ID4gPiA+IG5vdCBleGl0IEwyMyByZWFkeQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIEFwciAw
MiwgMjAyNSBhdCAwNzo1OToyNkFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gRnJvbTogTWFuaXZh
bm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+
ID4gPiA+IFNlbnQ6IDIwMjXlubQ05pyIMuaXpSAxNTowOA0KPiA+ID4gPiA+ID4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiA+ID4gPiBDYzogRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gPiA+ID4g
bHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4g
PiA+ID4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4g
PiA+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+
ID4gPiA+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
PiA+ID4gPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNl0gUENJOiBpbXg2OiBXb3Jr
YXJvdW5kIGkuTVg5NSBQQ0llDQo+ID4gPiA+ID4gPiBtYXkgbm90IGV4aXQgTDIzIHJlYWR5DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT24gRnJpLCBNYXIgMjgsIDIwMjUgYXQgMTE6MDI6MTBB
TSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEVSUjA1MTYyNDogVGhl
IENvbnRyb2xsZXIgV2l0aG91dCBWYXV4IENhbm5vdCBFeGl0IEwyMyBSZWFkeQ0KPiA+ID4gPiA+
ID4gPiBUaHJvdWdoIEJlYWNvbiBvciBQRVJTVCMgRGUtYXNzZXJ0aW9uDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gSXMgaXQgcG9zc2libGUgdG8gc2hhcmUgdGhlIGxpbmsgdG8gdGhlIGVycmF0
dW0/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvcnJ5LCB0aGUgZXJyYXR1bSBkb2N1bWVudCBp
c24ndCByZWFkeSB0byBiZSBwdWJsaXNoZWQgeWV0Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBXaGVuIHRoZSBhdXhpbGlhcnkgcG93ZXIgaXMgbm90IGF2YWlsYWJsZSwgdGhlIGNvbnRy
b2xsZXINCj4gPiA+ID4gPiA+ID4gY2Fubm90IGV4aXQgZnJvbQ0KPiA+ID4gPiA+ID4gPiBMMjMg
UmVhZHkgd2l0aCBiZWFjb24gb3IgUEVSU1QjIGRlLWFzc2VydGlvbiB3aGVuIG1haW4gcG93ZXIN
Cj4gPiA+ID4gPiA+ID4gaXMgbm90IHJlbW92ZWQuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGUgcHJlc2VuY2Ugb2YgVmF1
eCBhZmZlY3RzIHRoZSBjb250cm9sbGVyLg0KPiA+ID4gPiA+ID4gU2FtZSBnb2VzIGZvciBQRVJT
VCMgZGVhc3NlcnRpb24uIEhvdyBkb2VzIHRoYXQgcmVsYXRlIHRvDQo+ID4gPiA+ID4gPiBWYXV4
PyBJcyB0aGlzIGVycmF0dW0gZm9yIGEgc3BlY2lmaWMgZW5kcG9pbnQgYmVoYXZpb3I/DQo+ID4g
PiA+ID4gSU1ITyBJIGRvbid0IGtub3cgdGhlIGV4YWN0IGRldGFpbHMgb2YgdGhlIHBvd2VyIHN1
cHBsaWVzIGluIHRoaXMgSVANCj4gZGVzaWduLg0KPiA+ID4gPiA+IFJlZmVyIHRvIG15IGd1ZXNz
ICwgbWF5YmUgdGhlIGJlYWNvbiBkZXRlY3Qgb3Igd2FrZS11cCBsb2dpYyBpbg0KPiA+ID4gPiA+
IGRlc2lnbnMgaXMgIHJlbGllZCBvbiB0aGUgc3RhdHVzIG9mIFNZU19BVVhfUFdSX0RFVCBzaWdu
YWxzIGluIHRoaXMNCj4gY2FzZS4NCj4gPiA+ID4NCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5
IHRvIGdldCBtb3JlIGRldGFpbHM/IEkgY291bGRuJ3QgdW5kZXJzdGFuZCB0aGUgZXJyYXRhLg0K
PiA+ID4gPg0KPiA+ID4gU3VyZS4gV2lsbCBjb250YWN0IGRlc2lnbmVyIGFuZCB0cnkgdG8gZ2V0
IG1vcmUgZGV0YWlscy4NCj4gPiBIaSBNYW5pOg0KPiA+IEdldCBzb21lIGluZm9ybWF0aW9uIGZy
b20gZGVzaWducywgdGhlIGludGVybmFsIGRlc2lnbiBsb2dpYyBpcyByZWxpZWQNCj4gPiBvbiB0
aGUgIHN0YXR1cyBvZiBTWVNfQVVYX1BXUl9ERVQgc2lnbmFsIHRvIGhhbmRsZSB0aGUgbG93IHBv
d2VyIHN0dWZmLg0KPiA+IFNvLCB0aGUgU1lTX0FVWF9QV1JfREVUIGlzIHJlcXVpcmVkIHRvIGJl
IDFiJzEgaW4gdGhlIFNXIHdvcmthcm91bmQuDQo+ID4NCj4gDQo+IE9rLiBTbyBkdWUgdG8gdGhl
IGVycmF0YSwgd2hlbiB0aGUgbGluayBlbnRlcnMgTDIzIFJlYWR5IHN0YXRlLCBpdCBjYW5ub3QN
Cj4gdHJhbnNpdGlvbiB0byBMMyB3aGVuIFZhdXggaXMgbm90IGF2YWlsYWJsZS4gQW5kIHRoZSB3
b3JrYXJvdW5kIHJlcXVpcmVzIHNldHRpbmcNCj4gU1lTX0FVWF9QV1JfREVUIGJpdD8NCj4gDQpS
ZWZlciB0byB0aGUgZGVzY3JpcHRpb24gb2YgdGhpcyBlcnJhdGEsIGl0IGp1c3QgbWVudGlvbnMg
dGhlIGV4aXN0IGZyb20NCiBMMjMgUmVhZHkgc3RhdGUuDQpZZXMsIHRoZSB3b3JrYXJvdW5kIHJl
cXVpcmVzIHNldHRpbmcgU1lTX0FVWF9QV1JfREVUIGJpdCB0byAxYicxLg0KDQo+IElJVUMsIHRo
ZSBpc3N1ZSBoZXJlIGlzIHRoYXQgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGFibGUgdG8gZGV0ZWN0
IHRoZSBwcmVzZW5jZSBvZg0KPiBWYXV4IGluIHRoZSBMMjMgUmVhZHkgc3RhdGUuIFNvIGl0IHJl
bGllcyBvbiB0aGUgU1lTX0FVWF9QV1JfREVUIGJpdC4gQnV0IGV2ZW4NCj4gaW4gdGhhdCBjYXNl
LCBob3cgd291bGQgeW91IHN1cHBvcnQgdGhlIGVuZHBvaW50ICp3aXRoKiBWYXV4Pw0KPiANClRo
aXMgZXJyYXRhIGlzIG9ubHkgYXBwbGllZCBmb3IgaS5NWDk1IGR1YWwgUENJZSBtb2RlIGNvbnRy
b2xsZXIuDQpUaGUgVmF1eCBpcyBub3QgcHJlc2VudCBmb3IgaS5NWDk1IFBDSWUgRVAgbW9kZSBl
aXRoZXIuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLSBNYW5pDQo+IA0KPiAtLQ0K
PiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

