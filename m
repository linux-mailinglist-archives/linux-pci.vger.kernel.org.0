Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEE69908A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBPJ4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 04:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBPJ4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 04:56:39 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F037577;
        Thu, 16 Feb 2023 01:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJpRxXfeBrXM/Mdb6be6mLtvRfoAQhMRHH0ecvnUSDSm4HUQ9zUyVHHw9zhget888fv3daGpkDov8RhxRy9lZ7PS6pyZEBFE6aFTF1/CdVFaSYQqaTl3TFsPrEMVB6Mscxj3W6YjKtfqDsWfO/yY0H9ABkaT4kaFE7Ls/hofiJ2t25yIQ5n/1B912O1FmbNqd4alkEi78o7rhC9LfspyWzuTJWe5Vi8dp7nN17prym8PAnyUlqlK4I/WopDaC2+likIkklhKcJD3SNjxaKyESuY8yZUFc2bmBwjvjdo8fKrb2jtjWlSv/5+w+bkKZ7yrz2lJbUDwETZgQoepWlWVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep95r/3MzZemWxkejwoMcef78vh2PJJM3XMyKWPWDWc=;
 b=Ei5qjkJRM56bsXckaCs1PoNZ01whYOBu8Z6CHW2vP1Y/rs6EoH+imm64XmZ2lAAZIRp3lpUlyl/F5v9b/EkcHCzU9KucE90ePlsT8UFI+xS7/57QZypmEjVCNOW9i5qmR5t4VR70eRX5Pxa9rfvoi+rBPbVxRu02owoMo3cKV0R4+JmxRvlnnKT42FChoFEySQBh85B3FY5FgqdgaTzxGjQW6KOggVyI7niZRhf2xcA0ghumwmw9j8FVGhvj391Oi/5/tCLB9y6vcy3b7GKuuqNGtnT12RYmGVNif+yRQsXjRbKgJPOaJQmYbWlskz+Er8cHxpUS9XqFr6P5uxnHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep95r/3MzZemWxkejwoMcef78vh2PJJM3XMyKWPWDWc=;
 b=CZ2opeToCqM9rsAXcUGanItioyAqndeNEpXrHzQhB5t55FlGTvfjsJQ17/G8hdC4xicoSK2yPNn5sj/KmIziauyvLkk53U72YCKrToEL2QStd+vtvQ5kFPS28DcuNNm2sP/jhxm8uyqDiBp4EtzYMoqyqrakG6o99xk5YmTStWY=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYYPR01MB7854.jpnprd01.prod.outlook.com (2603:1096:400:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 09:56:33 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::36d0:6f72:47fb:ed43]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::36d0:6f72:47fb:ed43%4]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 09:56:33 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
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
Subject: RE: [PATCH v9 5/8] PCI: dwc: Add support for triggering legacy IRQs
Thread-Topic: [PATCH v9 5/8] PCI: dwc: Add support for triggering legacy IRQs
Thread-Index: AQHZPVZ7IvxxLmyn6U6S62mwDrraUK7QJwuAgAE0c1A=
Date:   Thu, 16 Feb 2023 09:56:33 +0000
Message-ID: <OSYPR01MB5334DEB2AFA69AB7DDCCC9BDD8A09@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
 <20230210134917.2909314-6-yoshihiro.shimoda.uh@renesas.com>
 <20230215151913.ilqqzbfzfbitpeop@mobilestation>
