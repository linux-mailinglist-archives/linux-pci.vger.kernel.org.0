Return-Path: <linux-pci+bounces-25472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F4A7F2FC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A97189909D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116424EA9B;
	Tue,  8 Apr 2025 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b6sb+VEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE923ED6E;
	Tue,  8 Apr 2025 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081367; cv=fail; b=oWGxu/NK+PTvGa/jj7euRSWM5L+BJaVZzp9lecJWsRfESKA59tWjtsdMrLWUEf+LEebppK6SSIUMhpmhtNU2scrW1yxDyr78AGrCe81YSqId9d2Aval73gidZQty7Gmm0SpI+rwFr8kdP1lKtK1pRag35vefF1gXdscfNpiCs/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081367; c=relaxed/simple;
	bh=W2ygzXgc+LHi02je5G4pCADb+OXO/9XwgHM2PWVJJWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6+qmNUD5MzofyTRsuAqMQ1D99UDM/hoFJSamZCCfwfJcMYJguDVjO6teUJJG9Re7z2KyDhUWvy/0nMRpXBTpALpzcg68eFkTk1gPlTwN5aJEb+tANCv50o+nvuXqlug4DamLGR+val9eQMYTnLjuYfykIrgpcy3kpXHKxQlvNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b6sb+VEC; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ogw0bHE3JShd5ArpLx+4524yKj0G0BchtSJ9GMEN7mP8NmPONBRClusuNAvgshyvs7bimE7f+BnN2ZVBqiOq2fSUnggu++LhiVCU3g69iELJIaplA6BtL0yQiEma07RjJ7npkO/8MKf/dMb4gorwgrR6gpoC3qD0nvGTxi/b3ls4P/K2XZ2lzkBSrdic1tBSS5tz4wxHY15ipF/mZLx0hBRikIk2wRHvXUR+gjU5nmig+Tn22UUAB8uHiXq9u5pz9tHMUJddCdrhJjafWySMvub9HppCQ5zifstzfgpLFJNZOuEAnSoPqrW3M1O3pi2lnUb+Qhqxmzay2cYDQLms1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2ygzXgc+LHi02je5G4pCADb+OXO/9XwgHM2PWVJJWY=;
 b=CO346HAk2Oel7eNONZhKUs7rJiaQ6ikkaeovU+i+SbUSaHNFie0xtTamsWpDGsv/pm4I9E/3SLv+ypnJ8wXCjmjz48AUbuIqlwqkOTwgA+LWC9rRvkwLvNlzjtJ+6gyVUOeAKmzq00RzHhHFR4gu8kliOsTwD1bE5iv+ym4t6bwwNu5MLXK5mUnNasX5pgZnxmtMzgHB/xa9iXXM2mhlUPERfdZc4xPDtA/3klVQ8cwJillkVcBkK6n5pw1DdGIkKzmckKjRbaTdHlAodILzYI09sTfpxj85WwHwPFOASj1HHYVmKMlLg90d7vVGgniftUZ2hmFcsMNCHjXTsI+jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ygzXgc+LHi02je5G4pCADb+OXO/9XwgHM2PWVJJWY=;
 b=b6sb+VECVnVu9NmkLBO0xhTqmMXamNl0OOUhM7C+edwC8+iuiYpIqfNJVTRvmKLm1DlWoyYwy617XoC95jVdtSp5/W4gbduQrfbYBTp1/6/c9Gey+WLFmH35hr1/E2/gMFTcFk3cgerUcAIb5iZm6YnuoH5Nx+nkqjZG2AigkZ90aV7Ktqf8PV6vp4babnmcyPEe5XBDeVQUozHqstVSZgcYG3REeBOs4HGum2Q37+nom1Vl1yVsYTzj9VMBBDuyqJayXn89/GA1SC8+Yr2R2fY5z6ovksGI+04t31enqNZryq4Mkaa+BBgfaj7NUbFjJ3g97I5X9bSn46fEJZHNYA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:02:42 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:02:42 +0000
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
Thread-Index: AQHbn44DKK1oo7avrE6ytacDA3gL7LOP/LQAgAAFMnCAAIO0gIAAxEXQgAfaDNA=
Date: Tue, 8 Apr 2025 03:02:42 +0000
Message-ID:
 <AS8PR04MB8676C5D0DB84975D34C4C65A8CB52@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
