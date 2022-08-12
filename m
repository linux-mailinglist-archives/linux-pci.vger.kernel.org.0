Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610CA591520
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiHLR6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiHLR6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 13:58:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F06B285D
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 10:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHFGvdERpREN83Znuqetw1gLrhePgOVOY5x3qpGflZLLEK6x8wnueN5r7sa4gOuifc6BGWixQgYC5oML/14lkRn5xbobf0320HFjz2YtZgSpoJQsti/afId51wEbmhHn4wGWZ7tVknn3zTw04DBuWM/6Y+HdGcjbdD4QvoYO6RPDhf24viyz4ZnkDQKOvdFT1E/eADNECZHAVcBcHquurBgzKgtGo6UcJBB05qabmUdX5IiCK4hXTa49ghJ13X+U1sfHWBEZYU+mP881jukwel8qFGd7E41ZsU5MidYu7U0beXMgn1lQLm7B47Ppklvm3yuXxwl7dPnsD2/I6RxRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJOMkOC/lm4qh/7XdqaVHdEZ9WbPrFjsSIdpo6yn4Lg=;
 b=MgtnRO5aJfFQ163AxEjgPlbU2ZYctoQWxwSWspRVt3l4rgQ3EMhqzXMjCWLbzwe0OrEpR6f9FUugViqi5Szno3LxUJ+VRJAgFsraffkQL/4lZHMw3t4sFdYLRZZedyBCtpfkx8l1KpgCH/uxDObyuT5Kk/PhEEE2nUL9KZzbqnktkq+nW+2tiKefA5zlGI2MxRuc3ToxojJn23qM48adh76dSg7w2rzLocexR1J9wCuad/tbZIUGewmTXFyqS6DqXTe5YacTr/boj8486qbxSMuUpfyXktJlPl5j/VFW+gHdmB1J09V5SncahEHxJ+uAwlLZZXLHUinkTnsMi133rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJOMkOC/lm4qh/7XdqaVHdEZ9WbPrFjsSIdpo6yn4Lg=;
 b=sVIXvloUFfFwQFrlr+vmilH5+g+cXeLvpZTQF7jHh18Ip4C1K4gEd6B37Es1Pefirm6CkxbjtMHt3WpSd/MnSPJOpCT0+7qYUAGhE1CMwQg/FMgbWzaGLHjOMWegIB3nndeYXzdlRnPG/PDhi7xJtfo+Lyz51G3jhiJNk9uvcfY=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 17:58:09 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 17:58:09 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] [bug report] PCI: endpoint: Support NTB transfer between RC
 and EP
Thread-Topic: [EXT] [bug report] PCI: endpoint: Support NTB transfer between
 RC and EP
