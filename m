Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0C78E46B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjHaBex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 21:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbjHaBev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 21:34:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC7CD2;
        Wed, 30 Aug 2023 18:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT5rj5M94ceywmnjcna0SKEKiwsZfGWXoTUMo98Sw+ukt1wwb+ADDPeLm9RnKDouEjUageQbZ/O4KaPZbrJLSTDKdmoFd1fKPO7d9i67eu+a1Uh8rW8f5/egt8e63V2QFg1U9tlaxz8IW0kSH+I6OwRxsMr0CXykIx6mNdPl0ORfbMCRGv2MGFy5IHW0ZQLy5npzCZ/QwTRSQYYG+daO81gbAW7B816XMPkUJWcKMgxFGlXt4niXkuyoOyDdydVCax10DRXj1Uwwakq5oDPJsSPCOLjCczNqerB80CpbnyAPQRQnJpTu97JbXtMe4dFMZm8B8/FVboTmuI5ujJLzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxYv1Ev8OEi7msPSixWRCmSViM4dLxE0y6bKmpob7ts=;
 b=jxFeWqK9R10kyVEA+DpAoKg31ABQYmrxeMfqxI+Ur+POOUg3cOe5PH8LsSU1+GIZDkElB0V1TjKkwpspEOeotAJOkYi/1t9TPr/GBG2PTod7Kwt1gcmbPHQIlIHHcg8El90wZc8GBKt/x+85xAXr5EyIwH5M/tRBL5jrIXXR3pco5hK4ZoEFlxnO/5VugI9ei+u8tP076ksEal5O0TpZPoEz0jXK0Gn1MiM6KGnjZGE3L4e4M+Hbmb7wj1T/Jsr7FAtmVr2ZthFlpC7nOX7iqQ/AVS8qVkPFAur+OvBII1j5oikie6LUXpEghi4W2g1ZmEl81MJogv5Uz5VsCw4dJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxYv1Ev8OEi7msPSixWRCmSViM4dLxE0y6bKmpob7ts=;
 b=LvXbXfSifos2Gi7CqNS2IOctbgaJLAE6miQDJUVWOfBMbRYw5b1ksqiHWjmV+2wlm7/KVdgo6Wv+QX6all6BRQWRWseIFIF3rzWZKPxd28/ehvBtrYaz/CGPih0HsfH5fL4antTLxyZE5zb8sm7jjCWaRjCstDeM0y2+LSVZAGo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10194.jpnprd01.prod.outlook.com
 (2603:1096:400:1e6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 01:34:33 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 01:34:33 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZ1zcNtDThJaZvc02SH965eUO1lK/+WEaAgAVM4qA=
Date:   Thu, 31 Aug 2023 01:34:33 +0000
Message-ID: <TYBPR01MB5341A56DBA3E4335FE8A35F0D8E5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230827162721.GA2932694@rocinante>
In-Reply-To: <20230827162721.GA2932694@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10194:EE_
x-ms-office365-filtering-correlation-id: 819c1c42-85f9-40d0-7d5d-08dba9c26dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNaro5ROehzk/wOBSp5hdl2C9joO8L2Ysnm4USxZLk0VrFyi2kiKBnktYnVi5mtDZ4e2pBKU3h4QVyCg+M0Latz7qVJU4Jjh3du8K1tJp2JTAlSV8R5MynMsFO/y+Dep+lbnD3HdU/FvLNU8FcXVxbleFM5Itd7sniU/51qsSSIAu563uOSks6ik245U+GD/qN/HdhhsYHD+6d9slu3C+NB0zeccvJ/QtGXOkeFkR0yS7a37I0WRXk5e3901JXaW1tG818OHVfRKiBhrH4W++H8rNJIXV5fs6qAwp0ByDPd/pLaEdc9CMSrpzN837rew8DXAl/m9uR1igY1eAv5WswS/zk2ZKF7OAXGBExuvTShcTuFgfbK3fLLMEBN1j4xFQFZnet2/38NdN8W/y/T8hS7S6dSiuptz79bIqW7JNbkF2u5eekyIM0YlHNRB1LTGz9hsixbsj19T/5NNLLShfkxr5z+ZRWKLNNmadnwG11xFgD40VmmrEhsO5Ab3AVJt6vg0CZKOa/ZYoIgyP6iqMOiL5Xkxk4jxNI6NHWXmpWNE274HW2lH6Hc7lkVJHhMkGGglQcV/ssHazbbL8IuKdo1JFdoAyRsYf/PjmX3E/0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199024)(1800799009)(186009)(9686003)(71200400001)(55016003)(7696005)(6506007)(86362001)(38100700002)(38070700005)(52536014)(33656002)(7416002)(8676002)(5660300002)(2906002)(8936002)(41300700001)(76116006)(66446008)(66476007)(64756008)(66556008)(66946007)(316002)(54906003)(6916009)(4326008)(478600001)(122000001)(966005)(83380400001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?2RYT/o4bpgr2u7O996BtrdoAaom+PetjTRNfey5dgUGUzhkGVWlDYpIBkB?=
 =?iso-8859-2?Q?iZCyXsHsB9B5rIj0pdRJTRQm9aj9eDuvD61lCHDwt1WD+NJzgj4faAPtqt?=
 =?iso-8859-2?Q?Ufwng6Ntf9sty1wsLbJxiOV4XXciU4WXUWIg8xSnvMhsjxLZkVXRhG3600?=
 =?iso-8859-2?Q?BjJ+s2p2Oo8wSlkNrP0f+GSuMGjINyzqJP2XjUqgA7lNYENZHtpgtazVH5?=
 =?iso-8859-2?Q?m/pKKy7NDUpl1zPAwmeE543wUu4DTiVzhJloHibQda11SPtpfehw5R/XeS?=
 =?iso-8859-2?Q?npD0CRZFAUn2EbUW5HIKAYvZVgfL6jQXPRX4i4yWZ+HGNK6FmHC8VnLt49?=
 =?iso-8859-2?Q?Vch6l6Qy/suAusRioV3LOGd4ANb6e4R9kHUmX4ictIG4LxVMoyUYVqsmxs?=
 =?iso-8859-2?Q?UCtR80oHbaru0iXawEpBgdOnW/w7dqJuUvvszjgArW9nsTOtgywATCfp/h?=
 =?iso-8859-2?Q?+KEDIA8jScX4+m+9Ccr809aV9RM94mlJrPb27WGKrgj5FGTWBE0hzHIzIA?=
 =?iso-8859-2?Q?Rkc7Xawd7xE+U1I0vkcs/bLboWgx737gIwd6SCzOs36qcrKrFsnVg+QhLg?=
 =?iso-8859-2?Q?dKX3xYGkuftPapIOzY1M9rsn5MhFoB63MArzhQUxytWzD0WK3Gob4YN2DF?=
 =?iso-8859-2?Q?mGcO7xl1W5yXVjnRPqYD+vlJYpsL2YT07EnoA2ypV9+QZ4zLBI+iMd8ntr?=
 =?iso-8859-2?Q?PVNnjjwWd4x/f1Lu+EMUd1WuquVLZi8XCPbbLVTZ34V01/gKUEfwrR+GWz?=
 =?iso-8859-2?Q?+JvvGqtC3Mq3QNd0xrxV7VETNdGw8DB+lq6VJRyZMYBz+2JDR+nbykfm8/?=
 =?iso-8859-2?Q?NOMjlh1qCcef9QO1vqizXep0gjZ1zpt9aNhzP4ksPWMAABZ3+it+xZ1A5r?=
 =?iso-8859-2?Q?4B8yt/2o/DCrj8vEOYuJ04mLaYywZo/3mXiStTCM5FSqBoAz6NGRrjuMqP?=
 =?iso-8859-2?Q?Xe5ni4QikkKoXuQfAlwK6G2VagbiT89v3S3pJvrng1522ggeM59sMPC7MG?=
 =?iso-8859-2?Q?Dtr0S0wvuwDyFnrN2GFf2fR3IMfHEvhUSeaVhbjxoC1V1olsKZd8ajywu9?=
 =?iso-8859-2?Q?gRaa45dU6OhxikHh0d4NGRxCk6AwIgZ2JkZESK0l0o5joyuQPINlkPK+uf?=
 =?iso-8859-2?Q?HPgw4FC1GHfFvZwjqIrIxKKa/g3G1Ml2qksMoGN8TVjwZskHIiA7Zx3Ozn?=
 =?iso-8859-2?Q?VcuQ1zbRvcSH+xAKJVsmC6QTwK6OG3dnsX1bY6C16A8ufvM72jsTKNPqUr?=
 =?iso-8859-2?Q?cXY/5oXi/tHFQZQLLqZU/rWmwVzrXkMERVmig3fsdNWg+6JCrQxcT/D7sq?=
 =?iso-8859-2?Q?qmXhIKW7kghXreMNtALyOL9oiv7Oeco2VbHOghjkv1STq42uGY5U/ftePm?=
 =?iso-8859-2?Q?qfjjy7CWJvz4AB4r6Df2dsdiIrKRz3VgCFuOrzFpcF+WYH4GgUqV/usN+k?=
 =?iso-8859-2?Q?w0oqKoFfUw8HKFAut8s54ClJH5T/VYjMzVODaH9xskuYxbn1ltXUpiCdzk?=
 =?iso-8859-2?Q?a+TqBwV6qqw8FCvTMwzdfoHRk7Fbj7NRF8TWszpcrliXgNuqsajp1d56KW?=
 =?iso-8859-2?Q?oeMupPpo1ZPYljAnqUWYsz4kxv+i001nRgB8MsDl7LdviSN/1LUQzpWyiM?=
 =?iso-8859-2?Q?CX6AqPs3zQno0ryCLD+jAcWkYXsnTpD6iNPV+xPotFgdrakabym+3vAQty?=
 =?iso-8859-2?Q?4JGX3H2pfn5LTNzpQYguAOmhMNRKiqUOyL+hcuLJRRd6INNBcHRaxLG9Ab?=
 =?iso-8859-2?Q?S2fA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819c1c42-85f9-40d0-7d5d-08dba9c26dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 01:34:33.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4obfsrUBopgvIzKfjVqsXHtuYz7fCy0f5AwYvjFfni6L5TeYJcDlce5hoDuosvNL4Lbfnl/COYVKDICpLrMUTfIg6VXuQ59Ytc9jDTK8Gj7iPhCz59bBnLQkfieyDcy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

> From: Krzysztof Wilczy=F1ski, Sent: Monday, August 28, 2023 1:27 AM
>=20
> Hello,
>=20
> > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > To support them, modify PCIe DesignWare common codes.
>=20
> Applied to controller/rcar, thank you!

I should have asked you before, but is it possible to merge this for Linux =
v6.6?
Today I realized that "[GIT PULL] PCI changes for v6.6" [1] didn't have the=
 controller/rcar...

[1]
https://lore.kernel.org/linux-pci/20230830190642.GA10547@bhelgaas/

Best regards,
Yoshihiro Shimoda

> [01/19] PCI: Add INTx Mechanism Messages macros
>         https://git.kernel.org/pci/pci/c/b6dc5750a17a
> [02/19] PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
>         https://git.kernel.org/pci/pci/c/6cbd4d406cb0
> [03/19] PCI: dwc: Add outbound MSG TLPs support
>         https://git.kernel.org/pci/pci/c/6ab660b25520
> [04/19] PCI: designware-ep: Add INTx IRQs support
>         https://git.kernel.org/pci/pci/c/b788d6fd273e
> [05/19] PCI: dwc: endpoint: Add multiple PFs support for dbi2
>         https://git.kernel.org/pci/pci/c/6e4db9846cf4
> [06/19] PCI: dwc: Add dw_pcie_link_set_max_link_width()
>         https://git.kernel.org/pci/pci/c/d0f961f40da8
> [07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
>         https://git.kernel.org/pci/pci/c/a0473c77b4c1
> [08/19] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
>         https://git.kernel.org/pci/pci/c/e45ff874cede
> [09/19] PCI: dwc: Add EDMA_UNROLL capability flag
>         https://git.kernel.org/pci/pci/c/2424c3ddbd4c
> [10/19] PCI: dwc: Expose dw_pcie_ep_exit() to module
>         https://git.kernel.org/pci/pci/c/3f937c80eb8e
> [11/19] PCI: dwc: Expose dw_pcie_write_dbi2() to module
>         https://git.kernel.org/pci/pci/c/a986f6fd339e
> [12/19] PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
>         https://git.kernel.org/pci/pci/c/6504d294399e
> [13/19] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
>         https://git.kernel.org/pci/pci/c/5ca157f7d36c
> [14/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
>         https://git.kernel.org/pci/pci/c/af285bc39885
> [15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
>         https://git.kernel.org/pci/pci/c/738bded11aaa
> [16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
>         https://git.kernel.org/pci/pci/c/943a310da907
> [17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
>         https://git.kernel.org/pci/pci/c/db4499d11f46
> [18/19] MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
>         https://git.kernel.org/pci/pci/c/2e0ef5776946
> [19/19] misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe contro=
ller
>         https://git.kernel.org/pci/pci/c/33fa67818fe7
>=20
> 	Krzysztof
