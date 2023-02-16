Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A85699329
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjBPLdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBPLdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:33:23 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F8311DB;
        Thu, 16 Feb 2023 03:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3WelbKwwrPFrYo5mANhTkabKdDexh7kES300Jk1v3k+MjB9s8AmYmNxrj0qYFACTrrzX+w1kAGJbIPBQjRDC4+mvYyOV2MMvRobstIGHVx44mFGby4Vs5caHa5R/Fd19xqBK+h6+vMBawX0RYjdHiwMOU8nHRdYPqo4DOcbxYpnDfpEYHYEjBhYXis9KaeShZdSknQFn6r4fQcge8mbrbjm+G6wUK7e0EMjWCF6wTdUD46VG3TUr67VeZTQEIjEYzLedx/to2XRE+ktwkOqtapZXn7DoJ9xBADD7GETvP44TqVIRfSDxZy/sID08sZ9gDPI0Pzxzhlfm7vS8jxzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps3utmxf0jE0qyINw4g2/M5jVEj/y6Ooy0iRTKIfc8g=;
 b=Aiky/mB+EgzYPA1G6wJ1HV2IRTRY6yMpdhOLcQo7210zL7eRbOyTJvuB6x0Qqi8zzDxjWEWQkjk/Ty5GTHw6Sq6OwTh97vf/XqCh7EjVRi4PWh3iz6d7UyNUbO3knAYKgOMZrhkkCcQVOTTPFGT6tLAEcw41NBsGjpyaCiObEI00uenRHMlr54BfD68SgQDE77NFfTW3vWC9Dw+CSGE3+8ett8gTIwA1/f0CimYPj4zphvjh7k5l3Lmk0s9/2mDrHplmP1Sdtwtxjdcpnynt2RtYXexodbQ9jj+HjtVw1ruL5phmQ2WZZmkvYB/wSqrfYufmuVoO+jJpokWWy9dXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps3utmxf0jE0qyINw4g2/M5jVEj/y6Ooy0iRTKIfc8g=;
 b=QWirt/caNXv2JlPdaiJjMaABuUU9o8k7WP9/sI9KnOSDxlLnBt+Q7jQQp5fETc454PKVa1nacaF92Fr8Xz2rB4EBNqQHUxW46PNAI4fWR4+iXYb75ker424rDwn8r8tltVNTKSk4CSoKE698bevBeLYS1S8HZ3ESMDYL29lC6Hk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5930.jpnprd01.prod.outlook.com
 (2603:1096:404:8055::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 11:33:16 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 11:33:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 6/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH v9 6/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHZPVZ6JTQdmTm1Z0amVXPFA/uYdK7QXUIAgAEJ//A=
Date:   Thu, 16 Feb 2023 11:33:16 +0000
Message-ID: <TYBPR01MB5341BD497C4EF94AC2524C02D8A09@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
 <20230210134917.2909314-7-yoshihiro.shimoda.uh@renesas.com>
 <20230215183316.smkcg3qli4savkks@mobilestation>
In-Reply-To: <20230215183316.smkcg3qli4savkks@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5930:EE_
x-ms-office365-filtering-correlation-id: 8f42cbc6-191d-46d8-363a-08db101198e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idgBpz6LKADbeZjY1F4LNTU1hylG7ycyyRZyhJJCM9w9Q1kVtTkosfGCTMKeslNiMFKcN5qAaOw1BImHitbxNjhsD3NgUGeyfpoIkoohuYmjM26Aw4TalKHSlGFZX7P0xiOumwP6mp9QSPWfoAh+cmXST7SX5M6CgUVvIEEBxKngnG8qVeQCI45MZ4n4T9RaTRB5i5a2gDo+IS1cBommTtYdfxPo6x61H7VhXObbH8k/RJgK8/hEgcAf/7jmq6C3FZMwDXJQd9ZAsGIuSr/JPURI5nrESPgcMRcSiBcIVn+Kg4g+5g1RUWYkihx1zAX0pdb9wPDPu3Nl3+f/knub27+GzHJv8JIC0270yyoyDD/bBqXsog1T6f25qbJkOxSlmFF2iYdPiVk6qraklrB4s0bJmkLyqUpHg5rw9mhaDSU/1ULqYSkD7viniIaLvXNIFi6tT3oTfHbhQ+caxwQE00SV4wyTBFKLMe9zShQEadrNVBr5ji+Ta+jVytc+hIcdll/xVjkBzjLhpveCVwY7LlU3teMhv8iz3R1hkxMH2irIxfidPslry4eELRRr6s84PJnCeZLk9RegU+xgFQoCcfYMvSFBblx1vHKZ/lfYwjEE0AFI3FOV68lz1sTLnvXg1b0h6RrR8iRKXRDOvY/67dVPNd3N7LKmLjmYwiSuhqT/LOmcuFFlTwtZpivmE9mx5kuJS1IsxB82EFFRHA/6fWqRltE1kIEoGUZ69d1OebDXi2YNPMEtF9Oq1dAu76f/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(86362001)(33656002)(38100700002)(55016003)(122000001)(38070700005)(76116006)(66446008)(66476007)(52536014)(66556008)(66946007)(41300700001)(110136005)(54906003)(316002)(64756008)(8676002)(4326008)(5660300002)(7416002)(30864003)(8936002)(2906002)(83380400001)(7696005)(478600001)(71200400001)(966005)(186003)(9686003)(6506007)(26005)(461764006)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sMmsMUjTXgQJt/AY+M83/iU3n+45kqfBQxYMAdMFj0+DjsdtYW67/PjRSX7G?=
 =?us-ascii?Q?5BpQFkOcUGQdtLKmx/ftIu+m0DFGX3J3yz+W3tZoY32hZ53D6qc/v6Hu2Qle?=
 =?us-ascii?Q?wy8BcwuY94rY0SSzQGOIKo0uanFzWRZhAaq2RwOsusPweut4TidTIir4c0e+?=
 =?us-ascii?Q?hWEJhDZpI0G0T/TPEvco+oCmyBG0X6Qzy7ERUbxBPEwieyWmlXnoXaZ+MDGt?=
 =?us-ascii?Q?DQMkMA5Hkf0cyVUqz12KuNFgcV7YYfebmkRic0rgpjenaK05r5TQZZ0GtWjX?=
 =?us-ascii?Q?DXG3NAM3li4TVo4FLoMrSThxYksmJXajspsdyoyFmHcmcM7qgLmlUi6qsPkz?=
 =?us-ascii?Q?/IzQdr4FnX5d5r9BadBJHb/Ugsug1ayOfKK/qGvPpp9BfbggqZQ+vJHzfdyA?=
 =?us-ascii?Q?tUTHiNVg6qQ1E1h8wcixOxKLv16Mp8Ca3vc2dRth5kP7Sn2Aj9H4CXoWxZnB?=
 =?us-ascii?Q?1G2fXyNcRzdHfLpzVKmrZV/2glyxoKPtyXIONybIg9HhnuJEIXQ3+vhLgLJz?=
 =?us-ascii?Q?nHB8fVcwNkfZd5MbYUQ9zWvdSnFqmH28FWjt7mSxxjntQ3PeC3Aou2WM0kRq?=
 =?us-ascii?Q?KPTQEhyrBT+JtfEpjf/kFVu2dU7PVm7k3bz1A2Uu5fVq7//PQLMWw6VEWwVn?=
 =?us-ascii?Q?cDV6IPuSM+znusMfjRssZCtMBThNAlNhtDJT1wPedxAenky8ozO+I21BVkYt?=
 =?us-ascii?Q?iosVnD21qzS2SEVZNj060drMpVl1Eu0qDh7SFr2U6pz9gG6knYExnuZNYvA1?=
 =?us-ascii?Q?jAHoS133DPrlbhdyb2r15WWI/fJJEXEJ8nsEK6blgldPabPPr/lExI5JZjon?=
 =?us-ascii?Q?REbtnjIVVmoNfoSQOo6DSiSWiivtbwo2dmkzVkoN9lOLjlsiED1WnJ7wkPu/?=
 =?us-ascii?Q?fh71v+QlWMCXpiHQHu1+xOQmS7hCtcp2w4V9eZRnJW/0Qdm7ZZT/m85p2DGS?=
 =?us-ascii?Q?fDRwhRnt7RVPDKNUai4wUq4Ie7ISK7HjMGwRROpPWPn9OTGVZ0MuZFrv2BHt?=
 =?us-ascii?Q?ByCN0myEUCJ39Mzu4KBrAhymfYHoRfEnStkCctNQGAoVOVJW5JIgqsynnSc1?=
 =?us-ascii?Q?ty/azISsWUeWi07J+XcqyU9XTTPJwh3n1JP6r0WByKbKlSetoTpZ5UfAkMIJ?=
 =?us-ascii?Q?sdVpsRd6SrytUZXB6QD7gmt9uAEzGPfkOhGsCknzUJMyH/Hqxn9H00P9UAF2?=
 =?us-ascii?Q?q6Z43GcH3hvYwC5QtjRVptgA9PwqsQk+NL+wsht/Y/i3hpY85vcg3F9RPmXt?=
 =?us-ascii?Q?GJs5qaXOosMSRkZH8b6W6P98fieZPjt8bD8H218pX0y/S3b979YgEGumDvMm?=
 =?us-ascii?Q?6pG/t4VQceymVFZr3Zp84fOJam+Bx/xIu/qqNX1op1B30tYwAS2IoYNK1CYn?=
 =?us-ascii?Q?npZWZ1qDPYlrAFL1FKUQzdo8Lyax3yqfgUdiMOy/YpzKqD//+lRtr2O/pV7o?=
 =?us-ascii?Q?84u1uBf5lido/Y9D9eSffkta7xgHVuC5rFEkpSi0Ogte28gRfRHNEccUxeSL?=
 =?us-ascii?Q?GfnjlaCYXVVn+nJMUU+6moCz8fMtsDRzxagpQnvk0KTl+PHGEl+VSv7tYosv?=
 =?us-ascii?Q?aH8h4kijnfUGANcBpAagT6cn/BPinEjxbdvPSljl6djrVVd/daw3N+ps5V3O?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f42cbc6-191d-46d8-363a-08db101198e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 11:33:16.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUinV+a/QELgwgkifDKFf4uZjbXQ0QLUnHOIoT6rmJO+TdzfmnVTn2VTd1cGBhg37gxw2m8Kddr2Li5Te5WSyah9SFtwrr+UTCYvWuReF84a1Nw5TqyK483DwyBIFXBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Thursday, February 16, 2023 3:33 AM
>=20
> On Fri, Feb 10, 2023 at 10:49:15PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > This controller doesn't support MSI-X interrupt. So, introduce
> > no_msix flag in struct dw_pcie_host_ops to clear MSI_FLAG_PCI_MSIX
> > from dw_pcie_msi_domain_info.
> >
>=20
> > Note that this controller on R-Car S4-8 has an unexpected register
> > value on the dbi+0x97b register. So, add a new capability flag
> > which would force the unrolled eDMA mapping for the problematic
> > device, as suggested by Serge Semin.
>=20
> Please move the noted fix to a separate pre-requisite patch seeing your
> update depends on it. Thus this patch will be a bit simpler to review
> with no harm to the changes atomicity.

There is other patch though, I think Lorenzo prefers non separated patch:
https://lore.kernel.org/all/Y245ZtqqqelXif+Y@lpieralisi/

But, Lorenzo, what do you think?

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-designware-host.c |   3 +
> >  drivers/pci/controller/dwc/pcie-designware.c  |   8 +-
> >  drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 165 +++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 166 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  63 +++++++
> >  8 files changed, 419 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 434f6a4f4041..94805ec31a8f 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -414,4 +414,13 @@ config PCIE_FU740
> >  	  Say Y here if you want PCIe controller support for the SiFive
> >  	  FU740.
> >
> > +config PCIE_RCAR_GEN4
> > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> > +	  This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index bf5c311875a1..486cf706b53d 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) +=3D pcie-tegra194.o
> >  obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> > +pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host=
.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index 9952057c8819..5aefeec15c9b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -242,6 +242,9 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> >
> >  	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
> >
>=20
> > +	if (pp->no_msix)
> > +		dw_pcie_msi_domain_info.flags &=3D ~MSI_FLAG_PCI_MSIX;
>=20
> Changing static data field in the probe path doesn't seem like
> correct. Is it really that necessary to clear out that flag?

