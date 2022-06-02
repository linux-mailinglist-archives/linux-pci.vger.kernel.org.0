Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D215B53BA12
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiFBNsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiFBNsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 09:48:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D665D7;
        Thu,  2 Jun 2022 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654177662;
        bh=2iYMbjgyUAEmKKRbCPL6Jl2Wqx6/vlykoO1h/cdX9pU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B2lwuKhhses728holgAZp4oZnvnVyjpESpX5d4Wahe78tNJd3f7G3iHZN30VkwjsH
         1q3k8Lea6OztCKRlH2bP/S9GAYekJz/0C+n+sKdRpScjskIa9I1rRRD5u26It9R98s
         VtpCdQQEYQDUF5VyLUAzEr47GXRxAufe1baxqXxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.102] ([217.61.145.102]) by web-mail.gmx.net
 (3c-app-gmx-bs39.server.lan [172.19.170.91]) (via HTTP); Thu, 2 Jun 2022
 15:47:42 +0200
MIME-Version: 1.0
Message-ID: <trinity-b1d8205a-3354-42e7-8784-0a0cfd7e8a36-1654177662388@3c-app-gmx-bs39>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Subject: Aw: Re: Re: [RFC v3 1/5] dt-bindings: phy: rockchip: add PCIe v3
 phy
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 2 Jun 2022 15:47:42 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-940b8fcf-17e7-4445-8aeb-e17f36b41b4b-1653047439840@3c-app-gmx-bap67>
References: <20220514115946.8858-1-linux@fw-web.de>
 <20220514115946.8858-2-linux@fw-web.de>
 <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
 <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
 <20220516173537.GA2942634-robh@kernel.org>
 <9496CAFB-6CB6-4BDA-A539-3A6E1B562299@public-files.de>
 <20220518155551.GB3302100-robh@kernel.org>
 <trinity-940b8fcf-17e7-4445-8aeb-e17f36b41b4b-1653047439840@3c-app-gmx-bap67>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ou72G3HO5kBx6mld4VIc7l+uMCSnBYkop7SJ5NIcA1Q3jsvlKS/T+4A2TSpMYReYX1Th0
 GAypuTa3Dp5BK76Enhpr3QRdwCqTSZRqGvWRg8QAKYTGYvWejEs9dbpyaEqq1FTO8xZ16d538kB5
 eY9I2r3Q0tpRm2I9dUl60ZMM4o41OGb7zWBlZPLHfp4gZlwFehrFuARn0k53XVU1e8bI19FDn7pR
 qURa9QP8VTUcbDNiMTKY7o/g6JQGRjPw2uNLkyeSpz/dp0nuEC+MWu+Iff69VEglUCvsEE4gwi++
 +E=
X-UI-Out-Filterresults: notjunk:1;V03:K0:AM77h1kBGk8=:BFWCs43+kuOa1+j+QUaBrc
 xUewSLTR6sWjcX/t/JXh6voUcMsVSiBagkHDIcOTlNTHngfeHJSZy8Qj7NHOeJQYRHMfHHpHi
 OBI7kmLwzjW23tCFGSYcTTeGYqr2gzMT4Bnzae8XSCvQrD1LwapSpYhvVKv64Qs4wMAkMZSIl
 M+ydn9ktzWPygx0j0usL15amBFWotiOtewmog1LE7yNkOU0RUIjZgFTP66BCQF7JszrotpQ4J
 DaqDPvH6nNl5DnOAtVyWx1GhR+E4hKsdmDo31jw0rmPgzhFzc2SyKU1IM4oBuJ1jSHW+F2RVC
 T2Ag9HLokhVoa0xIWI9gTRE2IojuWWwxplNXf64p7laHinWjbw+7Bjefi9gLm6OK2KiwuH9jl
 D1PbqX0gA9KwsI6peS5UrWANHghNgDGBLS+8hz6ecsFnVm/FhvWhSY1tAhnxlQSDq9OCVcYkq
 EEG1LoMz7j3VrpzjjZdh8VzhiBNG8urgDCdnoH0QsbbtIsIPZjmFoLwe/GoUHRCNrsv6G2CBi
 /khwDm2OWPOJ8Qr3lVaN8Lb8NoroO89YRCX28sgqrBe5ROrHU2AvXtRvbBCBR6B35whGF4Lgf
 N9RYAy4YdWkc3DYijq2gAUA79W1kl4vFpsD62UNn1p+x7qv9jmVBH5oRbx1X+ZvA8Y9dVftqr
 XTYPb/N4sU55JUh6+t6k5wOWcRzlOfW3I0uiKjPp2l0wu1Wa92JKn+DS7AIbsXsSMJx2EQFP+
 q4ydhp2uVyKH89+WcAnpuDKsndqtgejGlenvaSIWRY/adCbtrkjuBFgf4/BEtVcmYb8b+ErdN
 qXsGcYA
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Freitag, 20. Mai 2022 um 13:50 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
> An: "Rob Herring" <robh@kernel.org>
> Hi,
>
> fixed reg-error by using 32bit-address in example, in my test output is =
clean.
>
> +++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> @@ -68,7 +68,7 @@ examples:
>      #include <dt-bindings/clock/rk3568-cru.h>
>      pcie30phy: phy@fe8c0000 {
>        compatible =3D "rockchip,rk3568-pcie3-phy";
> -      reg =3D <0x0 0xfe8c0000 0x0 0x20000>;
> +      reg =3D <0xfe8c0000 0x20000>;
>
>
> i hope yours is clean too

have you tried it?

> regarding data-lanes instead of own lane-map, Peter and me only find thi=
s in special
> bindings outside the phy-"namespace" like this.
>
> https://elixir.bootlin.com/linux/v5.18-rc7/source/Documentation/devicetr=
ee/bindings/media/video-interfaces.yaml#L157
>
> do you mean converting this binding and add it there and base out bindin=
g on it?
>
> https://elixir.bootlin.com/linux/v5.18-rc7/source/Documentation/devicetr=
ee/bindings/phy/phy-bindings.txt

is this the right binding to add the data-lanes or do you refer another on=
e (have not found phy-provider)?

regards Frank
