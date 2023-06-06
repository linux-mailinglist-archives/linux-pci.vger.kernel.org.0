Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB27723D98
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjFFJdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFFJd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:33:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67710F6;
        Tue,  6 Jun 2023 02:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb/ISTR3lhLaoeXMG9KzLIvl+SntWoQmhNd+HrP0bCmtti7BG81MjajA+1YQF1/LhtTTBM06IpYJZw3wa6ijO4cxjqTLzkmK1N1mV4U/tGHU3z2Wg0cniFjHY62aB5iPHLKSFK+2zsn+9FYEQKeSozYtolUqVzyChtYZ+XL13ujmPECMqpJHOHVe5GS+YZCj/5AFyJd7m89QHbhQoz0MriKcAZRSmYOoT5TLU9l3smQs7kI6dJVsR/TGvtgEnu/RTDpf+Y8JGz9XZ0Y4cwb6sJgXpJM6Jf2zeFAUFCaR7fMEYbd+ixKPzwxtB2Xq7RalgMf+ONPFfPGvzsISeC/6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zks0IL639JmrZbP0cmZ1t9PmZvbFHvLLYnMbuq/5DuE=;
 b=ku0GTTwbMwNPqdHdmyqW0QrM7D5IkwdhZzxo9F+0P6k/AfNOr+qsoOWZxflsChAPNqaS7GdD1Ha6GGTdW6aYL5rN8j03OMESE4PkfL7hc6FVgit8xyWkgOcmaf/uPhDXPe6b32I/rXKMTTXjtEa1pEWIMcPycyyRtH6FkPC3LapqnA2e8jb1HUXIrZ88sgfWcG+aqA/r9cgL7mycd5hyPWUV0KSgF6wTX1iqeMeQHZ+ZD4+QyGm9TiRfEtakDfeA4SArxGyxkN8LMknQAOOhi7mhcW92/wGXrRmsW5nAquB8Hs9yCBGsaXKjYtd9Kq3UE29r4sx9ETl1ef+HB9ukow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zks0IL639JmrZbP0cmZ1t9PmZvbFHvLLYnMbuq/5DuE=;
 b=QBThB9did/1Edji6WBlNi4Hz9fGYv4ve6NA14fiNHFEzHhwIz/pYyzzotLKA1dt7tmyIqRe8RGrPicldHesqWSmW3t/bu5EuEeoB5WuTDJppM4Y1c1RDjLYae7iasZCeFeIUmxf9GUrCZ+8BPFaMi9BjfcOFycsT6PznkCwP9Rw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5465.jpnprd01.prod.outlook.com
 (2603:1096:404:8034::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:32:48 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:32:48 +0000
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
Subject: RE: [PATCH v16 11/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Topic: [PATCH v16 11/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Thread-Index: AQHZgwfShp4YEfaarUiMbO76iq3U3q98M0oAgAF5XaA=
Date:   Tue, 6 Jun 2023 09:32:48 +0000
Message-ID: <TYBPR01MB53419E47250FEEC3088A9253D852A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-12-yoshihiro.shimoda.uh@renesas.com>
 <20230605105836.ddvbrhlf6xfnkd2y@mobilestation>
In-Reply-To: <20230605105836.ddvbrhlf6xfnkd2y@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5465:EE_
x-ms-office365-filtering-correlation-id: bbe531f2-7bdd-40c8-19cd-08db6670fda9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95CEIQ7ySQXEz1cTT5UFYanPdRKh4L5e+cryURX51sOrvMGnwFIjsZTQ66TFJ9rOpo/HrZOZz9QIO0r13MIISlAyslQpp3JzNGs/unnk567x16LPAnBEcdg8BcQb4ZYy+KnLlVnhOW6t3qKyiCMWkuYyip6WKlkuTL2TEnhxGvHmSVJTBua/BzPSRsEsKC9XF3lavPbpb4Qo21vnbS7ahguTFCar/p1KE/oO2KU+0xskKGKQzR6x4rap69ID0cIbtkKFAh3H2mwXrT6V+St1+l/JD86ewzRUp5ySsFGTyMlFLG8yCVwE/LUmAqIo7hhCfQ3liXMf+s4PDtsQqndYWXFFDoAqtOcde8Aylb1KZR5clUhSbAKm+ZQL5PrwEMFsBAYgTI3DjMWmoHgSIOqm30RE0yNLyuqNKe5wPSwCzJpwF4wIk78sETlTCjVwjQvFuMXHGzzKNNDoAquy9ABtY0Ygit24B92wrHvZZoHg0uZDmH3fHvvluJ1VWf96JR+Ro1llqyWSFdoO4v4a/AWXi50WqD7QK8nJC9r3W5F1nebJtikKVMxUUDp9eC8zKGukEcR40YzAQdFAo2lN9Pk8x93ZsSr7HXH/bdVaHDIgnGSo66Ss8hnktXFfmXxr8EBG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(7696005)(38070700005)(71200400001)(9686003)(55016003)(6506007)(83380400001)(33656002)(86362001)(186003)(38100700002)(122000001)(54906003)(7416002)(5660300002)(52536014)(316002)(478600001)(41300700001)(66476007)(8936002)(8676002)(64756008)(4326008)(66946007)(6916009)(76116006)(66446008)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vLiVZUtdUq9/tzSu07+EpbgTSnXDSqT/FtjBxA79FZFkqaOQsA8bhwjxQDrg?=
 =?us-ascii?Q?NWygSVgBmMgWS5hI0PQtQN+SH7tNfdiTnUDs/nHrbC+9cuvAWo6v8qsyQrS7?=
 =?us-ascii?Q?6MnPOlYQzVqfHpyxL97eY1Wfbkb7DfK1QsNFClPrNIOAdtDA+7SDzncewaj3?=
 =?us-ascii?Q?IkTlTGBuH1ox3L0Lotc6PR0YxVmNduQYf907z9zm5OGsdxI0/HN8WK9KP2Di?=
 =?us-ascii?Q?u7wGyTjYf6W//5xsG46Y6onnwFMHyfKy9rDhR2IMsxWo0nydHxBMCh2aVt57?=
 =?us-ascii?Q?Rt8pMgbg4zHeL/0Xc5ljg0Zt4JbOv/ABEZiIyvB1kBrWGS5sitgneypFz6vJ?=
 =?us-ascii?Q?j+11cGHWnHnFtwnoSrpzfeBhJk0VfHYIYhsDih5Lhtzi6SXCMQzo1jQ/JqBZ?=
 =?us-ascii?Q?54HnHijensbEfk9L10pYcx4Cd/uphzI+fWztsLeFzsvubDqmnqG+4VnpuWdk?=
 =?us-ascii?Q?G2RpH0MJvkYxLSFwX8qSk0XGr4tznzLvK+jmkA3y85mJxBmjw21Y7TlT0RIc?=
 =?us-ascii?Q?rm/zoDj/ELarx1Ecy4b7si1c4payGBtVZM5RLQge14YZqTF6Gyi16k4rllrv?=
 =?us-ascii?Q?8tbjE1shvFm4kfGhRxAof8FSnLh3tto141MBkChUSlZuZhzCe/YBCKwuxmYm?=
 =?us-ascii?Q?IrvX8eVAtr73O4NoWqVmmSaXwCvI2xWPJ1v016d6By/RflCFcdoUBEnd7/n9?=
 =?us-ascii?Q?BBaEsXwNRnuFlo07Lp89HcdAV3GCIGlhyCjvu5vFaW3gU3kYlm+xGAl7VojF?=
 =?us-ascii?Q?mbhFMDVgg0qgj5H9YUEgMxAp4eiWUReNMPBYhY0e6ietz0Rf1xMAcJSq3PaK?=
 =?us-ascii?Q?h/Api2xhKfGjEHLPjGI9amPYoX3pUsK5blwf70tc9sClubl30E7Nh24eCOQK?=
 =?us-ascii?Q?hux9caAZgRdqxbZjCRAm2fk+YO52xJYu7EaNP2dYUygxYF9durb6Jmep45pk?=
 =?us-ascii?Q?BCGV8lk0Mmi1vYE2Y3ThOy+XAFvhBMa2NdNm2v/NGM9kW+BU5cvTg+VXlplN?=
 =?us-ascii?Q?A4ehkZhbh1y90LpCuBkyZCVHL6OS9QTADF+IiSp3XsH06zMxklmM84F++Kol?=
 =?us-ascii?Q?P5+KRpfeupxo/Wj+sv6U3rp6kWYLGWVI9wNs+6Y6ZAeJ2LPXOi+l+6q3F1Yo?=
 =?us-ascii?Q?UabH6GAev1htsuEFzctvOt83x4Og5koLXU66jhiH10zbErpMqwb63tcpDNq1?=
 =?us-ascii?Q?Sms0ByB2DkMCk+dNn8+XqhfxZBaN9IepzckD7L6hMzxWrB4dNrBWiVG1jxXo?=
 =?us-ascii?Q?q9f6aj+V8amaD7OJXOh9R6VwpY8om+CT8pg5n4kWBQ1G6SbC0ExGoz+nr6CE?=
 =?us-ascii?Q?+9IDdxD+sSW8fdVKtKxaIEIY2SGrFchPhnn9CnGlXsNX7sPo2z4IMBwLg69V?=
 =?us-ascii?Q?/7c2qI60laGYxzndL3G9SQBQo+6hJpr2WSE5lGRtgiNjjP6ztNMerZRw9Ghf?=
 =?us-ascii?Q?snd+ZkFGnYq1U9mvoykcfCWtTriqa8vkLP4rirPAljhIJAvdqjUrxt2l6tPQ?=
 =?us-ascii?Q?UsJ38Xx6PpSKu3vwDEKKsstKzolsISrGTc1kK0Ey1yIFs7eNHAvmh5ZTm1uu?=
 =?us-ascii?Q?RCVD9U7YLGMvrRK6PpoQMATmuqQPCfZUQwLcqhACWkCBNN3UeGFxoxYLKN+B?=
 =?us-ascii?Q?/bL/RWurJagaWc2wlmzHr4DLQE1n9oVPsOHFAx7NnRuA0lLPHx+8SQN/z6KJ?=
 =?us-ascii?Q?AGhGkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe531f2-7bdd-40c8-19cd-08db6670fda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:32:48.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ecJQa/fC0S6yWm8rUTWjQa0zScFRG9vVy0x4P6qo3KaZb8qLYoDFKUCWhyvpcpEJtbxQxBseqVQyn39QmoU2T1M2gYYyYYV2gWM9CjsS0zI7yFDEpyVcmnZKsyZiZ72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 7:59 PM
>=20
> On Wed, May 10, 2023 at 03:22:23PM +0900, Yoshihiro Shimoda wrote:
> > Add dw_pcie_link_set_max_cap_width() to set PCI_EXP_LNKCAP_MLW.
> > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > field there is another one which needs to be updated. It's
> > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > the very least the maximum link-width capability CSR won't expose
> > the actual maximum capability.
> >
> > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.60a, March 2015, p.1032
> > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.70a, March 2016, p.1065
> > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Po=
rt,
> >     Version 4.90a, March 2016, p.1057
> > ...
> > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoin=
t,
> >       Version 5.40a, March 2019, p.1396
> > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root =
Port,
> >       Version 5.40a, March 2019, p.1266
> >
> > The commit description is suggested by Serge Semin.
> >
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 5dc423dd2f21..8b2978c6eb23 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -758,6 +758,21 @@ static void dw_pcie_link_set_max_link_width(struct=
 dw_pcie *pci, u32 num_lanes)
> >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> >  }
> >
> > +static void dw_pcie_link_set_max_cap_width(struct dw_pcie *pci, int nu=
m_lanes)
> > +{
>=20
> > +	u32 val;
> > +	u8 cap;
> > +
> > +	if (!num_lanes)
> > +		return;
> > +
> > +	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> > +	val &=3D ~PCI_EXP_LNKCAP_MLW;
> > +	val |=3D num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> > +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
>=20
> Once again. Please move this code to the
> dw_pcie_link_set_max_link_width() method as I already asked here:
<snip URL>

I'm sorry for misunderstanding your previous comment...

> There is no point in creating a separate method for the action which
> is implied by the already defined and incomplete
> dw_pcie_link_set_max_link_width() function.
>=20
> Also as we already agreed please replace the hard-coded bitwise shift
> operation with the FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes)
> statement.

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +}
> > +
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  {
> >  	int max_region, ob, ib;
> > @@ -1040,4 +1055,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> >
> >  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> > +	dw_pcie_link_set_max_cap_width(pci, pci->num_lanes);
> >  }
> > --
> > 2.25.1
> >