I didn't investigate the detail, but even if clearing this flag
disappeared, it seemed to work.

> The rest
> of the LLDDs don't seem to be bothered with that (mine included). On
> the other hand it seems to me that the iMSI-RX engine doesn't really
> support true MSI-X messages. It always stick to a single base address
> with up to 256 IRQs in total and up to 32 IRQs per function. Do you
> suggest to drop that flag then for all DW PCIe hosts or just for ones
> with iMSI-RX engine in-use or just forget about it?

I assumed almost all controller supported MSI-X, so that I suggested
to drop the MSI_FLAG_PCI_MSIX flag if needed.

> @Rob, @Bjorn?
>=20
> > +
> >  	pp->msi_domain =3D pci_msi_create_irq_domain(fwnode,
> >  						   &dw_pcie_msi_domain_info,
> >  						   pp->irq_domain);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index b4315cf84340..7d649ba387f8 100644
>=20
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -847,8 +847,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *=
pci)
> >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> >  	 * thus no space is now reserved for the eDMA channels viewport and
> >  	 * former DMA CTRL register is no longer fixed to FFs.
> > +	 *
> > +	 * Note some devices for unknown reason may have zeros in the eDMA CT=
RL
> > +	 * register even though the HW-manual explicitly states there must FF=
s
> > +	 * if the unrolled mapping is enabled. For such cases the low-level
> > +	 * drivers are supposed to manually activate the unrolled mapping to
> > +	 * bypass the auto-detection procedure.
> >  	 */
> > -	if (dw_pcie_ver_is_ge(pci, 540A))
> > +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> >  		val =3D 0xFFFFFFFF;
> >  	else
> >  		val =3D dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTR=
L);
>=20
> As I suggested in the head of this message please move this to a
> separate pre-requisite patch.

