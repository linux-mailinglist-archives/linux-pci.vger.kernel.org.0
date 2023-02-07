Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984E068DD29
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBGPhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 10:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjBGPhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 10:37:21 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB81554C;
        Tue,  7 Feb 2023 07:37:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqjfhbZLCgNcMtagu/58wcb1WPktgvmzN9QG0kiXBGGIN71mMJzhkrz+y3nIAaTHknrjG+HI58eQeXiurii6n9PJ1aZ+sKkOju7YxqoRgOMu/jW/FSIL37eg9MxzfIGYegl4v0sJUWFZLpZaQ245M2lu5JTFkVbPwd+s36r/jWYMc4RSQpIhkKKtRwTeHxiTgu11520CYfGs2Vdp5oiMqZhrhkzlN2pfEFNFWSWFsk5fUvicmKa56mNRCi8MzY/EpCLXIEYVGuMp5KzIi4mpg43t0gc1tP+p4PbUPX4YAhH1hzrNwGQleheNnO87+rqOcN4LbYn9JMFiHfHRK32xIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJc/+FRes2TkpbsGKm92dHKO/t2T/nnX3WxNF+5FdA=;
 b=TBVdSv3D3+HHy4N4PSzfaxaID4yKXoJ3gwdhse9oQ9lUem7rXYb4kFub/6MxVfiKqvmQCUu5aMZoGv6wIR+16W84BBc7ufcThf0xUgY65HxXgy79EoNJ5WK9c0VOV5hU0ynSlYxqpXmat9EJ7fhgZ4dZ94ltY5CimkGfXryTS28dyUYpACt4OYo1OIijR/frhDCjR8xT2ZbumJx0lDOzPPyhBXxr4dAKhJWgPhONO/OIlgfsOu3ty0jzSYP4+JItPuhyMY4MUZKNKbbY+rXpCDis30bowMCfXkq6QJX55hTEXD8qFCzAApe4SNXZQrXNxACJ2/en7Yx4KfrGQOYRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VJc/+FRes2TkpbsGKm92dHKO/t2T/nnX3WxNF+5FdA=;
 b=EMnvG9l8xXJc530FSw4EPrQ/whFP+H8UkRaopgAktCHEFsuOTPg+UWjvSIYu85sronTl/P5QXCBa3B7ld/wHzi0c8DI351UUaqFjbmLX3JREp6QEmrpKZ34ntreAykpQuhNmSxAWGF6v+z9C8uNWmXC86VntcswV33zOjeZwC3c=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 15:37:16 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 15:37:16 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Thread-Topic: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Thread-Index: AQHZN7liQTou1LlKIkegIEQy1N8nRq69xHgwgAWRngCAAEuvAA==
Date:   Tue, 7 Feb 2023 15:37:16 +0000
Message-ID: <HE1PR0401MB2331D1335BFACBD23B7676EF88DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
 <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
