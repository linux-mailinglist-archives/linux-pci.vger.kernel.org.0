Return-Path: <linux-pci+bounces-30335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E22AE3376
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 03:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C92216614B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 01:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724A16F841;
	Mon, 23 Jun 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sx79INSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9C1DFDE;
	Mon, 23 Jun 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643878; cv=fail; b=KFMjjHtKrVYifDeaPZzQaIR5NmRss/9WSajhd3tgArakasCpCzcU3qchvFReUnTF2/Q6mPxAsRI6l/HL1tZwa2CgKE/2cSNntsmvKcEsTenf48suzEFhAdZFRXKdSb64C4+nhevyVH9uDwuYs/q1TpRuiVB96Y/fgD/9bxUZwo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643878; c=relaxed/simple;
	bh=4yRXb3ZIAwAAbx1fvrnsCJQZxrAGoE6LCyHeCDYGKAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlrAwsN8iOYEO23BjOJla+A3KoVH3p3ptsvMXdMoLhnZwsMKemr27Jp9DzoeCjA5b+QHBt/T+FcIVvvQtaMureLUlQUSnGOB5SuXZ1TTm8c/C41JbFW6amjXnCLYVrM4QxWdy4x4rBIZUuHNB/aTFEmjukf5QD1qMwZWFkNUV+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sx79INSo; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgbioELURvqjVs52Mlny8/z34/RQKvScdwJuqyYsIzh1NrWwU/eZhk6g06pGNUan3dc6GeXDGRbvc+ImRZsgzdaZo4wAxGukg00QGwerfpTfRzdcg5FRXhir6gW0VU6T6ZPGyWbYHhwUrbWwpmrrEyyX6XUML6tQYdIV1ERgsZPy9wBmSstRlEPWhiCjIQLGmLJ0hde4Ti5eEplCF2tiKe/cbgFFW/su5bPISzv/ZYIOUtQ5NbEsDqCofyhkm1U2vqZ7gGEXiKXZhcz1YbqLpM7am1Hmm0AVb2BwInRabykd1EJ82j+OF4y87t9AaG79j3GAPMp6PPESe7CXDBeNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yRXb3ZIAwAAbx1fvrnsCJQZxrAGoE6LCyHeCDYGKAY=;
 b=dTINuQgf6IHdeejEre8yICUNDR3ONYhbpujDL/xye73n5gRbQjmQQHJtIrw6Ki+BKnbHA/yk078UEqUmJqelcZVJ+/G88Lo10FSJNU1NKsM58l9JRquElYhl/Fw/9DiB4wOcyfGBt00zU3m3CtZGyPOyUx/BHYkFo4AuDV7XfYwRhEwNbvZ6UQDeoS0Z7vsRnR0K0sSdpTjlaZG5ayiuxInlI4I5LCcKnwwQEtgWfQv08u7jj8WddTm4EWtbZB128roJl5agMde0ks58vQPsWke9jy7HjRp/rESo8m+gisAKygbEI6ODb9LHECPe9hgqKKP8qYHhHa4JR0FSQJIhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yRXb3ZIAwAAbx1fvrnsCJQZxrAGoE6LCyHeCDYGKAY=;
 b=Sx79INSol/Yiv/TCel201Nkbw+Q+VyZBZaqucmmm3pFActjkQ1HS6CExRiQCuLg88FIGWUn0FNLo+knEz+DIjDaQxn+I+2uP5OI5+UJ1XlNWjnK3rQ1v0W9sLmXB+c/ctsPomFVNhl8JOV/pdId/MgZpV0gU9IWmWzlzoIARCEFKrpc7d9ybfSd0TsdXX4QC205WpnZsiwfkOCcQH3CpoSJz14wSVfZeCekkUEw6dbq0x3It4+pGzp8o0NvslDj7LiogxLewRThxzk95kdlThKSuX3EvOjdZWI2suobfADtxvDCoali1xowUzRxqFuuhkkOc1PTL1B5yP9ovXr1s3w==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 01:57:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 01:57:51 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference clock
 mode support