I would like to know Lorenzo's preference.

> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 1a6e7e9489ee..1b1af514b849 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -51,8 +51,9 @@
> >
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
>=20
> > -#define DW_PCIE_CAP_IATU_UNROLL		1
> > -#define DW_PCIE_CAP_CDM_CHECK		2
> > +#define DW_PCIE_CAP_EDMA_UNROLL		1
> > +#define DW_PCIE_CAP_IATU_UNROLL		2
> > +#define DW_PCIE_CAP_CDM_CHECK		3
>=20
> ditto
>=20
> >
> >  #define dw_pcie_cap_is(_pci, _cap) \
> >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > @@ -303,6 +304,7 @@ struct dw_pcie_host_ops {
> >  struct dw_pcie_rp {
> >  	bool			has_msi_ctrl:1;
> >  	bool			cfg0_io_shared:1;
> > +	bool			no_msix:1;
> >  	u64			cfg0_base;
> >  	void __iomem		*va_cfg0_base;
> >  	u32			cfg0_size;
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers=
/pci/controller/dwc/pcie-rcar-gen4-host.c
> > new file mode 100644
> > index 000000000000..d60f4895ffe9
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,165 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret =3D rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
> > +
> > +	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> > +	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(dw);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		/* Enable MSI interrupt signal */
> > +		val =3D readl(rcar->base + PCIEINTSTS0EN);
> > +		val |=3D MSI_CTRL_INT;
> > +		writel(val, rcar->base + PCIEINTSTS0EN);
> > +	}
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > +
>=20
> > +	dw_pcie_setup_rc(pp);
> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
> > +	rcar_gen4_pcie_set_max_link_width(dw, dw->num_lanes);
> > +	dw_pcie_dbi_ro_wr_dis(dw);
> > +
> > +	if (!dw_pcie_link_up(dw)) {
> > +		ret =3D dw->ops->start_link(dw);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Ignore errors, the link may come up later */
> > +	if (dw_pcie_wait_for_link(dw))
> > +		dev_info(dw->dev, "PCIe link down\n");
>=20
> This whole procedure is done in the dw_pcie_host_init() method (@Rob
> already noted that a bit earlier). The only exception is the
> rcar_gen4_pcie_set_max_link_width() method, which I suggest to move
> the generic code (see further for more details).

I investigated this and then I found they can be just removed.
# This is related to the following patch. After I applied the following,
# I can remove the above codes.
# https://lore.kernel.org/linux-pci/20230216092012.3256440-1-yoshihiro.shim=
oda.uh@renesas.com/

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops =3D {
> > +	.host_init =3D rcar_gen4_pcie_host_init,
> > +};
> > +
> > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar,
> > +				   struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	struct dw_pcie_rp *pp =3D &dw->pp;
> > +	int ret;
> > +
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +	pp->no_msix =3D true;
> > +	dw_pcie_cap_set(dw, REQ_RES);
> > +
> > +	ret =3D dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to initialize host\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > +}
> > +
>=20
> > +static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +					struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +
> > +	/* Renesas-specific registers */
> > +	rcar->base =3D devm_platform_ioremap_resource_byname(pdev, "app");
> > +	if (IS_ERR(rcar->base))
> > +		return PTR_ERR(rcar->base);
> > +
> > +	return rcar_gen4_pcie_devm_reset_get(rcar, dw->dev);
> > +}
>=20
> Please note that after fixing the RCAR PCIe EP DT-bindings to permit
> the "app" instead of "appl" named reg property (see my note the RCAR
> PCie EP DT-bindings patch) the method above will be identical in the
> RCAR RP and EP driver implementations. So you'll be able to move it
> to the pcie-rcar-gen4.c driver.

