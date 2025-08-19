Return-Path: <linux-pci+bounces-34242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC7B2B8FB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878293AAC1D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A8221FA0;
	Tue, 19 Aug 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OlQrTNa2"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21F2236E0;
	Tue, 19 Aug 2025 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582752; cv=fail; b=OMjjQw/cyQQy2kpb+T5iwJ/rn5dhXVkJ32zf9TPTxwwpdRITQ+4eoCOjgYXi0niwDCwPC2gtYZZuk88qhy2jnOu2vZ0HEYw8GxOzF7O31BZwE2okYPkeIVNYCIFg0xfneXtzAgb5RqqZ7lpYLlXchJZPdjVb02coiiH3nBx2K0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582752; c=relaxed/simple;
	bh=LbLaheOU7O+dVQGlMUSpM2KXOtskKQ9TH1iPH7rJIr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZMfiqLaOfrAyiPEIOPGqs+YGTYRVUl5DU7RrPSYdRhQHMD/lz91MnrxrLFVVSEvZJlqnclhpwKIDdh7vIHWyQTV0sIvHzCg9E0Bjiqmjq4DPigTvo3x4tpQrW8BU6GCdmOhhrvVuUBCjfrv5uW14g6OpLKpzIK40RLc5gOr2Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OlQrTNa2; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnjF9b46sQ/8+BEVCLEWNPOj6OcTZM8nC+mx+6T4GcqLSGDdRgshE76IVrEBMskzz/OwRNHqxBFUiTAlDoTq6VLW10JyLnZF1dD6B3dVnUhaKv3k+ddERsPkQWUAyeuNlWbPVPDMHLmCcY31X2cw/sV98bM4qO9fQRM0v+h8LPhMesFe8NkTAdFCmy9hO4ZIDl9ncRlFhvkS6UehBpn2n7DYYqR8BP9CV4U5c9f6KGnyccF2U1s1IOrKdo9aC+zUZNFGRk5/EcbRAZAkVKFFAZkeBOqsP9Np0Xzu6/7LFgzpK+nYKQYe1E2UoSuJ0tGrS1LbqCED0yWNmi2xyjHQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbLaheOU7O+dVQGlMUSpM2KXOtskKQ9TH1iPH7rJIr8=;
 b=P5pe6HXduyJg7MrgwBryieRKsAYibS/koCSfqk0tIqKq5wNFPU4fo7eHWWZa4urbmWlGM7vHPbIYdhcYa56MnZpCwLOYRGYfnP2rTaulwBJ1GFrWjy1bw+9WAGwXDAyHW6yUG69LzVq8yKvDyHNl20EIFsTjvDgmXjM6xUwv5W39iTZDrvupPzLJm30FiMGJ8iePvfnXMvt2zOsmx7j6FQBAZeWNbXv5gSRf5CEnMyaloyrPB7tYIEUf7pbh6hOfBfp7WdBOum4UZxpsOb5+cLq+YhzTbEUDwCIGUvhdx1wDEORZHJ2MBuIAsfEMlpagK3KRBnFzztXqdgoIIqSHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbLaheOU7O+dVQGlMUSpM2KXOtskKQ9TH1iPH7rJIr8=;
 b=OlQrTNa2R7ADsbzvwwWjOVN8FI21RQGAgLU2Wawn4PWFKWxKCooaJGdWapCsWMqVA2425cdySmEGeG5+xCJUoU9eO0YGtGg5Ua3uimXUjdzka7a4UDjArCWVrzch1dqWeZTeBLDndu9TRs6UUYNdRRGw6dTfcQlwTsUPQ2nnqAGzX6vM/sfablndWsxcxX4CAEeXDbrqJKhCEzK7hTzadqEVzVCjEuheqhtWJxfaKbqjtlaaNMHSW3VVxuawiAU2y1rIEco/n16+zYISgEj3HLrl6W9x7nO8Kt9NYNiw3jk4gRb2uFqaD/yx76Pi5DkUZ79HSRFBVktt5a/k+F3RXg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB8089.eurprd04.prod.outlook.com (2603:10a6:10:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 05:51:41 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 05:51:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Topic: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Thread-Index: AQHcEBJEElOYRUyYLku2WlVlqYn0A7RojvWAgAC+oRA=
Date: Tue, 19 Aug 2025 05:51:41 +0000
Message-ID:
 <AS8PR04MB88338A64A256C92CE64A02018C30A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250818073205.1412507-2-hongxing.zhu@nxp.com>
 <20250818154833.GA528281@bhelgaas>
In-Reply-To: <20250818154833.GA528281@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DB9PR04MB8089:EE_
x-ms-office365-filtering-correlation-id: 714b2248-d7b8-45f0-5b52-08dddee47884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q01XT3QweTE3ZjdGMGhIUXF1cVUyZmp6R0pCWmFrOC8yNkhXYlBZZzRyTVJ0?=
 =?gb2312?B?TWRGSnNVZWRYVUhQQ2thQ3B6SkxJd1JkckxsRm1MalEyRGh1VmhTdE5CRHNE?=
 =?gb2312?B?UDJ6U05sejBiSEFYYnBWNnp4U0E4b3NXcXZYVkYyZUhvZ3VxUFRkcHVmK0ha?=
 =?gb2312?B?aVgyY0p1RW5MdFZuM3dDeEYrMTNPY1djSUZGMGRCQU9SRnVKa2NzSEVXN2Jo?=
 =?gb2312?B?M0thT1hPSEJ0cXc3MHdabDBVbi9jd2FhUWdaeUQwYVJPN1BVNFVXNXZ2OXZP?=
 =?gb2312?B?VG1DUThSQXdZRGsza1BNQUQwd2dhSDB3Q0NhNWxzSW9LQmg5OVhJbUo3RTZX?=
 =?gb2312?B?OUtCOGIwY3plditNeVFaSW5wVWhjK0ljN0lGT2Q4QmJobzNETmI1dm5sOHk2?=
 =?gb2312?B?VUVXcGlTS1BVeDhkaGJMam5ISXJHOTN0ODU2OEJQR212VTFybDZzSXJ2Vjhn?=
 =?gb2312?B?YlpjZmVmL2w0S3R0b0lmdlcwZVcyYzlHQWo2ZDdPcTBWOC9weVlNTVBXdGdC?=
 =?gb2312?B?bUE3aEtXbEtoMXIyRnk4Y0d0Vm1TeW9qcGVkUUNwS2pBbmFuRFpKY3pJNGsr?=
 =?gb2312?B?Rk9sZ2k3NnJ5RE5NMGJRNEgya0ZiWDI1WVczU0trUVltY1JEQ29qNnpVZm1w?=
 =?gb2312?B?blVQWE43Q2x4ZE1PSG13WmlZY0wvaW1QSGZPeUVoQ1ljcGhBVlVETk5BQlpV?=
 =?gb2312?B?OEN0a2lxRHBFUWdKZkowQkxneXlTSnFEMVRoQUJDM1A4S0w3Y1FUVHcyYkcr?=
 =?gb2312?B?ejJIRytmM0NTMnB1MlF4cFZmdW5WeDQ4bkpvUk82Mkh1djB1cHBpQXY2RmxK?=
 =?gb2312?B?Um1wbUR6UFFkRVhxR2VhRVlNVGZkbjF5T09DbU5XTWM4UFhUY0FSZUtrbU9N?=
 =?gb2312?B?RzNLek9oK1NiN3NhNk9IY3NVQWRBV1BJbzF2djZYeXFzWDFrYzRoK0dDYVhP?=
 =?gb2312?B?aGp0c1RvVXA4S3pkaFBiVVc5V2NJNFhCYmNqSXRPU1lVSVNmTmk3VDFMZlN1?=
 =?gb2312?B?dGhXeFJ0dDl4bSs0NlZ1ditUWktLRnVleUF1MzN6SFNNSlJyTzN4RWVrZjV3?=
 =?gb2312?B?bG1MN20weUFtWjJPTE9EYlBSN0Z2M0cxZThVS01IYWlGM2ZITEpZOUxYQSs5?=
 =?gb2312?B?TUdSeENHZGorKys0cUl5SGFBckxlZUJKV0hMa0ZMaWVOOVBHUklJMldXSXAw?=
 =?gb2312?B?UmtNTnhVN0sxaEZDTXBMMVAxLzNXZGMrem1oeVJJSytMaXdyWk9iWXlxRW5C?=
 =?gb2312?B?Y3AwU2tQenRCQWZNaUlvV1NnMnRXV0d5N01acHozRUpheTcxR3RrUmlDUUpz?=
 =?gb2312?B?NGQ3YVpsb3lWYUNWa3VUK1VxSXdxSVN5NnpMemF6alNOdmNCVC93TzNBR3Y5?=
 =?gb2312?B?bWRRRXRDVWhNVEs4N09BS08rNDRLRGwxdDJnckZzbVd3SUJPc1V5Yndad0pn?=
 =?gb2312?B?WWxrYW9vUHZzQ2gxYWU1a3AvdzZidGZCa2ZVWkxRZVVvcGZzemlyQXBzSEVl?=
 =?gb2312?B?M2hiZldEazRXelN3aDhLMVRXalAycUJNVmUxZ0pGSFJGMzVvdmZyZ2wxaGRy?=
 =?gb2312?B?VWNSeGNnK1N0LzJvQ1NoTVpjQjgzd2hJR0RIY3pMZ2xMREJYbS8wWUM5c1Ns?=
 =?gb2312?B?aVNjR1A4L08za2NmRk1HMEVMRkVlWE04cWtFRnpXaGFCN0tHUk4wVGw5dTlT?=
 =?gb2312?B?cHA1U2hWOGMxQUNxNFhmQzlIaFkrL3lkMW1ZTTBMd0czNC9LeGEwaFRodndG?=
 =?gb2312?B?b0JpWTdaWkxiR1ErcklxdEM4Ti9tcTN1VzVmaitTUDZmekhqNDFDb2lIOFMz?=
 =?gb2312?B?ZUZlRzEzYjNCZldCd2JFM3Vtc2RkQkpHSE5pRWxLNGFUSjRHUUlTU0pYZGNO?=
 =?gb2312?B?VWNzM29EYVNZMGx5M3JxQnNROC9hNlZmeWZEM3RTVlkrZ2VxbFZHTGIvOHd6?=
 =?gb2312?B?cGlwWll3bWtSTEhxYmVSbEVDMnVoWHpSSFc1Z1ltejhzQm8wOSt4SlVMbUV1?=
 =?gb2312?B?WnNKaDc5akN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WVRwL1gwSkxWamswR0t1UGJDYzhIOFZBNFp3WFNmZU5FeTAyTkhveEE4bFpM?=
 =?gb2312?B?Mlp2bmpySjY5VTh6QTdnb0R6L3VNb0VUQmpLZEdnR050dXdmQXZsdUlRRVpL?=
 =?gb2312?B?QmU1VENoTkY3WWNUVzZ4VTFsbjRWa0R3NlVEZHliZjZlVC9tUk1BQXNqQkFh?=
 =?gb2312?B?VkwvSEdMdjdqNTRqa0krSzFKb0tmbXN0MzBVMXdxSHc3V1NuNko1TjBtUERi?=
 =?gb2312?B?eXRDV2gxZ2JiN1lsZmhab01HeW5aUGJUNlBoUWM1VWt4MlZNS1ZTV2FESW1m?=
 =?gb2312?B?RjlSRXRka0grZzlLN0pRNGZiOEdHS09sQ3RVRFNjbnAxZHE4VFMyQ3NoODJD?=
 =?gb2312?B?Y3BGb25YS3BvNlZnVm5zNUxYUGhWWEdiRnRDdmRySzFOYkRnaGp2bGx4Vm0x?=
 =?gb2312?B?WHZTdlA4RHFTUnl0YjZBbmthY09QVlNSYzNtTFdWdlpyWERwcnlBSkNqa0Vz?=
 =?gb2312?B?QS8rcitxOW9LY1QrYUJJUE1wc2toMlBzZ0YxUkJPak1mOUhLMDNOWm5sTlI2?=
 =?gb2312?B?TzNneFhNQUFVbGdQY3VIa3AwaGg1ZS9VdGFIelo0K2p0Qi90UjFxUHpvWC9L?=
 =?gb2312?B?d0wwVEpxTFZlN0dyWTgxMll4MU5pU2xRVjlQcHhoN3JITUtDam9UaytSTWx2?=
 =?gb2312?B?bTRUUUhSQmxiSU5yeTBaZjhleEQwV2g1OVFoRlFGZnNueEMwbWpwL1c0aHdN?=
 =?gb2312?B?ZGhBOElDYW9FZlludzh1RXBHUkl5R2U2K0lFVVg5cjRpdXJmSlpLeEVsR3Z0?=
 =?gb2312?B?WjBhOHZzSWlSckswZGo4SVFEV0txWUtMTkUyOEJoTm5aSlRmd1ZzLzloNno2?=
 =?gb2312?B?RStIWjVWRjhqL3FVNDB1Qm8yQ1U3eU5WbWZlUER1U1BLWm1kR3hXOWJqNDBp?=
 =?gb2312?B?bmpTZEkveCtlWWwxNURkMUVnK0pybDNZVHFUMytJdzBPRCt4R2E4UzF1VUNt?=
 =?gb2312?B?ZWJ5MGt5QlBnMFdFd0xTZkhIbUFsMHFmcFo1b2poVHhqclA1VkxGSVRQa1Vt?=
 =?gb2312?B?c1ZWdGFCRS9rcHd2bmNxeWIzaU9hQTBUbWpsaFBsaXVxN0NpbGEwR2xPVXhU?=
 =?gb2312?B?ZjlzYlZyeTJOTGFQWkNlRFdxdjREYTU4Y2FHSVBhK3Q1Z1g2aFpYWStoOERK?=
 =?gb2312?B?Q3RIRktEWlVEd2NoemsyREIzNUFwNXg3eDA5TzhtU3pDQ3ZYb09nWFQ2UFcz?=
 =?gb2312?B?K3ZzMzJSbzh4YURxdXIrNmxKRmwzb2x2WDNseFVqejBLSytvTmVlWmw1WmFX?=
 =?gb2312?B?Z3NNQkVlK1lNUXVxSTZyeE9Cc1g5TDQ1Q25tTXlWZlJDaHZjSmtpbUw0S2FW?=
 =?gb2312?B?RGRSODFkU2JRaVNQVkFPWVhoSlhhQjZWSmhFd01yZEo3TlNsR2YyVTN0UjFP?=
 =?gb2312?B?NXVNRjBwNGRoYzlIQUVJdEdPdUZ0Vm1pVmhiSDFTTGJXQzFRblJQUGZISjlX?=
 =?gb2312?B?Ujd6dDRkdXV1Z0I5djlFNk5GMkRmR084UzBENFFjK3krZkxhT2UwMHQ5TXNY?=
 =?gb2312?B?U3JBL29DSGNlWEhIaW1lbGFWZFNTUzFXTkpOM3dyNURISnlxdGJYUWZRWW9U?=
 =?gb2312?B?QlY3TGhtOTRhc011cGRMV3NUaU9Jc1Y4cmw3b3lEMjY5RFptdm1UQXNtZFI3?=
 =?gb2312?B?SUR1MHBDb08zTVpMUS9XZnhPc1lQR3ZlMFJ5N3VaNkZ4VnVkbmpVelNEVXd6?=
 =?gb2312?B?cGZ1RDlCeUtzL0diUUZmMGtzODRLQ3hRcVY3RkF3Rm1kWWZEaUIwamRjUHgy?=
 =?gb2312?B?Z1JtMnJLRUJvMjRJZU5mR0JRckdNNUFCa3lGK1cwMmtRbjM3OVV5c1Y1RDVr?=
 =?gb2312?B?L0xNQzRpd2lKQjhZclo1ZnpXeWU3cHJUNUFnYUVGblNPMzhucW1KWk9taCt4?=
 =?gb2312?B?Z2Jpck1Nc0doZjRpQlFSVnJMaStlOWZWeXcxblo4UFpRMlNkME1Vd1IvcC80?=
 =?gb2312?B?RVlDcERxNzM0ZDd3cGlKMUxqOU53clRSUHBxN0ptVjVuRGluRCtEbEtRdzhv?=
 =?gb2312?B?YjY0c0ptOWZJYmhDOEdsbmZvNUdrdkNFaGVpWkJISkRSTTlySjJONGtTMVg1?=
 =?gb2312?B?UlBwK0tnODluNE5uTHhFV1lWem11N2ZzQnpWQ0t0WUxWRHI4dGY5RGxaQzVG?=
 =?gb2312?Q?kX/Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b2248-d7b8-45f0-5b52-08dddee47884
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 05:51:41.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jI/7KcJY3DvhSW5YepvBcZdSN9pCIm8PMFDzfoxgHL5qbY3ccmXJ5u6iB6yCmlrGzPJrCJ4Wtd/BsCG8rRgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8089

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jjUwjE4yNUgMjM6NDkNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7DQo+IG1hbmlA
a2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXgu
ZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkVT
RU5EIHYzIDEvNV0gUENJOiBkd2M6IERvbid0IHBvbGwgTDIgaWYNCj4gUVVJUktfTk9MMlBPTExf
SU5fUE0gaXMgZXhpc3RpbmcgaW4gc3VzcGVuZA0KPiANCj4gT24gTW9uLCBBdWcgMTgsIDIwMjUg
YXQgMDM6MzI6MDFQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gUmVmZXIgdG8gUENJ
ZSByNi4wLCBzZWMgNS4yLCBmaWcgNS0xIExpbmsgUG93ZXIgTWFuYWdlbWVudCBTdGF0ZSBGbG93
DQo+ID4gRGlhZ3JhbS4gQm90aCBMMCBhbmQgTDIvTDMgUmVhZHkgY2FuIGJlIHRyYW5zZmVycmVk
IHRvIExEbiBkaXJlY3RseS4NCj4gPg0KPiA+IEl0J3MgaGFybWxlc3MgdG8gbGV0IGR3X3BjaWVf
c3VzcGVuZF9ub2lycSgpIHByb2NlZWQgc3VzcGVuZCBhZnRlciB0aGUNCj4gPiBQTUVfVHVybl9P
ZmYgaXMgc2VudCBvdXQsIHdoYXRldmVyIHRoZSBMVFNTTSBzdGF0ZSBpcyBpbiBMMiBvciBMMw0K
PiA+IGFmdGVyIGEgcmVjb21tZW5kZWQgMTBtcyBtYXggd2FpdCByZWZlciB0byBQQ0llIHI2LjAs
IHNlYyA1LjMuMy4yLjENCj4gPiBQTUUgU3luY2hyb25pemF0aW9uLg0KPiA+DQo+ID4gVGhlIExU
U1NNIHN0YXRlcyBhcmUgaW5hY2Nlc3NpYmxlIG9uIGkuTVg2UVAgYW5kIGkuTVg3RCBhZnRlciB0
aGUNCj4gPiBQTUVfVHVybl9PZmYgaXMgc2VudCBvdXQuDQo+ID4NCj4gPiBUbyBzdXBwb3J0IHRo
aXMgY2FzZSwgZG9uJ3QgcG9sbCBMMiBzdGF0ZSBhbmQgYXBwbHkgYSBzaW1wbGUgZGVsYXkgb2YN
Cj4gPiBQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTKDEwbXMpIGlmIHRoZSBRVUlSS19OT0wyUE9M
TF9JTl9QTSBmbGFnDQo+IGlzDQo+ID4gc2V0IGluIHN1c3BlbmQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgfCAzMQ0KPiA+ICsrKysrKysrKysr
KystLS0tLS0gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8
DQo+ID4gNCArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggOTUyZjg1OTRiNTAxMi4uMjBh
N2Y4MjdiYWJiZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IEBAIC0xMDA3LDcgKzEwMDcsNyBAQCBpbnQg
ZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gew0KPiA+ICAJ
dTggb2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7
DQo+ID4gIAl1MzIgdmFsOw0KPiA+IC0JaW50IHJldDsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+
DQo+ID4gICAgICAgLyoNCj4gPiAgICAgICAgKiBJZiBMMVNTIGlzIHN1cHBvcnRlZCwgdGhlbiBk
byBub3QgcHV0IHRoZSBsaW5rIGludG8gTDIgYXMNCj4gPiBzb21lDQo+ICAgICAgICAgICogZGV2
aWNlcyBzdWNoIGFzIE5WTWUgZXhwZWN0IGxvdyByZXN1bWUgbGF0ZW5jeS4NCj4gICAgICAgICAg
Ki8NCj4gICAgICAgICAgaWYgKGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VY
UF9MTktDVEwpICYNCj4gUENJX0VYUF9MTktDVExfQVNQTV9MMSkNCj4gICAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiANCj4gWW91IGRpZG4ndCBjaGFuZ2UgaXQgaW4gdGhpcyBwYXRjaCAodGhl
IEwxU1MgdGVzdCB3YXMgYWRkZWQgYnkNCj4gNDc3NGZhZjg1NGY1ICgiUENJOiBkd2M6IEltcGxl
bWVudCBnZW5lcmljIHN1c3BlbmQvcmVzdW1lIGZ1bmN0aW9uYWxpdHkiKSksDQo+IGJ1dCB0aGlz
IEwxU1MgY2hlY2sgaXMgYW4gZW5jYXBzdWxhdGlvbiBwcm9ibGVtLg0KPiBUaGUgQVNQTSBjb25m
aWd1cmF0aW9uIHNob3VsZG4ndCBsZWFrIG91dCBoZXJlIGluIHN1Y2ggYW4gYWQgaG9jIHdheS4N
CkhpIEJqb3JuOg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KU2hvdWxkIEkgY3JlYXRlZCBh
bm90aGVyIGNvbW1pdCB0byBnZXQgcmlkZSBvZiB0aGUgTDFTUyBjaGVjayBjb2Rlcz8NCj4gDQo+
ICpBbGwqIGRyaXZlcnMsIG5vdCBqdXN0IE5WTWUsIHdvdWxkIHByZWZlciBsb3cgcmVzdW1lIGxh
dGVuY3kuDQo+IA0KPiBIb3cgZG8gd2UgZGVhbCB3aXRoIHRoaXMgaW4gb3RoZXIgaG9zdCBjb250
cm9sbGVyIGRyaXZlcnM/ICBJZiBhbnkgb3RoZXINCj4gZHJpdmVyIHB1dHMgbGlua3MgaW4gTDIs
IEkgc3VwcG9zZSB0aGV5IHdvdWxkIGhhdmUgdGhlIHNhbWUgaXNzdWU/ICBNYXliZQ0KPiBEV0Mg
aXMgdGhlIG9ubHkgb25lIHRoYXQgcHV0cyB0aGUgbGluayBpbiBMMj8NCj4gDQo+IFdoYXQgaGFw
cGVucyB3aGVuIHdlIGFkZCBhIG5ldyBkcml2ZXIgdGhhdCBwdXRzIGxpbmtzIGluIEwyPyAgSSBn
dWVzcw0KPiB3ZSdsbCBiZSBkZWJ1Z2dpbmcgc29tZSBOVk1lIGlzc3VlIGFnYWluPw0KVXAgdG8g
bm93LCB0aGlzIGlzIHRoZSBmaXJzdCBvbmUgcm91dGluZSB0byBkbyB0aGUgTDFTUyBjaGVjayBp
biBMMiBlbnRyeS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gQmpvcm4NCg==

