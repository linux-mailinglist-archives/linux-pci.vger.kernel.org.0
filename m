Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC027EFED
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgI3RHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 13:07:06 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:26720 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3RHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 13:07:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UH2aqf016391;
        Wed, 30 Sep 2020 10:06:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LDwEU+pZIYoQ9+aUGRIpvjwnaqjZAXgCppopOKP52EM=;
 b=MhGhbM8fphZm/LiVQmiyAQrWEyfwJrraTO866ml4vi5naQnmzBqOdfcNf7e0wV6ts4+w
 +e1Ex/PKMoylRUvueIc1IhHS6yoRjhVYdUw1OCpqdmavwuaX71KdU6NUWitzfEqiw8og
 a+MzzxHj05/aVhHe8hmhDymI3OZe/WgErY7cOnFIwpKSjGCmHICWJG8gKWKHlU73lmwC
 1SfA94vC5IzAu1MWMMThg6WHelMuURUx5SBOLyxy4Wrv5ftoETbi0hzyOJZZjjXzNFmI
 iM86JR/RgpoUC95wOy+l6K2qXtkcwOHnvXqMAnv3T1s4ru/+C+KlY11Q31JZQUS9RccW Hw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33t26xq3s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4Eb1jNl+Glm/jOHrAxUnaUjISZwx1AxUZuaZvkWGO/POAlpt2dMqEaRmX5sEPqJpIXAJcjuQfmRBtCUmT4YCAmngRBGIBT1xKFi0s0me6lQruCyaODJvJrHjK7d0ww/zsWAZv9V+G7TQT8lFEydYHcBJKKS+3LAgvrdVlrVTYf/kJ2DArVbiDO07cnjFlvjRPPZncLHS0jWOvz2+9g3ulWXNNAeYfKuvghaFosliDU4izLR4k2Dr77YpjAfW6VhNqrx31V5Fi85Cl+QgI0BKAwXS95/Lt1At7rJVFAcVOayYXgiuac5wzs+EGDWvXimKGBGWhGNpwS7uQntevj7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDwEU+pZIYoQ9+aUGRIpvjwnaqjZAXgCppopOKP52EM=;
 b=TJ4Ca6P0wntlTuiPl3XV0WjUlM8ktjNxa596rF4aOBsCFpTQx+yPRVN7ZI8C3REvoGTZjiUhSouVAzsZVNH4+ATNAOyh/MxbQ9Zq3p/4jd6Zs8k1QlEye23zmKZTJ0OobzKv1yjpB5x4J+5yQmX0TouI8kTSTO5zBOmBLESVSFl74G+2Wb39O98NIdoDu/jWP81APvQ+MuMLeiN0cgjPeuZGrJxtWuZxqgW6/DP6zFjb+NHA0uUg3T1x1HX4irFViqVOOk9rNz5d78y+ZE4ZKJ2kvGkNwC1lxfsU5tIQ7wh4hQu8DiyyKVtjb4L/T0sp2xQKSEO0oRfYoii0EdGVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDwEU+pZIYoQ9+aUGRIpvjwnaqjZAXgCppopOKP52EM=;
 b=goVMIeUgVfRHBer59j+IiwemnIYbRIL3KeC3R13rKlOaOJlNCtppS+3crrzeP1lJEV9PYjpEXkdeeWLyZ85bSr/Z2ZNmfzEfDBVf+MAiEpKiA8mputWoSn2BIxtKG/rW8B7s3moS+m4BDVBgzFf4yRKAs367FndyLhYN0HJ9/VQ=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB5646.namprd07.prod.outlook.com (2603:10b6:805:e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 17:06:50 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 17:06:50 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Topic: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Index: AQHWkdgyO198gx0BFk+Kvm6f02xHwql2rzSAgArDZrA=
Date:   Wed, 30 Sep 2020 17:06:49 +0000
Message-ID: <SN2PR07MB255790961476555221B24752D8330@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200923183427.9258-1-nadeem@cadence.com>
 <20200923203809.GA2289779@bjorn-Precision-5520>
In-Reply-To: <20200923203809.GA2289779@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTI2Zjk1Y2MtMDMzZi0xMWViLWFlOGMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDUyNmY5NWNlLTAzM2YtMTFlYi1hZThjLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iNTUyMCIgdD0iMTMyNDU5NTkyMDc2MDAyOTIwIiBoPSJ6UlFoT09Ua0tkV2loTXdxZjJoVWxkSDFoTTA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ff5228a-f472-4ca1-9f0d-08d8656338c3
x-ms-traffictypediagnostic: SN6PR07MB5646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB5646D4168AF515A34788E445D8330@SN6PR07MB5646.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eeITYgJ9saCBJa+NUB+wcMXLthdIa5SbmSbTbvgMj+ZLg7N4g4sq5k8Zmtjua7A4CsYxdBkZn05PXQ4glJhYeejYCJauEfNHC49S12c2xOFrAnfTV/S2LWdB+o55ciRgcNADay4XEBfwYHeGfbxfW/B3nZKpF9V0DzAeFFUS8Ej+3O7Kc/rKPAtyXpHRmk5Z1T1b1lvEBGR3VPhBTRr+iGN3zZow8rmXbiAoh/RHE2a9BBlRtGAfVYuxO1nkOE74bzdVEqffDaOFxpvB70hjWESFok3jNQBCZc4tj3IpQKYHiJEDBE7eSNz5ENrdscDsEtGQwNsXQlJgkjtCGpWezTKBnUjJxls+DOEGDgIx/BJvOu8JozYsn2YkgL3HSzSzx9r6LLVEF1vGmH7ch9nmhHFP40KtbYntXi4YlCTo10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(36092001)(83380400001)(186003)(7696005)(316002)(6506007)(53546011)(26005)(54906003)(52536014)(71200400001)(2906002)(66946007)(8676002)(76116006)(66476007)(6916009)(5660300002)(66446008)(86362001)(64756008)(66556008)(8936002)(33656002)(478600001)(4326008)(9686003)(107886003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S0rcgcZiNcCIRzYBElbj7HMjHe+x7rR8DMF+MlMvMN3SKD/ox/3rOb+VM12xyTFSZr9g/VCovdHqTB61vVx6oo3EaiW2zPxVh+p4pxT7vcUsc6eJHW+b7x4UR5JT84kDOCeBUJrie7cLmkY52gs5LlQg6bwPEhobwaEbg22Yh/hWK1bJEzhhYpHMyf0B2cn0qWEwQ1PZ7itfrzprSZiBMm6Wa8ceJtmCVrwPY3kVVRpgkVyYEUN5o/1DLyyBz2zezxFYiIOX66hCxb5wCKCZ0WqYeCN2Pn0xhG6FUxBeorgT/25dEDcFJZNF8axp8P6l3lrhERG90JTwT7+ZMHedtR3mUAeRIg0JqOkCzMp5t2qzwaE0NpsmvHfJJK0ep8MZr3r8bsNeD5VR9ErcRoao/8sSgOQoKMqU9wc248+hkqo7tgdznbGhY3AnAQx1btAtiEq0+CxmGZqUw697bs0bfLRa6t+kzxlxy1wvlndEcl6OqOeGfqvz709g/IhS/j9f1LcAG6AAgezYSPiYWa+o5gn9MoKLV0FCtpR9kvs0eFJQLTBA0oZCfuQww68mlSyO6iX39PB8HJZlfvkThkhOgwWjeI7XawKP2jQqZ4NCoSiHVx4ySAKWrhQWCiwLFhQTvzpfTn4bsvu57JD8+xXYPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff5228a-f472-4ca1-9f0d-08d8656338c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 17:06:50.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvNM8dqVCYV86bgtiW2EE6fFFNZtwtZIacz+GGSULYYCYFfmA4FNeNFfRVCpVvqLpVDmmjUejQqKKxTg9vnw4n5pAzkpWQK8N94/YO/3Skc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300134
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, September 24, 2020 2:08 AM
> To: Athani Nadeem Ladkhan <nadeem@cadence.com>
> Cc: Tom Joseph <tjoseph@cadence.com>; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; kishon@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Subject: Re: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
> autonomous speed change.
>=20
> EXTERNAL MAIL
>=20
>=20
> Something like:
>=20
>   PCI: cadence: Retrain Link to work around Gen2 training defect
>=20
> to match history (see "git log --oneline drivers/pci/controller/cadence/p=
cie-
> cadence-host.c").
This will be corrected in patch version 3.
>=20
> On Wed, Sep 23, 2020 at 08:34:27PM +0200, Nadeem Athani wrote:
> > Cadence controller will not initiate autonomous speed change if
> > strapped as Gen2. The Retrain bit is set as a quirk to trigger this
> > speed change.
>=20
> To match the spec terminology:
>=20
>   Set the Retrain Link bit ...
This will be corrected in patch version 3.
>=20
> Obviously I don't know the details of your device or even how PCIe works =
at
> this level.  But IIUC a link always comes up at 2.5 GT/s first and then t=
he
> upstream and downstream components negotiate the highest speed they
> both support.  It sounds like your controller doesn't actually do this
> negotiation unless you set the Retrain Link bit?
Some Gen2 controller variants doesn't support this negotiation. Hence requi=
red to set the Retrain Link bit.
This will be handled in much better way in patch version 3.
>=20
> Is cdns_pcie_host_init_root_port() the only time this needs to be done?  =
We
> don't have to worry about doing this again after a reset, hot-add event, =
etc?
Yes. Only during init.
>=20
> > Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-host.c | 14 ++++++++++++++
> >  drivers/pci/controller/cadence/pcie-cadence.h      | 15 ++++++++++++++=
+
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index 4550e0d469ca..a2317614268d 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -83,6 +83,9 @@ static int cdns_pcie_host_init_root_port(struct
> cdns_pcie_rc *rc)
> >  	struct cdns_pcie *pcie =3D &rc->pcie;
> >  	u32 value, ctrl;
> >  	u32 id;
> > +	u32 link_cap =3D CDNS_PCIE_LINK_CAP_OFFSET;
>=20
> This is not actually the link cap offset.  Based on the usage, this appea=
rs to be
> the offset of the PCIe Capability.
This will be corrected in patch version 3.
>=20
> > +	u8 sls;
> > +	u16 lnk_ctl;
> >
> >  	/*
> >  	 * Set the root complex BAR configuration register:
> > @@ -111,6 +114,17 @@ static int cdns_pcie_host_init_root_port(struct
> cdns_pcie_rc *rc)
> >  	if (rc->device_id !=3D 0xffff)
> >  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
> >
> > +	/* Quirk to enable autonomous speed change for GEN2 controller */
> > +	/* Reading Supported Link Speed value */
> > +	sls =3D PCI_EXP_LNKCAP_SLS &
> > +		cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
>=20
> The conventional way to write this would be
>=20
>   sls =3D cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP) &
>     PCI_EXP_LNKCAP_SLS;
This will be corrected in patch version 3.
>=20
> > +	if (sls =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB) {
> > +		/* Since this a Gen2 controller, set Retrain Link(RL) bit */
> > +		lnk_ctl =3D cdns_pcie_rp_readw(pcie, link_cap +
> PCI_EXP_LNKCTL);
> > +		lnk_ctl |=3D PCI_EXP_LNKCTL_RL;
> > +		cdns_pcie_rp_writew(pcie, link_cap + PCI_EXP_LNKCTL,
> lnk_ctl);
> > +	}
> > +
> >  	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> >  	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> >  	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE,
> PCI_CLASS_BRIDGE_PCI);
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
> > b/drivers/pci/controller/cadence/pcie-cadence.h
> > index feed1e3038f4..fe560480c573 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -120,6 +120,7 @@
> >   */
> >  #define CDNS_PCIE_RP_BASE	0x00200000
> >
> > +#define CDNS_PCIE_LINK_CAP_OFFSET 0xC0
>=20
> Use lower-case in hex as the rest of the file does.
This will be corrected in patch version 3.
>=20
> >  /*
> >   * Address Translation Registers
> > @@ -413,6 +414,20 @@ static inline void cdns_pcie_rp_writew(struct
> cdns_pcie *pcie,
> >  	cdns_pcie_write_sz(addr, 0x2, value);  }
> >
> > +static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
> > +{
> > +	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> > +
> > +	return cdns_pcie_read_sz(addr, 0x1); }
> > +
> > +static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
> > +{
> > +	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> > +
> > +	return cdns_pcie_read_sz(addr, 0x2); }
> > +
> >  /* Endpoint Function register access */  static inline void
> > cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
> >  					  u32 reg, u8 value)
> > --
> > 2.15.0
> >
