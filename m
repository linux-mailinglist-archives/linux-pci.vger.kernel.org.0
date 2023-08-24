Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E87865BA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 05:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjHXDNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 23:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjHXDNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 23:13:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D810EC;
        Wed, 23 Aug 2023 20:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3B5Kq3WGUJ/+AEbQa+h6XH3b9PSGesR2ymMduAquF4iBRhdyHAQbcysITGzbttOtgiJhxMj9AD8A16j3CohrtomOAMfYeE0pPA/M9lj5XeZ1PV+Vc7u7MlPVaWke+nG4sFO4y1qdWQd+Fp5gLN/GRauncAdM4ZXmi6ssI0BM8APXm3xIRZqjmeoZ/Gim4NscTC8Is+uxdsC71V5fSzMLPOe6IueTeRQg9pq4VdHCysjFHSjj9h113MujdH55giiOVBe6o7pItSScgZvOfCteJw/aoF+Le2fpXh+jOg6jP3WCxxzEhC8fthEyb5FpKv3G07kY9IdhF96rBxKmg+x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLJ5MJ39AdEH4WqUBfBTUHuZqAco7O10b5y9s0Bm1sg=;
 b=Xs2x6FA8vgoF55BCAY67OI5Po/VUGu9aYt5VCKNY5b9qxZC4XG01Ln3+jNeWFBj4xtWCDoBvm966C+qgamdVhxvospVSOMzjjje+oPmJRwbWECT6ol4KiPqSUMy09bD+FIhkTPMVpzCFzTsaiKBXLgoabn7YHO4/khA4MaKga9TODf4IiIZdyfMcas4+lhM/vfpT4kjzTN2gUBHqGKZ14Edm7pGGhq6VO+S4BFcSnsGb/g3KpB4YKgLUhFwAKMyyNhSwCS1YDlL4Wtnc3MLI7yPKjD3PIKe3jTFiMhidDL/L0bmT/6X/+tWRkFpcIQ7h3JRo4uqvPAmMb84zPLYf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLJ5MJ39AdEH4WqUBfBTUHuZqAco7O10b5y9s0Bm1sg=;
 b=QoFJtZyetUAUoKy+WPYlNtqLCyNjR9Bl86Dzy/VeZl2pA6qqOSJGb/BuLICNpu8MJcY8qf7Tl8XkdVvJOm4Y0FtlsTH/EMFV02ZrZ8c8ukmSIJVXsdOpQMeknrAcaKMTHo+iFL7phxiDd6Knf/RTkAdWgZ9YcY9g89gt8EUUJCw=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TY3PR01MB11410.jpnprd01.prod.outlook.com (2603:1096:400:40d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 03:13:28 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 03:13:28 +0000
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
Subject: RE: [PATCH v19 05/19] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Topic: [PATCH v19 05/19] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Index: AQHZ1aHike9QDEncykO3WGKSGEpPR6/3stCAgAETPZA=
Date:   Thu, 24 Aug 2023 03:13:28 +0000
Message-ID: <OSYPR01MB5334E3B584E3FCCEADBB2C66D81DA@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-6-yoshihiro.shimoda.uh@renesas.com>
 <ku43dl3ssq4c6zewwt6ckiwjdolgpmt33iemwfx62oqu65zjlr@5ctyxmqigkbb>
In-Reply-To: <ku43dl3ssq4c6zewwt6ckiwjdolgpmt33iemwfx62oqu65zjlr@5ctyxmqigkbb>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TY3PR01MB11410:EE_
x-ms-office365-filtering-correlation-id: bdc0d60a-6f35-4aaa-359d-08dba4501663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lLe3JJkB7bb5iHL7GfrNr6vO8yAF0ZwiihwTdD++N29zMxE33PaDQkTRXqWfy+LWZshS8f9Oc7VeeUWeT9sUC+4FWrY4kPG+e4k+xDBrnJvyzIFZKGx7FSvGB4KVAhjuDdolZ6zj+dT7V6bYqS3w15rDOTdR41muNq2NUFwhBs7T+z7FGKbcn5L1BxbafHeF3AFk/aAtMaOpRX+1n78qQZlZP5kqM6v3hn+kXejWaMeMp0vbxIMF49cBCHb6xFx60U1B/4MpMQtAFvF/i4PiNLaehnTOCZhkttnSCockf5Exfw/vIFrbTAdp0Wlu3sxf+cWjwFBN6/8cnnP9UzowWRgHrO7jsvhV0uDmFvx40oK1CJtL6IGHvB5bOtwvcNwn3Pj+r+yJTbvOKErA7HHofV376MD+oUZwmoWjlXviThLQgP8aoJ0NDClWnGRDRPnzpAT5ce3kECqakWg29lEDpEnZDjeFKR4R+C/DGHBaijYjLN+lB3JYf12ToPw7R/9hcHsNgKf2SbjQKqiJs8ef18Qi/C+H9z0wA74p20syL/7o1saCV2mmACOD7ikixqIs53pSYrLmAJ79HbT+gEM5Fg51boYtph7znqs3dya9wUE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(7416002)(33656002)(55016003)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(478600001)(966005)(41300700001)(9686003)(2906002)(6506007)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoNwKGHqpgU0C9UIk9cv1pPYYd76+hTl/oUA/ROhqOrZaELWOkEM8PBsPmdF?=
 =?us-ascii?Q?iBY34T7firT5Ut+9CRNdyDQCy9Taw5lDhp4kK0FH9fOl7d32FBwx+mJj/RhW?=
 =?us-ascii?Q?cEagoxEzStGEtqmO6Hv03BNbQqG/nYDNbXGASpq5QdUdn3CcWNW4DgqiXTN2?=
 =?us-ascii?Q?oaOWBfKb4/OUu/r45yOL7RkbtsAtLKgABmdYymiXh+/S0mtYErK2vD1y2s3a?=
 =?us-ascii?Q?UBs7V2WMWAhaBAYZylaNfaLV9kcqbj/A/ForvCECicEuq7khH08+CX5Ac7wL?=
 =?us-ascii?Q?yMgv+fapg37fDql0SqMBej8CoaAhqG4RBc0KCcSyjRdIpElm+/V9K5lGUuV8?=
 =?us-ascii?Q?2J/bHzbFKB9657FK38FBhckLuno0cYezv1BvFoZuiDOtMMO4W0XwMZv75CK8?=
 =?us-ascii?Q?/UrtaO2efW9+AcazTP9qwUVMAGMurKEbgBstLz/uSJnS67YobWZmtX3v9tLF?=
 =?us-ascii?Q?tVBock8phFQhVZGo9+NM8eFe5fuaT1Rq2Y02NKb9v/lTE5+Gb5r3KFh7GJjE?=
 =?us-ascii?Q?0WEAtxM34SMZ59AHPMKCdlQxrJQZGbydzLydBLSRy7+dZo+Hs87hE1xnHict?=
 =?us-ascii?Q?XRMRennEzqN2SzyaEq/B8nw9hOk1Uqo+p5e19lQdkvahDV1gzS0pIIUsk0h0?=
 =?us-ascii?Q?qcB1o+XFHfc7r0ZxIavWysqMxYecFCMRJw68TV8xeupmu95AA5KgG/ZJNA88?=
 =?us-ascii?Q?TE1CCikX0LF7aUg00I9cWqePTnnSz0i5rEdmy1vEehlkv6sbIpnsCCDcItmD?=
 =?us-ascii?Q?wsLJihgBBvjYhDEo1X0tVfqqv/EXDaLjFs84o2TrLL6r0jNEm/6t6SKanRvA?=
 =?us-ascii?Q?d9GymI7L+hM+2pBRIsm9229OL3CtYrjyGA8tsdVogXHrqTeKlwWAVEg9VIaQ?=
 =?us-ascii?Q?JvPRhCd/OkUFcJXbbGHYR924Klpek58cVOBVTvThyy4dRa/YGnUnrtQyT7nY?=
 =?us-ascii?Q?DxfL/LJ7kE0X7jrYemVl/M605Hasl30/O2tiTinRVMdUqDzex/7Ls9jxnqGW?=
 =?us-ascii?Q?xq6TFqa0lISQmdwjD8hEdrLlncV4kXL2HQiB93gUxiP1eTfH6lKWq7FRsovo?=
 =?us-ascii?Q?C6JehLYsCrq0PDEkhctuKIWKmsDH6cTcJff/GMYYMfA6m+YdoHmcUhSuQPkC?=
 =?us-ascii?Q?CQgtGyhodkrCbtvcnjDZU/xmfu6bfmfcY7zGQRWAo+1Lf22DDdIG/McDybK8?=
 =?us-ascii?Q?I3Ddp7sGw7uIA8fo2O5ANUSgcD1C+faV8QL0ysfRyxQEIAbzTh4zUvG2N73P?=
 =?us-ascii?Q?e5F3id8Z8kGDZdGiBqH6pBDAnf61j0hPxVf12hLiTy6QykRFM+OiLXHsU8Ux?=
 =?us-ascii?Q?V22qLS/L2uTn0VaAJkgvICgNzSxcqsF2Zhlli/QgyMDSyfXcMLZ8d2PIxSAn?=
 =?us-ascii?Q?hFEWZ2buUaxnFU4IevYyaNtoTWMXsAj8aLr8M+6k2QoStsYzfeYI/tcORLT/?=
 =?us-ascii?Q?RcUcJWwsTopXToQjyiR4PrKJUh+LMceu8rirtkwwZgcmLLSYsof8Eh59huaU?=
 =?us-ascii?Q?jaKlb/235sITuhkduIpnKMDqZuVY9ebf88+h8GSe8J59InoVtRrVvSrsD/g/?=
 =?us-ascii?Q?P8JGpmy+wSObtBuKVwP72czSNalu1UxXF9iM2U/f9VWj19X1CZMyyVpITX6W?=
 =?us-ascii?Q?yGURm2a2ht4OhvrkrsdnU69XjxlLKXc8zcsHItKhGec+xxJo1Z4w0pkfnnGb?=
 =?us-ascii?Q?b5fLJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc0d60a-6f35-4aaa-359d-08dba4501663
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 03:13:28.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JghHqm/O8GsGw4UmmbfMNG48e9rJQR3ogu9Kl+ejIEVIllAxuG61TvHhB+krb881oR9ur+8zSwuI4Dk/ED7+8NjGfBz3Y5bMVY0Jgl3hyhGWGYAqlYl8qSn0eBpDIAhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, August 23, 2023 7:46 PM
>=20
> On Wed, Aug 23, 2023 at 06:11:39PM +0900, Yoshihiro Shimoda wrote:
> > The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> > for DWC") added .func_conf_select() to get the configuration space of
> > different PFs and assumed that the offsets between dbi and dbi2 would
> > be the same. However, Renesas R-Car Gen4 PCIe controllers have differen=
t
> > offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> > the offset for dbi2, add .get_dbi2_offset() and
> > dw_pcie_ep_get_dbi2_offset().
> >
> > Note:
>=20
> >  - .func_conf_select() should be renamed later.
>=20
> That's the problem with half-measured solutions. The code now looks
> clumsy and thus weakly readable.

Mani suggested that on v18 [1]. That's why I didn't rename the .func_conf_s=
elect()
on this patchset.

[1]
https://lore.kernel.org/linux-pci/20230728023444.GA4433@thinkpad/

> >  - dw_pcie_ep_get_dbi2_offset() will call .func_conf_select()
> >    if .get_dbi2_offset() doesn't exist for backward compatibility.
>=20
> >  - dw_pcie_writeX_{dbi/dbi2} APIs accepted the func_no argument,
> >    so that these offset calculations are contained in the API
> >    definitions itself as it should.
>=20
> I very much hope you'll get to do that after this patchset is merged
> in.)

