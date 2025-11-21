Return-Path: <linux-pci+bounces-41845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25AC775A9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 06:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CB003600C0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD322FDE6;
	Fri, 21 Nov 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RcRQ30T3"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5E2D7DC7;
	Fri, 21 Nov 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702525; cv=fail; b=rK/2CPZuxyIjuzIUg8UMWA/b5GXhLFp9rudVTJczs9/WcMtFq63MCYukxubCaykCv5exfVVceI7ysrcy4ySe5fWB6zuWmQEIbUOOt/DJnRH/YwSHdteLJe3wQV3CGow8ZK+/gn0keNeDIJT5YSeqUGuXKL4mYlPv5eBlwD2pNgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702525; c=relaxed/simple;
	bh=bq+XFYI6q7SVX6A5AruLx05G1a5Er0ozQ1DPP2iQDoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbSjRd48FJVhLfy012M3YVq4E15Kf2bg4jeEfSQ0tb+aztsmhUOCj0F+sEAOW8t6lPWqWLHHjqdrptBIFPbaZxJH0Ofj42BHhV8JqT6sfNT92ZAVQiT1UWc1spl/diW9bKavw7woUn6z/AmzZoHvwv0S7Rfsx6Hab2XwZJ8Oc64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RcRQ30T3; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQpX2T8iBin2GCb8Bk6xBVHrp7fBuf/AT1hwjfeOk2DDrqg3ZfvT8WCa9sSN9z9wjc6gDORCYfBpGP5Z1w4wh0NyzoAFsdPQEzz+54NcTgrMfL98YdcNUIvW7zPUtWU3r5pX5YGI2bB1ZaIIgbi6Np6sAbid7M90kHo36/mpwdF65J3X9OaRGtG4FcSYrZCX2WYSGpIZMuv2LCegcMrt6LgEgAxJ6dZBOClEUQvTPlyVnB1rVsDMt8y7fwuQmRnOvJH9f3wppG7YXvGVTktpc/NieoROrIotdFced5dPJRgROm2Vrd5hlYlLEwSX/B0ssrIM8R7JQrE0L8jzJIBpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+XFYI6q7SVX6A5AruLx05G1a5Er0ozQ1DPP2iQDoM=;
 b=RxQEk5lACS8ZZK4hhCslcHEnuLRwJ9Uha8yecLwrqcCFYzkpK2FLpgd4ah7gxJ8Fvz3OAZaieuHcOGDjIdqhOFD8bE9i+SgcCc253QMQHQjmGxjYG935IM+ji4Yj+qudpJ1Y3Ni7Xyfy0mmVWcbX5SLFzJyQupgwli+1Lq5qkjD8FJ9oH4BJmVgk3ZDOpEVvPZyLPBZ3sJYqGp5GoYlRpPPRkVTlilOp231NZSfP5JrfVAx4kTh1juvLl5PGUVzVGeAjBHOmjx6jpYZxFoGIgNapNL3EkfwZSyF4Wpi/Ca8aGpwnRtgWg1EoW0PTbS65FkpV4TaUOeG7PKiDuc2JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq+XFYI6q7SVX6A5AruLx05G1a5Er0ozQ1DPP2iQDoM=;
 b=RcRQ30T37FHxU5Dr0kKsyZ8lEYWi4Ay3Ldy1SGy/1AY0i8QUZpWGV9Ur1sDqZoHjvln3GJVKppOLDPFsQvwfEcThMMpT6/LD4Fjrp/4/nyHHFeVVZxcVji8t0qikH6Agym4tRQZzltK7qS+rH8KQRqZ7XfrfgOasvIUj/gJghXfVPCc/liGEOsJlnY8NGdgPZ3TLKWPMU12JbN8b/Q37uRy+sdFWLJTG8GsZTdXAUrkKz91WeNr5GKXY7egoLInanMrupIi+UOHIPYRy7qYsKRbuiN2WorON+exWq6esFe57MFeaCPZJ7yhiwIeeJtl5Nx+dcBOhKaVIPj38E2iPWw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:21:58 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 05:21:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin
	<shawn.lin@rock-chips.com>