In-Reply-To: <20230215151913.ilqqzbfzfbitpeop@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYYPR01MB7854:EE_
x-ms-office365-filtering-correlation-id: 9b102ea2-d913-45f4-98ac-08db100415df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21ib9RV5nfN27PNdvubH+kyZf3HdMxAGNIHas573R7qrI+1OXcawky4GlKmgZC00Wuvw7RTfq2UiqT0qT6uApUNMEJX4MI9qEpM66UrL8xnuYdYSBKxSuPwLg9Zf/Y9OpYnHpVAhY76lBFZc5xJ/EqUEljNLL4i3kZMsf9w+RiSNJyrvdCFId5KbkS6A1hngZTLmmqskv6r7SACLNjQl1ZE96vVDdh1zRzfFbZQ8ORGocH8xBwKtQOyyOSh4v5owQAU05UWVk9Y4/KLdQV+EGg0YpxmQV5QachBObULD4Xs9QUPV20d5DuSw90eGT+7iEnOdBRg8b3JoAj1YMHzxER/jrfRj21krwgOVv2umJ8+XbelballFUBTE47/uQAkxDCsCF1H8/VSGWQB8Ou0BP7Kt/YZW+FXIOfNR8wj3p7GWDCep4/ZSxHxUKTnLZCNPS7HKsMjrd/KdoGaoP62izw+SnxGK6Eqz/Bl7EPV67auFTIOT5IgRnRVH8eAscGxqCwxvngopYsUTyS7kYSs+VaHMqsJQsp28TVWdXXqd11VtvX9bjyn+Pa+AnTEALuUzMTmcPtHSImEuRQ9ugz50AwX63mxFfo0IN6Ox5Gwnie0/zhnu83y3yGFqFp7o0g14Ipy1ytIHSSqUTBNuVXZOgjWITko9q4pIB/xK0w98b0OB0Rn+CATDTRzF9GWj8LsEjia/5Bbh3EHUQu1oR/ORbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199018)(478600001)(55016003)(38100700002)(83380400001)(186003)(7696005)(9686003)(6506007)(26005)(71200400001)(38070700005)(33656002)(2906002)(30864003)(54906003)(110136005)(316002)(86362001)(52536014)(5660300002)(41300700001)(76116006)(66556008)(7416002)(8676002)(66446008)(64756008)(8936002)(66476007)(4326008)(122000001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LecfWTSuYB3iRGr1KiJEKXNOgn8S8Q4GsLcfkxtxf5+UhbmU9SHlRPUzcSCu?=
 =?us-ascii?Q?Oez4gC7lkI4bXIfPLhFSvDelHHgdn4EP5ahDIFB3S8lTz7k+HQO7WMhOFfpj?=
 =?us-ascii?Q?2KL9HSUZMi4K0Vcrkh/DgLVD75Alkt9KSESmoMVLf2t7oi6VOrkR5+HGflKO?=
 =?us-ascii?Q?5JhXc9zmlQeUyJOJgBJ8Kfy9PpSNT/QdnyeZK+qT8mDvA1pL41DhW4iFloaQ?=
 =?us-ascii?Q?BinOjMeglmpKtMKkvEV2yI3nHirkUBrypteT5/UoRImlX97+35FqSNNBm3FE?=
 =?us-ascii?Q?QFnzYfq8VsZFjPcQILyw0WiUf90vm9l8BMh3ekzOJ6Mya5Y4gd7QHHYP+WRE?=
 =?us-ascii?Q?8OSEWzU9zkFQbKDDL+nsA1RzA7hfjLZafyEFJO/rl1+V6UA/FGhgwO0lT1Do?=
 =?us-ascii?Q?I60G7Yj/99iggSOsBRk28ZMIX96+sDe3McyU8In8vPMoacTkQsFVZn/QR6RM?=
 =?us-ascii?Q?osdRAChoINqIhzAQ37udEvlMcju0+3U5J671fjlIBx+3T+jJ2Snfi3X5WsWJ?=
 =?us-ascii?Q?URYf7Tfc/5IjPVJJzQiehc2ur84cv2CofPv6DWpVhunuLyg3r+6E6uvcYFIs?=
 =?us-ascii?Q?3Rj7fTELnmKB/v73SXZgKJMSGtzy54G9hH4FUbnz2XK1WXDFo77VqNAhGh30?=
 =?us-ascii?Q?cu3zowtBMyp2W7J1Q4tAsmqImVwH7jaqPwfwkQvJX9A91M0MLBGWfRw0TXX/?=
 =?us-ascii?Q?vQH8F2NE7Ld+uWVxTCQTB30WE7g3HDjZd5aTKkD30SPfHz50TXo1Ff0mm7Nr?=
 =?us-ascii?Q?YLSpEvm0X02uf3XmAxv+fIHODOqy345e2OIWI/PZZMOHNJ7nvaewXsNNVAxX?=
 =?us-ascii?Q?uYNHVfhH1+xLUycn/YNMRmKgtIErjEhvvZM/4I0LUYZC5+nqkuvfEvcZE0Z3?=
 =?us-ascii?Q?OTn3ubqZHFiDBMdpKCouzDlNU6OLSyJtXHlpeg3m6HvWyP6BOIpH6FLGkK1s?=
 =?us-ascii?Q?aeOiysd86eNQVvAobBNVsymNx1NtWXmAGzRWKaKF6DG4sU1wJ7sPXt/wEEXq?=
 =?us-ascii?Q?+QbfX8oKnyB2yycqMKu7DZnh4bJ4WWErSuToqCOGnuhx15LNnbJrVbuEKWou?=
 =?us-ascii?Q?2wHHMtQyFydh6Ibq/q2Q6hmQq/B0OxzgRW1/xrX9sab2RXsPhihDTDQkrwXL?=
 =?us-ascii?Q?vzL6MnrGbFMJ7JYlph7AXk9BuxbFzBxR9unmkHTkc1yQnkEnhtjZX04uylSH?=
 =?us-ascii?Q?0qWrTxJ0FDsAMZZUr6nipuL3ez7NYko5lhuV68inC+cX9Cz9LiVN38nnoBYJ?=
 =?us-ascii?Q?YyY76VkG9D+2G9AWeYkMjMsItlDAW15UvXcqUmhaKLEBNcDXKz6OM1cjb75y?=
 =?us-ascii?Q?nkIxo22/fwonoG29xZ4fa0Mdq0xwexUicXFjD6H9xpHPoPCehTMobrwr1JrJ?=
 =?us-ascii?Q?/Oxp6okFmrhvSQjkoNzEIgWD+x4QJYC9JpN/LhfqGqiT335uYIPREhRJ5xbd?=
 =?us-ascii?Q?12amlaWfhq+Zh555tZzfdJx4cgDp2Vsej+BWdTcQR903F/H7td02W5b95ArY?=
 =?us-ascii?Q?sXqKnrsP5UCo7hzci9VJAYB1XnGy+HxA/uZeji4NsNTU4cx9JqW8/Ci9xPGv?=
 =?us-ascii?Q?C3P6CsRQQQxXNL3sXpdBvTiG45fQKUkNYKp0uf/ne+2aZWdEnUkhefmvfGKb?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b102ea2-d913-45f4-98ac-08db100415df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 09:56:33.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMRPPgWadY71A+5bFQV7WXz9P2XMeLSWXMx5Cdv4TKuRM0VyaJsq8k/dzqf7mDw1uFShhO7xSQ5yGIW1cTjBku5/gM+sqwMoeaxBeU7WFdl6QuxaxnRWIUigCEdD8ZYh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Thursday, February 16, 2023 12:19 AM
>=20
> On Fri, Feb 10, 2023 at 10:49:14PM +0900, Yoshihiro Shimoda wrote:
> > Add support for triggering legacy IRQs by using outbound ATU.
>=20
> I supposed a little more details would nice, like outbound iATU is
> utilized to send assert and de-assert INTx TLPs. The message is
> generated based on the payloadless Msg TLP with type 0x14, where 0x4
> is the routing code implying the terminated at Receiver message. The
> message code is specified as b1000xx for the INTx assertion and
> b1001xx for the INTx de-assertion. Etc...

Thank you for your comments. The descriptions are very nice to me.
So, I'll add the descriptions.

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 66 +++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 25 ++++---
> >  drivers/pci/controller/dwc/pcie-designware.h  | 12 +++-
> >  3 files changed, 87 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 95efe14f1036..886483bf378b 100644
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
> > @@ -479,11 +482,43 @@ static const struct pci_epc_ops epc_ops =3D {
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
> > +	writel(0, ep->intx_mem);
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
> > +	ret =3D dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_ASSERT_INTA + intx,=
 0x04);
> > +	if (ret)
> > +		return ret;
> > +	usleep_range(1000, 2000);
> > +	return dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_DEASSERT_INTA + intx=
, 0x04);
> > +}
> > +
> >  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct device *dev =3D pci->dev;
> >
>=20
> > +	if (ep->intx_by_atu)
>=20
> IMO the flag is redundant. Your implementation is generic enough to be
> useful for all the DW PCIe EPs. If you are afraid to break things,

