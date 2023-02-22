Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D669EDA9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 04:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBVDwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBVDwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 22:52:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F592D44
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 19:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga3UnBLcxRXipu19JSL5D5KxzcFrksP3v+38NXr5AqonEpnH8LhB8TrOlKySI9OatIkJrC+A6PFN0MGDS/hkoMT6weVgo7s9e7EddUkmHI8X9W7i8/DtHkA6cIsXnKSCv/C7hnrC5JK+ayTJ2GnGntgIcWELLPk9sYr1Tx6BwB+aHmonTS17JNJ7KL3EmO+CGK425BXLQgHzoDXT1iAB09+t6Ft2r+X0Xl8GghXsh+Ocf22lbv4vmH9ANpVh8JL+U8Q17dGSPEZWT4hT/K+yyzhzDgEqDBRiZQPtrFYH9iufKdwd6uj0b8JzxsgNUYXZBJJiPv92kZTqPZ9bgxxdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E5fEVF53ecUB7R9bgp8/PD/vP1/S+4wcP9c7eowEpQ=;
 b=FByVyy3FYOfKYLxGM9SOoOsoQnyRr91Yx+aTu2ST4iuorEg49xE3LnyffwavYPlGpVhootzrbav9qijZ7vPD997wf5t/5jgjU8u/flO4ngEV7OVhIQZfBoDfOaOlJpkgm13xkpXo2Zbi373EENrbQsAOjv9NEtY2TThkZRwOpmBiMH8utbSnvagqJULiNdBm55aN/mcLnf/0icGIKgsX9dAZ/xFXbGyK+fVxPsDty9HruMeXdODd5u292cTVhklYyB5B7a/l8YULaX36QeCh5qPdtN1fniB8VPYA6vNHolKSrZfssA5xX2SdenT44YnqzUJHcOI56WFd21ndVbGr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E5fEVF53ecUB7R9bgp8/PD/vP1/S+4wcP9c7eowEpQ=;
 b=qHlV6J89KzIDqiR9tF7k2Jx5m6P5INj3VCoAumfRRNcxLm8Y4TdA2E51b1sHxsN44HeFz/h6y1AZoIUBbg75XarGkFac2nNHWFiyDQBYMvZQt3/7e8CahIPwnRoV/j/07jUoIIKcZKZDFI03oIxCQtC0V7aACGsR03qzP/wcTKE=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 03:52:46 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::4bcb:22f3:7a9e:4036]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::4bcb:22f3:7a9e:4036%12]) with mapi id 15.20.6134.019; Wed, 22 Feb
 2023 03:52:46 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Topic: [EXT] [PATCH v2] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Index: AQHZRmB4srzvnXsHokaDoAyz+1u0xK7aVUzA
