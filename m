Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249C69E430
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBUQGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBUQGe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 11:06:34 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC12A9BA
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 08:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/ei1PSOghG7ogJ0NUkQoa+rzOZmd5+v3nUgYaxllLM9NMTedW6HGcfngIXMRC37NJltm5rjPolyGSYSvH4QNPqDLaEBEWhTGQkm7TjauNBX56rlQxEtmOzDjZsGYEj5NA6E8sYbk2qBluyAJ8n6a8eQ//Hl5w4T5VC03uu8U2J5TnOzL8yzEUXomEJ9K9j70JEs/O4mrVYjscda2deV/AXTI9oz1ay9uX36zHhgYrPwULHGtWettXsRrtnRuZaOoSyNJs3jFgVF1c6npu8H/qO/FgJTAXdEgzizLon+q8+wS5gMIpHKIB8pc/6Z48hBd6Q6A9CrsS2yrontChQWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APssXXqPn4FADDIXJHW8YrfhNrzbKIJQbs7batD51nI=;
 b=fxsQdqG17uIZwJ+IBxnA3EOdVecO2NWzG79SGnRHYkBlDVtOxwAWhblfnWpfGq0FZShNztkxmf+rswfqVKnX7DgmGSmckLAMfCx89Lk5hARnhakBP30MJS0a9udoepeFEXzAkH3FEMia6rdC7zzJI3SvMhAgBrZNutvxwWzuY6ebTSM9U7Xmk1ZphRE0C+zX5b0FfnpY0NwF1O550xbHtE3tXkwsI+fWkLBq8YjzU5DuaiMh+OqY6KZ4Zy6OMLK5cvMUqMI9rJo1FHJAUXmR8UiFT93qCxbpQTWYiO3Yby+8r6ZtlmPSsGWC/jBRYQV3y6c4moILQuQrYBaxMcj3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APssXXqPn4FADDIXJHW8YrfhNrzbKIJQbs7batD51nI=;
 b=YECiuREPISc4ez0fp9yOuoqTTfiZ3r8+fIPxKmj0VQ9Av2h3NZTHWwbfkxTk7GBULfxtBiciygYTsXrfhNYBPJNADvMw8tIRIk/KiJOuYmlzjOIJ+0cBn1d5WRe/6rm1Z6skixyXPD+5dgRlPGPij4CkbV+6mRcam+BLsC7K6Qc=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 16:06:27 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::4bcb:22f3:7a9e:4036]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::4bcb:22f3:7a9e:4036%12]) with mapi id 15.20.6111.021; Tue, 21 Feb
 2023 16:06:27 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: Fix dma_chan
 direction
