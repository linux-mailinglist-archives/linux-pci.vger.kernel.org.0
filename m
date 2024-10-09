Return-Path: <linux-pci+bounces-14054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E189965EF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EF6283E65
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5A189B98;
	Wed,  9 Oct 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aX1ouZfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638F1537D7;
	Wed,  9 Oct 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467488; cv=fail; b=gsn2iBI3+uowQux3UmXaC7de8DyRIddgypTnvX3nC7L1xBg2uWLBqJGcsXN+Hk+tzzFr1ZCtGUJwaOipVcp/OZGkg8dS8wyGLK8IjOQSVk75PWtE/qeRJQhnwsQJXM8NRJdoVf1uIUVt1kL+INy9KbKMjpxql2Ie0bY8GsuFT5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467488; c=relaxed/simple;
	bh=LO05Bm4KJraWBECxFUDKTgs0T7JFaxckXi2P1Yo9VIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oPX9tV5yGNb47ODRcYJ9/2U3qOx3mKZDCiNY4E6HgY10kBNrjG9pkaAQkQipUyk3kcpR/bMEcU6cqnv9AJ34YnJU9pplIVx1VHxNXculavKfvuiTA3XxDIPrsUM2IzBMi9387XHBDfexNf0BFm3rk2ld22TlTMASmX5ax8sv6VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aX1ouZfF; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1gQdr/iYrSCfv8aiuxxrMcEkFmIiBRWw+fLdxJFU43frQi0nWaAa/yeN4gkekkWiqH60c3jlynY9Ul1FG56+BrMq4/xd0kbMO0sMDD8zzPs1YxOcgwvS3K1EGAyunz0STJ8TmSjmdIdaomr0VHD5xC6Rndp4TsBsNeicAtNINgnbDpHGGtODkvmtEmIdJ506hTfUkxHpo/mT5UZs+unvhPWAxzvRG3cTrtIoy1XLDeThFvqF4PHV1vMXfXpAcIj68u5jQyFKORkCOpwDdhMYqIEXsw3oYRZEMIo/dbNkJKak+B43v8O2S+bg2jeFdJAMsZnp3NsmqFM2DsU7aoUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO05Bm4KJraWBECxFUDKTgs0T7JFaxckXi2P1Yo9VIg=;
 b=OJsumodTpZUXWFOvkrPzMdtERQ6N+vkMUbP7GzGLYkuwrgLPJsCFPArMCod39fxUpfggjFHD+Ihsx0ezNLdJt+hB8Zk9B7WewlmXvgH4Oji6+L0l/cnnunufG+cHP4gY/1EqAHmrHPaTD4OwMppOba7R0KMfrjomimY62MvPQ0eRi1dAODCr02SLDiLn9A7zuv71uaFBjmG/a2YUSbusPmXVPqfD8O+XbZp/UpxfzMXmN4hIEmW0VKis11jTelFuQFvRgDsXWExCBpZXovkynCSUfMueKfHCt+Cd8cten5JHo47hz/lMeeTfIEOoGxz/fSjol52zm7wFrn4ZmmD0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO05Bm4KJraWBECxFUDKTgs0T7JFaxckXi2P1Yo9VIg=;
 b=aX1ouZfFjWrEnwAAmbboLId+1owGBAKtZBmrWYxHOC2DH1movqru/cs0Min+ejWPjcsmIkipPue1uxQIP5SWjnPf0fkr8gjDlQti+lKlfRmN2ShjtQSxelG7bgs6Fh0Bqb9Pu8RDRyEGbGc6qlhpE+CYU+my4xWoV4rK5ac2o4pDttaPX982wqenau+1RJQbGX+vQrDSiE/4V7EpKJgilOjInYvho/VWnJMuUvvKEOMywKANPw64mKBE7iIBknV/aJeb0WdNL5bNzlk+tUcMnwr1Jn+rHMWGcr9RmaRz2tkqB8XXcHRQbjMXW3DTp8XMO4jBGIa76p3/bzCDb5SHWg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 09:51:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:51:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] PCI: Add NXP NETC vendor ID and device IDs
