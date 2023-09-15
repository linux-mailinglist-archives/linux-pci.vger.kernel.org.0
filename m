Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3547A1AB6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjIOJh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjIOJhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 05:37:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77C1FE8;
        Fri, 15 Sep 2023 02:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYQkhLVCbq9895L/3JD+vRhyruSTdsgaS0G9Q3UxS1TzltL0+z0qfkTkv1VWJOZs05NQhmlbnL4QTU0WQreYXge2uC9MEkJQKvbMW8FyaBXyDBtnkItFl4ALrdcpY8enb8DReV+W/l4i0EC8iEWBL2idt78OhA9daJTtcTmAWIZI41XKn17q7QTTbzgRSSBm8RHiP84ENUqpFr/Njm0/NX9PiLC40cBs6h2lyhL8KPlZRPIKxjz+YvZICJrgauD3g2LY6oA1sJeAxjlKVrq5EqipEYDq5dpOMfqIQIt7M4XxaauQKFYiHXCm4N2RSYLnD+WX8Bwi8Fzq2KmXI1JaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUKj8P0oNcUyo0OAAMyfiwdS5zWIm6NqOistcVWeuks=;
 b=hxkVebi1x1qll5ESIDga0MFCLHR0c6eI/f6T+r7QhgGKDw2qy6Q8uKp7y+THZnSNSgAoRY7kqiiJExwoC7VXi6kbjzU4v+zyLC1kA/DlS9V1jTwmjk/WxhSEN6nwUql5OjfLgzq0dA1z6Bp5NFI6AzttdDXuEnvkyKwA+KVBB56ESJiDRBhE+KSJEtxpEqhiseI8xC9e66TBUzbF9aR5pmuPGcqEWDhot7IlF6TEe+7qf3b6ThsnnD5TB5fLKHE6Hs1I+l1ehDuTvY95LlnxVym5Ss8odC/SgF3n5qaAjlNn1gj+YFHxg3ylKyN26JQDdykhMAhCLyBykclAn0/KXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUKj8P0oNcUyo0OAAMyfiwdS5zWIm6NqOistcVWeuks=;
 b=hyK0FLbGh+wBlKQkZeprI9RO04qX+/scjDAVmwCuZ3XcWyCG8cKn4adZGstMeuE49Kxo1R/Hmbu5hRPZFzfvME4g/kE5nVMsVnKaa3OUuQK8p+05ge9QKISJ/FRVXox1eulcIp82UIjUqqnJwxHSO1WPCoi9Du5Qjt26jP1WIC0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9608.jpnprd01.prod.outlook.com
 (2603:1096:400:19b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 09:37:15 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 09:37:15 +0000
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
Thread-Index: AQHZ1zcPesbymzM/EkSeMq7i4076ZrAapFqAgADBUNA=
Date:   Fri, 15 Sep 2023 09:37:15 +0000
Message-ID: <TYBPR01MB534112A636FAFB61A4038337D8F6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-17-yoshihiro.shimoda.uh@renesas.com>
 <20230914163455.GA33111@bhelgaas>
In-Reply-To: <20230914163455.GA33111@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB9608:EE_
x-ms-office365-filtering-correlation-id: 6439282a-e3b1-4099-664c-08dbb5cf5882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1tWKrV+HEqIrkdzOo0Jt6IMWJjyMBfahd+3K3X85w5rZlXJSTMDcqnwQGKsQKMFqo/jVxKDwP/3aVGkbE777+KnRKJ7DwvIOgtB7UvayVibS5PZ9g2oxp3vgwn6oPtVruA2oEcxZVbNJ0nbzPSmvZ0vnnj3XHPJNYQHLPh2pq27i6fhdz6HwDgWoxgYUhL6nxK0jKdSn5DljrKTANcTPE6WT947mFWqik2EN41ryCt0UrIywuwJBjlox7Miqltb0Ua+Bqmhez3RqRxB9ee2jJ+b3hPIhuhU+67oAGiPfPRf/ql+1Ko+G8i5MO4itoQlhBZgJfocqvfz+sw9+4+FTFZMSq1xMfa3zJ20he1F3O4Z3m8fezb1JBevt/KpGrx6Jr7VBBcKSG3kRo9Dwwpr1eUy2R8FNur/hd8lMFu/+VgXWOOgq8jevn4aGefpxcjF3IfTUKsIoimS/OWsqTecpJ/a0Nl6FAAgZ/odGiuTX2xsoxVxOo63lUSPQrETODegrSwC1Echj33Sp//62jeqvsneYROeBxjQSWO5VZJpvBeB+O4B0sUN7hfje5lNTTXNgdPe/7jutINh9Eu/JAl1/BskoGt1c0jC4/8dWvWCXAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(122000001)(38070700005)(38100700002)(33656002)(86362001)(66899024)(55016003)(9686003)(478600001)(966005)(7416002)(2906002)(8676002)(8936002)(52536014)(4326008)(41300700001)(7696005)(5660300002)(71200400001)(83380400001)(6506007)(316002)(66556008)(6916009)(66946007)(64756008)(54906003)(66446008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?miJhQVfr0XmQSJDBSxAW0nUfBwHHiQ/30PjOt+50psWXHFLC1QwX53U2rJa8?=
 =?us-ascii?Q?syWIGaQTB/COoU6iFzTcc3Pnn0cwHhAd4vx4lu04LD/ircJkfTu5HABFOcHi?=
 =?us-ascii?Q?Y63WS/ctTaqrOAroJMS+Jk+H+Y9gPS4BuL2r+5lr/fNrFFwipOwQrSHss/Ya?=
 =?us-ascii?Q?hDWT5+v8kE55xH5Mumclwugbvcks5JCgtljiwnAVAwqx6x5+Gq0l9F6UD+Q0?=
 =?us-ascii?Q?f1x/vkE8SnyTjX/qNqgjB4v69mmjjEHoTKrXf2DjLD7+dY+l5oN+Jkwt0z2G?=
 =?us-ascii?Q?w8lIPocNnasy6NDDGNtQl0kevb3auSQ+sd/7/xBMjrVesNYNiUTtnDPifxj+?=
 =?us-ascii?Q?Wmw5fBtgUwyD23UCM2KQU5qfHW2rjbsbwBhSADA29jC8sPVLgBayGmGEE/er?=
 =?us-ascii?Q?bIeeDBzouE+vfxEQ3frfQ6iXZXF1CXYGUwac/BYgVy5z1W8qDM6kya87BafW?=
 =?us-ascii?Q?Rbmc6eGMKagLCrsuYRajtPF9LS9La2C0Va0Oi5tWUwsxUVGvOLMPgWch7Y1X?=
 =?us-ascii?Q?CxfPrkh/4HeTrZoz222Ia/IJZWyVZMtIMmqXJHX05jsQ9jzXZVI4hnl+xYTG?=
 =?us-ascii?Q?HALFtntuqDKbLFQP4V9INoMvT9eYRRh+FpzLuYqq54DFUQnMRRJ8CD8nZpLU?=
 =?us-ascii?Q?F//7aQMsZh6xZQt6VvJMY05BNM+rt39tZgkK+91nhGI9nb+WbBit67qyuwCG?=
 =?us-ascii?Q?suIMAehNIfyRaQPUyJM3TpKZr/xQxIzAq8m9pDCfZm6rJmVIOt7BAzif1aHs?=
 =?us-ascii?Q?aLqZ6XLNs6h0Ncds4R0ltVZt7xISba1lJ3AYVcoYK//+mIxQiitcRlnHcpF/?=
 =?us-ascii?Q?cjSvW/FA5uR8Of7odl8oEAr3kJSiygtq1biwWvLnBdcWBr+WluupFshtrmPa?=
 =?us-ascii?Q?xelEwih9lJp004sO4IxRqxxy1fLIibDsnF28xM/DMCQBs6qt/EA8xA9Ounyy?=
 =?us-ascii?Q?xHAb96OAvVNNTs6NMLOHPuR4DXbxC+GcXaywgQF9toxky3lPPI/EyGkncbdh?=
 =?us-ascii?Q?BkFung7Gc2Y8uxceBn2vh8nsET2h/QKPqjBnC0XIb5iIs7Oj0bvXxkAso0B8?=
 =?us-ascii?Q?4HgzTDQFZR6eyj+u1xPgc0EnbKkZbVtY1LY9hNEmE7RAcOhaozfyhDYmrtIa?=
 =?us-ascii?Q?vN9wpMQnbgOz9ISyS41nqUOnbfOJywynNz0qspmzYsjkpyuWOdTuXX280gCX?=
 =?us-ascii?Q?wAjs4F2dLpCJnsspRrfL9oyWhaMZQQKl6U3umxTc6F1nQRt58xO5/+/qFCt/?=
 =?us-ascii?Q?cnqojIfz8RkNxgH6Wyfa0lN63fzaFKT4bHkYpXKwTlU5as3s0fwkaGLFTQ7Y?=
 =?us-ascii?Q?84JWcyA9oz5YJWzB3RL/LDe72u0SXln4XW8SNGHmtcTpkKPL0GBfOXwQwJD6?=
 =?us-ascii?Q?YK2NeGADJuziYE23iwe3QdFTQzMrcEtm2kJwL5szN2bnyUGXLtSfC6TAH5Xs?=
 =?us-ascii?Q?uekgo8JGTQf8j74rI/1Pk3bVgMC5jF0KLUOMehYi+QqCZAk9JyMcabg8l4kh?=
 =?us-ascii?Q?7Nbi6Bhre366Q0uEeJQvUCPtLnB6Q0tHc76rvx6QCNagv3HhYlRlZO0206ns?=
 =?us-ascii?Q?NH4mBBNctOPCtaOYgyjsAk16UDsa1mrKfGezfw+i8Fdqqd3s1SXc73V21K22?=
 =?us-ascii?Q?EtHwdUItQBM/6a6hiIWmTY2WkIr6i/2Qx51baoOCf6nKR3TlQK46oY64DnWg?=
 =?us-ascii?Q?rD9ECQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6439282a-e3b1-4099-664c-08dbb5cf5882
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 09:37:15.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbXH52onwT/UKU2gNrAIvZh52L/TIWqNZ/hKVUcgeG6btyl6NW/b+cgI6UaS3EGQ4zREnizobIe2wt79xmcPPIojFq8lswyizc6DIq38cNHjgsryQa57vcWDCEogoQ1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Friday, September 15, 2023 1:35 AM
>=20
> On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > registers so that requires initialization code like mode setting
> > and retraining and so on.
> >
> > To reduce code delta, adds some helper functions which are used by
> > both the host driver and the endpoint driver (which is added
> > immediately afterwards) into a separate file.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  10 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 135 +++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 227 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
> >  5 files changed, 418 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.=
c
>=20
> Is "pcie-rcar-gen4-host-drv.c" following some pattern?  I don't see
> "-drv" in any nearby filenames.  Typical names are "-host.c" for host
> driver and "-ep.c" for endpoint driver.

This is not following some pattern on pcie subsystem. But, some other subsy=
stems
have "*drv.c" filenames. Manivannan suggested the filenames to rename the m=
odule
filenames [1].

< Now >
The source code filenames : pcie-rcar-gen4-{host,ep}-drv.c
The module filenames : pcie-rcar-gen4-{host,ep}.ko

< Previous >
The source code filenames : pcie-rcar-gen4-{host,ep}.c
The module filenames : pcie-rcar-gen4-{host,ep}-drv.ko

[1]
https://lore.kernel.org/linux-pci/20230724122820.GM6291@thinkpad/

I don't have a strong opinion on which filenames are good.

> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
>=20
> > +config PCIE_RCAR_GEN4
>=20
> If you look through drivers/pci/controller/dwc/Kconfig, it's typical
> to use a "_HOST" suffix on the symbol to enable host controller
> drivers.  Similarly, "_EP" suffix for endpoint drivers.

I got it. I'll rename this to PCIE_RCAR_GEN4_HOST.

> > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	select PCIE_DW_HOST
>=20
> > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +	u32 val;
> > +
> > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > +
> > +	ret =3D rcar_gen4_pcie_common_init(rcar);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > +	 * assignment during device enumeration.
> > +	 */
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > +
> > +	/* Enable MSI interrupt signal */
> > +	val =3D readl(rcar->base + PCIEINTSTS0EN);
> > +	val |=3D MSI_CTRL_INT;
> > +	writel(val, rcar->base + PCIEINTSTS0EN);
> > +
> > +	msleep(100);	/* pe_rst requires 100msec delay */
>=20
> Can we include a spec reference for this delay?  Ideally this would be
> a #define and likely shared across drivers.

I think so. Some other PCIe drivers also call "msleep(100)".
So, I'll add a #define into drivers/pci/pci.h.

> > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > +
> > +	return 0;
> > +}
>=20
> > + * Manually initiate the speed change. Return true if the change succe=
eded,
> > + * false if the change didn't finish within certain periods.
> > + */
> > +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
>=20
> This looks like it should return int, e.g., 0 for success, negative
> for failure.  Boolean functions ideally would not have side effects
> and the name would be a condition that can be true or false.

