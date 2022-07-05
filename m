Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD48056723B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGEPOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGEPOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 11:14:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE483165A6;
        Tue,  5 Jul 2022 08:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cttt+bIb6yUEhcZDlXryeFAwjx09MsWE17++kL2Uc38QqiAw8yOsj83cTyCf1nwjGN+k0LTl0DVg1MFfEDvGgb6bquhB2S45FfV7eCvZ0TGzaVv6jWKNS6yCbQoJdGN+V6xkB359+8arwbaRBWeHLn6YKGTwQPlYqXPHjOiwZU9SA9hz/9CRygSBMyGfUTXPHWNgx1TSYnlHIjXo/Lem4owNpDZcqq7aNkS/3Rqw1q0cj+jzB7e/AENwVH5XmmeVK/HupskD2LQa5RHz60HewglbuNibxtnS0IHKy1LmctfgGK9TRivRauKdx8KBy1td4Zwssn7gRGPVGVAsnyjQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxVqL5a3UVmd3eD16K4e+TgFSTJiRU6clFYCP1of8NI=;
 b=HdqUVyvtbzKbBywfifbpdHmA+GDwhFb9B1ZzOiDVfR51oplTJ0FhIDrgxbtfdtiIfUezkCV7nv1ujG28ZexrHMG6qy81oqbiKvrm9TBayEKbWZRwuPDbKgIQkdHM59d3YBgu2y7He1G1JTTR7TYQMh5HNIawkMoHtfLN3/Uq4Db5nfg3lrxzYw+SStmGbZxV9+zJeHQIICLt3ylvJhPBY8VqGl8cWlcW0pYkBehZn//QGyHBXAGoZAYnL8GKsiXb2IkUOZvIfsQchwMTph0lsbPow12EE42JR7ZsNkDg17L47Rf0wtfakbdf9eevnu25Hojid1NoR+drY6wdneW2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxVqL5a3UVmd3eD16K4e+TgFSTJiRU6clFYCP1of8NI=;
 b=Yc3wJAPHHwlbFHAzIMm8zGfESR/SwiYm3HA21p7d8tzyshelk7D5La28c5XiqguwpCf/53G373H2qgOCfKeO4ZOWL5sGFnZGNhiiZg/4peV7bB6n2VOk2w2dYXDDecGRAj0CLI9fkwF3TCVDGvp4LMUM2iSfUaOyrzY6NIOpNto=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB4205.eurprd04.prod.outlook.com (2603:10a6:803:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 15:14:34 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 15:14:34 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Tom Rix <trix@redhat.com>, "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several
 globals to statics
Thread-Topic: [EXT] [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several
 globals to statics
Thread-Index: AQHYj6mjuRnEAzekOE6wUpPspghcC61v5Fnw
Date:   Tue, 5 Jul 2022 15:14:33 +0000
Message-ID: <PAXPR04MB918658D6AC3A0A341E4260FC88819@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220704132559.2859918-1-trix@redhat.com>
In-Reply-To: <20220704132559.2859918-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e0e53b6-a66b-4ec4-c0ec-08da5e99114e
x-ms-traffictypediagnostic: VI1PR04MB4205:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tz5WgyhwkhD+c8FnNsRrjfbv/NuJp6WIZOdHEGvgL1GE8uiCvzvuY7Xgpl/IkeQWF3jJJl3QI2x4NQ9DtvgJwR2DVxjwVVZ8m7aWeblMSgix7d8X8kGYzSueg7Mmd+di1Bt2K6fmNshbnjmnghCLXgloOOBcBiMmrwy7rXfVZkpsOhq8oj6BHu4UXscGEkgboecSbgm938R1jVO1F70E0HfLzEflMo6LemwaJ5Vu2pCD+svK+173ISVYVeMgB+LQKpa1KFBp/AKdDZ51R+ryezKqlRzVxh0j2pA7lt6xSBi8k49exvhZPUzivtLx5/8OXpwjicMA8E4UpVHC2r2pX7QdS6ODDy0kCMt6Fz+zT/VReLPgssKGKBJDgsRaE3nxhNUWWJEC+7T2pOphtoyrnkDqfUO/m3x9vOzwfkJb+iTOD2vaOFXjMwNBB8BkDs6yXa1VfZ1Y3USXHJnUFEjf3PZwkXA4tiDgREzk5LYxeqWEzwPGJndof/dO3yde2j3RBtrjf/jk9zuiN+VsZnQZC27A5sJsi6ZDW9KOgzL3XB3mHspqVjKa4am11jQYGZEDELhXo5MMSpAckDF/K7xSuo4s75NAJumAJ9MrLsUA63MyztkWOoh+nQig0rf4AxNFPhtwNHX+jKbKppMs1D2kapjSAfTVF40ZRSE75bMmPm4++SU3Lg3q8Prvt0ayRDdSssnHk4LC7OJm1j0KydplJcCqJF1/o0FkOxH8G7r7rtkImKX6tSrIYrluGRdhK9R/w7r+iti9SECU7soonld5+CWolf8oUoarTst+eOxoDV9E1fxZBxjTgAeghSSOiw5R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(2906002)(8936002)(83380400001)(52536014)(186003)(76116006)(66946007)(44832011)(64756008)(5660300002)(66556008)(66446008)(8676002)(66476007)(4326008)(33656002)(478600001)(55236004)(55016003)(71200400001)(26005)(316002)(7696005)(9686003)(6506007)(53546011)(38100700002)(38070700005)(86362001)(41300700001)(110136005)(54906003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Y07bZhrU7vY68lWy7zGfEyCchwH8JDsIjc/F1i3C/0okoTP5x3kbLL79r7q?=
 =?us-ascii?Q?/rqg7tVTt8oV2V1KNvwZdUll61ngTeaTdE/eB96ik5nR8O8LBT4/bwKqtd7y?=
 =?us-ascii?Q?+1j1eNLeMzsjdkKfHf4R7EdsVmHemqdfdV9z0vWFTIqgO+ho3t+Lu2OEE5Iw?=
 =?us-ascii?Q?BEWc7wHWbIDtCmTOlctD0Njzd9aK//5X1HOt1Q5/yCMF8/70Ky3e+tGVWTnp?=
 =?us-ascii?Q?2hnjGkeMEwKKusEiAVdgWPE9OzwFBlRfCLrPi5P9Md3GmsBsGrTbiA1clXPm?=
 =?us-ascii?Q?rtgRloZhlRh9nnioh6Kg+RsKXEALkee1zE7Qk4kzbHqmq06dqIn6MoLjKffO?=
 =?us-ascii?Q?6JsXH1sW966VRoMUQ3BdaiL5Q/z8DsZspDlJ/pcH4q879FiYqnKAYAbIjIHg?=
 =?us-ascii?Q?pA2jg5TO3xlqvkAxCaHXD1ilJwpiHkCaBN5ZcdfRWnFfm3rfoqp/JqW9kv21?=
 =?us-ascii?Q?CjND9GyRMSrUeA1G69Zx09/WJA46RGt7KbrJ+JI6PhGnOHSJ59ED0Jlt9b93?=
 =?us-ascii?Q?A7yaTXPUfyN7HJiyMXjo+lRK9ajawGhZbOrvTfVU3VAn/SvEpRK8DbR071Us?=
 =?us-ascii?Q?D5NZjeQhKSvO5BlboaLo1Djh+lVcc1hdzNf/4uioiaq1pg60ge081pHhK+Yy?=
 =?us-ascii?Q?p62W9TQbtowdEJ41nkzfFV/IbVcu8Iy5ROJDwyifmOQngc7nJDyfZXc40LXx?=
 =?us-ascii?Q?bblUNk5f4YLq8fLsXbrmm538j2qbHuExRjhhVa2K1srPrAH5ykkc2pGns6v7?=
 =?us-ascii?Q?bC88+FBSBJENvzdsefjlCbBqSKMdFgEQcAw8x0seCnAGXfrmsqNZIeiV5UgS?=
 =?us-ascii?Q?WDzXeuaJPejCWuvDe5ZomY02dUeskZxQI9U8AB+kpa8zfRT5Pxxn8LZ8EgmO?=
 =?us-ascii?Q?VVFE9AggosrfKMYfy2mZB6AX4ZqW6Nh5YUuTpJeTr6vpi+OKGVDixzbHvPLW?=
 =?us-ascii?Q?gEb95gtT0yMWSTzhOTMPYcEaQGxO8JX+SRwUCz9tVsQ5EO5nQsXuCH0tS1lw?=
 =?us-ascii?Q?xuIlgTEhCeUb7L/daxgW+1/lrfQpcBqLvDBcOMZW6r/IDO2aE7C5L1YfX0C2?=
 =?us-ascii?Q?n9yQfNr9cUKlcchIH2JT472quuw9mPQYtUdXGXAD+gu8i0kcgG2KF7OVSVKC?=
 =?us-ascii?Q?HHf02T3Vk0jLsxOjw9TIzRhR/HWIIPePh7tKIbhpdptkA1fIKQPjXMV8Q5jx?=
 =?us-ascii?Q?D1fHMhpduPlzJkD/+aEpHOVvgNG67xzAvbTY+yzISAv0r7wOrvU9iqZEBdrL?=
 =?us-ascii?Q?vkaoHj5N+a7YWMg95RMdBEhoxy6rhkSr4wtwVCXaciJ5hGqTFuIMZiDS78Qs?=
 =?us-ascii?Q?0jXHwfqBi14cyHY4+792Qj4zAZ1Lc2Ugtoo1O3EQnJzbleRxJjdWZ1yNDeZN?=
 =?us-ascii?Q?FdNHAySHSvbq3Ts9lNjgbPyira0HCsiZ0N8egkmpNaaDj67RLqcwCSUGtyVX?=
 =?us-ascii?Q?poIBrCw9d8QyLeI3ZHAYC7y8n0Ulg7j/K4ZIyVbW+bno0s7+Plojpdh7yv2l?=
 =?us-ascii?Q?9/h/BqXHmqbcRG+Uz6MYQyKLVVOS7kS43v2n/VOQk2oOfp2AAowGLMYb2DWk?=
 =?us-ascii?Q?mlK/kh5X2YAgb5qNfgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e53b6-a66b-4ec4-c0ec-08da5e99114e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 15:14:33.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GZHyztKxvj48Jkc9cCio0nZeuSkbyq/ou66Vh9dOEkEtd5DN+JGfgxiEi+qTQBh0Ql9YyyRPOjmgf6Xp+ZAlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4205
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
> From: Tom Rix <trix@redhat.com>
> Sent: Monday, July 4, 2022 8:26 AM
> To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; jdmason@kudzu.us; Frank Li <frank.li@nxp.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [EXT] [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several glo=
bals
> to statics
>=20
> Caution: EXT Email
>=20
> sparse reports
> drivers/pci/endpoint/functions/pci-epf-vntb.c:956:10: warning: symbol
> 'pci_space' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: symbol
> 'pci_read' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: symbol
> 'pci_write' was not declared. Should it be static?
> drivers/pci/endpoint/functions/pci-epf-vntb.c:989:16: warning: symbol
> 'vpci_ops' was not declared. Should it be static?
>=20
> These functions and variables are only used in pci-epf-vntb.c, so their s=
torage
> class specifiers should be static.
>=20
> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and E=
P
> connection")
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2,3 : Change commit prefix
>=20
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..6f0775b1fec3 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -953,7 +953,7 @@ static struct config_group *epf_ntb_add_cfs(struct
> pci_epf *epf,
>=20
>  #define VPCI_BUS_NUM 0x10
>=20
> -uint32_t pci_space[] =3D {
> +static uint32_t pci_space[] =3D {
>         (VNTB_VID | (VNTB_PID << 16)),  //DeviceID, Vendor ID
>         0,              // status, Command
>         0xffffffff,     // Class code, subclass, prog if, revision id
> @@ -972,7 +972,7 @@ uint32_t pci_space[] =3D {
>         0,              //Max Lat, Min Gnt, interrupt pin, interrupt line
>  };
>=20
> -int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int siz=
e, u32
> *val)
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, =
int
> size, u32 *val)
>  {
>         if (devfn =3D=3D 0) {
>                 memcpy(val, ((uint8_t *)pci_space) + where, size);
> @@ -981,12 +981,12 @@ int pci_read(struct pci_bus *bus, unsigned int
> devfn, int where, int size, u32 *
>         return -1;
>  }
>=20
> -int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int si=
ze, u32
> val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,=
 int
> size, u32 val)
>  {
>         return 0;
>  }
>=20
> -struct pci_ops vpci_ops =3D {
> +static struct pci_ops vpci_ops =3D {
>         .read =3D pci_read,
>         .write =3D pci_write,
>  };
> --
> 2.27.0

