Return-Path: <linux-pci+bounces-15899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDD9BAA53
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5C280D1E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9A0282EE;
	Mon,  4 Nov 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fo/rFkx1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3764BA34;
	Mon,  4 Nov 2024 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730683885; cv=fail; b=gBrLvuiQcLVS8Gn7CjjTMcFNtNwjTuMj3cVj4+ZkFv26BqP9atPO8a6vjS6+yPlrq/2r9vHsOWGUm5fOSs4VmJNkMVItKTtWajl4VTYEMFeHDKKshBOQUzcQfunhxuWHVE8f+HaiRS0NU/2GJMeOpgF5fdg/dNL1tfyMUB78uz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730683885; c=relaxed/simple;
	bh=/qH0N+GNLHLdlysHdvG55RF7UL6UDus4wWETjfD0m3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xm1ZC4tSsKr0bE75Q8GKaGVZ4060bqDdKSUbbjrbXRg2Wn8u15mvA0NYJu1BCOmTGiaJnPMP7TO7iGq9PjyMhsZr9mHbs0BTOKfLUdfnGo5BAw3P+R82tjsknFmRvL0W5QiZwb61G5d0/YYTa+dysNzfbbNaJfdroo3ZUFD//U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fo/rFkx1; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wsugrl1AZbmJ03b9E57Azp351TmdCJs3wzEE2w951tEJkxhrZ3QZkNQInqzIc84/raFVcPXFi9PKQKRh1lNoXIfEmokC2GQ/cY+h1x9ciITmWeHMSjAibRE1breffz4kx/Okr79yZFhhN5SHiLYVlK8P940DY5t7fSPqMGlwjUyJsRzo8oi40BPJ6tab3nGwZJnIpbgQze5POZF/bUFxjujSsB3iBaD1621S7+YNIUju1JdiAct5pEf3IT+LM0cB122/tztfI3L2cZIKJevER6XF7Pq2HPoiQQ4TxCiiwa/ygn/ExL8by+TDXPCfR7YLrwvezzxtUZHWHX/qbeo81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qH0N+GNLHLdlysHdvG55RF7UL6UDus4wWETjfD0m3A=;
 b=oSwCA2Q2aMTqfi0Rx14pXPIHLuBMZn3DGe4A+kfugOE1mS8CDJfyb6iKQabtM552Ue3jk/zWLKjEtKJnTDFcE6XWhok8DL8K0+Pdy9QBd3BMrJ6M8wK6rVFNk4nNDJEs9fcMTIpvcJ5LauWFWRnW8ejTBg7R86sgfGxx3Nu6JezWX6V1cdCboQywGuaDeLZp/FK5xTIELGVaF2Njf7t80ZJY57AZdRj+blwfC+mNt9kOItD9i+XgasoW2N/NLJURZMmJvI3P+JSYjc5NZAOQ5S4Oe7/cUVMmRu54l7de7HSs8N6qDGS/+E54swNORReV2EkaQbHr4W3w2yhlKSsgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qH0N+GNLHLdlysHdvG55RF7UL6UDus4wWETjfD0m3A=;
 b=Fo/rFkx11iclsPKMkEXBojFXrr/Rg4Cb1JgAkKmHkdpXG+Aj9A1gVYknpWcCIhpaeNsBXyhvjMUDTUqBgHAaphQuHNFq/kk6gT7BAPSSFdvFkq9zhXPFbl/9W+tutlAf2L7r7jofGgzQHGWZNgAB74X6eR3Axb2NL4R0Ks6rtayd84T7zR9t4nBHYFsazoQDr7O3OVD9vJij1jztTKWx42nCI6M2QtU61b+OZYN8pOqK8mcB9nEM1NwPMVJbfsqnuJ2OSBHqxDZ2yhScrLESLAEkx0weP06Nb9/gO2HEN5SYxC0hNCK/GVOjkQcg5RTWzliZOhpYIqam4rwL90a5LA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10119.eurprd04.prod.outlook.com (2603:10a6:102:45d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 01:31:19 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 01:31:18 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Stefan Eichenberger
	<eichest@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <frank.li@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Stefan Eichenberger
	<stefan.eichenberger@toradex.com>
Subject: RE: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Thread-Topic: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Thread-Index: AQHbKrcZqzK9i3twKUuovutR423kQLKi1KAAgAOIFDA=
Date: Mon, 4 Nov 2024 01:31:17 +0000
Message-ID:
 <AS8PR04MB867619F514B354197802B8918C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241030103250.83640-1-eichest@gmail.com>
 <20241101193412.GA1317741@bhelgaas>
In-Reply-To: <20241101193412.GA1317741@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA1PR04MB10119:EE_
x-ms-office365-filtering-correlation-id: 999f7fa1-406f-42c8-5fbe-08dcfc706166
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?T25oSmlYeExseSs0a3JUdnc3V1FJL2JGeUc3ekJ0VXl2UGwwaXpDUVZFcDlX?=
 =?gb2312?B?VXptaVZndFB4c2VIWnFNUzVaREVOOG1CY2s5QmYrNWRoZnV0ZW90OFIyeExM?=
 =?gb2312?B?OGptSEVFM2tZb2JwMithK3prTFNTTHNnamJ3WGlleXU5RzhDaWRnMFFiZ3gz?=
 =?gb2312?B?K2wxbGhveTJZenBDbnpVVW9NTEUrNTFSNUF0UHpYV25UN1dEQ3ppU1c2ZDh0?=
 =?gb2312?B?QWNjci9HWHIwRkowa2pCL2VPMDJUWnNTMEk5UE9BdTRzTmdlUzlhUThYZUtF?=
 =?gb2312?B?WlpuY1NvbXVXajZjRSsza2t4OE5UWnJGT1l5NHdLcXVVdU1XcmUvMHhQeW5F?=
 =?gb2312?B?UWRiTThkZ1liakxBSVRyWjZGcmVrWERSODE0LzZmd1N1VElLemZuT0tPbHJV?=
 =?gb2312?B?QzNURG9qVjk1bE9xVUxSbkZtNXRRQ1luWFBxZmQwTjhmOHR2dG9ER3l2bVNI?=
 =?gb2312?B?K0FLajhkRzVrNmQvKzVQSU83aWNCNGNxYVlmaG4zbEtLOHNYKys0MEprSjJv?=
 =?gb2312?B?cTRtZ3ZTcjdMTzgyVWRmVzBMRS9xK0pTbTJhdVhWYTNVM1ZSRWtQNWI2eTgy?=
 =?gb2312?B?K0lGdnhjVzVIb1ZpUnlJUGtPeWdtMWFSNUVic0J0SWt3cERxeHJibmZlWDJQ?=
 =?gb2312?B?R1lvQXJlUy9nL0lhTjZZdjRHb2VFaE1xY1VmQllNU1ZCZXVVTnJQa1VlYmF4?=
 =?gb2312?B?aS9TMm5tKzNhWEgvTTZVeUJjdXFzSXZMdE5yS2YxdzduUk0xZklxdkZOTXcr?=
 =?gb2312?B?azJxWWQ5cUVrSEd0WjdDalFnMmE4RGZhNElMRG1jNCs2dnlkSXVRN0xZdXI3?=
 =?gb2312?B?ZW9DTjNEREFUTEVMUGJ3bFQwOXdXRGNLQTZzRTdGc1BGR2ltV1BPamppWUpi?=
 =?gb2312?B?Wm43RG91ZmZoN3RYakluVnZISnN6U2RpczlXczJEekUrOXZWSE9JcnRrRlZ0?=
 =?gb2312?B?U2F6Mmx2MnhoRVNDOThnWnRSc3I2SkJSZVZKYXl1Tk1IS3BnZkg5MVB6L2pM?=
 =?gb2312?B?aXhYc3A4ZEI0VDdHMHcxVWZGSWd4VXN3SlFGanVDM0syUkdQaDFuYWhSdzBk?=
 =?gb2312?B?bWp6RjBWOHBWaEZ1dEhMcVM3djdYR3Z2a2p6dkZENVBISVl6OFhzUXdYYmV1?=
 =?gb2312?B?OTh3U0wzQjU4azR0VTFpamZrR3BKbC83NzNlL05zTDljS05EUENsVG5VdDYv?=
 =?gb2312?B?dEJEenVUbC9UZzFObFg1K2VvbkxZaTZHN0U2QXp3TXFnSmtka1d2b1E1a3hU?=
 =?gb2312?B?OVMvWGxabFpBOGg1ZXFicHlReTRtdTV3QVNxZGw5WCtpbDJOa2FPd1QxSU56?=
 =?gb2312?B?M3d3blBwS2hQZGVCcG9NbzVaWUY2MXBEVzVOUURjL2l2TGFCWENWS3hCdE9a?=
 =?gb2312?B?M3VFaGhIZjVRYjIwV2UxYnBnS0Q0WEpHM3FMVkhBeGE4MUt4anpHYVRBd3dn?=
 =?gb2312?B?MEZKK2J3RVJOaUxiU1lqS1lWWUhXa2FiUVBaSFVvRmJtcEpXRlpLZU1vU2E4?=
 =?gb2312?B?ak5jMmdjNGhYb3ZhZDY3ZDFLUC9DdnB0alpYcXRrSzJiZ25ONkNSRUtMUnNJ?=
 =?gb2312?B?bGl2d3p4VnhGTkNMRWtOeVNaRmNyRjAzZExzVHdxNlRPMlVyOWJwMHp3MThh?=
 =?gb2312?B?NHd6QVdsMzZ1cGJQSzQxRmdZbkovaVFOaEFVOGdvZ3ZLZmhrekozY0FMMGFD?=
 =?gb2312?B?b2p4aU5vMWdVQW56YlNoQis5eklIdXpqaUNObXZyTnUzVThXMVNKWGdQdVdZ?=
 =?gb2312?B?N2prQ0pOS3QxcmdIamNxUHBqQXBVMHM2UnR2RWc2WUd5d2pBdXpsSzZHOXRh?=
 =?gb2312?Q?cnlDMK5EIaCBJw2AlQv4VHhK0Ashd5w52U/GU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dWFCa1BKZlVOSWhFMERHVWxZT2NlOFFFS2lpTVFERTUwNXE2clJuYUE2cUxQ?=
 =?gb2312?B?Tlh0L2JpTDUrSjV0azRaaS9pTHQyMTJpRkQyclQ4TDhrZlY1dklRNGRwSUtN?=
 =?gb2312?B?YS9sOWFZVDgyZ1JvaTk4blZLLzN2ZE5mQUhXVTNQZThDeW5EZ1lXTmE3cU84?=
 =?gb2312?B?ejNRUlEvVDJBbTVDQkdyTG1KZzg0OGVtMkE0M0xQSytnVm9MWHBiOWdxWk95?=
 =?gb2312?B?dEt4eXdCMko0UHhvWCthVTBhWE84Zjd3VjNkWlRVTGhWMUhlV0FxR2gzaVNS?=
 =?gb2312?B?ZlVRZm5od3NSZVJraWpFOXcwTDNTbkRabW1uYUtiOGJ1MktkL0tCL043MXJF?=
 =?gb2312?B?dTBadURSRDZxckZEY29TS2VSZHc5cFBSV05USWtoY2tDN1ZlYitCeUxQbGY5?=
 =?gb2312?B?bFg0aTlVd0hDaVE4Q0lRMmtOYlRTaS9tdjVIb3NOSzJYRVFBaUJRSE94VjBY?=
 =?gb2312?B?QytDZUQwR1d3NE4zOUZuR29oaGZEN2U1eGhMWEpwY3hGemFpWmlsR0lKeW0x?=
 =?gb2312?B?OVdzeVNmTExOemdPNDkvc3dKbHRzandlUTRZbGNxcWZ2ckRtYTNTQWduWGZE?=
 =?gb2312?B?T3pFOUxuWE1RMzZpYVlrQWZ4V3htZXVGVE1VZVg3NFROdHEyOTQwQVRWcG9D?=
 =?gb2312?B?ZHlHVTFDd2RiRTlqTEV1bXJURFRMU0YwRVdTMkJYRjF3K1lXTzJ1d2FtbFFU?=
 =?gb2312?B?ZEVQUVVBQ2RNcXlnRnpXV1YxMWN1aHdUUThjbEp2Um92ck8zNVBYQ3hXQllK?=
 =?gb2312?B?Z09oRjlRRGNHUVFMem1qSmMzUTNOR2xDZkxZSkE3d0lvcEJQbXBLYkdSaDRI?=
 =?gb2312?B?VWxsRmt4cy81VHFLdEZQQlVLOUtBdmFjTUFZZkxVbEp5c2k5VlFIZjIzaHpC?=
 =?gb2312?B?U1lMQktydE04VUJZYnV1cGtVZ29xZ0pvOWYrR0pVaG1rc3BSVE1lYzR5SDFS?=
 =?gb2312?B?RGZFMHVEcVpQT2dVNUU3REVNYUpoTHpUTXRWMldJYUU0V09XVzAva2tpeENE?=
 =?gb2312?B?Vmt1TDllRXZ6eXY0UnVySnNZOVVRV2ZYWGtuQ0pJWE5zMHAwdzROYk5Nb2Nj?=
 =?gb2312?B?blc2UGJObVcvWEIyZnRNTFJXT0VOZmxLc1NmSFhCNTR1WmRvWjhMSVc4cDNV?=
 =?gb2312?B?MEpjMG8xV1p2U2hwTVpoUXhQVjlFajl0WHExZ3ljcFlhSnBlekhDUkV1L2Q4?=
 =?gb2312?B?ZGtndWl6V3MwSEh5YnY3aHlpSWVNSjJsdEZpL2JYN29jalYxcEIzYVNBelJK?=
 =?gb2312?B?TVhVSk1HbWF6NHdQSHQrRmovMy93N2M1ejd1aTU0TkE0REJ5dk4xTzR5cy9j?=
 =?gb2312?B?OFZlTzNhenhwTXZjWmJQTVA4VWpPNURNbDRVM1BZelF5VDBtQmJoMzZVTEFD?=
 =?gb2312?B?QXFlQkVvZXJzTTIvTEQ1UzNuOUFNSHRsdkxFL2FRempVY2syblc0WEI1dlhU?=
 =?gb2312?B?V0pkM1hTb0cxMUZIRElvOEMyaTE5UWVqVCtrdTFZekdydENNRmRudlhnRnFC?=
 =?gb2312?B?b3lJcVFvTU1KWkJpNTJabUptYmZQS0lQY2EwbGN3MTRxMVIyRjkyditHSlI3?=
 =?gb2312?B?SVdxeFJ6ZWxDTFVVSjZIUjRIblVLM05qK0V1OTA2TkZEY0hkc1VZczJSdXQ2?=
 =?gb2312?B?dXhnSUkvdk5vWnIvK1ZtdlhvbWFyNHJQNDdLR08zVzg0ZWJkeTd2L0RCd2U2?=
 =?gb2312?B?VGJsMXpkd0lvRzd1MUdtcCtoWUxLdlFSK0l6UHBueTBLNW1ld2tGZUswR255?=
 =?gb2312?B?L2w3SVpqcmh2SGVQTkFhZkNodEp0OHhSZXk1bWgvMzdvQlEzUkJhWmtlTy8r?=
 =?gb2312?B?NitYY3dBc081WFd5SjVSTE1OVUhDY3NMMCtneWZJcHhIaXhaRzlPMmdHc0l3?=
 =?gb2312?B?SDBNbU5MdWY3KzR2end1d0U4YndZbXFNdFZlKzZObldIYnhnb0V0M01iM0dj?=
 =?gb2312?B?YzVGZGsxZXloa2pDZ0RLd2JXOXlBdU5tUG9jR1N2OGphVE1YSDF0MGVZMGp5?=
 =?gb2312?B?STVtMHFhQml6bXo3Z3NLS3lKbnlsR3c0cmhCaTdwMWhaYkhZbFhLdmQ4Y2xm?=
 =?gb2312?B?dk5WZWpGUGtFc0g1M0tvTFVxQU5nbm9ML2xoS0RSRXFSVjNYcWRoNVhEL3ow?=
 =?gb2312?Q?qq+89QXK/89gUCT+vhxWCx22M?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999f7fa1-406f-42c8-5fbe-08dcfc706166
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 01:31:17.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5w4Nm/28tTvY/szIzGii84MgSv72A07x5Vv5/zMIkG9s0lzLv8fWAeL/5TLpE+edwz3Y2IAnn/lyVupy7FSR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10119

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEx1MIyyNUgMzozNA0KPiBUbzogU3RlZmFu
IEVpY2hlbmJlcmdlciA8ZWljaGVzdEBnbWFpbC5jb20+OyBIb25neGluZyBaaHUNCj4gPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+
IENjOiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgbWFuaXZhbm5hbi5zYWRo
YXNpdmFtQGxpbmFyby5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IEZyYW5jZXNjbyBEb2xjaW5p
IDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47IEZyYW5rIExpDQo+IDxmcmFuay5saUBu
eHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBTdGVmYW4gRWljaGVuYmVyZ2VyDQo+IDxzdGVmYW4uZWljaGVuYmVy
Z2VyQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBQQ0k6IGlteDY6IEFk
ZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0IGZvciBpLk1YNlFETA0KPiANCj4gT24gV2VkLCBPY3Qg
MzAsIDIwMjQgYXQgMTE6MzI6NDVBTSArMDEwMCwgU3RlZmFuIEVpY2hlbmJlcmdlciB3cm90ZToN
Cj4gPiBGcm9tOiBTdGVmYW4gRWljaGVuYmVyZ2VyIDxzdGVmYW4uZWljaGVuYmVyZ2VyQHRvcmFk
ZXguY29tPg0KPiA+DQo+ID4gVGhlIHN1c3BlbmQvcmVzdW1lIGZ1bmN0aW9uYWxpdHkgaXMgY3Vy
cmVudGx5IGJyb2tlbiBvbiB0aGUgaS5NWDZRREwNCj4gPiBwbGF0Zm9ybSwgYXMgZG9jdW1lbnRl
ZCBpbiB0aGUgTlhQIGVycmF0YSAoRVJSMDA1NzIzKToNCj4gPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cuDQo+ID4N
Cj4gbnhwLmNvbSUyRmRvY3MlMkZlbiUyRmVycmF0YSUyRklNWDZEUUNFLnBkZiZkYXRhPTA1JTdD
MDIlN0Nob25nDQo+IHhpbmcuemgNCj4gPg0KPiB1JTQwbnhwLmNvbSU3QzkwMzk0NjBlM2NmNTQ3
NzNlZmNkMDhkY2ZhYWMyYmM3JTdDNjg2ZWExZDNiYzJiNGM2Zg0KPiBhOTJjZA0KPiA+DQo+IDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg2NjA4NjQ2MDQwOTg2NTIlN0NVbmtub3duJTdDVFdGcGJH
WnMNCj4gYjNkOGV5SldJDQo+ID4NCj4gam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzAlDQo+IDdDJTcNCj4gPg0KPiBDJTdDJnNk
YXRhPVdBQ0t3dlVQbFRaSmN4amtMZTdZSTNabklUdHhFajZ3VUxoTW5kaDh6TkUlM0QmcmVzZXJ2
DQo+IGVkPTANCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIHRoZSBpc3N1ZSBieSBzaGFy
aW5nIG1vc3Qgb2YgdGhlIHN1c3BlbmQvcmVzdW1lDQo+ID4gc2VxdWVuY2VzIHVzZWQgYnkgb3Ro
ZXIgaS5NWCBkZXZpY2VzLCB3aGlsZSBhdm9pZGluZyBtb2RpZmljYXRpb25zIHRvDQo+ID4gY3Jp
dGljYWwgcmVnaXN0ZXJzIHRoYXQgZGlzcnVwdCB0aGUgUENJZSBmdW5jdGlvbmFsaXR5LiBJdCB0
YXJnZXRzIHRoZQ0KPiA+IHNhbWUgcHJvYmxlbSBhcyB0aGUgZm9sbG93aW5nIGRvd25zdHJlYW0g
Y29tbWl0Og0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4gPg0KPiB1Yi5jb20lMkZueHAtaW14JTJGbGlu
dXgtaW14JTJGY29tbWl0JTJGNGU5MjM1NWUxZjc5ZDIyNWVhODQyNTExZmMNCj4gZmQ0Mg0KPiA+
DQo+IGIzNDNiMzI5OTUmZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Qzkw
Mzk0NjBlM2NmNTQNCj4gNzczZWZjDQo+ID4NCj4gZDA4ZGNmYWFjMmJjNyU3QzY4NmVhMWQzYmMy
YjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg2Ng0KPiAwODY0NjANCj4gPg0KPiA0
MTIxOTA0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1DQo+IE16SWlMQw0KPiA+DQo+IEpCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0Mw
JTdDJTdDJTdDJnNkYXRhPXRhZm9UOHVnNEVlaEdYckUNCj4gTnpRT2IlDQo+ID4gMkY3ckQlMkZy
YTglMkJlZm5BRWlWJTJGQjhBZmMlM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gVW5saWtlIHRoZSBk
b3duc3RyZWFtIGNvbW1pdCwgdGhpcyBwYXRjaCBhbHNvIHJlc2V0cyB0aGUgY29ubmVjdGVkDQo+
ID4gUENJZSBkZXZpY2UgaWYgcG9zc2libGUuIFdpdGhvdXQgdGhpcyByZXNldCwgY2VydGFpbiBk
cml2ZXJzLCBzdWNoIGFzDQo+ID4gYXRoMTBrIG9yIGl3bHdpZmksIHdpbGwgY3Jhc2ggb24gcmVz
dW1lLiBUaGUgZGV2aWNlIHJlc2V0IGlzIGFsc28gZG9uZQ0KPiA+IGJ5IHRoZSBkcml2ZXIgb24g
b3RoZXIgaS5NWCBwbGF0Zm9ybXMsIG1ha2luZyB0aGlzIHBhdGNoIGNvbnNpc3RlbnQNCj4gPiB3
aXRoIGV4aXN0aW5nIHByYWN0aWNlcy4NCj4gPg0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwgc3Vz
cGVuZC9yZXN1bWUgd2lsbCBmYWlsIG9uIGkuTVg2UURMIGRldmljZXMgaWYgYQ0KPiA+IFBDSWUg
ZGV2aWNlIGlzIGNvbm5lY3RlZC4gVXBvbiByZXN1bWluZywgdGhlIGtlcm5lbCB3aWxsIGhhbmcg
YW5kDQo+ID4gZGlzcGxheSBhbiBlcnJvci4gSGVyZSdzIGFuIGV4YW1wbGUgb2YgdGhlIGVycm9y
IGVuY291bnRlcmVkIHdpdGggdGhlDQo+ID4gYXRoMTBrIGRyaXZlcjoNCj4gPiBhdGgxMGtfcGNp
IDAwMDA6MDE6MDAuMDogVW5hYmxlIHRvIGNoYW5nZSBwb3dlciBzdGF0ZSBmcm9tIEQzaG90IHRv
DQo+ID4gRDAsIGRldmljZSBpbmFjY2Vzc2libGUgVW5oYW5kbGVkIGZhdWx0OiBpbXByZWNpc2Ug
ZXh0ZXJuYWwgYWJvcnQNCj4gPiAoMHgxNDA2KSBhdCAweDAxMDZmOTQ0DQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gRWljaGVuYmVyZ2VyIDxzdGVmYW4uZWljaGVuYmVyZ2VyQHRvcmFk
ZXguY29tPg0KPiANCj4gUmljaGFyZCBhbmQgTHVjYXMsIGRvZXMgdGhpcyBsb29rIE9LIHRvIHlv
dT8gIFNpbmNlIHlvdSdyZSBsaXN0ZWQgYXMgbWFpbnRhaW5lcnMNCj4gb2YgcGNpLWlteDYuYywg
SSdkIGxpa2UgdG8gaGF2ZSB5b3VyIGFjayBiZWZvcmUgbWVyZ2luZyB0aGlzLg0KPiANClNvcnJ5
IHRvIHJlcGx5IGxhdGUuDQpJJ20gZmluZSB3aXRoIHRoYXQuDQpUaGFua3MuDQpBY2tlZC1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIEltcHJvdmUgY29tbWl0
IG1lc3NhZ2UgKEJqb3JuKQ0KPiA+IC0gRml4IHN0eWxlIGlzc3VlIG9uIGNvbW1lbnRzIChCam9y
bikNCj4gPiAtIHMvbXNpL01TSSAoQmpvcm4pDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+
IC0gQWRkZWQgYSBuZXcgZmxhZyB0byB0aGUgZHJpdmVyIGRhdGEgdG8gaW5kaWNhdGUgdGhhdCB0
aGUgc3VzcGVuZC9yZXN1bWUNCj4gPiAgIGlzIGJyb2tlbiBvbiB0aGUgaS5NWDZRREwgcGxhdGZv
cm0uIChGcmFuaykNCj4gPiAtIEZpeCBjb21tZW50cyB0byBiZSBtb3JlIHJlbGV2YW50IChNYW5p
KQ0KPiA+IC0gVXNlIGlteF9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0IGluIHN1c3BlbmQgKE1hbmkp
DQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDU3DQo+
ID4gKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggODA4ZDFmMTA1NDE3My4uYzhkNWM5MGFh
NGQ0NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IEBAIC04Miw2ICs4MiwxMSBAQCBlbnVtIGlteF9wY2llX3ZhcmlhbnRzIHsNCj4gPiAgI2RlZmlu
ZSBJTVhfUENJRV9GTEFHX0hBU19TRVJERVMJCUJJVCg2KQ0KPiA+ICAjZGVmaW5lIElNWF9QQ0lF
X0ZMQUdfU1VQUE9SVF82NEJJVAkJQklUKDcpDQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19D
UFVfQUREUl9GSVhVUAkJQklUKDgpDQo+ID4gKy8qDQo+ID4gKyAqIEJlY2F1c2Ugb2YgRVJSMDA1
NzIzIChQQ0llIGRvZXMgbm90IHN1cHBvcnQgTDIgcG93ZXIgZG93bikgd2UgbmVlZA0KPiA+ICt0
bw0KPiA+ICsgKiB3b3JrYXJvdW5kIHN1c3BlbmQgcmVzdW1lIG9uIHNvbWUgZGV2aWNlcyB3aGlj
aCBhcmUgYWZmZWN0ZWQgYnkgdGhpcw0KPiBlcnJhdGEuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5l
IElNWF9QQ0lFX0ZMQUdfQlJPS0VOX1NVU1BFTkQJCUJJVCg5KQ0KPiA+DQo+ID4gICNkZWZpbmUg
aW14X2NoZWNrX2ZsYWcocGNpLCB2YWwpCShwY2ktPmRydmRhdGEtPmZsYWdzICYgdmFsKQ0KPiA+
DQo+ID4gQEAgLTEyMzcsOSArMTI0MiwxOSBAQCBzdGF0aWMgaW50IGlteF9wY2llX3N1c3BlbmRf
bm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4g
IAlpbXhfcGNpZV9tc2lfc2F2ZV9yZXN0b3JlKGlteF9wY2llLCB0cnVlKTsNCj4gPiAtCWlteF9w
Y2llX3BtX3R1cm5vZmYoaW14X3BjaWUpOw0KPiA+IC0JaW14X3BjaWVfc3RvcF9saW5rKGlteF9w
Y2llLT5wY2kpOw0KPiA+IC0JaW14X3BjaWVfaG9zdF9leGl0KHBwKTsNCj4gPiArCWlmIChpbXhf
Y2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxBR19CUk9LRU5fU1VTUEVORCkpIHsNCj4g
PiArCQkvKg0KPiA+ICsJCSAqIFRoZSBtaW5pbXVtIGZvciBhIHdvcmthcm91bmQgd291bGQgYmUg
dG8gc2V0IFBFUlNUIyBhbmQgdG8NCj4gPiArCQkgKiBzZXQgdGhlIFBDSUVfVEVTVF9QRCBmbGFn
LiBIb3dldmVyLCB3ZSBjYW4gYWxzbyBkaXNhYmxlIHRoZQ0KPiA+ICsJCSAqIGNsb2NrIHdoaWNo
IHNhdmVzIHNvbWUgcG93ZXIuDQo+ID4gKwkJICovDQo+ID4gKwkJaW14X3BjaWVfYXNzZXJ0X2Nv
cmVfcmVzZXQoaW14X3BjaWUpOw0KPiA+ICsJCWlteF9wY2llLT5kcnZkYXRhLT5lbmFibGVfcmVm
X2NsayhpbXhfcGNpZSwgZmFsc2UpOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlpbXhfcGNpZV9w
bV90dXJub2ZmKGlteF9wY2llKTsNCj4gPiArCQlpbXhfcGNpZV9zdG9wX2xpbmsoaW14X3BjaWUt
PnBjaSk7DQo+ID4gKwkJaW14X3BjaWVfaG9zdF9leGl0KHBwKTsNCj4gPiArCX0NCj4gPg0KPiA+
ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBAQCAtMTI1MywxNCArMTI2OCwzMiBAQCBzdGF0aWMg
aW50IGlteF9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4gIAlp
ZiAoIShpbXhfcGNpZS0+ZHJ2ZGF0YS0+ZmxhZ3MgJiBJTVhfUENJRV9GTEFHX1NVUFBPUlRTX1NV
U1BFTkQpKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gLQlyZXQgPSBpbXhfcGNpZV9ob3N0
X2luaXQocHApOw0KPiA+IC0JaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gcmV0Ow0KPiA+IC0JaW14
X3BjaWVfbXNpX3NhdmVfcmVzdG9yZShpbXhfcGNpZSwgZmFsc2UpOw0KPiA+IC0JZHdfcGNpZV9z
ZXR1cF9yYyhwcCk7DQo+ID4gKwlpZiAoaW14X2NoZWNrX2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lF
X0ZMQUdfQlJPS0VOX1NVU1BFTkQpKSB7DQo+ID4gKwkJcmV0ID0gaW14X3BjaWUtPmRydmRhdGEt
PmVuYWJsZV9yZWZfY2xrKGlteF9wY2llLCB0cnVlKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJ
CQlyZXR1cm4gcmV0Ow0KPiA+ICsJCXJldCA9IGlteF9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQo
aW14X3BjaWUpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwkJ
LyoNCj4gPiArCQkgKiBVc2luZyBQQ0lFX1RFU1RfUEQgc2VlbXMgdG8gZGlzYWJsZSBNU0kgYW5k
IHBvd2VycyBkb3duIHRoZQ0KPiA+ICsJCSAqIHJvb3QgY29tcGxleC4gVGhpcyBpcyB3aHkgd2Ug
aGF2ZSB0byBzZXR1cCB0aGUgcmMgYWdhaW4gYW5kDQo+ID4gKwkJICogd2h5IHdlIGhhdmUgdG8g
cmVzdG9yZSB0aGUgTVNJIHJlZ2lzdGVyLg0KPiA+ICsJCSAqLw0KPiA+ICsJCXJldCA9IGR3X3Bj
aWVfc2V0dXBfcmMoJmlteF9wY2llLT5wY2ktPnBwKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJ
CQlyZXR1cm4gcmV0Ow0KPiA+ICsJCWlteF9wY2llX21zaV9zYXZlX3Jlc3RvcmUoaW14X3BjaWUs
IGZhbHNlKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcmV0ID0gaW14X3BjaWVfaG9zdF9pbml0
KHBwKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCWlteF9w
Y2llX21zaV9zYXZlX3Jlc3RvcmUoaW14X3BjaWUsIGZhbHNlKTsNCj4gPiArCQlkd19wY2llX3Nl
dHVwX3JjKHBwKTsNCj4gPg0KPiA+IC0JaWYgKGlteF9wY2llLT5saW5rX2lzX3VwKQ0KPiA+IC0J
CWlteF9wY2llX3N0YXJ0X2xpbmsoaW14X3BjaWUtPnBjaSk7DQo+ID4gKwkJaWYgKGlteF9wY2ll
LT5saW5rX2lzX3VwKQ0KPiA+ICsJCQlpbXhfcGNpZV9zdGFydF9saW5rKGlteF9wY2llLT5wY2kp
Ow0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IEBAIC0xNDg1LDcg
KzE1MTgsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtd
ID0gew0KPiA+ICAJW0lNWDZRXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDZRLA0KPiA+ICAJ
CS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSU1YX1BIWSB8DQo+ID4gLQkJCSBJTVhfUENJRV9GTEFH
X0lNWF9TUEVFRF9DSEFOR0UsDQo+ID4gKwkJCSBJTVhfUENJRV9GTEFHX0lNWF9TUEVFRF9DSEFO
R0UgfA0KPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19CUk9LRU5fU1VTUEVORCB8DQo+ID4gKwkJCSBJ
TVhfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gIAkJLmRiaV9sZW5ndGggPSAweDIw
MCwNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg2cS1pb211eGMtZ3ByIiwNCj4gPiAgCQkuY2xrX25h
bWVzID0gaW14NnFfY2xrcywNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=

