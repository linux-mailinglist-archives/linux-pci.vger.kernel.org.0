Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B687A5AC7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjISHXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjISHXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 03:23:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A4FC;
        Tue, 19 Sep 2023 00:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqvRiGA6OJ1f2JO62igtFbtm8WPFfPY9bVO8KqfZp/6vWxb6/A8JFDVtYZ/jDS4mXEYvI0XMoXJ3WRFh9R7LKs+sieyOq4eiQY17tQeV1d5uUbUleue3W+4BUNiSYbaw5TSVDJjirrhedRP6xSreQMpZzUZKVSy66c2Eh+Cl9JLOhZQWh8ytr4C/Ilkt8gmr7lybCWhyRwHUIBKlDHAxJmfbaCAqWwvNreC4jVTXVhZT+d/OY94Dtpq2NYDdpT3eQoK92+OgnwqqRwC8Zoyj2kWo51V52ls/YVMlZCsOIQQ+4AwTRe7HlHYy3aMwizm0RkmNwR3c2Ir1MuJmDu+/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J917dF0zZRe8sGUZUDbmmzoexLsTCv1sGheFaLWx7tI=;
 b=XQZ/9zKDG9grlNk47DOmxSEwrGQSzuR5odh2dGB2QoXfMW1yTdTq74BdaqTq/UYBUTpFRRlBvax7ooGNkKlf91ONvBgKTHniB5uRxX/71BeY16GEyUQ0z7b/w8Pcj2HNjiuP8jHZdw3WBUCfMmt3u5Pn2w7l+G8yBmfYQH+g1uTitRpytQXBKC4Q1Zq1mJqA/IAuN87v3n9UJrqYs7/kUGu6sDzN76rKzR3TmjaDmmuTm9/FOBSuvoczQ5Ma+myEJPCizfcil2OY+aItLALpefHGvWRq2bO2Io+j+/FMGSO16AzR2huLNSlUEhLYHUThsr3Qu2GF0Aa40kJCpNY4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J917dF0zZRe8sGUZUDbmmzoexLsTCv1sGheFaLWx7tI=;
 b=KqzH1ZHdumieOVRXBketH8WZ9GWBl2y7XxpWEmHOu3mnvWnd7rHZqOqlPV5QzMt00CEybNsosJJaRgbjtWLAWrUurivTMNFp11/4hRoKiUszHkmYHLPds2MFsZIFRMFtkGdnsg7MgaOC5vQYzQh15bCWwkzyEC+68HKCCSrsbL4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10709.jpnprd01.prod.outlook.com
 (2603:1096:400:2a5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 07:22:48 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:22:48 +0000
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
Thread-Index: AQHZ1zcOdRSM/H58w0WCrYWL3XR2drAZhliAgACMtyCAAnRgAIAFWa0w
Date:   Tue, 19 Sep 2023 07:22:48 +0000
Message-ID: <TYBPR01MB5341FBF030A8A4F35CA74B62D8FAA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB534145152342F6E6808D98DCD8F7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230915212356.GA122696@bhelgaas>
In-Reply-To: <20230915212356.GA122696@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10709:EE_
x-ms-office365-filtering-correlation-id: 550310c0-b141-4249-39ec-08dbb8e13a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V04zj7xMNqo9OgQgaMWxaWkQm7I9ce3qzAViLk296YLeZEDRYdg/jcE5MYFOAXv3F06UoawCACJ6vZHL474SB1LKSIogYifB1O3IE/3L1AZ8bMO3FvuKUpDP/g1KioXpbMSp/ZxbYtvPjkYmxLSQo70PT8UMZ28DuPyhutXSa2CFBMasBMzc4Bh7qotnQgJhnIBaG2LNiz8stI2H3NINVzN9odMBtxPE9BY2PY1vjq3IhltLSpM6G3F3RQNuLHaKmq4d/8G4yljNKn09eIoyV0SJWzyW2j640UAFAXeXmzOIIZYfRgyY8wPHUOnno7MDbLOueD5IrcihbimVzK2mBQSM0asie691dCp15veJbEy9AVrdS3pfj8/yqmT7CHRdVgwpKJT/QGy1z8EwnozoWItLaCwoxt5NrEtvRrZQujp7xOFiLSCwASruk9ULBvRSYo0IgkAbGM5pFCpNRY9xXluYWG/DsWkohFDVOuOC0ghQRSOeht7RWldZZp0PwmUd4UKTc3x6GxDW2uC8m2JVr/GgehGJH89Y/AnfFRJG1P22CU5LNk+1lDq2RJUcKzhJ0KeHCY/EpNtAM537PWhvfDsPz9Mv3p060pOZLleX0ydHJjbZLPeaF/+tMWL8CHXEv9sr3P50grW1rRCoc//Rcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(45080400002)(6506007)(478600001)(966005)(71200400001)(55016003)(316002)(86362001)(83380400001)(5660300002)(2906002)(7696005)(52536014)(122000001)(66946007)(54906003)(9686003)(76116006)(66476007)(64756008)(66446008)(6916009)(66556008)(41300700001)(38070700005)(4326008)(8936002)(38100700002)(8676002)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ljqtn1h1VeOhKvlIvr9pRmSWYmqwFO9uQUiKWW50m40voHNVj3WN0GRfcg1p?=
 =?us-ascii?Q?oO0bsKRMhrguz7Gl5N7nn/PjwJUuIQTah54lZd9vcCAopcHwiPm5d5ufPTQm?=
 =?us-ascii?Q?6sGlBNEC9FAg6GxDeYTYD4Q5C/fGf/6s2C1glENilsSTX7dmTl65rvCUvHy2?=
 =?us-ascii?Q?k+eldZFPjGQpvLFiuKoV1uGX564LbV9vfgp17rpVcaWP7YSBOwS2CDiXPfqR?=
 =?us-ascii?Q?yH5farw+my65WKEVLYtR0jJEQzfrR2ca+vIhUmY9IgcWJpwG/vHIDyBYzoqK?=
 =?us-ascii?Q?T66eNxi5D/XKYV45ot4XRgglTa5oMOJBO+JO+ToUWZHitpQQ+9RHbQQyftWm?=
 =?us-ascii?Q?vEEtWjW2E32HN5pdqiJ8Ugm0a+bFriV7X/EQYmdHXr14n82lDbO24hkaFf7n?=
 =?us-ascii?Q?7w9IdeqYaOslzZiij1eeUVMtVh+4KTouJCijwHBdsafvTFo4+NgfE6gV3Zru?=
 =?us-ascii?Q?8Qcgyh9tQSkC6vHrUuQSg/mYamcKBjw+6Sp657rLuMvZ+o1kmFbZh3ETfuXn?=
 =?us-ascii?Q?hz+Gz7FC3RMjPs7+8xqhJxXKxezZ44u4gJJEtc9Bi+r/tSbY5mQdd3YkO5Og?=
 =?us-ascii?Q?DCvw0Fu6kOsqLzYd3rGgQwYCzd9nhWP3s9NfYWB6FL1s1Igv85UNSMgHzl9m?=
 =?us-ascii?Q?kO4h0ftlCu+6NltYjuhalLE3X03LNcyNW6q8wiDv8Ol6QI80WCphKZ1h2HtC?=
 =?us-ascii?Q?Fgc4CZlBlZ22P6UiDImmzSGOy7cZRDuGeDJCteYRf8RTpVxdoh0vG9vg70zM?=
 =?us-ascii?Q?6H0usgDS2obn1NQ0aQg39MjKJ32lNgVun5fRO8RcIJBsYh5cZb21nJYi4gTh?=
 =?us-ascii?Q?MLzyAoCqrsm33kMCRsXh3MpaDkAsahwufkTwg356two6aO9h9onqIURW+i0v?=
 =?us-ascii?Q?7UxK39R05UnGnZ0pDfN5CGL8+P40gcM3DFJDRW3xq0N5UkAhfzS696wrnFd1?=
 =?us-ascii?Q?Ts7KK48CBl7km5BeSQn0yrige8xb3NNcBrsCpgSUYwQBqC2qEIWnY7ZQAABD?=
 =?us-ascii?Q?9AqkTVZa0EdK/soNzYPT2kVzMRujx4krqW0y+sMArIm5WGxfuHOqKMXi6tVr?=
 =?us-ascii?Q?nJnVGj+fE6QzkBxpAKZWM4TLbG32TRHFLJfyQk2cwLjX6UsF66MTmo7b3pj5?=
 =?us-ascii?Q?4uuXhSgN99ca1UOXwr7893A/d3s5DzzwoKp1SKMZUsgqmmEvehSldeedPkK3?=
 =?us-ascii?Q?uc/FPnch8bwzBmQzK7Co6R+drQJrecX8z1TuX2sJguGpWj9FOqu4Aca3q+EC?=
 =?us-ascii?Q?rq0/Ckaw0OdQ1RoH05AwpH4si9LcuDHIE3eWlAKH8z3wwlVUhcIswwJJSY1o?=
 =?us-ascii?Q?lRbXqG8ZkmlPMufUmGLNU80Eh+6GhDEJqp5ngA/peUcKb4PyU/nt6Y3j8Au/?=
 =?us-ascii?Q?enEGABmG99ZnZRbAuWThEf1meQPpsskOhB64kvqxaux0GTmTRM7Hfa5P01sz?=
 =?us-ascii?Q?IHflJ9xZD3ygN2HbhN82p2Dyqyi6rEj5Hp+TuZLNpWtOTyXBHSCucLYc5E7S?=
 =?us-ascii?Q?BoaBlmicLzNQ01rMvG2aoov7uZ8+vTtWK8id7SK40crzH8xwam5nTalUs6JX?=
 =?us-ascii?Q?yIJPc+IQJ4C7YeukeQ/p9oZmxR4Hy4nuZv8PCs/zK9ZzvyaBl4vt6Xhye+0t?=
 =?us-ascii?Q?mRHm385VSJIajtSC2NRTGORn7gk2S0nruionQJgsxv1IX6bxo9VW/DeXZLZJ?=
 =?us-ascii?Q?X2DCFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550310c0-b141-4249-39ec-08dbb8e13a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:22:48.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wMgB4i+TQirttgG1cVtf5ZN0aIrlUzit6+U93n5FbszOVJOsdF97SJAqVIRGEiyzMiJqY6X6a9ceOvAGQvN9FCsh0fTShPPkKMR8aWIYbsRfjZ3RbEMMq+r17KAlVGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10709
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

> From: Bjorn Helgaas, Sent: Saturday, September 16, 2023 6:24 AM
>=20
> On Thu, Sep 14, 2023 at 07:56:21AM +0000, Yoshihiro Shimoda wrote:
> > > From: Bjorn Helgaas, Sent: Thursday, September 14, 2023 8:31 AM
> > > On Fri, Aug 25, 2023 at 06:32:04PM +0900, Yoshihiro Shimoda wrote:
> > > > Add support for triggering INTx IRQs by using outbound iATU.
> > > > Outbound iATU is utilized to send assert and de-assert INTA TLPs
> > > > as simulated edge IRQ for INTA. (Other INT[BCD] are not asserted.)
> > > > This INTx support is optional (if there is no memory for INTx,
> > > > probe will not fail).
> > > >
> > > > The message is generated based on the payloadless Msg TLP with type
> > > > 0x14, where 0x4 is the routing code implying the Terminate at
> > > > Receiver message. The message code is specified as b1000xx for
> > > > the INTx assertion and b1001xx for the INTx de-assertion.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 70 +++++++++++++++=
++--
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/driv=
ers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 747d5bc07222..91e3c4335031 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -6,9 +6,11 @@
> > > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > >   */
> > > >
> > > > +#include <linux/delay.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/platform_device.h>
> > > >
> > > > +#include "../../pci.h"
> > > >  #include "pcie-designware.h"
> > > >  #include <linux/pci-epc.h>
> > > >  #include <linux/pci-epf.h>
> > > > @@ -484,14 +486,61 @@ static const struct pci_epc_ops epc_ops =3D {
> > > >  	.get_features		=3D dw_pcie_ep_get_features,
> > > >  };
> > > >
> > > > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, =
u8 code,
> > > > +			       u8 routing)
> > > > +{
> > > > +	struct dw_pcie_ob_atu_cfg atu =3D { 0 };
> > > > +	struct pci_epc *epc =3D ep->epc;
> > > > +	int ret;
> > > > +
> > > > +	atu.func_no =3D func_no;
> > > > +	atu.code =3D code;
> > > > +	atu.routing =3D routing;
> > > > +	atu.type =3D PCIE_ATU_TYPE_MSG;
> > > > +	atu.cpu_addr =3D ep->intx_mem_phys;
> > > > +	atu.size =3D epc->mem->window.page_size;
> > > > +
> > > > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* A dummy-write ep->intx_mem is converted to a Msg TLP */
> > > > +	writel(0, ep->intx_mem);
> > > > +
> > > > +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> > > >  {
> > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > >  	struct device *dev =3D pci->dev;
> > > > +	int ret;
> > > >
> > > > -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> > > > +	if (!ep->intx_mem) {
> > > > +		dev_err(dev, "legacy IRQs not supported\n");
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > >
> > > > -	return -EINVAL;
> > > > +	/*
> > > > +	 * Even though the PCI bus specification implies the level-trigge=
red
> > > > +	 * INTx interrupts the kernel PCIe endpoint framework has a singl=
e
> > > > +	 * PCI_EPC_IRQ_INTx flag defined for the legacy IRQs simulation. =
Thus
> > > > +	 * this function sends the Deassert_INTx PCIe TLP after the Asser=
t_INTx
> > > > +	 * message with the 50 usec duration basically implementing the
> > > > +	 * rising-edge triggering IRQ. Hopefully the interrupt controller=
 will
> > > > +	 * still be able to register the incoming IRQ event...
> > >
> > > I'm not really convinced about this "assert INTA, wait 50us, deassert
> > > INTA" thing.  All the INTx language in the spec is like this:
> > >
> > >   ... the virtual INTx wire must be asserted whenever and *as long as=
*
> > >   the following conditions are satisfied:
> > >
> > >     - The Interrupt Disable bit in the Command register is set to 0b.
> > >
> > >     - The <feature> Interrupt Enable bit in the <feature> Control
> > >       Register is set to 1b.
> > >
> > >     - The <feature> Status bit in the <feature> Status register is
> > >       set.
> > >
> > > E.g., sec PCIe r6.0, sec 5.5.6 (Link Activation), 6.1.6 (Native PME),
> > > 6.2.4.1.2 (AER Interrupt Generation), 6.2.11.1 (DPC Interrupts),
> > > 6.7.3.4 (Software Notification of Hot-Plug Events).
> > >
> > > So it seems to me like the endpoint needs an "interrupt status" bit,
> > > and the Deassert_INTx message would be sent when the host interrupt
> > > handler clears that bit.
> >
> > Thank you very much for your comments! About this topic,
> > Frank also has a similar opinion before [1]. So, I asked Kishon
> > about this, but I didn't get any comment from Kishon at that time.
> > Anyway, to handle INTx on PCIe endpoint framework properly,
> > we need to modify the PCIe Endpoint framework, IIUC.
> >
> > Should I modify the PCIe Endpoint framework at first?
> > Or, can this patch be applied as-is?
> > I guess that such modification of the PCIe Endpoint framework
> > need much time. So, if I should modify the framework at first,
> > I would like to drop adding INTx support [2] from my patch series
> > because supporting INTx on my PCIe controller is not mandatory.
> >
> > [1]
> > https://lore.kernel.org/linux-pci/TYBPR01MB5341EFAC471AEBB9100D6051D871=
9@TYBPR01MB5341.jpnprd01.prod.outlook.com/
> >
> > [2]
> > The following patches are not needed if INTx support should be dropped:
> >
> > eb185e1e628a PCI: designware-ep: Add INTx IRQs support
> > 5d0e51f85b23 PCI: dwc: Add outbound MSG TLPs support
> > 4758bef61cc2 PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
> > 44938b13046b PCI: Add INTx Mechanism Messages macros
>=20
> Since INTx support isn't mandatory at this time, I think we should
> drop these patches for now.  If/when somebody definitely needs INTx
> support, we can resurrect them, and then we'll have more clarity on
> how it should work and we'll be better able to test it.

I got it.

In this case, should I submit the patch series as v21? Or, like the previou=
s
time [1], should I submit some patches for squashing the controller/rcar br=
anch?

[1] https://lore.kernel.org/linux-pci/20230901131711.2861283-1-yoshihiro.sh=
imoda.uh@renesas.com/

Best regards,
Yoshihiro Shimoda

> Bjorn
