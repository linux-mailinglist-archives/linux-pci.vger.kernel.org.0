Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700E7468D4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 07:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGDFTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGDFTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 01:19:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0415E49;
        Mon,  3 Jul 2023 22:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB1Ndy2+xXTL1+PfwApBwHZP2mxlHyZqQ6ETXNX6F0J9ejHCfqclwCODTLMwNAfH61uiI08XBKm20NgV1G/jk8QXzL+FT+bKaTDZ0FlBByvS8yQod68gaIJSH+JBE7g2ZH+9mPfwP1GwPkp8Cg2+TECeTaEDneuS1q82nwLhchvQfH5/JHbZLczg55c6uTUNOlkm2iasAcui160crSwk0m9oinBaMRNTwMu4S1ItN7Yqos9v0GDGgP7Y/74eGz137Oe17oFLd1qNgC0WVoJy/7+m2c7Bl3lL4QZS+beztcx0zYjxI27xg9pYrRt0HynlTu6q8MTkxIB0IfmxrqDvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thofb09QBFRdr4kuGNZ9JSKqyZah2Nacu5aGs858X+o=;
 b=RbYZgQPK+n4rWUj6Iu05kC4KFkFz6TGmJGFQLEevCLXZbrTUT9aevOov41fG9gIbcNm6HqWAc9NZCz2/HS9cqncnxlnTGU9JAxDTA3mOD8FY/urjGtp+hTtyTY9OFJfv25dfnXXbqetdavI3dLl5D7zmMtXTS58vFibT4FxDbpSqwQa+jn0xGt3KMjAWfswts88CksgaNjDhqG+VjLVddCCsv8d+obe05ZJED2jEOsKAGcxbykRe37cYa8v84rANiUnVSZ1HeTU8qBnVROJDjfKNW5wGUgysafUYlaEr+57uVLwRKhxS/qpbBp5+rvAmI3d3Xq1qOUzVgobOj3aiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thofb09QBFRdr4kuGNZ9JSKqyZah2Nacu5aGs858X+o=;
 b=FME+1iJVVvrjm+SlhZ2BpVtvObIHdZNo7AKA064083844iiD2nXjAPtCtqSTxthoohKFF6HcauY+hsLKS6OyLMi6xlg7n+2nn3IIP9c+tI/09eMb4TO1a5am1xNtndZl+5y8c1HT5lQoYTSaEUX3prHVZ9tU6v/vfqsW1rdcESs=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TY3PR01MB10142.jpnprd01.prod.outlook.com (2603:1096:400:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 05:18:55 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::3b0c:473f:654a:ac11]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::3b0c:473f:654a:ac11%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 05:18:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 06/22] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v16 06/22] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZgwfRfxWX2cgsBE6/y21tfJwgKK97ejKAgC3tONA=
Date:   Tue, 4 Jul 2023 05:18:54 +0000
Message-ID: <OSYPR01MB5334B87E07C475E4C9E76CD3D82EA@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-7-yoshihiro.shimoda.uh@renesas.com>
 <20230604235607.nyiy4ghk3idgsd7u@mobilestation>
