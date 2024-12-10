Return-Path: <linux-pci+bounces-17978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86B9EA51F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 03:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0850A1887BD2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166523596F;
	Tue, 10 Dec 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1Hc25rx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D6171D2;
	Tue, 10 Dec 2024 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797919; cv=fail; b=FEQ7zyGFMUIi5U9H1ueHcNnTlGm+PMXQdL1w5m30+exvor6ihQhRTfOUcsRrPEh1DRGpXc41uCaQ3NJCRo25lLeSHoAwhOL1U7QMBlx6EpFI4wgpiR2eGNS7b2VmCfblJ3w4WEXHo8AHRjdvPZg2eIqFhYOS/DvYMWIl4G1IMg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797919; c=relaxed/simple;
	bh=ZTk+nBQdLByBskF89eNamO6F9bKurjM7ssccH7+PH6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADQ6rBrBublgPH1NlX6d1U8/P3VSXDgOoTrr9m+T17HwscLIQyrh8VGmNJ2wGjiXYhHoYtOK184lM3/GLSQeu2+tFsXMbtwqQ9Rrsy/wdK4N1d2RD8crOD22F2WSa7EcI68+tHkLqGgoNxMpJGg8qtz87AWKSYhikv6/0uidL+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k1Hc25rx; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIgPSFDHMmfQlQjj8fwpkWHgQO98mrIkwMgWAvYmD2FmLwnIcMtZbRKB2yn1YzGjLqdTtKcz2f68prM6rSExNGFPz4Nj8NkdMDYml2lnqWhs3mZ1X0tpSc7X/4cUgt8ntKTDk16ha1hIz0P9UyEjAuTiXWakkdVLNcVMgFpIpVf9k2ypZPRGku+lRm3fwtYyN830Q6P5p6ndFptnqRp/M8UUT+pQM+rZnAp94sd/6zHBrJfWUPo9WX0OKGSAnxKbkCMuWpKL/Yh2MyAveEWBK0hXmS3bSpFbj8Zz8l+d4Ls7cxyuU9Pt2lza0e6KESXJorqLRuMKNFTyGUuZy8qWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTk+nBQdLByBskF89eNamO6F9bKurjM7ssccH7+PH6A=;
 b=P+yaCGBEnoj2qfdHXkAE6vJr4zf7PbSVehqEqekYEsj8dova//BGr5iUgKtYyDdyYl2bHVcTnPymXS38ByFh67lpTPHT5EHa51taFx3jQfaExRG6RHqnfGUSk7QWiSEConG7JxwF36T6T6xAjlzsSEpjgSUeJw3xkkUT+7U1fVnd6M3JiuOizPLYSjKuHFQDiXHHHKF+EXwaJUr4o/Io4P8983b+nhZoGfp6y0gW9G98AshfdrusNMq3Wn4PBbU1B9fowgBgG3+6DLv7PJ2Z3ZNDKHxlZK/VvnHRHTpMfdC8jEuFffz94zhYLuxJdb92s6FoqUHLCjMP7dnJNVdZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTk+nBQdLByBskF89eNamO6F9bKurjM7ssccH7+PH6A=;
 b=k1Hc25rxZH3qJC/y91qqO0ynxghxOM0RVnERt6bnntkR7YmecWiKyH2zaEzr54YXE5o+B/p0yn/6IAe6l5Ckh2BWd09jcZ2Ao2lUaEYa2wWRD7eJhEaWwqbceFuaogwPWk3Yyc5nGlk/cJuv18qpFNqP4QbtNr57kUuNpwR46+9zvKyLGu85woOv+jvQQKAi1HZ90iYXiOdAk/YtqlwMRL1gBqdBjPZYQ5jLZbuGOqmNQBNWaxkMY5cKSFEjvjsCC7DLY8weiEOUAZcIRPj5qtdY8fpg2qPu7UG+e6f/NGeGwM8CRcUok88Z99HjtI/gWgGHCUfgTVAn7XrHE2pSBg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8357.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 02:31:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:31:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	Frank Li <frank.li@nxp.com>, "quic_krichai@quicinc.com"
	<quic_krichai@quicinc.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] PCI: dwc: Fix resume failure if no EP is connected
 on some platforms