Thread-Topic: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Thread-Index: AQHb4ZGnnK0+mhMxB0CmqHMoIIKW/LQLrY4AgAAFt2CAAFJcAIAAGeAAgAPeIeA=
Date: Mon, 23 Jun 2025 01:57:51 +0000
Message-ID:
 <AS8PR04MB8676AFBB4F87564E45CDA4378C79A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250620031350.674442-1-hongxing.zhu@nxp.com>
 <20250620031350.674442-2-hongxing.zhu@nxp.com>
 <20250620-honored-versed-donkey-6d7ef4@kuoka>
 <AS8PR04MB8676FBE47C2ECE074E5B14768C7CA@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <130fe1fc-913b-48cf-b2a4-e9c4952354fd@kernel.org>
 <aFVy9OMxL4WXEOzz@lizhi-Precision-Tower-5810>
In-Reply-To: <aFVy9OMxL4WXEOzz@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI2PR04MB10666:EE_
x-ms-office365-filtering-correlation-id: c65303c9-0ee6-41c6-aa80-08ddb1f95cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V21xblB6RkhnT1lWOGdhTU04cUlUY1dQUTh5TC9zYUgxVFZUSWNHL052NE0z?=
 =?utf-8?B?cGNuSjZZQVdoWTA4YUJnVGN4cnRkdWdWT0lWQ2ZwWjBUUlJaMGVCZE8xQS9s?=
 =?utf-8?B?QlByOC9MNXNDT0dSOUlMZkgza1h1WlFGTjE3VHhxTWFMSlNsdEJrajNpK3Mv?=
 =?utf-8?B?WGdEWnRaOXFSRkdTd3UxT3pzdHVIbmpGMUtBY0FmeGUvTkZWYXd4VjBoYWND?=
 =?utf-8?B?SUpwN1BwcnFra3lHMkVjV3ZSeE9ucEhXdEtWaFZtZTdCMm41NDRQMGZJVk1v?=
 =?utf-8?B?elBwSkJSbEJ1ZlZDSm4vQkZDWjlTSWtreUhHNXh4MTV6RWNlRWRVeG43WUNI?=
 =?utf-8?B?bzc1VG0xdDB3ZmZneVMvYjlQZFp1UDZnMFNrTS82eFJxOEpmd2ZwWjZxRGpD?=
 =?utf-8?B?bnNVRllraTV4cktpVkpJUlhZTkZ2N012UHQyd2lyNGJTdkhvNk1tYTBWS2p1?=
 =?utf-8?B?ZHI3NnZ0SG9lemx1NEJ6MzNhTS9MSjRVNVF0LzgwU2p3S25iU2MwbmF0SWE2?=
 =?utf-8?B?MjZ4bk5lM3orYUJmMlREMXV3Tm9hVTJwTjI5RExXSDdFY1FlNzFIMFZMODJ2?=
 =?utf-8?B?YnVyNWtYUUdtQTlVNSsvSFgzZFBwc29FMVNmQklTZzZYVmJOa3c0YnhRR3oz?=
 =?utf-8?B?QTRVU2lWOW50d2lQeU04Q1laZzFDNmtxdWVCbHdqcHF5akNaSG4yUDY4OUpj?=
 =?utf-8?B?VjlGVlpqWElMZnZObFVyZlh4dUQvWUNHaGZnSEk5bmtNUUtjS29sZitCNjBM?=
 =?utf-8?B?WmFDRzd4ZVRYbVpqeUFkQlhPcFVib1VCVkdMWXJSR2VHbDJ5TUdqRU16RkxB?=
 =?utf-8?B?L0lrT2lhV3RpRE1mWi9XR29VYmpCS0g5eEFxZ1ZOc1VsMWt5NEdvalluZmlj?=
 =?utf-8?B?RTcycGdIcXk0RmRzVjYrTmVML0dpbjRlL1RDYWJmVUQ2dnhkcEtRekY2dysz?=
 =?utf-8?B?dFEwb2lOZjBmOUg5V1h5Mi9jSGZUL1JCNDBCd25LOCtLckxnak84bkhVdmJM?=
 =?utf-8?B?Nmt3RThQN0dqYzVVaklGNlhoRkxvMENzYVA0eEFXVnlZVUI1MVZKU0lmR3Qr?=
 =?utf-8?B?MkpIUW5yNUZESS9YTnN4dnB0cnowVWErQlhWcjBscXhoRndUdG8xb0N1ZHps?=
 =?utf-8?B?YmJQSnpicEdmU1ljRWpwZEx4Y05WNkNacVYrSmhNQ0J6SnlyR2NSdk02dy82?=
 =?utf-8?B?RHNkTldnellnQ1J2Wndkc3I2c3JLUzB1YXpvNFZIdVJDNzJHM3RhczIrNCsv?=
 =?utf-8?B?OHljUVRibkoyQ0poU2kwTFlzclpHNG1xd1prOHFTR3NRQmF4LzVlR2dLbkI4?=
 =?utf-8?B?OFJyNXB2YzJHZVZJZDlsb0lxR1lYT1JVVThGbTlGSmpWSnprRjFFck9QMHJt?=
 =?utf-8?B?Z2E1Q1REbytWKytrOEsvMUxSR2xOUDhJbjdLeWtZTW55L25XTDRNMVBGR0l3?=
 =?utf-8?B?M1dXREdPaHdUREN0M21ydW5TYjA3bFFNcW5hUjVDQm1DK05QdVpMeUxxMzkr?=
 =?utf-8?B?YngwT3RMT0txcmJNay9hazJ3c3M0REtZc0h1UzMvUU8xM2dJSkY3SXpDbjA5?=
 =?utf-8?B?UDNwMWNQeVJoMFNuUHlRcVZzMURBUXNjWkQwRUhhYmUwdkpFYy9BYmU1ZGVa?=
 =?utf-8?B?bmFnS2pDampjdk0yTzhjOWhUMFZkY2VYeDltb3l4UzZUY0UwQUtEMGMzclk5?=
 =?utf-8?B?M09PZmlmckt5TGxadHdWQWZQeFk0cE9ZalI1YUlJTkNlczhlWG9vbXVpK3Vo?=
 =?utf-8?B?dVdvU0o5eDhPb1NOdjVCNU1DblQ0NjJIM3E4VFVyUkVHOUVTZE1aN1VpTC9R?=
 =?utf-8?B?QVdhTEhsOFlZZ1JwWDhLek5VM1N5bm1MK0ZwMWgzZzd2dU4wZlB6a0pNbTJt?=
 =?utf-8?B?TTJlSlhsUGF6OEMzRzg3NGtqRGhOMGJQa1ZkNmNwZW8xYzBoMzJKV3BRQnlU?=
 =?utf-8?B?V29mNUZWemJFTVduaXBKYTc1V0JLRTQxOER3K0JwYklyQ3NNWGRYcTdVNUcz?=
 =?utf-8?Q?aRZjdax2ibrrQMDBUp+iON6AmRh9Ew=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk5WOXBpMno4MVFQSlJkTTMrY3B2cmN3bjJRY3N1dlJEQWR1anpDd2M5ckpL?=
 =?utf-8?B?alowVHY5L0hXYWQ1Nk9NTitvV1ZqMkx2NUxaT1JTRjF6NGphaFdoaWNkdHlQ?=
 =?utf-8?B?b2VjNTZORnhtWUp3a2VXT0FvV0xsRHFvWkxLVjA2Wk8welE3SUJGM1c2L1BO?=
 =?utf-8?B?NXk4cU9SUitXS25jL0xXQnJ6Mksvd2s4eGkwd2ZQN08xS1RRUXkxR2orNTgx?=
 =?utf-8?B?QzRtVmhBZ1BRMFpVWXhEcFp5QjBVbHhQbGxZeE9aUHJEcE13bkd5N2JFZ2Q2?=
 =?utf-8?B?R0NMU1RsZFl1ZGxFRnZweGdwTVNZMXhrc0srbjQ3alZ0UEFyV1VzMm90bnhV?=
 =?utf-8?B?TitHeHozOHJYOEVRNENzUnZUYmpnN3Mxc08zeEhJVENsOVlHSkowZ2ZWT2tx?=
 =?utf-8?B?L2t3S3VlVmdtUFg2TU1jWWRwM29NQm50aEt3ajhJZWNicnZJM0luTHlQRGV2?=
 =?utf-8?B?ZXpkRStHR3hiUmZzQ0ZjSG4reDV3YWVKWTRKRGZocFJiTEFsNEhIVG52MldC?=
 =?utf-8?B?d1RsN2piUEU2Z1JGYVdydDByN2FESjJLVGoxU3MzN2lIMlV4aTYzV2tQQThM?=
 =?utf-8?B?czF4aDBHZWcveFlEZWk1R0o0V1FEY1h2b1Roc0FQOHlmazIxT3BFZEZ0dGFE?=
 =?utf-8?B?N3ArWWthRk1aSEc2OEo1djk2b01kREZmaEdLemFMTXRaei9KN0tmNXB0VFg5?=
 =?utf-8?B?MHdzSkUzQjI0UFM5Q1hzZUZGTE8vTERGeU1xUktuZ1lQaVRxTWJuV2wzam1h?=
 =?utf-8?B?Uk9EQVVsWmVNelFDSHpWTTRrcFdnZEV6eFBBRDFKVWRCbVJEdUYxWE1ROFl5?=
 =?utf-8?B?VzlNUFhmU0QzcGZZZ29HYUNFUDRqQjloZjZSUXczMENqclJQTUJENlhZaWFm?=
 =?utf-8?B?Z1VXOXdqYjFMU1JrUHZxUUo3R1BDUHd3UG9VMkRucWx4RWNWcmJVaHVtL1Fx?=
 =?utf-8?B?UDNULzNxcmYyNXlnTEYrY0hFaFExWTFVemwvZExNUzFuQ3ptUjlGYy9CdVlv?=
 =?utf-8?B?bXMxTEV1aGZCeEkxS256bmt0cGxPaTNVc2lLd09heHQ1Uy9Ba1Fvdmx3NHNH?=
 =?utf-8?B?OS9HZUloeWNQOVBqa2xaczdiQkR3VGR1bU92azJYNS9tbmJES2s3Z3BPT2Vy?=
 =?utf-8?B?Zk5OSzRpNURvVUJYZ0J6Skp3U1FQWlpMK2VCWFlRZ3lKTkFObDkyZHFhbUJ5?=
 =?utf-8?B?S05QY3lPcUg0aEVTV2Q2dzVkTXloR2huUnM3K3BnZjJONFFiZWpsN1RaNkdo?=
 =?utf-8?B?YmZLQ1N4YXdFZjJsb2I4cTdmYW1IMXNIM296Y0ZWLy80VTg2dUhwT1RNR1V4?=
 =?utf-8?B?amNiUm1iMW42cHllL2JTckRYUDVmb2RCaEVQeTBLNjZnRkJ5WDdGU21BSGV4?=
 =?utf-8?B?ZlIwQzVoV1VEYTVvT2pBMHY2TzdHTHd5Y0JDa3k4emV3ck9mc3NvYmdaMFVY?=
 =?utf-8?B?bGNPSmNtMGd1c2lSaHRWUGZCUmJ3cjBvTzNaSVpiL0dVcFFNUnprbnJ4L3hJ?=
 =?utf-8?B?b2FVcDlZZUdWbGEvT09mdHdWOXFPeVUwRTB5VEIrQlhzNTEzUFRIYlM5ckJM?=
 =?utf-8?B?T09rYUgrYTZMWDVMb2RNY2tBSER1TjkxR0xxU2NUZitvQXdvOGxMWkpoVUJW?=
 =?utf-8?B?dm1ZRzBQRzlLTlN5eDNJeHJCSVlpSXhDQ0ZldlZlVmdubWtmK3plN2JWVmU1?=
 =?utf-8?B?Q3R6YW8zRS9Ebm5sR1IwODJieWRiMjN2MXBLM1djbDU5OUFsaHBoVEU4bHQv?=
 =?utf-8?B?djNsTTNDaUpVdnM2aGRwclB1cVNzQTJBV0oxZDF4SXppQTdnZHJqcjBtQmto?=
 =?utf-8?B?NEcwNlVlSWJIRng5R1BlY0w2WFdmSzBpNkh2WVdzSmJHVko3TjlzZExlcnJS?=
 =?utf-8?B?R1B3Qlp5a3Y2R3R0SmpWMDkrNktVeEJ2TjMybjY5MWtSUUZna2ZQM2YwQUNQ?=
 =?utf-8?B?TEZ0YXVuZ0RtSUVHbVFOc213WWw5M3pPLytxVlhHTUpSS2gwOXhuN1FkRHEv?=
 =?utf-8?B?eVhaTXQ3V0VZd3ZoYUFiUXVvUGJ4NW9scEZGc3RJcUJCdEF0ZTk5SkhVNG9J?=
 =?utf-8?B?WC9qZVNDTkRlc0lKR25Ca05DaFRFYkNwT3BBbEE5ZkEwUmxBc0FKUGFCMmg1?=
 =?utf-8?Q?KGozgfOAJrHlBzVk/tGFMWU93?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c65303c9-0ee6-41c6-aa80-08ddb1f95cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 01:57:51.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /H7h04SpcS5AJoPvnCdC8VzztHMdDNZvCQgZh61v99/tNUkErO6p4+vHJCdI/YQekbmBZEpGljb8UwfEZzECKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNeW5tDbmnIgyMOaXpSAyMjo0MQ0KPiBUbzogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGlu
