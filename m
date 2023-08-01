Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D476A653
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjHAB3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHAB3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 21:29:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B97114;
        Mon, 31 Jul 2023 18:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxMX/T1iOmhikyUNIKU0+7B3jUBEVrb6PLTzm2WR22qx0wv20y2czCz0g1Js1c7pTUt6dMP38fD6lBYLGctMCQxG2WvulwqDjvXScbW7gyiNulMGm7ouq9fAiiWqwk+/uRpqJPvvy/SLw+hGYRWMDeuuMdEfJGsjml0r2IQM/FClxXU8veInIS0hswh4B7fa0tjSwoOh1QAuVtYNdAte/Y73Y4K66XCycN/d251NCj+NX9KQ+k7SSTht5+Sbc88wQkNefXWGmlRmFd8epK4+vkCyOEk7K3Hzbcx7DzzVVoyIKqAP0o29NkQTvmOyqArpwl8IcLU11HtAPqSzVwcM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3RLxI4KvDm2vtFmxLs2XjELCg1ZfjySqt14jB40S7g=;
 b=SHVkxAnQHpqMb3PVcscaEkEvy6jfJF8ckidOy+Mwl1668pRnCstTY0MP3IOIB/hY/utiFbKoWz8Kk5qdu04kIjV3eksb8C3LwLPeymgxd7x/ZkhUvE/FM6OO+qBoVsENfDTWDidkE8QFpOJTp4/0NQEWo1JdmMfdDSbViJEl80Txn1+WdzSaTQ5kDVchfvEbrmSmgtXyK6gDWjl1z1jER8q7hXRyPp6GYrJK94HC54f1pFBV6S5J8lExg1BWUk9Br+1p9edwUGH2i++KelRvDN9j75ljaWwdEQN4d0hJNYnFw07KtdMJyTVKGb+AjwOmDTwGDza8+B6871vOp9KqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3RLxI4KvDm2vtFmxLs2XjELCg1ZfjySqt14jB40S7g=;
 b=ZF67PMNMGeC5M6UAJjmlbi+jM+lW3ecO4vWwf9v7HNwtsabz7gVjT0rKGZ0i3ACQx/FXMTYI6p6q1gx0w44yPW5esYgslORLYyps3U9WoIVcOm9cxTyeZ/ahcWiZk20Hk2kUuJFFCVUJ62SKyw+4ug82GJw5JnEooRaiMOitPG8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5756.jpnprd01.prod.outlook.com
 (2603:1096:404:8055::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 01:29:10 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 01:29:10 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
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
Subject: RE: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZu6dDb7hFhSogz0udklVWjO2cJ6/QC08AgAMXU6CAAVM9gIAAQCcQ
Date:   Tue, 1 Aug 2023 01:29:10 +0000
Message-ID: <TYBPR01MB5341F15483816E81A073B12DD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <u2lzrypnaevcp5r5xueeceoq6b5v6ngzdmwyadel2liloxb3rz@6ribp2lqv2db>
 <OSYPR01MB5334EBCD11ED8D3104A0BEFBD805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <4idgmodxlnzv2kkscniuw3336ynmukh3duu4rt2db354ln5sbg@e4jnmhfugmj4>
In-Reply-To: <4idgmodxlnzv2kkscniuw3336ynmukh3duu4rt2db354ln5sbg@e4jnmhfugmj4>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5756:EE_
x-ms-office365-filtering-correlation-id: 8bd1d5d6-7f85-446b-47b8-08db922eb4bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmPrf80y2RyABKGVgPmWIhoH2gONsBfppydy2X5z8iuIz67EZyk3wwtIbOPq+KXPdwQ5z8lpDUDP15e6OwGURrDEcTfW5YZH7wwfzpbd3m2SGPqeQSRjl44MiL0i7FXO0+2N5l2z501bkxGT5JTvlZLRpzLjgJS+WqIXdc00KgTbNzOLAGRHvEBEAj7djz7U+cQIdhOi7qWJvWpburbNyhDKt3WRNLRmuJtwj87bo/VIMzhyuMaiwbADSMml1+/TcWDyxclNUpCeU1wNF8sSGTU0Yo09oIFu8kE9RxNK+vKZlp5XaEy9OZK/lkbhf7oahN8+xEAr4DkHQfjXMsEN077hhbM8W9Kp+Sq/fpRqiJNE+AHLn0dpJLL7sJkRiIOGsVqgK+1nhzGhHLlvUxGnjPucPaH4SV2sSN2gOZS07HCxcNXAfx8L99lYAmZdkKLNjnmkus+qU9IFxImdDJhfSQOM3s3n736q9n4Kz7/LBYNqvGxdV4CQT4S49k4SmtZqiF4mA/saoebkY8iUv3rOxIoheiDdGwEVgnjciVp9dLeImpOYiYfIQTc89Dpy0CoxrdbOHn7SBjdqhmaqxWUb91mPYmuHv92qfiNGOceayYt4OskADd5XlmvmbKF9zez2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(6506007)(186003)(8676002)(8936002)(7416002)(5660300002)(52536014)(76116006)(66556008)(66946007)(66476007)(64756008)(41300700001)(54906003)(2906002)(66446008)(6916009)(4326008)(30864003)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EW/lsz/TihNQQszTq1bTMvBohLeggtWEWWU+NHnkQYywlbiWfgFPa3LiqNZL?=
 =?us-ascii?Q?GLm6bZb1Ssd3+ONWpVtAq/IC32OdPl0RHYA8t868ZmEWMcvFIq4KLdy6oWhC?=
 =?us-ascii?Q?k0Ga30QFlZcWvaxz/PMOVjgVUP2IyDM8CVy+q/ITe4GHImOwNA1UxZ1qbQFL?=
 =?us-ascii?Q?fD1AtzIsfTT4R8FXLyDGRF/duv7USPCvvjFwTtN0/LiP0v2Fhtd8k1uxk1qb?=
 =?us-ascii?Q?AY6gzVdy4ehsNgbETg86uiLNJ/UowrNQu9orY6MvVprDbWrbCszhNdHURTf7?=
 =?us-ascii?Q?RuQ9uM6f1dm2tDp7/+lNr/jbZihsEviwbT4nXxcSafIPK0ZVggQbBdC+yII+?=
 =?us-ascii?Q?zWyRWVpGHVXHHWqhE72nrpuZFI5Q//Dj8GU9KLdyRyDAfSf1435k76XmZZ7c?=
 =?us-ascii?Q?QObTOFl2QmzUKY8nYD1yS6m9TnzT3l6ZKo7Svynfylj6TN63aGWz40bie5Fv?=
 =?us-ascii?Q?CufZDA9sdJyo+xjrhfiCTvtXQzVOMNBLdidHQVP9/cmE093A55EwTT/cp2+Z?=
 =?us-ascii?Q?blhC0zLrQo8xSB186HR5Fmng7CU7+ckWyh057GgKV+WFGZCr6BZkLPcJ2d3j?=
 =?us-ascii?Q?vQZmmm5fkCNOJ0Bu+xvfIqNDE2Tt+P1X+bBCbqsSZIdyadijv9eoTRifkLxP?=
 =?us-ascii?Q?ff+bMpP0ERYT4/jvKdxQv/xwWh89NTiZWIVlEXs1MfLGxABPHsSSsMb/X4GQ?=
 =?us-ascii?Q?h5kTspfALDNLfpcXEMUGbjbAZh+lrCqLj2jNcHBDUSkz9JACw4sbjuhYuXFp?=
 =?us-ascii?Q?nANYgf/LRVcipwTPjUVFiYt/9yTcjbeor4N4ZJUFXvrMN15XTQQIbSZPr2wv?=
 =?us-ascii?Q?L1c+Zkd2Cjlxzn10djOC/82WB0TAbj7jG6bV7hV5StehGi4nwzDVODyS9xtC?=
 =?us-ascii?Q?5KMa5n5uNV0oNtA0mCXId134eM7fntCthzxvD4ykL8gnBeyDx3Ptsa/So8o/?=
 =?us-ascii?Q?qstN5PKpAyckcNl8gIxmP2iCkEB9TGcq0vDesDzey66IrWdL8fJKbw9qzRDc?=
 =?us-ascii?Q?3a39FfxWhJyy/+W+qT3nbxrUak9bKINEeA4luCtVZRtcXGRAF9cWPjyJXKCr?=
 =?us-ascii?Q?IT+VlicmybLMV3+svP2oArP4T5NSZpyXo93/33nSs/Ap145SduGHV+Ht+P/C?=
 =?us-ascii?Q?sJuThwsYdN2NxhbSX16NYXthKSUoD6t6xVjfUud138aOP/HZAlvw7T6dDWhB?=
 =?us-ascii?Q?7uhrEYTxyUmGzQ2QDtNIJJO3QSdajpPUPCZ1yWMLl/iVikz8EED4MluDntBt?=
 =?us-ascii?Q?v9luexy23GZOUbTttssNsNUEJ3ivudQkKV9ujI9kI2jxFkw9Io+WffmjS2cy?=
 =?us-ascii?Q?w6mmP57nSKoZ/HiMj9ZNryLMy7afDiA4pbfiyCU0fHPvs2Y3AlB3l0V6edRY?=
 =?us-ascii?Q?fS4BfjGs5TjbEPWaCiSZu3SwaD5TUEhWTObNIZckHnPqV6/kO09+k1vdOVGd?=
 =?us-ascii?Q?nYmcLRYBmBfbFOCPNYZsuLNVF5AtNISBgsdDTNEpePYBCeWieJg1s6YGSV8p?=
 =?us-ascii?Q?Ib+leeaUxPNoaFIO1R0eqW+f3KNEuJxB5bZKw6T3UuzEd5oM8qhddjUjJC1I?=
 =?us-ascii?Q?RlTUOv2N4OeL272PiSj4iq1GnywGiRiWsBJp6WUu0kXqiiq/CELuNsyvx8QX?=
 =?us-ascii?Q?IRxJ3bldfWubmG1Io/gL8cc615M7mW2sBIC8rsM39Hcbmk7laPJgnsn/mHpy?=
 =?us-ascii?Q?Ao42wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd1d5d6-7f85-446b-47b8-08db922eb4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:29:10.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySjIjd8hnneHnvjdx1zyLqvDLphXfr/kzWerlMFlHppjnIcwVP2oQL1XPS2xl8Q1rdq457vNLdgaTDVSnO52HjhQgFHa0fukDeKwiicitZfW+vJRuG+o1qP2Eb6LCl8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, August 1, 2023 6:33 AM
>=20
> On Mon, Jul 31, 2023 at 01:24:27AM +0000, Yoshihiro Shimoda wrote:
> > Hi Serge,
> >
> > > From: Serge Semin, Sent: Saturday, July 29, 2023 11:07 AM
> > >
> > > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > > To support INTx IRQs in the future, it requires an additional 2
> > > > arguments. For improved code readability, introduce the struct
> > > > dw_pcie_ob_atu_cfg and update the arguments of
> > > > dw_pcie_prog_outbound_atu().
> > > >
> > > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > > a need.
> > > >
> > > > No behavior changes.
> > >
> > > So you decided not to use a suggested by me in v17 more detailed patc=
h
> > > log?
> >
> > You're correct. I thought your suggested comments was too detailed.
>=20
> I strongly recommend for you to use mine instead. It gives more
> details about the change and the patch context. Moreover it much more
> clearer justifies the change implemented in the patch.

I didn't realize that you have a strong recommendation about the comments
you suggested. I'll replace the commit description and add your Suggested-b=
y
tag on v19.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > C&P it here just in case if you change your mind:
> > >
> > > This is a preparation before adding the Msg-type outbound iATU
> > > mapping. The respective update will require two more arguments added
> > > to __dw_pcie_prog_outbound_atu(). That will make the already
> > > complicated function prototype even more hard to comprehend accepting
> > > _eight_ arguments. In order to prevent that and keep the code
> > > more-or-less readable all the outbound iATU-related arguments are
> > > moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> > > to which shall be passed to dw_pcie_prog_outbound_atu(). The structur=
e
> > > is supposed to be locally defined and populated with the outbound iAT=
U
> > > settings implied by the caller context.
> > >
> > > As a result of the denoted change there is no longer need in having
> > > the two distinctive methods for the Host and End-point outbound iATU
> > > setups since the corresponding code can directly call the
> > > dw_pcie_prog_outbound_atu() method with the config-structure
> > > populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> > >
> > > -Serge(y)
> > >
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++--=
----
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++---------=
--
> > > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/driv=
ers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 27278010ecec..fe2e0d765be9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pci=
e_ep *ep, u8 func_no, int type,
> > > >  	return 0;
> > > >  }
> > > >
> > > > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_=
no,
> > > > -				   phys_addr_t phys_addr,
> > > > -				   u64 pci_addr, size_t size)
> > > > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > > > +				   struct dw_pcie_ob_atu_cfg *atu)
> > > >  {
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > >  	u32 free_win;
> > > > @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_=
pcie_ep *ep, u8 func_no,
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE=
_ATU_TYPE_MEM,
> > > > -					   phys_addr, pci_addr, size);
> > > > +	atu->index =3D free_win;
> > > > +	ret =3D dw_pcie_prog_outbound_atu(pci, atu);
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > >  	set_bit(free_win, ep->ob_window_map);
> > > > -	ep->outbound_addr[free_win] =3D phys_addr;
> > > > +	ep->outbound_addr[free_win] =3D atu->cpu_addr;
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc =
*epc, u8 func_no, u8 vfunc_no,
> > > >  	int ret;
> > > >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > -
> > > > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size=
);
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > +
> > > > +	atu.func_no =3D func_no;
> > > > +	atu.type =3D PCIE_ATU_TYPE_MEM;
> > > > +	atu.cpu_addr =3D addr;
> > > > +	atu.pci_addr =3D pci_addr;
> > > > +	atu.size =3D size;
> > > > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > > >  	if (ret) {
> > > >  		dev_err(pci->dev, "Failed to enable address\n");
> > > >  		return ret;
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/dr=
ivers/pci/controller/dwc/pcie-designware-host.c
> > > > index cf61733bf78d..7419185721f2 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus=
(struct pci_bus *bus,
> > > >  {
> > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > >  	int type, ret;
> > > >  	u32 busdev;
> > > >
> > > > @@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bu=
s(struct pci_bus *bus,
> > > >  	else
> > > >  		type =3D PCIE_ATU_TYPE_CFG1;
> > > >
> > > > -	ret =3D dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, bu=
sdev,
> > > > -					pp->cfg0_size);
> > > > +	atu.type =3D type;
> > > > +	atu.cpu_addr =3D pp->cfg0_base;
> > > > +	atu.pci_addr =3D busdev;
> > > > +	atu.size =3D pp->cfg0_size;
> > > > +
> > > > +	ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > >  	if (ret)
> > > >  		return NULL;
> > > >
> > > > @@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus=
 *bus, unsigned int devfn,
> > > >  {
> > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > >  	int ret;
> > > >
> > > >  	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
> > > > @@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bu=
s *bus, unsigned int devfn,
> > > >  		return ret;
> > > >
> > > >  	if (pp->cfg0_io_shared) {
> > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > -						pp->io_base, pp->io_bus_addr,
> > > > -						pp->io_size);
> > > > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > > > +		atu.cpu_addr =3D pp->io_base;
> > > > +		atu.pci_addr =3D pp->io_bus_addr;
> > > > +		atu.size =3D pp->io_size;
> > > > +
> > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > >  		if (ret)
> > > >  			return PCIBIOS_SET_FAILED;
> > > >  	}
> > > > @@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus=
 *bus, unsigned int devfn,
> > > >  {
> > > >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > >  	int ret;
> > > >
> > > >  	ret =3D pci_generic_config_write(bus, devfn, where, size, val);
> > > > @@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bu=
s *bus, unsigned int devfn,
> > > >  		return ret;
> > > >
> > > >  	if (pp->cfg0_io_shared) {
> > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > -						pp->io_base, pp->io_bus_addr,
> > > > -						pp->io_size);
> > > > +		atu.type =3D PCIE_ATU_TYPE_IO;
> > > > +		atu.cpu_addr =3D pp->io_base;
> > > > +		atu.pci_addr =3D pp->io_bus_addr;
> > > > +		atu.size =3D pp->io_size;
> > > > +
> > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > >  		if (ret)
> > > >  			return PCIBIOS_SET_FAILED;
> > > >  	}
> > > > @@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops =3D {
> > > >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > >  {
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > >  	struct resource_entry *entry;
> > > >  	int i, ret;
> > > >
> > > > @@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_=
rp *pp)
> > > >  		if (pci->num_ob_windows <=3D ++i)
> > > >  			break;
> > > >
> > > > -		ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> > > > -						entry->res->start,
> > > > -						entry->res->start - entry->offset,
> > > > -						resource_size(entry->res));
> > > > +		atu.index =3D i;
> > > > +		atu.type =3D PCIE_ATU_TYPE_MEM;
> > > > +		atu.cpu_addr =3D entry->res->start;
> > > > +		atu.pci_addr =3D entry->res->start - entry->offset;
> > > > +		atu.size =3D resource_size(entry->res);
> > > > +
> > > > +		ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > >  		if (ret) {
> > > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > >  				entry->res);
> > > > @@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_=
rp *pp)
> > > >
> > > >  	if (pp->io_size) {
> > > >  		if (pci->num_ob_windows > ++i) {
> > > > -			ret =3D dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> > > > -							pp->io_base,
> > > > -							pp->io_bus_addr,
> > > > -							pp->io_size);
> > > > +			atu.index =3D i;
> > > > +			atu.type =3D PCIE_ATU_TYPE_IO;
> > > > +			atu.cpu_addr =3D pp->io_base;
> > > > +			atu.pci_addr =3D pp->io_bus_addr;
> > > > +			atu.size =3D pp->io_size;
> > > > +
> > > > +			ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> > > >  			if (ret) {
> > > >  				dev_err(pci->dev, "Failed to set IO range %pr\n",
> > > >  					entry->res);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers=
/pci/controller/dwc/pcie-designware.c
> > > > index 2459f2a61b9b..49b785509576 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val=
)
> > > >  	return val | PCIE_ATU_TD;
> > > >  }
> > > >
> > > > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 fun=
c_no,
> > > > -				       int index, int type, u64 cpu_addr,
> > > > -				       u64 pci_addr, u64 size)
> > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > +			      const struct dw_pcie_ob_atu_cfg *atu)
> > > >  {
> > > > +	u64 cpu_addr =3D atu->cpu_addr;
> > > >  	u32 retries, val;
> > > >  	u64 limit_addr;
> > > >
> > > >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > > >  		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > > >
> > > > -	limit_addr =3D cpu_addr + size - 1;
> > > > +	limit_addr =3D cpu_addr + atu->size - 1;
> > > >
> > > >  	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->regi=
on_limit) ||
> > > >  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > > > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) =
{
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > > >  			      lower_32_bits(cpu_addr));
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > > >  			      upper_32_bits(cpu_addr));
> > > >
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> > > >  			      lower_32_bits(limit_addr));
> > > >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > > > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > > > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> > > >  				      upper_32_bits(limit_addr));
> > > >
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > > > -			      lower_32_bits(pci_addr));
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > > > -			      upper_32_bits(pci_addr));
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > > > +			      lower_32_bits(atu->pci_addr));
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > > > +			      upper_32_bits(atu->pci_addr));
> > > >
> > > > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > > > +	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > > >  	    dw_pcie_ver_is_ge(pci, 460A))
> > > >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> > > >  	if (dw_pcie_ver_is(pci, 490A))
> > > >  		val =3D dw_pcie_enable_ecrc(val);
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val=
);
> > > >
> > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU=
_ENABLE);
> > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCI=
E_ATU_ENABLE);
> > > >
> > > >  	/*
> > > >  	 * Make sure ATU enable takes effect before any subsequent config
> > > >  	 * and I/O accesses.
> > > >  	 */
> > > >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries=
++) {
> > > > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > > > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CT=
RL2);
> > > >  		if (val & PCIE_ATU_ENABLE)
> > > >  			return 0;
> > > >
> > > > @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct =
dw_pcie *pci, u8 func_no,
> > > >  	return -ETIMEDOUT;
> > > >  }
> > > >
> > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int =
type,
> > > > -			      u64 cpu_addr, u64 pci_addr, u64 size)
> > > > -{
> > > > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > > > -					   cpu_addr, pci_addr, size);
> > > > -}
> > > > -
> > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, =
int index,
> > > > -				 int type, u64 cpu_addr, u64 pci_addr,
> > > > -				 u64 size)
> > > > -{
> > > > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > > > -					   cpu_addr, pci_addr, size);
> > > > -}
> > > > -
> > > >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 in=
dex, u32 reg)
> > > >  {
> > > >  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg)=
;
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers=
/pci/controller/dwc/pcie-designware.h
> > > > index 3c06e025c905..85de0d8346fa 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > > >  	DW_PCIE_NUM_CORE_RSTS
> > > >  };
> > > >
> > > > +struct dw_pcie_ob_atu_cfg {
> > > > +	int index;
> > > > +	int type;
> > > > +	u8 func_no;
> > > > +	u64 cpu_addr;
> > > > +	u64 pci_addr;
> > > > +	u64 size;
> > > > +};
> > > > +
> > > >  struct dw_pcie_host_ops {
> > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u=
32 reg, size_t size, u32 val);
> > > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int =
type,
> > > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, =
int index,
> > > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int t=
ype,
> > > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, i=
nt index,
> > > > --
> > > > 2.25.1
> > > >
