Return-Path: <linux-pci+bounces-36929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A997CB9D933
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 08:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768123B6406
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244B2E8B94;
	Thu, 25 Sep 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CHwOdZE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE32E8B8C
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781190; cv=fail; b=ZBLtM9mjoZOYVsbY/m3HzSP67a2cFcrffE+Vnt+4/tlsBPyuB9NGVEDcgQ0/chZR6r5eX5cmMYkUfjZTVEg7PsNNNOeqzZi3kjzKHh1t1fK+c+RGTb1Jxzah8ESKFuFvxOQf8j07FOvJCVnCQq1Q9++qbZ/9IF1W45ncom9qCjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781190; c=relaxed/simple;
	bh=8QFvThDD16OeB23BfpTcck0WREqXyfaVjKJRXNw8sSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSsyZ41EhlxQR6HTYcx3p2WEiCY/hBl1RD5wFKs/AXfTp9dStjqCJBF03gfN/kyo+n36qoaO9gwUcW0qG5H8NE7JFSjSp0gB8tlMxr++QW/geekRhkBsgvehLCNp4VXkCneUOIUmeJpyngmD6elKhLnRzXFXnbczIdj1hxmIDMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CHwOdZE5; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDVD79upnN3lgacwp/I549rr80nLVUxpZoyFZ1n+we7I88FDB9QWr+JM74Rce7uc6KwdY9skN++uQyT8dk6txGC38lR8nNgkC2OwVDP+wpT68JZjxppz/cSL1zJpQXfNI8Wr4VgXd/dEUQr2oUcLttsODO3E/jOxqLosh1geKN68mHR2whsXCbRWQJIw9BaMr095r3x2qQK6wAHpsW4NaQtEefX/7lfEJAEY3d8cLEQHbn4MhqDVNojX2ifp8Zm0NGQpxj/dQkCrcfqMHUxbglRNencI706nvJeKHHMXYOr7Ncu00yaQBUGGunEv2gcBqbz2ILFSzPerpdmzkTTwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QFvThDD16OeB23BfpTcck0WREqXyfaVjKJRXNw8sSY=;
 b=K3f9QLe9WCkK2WfIdJ5bqmIZ4xyVxaB2wLKg0PD6NDm1zZsiUth9hhi7U7U0+qwQvQZ/1Py+0JUd+/l9WhXhriwO41T6SH9I9GknvNJ20sFigv6+gMi4RCAJ9bGFFH3UhqaR7aEIdQHqMPKl7ASoQp6PIUXcfYrxGX1bKna0i3TvSgT3Lk42XkPy8gJ8CfOiAX4FXJKGsuHgkdj7TSMWkE79HEmqFl5OTGzoZanGHN0SW4yO2hGh/7+1tmteq2sUubqn0dJww4L537kLsXCnf4Pf2NZ4RTtG/k7LR0g/M9Gt2uhPDckrk9M29ZsZPI8xKIuWfRBAMm7Cm945nmbEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QFvThDD16OeB23BfpTcck0WREqXyfaVjKJRXNw8sSY=;
 b=CHwOdZE51FrX0pTpgAd1OXbJH0n/w1ZJ+Op63FO0kR65zQsHDB6TORiM4fm4elQA4JTBZMLSaI3Lx4cklw7qFvOaWeNKxWCDZ8aT3CMhXeGaOKqamd6ku5OaVooSj+rf4FDOZ2P8O+O/UfA3C0VcStliUNjbsDyxEHaO1xocSWexe6zw64Ss1tPF6H37QXboUK/6FPg65hlAYib43esdlSa3w/wIEminGH3+An/a9CPYfsQ/S8KKvclxKjwl5xWywLl9gCH1qeeJChjqtbPkMBNlev2G5z2m2sHjypDFs+YztN5gCyBsNoFMIkyYydV3tylvZlWoUbDZRuIlATpTPQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 06:19:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 06:19:44 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "He, Guocai (CN)"
	<Guocai.He.CN@windriver.com>
CC: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, xiaolei.wang
	<xiaolei.wang@windriver.com>
Subject: RE: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Topic: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Index: AQHcLDoWCHKSsTl8kU6/ZHTMf2OTprShYyYAgAIMcfA=
Date: Thu, 25 Sep 2025 06:19:44 +0000
Message-ID:
 <AS8PR04MB8833C1C2AA31DC32F5B37DC78C1FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <CO6PR11MB558624C238AA9C39C9C6A936CD1DA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <20250923230006.GA2086105@bhelgaas>