I got it. I'll fix it.

> > +{
> > +	u32 val;
> > +	int i;
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val &=3D ~PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val |=3D PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	for (i =3D 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
> > +		val =3D dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +		if (!(val & PORT_LOGIC_SPEED_CHANGE))
> > +			return true;
> > +		usleep_range(10000, 11000);
>=20
> Where did these values (num retries and sleep duration) come from?
> Can we include a spec citation for them?

These values came from my investigation. I could not find any spec
from the databook.

> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Enable LTSSM of this controller and manually initiate the speed cha=
nge.
> > + * Always return true.
>=20
> This doesn't return "true".  It returns *0*, which is a perfectly good
> "success" value, but it isn't "true", which would be a non-zero value.

Oops. I'll fix the comment.

> > + */
> > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int i, changes;
> > +
> > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > +
> > +	/*
> > +	 * Require direct speed change with retrying here if the link_gen is
> > +	 * PCIe Gen2 or higher.
> > +	 */
> > +	changes =3D min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> > +
> > +	/*
> > +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
> > +	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
> > +	 */
> > +	if (changes && rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> > +		changes--;
> > +
> > +	for (i =3D 0; i < changes; i++) {
> > +		if (!rcar_gen4_pcie_speed_change(dw))
> > +			break;	/* No error because possible disconnected here if EP mode */
>=20
> Rest of the file fits in 80 columns, it'd be nice if the comment did
> too.

I got it. I'll fix this somehow.

> > +	}
> > +
> > +	return 0;
> > +}
>=20
> > +#define PCIEMSR0		0x0000
> > +#define BIFUR_MOD_SET_ON	BIT(0)
> > +#define DEVICE_TYPE_EP		0
> > +#define DEVICE_TYPE_RC		BIT(4)
> > +
> > +#define PCIEINTSTS0		0x0084
> > +#define PCIEINTSTS0EN		0x0310
> > +#define MSI_CTRL_INT		BIT(26)
> > +#define SMLH_LINK_UP		BIT(7)
> > +#define RDLH_LINK_UP		BIT(6)
> > +#define PCIEDMAINTSTSEN		0x0314
> > +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
>=20
> These register offsets are hard to decode whenthey'reallruntogether.

Unfortunately, these registers' offset names are from the datasheet.
Perhaps, adding full register names as comments like below are helpful:
-----
/* PCIe Interrupt Status 0 */
+#define PCIEINTSTS0		0x0084

/* PCIe DMA Interrupt Status Enable */
#define PCIEDMAINTSTSEN		0x0314
#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
-----

Best regards,
Yoshihiro Shimoda

