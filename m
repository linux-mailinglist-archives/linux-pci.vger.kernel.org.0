Return-Path: <linux-pci+bounces-35732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCEDB4A336
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B3B4E0107
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78E307AE1;
	Tue,  9 Sep 2025 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqNkKaSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A07306D3E;
	Tue,  9 Sep 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402098; cv=fail; b=PMjY+nwE6TfcmoCPpdhOnUeJMpan+jybxpvUJDgJ8D7FMmdPSp6zYST0ykV0yzIefGzyNzbZDIuiXdZT60zu9Jq1/ZSpkZ3LN7vkmB2x4ySu0rRVMu6ahBAis0RulGj9koXZ3sTkz7K+FHDoL5IfnZD0ULnVmQge1QrzkMFyUJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402098; c=relaxed/simple;
	bh=H1ap6DEUovrxdVXlyIDBghiKs5NUw8bba9/5oUucL64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n3du6q820hsBxe+NPa8QDxLwD/nRF+d1XBVLXY7+8ZJbys0akWpY3ZHWPisebqHJtG43gUiZJAhRtJGsle2YmxOaKeTmgfT/CUat3/iTm6U6gexKwGcDG80BFUJW/HLSMs0VPZPl/xGY3uXz2wN5ac2QGRUgAQpu+Wo2Ax1Wtyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PqNkKaSD; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntgf5oiY2fbBlN0Mhqd2W6kzY34bYJaakYMQRiESDoh/f6Glo72/b4GMjxp8bCpOS5uSN0UhcDYlPGPGeN0JZBpu8LdJ3B7KNIYd6W8G0nsRZGgt03NpoGMqVBRBAf3bOS+C2pFnQDkn+pqGmUSnqiJNCpL0I/JII8ndHQLg0T+DEpKcnpnfV7BKCZ3EyCmbkpXx9S03haHcR7cIYXJVe2pw4TBvVExJcrmNAQVq6jEJNfT3a9sCgKlUtUumq8kYhXkwHdrB9qiJoB178Zu314gED6MdItjnfgr2metbj2TcsMys7QFQHt+dKvNYZto74k9wj3Et8HVxeF2Vp5gX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1ap6DEUovrxdVXlyIDBghiKs5NUw8bba9/5oUucL64=;
 b=tETPPuKBM9Q3PB5gVrBr6fufvsgg8aiUr2aLgp97WEfMr9unoRd5YteTtfU8kbStSZPDGCVnKhmB3uERXc+b7FxyFljOyD7HOrpwGm+NoRML0KKA41o+ZaGOsHZnjemlOIc2G1cnafL4m0N62SD5cVUIBa0uaNQ2xpL5l8rtTqNTDc2meFjk1ZSzUftCrhDWTaCHbZtx0mvzfNb3I6An9NZ6z8nTxJC0nyTYteCNy4GULYvXvfCqmqv/0kO2hngVJbMd8JDx7OSCmZPz3z26Xhc4p7KUq+sqQwpsJJi+vqwDGTpsjG38TYSSlbBDBOlU8gTgAj+oHEQ5NnN0kxwyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ap6DEUovrxdVXlyIDBghiKs5NUw8bba9/5oUucL64=;
 b=PqNkKaSDzBbOE1Isk5QGeo374i6r5AHh5gUENAP/KWRfA9nORO9j/fMrj8m4WVW39wI00s44Exyf1GJd87bLvCsO52GBVV/pnuziGAzD02F3QHObhi/N81l8XQduLta8VBxskFQeNvUnlgw7FdeThUaAIPS7CpKG4pehMwjCBSK7VyUAcE+d1W6IM1vCYhCMEqMdpZtxqw+Gi4ldvwVjOtrHnkVBPHkD2JBEzsvPZ9By6NTb+kdofaM1gcYpsep1vYaLqAknhYgd084F1JDQ7u4YXaoSs6iH6JBtRhwW2icapBdcyqjKLjs6INYlmksc/cmkcNaHWnsvpfEnWtoYGg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU0PR04MB9494.eurprd04.prod.outlook.com (2603:10a6:10:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Tue, 9 Sep
 2025 07:14:52 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 07:14:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ# override
 active low
Thread-Topic: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Thread-Index: AQHcEaoMjRru1StCnESzEOZ/k0fwQrSI6foAgACcgYCAAAaQAIAAC/uAgAD1tYA=
Date: Tue, 9 Sep 2025 07:14:52 +0000
Message-ID:
 <AS8PR04MB8833BB1398869A112F3760A08C0FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
 <aL71k+CeZEwTnn86@lizhi-Precision-Tower-5810>
 <ruhcvw3oqalrspkbl4ay5vebomatww6wbirwzowxyqxq7sdjou@yba5ri45j24w>
 <aL8FId/JQOfyv4Gd@lizhi-Precision-Tower-5810>
In-Reply-To: <aL8FId/JQOfyv4Gd@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU0PR04MB9494:EE_
x-ms-office365-filtering-correlation-id: 247d716b-14cd-408e-f8d1-08ddef70923c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0xva2xCbUMxVGpwcWI5RkJnMVFFWFRZSWZyMlVSQ3lHVWdFVkhER1BESkZz?=
 =?utf-8?B?R1NFek1vT2ZKY2YzRUsvZmpmai9jSXRDQVZOd1ZvemVDcWxPNVR2eVZ6MkZr?=
 =?utf-8?B?cGd5b0hWZy94UlI4cWRyRzNVQklYVW5vTTNYWkZyWGxYZ05xalR3WUNuRzRQ?=
 =?utf-8?B?Rms2Z2xxM1ZTcEtETDFZOHpmVHcydGs2eEZrL3hoUWIyN1hQWjRVL0Fzdjhu?=
 =?utf-8?B?Wm5UblkvWng3aHpleFdJZWYyYmZMVDMrTUQrdC9GYkJYTmJkZk1jQ2dxakc5?=
 =?utf-8?B?MXEwM05aejJFR3BCanpPTmFMQlh6YTIvdThLdG9CMCtQbE92Skw0cHByUzFS?=
 =?utf-8?B?UjBBNEJrVE9VVWlJbStsNXozSFVkSTNWam5vbnJNUG4zblJpY1JvOGxaY1hv?=
 =?utf-8?B?QjBiMy9BMU1rS0dFdHhnZmN6bzloWlZVRUVaRjk3S0VBZHM3RVVpR1ZaOVJD?=
 =?utf-8?B?eVZLemp0UXhPUGJKdmtlTWRLZS9vYWVPLzlmcEswdnVIZVVjRnBCWGplcXpU?=
 =?utf-8?B?czJYRG9Salk0aW5iTDc0TUVZNXl4akREMDZvazcxbzlveTdDT2libFlud29I?=
 =?utf-8?B?VmxuMXRCanRzaDd0cHlYZUFFdXVDQytlbk9JN1FkNTJpVmI4THd0M2FUNG4v?=
 =?utf-8?B?bU1oK3ZocFpPU241WnVsUWUrY2UxWE5UNnpwTithYzNkdkxOMENhWHB2a1Bh?=
 =?utf-8?B?ZFoyQ3lWaE9ocklwbWxIZjBUaHl0SlA2aXU0Rk5vZHNhQlZ2SUlUZVZzbUhN?=
 =?utf-8?B?NndQVVZja1VSbzV4QmxVN01SYzN0TTVRMEk5Z0prcUIxSjZGUVZSNFdoTWQw?=
 =?utf-8?B?bnEwQ3ViTEhkVTdPRHdsOUdDVTJaSW9keWl4bk5vZmdTd0J3eEh0RUMzaDNo?=
 =?utf-8?B?aVBYSnFmamdmYlFaOWx6TmtXYlFDWkt3VkIwSlVQcitiYnpyS21tck5LSVVw?=
 =?utf-8?B?ZFFvbXRTM283VkMzQms0TkpWcVhLa1kvcmw4OTNUTVFOeFMzcm5hcVdJa0Z0?=
 =?utf-8?B?SXZDM2I2Lyt4MTZURWRaQXZ3WkphRkt1R3NRMHlOdUJxY3BpZDJOb0tYbys4?=
 =?utf-8?B?Ny9aQlFkUlJHNFc3dlhlbEtSZjRweS9NSlEzaFFjMTdNVzBtYUg0NE9vcHNG?=
 =?utf-8?B?aSt6dVRxV1REL1UxeWcvN0hJT3hJWXp5WGJVK1g4MUhOVlo5Vzl4aWdKVFFD?=
 =?utf-8?B?a0RaSzVkZHJVeVBBQ0F6TWg2dUpPWU9Dcm16dU1JS01RK3hoVHVGV1hGc3gr?=
 =?utf-8?B?VHk0NFpZdFRiemdpdVJQUmlwelExSWVIdEhhMnQ3R1FEQUZtZkcxME1MUUta?=
 =?utf-8?B?OENJb0YvZzhlZjU5dVYyUW1HRTZzcnBXaEF0VTRleHpCVVlOQ0J6UCtCVDZ5?=
 =?utf-8?B?N3JiRVJKR1drakNvZzFxY2FwRWNZeGFYRXZFNElPNDVMRFV4dURUcXkwM0l1?=
 =?utf-8?B?QWh6R1Z4REhGR1RhY3k0M0pOYVNoMEhWKzdZZVJOZmRvRkV1WnovZkIxZ29D?=
 =?utf-8?B?NXhKNVNvMnJ4MWFkeE9vYUg0S0dJYzNHZ1g2aVN2MkdhR0h1a1JSVzhRaXdT?=
 =?utf-8?B?MHE4aWd2NHlvQzBSWjQ5aXFSNS90WjBMbFdQZkFRZ29ZUjVLQVBCUU51TU1z?=
 =?utf-8?B?Y3ZsVlJaU3k5Zlo5UTBkSGI4TjR3ZTV4TlRTdkNaMTR4MFpBR1k4djBCYW1o?=
 =?utf-8?B?bk9WU2xOMmo5Y285SHFLY2FlKzI1bVBjMG81ZlZsQ3Q1bHdZZUEvMWpycWpK?=
 =?utf-8?B?VS8rWHdBVHE0ZCsrdnR6YkhRRjRuRXVwUkswWkNiTFpmbDg1VUVGMEtNdjhj?=
 =?utf-8?B?NWJwbFNMZG0zaVorY1ZJV3dmQ0F4enpJYWs2d3lBNHdwVVhyRlczOHBqZG5q?=
 =?utf-8?B?NGpYVmZHbDI5QjVNWnh6S0VDaTJrNGtCOWRpVnNJSGpSaFpDWUN0TjBqcG1w?=
 =?utf-8?B?eWszQWlwMU95cGJZdE0zRUkyNnJvT1dJcHlET1hLNUtlcHlRZ3VzOCs0d005?=
 =?utf-8?Q?TnCXxrOrlia0vfx+1cR/1XYK9nh5aU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTA3SG4xUE9nYWl0S3RRdGEvbHB1L0l0Zk50L3h0bHZCV3ZEcHl2cXQ4b3B2?=
 =?utf-8?B?VWx3aURHSGY2b2xhcHI2cmNEcjgrdzZ4UWJHbHZ6SmI5dG9iY1pabndUVXpj?=
 =?utf-8?B?bjRzVkdPeFBWR29laVU1bDA3TGVwWXVXU3ozTkdySFBMbGxkTWVUZmtTM1ZI?=
 =?utf-8?B?dktWdUdzcGhEY2haWVlqOWpoN05Pcmk2Y0hXb2JoU3FFUkQ2RHF6VjlIUFp1?=
 =?utf-8?B?YlpzN0RvV3RwOHBwMUwvMS9BTExRbllLSEU5NVp0QysySzFBZGF6WExmdTk5?=
 =?utf-8?B?S0tzMkY0ekY4ZWRXV1ZUcUJRSlNCRk14NmpIRENtYmEwYmkxeTdPLzJxRWpp?=
 =?utf-8?B?MkZpWCtyWnRKc0ZXSFlyMWEyYURtTXFJOWZpYXBZOUlXZllBUmNwQ0orOHgw?=
 =?utf-8?B?TVg3dnNiTGRER1JVR0pJSkE1U0gyYUpienBRNWFHMG9DOTJMU3BxdWtXdERn?=
 =?utf-8?B?WGN0OU5yeEFmaEd4MlFndG5aOWtuVlRJWG9XNmJiaXN3ZGJVS2ZIeFhlMWc4?=
 =?utf-8?B?ZVVENytZL1RMRU8zV0ZUbGJiaXdBYTFyRk5PZ2VDSEdja09JNVlyZytIeCs1?=
 =?utf-8?B?bUI5UzhNcXR6dk0wSWFRY2RpVUtrY1h0MDRlbHRnbFpyVTNoYTFhMERGSG1W?=
 =?utf-8?B?bFhDMkU2OFlSbVF0U05yN3NEdEsydmRxN3htN1YyZGRLVWplOHJwY0Nlb3M2?=
 =?utf-8?B?U1lIcVJZUGlzUnl4TkJOOWxGTmhGekdyWElNdXF0OE1QOWZsOXQvUjRNL1dh?=
 =?utf-8?B?M1pZakcwTGVFNnI4TmxBSEJ1NVdMVkZGK3JUNTZlby8xcERiTm5tdzNvQm1P?=
 =?utf-8?B?TFpvbnkveVIxMXhoQVFRZmdJM05WNjVVV1lGNi8yK204Wi9LK243QW81OHhM?=
 =?utf-8?B?dzBhdGRaZkhURDllL0VMWGZ2VSs5djVmc2xCTzdDdmVFOUsrNEZ5M0tENlk3?=
 =?utf-8?B?Skx3N3dKa1lhTnBNU2toRkluSU5tMVYwd1I2ZWNTNTFwOG8zM1NocjJOYXl5?=
 =?utf-8?B?akFhenZldTl6Z1hHUHNKT01uL2YvREFOdTdyU1RhVFZkaWJhSzBjK0hOeTl2?=
 =?utf-8?B?K1h4cjlPRXRBUjZvdmQrQWdtbU1qUkQ0TVVwa3FINUkrQU9SMG14UVp0ZkFr?=
 =?utf-8?B?OGVBOHcwU0h0ejlVNzZ2WC9qZmJ0NWtDVStsS3dkSFVUc0RxczUwVGNLZnBI?=
 =?utf-8?B?MDdBNzdRc3QwUWFBK1VmeWFTREpMbmtySkFmUlFub05hZWI1T0ViMExnQU9w?=
 =?utf-8?B?bktZcTNlNDg5QTNURzJCSEp1Wks1em80bnV4MGNPYnRPQTV4dVh3OExUQWJW?=
 =?utf-8?B?V0lmOXpsdkZhUVpqU3A2QlhieHRYeGhRREpVUmQ2SG45L3pHTU1OUnV4NFJS?=
 =?utf-8?B?Q0Rmb0FqRDdqbzBJdDFsNUpoR1RoZnlVNmNWZXd6dU9rTzRyaS8vSmRrVzFE?=
 =?utf-8?B?Qm1mb2IrbUU5RFUyejFtdysrdlAwQlh4YnQ5dmlMWlN5dUtHVmhDQTZmY3BN?=
 =?utf-8?B?NWczUC93cUY3NkxETm9GU0FpZzFZd1Ewd2d4OC9qN3kwdGZZbVVDVHd4U3d6?=
 =?utf-8?B?N2xWTThHcTJqOFVnTUY4QVdDOGtIb2V0UmJDUzkwYkMwZWhsWmQ5ZXVRZ0pV?=
 =?utf-8?B?YjNkalRIR09RZmhkSE1xMHVOUHFNRXhOQXlkdEFaVGhLNHQvOG9yc0c3dU12?=
 =?utf-8?B?UWpuaEt3YjVFMVNwbU8yYURtL2wyb3lkWU5aQ2hDQXBUQkRZRGF4L29aV1Yw?=
 =?utf-8?B?eGlqL043QlVCQWRKbWg5NmM5Rm9PTEh6cEZwWWc2YkZBZUVPc1pyWmlGN1dX?=
 =?utf-8?B?ckpzYitBemg4Y3hPZnQzWVZiRGhrSDhVZnhyRVBMK2M4cllzOUEwS0c0MWt4?=
 =?utf-8?B?QThIV2JMR3pUT0dzcmc1TFgrKzJOSENORkplMzl4WEJ5d1FkUGFSMmlCSUcy?=
 =?utf-8?B?MFI0dnppcHZRMXNEUGIrR2ZsL05xd1l0MDd1c0VEelplRTlUUWNNenU5eXc5?=
 =?utf-8?B?TlQwbStTK291RGphVGVUenlSQVdIbDFhbFdqTWRjTlJIa2Z6QnBNTFdUYUZx?=
 =?utf-8?B?QmIvUUpDaDJLZ1VVbzY5RTJxTnU1Y0daeGlRN3NVNE4xMzFJRUNtTHZGTWpj?=
 =?utf-8?Q?RYcolk725nRHD+gD60sUsd6Ed?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 247d716b-14cd-408e-f8d1-08ddef70923c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 07:14:52.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWS1CbdnIElxgnnUiBsjwTVz6UNNVadDAcLrtFu4Q+86NS7MjAzGyXHW7Gf5Mj+LYPnXsPDxjjDD8R00VdQkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494

SGkgRnJhbms6DQpJJ20gdmVyeSBhcHByZWNpYXRlZCB0aGF0IHlvdSBraW5kbHkgaGVscCB0byBh
ZGQgdGhlIGV4cGxhbmF0aW9ucy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5saUBueHAu
Y29tPg0KPiBTZW50OiAyMDI15bm0OeaciDnml6UgMDozMw0KPiBUbzogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBrZXJuZWwu
b3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFz
QGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzJdIFBDSTogaW14NjogQWRkIGEgbWV0aG9kIHRvIGhh
bmRsZSBDTEtSRVEjDQo+IG92ZXJyaWRlIGFjdGl2ZSBsb3cNCj4gDQo+IE9uIE1vbiwgU2VwIDA4
LCAyMDI1IGF0IDA5OjE5OjQwUE0gKzA1MzAsIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4gPiBPbiBNb24sIFNlcCAwOCwgMjAyNSBhdCAxMToyNjoxMUFNIEdNVCwgRnJhbmsgTGkgd3Jv
dGU6DQo+ID4gPiBPbiBNb24sIFNlcCAwOCwgMjAyNSBhdCAxMTozNjowMkFNICswNTMwLCBNYW5p
dmFubmFuIFNhZGhhc2l2YW0NCj4gd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgQXVnIDIwLCAyMDI1
IGF0IDA0OjEwOjQ4UE0gR01ULCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gPiBUaGUgQ0xL
UkVRIyBpcyBhbiBvcGVuIGRyYWluLCBhY3RpdmUgbG93IHNpZ25hbCB0aGF0IGlzIGRyaXZlbg0K
PiA+ID4gPiA+IGxvdyBieSB0aGUgY2FyZCB0byByZXF1ZXN0IHJlZmVyZW5jZSBjbG9jay4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFNpbmNlIHRoZSByZWZlcmVuY2UgY2xvY2sgbWF5IGJlIHJlcXVp
cmVkIGJ5IGkuTVggUENJZSBob3N0IHRvby4NCj4gPiA+ID4NCj4gPiA+ID4gQWRkIHNvbWUgaW5m
byBvbiB3aHkgdGhlIHJlZmNsayBpcyBuZWVkZWQgYnkgdGhlIGhvc3QuDQo+ID4gPiA+DQo+ID4g
PiA+ID4gVG8gbWFrZQ0KPiA+ID4gPiA+IHN1cmUgdGhpcyBjbG9jayBpcyBhdmFpbGFibGUgZXZl
biB3aGVuIHRoZSBDTEtSRVEjIGlzbid0IGRyaXZlbg0KPiA+ID4gPiA+IGxvdyBieSB0aGUgY2Fy
ZChlLnggbm8gY2FyZCBjb25uZWN0ZWQpLCBmb3JjZSBDTEtSRVEjIG92ZXJyaWRlDQo+ID4gPiA+
ID4gYWN0aXZlIGxvdyBmb3IgaS5NWCBQQ0llIGhvc3QgZHVyaW5nIGluaXRpYWxpemF0aW9uLg0K
PiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IENMS1JFUSMgb3ZlcnJpZGUgaXMgbm90IGEgc3Bl
YyBkZWZpbmVkIGZlYXR1cmUuIFNvIHlvdSBuZWVkIHRvDQo+ID4gPiA+IGV4cGxhaW4gd2hhdCBp
dCBkb2VzIGZpcnN0Lg0KPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBDTEtSRVEjIG92ZXJyaWRlIGNh
biBiZSBjbGVhcmVkIHNhZmVseSB3aGVuIHN1cHBvcnRzLWNsa3JlcQ0KPiA+ID4gPiA+IGlzIHBy
ZXNlbnQgYW5kIFBDSWUgbGluayBpcyB1cCBsYXRlci4gQmVjYXVzZSB0aGUgQ0xLUkVRIyB3b3Vs
ZA0KPiA+ID4gPiA+IGJlIGRyaXZlbiBsb3cgYnkgdGhlIGNhcmQgaW4gdGhpcyBjYXNlLg0KPiA+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFdoeSBkbyB5b3UgbmVlZCB0byBkZXBlbmQgb24gJ3N1
cHBvcnRzLWNsa3JlcScgcHJvcGVydHk/IERvbid0IHlvdQ0KPiA+ID4gPiBhbHJlYWR5IGtub3cg
aWYgeW91ciBwbGF0Zm9ybSBzdXBwb3J0cyBDTEtSRVEjIG9yIG5vdD8gTm9uZSBvZiB0aGUNCj4g
PiA+ID4gdXBzdHJlYW0gRFRTIGhhcyB0aGUgJ3N1cHBvcnRzLWNsa3JlcScgcHJvcGVydHkgc2V0
IGFuZCB0aGUgTlhQDQo+ID4gPiA+IGJpbmRpbmcgYWxzbyBkb2Vzbid0IGVuYWJsZSB0aGlzIHBy
b3BlcnR5Lg0KPiA+ID4NCj4gPiA+IEl0IGlzIGhpc3RvcnkgcmVhc29uLiBTdXBwb3NlZCBhbGwg
dGhlIGJvYXJkcyB3aGljaCBzdXBwb3J0cyBMMVNTDQo+ID4gPiBuZWVkIHNldCAnc3VwcG9ydHMt
Y2xrcmVxJyBpbiBkdHMuIEwxU1MgcmVxdWlyZSBib2FyZCBkZXNpZ24gdXNlDQo+ID4gPiBvcGVu
IGRyYWluIGNvbm5lY3QgUkMncyBjbGstcmVxIGFuZCBFUCdzIGNsay1yZXEgdG9nZXRoZXIsIHdo
aWNoDQo+ID4gPiBjb21lIGZyb20gb25lIEVDTiBvZiBQQ0kgc3BlYy4NCj4gPiA+DQo+ID4gPiBC
dXQgbW9zdCBNLjIgc2xvdCBub3csIHdoaWNoIHN1cHBvcnQgTDFTUywgc28gbW9zdCBwbGF0Zm9y
bSBkZWZhdWx0DQo+ID4gPiBlbmFibGUgTDFTUyBvciBkZWZhdWx0ICdzdXBwb3J0cy1jbGtyZXEn
IG9uLg0KPiA+ID4NCj4gPiA+IElkZWFsbHksICdzdXBwb3J0cy1jbGtyZXEnIHNob3VsZCB1c2Ug
cmV2ZXJ0IGxvZ2ljIGxpa2UgJ2Nsay1yZXEtYnJva2VuJy4NCj4gPiA+IGJ1dCAnc3VwcG9ydHMt
Y2xrcmVxJyBhbHJlYWR5IGNvbWUgaW50byBzdGFyZGFyZCBQQ0llIGJpbmRpbmcgbm93Lg0KPiA+
ID4NCj4gPiA+IE9uZSBvZiBpLk1YOTUgYm9hcmRzIHVzZSBzdGFuZGFyZCBQQ0llIHNsb3QsIFBJ
TiAxMg0KPiA+ID4gMTIJQ0xLUkVRIwlHcm91bmQJQ2xvY2sgUmVxdWVzdCBTaWduYWxbMjZdDQo+
ID4gPiB3aGljaCBpcyByZXNlcnZlZCBhdCBvbGQgUENJZSBzdGFuZGFyZCwgc28gc29tZSBvbGQg
UENJZSBjYXJkIGZsb2F0DQo+ID4gPiB0aGlzIHBpbi4NCj4gPiA+DQo+ID4NCj4gPiBPay4gSUlV
QywgaS5NWCBwbGF0Zm9ybXMgZG9lc24ndCBhbHdheXMgc3VwcG9ydCBDTEtSRVEjLCBhcyB0aGUg
cGluDQo+ID4gbWlnaHQgbm90IGJlIHdpcmVkIG9uIHNvbWUgY29ubmVjdG9ycy4gU28gaWYgdGhl
IGRyaXZlciB0dXJucyBvZmYgdGhlDQo+ID4gb3ZlcnJpZGUsIENMS1JFUSMgd2lsbCBiZSBkcml2
ZW4gaGlnaCwgYnV0IHRoZSBlbmRwb2ludCB3b3VsZG4ndCBnZXQgYQ0KPiA+IGNoYW5jZSB0byBk
cml2ZSBpdCBsb3cgYW5kIGl0DQo+IA0KPiBDTEtSRVEjIHdpbGwgYmUgZmxvYXQgYW5kIHB1bGwg
dXAgYnkgcHVsbCB1cCByZXNpc3Rvci4gVGhlIG9sZCBlbmRwb2ludCAoUENJZQ0KPiBzdGFuZGFy
ZCBzbG90KSBmbG9hdCB0aGlzIHBpbiBhbHNvIGJlY2F1c2UgaXQgaXMgcmV2ZXJzZWQgYXQgb2xk
IFBDSWUgc3RhbmRhcmQuDQo+IFNvIHJlZiBjbG9jayBpcyBvZmYgYXQgdGhhdCBjYXNlLg0KPiAN
Cj4gPiB3b24ndCByZWNlaXZlIHRoZSByZWZjbGsuDQo+ID4NCj4gPiBJcyBteSB1bmRlcnN0YW5k
aW5nIGNvcnJlY3Q/DQo+IA0KPiBCYXNpYyBpcyBjb3JyZWN0IHdpdGggc29tZSBzbWFsbCBwcm9i
bGVtLg0KPiANCj4gSXQgaXMgY2F1c2VkIGJ5IHR3byBjb21tb24gUENJZSBwcm9ibGVtLg0KPiAt
IHN0YWRhcm5kIFBDSWUgc2xvdCBkZWZpbmUgY2hhbmdlIFBJTjEyIGZyb20gcmVzZXJ2ZWQgdG8g
Q0xLUkVRIywgd2hpY2ggaXMNCj4gRUNOLCBiZWZvcmUgRUNOLCBhbGwgRVAgZGV2aWNlIGZsb2F0
IHRoaXMgcGluLiBhZnRlciBFQ04sIEVQIGRldmljZSBwdWxsIHRoaXMNCj4gcGluIGRvd24uDQo+
IC0gdXNlIGxvZ2ljIFsyXSB0byBkZXNpZ24gYm9hcmRzLCB3aGljaCBqdXN0IGltcGFjdCBMMVNT
LCB0aGUgYmFzaWMgZnVuY3Rpb24NCj4gc2hvdWxkIHdvcmsuDQo+IA0KPiBGcmFuaw0KPiA+DQo+
ID4gSSdtIHdvbmRlcmluZyBpbiB0aG9zZSBjYXNlcywgd2h5IGNhbid0IHlvdSBrZWVwIHRoZSBD
TEtSRVEjIHBpbiB0byBiZQ0KPiA+IGluIGFjdGl2ZSBsb3cgc3RhdGUgYnkgZGVmaW5pbmcgdGhl
IGluaXRpYWwgcGluY3RybCBzdGF0ZSBpbiBEVD8gQ2FuJ3QNCj4gPiB5b3UgY2hhbmdlIHRoZSBw
aW5jdHJsIHN0YXRlIG9mIENMS1JFUSM/DQo+ID4NCj4gPiA+IFNvIEkgdGhpbmsgbW9zdCBkdHMg
aW4ga2VybmVsIHRyZWUgc2hvdWxkIGFkZCAnc3VwcG9ydHMtY2xrcmVxJw0KPiA+ID4gcHJvcGVy
dHkgaWYgdGhleSB1c2UgTS4yIGFuZCBjb25uZWN0IENMS19SRVEjIGFzIGJlbG93IFsxXQ0KPiA+
ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+ICAg
ICAgICAgICAgICAgVkNDDQo+ID4gPiAgICAgICAgICAgICAgIC0tLQ0KPiA+ID4gICAgICAgICAg
ICAgICAgfA0KPiA+ID4gICAgICAgICAgICAgICAgUiAoMTBLKQ0KPiA+ID4gICAgICAgICAgICAg
ICAgfA0KPiA+ID4gQ0xLX1JFUSMgKFJDKS0tLS0tLSBDTEtfUkVRIyhFUCkNCj4gPiA+DQo+ID4g
PiBOT1QgYWRkIHN1cHBvcnRzLWNsa3JlcSBpZiBjb25uZWN0IGFzIGJlbG93IFsyXQ0KPiA+ID4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPg0KPiA+ID4g
Q0xLX1JFUSMgKFJDKSAgLS0tPiB8LS0tLS0tLS0tfA0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICB8IE9SIEdBVEUgfCAtLS0+IGNvbnRyb2wgcmVmIGNsb2NrDQo+ID4gPiBDTEtfUkVRIyhFUCkg
ICAtLS0+IHwtLS0tLS0tLSB8DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU28gSSdt
IHdvbmRlcmluZyBob3cgeW91IGFyZSBzdWRkZW5seSB1c2luZyB0aGlzIHByb3BlcnR5LiBUaGUN
Cj4gPiA+ID4gcHJvcGVydHkgaW1wbGllcyB0aGF0IHdoZW4gbm90IHNldCB0byB0cnVlLCBDTEtS
RVEjIGlzIG5vdA0KPiA+ID4gPiBzdXBwb3J0ZWQgYnkgdGhlIHBsYXRmb3JtLiBTbyB3aGVuIHRo
ZSBkcml2ZXIgc3RhcnRzIHVzaW5nIHRoaXMNCj4gPiA+ID4gcHJvcGVydHksIGFsbCB0aGUgb2xk
IERUUyBiYXNlZCBwbGF0Zm9ybXMgYXJlIG5vdCBnb2luZyB0byByZWxlYXNlDQo+ID4gPiA+IENM
S1JFUSMgZnJvbSBkcml2aW5nIGxvdywgc28gTDFTUyB3aWxsIG5vdCBiZSBlbnRlcmVkIGZvciB0
aGVtLiBEbyB5b3UNCj4gcmVhbGx5IHdhbnQgaXQgdG8gaGFwcGVuPw0KPiA+ID4NCj4gPiA+IEFj
dHVhbGx5LCBzb21lIG9sZCBib2FyZCB1c2UgWzJdLiB3ZSB3aWxsIGFkZCBzdXBwb3J0cy1jbGty
ZXEgaWYNCj4gPiA+IGJvYXJkIGRlc2lnbiB1c2UgWzFdLCBzbyBjb3JyZWN0IHJlZmxlY3QgYm9h
cmQgZGVzaWduLg0KPiA+ID4NCj4gPg0KPiA+IE9rLCB0aGFua3MgZm9yIGNsYXJpZnlpbmcuDQo+
ID4NCj4gPiAtIE1hbmkNCj4gPg0KPiA+IC0tDQo+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