CC: Frank Li <frank.li@nxp.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"zhangsenchuan@eswincomputing.com" <zhangsenchuan@eswincomputing.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Thread-Topic: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Thread-Index: AQHcWX/Z1gYkRLXMSUaRfofEExV5hbT6wrwAgABJxICAAYvSgA==
Date: Fri, 21 Nov 2025 05:21:58 +0000
Message-ID:
 <AS8PR04MB8833807ECE928024892B73408CD5A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
 <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
 <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
In-Reply-To: <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU4PR04MB10483:EE_
x-ms-office365-filtering-correlation-id: d1347052-3081-4a6a-efd8-08de28bde4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2VVcXBUb3pJeWllS1V6ZTRxRkRycWhnRHg1ZHVQZkVRRkgvVWlYaHZ0bVJy?=
 =?utf-8?B?V05ENittNjh4c0pLT0FlaEZIenJrTURuaWpkT1NkVTE1TnUyb1hjc2NGbFMw?=
 =?utf-8?B?WmxVWkc4VW91cnRibUUyQU5YRVk1ODB5Y0t3QS9KYU40Q1FuVGxSVWVpQzJR?=
 =?utf-8?B?Q0xSNXFVcWtnS1ZGS2JtVHBLKzVDaElOMUQwNXVZTis5SWdrMWs5SnlzMFJx?=
 =?utf-8?B?N3JZS3hHaDJWdUhma1IyU3gxMnBETFFyL1FWMi8xTXFNaVNZK0RDMysrRXhj?=
 =?utf-8?B?ZFV5MkowM2lXbUN3c1FuVXZpc210VWsyQ2JPY2RKMGJ0ZWxCaUJ2dzNOVUND?=
 =?utf-8?B?YmVuQWt1bWRnUjRXU1VMUTJKY2FDeFlSeXhTTzZJMFloZFpEVHFUQTRRSm1t?=
 =?utf-8?B?dFZ3NlB3d3A4enNGbGxYUE93b2xBMnYwbEZ4NUxlNVVCUFVWYXcycEx4NDla?=
 =?utf-8?B?cWUxQ2Y1bVIzSkxnTjVidjFmTkZvOGYzRXI4YlJNKzF4QXh6b2M3SEloaDho?=
 =?utf-8?B?SzducGhCQmNKMEt5YkE1RlhFTGRJd3gwbEtOcG00dFkvSVR6eDFSRDlMYUVi?=
 =?utf-8?B?N1ZoWGRYUlo3T2tnRmZmbGdnZVc4Nk11blRRWCtQaCthODFiaVlXT0pYOGNp?=
 =?utf-8?B?bnQ0MEhUOEdtcFdhenNVeFU0U3UxbTFWeHdtVkt5MUNET0g2RDM3T2NDbjA2?=
 =?utf-8?B?Y1pndzBqeUpMOVo4SFoydThmZ3VBcDlXZ2FoeS9WTHgxWjZVaEgwVUVjdWFQ?=
 =?utf-8?B?YzRkOWYwMnFWY1ZzTTEwL2tvS2hka0J4WTU4UEdBakN0TytTMGtVcnZmYkN6?=
 =?utf-8?B?Ukphc0h1WDgwR252QWxhTVRHSkxoN01odUhJeGVkNVZDeGRDTDJ5U0g0d3NB?=
 =?utf-8?B?azQ2TjR3L25YUVlLZExwYkhLZXdYRkgzdUpPRlgvVE1hSDVubGpJeU5EOERL?=
 =?utf-8?B?UlNxb0ZYY0xSbW9OQmtQaHBPMHpXaG5QQkVlYXVyTW5iWU9KNmkvR1ViWEU5?=
 =?utf-8?B?UkVhRi85ay92eDhsb2NLNTNYallkZ3lucVNjcENaNEZoT284WEkxcDBFZmVq?=
 =?utf-8?B?Z0ZEQzJBZkw4YnkvL2Qvamt0WERwUVNLZ1NMWXhJcW1GT1VSZUd5RktMa3V4?=
 =?utf-8?B?WUJaUVpmbEpkSG5QMUFVUmtSb3J6TmRVWmc3S2VPWFlvNzVhRHg2MjhNNS90?=
 =?utf-8?B?d21hM0Y3eEQ4ZUUxM3NjRnExeURJam93MnB0UVZUeEwwTU1MaTVKQzJrK2Rk?=
 =?utf-8?B?OUNCdnJEWWxYWEFhNVRLRFVIVVlxMUtNYzZmM3FpNzJsWWdoNEJsWlZVRWpB?=
 =?utf-8?B?Ykd2QUJ1c3dhMDZpRE95NUVpVTdJOGF6VDVtbHErdzNHWmFIemhRckppUjlQ?=
 =?utf-8?B?QkZVYjdaRDJqalNzZUtBWTVZcWQwL253R2FTVHNWVThqSTVJYmJKWUJubXRR?=
 =?utf-8?B?MklrWjc2WDRvUlVXbldiSzgzWEVBUWNoNVdrTlhSZmtSSW9tWVBob05rRzl3?=
 =?utf-8?B?V2NLbG11ckJVZzN6ZFl0Rmt6S3VPbERORnJ2cHBJWG16aU9IZWtvRE1OUllQ?=
 =?utf-8?B?S2VvSmFsVlVNQnhsa1FaaTlUVWlxYXRHTkYrL21mK0FRcEk5SXZ0TGlwOEE1?=
 =?utf-8?B?QWVFUVR1dTFMNkFxQlZrN0NYWjlCWjdNMDA1eXlwdUNTN1lkVEIzRXluVDJo?=
 =?utf-8?B?UzlaRmpXeTRURVlDTnpheW1zTk13RnRxZW1LTnhtRzZCL2dXVXZxamlydkI3?=
 =?utf-8?B?SWxsWDM2SWhuaFJmeXd5UTNjeGpEZzAyVGhZRWJGTE1QV3Q0T1hsSVh2RWVr?=
 =?utf-8?B?aVZXYXY2WGlZMWhUU0ZQK0pvUEFURUhFM1JFckk0bHNnaXRzNVhhTXhYaEh4?=
 =?utf-8?B?b3pZNXFXSWxuQVRmakVVbnpuRld2NGZBL2FZYzFObWpDcWVyQVYyQytXK2ln?=
 =?utf-8?Q?BeBXJIMJiPzttU3fBC4eLCTmFwI1JTSI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkhLQkFVd082NllnYmhhRk52b3RyTGsrRkNCcVBnVFhBZEdlUWU0elNJKzEw?=
 =?utf-8?B?VjNmcmc3bVNzK29BSzlwU1hJMCtVU1QrZkk1dXdLMXY4UTFxNks0T1U0L3dD?=
 =?utf-8?B?eUU4Uk1lVUtla2Rid0NtSlU1Zk5rSFp6SnBCYTBFaDl0ZWNRYjBpcG9Mcnkw?=
 =?utf-8?B?cDVvaTg1RmRSTzJYWlAyNHRMb0ZSbS9Wa0pWYVdDZXIzWmQ5SnV2aU1qUy92?=
 =?utf-8?B?RzhnRnFwKzBYdzl1ZDJxRlBZRkh0djUweVB2aHBTRlJLQ1A3UktkcjFKVGxu?=
 =?utf-8?B?OHoxdnlsU3F6TmhNNTlTYXZPZU5oRVM1eU1pdVpDckhLYWxpMnpqMXZyMExi?=
 =?utf-8?B?K3pmM05WaThlRE1mV2JMZzZ1R21vdnc5UTNDRDdPVlExU3lraFBmNFlYaDN6?=
 =?utf-8?B?dlMzS25UcS9EK0RTSXAyRS93czgrOUM4NEZnNW8zRFNnOHRhRC93dE0yMTB4?=
 =?utf-8?B?MGRBajhrVHYxOEphUDIwNmZYb1hHQTgwbXh5QVJtUlBhbzVITmRER1AyL0hT?=
 =?utf-8?B?VXpaOFhxQXlMTXNQOEdNd05pdGtLSSt5SDNYZmVlelpGTnd1S2pyWXNENXZp?=
 =?utf-8?B?Z3JtNWlyd0Jhall2bllqV3dkSVczZWxzRVZRRUFCRFRwNEF2K1RpZnBOYXdE?=
 =?utf-8?B?aEJ4dW1TK0hxMi9IMVZTNnNXbjlrZ2tVT0g0N01sQkl2QW5HVDRnZTNrVzg1?=
 =?utf-8?B?RDE5VC93MEhsRzdhcXZBbXhWbjVZQmpGZEtZdU1ERmNheU1sN3J3UFUyR2s1?=
 =?utf-8?B?d2VOS3dYZlFjVVVWcVJyMWpJQm92NzE5U2tNMVBXMjlXZVR0SjFYV3BLZGlJ?=
 =?utf-8?B?bnFzT0w5TkNVaE5xdStPWHg0bm9kbW42WDE2eWdQdzZsN0s2U2pXTVBXYnFZ?=
 =?utf-8?B?SkVWbE9iam9ZYnZ6SkZOeVFtanZZanQwS1RQalkzWjF4MHdpUVd0SXNrUEUx?=
 =?utf-8?B?a3BNQlQ4YVU5NHdxUS9BU2JMcnBHTEtKeERXWnRjRkFLdTNKOUhJTG5kb3R5?=
 =?utf-8?B?S0FBRlgwcG94RHJTL3oyT3dqcEZIaWtLcURRWTVCMWhXdjJZaWQyZ3pPRFFT?=
 =?utf-8?B?cXh6Umd2SHFFaFE2ZzFRZGNBRXZRV2g3ZSswd3hPK1dPM1E3ZTA0SWRyb1Ix?=
 =?utf-8?B?SHdrNFFjcnV5Qy9uYkcwWnhDbXRmWFB1VTdja2crZFEwVFZhc2hYZkMyRmlT?=
 =?utf-8?B?WlNzSXI2bHA2Tit3amtqWDMzSjRUWjdqd0dBOFA1VFJ0Z2RGZU9sTkd6TXh1?=
 =?utf-8?B?UEJsQklyRjJKdVFrdy9NZUlyUlFDUEFqZ2I2Z0I0WE9RS2lJNkR3cmdlMDZq?=
 =?utf-8?B?NVF4YkxRRUxIZkZCYThxOG9FcTBYL1Z2RWtoNXRyTUlRYlNsY0I4elVoNERp?=
 =?utf-8?B?SEpLYmtoK082UDlmVG5xNzRIY3puOGtnMk9sUGEvcTBJVWxmc1hLK2htRVVH?=
 =?utf-8?B?U1VGY1R2NnJNS2V1dm1DeHpMa1NLRkJYL0pnSXdkbzY0enVOeFVLRi9YVGIx?=
 =?utf-8?B?MFo4ejh3VG54Rml2TU15REg3cjErU09UR3VhR1dONXpuYjNsVUVvUHo2eFcz?=
 =?utf-8?B?TDZYODJ3YklZM214TUdwcEdXWThqU1JmM1dQa3FuY3dtMnAyMHh3Mk5GTldJ?=
 =?utf-8?B?a3FoT3hRTnVnYUZXK2hMT0NqajlPeU9ieHN2NXlzekloaHllODJXemxBSHdy?=
 =?utf-8?B?T2R0cG5iSUd1bGJTaE11Snl1dHdaTEhFQ1U2NW8vTjA5SVhBOXlsazRuUDNH?=
 =?utf-8?B?eWxmYUwwdW8yTy9sTkVnOEZodTBlNWhOYkFuV3lvcUpJaUFobU5qS0pFUDlB?=
 =?utf-8?B?b3BaZk5hN3pQSDEvY3JjQzgxNndvY1daVkNYb0prTWpsZ1czMGdPVEJOeTJB?=
 =?utf-8?B?RFNWeldKZXdnZVh3K0VWWUQ0NUxpTEI0cWNrTUw1T25mbUlKKzNDQ2lyYXdY?=
 =?utf-8?B?Ry9BQTFOS1A0UWw3YVNURlZiTTZSM3pFRnlLYlR4SnFqUUUzM3ZVUXJjbGw5?=
 =?utf-8?B?RVJxT1c5WFUrR3JoZVJFQXZHdVYyOWFHeHpZeXBUblF2a0RsTnR2V2tMcVRQ?=
 =?utf-8?B?Mmo2UzhYelM0VkFpdXNYaTBSSnJYV0tPemZ1em1VeFVPU055bTZTWktiZWEv?=
 =?utf-8?Q?iUgAbLyPEKqjrtoFe/cRXTE1I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1347052-3081-4a6a-efd8-08de28bde4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 05:21:58.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqD77un7IC4q56Isz0wgCW/QEuGfQrCowrTjdfMsqSwBMoKYbtx5gAwoxOws3u73XxQONNG9osfrY/C5xmcb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDEx5pyIMjDml6UgMTM6MzcNCj4g