I think so. I'll modify it.

> > +
> > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie *rcar;
> > +	int err;
> > +
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(dev);
> > +	if (!rcar)
> > +		return -ENOMEM;
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar, pdev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_dw_pcie_rp(rcar, pdev);
> > +	if (err < 0)
> > +		goto err_add;
> > +
> > +	return 0;
> > +
> > +err_add:
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return err;
> > +}
> > +
> > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > +	{},
> > +};
> > +
> > +static struct platform_driver rcar_gen4_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_probe,
> > +	.remove =3D rcar_gen4_pcie_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > new file mode 100644
> > index 000000000000..a6a29d6125c8
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series =
SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +/* Renesas-specific */
> > +#define PCIERSTCTRL1		0x0014
> > +#define  APP_HOLD_PHY_RST	BIT(16)
> > +#define  APP_LTSSM_ENABLE	BIT(0)
> > +
> > +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> > +					bool enable)
> > +{
> > +	u32 val;
> > +
> > +	val =3D readl(rcar->base + PCIERSTCTRL1);
> > +	if (enable) {
> > +		val |=3D APP_LTSSM_ENABLE;
> > +		val &=3D ~APP_HOLD_PHY_RST;
> > +	} else {
> > +		val &=3D ~APP_LTSSM_ENABLE;
> > +		val |=3D APP_HOLD_PHY_RST;
> > +	}
> > +	writel(val, rcar->base + PCIERSTCTRL1);
> > +}
> > +
> > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	u32 val, mask;
> > +
> > +	val =3D readl(rcar->base + PCIEINTSTS0);
> > +	mask =3D RDLH_LINK_UP | SMLH_LINK_UP;
> > +
> > +	return (val & mask) =3D=3D mask;
> > +}
> > +
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > +}
> > +
> > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool r=
c,
> > +				   int num_lanes)
> > +{
> > +	u32 val;
> > +
> > +	/* Note: Assume the reset is asserted here */
> > +	val =3D readl(rcar->base + PCIEMSR0);
> > +	if (rc)
> > +		val |=3D DEVICE_TYPE_RC;
> > +	else
> > +		val |=3D DEVICE_TYPE_EP;
> > +	if (num_lanes < 4)
> > +		val |=3D BIFUR_MOD_SET_ON;
> > +	writel(val, rcar->base + PCIEMSR0);
> > +
> > +	return reset_control_deassert(rcar->rst);
> > +}
> > +
>=20
> > +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg)
> > +{
> > +	dw_pcie_writel_dbi(dw, SHADOW_REG(bar_mask_reg), 0x0);
> > +}
> > +
>=20
> Hm, this seems like a DBI2/DBI_CS2 CSRs. By default the DW PCIe core
> driver assumes that the DBI2 is defined within the 0x1000 offset with
> respect to the DBI space (see dw_pcie_get_resources()). In your case
> it must be within 0x2000 offset (judging by the SHADOW_REG() macro).
> What about either defining the "dbi2" reg-named DT-property in the
> DT-bindings (see DW PCIe RP/EP generic DT-bindings) or re-defining
> the dw_pcie.dbi_base2 field in your LLDD?
>=20
> Note the dbi_cs2 space is currently utilized in the DW PCIe EP driver
> only in the framework of the BARs mapping setup procedure. Are you
> sure it's working well in your case seeing the DBI2 base address is
> most likely incorrectly initialized? Anyway if you get to define the
> dbi_base2 field properly you'll be able to use the
> dw_pcie_ep_reset_bar() method in the EP driver instead of the function
> above (please see the way it's utilized in the rest of the DW PCIe EP
> low-level drivers).

