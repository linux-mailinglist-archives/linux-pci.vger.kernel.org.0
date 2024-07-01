Return-Path: <linux-pci+bounces-9496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755091D6C5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 06:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA19C1C2143C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 04:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57026111AD;
	Mon,  1 Jul 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="USX0CVrX"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2079.outbound.protection.outlook.com [40.107.113.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759B1FA5;
	Mon,  1 Jul 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719806933; cv=fail; b=qEoSLyhiKOEyc6bJEtsBt9N/ShvQz2jqZkM8GLlXkgfz/NRWT24X7fa7HLt7GU+r/Luy+KOa//P8HS1H8+ioDEWvVRpPRdC/DnpJ7VOW1zy334Stmr0IuPQ7hp3Ebj+/iWbENLsM/VtlYb9KeRh7SvxYGFAeffVuHFvIR9pBaM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719806933; c=relaxed/simple;
	bh=0qQ3d35tYOnAuCZ+AYcmmnrtBpPH/zbNhOG8hcNmxsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WoFB6S1kXxdPrthgi7EJjQZ/hrsPovIPQ40v5lUzKnzG3JMfXPuejBVuw43qVKKXsMVq9sSgoodLDAtU7JOHw/J9MA1oTbt70PKQ0jSUFtDIdZrr6AbLMSkATMG/mwA8jVkRaAkSNYmhBLky0CDJPjYruHzCJpJVCSnBR+fvWaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=USX0CVrX; arc=fail smtp.client-ip=40.107.113.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxJ3mq8w00SOZnS+Go8vg/zpgktus2kI0DoOUcw6vHa577ASqViQYAVRlxJNVqY2EXxhBN/jazwGsZw66xcdKbZgzxJtjJm1DrEEng8tnxJCdCfod+kZLAFIrr8YdGeZsSiw9BHX5fEHqWG86l1NVs4yZ/Ag8h9wVI7c/ZVI0h7NXKxJu5SIJ83YazrkmqJyf/fsLOUIyFGJoHwEMFb9wszzcSeYYEeWXvFWxMkZ5Aha2mORpJXXn2hx4/yHcmyivTWW8GD3WyPKjtzxggjApSoVRtdx9yEiXuwLEcslTpv+tUaaGIdY6DhIAjv+6yGXrw8N7LRVUgu06NRQoeAaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39CNcIuTvpnsvIGYJPVJp326MAEFj5wRTHpMEvsfpy4=;
 b=DzpaLCdnTdN9q7MyGbHMJbBRaRfzcSqHLVRO0cUubdg3uJgwSKUOejsyi+EhtQwS/vjQq1spYtanJXswc+0irMo4bCweXfT4PeAB7tipr95RVyqdbCH/a1jFd4KfbQmB4LlLiwRfufOjlitGhl/XM8Q8DaSgWCnfnywepaf8E7AoXMydE6nd+Xh+Ppoto8/tZbH+SS9JrrlPTax5yiS5ihDau8G6MbCwD6WXarxBOZRnwerP8U5tsWDQ88sGSLz7BQmE7h+K2EXn8+r+0JaAVf2NY8rGn62xec5zyDY1Eu3G1hP9fJpGP8NZfsTmmvzukUZkp6+4ET6FGau/DqS2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39CNcIuTvpnsvIGYJPVJp326MAEFj5wRTHpMEvsfpy4=;
 b=USX0CVrX+GOdBwWJgNzx2tEAQXPDcabyKivUFGNZIiOk76mt8A79U29cCIFkIdFv832+KaQHSnzKICOM3zaCZxLmfagSmuclq9d+qnz4FZXy4H3xvqLEht7QnOpfSdHZpKDOgioVMa3NU0KYswHf/Riv8Z3R1uqnbxZN9tIFdXo=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB6352.jpnprd01.prod.outlook.com (2603:1096:400:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 04:08:46 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 04:08:46 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Thread-Topic: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Thread-Index: AQHau/4H+pvFGTDHG0OY/yehxiZnUrHfR8UAgAIYlEA=
Date: Mon, 1 Jul 2024 04:08:46 +0000
Message-ID:
 <TYCPR01MB110400794F8A95CD65B439967D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240629200650.GD2249818@rocinante>
In-Reply-To: <20240629200650.GD2249818@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB6352:EE_
x-ms-office365-filtering-correlation-id: 2eb3b4f7-0e35-4969-fc78-08dc9983811d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?wTwwqfzyZ5oC97Jruj4Uj8Xwm6kMQqtCh5D/WCSXG8A9Pw89TqwZD1b+jL?=
 =?iso-8859-2?Q?i12Ru1SSwv5IhFDFggdCTVdGz2gyCS2e1TxAtJSFMGYqnXPloUKkJ1jmkQ?=
 =?iso-8859-2?Q?jnyo00PwNmsI66KRBQuadrySzxy9BsP0QaxgxbCtkKGqdsu1luj0KQA9Xt?=
 =?iso-8859-2?Q?HaKS0J2Aeazk89pk6Lkw2NZd91rVdovQXoQvy3wfiuY1y8xXu50Xyw3dVc?=
 =?iso-8859-2?Q?CNLP9lP9qO//F7O2duzId9zzSQCZlylZB3qZ2Je8PRPUukbWTHO64NfVD8?=
 =?iso-8859-2?Q?Y+M5nR7bqmsVNMy1+estuBdirjCaT277X/5M+9gZoJ8pXoaUP39T8lE9eT?=
 =?iso-8859-2?Q?0tmyKc86cmJ6ML5SVarVehAGPhvDerV+jcvzJPEDoyCOUasndqTgVOCvxj?=
 =?iso-8859-2?Q?l0ZAx8i25LjDlVHs6jqSc8kAQOD6bcZcJ6UcPeRbPL8S6x1aWZ5X+7crtg?=
 =?iso-8859-2?Q?1gP/mqvgAWIyUyGBLSn+RbfRrf6gJoT/hVJnFQvWElRKESSDrwTSsf+d/I?=
 =?iso-8859-2?Q?7bWy4LwdWOA3ZP3jthlMkdl63PnoRMnny2DjZyVjN/usy5/dA/XUtv9D9A?=
 =?iso-8859-2?Q?NJllGaC4Wh3Aq7WzTOtebdyqiiyX+aYOEs2Wx/f31ts3nyGtsFpXErjz96?=
 =?iso-8859-2?Q?8yh82fCJqmdkHlKwPSwHFe7S7drOHHFkjlOaAiGUN/+6p4OuAIDnQTRLjw?=
 =?iso-8859-2?Q?Ylvx/ZFmU1AS6+X1xCAkUSmlakhcZ1HZ9f9Ch5eQwY+TyR2NpnUSDyvfHr?=
 =?iso-8859-2?Q?UEIhJsZHjnQglssvA4VM7uPmxQa1E8cOu/zIXgF91eap3Ps1rKOlluXpx6?=
 =?iso-8859-2?Q?8ruMwcyB/r22WZBjSex9Ou6bwKDecNiWBL8FZZgWIYnaPIGgBLqZ6BaBK7?=
 =?iso-8859-2?Q?rszyteXHDuYbtW60RpzAkeRBZx0m7dkzN77n0u5JyzZTkrlakOdSjig6ui?=
 =?iso-8859-2?Q?aZApEFDZuPAnSAuW6eKk5LnTViuTiMaCIfTxcTGJJyWQdfyPZWfGS1DRV9?=
 =?iso-8859-2?Q?jnYn4NDbMJqa/leAUqZdUxpBK4Xj1wfXWRr5kmtFJyTi/qbG15ym+eIJMw?=
 =?iso-8859-2?Q?pw03PfWZFYFUFvyDSdQHSrTHEgdwzclEUNAclvATlZaxwsEcJCkiuwx/5b?=
 =?iso-8859-2?Q?AgmNeLvswT1lxJwD+ovI4QvROqvlJkw7cOpA4l9/GjdREsKKQZUDDD/8aN?=
 =?iso-8859-2?Q?yaAW01H4fa2PlmiEGPOO3ZEUgUFoSCugYfDPce0R7k2z3Htelx1ONJBYCY?=
 =?iso-8859-2?Q?7w6nOm1F6jNHK4QfqAH20NnaO8x6zSmlGYMA0Cgo8LB6Xy9OVHeeVkR5vy?=
 =?iso-8859-2?Q?2Cjkz5t28Ff5NgY+ky2VweQGt7ogDzDLez7NY/xDrkq8xK3hmfEZ1sNoo1?=
 =?iso-8859-2?Q?nPkctqousIjwYfLojkNZgrP83B+jnbrSHvl2m4TPEVwr9uynAP8lGM17Wj?=
 =?iso-8859-2?Q?YHvIICQMH92b6EnpJhyGq8ct7wnDprcMVz3YPw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?PRp62QxvKpgtfB4lO0n3tKIhhhIfHuBWvhRSMehaUSwUbtKsk48n4kxrNq?=
 =?iso-8859-2?Q?yJuQ8gtstKZdRE07RTLBikkpN6hDjKYNNEypOLMlmJFbjvawuqWuuM3Gr7?=
 =?iso-8859-2?Q?Wd3f8lMXnmtm6UaTNt+CDroyYv5unoYXKEEFM5YwqCSe1sDReGhn4ji+gD?=
 =?iso-8859-2?Q?LR+H60d0c2ZOvTNDlaGxDDBKv6XOGD4g4RcOqeNf3wobbOpd9N7A/rtg6p?=
 =?iso-8859-2?Q?LNstQqoG/gv0j7KLv2XSUSVhD/MuxVVM67hWherR6IGXPQVuXBFvvw8LjJ?=
 =?iso-8859-2?Q?QrK2bAb4b3XGOkJPUGpooax7FmLuvwxW4pnlfX+qbcpj7oLHnXmEAI0SgU?=
 =?iso-8859-2?Q?d8rZP83QTMg6jBWn2f1mdXKpc4A6XvOVWhIqnEzFxnTkqLmBatsJoOzzO6?=
 =?iso-8859-2?Q?9q1tdSSd5gU+b8F8zt97FP5R9pgcOR/gPiP4KVOnvQ34OVdTeSPyqDtN19?=
 =?iso-8859-2?Q?cPPOlnSAtOC1fS2w7pJL8rGCf+ZAbZiMySROJmkvV+4PDKonNdnstIHwyM?=
 =?iso-8859-2?Q?fApJ0SS7EUwJWf2s/7xktUM6sGtDjTf5cgbKJf+fQUbaKh2uUG4VqSFndD?=
 =?iso-8859-2?Q?a20N9V82t4tbUZ1IlDLZp1jE3XNGGgAd2eoOWUl/9hfBkE4FGBE/4favGe?=
 =?iso-8859-2?Q?hVerDUOXu3Hjdgx7Ewo0h4J6DwkIDaavaM+Fi0Vukc0EL5myDFhAb1NMMM?=
 =?iso-8859-2?Q?jKPvkv8npSJE14pSm4tUyfLORRXM93vUP+JMcAEDEivwp9qW4GWt+5uQuo?=
 =?iso-8859-2?Q?lLV3FNTFYuIm87rL/0s/+R5GAVvs5oB4PVGN0flpt3/bKL6M4U8iQx5/vw?=
 =?iso-8859-2?Q?eHPU3RfDpNfkYDGIwovk+L2VipmD4cME2/adHiblQyno0hRB6lS+vlounQ?=
 =?iso-8859-2?Q?Oft4B4x5hfwqd8C4CFlTixlhEy7qUyqonVuE5rZw1g2G5FlbvFOOfBRqUy?=
 =?iso-8859-2?Q?iQ5gNCeKsVVvzy2lqTmtwPo05N0SgoavrCHiuD17dTJ+uw/y2OdQbvtO5V?=
 =?iso-8859-2?Q?gozluOVDYV+d7ET0U/TwVE7t+MyNJTxypPw+lCq7Exa3Y7wOTLNjpK/b9F?=
 =?iso-8859-2?Q?CamI8oX77AGfzrAO5iz3RlbB3NtX51L5yG+LqWVHYgNGiNMwHpMjG0PSaz?=
 =?iso-8859-2?Q?3m7ixx0GIELT+Th9wridFUSwgMyfdJIbEGFxzNFyMbO35ifit7JlBFfUiv?=
 =?iso-8859-2?Q?e9WoSTsWL4M3Kd28fUvL4O/k+c6yh/mIUqRtpEAOKVJPOUCfX0TrKrQpfx?=
 =?iso-8859-2?Q?t2YJbmO9np5g9I7WUERi2+ZmUP/Vx+XQrnbK6v70NOaJlxeBJbPfKthXM4?=
 =?iso-8859-2?Q?1SIUtd46xg+2DIIN/sLbvxCXLjKpgME96WaQYc66i53Aaid4auZ6xNq9b9?=
 =?iso-8859-2?Q?Wd/t3hDbvUN1AaYUhiXaRMPnXUJr3Rh19iuEudSh3Wa0Fnq309vPMhQFpA?=
 =?iso-8859-2?Q?yWS7++5vK1akSUoC9GqQt7Qssq+dXWHFcquUwdvkxaUk+WhhC8qzJOUAeX?=
 =?iso-8859-2?Q?Y6YSJS5ZsIh/r1MxeDhLtfv6ThN8Aj0sDXd7axySdyBUQOcs2VG4UfuJVJ?=
 =?iso-8859-2?Q?+qVACd2Fyj8hup6DLMyc4/eENsvt/kfIvyz13DXq7TzmmPl7ryKGv+agMD?=
 =?iso-8859-2?Q?fPin3C59FwvjwcT96+X0b6Tt+vrLMU8CpB96zSgtXaybN4F1bLTps3ojZm?=
 =?iso-8859-2?Q?FhmdBeWGmhLnXjhsCMbeWD08/8Y+tW3ARA7OZyl7s7mXB7PYHeqZN5Qih3?=
 =?iso-8859-2?Q?9Xqg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb3b4f7-0e35-4969-fc78-08dc9983811d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 04:08:46.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ePNIkI4AQtfz9WhlZyfTRJD61hx+g+04zcMkjxXub8i2yYWKFgS173DPkpSyDftdeds59cen2rv92XfQ6PUfzKa5JwMlU01z1U+1kcnEjhnBRwlp36zLvmimc8BJJqZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6352

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Sunday, June 30, 2024 5:07 AM
>=20
> Hello,
>=20
> [...]
> > About the firmware binary, please refer to the following patch
> > descirption:
> >   PCI: rcar-gen4: Add support for r8a779g0
>=20
> This quite a sad state of affairs, and usually would I oppose including
> drivers that rely on closed proprietary firmware blobs to operate.  That
> said, Renesas is not really setting any precedent here, so we will live
> with this.
>=20
> Shimoda-san, if you can, please pass the feedback to your bosses that thi=
s
> decision to keep the firmware closed is rather unfortunate.

I got it. I'll try it.

Best regards,
Yoshihiro Shimoda


> 	Krzysztof

