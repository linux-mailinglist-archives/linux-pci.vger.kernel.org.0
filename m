Return-Path: <linux-pci+bounces-25777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4439FA8762A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A1188DB14
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03E2F32;
	Mon, 14 Apr 2025 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bEOZ9y13"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDCCA52;
	Mon, 14 Apr 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600611; cv=fail; b=lksxm9mJHnxo1mPsgy/zVLaLKAhQz1cPZD2egeI36mZFjODGIeUNrIzjZlUKwxNHrwJs8v4CHLJwaMfaaeyGmnGRk3mczGYWLkBPhl/+onWz1/oYFPQL1MNMUKvyrABxf3XXdiIcT27jvIVkAAtvwb6UWbfcL7kpH9XMOGNWOEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600611; c=relaxed/simple;
	bh=aXhT1LnacZz2ihp+omH5G7caOT3TYaFSngzhatX7COs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUwPMjuO8ePllziZinCfFDThYoJC3VbpJPqTj+2XoTqLviD9JDVU6SoO+U8wvxsZtlfB4rsWO/obsdzLkEG2gzvSXbaI/nH2B5K4Nk6/BOWQqJsZiH9PTKq8Jt/4dAPeFpeEoOn0ZI/y6j12bjauqccBxaC0Y3bJAl8+WyTgJV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bEOZ9y13; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPeVionxobVBNBRDWF+arQX/YZMU7LHd3aAtONVHtZSo+/nRjTtnWqMneMZs1mCNnwIwpGaUdgRdc5aTJtKobn+TcObiTm52o+OoUmeUqlslGT6inUvQMmaOFqUUJiVNA9mfVS3ICw1X34gCcKPFsG9nEgaYEfPm0ovwA4HQMB2O6XF9GVWmRCkOmfLZwGn7wA5f9uz5E7WTQp4VN7OlufSflbg4jHNEToh3Ccbk+icVu4rmnCoBYHzRlgjRkc82x2MwRgoHIUqCbnEL9BUOetrZtsCoIrosv2tl9ZxSPlbSO9ZL99g3iAdyFI6M7tc5TPoOTNDJHGtcsz6pfLRHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXhT1LnacZz2ihp+omH5G7caOT3TYaFSngzhatX7COs=;
 b=x8XpHdOyHZPqWFRmCS7TyNGG4kySzmtSM/MQy7DDjGa5aAy+YTVpurAQci2NGmrNbsigPouNOWFxwmXmieHuOL6lsNgioW41OmLnfUvwELHlgHrRnIEsQIxotQcy6c9gxC3s/s7tu3J8nzm3d3Z8ZeMRc9wuS4JYstPWwI6mE+hv7G08YIeD9r3A4NSLhnQqoAvNJvhXUbejCauCvR3W/gp8OGzh2qVJJFldZJIkQbH1WzRgxtqSQjfC2VkqrJSj5QyTLPmdxWrnA15i0A/+gzbFU3CCKQpjgLamLsb+leQB/c2w7SbndDQwD+WFwU8QJUvDFBypowKKs+P3ecKi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXhT1LnacZz2ihp+omH5G7caOT3TYaFSngzhatX7COs=;
 b=bEOZ9y13yH/kIj/uRx9ihiOApQ/WFk6w0frsXoCNmwgewI5KlwBOHrwiffOlT2mnHZMklvQdlxtpX41kYmx18tiYvlb4HX22Y8WAXCJ6MYJQx3VpGIpKNVu906i2+3FF3b24dLr21yRXzuTSeytaM6LerJEjmEvNMgga3GGcrgMJzpti5rmEynEM518S9zZwupXwUBBaHBcMR3qsqFFKrVuGvfIZdFbRpG6lNEFFIQiTVRfBEbi01DLwgenEtvMwzMd9pUiVcNN2CUbWmbtfSRWjxBEDPU6h7JCjjegXTmLsiwSq/YkThH/fE5F7rVXHATuhmpvey2nu2A/O/i1a+Q==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9782.eurprd04.prod.outlook.com (2603:10a6:10:4b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 03:16:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:16:46 +0000
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
Subject: RE: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Topic: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Index: AQHbqDKBL99Pwo1Evk2anRpEtc1bU7OhwmqAgAC+NgA=
Date: Mon, 14 Apr 2025 03:16:46 +0000
Message-ID:
 <AS8PR04MB867619A464E923655EDEF4878CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-7-hongxing.zhu@nxp.com>
 <uqrhqkmtp4yudmt4ys635vg3gh5sibhevu7gjtbbbizuheuk45@lhxywqhtbpak>
In-Reply-To: <uqrhqkmtp4yudmt4ys635vg3gh5sibhevu7gjtbbbizuheuk45@lhxywqhtbpak>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DUZPR04MB9782:EE_
x-ms-office365-filtering-correlation-id: c46a242a-dd0e-42c4-f312-08dd7b02ca02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OStTSndNKzlJTUYwV21wdUhITklOZ3JreXBnWERabEh0MENkSUI2QUlWdjdi?=
 =?utf-8?B?ZzJLeU1QU1NWczZoNVZZZDIzU1U1dTRtWGZNUjJvR3c4R1lhemRldS9meXJo?=
 =?utf-8?B?bVRTRzN5N3lDeDZTZk9JYmhHcnp5aDBtYTNHOFloK2I0VWRaOEpiWG9QV0hM?=
 =?utf-8?B?V2lwUktoeWEra25wdlFZVEd5aEU4ajMxaXRnYXYvWjVKT0RwTVhTYjFPU29p?=
 =?utf-8?B?bzcxVTlWWUExZVUyVkhwNnpXcGRlZE15UWI1cVRIcmFvMy9tdmpYbUtETnRV?=
 =?utf-8?B?Q0tPVmpqSWdzRXZldHMvREI5ZlhPZUc5N3RkNG80UVZ1SHlkcU01RjZEcmFr?=
 =?utf-8?B?OExWNWlrVFhuN25JTXpoTnpwOU1hcFNmSTF0VG8wYWI1VTcvQ255eFQ4K1Rq?=
 =?utf-8?B?VGhOd0wwL2laTlJNUzB4bnV3dUxJb0hBQTdqYk51UFlCVmxFbkZ2YlZURU1z?=
 =?utf-8?B?UVlIa1BsR0ZvajdqNTJDdHZ1eUZjVzVaemRYMW5WUzltemlLTGtPbng4UzF6?=
 =?utf-8?B?ZWRpVG9OMVR5N081SUlTbVp6bDFXbW14ZW42Q3hNbVhCSWVOMTFieis0SCt0?=
 =?utf-8?B?RWhPaUR4bDQrN2RidlZsR0tmUWVvV2FSTjBvcjFsUlhoV2lMWXNSM21meFBk?=
 =?utf-8?B?dTc0MmQ0REVxa21SWGU3dFBUbDdhcUFLVTFQaUxIVUVpWGZTTit6V3lhV1B3?=
 =?utf-8?B?b3Z0ZnM1KytURWRFbEpqQ3dmYktncnJhd3d5dnVkMC9mNENUNUhCQlZjZmxT?=
 =?utf-8?B?NHJUOThMaWE5TnZnc0t0Ynpoa0dZZ1NIM20xcUxoY2p1bXo3WGZBRm5wdU9K?=
 =?utf-8?B?Y2NLa0RWTHl5VVFacG5UZGRtQ1NHbUdScW1Sb3l1SmVOZGRtZWlFcDhPYW5k?=
 =?utf-8?B?N1BGVHo0NkpKbmVXaDJsbVlNd2t0b1AxWW9lekJLbWxtQ0NudnRId0M0OHc2?=
 =?utf-8?B?dmRQdVprV25YTTAycDQwUXZhRjNWYTNaOFJoU0c5ZW51S0Y1aVhJSlJFd1hB?=
 =?utf-8?B?Y1FxSjhmK01tYkpJSDlqR3JNRFN2aTRZZG5EK2hMbXJnSWhwTXd4cHdiZW1j?=
 =?utf-8?B?dDRRSHdPSGM4MUcyRTZWMDBKZTVPT1NOUWQ0V28wbGxpenhYOE4vT1FiWVFj?=
 =?utf-8?B?M1k0MVBOVm50NkZzckhlb29hSUhzbWRRdnk5OGhzZmVpNzhxazBlWFBJMUZv?=
 =?utf-8?B?NThORkFaTGJQTGxXbnphZ2FGQjlxc2pGNFJwRDVRbUw4YkZaM2FEL2c5WGdk?=
 =?utf-8?B?cWtQZ1k1T3R2VEVoNGxxbWhmOVVDVWxReUxrSmpTeWloajQ2M1hzblVpYmhG?=
 =?utf-8?B?QXVlTndSNVdYSjBSRFFEQUxDMndoSUV0aHp6ZWE1VDBuYUlNbVdHamZ0dUF0?=
 =?utf-8?B?WVQxbXBQR05HdnhGbE9mYWNiaVdjYzkvcHJlUnF1c2xSMHdkY3ZSSU1wT2xl?=
 =?utf-8?B?ZW5kdzl4emhtMk4zd25rekN2SzF5Z3Qxb0FaNEIzWGJvL2ZnMjM5OGM5WjlN?=
 =?utf-8?B?YUJnZ3pNckU2all3amY2b0VLdHh6aFNvdnlLSGdvNW5OdmZYaUQzNldUS052?=
 =?utf-8?B?NnlDSlMxOUEvWlB1MTlHekw5MitvQUliSEYxTlVwNWtHaFhjdldpRFhSRVB2?=
 =?utf-8?B?UzdzMENrcmpZQm9na1AwUEhGQTZlMzJzdGFFUmJjTDdqbzdKdUN1YWpVeldK?=
 =?utf-8?B?Rlg4OXRQU25XN3J1NGwrMkY2Z2NqRmhSZDUvR0RCd2hNdFVhN2MreHBrUXVU?=
 =?utf-8?B?ZlpmNjB4aGZPUnliWGtXc1czbE1iVks3TWM4cmpVRTkyd1BveGJFc2J6cWdM?=
 =?utf-8?B?K3ZocXZ6QW5NQmlsek1ETmNJMlR2RGdua1lwblpVNkF6Tm1WaGpFY1JuWUty?=
 =?utf-8?B?c2RYczZIKzV2NUdRelVvV2JORFJHK2h4UGVnaStMeWZ4ZkxLNlZtL3ZsZ2kz?=
 =?utf-8?B?eE9oQW56NkpjSXJ0RFlkUVNybXFGZlRodkVqc0tmSDlyM3JJSnJqc0gvY1lM?=
 =?utf-8?B?Nm8vWmZadWhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aytXcEpYK0dKa0gwK2ZDQVJ5OGEveTkrbmRzMHdsejlqWXFSVndFQzcweEVI?=
 =?utf-8?B?MEJBZ3FwSkRnVzNaTS9sSUtmN1Fxa1lKT3RvR2ZzbHN2cS8rMjBXTU9Mamtp?=
 =?utf-8?B?WEdJTGMrSll0c2ZQbnBzamE2dFdmb0FhU080d3E2QklLbDlCaHpKc3RPS3cy?=
 =?utf-8?B?emUrNWtscXVMb0s4L2NXa3BjSUJhT0wzWUl3M1NJa1YzbkdzZ2lWNmlxSDdi?=
 =?utf-8?B?WURieVJQZ2dCSUFRaG1xeVU2RkhmVkN6L3huam1QZmd3cDRGejRzNS9MRDlL?=
 =?utf-8?B?dFI5UmhaNTNKOVNzNTNjYS8xVW51UmorVGFGMUQ0QXErNWh2NStTbEM1bXUr?=
 =?utf-8?B?bXA0NDl5VnB1RU91SzVoMTllS1Y1VmJmRGp0aXc2NnlTU0tIUUMvRmc4d0t6?=
 =?utf-8?B?WmNvYWRUVnltdCtJRTIxMjIxMzM0VE52SEc4RW1mZlltdVhHNk9Cakp4cXZh?=
 =?utf-8?B?RGJuaGphejk1TVF5QVBTT0pwZEs3MTJpaGhtclYxZGVnMWl0bkFJM1VvUFgw?=
 =?utf-8?B?NlB0d1NkNyszZjk2RitxVitsbExHcityUCtUM1dFd2Z4aWpmRDhmUTZHeVpY?=
 =?utf-8?B?b0RpYVY4THpSenR0WUZodWE3czI4cStpZ3FtNWRWNDluTVF6MTNYRWk5b0tD?=
 =?utf-8?B?M3EyUzhzQkpjdUV6SldNYzJ1cVVyTXJBRVRvc0VhUzVuV0NaN3BYQnkrSUZS?=
 =?utf-8?B?S0NxRGVQVmNaNzYyU1NaR3Zlb2dJdlIyeThTeUoxdW85WENTTDROcTJkMjYv?=
 =?utf-8?B?NmZwazJvWFMrcmJMbEJMWXZEM1FpaHhwUWdpWUdCMk5IWW5kb25MTWxnSENL?=
 =?utf-8?B?M0ViRmwzMHJ2ZGtLM2gzaUYveFo4d1gxOE5MR1pvTGd2Y3A2eXBISUx5V0JM?=
 =?utf-8?B?N0svblhlSHd5UHRUS2ZsZVpleVpKaUhTckJQOFJ6RGN4UmRSd1BRZ0xMUEVV?=
 =?utf-8?B?NmxKMmZGWjFPeDRCTUNvWVFRbUFuOXZaSTkzZHczUnhZWnNUVXc5QVMvSi9i?=
 =?utf-8?B?bXhhSlR5WVk5TG9JMjhpYjV0WVhIVEtmWjhnNi9GQ0NRdnZtUDBEUjArZWgx?=
 =?utf-8?B?S2RnTUZIS29ZUkdPTmV1anJYOGFLdUZmQ1pCMHVEeVNha3VnbElVbmlaMXdl?=
 =?utf-8?B?ZUFzMkdGdmxtZVBKbm9RN0JSTHdCRmZJZWhhSklPQU41WlVFb1JKTm5MbTFD?=
 =?utf-8?B?RkpPYTJyaGtqdzUzVllRUzdTY05xdTRiTy9ZS3JPTEVnU285Rk8wWm9yNFgy?=
 =?utf-8?B?S2lESlhWUnBXUCtuV2VXQ0ZrVzY0ZktSQXhWeWIreWdEeGpvT0xxdjEvQTFC?=
 =?utf-8?B?TlpoMVBIU1VmMEgyQzlWWHBWaDRZTUErOUcxVFIvOW11NDNzL1U1Z3VqWjBv?=
 =?utf-8?B?UGdnb1JsSk1IYzIxcERqT0paWHYzQ2QwS25Zc1VkejQxS0QvL1lCT3A0N28v?=
 =?utf-8?B?UnRRVytYNG5zcjlabFFheW5HaWxYSE1XTzc2RmVlMGt1Y0RCNjl2b2ovNUV0?=
 =?utf-8?B?ZzlyNm5TQnNXbksrSHIvUEY4eFpaeTBEMWhsdjRQOHdvbU5qVzl6M0UyalFw?=
 =?utf-8?B?VlFKNEZ4VTlacjZPYnIzNWRMSyt2bFVqY3lIWk9udnhkYVhzazFOQmtVT1Yr?=
 =?utf-8?B?OXF4dUo1Y3dJMWdBNDBMcTA0RDNKRFQramg3MkRxZ0JiODQ5bGhUSGZRc01W?=
 =?utf-8?B?dzhhK3kxRzh3bGhXRTJMckU2WUFmT2E3Rzc2THJRYlA0emkyOVBucXJhbnhV?=
 =?utf-8?B?VlZ2MjhuaUFZWFpJNCt0ZCtnakRpRnIyOFFoN0dtaFRzLzJMLzBCWDl5ZjAv?=
 =?utf-8?B?eEl6a0pkUGovNVhyMDZrbmttNnJjd2loUS9jekdKOGRTcG9CbEpJU3dMd0NH?=
 =?utf-8?B?cVVPSjdVNW5WWllxOTBKMXZuK2VWM3dycGlEMkg0NE1DTHk4eWhFbHcyUnNL?=
 =?utf-8?B?VlR0bmNFMHZxNis1T1Rva1pNcDcya2tvMmNySU1VbDBMMjhwUVFnU1ByS0lm?=
 =?utf-8?B?cGw2N01oWEdScyt3dHdiYWc3bFAvRlVSWkxJTUllRmpheFZBWFg4WkRjbFdL?=
 =?utf-8?B?bUVRRUU4R2JPOSt6NUJMWGplN2xWVGVxWnRvSGdlWXN0MFdPdEV4cVRHZG5D?=
 =?utf-8?Q?NwaD8IfCUGpGnoIN7tTiG4w9q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c46a242a-dd0e-42c4-f312-08dd7b02ca02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:16:46.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjuXnuTSugY5RgEPejrcGGu3/60PDANKI36lAt9mhWrBqKH3aJQ9m5GtTRDAyilvRtZp4AER+LawULvW1f22cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9782

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDEz5pelIDIzOjMzDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNi83XSBQQ0k6IGlteDY6IEFkZCBQ
TEwgY2xvY2sgbG9jayBjaGVjayBmb3IgaS5NWDk1DQo+IFBDSWUNCj4gDQo+IE9uIFR1ZSwgQXBy
IDA4LCAyMDI1IGF0IDEwOjU5OjI5QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFk
ZCBQTEwgY2xvY2sgbG9jayBjaGVjayBmb3IgaS5NWDk1IFBDSWUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMjgNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiA+IGluZGV4IDdkY2M5ZDg4NzQwZC4uYzFkMTI4ZWMyNTVkIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTQ1LDYgKzQ1LDkgQEANCj4gPiAg
I2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9HRU5fQ1RSTAkJCTB4MA0KPiA+ICAjZGVmaW5lIElNWDk1
X1BDSUVfUkVGX1VTRV9QQUQJCQlCSVQoMTcpDQo+ID4NCj4gPiArI2RlZmluZSBJTVg5NV9QQ0lF
X1BIWV9NUExMQV9DVFJMCQkweDEwDQo+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9QSFlfTVBMTF9T
VEFURQkJQklUKDMwKQ0KPiA+ICsNCj4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1NTX1JXX1JFR18w
CQkJMHhmMA0KPiA+ICAjZGVmaW5lIElNWDk1X1BDSUVfUkVGX0NMS0VOCQkJQklUKDIzKQ0KPiA+
ICAjZGVmaW5lIElNWDk1X1BDSUVfUEhZX0NSX1BBUkFfU0VMCQlCSVQoOSkNCj4gPiBAQCAtNDc5
LDYgKzQ4MiwyMyBAQCBzdGF0aWMgdm9pZA0KPiBpbXg3ZF9wY2llX3dhaXRfZm9yX3BoeV9wbGxf
bG9jayhzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llKQ0KPiA+ICAJCWRldl9lcnIoZGV2LCAiUENJ
ZSBQTEwgbG9jayB0aW1lb3V0XG4iKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGlteDk1X3Bj
aWVfd2FpdF9mb3JfcGh5X3BsbF9sb2NrKHN0cnVjdCBpbXhfcGNpZQ0KPiA+ICsqaW14X3BjaWUp
IHsNCj4gPiArCXUzMiB2YWw7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBpbXhfcGNpZS0+
cGNpLT5kZXY7DQo+ID4gKw0KPiA+ICsJaWYgKHJlZ21hcF9yZWFkX3BvbGxfdGltZW91dChpbXhf
cGNpZS0+aW9tdXhjX2dwciwNCj4gPiArCQkJCSAgICAgSU1YOTVfUENJRV9QSFlfTVBMTEFfQ1RS
TCwgdmFsLA0KPiA+ICsJCQkJICAgICB2YWwgJiBJTVg5NV9QQ0lFX1BIWV9NUExMX1NUQVRFLA0K
PiA+ICsJCQkJICAgICBQSFlfUExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFYLA0KPiA+ICsJCQkJICAg
ICBQSFlfUExMX0xPQ0tfV0FJVF9USU1FT1VUKSkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiUENJ
ZSBQTEwgbG9jayB0aW1lb3V0XG4iKTsNCj4gPiArCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGlu
dCBpbXhfc2V0dXBfcGh5X21wbGwoc3RydWN0IGlteF9wY2llICppbXhfcGNpZSkgIHsNCj4gPiAg
CXVuc2lnbmVkIGxvbmcgcGh5X3JhdGUgPSAwOw0KPiA+IEBAIC04MjQsNiArODQ0LDggQEAgc3Rh
dGljIGludCBpbXg5NV9wY2llX2NvcmVfcmVzZXQoc3RydWN0IGlteF9wY2llDQo+ICppbXhfcGNp
ZSwgYm9vbCBhc3NlcnQpDQo+ID4gIAkJcmVnbWFwX3JlYWRfYnlwYXNzZWQoaW14X3BjaWUtPmlv
bXV4Y19ncHIsDQo+IElNWDk1X1BDSUVfUlNUX0NUUkwsDQo+ID4gIAkJCQkgICAgICZ2YWwpOw0K
PiA+ICAJCXVkZWxheSgxMCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXJldHVybiBpbXg5NV9w
Y2llX3dhaXRfZm9yX3BoeV9wbGxfbG9jayhpbXhfcGNpZSk7DQo+IA0KPiBJcyB0aGlzIFBMTCBs
b2NrIHJlbGF0ZWQgdG8gQ09MRF9SRVNFVD8gSXQgZG9lc24ndCBsb29rIGxpa2UgaXQuIElmIHVu
cmVsYXRlZCwgaXQNCj4gc2hvdWxkIGJlIGNhbGxlZCB3aGVyZXZlciByZXF1aXJlZC4gaW14OTVf
cGNpZV9jb3JlX3Jlc2V0KCkgaXMgc3VwcG9zZWQgdG8NCj4gb25seSBhc3NlcnQvZGVhc3NlcnQg
dGhlIENPTERfUkVTRVQuDQo+IA0KPiBJZiByZWxhdGVkLCBwbGVhc2UgZXhwbGFpbiBob3cuDQpU
aGFua3MgZm9yIHlvdXIga2luZGx5IHJldmlldy4NClRvIG1ha2Ugc3VyZSB0aGUgSFcgc3RhdGUg
aXMgY29ycmVjdCB0byBjb250aW51ZSB0aGUgc2VxdWVudGlhbCBpbml0aWFsaXphdGlvbnMuDQpU
aGUgUExMIGxvY2sgb3Igbm90IGNoZWNrIHdvdWxkIGJlIGtpY2tlZCBvZmYgYWZ0ZXIgdGhlIENP
TERfUkVTRVQgaXMNCiBkZS1hc3NlcnRlZCBmb3IgaS5NWDk1IFBDSWUuDQpTbywgdGhlIFBMTCBs
b2NrIGNoZWNrIGlzIGFkZGVkIGF0IHRoZSBlbmQgb2YgZGUtYXNzZXJ0aW9uIGluDQogaW14OTVf
cGNpZV9jb3JlX3Jlc2V0KCkgZnVuY3Rpb24uDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUN
Cj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCu
muCupOCuvuCumuCuv+CuteCuruCvjQ0K

