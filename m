Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435F770795A
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 06:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEREzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 00:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEREzo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 00:55:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC42693;
        Wed, 17 May 2023 21:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEN7m++5nLrChQ04vjhLVL8GLjdnKi1rgygjlF1Y9HLuyl7YUBBNiONXd0Xkbn1964JThzJuTuNKHcqFDoYCVSFj15b1v4dEGVEetdLPQsE9Rmk10rgJoRthuCxtlBJ5R2wbnW5bxuzM+W0c5vSsK7Bze3F5qD/qVisSlk+ZPJ/GCyTYyq/iPCDXAu2bWw54PgRTVVFi8YPTuHxCx7aMzmk0kVLoWfGb/mh6vZ9I+Gl7uckkvj76HiPT0HY9+MTcnT4bHSRULYlT8Rib5Lzgz0uk9rkwS4X72D2248iMNuj4b1XRSRbDtgQhGID1pA3WFMwFO1xFtTTAQC1oaS9FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkxbQiNNEu0V+RfGymhvddZ4k9gg3JaIB9cHaGdCkfw=;
 b=RhnbW41UmXhzOs9Pu+JkD77EUQpI7F6Jtx0qiOXwHbCfjjgnshMWCsgjSgHTvkSs94EwclWD4bxr0RL+2b6Tk8B9FVKZmDcYV85dawDd3vJtUT8OyFDcezFhCZ7W3Z8xbuZLFmMsjjzgUllmPWnH00Q73FMKdY2rjCr4HHvXzNqrpBzfABnySLmMuTShZ9Pc25q3Az51ZKSbisCWfJ1BFDHKtzQPc7l9S/KMLiegde5BUuREOh1Z+KIPSdSK0u6l1XerXtOY/4mVTTFs5lUVBJywsgbJ0y5ql5jg18m1lE83vK6F7y/bp0n9sWnvOMs5VwyLXUNMVviEj5PDoFkzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkxbQiNNEu0V+RfGymhvddZ4k9gg3JaIB9cHaGdCkfw=;
 b=NRc5XQlUvgivYd41ccinok39wv1Mwnu73eg4Aar7JlJIfaM/L+tVlcNGSAGjwc2c1BEBk4sHoeCveaTiH93sEJArNp6EqUvmcQ1lq7wD54A8r0Xr+EEO4+lnxMeaxCtq4Xhc6gx0ERfcmGTOcy24U67tsIp6aUiocJwlcut0qR4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 04:55:41 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 04:55:41 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZhJrntUaPjNRHKk2++3mbbOWIBK9W6TcAgAiW+fA=
Date:   Thu, 18 May 2023 04:55:41 +0000
Message-ID: <SN7PR12MB72011B7A1B2B8FFAB140E6A08B7F9@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
 <ZF56rHL+4Cv7VOuN@bhelgaas>
