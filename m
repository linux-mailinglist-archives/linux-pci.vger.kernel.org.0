Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936537A5A6F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjISHEE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 03:04:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C38102;
        Tue, 19 Sep 2023 00:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGKjjVjlhagB5JOMc+N6kKFem8pB9Wk0EyPK6tcgyzg4M6UWBH64pQx89LOaF0Hyj3cJdA0OVjJufr002fZDKKp66FsAuPhWNiPPyZ3OEHMkaMdNTSMcHJntNtizd19D04WJ/e3r3ORAmA+A8ji1TvQnzfGm7556vPcGkA2mGpq9X4aGX1Z/gt6fbe5RRgQHw8dE0gjlcA2/kioH1ZVqk+ZO8mOZaFOlFk400gwpxZH/n53gzfq2TVqtDOv8WbgsgCmECET6lFnTahLpK6oC2m6LWgheuGI3dqywhCj0Zt82F8YrUZ6azs5eJfcUdMfr9hzXkro4fjEKJGd7YbYsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyOOkdbft3kP0c+fpmWbygy/V4xDg2jlcvYxpQBxpT4=;
 b=bxUAHmYKPWhzpVV9z22qN2Lo/W1686f9+16rAK4Xz/bzDDXKXRdASr0qy7pKoMvintDAVtQXKvM6HZJE3ljaeDtieLtUEpFX1RBZHV9DG33Vv61isFYHshy/4qhUxz8b8ia0YIFlaSiq7nhb2zTyvBq0gUA8xgrnZ246Zna8x6QnH2yH6EABKM7MARTmYwLgGg/wmVVXq+UY6zv2PbWnfqK482/xnuIMKqEmg8OgdTKEFdvqAuh4VHyy2zH8Pr7J7l3T5sNBUkKz033Pktpdv1eZu1BcpEGQVR7WKPBGoHsRMZYFTZE9X7L3LJ3XJq7yuCfFoVLaEatFpeQm0l9DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyOOkdbft3kP0c+fpmWbygy/V4xDg2jlcvYxpQBxpT4=;
 b=iUpZRl3Bn6VcvQ2N6bNBEVnF1oMypLh2YvYon0lBRvLrWC4/OLISti7DzncLKeLLTEY7QaiNigxS6yoYU9sEKIHw6+eUzaCgqQ1T0zzr/gw25WJQVNee3deMFmZfoD0a10ijRQRNIYbYPHXVj0V41BZ7x7QxzxO6+JsY1rIS/Iw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB8663.jpnprd01.prod.outlook.com
 (2603:1096:604:16c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 07:03:51 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:03:51 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZ1zcPesbymzM/EkSeMq7i4076ZrAapFqAgADBUNCAARUUAIAFYMhw
Date:   Tue, 19 Sep 2023 07:03:51 +0000
Message-ID: <TYBPR01MB53419C8CEE878270933E7C2AD8FAA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB534112A636FAFB61A4038337D8F6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230915203830.GA105215@bhelgaas>
In-Reply-To: <20230915203830.GA105215@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB8663:EE_
x-ms-office365-filtering-correlation-id: f4f6ba7f-42d0-4bc6-6cd2-08dbb8de9458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xye9YEwZkvrDlgNHrtV2a01y5W/GiEDbjdEoHRkg8/DUlPW92Q2eUlJqzpXDK0b+FlluJob5ISv2d9x/PDdFkuBvdf7QrmFjY0a/O0jub5rRKvDIi82ihuExEsIFOas5uHVdejH137DiRUFDVu8YNatLbJ8UEIIbj/C5a5o5mMgImfcsTuKzEgNfBL/RDaY8Hs9lF8zQupvnMufHHo8lhV+LcCdo0HH89AFLB5hXaDUczAoNt0uRmkJFjwI0UuEZ6eY0wWQInZDxpX2LxqL8aocuC5JxmIGbpodMjnhItu4By+v9of2iXd4AZUwle3Ncf5zvIqfKwsgmJM85ni83hLe0c7KpOpUuxkHMnET9skbS87Bs+s5o+Xhd7FmrFhgExtlPOYm+wUUQHeMaVlTsEmUbvrN4MxdbUk0qWFP579Old8CgEzXwLseUZHkj4QeV3t9xLz4k5PmJlyR1GDY4x5gFc+9mWjLLRrYoF/psklQN5HgAfVxYhpdhwY4O20IwkPX+LeUkdArmIhRXIx49uy5FsBlijqMn9KKeZsdnv/vpDD6QVZXdDDwE/erAA2TiUv8Ah4AY1w5fqdUOCSqvpedn9OOatUytC89K5+IVdxI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(6506007)(478600001)(966005)(55016003)(71200400001)(83380400001)(2906002)(5660300002)(86362001)(7696005)(52536014)(7416002)(66899024)(122000001)(41300700001)(76116006)(6916009)(66476007)(9686003)(64756008)(66446008)(316002)(66556008)(8676002)(4326008)(38070700005)(38100700002)(8936002)(54906003)(33656002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w09fd+io3lyK88TG3LzTswlOF87YaB9M7kV70Zt3Q5t7kmwVXeXU12moXL1v?=
 =?us-ascii?Q?Th8sIrdLOl0MzUglNS1OJF6aATntNqX0MIgVvdOJHfz6tXi/pmZycwTu0In1?=
 =?us-ascii?Q?L28DR+WMXK1efOslAXP7Zwm4TrG6J4ClvzCc+LzutWbBVkmHEZzA7ZSjct6R?=
 =?us-ascii?Q?eI1KJSnTP4CnRCgxfrhy/Xk9olIhC2UEH7RdpLYnm2Xoi2hPmLcrcXx4Lk+Y?=
 =?us-ascii?Q?2QW0XEbxPTIlrWA3vYKhuMPCXl/iBVYAxEGqUnx0B1mBIo1+CL4Q9jHcngvK?=
 =?us-ascii?Q?N9EY/WJ35Gb+VpMY93inTvKk8M3EXik3GrAq5fhDhbTyq+LAOTQaI+Vqs+IY?=
 =?us-ascii?Q?qSpQBk06plUMpYi64ph7u6wkkNgkSIO3acXBUHMWQhPAZi2sTN4WUBQaZsAq?=
 =?us-ascii?Q?2pZPKopiVWhFQZR2QXYQep3Q6+Tfjqpzk5qzLlKgtwWmCrl+EdTL2jVGl6mL?=
 =?us-ascii?Q?kYfSVyKkTIiYs9/x8W1jAfckLpN/QM2D7jrXPof6SPlhwZMStwt50ovxlyOg?=
 =?us-ascii?Q?uRuY+ITIL7eD9Hy+XiDzOSmsqJoF+0bk5MkjaJ0YIkKyuTHMxON6wsOZlh4a?=
 =?us-ascii?Q?KWNZqQgJnIjYo1pv7aBu6Yymqxb9s9MjBoonpPI0H4bVkmJHKzua+o/7sM4k?=
 =?us-ascii?Q?HpOgc+katDFr7r3Ma10i6XUgVRrhOQVolDByQZGNDpm2PLJ+6aUUtf6oaStX?=
 =?us-ascii?Q?Ht0Ox2zLyKlJCgctHLYCmCGKrRNv9bpEcqOw0xayN0D12jdmFD/TTbxQRkBm?=
 =?us-ascii?Q?3obtuukei+uknR4a7NWdZ8P1Sh/FNKMXtybZkLSGEIBEnMDug0PEeIm6tjLt?=
 =?us-ascii?Q?Tjn9AkZruoUQawXkqTGCT2t6QuOCHnNoq0F8R/S6BttMq1R5LU+dExEEFwSL?=
 =?us-ascii?Q?0cZja0S4e5mmZ99ueCKuw7xZu9JfcA3oW8sf+L2gfYhkd460F46NdyhlmKmQ?=
 =?us-ascii?Q?oIYVNo0VsNWyUuzFCLXzjmJdSUJqP9PiScizXz7Jsvo4gpzRW7Jv0uF5Kk/b?=
 =?us-ascii?Q?N+TOa2MA+vnSB/SEcWAWzISSZLaTpUbg3USJCGV6SgEippcCw9ZKxmV1GStr?=
 =?us-ascii?Q?UZlNLCLpfXJTRquOJHx7pfW91uVPDdD1Qsmcj61xGvXRLibTMz6VAbaGNlcq?=
 =?us-ascii?Q?Es0SeBq3iblKWpbrmUM/TW8bFjJa/n5BPQu4EdxdAJWQX6XDFhRYRVaFIzbS?=
 =?us-ascii?Q?GOyqnna33WGDWtXlWDpxg0fPLOcs5lI9ae/7CuF1ZssSv/2aP5F1DqQkMCqp?=
 =?us-ascii?Q?1N0O7ygEtJ4Qhi2rydGw2xPc/EQc7l/3Vyzpr3dHU+Wc90iGXFxw7sFh04As?=
 =?us-ascii?Q?5ROSI5Um/sd+tkwAALEl97zQo/EjB5aMyC1z2vp4k/ECMmTMk9hFxvJk5Tii?=
 =?us-ascii?Q?x0ruqo9h+2VoaBZGC/i3CQwgUcwtzWC9RfOwwNz1vhtZI4TjcUDfqzUykF+n?=
 =?us-ascii?Q?Uq6NMwlVGppIKlgOzoZxgHNMhdUlcws0RBzSXDnb3d8GWgjL1znz57+zUxgG?=
 =?us-ascii?Q?LEuQyqB78NUo3R5348mzO8dNEAfZuLVi+/phaKaoRAzdVT7xMie7ZmU3iWni?=
 =?us-ascii?Q?nc7WHdJxqD09BV8GM+ruJQqMZKJ++m62zsTWcTKLfDOQYndj6DLt2gcM22TM?=
 =?us-ascii?Q?/TrfD8Xc/a43j1cPr0u3HT1wwb+0xXeQFt0Ay/4PoCnqjMLg+qTCrloG83aa?=
 =?us-ascii?Q?HmA7uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f6ba7f-42d0-4bc6-6cd2-08dbb8de9458
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:03:51.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXcnMlXfvXspb9pAxt+oQpOh0CRd9W5c93S5AulvubTJlFYNw7PdDTpGeS9EfEJaGtiw0n2joFZ6m/dYIrIW/geMr83Lp/qxfkksf1J6KLZg2MLgFgSevg6gkFORXjQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8663
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

> From: Bjorn Helgaas, Sent: Saturday, September 16, 2023 5:39 AM
>=20
> On Fri, Sep 15, 2023 at 09:37:15AM +0000, Yoshihiro Shimoda wrote:
> > > From: Bjorn Helgaas, Sent: Friday, September 15, 2023 1:35 AM
> > > On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
> > > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > > > registers so that requires initialization code like mode setting
> > > > and retraining and so on.
> > > >
> > > > To reduce code delta, adds some helper functions which are used by
> > > > both the host driver and the endpoint driver (which is added
> > > > immediately afterwards) into a separate file.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig            |  10 +
> > > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > > >  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 135 +++++++++++
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 227 ++++++++++++++=
++++
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
> > > >  5 files changed, 418 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-=
drv.c
> > >
> > > Is "pcie-rcar-gen4-host-drv.c" following some pattern?  I don't see
> > > "-drv" in any nearby filenames.  Typical names are "-host.c" for host
> > > driver and "-ep.c" for endpoint driver.
> >
> > This is not following some pattern on pcie subsystem. But, some
> > other subsystems have "*drv.c" filenames. Manivannan suggested the
> > filenames to rename the module filenames [1].
> >
> > < Now >
> > The source code filenames : pcie-rcar-gen4-{host,ep}-drv.c
> > The module filenames : pcie-rcar-gen4-{host,ep}.ko
> >
> > < Previous >
> > The source code filenames : pcie-rcar-gen4-{host,ep}.c
> > The module filenames : pcie-rcar-gen4-{host,ep}-drv.ko
> >
> > [1]
> > https://lore.kernel.org/linux-pci/20230724122820.GM6291@thinkpad/
> >
> > I don't have a strong opinion on which filenames are good.
>=20
> I have an opinion :)  I think splitting this up into four files is way
> more complicated than it needs to be.  This is all for driving a
> single piece of hardware, and I don't think there's enough benefit to
> split it into separate files.

Thank you for your suggestion! :)

