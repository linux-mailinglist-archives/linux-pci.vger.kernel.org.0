Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D28557EB3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiFWPgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiFWPgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:36:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444292FFE3;
        Thu, 23 Jun 2022 08:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFj+I8nf99Fj1BQ1K5/0n21BdyuXY6ju3ge/BSFKoPlVNvO8UDTj7FVOFTR5Ha9Qznl0wizVjNzZe7otpcrx6ZdS14B/+iuivZuHjiSkS5ep8Cp3PDtYCn06cCwqrS9VvYLuiTvd+iSrK2bzl/OW9FbDzUn2YMWxGPYR8+g5OGYki+pvgrQ+q8aY/9ZaeAmJN7fU9i1SgLznTeLevLFhCrACq7eOIkq1UsUCEicW2hQT64XGRiAgsX8pGmv99RHZadu6q1ETsW5YYGvrDYZ9miNzGivSIlfa3+wSf3tLzCCYGRoPva2hxbEAFl+ijjVE9CyU3yklodd+peCjRRpNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxUKLARJwDxyJAeH9YhfAuQu18+HIQ+kzgzVvl0CydA=;
 b=aqMLhPJ4INlJ8+10/Lbbc8OUOPiiZxru4yp0M1FG5+NNB9671VlT1mpP37hhQzmjpqEhareGapgO1yLgOaUPnbrvkABgTL9GnpAu/UV0iOxclPRsISQAAyBzfExhLRXQBNy+U8NNogQuLwyg1PVwqWeaOXl7HpDywNmYi8OT4fzZosTKax0zwYmNExrhmC4hk5+epfETWeVN/F82fpLg2r85enQ7sUeIIMp/BRSiyzFfar9hEGxv+CKLmZ8DM5g605K1EOiI1a1iY8fvSOgb7oZ3fES13eaNnwP+jP/zXGmS2tP8MvjbLtl/UE9VO8GU9OZu+0voI/5GrQJopDYIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxUKLARJwDxyJAeH9YhfAuQu18+HIQ+kzgzVvl0CydA=;
 b=q+is+pgwuKhEISF4dwZv8X12Y9Z/7FEivuuxtVS8/HSxjDx+o202U8oGxUW5XT68n3YYJEUc3I0guqARVbdkReAvc4tK0OEHcPGXU+M3tWkTJrXshFTnKrKbYHmsNjLdC1v9wdh/u06rLSdZ7NEj3/C/hDB5r145LWX+ySJVJyk=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 15:36:38 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%7]) with mapi id 15.20.5273.022; Thu, 23 Jun 2022
 15:36:38 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Ren Zhijie <renzhijie2@huawei.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Thread-Topic: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Thread-Index: AQHYht4N8aJP5oM9M0SulvdK/o1soq1dIDMQ
