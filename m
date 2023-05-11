Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55EA6FE889
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 02:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjEKAX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 20:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjEKAXz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 20:23:55 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C41558D;
        Wed, 10 May 2023 17:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKNTePc30X05lm0n2t2oPTqnYtI84Y1sUOVz+i/L459NORi+1SmLb5mX20jCUOnvMShSZqya1LBY5UHzLDBVKg7KuoDSJE78lQJZtkRv/bvHmVAn29McZkt/TFNnMvw0k2iaesKmpdRmU811zjRPHwkjf67NAA0OUpT57jY9m2Kxbhf8/WVMaJbEXcMKVajcNTtJSHt8A8pASFpr+gO4xdYJXLLu7NM71ti6bF0vPnpWrdr8LHstwkA8XjhE8hYyoMASNsv4QgEV1kQqYu/WDzUyK5pp1ZQ5/bM3jEpIQcm920H5SapKUYtU6WNStnDdVjTtqzGoUIWwKyToEVQQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX0EV7fd+aelAFvugfjQN+/qUUT+2vkTyhQNj4Yr2Is=;
 b=fNldIHk3KYN/+9H/5wM5SL33mEiG4b3QnGqMW10jNLhDrX+Tiio8MZ28nnIEv0DWXdbRieOYoPsFpEK1mYRj6Gj0xr1RlmPaPrsWwTFbaFA8BekU7K4I+TSEUJZFrZG0Q+IxqQQyM1h08OzUHMz7imHKN02rn17t4+rm4KiugTpHinodUIR1Z6lUN2JGF3Z8+HVTGzvHWHprhuN1omIsQHQTIVgjlPrW6TWafJsX1K92iniADXgYLATB2CSS9mSyl1YbqJ/Z7rv3BeWn9nM3LMHcR8oLgOiUXKf78Ky3cYN6IV1SbmuyHKAjM0/F3aB8EzbYK3zKVALkuIvjN1aGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX0EV7fd+aelAFvugfjQN+/qUUT+2vkTyhQNj4Yr2Is=;
 b=ZCqnV8iEEZ4KqcH4bUB8MrTIvHzPTf7s2q0EuL3+3fXLdU71BHTHT6AXMoadgzXIC9lgUvk9TBpoMjATMzNQsI6V7o8vAw+B8fpsVDPVASil7R+CdsYamufhalqEmdlMHefgUcpnw2rZUKa+PCNDr7U37/QZgR8TgQIgKqPS9ZY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB7902.jpnprd01.prod.outlook.com
 (2603:1096:400:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 00:23:49 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 00:23:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kw@linux.com" <kw@linux.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>
Subject: RE: [PATCH v16 18/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH v16 18/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHZgwfSbcFD4WwTw0SuBTJ3MhOZ169TRy+AgADsHNA=
Date:   Thu, 11 May 2023 00:23:49 +0000
Message-ID: <TYBPR01MB5341D96B3E3F65BD12434F09D8749@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
 <20230510100309.e3ggidtc35xi7jde@krzk-bin>
In-Reply-To: <20230510100309.e3ggidtc35xi7jde@krzk-bin>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB7902:EE_
x-ms-office365-filtering-correlation-id: 6c58eabe-0ae0-474d-b27c-08db51b5fde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCFWoq/jDJlEpCpPqb9ehuTvKxM6CqNWWGsM0jdL1Yg2Gp2Jah7o1Eo/5yK/qYdGtvwuob2x1xMVVtNJpv9GomkwVDCCOZM8ic6QG+TKNf8BnW6abmpeyiZJ9x8Mat2QaLp4s65dnc7y6dQOC/NTdM3pniPaHpQa1lfhBpDT7eliyMzs4+Fmap2HQpZt6B/dvSKUzhWEjQ2nPT3x+ZKeAMPWXe64yJfVqDIDvhEev34hGEkMoQiFlzRbuQSGG/RRQ2zgQyhF7UT/3UXwsdeCmfhHMGiA50gCn98PV5Ydx8hO+HgqiE1TJrUn/8Ge4cAWJ4Mb9r2UWLy8dyDRikPrpzzxeaKx/xFkxS627TaUpfzajWA8kR/oy0FuWmy84IlIjKOH/sVPoQyjJVdXyeiRfsH/+0OJ3bzBd5MwjRHqHTOYKo/Zmlc/mEmDI44lVUmQv7VwkH8JdvCETNj8uGr01Jqobw/W0i+25bKcIL/SScpW+auwv8ldn5hmiigSIHhoCrtZQphq+S7Wm/h5EjrnGOmL3W564qKgkUbhEep48D03BTvZ3IIo60LscYlLVQyEHV57W0QAGiZpPf8R0jdB361VnJjTqK8HLWWqMx8Cgis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(966005)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(76116006)(478600001)(7696005)(45080400002)(316002)(54906003)(33656002)(86362001)(186003)(9686003)(6506007)(83380400001)(5660300002)(52536014)(8676002)(8936002)(7416002)(2906002)(71200400001)(41300700001)(55016003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zCl1G8bU1YG9h3crrnOchQ/7KiGDigYd0LH7GQ6DA/3NePzOrxU6i3heMKcG?=
 =?us-ascii?Q?moaDyqxnm3XxLkwn0h0Bn0eriPXEieMOX8+5s5f77rgvT1ScBpNIlu3LaULg?=
 =?us-ascii?Q?1xikFTU4sdBScrQD9cjHg7dXBX9dXg8QTWzbK5jpvUFWqVfx4zi3ObgbbySn?=
 =?us-ascii?Q?YmBjxBZ1d5aYbHw305DJa5W21+vQrhxZz4AmL9ST602oJQWbpjnSCgg+1DmH?=
 =?us-ascii?Q?F3v7ymNyxxrMaxQ6w8P38ucoyGx5mPo3B+hQVQH7XG1LRcHa9fLtcHM+RNww?=
 =?us-ascii?Q?siEDwo5BI7Naom4xoygs4dSb1qAT5agrniWgayWxbBbanYiVayooCDcfUSPR?=
 =?us-ascii?Q?xBBzxExOEKt7QZ0qI0NvyP88UzxWZagYmXDbovDl0fS1RryJ05ULYQzQiob3?=
 =?us-ascii?Q?HKls63nmOX8PJEHPwDVTyahScKjyOfa5T/Snmao0HyWUB03NhkTOHsAs2r3u?=
 =?us-ascii?Q?S6f79jSrc7Z3TO/gw1FfVP5hEkjvIeQ0VUra6nNJf5bpxeYzY22FhqoNcxem?=
 =?us-ascii?Q?hpO4eW5AHUevFq1o3SP8FWbvMwGaiZr48yVlrXLhf0dOnu0Sm8fFfHMY+UbW?=
 =?us-ascii?Q?3dqh2pnEwEPa/Ay2BD25OXDMW8omm49CvBING6zdZ18xPaVMyhXR9Ru1tcmO?=
 =?us-ascii?Q?JXyINZVuRi3OZYDaVDTnBqblzbdeKsmthP8fzGpNul29v4y2PkDiQ+0hZM4O?=
 =?us-ascii?Q?D5JdR3CAX4vuXu/bDiocwyWgquGyQ55cJR/jwznrYujgB8D/N42TEpRU81ai?=
 =?us-ascii?Q?h2BwBX078rv0FnuzWS93wIqgCbeFcYkQYt4yUGMsYQ9lITo7TxKn5et9KG1D?=
 =?us-ascii?Q?Gy1lRznTaVRMyOmeL51UVZPbDnxFK2wrxGuP10GNTiQuUsf7K8f10SYTezui?=
 =?us-ascii?Q?VTaVVwux7EMYw1yPCI9kQrgYWOvsPE1Rmk95PMlieh/ZJhI1r+SpHXSoe9PP?=
 =?us-ascii?Q?om60gAzfkLSehmf8egFmn3ScJ33nWnVpX9LcH5c1u7PSVX13iWK8WoxYjMoG?=
 =?us-ascii?Q?vh302qQEUlH/VYVL1yUcQxVHH+Y7GwGkcN/0Pz8Suf68kRc3xw4y9FFbYXtn?=
 =?us-ascii?Q?wd/jLqdyNZjR/ubqSlbNG8VZJZ9nQMSKQiHEKzsMGsDTB7M2jmMNJbdHoLJL?=
 =?us-ascii?Q?TwW88lxUuyq7PhaHJW3T5UlRFcdzEJodD9EgRFLICBG+7uG2emv+DvvvDIAV?=
 =?us-ascii?Q?Dm0C0BC1YTHuR45IKdusPfBTcVujEI3LN4E2Sc0AmA/w2Gq415u5kXecltfR?=
 =?us-ascii?Q?rGNufLp0Xtwl2VxOYv2B52SZHeRbD5IeI8ZA8KdNaYUUvV7l6tUpUII8yAqQ?=
 =?us-ascii?Q?lnvwxnxi3i0Y7i6ceYPxNSSD8HZTzC2a+P7tchtvFo60ows/boADzUne3erH?=
 =?us-ascii?Q?wcZVQw2LYrsaTwx4BALpev8/ZyPMKIAvM4wW8nTqYZH0LZjWX5rQ1Frh7uuR?=
 =?us-ascii?Q?d/lcCDd1gTXxkEJ0L1Brzpf+/8Gcneq/Eyfu7xRHHfhb2T9ZUqWD7DHUANwa?=
 =?us-ascii?Q?JcKZq3FWVPyNkWBZdOwQWpn1uXDA89XcL5GD1/m6Lvo0Q6SSd+4y9X7a83W7?=
 =?us-ascii?Q?mImAAOiQRB94RUl6RaXZfAeTiI9H2u92zFzJveDSynCXlh+ACM7LpfRmySfd?=
 =?us-ascii?Q?a982SExBFObmZd6wmRknF3sxef/6JNI1H8Qq4ThusKAl37plwUZrdhvOPaON?=
 =?us-ascii?Q?EFZGuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c58eabe-0ae0-474d-b27c-08db51b5fde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 00:23:49.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbsZo53JK4wG0McLKGS9Sog9PSCVAwbUoX6GlT//f9A0fmenJ6EaMXhf3V570vl71Bf0+Aflegjg5pdxPQ3wtdAdbv5INQrVGeJ3pMIv3dati4WekOf6HWWAEA44a+oF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

> From: Krzysztof Kozlowski, Sent: Wednesday, May 10, 2023 7:03 PM
>
> On Wed, 10 May 2023 15:22:30 +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe endpoint module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-ep.yaml
> >
>
> BTW, you keep not-ccing me. Since long time. I don't understand why. I
> don't have the emails in inbox, so I won't be responding to your
> patchset.

I'm sorry. This is my bad. My using script for sending PCI patches didn't d=
escribe
your email address and I didn't realize that until now. Today I added your =
email
address and Conor's email address into my script.

>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.example.dtb:
> pcie-ep@e65d0000: reg: [[0, 3864854528, 0, 8192], [0, 3864864768, 0, 2048=
], [0, 3864866816, 0, 8192], [0, 3864875008,
> 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too l=
ong
>       From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.example.dtb:
> pcie-ep@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'addr_s=
pace'] is too long
>       From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-ep.yaml

I believe these errors disappear if we apply the patch [16/22] of this patc=
h series.
So, we can ignore these errors.

Best regards,
Yoshihiro Shimoda

> doc reference errors (make refcheckdocs):
> Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/p=
ixfmt-packed.yuv.rst
> MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml
>
> See
> https://patchwork.ozlabs.org/patch/1779260
> 1%7Cyoshihiro.shimoda.uh%40renesas.com%7C84515e5d9f5045c6e2a408db513dc57e=
%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0
> %7C638193097971078712%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%7C%7C%7C&sdata=3D57twFUl%2FDPMnxVgxTs%2FJCH5tXNmWqdRyoNMO5yqt8Zc%3D&r=
eserved=3D0
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
