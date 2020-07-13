Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1321D5D1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgGMMYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 08:24:47 -0400
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:65154
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbgGMMYr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 08:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm+tTxOynYBRrustTQ/WWubPMmDkBHnp/dSLttSQey03c9hv3mpKNOr/LJl0OcBuQznwqRNfcD5yJCc2pEDXa0ZBDdgROoqD2yaigF5Yl5112y92KoYhF5tj3DJ/ejuBcWLShu1AjyRB1Uy5XIaxxdU8ebJP6Bm8N5mhfSpBMdDyP4w3bmtKUOd5I7+XW6u/wraupd0z/TDFXnxf8qk36VYQsA+YOCUEh5JGykAiJuxijgULnmxsZjzCcev7Tma5p5AGwDDLE3ipon8eN0IjjldAx97uFkbAg8qsjSm1suVCgpJqrowcG4etfm9dkIQZx/RP1IyGGhrCDZARszNMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKuihiNaP3X59rQkdAKOMCXakdAnOjwErboEP70Icqg=;
 b=TTZddhkVZFZpY9Tne5YhoFVm4xRX8rT6VsmVNV0yrPoYKDpYniAgo8/PWa+HjpkHPeET7q61wgZZKW3n9vd7xpc/uoQVQ3Xye9XDQs7u82WedX768bDway6L866u1jYghLgsJk3dtTXnf94KuJrGSWchh+I0qdfZh22yvn9MWgKyS7w6+2EWJq3E1bedvW3g4w2PbCqau1Zlb4KZXHRdvH0oLNvYFofJujc60RxIDGSli3BReILyAtDSfT+ViNR6Tfr1ue+kHemwb1TCrBeRhttm7nr3HjpY1ul3vvQxhcteGmTmqVkuawzomIOCpsJjMXjfsl+TpLBSlYv0obGSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKuihiNaP3X59rQkdAKOMCXakdAnOjwErboEP70Icqg=;
 b=Xyci1YtDG/MukFjVxdYw7dHEMn+taBpz0FUtHzZLXObkVg6pilv1AVoSL0eF8Sj+8hD5e5lQYK6Ghn0VmdUuHBdtFh5sifuoq2emxqqN9H0B/eVw4pUA+2uc6tH7bf76lS8jmsPPBxjT/oYKTOP2aRcO7m934N0YC9HwQkvbKsI=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 12:24:44 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 12:24:44 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
CC:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWQ92np3oy3WTBdkWe1KxJ1x02XqkBEpGAgAR2iICAAAek0A==
Date:   Mon, 13 Jul 2020 12:24:44 +0000
Message-ID: <BYAPR02MB5559FBB8597F3B0CD5EF0F22A5600@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJ0WARicxaATS_1h2W2MyXqZ8OGOxOTvWWB+hD70ea_MQ@mail.gmail.com>
 <20200713112613.GB25865@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200713112613.GB25865@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c3ca20c-00ff-42cd-572c-08d82727b9bd