Date:   Thu, 23 Jun 2022 15:36:38 +0000
Message-ID: <PAXPR04MB91861EE0E20E9EC71F4C494288B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220623084629.260822-1-renzhijie2@huawei.com>
In-Reply-To: <20220623084629.260822-1-renzhijie2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b558573-6fc9-408f-16ef-08da552e29a5
x-ms-traffictypediagnostic: VE1PR04MB7359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEoD6PDhQHvt57bObHUY9RCdqshAX3K2Qf3GnN3STgu49VLiq6jEjbg5dBBPkIYQB9Hc97PIXYTQ/KXeAD1AHF+PHgKK2rd6GN1uIGjmaw5TW7AhdoFaINH55bDu14y4eolgob/XsHA+57E2pKL8sbd4JYsBcCgHtP6Dtk3PUho6DrZuLZ/gpSAPi716IaokXay+u6mIJaraSjyeutyP3DQ+4J9SDkWrVjgGgsse/fJFFG0rqmNEPxBkACPDBhqW9HOoKlDFbLMZjUuK4w6e7ckFhzdLVcNNIYNGJ65hP23iyxwJJxXBnKtzCndeEe8P0bWlpDzXx94lEnye4zw3Pf89vM+a/vTkYUeuIibhBzBA3Rz4upDmucY5fomwVL++Lao/NKlhLx5n3g3BaQJim/LZyTIvAWuiEvkfzFW8UJeGZjgKoKxidjtHIGNDL9x4Qb+Vsjy2OwMZ0JzMkpLcy2IJ7ju8jQWjaTO14YAEYcBY2QbkgtUSr/XjJ+XVeLAWGw/1Ve9zUZi4pJThKah9GiDsaBjxU9xPVR3ldgpGx7dOWXip6k67g5AdM1AIyV+NNouwcKVt2UDfH5/cFH6ieAZeByltsZXQzlA4OFp1+re/Pelskrlspw6zsTt8RlTHsgkA5QBRqhXSS1II+7wr15WetptRsqWd/wU/EvMWZXzhw637oftgAvfxz/RgFch3/4I/i5T1PfR4aT9R6/MgdDz0GQbNCRpoHBlHDfg4HTtF3IMtz+zt0FEu8EgoZEmCTSzMhz3hjbRQ1qgzcQUSwDJJoA7dLwxwfuDJoYxo5ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(2906002)(6506007)(7696005)(54906003)(186003)(316002)(52536014)(66476007)(110136005)(55236004)(122000001)(66946007)(66446008)(44832011)(76116006)(64756008)(53546011)(8936002)(4326008)(38100700002)(83380400001)(66556008)(5660300002)(26005)(9686003)(8676002)(38070700005)(71200400001)(478600001)(41300700001)(86362001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6+w1iWQzrRYldrQ7gw+6jOHqDdlv9vARxVi7CFbErFMWFHuXH0MzHvCDJOLt?=
 =?us-ascii?Q?ABcexAtMbWL6ajL7txm4AMtaUHNr5EvDl0MFrcwXePKZkwsa2Ywf5I3rzIRx?=
 =?us-ascii?Q?8F9PC/gD7dA2ER+5UUxriXFkk67C/pvH95JYSA5RYtANjfnoAwGVQePV39mn?=
 =?us-ascii?Q?zYvGVzcBIcP0Bb81Ay+mbZj1yyaPabENFcWcv5QbpQMCF13MUe/roZKoO/wq?=
 =?us-ascii?Q?5SFwi4nC2lhtvDS4eKbuIEc8IdGkrftzF/eoJtaqzg3blRCUy+SNk9pETK2U?=
 =?us-ascii?Q?rsEK1QVbWGEkv5Ua+LJC/m7Rgk7JlnPD5oqcvODk8Xoz9JPb3Fzi+3EE6ZmK?=
 =?us-ascii?Q?sTJ/brwUDAvjrYZZe4nMi56k3hI2BQd70xfJ/0K11i3bCYaVHTcuWVDcvHG+?=
 =?us-ascii?Q?1d9TyRPPda9Ci4KwYEdVUtqvskGA1eJVhU/ovPryVvwHoKSBxPX9S6kH4fnf?=
 =?us-ascii?Q?pXfuTKkZmCXPskmGyq7pgtphdHcksVkbL3hm1NkUqBbqJCslFBSXm/Fms5NV?=
 =?us-ascii?Q?x0fmWDcRoIiZE3Lley8UNli8saEwyXwc/XWZfSeAwwVsHJJVETjCSqlPfUbe?=
 =?us-ascii?Q?BdFwGAaomsnV9YTzfFqxDbaqR4g24GgNG3fk97wtgw1x8O03nAsvQGYsJ1yf?=
 =?us-ascii?Q?mOOha9MsmH6W86Z69s9VMBg6cDOqLN3BcSD3CkFddW5qEy78/5nNgN1Cg0NN?=
 =?us-ascii?Q?aQR3QexJS01jwe/WyRZP72vtcNyuCzYX1eGz8MAhZLGxfv0Gy1rF5ptiUEyK?=
 =?us-ascii?Q?Drdqb2eBg2UMSZTyxCG2Sgz+xugtbiPf6CKYpWrxNQWz4Twd64oK3lT5I56A?=
 =?us-ascii?Q?02BDQbv+ie0KkuDHfAOQN2lC1XJp4n31gITCqVYrvSKMyOQx3DJMT/uy1Pvs?=
 =?us-ascii?Q?mgohQ0F1pxiOkIUNFfKdk5ko8DSne+v2BgF3v7A/hNwvfCtnJgg5PS0PWBOH?=
 =?us-ascii?Q?XRqCppe/N9AF1ViQYdxQhvQR8dALsnrDQWqxLhMs1pw+myfSX/Q0zdncKgNm?=
 =?us-ascii?Q?LQ698aujb69eK1opAb77dFK7JI0filAN9khzgOos2QzeLKzzJKJBbqsVNLl9?=
 =?us-ascii?Q?LhDEoEGSVEZG12tgSum+G0PJ1Mxmw+XbQ8y1k9iZvtTtAJsZYAhm2Te+DS+L?=
 =?us-ascii?Q?DsC7Vc/zTqUa7f18FWpVD1fIsnmQByFRfpVionIzFt0pcKr+t1iAfKKW6ZF9?=
 =?us-ascii?Q?Szk0NL7A4opV7DWqLhmTreGtfrcycI25LWWQE4m2FgmTCp9LImxyMQZjDL+N?=
 =?us-ascii?Q?caDZeXI8ghzbpgZ5M2KtBnfLIcslp67qHcpxtE9OKbfShQGnVm5ppC6IguL2?=
 =?us-ascii?Q?vh0i4B2MvYgk/Cai3Pu/LA8wnps20tkJC/uuOrby9H6kBEvxEyUoH4Im0b/F?=
 =?us-ascii?Q?5m3tYuyC+JDLg1B8x2RUoU6p9o1OMoJVuL3wDPgOZwWmyQkNhSUh1TfnslDP?=
 =?us-ascii?Q?ioZ2PSY+JRcT1QGgDd+xlRxa1Jsn4cy1rBQ9krvFTTV6Uux+hjZ/ZuR/HKTK?=
 =?us-ascii?Q?SACkklkVAWJ2X3mXUx3KEBNWbIrfX9sueRKeQFHo++oMAGnCI84do7seleSa?=
 =?us-ascii?Q?qpaLzElfGkkOXvW+zQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b558573-6fc9-408f-16ef-08da552e29a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:36:38.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HcCWn1aX0qeZUCqVJS2odYLQ6/u9gAArJ2tbBTYs/gcMcnd2riK3mFBxuZLN8BPMNiE+oFpS8sk2QGR+GfYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Ren Zhijie <renzhijie2@huawei.com>
> Sent: Thursday, June 23, 2022 3:46 AM
> To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; jdmason@kudzu.us; Frank Li <frank.li@nxp.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Ren Zhijie
> <renzhijie2@huawei.com>
> Subject: [PATCH -next] NTB: EPF: Fix Kconfig dependency
>=20
> If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
>=20
> make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu-, will be failed, lik=
e
> this:
>=20
> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
> `epf_ntb_cmd_handler':
> pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
> pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
> pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_prob=
e':
> pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_devic=
e'
>=20
> The functions ntb_*() are defined in drivers/ntb/core.c, which need
> CONFIG_NTB setting y to be build-in.
> To fix this build error, add depends on NTB.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP
> connection")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
[Frank Li] Acked

>  drivers/pci/endpoint/functions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/endpoint/functions/Kconfig
> b/drivers/pci/endpoint/functions/Kconfig
> index 362555b024e8..9beee4f0f4ee 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -29,6 +29,7 @@ config PCI_EPF_NTB
>  config PCI_EPF_VNTB
>          tristate "PCI Endpoint NTB driver"
>          depends on PCI_ENDPOINT
> +        depends on NTB
>          select CONFIGFS_FS
>          help
>            Select this configuration option to enable the Non-Transparent
> --
> 2.17.1

