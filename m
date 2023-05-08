Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3D6F9EB8
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 06:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEHEjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHEjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 00:39:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC541569E;
        Sun,  7 May 2023 21:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsP1w3rbBW5SkhLdP4zWszb+U7hyjVLiPIi0kAKUNbg2/7N6ThjXFjt4nDhqoO8irNsiSivtTmcewcyBK8pTnGxsPEwgAPgRipIXGEBVcew/H38YqaLuCjt6OjJ5FUhnfQ57XFpjxTbqWoWrWTFnKHbNbgeB9Y0SLeqAu2bak0YlmtJynWJZAwsE04T2P34Zaie4t+yeo0mMtV74kKsZy7WaO6PWWnOgDJBE705q+oX7yKKO1/5tkK7MljyV5ZO0U9T/lovO3mUQjogygKMvFmgYs21O8qoorBAsOyaX+ISb6rMWGHuKt5MysakX1ku2mPqmn5SfpbUh9dGyZtTrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxv81IS8ebmvJ9ihzRG0JJgurHuXEBR6JGbaNEy0FGE=;
 b=Xt2XzcPxWxkBbS5l87CpsjHDwPzR3vABVti864ilIz7fMn8hnl+mVJJmHXWobj7bvO6388CYQrMyWN7G8D8epdv1INLDB67ckbH1oq2i/wFAwCpN5l4HTmJHK05puVaR4p2HpNOocuH98RWto66Ju9mgGYTb7/ApeQrczp6lETFtWSoVP0bK2rjHYx6owdH2/rhq0eJIza/XDYT4GzFjLrFvu7hEDtoSitCn7fJ1oMZcATCTH65Vyz2aXzWyJeQW+CcRmN6rKKI44J8F78Phl1JeW8sAS4Q1Ug1uPtOzBlsrXAkR4i9jDOJVmxgYbYhrtaSeEZxdvd0vRAp84Oggkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jxv81IS8ebmvJ9ihzRG0JJgurHuXEBR6JGbaNEy0FGE=;
 b=hBdNut0WzlNde32TsDrOOf8saUeHuxh5WCTMnmBw6V8JCA29RzfXk3VfcH0v4ND80LnwMo1HtAFlMoXV+bYr+8Nk2LNVN0n+yzB/upRt0qd+VOyntzcj7cP4KI5AYhBS5gdELF6iRzPlbK2VmJ9GmbTTpuYxslmRe6rBHDm2LIg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11791.jpnprd01.prod.outlook.com
 (2603:1096:400:40a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 04:38:56 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 04:38:56 +0000
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
        <linux-renesas-soc@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v14 05/21] PCI: dwc: Rename "legacy_irq" to "INTx_irq" in
 DWC core
Thread-Topic: [PATCH v14 05/21] PCI: dwc: Rename "legacy_irq" to "INTx_irq" in
 DWC core
Thread-Index: AQHZd/tpsF9o9OFj/kyMTTuM2a02/K9FwAsAgAoc89A=
Date:   Mon, 8 May 2023 04:38:55 +0000
Message-ID: <TYBPR01MB5341AAE8C3846683953E506AD8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-6-yoshihiro.shimoda.uh@renesas.com>
 <20230501180900.6jmxgd2ob2ebf34d@mobilestation>