Thread-Index: AQHYrW/Zz6TCtBX7Lkal2Sn5L+7IWa2rjvCQ
Date:   Fri, 12 Aug 2022 17:58:09 +0000
Message-ID: <PAXPR04MB918619FB78A49CA8E79A41F388679@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <YvTeWal8mQg56xMA@kili>
In-Reply-To: <YvTeWal8mQg56xMA@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b32676-b0d7-47ff-c952-08da7c8c37a3
x-ms-traffictypediagnostic: DB9PR04MB8107:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4zIL0YPhzkMN9L/ciDByp8D7qKpW9Nqf6QVfDlmyRkhOA82pjizXH3LJ7OCZ8pNjrOl7q6RBl7TxIJB7Pjps3mIz8NnAXlydhjaZOB/KURKrezoX3+jBYhODMk5ljXu04V4QIp4enCBWf3u7acVYDZM6ASlKoZlLoyaoXvGUrADnl5E17cdq9yp+02yS7rACNEQ/lXC0DW3q0vUj+kCCgXQ/1Z2MNgEZdDdTymQBLYlpuYbaVBWQ5CTw4hsD/rA48ScR9hdL3nGT8Pb/gqTw/LTFDkERPeYTMdlPl9FYIofmluocvVE8Sr/hXkOJpLC/Jl7XVg2sOGWgH/Bv1NEemTGY5njI2oxUnDowDDUJWAXgK/CucxHOTJaWvhyUjLBIKG0Ohkv0o/ocS83wWBhSewsUlfTDzWyPkCkUrvZBXIExN86QqGbpMaJ0IrcOgFX4/Gu6Sd2V9aVq8b0KEt4RCk0XJJjghoP5IfyyCICKcBl+w1nNnONq37MjcMLx9YC527vSYo2CHzRKVoYOBQcLv8PscJzcURq5h5+cj524lDMdEddYHr6tzGR9/SZdFB+aKDtQT9h6nz3Z3Id2MHHoXpZNsyjB2C7AaL7czs7Td3lo8cjuOAZXBYcgTsqy3JT6nz51BO3DTHxCttoxsP4flMtXXNGimJMzIXKdWJY4TVSMenBPMPMIhXxiM1yxt6/Px4mki4M8hF8zoTc3mQ/W7OAyWOXW/oDZjEF2zn60nKH50HqrYBYh2m9eJ9sGC37O8Yc/xP19cWUA1nIOaPzi4uHiXN13u9/tnhnq4mQY1aff53zDWuccn/v18ZxG7E7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(8676002)(316002)(66556008)(5660300002)(66446008)(66476007)(76116006)(6916009)(4326008)(64756008)(55016003)(66946007)(8936002)(2906002)(52536014)(44832011)(122000001)(38100700002)(38070700005)(86362001)(33656002)(53546011)(478600001)(41300700001)(26005)(7696005)(71200400001)(9686003)(83380400001)(55236004)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6WaGBHIH2rXebOdgORO4MPCuPGIQ2SymxYQX8UHsNWMaC6ySbk/mP8/ZOfKk?=
 =?us-ascii?Q?RyO4d91LsajAlFeaqkpNI1Kgnu+WgvNEL9y3jyvdWxeKUv8dN2PURHBgw/hv?=
 =?us-ascii?Q?c6szGcTkK3ntN0oQMtch4HEs23XJw7PBveuEsi1WrVQ2bvf+gTmg437680SC?=
 =?us-ascii?Q?oFjyfw7nFMcNG8NI6zUMsDP1o1yiMZawkFfKMOXTLtiZxXOTc7X/m5G9zEL3?=
 =?us-ascii?Q?7bwZUoVzAJLdTdVJTdqHzVyh1z/6LIwJFpHvcQlXqpuJLGNWneTnsJK4APHa?=
 =?us-ascii?Q?6LQ0CPjRGUfzQXUERp92tP5M1JLg3SG0tB8V9tADAn9VxUF17m9yozLXkLVF?=
 =?us-ascii?Q?qoQsr6QCXVBPDrdhaqd9GVtadraV3hbKFd/8iJFQ4fOPdXJqVFGNNrq4/vr4?=
 =?us-ascii?Q?jzMcae5tlBOcgoXcw1n/RqEac0hAE5oouqrO5DCnZVi1h5fEHxmumz9Xoh8W?=
 =?us-ascii?Q?oQ35A2NKD+F7p3Ekoh7BwXpm+cwUF/Oxnu5zqB5eCe5hKYCqfmlP31KeRoAK?=
 =?us-ascii?Q?8/Vlz+fgJ/mMr1TY4O8dfkcSuN2FoZei9b3kjsUWNWtBm5qgmyK7V5W8D3bl?=
 =?us-ascii?Q?yfS3LH3wkOFSCOXH2vtQ4FAROGVnLg8lryP3Fjl/lgIB31bkLhOxCzaPKGmH?=
 =?us-ascii?Q?s4PSlYaJjsMSdyarySEFtPz6lHmOd/sDOGlKXmGVryXvg3jkTxhsNcday0uX?=
 =?us-ascii?Q?VCAEdBpCcPVdDwJ87z2aOKn1bVJAppZzRcq+vwRZFV9L+e5nkB8jmurltxMB?=
 =?us-ascii?Q?NiofKUOTDfIWTG71KdF4ZmR2ifx8tJ9ipfKJxrHQqHYy9OvFwIDivcu5b953?=
 =?us-ascii?Q?XZx8ZS0Q0nBVj0XD1ky7nPImrS3fjonJcpH2L888FQULCNVIIrXD4QGdZ7WG?=
 =?us-ascii?Q?rTsCq5ElIV/aKaVLnU3rdXNvHd3Jpdba9HQv92go6Md5Zvk4blnPYWanxij5?=
 =?us-ascii?Q?UsjIwmMNzHXs41kiu3QWZllY9Q/mfsyQBxJZTsDHpBMoZbD6Zgxcf6FTZor1?=
 =?us-ascii?Q?hpIsEIEZ/T7CRcJtOV3c7e/dDtz96p9O/+QTci7QIUGjIzUrvhZaorNAV/RT?=
 =?us-ascii?Q?/98tER75SCMqG3R5abDtq0m8heACyBhOuahIhq6A4Vu7jypR7+STgkDBd1Jc?=
 =?us-ascii?Q?PmcED3YcjxP/EJq8J9acd759puayVhP4EDPS4LitNrQPBFTuY48q70HSaZpX?=
 =?us-ascii?Q?HN6QcjNn4ZN0RZud+wiRRyQjQz7ZIsDd1tL3oT04DC5NZdASwUGWD+RH9ng5?=
 =?us-ascii?Q?Q8uHJXe/Jq6ofefXNwfRYVSCEgj7ga2zAbvqNHAYaJStr1kUhfEou28e3ly7?=
 =?us-ascii?Q?3B3bD1mH4v+f+Taqh6ZwGs18d4rMaRTmzfmApN8OvpVZDTln8yrw004RyCXd?=
 =?us-ascii?Q?ifEM5jXx0PLBLwNuIb7zscBpQf7oDxE/P+7yQyUCQwmgVWj72BODIT66psUQ?=
 =?us-ascii?Q?6RWvG9KnwCTqspGv5mIKoFCyZrzM4fppheVj1BdOx9f8hGG4mvrEfI7/LD53?=
 =?us-ascii?Q?L1d8w6i9ztZNvv3UngKXTyLsAZ/hE0qrTY5egNB8zrGr8EgXBcii8lAnqnZq?=
 =?us-ascii?Q?b1rM3Hp5hRn1G0yziGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b32676-b0d7-47ff-c952-08da7c8c37a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 17:58:09.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgcHrP+3erkETCatEza3wTjviRbj7WpqAeer6//yNnk/g8RGwkonWR37+0hnv1WgHxqCEa//PvqrgWV78MtO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Thursday, August 11, 2022 5:48 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: linux-pci@vger.kernel.org
