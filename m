Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAC751E7F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGMKLU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjGMKLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 06:11:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD210F2;
        Thu, 13 Jul 2023 03:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlyu7ZTA4/fBzPIY+381h7WAjGUNcCv2cWkDfqVNAbF/injvy3ArrhxrU6M+29X+yYxHZUB6fHs1pUTWnpxPYjlZQ8D0iJ9FOZ3XL7MNfEwgv2R0nNKjKG1KQ7eMAtUcG0gsN5scTkAL6CWMEchmcpsNHzUVIpOgCoC0GHyOtcKdm89fXs2b9e6qWW5HmmxcXOUDPXPDVV1yW8JV7Wh5x+ZXV4qggf1YxIIpB2aeHOnOyjBG6vDmYTOtxn+5TZRgKdhSVgYmVGTwDP+bH0MdMz7CTV6j20DiXrhTQ7gOEdQfcNciThBmPaUsVQLqpL82suZ7+cWlHbdseCr/k0aqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c7yvbLkOTqdOVIcAMQ9CsiDn/YvajQOwactNGX+YFQ=;
 b=kjr1kC4pI8PHMU+DVefCbwZkkC7Et37Hpz1PKrTrPEkxADmh3YNunH+l0Lv48f6as+0RkkkbeMwGGTJmCXvHKc0V5m+2B7dOJgk3mXD5oVXT2Tvp22In2EiwxCz3DuE6ojoSJHjls5wO6YZ7lqITiGZHozOq+IAyKNqWYG/alP/Q1UOnrvFrhONmkWn3Yd/tf74QleFZCHWvtUyUzhk+ffJnES5XIGOCnrMkllj/wPLtkn1piUO9MdbFUs3GpsEZUQgpx4MEqGYCifY2E0B/B0CpaaFf7GBsd6GsI6gSeARu0/dfK5AnHh9VuUwmjTW7exBPq4kWjyb2mhbF71KLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c7yvbLkOTqdOVIcAMQ9CsiDn/YvajQOwactNGX+YFQ=;
 b=XL9PRN0t4pF75RW32Z7WJy1cMrZiqpMzslB2WOb0Lnwah6CF1/n9mBKDJ1hpjJP7WTgADZm2FJWMP2qzqomR3Ul2HtUgMN0Fq4eL0LdbVcegL5mfCQiEIKQNPgCf+Wu1vvmyIbC/tBBNTBULHpGo00U+jjv9p0Rp0Gk0D9NpM+Q=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5656.jpnprd01.prod.outlook.com
 (2603:1096:604:c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:11:02 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 10:11:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v17 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v17 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZrzZQH/TXa67Ck0yjF8MU19GZg6+0reoAgALYDpA=
Date:   Thu, 13 Jul 2023 10:11:02 +0000
Message-ID: <TYBPR01MB534127FD9E176BAF790B0017D837A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-5-yoshihiro.shimoda.uh@renesas.com>
 <2ch2jdsf3qx4ir4agqmqlzbnya2jmiwzdf2bre3hswcsk24wrs@kdo42tn7xzry>
In-Reply-To: <2ch2jdsf3qx4ir4agqmqlzbnya2jmiwzdf2bre3hswcsk24wrs@kdo42tn7xzry>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB5656:EE_
x-ms-office365-filtering-correlation-id: 30cc436d-b513-43cb-e20b-08db83897690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oufm+eJ7W7MNpEvtxpFHbbuepPI0IzWY5x65rj7desh2CXKpA5vBZiyXGEFzfHVs+OTT3RVYL6CzXr18y4eZTB5dAiAup8XG9KyGFIJZfoPnzrDwMRvMEJtk3R3LoF+46Lus/mlvq1RCu+Ds1WzQcromrqkE3kiQXlBzpzP/g+UJ7WwM+Lo/Vm1oV+sg9fMmxG4U5SxME7ZrSU0Yt+bJS/RzvcELmFILC37m6RknfCq/NfI/Mdx/9JwbSvr9ukj7GQLj2TYtGDMVfzVj2dP1p5W9sjqy1zXsS25RG4fF1rKOBzSGEvPAC03pO5JtaNK239HuUP7LnLs7v19EZ9g17DUrAqEx7kvQciipxxCUlVflC4g9mBIf8hLQiiV2khw13Y4zfH23FvOCemHuOyWExRoO38tdhy29pqNO5gUA3e52JQIGx+hH0T8LjZJVLtYL62s2I8jiDW+1FGB7MiUKR9iNO8h6teFlj+R7C7DIEl/AGL8OrOFfyZRR8AB6n98Yu5BK8REcar4+wE97zxnqu8XWkObNi0YGgjXwKkUZpWhpTOABEjrS3YkbTfbcRv8p/7UDJEHelxTyrPN1suCwe3CmyNxoniARjG1lfgf+lr8X1Yxib+sL5ZnLtyzNwuHX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(7416002)(52536014)(5660300002)(8936002)(64756008)(66556008)(66446008)(8676002)(30864003)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(76116006)(66946007)(54906003)(71200400001)(7696005)(9686003)(6506007)(186003)(83380400001)(33656002)(86362001)(38100700002)(38070700005)(55016003)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g2YpROap95Jx4lMWhYTmHKw0gMwu/A2XcXY96upYEb5zseWYkqmfrg/2D0kh?=
 =?us-ascii?Q?XmUAu3Ppwft88txk/zXaMy/Hxk76KVL49EuFUUwvmwEGrtINviuS72EBjB5B?=
 =?us-ascii?Q?Ifbh2D/OpdvwYmwmE+eMR9K9mAKUVlh/ZZMexLf8maVEHnpl+DMLZnb83+F1?=
 =?us-ascii?Q?f75UwZ6E9lkE6sz8Hyf6+PtjN7riLvh9qGjIrmg7joxvC8yPJrL4gwk5MzdH?=
 =?us-ascii?Q?Li84Lm1qbJ1iwftFn9qF578BXYwSAJG9dt9tkFOjuEt/5MXDSVb9b+8B7e8l?=
 =?us-ascii?Q?gudLrBJNzTK/a5BKtwUKDHNy2B8PtV42Li7BcxA9Ddp1HTqvlKTwQCeJtZjn?=
 =?us-ascii?Q?X3CKw2MS2iEBUoWT5hBuVJqbCLTF61yjJ+PlhCitG/a0Y35a7xMO2jyhENeq?=
 =?us-ascii?Q?7s0CtNdUja4Mtiz4zhOwn1t8/NC1blImZRK6HEKV++oOAV0wh6i1dcxfo8G8?=
 =?us-ascii?Q?jlBTpv/FK5z9CCYKTrHSYKKfHtuZZKQcLaqTAeGqXv0WELOxINFYTKxUBiqp?=
 =?us-ascii?Q?Kb0CEBJRDxH9ghNFgydwuHGeSvGV0jT4F6/UoK8Ek4Emzc5ozZLNdzplFN0y?=
 =?us-ascii?Q?kkdiRRrV3A+9wbJvhlwz1eaflz1UlydDHzZ6PMO+3wl5qGpPJtqXvxu73M7Z?=
 =?us-ascii?Q?T8INwXFj2u7BtyWOmW0niXunXXwWdY/FHPmPO7MPwvH1OuUKKecHlkqe6iRQ?=
 =?us-ascii?Q?ENh9hL2NH4G+2bqGuz+vNKVaskpPri1zhb9xMsbANtiMm8jeamiL/cTEfibZ?=
 =?us-ascii?Q?gguGeArEP2RbAqIlkfkbIiINNhwqXmW123Pj9RFMqlY9K6nY7QeO9H+Qc+2+?=
 =?us-ascii?Q?5IaFJ29bkOhZ4LNpwoD3uJup6U70fzA6Nm/bLTxRf1b2wU/GwQ74NNlB16IY?=
 =?us-ascii?Q?NuOma+z/0kvfwzbbvQdoJEXVGhsEfwxOxdXjUMvzWmRXCsOnsRFdEX+q1TR+?=
 =?us-ascii?Q?28D1o6H9IszIZfdnWuXwW8XVe5XgmPRsrd6iHJ9PKdEd9bz8yeIdF1Mt5V8h?=
 =?us-ascii?Q?zToKLp1Bz5wjWuk8IRrC0BK2xM1oTG7KtRkgvp3jYxHgStMKMu9LLtvUlrkA?=
 =?us-ascii?Q?zTnciV+/cJJ/fXPxrFw/VD+j+pCNlM2yiqOuKpB0EO6yLbs/W704h0Q8BQFh?=
 =?us-ascii?Q?jCdFhmkBmnzG8Z12EVxmXzUbQi1p9hA+2448Sgcm3k44XlNPqHIdX+8x6KhE?=
 =?us-ascii?Q?JLxgJdD87JceuVgXqEo9LVKTN2tyKWScVf5o5inetHS7FZsck5qziBUMJEOc?=
 =?us-ascii?Q?upAoyvN7D27tkxKYCPvKg718tSyi5WJPBx1H1TuATgbWVrunHinA63cnqI5U?=
 =?us-ascii?Q?u+4m1VUX6m6x3YU1TiTbOKaNk6J6yrm/GdAd+mNrcyU5q0N//ayuWrmyccow?=
 =?us-ascii?Q?dexuSK0L+AlJ/FOTMn6YNibgZSwKVx6ZZ3Rqi6xTrbcmZzwlL4CMkWLOwinb?=
 =?us-ascii?Q?hUPYlHnQvpZfcKJZWRB/qUTW8nrL/iK+P9DbkHhq+ayImGGi+gmN9iYw7D3b?=
 =?us-ascii?Q?wG6/5S4j+z+ZeGVAbN7bB8OGqujpRQUzCvEbIp+u+tyfDjsQArtCoulvAPyw?=
 =?us-ascii?Q?/mPpnq4PgA6qP/5UuwXTdn+b02pNdy51ILrg71NeLm6pDGEgeKyrKwMF1Qj3?=
 =?us-ascii?Q?zRjWmf2dxghPknord23LkM7ZPmjIUUWF1cB1nh2xXgkjAWM1zXmb/JwRpqSe?=
 =?us-ascii?Q?Tse2ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cc436d-b513-43cb-e20b-08db83897690
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 10:11:02.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ//slSvB81p1aquosGSSzaHZfXwq9D184bYleG+E/gGdFNly7sgqoWuv1WUnSqaWek/CLwOB8s2rcrMEg1/BTLtsEJL/MxzCWcTeGTzaXgdu4c1uiPcWQ1pYax/3Pda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, July 11, 2023 11:44 PM
>=20
> On Wed, Jul 05, 2023 at 08:41:50PM +0900, Yoshihiro Shimoda wrote:
> > The __dw_pcie_prog_outbound_atu() has 6 arguments now. To support
> > INTx IRQs in the future, it needs more 2 arguments. For code
> > readability, introduce struct dw_pcie_ob_atu_cfg, and change the
> > arguments of dw_pcie_prog_outbound_atu(). And, drop
> > __dw_pcie_prog_outbound_atu() and dw_pcie_prog_ep_outbound_atu().
> > No behavior changes.
>=20
> For reviewers:
>=20
> This patch is a preparation before adding the Msg-type outbound iATU
> mapping. The respective update will require two more arguments added
> to __dw_pcie_prog_outbound_atu(). That will make the already
> complicated function prototype even more hard to comprehend accepting
> _eight_ arguments. In order to prevent that and keep the code
> more-or-less readable all the outbound iATU-related arguments are
> moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> is supposed to be locally defined and populated with the outbound iATU
> settings implied by the caller context.
>=20
> As a result of the denoted change there is no longer need in having
> the two distinctive methods for the Host and End-point outbound iATU
> setups since the corresponding code can directly call the
> dw_pcie_prog_outbound_atu() method with the config-structure
> populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
>=20
> >
> > To add more arguments to the dw_pcie_prog_outbound_atu() in
> > the future, introduce struct dw_pcie_ob_atu_cfg and change
> > the argument. And, drop dw_pcie_prog_ep_outbound_atu(). No behavior
> > changes.
>=20
> This sounds the same as the first chunk of the patch log. I'd drop it.

Oops. I'll drop this on v18.

> Anyway as I said in v16 the change looks good to me.
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> >  4 files changed, 77 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 27278010ecec..fe2e0d765be9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep=
 *ep, u8 func_no, int type,
> >  	return 0;
> >  }
> >
> > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > -				   phys_addr_t phys_addr,
> > -				   u64 pci_addr, size_t size)
> > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > +				   struct dw_pcie_ob_atu_cfg *atu)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	u32 free_win;
> > @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie=
_ep *ep, u8 func_no,
> >  		return -EINVAL;
> >  	}
> >
> > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU=
_TYPE_MEM,
> > -					   phys_addr, pci_addr, size);
> > +	atu->index =3D free_win;
> > +	ret =3D dw_pcie_prog_outbound_atu(pci, atu);
> >  	if (ret)
> >  		return ret;
> >
> >  	set_bit(free_win, ep->ob_window_map);
> > -	ep->outbound_addr[free_win] =3D phys_addr;
> > +	ep->outbound_addr[free_win] =3D atu->cpu_addr;
> >
> >  	return 0;
> >  }
> > @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >  	int ret;
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > -
> > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > +
> > +	atu.func_no =3D func_no;
> > +	atu.type =3D PCIE_ATU_TYPE_MEM;
> > +	atu.cpu_addr =3D addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> >  	if (ret) {
> >  		dev_err(pci->dev, "Failed to enable address\n");
> >  		return ret;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index cf61733bf78d..7419185721f2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(str=
uct pci_bus *bus,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int type, ret;
> >  	u32 busdev;
> >
> > @@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(st=
ruct pci_bus *bus,
> >  	else
> >  		type =3D PCIE_ATU_TYPE_CFG1;
> >
> > -	ret =3D dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev=
,
> > -					pp->cfg0_size);
> > +	atu.type =3D type;
> > +	atu.cpu_addr =3D pp->cfg0_base;
> > +	atu.pci_addr =3D busdev;
> > +	atu.size =3D pp->cfg0_size;
> > +
> > +	ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  	if (ret)
> >  		return NULL;
> >
> > @@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
> > @@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *b=
us, unsigned int devfn,
> >  		return ret;
> >
> >  	if (pp->cfg0_io_shared) {
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > -						pp->io_base, pp->io_bus_addr,
> > -						pp->io_size);
> > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > +		atu.cpu_addr =3D pp->io_base;
> > +		atu.pci_addr =3D pp->io_bus_addr;
> > +		atu.size =3D pp->io_size;
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret)
> >  			return PCIBIOS_SET_FAILED;
> >  	}
> > @@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_write(bus, devfn, where, size, val);
> > @@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *b=
us, unsigned int devfn,
> >  		return ret;
> >
> >  	if (pp->cfg0_io_shared) {
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > -						pp->io_base, pp->io_bus_addr,
> > -						pp->io_size);
> > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > +		atu.cpu_addr =3D pp->io_base;
> > +		atu.pci_addr =3D pp->io_bus_addr;
> > +		atu.size =3D pp->io_size;
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret)
> >  			return PCIBIOS_SET_FAILED;
> >  	}
> > @@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops =3D {
> >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	struct resource_entry *entry;
> >  	int i, ret;
> >
> > @@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
pp)
> >  		if (pci->num_ob_windows <=3D ++i)
> >  			break;
> >
> > -		ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> > -						entry->res->start,
> > -						entry->res->start - entry->offset,
> > -						resource_size(entry->res));
> > +		atu.index =3D i;
> > +		atu.type =3D PCIE_ATU_TYPE_MEM;
> > +		atu.cpu_addr =3D entry->res->start;
> > +		atu.pci_addr =3D entry->res->start - entry->offset;
> > +		atu.size =3D resource_size(entry->res);
> > +
> > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> >  				entry->res);
> > @@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
pp)
> >
> >  	if (pp->io_size) {
> >  		if (pci->num_ob_windows > ++i) {
> > -			ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> > -							pp->io_base,
> > -							pp->io_bus_addr,
> > -							pp->io_size);
> > +			atu.index =3D i;
> > +			atu.type =3D PCIE_ATU_TYPE_IO;
> > +			atu.cpu_addr =3D pp->io_base;
> > +			atu.pci_addr =3D pp->io_bus_addr;
> > +			atu.size =3D pp->io_size;
> > +
> > +			ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> >  			if (ret) {
> >  				dev_err(pci->dev, "Failed to set IO range %pr\n",
> >  					entry->res);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index c87848cd8686..e4ac1def7363 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >
> > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no=
,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +			      const struct dw_pcie_ob_atu_cfg *atu)
> >  {
> > +	u64 cpu_addr =3D atu->cpu_addr;
> >  	u32 retries, val;
> >  	u64 limit_addr;
> >
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> >  		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> >
> > -	limit_addr =3D cpu_addr + size - 1;
> > +	limit_addr =3D cpu_addr + atu->size - 1;
> >
> >  	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->region_l=
imit) ||
> >  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> >  		return -EINVAL;
> >  	}
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> >  			      lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> >  			      upper_32_bits(cpu_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> >  			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> >  				      upper_32_bits(limit_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > -			      lower_32_bits(pci_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > -			      upper_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(atu->pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > +	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val =3D dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENA=
BLE);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_AT=
U_ENABLE);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) =
{
> > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2)=
;
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >
> > @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_p=
cie *pci, u8 func_no,
> >  	return -ETIMEDOUT;
> >  }
> >
> > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> > -			      u64 cpu_addr, u64 pci_addr, u64 size)
> > -{
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > -					   cpu_addr, pci_addr, size);
> > -}
> > -
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr,
> > -				 u64 size)
> > -{
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > -}
> > -
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index,=
 u32 reg)
> >  {
> >  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 3c06e025c905..85de0d8346fa 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> >  	DW_PCIE_NUM_CORE_RSTS
> >  };
> >
> > +struct dw_pcie_ob_atu_cfg {
> > +	int index;
> > +	int type;
> > +	u8 func_no;
> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 r=
eg, size_t size, u32 val);
> >  int dw_pcie_link_up(struct dw_pcie *pci);
> >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +			      const struct dw_pcie_ob_atu_cfg *atu);
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int i=
ndex,
> > --
> > 2.25.1
> >