Thank you for your comments. I'll investigate it.

> Another question. Are you sure the method above is relevant to the DW
> PCIe Root Port controller? I don't see any shadow registers defined
> for the host BARs in any HW-manual I've got (4.60, 4.70, 4.90, 5.20,
> 5.30, 5.40). What are they used for anyway?

To be honest, I reuse this code from our BSP which other guy made.
So, I'll investigate it.

> > +void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *dw, int num_lan=
es)
> > +{
> > +	u32 val =3D dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
> > +
> > +	val &=3D ~PCI_EXP_LNKCAP_MLW;
> > +	switch (num_lanes) {
> > +	case 1:
> > +		val |=3D PCI_EXP_LNKCAP_MLW_X1;
> > +		break;
> > +	case 2:
> > +		val |=3D PCI_EXP_LNKCAP_MLW_X2;
> > +		break;
> > +	case 4:
> > +		val |=3D PCI_EXP_LNKCAP_MLW_X4;
> > +		break;
> > +	default:
> > +		dev_info(dw->dev, "Invalid num-lanes %d\n", num_lanes);
> > +		val |=3D PCI_EXP_LNKCAP_MLW_X1;
> > +		break;
> > +	}
> > +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_LNKCAP), val);
> > +}
>=20
> This seems to be a generic action. What about moving it to
> pcie-designware.c implementing a function similar to
> dw_pcie_link_set_max_speed(), which would be called in
> dw_pcie_setup()?