In-Reply-To: <20230604235607.nyiy4ghk3idgsd7u@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TY3PR01MB10142:EE_
x-ms-office365-filtering-correlation-id: 82ff5958-a319-4767-ba26-08db7c4e298c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAiB62OOEHW8dPR+lt0D6rsEH5FZ/Q+kA6wNNOXA/Y2wXQkxxZw+DA3puEmhgrm79N94xSRPYYQhvu/YNE6lx+TDN5lD5M+TK3Vav/F27uK103SZ8Ydl7yXuYRo/T2spBnPdJlfEki/B5ThnqLauTWaGICZmjsJeGyNWqKHDD3g1hjWU9pHbBTYKr9Cl4Y2j+yj+46OGskRa4RYlo7vmNZNAnre75qTuBmQm2Gsq2NUjC/HeID6hjAj0U0bCIdS3mhlkEJTuorbpT0iZDMZYqlKWAJeNC7HAGDw2HprXXHSs897i1wc6OjhVcTgByks0KxUgcExeDbdJJJMp5aKGZG93w4MrW8F0jCeFEf7Ps3UaYs/dIaHlpniHQ2m+y4QfcAUiWl7ZlZ9FADfFdERRPxulWdSMrkjJURprdRMfxd5N6uXMkF0t23dKnlaZT/mYhX2PSTktF9SPbXs17I/crLS+E89AhnGXKd5Ltf8JwHraNto/MkYO1e02BOCstzweyIVOsKqW7hvs34FUnb6lZoJppnwwYBp6Nrwd+9cejS0pi8Ifz1Ndx1oUWX1v49BvWOzAj6hVFk7MyqW9yS3NjARJ4NV9EB2WMxjDgtAdDMeZrMOvF7FXmiLwL8288WPD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38070700005)(30864003)(2906002)(41300700001)(5660300002)(8676002)(8936002)(52536014)(7416002)(33656002)(55016003)(86362001)(186003)(478600001)(6506007)(9686003)(71200400001)(7696005)(76116006)(122000001)(316002)(66446008)(6916009)(4326008)(66476007)(66946007)(64756008)(66556008)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wJUe76TKgjc+4QB1Ge9ubRob/Dfc/luX8jp93+QXHBvEHhb8gNem3naK22h?=
 =?us-ascii?Q?fVww+jTmYh6friW+IK5fMa/tnYesozX3l2V6brhl1lf4w61fKgddysygXDRZ?=
 =?us-ascii?Q?RLe7NPZs7343hkwet+qIsxDCagNusBE04olqbmOMZfZdvuz8P24fvZn1RHJJ?=
 =?us-ascii?Q?ecLUG7Tn4mYgE4oWhgbKUlM72NH0zTJs6y+cZe0Kj6qYDbumnnqsT6NPYdKO?=
 =?us-ascii?Q?/V/a+Xz1yXrS1wsaDm4KEFqCRGK+V7rrc3i6v0RxrDgTKFJiiv4z+cU+suGk?=
 =?us-ascii?Q?SW4US2/pOb/8QafTXNKCfwrsRLsjojVl3tqYZAUQjmvO4ks1JXom8qXQ03pu?=
 =?us-ascii?Q?K47pLr5LwvQ6GnlcDbhocqX5RM1IctE+s3dxRA7bOJSjTfAolcvVNktDLysj?=
 =?us-ascii?Q?pAPG/lNaObrKY2UavqanNxEr02tp+BO4Woi+YgUJYhRaHmOwYoEf7MWBrLIM?=
 =?us-ascii?Q?uAf2X4UF01JGTUPcTkAW+ZL0D8wflauoi7feVyTp2RKllIyAJ5HksIrgurvp?=
 =?us-ascii?Q?9B7q+oL+57qxy4MDWEJoOtQjom0THqQb4J9ajaO8t8bJtGZxfug9S90rF/zb?=
 =?us-ascii?Q?6kaWO7DI1XIcKzsqNBFGWClD1Te1zm3/BqlIA0iWL8koTetO9O7KkgTJGIrO?=
 =?us-ascii?Q?V4nKSvueepfLxs5V3cdxO33kujGBXQYgimKgss8uhKPV8EP1e6o30ZqMlTjy?=
 =?us-ascii?Q?ZWDcvm2Xvzp147VzidKysNqQWFtM6kLNYFGapVecH7AxYH7NoneVjapOXAHA?=
 =?us-ascii?Q?+Y9cRz2ddntfjVk1dwpyB1XD8R5HYCUjWLzTMXyWbOgSQiSrwmoy0K/dRTSK?=
 =?us-ascii?Q?X9ECtGIzzu+Rr0jTZsOzXVnHJYbLJh7A6wFj51BftQ2Vuv1CYqHrIB6no2my?=
 =?us-ascii?Q?CTFzazheZFVhuDXwFVm66M0YUO/F91m9Uq/yTCx2rCbk78MGupp1IEZZhNEh?=
 =?us-ascii?Q?L0onIvasNhwIMgyaFBzBRiDba/H6RAvDLO7U9V88A0mwrBTnIHb4E1Ttvv7x?=
 =?us-ascii?Q?4MHy29nbRYChgt1aywaD83ODVzUj5s38fIj//yFjiV0EMqAb7VTksccnwqSj?=
 =?us-ascii?Q?PAFvus7t48TtQvc4JhPhxRV3tddkOVylF69d5KXq5SHT+5Hb9ETsneQ+6gnp?=
 =?us-ascii?Q?qcJJ9BVSMj2l/nFb37pBJLS1PYcEemww3PA+A36Ucf+AD/J5gkt2WvcSq+ss?=
 =?us-ascii?Q?1c74uWUZ8PkVz6m8ZxubdxSrwamNnKcbfaxueshzbDEPLQlmZxeFkfm7pNnW?=
 =?us-ascii?Q?s8078W/TDEoaX1qPLQomCJnoS4hvnrbY48PZTDAMPGlZmqSNUb23KnLQ1BBm?=
 =?us-ascii?Q?Ao4gX/o7tef71G0dNtka+VLHi0NEAlsHSMjDG/SFhqnW6Eq8kszmneDpTCq1?=
 =?us-ascii?Q?XI4eBeKLh6JPHHLkkKbycWM6pRlX9Ytxs1RAR0DB4921dpInX4hs5frRi8YZ?=
 =?us-ascii?Q?B02kIS+Z4EJKf9P1WcBk7YGYspHzzAxKkwitbkQpN45w3bUieApCO9PLo4TL?=
 =?us-ascii?Q?5D2A133TRToURPeuHyYAXRPaLSf6pZ9Z2eRedzLZLwtf888pp8dt4gtcWglu?=
 =?us-ascii?Q?IjkUiz7WETccM75JvSq0unTtSBydiExzMrPt8V9NBXbfZPLcMEXKemaWiTFr?=
 =?us-ascii?Q?VHj7odfgIhm+cFsBgwmDm/RH4NobbSCf5SuWWmga+PVJDSnrxaAO5/+gWAjr?=
 =?us-ascii?Q?G3Zi9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ff5958-a319-4767-ba26-08db7c4e298c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 05:18:54.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nNoho5y6p5kier0zLKnFXOggTQm4FTyvrMAwBmW8UkjBiUL2AinFTXF/cA9mx978RuCRHUeRP2cMCUu4cs2hte8vNCgexdoynwabe814RhATR5aMhv3yDrcu/N4UAT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 8:56 AM
