Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC97864FE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 04:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjHXB7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 21:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbjHXB7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 21:59:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD5E59;
        Wed, 23 Aug 2023 18:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7+4TNi3u0Ia0JXd7pr/UOoc8SBe4uG1f8k6vYMTwGw/9nrrgmYZCpLCgRrC8gINkze5HQF4E5pH7//xOMcri4m+raKC1d7tBzrMKadKCOOorpyAAGLdkbB7VbmQFoNed3sYMs4ANfImoSh2x+UIbm+BN4zCi5uOaR314B6a/mIceGvSftuua2Sm4HkKEIbV5pY9+XfNPSGgv9LMxVVRi9MnS2Pl7AdNGAU6ysrVPwVzcwyXN9lyV4R8bKC6hSHp62/ygyQjS/u9wVUKVCxlTGquKAoDa3ujNDF6jG5U3LMpvtSyn0NYKA/x7c65lSyrGnOVtrx1bLMu5VdePO9rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acwm1PzfxwIqAWWPkn3duRIFzyX/W0HImKLwklM4Irg=;
 b=flm/laq2ooUyvciWbdngj73TqyAFAAHj8IJKrGyM0lXuzj7XMYVlClCGEIEBPcyh68YL8i82/t58V9wkNSXvbLgwo7vl+d++owwVqXar1n6LMQGsy1TMTTxsfAIKbR82lOwO9XRz/F+F0sp2PoB8++HLXUfdwXrfE/jx733Jpv0xAyJ/5eMMIkk0IJMAODez/cBHkxNjS1lq93ZVcQi2iP1JPokm8NMtTomB0mlWYo/Zt2KctLfUb7EbqVRCSsTgR+HKOzreidAqK5qe5bFnFtBofz1rr0tKF06vljCgw25sFoRG07H3QUTWECuvcDhpyeEqoOpbwpSY0w4iI1RHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acwm1PzfxwIqAWWPkn3duRIFzyX/W0HImKLwklM4Irg=;
 b=B6Lg5EhHEKUNbvZPKNGynbBdJHMzndVx9uyTc310vu2bmrtOEZXXuxP/Su/lDVKKCf6wQkMFmSdJ6HSy4PKT43kjckzRe2/5vg4Q311+sgtjbSrHaTG2FtCczLy7lTR9I7LydexwqXgXjLtAw8eJZmavPXmYeYPFp5qmYmd7dTQ=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYVPR01MB11313.jpnprd01.prod.outlook.com (2603:1096:400:365::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 01:58:52 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 01:58:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
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
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v19 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [PATCH v19 04/19] PCI: designware-ep: Add INTx IRQs support
Thread-Index: AQHZ1aHiKafVNbC7PUy4CRo+299zia/3ruuAgAEApVA=
Date:   Thu, 24 Aug 2023 01:58:51 +0000
Message-ID: <OSYPR01MB533420D69167B555EC33F345D81DA@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-5-yoshihiro.shimoda.uh@renesas.com>
 <m76plvpf5zfvrajtnqycagp5yyd7c2njunn3clux2svof6zh27@gquktcx4n7qm>
In-Reply-To: <m76plvpf5zfvrajtnqycagp5yyd7c2njunn3clux2svof6zh27@gquktcx4n7qm>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYVPR01MB11313:EE_
x-ms-office365-filtering-correlation-id: eadf6532-4071-4b34-ebd0-08dba445aa46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rycEEF0IDNQKiFst8E4bi2TaEtYt8an4dFfn13Du1BHQ9dmyOAwFa2bFl6TuDUNV118XPhF0L4IbjK5nz7ZIlOilpUUTFdc31kWNugofAgZ2s3i6XkS0zPDAivIBcDXu8/1fyLce/fIhY+Cj7ju2amxzbOZDgbj5vd9XjufHIzMmBXRGX/RoGgwREN4OzgXH5DZUqNMjIAeEBU51LrksdglZqsPcGPbfndH/7QKqyPSRbwHxauGmFwswthy+sWGBimMKkAUeog7rGlyik6yUeisfBPXqtcc0W8KYZabcI9DNDLm1y0HT6A0mgLWpGyGXFW8FHSi4A8Avv6DyFp/Rr+DPocJB7Bmis3BIaTDynELOTWINHimTfbh7RI0slf8w/zfJQiWFMWEMs/ozOXGKZ7PyvlmxV/oft8+8Tj3HVSPijttQgXUiH+epH8qe40Plab0zAelOTz9n5W+RrPBJgGUPMs5eJkDWmTTIn8s2onosT4UP8fPq809hdaiDx0FtU3LwpIPPiXFXi7l1sd9fBNtp0BMa5YMNczaX8nS4aNXYgXXue4YItXJrJqLBuMZzlEMqc+VzPxjtGVKRMrKrHLPOQW0y4vUHXxwsD/xj7F6mmZDX9Z06HqBqUuKNwjR5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(7416002)(33656002)(55016003)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(478600001)(41300700001)(9686003)(2906002)(6506007)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mESukFcbqzK0+vYa5PzSYc3gfdnqLptVeICtuYJT4rwUvHmAmnzCja+GGPIO?=
 =?us-ascii?Q?CJe5kR74Es+reDPUFSHL9lFkWqyGGT+nQC7+74yXVFNXWPxfuDWISVv8UZs4?=
 =?us-ascii?Q?xk/2Y5hdtL7wI439wWiHNt6sWpt06MhxT+2wHRLi0N/mVSZs2AN/kQ/wGZ2q?=
 =?us-ascii?Q?PUyM+XhlOSUuqArHdzuegSaxsq93pdwezC/0DRyRRXg3ic1i5TWcyC821Frq?=
 =?us-ascii?Q?eJ0HezI/FLLa9xHPMgN1NqkO0L+rrD7YaSY5nS+mgfPnPEOj9ZCdiCF/B8CM?=
 =?us-ascii?Q?W8r2EDh6LgWdcEHFQ1i7cEG1RevxXJCGt16l5/35beiAcr3OamTifSPEDfov?=
 =?us-ascii?Q?pYXOu/YXGs/jgesk4Wp5jOSC6DA1uKVRwg04c6tRuwCysEMEk5zn79eWVVdZ?=
 =?us-ascii?Q?2MFXaUhJpnhyznQSiXYm//Brj8jr9CQb9SVi2UiHzKr+0WL1oPMKDApWNVdu?=
 =?us-ascii?Q?wp1KbA48qDqO4adoe4fWk+wWTiklqOiuKwjjcyGrx2wdJ5DyPGJBP2jLMCeb?=
 =?us-ascii?Q?PHif1Sby68XjLLodUJ4ZF4Iyu45w12rN1rEgEPm+OAfCoat6sL3UuP61zAPs?=
 =?us-ascii?Q?yBOszvWPbeylTnj81YiSyjZq2KefEy4iCz6l91jc0+H/HyJM1Ave3DKzNHua?=
 =?us-ascii?Q?T8J4ydTfwBdUgBy3aUSJosACbJDiBRscEteu4VA3R4oxHyiQDYqGX/+llsfB?=
 =?us-ascii?Q?jIRla+Fzy5r1CTdjRLMCkYNrvdjeAPcZz3T7EJ9emUPX7gLpME9QACie4ZEd?=
 =?us-ascii?Q?Obo0nLIWEHqnLg78AAv7Yeb5+xnKaNURdAFSe9OBNAtqkhK1VNxcSA22QN1J?=
 =?us-ascii?Q?hbRYHZ3NzmKYtMbQptq47HrVjSJBODfo6efnFV1VHmoMV1oo5iYCzGeN4Q68?=
 =?us-ascii?Q?D7SUw+nV0fpejWzITj+7FzP6lW//g7GqBtHVRkH3tERpe5rKp/CSp+wOARKi?=
 =?us-ascii?Q?KyzRedSBv7eWSgO8LAFQ3+T94oe4ZZX+xq8AyISqY5HeOAWYB63T9k7PfN0i?=
 =?us-ascii?Q?pOblQNAg8hLIBj6WyKt0d+MY+Se55THQl3/jRPtu0yJOsmUHpBlf/+XrWmg4?=
 =?us-ascii?Q?VLrmu+q9z2eN79puHGE6RsQnQunTXfbAy5inqkOZHlG54mNAEgzZXBsXfp+g?=
 =?us-ascii?Q?iALqG9Wb8DgSbmLLxw+trq1mE95Abc0zCJszaXjvIs1kQytV5okdqaB0EZw8?=
 =?us-ascii?Q?PgSUbi65Q3WVhWeOKzEm+4eUVJ4YyzEUXKVFj85xv0bDXl7yyTMkrP7mW7sK?=
 =?us-ascii?Q?1kx1vPU40duGdKpAk3cIZH2g01IG5HijTTErx0Fa77+89PGdZapkE+0PGC7V?=
 =?us-ascii?Q?9yAR00w8AzxG7+NuB5s48//7uuS1yrcMuK4H4bQnOXpvOq96kgoYseZrweJr?=
 =?us-ascii?Q?IdmeLIetdxKBwinO1m9UDmmJxVoAKBLEU/2oBc+9/6w7gZvUf7HMwPnBQKTu?=
 =?us-ascii?Q?kj/q0q/bo2/6je6Dtw9moZXyYrqhruWy7OQC/nfyx5wBwcrTjxvaBWaEwwwy?=
 =?us-ascii?Q?rnmU0dyUX7HG977JQuqzgGaSjuYwCUZDO5RjYk1JkCB5/xvoWo4UiIl4l059?=
 =?us-ascii?Q?ViYuFek7FHqr4qP297STh0R9n5a/sHVcUu6FK0U7Pt1pLnNbly5aEVhNvfKl?=
 =?us-ascii?Q?x6QMrzkYkkUQqvlMKnXUjUZ6MkMf/ANXpwVG0EX24iGs8/iTJ2POxM0XrD3q?=
 =?us-ascii?Q?YOU/Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf6532-4071-4b34-ebd0-08dba445aa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 01:58:51.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14CUxGaJKrO0vXkp+k4P7VmkWKUzoz2dJjehDbWWpHErlRF/JiCLdJoBh+HZvlJoxn8EbG8sF3gANQMAWWjU1XP4x9Ti93ZLAqNyJt6Y0Em6fwKXl0ZbmnsZ0I1i2GBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, August 23, 2023 7:32 PM
>=20
> On Wed, Aug 23, 2023 at 06:11:38PM +0900, Yoshihiro Shimoda wrote:
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
> > index 747d5bc07222..4a8c116cdd4b 100644
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
>=20
> > +	/* A MWr with an effecitive length of '0' is converted to Msg */
>=20
> 1. writel() means 4-byte IO-write. What is the "effecitive" length you ar=
e
> talking about?
> 2. You don't generate MWr TLP here. It's Msg TLP. See the atu.type you
> specified.
> 3. s/effecitive/effective
>=20
> > +	writel(0, ep->intx_mem);
>=20
> IMO what is done here is a dummy-write triggering the INTx Msg being
> generated. I bet you could have done it within any address from
> ep->intx_mem to (ep->intx_mem + epc->mem->window.page_size) and by
> writing any value, not only 0 because the Msg TLP doesn't have the
> memory address and data.

You're correct. The following cases could work correctly too.

writel(0xffffffff, ep->intx_mem);
writeb(0xff, ep->intx_mem);
writeb(0xff, ep->intx_mem + 0x100);

So, my adding comment was completely wrong. I should have checked this befo=
re.
And then, I'll change the comment like below. But, what do you think?

-----
+	/* A dummy-write ep->intx_mem is converted to a Msg TLP */
+	writel(0, ep->intx_mem);
-----

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
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
> > +	 */
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_ASSERT_INTA,
> > +				  PCI_MSG_TYPE_R_ROUTING_LOCAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(50, 100);
> > +
> > +	return dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_DEASSERT_INTA,
> > +				   PCI_MSG_TYPE_R_ROUTING_LOCAL);
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
> > index d31c018a3803..c17e5255fab6 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -365,6 +365,8 @@ struct dw_pcie_ep {
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
