Return-Path: <linux-pci+bounces-17064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30CA9D21D3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 09:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3391B228B6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADDF198A35;
	Tue, 19 Nov 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UbP8+rg7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA013C8F3;
	Tue, 19 Nov 2024 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006145; cv=fail; b=BdP9LpStNrEfvFhdw8N3xCdTRNSK3dMhNUVLUEQk3xQO0G+0XO7RDmjfyAnUV/DnKHTntgOEFBB3j1lahjojl82DicGB4MiIYVlD108mWWUpo7H0eDRGWUQ3c4ogi+5mHRhNf75mpfP/qxmHhxoGmRt2l1nio6g3fM82OcEGXhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006145; c=relaxed/simple;
	bh=7H528C0490WX+Pyg4ZanGKdQ2l6jlGuYkkSwpzMdnD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L8yWVOXYE4ztUVVd6axuyaB3cxv/WIVwXcSHID9MZIxekkDbM8+0SV2dTK9NlvvbWgyfULCtmzay4ExSmunuDFRQqUTac6OGiPS3Rmr/xDmuj8hGHnWovAGJygPa5HQVda02SXgQwQnQlRnZY65mlxtesdZQ0vhssFb8oMUGDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UbP8+rg7; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3jpavrLesBlagSSBCRHhGjGexue5bjXE82enSJ57kEhGYGFVkEgupRd9myTY/XQ43H5RqlXoCLGY1FuI9W15a5PB14D7H+DggnRhQYkzDUJ8cNTuwBy2pFm1zJrlvdbdajyj2FiV8d8PNw7sKVT2Ov7FqN0HkjsVZ+geawsIlvxazTl7M6ArDLpLhyQVJt8RBYEsBOd6I/63ldCzcwQRDRrQlcMar6LCIOK3PAw8eC3qB1s93Fmo+VFp+XGKhZnAxVQGDE9vmKnjG8+h4j+h7F/T6drA8EDUrgeULYTXxvOIA4z1MP3G6wXw6BwgqAwYdGnGCP3DSy7v5+d22lINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H528C0490WX+Pyg4ZanGKdQ2l6jlGuYkkSwpzMdnD4=;
 b=l2nHGyUbZvR6/lvoGlAkotTB8tkG9EK0fczrhcIiI5A5k4APLnlrtSF6JSfej+bHKadmxTHJs4THySDI4Uquf6js9EpQX+0qEiVof5/UBu1I8O2pjHVmaF5EfQU8hADSe8CZgZsszH/NFSy39HO5/X5BxfvGbQOI1KBpYQb9e9e3vDdxEZUovmp42sx6mdp8MuBudQ702T02OW99WWCy8cLphPDJb5kQTGKvb0T5msqdIc/8xb8IUnZgfvjk5oLfZpHH/PDBA39tndgmoFWPUjmqSJ+BT94QLY4OD89OHZM9q56yLq1zX0NHFrfQfHs1fFz6CTxLYkvzXnZNriPWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H528C0490WX+Pyg4ZanGKdQ2l6jlGuYkkSwpzMdnD4=;
 b=UbP8+rg7mrlLT+ONtGuqF3otd8hlcsZXqk4fQeSnIh2vQxdqgl32Bcc46S+7N14CYi/uU5oe/DkYB0K+JOHawx2Y+pgJgmgkZEtAZ/Qr6ho3Xi1FBYaHVMy5oscAnUraJuXuDBB5Swqn9CUdgUwZfW0hVvOXZBynNcKMCOaiMCP5stZQ6mjglpkvJvisk5D19IyqzVFKVCQnPZ5LQuVzoAnmqgqnqQAWP+Kg8ra19fMv9BuJ5ZsfdoX6N11+rN0F8QWvNJZ5PFJfYM1ugRgXvQXPC6Rx06X8NscHe/noJgq23IjFdZsfCXx3TC2E2oNliTWd6d7IEGiH8j7wl3sVqQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10739.eurprd04.prod.outlook.com (2603:10a6:800:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:48:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:48:57 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	Frank Li <frank.li@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index: AQHbOX1jfD65FUimD0C9XmRBulHERrK8myeAgAGtZ0A=
Date: Tue, 19 Nov 2024 08:48:57 +0000
Message-ID:
 <AS8PR04MB867619836B0F30C2663AB9418C202@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
 <118e87ef-3852-8c07-7de7-d97e885cfdd6@quicinc.com>
In-Reply-To: <118e87ef-3852-8c07-7de7-d97e885cfdd6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI2PR04MB10739:EE_
x-ms-office365-filtering-correlation-id: d39ec02d-807e-4130-915d-08dd08770174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UG96ait4eHRTZ0lrTlgrUGh1Vk5PUERPVWxlN1RnN1B5aFM3b0o1SjdITlEv?=
 =?utf-8?B?S2pWTmpjV2wwV0R0ZmthUGlDSURKNUl4TEFrVFRSQ0tzaWw3YnRHRk92RHl6?=
 =?utf-8?B?VHhna1BHb2k4UDlZdm1Sc2p4TDhKekFlWHgyTzZ2eE1Ca0Q1b2FudzFpemFn?=
 =?utf-8?B?SzZPeERQVmJSak9ua2luOFAvMUVCUVJxN3p3STdJSmt4T1FBV090TDVOcUtz?=
 =?utf-8?B?anh3RVJ6MUk0cTJzK3pwWkl4ekpsRi85Mmo0bGhwOENRYURLR3I1N1M4S1hY?=
 =?utf-8?B?Lzcwb3lXWnJMb1JIelBJeWZnWTlPSFBHMk5rVWtRSkJOTUhoQnN2clNDMnVh?=
 =?utf-8?B?bWdEOXBwUTJXcXJiQ0VlSWNSZGpIclBNNTg2eXRaZi93anZIWXhDbGdlZER2?=
 =?utf-8?B?RmtHRlZzRFhzTDZxQ1JWNGpPMEEvZEhUYVVLMkRBOUgvYUl2VW5EYnZseDZD?=
 =?utf-8?B?WE9CbVlQQUxJKzdJc25SaHVhTG11Q1AyWWtKZlMyVjlNaFd3dWRPVlJsaW8x?=
 =?utf-8?B?SG9UWHAvZlJuZS9HeE9WRkFweWsxUjBudS9ReDZqV1JiZkdRbHZoUVFKbUdF?=
 =?utf-8?B?NDRyYW1uV3hyN29BaU93ZExCa0VaMldGRXF2OFhacldRZ3RPUWpXRno3cTls?=
 =?utf-8?B?a2R1VkNWRzhHT0ZpNXM2MDdIdVNQai9Hb1VKVVBjTHJ3YjQ1WkZLZW81cFhO?=
 =?utf-8?B?d2VGTzBuOFRGNEpma0ZvZTBZNDRxYXUvMzBubi9Pd1BVdVV3Q0FvZGl4MHZC?=
 =?utf-8?B?L2psZkZBcUc5ZmxMVHRhNEZJMjE4ZTVlejdJejRXZmlwS2hTV2k1MWF6OUNp?=
 =?utf-8?B?Mzd0MVgzTXNxWTZjVWZVT0s1RWxnSGl3cHdGSHdZL1FOMksxRy9HU21GNm9n?=
 =?utf-8?B?a0htOVgzWWNRb1AzMStmV293ZUxtQklwMEJ5dDhUWExrUGhGOCs4OWc5ZldW?=
 =?utf-8?B?T0pkeUZ4Q1FaZklJVFFiRzVQVk9NaDZCK21zSWVJdE5JcENtWWcwU2Y1d2t4?=
 =?utf-8?B?cG9QRUNRZjZiNzc3Y1U2ZnFrcUxta1ROYTZma0FKanJkd2xUYTltbmVSNmlp?=
 =?utf-8?B?MC94Rnk4R0hYMURkbjNlREJ6UmlnVVhlUmh2azV4Ti9pc0o4ZWNDRmNhc1BV?=
 =?utf-8?B?WHp3ZVd6d3REQ0pVdFRyOUN3YXdMaVFpYXMyTDZCaHUvbzFzN1g5RjJZRGM1?=
 =?utf-8?B?dzRITnhkTUVaL3EzZ282YjRHOWV2aEt2cnNkdkY0MFdBM0F2dXBaR1V4MXdI?=
 =?utf-8?B?K2oxZnVKWDdLd0QxeWFYYVJzV0gvQUtwb3ZxbEozbTJNTmxMUkZDODhCR0Zn?=
 =?utf-8?B?bDJUUk16NjVMN281UHordTdhQktodzhjd0N2aDlYNC9MVklwYTUyRER5Vzk4?=
 =?utf-8?B?akVZcFBEUEZNSzVVcFZlcXZ2b1RPOGw2d1prL09pdHF3M21FcmxTUWZYMFM2?=
 =?utf-8?B?amRXRWc0ekdZeVdEdWZ4c3JuSlAvOG5aT0JRSlN6b1FTN09QRFFFMVlHQXF2?=
 =?utf-8?B?WFpCY0JXZEFKM1FabjgvNjdKOVFZaEtpSWFiZHgwb3FBUVVsRlRHaWtHV290?=
 =?utf-8?B?R3k3ZnhxUWJZa3pqa1kyZ1FTa1Z2dlRTUzNWeHVIMGhNMFhUamZwQVRSWkZz?=
 =?utf-8?B?RFRWa1A5MkY2TXZxWGxFM1BsRkZKdkdGMXdha2d0STkyQkVHemE3U3cyTzRm?=
 =?utf-8?B?bEpucEdsSklJVjhFNjl6RjdjQ0YydXdqRDFCMFVNWUltTDVIbTdvRGVpM1kr?=
 =?utf-8?B?VWZtSnFEa2RjeWRjZU01WGVuZS9GZHRZWTBUU3ZBOWlJSTJMcnB6a0RrZVRl?=
 =?utf-8?Q?J1dBeJPMT1nwzSwYrlzziC6zYHSR/S3HXkQ+E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGdpWURLNnRKU04xM1dTUHZuT3ZmR0VwREJYNEpnUG9tcE5WYjhWVkxaYThm?=
 =?utf-8?B?dzlkNGN5ekVFcWxyK2dHbjNyOXZzb091NERCSFFBSmEwTUZLdzBPclgya3U0?=
 =?utf-8?B?QmRMclBrL1g3aS8yemxXbzZya3UzeENoOUlianlDUXRTZHZBUEpDWHZkcDVJ?=
 =?utf-8?B?bk1VRGJhMmxER1hkVE4yVVYwVFhtbXQ0ZFRkZDk1TFpuL1FHZ3NkbTFmeCsr?=
 =?utf-8?B?eUF4YVR6dzU1b1VhWFNaZWFHdFFqUmhKZHVlODFrY2hBTWNrMGdmbEVzbUNN?=
 =?utf-8?B?NmxUSWx0TFNQTmgzMlZjYlZFdjNYTEtMYkZNcS9vYUtzQzgySUdTMU5uVHg5?=
 =?utf-8?B?eFZCam11d3gwTWZrbk5wbkhVS24wMzhFVTRFYlNGUzZ1dytFV3dBbFg3QlRM?=
 =?utf-8?B?dGJtcEJrSDVjVmUxdnpQZ0xQTUdZLzNDdVREOFAvNVgyRFBLUDNRSmtuQnlK?=
 =?utf-8?B?RlNDUGJra0YwSi9lOW5oczRYL1JocHozZ0VsZmNMRy90Yk1UMUdwOGZRVW9x?=
 =?utf-8?B?SHZ2d1E0dE1sY2tJVy9xL0JSMHV1Q051SlVMRFErUE16VlYrVi84RHU1MVcx?=
 =?utf-8?B?M3k5MzhtSm1tSmk4NE5XdlkwWDVMaUg3ZnBxSm16Q0RQZmJ1TjBHZ01DbDhk?=
 =?utf-8?B?empMWmkyU2g4NW9oR0hzQkxDYVJMRyswRCt2MklVVGxTM0xDWFJ1MjFnWXcr?=
 =?utf-8?B?cUIzampGa1kvUzRjb1NxckJ3Y21aSG1DZEhoT0RnSnNNcHVFNWxNTDFOUDYx?=
 =?utf-8?B?NjIweDZDZDA5ck9BMFR2S0ROZFc2YWRUZzZwSkJqcnhzSTFZZWlWb0NCL2Jz?=
 =?utf-8?B?WWpJaXlRUjBMd0tsbEZHbGF4TkJjY3FxZVdzdmw4RXNxcGFTb20zUU9wTGNs?=
 =?utf-8?B?Ti9DbVMzSStCQnBUZkFySWUxMENQRFVBcWNBcytHVVljS0x4bnFYZEg4YWts?=
 =?utf-8?B?QU9nSjJpZk9XOVZXak8rRFRJU3dQZ2VLSnAvSWZvKzY3KzBVUkI2ZjkwS00r?=
 =?utf-8?B?UVNUZXpiZXZGaTdOcDIyWVhTNGYvYUh2QnBnT0VsQVc5SzFwcGMzRmVVeFlH?=
 =?utf-8?B?MTIrMVZtNXJhSW9Sa09ZaHdIK1YrcHBiR2ttd0NyM3ZEeHJXb0dJNkRMY0dL?=
 =?utf-8?B?V0RBNDBwUmFhMGhDMzIvK3dHbjg1VUhJaUd6TlZaS2U1OC80M1VIZTBOb1Ri?=
 =?utf-8?B?TExRQXNQamNydkJZbmFEd01EYWJJa05XUUg3cUNsOGdsTmFha1RYUHBYM2JI?=
 =?utf-8?B?c2VlelR5US9HMXJVOUczYjc3b3NQN1Q1TWtXVk9ZeUEzSUNkUDdsV09ObWZQ?=
 =?utf-8?B?QW9QNzVldHFBNnkvMnBFcjhtWFFaenV6d2ZvRkF5enltM0hiU0FnbWNHeklF?=
 =?utf-8?B?YUo2ZnB5aTBPbytKZGtsV1BWSmZMR29zQVBiSHltdEVoN2VHektlMGluQm9X?=
 =?utf-8?B?cmF0V2U3TER3SHplYU5sdTVLZ3BlQkc0d1E1OUlqMmovRUR3Y3k0QWd2dDlH?=
 =?utf-8?B?eUJvSXZaamc0Y0Z2cUdZNnNZdGFiQzlYbGNDQTVKOHhWT3pnWFRkeW5LZnRS?=
 =?utf-8?B?NXRkN3BUZkhZbDN5NmozUUh2K2dDc3A4K0VyYnl1Z1VPdjc1dnNQaGgySFpB?=
 =?utf-8?B?d2ZzWXZyeE1xWWl2U2xsekdNNUNLWGFXN29pRzJuQ2I3K3RDRnpEMlA2M2dN?=
 =?utf-8?B?OTV2WER5UU1UbTUrd1o1anNveUgxVGNlRFJXZi9wT2tZTGtzL2RzZmZvUGxV?=
 =?utf-8?B?dW9RRkg4OGU2bFpwNmVPalY1UlZlY01LY2lRQ3Bja214RWN6cWVQeFJMUVRn?=
 =?utf-8?B?ZzNaaDZhVHMxY1ZhZjJEeFQ5aThWYnBXSy9sdkZMNnJyRlVETjRTSHdSZFZX?=
 =?utf-8?B?eThRcm9namlaTUFFdm9nY2cva2hOaEZWNUVmaUlNMVF5bVJKdHY1SjBWdG83?=
 =?utf-8?B?ckZVNjRKS2JJOFR4amxDVlZ2b2djUitYUVl0aERTeUp0WkxMNnFRNHREekdF?=
 =?utf-8?B?QzhGNkVhcnlXZGdCd3ZEbk54UU02a05ORHdObk5kemN3VHBlMzhjczZRamhH?=
 =?utf-8?B?WXU1V3dzWWJYdkpNWEdPdHVMOWQ4M2ppWGc2OGEzclJUL2x3NG5JVG1IVUhr?=
 =?utf-8?Q?Wnl0siXaGUv6FgI7pCJml2zY5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ec02d-807e-4130-915d-08dd08770174
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 08:48:57.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XuXLDMFrM0PMcOczjT8yqVpLV1lQk3da7xx+TiWgwnEG4TZXee8jZ8gSDFR5DDT6yQGjkY7tpW3dlQ0ceUrTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10739

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcmlzaG5hIENoYWl0YW55YSBD
aHVuZHJ1IDxxdWljX2tyaWNoYWlAcXVpY2luYy5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMeaciDE4
5pelIDE0OjU3DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgamlu
Z29vaGFuMUBnbWFpbC5jb207DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsga3dAbGludXguY29tOw0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9y
Zzsgcm9iaEBrZXJuZWwub3JnOyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gQ2M6
IGlteEBsaXN0cy5saW51eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzXSBQQ0k6IGR3YzogQ2xlYW4gdXAgc29tZSB1bm5lY2Vzc2FyeSBjb2Rl
cyBpbg0KPiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKQ0KPiANCj4gDQo+IA0KPiBPbiAxMS8xOC8y
MDI0IDExOjE0IEFNLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBCZWZvcmUgc2VuZGluZyBQTUVf
VFVSTl9PRkYsIGRvbid0IHRlc3QgdGhlIExUU1NNIHN0YXRlLiBTaW5jZSBpdCdzDQo+ID4gc2Fm
ZSB0byBzZW5kIFBNRV9UVVJOX09GRiBtZXNzYWdlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUg
bGluayBpcyB1cA0KPiA+IG9yIGRvd24uIFNvLCB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIHRvIHRl
c3QgdGhlIExUU1NNIHN0YXRlIGJlZm9yZQ0KPiA+IHNlbmRpbmcgUE1FX1RVUk5fT0ZGIG1lc3Nh
Z2UuDQo+ID4NCj4gPiBPbmx5IHByaW50IHRoZSBtZXNzYWdlIHdoZW4gbHRzc21fc3RhdCBpcyBu
b3QgaW4gREVURUNUIGFuZCBQT0xMLg0KPiA+IEluIHRoZSBvdGhlciB3b3JkcywgdGhlcmUgaXNu
J3QgYW4gZXJyb3IgbWVzc2FnZSB3aGVuIG5vIGVuZHBvaW50IGlzDQo+ID4gY29ubmVjdGVkIGF0
IGFsbC4NCj4gPg0KPiA+IEFsc28sIHdoZW4gdGhlIGVuZHBvaW50IGlzIGNvbm5lY3RlZCBhbmQg
UE1FX1RVUk5fT0ZGIGlzIHNlbnQsIGRvIG5vdA0KPiA+IHJldHVybiBlcnJvciBpZiB0aGUgbGlu
ayBkb2Vzbid0IGVudGVyIEwyLiBKdXN0IHByaW50IGEgd2FybmluZyBhbmQNCj4gPiBjb250aW51
ZSB3aXRoIHRoZSBzdXNwZW5kIGFzIHRoZSBsaW5rIHdpbGwgYmUgcmVjb3ZlcmVkIGluDQo+IGR3
X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjMgY2hhbmdlczoNCj4gPiAt
IFJlZmluZSB0aGUgY29tbWl0IG1lc3NhZ2UgcmVmZXIgdG8gTWFuaXZhbm5hbidzIGNvbW1lbnRz
Lg0KPiA+IC0gUmVnYXJkaW5nIEZyYW5rJ3MgY29tbWVudHMsIGF2b2lkIDEwbXMgd2FpdCB3aGVu
IG5vIGxpbmsgdXAuDQo+ID4gdjIgY2hhbmdlczoNCj4gPiAtIERvbid0IHJlbW92ZSBMMiBwb2xs
IGNoZWNrLg0KPiA+IC0gQWRkIG9uZSAxdXMgZGVsYXkgYWZ0ZXIgTDIgZW50cnkuDQo+ID4gLSBO
byBlcnJvciByZXR1cm4gd2hlbiBMMiBlbnRyeSBpcyB0aW1lb3V0DQo+ID4gLSBEb24ndCBwcmlu
dCBtZXNzYWdlIHdoZW4gbm8gbGluayB1cC4NCj4gPiAtLS0NCj4gPiAgIC4uLi9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDQwICsrKysrKysrKystLS0tLS0tLS0N
Cj4gPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8ICAx
ICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IDI0ZTg5YjY2Yjc3Mi4uNjhmYmMxNjE5OWU4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTkyNywyNCArOTI3LDI4IEBAIGludCBkd19wY2llX3N1
c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgIAlpZiAoZHdfcGNpZV9yZWFk
d19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NUTCkgJg0KPiBQQ0lfRVhQX0xOS0NUTF9B
U1BNX0wxKQ0KPiA+ICAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+IC0JLyogT25seSBzZW5kIG91dCBQ
TUVfVFVSTl9PRkYgd2hlbiBQQ0lFIGxpbmsgaXMgdXAgKi8NCj4gPiAtCWlmIChkd19wY2llX2dl
dF9sdHNzbShwY2kpID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfQUNUKSB7DQo+ID4gLQkJaWYgKHBj
aS0+cHAub3BzLT5wbWVfdHVybl9vZmYpDQo+ID4gLQkJCXBjaS0+cHAub3BzLT5wbWVfdHVybl9v
ZmYoJnBjaS0+cHApOw0KPiA+IC0JCWVsc2UNCj4gPiAtCQkJcmV0ID0gZHdfcGNpZV9wbWVfdHVy
bl9vZmYocGNpKTsNCj4gPiAtDQo+ID4gLQkJaWYgKHJldCkNCj4gPiAtCQkJcmV0dXJuIHJldDsN
Cj4gPiArCWlmIChwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKQ0KPiA+ICsJCXBjaS0+cHAub3Bz
LT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldCA9IGR3X3Bj
aWVfcG1lX3R1cm5fb2ZmKHBjaSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7
DQo+ID4NCj4gPiAtCQlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwg
dmFsLCB2YWwgPT0NCj4gRFdfUENJRV9MVFNTTV9MMl9JRExFLA0KPiA+IC0JCQkJCVBDSUVfUE1F
X1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gLQkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9V
UywgZmFsc2UsIHBjaSk7DQo+ID4gLQkJaWYgKHJldCkgew0KPiA+IC0JCQlkZXZfZXJyKHBjaS0+
ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006DQo+IDB4JXhcbiIsIHZh
bCk7DQo+ID4gLQkJCXJldHVybiByZXQ7DQo+ID4gLQkJfQ0KPiA+IC0JfQ0KPiA+ICsJcmV0ID0g
cmVhZF9wb2xsX3RpbWVvdXQoZHdfcGNpZV9nZXRfbHRzc20sIHZhbCwNCj4gPiArCQkJCXZhbCA9
PSBEV19QQ0lFX0xUU1NNX0wyX0lETEUgfHwNCj4gPiArCQkJCXZhbCA8PSBEV19QQ0lFX0xUU1NN
X0RFVEVDVF9XQUlULA0KPiA+ICsJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4g
PiArCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMsIGZhbHNlLCBwY2kpOw0KPiA+ICsJaWYg
KHJldCAmJiAodmFsID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCkpDQo+ID4gKwkJLyogT25s
eSBkdW1wIG1lc3NhZ2Ugd2hlbiBsdHNzbV9zdGF0IGlzbid0IGluIERFVEVDVCBhbmQgUE9MTCAq
Lw0KPiA+ICsJCWRldl93YXJuKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRy
eSEgTFRTU006IDB4JXhcbiIsDQo+ID4gK3ZhbCk7DQo+IHdlIG5lZWQgdG8gcmV0dXJuIHJldCBo
ZXJlIGluIGNhc2Ugd2UgZmFpbCB0byBlbnRlciBMMiB3aGVuIHRoZSBlbmRwb2ludCBpcw0KPiBj
b25uZWN0ZWQuDQo+DQpIaSBLcmlzaG5hOg0KSSB1c2VkIGVuY291bnRlciB0aGUgZm9sbG93aW5n
IGVycm9yLCB3aGVuIHNvbWUgTlZNRSBkZXZpY2VzIGFyZSB1c2VkLg0KRm9yIGV4YW1wbGUsIHRo
ZSAiU2FuZGlzayBTTjcyMCAyNTZHIE5WTUUgU1NEIGRpc2siLg0KImlteDZxLXBjaWUgNGMzMDAw
MDAucGNpZTogVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4MTkiDQpMVFNT
TToweDE5IG1lYW5zIFNfRElTQUJMRUQuIElzIHRoaXMgYW4gZXJyb3IgYWN0dWFsbHkgb3Igc29t
ZXRoaW5nIGVsc2U/DQpCVFcsIHdpdGhvdXQgdGhlIGVycm9yIHJldHVybi4gVGhlIE5WTUUgZGlz
ayBjYW4gYmUgZnVuY3Rpb25hbCBhZ2FpbiBhZnRlcg0KIHJlc3VtZSBiYWNrLiBPdGhlcndpc2Us
IHN5c3RlbSBpcyBoYW5nIGluIHN1c3BlbmQuDQoNCkxvZ3Mgd2l0aCBlcnJvciByZXR1cm4gd2hl
biBMVFNTTSBpcyAweDE5KHY0IHBhdGNoKS4NCnJ0Y3dha2V1cC5vdXQ6IHdha2V1cCBmcm9tICJt
ZW0iIHVzaW5nIHJ0YzAgYXQgRnJpIEphbiAgMiAwMDowMTowMiAxOTcwDQpbICAgMzEuMDE0NzI4
XSBQTTogc3VzcGVuZCBlbnRyeSAoZGVlcCkNCi4uLg0KWyAgIDMxLjYzNjcyOV0gaW14NnEtcGNp
ZSA0YzMwMDAwMC5wY2llOiBUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBMVFNTTTogMHgx
OQ0KWyAgIDMxLjY0NDE5MV0gaW14NnEtcGNpZSA0YzMwMDAwMC5wY2llOiBQTTogZHBtX3J1bl9j
YWxsYmFjaygpOiBnZW5wZF9zdXNwZW5kX25vaXJxIHJldHVybnMgLTExMA0KWyAgIDMxLjY1Mjkz
Nl0gaW14NnEtcGNpZSA0YzMwMDAwMC5wY2llOiBQTTogZmFpbGVkIHRvIHN1c3BlbmQgbm9pcnE6
IGVycm9yIC0xMTANCg0KTG9ncyB3aXRob3V0IGVycm9yIHJldHVybiB3aGVuIExUU1NNIGlzIDB4
MTkodGhpcyB2MyBwYXRjaCkuDQpydGN3YWtldXAub3V0OiB3YWtldXAgZnJvbSAibWVtIiB1c2lu
ZyBydGMwIGF0IEZyaSBKYW4gIDIgMDA6MDE6MDIgMTk3MA0KWyAgIDMxLjA3OTg2OF0gUE06IHN1
c3BlbmQgZW50cnkgKGRlZXApDQouLi4NClsgICAzMS43MzIyNTNdIGlteDZxLXBjaWUgNGMzMDAw
MDAucGNpZTogVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4MTkNClsgICAz
MS43NTgwNTFdIERpc2FibGluZyBub24tYm9vdCBDUFVzIC4uLg0KLi4uDQpbICAgMzEuNzk5MTQ4
XSBwc2NpOiBDUFUxIGtpbGxlZCAocG9sbGVkIDQgbXMpDQpbICAgMzEuODA2MjI5XSBFbmFibGlu
ZyBub24tYm9vdCBDUFVzIC4uLg0KWyAgIDMxLjgxMDY5MF0gRGV0ZWN0ZWQgVklQVCBJLWNhY2hl
IG9uIENQVTENClsgICAzMS44MTA3NjZdIEdJQ3YzOiBDUFUxOiBmb3VuZCByZWRpc3RyaWJ1dG9y
IDEwMCByZWdpb24gMDoweDAwMDAwMDAwNDgwODAwMDANClsgICAzMS44MTA4NDRdIENQVTE6IEJv
b3RlZCBzZWNvbmRhcnkgcHJvY2Vzc29yIDB4MDAwMDAwMDEwMCBbMHg0MTJmZDA1MF0NClsgICAz
MS44MTIzNjVdIENQVTEgaXMgdXANCi4uLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQog
DQo+IC0gS3Jpc2huYSBDaGFpdGFueWEuDQo+ID4gKwllbHNlDQo+ID4gKwkJLyoNCj4gPiArCQkg
KiBSZWZlciB0byByNi4wLCBzZWMgNS4zLjMuMi4xLCBzb2Z0d2FyZSBzaG91bGQgd2FpdCBhdCBs
ZWFzdA0KPiA+ICsJCSAqIDEwMG5zIGFmdGVyIEwyL0wzIFJlYWR5IGJlZm9yZSB0dXJuaW5nIG9m
ZiByZWZjbG9jayBhbmQNCj4gPiArCQkgKiBtYWluIHBvd2VyLiBJdCdzIGhhcm1sZXNzIHRvbyB3
aGVuIG5vIGVuZHBvaW50IGNvbm5lY3RlZC4NCj4gPiArCQkgKi8NCj4gPiArCQl1ZGVsYXkoMSk7
DQo+ID4NCj4gPiAgIAlkd19wY2llX3N0b3BfbGluayhwY2kpOw0KPiA+ICAgCWlmIChwY2ktPnBw
Lm9wcy0+ZGVpbml0KQ0KPiA+IEBAIC05NTIsNyArOTU2LDcgQEAgaW50IGR3X3BjaWVfc3VzcGVu
ZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+DQo+ID4gICAJcGNpLT5zdXNwZW5kZWQg
PSB0cnVlOw0KPiA+DQo+ID4gLQlyZXR1cm4gcmV0Ow0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gICB9
DQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTChkd19wY2llX3N1c3BlbmRfbm9pcnEpOw0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0K
PiA+IGluZGV4IDM0N2FiNzRhYzM1YS4uYmYwMzZlNjY3MTdlIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gKysrIGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBAQCAtMzMwLDYg
KzMzMCw3IEBAIGVudW0gZHdfcGNpZV9sdHNzbSB7DQo+ID4gICAJLyogTmVlZCB0byBhbGlnbiB3
aXRoIFBDSUVfUE9SVF9ERUJVRzAgYml0cyAwOjUgKi8NCj4gPiAgIAlEV19QQ0lFX0xUU1NNX0RF
VEVDVF9RVUlFVCA9IDB4MCwNCj4gPiAgIAlEV19QQ0lFX0xUU1NNX0RFVEVDVF9BQ1QgPSAweDEs
DQo+ID4gKwlEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlUID0gMHg2LA0KPiA+ICAgCURXX1BDSUVf
TFRTU01fTDAgPSAweDExLA0KPiA+ICAgCURXX1BDSUVfTFRTU01fTDJfSURMRSA9IDB4MTUsDQo+
ID4NCg==

