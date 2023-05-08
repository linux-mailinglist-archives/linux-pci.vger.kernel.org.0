Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF36FAE8F
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjEHLpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjEHLpY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:45:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446D10E4F;
        Mon,  8 May 2023 04:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbpcLanbtz86N3VEedx4JiYAaCGOHAhY1TXjdEARPzzGygt8t8ZVoi0k1GpbBDMwaGreXVTHgHCEpeoER9F5rVDQYrWF4xzhIfPyhnBibXgD+tbzmAi8Js3VOodo5UdQtQmBabzWWzbQw7Sv025Qle6+sTxNdUyibX2kTlpJW23evPECQoE0t4ZGmqi3tqIc2mnigvJ7fNL/EHIrDJNPYaG/1hmhrEMthyq4mNG4TeLBhiA+bvBYNjPHrppIh0AsVq1mhR8MM0XmGMPAJDnU0nMn4uYx31cFUXjguNrQF5Dj3RoSVf61qerOQTbYWxvwfg+JZjsvdKFsUS1+Jw2AcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2tJnpnVymcQq6YH9lArlKI2RtDSByHYdFPEDMpg0Kg=;
 b=EFK6TSnZbhFhYpjyq8VWwSnuoEajcWjD1VDuArHK/0lO/a2+ZhbwHuCwYhQsVXRDH64Q3HG0F3LMS1Z0NeF+A8R5Zex+mMHS39e5cex3n0abczSW4LJQUFWGhUCAW3OqfeBzOG9hGW/6edt5r5W60vcaardV1YE643Y6NSmLYtWqbtLczWcWXoXLEz+gajRYqiJAh7MYNE5FV+2xZSI3ECnDBVwN+yOeYd17ZEw9lPPtTiw7c8w7h9mCwrZKZGySqCxik77SOx1Gwp3k3axR0gh/uOg8w7N5ZUrxrhMrImxneqXXWr1vb2CI8zuXy2JcImIymSmijiRD9liDELFJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2tJnpnVymcQq6YH9lArlKI2RtDSByHYdFPEDMpg0Kg=;
 b=PVrrqy5F4L1t/bF9+ZDGeelm3xFSReeBzIhfmy+oXGA1VD5HMyn4TgkQkj7gW4cTsVc2gh6OZmj/2HSAeZCedDuRwcM9tCLb0E/HGcsiDfK2DnEoBQHUt8XLmkz/tr1/YRpA4/VrIHFKIQGLI0x2cWZimqiRExIGlgOiCUR9FhE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB6088.jpnprd01.prod.outlook.com
 (2603:1096:604:d6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:44:36 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:44:36 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Frank Li <frank.li@nxp.com>, Serge Semin <fancer.lancer@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering
 INTx IRQs from endpoint drivers
Thread-Topic: [EXT] Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering
 INTx IRQs from endpoint drivers
Thread-Index: AQHZd/trWnOtmE0+REezr2H1c/jFhq9F1SmAgAFrFoCACQ99QA==
Date:   Mon, 8 May 2023 11:44:36 +0000
Message-ID: <TYBPR01MB5341EFAC471AEBB9100D6051D8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-9-yoshihiro.shimoda.uh@renesas.com>
 <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
 <AM6PR04MB4838C160989D8BF56C7012B5886F9@AM6PR04MB4838.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4838C160989D8BF56C7012B5886F9@AM6PR04MB4838.eurprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB6088:EE_
x-ms-office365-filtering-correlation-id: fc6fd9f9-89f3-4550-ef65-08db4fb9995a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xz0nh+gVuIHRUCkN03Iufp7QE2LLbA3a1pTPSF7G50pkKkJq/Txw87oVJpNJJcqVY1l1nQYr4AmAqQBlhtY3Hdc52jfxGFFAOi95xpKDW7dF1cFOIPSJ0fpn2KwO0iOVWhOKhA3lR+vh1AugcHgfKFIfWnNfT9YWmbMtEVgZ4c/hAqLTLl57OhgRvyZu0F4yGkZixuOazZnpdL67+rTsIAwuLUv23nPodmyRJEG4BHXZ8ZdFnVDb98o0GTL1ZdMy5pmefELe7hIcgVDVMvDPI2YA6r36+qCcGMAwFCeeLJrgoxTSa7LfqccedRo9PyKbZC7cAIk9gPwh+LtgyQEuaGfcjB8laOa6iF7k6nubDjqpV5ChtIlkxeIjjfbIH2V+JtQ+RKA8Y7HSmBM2AgRNw7wwJC5B9jyQA2vQTA7RxVGq+pUiFbLzv/pNH/X8IfABlKHxzsuZIS+RX99HZcd6oQdR8GzuGwCRBZl0SiXr9+WeQz3F4vz2Re7Dqy4sfBXc9m3cQOmcHEux6hemf32NMdViRJSikaTWf1oMWutt1LYu9xy3e/0OYO6FxGI2XoS9EQsf+rNUv8+3Z6J2WM6+a25YRkkJjJFW12+ubqgE3eyobEq1PmnNwynkOZqqF+fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(83380400001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(7696005)(478600001)(71200400001)(110136005)(186003)(54906003)(55016003)(2906002)(6506007)(5660300002)(52536014)(86362001)(9686003)(7416002)(8676002)(8936002)(33656002)(38100700002)(122000001)(4326008)(38070700005)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GwWbK1JjJMmF/LxqDvOgQQi4y4VxDX4mRqATfSt8q7r8az9aL3ZILYGJYAjw?=
 =?us-ascii?Q?Haf1R1kyYH92yUTYNBeLfjn3duiCcxucbH97DiUB6PKT11JEy/ivErFjQjpJ?=
 =?us-ascii?Q?9vW5X3LMXoRB+CLod6QBEezLwXN7Og1ko4wFmzIKVUWRz75sk4/5RETuCmci?=
 =?us-ascii?Q?bIqLLlhXnS/f8Vo+6ZdSpfuFONEMsHLfIPXocYoqg4sF4dEK2TI4qn2Edlu8?=
 =?us-ascii?Q?BcX07uf2WQ3OArio4C0QE3rDGR/BBjZ5oHjKvOBI5f0KVM2LEDO2L6AvGGIp?=
 =?us-ascii?Q?ePjEv+jCNEsqQ5AjDcpmZ4bfh6E2nCauRDlcdqKiJ5iAoXWDLn3xvlzhFr7l?=
 =?us-ascii?Q?pAoIl7TinYOLvWZr1Mtd3JD+NohqZeg8hqJyhfBO2QGFxY/i3Zh+XD/fkCfc?=
 =?us-ascii?Q?nny360isVqjkLkudOxdqxboybKOiyAUHo85QUMzZB9gmfBLY0zWZIhfeUs1n?=
 =?us-ascii?Q?ovXHMHj8JxqN0qNoxejMa2cNP+maU2+524jLqgOy+l63SRiZDMWHgIEB3nSI?=
 =?us-ascii?Q?8tOsMiedYqKyMGeairDWjt/zg7vkIkKdDnqyRwq2UqUmoKmGiJTfxgOgWV7w?=
 =?us-ascii?Q?mUqUG4Rf8Sll0D4eCCxbyoaCegJbHN4lLbQPobpKqvqeXhht1VK4ZI7bK8HX?=
 =?us-ascii?Q?xV52qZDUezA9/PkpCHs3tiZdi5s4xDNjveVcKv5kks/majviuWRRDywQ05zi?=
 =?us-ascii?Q?lOm+PX2SrmZxMu2YbUxhuYBz0aU36uSLd+ZYRxxcwdaGWhDRraH8Z5JvICQc?=
 =?us-ascii?Q?3Yo15ZIImSJw+rrSMt0y/FoLaWBYPaAR/SXF7QnZ4I+pXiDEaA+Sa0q3ieLo?=
 =?us-ascii?Q?TZNF9XKbXatlI5tZ5TLx50ibH8Yy07FJYgg1R4bgBkBoVhs53HLh+Nj8N4El?=
 =?us-ascii?Q?+gVw/Zj/nizXGtK3FjSyj5C1rPfGZqvO+LnadNHAYSKqpzt0DWQS4dbIerI5?=
 =?us-ascii?Q?KmagDGi2x1vXkU0aDQLoTIbj7335mKV7y63gLNOyxmoFnOrWB5BvAUjqToz8?=
 =?us-ascii?Q?WC6cjT/h0qGKxAgHeqZ+ip09087dh7RN6TZ7PWrMgxLmOg9v77tlC0N++cpz?=
 =?us-ascii?Q?XK/fhp/z6jf/dgf+dM/uN3SRVC+yWXXfceUwmjBScokG+NdJoIS3QLbxS58P?=
 =?us-ascii?Q?oSzwgBWabu5o8dAgfl2iqwjv8Tna6Jbsqcx1g21Ce/SPQM22DSNUsAjgE7hW?=
 =?us-ascii?Q?npSU90TFxfDE3nQ2C5emThgGfa7VlMEXXGD1L6jiktlvHH7IARuWrGFQgWC1?=
 =?us-ascii?Q?4gxxnloH8dof+LBfXlMidGU3tTR2aaw7KpkHY1bVip20TUhk+AQDz63ZHkFE?=
 =?us-ascii?Q?q1ZCVlZf5mnCmwRgDRM+DziHHAc64inc+SVsqXmwJM0E13C9z8sJvIvvBEmt?=
 =?us-ascii?Q?t5fG5ftXmWYRe/4uND9beMDcyKgfaCJh3+Jr4IZJNWzDwdZRiwKmL5y6KTHB?=
 =?us-ascii?Q?6BIKPxahvhco/1VsMpAf4jWHgw+1VqNkRoad+rngxmK1zQBBu5bmh8Funnxq?=
 =?us-ascii?Q?a7EKCy9wh9OE80yQOX8TUKvRByXhvdUrzFr+ChisxbQ2mnHX8rjHMzi9wOQQ?=
 =?us-ascii?Q?0XH6sQbYSGR1IHqDApd0Bxr+ZSVk5SG61N468CE9rNzCfzoYwlHiPvfID/MY?=
 =?us-ascii?Q?enBSTJIOOZjJqS0RF4GTwX2Bj2AIP5i+2scnBLA6fpeQyTSDERQC5SWeczha?=
 =?us-ascii?Q?AsEvjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6fd9f9-89f3-4550-ef65-08db4fb9995a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 11:44:36.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiNZpq/Ze0S+CsRGuIMm4Mdr2d2AQcbO+Z2HnNiE0PYq9pLjNtFCoVw+bqwManFQRwPCGD9B0W+OvC/Bz8ZwLYEbiX/muNfMwZQAKyLlF0MEHxMFJh5Lxg2aBu9L4+Kq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

> From: Frank Li, Sent: Wednesday, May 3, 2023 2:04 AM
>=20
> >
> > On Wed, Apr 26, 2023 at 01:55:44PM +0900, Yoshihiro Shimoda wrote:
> > > Add support for triggering INTx IRQs by using outbound iATU.
> > > Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> > > The message is generated based on the payloadless Msg TLP with type
> > > 0x14, where 0x4 is the routing code implying the Terminate at
> > > Receiver message. The message code is specified as b1000xx for
> > > the INTx assertion and b1001xx for the INTx de-assertion.
> >
> > [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs from
> > endpoint drivers
> >
> > What about shortening the subject out a bit:
> > "PCI: designware-ep: Add INTx IRQs support"
> > ?
> >
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 71 +++++++++++++++++=
--
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
> > >  2 files changed, 69 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 96375b0aba82..b35ed2b06193 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -6,6 +6,7 @@
> > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > >   */
> > >
> > > +#include <linux/delay.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >
> > > @@ -485,14 +486,63 @@ static const struct pci_epc_ops epc_ops =3D {
> > >       .get_features           =3D dw_pcie_ep_get_features,
> > >  };
> > >
> > > +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8
> > code,
> > > +                            u8 routing)
> > > +{
> > > +     struct dw_pcie_outbound_atu atu =3D { 0 };
> > > +     struct pci_epc *epc =3D ep->epc;
> > > +     int ret;
> > > +
> > > +     atu.func_no =3D func_no;
> > > +     atu.code =3D code;
> > > +     atu.routing =3D routing;
> > > +     atu.type =3D PCIE_ATU_TYPE_MSG;
> > > +     atu.cpu_addr =3D ep->intx_mem_phys;
> > > +     atu.size =3D epc->mem->window.page_size;
> > > +
> > > +     ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     writel(0, ep->intx_mem);
> > > +
> > > +     dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > > +static int __dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8
> > func_no,
> > > +                                      int intx)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA +
> > intx,
> > > +                               PCI_MSG_ROUTING_LOCAL);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * The documents of PCIe and the controller don't mention how l=
ong
> > > +      * the INTx should be asserted. If 10 usec, sometimes it failed=
.
> > > +      * So, asserted for 50 usec.
> > > +      */
> > > +     usleep_range(50, 100);
>=20
> It is good method to implement legacy irq support. But there is problem w=
hich need be considered.
>=20
> According to PCI spec, section 6.2.1 PCI-compatible INTx Emulation
>=20
> PCI Express emulates the PCI interrupt mechanism including the Interrupt =
Pin and Interrupt Line registers of the PCI
> Configuration Space for PCI device Functions. PCI Express non-Switch devi=
ces may optionally support these registers for
> backwards compatibility. Switch devices are required to support them. Act=
ual interrupt signaling uses in-band Messages
> rather than being signaled using physical pins.
> Two types of Messages are defined, Assert_INTx and Deassert_INTx, for emu=
lation of PCI INTx signaling, where x is A, B,
> C, and D for respective PCI interrupt signals. These Messages are used to=
 provide "virtual wires" for signaling interrupts
> across a Link. Switches collect these virtual wires and present a combine=
d set at the Switch's Upstream Port. Ultimately,
> the virtual wires are routed to the Root Complex which maps the virtual w=
ires to system interrupt resources. Devices
> must use assert/deassert Messages in pairs to emulate PCI interrupt **lev=
el-triggered** signaling. Actual mapping of PCI
> Express INTx emulation to system interrupts is implementation specific as=
 is mapping of physical interrupt signals in
> conventional PCI.
>=20
> It should be level triggered.   When call __dw_pcie_ep_raise_intx_irq, sh=
ould be just assert INTx, then after PCI
> Host driver's  irq handler to clear irq,  EP side can desert INTx.
>=20
> So it should be two functions, one function raise INTx,  and another one =
desert INTx.   But I don't know
> How to avoid host side possible flood irq happen if EP can't desert INTx =
in time.

I also don't know how to design dessert INTx...

To Kishon,

Do you have any comments about supporting deassert INTx on PCIe EP framewor=
k?
I checked the Documentation/PCI/endpoint/pci-endpoint.rst, but it doesn't m=
ention
about it. Should I modify the PCIe EP framework while I submit this patch s=
eries?
If possible, after this patch series have been merged into upstream, I'll t=
ry
to consider this problem somehow.

Best regards,
Yoshihiro Shimoda

> > > +
> > > +     return dw_pcie_ep_send_msg(ep, func_no,
> > PCI_CODE_DEASSERT_INTA + intx,
> > > +                                PCI_MSG_ROUTING_LOCAL);
> > > +}
> >
> > Why do you need the underscored version of the method? I don't see it
> > being utilized anywhere but in the dw_pcie_ep_raise_intx_irq()
> > function. Thus its body can be completely moved to
> > dw_pcie_ep_raise_intx_irq().
> >
> > -Serge(y)
> >
> > > +
> > >  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
> > >  {
> > >       struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > >       struct device *dev =3D pci->dev;
> > >
> > > -     dev_err(dev, "EP cannot trigger INTx IRQs\n");
> > > +     if (!ep->intx_mem) {
> > > +             dev_err(dev, "INTx not supported\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > >
> > > -     return -EINVAL;
> > > +     return __dw_pcie_ep_raise_intx_irq(ep, func_no, 0);
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
> > >
> > > @@ -623,6 +673,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > >
> > >       dw_pcie_edma_remove(pci);
> > >
> > > +     if (ep->intx_mem)
> > > +             pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep-
> > >intx_mem,
> > > +                                   epc->mem->window.page_size);
> > > +
> > >       pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > >                             epc->mem->window.page_size);
> > >
> > > @@ -794,9 +848,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >               goto err_exit_epc_mem;
> > >       }
> > >
> > > +     ep->intx_mem =3D pci_epc_mem_alloc_addr(epc, &ep-
> > >intx_mem_phys,
> > > +                                           epc->mem->window.page_siz=
e);
> > > +     if (!ep->intx_mem)
> > > +             dev_warn(dev, "Failed to reserve memory for INTx\n");
> > > +
> > >       ret =3D dw_pcie_edma_detect(pci);
> > >       if (ret)
> > > -             goto err_free_epc_mem;
> > > +             goto err_free_epc_mem_intx;
> > >
> > >       if (ep->ops->get_features) {
> > >               epc_features =3D ep->ops->get_features(ep);
> > > @@ -813,7 +872,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  err_remove_edma:
> > >       dw_pcie_edma_remove(pci);
> > >
> > > -err_free_epc_mem:
> > > +err_free_epc_mem_intx:
> > > +     if (ep->intx_mem)
> > > +             pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep-
> > >intx_mem,
> > > +                                   epc->mem->window.page_size);
> > > +
> > >       pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > >                             epc->mem->window.page_size);
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 954d504890a1..8c08159ea08e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -369,6 +369,8 @@ struct dw_pcie_ep {
> > >       unsigned long           *ob_window_map;
> > >       void __iomem            *msi_mem;
> > >       phys_addr_t             msi_mem_phys;
> > > +     void __iomem            *intx_mem;
> > > +     phys_addr_t             intx_mem_phys;
> > >       struct pci_epf_bar      *epf_bar[PCI_STD_NUM_BARS];
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
