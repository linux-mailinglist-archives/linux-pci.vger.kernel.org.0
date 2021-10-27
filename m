Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9643CB17
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhJ0Ntr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 09:49:47 -0400
Received: from mail-eopbgr1410118.outbound.protection.outlook.com ([40.107.141.118]:58976
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231458AbhJ0Ntq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 09:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD/ll9+ZP8oRNcdd17N8ziCEvYXs0wHZ/VnQNdlnTcMQUnerzxysgbWf/0SJS/PRgh+4O81uyZn3o/1bReZews5jhRH+DbLjR/M82iqC7PjXgptdSjTyvOn9pq+DCS2Dw8rpq7IdGA5UI3U4Imfgl2mNJroOUZ2wB/5jubVl295I2rY0OQHeekDJ9DbLwunNee9dD/Dn3Q0eLsF3Y1SqDzMzllXD0MsKvPOMhff+RHuxq2Fbhe6teR37bsri9AjFiXVkWUvWRLAUMMcvqzv09vcoz4Wgso+6CjaXgdrMGgJ92u+5dTMdjAw/AhtADoUp9zLImUR7Kf9zMTz0g2sq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynrYgUKdiSKvEYh/4CK9woc1AfEaCO5vj4zZSV22RzU=;
 b=SpxSZHnGu9cn6psMxFlfPMNfpalOM6+VKhA9T5oYCXSB2Ycwg6sYdDC0aPRt+MeZZeOeJgX4okWLKz/mfVWsttqF9LtqbeVk1auNcvZPY9S8u1Xd+t9tepov4rsatyYRBXBXBVYvRNxj0a0VkaS/vd8U8hva9I/BtsvegTv/cG5W3GUH8vZrn4LrC7TAJ16M2v/cGFx62S9tGvK+pE7ks4Bpoh6M1BzWaQsOZUyQax7eh0ucox/Aw+oWNXagL+k5GRGkuwIXd3Mu5g0IGT6jlP9Cxe3tgHvCr3w6g45we7TLfM8Rvvmi0IdjlrRDOok29IJ/82Hn5uzY4UY9JV/KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynrYgUKdiSKvEYh/4CK9woc1AfEaCO5vj4zZSV22RzU=;
 b=hBY9eYEyOFdNYTRTo9Krfa/H8pkr6KS3oS82kRf8pK66xZwP8FtDXrEIoRXP/CtI4jn1zs4xbj9lNFHJv0pl35pMdwVmGQhTs4v9UtHFyGVOZm9T9gWWn7giuWESV/BwjCSm+brKw9CJr/rwweoESA3VLFW+lyLCTHTICnqqAeI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2769.jpnprd01.prod.outlook.com (2603:1096:603:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 13:47:17 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%8]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 13:47:17 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: RE: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Thread-Topic: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Thread-Index: AQHXyy3msS0KVMPGG0Sh5mhrfzKAaqvm242A
Date:   Wed, 27 Oct 2021 13:47:16 +0000
Message-ID: <OSZPR01MB701930E5407043BF0B47C500AA859@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
In-Reply-To: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 889eb6db-94c8-4d34-ecef-08d999504a69
x-ms-traffictypediagnostic: OSAPR01MB2769:
x-microsoft-antispam-prvs: <OSAPR01MB2769349FD337FF0C9E21ADFDAA859@OSAPR01MB2769.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCNUYobt9M6D+GTNhake+jxXwKsDh5S1kssQh0VU1AZ2kOS6eNQmgWttDtuSMVm1/PY6CPBWGXJOw0hxhO+iCxU26d7Brdc14SFEDYWthpZ90rWMnXm4W0wkc6sD/QguF/3aMAXmhTF0RJY009R+G0mX8SkAr7kcDdQKYK3VY8WsWxWtwIo0QP3MMGQwSdgkIJlSzdYbZ22sjXXs82HQCicHl4eTxjp4SBlu/OWyeBpbf7K2O+Ac+A7YIOPZqy8lZDx5lP991prsjJfibZgd3M6mm98bebeGgPVepKm+U4MYAemhof2wDXblnJe5h9VTqcTSIZoHj0vZZOvgvDnp4Rq05RytDP5Re/4gTiXgmWwpfMeAHgLwLq+8Lnd0OHWlXmdcglligoq2quSvwc1fDoL0u9oglmfTA8jj/dk41B7Ms5M3XBcDh9F62UpboUKLSJkzMyaX7k9RTBP1p542hm6s/B1bg74TDHU6dlWi3I/HDqKN45WKaNEdPLy9x7K7Ig6s3MztsXAZ1q9zAZOlT5c2QrT7ZVP0PuzYXKkv4lYwYLksDU6NhBB1QPEPdJKTHHKbS8xI9wwbxbmx8eGuHw5IAHQqpRqBS7mrLUxscy8+4HXdqrCHxdb+lPEDgqNCMc9OwWKsNQgeKBRcYOfnxj87zfLrdP0F7QHwMugX7X8+Y1gqtX3gP41OdB5b+LZ8MGCEstkxvD0uwGI430J8Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(316002)(76116006)(2906002)(66556008)(5660300002)(8676002)(110136005)(66476007)(66946007)(33656002)(54906003)(52536014)(86362001)(4326008)(38100700002)(55016002)(71200400001)(53546011)(107886003)(122000001)(186003)(508600001)(7696005)(66446008)(26005)(6506007)(8936002)(83380400001)(64756008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+wkWCZEfAhMcYcVEHRMKprVvN+W9HIezx47c5PNXKCOVhJQX4xErfQs+Bp2?=
 =?us-ascii?Q?LyNK3PKz39z8wHehADIpxmbWhIa1yVIO3f722gi+1Z/2TVpZx/XVl8D4qAX+?=
 =?us-ascii?Q?DHYbWNooPXqt+/dJfDm2kg/YC9JkXvHb6R1JTkYzVOqlFRftRtHD9IYS5b71?=
 =?us-ascii?Q?T5dEBfEkG9xf0KutgX9sdFuuJF+Rh/L4lzJTq5+Gbes71zOFTY+FeLv0nufA?=
 =?us-ascii?Q?rCEjmdxYDwQF4p3yTG61qxBYoTbGUuI8hJW7Wwm5l+we26PPTWggfHO0WnJd?=
 =?us-ascii?Q?tC5hXTah1E3lOA2n8BE8o59mR1bKLRtzdg5MSS5MRRRXmvzdf/5fAYsXwKG2?=
 =?us-ascii?Q?sv9YWQqTNacP9yct5gdHTE+7VbrafQHR2b/mW/UtQOTVqVCJbcM443nVhr+G?=
 =?us-ascii?Q?vtyNTZqHge0MNuJIkpVn1cL3D2ZShBIXD5hXbUT4nVZr/BsPwctlJ7reTsV5?=
 =?us-ascii?Q?/4WObwdaRkgYq6SzSa4zx2Uu1OzS7fd31kMRLpl61xwBPFDmLVWuOake52+f?=
 =?us-ascii?Q?v7pkg9JH3OtEYy12Sixqd7zXPiH4SEv6IibHxhpVlbDmk1st/gKz2x9Ij8Uw?=
 =?us-ascii?Q?C/d4r1utxpTRa8H7B5MhC1R9Jltc2nA+80lTBxuJApD7wCmN9P404VyI8nvS?=
 =?us-ascii?Q?pCup0oQy/zZwQJm4rPaoCvaPqbFeaQ/8SrbRb2wh7LRJE6VfaImndiapLb15?=
 =?us-ascii?Q?3Kfxca7lFEzaJ2XhjdIoEekNRCIwgu4Wh2WFYjgr8o4ncawNqDetfxpMu/qD?=
 =?us-ascii?Q?ipfUJLXNy51c+lOAj+slNIPySuzM5BiJuZ72Q65HtVQ/5tC++xaoDQSMHz8X?=
 =?us-ascii?Q?eweTPL0SzTCqRI1zIluEMZbCdFxis3u0XeBL5LlDMjKGVlzPfqeTjQw4M9uR?=
 =?us-ascii?Q?SDk/s4YjKE0MIt1j1d3U+nIWCHXWZO1QNUBFIi9KrdJ9usAE4hduki0rPI4F?=
 =?us-ascii?Q?i9hQ4ycOdvFBQ4DqjcaXw8wxIPVXhDZavIXAnLZ6pqelLn8BMV5+XOn58HDY?=
 =?us-ascii?Q?ovHTUOD4D+JPz87xuHIa1PXmfS0zatFSxmNhFt4E+eFzu3QsBfsZ0c/1vUZo?=
 =?us-ascii?Q?Jt7/XL4y+azTCVXCGyr6LvDM1VguQBVVVYEbBr5+aWOXiiklKF/xkdBIojkS?=
 =?us-ascii?Q?wQBoHJR8uNPbKTWdBR351tCnGn5EyiXXC4jcwU3KvPI/r6L/MsXagfNCmwwA?=
 =?us-ascii?Q?fUSZCepVCQkolBfAov6W2/oCSOCw2zo5Ax0vWAqQYpWnnHTkKq0Fooj1h4i0?=
 =?us-ascii?Q?vruQU0ORObtomoG1E1OvzPiG2raTyaQ+7Y7CWB5Bxm8cVX1GoCY3ZQsqg+kf?=
 =?us-ascii?Q?9bcLNxCs4pyiREf9CRI9JAvthG/4eHu3Ia3A9Q6MMwa7ndAPMr/lhMOnS76A?=
 =?us-ascii?Q?0EAADPQm3max1ckh/DxDpXLFaebkvWanbCQ362zE5UP00ohBHGFFUciwxELq?=
 =?us-ascii?Q?aio1jPiFL/ipC+RCeR0dzW7p8CT1FqMttD+Pa3UA73djV6tbEJ88NB76kSYP?=
 =?us-ascii?Q?W9ks/qiq5nW2sjafMIDJr0yFE9jUfhTRL7pME5eKe2bLefk4tS72h2qCJfBa?=
 =?us-ascii?Q?t6yWu+4mIrTIkeWkjfMwUo7plKMIGBoutBnV9VHNyP7XUrN5H6bs2Q9lCxXw?=
 =?us-ascii?Q?o5eoWExl5oyxp+m7dB9pOtm1tmp9mcDRmlWvoZRp0G+f6UoKWwg2yncnLn3L?=
 =?us-ascii?Q?Syfgx2egUjZ3xQ8j4hQL6UXry/eAzAdKT7qc3aeQr70ND6eZ5ySC751c4oyP?=
 =?us-ascii?Q?BygaC2oqgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889eb6db-94c8-4d34-ecef-08d999504a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 13:47:16.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHwB90WuJyvEjNUMMT4JmAe8ncgOAshjsi3XXDUDVRk9X2ypyw+B/MQSuX1VUfDqsOwaPIV2m9NJ2ticgYNfMj8EO+A2zmRqlpYjfOuFrrALJS130zBwYOGIiS1IRidW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2769
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 27 October 2021 13:27
> To: Marek Vasut <marek.vasut+renesas@gmail.com>; Yoshihiro Shimoda <yoshi=
hiro.shimoda.uh@renesas.com>;
> Bjorn Helgaas <bhelgaas@google.com>; Rob Herring <robh+dt@kernel.org>; Pr=
abhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: linux-pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicet=
ree@vger.kernel.org; Yuya
> Hamamachi <yuya.hamamachi.sx@renesas.com>; Geert Uytterhoeven <geert+rene=
sas@glider.be>
> Subject: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
>=20
> From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
>=20
> Document the support for R-Car PCIe EP on R8A7795 SoC device.
>=20
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> index 295840cf612f9377..32a3b7665ff5473c 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -19,6 +19,7 @@ properties:
>            - renesas,r8a774b1-pcie-ep     # RZ/G2N
>            - renesas,r8a774c0-pcie-ep     # RZ/G2E
>            - renesas,r8a774e1-pcie-ep     # RZ/G2H
> +          - renesas,r8a7795-pcie-ep      # R-Car H3
>        - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
>=20
>    reg:
> --
> 2.25.1