Thread-Topic: [PATCH] PCI: Add NXP NETC vendor ID and device IDs
Thread-Index: AQHbGi9yKUmqEajJRE+t+gKJMnAT9rJ+LGRA
Date: Wed, 9 Oct 2024 09:51:19 +0000
Message-ID:
 <PAXPR04MB851014FB55F1C52AF3D8BD5A887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009092700.146720-1-wei.fang@nxp.com>
In-Reply-To: <20241009092700.146720-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7280:EE_
x-ms-office365-filtering-correlation-id: 91366a51-ff4c-4da5-c23f-08dce847ecdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?N1IzV3BxZDIyMEphVU56ckhRa3FhOFdTRjgxcUNUc0sycy9RSzFXMjI2NWVI?=
 =?gb2312?B?T2h0bTY2T0UxSDVhMWJCQ2p1KzdUOXZzQ3lEOXhjcHpPcDc4NW5iNDYzNWtG?=
 =?gb2312?B?Z1Bnd1U2VFI4UWo0LzNaaDNHRytmOG1kbGcrVEplZ2wvV1RMeWErOHB2eWo0?=
 =?gb2312?B?Zi9kcVJwVXNFTmhYdWhYRDJNK2ltaVBsTXIzdGs1RDNjRW1mTk9sOURBaU5B?=
 =?gb2312?B?Y0VKRUhTS2NndDJadWNIYWx2cWVEUzdjM2dGWFlTcVFKYkdaWlNiS0FOQU95?=
 =?gb2312?B?YVArSU50aGJjVENHT0dZK2RXeXdsN0hBd1I0MXVXOS9hSWtxYjhORWdJQUkv?=
 =?gb2312?B?SHRXNExrYjJKaHAya0RqbHVPbkJZKzBBbEFEUE9WUER2anpQNDM1cFR1Vnpo?=
 =?gb2312?B?RjlJbUVneGNPS094dEszdlZSVklFYjJZM3JWWHBjdG81WWdadUtqamtaVndM?=
 =?gb2312?B?NXRsa3R2dnd3dWcwSk1wc1JkT2JwWE9xdFZFSVFQbVNTTjU2eFFOMkc1R1Iv?=
 =?gb2312?B?Ulp3a1RLQUNna1NadVpmMzlUd0txSDM1ZmQvK1NmdU5Qc3p1TCtuaXA2VDFn?=
 =?gb2312?B?Nmo3MXFXeENKbHZZU2Q4QjN0KzEramUvcHVVRG9KYlhpcEIzT2tkUFo5dlhy?=
 =?gb2312?B?bG5UL1RSVEROY2tvN3VtUVp5TE9JTFM1MDQ0dlRoOFlvRXdtNTFEcW9taDNZ?=
 =?gb2312?B?US9BeFhpSU1PWVRPTlNIYXFUZnBDYldkOXhxZXJnRmxUNUxWMGpWQ3J4bHVo?=
 =?gb2312?B?YXRCdVBKSEdNUGYxMWxBZmxyTUw3amtiTWZVZjA5cDFPWU14WTlLUnRsRDJV?=
 =?gb2312?B?eVl6bXAyWXU5QzJ2MGRLZTROWmVkTEpkVFN0ZDJCMkUzc2tnaC84WnVpK3Zv?=
 =?gb2312?B?VFQ5enQ2c1pka1cvS3F6N2hHV3ZCL3hzZ2NDUXl6WG5Jd0N0a2VldVVEVmxx?=
 =?gb2312?B?cExFbGRwT2YxTEg0ck5Xb1FlWkJQM01yOWMwRXd1emR3dENoY2NLQThKWjhN?=
 =?gb2312?B?ZmVXaHR5OFVJRnpYWU1QS2dLa1hlMDNqZHBkMVZSRUI3akxuQzRwQUVJbmZK?=
 =?gb2312?B?c1Fub2xaK0Zvb3JIUnBHRmdWV3J3T1k1Tll1YTh2MG1TQTMxb0FBVGZOWWVL?=
 =?gb2312?B?b2lGWTlrd3ZveStMVVlKTVgrRkpuWFJZRE1HSmxWZzNwSXliUjRaUTNQQVVD?=
 =?gb2312?B?eDRxWFR4dlNaaldtMkdCcmkwZzBqTEVTa3U2cGwwZjVWaWZEMnZDWERtQzFO?=
 =?gb2312?B?TVNaUk91R1FPZWx2dTViaXp0S3ZheGJPZXVQSTNGZTE1a3IvYWZ2ZFA5ZXpR?=
 =?gb2312?B?M1ZqZGlIUmV5Tkp6ZHpySE9KK1pqTExZcWNUZDlxMUVOUWhTdDJrQm5lVlgy?=
 =?gb2312?B?Vy8zdnNaaWhiUFZmZERmVGZrZFgydmRxd2pLKy9aODlYcHp4NktDVGhOL2pX?=
 =?gb2312?B?Ym5wMmZ6RG9jSHVQQ0YrWERycUNacmV0WXJEVkJNQ29zampLZm9HWHFyNU9D?=
 =?gb2312?B?djMzNFpoczdudno3ZjZyUmJsUStsUnoyTkJoeVlGVG0yMTl0WEhFVHZuNWtY?=
 =?gb2312?B?bXpIajZpclhtL3BnT2sycW4wSDB6c1k3Q3N4SzByQ2ZjMEM2a3ZwYkdvcTVi?=
 =?gb2312?B?VGYweTBFM29yM2d4TVZwQVJhaEgvc2hOS3hMSVV1N0o0UzYyQ3JaSmRod2Iy?=
 =?gb2312?B?U3BiZHVQY1hkb2dVU3ljOTBNaXV6WkJwekZUVFYrY3dvYlBUd0dxdzlwc201?=
 =?gb2312?B?SG9Fc211RnpZNkdqdzRvV2NOTXptNWNNU1lLQTVnWFVlSkg5WURuWElwWVZO?=
 =?gb2312?B?SjB5WlBEYWkwU0NIOUJRZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WktuTDhlNzNLQVJKRCt0U1gxakpNRDlLQklCcW9GT29NbkZEWjUwOE9MVkZX?=
 =?gb2312?B?NUFVU01WMUl4eHJZUGdHMHFZckxkOHNaclpEb1ZaejdHQ2ZoUGpWamVZUHMw?=
 =?gb2312?B?eTFJcFg2eFY3c3A4R0tHckJQZTB5MVFiTDI3UUJObTBPTzJ1ZWgzZ3dxRFBS?=
 =?gb2312?B?U2oramNOY0RTeDNkRlpSMm1kV2NzalVMSFBna253SXBVckZDV0Q2ckxFbkFH?=
 =?gb2312?B?MjgzQnlNSnRZNmFtWkc3ZDB2THRlWExQUGQ5clM2clJ3VFRZMlBYYm16NFRx?=
 =?gb2312?B?ZXlQTXZ5b2dTTUhvRjVzQm9tS1Nwb3pyb1lHSEZOdUdXaEQvdmVWWG8zdDcz?=
 =?gb2312?B?REdrZDNkUWdMMUJKQXhTUUJ0M1lZZC83cndxTk81Y1pCaEVYTVN6bGk1aENj?=
 =?gb2312?B?MGVvY0RwK1ZvMjVZNVAySUtuZ0lSei9GcmFXQnFxQk5oUVhWNTV1elVqeU9U?=
 =?gb2312?B?b3k0VmJhUENQa2hvR1BPRXNTdmtVQVBVeVRia2pnaW4vT1BCL3paSlhoRlRS?=
 =?gb2312?B?TW8yQi9pSFl4aVR2aVUwTk1lb2krdUdFZUloc040dlY0UEFoK0kwUkk3SFJZ?=
 =?gb2312?B?R0lnMzhCcU91dTRuVUhaS1ZtZXNuSUxlVHVWeHorM2hFU2dhcmpWWXE0YUE1?=
 =?gb2312?B?eEpxbEdVeWtIaWdtTGcvOFlrNG1vbE9WenBGWUhmRFg0ZXlqMzQ1SGQ5OS9V?=
 =?gb2312?B?cldQbVYvNU9RY3RwTmZHdGlzc0JPNkJBQTk4eXBucnVNK2g0SHoydU5sTkJI?=
 =?gb2312?B?Yk1MNmt5UWxiMjd2UEYrSFQ3cTJWRFhpVityUTNBTDMrWElzcG1PODFqemMx?=
 =?gb2312?B?ZklkVGJOOVp0UFdpWDhZTndlMVBMdUEvSWVTRzRObElZMnFETGZNdkw3SDR1?=
 =?gb2312?B?VG9WMzkwTE84YTBqbTdqdzd5NHllOCtxU2Z4NnhYRzUzNHNFRlpOTlFkdHhU?=
 =?gb2312?B?WXRQTGZuN2dJeW1lc2crc0VSa0svV3VLTThtWDZ2Y24wVkt5bXlHQ3ZrZVl3?=
 =?gb2312?B?V09KUU1URE8zVkFXM2YxL0xGZWV6RjdXUWlQRHN2eUJ1bkR6Y3RIQWZ5OGpJ?=
 =?gb2312?B?TGNwRTlnK1hOMUY0czBXZlhiSktqc05lUVlSQzVtNndHK2lVWVBTQ054NGFW?=
 =?gb2312?B?UWxObS9JRXkyeElyYmI5MmpXN3JSUE42NE5Bb0FyQWZEdC9Qa2xkZDhidWFE?=
 =?gb2312?B?SHA0dllYSm5WUVU0bWJDZXBuOVczaTdRL2VyM3VEMnhva21xMWtMM2lNaWVT?=
 =?gb2312?B?dWN5SHNjUGduSlBIUUdOQ3lJRjJPUzNZd2hNSkN3SmU5NEdxa3Juai9FYTJH?=
 =?gb2312?B?NXA0bUs3UUtTNTArWHVMYldFTk15MVNUUjVORklIeXBjMS9mL2l2RDZKQU9P?=
 =?gb2312?B?MSsyK1JibmNiQjZhL0ttNlRXQjFnT3E2amdoT0NNd1haWFlHTlNjSERpWVRV?=
 =?gb2312?B?NjljYStwaGRtYit4T0JXQ3JreUNFN2RobnlRcElib08xanBlMGdIMjA2Qkx6?=
 =?gb2312?B?MGJBaUZjZzdjcWZZd2FMT3hFaUFGSGZaek1IQW1DTFJaNm45NFhENFQ1L2cv?=
 =?gb2312?B?Z2RVOE9md1diTGl0OEhIVE9CY2lqb2ZjNENrTk1tSXljaVRaNEJuc3NaaDVE?=
 =?gb2312?B?bXQ1Q1B3eHNtNEwyYkxzc2h3TDg3WUNaYzdGTlZEUHZJMmp2NUZUYkozVWpD?=
 =?gb2312?B?a0RxeTBSZGEzUjVMRk9maEJYZUVWbWJPWSswdjNReE9KeEZZYzY1WTNaRW1a?=
 =?gb2312?B?K2xuV2FTdHI0MTRRUDRNY0hyN3NRcVNOUUtEWkVjZnBXeUhJcjd0MDhHNGUx?=
 =?gb2312?B?aXl2aE03SGNyNXExdGdYQVdDcS9ja0VCY3cyQ2Z6K09QbkFZMW5hZExmbG0r?=
 =?gb2312?B?eEpaTHRTQ2xXVTBmcm5xWFA1ckxFNklrYlZlQXU0OUVDdXVVdHJVWHhudjd0?=
 =?gb2312?B?R0NOQVdOQWZMdmQrL0RnbzNSMTVOdUQ1THZpeG4wWWo2WWxQUUJMeExmbDRj?=
 =?gb2312?B?bndoZlhWOVBHSUNkWWVBWVV5ZkwzT2Q0azI0Y3NOZDZUUTJWR1hEL2c4UGRl?=
 =?gb2312?B?WnVyVXlGV2RWUUtsT3cvSUs4SWlyOU1NL1o4cG95Q2RLZFhwVTZaRDBNMUZX?=
 =?gb2312?Q?6ts8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91366a51-ff4c-4da5-c23f-08dce847ecdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 09:51:19.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5NecBbLDaZDZK8asPVnFQEynnWh7XBI9U4X/EiOCpApj3g+0AwWApD8EOvqDdq3Jb3OoNXSNikgRlcrrRLmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkgRmFuZw0KPiBTZW50OiAy
