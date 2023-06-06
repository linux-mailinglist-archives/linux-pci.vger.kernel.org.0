Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB3723D14
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjFFJVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbjFFJVQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:21:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28857E77;
        Tue,  6 Jun 2023 02:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwdhtaZtKgqbB0UacPsV3gQUuzgM0m0ACASopDMWSNIXqc6oo+xmKM46Fvh7mzcYpgZPpnXe02kCQ/anBZKvoORMjJccG7UbZYg7AcARn+BvWrRECaREf32rjtdaa4/fAFL3cXFREVV4Mpzb716TOV1tuuYgp+EnPv7ZbwCSNZh4hUOEPDqWAHfvsYARQoLqQuMe2pK3a3KnFZxrdx9Ay8x8kONnGMNj01Dp5+vzrIZfcReOR9UJc2AbWN+9CLwd6MHMdE3cSNGNs38y0m7m3MlGEbMKussDPBVC3ZpKimTjTnjvXkOl3C9XpbmHscjSJiFSpfJ2C7NYAxg+QMAG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecuhHEkMvrUAaCdAPbBL/GQsUKd9LptHiUfCP9iPiuc=;
 b=Q2pgCEe2J9h2QVfYD20UmbeaS1r+M2Cm+beS0AuRVrqKINUY+Am3Y43xBAIAB3oCzGit9tJ6QZ9c3pAwH92feoHwrKDgDfWwKuFE2mxLaOBTbN1vncobm1wNIj9h/oP7amot9MViKK3pdlpeow9hbb4Fb1x0pKl23+HlQJMVCYqU5oLVLI6yE4BKEmR+N5I9tqCMRftNG/CXufg7T2BJhffOO9DooyK9c3bqvqO/VFTD2GyL1Q8UI/Lqln8IeTqZyPKWfdEv4kcUlI5KG4QNY4DQosQouv8gdumRuV4EVkzJcTVXZQF/CL12ca9TBmTFg9bssf87XrEqejewZjMoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecuhHEkMvrUAaCdAPbBL/GQsUKd9LptHiUfCP9iPiuc=;
 b=oJVxV4zxIBLfkDHd+erFxl5W1mNebxV1BsE26//YJlnMfbQQpZLqanz6XgwKIe59xf1/dEvsxa6J5qXY3MbS+qwjWCxYxQntqaiifSqa8YuU/ZNMx3Wns3zq9jF/CwZAgxlx9r5jVI2bff3XETXS/gVYGjwb2C0KL4uVuUQIS5E=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSRPR01MB11423.jpnprd01.prod.outlook.com
 (2603:1096:604:22c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Tue, 6 Jun
 2023 09:20:23 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:20:23 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 08/22] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [PATCH v16 08/22] PCI: designware-ep: Add INTx IRQs support
Thread-Index: AQHZgwfSDLM5xSYMN0SilaqvKziXvK98AvkAgAGmq+A=
Date:   Tue, 6 Jun 2023 09:20:23 +0000
Message-ID: <TYBPR01MB534194F9F416FB8DF50ECD78D852A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-9-yoshihiro.shimoda.uh@renesas.com>
 <20230605080540.hz6hn45zciqsun7o@mobilestation>
