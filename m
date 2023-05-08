Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99916FA0E1
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjEHHUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjEHHUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 03:20:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F0E56;
        Mon,  8 May 2023 00:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYYO3Q16i27TiQsxM948sVCGvruznoOfMQ3ik9Vh25+XqZ758/I6yXVJ4Nr2voI98DTX5quvRvD7IvPfxPanyjYMgNpB1LBYkWtyJK3cY1fhMFdE6ZvPJGfnDGA4KquhIHbFahKIbcH3OrKwq1+Jdyi+qJeBIipGIllg8Z0b93aEBmXXmXzHEkL/cIZGsbqbkr0cG1tBEeRfrkYnOUE/17JqjGybvS42OJrDsj4xdv0v4LQeC6GYZi+juBScEwPd+nBKi+V+Fgw4CjzMsTcknviFgJ13fXTwCqp2srPPeWyVT8wLk70lZoo7/UzyyxnrREmO5GAba6Y1IQPo9XOTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXoyD+kib8FcMlbYZXIZ8J8hhRvbDI6Jr5QQ4LuWmFQ=;
 b=CmjPtN+Y/J3F/TIZiDNUF8wnFmXhScvR3NEO2NxMkU+444j+2X6Onf8l9ZECByYowE+fZeSV+8S40F5SMiH3F6SIENGt0FFUvQq2/k30URxfAtK6lr97SdAyYWuXIKCR1Fvsa+POF/P0LY23kq8MekQaaHVSiVQeWL5nDrRnNd50l6KdftUOXKnByWUXQfPCtK5a3SQAmL1/x2kc71997fU+FL6XBmseFCyTTQZGBMPNYOqxIfkAT8UEC43wjap77IbST4w6rOoSEa51qrJkpzQdYnOzoIwAvJxO3Qig380LBsLyIXrYxNOSHuKkc8iB9RoIdXTUk4h79bjtVeCEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXoyD+kib8FcMlbYZXIZ8J8hhRvbDI6Jr5QQ4LuWmFQ=;
 b=DZ0Zrtcho706PQm/SOfNl66SPE6no6wdyF9y77tlS8TKQXuMgJTShKts0/XFkB1AtgUBiTeBQ/hxKk0cCRmxZ6yf00IW2vCUr5PJV1VOU3kPKwNsnTvsq0fA6Wxwa3HzS19DfZ6ccuKIps83UHnKvIJu0Q8k5IO/4ghta3ZjbE0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8538.jpnprd01.prod.outlook.com
 (2603:1096:604:199::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:20:38 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:20:38 +0000
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
Subject: RE: [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs
 from endpoint drivers
Thread-Topic: [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs
 from endpoint drivers
Thread-Index: AQHZd/trWnOtmE0+REezr2H1c/jFhq9F1SmAgAoz2lA=
Date:   Mon, 8 May 2023 07:20:38 +0000
Message-ID: <TYBPR01MB5341D386A010D10367769A72D8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-9-yoshihiro.shimoda.uh@renesas.com>
 <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
In-Reply-To: <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8538:EE_
x-ms-office365-filtering-correlation-id: 296146d8-5610-4013-b413-08db4f94b96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tv/Hawx3qc/cDadMNKjRBvqdER+FhIWVHZzKRvXxscvPk5QpvJnz3CdhBvUhZxtlOmb+JS21Y6Zm2XZFWhOVe3Tal6KjtwefGv0ep7yqagZXa8T0OCb860yCaLIsQTYAFJX8v2TzXZAXnRBypKFjQYFHZqLuB2YvnYu3F0AgbyV8hCY/tiCC0G3/gdqRc4G5XXfoAFfGVt3nGeNaDjtf1CmJqYgisZ8/N3Rc1scvH2EkumtrZRZgMUTwKTnh3aLEh7RM1UZpfjLJjmlJCTsbl8eT+lOkLjJe9hbmYbNe8BR5fDr05s2/DZp2O0nh0U3ptWL9Hzy/dERheO3IY69bbkmIzMwL6kg3qN9dIm0wNIYZgsINgWkuMLllYdvwMSSPxE11AP3XJojZQvWbrQzGa6qm8K0y2JDOnHKQjKWPCxTgvUlxwPtSygONjdraTY5WW2yRIqmrdYGQmNRt2PbtfEGZARreohbjTfqyNUuRXBNLT45kcXDEhY5lRaOhagiHN2nf7+aTTCFgdqjZUbnPYQ7qejD+ZC93thRP7jd9G0hS/U6P5i3RVpe6AseAIBblE7V8asNtrAIureFVCa1BMTLYHhCbWiWI3RCklDuYz1W8noxCOPwkJfhf786jMJxS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(76116006)(7416002)(66556008)(64756008)(5660300002)(6916009)(66446008)(4326008)(478600001)(8936002)(8676002)(66476007)(54906003)(66946007)(2906002)(71200400001)(316002)(41300700001)(52536014)(7696005)(6506007)(9686003)(186003)(55016003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ATgCXtB50RbXvfQlH4/sdsFquOcgq/o3Z1chXMj+KJdvOeMaycWg8aCDxfMX?=
 =?us-ascii?Q?bjlVQXagHMfEsPKfdJOdpA3yPdEBObuT6sfgueQhr3bx6if/qrQiL30994t5?=
 =?us-ascii?Q?11Qo68pnSkwEfT2A1NphoyijMR9AKvaLWU+38BC6zFxgfrUQLhzMCVS3pyCh?=
 =?us-ascii?Q?Nf4eHKICw0cWukiw5KFihSwlwZ7pk1aaiti8OEc2Ke2F4AFrcHR8/FFzRJvB?=
 =?us-ascii?Q?5UZ2XKRhsU5pb84HSu/qmiVE0sVHDz8jVMLvKAgtG0bezSZbpvHbc7cciTHh?=
 =?us-ascii?Q?7mq6MAJAXirhRpvoQH0fSnKJEZGxgH5cqlscinPpYN62BU6hJ7PhBPANvZ/h?=
 =?us-ascii?Q?uAAU3T5S32H50McLbBAxnN3xDl39aoVVqRfHgP6Wajb5yOvNPLBhfwa84pKh?=
 =?us-ascii?Q?O8AMol6QSbLSFJJdGsTw3frLehL8vSumSwrx+Q0eeNfYR0Bnx4+lisniUj6O?=
 =?us-ascii?Q?frKCBZHTZOTy85kjFfRLtbK2lVTV4h2GnttuJis53sHFc1P1iHRm4+gu56fW?=
 =?us-ascii?Q?nXgfWir5wPY6jjoM3iTNEpuiFscJsJQkeK7KcsC+ZHgGR2GWTPVqZMNvX2nP?=
 =?us-ascii?Q?qwTnzTlysd5AflBfcv8vOGuz5uavK7PHOlcKOm48j0auX3gQY7bF3HJNYyPk?=
 =?us-ascii?Q?4s1Q9Mm6umtzxOoZtgV/QtsP5Wh2yHLd83dtL1/OvboW5lntXbewN2gR9Fup?=
 =?us-ascii?Q?jci2gP34ECyYAmS8cbcfxUzm3XiOCKuPOFz4GrUDyHdbs7TfbsOqPTc2WZ9t?=
 =?us-ascii?Q?aTUSSUxAySG+KZQ59uTjzy1Es0qKKvPQj0hZHRd4xqFwWxmeXXBCDfW+CB6g?=
 =?us-ascii?Q?YAvZMvObqnXEUaM8pBgYfzS5xed52tgEjuqN5KK+olZvafJ/WogSauCbH1ei?=
 =?us-ascii?Q?qaYiTHHXw1ycfD2kMztWWENW0hru9sZRpNOheJpRvtFggCrvQzj1liWo5Znm?=
 =?us-ascii?Q?hTkzbxJ+KC9jPiJyn7U8UsyBGIZH/txwLdA4A+XcW5RErl2YWZ/qBSyoVk2D?=
 =?us-ascii?Q?hvnlB8cT8vo/R5eyRa/WyU0ka41u68MILwUWQhtz5CWulbaf1um3M3V4uDlK?=
 =?us-ascii?Q?oMAblyfPcAjURp/ITJ4dZF19cNQ9HZk+HBMhGev1ffpvLUklJUS9k/l17CBO?=
 =?us-ascii?Q?0qUYRgNjByU5YafD9Yn4A/x57TboswdsMZPU4zPI/kaUPUUKZU9j+7WmCbkB?=
 =?us-ascii?Q?lyPVUhCVR8KCDKkJuq8srtRdUeVXnTgqUwAOzrbemgMYWHiVtsOlO7yJWYTY?=
 =?us-ascii?Q?XdlHtWJicxY6RuvyXjZSrch9iaddFPx9iwAfP0NsUSTpUVToYY7nRzn8kWAR?=
 =?us-ascii?Q?0gQm2yqJ9kNhU/CxaMA2SrQ74zf2mYsWhHMlUOqCIx60HM+rawzOP5SNlwwc?=
 =?us-ascii?Q?8aSyvLW+IF5E/7De/a87bKyHzuW3Jm/oVJ7HgvrliNS3HRfI9oilGq3benJc?=
 =?us-ascii?Q?Lu2a3H3h7ZlHPtl5Ni8abpg0913zZuzsc26qaiMUvqfrqQ2pQvlcV1Vd0J3m?=
 =?us-ascii?Q?Kvcq7koj0NmQnnxP5+b6dvOg6M6k6IPqR4L3LnIzTWIRWvdzzxOcMQvKZ4he?=
 =?us-ascii?Q?LvsPt3ZxzXqmKpNKDIA0nIn3w0CKKMTpCwHRIck7Dzq8TS9GjF+GJlQFjriW?=
 =?us-ascii?Q?cMh948j1/m2pmexyuM+FVRW5t9DPNYwd+6WZrAhppA5LMTdz4wLkTyxBricU?=
 =?us-ascii?Q?3doM1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296146d8-5610-4013-b413-08db4f94b96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:20:38.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rf3Kon2rq6t7nxK7V0NbNWXx4Z8bWK8o7oy0Vg0DatXAuo7i0DkJuq08x0jHkhJaRKDdB7uCB0vrrWkdhfjZQD6Nd2xjIXPvjHM0Yt94S6tqYuR2//rgUShvKGicoxfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 4:25 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:44PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering INTx IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the Terminate at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
>=20
> [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs from end=
point drivers
>=20
> What about shortening the subject out a bit:
> "PCI: designware-ep: Add INTx IRQs support"
> ?

Thank you for the suggestion. I'll modify the subject.

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 71 +++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> >  2 files changed, 69 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 96375b0aba82..b35ed2b06193 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -6,6 +6,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -485,14 +486,63 @@ static const struct pci_epc_ops epc_ops =3D {
> >  	.get_features		=3D dw_pcie_ep_get_features,
> >  };
> >
> > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 c=
ode,
> > +			       u8 routing)
> > +{
> > +	struct dw_pcie_outbound_atu atu =3D { 0 };
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
>=20
> > +static int __dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +					 int intx)
> > +{
> > +	int ret;
> > +
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA + intx,
> > +				  PCI_MSG_ROUTING_LOCAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * The documents of PCIe and the controller don't mention how long
> > +	 * the INTx should be asserted. If 10 usec, sometimes it failed.
> > +	 * So, asserted for 50 usec.
> > +	 */
> > +	usleep_range(50, 100);
> > +
> > +	return dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_DEASSERT_INTA + intx=
,
> > +				   PCI_MSG_ROUTING_LOCAL);
> > +}
>=20
> Why do you need the underscored version of the method? I don't see it
> being utilized anywhere but in the dw_pcie_ep_raise_intx_irq()
> function.

I thought that readability can be improved a bit if a function was separate=
d.
But, it seemed wrong.

> Thus its body can be completely moved to
> dw_pcie_ep_raise_intx_irq().

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> >  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> >
> > -	dev_err(dev, "EP cannot trigger INTx IRQs\n");
> > +	if (!ep->intx_mem) {
> > +		dev_err(dev, "INTx not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> >
> > -	return -EINVAL;
> > +	return __dw_pcie_ep_raise_intx_irq(ep, func_no, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
> >
> > @@ -623,6 +673,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> > @@ -794,9 +848,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > @@ -813,7 +872,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > index 954d504890a1..8c08159ea08e 100644
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