Date:   Wed, 22 Feb 2023 03:52:46 +0000
Message-ID: <HE1PR0401MB23311B850532329F5C7F891588AA9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230222015327.3585691-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230222015327.3585691-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7335:EE_
x-ms-office365-filtering-correlation-id: 45dd2e24-16e4-4e39-0ec2-08db14884283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yxm+9BT9UEeC/PNSJT9IJFMOp0tOELpmOf9BeTFu/MsAysx0+5VLA/dm5QK/jlHCS6eI54FqZboMTcfZKpF/9swklPglRUpDleh7VBsmErhhN06+bnfTkmfIqTWv3UNMs0dLRZ8uGKl5EZ6uK5iTtGYfxLa1aBjENgAbIj0z5frEN+rgJDVMnqQSGGuEAqqL2UFO9NYO7j44fb1d2ArXVx1fNYeEOckX+B7u4jw55Beg2xa0wTKfVatHUIy5YQXXDMnZi9cALR7SsfG1QBa7XhlDmVT+aiIoBOL2ZhpU3xyTUIrI0JjW23ap1ys+bZQfgpsLewnqLK33wz3qKQbO+Ir0GOBdgRdpX3XQjSW9Pj0lWFDCjOkQ80Os6YRbw+qIHJ8Vfc5WJZau0OjMOmUZnDzIvEIZkHCpcaO8Yd49/9nLE3VLgXwqjPazUXs6DDdhin5xaDIgm78c99ERLFiyf4PTOeaDGHFfXBLKBDS1vor/RR1dhsAmM99yb9FwjU5gfeO4alC0HeCGjaMZlBfoy+XGjySrsE1qi1RFFYUoN1sUoOOa7mjsvEQd43CbIp7B8RPLvY4uuwV3ISfuX1e+rsJW4vW0q74s40I4kn5H6wSwnxcRx7fHFbJU3QL+99865/eMmB3lJUO2bhJP7zPqts7UbLBnpYiaFYFXOCwfS2+IPykwzDHyGHaWZDVKizvT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(83380400001)(38100700002)(122000001)(8936002)(33656002)(86362001)(38070700005)(2906002)(41300700001)(52536014)(44832011)(5660300002)(55016003)(26005)(186003)(53546011)(55236004)(9686003)(6506007)(316002)(4326008)(71200400001)(64756008)(7696005)(66556008)(66946007)(76116006)(966005)(110136005)(8676002)(66476007)(45080400002)(478600001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiRGHmrch2S5SnW88H/5D3YWZPqslvUEO/Hcn2TSPf4doAPfLP7/B4Uw0se9?=
 =?us-ascii?Q?U5CjRGTZiC6X4cZKdjxCEwwxgIJ1erG93vjxRiSuamPC//p0x9OCFqfLthaV?=
 =?us-ascii?Q?8xnqmVAcu51Z3pv9IN3NRQ/b6ArnkLg5hrBsCztsI+eYoqhEmcYFnxG0wWGd?=
 =?us-ascii?Q?8J6AuxFEUnUCp+FZyT7ccLeWZ/4MrwYDUfEtGvRV+/z+qWt9+JHS7Os/DvJS?=
 =?us-ascii?Q?XT4aditH3X54lUCFScc4cahalPpJn3kivMZmtOzuxkSif7KXRaSIKQ845RBM?=
 =?us-ascii?Q?AmzKZzR8xx65SvgnHP23fp3PKtbc3MoYAeqRTloskm4D3bVr0mN43xk+IX5c?=
 =?us-ascii?Q?9V7ns/i88dAdyE4qHvTZ4QWeXLjEsE7oKMV/7n6Wq1osKVEpKCNUgpLL5ZZn?=
 =?us-ascii?Q?oEAD/1SykYHK1Mdh8tP4PxBzrN/cA8+bOxOafKiB5Ss7HgoaxCas7iFzCD7B?=
 =?us-ascii?Q?JWKPAH/3B4P7UrAlgKhUngNiKyssDoZFH5T7X6XPnbEumz1ugIg6gHl3OLY2?=
 =?us-ascii?Q?/l3MOrYMviCmrJdYvFtYUJ2DS2f/9nrfb36FgfnKglVl7PrTUhFnpTUh3Qeh?=
 =?us-ascii?Q?Iyc3EIpEhivPciVGfOdpBmKRF7f2bNUDUOPirxbB7iHLLg/WWiOWvTv+iXWM?=
 =?us-ascii?Q?WAkr+9fmoNE8xoemrDbSV8pc8LTtmWGiBbKdzm3KQaTQvzIXPgMYl6afxjC/?=
 =?us-ascii?Q?rAtnZyfa6Lkpb41v26fbynOXHp6ogwSee1ygpixQOO908bZ9ClDGXNJwbn4Q?=
 =?us-ascii?Q?4ny/ExjvfDMdH+6U3GRzx5U0CnjKplu6bszFGo5owe6cd3b93h1wp/CFTXSt?=
 =?us-ascii?Q?aKFyChBt/GN//x1nbL1nhXG0LwfKl5lqD++KDdPCU87FLXzRnmQw/5S7L4s3?=
 =?us-ascii?Q?St8QOqxrliapLvMmZhACrD2u170mK2oJLLZMW3Mz0MI2yIpXFgcNCX0OB/+z?=
 =?us-ascii?Q?3OeWlwV9SH1Y/MT5/+5ljLu5sxNxvf+Mp4Q0vtf4/YXeaM2iYQRYd1XnZ3C2?=
 =?us-ascii?Q?HcygOyBCyNhK1rvHGefTeYJ57sAqssABFWezBmFza/OR2a7x2hfhmDDdGCjv?=
 =?us-ascii?Q?740Abbq9s2B+OK50xvDmxrHXeBEfztgPrE1o00VCljMBHTeOJad+b7u9IdAx?=
 =?us-ascii?Q?HrdrOSPqElOAg+2jLU6tXfnslbNUBQzcKPd7rTvCAxsWgM7Veq75/huwP8Mn?=
 =?us-ascii?Q?DgHW2sf7PDvv2tydM/sUoFbrhNbwT/qyBaNJQ1yZ+RxqXptSWxmGeYrcZsFi?=
 =?us-ascii?Q?0WCxIF5S+GTahyAL4T5AILDWgHdjw9SAyayThTSp8WyyjZ/sBB/4/yhGpxmP?=
 =?us-ascii?Q?mLLnp6bSyGnlSTgrhRQQNm4cvEinkjg88ZxeY8oqaThbFyQtNXgTX5yAU0NU?=
 =?us-ascii?Q?17G2FOPTixxgQSjTUVaMQNY+jxl26nas7FD2YRYlGtdmRqEmJ6zRFgiYLV6u?=
 =?us-ascii?Q?liJLCAEPNfeY9hymkQpsMfACUGkV+K7+ETI6IEmINjvA7kMmjuOrt/U31Ul6?=
 =?us-ascii?Q?AglWMRQT10zNVQzw+L+21LPl+BTiY9hwUROM9JR/VbmR5cQ/hlpFddRFNChB?=
 =?us-ascii?Q?vQ+cGqtp7VT706AdoPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd2e24-16e4-4e39-0ec2-08db14884283
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 03:52:46.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwDqKRU47Hu58iWHTGGsVnguhur2xrk+gr9oES8dAbU0MYG6Ei0TYIFlxT0gUC8LqePq9pRprmVjQ+gGiX6qmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: Tuesday, February 21, 2023 7:53 PM
> To: lpieralisi@kernel.org; kw@linux.com; mani@kernel.org;
> kishon@kernel.org; bhelgaas@google.com; Frank Li <frank.li@nxp.com>
> Cc: linux-pci@vger.kernel.org; Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com>
> Subject: [EXT] [PATCH v2] PCI: endpoint: functions/pci-epf-test: Fix dma_=
chan
> direction
>=20
> Caution: EXT Email
>=20
> In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> results of pcitest with enabled DMA will be "NOT OKAY" on eDMA
> environment.
>=20
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with
> DMA capabilities")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes from v1:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-pci%2F20230221100949.3530608-1-
> yoshihiro.shimoda.uh%40renesas.com%2F&data=3D05%7C01%7CFrank.Li%40n
> xp.com%7Cf725e4559e7e470a2b7008db14779a20%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C638126276145239757%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5QXtwk7UxBs0WnwILTPgGeSbmUBI
> XCB9yj9DxVSf7I8%3D&reserved=3D0
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-pci%2F20230221101706.3530869-1-
> yoshihiro.shimoda.uh%40renesas.com%2F&data=3D05%7C01%7CFrank.Li%40n
> xp.com%7Cf725e4559e7e470a2b7008db14779a20%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C638126276145239757%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5w8fkXes5CvaLP8NgI7X7Mlxhvg%2Ff
> iUhEG4D8wnoANc%3D&reserved=3D0
>  - Fix a condition for "chan" to match following check "dma_local".
>  - Fix a commit description about the results.
>    "NOT OKAY" is the correct result.
>=20
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 55283d2379a6..f0c4d0f77453 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -112,7 +112,7 @@ static int pci_epf_test_data_transfer(struct
> pci_epf_test *epf_test,
>                                       size_t len, dma_addr_t dma_remote,
>                                       enum dma_transfer_direction dir)
>  {
> -       struct dma_chan *chan =3D (dir =3D=3D DMA_DEV_TO_MEM) ?
> +       struct dma_chan *chan =3D (dir =3D=3D DMA_MEM_TO_DEV) ?
>                                  epf_test->dma_chan_tx : epf_test->dma_ch=
an_rx;
>         dma_addr_t dma_local =3D (dir =3D=3D DMA_MEM_TO_DEV) ? dma_src :
> dma_dst;
>         enum dma_ctrl_flags flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> --
> 2.25.1

