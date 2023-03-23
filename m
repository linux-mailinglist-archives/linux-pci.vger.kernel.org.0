Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FCA6C65D1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCWKzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCWKyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 06:54:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A08EB4B;
        Thu, 23 Mar 2023 03:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex0qnWxwkIlT4eZS/6LAg+oZB2EbHNyClUN5rqFCoF6dB4mKUiieajIzL4dZBnS0mlb7bQ/FNONYcSJj2wW0clwfTCs6MDvwV3rZTuVP6OVCxgSPVU4QGbHaiLmonO4iM5Fkbh7oRHMKAErpk910hD9dahOYYiCJEpHhsHf47xtqWKyNKN9qshhW4bQmCqIdbO4ivXzHxkmhCdF0vmCiA5SDHhDptI5lVe+qh+gF8WWwz9b97bw9DoH59BR9yQj+/DF8e/CRpqawgx5wfHf8ivibT6mi0q5jaLsOIGFh72suzS5RXSDg0PM4KeXqLPOJSbcrmyHXzJVP5MIBMtKzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E6tzwH76iMtBrLYjDAn4f5zWfNlbVGAFz5lQPD9xOk=;
 b=XlefP7Iw7ZHlEDhWqEUrqmna1tG0EOzLHVH+guoKSifZmFiQ0R/Ld5+MGdJjOEZErFrQyXvJdCrXx+0vwe8c/rvzudMWYzf1r++B36/zx5eJXUvV0XEXXoaVCvUn30SMocteFL8QG0Tj1esw8z6W/F/HA5AmoVTl90UX+9o6TsFsrsoKU+YfZGSFWHE3UHmBWRKuYHhJBb8hdWYlqMrq3LYHB2AHFxxXZUjT1kiykPVQ8EVXmnUMyclkLDkThDfkFFg2FroE1sEt3oGVVNSXl/LsbCVaUoejXtkRokL+cFZO+f6m0jyqQZzZJoLUfYqBA53yQpqI2H7mlZnjmQVLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E6tzwH76iMtBrLYjDAn4f5zWfNlbVGAFz5lQPD9xOk=;
 b=FQAXKIDAktLGkzAYp2wwCm3mtMeU4UgexlEh2tKLrZzM2x7UGVAfYJf77/Svq00N2Y2JHMJkIOBovYyUUhe6V0kdpWBvpx4lZuN8Par8a5EOxbz14WVLGPe3+l7SV1HhdHolWBGCk0pq1XE8hV3B0CESFtIcqTDRDIXEAeVWhKY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS7PR01MB11702.jpnprd01.prod.outlook.com
 (2603:1096:604:238::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 10:54:01 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:54:01 +0000
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
Subject: RE: [PATCH v11 09/13] PCI: dwc: Add support for triggering legacy
 IRQs
Thread-Topic: [PATCH v11 09/13] PCI: dwc: Add support for triggering legacy
 IRQs
Thread-Index: AQHZU0zEnypfLqVbUUa42GMAgQ0MW68HDQ2AgAE2xbA=
Date:   Thu, 23 Mar 2023 10:54:01 +0000
Message-ID: <TYBPR01MB5341FCE013F5C67604AF3256D8879@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-10-yoshihiro.shimoda.uh@renesas.com>
 <20230322161741.4m5dgnjtcicfawqd@mobilestation>
In-Reply-To: <20230322161741.4m5dgnjtcicfawqd@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS7PR01MB11702:EE_
x-ms-office365-filtering-correlation-id: 4d9f11bc-a367-4053-b5dd-08db2b8ce99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roWCzC/jLCkjEnEDWAQHcJWbmacbBmwLT7WfrIQLoXw9cUKxwPhSCrBa2KwwC1AISjSgmSKm0gwnXDn/Wpw8+MyauVNvK1BvatUM2zZeFtN684m35C1Et88ZHcGhc8qwScj9BLNheTLp1OG+/aiHbphdpK3JV7Woulilnalpl+fRGq+K2SKQgZfimJJ3TIOUblY2OG12xpp4gQdmYfyNHU+ZsDyvulI10COqlWRQjY8KnEgdpKSN+F5I82+trQP4eSsBK3sejiVN66JN9nJeWuzgwXa7/jVywbiX9FEXJeSEaWMPpTnIjVEpS7igcPiynESgS6SimG/xC7RFrnwcEvIBCX4O558QB6iEAGSUg8WwSpgp9mxlzI14ugVIJjsICkMJ/nCTNzT0uRgC/aFpM2RNnRIQidCEx2zLaVHZFeIU9XontrJuYOZNpJCC+XrfX4Fiup3+ODOlYPkiu59vBJK2mDG3x39xXgMPlmCDcgFtWzocRnmJgvMfAdgk0wKdWrXUboOmOAbTsr66/4Pbib9p53+Tg4y56sngdr7IrlpAeBaDn2vrYbf01z6qJMCMEwn+m0WHNzTEMXgQLU4rJfb93ct8tIqL43mXlP5u2Q04QuJI/ch7Wvvncqda4e6I62wUCyyyOSYo2rUdKzV7RsW7yDqmtHw07fuCZfHaZTnElonPAFNIax2kZw1mFNM2n1EoV2SEydtBEX+dUzSTUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(55016003)(38100700002)(38070700005)(2906002)(478600001)(83380400001)(7696005)(186003)(9686003)(71200400001)(33656002)(86362001)(316002)(54906003)(30864003)(4326008)(66446008)(64756008)(8676002)(66476007)(66556008)(66946007)(6916009)(76116006)(52536014)(6506007)(8936002)(122000001)(5660300002)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zB1h8oPsgQCjeZmwNjXK4/mA6nMhPPeQUrLrx0zaFgMN2yP8E05iXVTWrdf4?=
 =?us-ascii?Q?Tunez9+tbjYyVZhfTWc+QjqUd6XijPjC08yhQViJc7ebu6nNYa6n8fArBIfe?=
 =?us-ascii?Q?lDzZS0Lyy4WYHcz0zeXzEQn7savSVdZcMVIQhWAXVvXsYi3aauc97SlNvzMz?=
 =?us-ascii?Q?h5mLNNo+3tCAix9DK99hA8mMK2P2uXX4lE+ZhWhuVDddwSbqkbqDrqGFVBZ4?=
 =?us-ascii?Q?Od7wSSb+Ap8iFWgYxH828a34M41YkLPe72ib47i3iVZ8bHi98botRryclEV/?=
 =?us-ascii?Q?jXphboRuM+xYnfnhKsjFkoS8gCcVkBE3m3U54rHG/Z6b8V0D2Sr3SPTg6g5i?=
 =?us-ascii?Q?X7UAgUhzIJDQu7KXBW7w84MNIltXzUfecelO0beFjrhqJs+0qvc/P8oyA8jc?=
 =?us-ascii?Q?0lm9YUwTeknu31VyBCyDhjcxVbbXjirks0F3WVdDMtURmgzXHVkkB55NEUSR?=
 =?us-ascii?Q?Wp5O3yHRMovrQM9ciwiaKJgDXDWXhXlzPcMBdSIG4J6haRDQeIoSCHcQX9Yk?=
 =?us-ascii?Q?lV9JOqRQ/umo7QJkTVCXTn82YGIz8Bu9MTJRjeTgX9BnnHjocMWE6BawMCuQ?=
 =?us-ascii?Q?Z4QfZeQn56E2tgY/k5NvIInkhKtN0L7TBcLAg6eOuOgiVp/gHl5ke6urRD/g?=
 =?us-ascii?Q?lvx0XfHMjeW29x2kc6NJ967DSeZhaYaDEV3XTpe+w8GbCkvQBl8E3/FzJgLO?=
 =?us-ascii?Q?6rCIxjtaA1eS+Ddxugy+D+lgx1yWhLlcdMt7RRI3s3+Gb1Cr2XjYCqWharhP?=
 =?us-ascii?Q?FAbjwzmw76/7DzyezpQBdbOHyA+rRzdQELJ+Fj/8fXcCMRbZonxJHqXfMu7O?=
 =?us-ascii?Q?7ozfMoJlm2xc3QyBy84yssv0nmryS6FFFXLbbJ+TVqoHto8AOmyHU/QKXhR+?=
 =?us-ascii?Q?B0cyh7+QS3u7QghSAPlh89WR9qi5tdq7tfHUpSJzkCtlnAhKjfcZ9i4ddRkF?=
 =?us-ascii?Q?uyTgddG00mah212+p6QPM5Uz6jGEwjyTji7rj66sXozmpRHci/LsuXHYPGpf?=
 =?us-ascii?Q?MYZUeQYZDiOOxulk6XSinCAw2zr6C/2X2J+QGH6+ytKWAcZcO2fEqGC1F9yy?=
 =?us-ascii?Q?q7T17pJ/KG6nK7c+18I/jjI6cvCcKGk3kHluIdJ/HqG0lgzg/f0J+n1y20rF?=
 =?us-ascii?Q?fhsiWbwWMx8TlGSrnnQ5lpBcFAAELDoFbpesUNbAec0Iw+T6L0/dBnPXt6iQ?=
 =?us-ascii?Q?gNrIv0oYCOnkqMUY5CSUnF+XvBQgtMYS/b6TwlFzYK3GC2xkauJNpEbXyk7j?=
 =?us-ascii?Q?kQLYfSrFoaamtYekaImDveBBMuf1gb861aMBkmbmlo1UGbPeHzUI0at+oi/k?=
 =?us-ascii?Q?Hc9dw9xBgHWNjksyitVVO8YGZyzzgBoi7dKWL2BgTbq96aXCK/GXyDhUCE1Y?=
 =?us-ascii?Q?sqOBRF3YI5Id3UZ8x3rMskKvLtCNziizTkn48/heBMRpR190hJozhwwsQDGn?=
 =?us-ascii?Q?B/CBMxosS97nWMuvLBmYelf4DqUikB6Jld1KSFdHpHPZljG9wTK4Rr2olHAE?=
 =?us-ascii?Q?X6xVdExoURQiFIbTk5XGrD+S7+ZJbjhvfzOGfUxw75CJUxiLX8q+OcxT6Zrf?=
 =?us-ascii?Q?YruEoPasXDW8vPEpDK1lysH4fhDQ3pDLxcCFlJ122j1frVFlh74+6bCcTPC3?=
 =?us-ascii?Q?XorYOYvtu5bnE49JNVicqbcuF2UjcbqA+6h6BfMXVVw0ZCWanJzY3jPJ4iZ8?=
 =?us-ascii?Q?KdyYrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9f11bc-a367-4053-b5dd-08db2b8ce99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:54:01.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv1AMxUKxBoFpIP4L6LdzkUgtf6LyXr5UtJYds/Gwo5eRSn/o7lCUAYzrV/urKvsYJeEOPa05eR/DTYbQ7HPfROkcu4nVLI5M5Ge8SjZn6/W1+DLOeMFs4fd+0hIDj9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11702
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

> From: Serge Semin, Sent: Thursday, March 23, 2023 1:18 AM
>=20
> On Fri, Mar 10, 2023 at 09:35:06PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering legacy IRQs by using outbound iATU.
> > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > The message is generated based on the payloadless Msg TLP with type
> > 0x14, where 0x4 is the routing code implying the terminated at
> > Receiver message. The message code is specified as b1000xx for
> > the INTx assertion and b1001xx for the INTx de-assertion.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 66 ++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 88 +++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 11 ++-
> >  3 files changed, 126 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 95efe14f1036..73b3844e8a09 100644
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
> > @@ -182,8 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep=
 *ep, u8 func_no, int type,
> >  	return 0;
> >  }
> >
> > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > -				   phys_addr_t phys_addr,
> > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no, =
int type,
> > +				   u8 code, u8 routing, phys_addr_t phys_addr,
> >  				   u64 pci_addr, size_t size)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > @@ -196,8 +197,9 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_e=
p *ep, u8 func_no,
> >  		return -EINVAL;
> >  	}
> >
> > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU=
_TYPE_MEM,
> > -					   phys_addr, pci_addr, size);
> > +	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, type,
> > +					   code, routing, phys_addr, pci_addr,
> > +					   size);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -306,7 +308,8 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc,=
 u8 func_no, u8 vfunc_no,
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, PCIE_ATU_TYPE_MEM, 0, 0,
> > +				      addr, pci_addr, size);
> >  	if (ret) {
> >  		dev_err(pci->dev, "Failed to enable address\n");
> >  		return ret;
> > @@ -479,14 +482,46 @@ static const struct pci_epc_ops epc_ops =3D {
> >  	.get_features		=3D dw_pcie_ep_get_features,
> >  };
> >
> > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 c=
ode,
> > +			       u8 routing)
> > +{
> > +	struct pci_epc *epc =3D ep->epc;
> > +	int ret;
> > +
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, PCIE_ATU_TYPE_MSG, code,
> > +				      routing, ep->intx_mem_phys, 0,
> > +				      epc->mem->window.page_size);
> > +	if (ret)
> > +		return ret;
>=20
> < newline pls

