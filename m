Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE987689B0
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGaB4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGaB4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:56:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D8AE71
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 18:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGAiGJ5VerYwb/tUtBkdZI6XJyy7Uo638gnYC1kFm0yysL+A8mZSCR2LUI/d4vgPh6VnK0lEIwedlePDto3Z7btDtDRviEt/xUgj+RyMY5x75W4BO9xzhYg7l2M0B7bIfRu53ayEcJ4aWP0KfK9uGhKegnjgq1SRku+KLNVHWBVtWkkjf42nNS95LBGW7cQIsSAiyWxs2ihf4VzLUsNY7YlY4ZnqZCXgxxU6oIn2DC1+Zo37Xcnfx+AkbXCyRK8iVYlz1AvjUU4BZyzvYADh7GqwEwO4fqip8w4UApWaXiIkDhGgP3NlD2wWk4YTaefkPmCL/KSvFMiOnr20sLoq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiXVqUqga0xWgzFCpTtm3JR1rwn2ClxSqF+d/famJgk=;
 b=nffMF2R7rwkyyUn2tZuAEh56LiDbyie9LOELJ7PSxqGuixfnM8ZuIHV5SbN7aF5YS6yudBwh7Gr9h5TV1JuAIJaiNpaqc7UDag3fbCmTKWh55wNw3Kp/GO2+X6VofEbTtBLQZ6Mq+5exK/kAUIM7ll4/e2pO3Hk2hughPabjhoTZEFdGWo0qcDr9ljuXWyON9EQGkUjz6YVLZLHw1+6i+AVdLuNWZr4wpVq26hbSjQVlXRNUGYhGmyNoCryjUvuihYY3J5CTyrm523KBCY8ErgradS8QYyjFVV37E/YdFSjs5rgl2f3a9Q/GvnW1zUtIjqZ/fuvlIG9+jaEm2bhtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiXVqUqga0xWgzFCpTtm3JR1rwn2ClxSqF+d/famJgk=;
 b=HR/nXvm+ewQyI56tcy2rmSgXa0PfaBnWHlvamWllxiqnVnakprxxVHWAOTr2j0Ff5U806GND2uWr/fzLJEfNk8W+wG14eSlqhpeYRsfYGTlHiZCoaYhwUmG3WxpBiUn3SvACK0EYInx3pKCcfLtVyXFJ1ZXmdC2zmJDW7iN/oiM=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by OS3PR01MB6119.jpnprd01.prod.outlook.com (2603:1096:604:d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 01:56:43 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:56:43 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: RE: [PATCH 0/2] Cleanup IRQ type definitions
Thread-Topic: [PATCH 0/2] Cleanup IRQ type definitions
Thread-Index: AQHZw030cgrknKCySkKp3T9rvY8lAq/THZfQ
Date:   Mon, 31 Jul 2023 01:56:43 +0000
Message-ID: <OSYPR01MB5334E01589952B7E03D87C9AD805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230731012550.728070-1-dlemoal@kernel.org>
In-Reply-To: <20230731012550.728070-1-dlemoal@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|OS3PR01MB6119:EE_
x-ms-office365-filtering-correlation-id: 9ce5ab68-b433-4f78-1ce1-08db916963e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oB+QSVWXmWw0oPonecbBgaW1CC9CxSPtzYcCY75KiUnXJuXchEyBw5Bk0q81jeQpDjVpp4q/RPmDQsa9QZhfyQNsUfd+nnVsa2R4SMKCw7HYi3oiRAIck8poxC95QLVDSFhefYdJVa0oa3pMgGkKaYhYYrLM4QGBrhwwP9dRI6+F09LiQ3YWOLjjW1kZ5OrWaRWZkjm78IhdQgU2W2sxduAgK3KHzHUOb4u08hNvhf15OT5uveNr3mn4SE+hczuC3NW6r72cdeNobveNMLbALx2OXeKoKoHLihvPqtiVLyOnLV1lOMW6eCgHlYKFfqkrD0amnAXagAOz9/VQqKnksflvgqiblih38ctX8IyjG7WrimKXjwiKFH60P/TZf3hx2RUncMScXF8WGXQaqxCxgX1Ex7HGRn3G1/BMO8rpJw6FtTDInpmQR04UBrQwF/t+FONsZbobVawUnpUXKQVp+FIpq0K8DrwKqRoezR7W6PkbZ99k963lVWQ1AkIvlcgi9JbZqcAW+ZaltWDIyeSC8acRGDMKYPBtt0LxMLXocU8oybNC7Eox25RWdwyoWhycD0ghiXJeWD6URac58Ru2pitJhzQRRJEXbRfybG2RqWFHxWVkCzYdhLKddgOirFWmFY+TmtFDLwSvW4WekU4wzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(110136005)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoAGbaVIZNOJcoVH6mN1aiPKiThSv7K6XuRbeT6H+5OidhuMp9X4noGpERWQ?=
 =?us-ascii?Q?tOfdi31rF6Sm2TOi4wHx1NesV1WVKtqx7MXbl5VsNrKxBNRpWFAUhK5+7h1k?=
 =?us-ascii?Q?kCw+OomrGvrG/XIfKst7ALqRnWvvK6hY9vt2paiJWn+JFfzSpG0Fub2GujKh?=
 =?us-ascii?Q?1KvDhNReovBtEZVo6tUFJFb8HZqzbsnMc7VbPA/EpNb9rSqAdl1e1ZQ1LbyI?=
 =?us-ascii?Q?XBEpD/oKLAkJJPa7FsjrOA4zT8i/lJ3KHmb2eRoRFVfLC9Pj/Sp8tgPilVPq?=
 =?us-ascii?Q?E8EXfGY+RXPhGg6Gq4ovMXaVtBSTuuhZS7jyGFOqUpYO2mi+eaPPSnvBeyB2?=
 =?us-ascii?Q?4lL7hK/JbHn46v9oiSjeGZdTVyasJcyyaVctI8lINbNknrVLQYsI6iTNeQYo?=
 =?us-ascii?Q?CbAcQQAGYC2bmdLOiMn2sI26mEytIPBwVDbv9bQrtw126mf4M2nqeigBh0DG?=
 =?us-ascii?Q?8r3x0wkv/C8/1HZZhkOTqVNuJjlDtNsktVR/Vo/Kq+7LXCYWjyaArY+ot8wg?=
 =?us-ascii?Q?gaxOHIfFWt4lYvA55Q7tpgxmmg4OmLHMb9Rp4hEJT2FbbdPUF8b7ESVNYTPa?=
 =?us-ascii?Q?EGRj4K19crIDn2qH+Zp9t/JhZGQ69e3eNsIMKpu78buoDImAO7HCYvTeYuMA?=
 =?us-ascii?Q?v3XhOTGL3t2mIvZl8VkyUPUjkeFvRnA7JLBL20xks4lo1yLYR+/pY/rKBuFL?=
 =?us-ascii?Q?w+19XXJo6rtsWkZQXKPuoVmb2mEygfRcZcQrt7e7TVnoRz6d1yGNUOPCvNRa?=
 =?us-ascii?Q?+A6ZeZwZE38u64H11kc0UGgrE4Fc1p88n+ILAoiZw2cBN6Lu4HZpNeaok0rT?=
 =?us-ascii?Q?YDnRSAJbc7NSA/6F8YmAPaQVlg17IS4NgnDFjQFeS/3JvcL51cpeQ4HWYZ/N?=
 =?us-ascii?Q?t73Jm3odiyBHUtNZLqDrYv6CA9fTNv1oTlUqXZ16bknpvhDk91jS8IJ7teXi?=
 =?us-ascii?Q?b+Dq9jRiAEVyKsvkmbuV2Om6yEqFq4u21AenV0kurFY4m5zHqBQ/e5SpRYop?=
 =?us-ascii?Q?KcPbDOVPY88qk4ibm3QSBBJTJTVbt7KsfJ1b6HOOCgedY+VDZZ2htcoeHu21?=
 =?us-ascii?Q?OtrT6uO8Gjh36ivxxR1K5mGGrVBgAgkg7EkErv6ADLJhYlH0RS4ow+MvDR8y?=
 =?us-ascii?Q?wM/wYDner0R5bwBd8btdGMB14azYKV5SYl2c7Z8d4LwkmQQiNlc64DaCyFSk?=
 =?us-ascii?Q?i60rZQFm4UX5KjKI2x3gVXXPi9ndCBmzbA5SKy0JUJIpjl2Vt5Y5N9SBXZ8c?=
 =?us-ascii?Q?TWn+pk0IQ/9UX1q4ATSr/a3nzxfIrlXWqr+KrsL3HW7aPCcteVpzBhKp506H?=
 =?us-ascii?Q?QOqEhX6vP+1kGLqeNhoMlYrzFnN0k0VlacKTjo1KdmZSJ11N1Q7XryPXk2jP?=
 =?us-ascii?Q?SsQZ9uJa90AbU0ibgWVCC658jjOcUVQCTcYqP/9KtVpTj1Yt+8viSlqBkwiF?=
 =?us-ascii?Q?4yZPA1+zXIl5on+RRwifyjogh0wZODBkYdBjrPYY30DvLFHd7DNrcJJ7vm4l?=
 =?us-ascii?Q?hcFM0C4ppx/OTvpR8iViOYDiTWFtQh5U/3Bf+sFKJsmbElr1Up2Z3+RIEG21?=
 =?us-ascii?Q?Ejoh82q4QGkmiwiALWCfGu+xsMioxG/JXqr1AlCKNrGtQ34LCM+NGBCZU8Ua?=
 =?us-ascii?Q?PlqhIxIE9APx4jkA+foCp521SEANO8Kj34wJYrG3u2grzHXT14/FABCsUPv2?=
 =?us-ascii?Q?EtYaVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce5ab68-b433-4f78-1ce1-08db916963e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 01:56:43.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1vjdnNmlvunLpxCALP79Ri4euxdqgJ1spnYRKKdtNdl45woD66qCem+PafqkzZ0WCkS6WZKxb4wnKPaZ5C3ZLHcQhtmf14x4Za4ynI8eKLyfmCckvSOEH9x6ikJcCxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Damien,

> From: Damien Le Moal, Sent: Monday, July 31, 2023 10:26 AM
>=20
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him).
>=20
> The second patch removes the redundant IRQ type definitions
> PCI_EPC_IRQ_XXX and replace these with a direct use of the PCI_IRQ_XXX
> definitions. Going forward, more cleanups renaming "legacy" to "intx"
> in various drivers can be added on top of this series.

Thank you for the patches! For the patches:

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> Bjorn Helgaas (1):
>   PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
>=20
> Damien Le Moal (1):
>   PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
>=20
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
>  drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
>  drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         | 13 ++++++-------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
>  drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
>  drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
>  drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
>  drivers/pci/endpoint/pci-epc-core.c               |  2 +-
>  include/linux/pci-epc.h                           | 11 ++---------
>  include/linux/pci.h                               |  4 +++-
>  22 files changed, 65 insertions(+), 82 deletions(-)
>=20
> --
> 2.41.0

