Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C62721BE0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjFECQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjFECQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 22:16:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D9B1;
        Sun,  4 Jun 2023 19:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF0Ymcghlwr4okneEpV8ckmJorlom+ZANN0eJYw0IJvz6r/J2UgBx36fBDUbai4JVrkenFbxNpYDSNDwZZk6/D11C6YfQsV73WnwSyVskrVKJ5lsEBaLSt5fTm0LwbO8iHcBD5T0fMaVqZIv/6mpZAm2HMYoPodTIR8MuNIhJT2B+HMs02wn6DQlikazAnpoFpVBH/F32lgFkrJ9966MeychZroP9pMjr0QEgLN3CTnvuZI4gsMVMrcP0hMbwUS1JdwU2cV8XMkso0o+RehSdSwkHc+dzD/DnlynOkuv/SrU5mo6yrtUW3wQhlYOrkGlO0kLlIhufsqkWE1E8HzDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vprntX3EmtYVNx1y1bqmBHGFCmNysgthT6xMDE+XpTE=;
 b=CyNbanL2S4ZoBOnIRMDyluDfYBoUEdWLvhiWYNL2xvNpsjO3UMt6kBh4mx9KZhCg20QycdgeCI4Wwp3loD+V+MZPUaOlFCuJZ/zk2YN1Zx9Czqr5cmQFSYfKgbk3GYlGrzy62da0LR6vmX/6RlfrhZH9XnsxPmWuOiL9SBxlqM56u0LJZYOd7sqbDqthneKYMkFxCjVUe4wGb0wKl4LzUTigPi70Nz3x7xN9/BdGslbu9kz6Ae6sRavIn5la1q82gjKpko6Pv2whm9OY96VPUcbTN7/fx8RdHS9htfzjXNZyl7i9SURKY6EX2uWn7prDDbTFe5kqc0JB0qYOi07n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vprntX3EmtYVNx1y1bqmBHGFCmNysgthT6xMDE+XpTE=;
 b=WYItfNVzg0TQXlgVLUiPRsVtsxC1i2WTNvnl417HsMXn+2S6nVHUih/b0AQTnQ9Q05t95pp/ePWAvcyeHcjzXtUh0nkdf8JTO91EXRFvYgjmZuskNBxAuuKxjdhlXoVOwmbsGhLmrhbXJ6amNB5KdUg8mEaiT5BxqcmZDQqrGEI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11345.jpnprd01.prod.outlook.com
 (2603:1096:400:3d6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 02:16:33 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 02:16:33 +0000
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
        Bjorn Helgaas <helgaas@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: RE: [PATCH v16 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Thread-Topic: [PATCH v16 04/22] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Thread-Index: AQHZgwfRvGdp4McnNU28yNCJZUWM/a97cNiAgAAu2nA=
Date:   Mon, 5 Jun 2023 02:16:33 +0000
Message-ID: <TYBPR01MB53417DB8DD4B2F4583E29BA5D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-5-yoshihiro.shimoda.uh@renesas.com>
 <20230604232239.luomflcdbwbgrzqc@mobilestation>
In-Reply-To: <20230604232239.luomflcdbwbgrzqc@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11345:EE_
x-ms-office365-filtering-correlation-id: e0804dbe-c82a-4627-07a8-08db656ae1c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /oHVydEj4kdE8rP/Rxp1rNW6Pi1WTOPzZfYUohIY54IKDLKybVQi6fyxltWbC1KBunZ3Jx0nXH3OIunsKH61OFPt4E494bpzfkTN/tidPB8wQMZK/bTgMvpcXp7csDwTpktFjrDgge4RB532UW0ddqkaE0tefIedH5f9QEWXgBa24Pzln+F8Ajl9J9MbSawDCN9XEl1qrmSI6ACN74RXmEytU+uyNtGTLniVQRbZSxJOGAIbngvy9H/5AW8ZfgUDcrXZO1jSWu0EUJB+ijwAa/ZRI1A12s74hroQGtXvgncE6JeyxqcuOFHvPKZpDh0GwVDH318L1qfnidTcXV5l4Z5VBB2wJ53o/o+S2UICQMlwJlB/auzjNS66kt3GJetQPeqDu9LYHRt1ScUMm1B/9KzU9+Ljyw8wdlCqs6CGk0Zof0pC3Jivrt7KtNrtI1zLOr2MQSN/Txjzv4oC7orfnVYU5ISKQixY+usiYRrzb8sj+u/Z8D0xZaMABzNMgJI6vrahzASrsYFPIMX5D55N9tcYGTsGTN0uXKw+CUNmhKvVJmPso1K/vF9ms7Bm9dJmzLojyFw14lo3AB6D0upF6Tn/27boLHB7a6PEtIg2QA/96py+tOemZP/U9clTm6Ez
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(478600001)(71200400001)(122000001)(38100700002)(6916009)(64756008)(76116006)(66946007)(66446008)(4326008)(66476007)(66556008)(54906003)(55016003)(8936002)(8676002)(86362001)(5660300002)(33656002)(52536014)(7416002)(7406005)(38070700005)(2906002)(30864003)(41300700001)(316002)(83380400001)(6506007)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fJJ+Uq83DFezm17sCLjhFyNTItrRiYYdJJRXYHZE2zOJ2vNXaFYZaieOY8ep?=
 =?us-ascii?Q?wxVSLbW7e74TxP9tzjvMasBz1lw6M/5uvH5EzvVJ9m8CFJDjcoBOpiMh7tqt?=
 =?us-ascii?Q?r7qahDOECAsHojA6S+gF/pLUquxbKK3oPDkQVINsaEZC7spVcU911wl9lmmW?=
 =?us-ascii?Q?E0FW5EBuPTb53VhYmomUm649M8y+4EBNCM4q5SuDCH6tr4ZcMw7YtpjmnyjT?=
 =?us-ascii?Q?7m2fmZfonV5pUblO9Qftor1Ag3a6Xc5EsPKDg7WFsjX6wXL2M95IG+3IrFX6?=
 =?us-ascii?Q?kW8Bfku9SMFh/gv3jvMBWIP3wzp0u+3EGrhG4iSO+V3kOyb1AB3zBW2U9Uyo?=
 =?us-ascii?Q?0+BfAgbEdZKC6XHid7fWmIlZxyXdH2cfvmMEZ4rngjpoXU7bl5IE0NA/w18V?=
 =?us-ascii?Q?xFl69tU2SC5Z3qknIM97f6DlIhjU+Qc/0QBxRb4asTWyvQT+ACslyvsj9Kes?=
 =?us-ascii?Q?b9HGNNmrZ5OcYYqIsFsA2CeMQVBIQJBWf7ZEm33swSnJXC4cWcnzr7vVUQ6+?=
 =?us-ascii?Q?sOSJizP7cZRMZaYoF2QHVIf9newzYyVfUdYhZExSTPnAQVIqH8/kQCmrRW2N?=
 =?us-ascii?Q?CzkHdm/sUfuXwTCDWCn8WcnCdAGnSjdNUe+x5TeH3CNQQpJFKhUVv+l15jec?=
 =?us-ascii?Q?y9Qibv4DmD8LmGpci4/zUuToDky5uW/M0omlHsDShcpp6Ous5fhw35Fcw7hV?=
 =?us-ascii?Q?dX7LxOqBQYc9invAvN8zJYVCOnnmyxoqItycSGyRbTDC14BBia1SsrDmmaZX?=
 =?us-ascii?Q?AmUCnp00BBijQBdN51RD4CHb1t3lEjrDn+9EL57k0jKTs5TL5GMU2mVw1y95?=
 =?us-ascii?Q?oexNHAyce8h4YGNYX6vqlqp65G7v8mtD5AGYO2X7tvp6lYlWpXX47m9ZFMf8?=
 =?us-ascii?Q?tbj07wA+OWjHhfClKMBQ8u4eSXJX06DZw40/PmEMtiy6F5JyaX/ktxexPDmZ?=
 =?us-ascii?Q?wX2tbsvj7l3iUIPhU1NnjIeXLGnJyDGF0ZQjOqjUabUrKcfMOt92YKbODpWW?=
 =?us-ascii?Q?AjZVaWf38Am/3JtL13/ia0wgT8V8v6tXyce68zxmrV5Mn7OnKbj78dnipC5d?=
 =?us-ascii?Q?t4N4If4YBXRCPatoemY1mmFK6z4HcuZWjeY9KNWZdkA8omLg9eEW2/MCeXks?=
 =?us-ascii?Q?gEKbNuRERcJwsY0JlRfLH7fRVCW/SEuziGWHnfQRTUk+B8kvRRi8irJ8N+ra?=
 =?us-ascii?Q?ivbNlYOrR1sXc6jCx0Rrv6BjlzAU9zScfTYopusoKx65k/UVugy7JvXMq4YU?=
 =?us-ascii?Q?G4P8EvcW18Hvht83nQ1hEBa1zgYra2w9yYuhm3ge7kuM42uNG1V/qdRn90nR?=
 =?us-ascii?Q?jCmWdjoppAVvgnFrk+K9iu46V7ber9BbDHwlQboFujU9NVnkH2lBh2zM4FOg?=
 =?us-ascii?Q?SMKykOo21aM8cz3A8wa45xmW9ZlNQeHQmX9Tc/wqEY0SLvA5cT9RjGWmaxrh?=
 =?us-ascii?Q?2dQ4DDlcrDw/NNGqg7LxT++XZ6AeyC0ItPkgIvDfgpAlAABJA/or90BKB/tb?=
 =?us-ascii?Q?+Xa3Jx8yUbZfX2opnflo85/yZdX8uPfnLgaOTlqwYQe4gEpFKKGVdjepCjud?=
 =?us-ascii?Q?zSCPcEeQIfUwEN6R4L4zV6J4eEoBCdk1k6TVEnKowy+nVIYmTNqlMXAur1mq?=
 =?us-ascii?Q?C0Tm9YbwcKraomkyv4JZx0a0u3QQlrMMPzJ/iHAne51U4AioLovQEm4D/4PX?=
 =?us-ascii?Q?xpBNKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0804dbe-c82a-4627-07a8-08db656ae1c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 02:16:33.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsV0ARvEpyH4+2+dML6ydDzNZQJdyNr+s+4B8xpkF5ENWGi15U1MmFsHvb0bFAyPVGf3wbBZUGq+ZD/gITGCN38CeG2J0ryeCvsglDB9pahGT4R1cXoIP7R6eEtFYxBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 8:23 AM
>=20
> On Wed, May 10, 2023 at 03:22:16PM +0900, Yoshihiro Shimoda wrote:
> > Using "INTx" instead of "legacy" is more specific. So, rename
> > PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> >
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> > Cc: Tom Joseph <tjoseph@cadence.com>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> > Cc: Mingkai Hu <mingkai.hu@nxp.com>
> > Cc: Roy Zang <roy.zang@nxp.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Kishon Vijay Abraham I <kishon@kernel.org>
>=20
> I doubt that that long Cc-tags list of much use in this case
> especially seeing the change is mainly relevant to the PCIe
> subsystem core. In order to still let git send-email to create a
> pre-defined Cc-list I normally move all the Cc'es to be below the
> "---" line. Thus the specified developers will be added by the
> send-email tool to the list of recipients but git am will ignore
> everything below "---" so the mainline commit won't have these
> Cc-tags.

Thank you for your suggestion. I didn't know such a method.
I'll do that on v17.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
> >  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
> >  drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
> >  drivers/pci/controller/dwc/pci-keystone.c         |  2 +-
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c        |  2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 +-
> >  drivers/pci/controller/pcie-rcar-ep.c             |  2 +-
> >  drivers/pci/controller/pcie-rockchip-ep.c         |  2 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c     | 10 +++++-----
> >  include/linux/pci-epc.h                           |  4 ++--
> >  15 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers=
/pci/controller/cadence/pcie-cadence-ep.c
> > index b8b655d4047e..2af8eb4e6d91 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -539,7 +539,7 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *e=
pc, u8 fn, u8 vfn,
> >  	struct device *dev =3D pcie->dev;
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		if (vfn > 0) {
> >  			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
> >  			return -EINVAL;
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/cont=
roller/dwc/pci-dra7xx.c
> > index 4ae807e7cf79..b42fb1cc8bc8 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -410,7 +410,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep =
*ep, u8 func_no,
> >  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		dra7xx_pcie_raise_legacy_irq(dra7xx);
> >  		break;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
> > index 52906f999f2b..1f39e733ce19 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1062,7 +1062,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_=
ep *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/co=
ntroller/dwc/pci-keystone.c
> > index 78818853af9e..3806f5530937 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -908,7 +908,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_e=
p *ep, u8 func_no,
> >  	struct keystone_pcie *ks_pcie =3D to_keystone_pcie(pci);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
> >  		break;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/p=
ci/controller/dwc/pci-layerscape-ep.c
> > index c640db60edc6..ab3306e206d8 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -65,7 +65,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep=
, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/co=
ntroller/dwc/pcie-artpec6.c
> > index 98102079e26d..128cb1118e3a 100644
> > --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> > +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> > @@ -357,7 +357,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep=
 *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
> >  		return -EINVAL;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/driver=
s/pci/controller/dwc/pcie-designware-plat.c
> > index 1fcfb840f238..fc3b02949218 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> > @@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_e=
p *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/co=
ntroller/dwc/pcie-keembay.c
> > index f90f36bac018..ceb940b327cb 100644
> > --- a/drivers/pci/controller/dwc/pcie-keembay.c
> > +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> > @@ -290,7 +290,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie=
_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		/* Legacy interrupts are not supported in Keem Bay */
> >  		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> >  		return -EINVAL;
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/co=
ntroller/dwc/pcie-qcom-ep.c
> > index 19b32839ea26..077afce48d0b 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -658,7 +658,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep=
 *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/c=
ontroller/dwc/pcie-tegra194.c
> > index 09825b4a075e..4adba379b83d 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1980,7 +1980,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie=
_ep *ep, u8 func_no,
> >  	struct tegra_pcie_dw *pcie =3D to_tegra_pcie(pci);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
> >
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pc=
i/controller/dwc/pcie-uniphier-ep.c
> > index 4d0a587c0ba5..7787eedf87f4 100644
> > --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> > @@ -262,7 +262,7 @@ static int uniphier_pcie_ep_raise_irq(struct dw_pci=
e_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return uniphier_pcie_ep_raise_legacy_irq(ep);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
> > diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/contro=
ller/pcie-rcar-ep.c
> > index f9682df1da61..fbdf3d85301c 100644
> > --- a/drivers/pci/controller/pcie-rcar-ep.c
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
> > @@ -408,7 +408,7 @@ static int rcar_pcie_ep_raise_irq(struct pci_epc *e=
pc, u8 fn, u8 vfn,
> >  	struct rcar_pcie_endpoint *ep =3D epc_get_drvdata(epc);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return rcar_pcie_ep_assert_intx(ep, fn, 0);
> >
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/co=
ntroller/pcie-rockchip-ep.c
> > index d1a200b93b2b..ef9d1f6c382a 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -477,7 +477,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_ep=
c *epc, u8 fn, u8 vfn,
> >  	struct rockchip_pcie_ep *ep =3D epc_get_drvdata(epc);
> >
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 623b08caa998..6beb3f2b0afb 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -19,11 +19,11 @@
> >  #include <linux/pci-epf.h>
> >  #include <linux/pci_regs.h>
> >
> > -#define IRQ_TYPE_LEGACY			0
> > +#define IRQ_TYPE_INTX			0
> >  #define IRQ_TYPE_MSI			1
> >  #define IRQ_TYPE_MSIX			2
> >
> > -#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
> > +#define COMMAND_RAISE_INTX_IRQ		BIT(0)
> >  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
> >  #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
> >  #define COMMAND_READ			BIT(3)
> > @@ -600,9 +600,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_t=
est *epf_test,
> >  	WRITE_ONCE(reg->status, status);
> >
> >  	switch (reg->irq_type) {
> > -	case IRQ_TYPE_LEGACY:
> > +	case IRQ_TYPE_INTX:
> >  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> > -				  PCI_EPC_IRQ_LEGACY, 0);
> > +				  PCI_EPC_IRQ_INTX, 0);
> >  		break;
> >  	case IRQ_TYPE_MSI:
> >  		count =3D pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> > @@ -659,7 +659,7 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
> >  	}
> >
> >  	switch (command) {
> > -	case COMMAND_RAISE_LEGACY_IRQ:
> > +	case COMMAND_RAISE_INTX_IRQ:
> >  	case COMMAND_RAISE_MSI_IRQ:
> >  	case COMMAND_RAISE_MSIX_IRQ:
> >  		pci_epf_test_raise_irq(epf_test, reg);
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 301bb0e53707..c2572a93d73d 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -21,7 +21,7 @@ enum pci_epc_interface_type {
> >
> >  enum pci_epc_irq_type {
> >  	PCI_EPC_IRQ_UNKNOWN,
> > -	PCI_EPC_IRQ_LEGACY,
> > +	PCI_EPC_IRQ_INTX,
> >  	PCI_EPC_IRQ_MSI,
> >  	PCI_EPC_IRQ_MSIX,
> >  };
> > @@ -54,7 +54,7 @@ pci_epc_interface_string(enum pci_epc_interface_type =
type)
> >   *	     MSI-X capability register
> >   * @get_msix: ops to get the number of MSI-X interrupts allocated by t=
he RC
> >   *	     from the MSI-X capability register
> > - * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
> > + * @raise_irq: ops to raise an INTx, MSI or MSI-X interrupt
> >   * @map_msi_irq: ops to map physical address to MSI address and return=
 MSI data
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> > --
> > 2.25.1
> >
