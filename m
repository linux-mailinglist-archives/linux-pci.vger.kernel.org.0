Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C324693C30
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 03:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMCZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 21:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMCZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 21:25:55 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD34CA0D;
        Sun, 12 Feb 2023 18:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUpOsMaq51sipXXNB/+BOM31BouHZAnDGdPJay7hlpFKu3h7vCI/2P5eyHMltT2HnloTsLleEDJUWZ+GHs8w3RthTpnsnY6tS6PzH9YBwgwf7f99yhvwnY1/qLDBkhrG9e5mB7JqU3rvaDDZjx4/H5HVGiy5eYWIW0fVeaHCPQzO8FEoE/CODQ0de/K7P6sve1S6/iN60EgFVIHj+lj2JdA23QtmvNUsJZ3HcylzVL7eHWfm9T+sa+3zKB2uVGVMlNCQG2PYiP+p5Y8T51b+LcpbMWBowwtGBi6XpIEPpnrYdSzxrG8gpCHDcDUFHNjS1h73L7glRwZUQ1MzmBm5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGkEvRBZveosKotvsgfr80qVuLB0wKzhxItXPMt7dn8=;
 b=nuPG7/Im03I3aFDhj72qzuD3rYPYVVCOgpPvtgDRwWlKVACoyAqvoBKgrBdQqKnBmqs4gGQ2LAvD7BwW5qd+UxCgDnlymYZYeYycGeRLUg4w6yWOqbiH7Yd3+DBLEr+k7TLCHOdhkw8CQfXAM5aSzt7+Gv56HjOEairf/bghlWZGWzAMhI1V9Lp5WFE3nKRrPmEDmk8em9se/8X2EbrFVgewJyW4rCnoXXuwWI6cYVbozu8J3EM/5XZldbXPP/iT2NmjqMMIxRQZFFlTydz+Ac0xlBMPEhBAR9tYrcTO167XUWbecJeKn/0rhSiNYPIYxbhqMBDmOiTESnUIj8EQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGkEvRBZveosKotvsgfr80qVuLB0wKzhxItXPMt7dn8=;
 b=cZkAihGN0584DJTiEr0C4O56FOZ0BkuHbUNuOlGeKBQE3O6MaveTXuJeUmENySUJ3VsRkqt6GZHLaS2a4AILYIWLiExqBI66uDQqmC+YELvR7NaBzRRFHivf5GPoksySwXlZ4bkLUeRGvPtKvcEKtl0JFUojA7oh7jmtxr4iies=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9450.jpnprd01.prod.outlook.com
 (2603:1096:400:198::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 02:25:51 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:25:51 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: RE: [PATCH v9 6/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH v9 6/8] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHZPVZ6JTQdmTm1Z0amVXPFA/uYdK7IxCMAgANl/TA=
Date:   Mon, 13 Feb 2023 02:25:51 +0000
Message-ID: <TYBPR01MB5341360E53019EF247CCDBDFD8DD9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230210134917.2909314-7-yoshihiro.shimoda.uh@renesas.com>
 <20230210223124.GA2706221@bhelgaas>
In-Reply-To: <20230210223124.GA2706221@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9450:EE_
x-ms-office365-filtering-correlation-id: 8c1ca86a-efc0-48c1-52ab-08db0d69a015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WA7ojlK1If35DAL8yaRYKDlxJTSM0PSHB6QlIy1q1lXWnrZugwXP19R2iKhkY8vAWGlDtsV7Eicza2OtcD3py2bgoe4xnRl5rdOGSkIkNw6jqGXkLy1bL9Z9KcZQh0oEbdsT3Rc/wc8WjmgRx7B+O+S5EzIPzZCYHuooTa6sq5YV8lUp49IkHtiHrHvVJEu7rGcm0E0Eog5bEekYxOkQfIt6UASEPTsUWMw9Sldk0sO8h45JwDvnWw4JaZVeATP8dhTktU9GwsO1XoqTbuLtHSK0r1HHR3gwzF3iIdwk4666gxDmzt8yKD70G03sUm245afJFJkCQyRDdcdBvbTVSnePulraFaZwPFbkdYTIuFj2uLGFmtYhr1qup2srQdMTW7wmo93/79wg0lJWoZJCMoITAU1Y8KHGimWdTQEA2AI3w54dH4s7qQWY3ZSXmHnHGqzXEszN2rlnAGuaosuihzvVHWiGnaZ5B4ZDe7uB6Yyn65YYOM4VzWdemxcC9G1+XXuudQjbYvLtnhhE33ciAGxRiFFAfP+JCHk2bXls7ZvCUoGnBjivlTQmfnMWtBbDOq/tqgwq16GPFpImAteoO3HniJDqjkYI0z+DkZoW6wvkSgrEtaZmnuwSa4xmhUbRyRLOcR9mxIVzJb9UkSdxmr3v1FztnEOj+Omms+5u7n197ddiR6RshOiUI2Eu67JqCpFYx3cYMGYf3pLGKHjBaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(38100700002)(33656002)(55016003)(86362001)(38070700005)(122000001)(64756008)(4326008)(52536014)(66946007)(76116006)(66556008)(66476007)(66446008)(8676002)(6916009)(54906003)(41300700001)(316002)(7416002)(4744005)(8936002)(2906002)(5660300002)(478600001)(71200400001)(7696005)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M8rFUMDCt5I2wdKSrSEFQV25M8ZRNvNHiXRk5w/SMN+g02MVnMxY8DohpBoP?=
 =?us-ascii?Q?xxv61Q8qfAxVnFcY6cDlgM5hZgM0Advo+wx5S4O4HzS0SLPCQwWLFTQjqdsm?=
 =?us-ascii?Q?SkelDxv3Ctldixo/e6RB9noGS5BphIzhav7VpI16cRdPhU+xDi78nJVC+Ivs?=
 =?us-ascii?Q?BTl4bfJoPvGOX71+iUGHxFkDRf+2YjsaGFXVM7xubHOAchHMEcEGvVnN9bGz?=
 =?us-ascii?Q?V8JPIIWXclv6ZkRwaIsvSMWQgU1QwighUOEVmg1Keyio4lzeYoJ1AHp4l9Dx?=
 =?us-ascii?Q?r/7bGfPyJyOItez9Pjfj7An+5cel0AqacFCEUSvmRv4c3nN2NMTurGjKIUYt?=
 =?us-ascii?Q?pUGjwyrkKOUMPikrbzUA9RqTzwYq8Q3Ws6Vb7RCev3hazXxp916p0sVvQciZ?=
 =?us-ascii?Q?Pi5gf7SkUnc3ivO1MWmw6bQ0KzAFUAC3xmkZp+zu5mnwXx4Uzb5FkOht+ShQ?=
 =?us-ascii?Q?/nMwPxqosd1mL1ZNi/C+HpasseEo7yNBqf/ruva3Ync+qZNy8VLO5uGe2Tb/?=
 =?us-ascii?Q?/BaKeGff6BSbonGQacqpc0D6bk4jYReeV0OvamOa/8zo+iBAZm/6v12tNu7Q?=
 =?us-ascii?Q?9QHEZGAJxZB9siPYgqAMgtN8hxe5We18PZGEiVj+atiz8PeVe0vlTnNeDv8z?=
 =?us-ascii?Q?LPBcylS3hfgLfym+HQMEEicKmwF2wEDk81C/ip6vQE555I8+aYrXldKvgWpM?=
 =?us-ascii?Q?4XcW1N/g8kXFYq5jcX+e1TvjQqdVopthTVaxVSBBvmjkLWWMpDpQarHunJ0F?=
 =?us-ascii?Q?kMqVhBRyw9C0x5vJjVmHp8ymfPGPXzL6TCNzBRaG4aAEPBZIw1ECQ6P5whv/?=
 =?us-ascii?Q?+YOWVNYdOrGwY/OFmYRo7OXnkl0JtNTtBd9B2gdTFVIGxmfJU7kfM/60POrS?=
 =?us-ascii?Q?L6G65KoU5gMeHflIMGVD4GUolg2HlTVemDDOYolF/hkBhbAH9XLe1sIlfrqU?=
 =?us-ascii?Q?ciYHvhA/Brj2GKAXbDnXs9iTy/0k7BnOWRNbVoOA9fpaJKMq4T5QeIPlQ5ol?=
 =?us-ascii?Q?GBBl3sC8xpCiCjYntpGyL+B0MD0cmB/hOkfS3JihcVdXWR/5Fv1xpy0YBK4z?=
 =?us-ascii?Q?2T36XGCRKqtOStLUdmw+mgQRMhrXZ5KOC3TOiStFS+Jv1IyHEQEPkLe8JqrK?=
 =?us-ascii?Q?nk2IULZSKK4HV/WANQczREqJNI4TmjuS0HYqCjtlbZ5ZyBx6Loa0KC2hWu2X?=
 =?us-ascii?Q?SHP7U/dQbMLwCQYtweOzcuCYLvYvPnRQxorFXgQlD2s5F7uqNOqOE2NsBWXa?=
 =?us-ascii?Q?rfA94qWhzEdMeEj9fJ56IBncTgfXQwMS+9LM4ST1ae+stcYuMeYUbMDztN7O?=
 =?us-ascii?Q?cG6ixFWHzaPApAWvvPBQTDbl6L8QyT4kJmJ0szUsy2oRwWxBICGcca4VGICB?=
 =?us-ascii?Q?uYmD3vojUR6bAPK0HyxwUItV7o5TqjaJKWbvo/j3NvCu9m8iBQqIpYREiKGa?=
 =?us-ascii?Q?mKX+BQvD1pSJreT6fKz99m1izx4g5OIeEl5+1Ah+0CKIvBji+YRoqhK3YT25?=
 =?us-ascii?Q?FxGhntD5jVe+ROS59KOKmq9UKPoBTAc2t+7UFg0Yr5miGYImYlZaEB14wGRZ?=
 =?us-ascii?Q?y8Rp4Op1C8xU5w1kLV2IUBCywN9C8sDd7KwpYBaMibX3pEnSuwVfKu43SY9u?=
 =?us-ascii?Q?NQ0vIYcovkOGxLe7vJJ9JlgmiApoIF+HIHxbz8Lo8vj7S2GqDNavUAW74tjZ?=
 =?us-ascii?Q?S3j+XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1ca86a-efc0-48c1-52ab-08db0d69a015
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:25:51.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0m8YB3s2asKNSiH3Bps2gPCb2O8ev1BraHcHzrkCftDanDP8X6NbI5pMaTPY6/8pvNcfjunZFifajZeFaoMaw+DSavzEYWeRc6Ssccnh32fx16P0Ra+bPr4q+UaDRHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Saturday, February 11, 2023 7:31 AM
>=20
> On Fri, Feb 10, 2023 at 10:49:15PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe.
>=20
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
>=20
> > +/* ASPM L1 PM Substates */
> > +#define L1PSCAP(x)		(0x01bc + (x))
>=20
> Doesn't appear to be used; please remove it.

Oops. I'll remove it.

Best regards,
Yoshihiro Shimoda

