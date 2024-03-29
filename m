Return-Path: <linux-pci+bounces-5367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796A8911A5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6C028CDF9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33C7490;
	Fri, 29 Mar 2024 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SyHPPCvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1F64C;
	Fri, 29 Mar 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711679084; cv=fail; b=XTayVLfurfEsIgz0C4+mfuhwNAwt7RhcXH6s2OH4TuEAuJ+kh66RUK49DhT0lOx282Yc2yBL2+8EMawkTJhCAVHFUAk3r+lFi6fqw6g0dhoC/J2EkRkxQ2ADGQIDgPzEiLi/riDDJlwq1DXMto4ceL60vYDCtUFBMnMIgel/Nao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711679084; c=relaxed/simple;
	bh=alSX7eWNXkdxl4kTND3EUcGzzz7uyMWsdc/wwRVhGtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lczhu3X2YDrjG9VToyuDhAD3uvONbiYn3D8/Gxcx+b8sv/ExYXjZtDQrUD+DsqHRuFpe0D8L5xXK/i61l3y9fBK2g1tDcUBYDh5bXwS3gRP259/k3g9xu6TAIsLgQpSsMkZTldCiNm0vUKv2QFXTzx/lYrz4e8GSjC4v7eYTa6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SyHPPCvq; arc=fail smtp.client-ip=40.107.114.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpwgweKD+6Q9Js+4SomiquFVYpBg5Sg4+j5mr2BYucYaJFiqTzWMFP6Y83mHkmmKUtXE04LJJX38q48KQF9ouSed6ePVjoZBWjYe+YNyqnhWTIyNl3KmjEYqkz6Q7kDW9hS8bSvszCoti1CQsq70057o3bIL4qQZ0PZPevBDdTtUFOWbZKLroSORbTN6MR6s2HcihjgEIi+ScS0roL6BXMPzRAj31baU4itsBz/J9MID0f0ChfKje4Gucy/s5SVRuHV6y0Uiz261wx+TESWpbvHzSqLtMtD1XQfWUw0hdPRobmmDUaFxitUYoSna97baIJG2LnOGv63zyh9N538Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0Q1I+yKJqyKOmzflgsZv2s8SZhrcxZy4f/wrPgwczY=;
 b=fuSBhrQjd0fP8EZq7hjNqBQY+C+aTabzEGbJtYpTDpWoGPuyD4QWpv/+Vc260d2l4npKxdluSS9ytsf/yATyXPc0FqDXIUJObRDQzvHR/mHQLHJ8bKJeeBVqNRIaB3+4uN7T6HyjtJmpzKLU4V8gx2zKeV1vDSTKo163ywelpIW+9sFL3VeWBCBJ7zqtomTRLEQPiPimutLVPFJxBlcxKX8B6ntoxjFCjZDMp76E/YMSF8m1Y4P3qYtjEJaMuxYsbwPGLM7UwOQOBklS7YY5qzfeIgfn/Fz0PrfJaNDpulqQIR5MgKx8XzNkGluuL0lfytjcKz1oG0pX6sXnmkxHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0Q1I+yKJqyKOmzflgsZv2s8SZhrcxZy4f/wrPgwczY=;
 b=SyHPPCvq+RRPK2lT4qbHSW+J8R1dB49mbYd9fY3LWwxEGKQaDLNLREu3cG0ZrUE5JlGrKw3KryH4tIjE+pnaKtTPIXNrNwqLRkRHTsB3dzt9PUpXUUQX+83KfUWylgGPwR5oZhwggz0yoV23aC1yRK4zScQWns2SH8xBPUz2uKY=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYAPR01MB5546.jpnprd01.prod.outlook.com (2603:1096:404:8037::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 02:24:39 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Fri, 29 Mar 2024
 02:24:38 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Thread-Topic: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Thread-Index: AQHafye+eT6AlZmhy0218gL98LfreLFKf6kAgACLGuCAANw/gIACGsNw
Date: Fri, 29 Mar 2024 02:24:38 +0000
Message-ID:
 <TYCPR01MB110400CF3EB245339D00544F3D83A2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB110402EB3E15B3471C7F526C7D8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240327181451.GA1531625@bhelgaas>
In-Reply-To: <20240327181451.GA1531625@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYAPR01MB5546:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /YlKOJdkJanZuN4VqG+2SoKiVjqNmAUicxMCzos66kI8riEJMsKh1IloRCvuG+4bQWd1lDiRtajReRQk84sX5D9OQHD2Nu3DXlfowCyxNEeCL7tXSrsGuvj9Hs0FIVkmrCFVqKBb+0KDrHsihZbtcHq8nAMfvKXXDSdQKcnW+gQ3xk0BzAxSiaRTEvkhr6Fs02x6LYrtLD3dmqlV9FtnUDLiQz2a1xV4T82X7rI6TVCvpqzDGhhKVZrRiaeoYJXw0eD18Dy1WiiIVJLuOA+r9tsDKhyWOKH2J+Xkmhv61tx4IY24a8g2twl+T46UpBtQ5eXcbea92WaCDcWf/YSGjwfRZwuX+vCbpXEWRldk52VW1lRxnJbN+9TgXDTn+8VIecvA1PSJhMohOGVBTbwlMNvrfu0SUFxZw8+yP0szj5oiPhPae5GSIliZ8VBwmHxjVzLK9Q1kNxIv7tVv/5x9Nm2Bh5eeuRWlyE8E7GhmKTrDPv1VmalmmEY2krHjQgVFYpSf+mkDjquyko/0DLa7IhdR5BO5GPS+wMSwXOA3RDeMnWz++bUkS7uNOoVjYrULn63cxqK9vhGEMFk6VLi/EmBTGge/CJV7ju2TL2U5Xz4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VxSSKgq5cwWbHC4vqBR9G5ktinrkMTVhFlVzXk3r+XS2E1ywD/bMMkp8Hei1?=
 =?us-ascii?Q?vwGAPrhwM/LGVYEawZxGORCSvKa7RnDCAr9OLbcRDAMB/z9972YJpbl3dGij?=
 =?us-ascii?Q?5vPTTT/ePrNahCCo4Dm4K9X15GFJw6W/2twlMbu8JHzwhwPLxRMYvLh2Wy/T?=
 =?us-ascii?Q?xnbTd7z+b+hOs4/qwcs4l0ts0AlZpYOV3v5UyN++ajGpTDEI1uqfM1TLlnSw?=
 =?us-ascii?Q?GrVWfVuKpcbidcA+hznHRTGbQHNW8xrEQaxrtCxsxq5A3gkquhaQrn5FRlRD?=
 =?us-ascii?Q?YctBNujCEWNJIFiEgioBKLjBqNHVdX7CckLhqIUg/lc9LwNn31u1dy2MTFHU?=
 =?us-ascii?Q?MOwIdh/wJoh+WqGwxEsk6/76AklyTI5nRUiS7+ktm92Rerv70ZRCyjz4LDwe?=
 =?us-ascii?Q?jK3tr2P93AHhiWsOkW6jOoAtQFzOppSrEThaCjJDNYolm5uls0zxmWnBiApV?=
 =?us-ascii?Q?JrJJt8EtWLLRiPZTGRZ5OQH9z6fY5lCQPMyA6rN/dxv0WhIUgOCj++R2tibE?=
 =?us-ascii?Q?5Bd5owSRKNL0GOUrl+sMFlW0fjpwuJ7KcGsT0Pn3M35lQo2TUjtK4qYbvWEb?=
 =?us-ascii?Q?Kkv0bDH/u9Dh6BSuFglPdRO/3rkV/+rNVMTkrelNyq3XCLa3RC/7ArHCTKL7?=
 =?us-ascii?Q?T+Z3hHdSiSAZcWn2gT43aN3K4Izwv9LAw9yPxn9SyNTzD9N0JK9BheJlf5sF?=
 =?us-ascii?Q?A/IBdBfdtzwAGD2PcKHaiwthpyN2+Al3cEDVU5ko6u9ZI+/rLrfo56ZZe9Gt?=
 =?us-ascii?Q?UbrO0m20y5z7vErzsL1/plPLxtMXmJnky47+NCT60YFBtSmEys5RevYuTn+a?=
 =?us-ascii?Q?SRKBuA8aCkcYbq9VnSGHKjOa8U3ysOY3qd8fMSJUJQ0XFHOzMd6vV+i4O0IO?=
 =?us-ascii?Q?P7ywOcC4c9KudpTOVmroO7RucGA6P0udwffUWkZ4SbP6enqqRwZDdymK+N/T?=
 =?us-ascii?Q?TXr6EXwlJP1ZKMvAaEkzl1Y8QO8n2Zg5EHYmnsVgEz3kRbuJSXOJn//h+UqE?=
 =?us-ascii?Q?ajLD8vEya23oX7le30ESVnvFyTyWdNvLHSt/ITd2TDtsru+1fQvGdX4JeFnv?=
 =?us-ascii?Q?TndGqHORo6Ql9UsI9hesAeXTSL5itpI9WwijHRCx9/vI3cC2VUa4wg+t5Jme?=
 =?us-ascii?Q?gUGNAMbU/vo9FvR7jKaPGB20b4UTTfAnI/Ru8KUW0jZZGXiqV/iFjK0SNhC0?=
 =?us-ascii?Q?JDsJWC/VqCmEcaawgHz1N2+O9VvyqlQ3PgjJsCBZzjW4uOo/2J8Ondi7JErv?=
 =?us-ascii?Q?wKZc8g8ZtLQyODtK8uhREjzAI1QYdqiKIo1WHPIlRDa02IdLFYv1SkokUUB0?=
 =?us-ascii?Q?S4l51DROUo7mls3Dm75s8oilYcqTueWfNIFVRJCSAQ+C5WixJKYjK0H3qBsa?=
 =?us-ascii?Q?hXKrJR2uajS7l+ADvnIBGM7hl0klRLac4ji02W7C11HsaaZWMqaBzOg0eI1R?=
 =?us-ascii?Q?i5it/o5jw6ktRjcfL1SuQHjWUy2YvTBYQi+gco+AmRxbIqbl53+hawjyEwep?=
 =?us-ascii?Q?TnOOu3ngO+bR08H93xnfmMtAQhWK4Tr5nak0AFhCtYGDdVCNR3O40uOlCphr?=
 =?us-ascii?Q?wW9eipQacnrHo1w54TihHLWUR5yc9aMx/sdgDISquCFVdwyPpMhXD1HWHzH0?=
 =?us-ascii?Q?wIwULlhg2gN3JJ0HKT0cMCDCnTLfEXX+TGE+qaW2k40voVkEMmWY0Mvn8K9B?=
 =?us-ascii?Q?/p9mAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15446c42-cc81-4ca1-a66b-08dc4f97625a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 02:24:38.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEVZofUnjpE827rGiKmlMO9N0HwGsUw3Mk5R7G/i1Q6Uc6d2lcHQaItpVJ55cr6dTwXLdzIEJscuC1Qdej01/tQfHHLyRC2q+kKItdetEcdmc1q5aYw8Btul23YnwBeN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5546

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Thursday, March 28, 2024 3:15 AM
>=20
> On Wed, Mar 27, 2024 at 05:32:57AM +0000, Yoshihiro Shimoda wrote:
> > > From: Bjorn Helgaas, Sent: Wednesday, March 27, 2024 5:49 AM
>=20
> > > >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rca=
r)
> > > >  {
> > > > +	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pd=
ev, "phy");
> > > > +	if (IS_ERR(rcar->phy_base))
> > > > +		return PTR_ERR(rcar->base);
> > >
> > > I don't get it.  This imposes a new requirement (presence of "phy"
> > > resource) on the existing SoCs.  That doesn't sound right.
> >
> > According to the dt-binding doc, the existing SoCs are also required
> > for the "phy".  That's why I didn't add any condition to simplify
> > the code.
>=20
> Is there anything that enforces that?  Is it possible that DTs exist
> in the field without it?  We don't want to break any existing setup.

Using make dtbs_check can detect an error if the "phy" doesn't exist like b=
elow:

/home/shimoda/development/linux/linux/arch/arm64/boot/dts/renesas/r8a779f0-=
spider.dtb: pcie@e65d0000: reg-names:5: 'phy' was expected
        from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-ho=
st.yaml#

So, I believe that this can enforce that in review process at least.
Now arch/arm64/boot/dts/renesas/r8a779f0.dtsi has the pcie compatible,
and all pcie nodes in the dtsi have "phy". So, this patch will not break an=
y existing setup.

Best regards,
Yoshihiro Shimoda


