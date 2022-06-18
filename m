Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF6550209
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiFRCgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:36:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F54EA0A;
        Fri, 17 Jun 2022 19:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC8kJfBrSEwh1D67WUsWD1N4XC4WeL6WkXoJ0yRR45SVHJ/YMfPyGHLGkbv2v3dN/f1wYJIx7Cz+b+q3s0qRjx+itrD45S9vY5OTWij5hOXMaFSujCOeC/tcasbNFYmkyWffqOsi5r6uasaHHKOAc0ehhmpRQy7AIdR5hXjo60NAGgOlC0Qd6blQbJi6+dIU2fCPN24T7aZjjkhe4Eyu6dO8UVCG0PoWADtLTyKklIou8WHMyzG/ivpxVz1OK4olj4xV72QJ4YSe3MAg1B8uvCwVt/ZD6V/KKXaBN1j7AciMG4cyBZ+4Jo/nJcpsNJMLlNuL3IQDDE4pKY2QWY4MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXLljmzy2k8tj3NbfM+KZa8KRtglxkt424hwWH1jmbI=;
 b=LBArnRsONP4AFNYmtZtRUv7LWCKI+mWqdHEc+SBpUB8lSnUHNDmLG7VoNNmZY0ZOqdASjf8D4sOLaIUcL3xdBa3GAPL/E5s3YzDB5zEIThyMxijMh04iOeIWUgxRyRaRBWbtr+igKwj462eJNPsAhFr/SNCbT/4Lvd7jbFYpUr1zegT7bLxoDlXPjJ4AvD9FE7Ns1uQ9ljNQ0CBqryUDaac/HDwYU2jROZF+YFbUrlXj8ysaWzZX/VuHW8K2R/gG9CYg9r6aTiFgyFIQ7J3+LfPaZ1ITkGzYd/W5vDWx7jzqxK4d7g0yigDsdu5Li4nDHE3H4yj47z4Y/zr5DxFAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXLljmzy2k8tj3NbfM+KZa8KRtglxkt424hwWH1jmbI=;
 b=0v7rdEAweOrvCMDmPAXIIQQSOB18NnEYKiiqA0AvZAnVhrMxjMtGyPBorIqOScyT2Jf9DSHW2BvXBi1Q6KXeG4CcZEv2rb3D3A+ZpTWBhsSRCuAS1vYSw8qvSX+/000RAHmyeqmmQmkYEn2nia3cFsDee+thaqGS3ccJ0WWH2Xk=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by BN7PR12MB2739.namprd12.prod.outlook.com (2603:10b6:408:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 02:36:31 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b%6]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 02:36:31 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Index: AQHYgX7mH0vR7dmsnE6ExvvvajurVa1SaRMAgAIMMWA=
Date:   Sat, 18 Jun 2022 02:36:31 +0000
Message-ID: <MW3PR12MB4411EDCE0A7C3A1EA81DB7AABAAE9@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220616124429.12917-3-bharat.kumar.gogada@xilinx.com>
 <20220616191944.GA1102555@bhelgaas>