x-ms-traffictypediagnostic: BYAPR02MB5430:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5430768D6DDE8D65ABB10F76A5600@BYAPR02MB5430.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXk1gARrV4KKXCzyjg6UlM4V3ljHG56v98Ahy6TwmCyUTzVcDvAnyMo609JCQLjuI3eSo8/vj/f1XqkIVWD9iS5Cpcu0RTEqIEDWSjCR0tpK3PWclbQs+y+fiJayHxX3jMre2eTtct3nmzaatLQXGaVTbzzQjTcsNk5vou6i+OOwNpzZ2PkA9Ers/BECbU4PIyjhnhaWZUlctoEBAqvIyJ3Xdnv7zhj+n/LQAOz35OpWyp82q1wMLIsw39ZQjyxcgvEee1tO2FY/RurqqhCstN8m81pVfEbMgUe83he2Ne+I6Z9IDKf9Bjs7/yd0frut
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(4326008)(8936002)(83380400001)(64756008)(52536014)(66946007)(66446008)(66476007)(66556008)(7696005)(86362001)(110136005)(26005)(5660300002)(54906003)(2906002)(33656002)(71200400001)(76116006)(6506007)(186003)(9686003)(55016002)(8676002)(53546011)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hPi0KZAjXKlavx2GFZfJsPl9dXdvONzTHVgpd2yT2c3XGgJaaULC2VAzmGBJJlob3SSA/WIAQifgJt5PhrOkrXgg+u42vhvbN9uRR+YCAyMNeCKhiP2JgowkBp/69Xx16rG9+8KlJtubgOBH/8jXr95lyl7LIk/UCkX0T3lrmGEqtf0VAogaYxE00xz25m0KJ6IumglpnfoGy9QzwsIr7gNJoeajXXdn0DoIISG78b755fDm9WnzWM5nc1d1DnGdYYq/WUyC9meuE78jRPOGlJZ/aCxgTR5b3B1dGL+Uk2gnkzvPvsaJNgiykTeBwsa4IAGRdPydxpROe3Wcx6ijp4cSmzpcje2rhn0yP2SgNGPEUXeaPZacMnUy5yBnVsV3JhInfNGiVq77wL3J465vK0/34rlhk/dss4fXHYdKhx25JVn5mBRgkMajcehoZ5WoWbrthhRPEu2RMHGdXXXkVNti+rrgHMpm9Il0+LfC1Aim1o/ImnkOkZKdzHJRr4bI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3ca20c-00ff-42cd-572c-08d82727b9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 12:24:44.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENvA9M3e533R5K+0W2DKuE8rPVIokBSJIFOe/gdpMhxULiT7Zi140euCqxDEddSsYdZq7A+trFf7KmW+DkVc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5430
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Fri, Jul 10, 2020 at 09:16:57AM -0600, Rob Herring wrote:
> > On Tue, Jun 16, 2020 at 6:57 AM Bharat Kumar Gogada
> > <bharat.kumar.gogada@xilinx.com> wrote:
> > >
> > > - Add support for Versal CPM as Root Port.
> > > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The
> integrated
> > >   block for CPM along with the integrated bridge can function
> > >   as PCIe Root Port.
> > > - Bridge error and legacy interrupts in Versal CPM are handled using
> > >   Versal CPM specific interrupt line.
> > >
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ---
> > >  drivers/pci/controller/Kconfig           |   8 +
> > >  drivers/pci/controller/Makefile          |   1 +
> > >  drivers/pci/controller/pcie-xilinx-cpm.c | 617
> > > +++++++++++++++++++++++++++++++
> > >  3 files changed, 626 insertions(+)
> > >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> >
> > [...]
> >
> > > +static int xilinx_cpm_pcie_probe(struct platform_device *pdev) {
> > > +       struct xilinx_cpm_pcie_port *port;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct pci_host_bridge *bridge;
> > > +       struct resource *bus_range;
> > > +       int err;
> > > +
> > > +       bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*port));
> > > +       if (!bridge)
> > > +               return -ENODEV;
> > > +
> > > +       port =3D pci_host_bridge_priv(bridge);
> > > +
> > > +       port->dev =3D dev;
> > > +
> > > +       err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows=
,
> > > +                                             &bridge->dma_ranges, &b=
us_range);
> > > +       if (err) {
> > > +               dev_err(dev, "Getting bridge resources failed\n");
> > > +               return err;
> > > +       }
> > > +
> > > +       err =3D xilinx_cpm_pcie_init_irq_domain(port);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       err =3D xilinx_cpm_pcie_parse_dt(port, bus_range);
> > > +       if (err) {
> > > +               dev_err(dev, "Parsing DT failed\n");
> > > +               goto err_parse_dt;
> > > +       }
> > > +
> > > +       xilinx_cpm_pcie_init_port(port);
> > > +
> > > +       err =3D xilinx_cpm_setup_irq(port);
> > > +       if (err) {
> > > +               dev_err(dev, "Failed to set up interrupts\n");
> > > +               goto err_setup_irq;
> > > +       }
> >
> > All the h/w init here can be moved to an .init() function in ecam ops
> > and then use pci_host_common_probe. Given this is v9, that can be a
> > follow-up I guess.
>=20
> I think there is time to get it done, Bharat please let me know if you ca=
n
> repost it shortly with Rob's requested change implemented.
>
Thanks Rob for your time.
Thanks Lorenzo, the reason I cannot use pci_host_common_probe is,=20
I need pci_config_window locally as the we use same ecam space for local br=
idge register access.
In xilinx_cpm_pcie_parse_dt funciton
port->reg_base =3D port->cfg->win;

If we move to pci_host_common_probe, I will not be able to access controlle=
r registers.
So can we please proceed with existing flow.=20

Regards,
Bharat

> >
> > > +
> > > +       bridge->dev.parent =3D dev;
> > > +       bridge->sysdata =3D port->cfg;
> > > +       bridge->busnr =3D port->cfg->busr.start;
> > > +       bridge->ops =3D &pci_generic_ecam_ops.pci_ops;
> > > +       bridge->map_irq =3D of_irq_parse_and_map_pci;
> > > +       bridge->swizzle_irq =3D pci_common_swizzle;
> > > +
> > > +       err =3D pci_host_probe(bridge);
> > > +       if (err < 0)
> > > +               goto err_host_bridge;
> > > +
> > > +       return 0;
> > > +
> > > +err_host_bridge:
> > > +       xilinx_cpm_free_interrupts(port);
> > > +err_setup_irq:
> > > +       pci_ecam_free(port->cfg);
> > > +err_parse_dt:
> > > +       xilinx_cpm_free_irq_domains(port);
> > > +       return err;
> > > +}
