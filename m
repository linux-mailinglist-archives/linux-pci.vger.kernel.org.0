Return-Path: <linux-pci+bounces-14838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B408F9A3221
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 03:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8691F22F8A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9D6F2FE;
	Fri, 18 Oct 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7pUSsW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418256742;
	Fri, 18 Oct 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215551; cv=fail; b=e50EAg7zM1vujs2OFlK6EaX5NWgeSxJ1LFZqzvIVjXVOdzURCOvadS+PT4LFziBjWqrsmJaP13kgkN78re7PR+KxgPKbrZPnKVUfH8G2P+NMUD9OFMju8zGgF2UPRf6L6RF2spJkRyY/FV2OTS+vcXILlT6JLIT5KGOg+sQs+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215551; c=relaxed/simple;
	bh=A10AsX2H7AlcaeRzr0c9JBvFW5iGyFlOurWXG3hsgh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bz160f0ZT712QY+xZ0i+P9vK5uJZc1hB7GL+0/9WALd/1rgOG9ms/t3P9IB6IdvzN31l1Fms5XP3zv+nYXYIFTRWERZ5MOOrdOu5N+0mFEYB+VSb31qWI7q0MF/o5J6L5KwE6vvhcZWzPuoQHKmIps/eV71YKyOetNUFI/P/PBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n7pUSsW1; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPVtm27FK+NbFQ6mvYSugFuEMGuwFbNCCdt+J04KlAU0ukMJfzw6YU7YQwGF3wO2iDG4fCrFGLKjhc5ZjRbeSatwiMM2BorNjfFvaGTtQQ9Xa4E58+0h5Q67HtwSDQrS6cAO9uFHVnvfV0906XCNvY5ic3jsyYgKUqB0a5Fxf4v2azexJf9iCZxuMqO1tjZ1WalJ6l4wbsxo/C1B/0/lSoFq9hKl45aXFw+Cs7ey7Ko50K5vx4d5KEuP8MjRgW9j5aNxHTvDngGFdfR50CDjODb0xas2iPaa/OWJPky/55ec5yHC+aftPrtCpIu7WBRghOiXXfThTT3AqFzFxbg5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A10AsX2H7AlcaeRzr0c9JBvFW5iGyFlOurWXG3hsgh8=;
 b=H77RI4JyoZ/ZTvuK0LOX1M5M1h7npmYmZvXepcMuNVv7mql1un7Q75Y9YTwEDIF57l4PP7tiy2oljwNUDgX/C6TuZXg2b/7gwxTAK/+kwZv3hiAwUNXDe97Av4iC895p88oxP7PMRKBfE8Pls8oova+VHKYehLGi/w4oWUoGCYlZaqp5Aj31oR2c35CYxsetCPCtioJWB6py58dUY66rrOrK2aj53h0Ti04iTHX7glcXSnl5DJRQMcp68YQC8PcdlJoFfwsyghKT144QZzL2ZKueuVtv58raTrfQy5g75nn6YnkwcYZChtszLnGdYGyY0marhH0fDgZocq45oaL8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A10AsX2H7AlcaeRzr0c9JBvFW5iGyFlOurWXG3hsgh8=;
 b=n7pUSsW1vDPuFcWdRRVEy4e4s43I/T+tnIS6izWD2kU4S8Qz8tx5JFuEVPEmL62tavEK3deKSTexcuMmwz7C3Nx0cAN14W/v6I/jzeMScitfC1ZdufBDDBZ9IbQ+os0gd+NtVJjH+1SpIj2/XvHpMu9sXDKF7Da+P41Z3Fatnqrjcyk0Nbp4QcsN7MNfMv+/lQX9saJhdG8PG14EvOaaCTS+M0s2vIyzwhYUeuMoxiVpCmKWdHO0XNBCq5cgitLCwBuQK3R4r2wop+e5SrFgTGwMTbSCRTJABpfW+JAfsVrp12LW5dzXB1HLPqawiaalKlMKm41ZsD4nYu9Gpm2L0g==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 01:39:04 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 01:39:04 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Frank
 Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 0/9] A bunch of changes to refine i.MX PCIe driver