x-ms-office365-filtering-correlation-id: f29d2cbe-20bc-42ea-1cab-08dd7649d468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SytON2FNSEpnK0VXdjVtRk9JMUZUdjVvNVVRYlZpbUx6cG5KS1N3OW9DckFz?=
 =?utf-8?B?NHlpWHh3VG1BTDBNTlBDQ2xXdU1QR0FWR01ybUk4enhVZGhvMUFjYjBqZ0xO?=
 =?utf-8?B?MTVpczhhRStwTkphZ2tGOVZ0Y1JmMThZcmhhZXpZcGxHVm9UemxXb0YvTFg5?=
 =?utf-8?B?SFJ3MUdLdnRBVFlLYkNqcTU0d3RRTEpQSXhTdDFEdFU5cEQzdVJEZHA1b0wr?=
 =?utf-8?B?VVRSQjQvQkJIVFprQk1QMkJsdkIybDFMaUFBcW9tVS84Q2JzalVxalIxM21k?=
 =?utf-8?B?UXhyMXVMTmFJa255bm5JbHpJYSsyRW5SMlI4bXlWczFZQnY1cEZBaUp5TEhq?=
 =?utf-8?B?SGZ3MDcwaVpISHNGdk9KYzdxWUlCRy9haC9lcHgwQkppMU1vTTByeHNLMzhG?=
 =?utf-8?B?MTZOOE9hU010Z0JhUmlrUkZGWjNNT2dFSEdJQTQvYjFsQkMxaFVSd3VRRE9x?=
 =?utf-8?B?bGtiYUJnNmV0S0YvL2x1ZVJWR2dGMGJDZ3V3UE1qcU5GbjFLVkZwLytianlP?=
 =?utf-8?B?WE1KSTJSWFNaSGwvaEptY1FIZjd5RXhaMTdKY0JTOXprV2lpOXgvaFBmQ0xv?=
 =?utf-8?B?ZDFXc3NjTUh3dHBXbDN1NjFZNmlnN1RXbFdGWkg1ZGxmTzdZdFA1ZThJSUFY?=
 =?utf-8?B?bFJxcS96TFkyRWhpRks0V1E1TnFCeDZDSFBVWXRtMHdxK05tSkpwVlJJS3Vz?=
 =?utf-8?B?bWU2bWQrQjZFQm90SzJPREQrOXFIZUVuUTRKanZQU1lzcjBaRjZvZ2g0MkR4?=
 =?utf-8?B?dndOdDN2QnNKQ2VhU3JrZ1NvSDAyenhkMEQ0VnF3RVBheU1ON3lEVXB5NUJE?=
 =?utf-8?B?TlZwdWFLMEcwd2lPd1lxZGZuQW1WS0NKSStXN2JuVFpGTkFPTm5NcUVidUtj?=
 =?utf-8?B?QUN2dEpHcXpGbm1IQTJ0d2RxNXZTbWhGcXJvd0g1R0dEaFpBZnYrM1E5QVFX?=
 =?utf-8?B?MG9sVVpiaS9hOTVKdFlBNG1kK2tPcHhPVnROc3NOZU9IRnNTOEd2VUlDTFFI?=
 =?utf-8?B?emxIVlJyZWxnSzNsVUVxRm9Yam1maUNEWUlpVnp5TkZIZ2EyNHJuR3o0dmpJ?=
 =?utf-8?B?QVFlejIyUVplR0RvR3hBYXFnUE9SbTg3TXpJR0phaUNtUk95Q3JRRUllL3g1?=
 =?utf-8?B?UnlvLzBEekhkMWU2dzNNM2hmcnBUbm5pWmpFTk5scXA5QmxaVi9sSFlNSzJY?=
 =?utf-8?B?VmVzZktYQ2kyQi9kWDYvdFZ5eFV1Z3ZCd2x6UC9ENEVMWGNCTmlJamdCVkEv?=
 =?utf-8?B?OTBMeGlaeWhEWGdoSlJBS0hGMXZsT2xMV3lUNk4xOFplOGpGM08wTDBRS2tw?=
 =?utf-8?B?akVFakRPa2FPMG5MNmtIK0FvSStIeGh5S25LYlh6eVd2M0lSV2tJR3JJQ2Fi?=
 =?utf-8?B?dW1wZnZ4MVRWMlEzT0J3c0tveFBDYUZEYTB1dkZWYUJKUS9GMGJLVldUdDFZ?=
 =?utf-8?B?dmRyRjdubTJwUXhoSkR0WDdUaGE4eUVjaS9kblpwM05iSDJNYkR3bXB4bUtQ?=
 =?utf-8?B?clJLdWxMVUtPc1hnVExqOHRWMHR1QjlZK282aTl3M05iUlVZRUY5dXBGWXhZ?=
 =?utf-8?B?L2ozb1hyUVFyeXIvRlpPUVJlMGkzYjIxdmd2WEJxamtUVjRYK2N4dFJ3WkpK?=
 =?utf-8?B?TzNDR3dSWGFLS3cxeXJtSWRPUHJDMEpabUpVWmw5VlVuR0ljVnEyYU9ycWs0?=
 =?utf-8?B?ekNGNzdVczA4bnRoTEcrbWpvalllZUF5b2Y3aXlaSGkrVjNiREpNNDBxTVBa?=
 =?utf-8?B?YUk2aWNtRCtxSmJpQ0h4dXlhZ2JybFQwcTBDL0hQNUV1NGM2TndLcWxNVWdJ?=
 =?utf-8?B?VXFWVGpaS3U3Vng4Zng4cVdUaW1oL2FVcHNWU0dPMG5tMjVtaWIraUNXZm1i?=
 =?utf-8?B?OUNsYmJJTDJuWlYwK2Zoc0E1ZXk4NjRqQVJvRDYvTnR2L1FadFNNSXBWYVE3?=
 =?utf-8?Q?Zl9TLT6HcuHvmzRX3slsmHUomYOxO5ja?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2FpN2xrcWNHUGFkdUx3ekV2cFBjUXZxZk5zbDJwekExSnBBRmdSa2R1Vmhr?=
 =?utf-8?B?blJvMVB5WVFIeVpCNFlzYUg1ZW9HUk13czRBUzBnZW96U004L3VrMDNGVG02?=
 =?utf-8?B?K1ZzMWdVQ084bFFqZlRWKzJhRkhFdmRpQVJBaXA2LzhMV2R4V2ZxWlhKbjZW?=
 =?utf-8?B?RVVweE9SUDdkTFZXU0ZqdXRwLzlpUi9qenlOR1FIeStPcldLMFVsTEFRWGYw?=
 =?utf-8?B?UFRQNDRnd01KR3lKVjdWV1RjZXVKTXo4NFFTRFlaMDY5dnJaWWRJRy9FcTVs?=
 =?utf-8?B?TXNqTWpXZEx3THRzQVptQldET3Z3akZ3NFdPdlJ2dHpZZDFIMDdNRUlpR283?=
 =?utf-8?B?SzlSU25mWmh6d0lBRElVUEcrZ0VNby8yNXRQWnpocmlpMElRVnJpU05WMWlu?=
 =?utf-8?B?NHNyRUk3cTVzdXR6NDBYZGU2a2tyenpLWEc3RjRGazFYVDlFZmcxV2tWL0NF?=
 =?utf-8?B?cTRVanN6WjNyWW1ObmRYZ1dSWHJobHl3OThJcVlTMWJlSG9JK1JlSVJtSVlm?=
 =?utf-8?B?QXphRXJUMmJEN0RVNnZsSVA5K1krTlNqRmMwS0J5NmdiYzYrbDhZVGpYQjJ4?=
 =?utf-8?B?eFdVWVZzK2srNzY1aUFsZCtlbDQwWWVTeUFWT1U4NzF0blFXMjhNRDJ6NmxN?=
 =?utf-8?B?WkpycWo4aytyTzNOQWRBWlZ6SnR6dFNERENqMExHbDA1ekhOcEhnaWhIbUg5?=
 =?utf-8?B?OUNzZ3dMRGVqSTRnOFBwR2FsYzNmU2ZzTC9YcUVTRnpwaDdXVWV2dzl4MG9K?=
 =?utf-8?B?cFNjQmRQRjNIc1JEV0t4S2xmN0dsbzRrbEx0eTdGYUVSWjc5QkN1dHBaNys3?=
 =?utf-8?B?ZnMydi9BeXRKRWI5eDFib3hJZy9USmpWWWh5UjJZUzc1R0NkRE5WVlBBblpp?=
 =?utf-8?B?Z3pKY1ZJblZtRTZINUxzUnBSUWhMWWp1dmlYYnVTaFRYZXhwSklCTHY1Qkc3?=
 =?utf-8?B?OTFSTG9wajl1WnJkNjBUN0lYZjV0bkFRS3d2Rk96dGZ4c1daMW9DZlRINTlQ?=
 =?utf-8?B?NWNjMXkwT1RPczgxcWFXZHY1MXIwd3VmVGgzbW1Yd25VZVVmWmloNU1YWm5J?=
 =?utf-8?B?UWVQNklrM25DNzVHWDVMbEZoQkVRZXgzQ2dXaFErNWxNemYzVkV4Q25FazJq?=
 =?utf-8?B?dDFyMGY4VXQ4aUNtV2ZIOU9EamtwWWdPOThLeU03K09JeEUzOElpZUt3NUlL?=
 =?utf-8?B?ZE5TZUNqanBydjJwOURKRGNnUWhCUWoyRDFWVkZSQVAwTE9pYmlOMGo5eVF1?=
 =?utf-8?B?L20wTzZUVElpZ1lxSXQremhzelVzMDgyLzFNeVFMMGVBaCt5QXluQzJBa2xl?=
 =?utf-8?B?YWg3aW93MGdZeEgxTzJ0My8yMTh4Uy9wOWdvcUp4U290VlBJMmVMSDBaa1hU?=
 =?utf-8?B?akp5YXcyeEw1K1hDS3VyNE1mc3lQeU1LekRycjFYNXA3empKWjhiZ0t0RWhM?=
 =?utf-8?B?YkVER3RyWmNqck5ycWJJcE5ka09qM1dMQVBnS0RsWDZTanJUZjkwRXE3ZFgr?=
 =?utf-8?B?RjU4NWhPeG9lUjNVT09mV3preS9XcFVUYmFVT3E4ZU5mVGdPQkpCN2NDUlFr?=
 =?utf-8?B?aHNtbXpjR3QzeFNwbHp1R2ZwZE5EYml6eHFWR0xKaXBMdFdWemxjTThWejRV?=
 =?utf-8?B?ZXprUE9zSUhNc1hNT1pKeWowbEpaK1ZwY3U5OUVvdWFBQWtxOTl2Tk1KNnpl?=
 =?utf-8?B?Q0tVdzA4UWpDWmszNjB0cWdpajlTWndVeUpTUHRLWUZZM08zb3RDZUQrNmFo?=
 =?utf-8?B?QmNMZHl0Vk8ra1ZheVlBVjBkU1U3c2Y5cUQ1NHpxVk0zUy9tWERGVGhPVE5G?=
 =?utf-8?B?MExBTVRWejl3YldpUTl1T0NzWjBDamhKWUM0TlBWWkYzaDRSZ1MySHJ0Qm5Q?=
 =?utf-8?B?NVJLSU8zOTBCNVpOdUFBVnB0aDBDOU45L1NwRDZUZWdNeXZNekNwUkFLL0ZR?=
 =?utf-8?B?ZE1IOGVwWERsQTNEQnVENkQrRElReVphQ3FrOXFzOVI5T3V2b0lVSVV3K2Qx?=
 =?utf-8?B?SUpTZVd6WmVmaHByQllQYi9XQmd5UDZEdjMrSWJ4aTIrQ0xQcVA1bndWRm1M?=
 =?utf-8?B?L0E4NVZWaitEYUxvdkwzT21mbkp5bDZDUW9VS21aT3pxUnlWWVRrTjFHTHhH?=
 =?utf-8?Q?4ILW2iUQDX/4wDboP7dEA17zi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f29d2cbe-20bc-42ea-1cab-08dd7649d468
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 03:02:42.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ30Mr0AR+xlGkOrhCETlytQo6p+/twMUQMersQji6SI3mkiDQS8oEnf5TlInzEh/VderOLBexQxFCNmlYJhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyNeW5tDTmnIgz5pelIDExOjIzDQo+IFRvOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxp
QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7
DQo+IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0K
PiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMu
bGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjMgMy82XSBQQ0k6IGlteDY6IFdvcmthcm91bmQgaS5NWDk1IFBDSWUgbWF5IG5v
dCBleGl0DQo+IEwyMyByZWFkeQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxp
bmFyby5vcmc+DQo+ID4gU2VudDogMjAyNeW5tDTmnIgy5pelIDIzOjE4DQo+ID4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gQ2M6IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gPiBscGllcmFsaXNpQGtlcm5l
bC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiA+IGJoZWxnYWFzQGdvb2ds
ZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4g
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBp
bXhAbGlzdHMubGludXguZGV2Ow0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNl0gUENJOiBpbXg2OiBXb3JrYXJvdW5kIGkuTVg5
NSBQQ0llIG1heSBub3QNCj4gPiBleGl0IEwyMyByZWFkeQ0KPiA+DQo+ID4gT24gV2VkLCBBcHIg
MDIsIDIwMjUgYXQgMDc6NTk6MjZBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+ID4gPiBTZW50
OiAyMDI15bm0NOaciDLml6UgMTU6MDgNCj4gPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+ID4gPiA+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiA+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsg
a3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gPiA+IGJoZWxnYWFzQGdvb2dsZS5j
b207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiA+
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+ID4gPiBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+ID4gPiA+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29y
a2Fyb3VuZCBpLk1YOTUgUENJZSBtYXkNCj4gPiA+ID4gbm90IGV4aXQgTDIzIHJlYWR5DQo+ID4g
PiA+DQo+ID4gPiA+IE9uIEZyaSwgTWFyIDI4LCAyMDI1IGF0IDExOjAyOjEwQU0gKzA4MDAsIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiA+IEVSUjA1MTYyNDogVGhlIENvbnRyb2xsZXIgV2l0
aG91dCBWYXV4IENhbm5vdCBFeGl0IEwyMyBSZWFkeQ0KPiA+ID4gPiA+IFRocm91Z2ggQmVhY29u
IG9yIFBFUlNUIyBEZS1hc3NlcnRpb24NCj4gPiA+ID4NCj4gPiA+ID4gSXMgaXQgcG9zc2libGUg
dG8gc2hhcmUgdGhlIGxpbmsgdG8gdGhlIGVycmF0dW0/DQo+ID4gPiA+DQo+ID4gPiBTb3JyeSwg
dGhlIGVycmF0dW0gZG9jdW1lbnQgaXNuJ3QgcmVhZHkgdG8gYmUgcHVibGlzaGVkIHlldC4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFdoZW4gdGhlIGF1eGlsaWFyeSBwb3dlciBpcyBub3QgYXZhaWxh
YmxlLCB0aGUgY29udHJvbGxlciBjYW5ub3QNCj4gPiA+ID4gPiBleGl0IGZyb20NCj4gPiA+ID4g
PiBMMjMgUmVhZHkgd2l0aCBiZWFjb24gb3IgUEVSU1QjIGRlLWFzc2VydGlvbiB3aGVuIG1haW4g
cG93ZXIgaXMNCj4gPiA+ID4gPiBub3QgcmVtb3ZlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoZSBwcmVzZW5jZSBvZiBWYXV4IGFmZmVjdHMg
dGhlIGNvbnRyb2xsZXIuDQo+ID4gPiA+IFNhbWUgZ29lcyBmb3IgUEVSU1QjIGRlYXNzZXJ0aW9u
LiBIb3cgZG9lcyB0aGF0IHJlbGF0ZSB0byBWYXV4PyBJcw0KPiA+ID4gPiB0aGlzIGVycmF0dW0g
Zm9yIGEgc3BlY2lmaWMgZW5kcG9pbnQgYmVoYXZpb3I/DQo+ID4gPiBJTUhPIEkgZG9uJ3Qga25v
dyB0aGUgZXhhY3QgZGV0YWlscyBvZiB0aGUgcG93ZXIgc3VwcGxpZXMgaW4gdGhpcyBJUCBkZXNp
Z24uDQo+ID4gPiBSZWZlciB0byBteSBndWVzcyAsIG1heWJlIHRoZSBiZWFjb24gZGV0ZWN0IG9y
IHdha2UtdXAgbG9naWMgaW4NCj4gPiA+IGRlc2lnbnMgaXMgIHJlbGllZCBvbiB0aGUgc3RhdHVz
IG9mIFNZU19BVVhfUFdSX0RFVCBzaWduYWxzIGluIHRoaXMgY2FzZS4NCj4gPg0KPiA+IENhbiB5
b3UgcGxlYXNlIHRyeSB0byBnZXQgbW9yZSBkZXRhaWxzPyBJIGNvdWxkbid0IHVuZGVyc3RhbmQg
dGhlIGVycmF0YS4NCj4gPg0KPiBTdXJlLiBXaWxsIGNvbnRhY3QgZGVzaWduZXIgYW5kIHRyeSB0
byBnZXQgbW9yZSBkZXRhaWxzLg0KSGkgTWFuaToNCkdldCBzb21lIGluZm9ybWF0aW9uIGZyb20g
ZGVzaWducywgdGhlIGludGVybmFsIGRlc2lnbiBsb2dpYyBpcyByZWxpZWQgb24gdGhlDQogc3Rh
dHVzIG9mIFNZU19BVVhfUFdSX0RFVCBzaWduYWwgdG8gaGFuZGxlIHRoZSBsb3cgcG93ZXIgc3R1
ZmYuDQpTbywgdGhlIFNZU19BVVhfUFdSX0RFVCBpcyByZXF1aXJlZCB0byBiZSAxYicxIGluIHRo
ZSBTVyB3b3JrYXJvdW5kLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEJl
c3QgUmVnYXJkcw0KPiBSaWNoYXJkIFpodQ0KPiA+IC0gTWFuaQ0KPiA+DQo+ID4gLS0NCj4gPiDg
rq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

