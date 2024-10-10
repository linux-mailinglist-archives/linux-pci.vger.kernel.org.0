Return-Path: <linux-pci+bounces-14119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF7997A74
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00BA2811D8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F03E479;
	Thu, 10 Oct 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q4G9veOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013037.outbound.protection.outlook.com [52.101.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854F2BAE3;
	Thu, 10 Oct 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526496; cv=fail; b=HHcnY2Kk5LYcnUP8vrXgDHaZV+wUJ7tr0pL6/0PLlXhefSHqzFR4xSh+pNj3jPYcU8prhtXx0C/1xhyz6mLCthqe5prjtSCRffH3I6CP37XrTtRS6NBuIOzxyxnlJgoXRPY1W3ZLW2wAtseZNH8ovg4zq+y4Lc5oxfeajPX37jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526496; c=relaxed/simple;
	bh=sZZ1yAMoklQlKYeaD/1nVDnp0/lLFPtnQVMzFmu5uqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dE0Rd67B6SPBQoxM5VmOxD5mt4oU7JxL3cd5Mg+tq5ogOlmFi0AiLPt+M7uoYgejRCeVexYCM0MoG2QwvBNT27uPHfUE7krUDM8iGsxB2ibGsGNu8qlyXINW6F3XX/MNxq7WSuqfegSIlyrCg3BwY+uohsK+bPy10HdviYLhukk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q4G9veOs; arc=fail smtp.client-ip=52.101.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxGzSkJqNvuXN1sZ+cw+rE4m9d/JHBm3qqJQqki3boDQX2emyJ8HoauyTB1Wi3XrNFp7xdrSGnB3WcW1oiXLI8ck++uxxeUWgns1/irNXvyHMuwleeKOhLlhZ3zVF/e2Hx0Wivl12XbABJEyq4xACjyH/XiDe2vpysZ3wmw5jMQOmqpJe6BCO3edwvNbHGZavdPjKWKy2+HxvycSC1grzTfD640N+96qGjLbLcR94g3d65m2NdjysW492K/awgM8wc3cyOdbHaU6Ljp+pKDQMrrRns+rbiGdwp3Cos2DWPqcYuQH+UnHt43eJBUl3hIzcqg9tFd3I9EIz8CVVqXTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZZ1yAMoklQlKYeaD/1nVDnp0/lLFPtnQVMzFmu5uqM=;
 b=vc0LxbE/5Ww6zPTo4CkCWUEetrdHutmbXn6l0CDE+neBAZzfh+AWyeRm0OpJhLQrMxzE6AOLawRv6B+UPbagNtKPLHdyFFdsFoqTM47jmZkGenxu9sZhmSMmJ//tueOL8LCUx+EvNohhPPTktbUx2YtFd5wWOPs9V561vq222Z6kLhl07TQSxBdK1p7/z0f6VrzgN2++RkQ4jZr3KPaez1UtFqdlByo7RbgcAmdSvlvV+rMFM4O1PJwNe2FqO+6EtjHSoPKilqnreOu8VDxhj4l9kJoL2G/cAa+M5fraXbBXqKSKLaiRE/NTMn7cREb9MmcdJtfwQPl1ztSscgCfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZZ1yAMoklQlKYeaD/1nVDnp0/lLFPtnQVMzFmu5uqM=;
 b=Q4G9veOsPFdEL7ybNUixee7lK1XMsOR5qeT/SOXfBTt11OSMzIL3XpnOyywj+r53HSI5mFOEH5S7Fzm4ZcSF7gfXBLIx2xZ1yW8A8T0xargVklZ5MrLc+j0SAOuaaq++Tu6glM1JfkIpBmiiSjsE0+lgIeRsbOCKGUuaG4xUScT3Nbp0Ez9+ZcFVhCjNB4jmD4GRsm4W+fjJ+XyFXWlLENNK6P8mprhYMDePIaWo9JLNbGXPCvlbOd8ZN0zrQbgVDZ5KqDzMCXkurIORIaJKCER4exPs7XQ1zLQsKpFtG1GdanyLkvqd7cMBo20I3cu0RABfUGdnxeALO6np3MnxTQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 02:14:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 02:14:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Thread-Topic: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbGjLp/l9Es9i+jUim/i4c8s01WLJ+nI6AgABJhACAAFjFMA==
Date: Thu, 10 Oct 2024 02:14:50 +0000
Message-ID:
 <PAXPR04MB8510E8B2938E88DB022648F588782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
 <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
 <20241009205304.GA615678-robh@kernel.org>
In-Reply-To: <20241009205304.GA615678-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB7062:EE_
x-ms-office365-filtering-correlation-id: 388e4fa8-70fb-49b9-3fb8-08dce8d15274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dkNraFZJamVlcmRvaVkxLzlLb1g5czEzL0V0Q25rVktaenowZURoWldid09R?=
 =?gb2312?B?NnBSOXVFU21GT0F1T1Q1clpjRlhBYTE4eFIya0lhNndHdHgzd1RRdVk1MHNP?=
 =?gb2312?B?VU92SDdDcEovWDlsSHh1R2daNVdrRExCVll6Q2tiemNPZWo5ZHBrWXZkWUJB?=
 =?gb2312?B?Ui9QeE9GenlTU1hpUnE2bVNwQlZpMGxjR3RvdGluK3JpZnF4UkNtUjkrRWpz?=
 =?gb2312?B?MnNQNUFueHVHZkJydFIxSnB3UXZtZmVsdGlWcHBPcU9lNEd3aEgvNnhzRHBp?=
 =?gb2312?B?WHlldWRUYWVrblE0NmE2SjJkVEV2RThzWUFpbGNkTFg0T2RvMVFzK3VxM2xX?=
 =?gb2312?B?NWpsOWdhell1eEpMVGVPbGNKNFZCQzVlRXpGbjUrY3ovaUlqNTVoR2k2alg4?=
 =?gb2312?B?VkNmNU5ZK3VSYmU4SDI2eVRydnM0SUk4dm4xamdkL0F0bDJFZnVWQUQyS0Ex?=
 =?gb2312?B?MUZJcERPNXVrOHExbTJkOVRZYXBBMzRwUkdESDNCWFhXc1J3ZHRNbjRmby8x?=
 =?gb2312?B?WEFjNGlXVVFCN0kyMHRwYnhid3dmWmFsZjREUDMxWXZsUjNXUjZkbnZvRGxY?=
 =?gb2312?B?ak9vSlpaZ2pQa0x5bFRmS250N1IxK3pxekR5Z2pxUGN2TGNjK2RSdjFHb3ps?=
 =?gb2312?B?d1ZuWWNzVGlXazlwOWZMbVhKSTYyNTcxYko4elFGNGFmbnNGVEtSbzlVbEo4?=
 =?gb2312?B?cWdtSlMvTitDcEYyZjZHdVdNWDhvYXRPR1djZnhsMGxjckhKUEpjdXNSV1Jt?=
 =?gb2312?B?MXVpZk5PMTNCY1BVTVR2TkxMaDJ5VUhNc3NXWnNPa3M3ckxua0ZHSVRPSllE?=
 =?gb2312?B?MWgyTzRlWmorL3lFVXJtUGM1VnY0MFhvRDY4eXduK2xkdWhzZTBWYTNuWUdx?=
 =?gb2312?B?ZzRxTWJlVGZvNGxWVmRuRlcxTGZHWDV1dklOZnNPWjZiM0t3WDY0anB0MzBa?=
 =?gb2312?B?UEwzaHloOUo5bmN6RUwrT0tkdjBuSDQ4eTVzVmFORXJtMjkzWEJYWFp3ZjB5?=
 =?gb2312?B?c1M1dEI4aGN3ekVkSkUvUGhlZGM4ZkxXYkR1TVRkZVJCMi9Gakoya2MyUUFK?=
 =?gb2312?B?NmgyVjN3RjlUSStQZzNaQ2p5R21EdW4ycXhSR2VvZ0U3TlA3R282MW1ZWGRD?=
 =?gb2312?B?STN3UWl0NDJjayt3QWc1a3UyQXRDQ1N2bWpSRE95WS9YaWc4TlFlWlhTWkRB?=
 =?gb2312?B?d1RFalE1cld0MjNGenlXZVN0VFFWV1YzMFQzdVdyWVFLcWU3OVBmcHR2cHh6?=
 =?gb2312?B?QzZUOXhDKzlxQ2VsNklBdktIVytUUUROK1BINktuOTVoVldHS3o2dXMzMEti?=
 =?gb2312?B?eGVyU3d4ZnhidWwvcnFLRmJUckRPby9EakhGVFlNM0hUeC94LzN4ZXlGcnRT?=
 =?gb2312?B?YlB5QnZsaGpEYmdYd1gzeUV4WGc5TVVIaXMwb1hSbm1PdWJ0WnE5bUNQZ2RX?=
 =?gb2312?B?NkNiYWFLSFN3VmdKUXg0S3l3b3JaRDVOY0plVkczbmYrWm4zbkhHYjEraDlU?=
 =?gb2312?B?alBScUlqNVlzMmJtcXIxK3hhbGtWUHpsYUJicnEwVTV0TUdvV1k3V1U5amkz?=
 =?gb2312?B?aVV1bUF0bHUzZkI2UjBVdnZHaWZvT0ZrODh2RU5iK0xZdFNUdlFGaUd5R0R1?=
 =?gb2312?B?WCtYM3ZyS2RUblhzWXZVd05IYjNaaHcyb1AyRC94ZzAwbDBKTzhPQVUwZEt3?=
 =?gb2312?B?cjI4SlZKbjN0UTJXdW0zREpIMUFLTGFVSnRqL01XYjc2M2lmNndXR3czTk1j?=
 =?gb2312?B?QmlTeTU5Y1ZkeFZKeWx5ZFdnN1VoMk1QdFIwbFBWcnMyMzJUb1pVQ01sRVlB?=
 =?gb2312?B?OXQ4c3lmd0c0T0doN0FNdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T0lVbVZXeWVCanZlRjJ4K3hSN0JROHZIQk56bzBUZHAyVklKZGtrTnZ3dE9X?=
 =?gb2312?B?cmZqZnZwTSt2a1ZkbndnaTJGQW41WDBpa1ozVk5DN28ydU5jNmd3R2NobnRt?=
 =?gb2312?B?WFJsMFI0NVMxdElDSythWExnMFFGWEdLQndkTXIzZ3Q4dUFDb0tzSlVpaXV5?=
 =?gb2312?B?US9wV2F0aDFYTjcrRGV1MFVZT1A2OGNuNHVpb2IyZlZpbXFwdjhxRXdBd2Yw?=
 =?gb2312?B?d1YxaXVQNjQ2TWl1R1BRaWkwZlU2K05NWlh6T0IxOE5IdU9RWnY5ckdLZzd5?=
 =?gb2312?B?Zk5DNW9SZmVYVVR1YUZTNFNhVlJRcWZZaHA2TGdEc0pOWSs0a3U2MWFjb284?=
 =?gb2312?B?SllWZXdyUm5VSHpnS2szNE9xaDBNZHZvYzdOSWxiQXpkSUp0N1N2Nk5Rb0tG?=
 =?gb2312?B?dC9UT0Q3S2ZaWmJ5aE0xSWZyeG92WUxRRDk4RlAxZDV4RmNlZWZsOWswaTJZ?=
 =?gb2312?B?VGd1WE84N041dFdKejJtTXhvVTAwYy9FODFadVBteVlmTzNjVDBtb2srRURY?=
 =?gb2312?B?SHA5QnM3MmpIMFRPZXNGVFJVQi9YeG5UYzY4TFMxSkdlVnJ2RzRtcUdmNC9F?=
 =?gb2312?B?L0IrTWFpTlFpSFhJNXZmSzhxMm9QdzZ6VjdmQUhDNWxEYlg0ODBYSWI2cFJj?=
 =?gb2312?B?ak1kc3F4WFhPTkxIM0FCdXN4V1NkbUI5SEFkTEdiSXR3di95TVF0RWFQUEQ2?=
 =?gb2312?B?S0p4SlZiVmhQZytmU2hlK2x0S1pabERmc0FNZW0xMTJWVjAyUVVBR2drNlhk?=
 =?gb2312?B?N3lSblkvSjlPbE5DRFBNeEZtOWhCUUdxL0RWa1JHK1B4Q3ZmVzcwSS9ib1RE?=
 =?gb2312?B?RlBPTFJSNjFRTHIrU0V1NVVPOXRQYk9HSFVJelNFU3JzMGZsNmJCSVZ3Smtu?=
 =?gb2312?B?dFJ2U0hGRTgvNXJzNVRVS3dqcVRiVGc3eTFUNzRmc2RZenZ0Z1oxRkVUcGRD?=
 =?gb2312?B?cXdPaTlyMWRzZ0NGTkwyb01yZjNMQXFQTnovSTh3OWZpY0RITDc2RjltRkQ0?=
 =?gb2312?B?M0RHS0xhZ3Nnb0VrdkU5R08xQ01IdUlJS3JFejdpY2Y3MnpaQlBVSS9KRGVh?=
 =?gb2312?B?SldwbTlhQXE0ME1JaEhmUWo4VkxnU2NTeTNkeWJMcDhqSG12UUNpZDYxemJs?=
 =?gb2312?B?OXBPOThVMjlUbTlSZFNVSlkzYzQ1bUtxZmRzRHhrRG9zb1VGWXJ4S0oxSzBt?=
 =?gb2312?B?UitjU1Y4YUZzYjRUeXRhVFZ3cXBXSHFDZGlzY2dSWVIrRHVIQ0dBNlBhdWpF?=
 =?gb2312?B?ZmNJSDdmdEZRbWtRbGZiMm9CZGg2NXZ0RGJEYTBiT3hJMk9VM3hsSHVLN3dQ?=
 =?gb2312?B?SGRrMUZvY0xha3ZUOVB4NnF4YWpjZWJtRVdkWEMvSzlXc2xWaEVGTjkzaVB3?=
 =?gb2312?B?cUJ4OGRya1BCNWs1TzZqOXA1QXNJUUNxUkUyUWNaMjJVc1hWdlpPemk2Z1Na?=
 =?gb2312?B?R0ZoYjJHQkVVNDlPdmFJdFNlY0ZlWXdhZlZBU2hQUEN3ZGg1anJVWHBmMGN3?=
 =?gb2312?B?TlpsOVNRcjZwendFMjAzWlAwdHNIZm5tUUZqMzduSzc5TDVzYytlSEorN3JF?=
 =?gb2312?B?UytWek9uMnBtYS9uczZsL1JqR2l0RFZOWC91NUpMdjk1c0N5UExaT0c2Y0RX?=
 =?gb2312?B?YjhvOFU0eXhkenNFOEFXeEt6eURWZ0NaN215a1BacWVlSDZsUjc1YnBkWWtI?=
 =?gb2312?B?U2ZXcFlrM1pHQzNxYllKVTNUZC9CM2x5ZE1EOUhKMWpydTU3T1R5c0ppYnF4?=
 =?gb2312?B?c2lzSldnbUxFUkVsQmJvQTk4bldXZ3IyU3lXQUhXU2NJY1l4N2V3MzU1RkJR?=
 =?gb2312?B?dFE1ekh3NnlINFBmN1pBekdicnluR1p3akNnNmRLOHE2UGV0MWhJeU1YenZh?=
 =?gb2312?B?RThPalFFZTROeWNhdDFFTzVvUUJRalQ3NUUzb1RHUjB5dE5tN3hRQWlpMVBB?=
 =?gb2312?B?RXdyVGMwTEV3RXJjMXhiVlBRR2hTUSswTkNrdkhFeE50dmpia3NXb2tKTWxw?=
 =?gb2312?B?RzZhUjZZM2U5cjVGTi82TTdEcENhS3BwcmVGSGcvMUd6WGE5bllYcFlkMExE?=
 =?gb2312?B?UjdyRnFTY1NOWnhQN0FZNy9jSjZKZ3NnZnd6M3dtUjl3WENjOWw5N3ErSE05?=
 =?gb2312?Q?tKlA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388e4fa8-70fb-49b9-3fb8-08dce8d15274
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 02:14:50.8360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD6xkjsrgfGohrEwjjqfJntWw88SymoORf3nWvuY1nYdX+UgoJN3AFfKAJbfsx3pGW3EEGDy/fLaSSxH8XjPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMNTCMTDI1SA0OjUzDQo+IFRvOiBGcmFuayBMaSA8
ZnJhbmsubGlAbnhwLmNvbT4NCj4gQ2M6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
OyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJu
ZWwub3JnOyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xh
dWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBDbGFyaw0KPiBXYW5nIDx4aWFv
bmluZy53YW5nQG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7DQo+IGxpbnV4
QGFybWxpbnV4Lm9yZy51azsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRl
djsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAwMi8xMV0gZHQtYmluZGluZ3M6IG5l
dDogYWRkIGkuTVg5NSBFTkVUQyBzdXBwb3J0DQo+IA0KPiBPbiBXZWQsIE9jdCAwOSwgMjAyNCBh
dCAxMjoyOTo1N1BNIC0wNDAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiBPbiBXZWQsIE9jdCAwOSwg
MjAyNCBhdCAwNTo1MTowN1BNICswODAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IFRoZSBFTkVU
QyBvZiBpLk1YOTUgaGFzIGJlZW4gdXBncmFkZWQgdG8gcmV2aXNpb24gNC4xLCBhbmQgdGhlIHZl
bmRvcg0KPiA+ID4gSUQgYW5kIGRldmljZSBJRCBoYXZlIGFsc28gY2hhbmdlZCwgc28gYWRkIHRo
ZSBuZXcgY29tcGF0aWJsZSBzdHJpbmdzDQo+ID4gPiBmb3IgaS5NWDk1IEVORVRDLiBJbiBhZGRp
dGlvbiwgaS5NWDk1IHN1cHBvcnRzIGNvbmZpZ3VyYXRpb24gb2YgUkdNSUkNCj4gPiA+IG9yIFJN
SUkgcmVmZXJlbmNlIGNsb2NrLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sICAgIHwgMjMgKysrKysrKysrKysrKysrLS0tLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2ZzbCxlbmV0Yy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9mc2wsZW5ldGMueWFtbA0KPiA+ID4gaW5kZXggZTE1MmM5Mzk5OGZlLi4xYTY2ODViYjcy
MzAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2ZzbCxlbmV0Yy55YW1sDQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sDQo+ID4gPiBAQCAtMjAsMTQgKzIwLDI5IEBAIG1h
aW50YWluZXJzOg0KPiA+ID4NCj4gPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgY29tcGF0aWJs
ZToNCj4gPiA+IC0gICAgaXRlbXM6DQo+ID4gPiAtICAgICAgLSBlbnVtOg0KPiA+ID4gLSAgICAg
ICAgICAtIHBjaTE5NTcsZTEwMA0KPiA+ID4gLSAgICAgIC0gY29uc3Q6IGZzbCxlbmV0Yw0KPiA+
ID4gKyAgICBvbmVPZjoNCj4gPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ID4gKyAgICAgICAgICAt
IGVudW06DQo+ID4gPiArICAgICAgICAgICAgICAtIHBjaTE5NTcsZTEwMA0KPiA+ID4gKyAgICAg
ICAgICAtIGNvbnN0OiBmc2wsZW5ldGMNCj4gPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ID4gKyAg
ICAgICAgICAtIGNvbnN0OiBwY2kxMTMxLGUxMDENCj4gPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+
ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gPiArICAgICAgICAgICAgICAtIG54cCxpbXg5NS1l
bmV0Yw0KPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiBwY2kxMTMxLGUxMDENCj4gPg0KPiA+ICAg
ICBvbmVPZjoNCj4gPiAgICAgICAtIGl0ZW1zOg0KPiA+ICAgICAgICAgICAtIGVudW06DQo+ID4g
ICAgICAgICAgICAgICAtIHBjaTE5NTcsZTEwMA0KPiA+ICAgICAgICAgICAtIGNvbnN0OiBmc2ws
ZW5ldGMNCj4gPiAgICAgICAtIGl0ZW1zOg0KPiA+ICAgICAgICAgICAtIGNvbnN0OiBwY2kxMTMx
LGUxMDENCj4gPiAgICAgICAgICAgLSBlbnVtOg0KPiA+ICAgICAgICAgICAgICAgLSBueHAsaW14
OTUtZW5ldGMNCj4gDQo+IGNvbnN0Lg0KPiANCj4gT3IgbWF5YmUganVzdCBkcm9wIGl0LiBIb3Bl
ZnVsbHkgdGhlIFBDSSBJRCBjaGFuZ2VzIHdpdGggZWFjaCBjaGlwLiBJZg0KPiBub3QsIHdlIGtp
bmQgb2YgaGF2ZSB0aGUgY29tcGF0aWJsZXMgYmFja3dhcmRzLg0KDQpJIGFtIHByZXR0eSBzdXJl
IHRoYXQgdGhlIGRldmljZSBJRCB3aWxsIG5vdCBjaGFuZ2UgaW4gbGF0ZXIgY2hpcHMgdW5sZXNz
DQp0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgRU5FVEMgaXMgZGlmZmVyZW50Lg0KPiANCj4gPiAg
ICAgICAgICAgbWluSXRlbXM6IDENCj4gDQo+IFRoZW4gd2h5IGhhdmUgdGhlIGZhbGxiYWNrPw0K