Thread-Topic: [PATCH v4 0/9] A bunch of changes to refine i.MX PCIe driver
Thread-Index: AQHbHuBBS7ZlRT6V9km3hIIquEv/SrKLvaWg
Date: Fri, 18 Oct 2024 01:39:04 +0000
Message-ID:
 <AS8PR04MB8676DA240C9694259EDB06598C402@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: 484fa163-e0c0-4bdc-8a9c-08dcef15a683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?REFzYzk3SWt5UHJUenpkRnhyMVJINVNxb2ZhSEtiaDE2YjdzQktiVXJvbFlY?=
 =?gb2312?B?bXJpTnlyU1FJUThVcDZ5Tnlldms5NGVOQWhvdnNHUDlkNXVmVFJ2bXU5RmZY?=
 =?gb2312?B?TWQ4UjNkT3pja0xYRFA2cldqZU04ZlRNNkhQaVlMbzJocWVtYzcxdlA1Y1F6?=
 =?gb2312?B?R2N0WlFYQnpCZkdKaFlPNzI2c1FSMHJqR2N4QXM2UUNObFExRURqY1MyTXJ4?=
 =?gb2312?B?TnNzQ2ZTKzZ5QzlLVzQwclpDTUJGRFpuYWE1aGZIT1ZSODRPWmFpWlRVcTBS?=
 =?gb2312?B?bTZjenRiWkN1YTVmSHBjeHJKcTlsam1IMk1DcEFMZTR3T29QNjBHOHBseFJa?=
 =?gb2312?B?dXVHeEt6Tm9vb0p4R3BScndWVW95eWdseTBoN1VqWk5PM0x5Sll4UXJsSUx5?=
 =?gb2312?B?d3hZaklFVGd2dW10VGNybGxCRWlGRkxpQjNWZjlWZ042bUxPQjNpS3pTVndE?=
 =?gb2312?B?STBrNDB2Y1ZQeTM0aVRJbGtTZy95YnBkOFF4d01MSXhsR0h5MUlQS3lKZzNX?=
 =?gb2312?B?Y0xwNmhJOStTUStjRXRUdHBSd2ZVYzdVQzFnUEg4bFE5aFZOU01uS3h3SGI4?=
 =?gb2312?B?cjhKSHozeDdkRDcwWHBOTFFYYnJPYWg3cmV0M3ZtRGJhemszK3JQbkhzb3Ey?=
 =?gb2312?B?MTJYSnQzWDB6aHdxcXdXV3FjSUZPbG9ZdUZiUnlHa2cvWXJZTXpINDVTdXBJ?=
 =?gb2312?B?aHRSZVdwM05WOE9lcEt2N3YwdDByTWR4UXdBUUZ0QmhLdXJPK0FJTm1vOFhp?=
 =?gb2312?B?amJxSmRSSm9adDBPMzVxMU5LMnE0ZEZMOVhsSE1kQ1pDQ3NMeGhmeDhwblV1?=
 =?gb2312?B?U0RSbTB6L253K0pKTkE3aEwwaG4ySzArdEsvS25aalBFZXJGWnpuTktTYk9V?=
 =?gb2312?B?dDVPQkJ3TkxTZDZRRHBzS3JSaWhTd0xmYThUOUdOZDg1RkdhZWxKdEZVS3Ar?=
 =?gb2312?B?VnhzY0VocFI1cDJxMWhxREU2VEg3QTZITXBLU212aHFsbFZVMFVPQnFGYmho?=
 =?gb2312?B?R0FjQXFpVmtwSU9mdjMrSmlwQkJMMllYK0FPekRDajFiYk9DVm5CSlpXdVNa?=
 =?gb2312?B?djV2ejBsWk5zZmRyaHczdkF1UXczbUFicUZUdmUxWVNtNHNTNitrOWpSZ2ls?=
 =?gb2312?B?cDA5YU5ncHJkMUI3UnlkbFFSeWJUR1dBdnQrS1lCRUwzdTY0R2dBSnFaSitW?=
 =?gb2312?B?Vm4zOFdwaWJLNDFrbUFKZ205TWdXcDZEbVhsbmR0dFhGZnhtNXh5WlJpdE1j?=
 =?gb2312?B?T2VCZm4zeWpYdU15TC9VWkovdUNZOWlGRy9tR05uUlpsR3BGeE0ybjZuaDN5?=
 =?gb2312?B?cUhsaXRIRjhtd0VyTlA2UTFNUHhQY1dkVkY2bnJqVHY2YWVLY2VGSFN2NWpn?=
 =?gb2312?B?M2s0cXRRK0J0ZFlza3VvT1NsR0hGYjNBNTUybEdSaFBkRnVPalJqVWg3ZE5n?=
 =?gb2312?B?cWt4Vm0wamlNUTlJZDhXMVRwaWc5TGNVVjFrSldGdVhyalpUZnFiVGVHQ0Iy?=
 =?gb2312?B?TVErZlVYSDJxWnVWL0pMWXM4VTZmSzhwdUxINXFwZ2trclloTTcxbTYvUHRR?=
 =?gb2312?B?NFJ2RFgrY2ZvVmdrcHdXODdrdng4dDJWMFhMTCs4ekJCOHc3azlNTE5sUC8x?=
 =?gb2312?B?SjE1UStkYXVPbFlHSlFhZkJwYnFMU29LTlFxUDZkSklNd0pjYnlQR1FEa1BG?=
 =?gb2312?B?eHFZV1d0eDRzdW1DZnc1ZlAxZGJ1T3c1clRJM2xpQXBaL3JwWXY3dStYRmpU?=
 =?gb2312?Q?ujkvq7i/2MjmfcBmX5rs/hdH9RFnPps0W5q2R2r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dk9YdzByUm1OZnJpbVRMb3hiL0R2RmtEblhHdFdrZHhkV3Mwb2FvNkhtUkRq?=
 =?gb2312?B?Q09QTHFOblJ5UGYwUzdtcVRZTkhaRDRiajVmQ2szQmxTdzB0djRFWHVqdjlX?=
 =?gb2312?B?cnBvSVNiMG9QVzVIbUpTVkpBdlJ5cjJSVERrSmpRblJKMVg1WDR0RkVQa3dV?=
 =?gb2312?B?N2luRlU1ZENEd3l6VHEzRmREQTBJSFh3UDFkaG83UVhlbmpyQmU2WVFsNWxv?=
 =?gb2312?B?M1pBYUloTWNJVWVhNklJT0dRNTV6N3NGOWdPN1BDdk5RUW90M0QwdmtrYzFh?=
 =?gb2312?B?K0ZWbmlJSGpSUHlYZTJ0bXVuTGJJMGxPU2FER2g1bWZCbEpaTWpZRzJvN0gz?=
 =?gb2312?B?d0xCZnhXOE9ocTBQdzVSVlhsWS9WS2IzVUUvckd2OVMzWkJsbUhDVlUycy9E?=
 =?gb2312?B?OVV6U01nK2hEQTVlSFZlL0h6QmdkeVV6a1A2SHdUYU5sYld5QWN3bDNtZUNN?=
 =?gb2312?B?aTlGQTNURVJJYjRrSGpVRVVuZWVJQytvUHRocFpFdW43ZUpuWmtkR3M5MUts?=
 =?gb2312?B?eit3RzFJRDFlZzRwWjVZYVRpMTVkRDBYaU55TGREdDNHOVM2RkVSeHhDSm5P?=
 =?gb2312?B?QnJrNTJOb3M4NVJraXhLbjc2TEEzWVFVYW9zcFdRcUM3STd1L1dOWkUrSWNt?=
 =?gb2312?B?ZlpLMjJNSEpBVlg5Zk9YRWVRSnU2ZVZYTVlYS01PYWorZXVkYXJXWEJpa1Zy?=
 =?gb2312?B?QXhmdS9PMzQvZWZNNFg1QkNrbndPQkVaSmlmemx3cHJDSERpUkxIMHc2Y05R?=
 =?gb2312?B?dmU1MHdIcGROYUxTbHY5bzVQcytZSUxrb3paUnZDMHJPV1Y4SkJxUDlzVTJy?=
 =?gb2312?B?K2RFT2RXKzVySkZNN1phRnhDNjEvbjdqaGZMZTlla05wTU1QU2R5aU84TTRO?=
 =?gb2312?B?b3JPbzEwYmVxRkhwTEIxZFJpVmh6Qk9kakdpaUExeEZLRVFscjlkTGwyaVVC?=
 =?gb2312?B?WGlGVklHL3JNeVV1UDhCNi9SbGRYTzMzTW5FQk8zazV6eVZUaFk1cWNhN3NB?=
 =?gb2312?B?NHFNL1NOeC9pVXVvRDgxZDVTeGNJeEZUSm0zVGR2RUtIaFNCeTB5Vmo1b0JU?=
 =?gb2312?B?QnZPWjYxbWM5czBSNHlIMTdYNTM4MlptbnVJekdQUmhIMitGYjVIcVo3dFNr?=
 =?gb2312?B?Uks4Vm8vWDV0QTl2Q1ZhQUJZbGYwWmpwSno3aithViszdDlmczRTdWRuZ3B3?=
 =?gb2312?B?d1g5VkJOQndaajhlQlJHUEdseUdLeGVVNkkzUk1aY2UydFJlOFI4TkoxTnR0?=
 =?gb2312?B?bm5PbzFxMjQ5V1pGQWFpalE5a3dBNWlOQXBwNHUvWE02WGNabUNobE8vSjE1?=
 =?gb2312?B?UDhXamxNdEVnYkJxdVpwaHNVZlZka1VzaVYzcDdzQy9BUi9ZOGIvUzV4RUZ2?=
 =?gb2312?B?SVByOUF0UVdnaHBZSVdYODhIRTBOcTVHTktCcEhsakcrbHpJNFpVYlZYSUkw?=
 =?gb2312?B?ZjVkbDNwVy9SSmZyWEVVZkxTcHlOai9pOGZjR2V1cTZhVjZTVTA1aXZlY29E?=
 =?gb2312?B?VlEzbmtUQ2pSbzBRRDNBWEo4VkUva0JIaVJhaTVtbmphdDYyWjZKZmp3KzRY?=
 =?gb2312?B?MVBzZkU3ODJPSUxXL0J6NTNubkdVRm5qMlpNWWx4Vkt2Qld4aUswTmRYWEhl?=
 =?gb2312?B?THN6bHZpdUphanAzaS84WW01SG9Yb2JkbnVZU3VtTnpiZjJCVHliLzNsWmpE?=
 =?gb2312?B?RXJhakxaOExISmVvbEFpSElPV00yd0JyVzhXRkxGVmdITzAvK0tTNy9uTzdy?=
 =?gb2312?B?NHNxNzlOajRTSHJQTlBUSzRlRUxrb0x2RHFRVnBoMGdBTkwwTHI2TTJucGw1?=
 =?gb2312?B?NXluYnRrOFVpZFJkaUxiaHk3WjZwdzFUYkdUaHM0b0QvelFVTElQcVFDaHdv?=
 =?gb2312?B?bmlqTHQ5bmRSa3lUcHlrQXl4YTVVZXFNcEFHQXhsWTlGeU1qS2lKVG9YRC9k?=
 =?gb2312?B?ZHBwcVlRNXR6ekZiVnNPemFtNVlwNGZtMXBXSm9KVVpJL25vYUdwTkxCcWcy?=
 =?gb2312?B?aDB5NFErWGVRVm1aYnJxWWNSWjdoQmIrWkdrWnNwbkZnVFZDbStXbjJrNFc4?=
 =?gb2312?B?OUJZa2tIZWFPNlhWWld1eWREdlBIeWZydWpWYnFVN1N0c0hydkljdEVDVlhU?=
 =?gb2312?Q?ODN+z5Wo2mVqkcwjbYdAFZOfb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 484fa163-e0c0-4bdc-8a9c-08dcef15a683
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:39:04.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Jkp2oCo3HjLW0Po0pe8VtoswMeVcxqtbTArrSG5uyNkcaRhlKrftuawbJGGCk7hF1mrHm1WM3pSxwUXheKHhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

