Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6064CCFE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiLNPY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 10:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiLNPY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 10:24:26 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8B186FD;
        Wed, 14 Dec 2022 07:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGvaZZQucyxlULYS1FeHZyhQ4GnBymgkp9qVRTx0LrpWPVDNHDWp+b4QAyEb/1Yk8YBLqMYLNsxhA4imIlJq1NLosJshXjOdM/uW910LmGDPrPeuRzaLOT5Nju+Lntd7+Q7Y+OJF40q8iffNq2X5rBK7o+bmQ4kInnX5ZbNt3g5PMbiP0xNcxsWuAm5k6+3drYqsB0Wza8x/czEInpQVMEtvEm3t2mY92mtqv8nhLJpwpkPBWXnaLdVYrVS9tlDllU2AktVkFBYWSBK3SUsQYH9kXPnvEZ5VzOLyWvZK+BnxChjfOIDuY87m9F4KVMqtkCCGCi4ClA5UJRZHn8f+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLOdH03f7PbDlPCuLthfbo86dDF7zjtMNZY8BLcLZP4=;
 b=m1r+hQNkHO8ymBc2moZFWuv4v5arBzpJ+faDHRadYa4GFSBhjOo98eWXwG0oVkVaK3+425kgc6vgiXzAzK+xUHZhs7jvcaotAT6NHv1O5YKSFKnStBKKkHkT+PbNfmmXjp89zs2WDfvFJFLw+NLIqjNWKRI6dRH+DP2as9v+aDp2ifb3NlccoMSTDfamneh62FQH2ApBE2sRMYkR91XG/ZB2757Lq6xH658bNQyLypvlqNfm8KhocMpyeGrisMRJFKR/yQ4JjuWv8uOouLvRt45gGsK0jqKBBbSxkCgXfZfrZboVFAuZkphOYLRX6cK3H7jbozNNedQzk5VJn7e6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLOdH03f7PbDlPCuLthfbo86dDF7zjtMNZY8BLcLZP4=;
 b=ePcfgEBRBvSrfnM7GLMEXZbqj30+dysh5viBkUAnhhX57s3gvhgAUPepuaIrUnDC1NM6OZ/L7CoqCbtzRFqFy9mzGb9GFuB+kQxQpZkt8Zk0AeshhcFGKG4jMi/HNZYck0RBXuDaxLHz9Rc7/YqGDV5oqY4ZvEzYfY3rSO3/nBk=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 14 Dec
 2022 15:24:22 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 15:24:21 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix sparse
 build warning at ntb->reg
Thread-Topic: [EXT] Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix
 sparse build warning at ntb->reg
Thread-Index: AQHY7sTvWWy/9/FSxESkmjmsd2hT965sx/AAgADxRyA=
Date:   Wed, 14 Dec 2022 15:24:21 +0000
Message-ID: <HE1PR0401MB23316D6F7080B36209689EC588E09@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221102141014.1025893-8-Frank.Li@nxp.com>
 <20221214002642.GA216337@bhelgaas>