> Subject: [EXT] [bug report] PCI: endpoint: Support NTB transfer between R=
C
> and EP
>=20
> Caution: EXT Email
>=20
> Hello Frank Li,
>=20
> The patch e35f56bb0330: "PCI: endpoint: Support NTB transfer between
> RC and EP" from Feb 22, 2022, leads to the following Smatch static
> checker warning:

[Frank Li] Thanks, I think my MSI patch is under review.  I will squash fix=
ed
Patch at next version.

>=20
>         drivers/pci/endpoint/functions/pci-epf-vntb.c:560 epf_ntb_db_bar_=
init()
>         error: uninitialized symbol 'align'.
>=20
> drivers/pci/endpoint/functions/pci-epf-vntb.c
>     539 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>     540 {
>     541         const struct pci_epc_features *epc_features;
>     542         u32 align;
>                     ^^^^^
>     543         struct device *dev =3D &ntb->epf->dev;
>     544         int ret;
>     545         struct pci_epf_bar *epf_bar;
>     546         void __iomem *mw_addr =3D NULL;
>     547         enum pci_barno barno;
>     548         size_t size;
>     549
>     550         epc_features =3D pci_epc_get_features(ntb->epf->epc,
>     551                                             ntb->epf->func_no,
>     552                                             ntb->epf->vfunc_no);
>     553
>     554         size =3D epf_ntb_db_size(ntb);
>     555
>     556         barno =3D ntb->epf_ntb_bar[BAR_DB];
>     557         epf_bar =3D &ntb->epf->bar[barno];
>     558
>     559         if (!ntb->epf_db_phy) {
> --> 560                 mw_addr =3D pci_epf_alloc_space(ntb->epf, size, b=
arno, align,
> 0);
>                                                                          =
    ^^^^^
> Never initialized.
>=20
>     561                 if (!mw_addr) {
>     562                         dev_err(dev, "Failed to allocate OB addre=
ss\n");
>     563                         return -ENOMEM;
>     564                 }
>     565         } else {
>     566                 epf_bar->phys_addr =3D ntb->epf_db_phy;
>     567                 epf_bar->barno =3D barno;
>     568                 epf_bar->size =3D size;
>     569         }
>     570
>     571         ntb->epf_db =3D mw_addr;
>     572
>     573         ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,=
 ntb-
> >epf->vfunc_no, epf_bar);
>     574         if (ret) {
>     575                 dev_err(dev, "Doorbell BAR set failed\n");
>     576                         goto err_alloc_peer_mem;
>     577         }
>     578         return ret;
>     579
>     580 err_alloc_peer_mem:
>     581         pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr,
> mw_addr, epf_bar->size);
>     582         return -1;
>     583 }
>=20
> regards,
> dan carpenter