In-Reply-To: <ZF56rHL+4Cv7VOuN@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB7575:EE_
x-ms-office365-filtering-correlation-id: 5d59e5f9-c04c-49b9-c70b-08db575c2159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hw5lWKExOPaL61HRmBOU/pxKB+04emL/MvRa32Mkc5PzSdXuMm8Bhdg1hFI7vZcZfLbhjWce3Ed/GJjEjkHHj7FZTXdbQ/JeFiLt/XWWfYeeT9KbKMPjWHHWFSgCbHXf8eH5Ev/ZHndqaqR/CAL09Ri/dEp5pHYWkdk6hrt3x39z7gE253xvaK7JJz/n9ep1rR/jWBs7iul9HOtVG5gY5j547pIgZvyStiV2+UOjpipjF7h/FwAo4e8fzUqt/BbBDsmioo9jn/Dt/vSLw++nWV9e+8FQkx8DHF/Cdm/DLw9oAidBhD4OYEIm3dG+vkAFaKiHghEhiq82qU25poKHlS5PLRg42ey3X6zEwSYeCgPC/NWetYZe15o08KgfqQbTD7C30zhPtTJfZ8gHqUO/635AB2i2O1KjCaq3hXY1e0Ho68DH9cb2qxDBP56JOgOR/2kP9p3ULF+7bBxxzZUivk/0xU4ts85HUda13yfEb0mg0hgQNrMPkVRitJ7CGz4KFddg1oRhVR6mvHDqLO6SMQD9FWKFra6Nr6/vmdUawSC8eGinr1sLQp4ukHzA4UM/fCv10+8LNn9SY/KNbSNLtjiPbPsVQT8cfB4zwiViLoj3dgoO3MTJgIp8bVcXuvX9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(33656002)(7696005)(316002)(54906003)(86362001)(66476007)(76116006)(66556008)(66446008)(4326008)(478600001)(6916009)(64756008)(66946007)(2906002)(8676002)(8936002)(41300700001)(5660300002)(52536014)(55016003)(38100700002)(122000001)(38070700005)(186003)(83380400001)(6506007)(9686003)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8eGRlU+IqCPNkOBnW9H/G9XCTW9e9XTLaX6nhokk8UP7xGRjVilODaGTHGyV?=
 =?us-ascii?Q?bBuPezK5ZUGHfUcjyrK4lKz70lZGmLubU7jdtefIBy9obed2fP+bEz0m1CaW?=
 =?us-ascii?Q?z0SdP/BXsMQo+f1MXfkjU0F5RoWTP10la8R/tarfn+WBkX/LKecG+lIpNvMf?=
 =?us-ascii?Q?dmOJdEYo9Pi7NiPBwWR0b6+Nd+iQNe3PQV7mXp6Hp96wHyjJpCNTJNS+WzxU?=
 =?us-ascii?Q?RmhtdVwlOe6R/VXpSRavJKcKKj8C+m5qWYBrg+0DYYmLrXDn9p24PcNUiOl/?=
 =?us-ascii?Q?5pKVqNASUqAaLFWST+Eih0MGO+h2sTd6/eGej0unBRmselLgxxRysTV0tXbE?=
 =?us-ascii?Q?iWC5mPxf6LOxQ+xLXN7vdh7g1TlljoOPFV8SaSV5W0uLjCmu0fna0Kn4wsB7?=
 =?us-ascii?Q?YPBgfqKV9VDh6oqjTTzj3khZ70p+nrKvYNkNDOuKgGb7vOFba0ob8yqW/veP?=
 =?us-ascii?Q?AHPkniOpsP2mAbgEvn6SJuoQ1ax4W5U46O43eLmt42SxcVGTD75LnELTFkE0?=
 =?us-ascii?Q?lZPRnI8K0KZG8C6XSkG5alFFkup10U1k9ZMPAMT4FW56yEeT8I/CXJJfe/5X?=
 =?us-ascii?Q?M44u6P8e8TNg6VuFhTlyA/YaPET6vt8Mk+JPQhtmgCkFt0KJ6SjNQpqZtFuB?=
 =?us-ascii?Q?F82rkcGhrg7Qs2p2s3RIFHmh8xBhfla3MqS/HPbICk5uQQ98UxfM/6Dk4Vy0?=
 =?us-ascii?Q?WwwTnFR5admHjV//suuG9jzQtsihT62UHPIbV9U8UpXUZDHJ8uBDQDD9Wwxk?=
 =?us-ascii?Q?JmaLOt31VXfqm0ACTufD0yL8Z9lkI08PwvqIcJIVwkkYUw4glhj+6tlOyUhU?=
 =?us-ascii?Q?XkNPY3GAgcMAYrFehWqRB6mB8e7L7/DCKuHFhHvOCgQV1lreHV276EoBfNMF?=
 =?us-ascii?Q?MsSGRboZU1BliaqwmXLmTMyidaMJLfvt9CkaAPM6ylmPwdSNwU6hzEua0AFb?=
 =?us-ascii?Q?B5PXReGhT4vEYB7CKvE4p/lurWxu+MjOHfEA/mygcfBPEWqdapn+UKIrAiDg?=
 =?us-ascii?Q?IhlgrG7xahg1VYDyQ87VWHcT76yQIk8zVRYpcQxiasFhJ/0+ikaG04XwmO7N?=
 =?us-ascii?Q?ddMXK69ukIzg0wmg18/qf/waFsZbKvJMR7mVsusK8MU9yYjN61ujzOL3VgRh?=
 =?us-ascii?Q?LiOqPtae0pB9HoI4DBwcBLg93tD9JVSrk88O1ycCnzaL4HqPMWM5bqkG+3Gd?=
 =?us-ascii?Q?b1qfzgJxq3iaiY7uvWDfbbrLfhu7pwAnbFZ934dzApAFuiHFO3b1QLMLZmeh?=
 =?us-ascii?Q?U5cLdDyCnje05btcW4dDpUYnz5qrF8aTtJfiYXcl9A6SgrY+rCVEa64wDwDZ?=
 =?us-ascii?Q?IXOoAC9krWdwzrKxT+aByEmIC2rYGeYXQTMX7vF74uFseGa6VP+e+BrRx3RO?=
 =?us-ascii?Q?uBlPVWpOuL82IXG1ZPD2APN/Nd+yNJb5Ymxo0GuryamEh00Jp/zvyNSK/ga4?=
 =?us-ascii?Q?fnn5JsdCzxyLHtp5Yl0WyKZdHiB2JBbG1O9401H3/7nfHnMaHNErxJuxeRHI?=
 =?us-ascii?Q?bfR67byHSuKLbzF+/y56YCO0CjujB7IpTBHBv7Ium4Xet+TJQiO3DQuxMLTc?=
 =?us-ascii?Q?n/U3YzbIZm++e1X5F7Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59e5f9-c04c-49b9-c70b-08db575c2159
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 04:55:41.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVeF7iD1jFymLgGxtvPmPVzvkqdidGBe+lNx2gkBSFaYtBLNg6tf9USMvYWJF/pxMSBsQL5CnbsXJtOq/WcYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
> Whatever name/text you settle on, make sure it's in alpha order in the co=
nfig
> menu seen by users.  As-is, this patch would make it:
>=20
>   Xilinx AXI PCIe controller
>   Xilinx NWL PCIe controller
>   Xilinx Versal CPM PCI controller
>   Xilinx DMA PL PCIe host bridge support
>=20
 > which is not in alpha order.