In-Reply-To: <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8114:EE_
x-ms-office365-filtering-correlation-id: 0d0aa9d2-5b40-44a3-a165-08db092130ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUJEWEoLudlOF2pD+Y85RPnMPOVCkb5tOqxQ1XLvyxdAM66o1if0AtaFPSLkCcBTmFySbOHRXSZcC+h+flws5aq90OCR21E844wLcs69Pd4WF6T05bmf7dJteLswmDnZ7Sp0htctSTjcm3WMlVnwL/VzpuWCbHbFfSsdYNPgK4Y4e4SQgYE5YPtztUwa8lciTiskopxZtqzOH5Fy6SJp2pNGMJIQjposp04SoJqdtGSo6RQCTeGY82AnwYXfgLEVQnkgjeSXBvE6JHH4w0+FnhQEEyQl6Xz5HZENkJi49KJ+7wPUF4L1aPL+sONYpQl2TUHmL+Gn693er8ydZfHUZgsIIwGs2dag/yGh4HF7EhJeuOPcgvsvD2z8RMtH/mVgHodIB1jLr5IPZXAndC23WF5QaYt/ncLqLTMmwtHIQFIQD2F9zu5IiGhjUbeRYigmkbEeOY8IbkkdfUPZECnLgCsaeNXc0Ge6xYPJK58LEKSH/qKM+JUjfllbs696jRoKFlZEK1shgxPnsquQlUUTBwV/JiB1imEZ4c1fxxwuyRbThrBaYmcm9q2KApCbuvqEtmKQ3hP4mZ4zJjN4lehuPkStRi+nEmDc+SxNgmDQX5oYTWvYvrg4FSCmrcRip9gFtkbDbXg3hohSVUSFzKBSV4ZRKBLxg6mWzo88UFJBSzt9b/CMLhWksZGmfgAVxg++JVLy1akWy8dkuH9scd0r4+xUOKNOxFDwiVtAcTOP/wEL7bf7XXPE1lrV6RHdpd1yg8b0JrdjBLa1+RAvMDSwmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(83380400001)(71200400001)(33656002)(55016003)(86362001)(66946007)(66446008)(122000001)(6916009)(4326008)(76116006)(66476007)(66556008)(8676002)(38100700002)(64756008)(38070700005)(6506007)(966005)(55236004)(186003)(54906003)(7696005)(9686003)(7416002)(8936002)(5660300002)(44832011)(316002)(52536014)(478600001)(4744005)(26005)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ql1d4lFaN/36rYghKnfO49gceJxAW4t9VrxISGv/ikCdLt1N5/peS43LzK?=
 =?iso-8859-2?Q?Nb/on9YdlkPzVS+Hl4WbNwTyV4We1O16No/lHHlZUi+vWYCWHz3NItkihj?=
 =?iso-8859-2?Q?8R56/FlBGt+TqfIx9EpvGYS+I+Ebr+tDAATFU7rB0+OXwmR97m0I0kezrd?=
 =?iso-8859-2?Q?y+B4RhkcbHWt4tNg8tStyVqEnP9PEZzRNAYX0465KFvFJCmT1pJlQ/mCA8?=
 =?iso-8859-2?Q?tMNiwqQAlXq9svJV0tnmMck2JUrC9gU2wPXTCdGVcNYpJ7cIMdLOszHhP/?=
 =?iso-8859-2?Q?ou+O98FVzx3n3G0OabLDZMgUuWtwKG/5CM6tv5P4J0b/2gOEe+wZZg120u?=
 =?iso-8859-2?Q?lW+U/pQFUS9mOl+/Bm8J4KnW2IyYo41IDWRoxis2Pvi23Z43xq0QsuRuO/?=
 =?iso-8859-2?Q?z1TEDBHXcg3+DTwOL5p33dmbo0vQH+4k1rpg1eZSU9SRziJoq8fRY89jKe?=
 =?iso-8859-2?Q?gCSmyI8fAbU9cte2sO4EVyd9k9mrGSUnaIZXKrpBnvEQnqrShNmIzDCv/R?=
 =?iso-8859-2?Q?EJHUYv5IUyYU6NaGvKmQZOTTzrMZc2e5Vum3rS82wc6MB4DOp2/CQ7zf/1?=
 =?iso-8859-2?Q?ZWQaR+Vwk++EgoUD2rk6TUHXeFNhfVHAi6FU4kBA43UKuHHCAc65MW0WPE?=
 =?iso-8859-2?Q?bLJH5OcMKn/ob8K5If7vB1ZZKq4HuSb2CYNlKl17fCEiD8tkJuOgoL4Jy3?=
 =?iso-8859-2?Q?A05wAHUEx3bRmNado/eau235cYmFbPLDeT53Z/K4NNKVmWFuYQFwM+H104?=
 =?iso-8859-2?Q?F5zj67OTGLckm+tF+b50DJbOuT49pLbXi4VmHk4Gr/udXoWrmuEApr0+eN?=
 =?iso-8859-2?Q?w58no1MPWcJmeeIBytJDetMaL02MTnnRlJS1PNBr77HLu4rQ5t7V0IFvzX?=
 =?iso-8859-2?Q?TE513mFWXcuxCB1k+ZRCDHHuOcKhvcqIQK1dZ+SV7oh5xctDIJXwZDpVQu?=
 =?iso-8859-2?Q?UuvYwJOSFXgW30aJQtsVUy73zkJfD0+G3MrbM8zp/KKJMcAJSCktnPCEPt?=
 =?iso-8859-2?Q?ZcDEww23P1ulT7RWXtOM0wbwgBGuJe2fqFQsQtRqezwxbkd1PD+pFI0iCm?=
 =?iso-8859-2?Q?YPgrxZCQS5YcN9aFiTpn0EVjGqArL0Ty7NoTDUU5quWxNCN9g4GH5E6zSG?=
 =?iso-8859-2?Q?YrkxTkjOC8GgNiVOoZu8YHy9UFeFlcFj/Hs49IUalWjYP8tUR7ytgqxMjP?=
 =?iso-8859-2?Q?X+LY7+PDOqK3tFzkI7foDMrje6cfEeZc3XeUtd9GrsEqJYd2wVuW1StDVU?=
 =?iso-8859-2?Q?ouGV/r6c4CgE5NIouuHdPKUlI6lyY08xTSa8GIpdfqugPlFUScm8WmFoEz?=
 =?iso-8859-2?Q?JJTOdZCcXfpdMvIVw3WYcLdoaKnXE+2q8PdxVycf6RN29KcMhO/ZQ8EjlU?=
 =?iso-8859-2?Q?OeCoBto1n3qIxRzyOevVZ4sXyEHbtBdounBhrse1EumU7lRLuJw6u9iqtq?=
 =?iso-8859-2?Q?zw9JQw+I3PCUoBD4YTbfpFXIfEkzu3YHrXrMpXp5a3Atml6mREhcNcFqx4?=
 =?iso-8859-2?Q?b0VowVthx/w99tpCwZOHTy0qMzIhnMxB9BNMquTD9Fp2fPkDz6xb1T7BAP?=
 =?iso-8859-2?Q?44x/ce/QkW3U0ghUS2I2ShVBH9G0YPWQC0dix+3lc4HRo8I5WTLuqTz55T?=
 =?iso-8859-2?Q?UOKxtQvZK2CIY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0aa9d2-5b40-44a3-a165-08db092130ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 15:37:16.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mM94PghNUlpOtl/LWMIvuiXv9voSlOw118L5gDNNNc6sWmWdk+5BT2cz9RQwniUkIZm7DgGvjHaLA0xWbPyi0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > but it may need update host side pci virtio driver.
> Thanks, is it possible to use  MSI-X as well? The virtio spec
> indicates to use legacy irq or
> MSI-X only.

I supposed yes. It is depend MSI controller type in EP side.=20
But not like standard PCI MSI-X, it is platform MSI-X irq.=20

If use GIC-its, it should support MSI-X.

Thomas Gleixner is working on pre-device msi irq domain.=20
https://lore.kernel.org/all/20221121135653.208611233@linutronix.de

I hope Thomas can finish their work soon.=20
so I can continue my patch upstream work.
https://lore.kernel.org/imx/87wn7evql7.ffs@tglx/T/#u

> >
> Best,
> Shunsuke.
