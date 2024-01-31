Return-Path: <linux-pci+bounces-2879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC4843CF5
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C019F1F319E4
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0069D29;
	Wed, 31 Jan 2024 10:40:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E69D0B;
	Wed, 31 Jan 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697637; cv=fail; b=o0/jZuTcbVsnk87E6sMj1r6LbLOeOIvgvdeSZDXWy/FJgBem44l8Praf6aG9c1ntlqC/DkGau5rueW6ytQzH2mb64lHVf8VskZXUGJtDAXs/I1bMgAKX3DSzFNd+jQE8B9dTj6JOnITzLwTQvGdq+JZehK6Lqh4dikcgYHJS25k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697637; c=relaxed/simple;
	bh=WrngU0cqJWE8iYOCGJHyDNFOSufIx64Og0cutRtDVtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZL7cMMzcUoG7SqcL9QNYYZEef6ryZoVaxx4a1fRM9nZ93xj9El7hsYYRkgL0NRJ0qymt+Lw9Kg7g5u8o6ivjRol/6zIpO3moXCHWWddhiV/nHTzMoiZUeDs+jSLJCMiikIye1p6tr0xG6dAHuYZ6uT6a/Oo9VB4oMpVTL3AT83s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgrMSJsQyXDmroakVZPCF0/rQRm18XiCmXUyzsGJDCVepksxuOr0OlbLMg/31v9kRRAnJiRNkhe09FSlaWR5V7loSgduEx+MLOxkWNsUrGgBwAlkpyFAZQtKKwv7GXLV8Hwda7DUvOyQw4VkTPJ3cHIhUpvSqfRjIzsQRwxekuAJxR30/w80+/QDoTVKzyOSv2bn9wwobgeW767pTjt4dllOQhg6qIKdnSCQ7K1X3bDnUoyPsjKY1TlxwFliR9/XhlddWJIMrvbKe6Ou8pFORcYS9sOD5berVeZr/X20GAzDgnjaWeMg6MDX2XY1sASfs9xNB0+rbQzhGFH+IjwVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhADv0OpMlAftKwUCinfh10J8mx+tVIicHFmgxSwuQ0=;
 b=HtYn1sm/VdNtHAaCnCPnqXhfI4cKbmo5rSYUZ9um/A9tsXRkes5Jd+uWSXUhbETWx7eUV95blhsLFGhV5+SD+oU5BHsB9syoqlwuLq78ysjzRqrTtzv9AyQLgPFqJNQDzf9UX0mUzNsW/MIYlBQ5q2HGOgyb/iLSddIl1UnIqXibgS2ymvOA+YhOoZyfJK6nArOh4Nv4rSsDMlkXqGdhOAgk8DQGhpp5plqivcm6QyHj5nBBjBUd3JPcSxhyj56jwQnr08zDkL1TsElo1TYizyD/Myq1f7RkPx7JD3leWB6vE+m2ouh9zCAvIt6yA/hsadBAGGGLgdCi8CNAERakwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:07:09 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7228.029; Wed, 31 Jan 2024 10:07:08 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Rob Herring <robh@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Kevin Xie <kevin.xie@starfivetech.com>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Daire McNamara
	<daire.mcnamara@microchip.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mason Huo
	<mason.huo@starfivetech.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Conor Dooley <conor@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v14,RESEND 19/22] dt-bindings: PCI: Add StarFive JH7110
 PCIe controller
Thread-Topic: [PATCH v14,RESEND 19/22] dt-bindings: PCI: Add StarFive JH7110
 PCIe controller
Thread-Index: AQHaUk7ANof4CuKrsESG58uORquI7LDxXlAAgAEciACAATsJUA==
Date: Wed, 31 Jan 2024 10:07:08 +0000
Message-ID:
 <SHXPR01MB0863F3FFB671A0B95324A830E67CA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
 <20240129010142.3732-4-minda.chen@starfivetech.com>
 <170656679886.3057.12378312489853176077.robh@kernel.org>
 <20240130151934.GA1636501-robh@kernel.org>
