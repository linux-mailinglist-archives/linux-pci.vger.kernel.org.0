Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046816FC857
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEIN7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjEIN7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 09:59:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209322718;
        Tue,  9 May 2023 06:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY0xdo5MRTgrDHqRyQoiRSnI7ve1Exur6qMIkITW9jCpi77EsRBPb5VNu8G+bTFUeaxFyVGIwE+1cz53EUgP/F+yhscZWB5/oZLzD+n7jqaKX+hGJfz2t06I/PIoArSb7t9ZgKMWJ1GJBzaPXMyA2ypPmyOIrI8WZtaSepGHY2AyOqxK+LJoMw2wfXKo37RIDAbqLAVAOmtrLgYiXSaYHoqeJrm7qeIHZEEA3GR2wlryoiDHGeYJc/shCr187JWj+zi8//UeoiwyFGvKiv+FkGOtD5sIxvvfB+BbmIRLu/9G5Vim+Z01znA6oDNCLy6mUd1uFiTQSRVznKAWiAXTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqMVS7h86MQP1r155eQEUIHsTweK9fpitw/W/D3QU8E=;
 b=PZrUzHdJFCi+9Sv8V58FXQbVkT07BrtkbzfNNJmVdniKOVrn4cU9nfP2KTwnqW/OCwbpXApSpJa3h0phMOYHffr3ofd3i9LAS4gzcn9DPGPw8y/7moWT18xMkbOPtFUCoUtlZuhjbNK9zixKewpiywUhf42YuXGYaCNqB2oYxKTFJl+vSithCJv+jy5rFg050Br4fNqDOn+Y6AxTMO8KHxiEuA4BCttPN9f/OzXBasiBU/BHeObjPhSZSAw0PsLo72Z46U9CxX0TGMqeD7F3gMyHqjZDaV5XXl1IwE5q+dzjMDUC7W4A2HrFS+kqxvC2MaPZ22z1AvY3pTp0vpDXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqMVS7h86MQP1r155eQEUIHsTweK9fpitw/W/D3QU8E=;
 b=XBW9g4BhUaKj0wjutI1GpnN2FlRpxR/Q3GhTUNDStyDGK0rLVeB3ybjvFzsgOaZQRFKc92DMl9MqejkbLeaDBxjPSqklKxy+Or1Wyv9a/SmTm6qjH93mdGS4vFM2PrUbtB1l9sg6QG+qzzii2+1irVzA9oL/bB0GjD0Qj0covUY=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:59:30 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:59:30 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [EXT] [PATCH v15 08/22] PCI: designware-ep: Add INTx IRQs support
Thread-Topic: [EXT] [PATCH v15 08/22] PCI: designware-ep: Add INTx IRQs
 support
Thread-Index: AQHZgnOy+z03BkvoTkqhqpIOb5/MXq9R9wfw
Date:   Tue, 9 May 2023 13:59:30 +0000
Message-ID: <AM6PR04MB4838CA729D82DBB18852F9CB88769@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230509124156.150200-1-yoshihiro.shimoda.uh@renesas.com>
 <20230509124156.150200-9-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230509124156.150200-9-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DU2PR04MB8629:EE_