SGkgTWFuaXZhbm5hbjoNCkNhbiB5b3UgaGVscCB0byByZXZpZXcgdGhpcyBzZXJpZXMgcGF0Y2hl
cz8NClRoYW5rcyBpbiBhZHZhbmNlZC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgWmh1IDxob25neGlu
Zy56aHVAbnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE1yNUgMTY6MzMNCj4gVG86IGt3QGxp
bnV4LmNvbTsgbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7DQo+IGJoZWxnYWFzQGdv
b2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5j
b20+Ow0KPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyByb2JoK2R0QGtlcm5lbC5vcmc7IGNvbm9y
K2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlDQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFtQQVRDSCB2NCAwLzldIEEgYnVuY2ggb2YgY2hhbmdlcyB0byByZWZpbmUgaS5NWCBQ
Q0llIGRyaXZlcg0KPg0KPiBBIGJ1bmNoIG9mIGNoYW5nZXMgdG8gcmVmaW5lIGkuTVggUENJZSBk
cml2ZXIuDQo+IC0gQWRkIHJlZiBjbG9jayBnYXRlIGZvciBpLk1YOTUgUENJZSBieSAjMSwgIzIg
YW5kICM5IHBhdGNoZXMuDQo+ICAgVGhlIGNoYW5nZXMgb2YgY2xvY2sgcGFydCBhcmUgaGVyZSBb
MV0uDQo+ICAgWzFdDQo+IGh0dHBzOi8vbGttbC5vci8NCj4gZyUyRmxrbWwlMkYyMDI0JTJGMTAl
MkYxNSUyRjM5MCZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNA0KPiAwbnhwLmNvbSU3Q2M3
NjM0ZWU2ZmI4NjQwYWIxMDI4MDhkY2VjZjc2MjA3JTdDNjg2ZWExZDNiYzJiNGM2ZmENCj4gOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg2NDU3OTQ0NTQyMzkyMjglN0NVbmtub3duJTdDVA0K
PiBXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQw0KPiBKWFZDSTZNbjAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPXdBSXhYNWtHUzNP
WlMzM0dmRFZkbyUyRk5PZg0KPiBBeFd4c0E2U2MlMkZBT2xYa3V6TSUzRCZyZXNlcnZlZD0wDQo+
IC0gIzMgYW5kICM0IHBhdGNoZXMgY2xlYW4gaS5NWCBQQ0llIGRyaXZlciBieSByZW1vdmluZyB1
c2VsZXNzIGNvZGVzLg0KPiAgIFBhdGNoICMzIGRlcGVuZHMgb24gZHRzIGNoYW5nZXMuIEFuZCB0
aGUgZHRzIGNoYW5nZXMgaGFkIGJlZW4gYXBwbGllZA0KPiAgIGJ5IFNoYXduLCB0aGVyZSBpcyBu
byBkZXBlbmRlY3kgbm93Lg0KPiAtIE1ha2UgY29yZSByZXNldCBhbmQgZW5hYmxlX3JlZl9jbGsg
c3ltbWV0cmljIGZvciBpLk1YIFBDSWUgZHJpdmVyIGJ5DQo+ICAgIzUgYW5kICM2IHBhdGNoZXMu
DQo+IC0gVXNlIGR3YyBjb21tb24gc3VzcGVuZCByZXN1bWUgbWV0aG9kLCBhbmQgZW5hYmxlIGku
TVg4TVEsIGkuTVg4UQ0KPiBhbmQNCj4gICBpLk1YOTUgUENJZSBQTSBzdXBwb3J0cyBieSAjNyBh
bmQgIzggcGF0Y2hlcy4NCj4NCj4gdjQgY2hhbmdlczoNCj4gSXQncyBteSBmYXVsdCB0aGF0IEkg
bWlzc2luZyBNYW5pdmFubmEgaW4gdGhlIHJldmlld2VyIGxpc3QuDQo+IEknbSBzb3JyeSBhYm91
dCB0aGF0Lg0KPiAtIFJlYmFzZSB0byB2Ni4xMi1yYzMsIGFuZCByZXNvbHZlIHRoZSBkdHNpIGNv
bmZsaWN0aW9ucy4NCj4gICBBZGQgTWFuaXZhbm5hIGludG8gcmV2aWV3ZXIgbGlzdC4NCj4NCj4g
djMgY2hhbmdlczoNCj4gLSBVcGRhdGUgRVAgYmluZGluZyByZWZlciB0byBjb21tZW50cyBwcm92
aWRlZCBieSBLcnp5c3p0b2YgS296bG93c2tpLg0KPiAgIFRoYW5rcy4NCj4NCj4gdjIgY2hhbmdl
czoNCj4gLSBBZGQgdGhlIHJlYXNvbnMgd2h5IG9uZSBtb3JlIGNsb2NrIGlzIGFkZGVkIGZvciBp
Lk1YOTUgUENJZSBpbiBwYXRjaCAjMS4NCj4gLSBBZGQgdGhlICJSZXZpZXdlZC1ieTogRnJhbmsg
TGkgPEZyYW5rLkxpQG54cC5jb20+IiBpbnRvIHBhdGNoICMyLCAjNCwgIzUsDQo+ICAgIzYsICM4
IGFuZCAjOS4NCj4NCj4gW1BBVENIIHY0IDEvOV0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFk
ZCByZWYgY2xvY2sgZm9yIGkuTVg5NSBQQ0llIFtQQVRDSA0KPiB2NCAyLzldIFBDSTogaW14Njog
QWRkIHJlZiBjbG9jayBmb3IgaS5NWDk1IFBDSWUgW1BBVENIIHY0IDMvOV0gUENJOiBpbXg2Og0K
PiBGZXRjaCBkYmkyIGFuZCBpQVRVIGJhc2UgYWRkZXNzZXMgZnJvbSBEVCBbUEFUQ0ggdjQgNC85
XSBQQ0k6IGlteDY6IENvcnJlY3QNCj4gY29udHJvbGxlcl9pZCBnZW5lcmF0aW9uIGxvZ2ljIGZv
ciBbUEFUQ0ggdjQgNS85XSBQQ0k6IGlteDY6IE1ha2UgY29yZSByZXNldA0KPiBhc3NlcnRpb24g
ZGVhc3NlcnRpb24gW1BBVENIIHY0IDYvOV0gUENJOiBpbXg2OiBNYWtlICpfZW5hYmxlX3JlZl9j
bGsoKQ0KPiBmdW5jdGlvbiBzeW1tZXRyaWMgW1BBVENIIHY0IDcvOV0gUENJOiBpbXg2OiBVc2Ug
ZHdjIGNvbW1vbiBzdXNwZW5kDQo+IHJlc3VtZSBtZXRob2QgW1BBVENIIHY0IDgvOV0gUENJOiBp
bXg2OiBBZGQgaS5NWDhNUSBpLk1YOFEgYW5kIGkuTVg5NQ0KPiBQQ0llIFBNIFtQQVRDSCB2NCA5
LzldIGFybTY0OiBkdHM6IGlteDk1OiBBZGQgcmVmIGNsb2NrIGZvciBpLk1YOTUgUENJZQ0KPg0K
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLWNv
bW1vbi55YW1sIHwgICA0DQo+ICstDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbCAgICAgfCAgIDEgKw0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwgICAgICAgIHwgIDI1
DQo+ICsrKysrKysrKystLQ0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS5k
dHNpICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gMTggKysrKysrKy0tDQo+IGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPiAxNjYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA1IGZpbGVzIGNoYW5nZWQsIDk3IGlu
c2VydGlvbnMoKyksIDExNyBkZWxldGlvbnMoLSkNCg0K