In-Reply-To: <20240130151934.GA1636501-robh@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
x-ms-office365-filtering-correlation-id: e20775ca-71d4-44bf-17d1-08dc224462b5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +eTndG5e8ZDFNKThe/FTof5rojlAiIQkdBV1uom3wmhYjdEqyDh9q31jfne+V/uYMKKm41d0Zj0FIOZRiZHHKBbGSYA/GgmgWefgs8gQfecs8Btwut6MIpV8X+YSZeGGlabHulHaQukz5WjaVkN0NdRrAxKv1+38ttBSnwEngX5uGgi1jTAJ6ZgnEXXMRwwWoi4gJruxPQ54aZrrMPOAB/Lm4FAx7ifz2Q9iJfKBRy5DGdXx5rBRfykiIWPOdJZ5NM7BzFgNXV1dPAPpm/nqErqm/qUTDda8hRePOMOyn0GByh0jos2Zc/Bg73Za4AX4+Qxsbu+h8hXDD58vKiJNnqKnmH0l+HdYzcw8PQwn71KdHTqYMtmKK15mImWeCeskuSx73Dxrbis9f1DyZuRT/+Bi9sLMZhkMOcHD4v+ef4+dAebQAMB83IY/nwuTu2luO0UJVEMgsWfTZ8VVf+1xYlKgWFZobcqzVWQtI/f3DgDeWlAHmizJAHtGpkDoW1gp04b0Ol4g+XPICObJydUbrTWuilBmq6X3OYEG2/HtBFS6+XDsAVkHqhXYsbsBdcfKOkpvS05zEys8qDmT3w1UOnDppi4W295/fPVY8ykyfHg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(7416002)(41320700001)(2906002)(40180700001)(5660300002)(33656002)(41300700001)(86362001)(66446008)(64756008)(76116006)(54906003)(66476007)(83380400001)(66946007)(6916009)(966005)(508600001)(66556008)(71200400001)(7696005)(9686003)(55016003)(8676002)(26005)(44832011)(122000001)(4326008)(8936002)(38100700002)(40160700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?iZLFVnPiawQsG6dKofl+88tg8LdCLBrx1rwXDDCeO8mWCXcfBEkzVcybFi?=
 =?iso-8859-2?Q?MWcf8s9HRNLv1SVNn/9wHYbP0tEnfDOUk7e+YGR93zy4eUPOG4Z03jl8cd?=
 =?iso-8859-2?Q?TjNBb3J0wuQzS7aYjLJwY+OHMuM9kSjxOgz7NfY0cFziXVOW4ZwU231aUc?=
 =?iso-8859-2?Q?MdLSkBk7WpSc8AtvKIScwZUhdT8qWB9lDk4DvooSZ5lXmvXhsiMIZ9vqIL?=
 =?iso-8859-2?Q?gSCH9k8syA4maG97dil+BrkiNQa3dmL92h1xuwhVDDLdujL1IUypPH5qO9?=
 =?iso-8859-2?Q?AmRDOw4YZMGappm4HW+me8iRVo+z/7wtZUq96NuX1+eRtrzB9g7YQIH7/a?=
 =?iso-8859-2?Q?voxGaV1C6JtnwM+fdqWXuWgRBywXMyv199/QwZvU/opBhvSiMgQSW8Vam7?=
 =?iso-8859-2?Q?9a73/tIXKFWkssbp3g5OmW0xClt2zd4zd0tYSKvzTsgy4oOB254e/m8xEU?=
 =?iso-8859-2?Q?a8Ib4nlc4+vV7BraBLrZ/8N40neoMN2byv+ATciGnWl7lkDrCN3x1cxv72?=
 =?iso-8859-2?Q?MmTmAoJOOfurQU+crBUimYT+yCPkpcaSMfVoG+a8DRwUhOCktazyq69fd5?=
 =?iso-8859-2?Q?wCYRUW1110V6urdGWhhVPqpR3JIXMXiQa2DsbF3jp+cR5adqjdwMURJOqH?=
 =?iso-8859-2?Q?SmGzkmmPawgBg6bLubYvbIFyvPIBgsmizs447D3QlvKcyR6dpTwupqXBl2?=
 =?iso-8859-2?Q?gzqqQNZGJ40gzktT7Y2eGpnWz57eJDS/sPXcsKXyxtbqPiMoTugAnUYJab?=
 =?iso-8859-2?Q?zhEm0ZxkDEjO9vNUDExAiLerwsV0zH8Fu7j3NAzaUh8vvfAi5Q5FLSvjMI?=
 =?iso-8859-2?Q?u5ZyfJZifXDDE7U9JRTNlJD/gIvu5WmkP7frdfwgtBzLmsYW5kvDTk3dLz?=
 =?iso-8859-2?Q?ERpQtvW/ouf0NZZjSu1m78sSkVNSDV/gzcR4IbFtH2HGRLVSrz/k8ALirp?=
 =?iso-8859-2?Q?f+zzwnVFkvW3PgvNz/USn+9M/veu7/FXo9yG07lc9dQFFBq4WEZ7tTfrFw?=
 =?iso-8859-2?Q?TkvyP4DNARuD7jCFjAMoLcTHJBbknpJ4ig9SnbZci4OA6CfiJIzrqc70Cj?=
 =?iso-8859-2?Q?YLb+iyEOBMdSymxm5NF+bPPTLBEcxWr6m8o65aNevEp3nX5JzyZTDUcrMn?=
 =?iso-8859-2?Q?U0SzKViohLup1f2tHPLHCFk8XMIMzOA7nTnHF/kIgL4ys3vocodBnaLFcu?=
 =?iso-8859-2?Q?aMIQLC8OMgk5IAeamc3nZGdEX6MJkI/Besw/+gNQwyEG358mR8HSps+nyw?=
 =?iso-8859-2?Q?x7O+po8KAgHqYWTnu7Y9ysUwf3cx6B0v9vZuc8CwkQEb011T4E5jYzw5bm?=
 =?iso-8859-2?Q?4VJ/lbpLoW8Wtv5sMsILkWfNYPpsVMJtYawDxpq+eu9rzOITalVffICBNq?=
 =?iso-8859-2?Q?a6h9XWFYMzIhUBHm3NO56CWxSs3t8ghztLafHjL/NY4Q59Kc5fS7gQ9ddc?=
 =?iso-8859-2?Q?8aBCD5V/OA/MTxVDmonAtHRfOIhF4smwTak8oJJBi5XXsuy0CfkHKkB9Dv?=
 =?iso-8859-2?Q?yR3OwFCU1vRYMJdcb7HYSh5h/lZ827kFFPySJgknucaFBB9Gz1CbyLsJgN?=
 =?iso-8859-2?Q?PbRKwyHddC0hDa2y9k8RpHFiqchuMZbyMS2qTpLNNVnb1Dwf8QJkx5c+Vv?=
 =?iso-8859-2?Q?cybX83Ul1tHF+GZZVALLnj9YoC2e5+DkNs?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e20775ca-71d4-44bf-17d1-08dc224462b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:07:08.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tuRH9VHICaUrxhvK7y47hamdbhcTDak1DGM3lnBPqYKRGia89/pEEKhcnwsZzOUCivEXe26esJ/5ojoivphS1gbSRuSv9lOM9D06QyRQ44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797


>=20
> On Mon, Jan 29, 2024 at 04:21:12PM -0600, Rob Herring wrote:
> >
> > On Mon, 29 Jan 2024 09:01:39 +0800, Minda Chen wrote:
> > > Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using
> > > PLDA XpressRICH PCIe host controller IP.
> > >
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++=
++
> > >  1 file changed, 120 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/s
> tarfive,jh7110-pcie.yaml:
> > Error in referenced schema matching $id:
> > http://devicetree.org/schemas/pci/plda,xpressrich3-axi-common.yaml
> >
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/s
> tarfive,jh7110-pcie.example.dtb: pcie@940000000: False schema does not
> allow {'compatible': ['starfive,jh7110-pcie'], 'reg': [[9, 1073741824, 0,
> 268435456], [0, 721420288, 0, 16777216]], 'reg-names': ['cfg', 'apb'],
> '#address-cells': [[3]], '#size-cells': [[2]], '#interrupt-cells': [[1]],=
 'device_type':
> ['pci'], 'ranges': [[2181038080, 0, 805306368, 0, 805306368, 0, 134217728=
],
> [3271557120, 9, 0, 9, 0, 0, 1073741824]], 'starfive,stg-syscon': [[429496=
7295]],
> 'bus-range': [[0, 255]], 'interrupts': [[56]], 'interrupt-map-mask': [[0,=
 0, 0, 7]],
> 'interrupt-map': [[0, 0, 0, 1, 2, 1], [0, 0, 0, 2, 2, 2], [0, 0, 0, 3, 2,=
 3], [0, 0, 0, 4, 2, 4]],
> 'msi-controller': True, 'clocks': [[4294967295, 86], [4294967295, 10],
> [4294967295, 8], [4294967295, 9]], 'clock-names': ['noc', 'tl', 'axi_mst0=
', 'apb'],
> 'resets': [[4294967295, 11], [4294967295, 12], [4294967295, 13], [4294967=
295,
> 14], [4294967295, 15], [4294967295, 16]], 'perst-gpios': [[4294967295, 26=
, 1]],
> 'phys': [[4294967295]], 'interrupt-controller': {'#address-cells': [[0]],
> '#interrupt-cells': [[1]], 'interrupt-controller': True, 'phandle': [[2]]=
}, '$nodename':
> ['pcie@940000000']}
> > 	from schema $id:
> > http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
> >
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/s
> tarfive,jh7110-pcie.example.dtb: pcie@940000000: Unevaluated properties a=
re
> not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-ra=
nge',
> 'device_type', 'interrupt-controller', 'interrupt-map', 'interrupt-map-ma=
sk',
> 'interrupts', 'msi-controller', 'ranges', 'reg', 'reg-names' were unexpec=
ted)
> > 	from schema $id:
> > http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
>=20
> These are probably due to only patches 16-22 showing up in lore.
>=20
> Rob

Yes.
The plda,xpressrich3-axi-common.yaml file is not added to kernel.

Error in referenced schema matching $id:
> > http://devicetree.org/schemas/pci/plda,xpressrich3-axi-common.yaml