Yes, I'm afraid to break things.

> then just make it optional. If no outbound physical memory could be
> allocated then initialize intx_mem with NULL and move on with further
> initializations. As before the Legacy IRQ raise method shall return
> EINVAL in that case.

I got it. I'll modify this patch like that.

> > +		return __dw_pcie_ep_raise_legacy_irq(ep, func_no, 0);
> > +
> >  	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> >
> >  	return -EINVAL;
> > @@ -617,6 +652,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >
> >  	dw_pcie_edma_remove(pci);
> >
> > +	if (ep->intx_by_atu)
> > +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> > +				      epc->mem->window.page_size);
> > +
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >  			      epc->mem->window.page_size);
> >
> > @@ -789,9 +828,19 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		goto err_exit_epc_mem;
> >  	}
> >
>=20
> > +	if (ep->intx_by_atu) {
> > +		ep->intx_mem =3D pci_epc_mem_alloc_addr(epc, &ep->intx_mem_phys,
> > +						      epc->mem->window.page_size);
> > +		if (!ep->intx_mem) {
> > +			ret =3D -ENOMEM;
> > +			dev_err(dev, "Failed to reserve memory for INTx\n");
>=20
> As I suggested above you can just dev_warn() here and move on with
> EP initialization.

I got it.

> > +			goto err_free_epc_mem;
> > +		}
> > +	}
> > +
> >  	ret =3D dw_pcie_edma_detect(pci);
> >  	if (ret)
> > -		goto err_free_epc_mem;
> > +		goto err_free_epc_mem_intx;
> >
> >  	if (ep->ops->get_features) {
> >  		epc_features =3D ep->ops->get_features(ep);
> > @@ -808,6 +857,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  err_remove_edma:
> >  	dw_pcie_edma_remove(pci);
> >
> > +err_free_epc_mem_intx:
> > +	if (ep->intx_by_atu)
> > +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> > +				      epc->mem->window.page_size);
> > +
> >  err_free_epc_mem:
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> >  			      epc->mem->window.page_size);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 53a16b8b6ac2..b4315cf84340 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -465,8 +465,8 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  }
> >
>=20
> >  static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no=
,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +				       int index, int type, u8 code, u8 routing,
> > +				       u64 cpu_addr, u64 pci_addr, u64 size)
>=20
> The implementation gets to be too complicated especially with having
> nine arguments now. Seven args have been not that good either, but at
> the very least it was more-or-less coherent with respect to the Mem/IO
> outbound TLPs generations. Now in addition to that it will be also
> responsible for the MSG TLPs mapping. What we could simplify here is:
>=20
> < either 1. Drop separate routing arg. It can be merged into the type
> argument seeing it's a part of one by specification. Thus we'll have
> only eight arguments left. That will simplify the prototype, but not
> the implementation.
>=20
> < or 2. Split up the outbound mem/IO and MSG windows setups.
> In the later case you'll need only the next data for the MSG TLPs
> mapping: function #, MW index, message code, CPU base address, MW size.
>=20
> < or 3. Convert __dw_pcie_prog_outbound_atu() to accepting a
> dw_pcie_outbound_atu(-ish) structure with all the arguments listed as
> fields: MW index, function #, message type, routing type, message
> code (valid if MSG type specified), CPU base address, PCIe base
> address, MW size.
>=20
> What do you think? @Rob, @Bjorn?