I got it.

> > +	writel(0, ep->intx_mem);
>=20
> < nelinew pls

I got it.

> > +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 fun=
c_no,
> > +					 int intx)
> > +{
> > +	int ret;
> > +
>=20
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_ASSERT_INTA + intx,=
 0x04);
>=20
> 0x04 - magic number. Please create a macro for it.
> * PCIe specification clearly states what 0x04 means.

I understood it. The PCIE_MSG_ASSERT_INTA is also related to PCIe specifica=
tion.
So, I'll create macros for it into include/linux/pci.h.

> > +	if (ret)
> > +		return ret;
>=20
> < newline pls

I got it.

> > +	usleep_range(1000, 2000);
>=20
> < newline pls

I got it.

> > +	return dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_DEASSERT_INTA + intx=
, 0x04);
> > +}
> > +
> >  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> >
> > -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> > +	if (!ep->intx_mem) {
> > +		dev_err(dev, "EP cannot trigger legacy IRQs\n");
> > +		return -EINVAL;
> > +	}
> >
> > -	return -EINVAL;
> > +	return __dw_pcie_ep_raise_legacy_irq(ep, func_no, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
> >
> > @@ -617,6 +652,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> > @@ -789,9 +828,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > @@ -808,7 +852,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 47860da5738e..364926832126 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -23,6 +23,17 @@
> >  #include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> > +struct dw_pcie_outbound_atu {
> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> > +	int index;
> > +	int type;
> > +	u8 func_no;
> > +	u8 code;
> > +	u8 routing;
> > +};
>=20
> Please detach the __dw_pcie_prog_outbound_atu() method conversion to a
> pre-requisite patch to make this change smaller and easier to review.

