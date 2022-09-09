Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BDE5B3B5A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIIO7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiIIO7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 10:59:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F0138E57;
        Fri,  9 Sep 2022 07:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W62H9Eg0ZNsf/iqqKiY4N16wPWAdPMho7r9yKI073gpwpr+iASfUlmV7mY90iOJZ3SCTMNTj87VBQeDpAP+BdLWsJzXaRAiY/+ygJKm8YZ9ccIgx9EGkCCNDm4d/HtglZqUiDv533KXBOpnCkEVnYU8KKogPEAToTMBygKLXStXDwCVbQHx+Sirg1LNOnjW7VhPTF28K0LtfO4jJEBnJ8j628tP34XSVjbmfh3Bmw2lHbSatPqJZYYjEbVL7HU8olEnp0s8rwPomOdXxJiugGICsVdgfgIOfhgLov1pGs3kvwy0Cl4PrPoruICVFaJNsNETV9ZUmI5WBJnLo/cQKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjVv5+btdkIlKNwSQEvAMmQc/Eeclxyy1byMtlb78lY=;
 b=IXPxZHczzT7wtwVnzE72AH8MJUPkVdPFTTmH2DX46olu2Qz70EVPtaMQxa3g/wWhtBHIECdWIF3ZB9FCNUU9bI1EfzTr/qdSnUeQIxI5iYp1JROBRYYNdSugBcU++oRmxinKtLRcyoVCWyal9/1MPcKogccrEu7lHxzIa5ks0vBObFLKKKV8vgPc3QSTKZ2kinIPbDEkm8Rk2XZb+1bKdjkPQ0//znbQ3G+5FvKke8QMnEwl2tVGSWyheep4NfE59JWHCddizX2taGNMUp87Nx8Vy52DfEcw0g+Pla3RJcTVvj7vSX429HyacUDf3mpyEuciKV5m3S+AeNthG6g5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjVv5+btdkIlKNwSQEvAMmQc/Eeclxyy1byMtlb78lY=;
 b=Ssuow/+gUOTdJv8rVPnlwWUAiIBUCx73LF2S1boy0lPymCUq/tadasvXuHwor4uRmXKGd+onw7vZLNBnecSjd+iI99rUk0khQZVtATs74jNxt0FhzFQyYqUOXcAkZho9zBYeDC/7BFWlIYGrYRKdelUx+wW4ZLLKSxDD/mpIpgg=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM6PR04MB6135.eurprd04.prod.outlook.com (2603:10a6:20b:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 14:59:01 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 14:59:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Topic: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Index: AQHYwmzT0d5rWoxlpEiRJzxdVpfwVa3VJ32AgABtNnCAAAtoAIAAAWiggAFjOYCAAC4UkA==
Date:   Fri, 9 Sep 2022 14:59:01 +0000
Message-ID: <AM9PR04MB8793746D9ECC6F07FD5B841888439@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
        <20220907034856.3101570-3-Frank.Li@nxp.com>     <87fsh2qpq4.wl-maz@kernel.org>
        <AM9PR04MB879338D6D4B55A74CD002E6D88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
        <877d2dvs0d.wl-maz@kernel.org>
        <AM9PR04MB8793CE5AAAB281CE628845AC88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
 <87edwkrbs4.wl-maz@kernel.org>
In-Reply-To: <87edwkrbs4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|AM6PR04MB6135:EE_
x-ms-office365-filtering-correlation-id: ffd96c7b-1ee5-454f-c145-08da9273d506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7c/4p9UAq1JHBQ0u0elT3GUHIKctGksoxdUntF2MbQWTwb2iFZKG0V4bq8YN3AOsJV+Gmgv6o5brTpIRL2Q6CxGqhVLz5qHGwqpG7ywKDvM/52rO9EmJsFDjqrDIoeviyIqSSNrpoOyGUYa+wn/iYmE/00RO2k8UE3CBtNHs1x9oiQVt7MkFwhdyQ6LJYYFXqxH/YGd8oOodYCWPL2hQRusBBX1lJoCj3+v4aGvCQ/1hHXyh5ikAAUS6v+46EnR7t8tt4Z2UM4OM+KLUupKYD2IMy9dhhuuVjQWUlDMXSe4kBkhvi08wjXq70crCmqggZYCEfb0fQCau4B6xeST3Eb+juwEKUZ0dnMToVuWcDCx4bJiqx3V7xpeEOpmGDasJC7CtshSldD6B0G5aaq438/2cH9wC7hfXj5N/+V0mWJYQXLUbLpaNaBdiUXLF+L7Ktx01C+ZEwYSH6auhsBlLz27MR0JasbQ/4BCLIOUmxgaxqnGsu1ME/418JhJMNK/RvZ1qJw54Ako8s0zRbHh5L62muTjGkPAkNOkc39ZJKNINIrA8APGbHjfOEDbRbU7VZ9DqNnLRuamH4gt6Urr45K/k528A7Khp40mXXS22KzmdA/Z+/Tic10a1OoAxSeIg2qT5wVJ5hWktcZGo6pyMJpxaoWDOBVOu8lSz2jmgFdz+EVTKhJeH3ZMBh2FqeSlwNJsAOgMzKg8U1NI00vbcaoytvwS6GM1F729bOiTef77XkpTbl3BseHn/z1BB5CgxtbzNTCzgDMuRDRLBc7nfdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(8936002)(86362001)(38070700005)(55016003)(66446008)(38100700002)(122000001)(66556008)(66946007)(64756008)(66476007)(76116006)(4326008)(8676002)(6506007)(55236004)(52536014)(9686003)(26005)(53546011)(7696005)(6916009)(478600001)(41300700001)(71200400001)(54906003)(316002)(2906002)(7416002)(5660300002)(83380400001)(44832011)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Znsab8XKlZ/G96F1XCksx8s14758UL7z2PnsP69nEGMPaszzF3C8rOJcubyo?=
 =?us-ascii?Q?ms+n86loHrYM1dibMqrmhR8kP2Sn1fWWeyFxQ85MWP5sccwyPwWfs/Ffwlaj?=
 =?us-ascii?Q?Hi84gNa8KWPTnHFY4FkJ80Q35P/bYlqt4SzWs6CKwAm3/vh3dxHgcx8IqUq1?=
 =?us-ascii?Q?2TSV4YiBpHQpno0F+zWAcdaN5KP2GkUX+FfROa5Xy4GVhHGhoIinbqXMUiAN?=
 =?us-ascii?Q?9I511/pKL13rxNUs+lXzM6M+P0C+4J/V4rUnQflYxo9XVV9z3J1uR3dwQwy7?=
 =?us-ascii?Q?OSl8Kf8r+KTi6QsxntkZE+yOk7pFRS02wu3NJ+JGF/EiZJKBU5rE03zwhAxc?=
 =?us-ascii?Q?ZJ/iZ9TOCT0GfAYnaDLMS1u/2bMa/+xj876hR3ErotW1PTOo/G1wSpHgubyq?=
 =?us-ascii?Q?tR/xp0UQfKUsqJEfh8lQox+3TAn5QxG8IiRcws6KY/Np98vcp89N3+HZZaAx?=
 =?us-ascii?Q?sl8kiQA+Xhpq1GSrbDikMBYr+5wM+SEdPRxnzfe+vCqAY0U7ZPP96GKQYkuf?=
 =?us-ascii?Q?PaYXEJ8JEmhPLHIifIAeByLtKBZxi2eje8WQX96LazukgkOktepxndji2TpH?=
 =?us-ascii?Q?6hOEpAgURMijVZBx/U0PftlGYq5TgKxf0hXoViBRLUq3+vtFZ7IWEibTDqsA?=
 =?us-ascii?Q?8KGFRnuQTI+t6pj33G3JiWnS2le6ktQL3FYrdV+wpqCBOlJssdYaoUt6GPKz?=
 =?us-ascii?Q?QpNwPPdFN/kWsKg9BWPYt+3V4IBw8cyCJa3uzbuzgxVLIamdTnDhGM2o1JvW?=
 =?us-ascii?Q?x/FHR4t5H5+nNaYK7j/wC4/Q9hPrDYenNpsTQXfyHKBT3YOH3qli5QrxYgLV?=
 =?us-ascii?Q?XeI8NHGedXoIvS6vzLNXEFIeHlsrCmOZirTDTX1AsUbYMrT4HvwHPahzKpVs?=
 =?us-ascii?Q?2vVDjzAq75NKNDGASeK+5H1x613PIc+W6UG6hIovkNnkcNobtOVj3UneJUAH?=
 =?us-ascii?Q?aTPBJrbFKxrMYcDgDSan7Apwfyn1j9XkMA/W3uxKkvvN+uPt3gnWN+Qmtdj+?=
 =?us-ascii?Q?s3KlYG6hnSw2OzFlb+9REezhftfaqT+pUE8bmAi3AHjsVlESRJ5xd/Y9eDso?=
 =?us-ascii?Q?EaWW9HEHBR2W4MJ4JbPCTWY3/ZvdWx8G31Dq+bC1gTsmPC3BSfZ0eizkszSK?=
 =?us-ascii?Q?CyER5cqsdXeEc+qs+6Mclao91N5K1RU2Pu3J65l4ROzq/U2gpbzjrcu5q7pW?=
 =?us-ascii?Q?NDxBGPhOST1ZpyHh4/EJzf/JzhmUd540ipWtg0AoTIw0h9wwb0xN1DHBf+mX?=
 =?us-ascii?Q?s2+GfSDuUqZnG9cyat4IL1SZRqFrsQVttCcI4KmkauOT0hTV1UKhjUwieFLZ?=
 =?us-ascii?Q?kzh3+cLSMG0fdSsQ0xFSx0JZNkb9vTG2UCkSB0zSzNH+ck4RX52RYL/U2u4H?=
 =?us-ascii?Q?2XNx/1FkpxyMqOLOV3lvGszjCvWaR1PxsiMufVtcPCFv2CzX+VznQfQwyU8L?=
 =?us-ascii?Q?1RPrwOeujJq5pVO/QRbNr+89Tz5kRcntpcw/eQJ6g8xWrXGwB7KEYXhqL9Ql?=
 =?us-ascii?Q?fnlbouKrCS7jGwXm9jZAz7ILStIM+mma1dTFPiDcFmWYM8NnE4FsfogU4FCX?=
 =?us-ascii?Q?M7RJzYQfYy7YdwtfVC8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd96c7b-1ee5-454f-c145-08da9273d506
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:59:01.9074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5ls6BtZLzC/gNVEac6kEr4MyIbooiDkcRStT2HIhzneCZAv1EZ5J5AaNR8hiMxG8k8Vw45Ne8cx6WtnxmzmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6135
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
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, September 9, 2022 7:08 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com; imx@lists.linux.dev;
> manivannan.sadhasivam@linaro.org
> Subject: Re: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
> driver
>=20
> Caution: EXT Email
>=20
> On Thu, 08 Sep 2022 16:35:20 +0100,
> Frank Li <frank.li@nxp.com> wrote:
>=20
> > > > > > +struct imx_mu_msi {
> > > > > > +     spinlock_t                      lock;
> > > > > > +     raw_spinlock_t                  reglock;
> > > > >
> > > > > Why two locks? Isn't one enough to protect both MSI allocation
> (which
> > > > > happens once in a blue moon) and register access?
> > > >
> > > > [Frank Li] Previously your comment, ask me to use raw_spinlock for
> > > > read\write register access.  I don't think raw_spinlock is good for
> > > > MSI allocation.
> > >
> > > Why wouldn't it be good enough? I'd really like to know.[Frank Li] '
> >
> > [Frank Li] According to my understand, raw_spinlock skip some lockdep
> > /debug feature to get better performance, which should be used when
> > Frequently call, such as irq handle\polling thread.
>=20
> I'm afraid you are terribly misguided. They both have the same debug
> features because they are both using the same core implementation, and
> the only difference is whether this is preemptible for RT purposes or
> not.
>=20
> > Spinlock have DEBUG feature to check wrong use lock.  Allocate MSI
> generally
> > only is call once when driver probe.
>=20
> Again, you should really read the code and the documentation and stop
> making things up.

[Frank Li] Thanks. You give me the correct direction. Some stackoverflow's
Doc was misleaded.  I double checked spin_lock implementation.  PREEMPT_RT
Kernel map spin_lock to rt_mutex.

I am curious  why exist spin_lock_irqsave and raw_spin_lock_irqsave before
PREEMTP_RT merge into kernel tree.=20

>=20
> >
> > The basic principle,  lock should be used only when necessary.  Access =
reg
> and
> > Allocate msi is totally independence events.
>=20
> Independent events that do not occur simultaneously. So no harm in
> sharing the same lock.
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