In-Reply-To: <20220616191944.GA1102555@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: addd1a61-b09f-4961-73cb-08da50d35a76
x-ms-traffictypediagnostic: BN7PR12MB2739:EE_
x-microsoft-antispam-prvs: <BN7PR12MB27393E71F9DD1314F7F2FFACBAAE9@BN7PR12MB2739.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eh0coDcE4cTXFnjnzSndJ+L7Ju+5upIJPLPUzBsXgfUrWMvtub8Aww6A36OB0UpZJ60a+H+KCoRmCGebpoq585BPl2D7tQIXb7tuP4blXSixhbZhDeTKDG/Coc5sjtUX1IS/5t9VWGy9PVvNS9zRszhQCMY3V7Etc0Jnh1z6CNdkDG2UJy9ixGMMLRCLZ2ADhGo054QhMYMAJU67A/1tUsRv16cV1Dnsz8KU8/kVaD4NgNBEEdoDNbI3tXu6a9+AqUjZukYZaZwkeuxuWW2RnRLY2GdGKHGBIU5JzZra7Eh6wp1W6m3NfcYMu/GXiW2j9NDeouzjOemTFhKxXo/eB39gNz9a0ChRbQ7I5Lw5lhx6XXCCdjQ10Rxfy5y1VOXCqhfp3HDJCJV3WQurR90H1HMIFKxP7xAtGcTbKVvw29Lnvp7i4BuMWNIFZlztA54JfB6Xt4mr4i3Q7T7WHPWacb3LSRLI7pgRsvCGZsMlnPmkQiGlhYUUqruxzacx3U0h2mMH7OVNZ/1yRf2/z99fDOeT3stXMlhWjyw6KO1AVFYp4iTAT4E9x+k77K6vfIIMUqp0qcdfRiyjm+KjLZ1rmqWChjpDPWTAF3xteUSTyyDn7rep7FQ0/WDJznfct5UgtrjcpA3yXrx1Wvd7dY8onUESpki4jWB22p4Wt2HWdZ2Ycv7ueHG240TbyWw9DCMaJ5fa6rY7QVlwbVyjx/5JhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(33656002)(316002)(5660300002)(52536014)(64756008)(38070700005)(76116006)(55016003)(4326008)(498600001)(110136005)(2906002)(54906003)(8676002)(6506007)(66946007)(66476007)(71200400001)(66556008)(38100700002)(7696005)(186003)(66446008)(9686003)(122000001)(83380400001)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4w/2wpX1Ch6h6pUhqV6HAZkaYPJa70bE6DJDmFziZgfYrsevfj+DHkNOdiuh?=
 =?us-ascii?Q?9XfQZuWWQTbSJOaKqxgrRCcpT6MhGkpzC+gwKV0/2mSBkyLCjqXd7wNzsozU?=
 =?us-ascii?Q?UzXc+t2nO2LIUf2pzgAnlRjumGZlvA66I0aL2sltfDkyd94tpS2gIQH3lr43?=
 =?us-ascii?Q?qug7z70f1rvCfPZtAI8x24QaWV8L0z+apCnMP6tI9KLq6Y1FoRBe6fKg7P2k?=
 =?us-ascii?Q?C59hioRMUFIDbaUzx+bwdSq5fYfkGwzHB8hY1Y9S+MzqNrl6iyhbmRLxh8Sx?=
 =?us-ascii?Q?bIbZPs7moW7m9+DrILgFP0MdlrqNrmeY/Y7Si9e6W1sAB3F7EmZxefx2f1lo?=
 =?us-ascii?Q?T7qMndwvCzIB6B0KUqgX9kIB/igQ6LsevxNN7tELLnbEFGoIIAiKCbtArfPV?=
 =?us-ascii?Q?KIUf/9VcE2IolxIW2G6VL0Im5G0egqkZi5QURl5g5WtBqpEzjmNz7y4UgWbB?=
 =?us-ascii?Q?JjkYdby87VQD3DGHuELrMfh/fUW29vrX8USgNtE5s6jjP121d2yQmedXOFg0?=
 =?us-ascii?Q?CeMIZt9IoOLXTjEGFZZjyfjO7NcPeVZcYcs5CxxxYLOSbZBmPKg5BtRtcxUc?=
 =?us-ascii?Q?PrU3vE9SBiBb0U0hTiMQpF/+TExwgOjI9KACeJQXWLf5Zv5n6xeK1f5YmnaX?=
 =?us-ascii?Q?fJHskRXzxWTYYUPb7GgPjIn9OuOBw90i0OnZM+iiiqukE8IhgbN3bKjjoFg6?=
 =?us-ascii?Q?83mhcyaHRdzAQRccr+P0O2jtH2vyagVwIK42K3Ui9co3p+pHUC/itnroEXLV?=
 =?us-ascii?Q?/hw57gwYVComFKa0+iePFpRNxmiZdNfg8nzAKYzu9swXckIN8N7A5b8D6rCB?=
 =?us-ascii?Q?ssGri2bkGfMgUzTUTDhsIXTIie0ukF0tBsnjMWpojLCKslAUnj775hx041fL?=
 =?us-ascii?Q?yDI9b2aC3G9N3DW6dHSEOqn+Hu5RaWHHkZf0b0e/KB1a0QFosPmpGeK70j8L?=
 =?us-ascii?Q?o8n59Saywp8SV2aUM4SMOclf51VsWZJ6F2J++dt5ewEdYDBnSfkVYkdJGKSX?=
 =?us-ascii?Q?5WOZDBAl0f1kqktHDNoSKqAOfjLp/KlH95f1nZXNtbujDMKG4oBNboA+f6L+?=
 =?us-ascii?Q?M35tWG/NCJgM09nWyVRUJOhaIYATHrGtdmggkZx1ogHjJrGp5fct02kA40Ki?=
 =?us-ascii?Q?r4vkjJ+VA6mOBMEtnHMS4P+/D0OfBTQG1CfYN+z3zsQ7PnhblrtzEi1zYbrI?=
 =?us-ascii?Q?XQiwDb92FNVwoaZ8+MwCjYWb+2SC72o17sNpmYWoR9HNl2W3eTsqVpb5/EN5?=
 =?us-ascii?Q?nDpLalCIQ5Hta6rmQ8L0h430blvf5HDl3wXYnrTsI6/l1aBBQOb+CSgkqxtO?=
 =?us-ascii?Q?dF9+CNYXkteRFFrXBv2tHyWLh8aCLKQKyDpg3u225xxA87KZat0KdpYu3yC4?=
 =?us-ascii?Q?9UZ+305cFhHjo+04Yx6UreR6tGElG8PEw38sZw4rJKl1UDdiXfWl2KvT8Mzr?=
 =?us-ascii?Q?b6N360qJLGj3Ua01bEGdWIjhb+2uShaN0o/h0ViJg4ZOnOMs4bEwnER/hEYL?=
 =?us-ascii?Q?kBfDN0nxzZvXRb3DYTJTPd/xyUIpeLPXcsIkUhuaCCXumXSxKVU83qX7Afyn?=
 =?us-ascii?Q?6TE42axkv49ttEsJV/ee+YwgWl98arV6r0WsByofWvsWNDGRuXRE71N6yWvO?=
 =?us-ascii?Q?VXiiG/pcRHM6uzcIwU7FogEZmT29GWpg7rUYDY7O0+L/yNsezBPhwGtKLV4s?=
 =?us-ascii?Q?aMia8tsn++0E8eTGcX6YUppAcBjQ0E/HTke5eHfdfOFTA54iPViKpBZwdql5?=
 =?us-ascii?Q?To68P/rOMg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addd1a61-b09f-4961-73cb-08da50d35a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 02:36:31.2068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0jK1T4MHHByg6hqrY6+AjzYNx3cu32+4lv/IA7QJ45ydQcyE5VFOLU0FEeU795zsQbUfOfzLuHB4FNYQhUtsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Thu, Jun 16, 2022 at 06:14:29PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additional register bit