MDI0xOoxMNTCOcjVIDE3OjQyDQo+IFRvOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBD
bGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBDbGF1ZGl1IE1hbm9pbA0KPiA8Y2xh
dWRpdS5tYW5vaWxAbnhwLmNvbT47IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogW1BB
VENIXSBQQ0k6IEFkZCBOWFAgTkVUQyB2ZW5kb3IgSUQgYW5kIGRldmljZSBJRHMNCj4gDQo+IE5Y
UCBORVRDIGlzIGEgbXVsdGktZnVuY3Rpb24gUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBF
bmRwb2ludA0KPiAoUkNpRVApIGFuZCBpdCBjb250YWlucyBtdWx0aXBsZSBQQ0llIGZ1bmN0aW9u
cywgc3VjaCBhcyBFTURJTywgUFRQIFRpbWVyLA0KPiBFTkVUQyBQRiBhbmQgVkYuIFRoZXJlZm9y
ZSwgYWRkIHRoZXNlIGRldmljZSBJRHMgdG8gcGNpX2lkcy5oDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3Bj
aV9pZHMuaCB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oIGIvaW5jbHVkZS9saW51
eC9wY2lfaWRzLmggaW5kZXgNCj4gNGNmNmFhZWQ1ZjM1Li5hY2Q3YWU3NzQ5MTMgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGNp
X2lkcy5oDQo+IEBAIC0xNTU2LDYgKzE1NTYsMTMgQEANCj4gICNkZWZpbmUgUENJX0RFVklDRV9J
RF9QSElMSVBTX1NBQTcxNDYJMHg3MTQ2DQo+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfUEhJTElQ
U19TQUE5NzMwCTB4OTczMA0KPiANCj4gKy8qIE5YUCBoYXMgdHdvIHZlbmRvciBJRHMsIHRoZSBv
dGhlciBvbmUgaXMgMHgxOTU3ICovDQo+ICsjZGVmaW5lIFBDSV9WRU5ET1JfSURfTlhQMgkJUENJ
X1ZFTkRPUl9JRF9QSElMSVBTDQo+ICsjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlhQMl9FTkVUQ19Q
RgkweGUxMDENCj4gKyNkZWZpbmUgUENJX0RFVklDRV9JRF9OWFAyX05FVENfRU1ESU8JMHhlZTAw
DQo+ICsjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlhQMl9ORVRDX1RJTUVSCTB4ZWUwMg0KPiArI2Rl
ZmluZSBQQ0lfREVWSUNFX0lEX05YUDJfRU5FVENfVkYJMHhlZjAwDQo+ICsNCj4gICNkZWZpbmUg
UENJX1ZFTkRPUl9JRF9FSUNPTgkJMHgxMTMzDQo+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfRUlD
T05fRElWQTIwCTB4ZTAwMg0KPiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX0VJQ09OX0RJVkEyMF9V
CTB4ZTAwNA0KPiAtLQ0KPiAyLjM0LjENCg0KT2gsIHNvcnJ5LCBJIHNob3VsZCBoYXZlIHNlbnQg
dGhpcyB0b2dldGhlciB3aXRoIHRoZSBORVRDIHJlbGF0ZWQgcGF0Y2hlcw0KaW5zdGVhZCBvZiBz
ZW5kaW5nIHRoaXMgcGF0Y2ggc2VwYXJhdGVseS4NCg0KUGxlYXNlIGlnbm9yZSB0aGlzIGVtYWls
LCB0aGFua3MuDQo=