In-Reply-To: <20230605080540.hz6hn45zciqsun7o@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSRPR01MB11423:EE_
x-ms-office365-filtering-correlation-id: 043763cf-0c95-4471-c683-08db666f41f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rH/N1YJbuj+RMFGoxW//RV01HKy5OrLuryAM8trDUOrK2wvc3Ea+nGOuqBuQrjWLgtqo3CtSAa7ggu9ZBSZp+1IQkjS9UO2pcp4F6DPrOtEB7xn88YXI3OfwlTXwJJMuD1negxBMtVYJxPDJeMvv353qLlTBgvHmlk8CnSfD802jXzgKZz5axbZBxSnS7KK7Dxg7AY8tBXL5xafcCEh7dz0gSvNL2SjjBdPpThWevSRzqAlIHXlRqZ+TNiwKaD260Ta15FnF9DtMSwqDuCxVK6yKFXSDhnw40elCYOfmvLQ1cpu1PwfcqX8YwjNlqaKeybs7aF4iipy61B8N7Ttz0+M3izZfObtfoKzsXhsLMFgyiMdOCIBTCt8ZI/1imIlVzzWtrpyUGcyy5O1ctbeXjbnmWAtQSW+w6iF0nkNGkM39PTpaCWE2oWx55MKq6it7UvblG/nRRZzcFdCHlvKyIqO5S4uvoMBBvlTE80Ievw4HQacRjZUVN5SnCZOkKP2Liv0EpSQ9fcEMpsaOYNweSLIrhm/3xM8nVOPD1DPXIGmzVs1J67iKU6CxOhkhyuThNmqOt0+13U2i3CTpfjCRa06WpS/QFDWGuOVdpYjoGxRaYukLyP76Krg1+ZoacHmi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(52536014)(478600001)(9686003)(41300700001)(54906003)(55016003)(6506007)(33656002)(7416002)(38100700002)(7696005)(2906002)(316002)(5660300002)(186003)(71200400001)(38070700005)(86362001)(66946007)(66476007)(8936002)(66556008)(76116006)(64756008)(66446008)(8676002)(6916009)(83380400001)(122000001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mxQgmYe9mC4RMhX5VQXh98zaknrziG0Z3Gk6tBeioFW/Q6a2TgDgG8LmbxMD?=
 =?us-ascii?Q?RHeCvBo7F31GZy2uvGxMWA9JMwFumGdWQA2LTmpcKOJ2lUx6RFQ3H3qwv2kK?=
 =?us-ascii?Q?uuRs/oW45Wi3AQGjiRoitSJcAiQacI3JEXW/5H3E2h/Sx6BHcAx5UXjLz4mY?=
 =?us-ascii?Q?qkOYHCzp+dv/gyYnU6GVyHf55Ce9ubS4NtcznVBV0dpCJcoch/dh53SnoPAj?=
 =?us-ascii?Q?XPdebzmC84bYbfwh2z5qxU/DEBoRFFWAVB5Je7Pqvp93MY7b+PqAu6A0ra/u?=
 =?us-ascii?Q?2YEV8TZMVGh0VsSN62YECvEM0N/vlwWTBB1ckySwfuX1moZ7gsXqNyZ4G06O?=
 =?us-ascii?Q?XC1Q8XZ8PmJSZaZ9WUFj/cqYgR0fX8HdnjhAlVN79Kq2zpymt1u/hWDUoK9T?=
 =?us-ascii?Q?RYiHADNmPZEjXqyKo+2PFkoF9dqhK8VPWr/TQHX5tPnIWf4J6wM2/0w8rPTJ?=
 =?us-ascii?Q?pD+DzRyh0LxJFCUUWoHKgioQTySzH+t5Ayoa545qz+AaH8+/wDBWDVXjKqC9?=
 =?us-ascii?Q?WSTolVGgKQhH7KJo9kBBkMTOqGxXLrk5w11Em6wHL/75iHfi3Ap5Bju3wAwC?=
 =?us-ascii?Q?AUYUTIyrnToHCn24QY83HiOtgNuPzlzckTC9xx5L8gFx4iaN9NpDPj8l6Xx3?=
 =?us-ascii?Q?mkdm+iEiB7TRp79IFvtsUmi++bxlOWWK/EFTt6wFlQueycNV3iT2rzJZntsQ?=
 =?us-ascii?Q?T++wJqmmgJUpTAxVgln4G8AqCpt79lTBw/76DwXpGNGT6pJVzSReAylIw/Xq?=
 =?us-ascii?Q?oTjBoV0lUNi36E+inQS4LXFCfJ12F+lFvglOWSM4frWOuphxZuy27OseijIb?=
 =?us-ascii?Q?eOZxW9bimy3iHfIdkppEWmhMav6xnlu0LzT0sHseGVvC2TKhldSNzR4U2iV1?=
 =?us-ascii?Q?201TyNHVmzUdhYitZT1mwQi5iojedy+Kz24qnVVPs6MqKsTnlePzdWYELZzG?=
 =?us-ascii?Q?xGJwgekkyNqbBpVu/J9+Lc3ijZcXIqzg9vlS7j+vIHWJ9LfzBLzK2DHep43a?=
 =?us-ascii?Q?DgED9MaZv8DKr7AumgGGXYxjDi72Xo09Y3NSHJkuhvKNwsFsOV6+9bLMXaaU?=
 =?us-ascii?Q?zAQO2lh0Pqrg/Aezu0invawCKBz/YugK1VsQmGqejwDkB83E+2qk7tkKmTEj?=
 =?us-ascii?Q?RsjGbG85B1Sli5YIFkX4EZoqqI9LHtf6QDGUzoJqxjS5nrd3ySv/KKDtKddp?=
 =?us-ascii?Q?nS4WG516QonehI7qYROds9wg3Hrz/vOFb+gGb6Lfm0/zhVT7FC2n4MjuTX+p?=
 =?us-ascii?Q?J6SXsmzfDl28Vp25Ak2GIle30UllhHbIP+IBYCff0LQ3bdQrV+A2vxCwmR1X?=
 =?us-ascii?Q?m9hP8ivpefZA8HuyZADa4jyxG2w9t87Ruvjso+sHRWhJe+ewXcaGDbi/3g48?=
 =?us-ascii?Q?rOsLTCU9auhIZYQyyBRdwnUiaTleRCyK+ivopVcp55vEVT7nCNL/2hnz3mgL?=
 =?us-ascii?Q?MmJ+XzpFMjAeI7PpQOi7YONJxeMj1Opuc128Fyh1TSYbLCR0WrlFPOw1sDDS?=
 =?us-ascii?Q?A4JjUOImyVEaxw/oJS7RYdpLaOD3ExXSvRMuj2pOKALf2lCy3txW43155LOm?=
 =?us-ascii?Q?lB/rtnMg3fe2d1jQ9hcD2Jevzcl6E+KmJaX8Hlc3q+6VM0hd6qGtHnXI8EpJ?=
 =?us-ascii?Q?ilhG2udqnSoFeEOeswTA8wtaOUu9u/2yGGd713dfUSJijonYYmhy9JeHK6SK?=
 =?us-ascii?Q?NvHfSQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043763cf-0c95-4471-c683-08db666f41f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:20:23.7211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYLwHq7ZAViRNDlNemqpb0LJj8KR13iH5CyBEdymR5zjr81LKMXHYfkWnB1YadWaKjJaxOAPZAFzbnSa8K1U6Y4VzCNgUAoTQSINsTmwuWq/jCE7KaqO8M2XdRn+BB3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 5:06 PM
