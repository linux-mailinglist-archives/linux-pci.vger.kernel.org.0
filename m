Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE956C6615
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 12:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCWLET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWLES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 07:04:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4381025D;
        Thu, 23 Mar 2023 04:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDSXJZ9EO3lXrM3Z7zr1ICwlRACrNTiUCqads5UuuLnoo5jk8Hh9ZJ5mphQEF5Zh5IdTc8z9CQnyxmWzZtx5TYaWfzhah3pbvQBx9Jlhd8xZBTRoJOFUmgbhes7gs8jw61SpnoSwlHaGzqBhQiiEk4TCPw6G460LJAY16PNX/LQTu394KAY5upBczz97D08zqWBHLyAbpjMAaxVZGHliwGrTZoxQ+ufaFn0/W0ff6umpwndG3A0iGgfdwwzPxB4KU6t8rfg9sTBgvBtdA5I2wyM1EkCd6ljhBXNnyhvE/ckcyi/fYg6MgJOkVU7fhVqctkQ4Y4BOa5dLqQOkv56i6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjrnAmYb4Jin6BZ0XtEsWcaTJP6FYGNHmM/lm3RFffQ=;
 b=g584cP8RwSvvZoiRkqRiRMuwbWSytOE0anJRIzr0Dxq7LCuBdu8qsoKcjFvCj2c5fPoqg4m+YEVJpyFqhNskdUvbOxdsdnGWJNGp2aDtbCCC4K4OE+tskYyfD9PBaxOcqx4dScFLhGAI0E2RsGMf887y/X73Obcw/KAX0KoReoHSimcgBJz6XBfwZSTuiUD5Sc4xz7lzzhNamp3OT3NKLFc/Tzq7HosijizGImo/B7dZRj4szErrFCgtxkyut7frTLlFY7WSEis4Ad/4i8Zry9wUpDJtqV5DF2mUNFIsaAw4qAmI0cxsB2Lxha1TEFcY+GrA+ldXFfzyU7bJPS1GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjrnAmYb4Jin6BZ0XtEsWcaTJP6FYGNHmM/lm3RFffQ=;
 b=pLKRQ8NvA0JafsJopF+LtTxU8TY+8roFK3TSO6PlC3pQvF5Hi324LdNsY5/JZpn4MGuu5zz+sgfbiGvq2ThF77akBGoWzXMuztHPCPGFH/qbTGyah1/8qyGrzUIFT/ZYbMgng4unFBlsJQUlTW/mA1yzRzPK3CY8sYkyLGFpMDg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8655.jpnprd01.prod.outlook.com
 (2603:1096:400:13c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 11:04:12 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:04:12 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v11 10/13] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v11 10/13] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZU0zERpkb9+pW7UWtywwz3wV3Nq8HHXkAgAEnhoA=
Date:   Thu, 23 Mar 2023 11:04:12 +0000
Message-ID: <TYBPR01MB534104389952D87385E8745ED8879@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-11-yoshihiro.shimoda.uh@renesas.com>
 <20230322171628.4jniegwhln4ong2g@mobilestation>