Thread-Topic: [PATCH v3 1/3] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Thread-Index: AQHbSg2VUuk+W62500+0wgzmvxABQLLdmnmAgAEoN5A=
Date: Tue, 10 Dec 2024 02:31:52 +0000
Message-ID:
 <AS8PR04MB8676595EA27CA466031D9DFB8C3D2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
 <20241209073924.2155933-2-hongxing.zhu@nxp.com>
 <ca93bfaa-0b7e-4335-87e0-5f4133efad6a@kernel.org>
In-Reply-To: <ca93bfaa-0b7e-4335-87e0-5f4133efad6a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: fd238810-745b-43ab-f772-08dd18c2ce81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q280eHpRWFZlWGhrTjFwS1pKYmRkdDFaT3NjR09pQWFJdCttSEljRTR5NnY0?=
 =?utf-8?B?dTZ6ejVnM1VkNklmdG1QR1ZEN3ltRXdJUDZQb2Z5WFBoWjZWaGZyZHV4eWp4?=
 =?utf-8?B?dWRIcTNQQzF3OVNlcGJVVTBWM29XK0s0LzhmbldKaVUrQlJ0eDh0bXhXV0FK?=
 =?utf-8?B?TTJ3Q2pSUktuV3RKNUV6bko3NW9rc0Z4SEZmTVNFQWV5alo4MmRUM2lKZlY1?=
 =?utf-8?B?dXlzeU1zRk85VFBwMXJ0Q244SXJBUWRYaTdjN2Iwc0VaS2plSE01S2N4Sk9N?=
 =?utf-8?B?SkUyelZpcUpGZmcxQWZwZVF5Mm5MejBnS3hwbHpFWnF1TGtERytCMnN2ZE9s?=
 =?utf-8?B?WUNGUlpwTW1oSWNOUEFCa2Z2Q0hqanV6WUMzT2RydnJWelc4RFlGZXBHNENP?=
 =?utf-8?B?REZ2MDgvWmo0V0RlRkliZitoRFQ0R1FEK3V4RjBuUlVhbzRFZ2NaampRMnVx?=
 =?utf-8?B?U0trSUpvMnIrTXBuMlZOOHR3cEJ6T2VSeFg5aVVTVWRHdE9OdHlvdTRhejVC?=
 =?utf-8?B?ejIxa2kvSzVuZjFVc2wxQzUzWFpoVmNGdWtwbkI2OUpuS3J2emNXOFE5cita?=
 =?utf-8?B?TUtiWVYrSTVVcnNSYUVvS2pPSmFWcGt4MGlQd0VMVnhNWG5RWXZYbzF5YzNQ?=
 =?utf-8?B?RGVqbVhNMGRsYUV0NDBLYUovbmJRaGkyMzN3RHF6RUhQdWg5NVhzOURuZ1VO?=
 =?utf-8?B?THdUNlQwOWRRN1YxcWtUeGhpaTB5dm5aY0NCK1h3S1U0YmM0aGVlUGRrQk01?=
 =?utf-8?B?c3kzdDFMY2RxdXo3VnZXWVBkeEZER3R3L1Iwd05sZEovL3M5TlFwemwvSkJF?=
 =?utf-8?B?Skp3OFRia01KcHVHSVNBL1BsZkdqT2x6TllkMXV2YVpZRWFhVkNHVmRmNk1q?=
 =?utf-8?B?dStTS0hQTUo2K2d0aTVEcGxwWGRUUktTSXErbHBERW0xUW5Vd20zbWpYdUo1?=
 =?utf-8?B?RHhYZ080ZlR6dlN6TGpPZjlOa0ZobkJ5cFIwZVJ3eWFDM0RzVFFtK29jb3Rn?=
 =?utf-8?B?eEo5QzhwWFJpK1dyV2lLNmdKb1RUY2I5NjdwSER5L1BSZ3B0SmZGQTlFV3ln?=
 =?utf-8?B?Mk1vUjdFU3FSK0tTQVI2MVNWdUMrcjN4cmVCajY3eFR6OHJ1bVF1aVNhS3Vx?=
 =?utf-8?B?QmZlRk5DbDd4NG5UdEZhNHNGOW50ZGpMWHl3cFdkaDRmbGFDWmhLSkppay9C?=
 =?utf-8?B?Z0NiamQzR0tHNEZJd1lGYnd4amVUS2hzWjBaVkl4Mzc3NFZNd0RhVjQ5eGpB?=
 =?utf-8?B?Z2JENlIrNXNkRC9yNHV2MDF0a1J3a2hFemRtdWsvN1k4UVpIeVpQWlRWd2Y5?=
 =?utf-8?B?NnlNZVpSa0RzZ0ROME03WFRNMDNKK0dWdHN4ZWpwYjljb3MzNVpyZjg1UUFW?=
 =?utf-8?B?MXNzbVZpT1duRThHb25CRzVUb3R4dENjaGUwSTJiaEcxaWRaWnBHODZvalZK?=
 =?utf-8?B?V0UrMDgvV0orU3pJUWZZT0lvOEhlQkljTlY3dTlSNHJQZnFyT1I0WUdHSk1o?=
 =?utf-8?B?L3BaM24vMjJ0citxZXZ6Z2ZjWW9RTXh4Tm9uSjVrcnZKQnJPNDhMSXBaTXhQ?=
 =?utf-8?B?M3dUeFZ1djFNSDZXMTU1VGdrYmJzb0h4NlExWjlkdTNYWXZHUkpKc0ZLUWNN?=
 =?utf-8?B?eDRCd3lBazJNUTExN2Y2TkVvNTFlUVczQ1ZXaytVYjVEOEd5bXQwejlmcy90?=
 =?utf-8?B?V0wrRkZiajBJanFiN1hLME9oUjQrRHB2dDFJUzh5QWJ6ZjdMdDFwaHArSkpw?=
 =?utf-8?B?UFB3VjVKU1Fib2lILzN1VG5Zd0NLM3FOL0Q3dzhJc005dFByY1g1RElCUGdj?=
 =?utf-8?B?UU5VV3N3MjNHcFZSeGNaOEM1OFpKSFdyUTFYM3oxZGd0eHpYNjNmQ01teUdn?=
 =?utf-8?B?ZjQ3NHNFRGFrODJabVhmRXgyenBCSUlMTEdhUU1rNU9pTnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXkyRXFiT0YrdXRTcTAxbFhLMWdvbE9paWxVdmpGWDc0OEFkZnQra2lkSys0?=
 =?utf-8?B?VStkd0ZjeFYrUEYvak9wSVQwNGwwVDVQdVRUbmQ4YnNURzVkSUFUZk1FcVZp?=
 =?utf-8?B?SWtWS2s3V1U1alk5WjNVTEZCaTZnNUs1MW9OYlovNm0rSzNpYzA2ODh3UEJ0?=
 =?utf-8?B?S1hSZ280dHZWMjFybC91YWhGb3NYRkxLazNtUVJSL3YzRG5yQ1RzbTVsT25s?=
 =?utf-8?B?SkJ3WWdrMlV1Y005dUxBZmZva1h6ODJyZUpBanlGVzBKWUowdE5zQytDSGxw?=
 =?utf-8?B?SDVBZ1Z0YnR2Mk8zb1paTjZBN1pHNXVHZnRkZnZSakNseHQzdlI3MDZmL2s1?=
 =?utf-8?B?OHhERFZMTk5TV2p6ZTdkWDRJNTdrVHBYNHp2d2hLV3dML1BabXpxUlNhUGd2?=
 =?utf-8?B?NlBXRkJyaDJBdE8wT21TZGhSZWlnWWsvV2MrcDZzWmlLZXVsK0VHZGVlblhQ?=
 =?utf-8?B?RHhaRlRIZXB3TkNZa1R2bmpZVS9JWGRDU2FxTStXNFMyandjenVFa2Z3UFMr?=
 =?utf-8?B?WVF0OFJNaUhNdnNyMEtaTzdtaFRiMzBRUTg2QlIyVVpQRUpsMytUa3BzdE1Z?=
 =?utf-8?B?RlhVRzVyTnkrRDJBRDdNdGJZSjFRdndtK0xQQTB2RHhUN2pSQnNLbmx3WXd4?=
 =?utf-8?B?ZHhRTnFqSjU2WnB2NGRweEhSQ04wa29OK2FvNlAxQUpqNGFxYk1lZUhYZXpz?=
 =?utf-8?B?R00zSmQzOWVKZ2xpVlZMbHhxcklGYk5xaGQ4ZTRJeFAxWFdtYTZ3QUZpK2Q0?=
 =?utf-8?B?dmZQeHZPdkNmcDVKL3VOTVk2dXI3Y08yWndHUjc5ZVQ2T3J0cEg2TlpVRjNY?=
 =?utf-8?B?MVhBa0EvYks0VVYwdmcvNFlpN21Qc2x4WkRnR2VBaVB6TTJ2eW5JZUU2dCtV?=
 =?utf-8?B?eTMxVzUyTnlyMSs3ZGNQc1RPajNxdmx5S3Jrc1dBWlFOaTdLSzJ5SVFJQlpu?=
 =?utf-8?B?Z1VrWEFtTkVjeUQ1SGJ4NHFsbHBOZGZYbEhFOTgvKzJSMDliYlBQVlZlYmsw?=
 =?utf-8?B?RFR1Rmp4RnJoazBhM0pDeWZURktsWmNUdDdZZ0xCdTBwdXN5eVhEUitBRlYz?=
 =?utf-8?B?QWxkbnIxVnRBajBVRXI5THVxZnQxZ3lxaGthUjBhaHl6YlNzSU5pWk5uWnlr?=
 =?utf-8?B?dUt3VUd4eUZRTWgvK2duc3E1dVlzYzZ0NTM3RUhtNHlCOVN0WkZHaGt6dld0?=
 =?utf-8?B?Q1lSaVQ0OXl4NUtOQTFEWEdSY2pOWGhqelk0TkhtaDBZMDJoM0hEbXRLU2Jp?=
 =?utf-8?B?ZzRDL1ZLc2NobjA2ZmhobUZwSHNuMUJSQmR6TllVNE9XVlNmZGYxcW5XSWpt?=
 =?utf-8?B?K0pFMU1BclVmak9KQkUrRWVTTlJYL0taREU3QTFjM1Z4VjZjMXNlVWJ2VFFa?=
 =?utf-8?B?dUdnaWN6MHJZb0ZGOWhsMUl1UUlmRmVXU1pSOFlmTm5OaXJEbzhKZURQZWN5?=
 =?utf-8?B?eEJyNE40TVdnNzlacFRyV1ptamFtQkJaZEFiV3c1bFViRUxFaWJ3Zmp4bTBO?=
 =?utf-8?B?MHp6NDVCaWVCbkxHSnNadGhYMTZMTnFrMUdHOUVpVGExbndML0I3Z1F1RHNG?=
 =?utf-8?B?NmMxQ1cwcjZrL0plUURoR2ZZRXJRTy9oT1JjRjBleTFOaEhMbm45Z2dMN3px?=
 =?utf-8?B?dXlwUVdVLzUwbGx6MFRiaitLSUZKSFBPUnYxTDJ3S215Q0s1UXc2eUMyWWJa?=
 =?utf-8?B?bTgvUTlGM2xBUy82VURrRnFjU3FwdVNwSmZZcDM5L0x2QmRJeFZSWnU0TUph?=
 =?utf-8?B?dkYvT0lvMjhJZjJxNFIrb0ZXUE85NHB5d093TmxpMWkzVzdBZWFuZzZCME1u?=
 =?utf-8?B?RG9zYWdOTmVKb0FyMzBYRmtWRTVrMC9GNmJtR05wWm4vZFJKZ2toOXRpOEhK?=
 =?utf-8?B?NkdnNTRsNE9vdzB4OEJFSStMTXdGaGJ6Qnk3ZTU5UWdHanltWkVSeG1uL0th?=
 =?utf-8?B?aDkyZDBlT1BQOERYRFlwa0tUR2FyS1F0Z1lZT3JEYW5QOFY0bkhHVXVoTlZJ?=
 =?utf-8?B?WFVnNGtvOXhIWndicHNjbjVsSnFET08wT0crNFRCWi9SRVZBM0pWTG5CNEhN?=
 =?utf-8?B?Vk1pSDc0OEZ3Y24rQittYlBvWCs1MUJRdE9rZ2xkY1FXN1NMOVhlcTV2N3BF?=
 =?utf-8?Q?tAVlkRjJnaLHL4HhRp5q37EGQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd238810-745b-43ab-f772-08dd18c2ce81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 02:31:52.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcVSuq0qMTJru4vx28dMJdcVan2k8pUzWRt2X4qTId1cnNSd15DG1xbVp4WjhZxL8tMMv6Rt6nXFcqxmqrFa9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8357

DQoNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFNl
bnQ6IDIwMjTlubQxMuaciDnml6UgMTY6NTANCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+OyBqaW5nb29oYW4xQGdtYWlsLmNvbTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5uYW4uc2Fk
aGFzaXZhbUBsaW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IEZyYW5rIExpDQo+IDxmcmFuay5s
aUBueHAuY29tPjsgcXVpY19rcmljaGFpQHF1aWNpbmMuY29tDQo+IENjOiBpbXhAbGlzdHMubGlu
dXguZGV2OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxLzNdIFBDSTogZHdjOiBGaXggcmVzdW1lIGZhaWx1cmUgaWYgbm8gRVAgaXMgY29ubmVjdGVk
IG9uDQo+IHNvbWUgcGxhdGZvcm1zDQo+IA0KPiBPbiAxMi85LzI0IDE2OjM5LCBSaWNoYXJkIFpo
dSB3cm90ZToNCj4gPiBUaGUgZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkgZnVuY3Rpb24gY3VycmVu
dGx5IHJldHVybnMgc3VjY2Vzcw0KPiA+IGRpcmVjdGx5IGlmIG5vIGVuZHBvaW50IChFUCkgZGV2
aWNlIGlzIGNvbm5lY3RlZC4gSG93ZXZlciwgb24gc29tZQ0KPiA+IHBsYXRmb3JtcywgcG93ZXIg
bG9zcyBvY2N1cnMgZHVyaW5nIHN1c3BlbmQsIGNhdXNpbmcgZHdfcmVzdW1lKCkgdG8gZG8NCj4g
PiBub3RoaW5nIGluIHRoaXMgY2FzZS4gVGhpcyByZXN1bHRzIGluIGEgc3lzdGVtIGhhbHQgYmVj
YXVzZSB0aGUgRFdDDQo+ID4gY29udHJvbGxlciBpcyBub3QgaW5pdGlhbGl6ZWQgYWZ0ZXIgcG93
ZXItb24gZHVyaW5nIHJlc3VtZS4NCj4gPg0KPiA+IENhbGwgZGVpbml0KCkgaW4gc3VzcGVuZCBh
bmQgaW5pdCgpIGF0IHJlc3VtZSByZWdhcmRsZXNzIG9mIHdoZXRoZXINCj4gPiB0aGVyZSBhcmUg
RVAgZGV2aWNlIGNvbm5lY3Rpb25zIG9yIG5vdC4gSXQgaXMgbm90IGhhcm1mdWwgdG8gcGVyZm9y
bQ0KPiA+IGRlaW5pdCgpIGFuZCBpbml0KCkgYWdhaW4gZm9yIHRoZSBubyBwb3dlci1vZmYgY2Fz
ZSwgYW5kIGl0IGtlZXBzIHRoZQ0KPiA+IGNvZGUgc2ltcGxlIGFuZCBjb25zaXN0ZW50IGluIGxv
Z2ljLg0KPiA+DQo+ID4gRml4ZXM6IDQ3NzRmYWY4NTRmNSAoIlBDSTogZHdjOiBJbXBsZW1lbnQg
Z2VuZXJpYyBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGZ1bmN0aW9uYWxpdHkiKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDMwDQo+ID4gKysrKysrKysrLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IGY4ODJiMTFmZDdiOTQuLjExNTYzNDAy
YzU3MWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtOTgyLDIzICs5ODIsMjMgQEAgaW50IGR3X3Bj
aWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJaWYgKGR3X3BjaWVf
cmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktDVEwpICYNCj4gUENJX0VYUF9MTktD
VExfQVNQTV9MMSkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+IC0JaWYgKGR3X3BjaWVfZ2V0
X2x0c3NtKHBjaSkgPD0gRFdfUENJRV9MVFNTTV9ERVRFQ1RfQUNUKQ0KPiA+IC0JCXJldHVybiAw
Ow0KPiA+IC0NCj4gPiAtCWlmIChwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKQ0KPiA+IC0JCXBj
aS0+cHAub3BzLT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOw0KPiA+IC0JZWxzZQ0KPiA+IC0JCXJl
dCA9IGR3X3BjaWVfcG1lX3R1cm5fb2ZmKHBjaSk7DQo+ID4gKwkvKiBPbmx5IHNlbmQgb3V0IFBN
RV9UVVJOX09GRiB3aGVuIFBDSUUgbGluayBpcyB1cCAqLw0KPiA+ICsJaWYgKGR3X3BjaWVfZ2V0
X2x0c3NtKHBjaSkgPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9BQ1QpIHsNCj4gPiArCQlpZiAocGNp
LT5wcC5vcHMtPnBtZV90dXJuX29mZikNCj4gPiArCQkJcGNpLT5wcC5vcHMtPnBtZV90dXJuX29m
ZigmcGNpLT5wcCk7DQo+ID4gKwkJZWxzZQ0KPiA+ICsJCQlyZXQgPSBkd19wY2llX3BtZV90dXJu
X29mZihwY2kpOw0KPiA+DQo+ID4gLQlpZiAocmV0KQ0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4g
KwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gDQo+IFNhbWUgY29tbWVudCBhcyBm
b3IgcGF0Y2ggMy4gVGhpcyAiaWYgKHJldCkgcmV0dXJuIHJldDsiIGNhbiBnbyBpbnNpZGUgdGhl
IGVsc2UuDQo+IEl0IGlzIGhhcm1sZXNzLCBidXQgdGhlcmUgaXMgYWxzbyBubyBwb2ludCBpbiBo
YXZpbmcgaXQgaGVyZS4NCj4gDQpIaSBEYW1pZW46DQpPa2F5LCB0aGFua3MuDQpCVFcsIEknbSBj
b25zaWRlcmluZyB0aGF0IHRoZSB1c2UtY2FzZSBvZiAjMSBwYXRjaCBoYWQgYmVlbiBjb3ZlcmVk
IGJ5ICMzDQogY29tbWl0IGFscmVhZHkuDQpTaW5jZSwgdGhlIFBNRV9UVVJOX09GRiB3b3VsZCBi
ZSBraWNrZWQgb2ZmIHdpdGhvdXQgTFRTU00gc3RhdCBjaGVjayBpbiAjMy4NClRvIGJlIHNpbXBs
ZSwgaG93IGFib3V0IGRyb3AgdGhlICMxIHBhdGNoLCByZS1mb3JtYXQgdGhlIGNvZGVzLCBhbmQg
YWRkIG9uZQ0KIEZpeGVzIHRhZyBpbnRvICMzPw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1
DQo+ID4NCj4gPiAtCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0KGR3X3BjaWVfZ2V0X2x0c3NtLCB2
YWwsIHZhbCA9PQ0KPiBEV19QQ0lFX0xUU1NNX0wyX0lETEUsDQo+ID4gLQkJCQlQQ0lFX1BNRV9U
T19MMl9USU1FT1VUX1VTLzEwLA0KPiA+IC0JCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywg
ZmFsc2UsIHBjaSk7DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJZGV2X2VycihwY2ktPmRldiwg
IlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOiAweCV4XG4iLCB2YWwpOw0KPiA+
IC0JCXJldHVybiByZXQ7DQo+ID4gKwkJcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQoZHdfcGNpZV9n
ZXRfbHRzc20sIHZhbCwgdmFsID09DQo+IERXX1BDSUVfTFRTU01fTDJfSURMRSwNCj4gPiArCQkJ
CQlQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTLzEwLA0KPiA+ICsJCQkJCVBDSUVfUE1FX1RPX0wy
X1RJTUVPVVRfVVMsIGZhbHNlLCBwY2kpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2
X2VycihwY2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOiAweCV4
XG4iLA0KPiB2YWwpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiAgCX0NCj4g
Pg0KPiA+ICAJaWYgKHBjaS0+cHAub3BzLT5kZWluaXQpDQo+IA0KPiANCj4gLS0NCj4gRGFtaWVu
IExlIE1vYWwNCj4gV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQo=

