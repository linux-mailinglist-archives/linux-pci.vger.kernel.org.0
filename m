Return-Path: <linux-pci+bounces-9587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF25923D88
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F944B2234D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890A1607B2;
	Tue,  2 Jul 2024 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="IlPBMA34"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FE15CD7A;
	Tue,  2 Jul 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922940; cv=fail; b=c81BUOURdTiqYtzOHqGrPkZZ2hWqjQZo9cNmCn65o5Jryz5TLpgq5M0FcTHxG/L4EZzw/QlOMp4+Lxk//3azBTlpJwOsJw/ZmjymlENw+iXvR3lwyzw2RlZ8GowLKyGh9LpHsT2WS2oJ3y7jMnZsbeN/zo1eiKKKdd3ooKKJr+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922940; c=relaxed/simple;
	bh=5oi4vycR0cmBvEHZKg9pMsBd5Pti1vGOwjlbB8W4y6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UjzWlPRptus6X4Juh7WOEr2OhBBpVjN9GIe/QbWw9SkB+hcJz8y/5nXzHr5QAEWUDsUSOurfVeDp+jxN1Y1gDnz8fTzMP473W6P5f0CbdYF4wdMVaSuSVOAHbbjf+6t6usqra3roCAc/0NJqdhsYLgrZEAKpnuhDhyheb1rD+KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=IlPBMA34; arc=fail smtp.client-ip=52.101.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzB/wK4sHVcELQsBt+yVNfvUxs79BHDBKokTkVfCsbdByK+upy3X1Mb3SVTos59Fq8Bx3wrnEaa5MQDzeUTNP1O3A3BHs4P6/wkjRgh324DG9TyaM69UyMLaINu1tQzR3gNLUVveHjizIUas3wp4XWb6NMaFwGHWDGf1T0schBJP6ULQJRJXwI17epZNNQza12SWZYcPe9IU9ScGpBzlexd9b7P9rSVnma/Vliz8M+JNJNzQq2VhPB9WtY/Xthmmww/Yu13q8l185CV0GWnEHHgRPjRaIaeOZVFVoY8AOPWbCoaxiIn/iiPgCiY7/CxEQQKbg+2qG6NUw/ztItN/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcyuOjzfy+FD2mEAl86FDrm6bfxD8TcD0bJFNeNcma0=;
 b=IxFQb+aT5oLAI43Ki31MFe+UiWmL8g63h37E55Jeti1JEI+WvuSuKEEuH+LOMtzx8giY/2dYnRvmHOTuIr+43Q0EzoJD7c22TQ0U/AUB6Q0J5uusd/z1w7pUlahY2fSncYeHzBqHsqXH0esY9nqIEcaGWddBbIMN0Y8srJhwfUih5Eo88sffi1xGt+ocba3DhgDqJ4pRubTJ3iqZOtunD5hhduYzkVw2k71A50UUcgV8UVRiBWFSlOcxZfxQ3lz6tyeDztzaaXwKJoHWA4orhxLwu9qFKWFEcnAOZB3h4XLAy6eAWFwV0Qm09X8+EmN0F1N39+ENzNFKbGVGkMKTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcyuOjzfy+FD2mEAl86FDrm6bfxD8TcD0bJFNeNcma0=;
 b=IlPBMA34kFHfW1LxO3ld+aDz02rsxHw32luec0HcpE8+7Ep+QUOul7wHMe0xcjz4pyZHL0/LARzldqnqublOsJqB6WUq6I0sYF5S49ds1Kt4FJclDc/EvTGKhwrMGlArLf8hk7DNvg4RnRJKiiAGwlNvP3hV8xZPMzy0OT01VEA=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS3PR01MB6594.jpnprd01.prod.outlook.com (2603:1096:604:108::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 12:22:14 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 12:22:14 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHau/4H2Ue+Yvqse06eFL/aaE81cLHfRNCAgAIafiCAARdjgIABBaRg
Date: Tue, 2 Jul 2024 12:22:14 +0000
Message-ID:
 <TYCPR01MB1104021542E26342F961B1499D8DC2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240629195615.GC2249818@rocinante>
 <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240701204333.GB412915@rocinante>
In-Reply-To: <20240701204333.GB412915@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS3PR01MB6594:EE_
x-ms-office365-filtering-correlation-id: cd6f1d6a-882d-45eb-2de9-08dc9a919b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?DqBudv3058SGZq8+eFueNMxDiaC+h6CDraJ0EImlK5tCv5vjtJENbNo3/B?=
 =?iso-8859-2?Q?l12Hce1YEIWD1lSInhySVgB20iof+5uV63/lrytOGgfj1cmtGhYK017NMi?=
 =?iso-8859-2?Q?/tXWhpLvlrACC6w+gM3+IZvxnRyUZkVU0Mbm0XCC2ZvxIeUpG1QtOItJWc?=
 =?iso-8859-2?Q?eyoUPtZqo8kidmv4eHj0r+NzNTM43AxTl7y8FRxgO0J+8pSdPOrLRKYWGp?=
 =?iso-8859-2?Q?RvXLbpvzN/nbIEA8WJolw0EOAQj8ErCZsa/m+BySkPv+CXLVuPRseDt2lE?=
 =?iso-8859-2?Q?dcDM/1TDAANIuNf6v75o8g+IjV1aqCZeK1abSqB5GOl2zZM21wd1biTtJm?=
 =?iso-8859-2?Q?TxXu44fRF6c9puhDGyczTx02V49d6S2J3R/TzA61OKL7Xfc5ftCuoLHv+w?=
 =?iso-8859-2?Q?wUr7djD/DYG/vWHgY03RI5kjD7+1iKIgofeWIrIvhx4uvAxlswmV19Bv16?=
 =?iso-8859-2?Q?7nU0LawY+j+SlSi/GuqnKFmlIPTLLtvvLl+DTd3d+M2TSDil67erZ34LwY?=
 =?iso-8859-2?Q?s/lwgJpf7JDDYp0V+Smr+rnnC8kpWMdRsD8AzBXEVdOYHrNQOzOBi+GGoT?=
 =?iso-8859-2?Q?X+UlrX/71JKjijQZ8yj3jXnHuoJEIYE+fuXlGdikmHRGpfzpdNIaz1u/bA?=
 =?iso-8859-2?Q?F2y6lGOxPshCNRgUD3ATeCwBE+Xl8Bd1FUGfoPBjOuA/FccmVhKWBLmPJw?=
 =?iso-8859-2?Q?PFe4oKUkMV/n5yGc/SDrNiHYojDp+PEVaLSTmRsWkKMFmWxZIKULlfQwcR?=
 =?iso-8859-2?Q?v2UWrUGgO24e54qQT7Ifeh1ZuTRs6IpQixogABrFWya3Dh2g8uIOh46lBG?=
 =?iso-8859-2?Q?8rn29WKxhTbK7N7TrsJzGw+RthKVU2vpaCcgmcV8M5yD56rnPwf1ZsY3zu?=
 =?iso-8859-2?Q?uqs0StDEnKaG+uZYDBoCDDTFJf1/BI0fPo3nd4IrGr+i1omFCO6bkHLIPE?=
 =?iso-8859-2?Q?DznKZv6uogyR0G9WXEjSQEe7JcH3CfyLxxicANfpLsD3afCJXzf8x+NPcm?=
 =?iso-8859-2?Q?OzGvenYSQ4ASs1ydBLGCpofi+LbSj8pLwiB6oECoaew1rUY8HCLWz8ZPn5?=
 =?iso-8859-2?Q?n85ELqeccqEcAw/kTZN6r4wrSdbMXfKiyucj85yGvJ/afw0nfUF/c6TrUt?=
 =?iso-8859-2?Q?RV/fOpLlK8fvuXPw/KK2gx1UI9UEw1B6PvFZpWD5RsgVTDLkz4VuJ2lZUe?=
 =?iso-8859-2?Q?gMIFmP7Z1444xPLM61D7+jCsfEAqEyyXK7fGBq1Gs73hz+HlZs1BrVjtBv?=
 =?iso-8859-2?Q?Yuxuqi1utbq6/p0WhR68aW4J6Zsp3fJUlkYvvwQUR2MvZPulbtZXkxBuK7?=
 =?iso-8859-2?Q?HGI3mottWgD/TnId4tPH0AwoUT4XPI8B/fnzPmZWYB8aLqLqbAaF21EJhf?=
 =?iso-8859-2?Q?vAOVAH5AzH5n9z+nd8oCCWu5Iy6/XVEg9gll6tqMRAShODWdteE7OlE5Kc?=
 =?iso-8859-2?Q?GSLQIYmtKvgWvf1gGD1LOyfMtI3uh76QqHEUGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?qLmCJBlSE+rlhmnYrYcYsQbht8bQqV4cYjz49Ottt2GOgm9MTYcvhj+vu+?=
 =?iso-8859-2?Q?KVIdRpZoHkPm0isVMwelnvOjQfS0ZJpeXjvJEoPescEDI2M9HbvbSYMK87?=
 =?iso-8859-2?Q?pF2GC1T2DFTAPcvwlUsSLrsA250A1yNdQmQdLZMxz9Cd9L2jMBltOtIeLm?=
 =?iso-8859-2?Q?BrsZSzCspe0rspEvDzCcviojSaO2GbgI5LRLWEHwAUVQzpfxYPd2c9L0Zl?=
 =?iso-8859-2?Q?i/vC319LoFGliWPfMRA89PvsccREmnHmbcbBJS4JK4/JjgZZlfhKOmPndV?=
 =?iso-8859-2?Q?qwCVm4W4Pugcsz00Y42r/xBDFwmBIl2I+TTQ/2FGwgOxcoNH871/utr40u?=
 =?iso-8859-2?Q?WxCqWw200XufbBAZA3YcJ173y64xrtvLQPyagA7agdb+Ujq9ZhrfbI/Tt4?=
 =?iso-8859-2?Q?VeQIm+68yxqBsJJsqXx+ZabJXQFlGXc7qPW9dWaD6ZnTu4FQpN148H7jPZ?=
 =?iso-8859-2?Q?CKXK1rmQb5H02m05K6DW7GeN1P4cyhuYwUnh4iy4/j7Yc5fj2rJ9/SgmT2?=
 =?iso-8859-2?Q?RLyE4judzEVbO/roCTnNoYKnj0AF1vWSnTlGKoY6C11NDPU/CrIDMBFiDM?=
 =?iso-8859-2?Q?xP5hQrzFiK36GAgRpMqK46mYintsCJ4J+HyTyBeFkNdmEf6U46C05wTDNY?=
 =?iso-8859-2?Q?IhCc1Ao2A6y5ihT40WmaqiN+251f95xscqeARnjq5CF+8LtYYmM4eHevpS?=
 =?iso-8859-2?Q?4u54PRGC9Eq1L5z3Arf7ZigX/6w7+4XXLhyt5vgp1s5EWW+uhtpUywwgUW?=
 =?iso-8859-2?Q?ylAhLOfY2iS+/qToJ9Ys1vHxtKLkWrDIx0R45uXzNXY4EcnNe43txgMNlR?=
 =?iso-8859-2?Q?bAO2OXGtjcvk2bozcp5sVVN+BDgdB+LBV8zjUL0N0vVW0LDLV+rKzWjU7y?=
 =?iso-8859-2?Q?bP6yX3U9inSoABFGEr0JPiKBl6K9iU60CTzpOBJ993DNJclrApdwpYHWFx?=
 =?iso-8859-2?Q?o+vqfSOH282jssaOgeTrj/cM9IP2jiYql45a8LogJqps+EaAWImLJJlAPB?=
 =?iso-8859-2?Q?aveRVBuqcVq4WETCOJhXn7sO9HD6wuPfQIrkaHRB2yLv07qXGrUE7Kn5bh?=
 =?iso-8859-2?Q?6rSZ3UgunemFYs7KomLsJLIIN94v2biysPZQ4csAUEcfLugpRzuzVMYiJ/?=
 =?iso-8859-2?Q?cdlNW3W/+AaGnyBzIKMInPF62noqMOxn66kUtsqbp5vR3TmFJtz/66QFf6?=
 =?iso-8859-2?Q?J6ka8TB6T1M4QxnsoBEA7ztey4WRNnRdj2DYBQE3RGFxPRVUrE9kfeOqSP?=
 =?iso-8859-2?Q?gZjoppFmL/OtbKF2Xut1xKxDXEo/X2GtZe6mpsyweenMt4vUYwDPkhQUK+?=
 =?iso-8859-2?Q?Jb0EuU4W8MxYNURZTDYyiHbEUKgj6VrvhEAxkL6n+wMdBUHxiKTtVqVzGP?=
 =?iso-8859-2?Q?FvkmSDFHbCHqERY2F4TaLT/CerHT3zItDjwnLmAy9/G1jOk3aZp65qntTO?=
 =?iso-8859-2?Q?bY4Xy2N7f5mJwetGGsb74HRkpiU+aXVuQNGX+/40PqHa8GqWlLEWOEXwrv?=
 =?iso-8859-2?Q?1ypZtfZ2r7w4/WC7DL/Gj5VBbPv0wjc7jhHJPqK4FdmKZfqA+5Yt3txDsm?=
 =?iso-8859-2?Q?/9LIB2kHqkBTfGy7YJ69YHnyfMIPVOhuJYhmLtNzqGWfcxKL2JjNThMgDA?=
 =?iso-8859-2?Q?YLU8SfhPAKyZRk25BdgAOrrSCf6RGm5j1ci67B33p9n9xMEa4zDJ53JA?=
 =?iso-8859-2?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6f1d6a-882d-45eb-2de9-08dc9a919b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:22:14.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJYynwT/uPvvVmfAk/CIrKbYlvjaiLjuPPBVCVclCf8GbRTdr99p/9iagqvCpunVRWmYdiTl1zDxJNjrrZCz2BEFgYQAiVpZbJ1CYnE29Ew0efzVfKGnYt4BNhsD+ryH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6594

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Tuesday, July 2, 2024 5:44 AM
> > > > +/*
> > > > + * The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" =
in
> > > > + * the datasheet is a text file. But, Renesas is not able to distr=
ibute
> > > > + * the firmware freely. So, we require converting the text file
> > > > + * to a binary before the driver runs by using the following scrip=
t:
> > > > + *
> > > > + * $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
> > > > + *      { print substr($2,5,2) substr($2,3,2) }' \
> > > > + *      104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
> > > > + *      rcar_gen4_pcie.bin
> > > > + *    $ sha1sum rcar_gen4_pcie.bin
> > > > + *      1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.b=
in
> > > > + */
> > >
> > > I moved this comment to the top of the file, since it serves as more =
of
> > > a documentation bit for the controller itself, and is not specific to=
 the
> > > function it was attached to, strictly speaking.
> >
> > I got it. Thank you.
>=20
> I decided to drop this comment.  See below.

I got it.

> > > That said, I wonder if we should include this at all?  The file name =
might
> > > and most likely will eventually change, as the datasheet gets updated=
 to
> > > include new revisions and erratas, etc.
> > >
> > > So, I wonder if this is simply better to be included in the datasheet
> > > itself, or some product guide and such, where Renesas can keep this u=
p to
> > > date and the users appraised of what they need to do to convert the
> > > firmware correctly.
> >
> > I understood it. I'll consider it somehow...
>=20
> After thinking about this a little more, I believe that it might be bette=
r
> to follow what some other drivers have done, and simply add this guide as
> a text file under a dedicated ../Documentation/admin-guide directory.
>=20
> We can then mention, or not, at the top of the file that there is a guide
> available at this location for people to read on how to obtain and prepar=
e
> the firmware.
>=20
> Thoughts?

Thank you for your comments. I agreed. So, may I send such a patch? Or, sho=
uld
I send whole patches as v10?

Best regards,
Yoshihiro Shimoda

> 	Krzysztof