> Most drivers, even those that support both host and endpoint mode, are
> in a single file, e.g., pcie-artpec6.c, pci-imx6.c, pcie-keembay.c,
> pcie-tegra194.c, pci-dra7xx.c, pci-keystone.c.

I got it. I realized that pcie-tegra194.c and pci-dra7xx.c support
both host and endpoint modes without "-host.c" and "-ep.c" files.
So, I'll merge all four files into one file.

> That makes the Makefile very simple and there's only one module name
> to worry about.

I got it.

> > > > +	msleep(100);	/* pe_rst requires 100msec delay */
> > >
> > > Can we include a spec reference for this delay?  Ideally this would b=
e
> > > a #define and likely shared across drivers.
> >
> > I think so. Some other PCIe drivers also call "msleep(100)".
> > So, I'll add a #define into drivers/pci/pci.h.
>=20
> Yes.  I'm trying to move away from "msleep(100)" for everybody so we
> can make sure all the drivers include the appropriate delays and
> they're all based on the same reasoning.

I got it.

> > > > +#define PCIEDMAINTSTSEN		0x0314
> > > > +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > >
> > > These register offsets are hard to decode whenthey'reallruntogether.
> >
> > Unfortunately, these registers' offset names are from the datasheet.
> > Perhaps, adding full register names as comments like below are helpful:
> > -----
> > /* PCIe Interrupt Status 0 */
> > +#define PCIEINTSTS0		0x0084
> >
> > /* PCIe DMA Interrupt Status Enable */
> > #define PCIEDMAINTSTSEN		0x0314
> > #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
>=20
> It's good to use names from the datasheet.  The comments should be
> enough.

I got it.

Best regards,
Yoshihiro Shimoda

> Bjorn