x-ms-office365-filtering-correlation-id: 6b227c40-54af-4f2a-101f-08db50959c0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3CTWVk4L6/gdbaat9Uif1TAGKhF+lPeKjw973Opvl7B4ehxc8RLK3g74R4AxJ4ZNdCE/JmWHbPL9RS1N+FJ++xKY9UV84vNtBW8D7HJAyw7xkwHyoF9yo/uYHd4wQVlwMrqoJfksn0bf3VOcdy4fPeyf0sUWY3nD9UBRzjs1/BNizX8y51TtTAvYvlrPmOntlMERJTPkyvRg1ErD7BKpvqUEqkN/Pj00aUOE1uyRxJOwC4/RhLJBOkBretzHIvMH3j+1+2q9SeYSrgRH/pDsZRmPM7wz1gIZ9WZL29QQ3Lu0/U34JKh7J5atJqp834soodU+sH8KRixvfQt8542NLwdGmV2KGAMfTqBvgrM62qfZcHqsuGHvwv7xC1LPvvO30wjNtbfCH2tDItE9Gg8QWOb8LtPZzwltFhMVu163zC6nzaFd9coaQxOA/8Bm/XrMY3bh9Nz2XkBDKhiEx/O1QrTWNJVlclKK/raLg+EupcHo22+lw/IAyusLEmEqD7HVIA+j+xlU8SrJhqHnaSbbRKuWAjKEH5F4MguSBm5Dc8XkQWKsExCdaOCatxWwzKbUkpvZofWOnWR1CVhR5kdhMCTmRqaOuRCTPki1VzWcBoGbfHJU3pyOTUD/pbDhc2TU3WvV8L0xda1XcJ7X/YIqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(7696005)(83380400001)(316002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(4326008)(478600001)(71200400001)(6506007)(26005)(54906003)(110136005)(186003)(55236004)(9686003)(2906002)(86362001)(33656002)(55016003)(41300700001)(5660300002)(52536014)(921005)(4744005)(8936002)(38100700002)(7416002)(8676002)(122000001)(44832011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+7UNiHRJApeg+Ha7VgGUUBR9ysMB7Ipr4zoG6k86FfdkJmiqrKwdspwm+aj?=
 =?us-ascii?Q?xcIkti5YSDcFOu4W0+ZgjTH66GOA59UZwK27sOTfBzEYBtLjTEjy0/RUyEUF?=
 =?us-ascii?Q?D/dppPCJ4+3kh0yc2cOMDn1MS7N9aGNHyr/dwJQ/Y9dK7G6MT6dRgkob7OJQ?=
 =?us-ascii?Q?1HxBe+6hcjHQM2YFmXQqWlD8Jct87O+VmVmgE4gEmYsPHvsQ1KnK8IR3A7+R?=
 =?us-ascii?Q?cAyKWuM5dJBFmrNKMPBmb5ficCW8WhrgtHZkWGri6mYtz7N8XUquZ56avrd1?=
 =?us-ascii?Q?LQTkkru4VaicOZy3k8YhSj/hnA08qpiVkYRaK4B1+FsRUti9vWrYUNO/NXzK?=
 =?us-ascii?Q?pFGn6ikxOjuOn0dNYmTAjbmeSOqquGxQAvvYTxiZTQqSr3eVgLbkX1CU2aes?=
 =?us-ascii?Q?8af1xT1KV1LETxZyWzcshJ5YRmCAI8J83DgwK/DAaPi5WcuVGZoa1McCWzP6?=
 =?us-ascii?Q?C8GfG43gwPJSXdlHq3nBRrJMVZrvP2O2fgqLSw8wT27rEFBGqD1KaC+r/w/x?=
 =?us-ascii?Q?KdB8AKlkAbN5QSkIT2O23AuVqaTG7xFAvC3GhkhgCARUK639T0+UxYglYcXC?=
 =?us-ascii?Q?/0pMUnL46CJjrLJ72ZEyQ5kywaIRlmSFJYwhZrc4lyiIUpT3j4fKGRjGrOEk?=
 =?us-ascii?Q?fijiu5xSwtlqDo/DE7byujN6FANEYoTh/IZzHZGfVSKwb/ePtLE65M/7RRBV?=
 =?us-ascii?Q?bIWSbXe/0MoZK2LIQzF6Mo+OgnqOI9ODc82a6FrULPEkN39ou0i0xH3srPcE?=
 =?us-ascii?Q?c9kmtcZ4TZnZrtUpcS0qrtz/zXAoJ3Fd+v/pffxzE/Jxl1/0t6zdNPvlbwAt?=
 =?us-ascii?Q?YZiefN0goiKlBbkiVYEmVhPmcKzLlC4e0EmtgYGB2DZsr8bYInbt4jC08qcZ?=
 =?us-ascii?Q?nPvy5Q+KiNUjCn71ZlM4t35dDJOQ4VrxF877f/m8ut163bMcH6O7pb+x8y2l?=
 =?us-ascii?Q?BuBUxWi8ZwWHQF0syfY8Pt9gHwC9kdVMdYa6cr9S3Ikap8uASdgVTK24zgck?=
 =?us-ascii?Q?CnBlZmLg3INmQwnKOPTJhcr7OefyHde3N481chxd24b5EIUdYy/c8sTW2v54?=
 =?us-ascii?Q?x0Qh1iarJVhw9DgNsVLUjzcSdfqASl3GaH9KxCN+WmlM96tfr68wCJUptLj1?=
 =?us-ascii?Q?6AuV3sEeBPy+6dgOWiGJKdLf/Aype74y0y63qdGe3TC7AnYQjLqEY5rN4ZSK?=
 =?us-ascii?Q?1EhOl12KHn2Lg+N0OHotAayWH+jSrwRuKfWIKCQPPwkwZRUSQut2a0hmMjDq?=
 =?us-ascii?Q?1cLnXbsxYQibZDgDMtP4J3uHSVS45UKgqV1wHOASkjRaXr3Nz/KqeBi74XmX?=
 =?us-ascii?Q?GMPgC1UnuECE87GgTRc4y91qSGE9eWmcPz8DDgnC8gjHwiEF+TYtDi8b20L+?=
 =?us-ascii?Q?5XWsNoo/mqjwhMm5IaoBK1SmgHzUlByTCN1HcSSslPMjZ4pgpL/Vtl4OvRx0?=
 =?us-ascii?Q?6FIGOSx3ICtHJfntbkIZ2RORyAXQVCE5qADrxwwCt+qAMuvgQTR+TYRB270X?=
 =?us-ascii?Q?khU1vKkbaUQCr0cnAlECbSi0m8Nsnlx3ZODUhy3e59yR9zL0r+Vi/qfR7Cq+?=
 =?us-ascii?Q?mcuK08F6chgG3RXqavY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b227c40-54af-4f2a-101f-08db50959c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:59:30.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kz/Y6aokjf4bXqQw6cXlrqvtAi4GE9nax7AW6JTH1ySj1Cqtq2LoGvzI6jYP7hgKpPaLbCBhStQ1R1MqsxFNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -       return -EINVAL;
> +       ret =3D dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA,
> +                                 PCI_MSG_ROUTING_LOCAL);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The documents of PCIe and the controller don't mention how lon=
g
> +        * the INTx should be asserted. If 10 usec, sometimes it failed.
> +        * So, asserted for 50 usec.
> +        */
> +       usleep_range(50, 100);

[Frank Li] At least, comments should be updated. It should be level irq.=20
Here is edge trigger because frame still not supported yet.  Will improve
Later or some things. Otherwise comments is misleading.

> +
> +       return dw_pcie_ep_send_msg(ep, func_no,
> PCI_CODE_DEASSERT_INTA,
> +                                  PCI_MSG_ROUTING_LOCAL);
>  }

