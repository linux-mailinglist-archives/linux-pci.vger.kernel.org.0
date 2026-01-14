Return-Path: <linux-pci+bounces-44704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA72D1CB58
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96722300D2B6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666836CDF9;
	Wed, 14 Jan 2026 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XZKKJRIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AE36C0A5;
	Wed, 14 Jan 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373189; cv=fail; b=r3ho4OD/FK5VS64rn/5osIiHC+zCb3Os7vQ+NM+zzySZHm420muYdqEofrGHr7JaA1KXuP67RTibHDO7HNeHBQ0ZHIa+cQj1T4u5Yq4I+3TQRivqZsDq/IC/LcCPbVcykX+jYMQmVBZ/BUjv6xSVL3FKnCGoxOBrO7O+KkZ20EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373189; c=relaxed/simple;
	bh=OqyUPRKa2Cs0NnAmw6/59U58FLdE6n5e5AFW+WrbL10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jg9+9ZN1hEFjzjOTw9FqgGjnpOxoTHHIIZp5yxlZXIZjPIZB2uz6v1LB7vJkLo+WmJ739q9p2VQmPtDANL2Xw0lJUpPuuKGyEZbFnV6cGd6BqKTBBMQ+HoDoUeTH6jtX7i7tk7tgHKmIPJgbaoAO+89hdklxiaTs7SJDws/UxOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XZKKJRIj; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKC+c/mHZ2Qn/P+eAGKcpZiZc1bjucg32XpqUhqTgL5exVw473IznnJhMRqyMGnZHCV8vfV6XdabX0ZTAvSQxv62OWCj4NllSFZE8GrilclXZ5CsaVK6HoFCeXwzqaMmyDdUW6EWxPIkYSWQJJE37O+dyof70HlgOaGofJ2WZ3yE3LopTkS9W98AnFCStrvpHTeidnRXn+ol5gqIqOnsBbdvmmfxizrtCu/DqcaRMNbT44uKUXOdlYZj2gvC802i5B2zIt7X1C3iwUfTlpFen/zu5EQfP2lw2iNLb7LDLyyiJIVlmcm+AySRn83yM7OR+/pZe9ov0o32fvrGxxiSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqyUPRKa2Cs0NnAmw6/59U58FLdE6n5e5AFW+WrbL10=;
 b=Ax2nOrK5J7G5ZqQHxRFqXBvxzLxpanSksAcIk7+M2h7JgYlwvjy7F+TAciikO8djaripp5Z0IIEs0wqF5f/N5T2e4MyBAceu8qwoDPuBy59usrSN+/CYpJGWRyLG89ZVECI11c9VPWOckNgVYCcDrPEptmp1OeVforURFiYwt2jsjzeYiuk9zPJCH8pd3oeh+FhMbl0Rc+ifiIxsB9OuxjWch2EW6lRUrXL+zf49RUs8+ENAyO0Mm2iXHA4Kyz05Uyw2iwR2DkRvZ4NBf0M+P+cO10iIUlzhHUp7dLy9Ytx00y6J9ZPDcWtHsSTylbCwsTNoT/op7iiU9sj8sNx9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqyUPRKa2Cs0NnAmw6/59U58FLdE6n5e5AFW+WrbL10=;
 b=XZKKJRIjV0RP/qP070S2pxrmKKMHdd5HNodcVVDiK7jFkqHrrLhyDPrHvTNWtKDvdTpTF2yWjiUpp/qnAAia3LnfUf+bsIiQxKBn675vweY+Shw9MpQFTEKwNLsv2+u8by4CtBty5iTOW4Z8P8FAJRvpK08SvaR8mZodu1Sm0VRpvck4CKZBYWDDtf2thTpfSAvoh0bO3nL+rX2xmXcypYcajq+3MMy01sAw20nXsLj/vVcx5eP9sR742+DWvtJr9Hai3QdJNIcKEQPfOZCMc7ofioCYY3gtQ9aklB1Dad/HSZNnqWrrgPgLT96I/DiCbSsPt+grCtbriMP57h0XeA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8664.eurprd04.prod.outlook.com (2603:10a6:10:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 06:46:23 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 06:46:23 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v8 2/2] PCI: dwc: Don't return error when wait for link up
 in dw_pcie_resume_noirq()