In-Reply-To: <20221214002642.GA216337@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PR3PR04MB7452:EE_
x-ms-office365-filtering-correlation-id: 57485ce8-5017-48f1-8cbb-08dadde7469b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSVkT7TPRZ/YhXKsxMJJZmI+OBu1qOG+SUuQ9DwG1TGMcKlFkbJ9LGkEGhO/8k4Zf3hX1f5bKWC4jaXg67RX8NecAYjhx4M4uOwN5Xf48pKnAk4+tF7Swh/obXnDAhBMmgactoaQZ7L3ObYE/0a3xeIrm0rFUeqXoQwIUU95G9WYSaxP+tTlcySyKfhukNtbIVZn0/Ihu5EVehpKNrb/O8RZogCqI3YQgiJOFPA79I930n68ZeytABvzbCqr4EvLvRWF0YfohtiyIAwEPCrahNk8fXjyh4b2vGnGPoaiaiL8aFdyjMx2d5pm5T02DXxoeA/RkKkcZxeonwHSFTFMsqsu31iNmy8APNCtLYaZwwLzzUg6+1r8humVkzPjRkraSuNHAoou2p/7nPxs64Li6UY/lTxSHasFiPAz29Wii2+DCr4Bbd7AZWOX3ocEzmb1CjyhwIDNlIFibCnt3HKyhyhEEogIO7El/Q+A8RqhSaPbAgeuFMPolnAEcUoGF/ABGZylANxYFXjvmGUiauBQ6fsP9PpjLX4PKS5IuwnvV2fK3T4c1GOkztFELoVM6CEF2iXXOzysHRG3uYV43yzCieYPhRo9FmCdUY9BgEWbggLdoL382jIE6peg5erGQ/xF8xRfqbC+z4nimGmH9qXMzyYeVeKbTraKFctcJKAi/4bBzw/lpAJgwMuI9b4fLbchdTyrBJ8ifsETC0qjMRuBRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(54906003)(316002)(64756008)(66446008)(66476007)(41300700001)(66556008)(8936002)(4326008)(76116006)(8676002)(66946007)(71200400001)(6916009)(52536014)(55016003)(33656002)(2906002)(7416002)(5660300002)(44832011)(86362001)(38070700005)(83380400001)(6506007)(122000001)(186003)(9686003)(478600001)(53546011)(38100700002)(55236004)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZYIXoe9QStIEfae+bDyFrIM5txCUSK6I0lw1Zvqb6h3rZ2KvWPJhAuvcyfo?=
 =?us-ascii?Q?iAfiJPawbTRyYvJaYlv96YYBrFENERQmJeE5TwoVBKESw9kwZpNsM28XuADa?=
 =?us-ascii?Q?A0QjzyZOSEWNni8oWhAUOptK2vnu9rtd4b14FUkXR3WWDiXpgOiI+j1bBsE9?=
 =?us-ascii?Q?8qMkwbVUE97RYVW0yKS0EZOys1JLpIKOpDlLrHmeW2JxWhx9Ggdap5B4+aU7?=
 =?us-ascii?Q?C2YAZAmry3zhPcJLbcxeIBaoCseeV2dX5AJomHjB3WEljaQZpUZ5jAyk4Qf/?=
 =?us-ascii?Q?RlXhCLDIKdlwpdkFS+J7xfUEJUgyMix3QuYHTurtnpOltMEA2w8eQMEUFFKn?=
 =?us-ascii?Q?T9kIckN0hY+iHIM6E/JSDjqHa3bmmeGQJNqFpErURfQZ95tTDBWUIqkO05Bo?=
 =?us-ascii?Q?c3wZfFIeYUFoieOVM65XP+36ZIjoRAT4dNuuFCwlt2XNjq2+nCF26MzB7W7a?=
 =?us-ascii?Q?yzVuZgMp8g3+MApl6MCOMjLprohre7HTEtXaWAfJkph18jvxptERjdHZV3km?=
 =?us-ascii?Q?ZM5CZBiW0d+ixwaqTyf4caL+6HDyfZ3vwaQcJ3wqei0dIWlFFIpBxsqrOrbL?=
 =?us-ascii?Q?z2QUSdNA7YFbgywavbZ4LuAUKFqcpKe9OtxtYyhGcVbATF4xUOjIu6F2Cxlv?=
 =?us-ascii?Q?GpvOAGXWE8/VM1aQaHaK3YE/3x6BlZkI2WRHuYYqhfm193mUJawk0pv20yCj?=
 =?us-ascii?Q?9mKymJHiZD50Gn8vew4FlOXQxFCfSjMedXNjTA/ladSVyk7mOAx+NatpF31A?=
 =?us-ascii?Q?L6AOp+VWmTEStCd5tMtegQeSJWJmnJS1Ttzy9YBfrrubLEZlSaYXPsJHUFj3?=
 =?us-ascii?Q?qSswagGaS8h8h95syd0J4wtxDr+VagMkLLUTK+6SMj0xr5cuh9MTnNdy4hSl?=
 =?us-ascii?Q?Wxj92L+rlWI/+652KDADepQkfZc1yAgCHHyemNiL0pSbseN2+54+mXfJrmUe?=
 =?us-ascii?Q?2O9GNSTxIKIW//wWpb0T5TuMCU87V2UXkdQWEI20j4X9MZciWX7plRvbpZ7l?=
 =?us-ascii?Q?laDL/cQwfKpI7OfG164a1LPKWdnwSTob8fpqeL/0r+8Q75RcCs0m1adyvoPi?=
 =?us-ascii?Q?U5uBPbcwRP+ky6couk7zRElexTD4wlZSSO4839jCn59RX2a3Osy9w0fqFfDr?=
 =?us-ascii?Q?Xn3k8SKLW3D00djVL038GyZnyl21O/JrIPBOmMuzHsKHAYxQ8DAgJ3TroEba?=
 =?us-ascii?Q?lNBbsCMAL3UjdDW/ZGtwGOkV5Hu61gWyaa/ANCzTIT5lFPzpghefNnQ2X/8Z?=
 =?us-ascii?Q?PSZAUj/TvR8yAT9YRR+soSnFE9jmZ4eHPJyuwxelkcMh8BgGfW0StgyYlB8R?=
 =?us-ascii?Q?DVToZqvvyJP+fgIxSwJ/Eg6WgV0rsFA2CrOZkEPy/QNrHfsvyNhbAP7ku9Ie?=
 =?us-ascii?Q?vRZYEsyXpNwaNv3rc7zlomAAaNGrGGm3oXDkSIoUj8xNPpscjrrkd9xmHUwa?=
 =?us-ascii?Q?soqa41f6zCdgYrx6gtHtyCkGbb4rlbhyVE5Vs2MwIlXK0KdoLqyNBsXcfiwi?=
 =?us-ascii?Q?R7iorUd5g/Wc2ygDWxIZ1tSUA4rSbT1NdmdB14BC0fxsq5KRMlXNq98r28uM?=
 =?us-ascii?Q?UYbH0/Y8ztJW9CCJXT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57485ce8-5017-48f1-8cbb-08dadde7469b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 15:24:21.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soI8648q2x7xSdqQdOj31m0EjJ7UO/IShzlg4VBM7FMk/C4Mo9fDWa3a6WGiTLZe87/z9+naYp+Wq17X8JQO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452
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
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, December 13, 2022 6:27 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> dave.jiang@intel.com; imx@lists.linux.dev; jdmason@kudzu.us;
> kw@linux.com; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> lpieralisi@kernel.org; ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix spars=
e
> build warning at ntb->reg
>=20
> Caution: EXT Email
>=20
> On Wed, Nov 02, 2022 at 10:10:14AM -0400, Frank Li wrote:
> > From: Frank Li <frank.li@nxp.com>
> >
> >   pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem
> *base
> >   pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg
> >
> > Add __iomem type convert in vntb_epf_peer_spad_read() and
> > vntb_epf_peer_spad_write().
>=20
> I don't understand all the bits and pieces here, but I'm a little
> dubious about adding all these "(void __iomem *)"casts.  There are
> very few of them in drivers/pci/, and I doubt this driver is so unique
> that it needs them.
>=20
> > @@ -1121,7 +1121,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev
> *ndev, int idx)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count *
> sizeof(u32);
> >       u32 val;
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       val =3D readl(base + off + ct + idx * sizeof(u32));
> >       return val;
> > @@ -1132,7 +1132,7 @@ static int vntb_epf_spad_write(struct ntb_dev
> *ndev, int idx, u32 val)
> >       struct epf_ntb *ntb =3D ntb_ndev(ndev);
> >       struct epf_ntb_ctrl *ctrl =3D ntb->reg;
> >       int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u=
32);
> > -     void __iomem *base =3D ntb->reg;
> > +     void __iomem *base =3D (void __iomem *)ntb->reg;
> >
> >       writel(val, base + off + ct + idx * sizeof(u32));
>=20
> These things look gratuitously different to begin with:
>=20
>   int off =3D ntb->reg->spad_offset, ct =3D ntb->reg->spad_count * sizeof=
(u32);
>   int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u32);
>=20
> They're doing the same thing, and they should do it the same way.
>=20
> Since db_data[] and db_offset[] are never referenced except to be
> initialized to zero,

