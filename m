Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436C4768990
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGaBYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaBYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:24:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2121.outbound.protection.outlook.com [40.107.114.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA60E7F;
        Sun, 30 Jul 2023 18:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVO6LXiehVZtlqWFGfKuAwwVQ8Ry/qCVzP8rSyVoxWWtMqm+D/70OjUK1CgwG5j6gywYWMrlV/TjL59x7dFY9L+tErdQvNka9gKUPtZUUlT+y3r99VBTjbSkvu8ld56zlZKLGAHcEh5rVQS0zh/cWSS297UPrTQ1RAi0jDFR1gXru/f9LrBGferZmWkUrXR5Vk5un/L66wMdJY3PzQt2fbX1aNjRN5mdSYjodEBevyym3vzixHZJJrQxnKXWBGdvQrsTJ29xFZ3gNwf0vvfbI04Y8jynE/7ypX/duCPbcJQtYJS/z63t7tJAzOz03ZUU4CVvEkUICmIX2bgN2dssZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vpZ1jEMM+ag5wN0gH13VMurspaTPypYQCdJGlItHVw=;
 b=GPzHK2Mv/pMErSmR/vHZRrW1RLER8Jn4dUhA5sXbIVIRQdG0GV75Fos76xkN2j7/V0qSBop88aeNJ6Bt4C5dP+2DykLNF+iA5RUft8VcLWpTbAyRQ2SAlzKJuHQC9E2/wLdmh5codJlmbgabyOxfOKeYvIyYLa4yXf/dV/bpCgaduReAaEEXpTZinauAaPBk9x134iYxWDjwdbI/nbGX+1haiQpEVnNCZihP2KTca9PzNFItpjB7g5NYEcqRvZ2ir5ejzw2Iw52zPUDPs3IClmzKsoO4yfNCY56e08zbRXs68UB53vv3Gcw73saAaIl8GwyOBLJhra1c2covErSMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vpZ1jEMM+ag5wN0gH13VMurspaTPypYQCdJGlItHVw=;
 b=k/JNuYFIfe6Hq7oBqPvc+tSknw3Ma3ny+g7NDVLRA4Hqu4DhpDRJwfc9OnCQ7W+0bp7YSPe3Du29kz1W4LCAKVfeP/+p9bhMKRM8dp9sHe/i+pdd1GoC9+QHx7kiplQyJ4UvIa9ZlPSp/3w6gvwra6e6ENOS7Lx1t5h+xcs6ijE=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYCPR01MB11708.jpnprd01.prod.outlook.com (2603:1096:400:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 01:24:28 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:24:27 +0000
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
Thread-Index: AQHZu6dDb7hFhSogz0udklVWjO2cJ6/QC08AgAMXU6A=
Date:   Mon, 31 Jul 2023 01:24:27 +0000
Message-ID: <OSYPR01MB5334EBCD11ED8D3104A0BEFBD805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <u2lzrypnaevcp5r5xueeceoq6b5v6ngzdmwyadel2liloxb3rz@6ribp2lqv2db>
In-Reply-To: <u2lzrypnaevcp5r5xueeceoq6b5v6ngzdmwyadel2liloxb3rz@6ribp2lqv2db>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYCPR01MB11708:EE_
x-ms-office365-filtering-correlation-id: 65d06969-9766-4f91-e0dd-08db9164e218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXDtvNKtziwauPe9HWdztSr3h8L/RImCRvNUfZgNDWwn0AVToQJAr0YXfWOkCy9m8EOifEcReFFZ7f3oqLVHMKfiL3OvOKpDPOpW/umxC+bNde/ViUwJGWqsb6XjjKr6Gq0nBN7WM4JLDj1uio9z0IYR/H4SkBlQ++FGJ9ijZgFz82B/YGfaRRhZiw4O+Y5KibLauh9gsflwrIXHgyxhOpIqHWRwZ26alxvc+lZkIFKA9VII3WsTyxYpjH5epIz/bkIErkOQEIvsJI46b2sw78Fe7etnJwOVZMCIDXuG671JKTdNpZKOfri6wzXxIQvrCjhiIT13uIWPhJqRTPpdAPh/GuyF2f6VesDq4TbMQYhDqaw52J2idFvkDmeYCAjKRB+V69hddWhRasDcJBJ1C8Yv3M+jEfGAvARdRSkLPGL60lwXtkiMOjAJ7YKBrrsZ4Kzh09jpUtGDdHLHuHkhVaA/PbJKTTxJ09ogwcbuDEvM1HPu90ZV1xTiXearuXmjiXbgUvkgRAger7qQ6qDV1EGdgsQdi7UzGPlAVFsFGrmNHcWO8Bwi6u2XDsOgOqa3vqkJ2QjrraE+K24MM/WeaWq3vLQ1eSUo9PMdO2zZeyRCofYY8L9bJk0pNQHDLnIF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(4326008)(5660300002)(6916009)(66446008)(64756008)(7416002)(122000001)(38070700005)(33656002)(66946007)(52536014)(66556008)(76116006)(54906003)(478600001)(30864003)(2906002)(38100700002)(71200400001)(9686003)(7696005)(6506007)(83380400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WQCN3neQSXkOkqPVdNKpCogtwK10P29gU2dsRwi0UBfXNvQeRZkrDrzjRF9O?=
 =?us-ascii?Q?S6NdFLPOHtKj3Xr+wB3rL1bK48/PsajHRF2vC7Xx/vSgr+FLrzljUOZPPYCB?=
 =?us-ascii?Q?pbLODdB5U/cIDGaAFp5A2oJR7Bk4Tt72FIthspycWi4BEycC+Gd75Bc3T6s/?=
 =?us-ascii?Q?YH53F+z6Kc3WH/Nh1BeHgaUaNzWuStK/xi8AArA+QcybuFC475bXRpKJdDQ1?=
 =?us-ascii?Q?Ol6mTuKAMGnDblLfaI7Zwt8pWr8O68hcY4m0lXbd2M7nYdhH3P2oiGS0za+K?=
 =?us-ascii?Q?7T3Y8R7CDkbbzt8nqpC0DQ/spcKlTTQPymS+5BBGzys8dC1VLeMNvo6XM4ue?=
 =?us-ascii?Q?43b2GmHkVWdkg4QaaHbb/8h7iRA3yfUt+UKwtqu4GwGM9VEOS8Jca1C+qhk3?=
 =?us-ascii?Q?tjTc/pJlEWx2hOQWdlYAqNQgS3YohLgqTAwR4Y+lh4VPfz47cEFJU7pHtCYc?=
 =?us-ascii?Q?/kG5SDaPorLaU45uf5/I2HkDgZi8wVCi63rtEYVGlQuS99//qCGyDNi1SbDK?=
 =?us-ascii?Q?rsiz3Dq+uqyzIobZDpMw31znSiw/YJVOehmZIu0A5Pfi+pky22PwLnXVyl0K?=
 =?us-ascii?Q?B9OVoRA8PwRNjtOVj1sp4n7b2nGDwJ+AjHE+qBzAMAwuk9vfWbwheyjEMiwu?=
 =?us-ascii?Q?8VFx/m04Calh74BU+O8cil8aCB7flRQbHpSSpwfYi7jhWsX4ameOkvZeeJXo?=
 =?us-ascii?Q?h77ewTLPOhpZKZb+j0khqyJB1JS4XEPy5jrPNchva9E5fNUWKRTDjGdqY++e?=
 =?us-ascii?Q?dbtQ/oRpVOPsikcTHWcoN5TbNrIJ58YLXk5kwAfC8+QHPuK14NgXThowiU0d?=
 =?us-ascii?Q?R4MBIuBtr+OgREnads2U5DowayUfTCQoFojl86+yykJFuBiFYs8BEYWeUu7V?=
 =?us-ascii?Q?a44MUxTjkypLGxKJRWczkhqaiWMoilo9eDvNLqHXJ5soPy3cU2I+P2Rl/TLg?=
 =?us-ascii?Q?FHHSkcJoED15CDklphzplJ6H75Z1cPzlDRv1k0+i7ukRRdvBcrwH3T/1ZPtU?=
 =?us-ascii?Q?N73L4yDEzV3nFL+v4bg37Uzev6yotqFZRdVG/Ud/bQe8EINJyBgkJCpWOmy9?=
 =?us-ascii?Q?HETA8sOl+1xN++zwCHLx0Ga96iKXhPE7T9yB+jlGG8tx9J3ApEIJSiY9fLkM?=
 =?us-ascii?Q?5jGBe7ocKgzbPj55rnH0koHB25FaMinLYOhqGRpuPMnT8JAa2q9NrDgmt6Cb?=
 =?us-ascii?Q?BWs+Z0CSCE5FPx/sXCsMATTSRC6z6fc4qDsS491GSFKVZOgQ4peMcLHMAT4L?=
 =?us-ascii?Q?JoGWPhFS9QO7hSA1PyFW5VZmvsuAOrtmZHG7irdvnO50iW1YkeoLs/GOiuQW?=
 =?us-ascii?Q?KFXYQw8IPZn3MY5Y6NIQHj3FaWKPyQgbVmeKT8nFR8I/pE2B+gNmBxaSS0r5?=
 =?us-ascii?Q?q6cSX3yWAE8zwbNmV7lTGH5pCtJESepujmEBYzJCpa9Fyk4eJ8dQlVOUAooh?=
 =?us-ascii?Q?uK5RCkapQAhyqCuHTQnDYoMaixgKfgMzJOp5k8Mo22d6iCqsbSw40AGPXOgL?=
 =?us-ascii?Q?8LcavEPRoR8oeGdBvTACly8b+jjDkxyreHMS+Fav5DUQuSAJ26SO2cVXE5T9?=
 =?us-ascii?Q?08dqlwlKxhWEAdQmc9FNn7H0Y0F6TfO66kNUgWBtUn1ASiUZMy9sFUGxfeh7?=
 =?us-ascii?Q?4MOi+7C0hldVqf+CCpLWXjbGFUXIZ5RSKesaVu/gzHnY8RA3U2b1b6Pz+2zn?=
 =?us-ascii?Q?RUX7qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d06969-9766-4f91-e0dd-08db9164e218
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 01:24:27.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbldKDMzePjLGU2sU++6AosJukLEB9N7t4PXa73cq9ODbVuif5w2YEmB36cqgpkCTuc+A6po7UJkO+FMAcADP1Kk4aZBV+kV3TN2pFgeYfFfC7I17pilpMwBtysmBqVz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11708
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

> From: Serge Semin, Sent: Saturday, July 29, 2023 11:07 AM
>=20
> On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > To support INTx IRQs in the future, it requires an additional 2
> > arguments. For improved code readability, introduce the struct
> > dw_pcie_ob_atu_cfg and update the arguments of
> > dw_pcie_prog_outbound_atu().
> >
> > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > a need.
> >
> > No behavior changes.
>=20
> So you decided not to use a suggested by me in v17 more detailed patch
> log?

You're correct. I thought your suggested comments was too detailed.

Best regards,
Yoshihiro Shimoda

> C&P it here just in case if you change your mind:
>=20
> This is a preparation before adding the Msg-type outbound iATU
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
> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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
> > index 2459f2a61b9b..49b785509576 100644
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