In-Reply-To: <20230501180900.6jmxgd2ob2ebf34d@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11791:EE_
x-ms-office365-filtering-correlation-id: a94fed9d-bac9-4511-91e1-08db4f7e2225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjjdT0nij55rMezyd2AKNsLrM+F7CsKWEvp64roTLVA92zOhoulYOHzr/y9Gpw0wUNHXWSZQMJTHn4hIChHlYcm3Es7DfK60fdP/6puvhPpmd9SAzMYddMiyEif7xOH1vp4Hqp/PnBCG6n0l/tEGqog1Jjax3eGwCXvmo1sq/WXwbh4BvDb8stnWzA4rbS+IUWLZa+kS7Bvgx8+Yqae0LQqNnk1yijqXRggl+AzcPczIWmsFs6ZoUJzQ8KVXEo9xz4x2kUYtFY6lxZm9CCChsqwmgrE6kX2K22//QG9X38sMF0js0OpcdgmqpqWJnJmfNSUfCSLHT1nZv2rqCNyvesNkft/RtbQ+l4EvWaiI8KfDL15N18i1qutUX1s3C0TvA1tz1BwMXy/00xBzK4Plc4Dv1+gno0PzL5aakDw93Oj8PNF+J06LctW4gVqbqSv9VVFU1Pjs+vWGQbAHkIqBPBsk1tPEg3D3+jkY2sciuyrLfP5ZTMu8tCTL4C2Lym45Jq6oXjLm8gpH0TWgz9YE1Z+paFMKrioap5uayribczsJyMFULalb0FDlFN5HTkp6cNkb18HyCFnTSY0iUI5iGvknSrouLoaTtPo0KsrFqTkhpWljEOJVnhWCAimw2bYI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(76116006)(7416002)(64756008)(6916009)(5660300002)(66446008)(4326008)(478600001)(8936002)(8676002)(66476007)(54906003)(66946007)(2906002)(66556008)(71200400001)(316002)(41300700001)(52536014)(7696005)(9686003)(6506007)(186003)(55016003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqLKFAONSj9oU9BxLIT5iwoz9oduZAjchcanwC6gIRZTyFK0gIQb/Mq0uaAY?=
 =?us-ascii?Q?rYCGpSHS6zTjPfFyUe+kPOJe6CXfWyKSVRGEVGdzpfE1e+8xR7sLsVKYUDDh?=
 =?us-ascii?Q?ychGIJIkBAWaCo2+HzTLNDnrtIyKZ2bLgYEJ23TOmvfG4bvZ/pK31K77PSp8?=
 =?us-ascii?Q?/QkRraS4vDD74WN2FsVHp2P8VTPtN8e/0wGy1scXKGPdZP4nzXDXToxeRfYR?=
 =?us-ascii?Q?T1PnxPB0UtLRydyM8egNtgalEuWohNfNe94lqzwa4rdgPaG51J3xl0NNOgte?=
 =?us-ascii?Q?MzXBOSASJ8rGmaZL9njrE2KE/215KTQR0Ig4jAwc4Dg42SEa23M/u2j2+cAG?=
 =?us-ascii?Q?LTn2p/c3wKEIa6SkbOBGjXAZWUbKAlCLkYw+b54DXjuaA0K9Hl5YjKnA8tuH?=
 =?us-ascii?Q?SyEpw9aSL5RzFUzLjKzXzvsCi95BK3cF7WMcPX6vvQxcsw2hitF31lX9GeFP?=
 =?us-ascii?Q?9lGgRquJQ0H7I0/th1o3QmR7ZiCBvWLUZbHBuEuOolAsy7nSIzfCcoMsEcdl?=
 =?us-ascii?Q?y3DT4vPdPJdW3rhryUH6T2e1p+7tHM0Au6mF5rEcLS59rOZxdvUV3yUqe4Wq?=
 =?us-ascii?Q?15kab3AUnjMX6pIQ8VzG1TvFV1tp37J1qycndo2sXMK1l9jz6/1zvI5gexmd?=
 =?us-ascii?Q?S4srXHKIYV9qlcDas9uTPLtIR5N0MP/W3tRkTApJnN/yN/DAyQ6CPQqpQure?=
 =?us-ascii?Q?Yx0Xkel20wwXZ97pVO95TRNX9kdWIKXuAHIzn1tsmzRbdiObGjMTG0tj4V/a?=
 =?us-ascii?Q?6IOpfk9YC7jn9ow7EpiVDpo1tztkqG1y+TacemfwfcMODhJmfkzMVXeDo44v?=
 =?us-ascii?Q?wURKqVaXW9e1XlnnVzNNWuGtzWDur/jvKljxI7E45lMH+m6HNpQ/RaYHJj7g?=
 =?us-ascii?Q?EC1FLbNMcwP0OJ49qHCdIgm9ciIycY9L2W6avhDz8jq3DwW/g3q9M83L3z6P?=
 =?us-ascii?Q?UGqOF/O4Mm95f7CxVpLPrr6la94O/0MTe8M7NilSQPNFbNsoFm7n0cnJRj7J?=
 =?us-ascii?Q?52oJizaoSHXGJLdqv3B0ahGJO/JZBD8LNMRQ1K/kIkzuzMa9IUXtOkWq8e1s?=
 =?us-ascii?Q?eV8Rx1H5lMyC4BVkmeElsIA+yoPcTaYlNw8HIu1fp3AJ+NSB6crNREJ4nQlU?=
 =?us-ascii?Q?8GUKgfvEGHivAS9kCBI6DCgFuykQ/GkMNNH5nNU+Y17XjRSNRc8bmMklzjwa?=
 =?us-ascii?Q?Fr5z/Q0Xl2eDBAfinTRx5EJulj7XsjYVkom+5zvP2+rulJKPFDgWafNNIwz/?=
 =?us-ascii?Q?YVbY0FrvlzjAJQxZWyM/6LT3B3CEqADaJYAhVFkX3ikCF4pe07MqDAoD+KJT?=
 =?us-ascii?Q?ncOKgeON91UhllbkkLeobKXdtaZdUvwfesXDUkG4D7cGvA6RFMQpKGG/Nsvv?=
 =?us-ascii?Q?4ZY11pZsaIPN34ZSOFb/GfplFDLoFbEh36C89mpAMS1njHIqeubr/d5RwkDl?=
 =?us-ascii?Q?PNuP0/QGbUozPqs8WHYGNsCPUATrLxS7QcbwyvayNW8HKli+oGyOlgZL6LQL?=
 =?us-ascii?Q?dwXq/FUGQYNzgzjhrKSramyenk0CAXpw/zRfGCG7kjbwuGNIPf4gmRlgEto3?=
 =?us-ascii?Q?OEXatnH6Eg+r/UjRcGyfuGFyeLVpv5ZPfkP7KsGfPcLFqEg1J/DX+E/eL1rL?=
 =?us-ascii?Q?aetRGtPKy5TaxQ0VDcAThxsL2eOi0VouoklFqiTorLtCzRUxUeEKnpVimJIZ?=
 =?us-ascii?Q?hFM0Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94fed9d-bac9-4511-91e1-08db4f7e2225
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 04:38:56.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJxkxpIy8pLwH0Cy/vmNgd5DZc9OacXEhgatyZo4jM+GA51NR7Y47b3XYxStixRKRDnKAfY9xu+r0WsFNEjettlG1tZhDBOC9gYXf+dMgKwk7x0l4feZZb+s/nr2euST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11791
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