In-Reply-To: <20230322171628.4jniegwhln4ong2g@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8655:EE_
x-ms-office365-filtering-correlation-id: 5fe7f438-08bd-4431-84ec-08db2b8e559a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7fNnZxv6mKNrFok0hYLLobxM/0QQAKtvpaVUUKokSpTcNYeUMQ1idyvEhKGNvh7IQm6Zt+DWVQ25JhRsQKtnOTr2zBOEWGvlR8En9s+6wbmAV4eoVpgm+l4MmIkfikPB3OTwzni1NzV73F/LO/QwqwGG8ZPj5tgkNnFH7TTCud/b5cKokq1WYK5fqUgcEAdmzpOb9OOWChVS7k+Y9+a0pUPvgzP4ugW/d1GwaiY4TGxxxt1NoHBFvz9qOhCysEROWmZuzwXJvJhT/1hi7O4oxoH4XGvH8W6iWCkN3If4oTWkp1C0vcnQeiN0CRgWVuvLvP/gdhOqnYK7R9Usg1EyKdWQWBQ89DEB9AYEkhdqzwifmhaLrJv0U89urmxzNWewIHovGmSPpoBvI8GaCiNwHVfA4qbU8P0lA/PIJS03e/V2bxA3c3Z9daLZJhpnx6NwbCIZsqmeYwpjpZjec+fcJTouX6baGnwCW3XwzhSqKNbt65WfAL0YgjJctqoc/qX+vHvGKRTiBIKUZa7FJVqPLpfbYXeYvrjr5XsSPcg55lIry6O5Z756i6RQzw5drYr3Vw6PH363ImkJHSfbmNzIBclsbGmrrB7vuzYS5rVdtyhCCeY55/20UvrUqkEPoh+SlQke9GTeC2Jy43HY/wjehTpKc8BlniLSfZLv6Jj/NB06VeOXi7CvTktQKy5fyC3ji80bVD/pJg/WRNJ2YD8Y/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(7696005)(9686003)(186003)(478600001)(6916009)(83380400001)(6506007)(54906003)(66446008)(66476007)(316002)(71200400001)(66946007)(66556008)(76116006)(8676002)(64756008)(4326008)(7416002)(30864003)(8936002)(41300700001)(52536014)(5660300002)(2906002)(122000001)(38100700002)(55016003)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+Gj1jMZ9AXmY2Kvw5Nre84rZeVkps7FS4970iKNi/pyUztdN7ySIpS7PxFK?=
 =?us-ascii?Q?fuanNlhzruA8uf+cbPHTlxHNC9wZoTD5HhVGSYJp7rZaQoB8bO+3N0FWnstx?=
 =?us-ascii?Q?SDfZw+tVU9wG/cJwnjD2/RunebUPwZ/38jVq3iuJTXTfzMBnL0u+d8Rgcxbv?=
 =?us-ascii?Q?SmTCtJp+Mh2oeXcpsV7MBNyPIOSzxFmekyisO2o0NuqgPD1kzJTF3iE9F7Kq?=
 =?us-ascii?Q?Ogrn7gOWtH1MUy5gxXIJVL1NlWo8QQ7c3CylsdtBkUt5a/7gyt03JdCeP85J?=
 =?us-ascii?Q?Ky6KQM9aMdim/W1RqNzwirpOFA8e3O6wObbWHz6QOWOHEwiuHCahfT49BvN1?=
 =?us-ascii?Q?ymQMn2SZdcaTO5uqwe/U5nIbr94LTx2Zu4dDv1o5ZvvcZaRrifqPP0/jmKH5?=
 =?us-ascii?Q?UbW8Bxhwi+kdoK/tfCpvbURu4VT/aTiAnfpCVasJzynuLJX/y2JMyd3Nz+K5?=
 =?us-ascii?Q?znjxmRtZR+7zvFay9D21cDPocc17yqIGy+JH0Km3hkXpqUIA3c7bNEwFl/Cv?=
 =?us-ascii?Q?xBUz40A0GD0Kk+UgpzoURpvtSo3/5oPc7qjLzvdy7k3WC8nC0dSX0iFQRtqL?=
 =?us-ascii?Q?5cztgNOmF7iBWGDMX/Yxfn4L55VSJDGGHKqeDCNVwXUsyqUfVjOmnm5RfQz4?=
 =?us-ascii?Q?DrP/Yv+ndYeq5llLzDnWlzVh+tztiYN0+nXTpRwFe2ZBVrzaQxJlJDusAUJF?=
 =?us-ascii?Q?/nYV++4b6kxr0jXwah+BpVu3oAkydu6xSG1W6KNz4AO10rtiXpkPzJvfdZ0L?=
 =?us-ascii?Q?YCSeOtHWYOQZnf8vnG1Ot9QLhnTFf8hWRkjy6ztbqJzLx9T1eZGyVSC4z8z8?=
 =?us-ascii?Q?+jKuquX2wtLYvXbmuy2f/0x4thl/EaQfxLZVkEey5fl0UucyjqUSIzVTmZjY?=
 =?us-ascii?Q?Dt8PibiB3ZhcK3CpUYdTeY11YSIeGjZWnzBsJFhTcA/efDCCgUto93b0uheB?=
 =?us-ascii?Q?w49PATVOp2Vztwq0/J7fNLWic7tySJ9bvdxtx78W8WsrqBq1a84ndZT8wjuS?=
 =?us-ascii?Q?zM6R1vmvOYkMRpnXzJUVJ004S33d95+im5qpJmngOav8zwSt/DHUWdU69+nE?=
 =?us-ascii?Q?G7iVhuOeFbIyqYiSRLEtBoH8EOMcqDWMZmft+7p966esbDR1cu9I9hpXBb0g?=
 =?us-ascii?Q?Ad1tg2pLdyAVZrowAPzHnIW0cXk/AQQGRK1sClY2f+lXfbRHY8l0nMyUj3Za?=
 =?us-ascii?Q?IIkqTPqq26aQ9UA3LcjsbLdh9WHx+rokDtsWsiHv1ZglTyRJsq0/97SdYZIJ?=
 =?us-ascii?Q?3dzGQY9dGktqPoX1XYKoz2zJU6QbxICiCpLMUEhWBjQ0rqwQnz09XPZuOGjI?=
 =?us-ascii?Q?/qnqaOfp+fro+u3O9yICcxmISdlREh/uc/xUamIPpS6AWesEVWWl/gyV445v?=
 =?us-ascii?Q?BkrK9LdPjEBfsAauyhqoGsuyfiG6DWsxhEspOmAMd/dIZwY31wNZc4P9KdeX?=
 =?us-ascii?Q?hFnPqaIvOnJtAfSvmKMG1cptHLQneY58L5Ix+KREyNc1NX4vMw/Nv3byzFXm?=
 =?us-ascii?Q?KrSsFgx5mBnG8AzOOgwBZKX2kVmTMUINKsm8oAhH4YgC3sYGRzOEB1OxgqU7?=
 =?us-ascii?Q?YqXChUnGzjeBIuYY/56YsaMwKehhuAH1p1UaS8fAcFgjuHdGpog4H5piOkuI?=
 =?us-ascii?Q?scyUPxR6ubrSy5LZ9ZIqRuw3wKqxqvyonIckJBUIOkWmJIrAxxVsXQ+gm9hk?=
 =?us-ascii?Q?ujWw0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe7f438-08bd-4431-84ec-08db2b8e559a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:04:12.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGTHYlUbQyTgWGfqZuLaUw9xGVxoVhzWPIdCzTe5tltU+Ik8+xabTa04hQcdU3LuaYuhNHjMB/M+qvk7LY+pllOpTxrbQ+HFgqRsmXlpzUl+U6IZiUS7shCEiQNwhAVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8655
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Thursday, March 23, 2023 2:16 AM
>=20
> On Fri, Mar 10, 2023 at 09:35:07PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > This controller doesn't support MSI-X interrupt. So, introduce
> > no_msix flag in struct dw_pcie_host_ops to clear MSI_FLAG_PCI_MSIX
> > from dw_pcie_msi_domain_info.
> >
> > Note that this controller on R-Car S4-8 has an unexpected register
> > value on the dbi+0x97b register. So, add a new capability flag
> > which would force the unrolled eDMA mapping for the problematic
> > device, as suggested by Serge Semin.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  drivers/pci/controller/dwc/pcie-designware.c  |   8 +-
> >  drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
> >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 +++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 156 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  56 +++++++
> >  7 files changed, 367 insertions(+), 3 deletions(-)
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
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 364926832126..6827d42fcb2c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -882,8 +882,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *=
pci)
> >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> >  	 * thus no space is now reserved for the eDMA channels viewport and
> >  	 * former DMA CTRL register is no longer fixed to FFs.
>=20
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
>=20
> Again. Please detach to a preparation patch. Even though it's related
> to your driver it's still a generic separate feature and having it
> applied together with your driver doesn't really make it more coherent
> but more complex.