I got it. I'll make such a patch.

> > +
> >  static const char * const dw_pcie_app_clks[DW_PCIE_NUM_APP_CLKS] =3D {
> >  	[DW_PCIE_DBI_CLK] =3D "dbi",
> >  	[DW_PCIE_MSTR_CLK] =3D "mstr",
> > @@ -464,56 +475,58 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >
> > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no=
,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +				       struct dw_pcie_outbound_atu *atu)
> >  {
> >  	u32 retries, val;
> >  	u64 limit_addr;
> >
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > -		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > +		atu->cpu_addr =3D pci->ops->cpu_addr_fixup(pci, atu->cpu_addr);
> >
> > -	limit_addr =3D cpu_addr + size - 1;
> > +	limit_addr =3D atu->cpu_addr + atu->size - 1;
> >
> > -	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->region_l=
imit) ||
> > -	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +	if ((limit_addr & ~pci->region_limit) !=3D (atu->cpu_addr & ~pci->reg=
ion_limit) ||
> > +	    !IS_ALIGNED(atu->cpu_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> >  		return -EINVAL;
> >  	}
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > -			      lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > -			      upper_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > +			      lower_32_bits(atu->cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > +			      upper_32_bits(atu->cpu_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> >  			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> >  				      upper_32_bits(limit_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > -			      lower_32_bits(pci_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > -			      upper_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(atu->pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > -	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > +	val =3D atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val =3D dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENA=
BLE);
> > +	val =3D PCIE_ATU_ENABLE;
> > +	if (atu->type =3D=3D PCIE_ATU_TYPE_MSG)
> > +		val |=3D PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | atu=
->code;
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) =
{
> > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2)=
;
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >
> > @@ -528,16 +541,33 @@ static int __dw_pcie_prog_outbound_atu(struct dw_=
pcie *pci, u8 func_no,
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu;
> > +
>=20
> > +	memset(&atu, 0, sizeof(atu));
>=20
> can be replaced with struct dw_pcie_outbound_atu atu =3D {0};

I'll fix it.

> > +	atu.index =3D index;
> > +	atu.type =3D type;
> > +	atu.cpu_addr =3D cpu_addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	return __dw_pcie_prog_outbound_atu(pci, &atu);
> >  }
> >
> >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr,
> > -				 u64 size)
> > +				 int type, u8 code, u8 routing, u64 cpu_addr,
> > +				 u64 pci_addr, u64 size)
>=20
> The __dw_pcie_prog_outbound_atu() conversion has a near zero value
> if dw_pcie_prog_ep_outbound_atu() will be left with the bunch of argument=
s.
> The same concerns the dw_pcie_ep_outbound_atu() method which now accepts
> eight arguments.

I agree. So, I'll fix these functions somehow.

> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu;
> > +
>=20
> > +	memset(&atu, 0, sizeof(atu));
>=20
> can be replaced with struct dw_pcie_outbound_atu atu =3D {0};

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +	atu.func_no =3D func_no;
> > +	atu.index =3D index;
> > +	atu.type =3D type;
> > +	atu.code =3D code;
> > +	atu.routing =3D routing;
> > +	atu.cpu_addr =3D cpu_addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	return __dw_pcie_prog_outbound_atu(pci, &atu);
> >  }
> >
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index,=
 u32 reg)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 36f3e2c818fe..3dbadb8043ab 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -147,11 +147,14 @@