>=20
> On Wed, May 10, 2023 at 03:22:20PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering INTx IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the Terminate at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 66 +++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> >  2 files changed, 64 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index fe2e0d765be9..0abc0073b1cf 100644
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
> > @@ -484,14 +486,57 @@ static const struct pci_epc_ops epc_ops =3D {
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
> > +	writel(0, ep->intx_mem);
> > +
> > +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> > +	int ret;
> >
> > -	dev_err(dev, "EP cannot trigger INTx IRQs\n");
> > +	if (!ep->intx_mem) {
> > +		dev_err(dev, "INTx not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> >
> > -	return -EINVAL;
> > +	/*
>=20
> > +	 * According to the document of PCIe, the INTx emulation should be
> > +	 * level-triggered. However, the Linux PCIe Endpoint framework only
> > +	 * supports edge-triggered for now. So, this function asserts INTx fo=
r
> > +	 * 50 usec, and then deasserts it.
>=20
> "Document of PCIe"?)
> What about the next message:
> Even though the PCI bus specification implies the level-triggered INTx
> interrupts the kernel PCIe endpoint framework has a single
> PCI_EPC_IRQ_INTx flag defined for the legacy IRQs simulation. Thus
> this function sends the Deassert_INTx PCIe TLP after the Assert_INTx
> message with the 50 usec duration basically implementing the
> rising-edge triggering IRQ. Hopefully the interrupt controller will
> still be able to register the incoming IRQ event...

Thank you for your suggestion! I'll use your comment on v17.

> Other than that the change looks good.

Thanks!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +	 */
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA,
> > +				  PCI_MSG_ROUTING_LOCAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(50, 100);
> > +
> > +	return dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_DEASSERT_INTA,
> > +				   PCI_MSG_ROUTING_LOCAL);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
> >
> > @@ -622,6 +667,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> > @@ -793,9 +842,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > @@ -812,7 +866,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > index c83d1d176e62..06e044e2163a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -369,6 +369,8 @@ struct dw_pcie_ep {
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