>=20
> > +	  Say 'Y' here if you want kernel to enable support for the
> > +	  XILINX PL PCIe host bridge support, this PCIe controller
> > +	  includes DMA PL component.
>=20
> > +obj-$(CONFIG_PCIE_XILINX_DMA) +=3D pcie-xdma-pl.o
>=20
> I think this filename needs to include xilinx somehow, not just "xdma".
>=20
> Since the probe function calls pci_host_probe() in addition to the DMA se=
tup,
> I guess this is a fourth Xilinx host bridge, a peer of AXI, CPM, and NWL,=
 and
> independent of them?

- Agreed, fix it in next patch
> Is the "xdma" or ("DMA PL" as used in Kconfig) name also a peer to "CPM"
> and "NWL"?  The Kconfig text, especially, should use names that users wil=
l
> recognize.  "DMA" or "XDMA" seems a little generic.  The commit log
> mentions "Zynq" and "Ultrascale+", neither of which appears in Kconfig, s=
o
> there are a lot of names in play here, which is confusing.
>=20
> > +struct xilinx_pcie_dma {
- Agreed, fix it in next patch
> git grep "^struct .*pcie.*" drivers/pci/controller/ says the typical name=
s are
> "<driver>_pcie".  Please do the same.
>=20
> > +	void __iomem			*reg_base;
> > +	u32				irq;
> > +	struct pci_config_window	*cfg;
> > +	struct device			*dev;
>=20
> Please use typical order, i.e., "dev" first, followed by "reg_base", etc.=
  Look at
> other drivers and make this similar.  No need to be creatively different.
- Agreed, fix it in next patch=20
> > +static inline bool xilinx_pcie_dma_linkup(struct xilinx_pcie_dma
> > +*port)
>=20
> Please use the *_pcie_link_up() naming scheme used elsewhere in
> drivers/pci/controller/.
- Agreed, fix it in next patch
> > +static bool xilinx_pcie_dma_valid_device(struct pci_bus *bus,
> > +unsigned int devfn)
>=20
> Similarly, *_pcie_valid_device().  Lots more instances below.  Don't spli=
t the
> "pcie" from the rest of the generic parts of the name.
>=20
> > +static struct pci_ecam_ops xilinx_pcie_dma_ops =3D {
>=20
> const *_ecam_ops
- Agreed, fix it in next patch
> > +static void xilinx_mask_leg_irq(struct irq_data *data) static void
> > +xilinx_unmask_leg_irq(struct irq_data *data) static struct irq_chip
> > +xilinx_leg_irq_chip =3D {
> > +	.name           =3D "INTx",
> > +	.irq_mask       =3D xilinx_mask_leg_irq,
> > +	.irq_unmask     =3D xilinx_unmask_leg_irq,
> > +};
>=20
> You use "intx" in the names below.  Please also use "intx" instead of "le=
g" in
> the names above.  No need for two different names for the same concept.
>=20
> > +static const struct irq_domain_ops intx_domain_ops =3D {
> > +	.map =3D xilinx_pcie_dma_intx_map,
>=20
> > +	/* Enable the Bridge enable bit */
>=20
> "Set the ... enable bit"
- Agreed, fix it in next patch
> > +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
>=20
> > +static int xilinx_pcie_dma_parse_dt(struct xilinx_pcie_dma *port,
> > +				    struct resource *bus_range)
> > +{
> > +	struct device *dev =3D port->dev;
> > +	int err;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct resource *res;
>=20
> Weird ordering.  Suggest order of use:
- Agreed, fix it in next patch
>   struct device *dev =3D port->dev;
>   struct platform_device *pdev =3D to_platform_device(dev);
>   struct resource *res;
>   int err;
>=20
> > +static int xilinx_pcie_dma_probe(struct platform_device *pdev) {
> > +	struct xilinx_pcie_dma *port;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pci_host_bridge *bridge;
> > +	struct resource_entry *bus;
> > +	int err;
>=20
> Would order "struct device *dev" first.
- Agreed, fix it in next patch
> Bjorn