> >  #define PCIE_ATU_TYPE_IO		0x2
> >  #define PCIE_ATU_TYPE_CFG0		0x4
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> > +#define PCIE_ATU_TYPE_MSG		0x10
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> >  #define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> > +#define PCIE_ATU_HEADER_SUB_ENABLE	BIT(21)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> >  #define PCIE_ATU_LOWER_BASE		0x008
> >  #define PCIE_ATU_UPPER_BASE		0x00C
> > @@ -244,6 +247,9 @@
> >  /* Default eDMA LLP memory size */
> >  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
> >
> > +#define PCIE_MSG_ASSERT_INTA		0x20
> > +#define PCIE_MSG_DEASSERT_INTA		0x24
> > +
> >  struct dw_pcie;
> >  struct dw_pcie_rp;
> >  struct dw_pcie_ep;
> > @@ -352,6 +358,8 @@ struct dw_pcie_ep {
> >  	unsigned long		*ob_window_map;
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> > +	void __iomem		*intx_mem;
> > +	phys_addr_t		intx_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> >  };
> >
> > @@ -420,7 +428,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > +				 int type, u8 code, u8 routing, u64 cpu_addr,
> > +				 u64 pci_addr, u64 size);
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int i=
ndex,
> > --
> > 2.25.1
> >
> >