>=20
> On Wed, May 10, 2023 at 03:22:18PM +0900, Yoshihiro Shimoda wrote:
> > To add more arguments to the dw_pcie_prog_outbound_atu() in
> > the future, introduce struct dw_pcie_ob_atu_cfg and change
> > the argument. And, drop dw_pcie_prog_ep_outbound_atu(). No behavior
> > changes.
>=20
> I doubt anyone not being aware of the change context will understand
> your message. More details would help with that: why the conversion
> was necessary, how come the dw_pcie_prog_ep_outbound_atu() function
> turns to be redundant, what additional parameters will be added
> afterwards so this patch turns to be a preparation patch for that, etc.

I got it. I'll add such explanations.

> Other than that the change looks good.

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
> > index 5718b4bb67f0..676216d540fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -544,6 +544,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(str=
uct pci_bus *bus,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int type, ret;
> >  	u32 busdev;
> >
> > @@ -566,8 +567,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(st=
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
> > @@ -579,6 +584,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
> > @@ -586,9 +592,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *b=
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
> > @@ -601,6 +610,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bu=
s, unsigned int devfn,
> >  {
> >  	struct dw_pcie_rp *pp =3D bus->sysdata;
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	int ret;
> >
> >  	ret =3D pci_generic_config_write(bus, devfn, where, size, val);
> > @@ -608,9 +618,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *b=
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
> > @@ -645,6 +658,7 @@ static struct pci_ops dw_pcie_ops =3D {
> >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> >  	struct resource_entry *entry;
> >  	int i, ret;
> >
> > @@ -672,10 +686,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
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
> > @@ -685,10 +702,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *=
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
> > index ede166645289..bd85a73d354b 100644
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
> > index 9acf6c40d252..b8fa099bbed3 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
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
> > @@ -419,10 +428,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 r=
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