Zy56aHVAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnOw0KPiByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4g
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5k
ZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxLzJdIGR0LWJpbmRpbmc6IHBjaS1pbXg2OiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2Nr
DQo+IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBKdW4gMjAsIDIwMjUgYXQgMDM6MDg6MTZQ
TSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiAyMC8wNi8yMDI1IDEw
OjI2LCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+
ID4gPj4gU2VudDogMjAyNeW5tDbmnIgyMOaXpSAxNTo1Mw0KPiA+ID4+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPj4gbHBpZXJhbGlzaUBrZXJu
ZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyBtYW5pQGtlcm5lbC5vcmc7DQo+ID4gPj4g
cm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
DQo+ID4gPj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsNCj4gPiA+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFt
QGdtYWlsLmNvbTsNCj4gPiA+PiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4gPj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nOiBw
Y2ktaW14NjogQWRkIGV4dGVybmFsDQo+ID4gPj4gcmVmZXJlbmNlIGNsb2NrIG1vZGUgc3VwcG9y
dA0KPiA+ID4+DQo+ID4gPj4gT24gRnJpLCBKdW4gMjAsIDIwMjUgYXQgMTE6MTM6NDlBTSBHTVQs
IFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4+PiBPbiBpLk1YLCB0aGUgUENJZSByZWZlcmVuY2Ug
Y2xvY2sgbWlnaHQgY29tZSBmcm9tIGVpdGhlciBpbnRlcm5hbA0KPiA+ID4+PiBzeXN0ZW0gUExM
IG9yIGV4dGVybmFsIGNsb2NrIHNvdXJjZS4NCj4gPiA+Pj4gQWRkIHRoZSBleHRlcm5hbCByZWZl
cmVuY2UgY2xvY2sgc291cmNlIGZvciByZWZlcmVuY2UgY2xvY2suDQo+ID4gPj4+DQo+ID4gPj4+
IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+
Pj4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4+PiAtLS0N
Cj4gPiA+Pj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbCB8IDcNCj4gPiA+Pj4gKysrKysrLQ0KPiA+ID4+PiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4+Pg0KPiA+ID4+PiBkaWZmIC0t
Z2l0DQo+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2ws
aW14NnEtcGNpZS55YW1sDQo+ID4gPj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gPj4+IGluZGV4IGNhNWYyOTcwZjIxNy4u
YzQ3MmE1ZGFhZTZlIDEwMDY0NA0KPiA+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiA+Pj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4g
Pj4+IEBAIC0yMTksNyArMjE5LDEyIEBAIGFsbE9mOg0KPiA+ID4+PiAgICAgICAgICAgICAgLSBj
b25zdDogcGNpZV9idXMNCj4gPiA+Pj4gICAgICAgICAgICAgIC0gY29uc3Q6IHBjaWVfcGh5DQo+
ID4gPj4+ICAgICAgICAgICAgICAtIGNvbnN0OiBwY2llX2F1eA0KPiA+ID4+PiAtICAgICAgICAg
ICAgLSBjb25zdDogcmVmDQo+ID4gPj4+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0ll
IHJlZmVyZW5jZSBjbG9jay4NCj4gPiA+Pj4gKyAgICAgICAgICAgICAgb25lT2Y6DQo+ID4gPj4+
ICsgICAgICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogVGhlIGNvbnRyb2xsZXIgbWlnaHQgYmUg
Y29uZmlndXJlZA0KPiA+ID4+IGNsb2NraW5nDQo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAg
IGNvbWluZyBpbiBmcm9tIGVpdGhlciBhbiBpbnRlcm5hbCBzeXN0ZW0gUExMDQo+ID4gPj4+ICsg
b3INCj4gPiA+PiBhbg0KPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICBleHRlcm5hbCBjbG9j
ayBzb3VyY2UuDQo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICBlbnVtOiBbcmVmLCBnaW9dDQo+
ID4gPj4NCj4gPiA+PiBJbnRlcm5hbCBsaWtlIHdpdGhpbiBQQ0llIG9yIGNvbWluZyBmcm9tIG90
aGVyIFNvQyBibG9jaz8gV2hhdCBkb2VzICJnaW8iDQo+ID4gPj4gbWVhbj8NCj4gPiA+IEludGVy
bmFsIG1lYW5zIHRoYXQgdGhlIFBDSWUgcmVmZXJlbmNlIGNsb2NrIGlzIGNvbWluZyBmcm9tIG90
aGVyDQo+ID4gPiBpbnRlcm5hbCBTb0MgYmxvY2ssIHN1Y2ggYXMgc3lzdGVtIFBMTC4gImdpbyIg
aXMgb24gYmVoYWxmIHRoYXQgdGhlDQo+ID4gPiByZWZlcmVuY2UgY2xvY2sgY29tZXMgZm9ybSBl
eHRlcm5hbCBjcnlzdGFsIG9zY2lsbGF0b3IuDQo+ID4NCj4gPiBUaGVuIHdoYXQgZG9lcyAicmVm
IiBtZWFuLCBpZiBnaW8gaXMgdGhlIGNsb2NrIHN1cHBsaWVkIGV4dGVybmFsbHk/DQo+IA0KPiBJ
biBzbnBzLGR3LXBjaWUtY29tbW9uLnlhbWwNCj4gDQo+IAktIGRlc2NyaXB0aW9uOg0KPiAgICAg
ICAgICAgICBHZW5lcmljIHJlZmVyZW5jZSBjbG9jay4gSW4gY2FzZSBpZiB0aGVyZSBhcmUgc2V2
ZXJhbA0KPiAgICAgICAgICAgICBpbnRlcmZhY2VzIGZlZCB1cCB3aXRoIGEgY29tbW9uIGNsb2Nr
IHNvdXJjZSBpdCdzIGFkdmlzYWJsZSB0bw0KPiAgICAgICAgICAgICBkZWZpbmUgaXQgd2l0aCB0
aGlzIG5hbWUgKGZvciBpbnN0YW5jZSBwaXBlLCBjb3JlIGFuZCBhdXggY2FuDQo+ICAgICAgICAg
ICAgIGJlIGNvbm5lY3RlZCB0byBhIHNpbmdsZSBzb3VyY2Ugb2YgdGhlIHBlcmlvZGljIHNpZ25h
bCkuDQo+ICAgICAgICAgICBjb25zdDogcmVmDQo+IA0KPiAgICAgICAgIC0gZGVzY3JpcHRpb246
IFNlZSBuYXRpdmUgJ3JlZicgY2xvY2sgZm9yIGRldGFpbHMuDQo+ICAgICAgICAgICBlbnVtOiBb
IGdpbyBdDQo+ID4gV2UNCj4gPiB0YWxrIGhlcmUgYWJvdXQgc2lnbmFscyBjb21pbmcgdG8gdGhp
cyBjaGlwLCByZWdhcmRsZXNzIGhvdyB0aGV5IGFyZQ0KPiA+IGdlbmVyYXRlZC4NCj4gDQo+IFBD
SWUgY29udHJvbGxlciB0YWtlcyBvbmUgb2YgdHdvIHJlZmVyZW5jZSBjbG9ja3MsIGludGVybmFs
IFBMTCAoY29udHJvbGxlZCBieQ0KPiBjbG9jayBwcm92aWRlcikgYW5kIGV4dGVybiBjcnlzdGFs
IChjb250cm9sbGVyIGJ5IGEgR1BJTykuDQo+IA0KPiBUaGVyZSBhcmUgY2xrX2luIGFuZCBjbGtf
b3V0IGF0IFNPQy4gRXh0ZXJuYWwgY3J5c3RhbCBvdXRwdXQgY29ubmVjdCBpbnRvIGNsa19pbi4N
Cj4gDQo+IGNsa19vdXQgY29tZSBmcm9tIGludGVybmFsIHBsbC4NCj4gDQo+IFRoZSBib2FyZHMg
ZGVzaWduIGNob29zZSBvbmUgbWV0aG9kIChpbnRlcm5hbCBwbGwgb3IgdXNlIGV4dGVybmFsIGNy
eXN0YWwpDQpUaGF0J3MgcmlnaHQuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KPiANCj4gRnJhbmsNCj4gDQo+ID4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5
c3p0b2YNCg==