I don't have a strong opinion, but I prefer the 3 above.

> (Please don't forget to define the macros for the routing and message
> code values.)
>=20
> >  {
> >  	u32 retries, val;
> >  	u64 limit_addr;
> > @@ -498,7 +498,7 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pc=
ie *pci, u8 func_no,
> >  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> >  			      upper_32_bits(pci_addr));
> >
> > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > +	val =3D type | routing | PCIE_ATU_FUNC_NUM(func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> > @@ -506,7 +506,14 @@ static int __dw_pcie_prog_outbound_atu(struct dw_p=
cie *pci, u8 func_no,
> >  		val =3D dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENA=
BLE);
>=20
> > +	if (code)
> > +		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2,
> > +				      PCIE_ATU_ENABLE |
> > +				      PCIE_ATU_INHIBIT_PAYLOAD |
> > +				      PCIE_ATU_HEADER_SUB_ENABLE | code);
>=20
> AFAICS the setup above is only specific to the Msg TLPs. If so then it
> would have been more generic to use if(type =3D=3D ?) conditional
> statement here. What do you think?
>=20
> > +	else
> > +		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2,
> > +				      PCIE_ATU_ENABLE);
>=20
> The next modification seems to be looking better in this case:
> + val =3D PCIE_ATU_ENABLE;
> + if (type =3D=3D PCIE_ATU_TYPE_MSG)
> + 	val |=3D PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | code;
> +
> + dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, val);

Thank you for the suggestion. It looks better than my patch.
So, I'll modify it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> > @@ -528,16 +535,16 @@ static int __dw_pcie_prog_outbound_atu(struct dw_=
pcie *pci, u8 func_no,
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > +	return __dw_pcie_prog_outbound_atu(pci, 0, index, type, 0, 0,
> >  					   cpu_addr, pci_addr, size);
> >  }
> >
> >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr,
> > -				 u64 size)
> > +				 int type, u8 code, u8 routing, u64 cpu_addr,
> > +				 u64 pci_addr, u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type, code,
> > +					   routing, cpu_addr, pci_addr, size);
> >  }
> >
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index,=
 u32 reg)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 79713ce075cc..1a6e7e9489ee 100644
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
> > @@ -352,7 +358,10 @@ struct dw_pcie_ep {
> >  	unsigned long		*ob_window_map;
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> > +	void __iomem		*intx_mem;
> > +	phys_addr_t		intx_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > +	bool			intx_by_atu;
> >  };
> >
> >  struct dw_pcie_ops {
> > @@ -419,7 +428,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
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
