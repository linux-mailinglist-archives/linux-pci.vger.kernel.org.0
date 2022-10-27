Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A660FA61
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiJ0O1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiJ0O1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 10:27:44 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D391805B7;
        Thu, 27 Oct 2022 07:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCwUDsZDaVg+OK7bwUH7fKnUrwmCtZxiSTVXsVe30sEo3OTtkD+1iZWZaBkWqN4l10if5gxTJW2XAV7yFp7CfAyqmYjBTxvXxt5unqRK4En1cdlJN154mvj3BDmxDUTJ5Ki2MBVlBSyeA0fdNXUUrOJyznfDpRigoRK5jqMQj0j/OBglwRdEpCxfLxLc5gWbKuIKHYLR8EbMQJ8xTiNwjmJtxM3tzvR0n5G4HYiC2Jd9FoR1QSF0mewUT3iYL9319NBRU/SE/KHV4ESU7tyA4jN3SQRj6bxIYcXdfqVbKr6Emzl6mfx8HUh1lxU5mxayNTB7WcPhGK74djjHf46l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8sYciNNYgFSqkfaQH6D0qvZcS0AZoWpHTEiWlfjctQ=;
 b=K0d5IxalGlrA2cYTOCg52+PzB7ayysoSDG60MaQmejf1zvGpprFfLR6im74t159368sRvbsyeqQig2BSJJ2wRUgSIHdQgCI4uTex0s5USQqbPKFbf6gRYQpBfMyQV6rNfD0kyVK9dd7VerZNJAN8/pJKQEjxDdC0sSn30at0gAURmVIPBrup7Xov/m+njE6A4QCPWAaRYS19RGGugXkGE4J9V9lIa8T4vPD+rdZNIGOPqprNem/LXJX0TDqGlMj281di9UWE2Oq7cep6FCwXq0UxGyVrMznr3o0ysVg2frhY3tDbEHkyPaJsWDb3HIqr6Rx72+hDlURmkmo46Fa+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8sYciNNYgFSqkfaQH6D0qvZcS0AZoWpHTEiWlfjctQ=;
 b=Bkw5qWb1lMIdmGp1h9NCJ9r/5/uWsOr/CttbS7IrKNz0ENTcZbythnxnVk83lwei4aVb2zP7HMKfBmpDPtQSrGiLLPg1f0UKFaYQ2EMyavT6q5vYOpiIgtBBZiSYpzzmzLWTlSGX6g8xl7QhvhtKI7kV3ZzK7M9VFwHW5H67HP0=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PAXPR04MB8237.eurprd04.prod.outlook.com (2603:10a6:102:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 14:27:40 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 14:27:40 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix sparse
 build warning
Thread-Topic: [EXT] Re: [PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix
 sparse build warning
Thread-Index: AQHY2oECIepfinQVPkG9I1ZysDbaAa4iLKoAgAA8ZHA=
Date:   Thu, 27 Oct 2022 14:27:39 +0000
Message-ID: <HE1PR0401MB23316F10D8535A548127D39A88339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
 <20221007191326.193079-8-Frank.Li@nxp.com> <Y1pgoPAH/BZ46gif@lpieralisi>
In-Reply-To: <Y1pgoPAH/BZ46gif@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PAXPR04MB8237:EE_
x-ms-office365-filtering-correlation-id: 1b7942d5-cfeb-4cb5-8d5e-08dab827671a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m92rGGTqReHHJGomeA+nayqNAkSUrXIe93nHI/6TytGWwmVq8s5A+itz4zmv8F0dxzsE2WFXN1EyrP9STv6DOqWcPZ22DF/0iT9EajIe2qv5LupF/RZiOUQZhKDrVL9ezZiaObONV7VizgQUEKzpPFeSoFUKe3mk7hVblfIZ14CoDA3WZSf/CGuzEOIAVLJMfDtyKci8tp9MMrGUeT4tR3q7en+auWFagekVkHUde3JayBqlxVAx0vfe+zozAn4jJ+8xvGoDTGqONfe8BaCu2QIDwHOg5hmgyigRzwaHYfR600UqIb/vKXmp/dIJ3ZYfuzpLGHEFclvlE2WkDZ2oCJf6l8B4sNwC4V1qZzlb7NbCjJOv2p1+aoh6AW5UMklF0dMpXPT0VpK9p+j4W20FoFU5HPhTJn0yVWbovSBXjU1GYVHngDDX90dGENNWfUV5mi0hRmlLJZW0LNePpdxmnTKgy2KhRrFyuiIwEU1exKWDs93yhB29KmLzfy5CpPRCyVpebqf8KyH82BRoaqEsx5Gn7lKTiKH7chezbOHd2x3n4iv07MgkPBG+R/NRlKTXq7evid+udBk50yMDw3LX20PZLLltrHu+7PtylWDWmz+4AXY1fNMZ4cES168HWXnF/JrN3BROgKsIikePUFTDr0va1wtDY+TDRBU6wqLJsUSYOj7iu49jkWZ7nYOd+nz+0CVQw6mWgA5pI8g6m/qmDC36MYhiY8E/WHzD+sdfJhkZezrMf077SiWui7z+Y9vI9ps3oNHc2OQI+rKbNgsM9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(2906002)(8936002)(8676002)(33656002)(54906003)(6916009)(44832011)(52536014)(55236004)(5660300002)(41300700001)(55016003)(66574015)(64756008)(66446008)(66556008)(66946007)(4326008)(66476007)(86362001)(76116006)(7416002)(316002)(83380400001)(38070700005)(186003)(38100700002)(478600001)(71200400001)(26005)(9686003)(122000001)(53546011)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Suuo5jYQjPLg6xWnDlwaWS0wYDZijkNLkziN6SWGy7rIshW3rDWrt/ZBUA?=
 =?iso-8859-2?Q?84lbScLTQnje2vQLHzpuVWSeQm79OIXExpcnQXFwI9hCsP/t3KUOpvk4zG?=
 =?iso-8859-2?Q?4AQ5TmzXNoeRBEANfDfROW/q3miipl2IwOIUWdrMc7kZgOy5H0WjCXJ99C?=
 =?iso-8859-2?Q?hiYK5MvJPBuapKp+lFuN1F8kjQT22Kii9iB2n7vnUhZA9hLe17pug2Fhgl?=
 =?iso-8859-2?Q?Soz8v8RlXAMEVjJbLiihM8iAeiSTy9vq1VEObzKn1xtskKEq4+BTjQhPgF?=
 =?iso-8859-2?Q?aXZkC/l91UtOyXR7nj3VqzxhQBSFYF4N2ccxXjFxog1zrGGRdAbX/6c+NL?=
 =?iso-8859-2?Q?/awVe5X0mR0MDPK5yyOpzDaj06YLc1dXxQUsqxiZtLxgRuw+i6vH6KcH3R?=
 =?iso-8859-2?Q?yZOuYmWGhUtsBd7SUqN6iRpMKj33fXIdko8u9VtA9Gq4cmVrwaEw6cbuR+?=
 =?iso-8859-2?Q?oFe4l1Xof1i+efgJj2NHp6/3F2FbI0jncAUWbrTt1yhxJV1QOmvFL1mANL?=
 =?iso-8859-2?Q?GDDvhtN/VaxKOBCRkEOdS62b9aTvoqXTy5X9EC+Ik+zpqPRged3wzNm6Ke?=
 =?iso-8859-2?Q?vNhNgwAU8WfGuaZDv7N+XB9EutmYLx6GNBX+0gUM9VvWDiBoi6VTzV9IGa?=
 =?iso-8859-2?Q?DO615nXHDlhhvfEWkR4ARb0U+twNp6WFbQwAj3//Uk3S/812NgKeAbWYse?=
 =?iso-8859-2?Q?3I5IPxTzuKyXavWOnYEA5omfhf2yB7/92AEN/z8Y1OtDMrrIhUlB1I4XwQ?=
 =?iso-8859-2?Q?KTMfWX15KKsD29c69IitGjlh5dGPIMluE2RlUSVQuOmoargWxQWK4jSHvy?=
 =?iso-8859-2?Q?cEJMGTQUON2SFHOCafEcBM10liRJGSFW90sXtRYNsF8A7KZCurDOGQWkNV?=
 =?iso-8859-2?Q?4oFDO7tM5KKnou5EnWNL3b+xgk25W+UQDoJpi1stZu39X1NadJkA6W0X5G?=
 =?iso-8859-2?Q?q8zPj1otOAx7LKamIhMkSSPfE0Qxf8qcWIKQ+PeynpJPSNT8Csb++LAk+A?=
 =?iso-8859-2?Q?ciAEe6+DCUO0fbMypbIhbDZCUMLSWVsnE50cbhHGNVY+RQzBRXUMTnaZx1?=
 =?iso-8859-2?Q?jLEhbDupDeRko0F0lHJ92vg01ClrbD1LEgIu7I4hlUQqEK0oWTPZFVSElr?=
 =?iso-8859-2?Q?Cdq9xV2SXhzcl/xxUiyzU/M9t3CyYe9wWMZocv04ERL3LzrNFJiEZXCq3D?=
 =?iso-8859-2?Q?yWLoyqeFonVozB3bmV9tag3ERjjDAueymc+exTLxwopuihG99cyL3/gzSY?=
 =?iso-8859-2?Q?GacsRNgzJBhBjCL6uiFv7ZKTryWqNzhk+lDAQ1Opii+Jyn/nA6MNy8ngUn?=
 =?iso-8859-2?Q?KWAcZZjyAgUacmKnyqCsM1lzLNjKvvqaThBgMOmCRrKhLlnfaD4TCl/u1T?=
 =?iso-8859-2?Q?JPkkQ3FTsRw53PSTNibDISFqrtps+BSVst/BY/SMTUnfI7lvcPb1WJPqni?=
 =?iso-8859-2?Q?7AQQofUDgdY91Og2iMOk7p6TByhXZDqTbG+DN2ak0Z2Xvao4SZijm08vmB?=
 =?iso-8859-2?Q?+D9o3UkBv13J5hnJM6djXXD1d0IxOlPa57Mfg+DIqBBJaaxxn1ZERJ7RxF?=
 =?iso-8859-2?Q?vUI2EXTlfhcW6lNdlGktTttJlNqSxLH2H1ayUz7nwnsmTqO9qxMv1Bn8QU?=
 =?iso-8859-2?Q?9sf8tvdRZXwj8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7942d5-cfeb-4cb5-8d5e-08dab827671a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 14:27:39.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /F3rdpWgGJDE7+5yRVbqarDvnwrgdt8+WoGNinSdC1awJJUoio4Im7PMHQZmSNCu92YxTtMtuozJhPsps2vmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Sent: Thursday, October 27, 2022 5:43 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: imx@lists.linux.dev; Jon Mason <jdmason@kudzu.us>; Dave Jiang
> <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>; Kishon Vijay
> Abraham I <kishon@ti.com>; Krzysztof Wilczy=F1ski <kw@linux.com>;
> Manivannan Sadhasivam <mani@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; open list:NTB DRIVER CORE <ntb@lists.linux.dev>;
> open list:PCI ENDPOINT SUBSYSTEM <linux-pci@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>
> Subject: [EXT] Re: [PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix spars=
e
> build warning
>=20
> Caution: EXT Email
>=20
> On Fri, Oct 07, 2022 at 03:13:26PM -0400, Frank Li wrote:
> > From: Frank Li <frank.li@nxp.com>
> >
> > Using  epf_db[i] instead of readl() because epf_db is located in local
> > memory and allocated by dma_alloc_coherent().
> >
> > Sparse build warning when there are not __iomem at readl().
> > Added __iomem force type convert in vntb_epf_peer_spad_read\write()
> > and vntb_epf_spad_read\write(). This require strong order at read and
> > write.
>=20
> This commit log is unreadable sorry and this patch fixes multiple things
> and even rearrange local variables in a way that is completely
> unrelated to the patch aim itself.

[Frank Li] Not everyone is English native speaker.  If you think it is bad,=
=20
Please give me what you want to change to?=20

Abut rearrange local variable, It is my fault when split patch.=20

>=20
> If you are fixing sparse warning reports the warnings and fix them
> one by one.

[Frank Li] Error in vntb_epf_peer_spad_write is the same as vntb_epf_peer_s=
pad_read
All are the same type error. Did you still prefer fixed one by one?=20

>=20
> Could you please pay attention to these details ? I don't have time
> to do it for you, sorry.

[Frank Li] Do you have other comments about other patches?=20

>=20
> Thanks,
> Lorenzo
>=20
> > Signed-off-by: Frank Li <frank.li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 27 +++++++++----------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 54616281da9e..9f1ec6788e51 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -136,7 +136,7 @@ struct epf_ntb {
> >
> >       struct epf_ntb_ctrl *reg;
> >
> > -     void __iomem *epf_db;
> > +     u32 *epf_db;
> >
> >       phys_addr_t vpci_mw_phy[MAX_MW];
> >       void __iomem *vpci_mw_addr[MAX_MW];
> > @@ -257,12 +257,9 @@ static void epf_ntb_cmd_handler(struct
> work_struct *work)
> >       ntb =3D container_of(work, struct epf_ntb, cmd_handler.work);
> >
> >       for (i =3D 1; i < ntb->db_count; i++) {
> > -             if (readl(ntb->epf_db + i * sizeof(u32))) {
> > -                     if (readl(ntb->epf_db + i * sizeof(u32)))
> > -                             ntb->db |=3D 1 << (i - 1);
> > -
> > +             if (ntb->epf_db[i]) {
> >                       ntb_db_event(&ntb->ntb, i);
> > -                     writel(0, ntb->epf_db + i * sizeof(u32));
> > +                     ntb->epf_db[i] =3D 0;
> >               }
> >       }
> >
> > @@ -529,13 +526,15 @@ static int epf_ntb_configure_interrupt(struct
> epf_ntb *ntb)
> >  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> >  {
> >       const struct pci_epc_features *epc_features;
> > -     u32 align;
> >       struct device *dev =3D &ntb->epf->dev;
> > -     int ret;
> >       struct pci_epf_bar *epf_bar;
> > -     void __iomem *mw_addr;
> >       enum pci_barno barno;
> > -     size_t size =3D sizeof(u32) * ntb->db_count;
> > +     void *mw_addr;
> > +     size_t size;
> > +     u32 align;
> > +     int ret;
> > +
> > +     size =3D sizeof(u32) * ntb->db_count;
> >
> >       epc_features =3D pci_epc_get_features(ntb->epf->epc,
> >                                           ntb->epf->func_no,
> > @@ -1123,7 +1122,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev
> *ndev, int idx)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * =
sizeof(u32);
> >       u32 val;
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       val =3D readl(base + off + ct + idx * sizeof(u32));
> >       return val;
> > @@ -1134,7 +1133,7 @@ static int vntb_epf_spad_write(struct ntb_dev
> *ndev, int idx, u32 val)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> >       int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u=
32);
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       writel(val, base + off + ct + idx * sizeof(u32));
> >       return 0;
> > @@ -1145,7 +1144,7 @@ static u32 vntb_epf_peer_spad_read(struct
> ntb_dev *ndev, int pidx, int idx)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> >       int off =3D ctrl->spad_offset;
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >       u32 val;
> >
> >       val =3D readl(base + off + idx * sizeof(u32));
> > @@ -1157,7 +1156,7 @@ static int vntb_epf_peer_spad_write(struct
> ntb_dev *ndev, int pidx, int idx, u32
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> >       int off =3D ctrl->spad_offset;
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       writel(val, base + off + idx * sizeof(u32));
> >       return 0;
> > --
> > 2.34.1
> >