I got it. I'll make such a patch on v12.

> >  		val =3D 0xFFFFFFFF;
> >  	else
> >  		val =3D dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTR=
L);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 3dbadb8043ab..1be74d2c3729 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -51,8 +51,9 @@
> >
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
> > -#define DW_PCIE_CAP_IATU_UNROLL		1
> > -#define DW_PCIE_CAP_CDM_CHECK		2
> > +#define DW_PCIE_CAP_EDMA_UNROLL		1
> > +#define DW_PCIE_CAP_IATU_UNROLL		2
> > +#define DW_PCIE_CAP_CDM_CHECK		3
> >
> >  #define dw_pcie_cap_is(_pci, _cap) \
> >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers=
/pci/controller/dwc/pcie-rcar-gen4-host.c
> > new file mode 100644
> > index 000000000000..4aaecc813d85
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > @@ -0,0 +1,134 @@
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
>=20
> > +	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> > +	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
>=20
> I'll ask it one more time. Why do you need these calls? None of the
> DW PCIe RC glue-drivers perform the BARs disabling. Moreover you won't
> disable them by using the methods above because there is no shadow
> DBI2 CSRs behind the TYPe1.BAR{0,1} CSRs. So AFAICS you can just drop
> the calls.

If I remove these setting, the controller cannot work correctly. However,
To be honest, I don't know why these settings are needed. So, I'll investig=
ate why
and add comments.

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
>=20
> This will be done shortly after this function returns. Why do you need
> it here? AFAICS you can drop it.

