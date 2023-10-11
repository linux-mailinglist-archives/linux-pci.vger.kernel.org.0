Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3167B7C4740
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 03:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjJKB2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 21:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJKB2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 21:28:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3992;
        Tue, 10 Oct 2023 18:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eejdOKaRUulDtWYvU1gZ+bCqGGJZIrLRcOURIzyxl5Kx3NfLf1Xbe0cw7MP8fGrBkdAdt8Z8Xm8ggy/ioCcprZcfU9jtOhTeIuw0RjG6ae/WhzPJtGwOrz1Cs4YJ3jcUEbiL6kWo6fFTodwEpYYOM9uVk24W9a9eh8OApRsARhBAW52RZdm6b9hkAJWZjt9lokiDPyLSisAsNppkaaxda7LARl5r6qG7K+wtHRvawFii2lgG3ZOgq5FSPCB9Y1mnh/FTXPDuHwIN8ha57zLol5TNBR0FsMinfMFnU7JxR3HTlTTVs3dAAt4BJI51XzJDtqnS2MhVI06xIaDyuj8WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc2ckM9mL2n4mQh35GHk5W/hdZvN6LV5rQE9OT9TT7I=;
 b=b1g/wWh9+3Hsrh3kYUflaclb4ngEHfQy1YJQ3qp16p9u+h/tCQ/5Opw+Ypq8g/HsjzlNu+LvmMVT0fINz3XO+sMwqNqWsC8x1Mr+CGDTf5gqXxGj1fsBjdxM9ZeAedc1zbinm/ilIoWZ0R8coxHyTq+ug2sovkxUITYAm9ppQyKRRG2WB64nPhhFvuOIDTrr5RVajDsI87YIrUrfoL6dkcSJtYrFh49Q/nHtaYoMZLWu1TdRu214zaeNHpEsQhMKGWAUHpntEmorNUgLJVTR32wtHzQ/3m8fWRB8ZMRjsoOBdWKJaDhRBee7WGC3YRaf/V8symt8kL7A/JWNsf6Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc2ckM9mL2n4mQh35GHk5W/hdZvN6LV5rQE9OT9TT7I=;
 b=geBJo60FK4GYdn1DMd2H4CfrYGwS9AY1xLssWWslPDrcMEvkluKJbWGbGPzXgzy+4bMTokI0UKegpLVb9a9Rt1LN37upv7pbShwQKDsNIp+lQUequ0SdUsv7W2kt0Exrq6b1xvO9xGre1WEHtOV2AKeRMhpuALXhpPTIvk9CJkw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB7827.jpnprd01.prod.outlook.com
 (2603:1096:604:160::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 01:28:15 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 01:28:15 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: RE: [PATCH v23 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support for host mode
Thread-Topic: [PATCH v23 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support for host mode
Thread-Index: AQHZ8HRsthoffNabyUqmvLc0YuNkzrA7WtyAgACUxoCAB/JMwA==
Date:   Wed, 11 Oct 2023 01:28:15 +0000
Message-ID: <TYBPR01MB5341E8E2461EB026E9EEEA92D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230926122431.3974714-14-yoshihiro.shimoda.uh@renesas.com>
 <20231005150907.GA746291@bhelgaas>
 <TYBPR01MB5341AA2E0292AE789F75222ED8C9A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341AA2E0292AE789F75222ED8C9A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB7827:EE_
x-ms-office365-filtering-correlation-id: b85f5c09-cb6f-4c2e-d4c5-08dbc9f9576a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFD6Y/otDd1Q1z8hHFQoOAFVKA525w92dtlalRDC7e8BsyyZb2c4jk5wxXZ6VabIra2FNSHy7SwS9xrOq6TTd+lLx3KWFNrvkZmBB2qoIyaZle0N+zV7Ro2vZKTeKGCNWtXZ+p3b8BTR2vANq+awUNMEHHQpyLzcu3+i7gdFvdZBFis+BdJEAYXFLwnCG0vS2JYES57oIj8CbteiG1sQLq0t766lPLgD4k0IdGoVaT9mv4SklQ+cQTssMQv+kvrdQkDCAQt+3EnBl6otNowIB3p+RiDkb3OfBuHrxmZENMRszCBXK4u/i9CY8a4J/5ITiV/NqonCH7kmNmcVy99TO57rZapvBt6hgSYwzvupwIrCFRysZiXVmQb/wkEJQ25oyDnNn/RXJI5XtTs/feKTJiFRgLDC6+jKLxxm6nXZcq3oUrI4foxgIXzxx3LsBlw4tc2vi74eEBP0C5elvull2sLq8rOiVqAJvWxTZ3FxSiYgdsvMGTHlsJPdIruf/e+mvzI6hWD3HwZaA1WUkwie4IQJ/i2f0wKk8sABYDjkbko86U/QIIhcZxclBS7Ap89RQgQIayZUR53iOvv+bLrxDGUCZVsW0lBCcMjBdNO2ebE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(6506007)(7696005)(478600001)(966005)(71200400001)(7416002)(4744005)(2906002)(8676002)(5660300002)(66946007)(54906003)(64756008)(66446008)(76116006)(66556008)(66476007)(52536014)(6916009)(8936002)(4326008)(316002)(41300700001)(122000001)(86362001)(55016003)(38100700002)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZgJDBMJQbwlm2rch3n6jD9kTYi5zo1sfbOZrm7clJeOxXr9y0SXDJSwei3dz?=
 =?us-ascii?Q?ibm3gQANZgFNhZJfUuYmFOWXiH8THI79empTulJeZbvYTqLYP4ss9yWirnwT?=
 =?us-ascii?Q?aRzWVTY/sfPjovShAzTKxNHoNpwpcjcfpiC7E5RC67gAe8TYILR5bpXvfm2k?=
 =?us-ascii?Q?0iUSxv3UWFfEkHwJDOMhqHlvWAEdqgu//UVzCa2R4TlPxbEIjOdy3u+FLF5V?=
 =?us-ascii?Q?k4Uo1mXc15DWmGrl4GcecMIXp7v2Y7P///G2mruqxo3bzV4ruQpwXWcotmno?=
 =?us-ascii?Q?AiDYVfj9g1bmp43qKel3GyajrnQQTTFFj+g/Q0XAjKBuZFwPcQTZStuv+Cri?=
 =?us-ascii?Q?aoejg4KYXLgqdGPSvo8vp75d9N1mXd+Qf/jfxNHc+IPYUgaijmqar00DFIV6?=
 =?us-ascii?Q?15HHnkO1JghTh/HYQeFVznuGWu7oXJDAp7JRbV4dQEOA/xAMHj0Hvzf0xulS?=
 =?us-ascii?Q?ZsnTMC4tVxYNFMYauQLUNakfxiJdz1V4XFe5kwtKC+rzjfQterQ9YG/UuJ22?=
 =?us-ascii?Q?LPnkXLpBdE1oizQvCG0qPV1A78Qft5iYI6n2ZK9AnEX2t9GEgc7X1D2DuEbR?=
 =?us-ascii?Q?BAeU/n6yyHmOyc8Ibwsm81jl8vP2qQXXvA7Jw1maiRLDGOp2y1GW+EBUfX6t?=
 =?us-ascii?Q?tEZ87NMu6vsvUrb0b8PYmgpBoFuXcs3IOr2bjxmMPwa4U6wl7HjF7OUIVRoD?=
 =?us-ascii?Q?rFhiZnGhGsWGBHN62fZpeXuNSNWAEH8OZk7AHhBa67Ympl9pv536zs9V+WA5?=
 =?us-ascii?Q?zSag+JmOX2pnp8rj50/RJv/NCMYoN8uZlqPRsbTWssj8oRlnNv9BQPdTC/Dg?=
 =?us-ascii?Q?n2ILg6CmE7+p4vKuAM/vzn6O4E0gyAVDSfXkpLqJ7t/g8byfiZBd5d2xUijR?=
 =?us-ascii?Q?oV57eIZiIQq4VnjjZnGFy5To4HskYT2HNIy61pArRSgfE/YiC02R+YajpFXq?=
 =?us-ascii?Q?DcaJ717YBNOMat9Ow8VsxypXiOslUrqeuEQxY9//nu9KKU5cnmrNk8Kla07U?=
 =?us-ascii?Q?I6hHoE1kBsnzOp+4cqCdoUeYD8Lya+0qx829mYA1afkQWXhn5Jxe4OmmG1Vj?=
 =?us-ascii?Q?9E4+Il7PxXhzOzj3+ld4Sqb8N/tneoSzb95rCd+6lj1KHJafgr9wcrd4jJsN?=
 =?us-ascii?Q?uKMYztqgYPhgmDKe+3G8HT6CEDoX5s1Hbvr/yqhmnnKDzvM1e3YNSqiF2xbF?=
 =?us-ascii?Q?SFhBEVY5EFFfvfOOu/QNkYhw1vqFiWJ0P/1E1axVzlEQYTZ5j71RuTop7Ly5?=
 =?us-ascii?Q?0A4czo8vYi8yIPPv9Nc7pD4RtlZjOTISIB/rlIimf+ic37LfT3aaCLG9Yomx?=
 =?us-ascii?Q?6UkjjjG6bzhjV6slY1bmZAwiE1ns2Q0HipgsGI0CsBagpORawohriCre3QpB?=
 =?us-ascii?Q?oOkD8fIdWfe//YJkju7PCJConJwU6xmqogeESjVz341RcQ5GpLUv1CtTCTvT?=
 =?us-ascii?Q?WGzyIE+Uc+9AKu9UKjBbcHgop8ZmThKh2GeYpIO4LvMp1dzGDZzd70opzdb1?=
 =?us-ascii?Q?9SgO/FIILUxCfpXSeHqUSpBV23PUlUSYY7AWHkMG8dqAtzRY0Gb1ANSOblNs?=
 =?us-ascii?Q?lamFvcht4q2C06LJh11L3WnHs3zV59VEe/77OE0GBXFoOGjz6TJs6XMBfXbX?=
 =?us-ascii?Q?17t6qc6JbrjpI45l2vSGnFk6jJblkU1ej4x45KFg/JVo1X7DTtuRRWjizMv1?=
 =?us-ascii?Q?21xzwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85f5c09-cb6f-4c2e-d4c5-08dbc9f9576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 01:28:15.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lq/SmtcsAtgp97VGE26glxRbSHqrSvdKXHdrefTecEECU4GkywxofpiwMfceFmB3eQeKfjsddT1dmt06Mw0vRmNPyXfSV+D6xxHQNdOKczT/Vso1mQnilGzTZ0cLiS1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,
> From: Yoshihiro Shimoda, Sent: Friday, October 6, 2023 9:08 AM
<snip>
> > From: Bjorn Helgaas, Sent: Friday, October 6, 2023 12:09 AM
> > On Tue, Sep 26, 2023 at 09:24:28PM +0900, Yoshihiro Shimoda wrote:
<snip>
> > No need to repost unless somebody suggests more significant rework;
> > these can be tweaked when merging.
>=20
> I got it.

I got some feedback from Manivannan [1] so that I need to fix the patch
series. So, I'll submit v24 patches.

[1]
https://lore.kernel.org/all/20231010120421.GG4884@thinkpad/

Best regards,
Yoshihiro Shimoda