Yes, I'll do that after this patchset is merged in.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
> >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >  2 files changed, 25 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 4a8c116cdd4b..500b092984b0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct d=
w_pcie_ep *ep, u8 func_no)
> >  	return func_offset;
> >  }
> >
> > +static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, =
u8 func_no)
> > +{
> > +	unsigned int dbi2_offset =3D 0;
> > +
> > +	if (ep->ops->get_dbi2_offset)
> > +		dbi2_offset =3D ep->ops->get_dbi2_offset(ep, func_no);
> > +	else if (ep->ops->func_conf_select)     /* for backward compatibility=
 */
> > +		dbi2_offset =3D ep->ops->func_conf_select(ep, func_no);
> > +
> > +	return dbi2_offset;
> > +}
> > +
> >  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
> >  				   enum pci_barno bar, int flags)
> >  {
> > -	u32 reg;
> > -	unsigned int func_offset =3D 0;
> > +	unsigned int func_offset, dbi2_offset;
> >  	struct dw_pcie_ep *ep =3D &pci->ep;
> > +	u32 reg, reg_dbi2;
> >
> >  	func_offset =3D dw_pcie_ep_func_select(ep, func_no);
> > +	dbi2_offset =3D dw_pcie_ep_get_dbi2_offset(ep, func_no);
> >
> >  	reg =3D func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> > +	reg_dbi2 =3D dbi2_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> >  	dw_pcie_dbi_ro_wr_en(pci);
> > -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> > +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
> >  	dw_pcie_writel_dbi(pci, reg, 0x0);
> >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
> >  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> >  	}
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> > @@ -229,16 +243,18 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >  {
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	unsigned int func_offset, dbi2_offset;
> >  	enum pci_barno bar =3D epf_bar->barno;
> >  	size_t size =3D epf_bar->size;
> >  	int flags =3D epf_bar->flags;
> > -	unsigned int func_offset =3D 0;
> > +	u32 reg, reg_dbi2;
> >  	int ret, type;
> > -	u32 reg;
> >
> >  	func_offset =3D dw_pcie_ep_func_select(ep, func_no);
> > +	dbi2_offset =3D dw_pcie_ep_get_dbi2_offset(ep, func_no);
> >
> >  	reg =3D PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> > +	reg_dbi2 =3D PCI_BASE_ADDRESS_0 + (4 * bar) + dbi2_offset;
> >
> >  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> >  		type =3D PCIE_ATU_TYPE_MEM;
> > @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >
> >  	dw_pcie_dbi_ro_wr_en(pci);
> >
> > -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> > +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> >  	dw_pcie_writel_dbi(pci, reg, flags);
> >
> >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> >  		dw_pcie_writel_dbi(pci, reg + 4, 0);
> >  	}
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index c17e5255fab6..7d02401fc783 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -343,6 +343,7 @@ struct dw_pcie_ep_ops {
> >  	 * driver.
> >  	 */
> >  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> > +	unsigned int (*get_dbi2_offset)(struct dw_pcie_ep *ep, u8 func_no);
> >  };
> >
> >  struct dw_pcie_ep_func {
> > --
> > 2.25.1
> >