Thread-Topic: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Thread-Index: AQHZRdyvoMw4ASfB0kuIB+eQzGb6g67ZhOBw
Date:   Tue, 21 Feb 2023 16:06:27 +0000
Message-ID: <HE1PR0401MB2331F8A482E2D3D9C782F2CB88A59@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230221100949.3530608-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8118:EE_
x-ms-office365-filtering-correlation-id: 085f6243-8372-4fc4-c6dc-08db14259688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvEjLvPc+HQl0bbywrI4DLgpMe/qWdPlcxdA8yqFCB+cA/d1CAsnzaPQUBn4AP6NJrvn7/bJoqEY51iETtjzJbfIMcJdjFoPwmPTtYi4bbWP5pysMVgWifXvxkb+GsrfloUsZKR3ratyi3J6mWdZEFpIUF/2xsyUh4A7WYeX+hKki+tcIpy2iz1IguWAnwpLqif0UXA30jk+n7Jjnyd0LpVXWMCeq0G57PXUbF22nrsD+q5eIGhiEdXPPV2El3wK61F+OWRTixsjU/u9aq0YzesvsRtrxObW+dk9dFPqkoP8skM9KQN/kQuRjuPuQ08xG4ItcMK9MBA470NywVMiHgYnyEVnIq4RrXoYJ60zmoPcD0FQWZgxIA7Cvp61UbzzlKzMrowW4T/xHAdQvxhvZs/tFWEv0XU6Ydhk1b+U87Ssg4pxvl1iEFE6Lb23RsFKTMD+LhqoS7r9msCFvT0h8/iTFIEmBE07FnQRylqzzwvSTZ+a91XpT6uf+E6hs2es9vSpBoWyn4ZaasZMfsS6o81+2b+QRir3hcQZT+zDuwEZXxwJ/4fG3PmgdMsAEf9C/bbnaepKuQJdb1TSi+1bDYA6qt4rPwfIvMXd/Q626GcoOtevQ3G+cZTH9bhR0RySHU3lkCaF3KreHgU3ny9DKedaB0+Oszpd2NlKLv1c194YnzUgbaYVXztv5jiLXynxQp2WqfqCOMppKkXGRb88VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199018)(38100700002)(122000001)(33656002)(38070700005)(86362001)(2906002)(8936002)(52536014)(44832011)(4744005)(41300700001)(5660300002)(55016003)(186003)(55236004)(9686003)(26005)(6506007)(316002)(4326008)(71200400001)(7696005)(66476007)(66556008)(76116006)(66946007)(64756008)(8676002)(110136005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DAk91QMxrTSwPgzOPqFB15CJ50+YsnWswjqFl4U2eYAYaXHQ4mt66hw61R+l?=
 =?us-ascii?Q?Tgnh0ZGoX3Y61fhcNSSe/qt/2Q9SQyUJY+WwbBAz+nnFGx1RWDQLMZJykJTe?=
 =?us-ascii?Q?T0LoEJYrYn08DPihTflzX69oeNDCiNQpqhYxDAi4Wa9hSzAC/E2G8iKeGJ2k?=
 =?us-ascii?Q?PyQCf9YlQGDrlTF0BzfKiqhN6W9RngHJsYTrWHpcA+Ad+JKuhNn0WxRC4GE8?=
 =?us-ascii?Q?ttpfgdi0BPM3CDaISImyzUktF1vd/1iYcQipIRvVt5X9spxxWYrbCFCV4BWB?=
 =?us-ascii?Q?Bk4kttswqBB5GunJWi8BmaY+gnK9hxithmaL4KN/DYKg+OjMFKfdugcEPySO?=
 =?us-ascii?Q?086CYd7E5RKqxM0+jq0emAzSo9yAYTJqCC+tu1sGygKxprloiqli/+kwcROB?=
 =?us-ascii?Q?AYrku71E56PnZyLO3kjq/vPi7/1j80Pq2UmlGIn/u76Qlzd3v5SeiHg2owzZ?=
 =?us-ascii?Q?LtUmP637Dp2QWStVy1e0UDQuLy81kBkjjvLDcQ0+EDwOffLa1C867Mw+bRO9?=
 =?us-ascii?Q?/dlnAEr6Pvfi3t3wXwi8kbi4wzf+eW1YO4F3Qjjg5gcOTN7bstpOICRnxz1O?=
 =?us-ascii?Q?ydtAT/TOQvKrc193809m+C22+FCyVpxXrfyASSMcNqKDczSqiXQ4P440zack?=
 =?us-ascii?Q?F6szlPkrX8+Tv6ZmVjotYb5kFRimHWH94w3HFCdMMC+UhssbtbofqdByjBVZ?=
 =?us-ascii?Q?1OlOsOw2q3NwvF6VxF3nBRUJgiqFyqGSRjz8wfydUUgW6HdhzXruqXtxM3lG?=
 =?us-ascii?Q?/8mh6BV2IlgYtaSIZ1Qe2OVgE4MzqzWBhGo8SAI0NmAN16QOTRiDQBzxRh8+?=
 =?us-ascii?Q?3G0uH20Hi7319GBSYGW6yZknZQC0jb5XCp7+ssnkRFBSmvEvfx8zEjJfdbnX?=
 =?us-ascii?Q?LgB+QyhB/FQLjbT/2GJHg3VGa6v0PcpIgPLTHT6B7/aCKA2Lp512ATR3Y3cH?=
 =?us-ascii?Q?cToon8V9hmRF1RN8Sarh2wnZeFAdWPT9scP3InWYGolgf7uCjX1uUzeCJD9M?=
 =?us-ascii?Q?twoRYMGEaGz31aQB6QghumDNwS9E8sdo7gCafiU9k5gQ0B3w6e3UcQprauxN?=
 =?us-ascii?Q?BOcZgzcgjSUh9uoPD3LSgpSGI+nmXKsbRdEDw+ujYOipHq++MRfWHr6ujhVb?=
 =?us-ascii?Q?sLTzcSgW3R7sUuuC7zCmJmhG3E08XKcYlQQ8VqyJOqqJNr7y3lGAq8luBwE0?=
 =?us-ascii?Q?mGMmPoTWRqdU5N+rb36TQcgcRC9dL5vwHkbAtbEZD9JAwwWY8gO5KZCa9qq3?=
 =?us-ascii?Q?Kw6F1X4yiXhQmTBDCIujqbj47pC43jRwKUyCGHHWMLlYx/SABwx3OdUdjvdF?=
 =?us-ascii?Q?9G3BbRbZDFGDjI7O8GYIZ1WMthEURi+CE/MZ00+uQ73GbCYuD5e5me/AMdzi?=
 =?us-ascii?Q?ZQKL5gEj9GGBHa/Hpdiqic7D0Ub0uWV2nizUha2hWAmXZcB9Q2soheFvreLO?=
 =?us-ascii?Q?yYcWdKGvsp3Jt1q0UwWiT8nFPQWPKNsji4iZr16YO4Eho+pwPtwtVPTzaORe?=
 =?us-ascii?Q?qm6TzKa06WVU6SbycKjm061Vy0BLbFwP7xtsiY622rsDmdG/r10gSi7vw98u?=
 =?us-ascii?Q?8ftT8HrXJVmyGUyLZck=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f6243-8372-4fc4-c6dc-08db14259688
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 16:06:27.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVXOxOwYazAzs9dCFHrGthq1Z9RBrMHcO++A0z5m3YXninIi7TR9nGMgYm8Dnt74VvQewVjB1glo1AsQQrBkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 55283d2379a6..3a720ed4655e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -113,7 +113,7 @@ static int pci_epf_test_data_transfer(struct
> pci_epf_test *epf_test,
>                                       enum dma_transfer_direction dir)
>  {
>         struct dma_chan *chan =3D (dir =3D=3D DMA_DEV_TO_MEM) ?

Can you use (dir =3D=3D DMA_MEM_TO_DEV)? match following check
dma_addr_t dma_local =3D (dir =3D=3D DMA_MEM_TO_DEV) ?

Frank Li

> -                                epf_test->dma_chan_tx : epf_test->dma_ch=
an_rx;
> +                                epf_test->dma_chan_rx : epf_test->dma_ch=
an_tx;
>         dma_addr_t dma_local =3D (dir =3D=3D DMA_MEM_TO_DEV) ? dma_src :
> dma_dst;
>         enum dma_ctrl_flags flags =3D DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>         struct pci_epf *epf =3D epf_test->epf;
> --
> 2.25.1

