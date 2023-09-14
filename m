Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9549B79FD8E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjINH4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjINH43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 03:56:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F91BF6;
        Thu, 14 Sep 2023 00:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBIyLq5IuE/XWr++kK98lci1uzi0DqMGERVD6SFZIlxVJj44Kk3i3xTPgFtzM04puiFnRPFP/3GZBcnmVsPhEUp4+I3JwPI7PAE2bNno5on/639K10jOsq7KWOVdqk5CWS3DNyUlO0liWm/faipHcN67YIJb4lWdhC+5tOBFxc1sfAge/yRAMQn2QHR5oIksJAf9hrKE/FOOwB7NFUikNe25YGBfE7fGrimVznGNHhjXfkO3gGFVFYVEar8zB1UKiFmpDDEkPGld+RvycD1k59x9LT9MIRkVHjHu50oNs3vLJ5DQjVYjj01hvjLpE8brN2xHA/m44UyUPGSbFQP5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J++xn7Hwt6X0xGltzsQI1BSnlQkLglZ4Nb+DxxRY+I=;
 b=HBOGFJUNnp42HfxiICHGUp99kFYFhFaMByak+hYG22TgO86YkhAgN5bmaeibj+rfC7kGbsQjlKs03L+l9jh5AGeQfbci9TwHSEt7I7dQoFgs59cMW6e1IV7EnWcwJux6Yev659PBEk3YF1VA4BjJKrSNWeOK2nJaU0QlPPeNk4tyovKenvRzp0AP4BT70ng+hWxcoj3chcRgEzRj5fOlpN6Z7AqbJ0W19nMeg5vKLaOFNKoWoPkynf3Bjeud1qjLPzi86cr+6Wp7kT2/0kN7AkxBQW0LXc/QodmiAXE0w05psxi5BB8O+4Q49ux8LKMFIv5/p59aD/1SLdcxwJtgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J++xn7Hwt6X0xGltzsQI1BSnlQkLglZ4Nb+DxxRY+I=;
 b=Z/6SsDuZB3oj+w1zwpHj2ex6CB/bblbnni7VSWIoRwYYQJFTnTFsiggigl4nZosWbL1B7cpFc8z5e0w4m74lERwAOrXV/0pbAAyv7ZYvvHV8MrMZqqBLVaorBwkrs4uqbGiDA9LNc8euB+Gigmh6i2VUlcNOGaw7zlyJIuVDVJA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB11815.jpnprd01.prod.outlook.com
 (2603:1096:400:403::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:56:21 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 07:56:21 +0000
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
Subject: RE: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Index: AQHZ1zcOdRSM/H58w0WCrYWL3XR2drAZhliAgACMtyA=
Date:   Thu, 14 Sep 2023 07:56:21 +0000
Message-ID: <TYBPR01MB534145152342F6E6808D98DCD8F7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-5-yoshihiro.shimoda.uh@renesas.com>
 <20230913233115.GA11062@bhelgaas>
In-Reply-To: <20230913233115.GA11062@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB11815:EE_
x-ms-office365-filtering-correlation-id: 4f3182ca-cb90-4cf2-ef90-08dbb4f815d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3mFY0Me2mKcRhSfgH8iIPyuKGyEsa4qCjHwO7coVC7AgMPiAjVeSssuwyNJu4r6AaO42yJsco4OuYrMhv0V1zTZkw9SeTEQo5widVANs9nmYAF+/u/UKd+mASUdXLr0o2Y5w8SybI5iV0Y1IOe+FyrTn5ThdOFicM9Ai88W9rBEAOpHk5kZhtDRO7KXpvBWw8IqNHAJWwFNJFINStFYGHNJNuoVWA1hE1Sz2+etqFitLEwj1ScCCIet8qD77XPEKqDwbxWcvjXbjNPZKC+LUmDaX4ivjCVtJo8JiRAWqT/4MvWZiHYo25+0otdqgfx0eRbCrDj1v4CjvS6hxQoBgbV1wkFu96h0MXTrvvwlSo8sIQXvyokFWWgdCh+QzG1iZVpmWkHzK/lBFrNylVHoKSopsAV54vVTpl2iP+zHAJJPYN251IohOVJjesDMprnk1PWRLQxCsAh9KQX6JKuIRwbs9JghAkRes5B/9IKRSe1YrRRMktiNlXAz5P69SKrKhYxyH9Ahb27guvk2q6L+o6kN5MvFDKu1GUC753mD5PU9f0A7T70KD1gdDmso1scUp6XYc8L+GltW78YTY7rUsNocCQUV7tzwGLya8o1ldlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199024)(1800799009)(186009)(38100700002)(6506007)(7696005)(9686003)(71200400001)(33656002)(86362001)(55016003)(38070700005)(122000001)(7416002)(2906002)(966005)(478600001)(45080400002)(83380400001)(4326008)(5660300002)(52536014)(316002)(41300700001)(54906003)(64756008)(8936002)(66446008)(6916009)(66556008)(66946007)(8676002)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oJvojfBvTXgn5FjJS5MPuaBVI0oqMTmeBiw8sWQ4jDv6bT4ka8EUpY63DKAi?=
 =?us-ascii?Q?RT6SB6BaEAHctBIj1Gi/Yp153kfcGJ6SYbkHofvbi8eKmYNf0pR0+Qr1icM/?=
 =?us-ascii?Q?igLxOyQZYmSwgHK8wrKFeMcSfEeoHRY4uN4JEzpBpXIledZLvkKZvQRDsGQT?=
 =?us-ascii?Q?BWMQy8PpZvv5A2M9JOoBoiVLXgsASmh+ZePv9tB8OPLicc3NQ8fP5F09o1QZ?=
 =?us-ascii?Q?8AnJ24y44ocBjIhVcDufA1UM6pQjA+0R5PGYL8Sx0Pa9cYmFSzjowks5stCM?=
 =?us-ascii?Q?cf0MHtjnoRphvwqhzrmxbp5M4R1Gpz5gK4xyJSPHpIYuPfMAA9slVFxsxn95?=
 =?us-ascii?Q?6bQHzpNAW0KL/CjWhuIPoZfEdTrYieRITICif9/6Frv8IKxZ6St4upkhZ8q/?=
 =?us-ascii?Q?rC5fjFZ7amncuv12BPSNZrYGLSW20rjCozLzVzboWM4GqE6Waz8Bj2T06MXC?=
 =?us-ascii?Q?RWxOBFP+C7ZlfqxzW+pK2KfAto7GKUPmPnlnFQZkQ2xM3vYmJcWasvUtbYoR?=
 =?us-ascii?Q?jUE645i9zVdn5ohSiCsyHtxdtetGlnWGiJPdqz7dMQwomDunGaz6QHx4TPAL?=
 =?us-ascii?Q?80lX+iJP1qSXXn3bGgELJ+s8TwUxBgxKl4HmwD0/ulEL2MkP4f0f722Ve/AH?=
 =?us-ascii?Q?8n/rl1x5DgOPd0Rlkphr4kOss4A1QHKqfWpiYxMHJlS6QYK0hyvDBloj+LhG?=
 =?us-ascii?Q?BcUsIQtKL3PlwuTy8F9t/MwZmIljSwdLXKrjtcmiizKwfoRDWlyfa7DiZC+C?=
 =?us-ascii?Q?W1XVPU6c5KPh/dQokR8TGTLnpK9+dssDnopVBxwDDTYH65wpdycQTW6QyhOi?=
 =?us-ascii?Q?ZI0RdXGNcNfy/nhpIfvqA0+9xMabCeZRJvBzQI0PEdq632XSwixOZM9oOWFe?=
 =?us-ascii?Q?lgGFQLQaCggYaksz0PUoJ+fgj+AWp26AtSz3zsf5MszVOct4k887Jbu8ed7p?=
 =?us-ascii?Q?uPr+hgwap5wEqV0XJ1dKsdyOHVgYYw3jqr6Kgl3OQkttwG+AuwcFf4rQXsk0?=
 =?us-ascii?Q?UF0Tm9wIciR2ULBJapU7FbzDV4KXgMGglNsFEcgXUYMp9qoSVeX0fuc+WrQH?=
 =?us-ascii?Q?axeTveciqTy0eVLqTOxh1ctsHjFO6PoFW6wPABcaI/doHkrwt1GkfZ2sXmMk?=
 =?us-ascii?Q?IOKlnmDoEyZHGLLKHauyvCryl1LqLM9AjI0QcpGn/4sXaC4SGjW0xuerTprb?=
 =?us-ascii?Q?yo0z4s3LLkVAvEBB5DNqHKEXoxNSv3dZ2d1dRCd78gVMfO33/H7yPGcXbTBk?=
 =?us-ascii?Q?ZbIYfhioYo9QBFH23NeIFmLT7kxQ8mjasnmeYEVYK5SCmS4mkvdXeTUo7znF?=
 =?us-ascii?Q?ccjlO8VmvG0Tp3ryjV3QoU9R5yoSV1MiRSoDtN2lF3HnPS5fWQnoDXO4Ia/h?=
 =?us-ascii?Q?j6Jt16AQoKzw1TJBEzwauK6HHcuh4TzJJWr2EhwUSm7Otujn279pwvXBxUoE?=
 =?us-ascii?Q?0OkuGG+Vbd3NWmiu8hTfolvt0oRNZ4HrP+uFSgPXHN0nFp23FsOpKLHRrf1c?=
 =?us-ascii?Q?bcXY369GnOKtUOM42ANADKwFv9ZY9CBNQ1EwC6Y7EdBhQimOIVTSvxxDbl0Y?=
 =?us-ascii?Q?yMNKZL46FDyQikV2m/DmBjhnc1s6lhHlliaG8IMJioreuts4XNOSfLKdOYqV?=
 =?us-ascii?Q?+8JInWw9KSzh0RfT4VI99UtNrB92gw0H9CUlGQI7iijoTgIlQyvOaqxjOi42?=
 =?us-ascii?Q?NTbkQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3182ca-cb90-4cf2-ef90-08dbb4f815d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 07:56:21.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1bVhod4mAUZCSbuqNkKUcnEIDI+Zd5iQSXmQpfGuNFFt+py8wUqwiQTx+R3LAH4LPv5dYQaJLL2LipXKRulm8f8XyZNfQnnPnPgKMUvBz1ei2RQ6YBW83bxlbx4t3n6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11815
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Thursday, September 14, 2023 8:31 AM
>=20
> On Fri, Aug 25, 2023 at 06:32:04PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering INTx IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTA TLPs
> > as simulated edge IRQ for INTA. (Other INT[BCD] are not asserted.)
> > This INTx support is optional (if there is no memory for INTx,
> > probe will not fail).
> >
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the Terminate at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 70 +++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> >  2 files changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 747d5bc07222..91e3c4335031 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -6,9 +6,11 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> > @@ -484,14 +486,61 @@ static const struct pci_epc_ops epc_ops =3D {
> >  	.get_features		=3D dw_pcie_ep_get_features,
> >  };
> >
> > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 c=
ode,
> > +			       u8 routing)
> > +{
> > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > +	struct pci_epc *epc =3D ep->epc;
> > +	int ret;
> > +
> > +	atu.func_no =3D func_no;
> > +	atu.code =3D code;
> > +	atu.routing =3D routing;
> > +	atu.type =3D PCIE_ATU_TYPE_MSG;
> > +	atu.cpu_addr =3D ep->intx_mem_phys;
> > +	atu.size =3D epc->mem->window.page_size;
> > +
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* A dummy-write ep->intx_mem is converted to a Msg TLP */
> > +	writel(0, ep->intx_mem);
> > +
> > +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> > +	int ret;
> >
> > -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> > +	if (!ep->intx_mem) {
> > +		dev_err(dev, "legacy IRQs not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> >
> > -	return -EINVAL;
> > +	/*
> > +	 * Even though the PCI bus specification implies the level-triggered
> > +	 * INTx interrupts the kernel PCIe endpoint framework has a single
> > +	 * PCI_EPC_IRQ_INTx flag defined for the legacy IRQs simulation. Thus
> > +	 * this function sends the Deassert_INTx PCIe TLP after the Assert_IN=
Tx
> > +	 * message with the 50 usec duration basically implementing the
> > +	 * rising-edge triggering IRQ. Hopefully the interrupt controller wil=
l
> > +	 * still be able to register the incoming IRQ event...
>=20
> I'm not really convinced about this "assert INTA, wait 50us, deassert
> INTA" thing.  All the INTx language in the spec is like this:
>=20
>   ... the virtual INTx wire must be asserted whenever and *as long as*
>   the following conditions are satisfied:
>=20
>     - The Interrupt Disable bit in the Command register is set to 0b.
>=20
>     - The <feature> Interrupt Enable bit in the <feature> Control
>       Register is set to 1b.
>=20
>     - The <feature> Status bit in the <feature> Status register is
>       set.
>=20
> E.g., sec PCIe r6.0, sec 5.5.6 (Link Activation), 6.1.6 (Native PME),
> 6.2.4.1.2 (AER Interrupt Generation), 6.2.11.1 (DPC Interrupts),
> 6.7.3.4 (Software Notification of Hot-Plug Events).
>=20
> So it seems to me like the endpoint needs an "interrupt status" bit,
> and the Deassert_INTx message would be sent when the host interrupt
> handler clears that bit.

Thank you very much for your comments! About this topic,=20
Frank also has a similar opinion before [1]. So, I asked Kishon
about this, but I didn't get any comment from Kishon at that time.
Anyway, to handle INTx on PCIe endpoint framework properly,
we need to modify the PCIe Endpoint framework, IIUC.

Should I modify the PCIe Endpoint framework at first?
Or, can this patch be applied as-is?=20
I guess that such modification of the PCIe Endpoint framework
need much time. So, if I should modify the framework at first,
I would like to drop adding INTx support [2] from my patch series
because supporting INTx on my PCIe controller is not mandatory.

[1]
https://lore.kernel.org/linux-pci/TYBPR01MB5341EFAC471AEBB9100D6051D8719@TY=
BPR01MB5341.jpnprd01.prod.outlook.com/

[2]
The following patches are not needed if INTx support should be dropped:

eb185e1e628a PCI: designware-ep: Add INTx IRQs support
5d0e51f85b23 PCI: dwc: Add outbound MSG TLPs support
4758bef61cc2 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
44938b13046b PCI: Add INTx Mechanism Messages macros

Best regards,
Yoshihiro Shimoda

> > +	 */
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_ASSERT_INTA,
> > +				  PCI_MSG_TYPE_R_LOCAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(50, 100);
> > +
> > +	return dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_DEASSERT_INTA,
> > +				   PCI_MSG_TYPE_R_LOCAL);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
> >
> > @@ -622,6 +671,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >
> >  	dw_pcie_edma_remove(pci);
> >
> > +	if (ep->intx_mem)
> > +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> > +				      epc->mem->window.page_size);
> > +
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >  			      epc->mem->window.page_size);
> >
> > @@ -793,9 +846,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		goto err_exit_epc_mem;
> >  	}
> >
> > +	ep->intx_mem =3D pci_epc_mem_alloc_addr(epc, &ep->intx_mem_phys,
> > +					      epc->mem->window.page_size);
> > +	if (!ep->intx_mem)
> > +		dev_warn(dev, "Failed to reserve memory for INTx\n");
> > +
> >  	ret =3D dw_pcie_edma_detect(pci);
> >  	if (ret)
> > -		goto err_free_epc_mem;
> > +		goto err_free_epc_mem_intx;
> >
> >  	if (ep->ops->get_features) {
> >  		epc_features =3D ep->ops->get_features(ep);
> > @@ -812,7 +870,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  err_remove_edma:
> >  	dw_pcie_edma_remove(pci);
> >
> > -err_free_epc_mem:
> > +err_free_epc_mem_intx:
> > +	if (ep->intx_mem)
> > +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> > +				      epc->mem->window.page_size);
> > +
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >  			      epc->mem->window.page_size);
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 8f22a7bc0523..e02d4986bc2b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -376,6 +376,8 @@ struct dw_pcie_ep {
> >  	unsigned long		*ob_window_map;
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> > +	void __iomem		*intx_mem;
> > +	phys_addr_t		intx_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> >  };
> >
> > --
> > 2.25.1
> >