> >   to enable and handle legacy interrupts.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 62
> > ++++++++++++++++++++++--
> >  1 file changed, 59 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> > b/drivers/pci/controller/pcie-xilinx-cpm.c
> > index c7cd44ed4dfc..0bcd11d27eeb 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -35,6 +35,10 @@
> >  #define XILINX_CPM_PCIE_MISC_IR_ENABLE       0x00000348
> >  #define XILINX_CPM_PCIE_MISC_IR_LOCAL        BIT(1)
> >
> > +#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> > +#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> > +#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> > +
> >  /* Interrupt registers definitions */
> >  #define XILINX_CPM_PCIE_INTR_LINK_DOWN               0
> >  #define XILINX_CPM_PCIE_INTR_HOT_RESET               3
> > @@ -98,6 +102,16 @@
> >  /* Phy Status/Control Register definitions */
> >  #define XILINX_CPM_PCIE_REG_PSCR_LNKUP               BIT(11)
> >
> > +/**
> > + * struct xilinx_cpm_variant - CPM variant information
> > + * @cpm_version: CPM5 has few changes compared to CPM block.
> > + *      CPM5 has dedicated register space for control and status regis=
ters.
> > + *
>=20
> Superfluous blank line.
>=20
> > + */
> > +struct xilinx_cpm_variant {
> > +     bool cpm_version;
>=20
> This is not really a bool, unless you want to preclude the possibility of=
 ever
> having a CPM6 or other future variants.
>=20
> > +};
> > +
> >  /**
> >   * struct xilinx_cpm_pcie - PCIe port information
> >   * @dev: Device pointer
> > @@ -109,6 +123,7 @@
> >   * @intx_irq: legacy interrupt number
> >   * @irq: Error interrupt number
> >   * @lock: lock protecting shared register access
> > + * @is_cpm5: value to check cpm version
> >   */
> >  struct xilinx_cpm_pcie {
> >       struct device                   *dev;
> > @@ -120,6 +135,7 @@ struct xilinx_cpm_pcie {
> >       int                             intx_irq;
> >       int                             irq;
> >       raw_spinlock_t                  lock;
> > +     bool                            is_cpm5;
> >  };
> >
> >  static u32 pcie_read(struct xilinx_cpm_pcie *port, u32 reg) @@ -285,6
> > +301,14 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc=
)
> >               generic_handle_domain_irq(port->cpm_domain, i);
> >       pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> >
> > +     if (port->is_cpm5) {
> > +             val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_IR_STATUS);
> > +             if (val)
> > +                     writel_relaxed(val,
> > +                                    port->cpm_base +
> > +                                    XILINX_CPM_PCIE_IR_STATUS);
> > +     }
> > +
> >       /*
> >        * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> >        * CPM SLCR block.
> > @@ -484,6 +508,12 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
> >        */
> >       writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> >              port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > +
> > +     if (port->is_cpm5) {
> > +             writel(XILINX_CPM_PCIE_IR_LOCAL,
> > +                    port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> > +     }
> > +
> >       /* Enable the Bridge enable bit */
> >       pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> >                  XILINX_CPM_PCIE_REG_RPSC_BEN, @@ -503,6 +533,10 @@
> > static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
> >       struct device *dev =3D port->dev;
> >       struct platform_device *pdev =3D to_platform_device(dev);
> >       struct resource *res;
> > +     const struct xilinx_cpm_variant *variant =3D
> > +             of_device_get_match_data(dev);
> > +
> > +     port->is_cpm5 =3D variant->cpm_version;
>=20
> It's a little clunky to use booleans for a potentially multi-valued versi=
on and
> to copy them around.  Something like this might leave room for future
> variants that need more knobs:

Agreed will fix this in next patch.

Regards,
Bharat

>   enum xilinx_cpm_version {
>     CPM,
>     CPM5,
>   };
>=20
>   struct xilinx_cpm_variant {
>     enum xilinx_cpm_version version;
>   };
>=20
>   struct xilinx_cpm_pcie {
>     ...
>     const struct xilinx_cpm_variant   *variant;
>=20
>   static const struct xilinx_cpm_variant cpm5 =3D {
>     .version =3D CPM5,
>   };
>=20
>   xilinx_cpm_pcie_event_flow()
>   {
>     ...
>     if (port->variant->version =3D=3D CPM5)
>=20
>   xilinx_cpm_pcie_probe()
>   {
>     ...
>     port->variant =3D of_device_get_match_data(dev);
>=20
>=20
> >       port->cpm_base =3D devm_platform_ioremap_resource_byname(pdev,
> >
> > "cpm_slcr"); @@ -518,7 +552,14 @@ static int
> xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie *port,
> >       if (IS_ERR(port->cfg))
> >               return PTR_ERR(port->cfg);
> >
> > -     port->reg_base =3D port->cfg->win;
> > +     if (port->is_cpm5) {
> > +             port->reg_base =3D
> devm_platform_ioremap_resource_byname(pdev,
> > +                                                                    "c=
pm_csr");
> > +             if (IS_ERR(port->reg_base))
> > +                     return PTR_ERR(port->reg_base);
> > +     } else {
> > +             port->reg_base =3D port->cfg->win;
> > +     }
> >
> >       return 0;
> >  }
> > @@ -591,9 +632,24 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
> >       return err;
> >  }
> >
> > +static const struct xilinx_cpm_variant cpm_host =3D {
> > +     .cpm_version =3D false,
> > +};
> > +
> > +static const struct xilinx_cpm_variant cpm5_host =3D {
> > +     .cpm_version =3D true,
> > +};
> > +
> >  static const struct of_device_id xilinx_cpm_pcie_of_match[] =3D {
> > -     { .compatible =3D "xlnx,versal-cpm-host-1.00", },
> > -     {}
> > +     {
> > +             .compatible =3D "xlnx,versal-cpm-host-1.00",
> > +             .data =3D &cpm_host,
> > +     },
> > +     {
> > +             .compatible =3D "xlnx,versal-cpm5-host",
> > +             .data =3D &cpm5_host,
> > +     },
> > +     {},
> >  };
> >
> >  static struct platform_driver xilinx_cpm_pcie_driver =3D {
> > --
> > 2.17.1
> >
