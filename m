Return-Path: <linux-pci+bounces-35733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D4B4A348
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C14F18970AE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C618A6DB;
	Tue,  9 Sep 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aISWqSIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E2220687;
	Tue,  9 Sep 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402237; cv=fail; b=HRq0YS0V1u8KLNyL3wtl38bNtcTCQfe4T5qJkXBhhKAikWAitTuWsnTWI36cMxOEbKi+FZQQqi2w8WAd8DcoDPcGVkvif6hf6X6BWMx9VoZKNW1twB6e8U/BHF+hgrRDIG0XdBYaMysYpdTDFSDWP6z85NQTBYt/0JOn9dqIoJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402237; c=relaxed/simple;
	bh=HUE79646ifyTCkWbYLz//2q0tj1vyH5ZjgpWyi/eieM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlxcPdpezfHglIX0abj0zv9cfOJDVy8Nz3Ozy0nhKq2leNwgd5J8R5P+HaEbzG+aVSyQi+Hdp21mLm1X0NyzRAt/0qdblS/iLRIrnqAVSvqj+FKYn/v+EEuzeJxDrJyyhlz3kyLcd5gRHi1g1XkEZ2isG2mboHX7KdSmM5+pI7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aISWqSIf; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD5pK0D1bbafPypVcMhCSp8lT3RkYqNTna16TgyqqxaAA5aio/TobJiWVQHUtAg/xa6KpRQMROwVRL2BezNRV/e0KXMpUJ8uC7A9MFTDjHXjjoTAwxiLN5QKFePn21O6zMI498WEqaihnMGOpLCgiV3P3ZrEylA3wgrw7y10O4To6NDmNkB+HteZim4OL4uRjbdBRBg2htyM2CZZ2ciDpzvBQWkidZ3rUE9cLF9OYu0Tq2E1vHjnWND8ITIoHPjtQoyJqGqZIaU6gnj/XkzM0zTXYrJ3Um51g1xJPCm3wEQ+RfZv2TETtRqMJl+ItYxGWUBNDWTIVQmhqYUl0MA9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUE79646ifyTCkWbYLz//2q0tj1vyH5ZjgpWyi/eieM=;
 b=w7vF6KXGIrojJn4hoSY9CEaJ6V4kJBLNjLdI2Flg6bU/VaJp22wBKlKLjYS+BuWLGnnTyBD2Nq2l24JCXBqFUL677UF6AkcluJfB2tPIo/MklJEIIBkJcRBwbuszuHGgNyRHmS7/nMdH4vXW6HX5yt0WWjQ0JPhOcgD275Hdo67d9UQMtQncCDA6a7gCS8T37t5IHhT0N/1sGFa7DyYatjVTC7teXDQLMkNWzlYu9bq+fL6hphd9e3FxRk78SqoVJ9daionl92VMO0crAO8RLQPskXUq9xdt3sS3PZJeAhjzVUcPEnKTBW0FUj+fkgQOa9MHmynDNe066Bdmhf/TPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUE79646ifyTCkWbYLz//2q0tj1vyH5ZjgpWyi/eieM=;
 b=aISWqSIfKp8avd9DgqyzZpk2/CIxuvYoBGjDWpan+qhtH94j7GUs5dmpQvMbjTXgny3NxUuIbnmElsClk0MzybY6P0KFZcLRbWktPhXURHGXRJ2dr0Py87pOpyr1YUxcaYGHLzrZXOSXBYL/zntVKGcVOeuNVH5Y/tnWkf+QbwsCi7gB1xoRG2LdnwA7olzf/bjbiLEvNuoFr8XpsbozBQ4s1xRy1kYobQBDJkefOQXzjESwLJZW9vEgD651mB264hWH2XccGnxoutj9JaeJbBFvqksLKNxSLoJPbAkGrGZLyxtU9HN+97jIK91942UZTLhu0mMRot3NU14DNEIJvQ==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU0PR04MB9494.eurprd04.prod.outlook.com (2603:10a6:10:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Tue, 9 Sep
 2025 07:17:03 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 07:17:03 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ# override
 active low
Thread-Topic: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Thread-Index: AQHcEaoMjRru1StCnESzEOZ/k0fwQrSI6foAgAGJUHA=
Date: Tue, 9 Sep 2025 07:17:03 +0000
Message-ID:
 <AS8PR04MB88335D19BE708CC766C24E2B8C0FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
In-Reply-To: <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU0PR04MB9494:EE_
x-ms-office365-filtering-correlation-id: 25facb47-4547-4ca6-cb72-08ddef70e04c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1RONXJaSTdPczc3Y0dEWXk5SUtqamNFSUMyWENHVzE0c3c5SFN2QkJ0Q1RN?=
 =?utf-8?B?ZnNURGdRekJGdjhVZGlpa3duKzlCTGRielhQcXlDa0tlc1FWODlzRzdPaDJS?=
 =?utf-8?B?RkJYT0xXS0hwOW0xUTQrc1BPYmo4RzRJdisrN0FhOVJNT2kyeFB2enkrdGdP?=
 =?utf-8?B?TS9JdnA4Y0twenF3c3owMzQ5Zmk1TUc5VEdXa3BXL2JZWEVoMy9PUDlRN1Jl?=
 =?utf-8?B?dUU1SXM4aVFRbWcreSsxcEloOFlYMlUwcjJET3ovWjRNYkRDQVdjbHRMZno2?=
 =?utf-8?B?RStaWlhUTERhdjhKV1AwSFpxUzRaMjRqa0p3bVpBVk8vaHBaSm9jSlNYdWxi?=
 =?utf-8?B?Y3dpbWN5SCthYXpqbFFvR0VFK1pWUUVuMExJbFd4Y3VxN2pGM3YxblFkUGdL?=
 =?utf-8?B?UlBvMlN2aGl2dnY3MWJLdkJLUFpDZG9LcEJUdk1wdzlld2MxVlZQdFFKYnJW?=
 =?utf-8?B?TFA2K296V1o3bG0zNngzV2k1WnZwVEtjbjM2eGFqS1NXRFJRQm02bGdSdVFG?=
 =?utf-8?B?RS8wdUY1NWZ5b3c0QnBXVStEcFpHdUZNL2wwbGJ2ell3eDZZOFExTGcvR25k?=
 =?utf-8?B?V3YzZzFJOS9Qb0JlZ1pWdm1rQktFQnVsWmNqR2lXeVJRNnRFdE42TkFHa3Bw?=
 =?utf-8?B?WnY2NkFpd0JWVFVsRnJab0wvSTJuTGxyMDFJWkVJcjI5ZVpCTUZrb2RBNVFa?=
 =?utf-8?B?NGVESnJCeWlVRjVWVEk5aGZmNkpuaS9mNm9tN2pzRnpkUGxHcXpQV0haUmxD?=
 =?utf-8?B?bno5b2d6ejJXQnlmaVpwOWVpQjUyT2FnR29qRW52UDlrNFcvSm9Fc1dUOGlJ?=
 =?utf-8?B?aWVXZWJMamVIcWc0c3VrZG9XN2ZGWmNiUDlKTU44ZjJlWmgvWDkyRE05WkZR?=
 =?utf-8?B?Qk1FMW83TTlybThkTmlRMSszZFBqQU5mS0Q5eUUveUJxUjJRUDVVZ2ZWU1hF?=
 =?utf-8?B?VWthSU1JRjhxT0hTbnJ6cDFJNDh1cFBGS012M3NnbkVPdlNGZmNuUEtES2dZ?=
 =?utf-8?B?K3kvV2FFaVNGeE8vcDZ5bkdxY25wQ0U2aUpSQ1NwaU1zOEhobUNXZTNZOTYy?=
 =?utf-8?B?QTd6N3lEc3BxdzRZNGdWazZSWFlXVjlxRUVZTlovT2dzUCtWRCsydjhlTkkw?=
 =?utf-8?B?cnF0NWxGQU02VUVySDNkZlVzVVlFbHVRUVMrUzE0WW9TVVdwdUVkdi93UndP?=
 =?utf-8?B?ZkVLYXpzRTZ5RjR5QWpiSUoxcmVNb0JuOUlheUtpRFBwTHdJeHJneGdvOVpB?=
 =?utf-8?B?UytoOWNzaFVFNHA0N2xPdEMwTSt5RklFYWVJL3ZKNnJQRXJOT1hTcXFaLzdU?=
 =?utf-8?B?Y0tiRElQZklQYk5uNDBoM25tU3ZvM1NxU3libFFZME1lTVIzTklqYnpuRStk?=
 =?utf-8?B?a0M4Nnh0RmtsN0cvbzVZMUJIaGt4SURic1hCRXF2SWlVaUkvMm1vWEgyTmVS?=
 =?utf-8?B?cSsvT2VTWldvYTh4WjhPdGhJZGwyWmFpUjdEUnRxT1V4NjJjRjdOYlNHMDBT?=
 =?utf-8?B?T0lwSzFjZU5DQlo4cHhFNlMxVjlnREh3bUE4ZVRobkZJK05DeFRoSVQ1aHY3?=
 =?utf-8?B?bVBWQUtPak1ha3BTTnc4c3A0aG5TNDNYNE5OYkZKZnVsc3VXT0tpcFFGdHRK?=
 =?utf-8?B?MFhvOVFQQ3U2Nm1NNGllVzA3MGxpU3R3dDU5RVZQYjlCRWxVeU1EcEREcDBi?=
 =?utf-8?B?Q21UcWM2V1c4SGwwMXpBd3RRand5TENUUzBjblpQS0JJRU41MVpsWnVlbFM1?=
 =?utf-8?B?SXJoLzkvTVEyODJYMDE3c1d5YlFpZ2J0NmtQT0U3TGtoN1EwQjFmL09GeTBH?=
 =?utf-8?B?alVNTUhaaUZ3aGcxbUFBaHE3eU1nbTg4Q3E4R3ZRTWJUVXdPaVBXdE84MVY0?=
 =?utf-8?B?ZksyR3ZDKzJwVXJqanJXWlFEcEMzN0tHbEpBQWxHZkxyUVRlNlZlbEN0amln?=
 =?utf-8?B?QjhIUkxZVTRLSEcrbm9sZzJmeW1YZDhCbUxrMXpsUVlsVkhuSi9hNnF3eDhK?=
 =?utf-8?Q?YeAi5shp4g1TdEd5wj40kFUijpXBaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ai9DaDFFT1kyQTRud0JBYXM4MWF3bVRTK0NGZlFZTE82c2FYck5UU0l3NTUv?=
 =?utf-8?B?TjFXRkJhYzBwZ0FPOXlsd01CZld4d2dyTk82NFFzZ0xUQ3haQXl6eFdaMDhO?=
 =?utf-8?B?TVFkck0yN0dxb09qOGxpRVlucUlQRXVUVGIxS0ZLSWZtVWV4WUFhc3JXbmdS?=
 =?utf-8?B?TUliN0NPcXNUQjVrNWthNS8zTUovTjkyNS9nRSs1ZjZMdlkxNUl0SjY4UXdv?=
 =?utf-8?B?Z1BEUHAzNjFDT0pWdWlYSjR0RTVJcktyNmdmL0VJRVVtQUljaTdlSm1aeVZr?=
 =?utf-8?B?eUxxaVJyS3ZrM2JoSk40QUx6YU9TTGVldE1KMFRNMTRidUlsK0xDb0FEWFh5?=
 =?utf-8?B?eVM4eUozbFUyNENydFdidGluN2h6UjZpb3NrTm5ta2dDUEsvY3JRWk9pZzVQ?=
 =?utf-8?B?a2NaaUViaUo1d1I3UVJ5MS93aUdBRDRVZ2dFVEVBYWZHRnZUK2tET3p2SkVt?=
 =?utf-8?B?cFBHSmVNcjVzNU9CZlhabDhwK0RIbEN0N0ZHK05nMWdwZllMdWpQTDlMOTlN?=
 =?utf-8?B?dFJmb2d1RCtxZkpjVEx0ZCtDdEF2Q0hVVWRIN2k0M2p1M0Fxc1VGMVhZSS9W?=
 =?utf-8?B?TWNNSXV1ZjBId2tnc3B3REhLelRPTnRDTkdqK0ZTanRiZ1VzaVhpeG5MaThm?=
 =?utf-8?B?OTN6WXBkbjNQdi9Hb2FNL1hZMG83YUs3TWlkdFRHZndrVnh5THB4K0hJenJh?=
 =?utf-8?B?c29DMWFEMnpBVUJBaGFwaEkvWDU2MjkxSmhPMTRVdjNVR1AyQlk0R1FxaTQ2?=
 =?utf-8?B?TVQwMGlnMDdGS3IzSHVidndCL0hGYXdMbkQ3cFl4OHNiTFhNY1EwUE1oSFpt?=
 =?utf-8?B?azJrc2sxUXg0eDlmc1BPMmtYN3FnRGRlLzYyYlcvWXNzZWVSZE1FVjJhUTRs?=
 =?utf-8?B?V3NFQjdHNVFvbGRzaTRGdDNaNTRrMG1DNWt1R2t3bS9LalFIdEVSczlOektF?=
 =?utf-8?B?ZTMza0RxM3YwQU1GUHNPT3BLSnQ5UnFjZzdmaFVudTJZckF0eHAvV2VGRVc5?=
 =?utf-8?B?Nk1hYXZXN3krR1EyTVA0dVBmeEsyZXBmRGlWNGlIczM2ZW4xZFRreHdLUnJ6?=
 =?utf-8?B?M0hHWjB3SjdsU3RNOFYvcVBjVUdzNitUY1NtdDgwYi9FQUVTUEpTOUZhN1hI?=
 =?utf-8?B?TWtHTnVUTjRBaHFNSzlBaGUxQnNFd2JzY3hBQmd0YXpwUU5aUVdEQldwdHBs?=
 =?utf-8?B?VjZjMTRMZVNZeGZZSUUxeUFZY1hRb0UvZnJRNEtyQ3FNSHg4SXE1MWdPNVJU?=
 =?utf-8?B?RTFLS1FrWDdkTUhYd25KWTluZ0JwWHE2YlRwVVM0dmdObXdzUHMvVFlBN2d6?=
 =?utf-8?B?UUt4TXN4Y2pqbWFSZlFoS1RLNnlBdWc3VVRjYzJxVW5sQjcrNVB2UWJxbklm?=
 =?utf-8?B?MHN6TjJvek5qT251OFVNNVhSb1pQSXNqeVpEMlQybi9Yd1RVQjJPM3FFbmY2?=
 =?utf-8?B?MjhPK3g3dU9EbVhkR09uU0xwbEZTeXdVZjRRWW05L3hHaHA0b3EyWC9hekwx?=
 =?utf-8?B?Z0psWEdrbExXaVE1YmQ2TEU1MWY5ZFZnQ05LcVpUSFBWMnBXVTRQVFVSUEg5?=
 =?utf-8?B?cGVqcEU5VmJPUEMrdjNMWkNYVGhMa3V0V2c3S0FtZG9wQzZpMEVpTy9CeHFv?=
 =?utf-8?B?R09hSGZxSkFqMTl3SFlEMjVvUTZ0MU1XUVlNb3JDYTNkaFNQV0p4eVNoYzl1?=
 =?utf-8?B?aGNiVEg4M1pKalVvTUZTNmZzV3d5OXZaMk9DRVFybzlMNEorZEVOMHJ4dkUr?=
 =?utf-8?B?dW80L3NQOC9uUkRiTCt0K2R5eXdicDM4MWRaMDF0MlhKTTY4ZDRrbDUvZVdE?=
 =?utf-8?B?NUVJYnVtQUZFUmlMc25hVlpJNS9PbkozQ25FOVM3ODVqSUVDanlreHVEOUVG?=
 =?utf-8?B?Rk5QSTBxVHUxOXpMZWNLUUt0U1hRbmxpd25uOW1uanNNWTJIN0J3SGJPSkdJ?=
 =?utf-8?B?VlFuTFJoRUZMVEVOVVVBR0hpam0wck1vdWF2dkVsREJGYlgyL1Y0Z0pSamlN?=
 =?utf-8?B?bnE4ZnNCQmRqZEgvNDcvbXh6RDQ1MUhWRFg5aHNpSmJZSFAvQm9BRDFwaWJO?=
 =?utf-8?B?MVZPYmpobiswNEZ0cG95RGhJb2Z3b2lOamhnOUNrdjZTMmV1VitSNlRpR1pi?=
 =?utf-8?Q?1BP4yxCB/f7EF2xvClIy5Ccwt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25facb47-4547-4ca6-cb72-08ddef70e04c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 07:17:03.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQ0EPmbIhuX94Pji97nNkpL6zjgnBYoLEPTcE0hQyWBscACX2PxvEx9XeGLSDFo8f0E2X6EmuM9whc3cfoRqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIg45pelIDE0OjA2DQo+IFRv
OiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtl
cm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gUENJOiBpbXg2OiBBZGQgYSBtZXRob2Qg
dG8gaGFuZGxlIENMS1JFUSMNCj4gb3ZlcnJpZGUgYWN0aXZlIGxvdw0KPiANCj4gT24gV2VkLCBB
dWcgMjAsIDIwMjUgYXQgMDQ6MTA6NDhQTSBHTVQsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFRo
ZSBDTEtSRVEjIGlzIGFuIG9wZW4gZHJhaW4sIGFjdGl2ZSBsb3cgc2lnbmFsIHRoYXQgaXMgZHJp
dmVuIGxvdyBieQ0KPiA+IHRoZSBjYXJkIHRvIHJlcXVlc3QgcmVmZXJlbmNlIGNsb2NrLg0KPiA+
DQo+ID4gU2luY2UgdGhlIHJlZmVyZW5jZSBjbG9jayBtYXkgYmUgcmVxdWlyZWQgYnkgaS5NWCBQ
Q0llIGhvc3QgdG9vLg0KPiANCj4gQWRkIHNvbWUgaW5mbyBvbiB3aHkgdGhlIHJlZmNsayBpcyBu
ZWVkZWQgYnkgdGhlIGhvc3QuDQo+IA0KSGkgTWFuaToNClRoYW5rcyBmb3IgeW91ciBjb21tZW50
cy4NCkhvdyBhYm91dCBhZGQgdGhlIGZvbGxvd2luZyBpbmZvcm1hdGlvbj8NCkVpdGhlciBpbnRl
cm5hbCBzeXN0ZW0gUExMIG9yIGV4dGVybmFsIGNyeXN0YWwgb3NjaWxsYXRvciBjYW4gYmUgdXNl
ZCBhcyBQQ0llDQogcmVmZXJlbmNlIGNsb2NrIGZvciBpLk1YIFBDSWUgUkMgY29udHJvbGxlci4N
Cg0KVGhlIHJlZmVyZW5jZSBjbG9jayB1c2VkIGJ5IHRoZSBpLk1YIFBDSWUgUkMgY29udHJvbGxl
ciBtYXkgY29tZSBmcm9tIGFuDQogZXh0ZXJuYWwgY3J5c3RhbCBvc2NpbGxhdG9yIGNvbnRyb2xs
ZWQgYnkgdGhlIGNsa3JlcSMgc2lnbmFsLg0KPiA+IFRvIG1ha2UNCj4gPiBzdXJlIHRoaXMgY2xv
Y2sgaXMgYXZhaWxhYmxlIGV2ZW4gd2hlbiB0aGUgQ0xLUkVRIyBpc24ndCBkcml2ZW4gbG93IGJ5
DQo+ID4gdGhlIGNhcmQoZS54IG5vIGNhcmQgY29ubmVjdGVkKSwgZm9yY2UgQ0xLUkVRIyBvdmVy
cmlkZSBhY3RpdmUgbG93IGZvcg0KPiA+IGkuTVggUENJZSBob3N0IGR1cmluZyBpbml0aWFsaXph
dGlvbi4NCj4gPg0KPiANCj4gQ0xLUkVRIyBvdmVycmlkZSBpcyBub3QgYSBzcGVjIGRlZmluZWQg
ZmVhdHVyZS4gU28geW91IG5lZWQgdG8gZXhwbGFpbiB3aGF0DQo+IGl0IGRvZXMgZmlyc3QuDQpP
a2F5LiBXb3VsZCBhZGQgdGhlIGZvbGxvd2luZyBkZXNjcmlwdGlvbnMuDQoiU29tZSBpLk1YIFBD
SWUgaGF2ZSB0aGUgQ0xLUkVRIyBvdmVycmlkZSBtZWNoYW5pc20sIHRoYXQgY2FuIGZvcmNlIENM
S1JFUSMNCiBhY3RpdmUgbG93LiINCj4NCj4gPiBUaGUgQ0xLUkVRIyBvdmVycmlkZSBjYW4gYmUg
Y2xlYXJlZCBzYWZlbHkgd2hlbiBzdXBwb3J0cy1jbGtyZXEgaXMNCj4gPiBwcmVzZW50IGFuZCBQ
Q0llIGxpbmsgaXMgdXAgbGF0ZXIuIEJlY2F1c2UgdGhlIENMS1JFUSMgd291bGQgYmUgZHJpdmVu
DQo+ID4gbG93IGJ5IHRoZSBjYXJkIGluIHRoaXMgY2FzZS4NCj4gPg0KPiANCj4gV2h5IGRvIHlv
dSBuZWVkIHRvIGRlcGVuZCBvbiAnc3VwcG9ydHMtY2xrcmVxJyBwcm9wZXJ0eT8gRG9uJ3QgeW91
DQo+IGFscmVhZHkga25vdyBpZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIENMS1JFUSMgb3Igbm90
PyBOb25lIG9mIHRoZQ0KPiB1cHN0cmVhbSBEVFMgaGFzIHRoZSAnc3VwcG9ydHMtY2xrcmVxJyBw
cm9wZXJ0eSBzZXQgYW5kIHRoZSBOWFAgYmluZGluZw0KPiBhbHNvIGRvZXNuJ3QgZW5hYmxlIHRo
aXMgcHJvcGVydHkuDQo+IA0KPiBTbyBJJ20gd29uZGVyaW5nIGhvdyB5b3UgYXJlIHN1ZGRlbmx5
IHVzaW5nIHRoaXMgcHJvcGVydHkuIFRoZSBwcm9wZXJ0eQ0KPiBpbXBsaWVzIHRoYXQgd2hlbiBu
b3Qgc2V0IHRvIHRydWUsIENMS1JFUSMgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgcGxhdGZvcm0u
DQo+IFNvIHdoZW4gdGhlIGRyaXZlciBzdGFydHMgdXNpbmcgdGhpcyBwcm9wZXJ0eSwgYWxsIHRo
ZSBvbGQgRFRTIGJhc2VkDQo+IHBsYXRmb3JtcyBhcmUgbm90IGdvaW5nIHRvIHJlbGVhc2UgQ0xL
UkVRIyBmcm9tIGRyaXZpbmcgbG93LCBzbyBMMVNTIHdpbGwgbm90DQo+IGJlIGVudGVyZWQgZm9y
IHRoZW0uIERvIHlvdSByZWFsbHkgd2FudCBpdCB0byBoYXBwZW4/DQo+IA0KPiAtIE1hbmkNCj4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMzUN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM1
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ID4gaW5kZXggODBlNDg3NDZiYmFmNi4uYTczNjMyYjQ3ZTJkMyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC01Miw2ICs1Miw4
IEBADQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9SRUZfQ0xLRU4JCQlCSVQoMjMpDQo+ID4gICNk
ZWZpbmUgSU1YOTVfUENJRV9QSFlfQ1JfUEFSQV9TRUwJCUJJVCg5KQ0KPiA+ICAjZGVmaW5lIElN
WDk1X1BDSUVfU1NfUldfUkVHXzEJCQkweGY0DQo+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9DTEtS
RVFfT1ZFUlJJREVfRU4JCUJJVCg4KQ0KPiA+ICsjZGVmaW5lIElNWDk1X1BDSUVfQ0xLUkVRX09W
RVJSSURFX1ZBTAkJQklUKDkpDQo+ID4gICNkZWZpbmUgSU1YOTVfUENJRV9TWVNfQVVYX1BXUl9E
RVQJCUJJVCgzMSkNCj4gPg0KPiA+ICAjZGVmaW5lIElNWDk1X1BFMF9HRU5fQ1RSTF8xCQkJMHgx
MDUwDQo+ID4gQEAgLTEzNiw2ICsxMzgsNyBAQCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSB7DQo+
ID4gIAlpbnQgKCplbmFibGVfcmVmX2Nsaykoc3RydWN0IGlteF9wY2llICpwY2llLCBib29sIGVu
YWJsZSk7DQo+ID4gIAlpbnQgKCpjb3JlX3Jlc2V0KShzdHJ1Y3QgaW14X3BjaWUgKnBjaWUsIGJv
b2wgYXNzZXJ0KTsNCj4gPiAgCWludCAoKndhaXRfcGxsX2xvY2spKHN0cnVjdCBpbXhfcGNpZSAq
cGNpZSk7DQo+ID4gKwl2b2lkICgqY2xyX2Nsa3JlcV9vdmVycmlkZSkoc3RydWN0IGlteF9wY2ll
ICpwY2llKTsNCj4gPiAgCWNvbnN0IHN0cnVjdCBkd19wY2llX2hvc3Rfb3BzICpvcHM7DQo+ID4g
IH07DQo+ID4NCj4gPiBAQCAtMTQ5LDYgKzE1Miw3IEBAIHN0cnVjdCBpbXhfcGNpZSB7DQo+ID4g
IAlzdHJ1Y3QgZ3Bpb19kZXNjCSpyZXNldF9ncGlvZDsNCj4gPiAgCXN0cnVjdCBjbGtfYnVsa19k
YXRhCSpjbGtzOw0KPiA+ICAJaW50CQkJbnVtX2Nsa3M7DQo+ID4gKwlib29sCQkJc3VwcG9ydHNf
Y2xrcmVxOw0KPiA+ICAJc3RydWN0IHJlZ21hcAkJKmlvbXV4Y19ncHI7DQo+ID4gIAl1MTYJCQlt
c2lfY3RybDsNCj4gPiAgCXUzMgkJCWNvbnRyb2xsZXJfaWQ7DQo+ID4gQEAgLTI2Nyw2ICsyNzEs
MTMgQEAgc3RhdGljIGludCBpbXg5NV9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXhfcGNpZQ0KPiAq
aW14X3BjaWUpDQo+ID4gIAkJCSAgIElNWDk1X1BDSUVfUkVGX0NMS0VOLA0KPiA+ICAJCQkgICBJ
TVg5NV9QQ0lFX1JFRl9DTEtFTik7DQo+ID4NCj4gPiArCS8qIEZvcmNlIENMS1JFUSMgbG93IGJ5
IG92ZXJyaWRlICovDQo+ID4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoaW14X3BjaWUtPmlvbXV4Y19n
cHIsDQo+ID4gKwkJCSAgIElNWDk1X1BDSUVfU1NfUldfUkVHXzEsDQo+ID4gKwkJCSAgIElNWDk1
X1BDSUVfQ0xLUkVRX09WRVJSSURFX0VOIHwNCj4gPiArCQkJICAgSU1YOTVfUENJRV9DTEtSRVFf
T1ZFUlJJREVfVkFMLA0KPiA+ICsJCQkgICBJTVg5NV9QQ0lFX0NMS1JFUV9PVkVSUklERV9FTiB8
DQo+ID4gKwkJCSAgIElNWDk1X1BDSUVfQ0xLUkVRX09WRVJSSURFX1ZBTCk7DQo+ID4gIAlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTEyOTgsNiArMTMwOSwxOCBAQCBzdGF0aWMgdm9p
ZCBpbXhfcGNpZV9ob3N0X2V4aXQoc3RydWN0DQo+IGR3X3BjaWVfcnAgKnBwKQ0KPiA+ICAJCXJl
Z3VsYXRvcl9kaXNhYmxlKGlteF9wY2llLT52cGNpZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgdm9pZCBpbXg4bW1fcGNpZV9jbHJfY2xrcmVxX292ZXJyaWRlKHN0cnVjdCBpbXhfcGNpZQ0K
PiA+ICsqaW14X3BjaWUpIHsNCj4gPiArCWlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrKGlteF9w
Y2llLCBmYWxzZSk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGlteDk1X3BjaWVfY2xyX2Ns
a3JlcV9vdmVycmlkZShzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llKQ0KPiA+ICt7DQo+ID4gKwly
ZWdtYXBfdXBkYXRlX2JpdHMoaW14X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X1BDSUVfU1NfUldf
UkVHXzEsDQo+ID4gKwkJCSAgIElNWDk1X1BDSUVfQ0xLUkVRX09WRVJSSURFX0VOIHwNCj4gPiAr
CQkJICAgSU1YOTVfUENJRV9DTEtSRVFfT1ZFUlJJREVfVkFMLCAwKTsgfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIHZvaWQgaW14X3BjaWVfaG9zdF9wb3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBw
KSAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7
IEBAIC0xMzIyLDYgKzEzNDUsMTINCj4gQEANCj4gPiBzdGF0aWMgdm9pZCBpbXhfcGNpZV9ob3N0
X3Bvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApDQo+ID4gIAkJZHdfcGNpZV93cml0ZWxf
ZGJpKHBjaSwgR0VOM19SRUxBVEVEX09GRiwgdmFsKTsNCj4gPiAgCQlkd19wY2llX2RiaV9yb193
cl9kaXMocGNpKTsNCj4gPiAgCX0NCj4gPiArDQo+ID4gKwkvKiBDbGVhciBDTEtSRVEjIG92ZXJy
aWRlIGlmIHN1cHBvcnRzX2Nsa3JlcSBpcyB0cnVlIGFuZCBsaW5rIGlzIHVwICovDQo+ID4gKwlp
ZiAoZHdfcGNpZV9saW5rX3VwKHBjaSkgJiYgaW14X3BjaWUtPnN1cHBvcnRzX2Nsa3JlcSkgew0K
PiA+ICsJCWlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xyX2Nsa3JlcV9vdmVycmlkZSkNCj4gPiAr
CQkJaW14X3BjaWUtPmRydmRhdGEtPmNscl9jbGtyZXFfb3ZlcnJpZGUoaW14X3BjaWUpOw0KPiA+
ICsJfQ0KPiA+ICB9DQo+ID4NCj4gPiAgLyoNCj4gPiBAQCAtMTc0NSw2ICsxNzc0LDggQEAgc3Rh
dGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0K
PiA+ICAJcGNpLT5tYXhfbGlua19zcGVlZCA9IDE7DQo+ID4gIAlvZl9wcm9wZXJ0eV9yZWFkX3Uz
Mihub2RlLCAiZnNsLG1heC1saW5rLXNwZWVkIiwNCj4gPiAmcGNpLT5tYXhfbGlua19zcGVlZCk7
DQo+ID4NCj4gPiArCWlteF9wY2llLT5zdXBwb3J0c19jbGtyZXEgPQ0KPiA+ICsJCW9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChub2RlLCAic3VwcG9ydHMtY2xrcmVxIik7DQo+ID4gIAlpbXhfcGNpZS0+
dnBjaWUgPSBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgInZwY2llIik7
DQo+ID4gIAlpZiAoSVNfRVJSKGlteF9wY2llLT52cGNpZSkpIHsNCj4gPiAgCQlpZiAoUFRSX0VS
UihpbXhfcGNpZS0+dnBjaWUpICE9IC1FTk9ERVYpIEBAIC0xODczLDYgKzE5MDQsNyBAQA0KPiA+
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4g
IAkJLm1vZGVfbWFza1sxXSA9IElNWDhNUV9HUFIxMl9QQ0lFMl9DVFJMX0RFVklDRV9UWVBFLA0K
PiA+ICAJCS5pbml0X3BoeSA9IGlteDhtcV9wY2llX2luaXRfcGh5LA0KPiA+ICAJCS5lbmFibGVf
cmVmX2NsayA9IGlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrLA0KPiA+ICsJCS5jbHJfY2xrcmVx
X292ZXJyaWRlID0gaW14OG1tX3BjaWVfY2xyX2Nsa3JlcV9vdmVycmlkZSwNCj4gPiAgCX0sDQo+
ID4gIAlbSU1YOE1NXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDhNTSwNCj4gPiBAQCAtMTg4
Myw2ICsxOTE1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRh
dGFbXSA9IHsNCj4gPiAgCQkubW9kZV9vZmZbMF0gPSBJT01VWENfR1BSMTIsDQo+ID4gIAkJLm1v
ZGVfbWFza1swXSA9IElNWDZRX0dQUjEyX0RFVklDRV9UWVBFLA0KPiA+ICAJCS5lbmFibGVfcmVm
X2NsayA9IGlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrLA0KPiA+ICsJCS5jbHJfY2xrcmVxX292
ZXJyaWRlID0gaW14OG1tX3BjaWVfY2xyX2Nsa3JlcV9vdmVycmlkZSwNCj4gPiAgCX0sDQo+ID4g
IAlbSU1YOE1QXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDhNUCwNCj4gPiBAQCAtMTg5Myw2
ICsxOTI2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFb
XSA9IHsNCj4gPiAgCQkubW9kZV9vZmZbMF0gPSBJT01VWENfR1BSMTIsDQo+ID4gIAkJLm1vZGVf
bWFza1swXSA9IElNWDZRX0dQUjEyX0RFVklDRV9UWVBFLA0KPiA+ICAJCS5lbmFibGVfcmVmX2Ns
ayA9IGlteDhtbV9wY2llX2VuYWJsZV9yZWZfY2xrLA0KPiA+ICsJCS5jbHJfY2xrcmVxX292ZXJy
aWRlID0gaW14OG1tX3BjaWVfY2xyX2Nsa3JlcV9vdmVycmlkZSwNCj4gPiAgCX0sDQo+ID4gIAlb
SU1YOFFdID0gew0KPiA+ICAJCS52YXJpYW50ID0gSU1YOFEsDQo+ID4gQEAgLTE5MTMsNiArMTk0
Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7
DQo+ID4gIAkJLmNvcmVfcmVzZXQgPSBpbXg5NV9wY2llX2NvcmVfcmVzZXQsDQo+ID4gIAkJLmlu
aXRfcGh5ID0gaW14OTVfcGNpZV9pbml0X3BoeSwNCj4gPiAgCQkud2FpdF9wbGxfbG9jayA9IGlt
eDk1X3BjaWVfd2FpdF9mb3JfcGh5X3BsbF9sb2NrLA0KPiA+ICsJCS5jbHJfY2xrcmVxX292ZXJy
aWRlID0gaW14OTVfcGNpZV9jbHJfY2xrcmVxX292ZXJyaWRlLA0KPiA+ICAJfSwNCj4gPiAgCVtJ
TVg4TVFfRVBdID0gew0KPiA+ICAJCS52YXJpYW50ID0gSU1YOE1RX0VQLA0KPiA+IC0tDQo+ID4g
Mi4zNy4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprg
rqTgrr7grprgrr/grrXgrq7gr40NCg0K