VG86IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPg0KPiBDYzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsN
Cj4gTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxj
b21tLmNvbT47DQo+IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPjsgTG9yZW56byBQ
aWVyYWxpc2kNCj4gPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47IEtyenlzenRvZiBXaWxjennFhHNr
aSA8a3dpbGN6eW5za2lAa2VybmVsLm9yZz47IFJvYg0KPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsNCj4gbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmc7IHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBQQ0k6IGR3YzogRG8gbm90IHJldHVybiBmYWlsdXJlIGZy
b20NCj4gZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgaWYgbGluayBpcyBpbiBEZXRlY3QvUG9sbCBz
dGF0ZQ0KPiANCj4gKyBSaWNoYXJkLCBGcmFuaw0KPiANCj4gT24gVGh1LCBOb3YgMjAsIDIwMjUg
YXQgMDk6MTM6MjRBTSArMDgwMCwgU2hhd24gTGluIHdyb3RlOg0KPiA+IOWcqCAyMDI1LzExLzIw
IOaYn+acn+WbmyAyOjEwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g5YaZ6YGTOg0KPiA+ID4gZHdf
cGNpZV93YWl0X2Zvcl9saW5rKCkgQVBJIHdhaXRzIGZvciB0aGUgbGluayB0byBiZSB1cCBhbmQg
cmV0dXJucw0KPiA+ID4gZmFpbHVyZSBpZiB0aGUgbGluayBpcyBub3QgdXAgd2l0aGluIHRoZSAx
IHNlY29uZCBpbnRlcnZhbC4gQnV0IGlmDQo+ID4gPiB0aGVyZSB3YXMgbm8gZGV2aWNlIGNvbm5l
Y3RlZCB0byB0aGUgYnVzLCB0aGVuIHRoZSBsaW5rIHVwIGZhaWx1cmUgd291bGQNCj4gYmUgZXhw
ZWN0ZWQuDQo+ID4gPiBJbiB0aGF0IGNhc2UsIHRoZSBjYWxsZXJzIG1pZ2h0IHdhbnQgdG8gc2tp
cCB0aGUgZmFpbHVyZSBpbiBhIGhvcGUNCj4gPiA+IHRoYXQgdGhlIGxpbmsgd2lsbCBiZSB1cCBs
YXRlciB3aGVuIGEgZGV2aWNlIGdldHMgY29ubmVjdGVkLg0KPiA+ID4NCj4gPiA+IE9uZSBvZiB0
aGUgY2FsbGVycywgZHdfcGNpZV9ob3N0X2luaXQoKSBpcyBjdXJyZW50bHkgc2tpcHBpbmcgdGhl
DQo+ID4gPiBmYWlsdXJlIGlycmVzcGVjdGl2ZSBvZiB0aGUgbGluayBzdGF0ZSwgaW4gYW4gYXNz
dW1wdGlvbiB0aGF0IHRoZQ0KPiA+ID4gbGluayBtYXkgY29tZSB1cCBsYXRlci4gQnV0IHRoaXMg
YXNzdW1wdGlvbiBpcyB3cm9uZywgc2luY2UgTFRTU00NCj4gPiA+IHN0YXRlcyBvdGhlciB0aGFu
IERldGVjdCBhbmQgUG9sbCBkdXJpbmcgbGluayB0cmFpbmluZyBwaGFzZSBhcmUNCj4gPiA+IGNv
bnNpZGVyZWQgdG8gYmUgZmF0YWwgYW5kIHRoZSBsaW5rIG5lZWRzIHRvIGJlIHJldHJhaW5lZC4N
Cj4gPiA+DQo+ID4gPiBTbyB0byBhdm9pZCBjYWxsZXJzIG1ha2luZyB3cm9uZyBhc3N1bXB0aW9u
cywgc2tpcCByZXR1cm5pbmcgZmFpbHVyZQ0KPiA+ID4gZnJvbQ0KPiA+ID4gZHdfcGNpZV93YWl0
X2Zvcl9saW5rKCkgaWYgdGhlIGxpbmsgaXMgaW4gRGV0ZWN0IG9yIFBvbGwgc3RhdGUgYWZ0ZXIN
Cj4gPiA+IHRpbWVvdXQgYW5kIGFsc28gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgQVBJ
IGluDQo+IGR3X3BjaWVfaG9zdF9pbml0KCkuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+ID4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5x
dWFsY29tbS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDggKysrKystLS0NCj4gPiA+ICAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgICAgICB8IDggKysrKysrKysNCj4g
PiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+IGluZGV4IDhmZTM0NTRmM2IxMy4uOGM0ODQ1ZmQy
NGFhIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gQEAgLTY3MSw5ICs2NzEsMTEgQEAgaW50IGR3
X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gPiA+ICAgCSAqIElmIHRo
ZXJlIGlzIG5vIExpbmsgVXAgSVJRLCB3ZSBzaG91bGQgbm90IGJ5cGFzcyB0aGUgZGVsYXkNCj4g
PiA+ICAgCSAqIGJlY2F1c2UgdGhhdCB3b3VsZCByZXF1aXJlIHVzZXJzIHRvIG1hbnVhbGx5IHJl
c2NhbiBmb3IgZGV2aWNlcy4NCj4gPiA+ICAgCSAqLw0KPiA+ID4gLQlpZiAoIXBwLT51c2VfbGlu
a3VwX2lycSkNCj4gPiA+IC0JCS8qIElnbm9yZSBlcnJvcnMsIHRoZSBsaW5rIG1heSBjb21lIHVw
IGxhdGVyICovDQo+ID4gPiAtCQlkd19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiA+ICsJ
aWYgKCFwcC0+dXNlX2xpbmt1cF9pcnEpIHsNCj4gPiA+ICsJCXJldCA9IGR3X3BjaWVfd2FpdF9m
b3JfbGluayhwY2kpOw0KPiA+ID4gKwkJaWYgKHJldCkNCj4gPiA+ICsJCQlnb3RvIGVycl9zdG9w
X2xpbms7DQo+ID4gPiArCX0NCj4gPiA+ICAgCXJldCA9IHBjaV9ob3N0X3Byb2JlKGJyaWRnZSk7
DQo+ID4gPiAgIAlpZiAocmV0KQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiBpbmRleCBjNjQ0MjE2OTk1ZjYuLmZlMTNj
NmIxMGNjYiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuYw0KPiA+ID4gQEAgLTY1MSw2ICs2NTEsMTQgQEAgaW50IGR3X3BjaWVf
d2FpdF9mb3JfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ID4gICAJfQ0KPiA+ID4gICAJ
aWYgKHJldHJpZXMgPj0gUENJRV9MSU5LX1dBSVRfTUFYX1JFVFJJRVMpIHsNCj4gPiA+ICsJCS8q
DQo+ID4gPiArCQkgKiBJZiB0aGUgbGluayBpcyBpbiBEZXRlY3Qgb3IgUG9sbCBzdGF0ZSwgaXQg
aW5kaWNhdGVzIHRoYXQgbm8NCj4gPiA+ICsJCSAqIGRldmljZSBpcyBjb25uZWN0ZWQuIFNvIHJl
dHVybiBzdWNjZXNzIHRvIGFsbG93IHRoZSBkZXZpY2UgdG8NCj4gPiA+ICsJCSAqIHNob3cgdXAg
bGF0ZXIuDQo+ID4gPiArCQkgKi8NCj4gPiA+ICsJCWlmIChkd19wY2llX2dldF9sdHNzbShwY2kp
IDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQpDQo+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4N
Cj4gPiBJJ20gYWZyYWlkIHRoaXMgbWlnaHQgbm90IGJlIHRydWUuIElmIHRoZXJlIGlzIG5vIGRl
dmljZXMgY29ubmVjdGVkIG9yDQo+ID4gdGhlIGRldmljZSBjb25uZWN0ZWQgd2l0aG91dCBwb3dl
ciBzdXBwbGllZCwgaXQgbWVhbnMgdGhlcmUgaXMgbm8NCj4gPiBmYXItZW5kIHB1bGwtdXAgdGVy
bWluYXRpb24gcmVzaXN0b3IgZnJvbSBUWCB2aWV3IG9mIFJDLiBUWCBwdWxzZQ0KPiA+IGRldGVj
dGlvbiBzaWduYWwgZnJvbSB0aGUgUkMgc2lkZSB3aWxsIG5vdCB1bmRlcmdvIHZvbHRhZ2UgZGl2
aXNpb24sDQo+ID4gYW5kIGl0cyBMVFNTTSBzdGF0ZSBtYWNoaW5lIHdpbGwgb25seSB0b2dnbGUg
YmV0d2Vlbg0KPiA+IERXX1BDSUVfTFRTU01fREVURUNUX1FVSUVUIGFuZCBEV19QQ0lFX0xUU1NN
X0RFVEVDVF9BQ1QuDQo+ID4NCj4gDQo+IEkgbXVzdCBhZG1pdCB0aGF0IEkganVzdCBpbmhlcml0
ZWQgdGhpcyBjaGVjayBmcm9tIGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpLg0KPiBCdXQgSSBjcm9z
cyBjaGVja2VkIHRoZSBQQ0llIGJhc2Ugc3BlYyBhbmQgaXQgbWVudGlvbnMgY2xlYXJseSB0aGF0
IHRoZQ0KPiBMVFNTTSB3aWxsIGJlIGluIERldGVjdC5RdWlldC9BY3RpdmUgc3RhdGVzIGlmIG5v
IGVuZHBvaW50IGlzIGRldGVjdGVkIGkuZS4sDQo+IHdpdGhpbiB0aGUgMXMgdGltZW91dCwgdGhl
IExUU1NNIHNob3VsZCd2ZSB0cmFuc2l0aW9uZWQgYmFjayB0byB0aGVzZQ0KPiBEZXRlY3Qgc3Rh
dGVzLg0KPiANCj4gSSdtIHdvbmRlcmluZyB3aHkgd2UgYXJlIGNoZWNraW5nIGZvciBQb2xsIGFu
ZCBvdGhlciBzdGF0ZXMgaW4NCj4gZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkuIEkgYmVsaWV2ZSB0
aGUgaW50ZW50aW9uIHdhcyB0byBjaGVjayBmb3IgdGhlDQo+IHByZXNlbmNlIG9mIGFuIGVuZHBv
aW50IG9yIG5vdC4NCj4gDQo+IFJpY2hhcmQsIEZyYW5rLCB0aG91Z2h0cz8NCj4gDQpIaSBNYW5p
Og0KWWVzLCBpdCBpcy4NCkluIG15IGluaXRpYWwgdXBzdHJlYW1pbmcgcGF0Y2hlcywgdGhlIGlu
dGVudGlvbiB0byBjaGVjayB0aGlzIHN0YXRlIGlzIHRvDQogZmlndXJlIG91dCB0aGF0IHRoZXJl
IGlzIGFuIGVuZHBvaW50IGRldmljZSBvciBub3QuDQoNCisJLyogU2tpcCBQTUVfVHVybl9PZmYg
bWVzc2FnZSBpZiB0aGVyZSBpcyBubyBlbmRwb2ludCBjb25uZWN0ZWQgKi8NCisJaWYgKGR3X3Bj
aWVfZ2V0X2x0c3NtKHBjaSkgPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlUKSB7DQoNCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+Cu
teCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