Rob also suggests it. So, I'll investigate it.

> It could be named as dw_pcie_link_set_max_(link_)?width() and besides
> of the code above would consist of the PCIE_PORT_LINK_CONTROL and
> PCIE_LINK_WIDTH_SPEED_CONTROL CSR initializations performed in
> dw_pcie_setup().

Thank you for your comments.

> * Please do that in a separate pre-requisite patch.
>=20
> > +
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +	int err;
> > +
> > +	pm_runtime_enable(dev);
> > +	err =3D pm_runtime_resume_and_get(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> > +		pm_runtime_disable(dev);
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct device *dev =3D rcar->dw.dev;
> > +
> > +	if (!reset_control_status(rcar->rst))
> > +		reset_control_assert(rcar->rst);
> > +	pm_runtime_put(dev);
> > +	pm_runtime_disable(dev);
> > +}
> > +
> > +int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
> > +				  struct device *dev)
> > +{
> > +	rcar->rst =3D devm_reset_control_get(dev, NULL);
> > +	if (IS_ERR(rcar->rst)) {
> > +		dev_err(dev, "Failed to get Cold-reset\n");
> > +		return PTR_ERR(rcar->rst);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops =3D {
> > +	.start_link =3D rcar_gen4_pcie_start_link,
> > +	.stop_link =3D rcar_gen4_pcie_stop_link,
> > +	.link_up =3D rcar_gen4_pcie_link_up,
> > +};
> > +
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
> > +{
> > +	struct rcar_gen4_pcie *rcar;
> > +
> > +	rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > +	if (!rcar)
> > +		return NULL;
> > +
> > +	rcar->dw.dev =3D dev;
> > +	rcar->dw.ops =3D &dw_pcie_ops;
> > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > +
> > +	return rcar;
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.h
> > new file mode 100644
> > index 000000000000..1cdce0cf7dac
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series =
SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#ifndef _PCIE_RCAR_GEN4_H_
> > +#define _PCIE_RCAR_GEN4_H_
> > +
> > +#include <linux/io.h>
> > +#include <linux/pci.h>
> > +#include <linux/reset.h>
> > +
> > +#include "pcie-designware.h"
> > +
>=20
> > +/* PCI Express capability */
> > +#define EXPCAP(x)		(0x0070 + (x))
> > +/* ASPM L1 PM Substates */
> > +#define L1PSCAP(x)		(0x01bc + (x))
> > +/* PCI Shadow offset */
> > +#define SHADOW_REG(x)		(0x2000 + (x))
> > +/* BAR Mask registers */
> > +#define BAR0MASKF		0x0010
> > +#define BAR1MASKF		0x0014
> > +#define BAR2MASKF		0x0018
> > +#define BAR3MASKF		0x001c
> > +#define BAR4MASKF		0x0020
> > +#define BAR5MASKF		0x0024
> > +
>=20
> * If you get to take some of my notes above into account you'll be able t=
o
> drop these macros...

I got it.

> > +/* Renesas-specific */
> > +#define PCIEMSR0		0x0000
> > +#define  BIFUR_MOD_SET_ON	BIT(0)
> > +#define  DEVICE_TYPE_EP		0
> > +#define  DEVICE_TYPE_RC		BIT(4)
> > +
> > +#define PCIEINTSTS0		0x0084
> > +#define PCIEINTSTS0EN		0x0310
> > +#define  MSI_CTRL_INT		BIT(26)
> > +#define  SMLH_LINK_UP		BIT(7)
> > +#define  RDLH_LINK_UP		BIT(6)
> > +#define PCIEDMAINTSTSEN		0x0314
> > +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
>=20
> Vendor-specific prefix would make the code using these macros much
> more readable.

I got it. I'll rename them.

> > +
> > +struct rcar_gen4_pcie {
> > +	struct dw_pcie		dw;
> > +	void __iomem		*base;
> > +	struct reset_control	*rst;
> > +};
> > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > +
>=20
> > +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> > +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 v=
al);
>=20
> I don't see these two methods being defined in your driver. Are these
> artefacts from the previous patch revisions?

Oops. I'll remove them.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool r=
c,
> > +				   int num_lanes);
>=20
> > +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg);
> > +void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int num_la=
nes);
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > +int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *pcie,
> > +				  struct device *dev);
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
> > +
> > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > --
> > 2.25.1
> >
> >
