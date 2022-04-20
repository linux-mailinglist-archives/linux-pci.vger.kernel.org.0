Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3965088C1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378745AbiDTNIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378746AbiDTNIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:08:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECEB222AC;
        Wed, 20 Apr 2022 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650459879;
        bh=wOmewmRrbd5TBpBZqdHt25VeQoHFPRad0GP83DFE/KA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KnsycIGSKRyZ0zSYB26Acbmgps+aknmDjPdrIVk97n9wZCzqTb9JUdQPb+kLOgW9s
         1eiGH1oOYrToBBcafHSbdNfR0kCycUlJ8Mltx4UTkg8M3VmXVzi+V0E9A3d0zyMJmy
         6TXFZ+TQ3Lk+jyJLchu4+Lw+zbDqL7teMZ1oh1rs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.126] ([217.61.147.126]) by web-mail.gmx.net
 (3c-app-gmx-bap05.server.lan [172.19.172.75]) (via HTTP); Wed, 20 Apr 2022
 15:04:38 +0200
MIME-Version: 1.0
Message-ID: <trinity-bf1af823-9e46-4da7-bec5-6e749a4dc2e3-1650459878842@3c-app-gmx-bap05>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Aw: Re:  Re: [RFC/RFT 2/6] dt-bindings: soc: grf: add
 pcie30-{phy,pipe}-grf
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 20 Apr 2022 15:04:38 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <8b9ad0a6-acc0-aad9-c49d-e4a4b38374bb@linaro.org>
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-3-linux@fw-web.de>
 <02b3fe1c-12f9-8f96-a9b5-df44ca001825@linaro.org>
 <trinity-c60358c4-ebd1-47bf-91e0-9ae0beefd39f-1650389348418@3c-app-gmx-bap70>
 <8b9ad0a6-acc0-aad9-c49d-e4a4b38374bb@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9xmgXgx0V9zQ9oJQ2v4jyZ8k5GDOHaZWDau5uvMohn+mtj1rU3a888flYq5JkzAbi24mD
 FHd6jW/TzjLC2M3aDwNp3kInEFdlDMp+mq2ha/0uYCNocwhoVXzNtHCUDW7cXu16sKCUH7D36rOs
 Ew8bePdsiJqO5iuOwaJ7KZfa213xpuyDOaVzLGmQW0VEb7L3Qr3ka6J3KZZOLDxdbz0DTagUk4HL
 FwkqjHfbMegxDqz0IhXu0RQO3z9bvFV+F2dOOCG/bw04UaHRR/FCH+hlHTqequG6P/qVknBwxrSN
 Gs=
X-UI-Out-Filterresults: notjunk:1;V03:K0:3yJGss0AXv8=:3z9IDXCNImRErPGVveLkWg
 9FT2mUQ/uub+5d3eCaoGXd8z2JJQJ/cbe3gPEp1CpWlXoCK1YZu2z2vCf8SSfXIL1vfVKLsa9
 uZU/9l50P7Fzg+caJijuhBzryf2tfXTOUVtRuT/nxeYZbwOBle3xBUqNdyqqI975vBwyydTan
 BDBPMZm4975M4ANAAYxWJQ0XFVy9wdpSuE02aTa/9q96WzGnyTeiwkIV3pKE9btu+H1eidmcL
 NVYNXBWtRxfs/WMYzclPMAgrKHAqRyP9TcaUtEkCiaPG23o6UPHdlWj0sB8xSGYk0go2NPbH6
 2npwGihW0ljkW+dulz39OoBpJmnAPzjJltc/9A8E42yXqB1N0qcATtrTE0BNTMQB0/R+5GyFP
 Gp/kgCGlpHQEw+kkHMXi9m9byjZu4qjgBlOR5KsHxgZv0pgI3yiwg2FSVQAgzQ7ADvqp3On+G
 5pGfPsM0nZLXqHwjBEeOTSl/i3s5SNw1WiNnXEH3GesYaBvMRPWwzAIyPrJlAGPLaPyI14Izl
 +Q8adU+ytcdUVAtt9bFmjJqfHOg755J1UDNVsBOSeHMnopes1sP6LIkrcqQi7DNjKDVtTVgmi
 qs8w2EXFR/n5kqKO3AkdVso57wm/v3dxxGErPIQkuCEg3JE/52lrMITvVODGmWkewej5Y/jfX
 3uBxui4FFo3Vv0RUVTD3k3/gj0hV4diJ5Zp4jCf5RyWfmssGdNL6/an0zz/sVu7wbNRBGjxzv
 FbDUW7w2OuiN+EVheyKLggtZM2QoweeZGeiUdz9rh8IAbHNuPgK5qxCt4tt6ogkiIeEj4jZ7C
 UBYIbbG
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Dienstag, 19. April 2022 um 21:40 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> On 19/04/2022 19:29, Frank Wunderlich wrote:
> >> Gesendet: Montag, 18. April 2022 um 17:54 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> >
> >>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> >>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> >>> @@ -14,6 +14,8 @@ properties:
> >>>      oneOf:
> >>>        - items:
> >>>            - enum:
> >>> +              - rockchip,pcie30-phy-grf
> >>> +              - rockchip,pcie30-pipe-grf
> >>
> >> These are without SoC parts. Are these PCIe v3 General Register Files
> >> part of some PCIe spec?
> >
> > imho they are shared across SoCs rk3568 and rk3588, but have only seen=
 rk3568 implementation yet.
> > PCIe driver currently supports these 2 Soc (different offsets in the P=
hy-GRF), but can only test rk3568.
> >
> > pipe-grf seems only be used for rk35688 (offset used in probe is defin=
ed for this SoC), which i cannot test.
> >
> > so i have left them SoC independed.
>
> Compatibles should be SoC dependent, with some exceptions. Lack of
> documentation or lack of possibility of testing is actually argument
> against any exception, so they should be SoC specific/dependent.

so i will change to

              - rockchip,rk3568-pcie30-phy-grf
              - rockchip,rk3588-pcie30-pipe-grf

and maybe add

              - rockchip,rk3588-pcie30-phy-grf

these compatibles are not directly taken by any driver as the nodes be lin=
ked via phandle (rockchip,phy-grf property) from the phy driver (rockchip,=
rk3568-pcie3-phy / rockchip,rk3588-pcie3-phy). So these compatibles are on=
ly in the yaml and dts present.

regards Frank