> From: Serge Semin, Sent: Tuesday, May 2, 2023 3:09 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:41PM +0900, Yoshihiro Shimoda wrote:
> > Using "INTx" instead of "legacy" is more specific. So, rename
> > dw_pcie_ep_raise_legacy_irq() to dw_pcie_ep_raise_intx_irq().
>=20
> [PATCH v14 05/21] PCI: dwc: Rename "legacy_irq" to "INTx_irq" in DWC core
>=20
> Drop "DWC core" from the subject. It's implied by the subsystem/vendor
> prefix of the title.

I got it.

> Other than that the patch looks good. Although it would have been nice
> to fix the local namings in the LLD drivers too...

I'm afraid but, what is "the LLD drivers"?

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
> >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 6 +++---
> >  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
> > index 1f39e733ce19..0831f3947220 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1063,7 +1063,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_=
ep *ep, u8 func_no,
> >
> >  	switch (type) {
> >  	case PCI_EPC_IRQ_INTX:
> > -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >  	case PCI_EPC_IRQ_MSIX:
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/p=
ci/controller/dwc/pci-layerscape-ep.c
> > index ab3306e206d8..3d58fc1670b4 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -66,7 +66,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep=
, u8 func_no,
> >
> >  	switch (type) {
> >  	case PCI_EPC_IRQ_INTX:
> > -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >  	case PCI_EPC_IRQ_MSIX:
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 205bbcc6af27..a80b9fd03638 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -480,16 +480,16 @@ static const struct pci_epc_ops epc_ops =3D {
> >  	.get_features		=3D dw_pcie_ep_get_features,
> >  };
> >
> > -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> > +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> >
> > -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> > +	dev_err(dev, "EP cannot trigger INTx IRQs\n");
> >
> >  	return -EINVAL;
> >  }
> > -EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
> > +EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
> >
> >  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  			     u8 interrupt_num)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/driver=
s/pci/controller/dwc/pcie-designware-plat.c
> > index fc3b02949218..2689ff7939e4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> > @@ -49,7 +49,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_e=
p *ep, u8 func_no,
> >
> >  	switch (type) {
> >  	case PCI_EPC_IRQ_INTX:
> > -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >  	case PCI_EPC_IRQ_MSIX:
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index adad0ea61799..9acf6c40d252 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -550,7 +550,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
> >  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> >  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
> > -int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
> > +int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
> >  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  			     u8 interrupt_num);
> >  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > @@ -583,7 +583,7 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_e=
p *ep)
> >  {
> >  }
> >
> > -static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u=
8 func_no)
> > +static inline int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 =
func_no)
> >  {
> >  	return 0;
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/co=
ntroller/dwc/pcie-qcom-ep.c
> > index 077afce48d0b..3061e5e13476 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -659,7 +659,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep=
 *ep, u8 func_no,
> >
> >  	switch (type) {
> >  	case PCI_EPC_IRQ_INTX:
> > -		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >  	default:
> > --
> > 2.25.1
> >