In-Reply-To: <20250923230006.GA2086105@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB8215:EE_
x-ms-office365-filtering-correlation-id: 18607870-f71b-4389-a7aa-08ddfbfb852d
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1JjMWNvWTJYTHN6dFRyczdETmJqSWUvcTVPSkF3RlFwc0NvMkpvWG5EZFFF?=
 =?utf-8?B?T2x4a1ozMlk3SlNXZmRzcmlOM1RXaWlLUE9ueit6VmI0Sk8wUXg0K3pYYkpk?=
 =?utf-8?B?aW9ERzR4NXc3bFY4WXlWUU9tejJtRklKRE9pUWdSV01CK0puTUZJWDNDSGlt?=
 =?utf-8?B?ZVdqM3AvWUJNS0k2bmZqU2xta1hMQllOSEhmV2dLVExHMCthUXg4N0oyV0V4?=
 =?utf-8?B?OWpLajVZLy9NSW15Q2FnVTFyOEhHZzFZcTJjYnZOQTdqekZ3cFhBLy8vY0I1?=
 =?utf-8?B?RVNvZGtFYm05QktlZGJYM2NIbWtseHJvZmR2VzdRMlhYV2poblpIek1mRGdq?=
 =?utf-8?B?WUpIa1JLZm5lR0N3RUlUYkVNNm54NEZrczBFVTMyUzNXbFZYdWRyQTVUbkdn?=
 =?utf-8?B?VUI4VXBFY1FmS1lqcDBWTFFBSGJZdkdlT0hsN3RrOEhEUUU5MzQ3QTJCcWdP?=
 =?utf-8?B?Wld6RWs1bXZST0w4K0ZSdUk5Q1lDdDY0UStldnhUZFRTc3dVd2lWclFkVHA0?=
 =?utf-8?B?QkhWMVNPVkJFbHN6YlB0V2hHSm56M1IxK2NWZ2tFNXI1SzJ2T0dDRkM5Mkd3?=
 =?utf-8?B?d3AvSkRIUVV6STk5Mlp2TU1JTGdvallwZXFQYUgvQkxhZW5YVjVLc1VZWjNP?=
 =?utf-8?B?OXBBVnI5cURhWndzMHprSWtiQXpSb0VHV0ZMYUpkeldyVHZhdmhqbWtZaUZt?=
 =?utf-8?B?aHhDRHdwRmU5Nkw2NWEyME9NMjJvRTRnNlZqeDVoWlBPMHFRU1dpSVA4emNl?=
 =?utf-8?B?dU1MK0wzOGtKNzh1WXRLYWYram5DVC9YWmg0ek9zajJhVnZIaU5qZ3RPR1BN?=
 =?utf-8?B?NDRndk5ZNm1qbVJ0VmJkWTJ5Nm0wRzNNV3lTWVJhSHR2bXdsRUZ5NUFReHhH?=
 =?utf-8?B?ZldjeXZPNjVHbDkxdjJWWk1mMVQrWWkxcHFtSGNpb1lVejh2dGs1azBrR0Uy?=
 =?utf-8?B?K0N6RXlzWFdQRUcrN1JwRWRzaVBMdUxlMmRZUnpuUnoza1FHMTViUDBPUzAz?=
 =?utf-8?B?eVFHSGZUSWcyMWRZNlNEeVJESnBQdEdpRWErTmJMOE1Xc05JKzY1c0ZieEVN?=
 =?utf-8?B?WVY0WjBGVldUQWRqZ2tVT3RNclVoNzVvTlFJYkp4QkFjTjFzRWlRb1JLdWg2?=
 =?utf-8?B?Y1AzcStkQThaangyNVJabEJZV0JwejhXRzAxbFdnOTE3cXR3NG55SmxZK3Jj?=
 =?utf-8?B?OFBzTXh3THBSclJoZmZTMHRqM1dVV2FlM3FpSVFON1VlQkJpdXp3UkFpOUhi?=
 =?utf-8?B?aXFmTnBCVGtsTXJ2Rk5RUTJFYkZTRm9GUVZoQkZ0bjlzV2lDdEkwbWRqelZi?=
 =?utf-8?B?RUVheHRxNnJaNEowR0lSNjB0bUc4VlZKZnM4Q2lUaUZRdmxubWpLbTZ0a1Vp?=
 =?utf-8?B?UUVwU3REcXpjMFFzd3FabVlsNnBnMUFIRkVlN3c1TnF0RmlqdlA1VnhiVC9S?=
 =?utf-8?B?MlZLUG1hMnM3WG1oUk1nbDBkclQzTVBRc2VHVWxBVThDSnQxclZZY2dHWitn?=
 =?utf-8?B?UnZIVSs3dmdSeEh2Y0d3bi9VRmZoQ2FLTFJ1RVJvVjRVSUtCTUxybFhFbnZC?=
 =?utf-8?B?dXdoR082aTl6MzhqV2NiL1lxQ2tob1dxeExtVFVVcHFKazVZZ2JnRXoxTENx?=
 =?utf-8?B?dkJmUklXTytjeFpSNDZRRXB1dWZGL0FpVS8xSXozNXRRc0JnTDdiVVVMZWUz?=
 =?utf-8?B?MkV2Y0lhaU1HNmNZOW5IVksxcWx6b2JSMnQvdkhpVVZob0FyVkZPaHkxcFRR?=
 =?utf-8?B?TU1zYkxxY3hSbGFaVnlEZi9NcGlmRENxY08rRGRjVFMwT0VmQTJDUEV4Tkl2?=
 =?utf-8?B?bklQeVQ2UUp2MFZNbUUxR2o1UkQ1cFpLSEhUOE5VUElWSWtOTVAwaVl3TXpm?=
 =?utf-8?B?eFJ5Z2hDOHk0QVM4L0YxQ2R2Uy9iWDJXNGJEbndJNFIrbEFhTzg1V3FteWVs?=
 =?utf-8?B?a3Y3eEZKWG9PVGNUeVliM0RudWdLSGZhWkRYQlcwMmJaZHY0aDVZNVJtaTZJ?=
 =?utf-8?B?bEJzS2pIVnY4Vjk3dDRua28wcTlkNU9HRlZFTkJsTDRZUHBIMHMzS3AzeVBz?=
 =?utf-8?Q?vWcrME?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjNXalI5dFoyTnUzRUVXRXY3bzR3eXFjaEdmcXVVemJndmxIb2ZtZW1sMGNE?=
 =?utf-8?B?cHhQUHNWMkh2NWV3MTJ4d2dBejhqOEgrV2I3MW9rZ3VXRXhyOEszRzFyUmp4?=
 =?utf-8?B?Y3ZxdWg3UXEyQVplVGJiZ1BGdXFXUjVTcC9GM1BPckJuNFN5c1pxcllWazZz?=
 =?utf-8?B?ZGMwelJtcGRaR2MvVGduK2dRYTFnSzNkM0dkc1VQZzJCTXdLdk8vQWhYRkhD?=
 =?utf-8?B?YWl1OW1VSGJFTm13NlpyZFBadTV3UGErS3NmYnRnTnoya0dGS3VDUElRdWxk?=
 =?utf-8?B?N28rVnl2dy9penY3RURjVmVpamE2azRFa01FV0NPV01sLzQvMXRibUJ6Z0dY?=
 =?utf-8?B?bkk3QVVZVnQ2MmhJdFBtOWFRVTh2VDN6ejZ0RUtHRVlXZmhSdVpGUXc1VytJ?=
 =?utf-8?B?N3pNZWJvS2VDS2paY1ZiZlJpbmR4QWtxUGxJMkF0Z3BDVTd4bEo3ZXNjTk1i?=
 =?utf-8?B?bHUzYTEvSy9PNXRKVnNwQnNRcFFkRjhPOFlFdVlob1dJZGlIMTBlVmtSS3BH?=
 =?utf-8?B?M29LVHRzcWREamw0NEwxQUVuQy9IRTd5SC9ZR1ZBMFRkR05NY1JLYTY1Mi9H?=
 =?utf-8?B?NEJlNGtOdHg5emhaanpmcTFhR3BDRUFJaGhiQUtLa21OcWcyWGdCSWlobzBp?=
 =?utf-8?B?M2l0V0gwaWZVb0t6MHNYWEFUWUYzeE14YWdsdGtIemlob2VVeE1ZTVJqbXNi?=
 =?utf-8?B?T1NjTnBPUEVJcTJVWEswaXJ2MmdoeDBBZitnKy9hRWp4b0FPOHl4NmpPRVNq?=
 =?utf-8?B?a1d2UGg3YmpHTkp5UnZkb3k1ZXJKOGI3d2FhL3N6MHdXRmdjMGVqaEFxUVRB?=
 =?utf-8?B?dU02c3FaTDc5bXJXWERxZ3VRN21TWUkzSWprbEs4OWI4NXY2dVlSNFVXU3Fo?=
 =?utf-8?B?Wjd2ekUyazl2dTFjY0dRNUZpTnZDbEhlaUtOMzVvbGZNTWpDYUZYcmlBUTh6?=
 =?utf-8?B?QW93Y2V4aEhwT0VKUmRTZkRFRG9ONmg1ZVBHbVBlVkxQVGZBaUMyb2ZUYXlK?=
 =?utf-8?B?YnlVSWd2enhvTEc3N0x0a1ZVT2FSand1Q28xd3pSNHJyMk1jU3huL1dNeklh?=
 =?utf-8?B?bURFNXF5MCtTd0ZQYkJxV2pOMXE1bmFuY0lSeHVsWW1kRm9TWjFpUCtNRzBy?=
 =?utf-8?B?NnhJUjI0RlY1bWlvSE1wTysvaEdFdGxoeGVQRERadGZuWkVwMERFb1ZJd2JW?=
 =?utf-8?B?NEFxNjUycEdRMjNKTlQ2UmpTS2VUY2lxZ1RiK2FOc0l1VTVJMkxpT1FZQjdp?=
 =?utf-8?B?UElDL3hZak8weFlCU2ZmMVc3UlE3Y0tqTzIvQWtEVmJVUGdMak10WFh0TnNQ?=
 =?utf-8?B?ZUxPeHdDbXl2SzREeDU1ZlZRaDJwc1lBSUk1cVNMaDV6WHBIU3hqSUg2UW5k?=
 =?utf-8?B?L1MxNllxbFh0L2I0Nk1NczltNDhFeGlDNFYzZmhObmJPR2FhY05zV2hjR0F5?=
 =?utf-8?B?d0pQWk92REtQWXBCemFQNCtjSjlFcURBM2pUZEM1L1ZaL1d3TkJxeklaMFdv?=
 =?utf-8?B?OUlVR25YajhOTGR3anJDZzlkS1hOT2lYUnhqVDJsU1diVUNtdDlYdWgvcjM2?=
 =?utf-8?B?N21xSnVlYk83eFpzWlEyTUFBUG5PTk5XOVBtdndEbnZvbXFkcmN3R0dOSmdN?=
 =?utf-8?B?aEFISUM3WmVaOGIvcmNBaXhMYllXUnF5Vm5kSlJnbm82a3VHNnRaMWo0bUhC?=
 =?utf-8?B?VlE0QVA4USsyQVN1NktSVHlGV1B3d3RreVgrR1R6VEFNZU1jQVNROTZTYUZL?=
 =?utf-8?B?YmkyVDFiRzBwVHZEVno2ME4yVlh4UUNmSEdqOWl4S2pVeDlUcTBrZkxSRnc2?=
 =?utf-8?B?UFVZaEtaSjN4aXZraE5pSGV4V0x1MVl1WXo2SVZGcEZnM3NyWTJROXpxbFVK?=
 =?utf-8?B?U2piZ0pESVVyd3JEclJyRHRLL2tCVkZlK21LVDRKNjJZTWR1V0dET1FXNGtI?=
 =?utf-8?B?UkJVdU0zd0Nqd2U4SXZISS9reDkvc2NKWXd2ZWJJS3BaTGFKWGpEQzQ4bFhT?=
 =?utf-8?B?NDdOOHM2T3ZwaGxuVmtLM0l0VXpwT3YrVnhsViswVDFsRWd3anpFSFVKZUM5?=
 =?utf-8?B?M0hBVnovWDhjcngrVEVmN3lrN1MvQTVDTjkxU05pMHlpZXZQQXBKMjlTV1pF?=
 =?utf-8?Q?vhvY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18607870-f71b-4389-a7aa-08ddfbfb852d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 06:19:44.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6xWY0YW3J7njCQyDR8Xgx7YitUvT2rT3pCz6qZyYL3tBNV3qcY/Qr/ktzKKD9ZqQM+pApfp3zP+Uv0/692CSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