Thank you for pointed it out. You're correct. I can drop it.

> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
>=20
> > +	dw_pcie_num_lanes_setup(dw, dw->num_lanes);
>=20
> * Please see my note to the respective patch.
>=20
> So if all my suggestions are implemented the rcar_gen4_pcie_host_init()
> will contain only the true platform-specific initializations.

I got it. I'll drop this.

> > +	dw_pcie_dbi_ro_wr_dis(dw);
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
> > +
> > +	pp->ops =3D &rcar_gen4_pcie_host_ops;
> > +	dw_pcie_cap_set(dw, REQ_RES);
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > +}
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
> > index 000000000000..4908892e413b
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -0,0 +1,156 @@
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
> > +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg)
> > +{
> > +	dw_pcie_writel_dbi2(dw, bar_mask_reg, 0x0);
> > +}
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
> > +static int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
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
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev)
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
> > index 000000000000..786f80418aab
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > @@ -0,0 +1,56 @@
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
> > +/* BAR Mask registers */
>=20
> > +#define BAR0MASKF		0x1010
> > +#define BAR1MASKF		0x1014
> > +#define BAR2MASKF		0x1018
> > +#define BAR3MASKF		0x101c
> > +#define BAR4MASKF		0x1020
> > +#define BAR5MASKF		0x1024
>=20
> I don't get it. You have DBI2 at the 0x1000 offset with respect to
> the DBI base address. But the BARx CSRs are defined in additional
> 0x1000 offset. So it's 0x2000 all together. How come? This doesn't
> seem right. In accordance with the DW PCIe EP manuals the shadow BARx
> CSRs are defined within the DBI2 space at the normal offsets (0x10,
> 0x14, 0x18, 0x1c, 0x20, 0x24). So in case of the DW PCIe _EP_ you'll
> only need to call dw_pcie_writel_dbi2(dw, {0x10, 0x14, 0x18, 0x1c, 0x20, =
0x24}, 0x0);
> in order to disable the BARs. Am I missing something? Could you double
> check this for the _end-point_ part of the driver?

Thank you for your comments. I checked the datasheet again and then
I completely misunderstood the shadow register and address map of
this controller. On the R-Car S4-8 SoC, the address map of this
controller is:

 +0x0000 : Function 0 (common address in Root complex and Endpoint mode)
 +0x1000 : Function 1 (Endpoint mode only)
 +0x2000 : Shadow register for Function 0
 +0x2800 : Shadow register for Function 1

So, I'll revise the dt-binding docs for both host and endpoint to add "dbi2=
".
And, I'll drop these BARnMASKF macros.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
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
> > +
> > +struct rcar_gen4_pcie {
> > +	struct dw_pcie		dw;
> > +	void __iomem		*base;
> > +	struct reset_control	*rst;
> > +};
> > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > +
> > +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> > +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 v=
al);
> > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool r=
c,
> > +				   int num_lanes);
> > +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg);
> > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev);
> > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
> > +
> > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > --
> > 2.25.1
> >
> >
