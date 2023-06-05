Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD55722039
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjFEHy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFEHyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 03:54:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC31E53;
        Mon,  5 Jun 2023 00:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLloz5K5YEW0mNhNxrtuDUb4O/R3lm9N6qsjmClJUpFQWJZ/8HyYDYVeI6VosBmSsPQBaVrAFcnxkMrrSO8lGm/xtHMERGiIidC9qv2xr9lF81FTk2HF3mLqz1rlRwX5mZU70L7BhWvj2i1xU2LjwU59FwNUmfrW6vAkdcrbLBtRprlaftc+vJeyNQWUIUkD9JoIypHEn66qJAERNBV1024CFmA+GgCjabtYPKyTbelPyGK8zRJrL3ktAhNaJTwuz9aVg2yULiVlLO9Kc3u4rH6LAt5zLS1vz8G+y1qa4a8UTw0oi4vnllbA0pyq8jSN/X0kYWsb7ng1wYMxw4b2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKA2xIlqyN6G86oAMHGO0T0pRuvafUg3+hCN5KXFsU4=;
 b=RdrLS2ZgzZC9W+0OoZHixlDdTCQTp0Ldp427NZ9cHLAont6BInWWaFU8d2gq/uI9leZiDO/PyHIqKYxSfSWMHtYu+XILxX8XFbuKOYW0oFZHngPKmEK1ggu3BTtHsmZxkN3wxcFErRiu3Cc0aITgNtDwzPQZJ/d7pUkPt9iuBd0lvnoiYRPwJX7jONoAMSHUP8qFO4YR6+625j5PiDBPz/RKoiiDfBzp1lrT9ARbh/C8voSm1ar9v/voWDzWv9xC9B5fDKMEfGeEBVYcF95vB/NeszWg5qk5w4IiDOMi5QJZ7NgzwvOk/2LCXxG1fPMTqHhW6eT1urR+rY0kDpt3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKA2xIlqyN6G86oAMHGO0T0pRuvafUg3+hCN5KXFsU4=;
 b=JnKDx5Vqe7cTtJ3PAvmBAuimtFU4pRpP1G+nrNov8qaTdPe65awQP+4KXimYa+b7P2A1LvTaTdPihdfdoRjAuqcfxqxpO+4ncXOf2vDSkreiLL65VlCbtxeZBjE19MlgWzaacl4hZM5BinY1XWl4KTfsAJeKgLi0+Mj+UamxOeo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6123.jpnprd01.prod.outlook.com
 (2603:1096:402:36::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 07:53:49 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 07:53:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Thread-Topic: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Thread-Index: AQHZgwfRbUDY2yQ+f0ON87x4/4GBmq97bKgAgAAysCCAAFgngIAAB+XQ
Date:   Mon, 5 Jun 2023 07:53:49 +0000
Message-ID: <TYBPR01MB53416C36A7980908E3B0A13ED84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
 <20230604230740.criuymkykrq54oln@mobilestation>
 <TYBPR01MB5341BD012D7BE2390CBA2075D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230605072435.2hpb73qllzhez3uv@mobilestation>
In-Reply-To: <20230605072435.2hpb73qllzhez3uv@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6123:EE_
x-ms-office365-filtering-correlation-id: 92266668-e37e-4cf9-6195-08db6599ffc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fA4tyGTlqX03B+iI0Oo3FuaB9mPd5WpqfupKkgdTfG9awPK3su71sy0ula0M5lEWoLwhi8EJzNQu9zx4nMFEtOH9UAs6188IU/sCC5y0uERIRmGSopMwVaoQbqgcRTNvTEH/ijv0X6JXu/gOQmNNo6bsYgec+2m20Hq6rsqilBBMF1f1sAbL3CZnV+KdvWJXaVqx3OHPbVZtGE2kLQM6utZToLyo/hWNv4hytoeK638CrQzW7gMupNeaGPuLi5gfjXjXvOOATq6B+Vm1MA9WSeu4BrLHkk9aV6SuTR6EbXLY3YYDOcTXW9XN2h3ILaW+Vh+kAb48n7zkqC+cycQbUH3I9YmZLefioYIb0XwogR6vLqRiNeoSP6LMQWgtiu8k1V2C/uBrWSCNLR5xwUbQN/Ta3SZl9G+LBGrPCpbOXdc5j5FzRKzykGEi6VfO/s9/JfmB8Zgf/NsCHdvSAWF5VjYbKTGdr0aeEz46txZHacm7jKLDWh/lzPouxKC6KvnohdYqa8WfHWUmfF3vcTgDCdZsI+kITlAVOEfTtxj1vIWaJjc/cy+qe40FVfpHFisNLviABWVfpstmOdXXvcSzlW0Yt6jgscHaSRLXnskCIC+vuZvB5HDJteYytDYSBRs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(9686003)(26005)(6506007)(38100700002)(83380400001)(41300700001)(7696005)(186003)(71200400001)(478600001)(54906003)(4326008)(122000001)(66446008)(66476007)(66556008)(64756008)(6916009)(55016003)(76116006)(316002)(66946007)(7416002)(8936002)(8676002)(52536014)(5660300002)(2906002)(86362001)(33656002)(15650500001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iH/RM8neoPuY1zD1GA23WBkubAtYrxVLt940jbK7WiceYw3CRBR1wu3LbWCs?=
 =?us-ascii?Q?00+JY7P02aSCDv5/lpNskQXoGyMpBSyVR5BDhNU3cj7b7sP9H2IgN/OTLHhN?=
 =?us-ascii?Q?UVAyZjnPJnru8w5tCDz8wwBLBx5j4UD7OkhLP7DE+lxjfmqVFzltD5VFtyQ9?=
 =?us-ascii?Q?NIDOptyYJ9IPmJhF8+zMB69JBuLyAM+7MGQ/0ZUqZeVGTrsyoyTbWSgmtHGR?=
 =?us-ascii?Q?bOMwRIBb7lAR7LS9teztRhYvD5PkJbtDnZXPJLfHgU1QhWtaLslW1hmNVSRL?=
 =?us-ascii?Q?eSVk+FJSSdoDpBtZ7T2PBEXZ44MFodR+f0VlVpFIcFqIfYc5JR3ekgPXMkGH?=
 =?us-ascii?Q?zY90EjWu9ItL8de3PGvdcQvMr4FugYEmid5FQB8J8r3AhOAeb6aCnS5GsEfb?=
 =?us-ascii?Q?JnA4wlilP7/yDeCmTPg54QXfrqUMzqiK6Tm3mGyZxcM2eZVJhq8mlo7t/EY5?=
 =?us-ascii?Q?OnJyN7ZLh2MP15H+l1nvdunqN/4vAqfb61K5pegUuIuw7iGsNrONpGMc4JFa?=
 =?us-ascii?Q?PIoqVK7LskTgICUz2keuUGutimVBAiS/3GXxCGRsCNJnSciaG6mDGD+o+LIj?=
 =?us-ascii?Q?fMH3mRvf645U39dDrjm3O/UX05y56LlOGXIwG/DWfsUx2L9OA+n6807RSk+m?=
 =?us-ascii?Q?M/kORrUBnD1LlgA9CWuZj6K+rYjGjmDSQqGX17Ab2BNtWLNb6UubjwG7Tq6V?=
 =?us-ascii?Q?hPp7TEdcDeTKoZqkMBN8W9vyOKELSLk1hydk953NFwiKrrJrXCRe5Ez/KwTn?=
 =?us-ascii?Q?MvLDaUWPrODW25JLhUe7pEDi2AMF2/90+Bo+rb/rJg2ek3FrU6FuIPdUCGs4?=
 =?us-ascii?Q?JuK+LmSped0OlLb3nNOq+fZNUi97Ghxz4//+Kg3c/7CQpVTKpq6OkhhACcU2?=
 =?us-ascii?Q?+Yn2Mt9sPCsUPU719WUYmmUreVGOWqi5B+bCj6bUzRE6VDlRhqcDmcIpcvDj?=
 =?us-ascii?Q?wl5iCm6UFUmMiQy9Dq1PRxYBjJO5JxMfz2rZm7HiKwLRQLryQBpz2CzEbNao?=
 =?us-ascii?Q?qSa3wh8Et/uahKg7uCzNRi15ITZWY3zw5b7Pt3OrWXdCymAXAT9Vnithv4Oj?=
 =?us-ascii?Q?NPYBoGjOKpb2UGevSnnC9sGwZjiuiqlIdE6yPVrDTZosUZcgekkqQLXaIlU3?=
 =?us-ascii?Q?e2P35+OuntkqXF8qNNlq7zQFEYV8HqPsRs816V7/zd5OS9k7uf/VrHISHD8t?=
 =?us-ascii?Q?Q6Q1W3scbLPB7EhEewMPjoSVT4ZvARIJSnQKSjNE6KcHu09xNC1PRa/zCOOI?=
 =?us-ascii?Q?we6vKkuqJy6MdFfhLCsj+OlbMoVfVOB+yrYx510RNGQyXwz42wvU4bljb1te?=
 =?us-ascii?Q?q82eRq4SvgC/+IXmlSWeBw+ihoF+thxiMH2tUFEyxshScDoEJLIfa8Mmpyoe?=
 =?us-ascii?Q?v5z0vQTXaq7a94qNrB0yXV0BLxAr7c7RP0Gy6CPnDux5PdaI3Io7H+U7W/7J?=
 =?us-ascii?Q?IxEDv3biNCYKnvyDrqe1qWhXDC162lh52Mob9hwf7iIDkGomtxUrkfBbUwFC?=
 =?us-ascii?Q?tstGOjSKfe9VHeV2nKj2EI1RCisqArWbtDdUFBzPekiBAQGsXAzIStb67oR0?=
 =?us-ascii?Q?jk4J7BSK3eH250eGxqit8FkX9cMm4p6E3P72+hkybbUrXjOHJ2d2PGWaa1xe?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92266668-e37e-4cf9-6195-08db6599ffc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 07:53:49.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnHr9eT1jSTPeMA3vDCqF9d7QclWdMhVTXSPVHGZvtspZ7KLgfW+ZcLp8eFKZZQukrAOMk6qhkzm2be4vy6CBAQBvXqzOUOxQVLlSLpgG230Cbek3jLCjQPfB3L0pPxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6123
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

> From: Serge Semin, Sent: Monday, June 5, 2023 4:25 PM
>=20
> On Mon, Jun 05, 2023 at 02:10:14AM +0000, Yoshihiro Shimoda wrote:
> > Hello Serge,
> >
> > > From: Serge Semin, Sent: Monday, June 5, 2023 8:08 AM
> > >
> > > On Wed, May 10, 2023 at 03:22:15PM +0900, Yoshihiro Shimoda wrote:
> > > > Add "Message Routing" and "INTx Mechanism Messages" macros to send
> > > > a message by a PCIe driver.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  drivers/pci/pci.h | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 2475098f6518..67badc40e90b 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -11,6 +11,24 @@
> > > >
> > > >  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> > > >
> > >
> > > > +/* Message Routing */
> > >
> > > Call it "Implicit Message Routing (r[2:0])" as per the specification.
> >
> > I got it.
> >
> > > > +#define PCI_MSG_ROUTING_RC	0
> > > > +#define PCI_MSG_ROUTING_ADDR	1
> > > > +#define PCI_MSG_ROUTING_ID	2
> > > > +#define PCI_MSG_ROUTING_BC	3
> > > > +#define PCI_MSG_ROUTING_LOCAL	4
> > > > +#define PCI_MSG_ROUTING_GATHER	5
> > >
> > > IMO prefix like this PCI_MSG_TYPE_R_{RC,ADDR,ID,BC,...} would be a bi=
t
> > > better since it would indicate that this routing flags are a sub-fiel=
d of
> > > the Message Type field. Bjorn?
> >
> > I got it. I'll rename them.
> >
> > > > +
> > > > +/* INTx Mechanism Messages */
> > > > +#define PCI_CODE_ASSERT_INTA	0x20
> > > > +#define PCI_CODE_ASSERT_INTB	0x21
> > > > +#define PCI_CODE_ASSERT_INTC	0x22
> > > > +#define PCI_CODE_ASSERT_INTD	0x23
> > > > +#define PCI_CODE_DEASSERT_INTA	0x24
> > > > +#define PCI_CODE_DEASSERT_INTB	0x25
> > > > +#define PCI_CODE_DEASSERT_INTC	0x26
> > > > +#define PCI_CODE_DEASSERT_INTD	0x27
> > >
> > > IMO Prefix PCI_MSG_CODE_... would be a bit more descriptive since per
> > > the specification the respective message field is called "Message
> > > Code" and not just "Code". Bjorn?
> >
> > I got it. I'll rename them.
>=20
> I would suggest to wait for Bjorn' opinion about this for sometime
> since the macros will be defined in the PCIe common header file.

I got it. I will also wait for Bjorn's opinion.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> > >
> > > > +
> > > >  extern const unsigned char pcie_link_speed[];
> > > >  extern bool pci_early_dump;
> > > >
> > > > --
> > > > 2.25.1
> > > >