SGkgR3VvY2FpOg0KSSB0cmllZCB0aGUgTDYuMTctcmMxIG9uIGkuTVg4UU0gTUVLIGJvYXJkLg0K
Tm8gc3VjaCBraW5kIG9mIHByb2JsZW0uDQoNCkhlcmUgYXJlIHRoZSBsb2dzOg0Kcm9vdEBpbXg4
cW1tZWs6fiMga2V4ZWMgL3J1bi9tZWRpYS9ib290LW1tY2JsazFwMS9JbWFnZSAtLWR0Yj0vcnVu
L21lZGlhL2Jvb3QtbW1jYmxrMXAxL2lteDhxbS1tZWsuZHRiIC0tY29tbWFuZC1saW5lPSJjb25z
b2xlPXR0eUxQMCwxMTUyMDAgZWFybHljb24gbm9fY29uc29sZV9zdXNwZW5kIHJvb3Q9L2Rldi9t
bWNibGsxcDIgcm9vdHdhaXQgcnciDQpyb290QGlteDhxbW1lazp+IyAgICAgICAgICBTdG9wcGlu
ZyBTZXNzaW9uIGM2IG9mIFVzZXIgcm9vdC4uLg0KWyAgT0sgIF0gUmVtb3ZlZCBzbGljZSBTbGlj
ZSAvc3lzdGVtL21vZHByb2JlLg0KWyAgT0sgIF0gU3RvcHBlZCB0YXJnZXQgR3JhcGhpY2FsIElu
dGVyZmFjZS4NClsgIE9LICBdIFN0b3BwZWQgdGFyZ2V0IE11bHRpLVVzZXIgU3lzdGVtLg0KLi4u
DQpbICAgMjguNjkzNDI2XSBrZXhlY19jb3JlOiBTdGFydGluZyBuZXcga2VybmVsDQpbICAgMjgu
NzQ0MzU4XSBwc2NpOiBDUFUxIGtpbGxlZCAocG9sbGVkIDAgbXMpDQpbICAgMjguNzc2MzYyXSBw
c2NpOiBDUFUyIGtpbGxlZCAocG9sbGVkIDAgbXMpDQpbICAgMjguNzkxOTk2XSBwc2NpOiBDUFUz
IGtpbGxlZCAocG9sbGVkIDAgbXMpDQpbICAgMjguNzk3MTUxXSBCeWUhDQpbICAgIDAuMDAwMDAw
XSBCb290aW5nIExpbnV4IG9uIHBoeXNpY2FsIENQVSAweDAwMDAwMDAwMDAgWzB4NDEwZmQwMzRd
DQouLi4NClsgICAgMi40MzI0OTVdIGNsazogRGlzYWJsaW5nIHVudXNlZCBjbG9ja3MNClsgICAg
Mi40NDMzNjBdIGNoZWNrIGFjY2VzcyBmb3IgcmRpbml0PS9pbml0IGZhaWxlZDogLTIsIGlnbm9y
aW5nDQpbICAgIDIuNjI5MzE5XSBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IGlBVFU6IHVucm9s
bCBGLCA2IG9iLCA2IGliLCBhbGlnbiA0SywgbGltaXQgNEcNClsgICAgMi42MzcxMzRdIGlteDZx
LXBjaWUgNWYwMDAwMDAucGNpZTogSW52YWxpZCBlRE1BIElSUXMgZm91bmQNClsgICAgMi43NDY1
NDJdIG1tYzE6IG5ldyBoaWdoIHNwZWVkIFNESEMgY2FyZCBhdCBhZGRyZXNzIGFhYWENClsgICAg
Mi43NTMwNDBdIG1tY2JsazE6IG1tYzE6YWFhYSBTQTE2RyAxNC44IEdpQg0KWyAgICAyLjc2MTUw
OF0gIG1tY2JsazE6IHAxIHAyDQpbICAgIDIuODQwOTczXSBpbXg2cS1wY2llIDVmMDAwMDAwLnBj
aWU6IFBDSWUgR2VuLjMgeDEgbGluayB1cA0KWyAgICAyLjg0NzcyNF0gaW14NnEtcGNpZSA1ZjAw
MDAwMC5wY2llOiBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDANClsgICAgMi44NTQxMzZd
IHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMC1mZl0NClsgICAgMi44
NTk2NTldIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwMDAtMHhm
ZmZmXQ0KLi4uDQppbXg4cW1tZWsgbG9naW46IHJvb3QNCnJvb3RAaW14OHFtbWVrOn4jDQpyb290
QGlteDhxbW1lazp+Iw0Kcm9vdEBpbXg4cW1tZWs6fiMgdW5hbWUgLWENCkxpbnV4IGlteDhxbW1l
ayA2LjE3LjAtcmMxICMzIFNNUCBQUkVFTVBUIFRodSBTZXAgMjUgMTQ6MTQ6NTEgQ1NUIDIwMjUg
YWFyY2g2NCBHTlUvTGludXgNCnJvb3RAaW14OHFtbWVrOn4jIGxzcGNpDQowMDowMC4wIFBDSSBi
cmlkZ2U6IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yIEluYyBEZXZpY2UgMDAwMCAocmV2IDAxKQ0K
MDE6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXI6IFNoZW56aGVuIFVuaW9ubWVt
b3J5IEluZm9ybWF0aW9uIFN5c3RlbSBMdGQuIEFNNjEwIFBDSWUgMy4wIHgyIE5WTWUgU1NEIDEy
OEdCLCAyNTZHQiAocmV2IDAxKQ0KDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ55pyIMjTml6UgNzowMA0KPiBUbzogSGUsIEd1
b2NhaSAoQ04pIDxHdW9jYWkuSGUuQ05Ad2luZHJpdmVyLmNvbT4NCj4gQ2M6IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBMdWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRy
b25peC5kZT47IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YNCj4gV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1
dHJvbml4LmRlPjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47DQo+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgeGlhb2xlaS53YW5nDQo+IDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtpLk1YOCBQQ0llXSBQQ0llIGxpbmsgZmFpbHMgYWZ0ZXIga2V4ZWMNCj4g
DQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDI1IGF0IDAzOjM1OjU2QU0gKzAwMDAsIEhlLCBHdW9jYWkg
KENOKSB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBXZSBhcmUgc2VlaW5nIGEgUENJZSBp
c3N1ZSBvbiBpLk1YOC1iYXNlZCBib2FyZCB3aGVuIHVzaW5nIGtleGVjIG9uDQo+ID4gTGludXgg
a2VybmVsIDYuNiwgIHdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBoZWxwIHRvIGNsYXJpZnkgd2hl
dGhlcg0KPiA+IHRoaXMgaXMgYSBrbm93biBwcm9ibGVtIG9yIGlmIHRoZXJlIGlzIGEgcmVjb21t
ZW5kZWQgZml4Lg0KPiANCj4gQ2FuIHlvdSBib290IGEgcmVjZW50IGtlcm5lbCwgZS5nLiwgdjYu
MTYgb3IgdjYuMTctcmM3LCB0byBtYWtlIHN1cmUgeW91J3JlIG5vdA0KPiBzZWVpbmcgYW4gYWxy
ZWFkeS1maXhlZCBwcm9ibGVtPw0KPiANCj4gSWYgeW91IGNhbid0IHRyeSBhIHJlY2VudCBrZXJu
ZWwsIHBsZWFzZSBpbmNsdWRlIHlvdXIgZGV2aWNldHJlZSBhbmQgdGhlDQo+IGNvbXBsZXRlIGRt
ZXNnIGxvZyBpbmNsdWRpbmcgYm90aCB0aGUgaW5pdGlhbCBib290IGFuZCB0aGUga2V4ZWMuDQo+
IA0KPiA+ICMjIEJvYXJkICYgU2V0dXANCj4gPiBMaW51eCB2ZXJzaW9uIDYuNi4xMDMteW9jdG8t
c3RhbmRhcmQgKG9lLXVzZXJAb2UtaG9zdCkNCj4gPiAoYWFyY2g2NC13cnMtbGludXgtZ2NjIChH
Q0MpIDEzLjQuMCwgR05VIGxkIChHTlUgQmludXRpbHMpIDINCj4gPiAuNDIuMC4yMDI0MDcyMykg
IzEgU01QIFBSRUVNUFQgV2VkIFNlcCAgMyAyMDoxMzozNSBVVEMgMjAyNQ0KPiA+DQo+ID4gTWFj
aGluZSBtb2RlbDogRnJlZXNjYWxlIGkuTVg4UU0gTUVLDQo+ID4gUENJZSBkZXZpY2U6IEludGVs
IENvcnBvcmF0aW9uIFdpcmVsZXNzIDcyNjANCj4gPg0KPiA+DQo+ID4gIyNCb290IGZsb3c6DQo+
ID4gI3N0ZXAgMTogSW5pdGlhbCBib290OiBMaW51eCBrZXJuZWwgYm9vdCBmcm9tIHRmdHAgLg0K
PiA+IHNldGVudiBpcGFkZHIgMTI4LjIyNC4xNjUuMTIwDQo+ID4gc2V0ZW52IGdhdGV3YXlpcCAx
MjguMjI0LjE2NS4xDQo+ID4gc2V0ZW52IG5ldG1hc2sgMjU1LjI1NS4yNTUuMA0KPiA+IHNldGVu
diBzZXJ2ZXJpcCAxMjguMjI0LjE2NS4yMA0KPiA+DQo+ID4gdGZ0cCAweDhhMDAwMDAwMCB2bG0t
Ym9hcmRzLzI5MTA2L2tlcm5lbCB0ZnRwIDB4OGQwMDAwMDAwDQo+ID4gdmxtLWJvYXJkcy8yOTEw
Ni9kdGIgYm9vdGkgMHg4YTAwMDAwMDAgLSAweDhkMDAwMDAwMA0KPiA+DQo+ID4NCj4gPiAjc3Rl
cCAyOiBTd2l0Y2ggdG8gYW5vdGhlciBrZXJuZWwgb24gZGlzayB1c2luZyBrZXhlYyBSZXByb2R1
Y3Rpb24NCj4gPiBzdGVwcyByb290QG54cC1pbXg4On4jIG1rZGlyIC9tbnQvc2Rpc2sgcm9vdEBu
eHAtaW14ODp+IyBtb3VudA0KPiA+IC9kZXYvbW1jYmxrMHAxIC9tbnQvc2Rpc2svDQo+ID4gcm9v
dEBueHAtaW14ODp+IyBzY3AgZ2hlLWNuQDEyOC4yMjQuMTUzLjE1MTovZm9say9naGUtY24vaW1h
Z2VzL0ltYWdlDQo+IC9tbnQvc2Rpc2sva2VybmVsICAgICAvL3RoZSBpbWFnZXMgaXMgdGhlIHNh
bWUuDQo+ID4NCj4gPiByb290QG54cC1pbXg4On4jIGtleGVjIC1sIC9tbnQvc2Rpc2sva2VybmVs
DQo+ID4gLS1hcHBlbmQ9ImNvbnNvbGU9dHR5TFAwLDExNTIwMCB2aWRlbz1IRE1JLUEtMToxOTIw
eDEwODAtMzJANjAgcncNCj4gPiByb290PSAvZGV2L25mcw0KPiA+IG5mc3Jvb3Q9MTI4LjIyNC4x
NjUuMjA6L2V4cG9ydC9weGVib290L3ZsbS1ib2FyZHMvMjkxMDUvcm9vdGZzLHRjcCx2Mw0KPiA+
IGlwPTEyOC4yMjQuMTY1LjEyMDoxMjguMjI0LjE2NS4yMDoxMg0KPiA+IDguMjI0LjE2NS4xOjI1
NS4yNTUuMjU1LjA6OmV0aDA6b2ZmIHNlbGludXg9MCBlbmZvcmNpbmc9MCINCj4gPg0KPiA+IHJv
b3RAbnhwLWlteDg6fiMga2V4ZWMgLWUNCj4gPg0KPiA+DQo+ID4gI0FmdGVyIHRoZSBzZWNvbmQg
a2VybmVsIGJvb3RzLCB0aGUgUENJZSBsaW5rIGRvZXMgbm90IGNvbWUgdXAuDQo+ID4gI0tleSBs
b2cgZGlmZmVyZW5jZXMNCj4gPg0KPiA+ICMjIyMjICBib290IChib290X2NvbGQubG9nKToNCj4g
PiBpbXg2cS1wY2llIDVmMDEwMDAwLnBjaWU6IGhvc3QgYnJpZGdlIC9idXNANWYwMDAwMDAvcGNp
ZUA1ZjAxMDAwMA0KPiByYW5nZXM6DQo+ID4gaW14LWRybSBkaXNwbGF5LXN1YnN5c3RlbTogYm91
bmQgaW14LWRybS1kcHUtYmxpdGVuZy4yIChvcHMNCj4gPiBkcHVfYmxpdGVuZ19vcHMpIGlteDZx
LXBjaWUgNWYwMDAwMDAucGNpZTogaG9zdCBicmlkZ2UNCj4gL2J1c0A1ZjAwMDAwMC9wY2llQDVm
MDAwMDAwIHJhbmdlczoNCj4gPiBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6ICAgICAgIElPIDB4
MDA2ZmY4MDAwMC4uMHgwMDZmZjhmZmZmIC0+DQo+IDB4MDAwMDAwMDAwMA0KPiA+IGlteDZxLXBj
aWUgNWYwMDAwMDAucGNpZTogICAgICBNRU0gMHgwMDYwMDAwMDAwLi4weDAwNmZlZmZmZmYgLT4N
Cj4gMHgwMDYwMDAwMDAwDQo+ID4gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBpQVRVOiB1bnJv
bGwgRiwgNiBvYiwgNiBpYiwgYWxpZ24gNEssIGxpbWl0DQo+ID4gNEcgaW14NnEtcGNpZSA1ZjAw
MDAwMC5wY2llOiBlRE1BOiB1bnJvbGwgRiwgMSB3ciwgMSByZCBpbXg2cS1wY2llDQo+ID4gNWYw
MDAwMDAucGNpZTogUENJZSBHZW4uMSB4MSBsaW5rIHVwIGlteDZxLXBjaWUgNWYwMDAwMDAucGNp
ZTogUENJZQ0KPiA+IEdlbi4xIHgxIGxpbmsgdXAgaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBM
aW5rIHVwLCBHZW4xIGlteDZxLXBjaWUNCj4gPiA1ZjAwMDAwMC5wY2llOiBQQ0llIEdlbi4xIHgx
IGxpbmsgdXAgaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQQ0kNCj4gPiBob3N0IGJyaWRnZSB0
byBidXMgMDAwMDowMA0KPiA+DQo+ID4gI+KGkiBMaW5rIHVwIHN1Y2Nlc3NmdWxseQ0KPiA+DQo+
ID4gcm9vdEBueHAtaW14ODp+IyBsc3BjaQ0KPiA+IDAwOjAwLjAgUENJIGJyaWRnZTogRnJlZXNj
YWxlIFNlbWljb25kdWN0b3IgSW5jIERldmljZSAwMDAwIChyZXYgMDEpDQo+ID4gMDE6MDAuMCBO
ZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIFdpcmVsZXNzIDcyNjAgKHJldiA2
YikNCj4gPiByb290QG54cC1pbXg4On4jDQo+ID4NCj4gPg0KPiA+ICMjIyMjQWZ0ZXIga2V4ZWMg
KGJvb3Rfa2V4ZWMubG9nKToNCj4gPg0KPiA+IGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogICAg
ICAgSU8gMHgwMDZmZjgwMDAwLi4weDAwNmZmOGZmZmYgLT4NCj4gMHgwMDAwMDAwMDAwDQo+ID4g
aW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgNiBvYiwgNiBpYiwgYWxp
Z24gNEssIGxpbWl0DQo+ID4gNEcgaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBlRE1BOiB1bnJv
bGwgRiwgMSB3ciwgMSByZA0KPiA+DQo+ID4gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQaHkg
bGluayBuZXZlciBjYW1lIHVwIGlteDZxLXBjaWUNCj4gPiA1ZjAwMDAwMC5wY2llOiBQaHkgbGlu
ayBuZXZlciBjYW1lIHVwIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJDQo+ID4gaG9zdCBi
cmlkZ2UgdG8gYnVzIDAwMDA6MDANCj4gPg0KPiA+ICPihpIgTGluayBuZXZlciBjb21lcyB1cCwg
bm8gUENJZSBkZXZpY2VzIGRldGVjdGVkLg0KPiA+DQo+ID4gcm9vdEBueHAtaW14ODp+IyBsc3Bj
aQ0KPiA+IDAwOjAwLjAgUENJIGJyaWRnZTogRnJlZXNjYWxlIFNlbWljb25kdWN0b3IgSW5jIERl
dmljZSAwMDAwIChyZXYgMDEpDQo+ID4gcm9vdEBueHAtaW14ODp+Iw0KPiA+DQo+ID4NCj4gPiAj
UXVlc3Rpb25zDQo+ID4gQXJlIHRoZXJlIGV4aXN0aW5nIHBhdGNoZXMgb3IgcmVjb21tZW5kZWQg
d29ya2Fyb3VuZHMgZm9yIHRoaXMgc2NlbmFyaW8/DQo+ID4gVGhhbmtzIGZvciB5b3VyIHRpbWUg
YW5kIGFueSBndWlkYW5jZSB5b3UgY2FuIHByb3ZpZGUuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMs
DQo+ID4NCj4gPiBHdW9jYWkNCg==