Db_data and db_offset map to PCI host bar0,  so PCI host will read it.
It is generally used as MSI physical address and data, which PCI host
do doorbell by write these. I have followed patch, which under review.
Irq MSI platform msi change lots, I need more time to study such change.

Default use software polling.  Even though it is zero, pci host driver stil=
l use it
to calculate doorbell register offset.   =20

> I'm guessing the point of vntb_epf_spad_read()
> and vntb_epf_spad_write() is to read/write things in those arrays?

No, it is separated region.=20

>=20
> You access other things in ntb->reg directly by dereferencing a
> pointer, e.g.,
>=20
>   ntb->reg->link_status |=3D LINK_STATUS_UP;
>   addr =3D ntb->reg->addr;
>   ctrl->command_status =3D COMMAND_STATUS_OK;
>=20
> Why don't you just compute the appropriate *index* and access the
> array directly instead of using readl() and writel()?

Good question.=20
NTB transfer layer treat it as register, so it need keep write\read order.=
=20
1. write data to buffer,
2. update header point.=20

1 and 2 must be keep order.  NTB transfer layer have not added memory
barrier. Need use writel to guarantee order.=20

About ntb->reg,  actually I think it should use readl also,  but I port the=
se code
from pci_epf_ntb.c and pci_epf_test.c.

PCI host side use writel, so write is ordered.=20

But I think reg->* 's order can't be guaranteed at ARM platform.   Reg->add=
r may
get order value when check reg->command.=20

At least a rmb() need after reg->command.  This code are almost run once at
Begging,  so no problem happen.=20

>=20
> Bjorn