Thread-Topic: [PATCH v8 2/2] PCI: dwc: Don't return error when wait for link
 up in dw_pcie_resume_noirq()
Thread-Index: AQHcf3/iGf01b3AqUEy45JJyK6ZwC7VQQ/MAgAD7zfA=
Date: Wed, 14 Jan 2026 06:46:23 +0000
Message-ID:
 <AS8PR04MB8833FD0095481ADD280363628C8FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
 <20260107024553.3307205-3-hongxing.zhu@nxp.com>
 <7akwvdfve5jcj2tm7jiwowkvcctsmqeslia4pulvtdgcgicp4p@h5ztwyp4h7ft>
In-Reply-To: <7akwvdfve5jcj2tm7jiwowkvcctsmqeslia4pulvtdgcgicp4p@h5ztwyp4h7ft>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU2PR04MB8664:EE_
x-ms-office365-filtering-correlation-id: 302f7d2d-19b6-442c-23be-08de5338a226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?czN2bUY3dkxvTlJ4YjdBWm1ZMjBlYXJWbHdrb0tuNEFhU0RhTGg5d1I1RFlP?=
 =?utf-8?B?UVZ4RTJnWTA1WnhCTFNuWkpjYmczRE1YUWdOUU16TFZJcElWbkNOcDhoVXc0?=
 =?utf-8?B?UVRNL0dBQlpDdlpRblRLQmhpem1DanUvaWFXTHdiTm9NR3BUMGFLbkdHalhm?=
 =?utf-8?B?dC9DSlo0blJrdHdkZ2k1c3ZpdUVXZGNETm9NdUxNbk5CZGxwMUNVQmFqMzZL?=
 =?utf-8?B?aUhzTFpYNUxyRHdRWWdZaENjWEFEeEI5VElqR3RTSkFnekdCT1U4cnJnSDJN?=
 =?utf-8?B?MUpiUTdtSTNkb0ZPQVUwTDNzTzB0aThCcXZFRzVJeVhiMUE5VVZVNTE2eEUw?=
 =?utf-8?B?V2s2YmZwQXlodFRaY1dTMzh3N0dzS0ZVWWRTYjFrZ0RaZG1yTlBObHRiZmhO?=
 =?utf-8?B?OXJiN3lBNDlacXdBQW9mWTVjdzdHRnA5cU1SSXVnQ0xNKzZlOTBtWEgrMmNa?=
 =?utf-8?B?MTlDUWZjVHpjYkdOd1F2RGFTV05qR3EveHZJc1hiUi9pYlduL3luSUlBUVpn?=
 =?utf-8?B?M2pJelRrYWlpaXZGT3FRYzlKNFkyVmovWjdjanhnaEhsa25kYjlxb1Fib1k2?=
 =?utf-8?B?a1hlNzJXUFRLUE9PT1NYV3k1NFZhcmhoNjV0VzVZSnhSby9SL3krQSszQnUz?=
 =?utf-8?B?c2JxZXdTY1BQTHBybGxIL3ZDa2hySThQYmJuUE8zWFZLWUkraDBoMjgyRzJD?=
 =?utf-8?B?UkJEcVlseUkwa2tmVmZkd1g2UlJPWXFFRVVCMWJzc1prUUxJNWtFL0FyYlpV?=
 =?utf-8?B?Ym9RMkFtWEgwUGhQbENSMFZyMzNyWHRFakZ3TlFOUk83RndBU1h4ZHFaT0pt?=
 =?utf-8?B?U0p2aURlZ1d6akJSUVM2UnpRUklqWThVNTFUVWRyYVZVSkR1a0I1aC9CT2Vh?=
 =?utf-8?B?aUsxbW9ETzF1UXl2bHJON01mcVVlcnV4L1Q5WFJna0FPWGh1UUV5NFUrSHpB?=
 =?utf-8?B?QXRCSThxTHh5K0NGMXJnTGlldWRKaVFUcUJNZ05jeVdERTJON2hRalNjeTBq?=
 =?utf-8?B?bGVVeGNBeVdZUityeit3UHRFeHJlZlBCbVlFbExQRE9HYVdVZWpGWjdSMHlU?=
 =?utf-8?B?T2Y4SHBUMG90MnF5QVdQNUNhSUNmQlpycHRtZmxJMG8xY3c5cXZWVWZjLzdO?=
 =?utf-8?B?VTBNQ2VwTWcwNUxUTzkwRDRWck5XWnEzRWZsZEYrUDlxQVE4dnRlV0VCdE9l?=
 =?utf-8?B?Q05LcnVveGc1VWlaTDIzUm1XK1RsSTJUMis4bTlrOUlUQW1sMjVLMHVSa0Nt?=
 =?utf-8?B?cGtJQUtiakthblphaEt0YWFkb3JSMkxJaHhmVis2Y2ZaalMwVHZXSU53QWNp?=
 =?utf-8?B?UWg0dE1QSlRVL3dzUW5rdnZWakVHaUxuLzRWK003TTVGc25ZNTBvT0VsN096?=
 =?utf-8?B?bFNpcW00MThKOHFlYTdSWnVjcWM4UG9aQzJ5SUJNUmdXK1hFWEMrQUFkOVlB?=
 =?utf-8?B?OEQ3azB1Vk9mQUZNQ1cvWUUydjhVVkJDZW0vS3N1bDQyS2xYd2FxYmtjbkJG?=
 =?utf-8?B?ZlNzcVVKUVB3b3BSTWRIaFNRcllMdk5zTTBYdkc5dUdpaWpUK0dxSFB1TVFV?=
 =?utf-8?B?ZmpGMzZWd1J6R1dSSDFQU3hIOWpjTTFONGFnK3FmSVljMVdDNGN3WGdBMkpF?=
 =?utf-8?B?d0UxZlRWRVBnbkhVbk9lcHRPbEdFK04wazN5RURTQXUvaHd0blA3SHpzRUtr?=
 =?utf-8?B?RjhoUmg0MVkyc2g1VjNPUktmYVNlc0xuYlczbnFxK3hCeGdmZ2dFaFFwZndI?=
 =?utf-8?B?dHlBdCsyWVhQZUFQTmxPNllSZGNhbTN0S05CMHpqSzNqVm5ZU1JycnhIcWhM?=
 =?utf-8?B?NDJkRGdueXg0aVVJN05QZWNBTlExZ3d6NFY0eExnbXVQZU5YbEVYMjNjazVF?=
 =?utf-8?B?c0FFaVdWMmdKU1JHNDFSZlRmUGhMRm5zN1FiUHVGaGJKc3B6MloyVUdRUDR5?=
 =?utf-8?B?T25tWVJVVDRMcXZkT2ZFY2prNUd4eU4rNFBDbkMyRUxRM05KRXNDS3dDdFZ4?=
 =?utf-8?B?RHl5U0ZkYXRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3VzUTZJOWViVU53Q2psT3dOTE5SOFArWExuQkljckxuUWRuQTFmb3lhWGVF?=
 =?utf-8?B?T05VcnRrUWNoc0xKVHlkRkpPS2dKNWNtRUFSZDlPVlFiYjlXaHNwdlRzWTRm?=
 =?utf-8?B?bWY0QmwvZFhnRXp4ajlEdnVUYXFrdDRnSmxMRklQbE1lN0VnSUtmZkU5OUxG?=
 =?utf-8?B?VVZNQ0FRcnJyR0RZSDh3elgwRlFENnZSK0JSbXhJbTI0bkJaVVhrZVQxZzVu?=
 =?utf-8?B?L1owdG9TbUVjc2xRQkFLZU1GMTdKZFJZYW1qWHA0SnhmV1BkMmdtSmNNRWow?=
 =?utf-8?B?U1MwV1ZKZUZOYjg3ZnhKNk80NDVjR2ZqSEFFdnhMSXljd0Faand4ZDJxWHly?=
 =?utf-8?B?ZEJUUXg4ZHZyMy9POHVnakdwaG03VlptdTVIRGhJTXIwd1N2dmxwRmFVbmdh?=
 =?utf-8?B?bWhBVDQrRmtWak1rd3lGRVg1TGFncFRzOFFoem0wQWVtU1NVZTErY1JuV1lp?=
 =?utf-8?B?RjlVbWRpbmgram14Wng0NXlXQ1dDRnRpVkoyMzVWNHh0RE5VaGJhWTZXOXVY?=
 =?utf-8?B?dmo1OTJNRlpKSGlPcG5mN3h4d3hGR2U5TTJtZjVJL3Q3cjk4QTMwQXVIUGdZ?=
 =?utf-8?B?QWREMDdtdUlTTU9mUUcxTy9vR3JxYTFVZHlQRFpHTDhzVDhkclU1Wi9jcXAr?=
 =?utf-8?B?VVRHeWlFc3dzRFlFNzFpUnU2Wm1HWGRYM3FhSmFma1oxZ01yeklZWHhCdndm?=
 =?utf-8?B?WEZvTGhhSm45OGcxRGwrc2xHbnNEMVFnWHRReFdrT1M2YXhYTnhuU2ZoNXda?=
 =?utf-8?B?REQ1WFArS2tmV0xqaURQdDFMRHpsa05OVU81VytyTkczN05TR29xL044THFr?=
 =?utf-8?B?MmZMNVd6bTZrY0dWZER6YkcyM05IYXRPdFZtUVhQSTJmNnE3VDFKZjZZSWRh?=
 =?utf-8?B?QzUvNENUUnhwUExhWlpZNi83Zjk1anU2NFZTZVVoaDg0YlFrNk5YcEVSTTl0?=
 =?utf-8?B?TDZxSjVad3g3eURSMXdHZnhyL3R0WVN3bkJaUEF6MmdKdlpwcjVQVlI4YXBL?=
 =?utf-8?B?b3hDUytKTkNGVWg4UEVyN1lFN3ExWUpXZWZQWHBtUE80TUdQMlNzS3VKcWVR?=
 =?utf-8?B?Q09heHhjd1ZBdUNiRmJYT01pampXS3Zxbmdvb1hNeXBDT25SQmVvMUxuREhF?=
 =?utf-8?B?eW4yK0l5L2V1Q2c5VGhZWHpCT3lJdGkzZ2RSOVJZbjFFVDlNSUl0amRadXNP?=
 =?utf-8?B?UEdwd094N0RESmRiUmppUkw1QTg0VDJuRnNnV3BVL1VTa3pJbFBuVk9wK2wy?=
 =?utf-8?B?cWYvcGl1UzQ0WDJ0dFB6NHEvTVBxUDM5TTJzQnk4NzZTa3ZQVUlPRUpFN05J?=
 =?utf-8?B?TDI2SHZXdTR2TU56WWJVdk9WaTFzSmE0OFZhbWhHTkZOdTVNN0hSSzQxOXlt?=
 =?utf-8?B?Tk4xam04Rm9CeFlQenVJeDZjL3FXNzBya1p4Y3hVNHQ4UStCSHVhYlRCYlBM?=
 =?utf-8?B?dWJPcThVWVAwTHpVbkF0Q0NzODFzbWxOeGhlSFZpNUZ1Y2FHVzZKV2VaRXEz?=
 =?utf-8?B?NWEya2VsZEo1S2gvOW9tTXhub2E2RFJVTER6OTRVZmN6TzRiOFV1WVRmMnNP?=
 =?utf-8?B?UVhtSnVRelMxYmZrUkVNTW9iMWY4RklNZmNOcmIwellSdjlwSHdIMGdtWDdx?=
 =?utf-8?B?WlVtbkJOV0pqQnFZUjVkZFJqQ05pbnpYTURZSDR0Vm1ZQkg0MWE0YUV6NGFw?=
 =?utf-8?B?Y1RpUGhkS2tTUThjTlFNU3NDWTFXbHR3MHZVMi8zQmkyemE1YWR5N3BzVGU5?=
 =?utf-8?B?SjFOOGlCKzBJM1BIbE54L25hMzNhd2R1V0Y5bjNlRXVYU1MwdjE4SWV5RGNm?=
 =?utf-8?B?alR2K3lkSWhhM1g5ZlVGUEdaZFNPUHJzdTlBL1pSZDIzeWh4cWlkdE1HM1c3?=
 =?utf-8?B?YzgxYTNNM20rekhkNFF1L1RnbEN0LzhVT2ppb2pvSnhMUHVoRmsrU1lCak1m?=
 =?utf-8?B?UENjdFVUQkxHejlCSzJFeDlQRU5tY3A0enRoeU1rL0hxTVpvZVpKV1hMNkV1?=
 =?utf-8?B?LzEreVgyQ3Y2VDhza2tPa0pyTHNNTm84UWp4c21vTnplZEdFdFhpU1hYa21M?=
 =?utf-8?B?a2w0d2RzeGpOUi9tam90SkhjeWY0ZlFpNTk1dUltVGJ5V1RSdms5OU9lL1Jj?=
 =?utf-8?B?TDFHS3ZlcnAwQ0tOYWtSQ2ZYeWtRVmZKUlpOOXAvTjFSTVJmaTB0UGd0Sjlp?=
 =?utf-8?B?YUZMb3V0Mk44dDhmZ0FTNUhCRnE2dVZGU0d6M1hTNFY5K3ZMbXNIM0lKS1Zq?=
 =?utf-8?B?WWltTE81THJZWDd0WkZEcURRVksrNE1XNlltK0RuZ05GczZZREY3bGw3d1Ru?=
 =?utf-8?Q?6ZlFDFmYgiSi5ORsdJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 302f7d2d-19b6-442c-23be-08de5338a226
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 06:46:23.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81V7Eub51QNAA+FxZUD2VMiXRBRcm3CWy+s8kXfNub8N22w4m8es0JroPmrZegwZUSdX9og9h4EuX527ocQ28g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8664

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDHmnIgxM+aXpSAyMzozMA0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjggMi8yXSBQQ0k6IGR3YzogRG9uJ3QgcmV0dXJuIGVycm9yIHdoZW4g
d2FpdCBmb3IgbGluayB1cA0KPiBpbiBkd19wY2llX3Jlc3VtZV9ub2lycSgpDQo+DQo+IE9uIFdl
ZCwgSmFuIDA3LCAyMDI2IGF0IDEwOjQ1OjUzQU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0K
PiA+IFdoZW4gd2FpdGluZyBmb3IgdGhlIFBDSWUgbGluayB0byBjb21lIHVwLCBib3RoIGxpbmsg
dXAgYW5kIGxpbmsgZG93bg0KPiA+IGFyZSB2YWxpZCByZXN1bHRzIGRlcGVuZGluZyBvbiB0aGUg
ZGV2aWNlIHN0YXRlLg0KPiA+DQo+ID4gU2luY2UgdGhlIGxpbmsgbWF5IGNvbWUgdXAgbGF0ZXIg
YW5kIHRvIGdldCByaWQgb2YgdGhlIGZvbGxvd2luZw0KPiA+IG1pcy1yZXBvcnRlZCBQTSBlcnJv
cnMuIERvIG5vdCByZXR1cm4gYW4gLUVUSU1FRE9VVCBlcnJvciwgYXMgdGhlDQo+ID4gb3V0Y29t
ZSBoYXMgYWxyZWFkeSBiZWVuIHJlcG9ydGVkIGluIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpLg0K
PiA+DQo+ID4gUE0gZXJyb3IgbG9ncyBpbnRyb2R1Y2VkIGJ5IHRoZSAtRVRJTUVET1VUIGVycm9y
IHJldHVybi4NCj4gPiBpbXg2cS1wY2llIDMzODAwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNh
bWUgdXAgaW14NnEtcGNpZQ0KPiA+IDMzODAwMDAwLnBjaWU6IFBNOiBkcG1fcnVuX2NhbGxiYWNr
KCk6IGdlbnBkX3Jlc3VtZV9ub2lycSByZXR1cm5zIC0xMTANCj4gPiBpbXg2cS1wY2llIDMzODAw
MDAwLnBjaWU6IFBNOiBmYWlsZWQgdG8gcmVzdW1lIG5vaXJxOiBlcnJvciAtMTEwDQo+ID4NCj4g
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiA0Nzc0ZmFmODU0ZjUgKCJQ
Q0k6IGR3YzogSW1wbGVtZW50IGdlbmVyaWMgc3VzcGVuZC9yZXN1bWUNCj4gPiBmdW5jdGlvbmFs
aXR5IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5j
IHwgNyArKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IDA2Y2JmZDllMWYxZS4uMDI1ZTEx
ZWJkNTcxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTEyNDUsMTAgKzEyNDUsOSBAQCBpbnQgZHdf
cGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgICAgaWYgKHJldCkN
Cj4gPiAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLSAgIHJldCA9IGR3X3BjaWVf
d2FpdF9mb3JfbGluayhwY2kpOw0KPiA+IC0gICBpZiAocmV0KQ0KPiA+IC0gICAgICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gKyAgIC8qIElnbm9yZSBlcnJvcnMsIHRoZSBsaW5rIG1heSBjb21lIHVw
IGxhdGVyICovDQo+ID4gKyAgIGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPg0KPiBJdCBp
cyBub3Qgc2FmZSB0byBpZ25vcmUgZmFpbHVyZXMgZHVyaW5nIHJlc3VtZS4gQmVjYXVzZSwgaWYg
YSBkZXZpY2UgZ2V0cw0KPiByZW1vdmVkIGR1cmluZyBzdXNwZW5kLCB0aGUgbGluayB1cCBlcnJv
ciB3aWxsIGJlIHVubm90aWNlZC4gSSd2ZSBwcm9wb3NlZCBhDQo+IGRpZmZlcmVudCBsb2dpYyBp
biB0aGlzIHNlcmllcywgd2hpY2ggc2hvdWxkIGFkZHJlc3MgeW91ciBpc3N1ZToNCj4gaHR0cHM6
Ly9sb3JlLmtlcm4vDQo+IGVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMjYwMTA3LXBjaS1kd2Mtc3Vz
cGVuZC1yZXdvcmstdjQtMC05YjVmM2M3MmRmMGElDQo+IDQwb3NzLnF1YWxjb21tLmNvbSUyRiZk
YXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDZjgNCj4gNzk4NzFmOWQwNDQ1
YWEwYTNjMDhkZTUyYjhhMmMwJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUNCj4g
JTdDMCU3QzAlN0M2MzkwMzkxNTAxMjE5OTE4MzAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
RmJYQg0KPiAwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6
TWlJc0lrRk9Jam9pVFdGcGJDDQo+IElzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2Rh
dGE9UE5kc1Q1MzBkYlJRa2dZc3JyOTlnQjFjVUUNCj4gQkxPa3ludmNpQzl0aUIwSWMlM0QmcmVz
ZXJ2ZWQ9MA0KPg0KPiBQbGVhc2UgdGVzdCBpdCBvdXQuDQpIaSBNYW5pOg0KWW91J3JlIHJpZ2h0
Lg0KVGVzdGVkIG9uIGkuTVggcGxhdGZvcm1zLCBubyBlcnJvciByZXR1cm4gYW55bW9yZS4gT25s
eSAiRGV2aWNlIG5vdCBmb3VuZCIgaXMNCiBkdW1wZWQgb3V0IHdoZW4gbm8gZW5kcG9pbnQgZGV2
aWNlIGlzIGNvbm5lY3RlZC4gVGhhbmtzLg0KVGVzdGVkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4NCj4gLSBNYW5p
DQo+DQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/g
rrXgrq7gr40NCg==

