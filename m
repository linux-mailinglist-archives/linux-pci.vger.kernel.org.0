Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC90352EB21
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbiETLvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348709AbiETLvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 07:51:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB2120AC;
        Fri, 20 May 2022 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653047440;
        bh=k4fKVQvURjqEQ8MtrJ2m1VCLQBvog7lyn9M2Wt/lV0Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MKjD+jclEwCeFylv0hyyBS+WvHTmuPewzMPlTAPq4SzQ7HIxWMHCty6ASa4JQwjts
         i4zZ0vYjycUJIHJPXmCz4RSB5WtmU7htC0/jVaXw49EzRSz0Oe593S1T5DNGJ3Bj8A
         duJ+9EBhv28L9SHCZLW8pavMUMEJSrR/3AitmwCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.153] ([217.61.152.153]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Fri, 20 May 2022
 13:50:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-940b8fcf-17e7-4445-8aeb-e17f36b41b4b-1653047439840@3c-app-gmx-bap67>
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
Date:   Fri, 20 May 2022 13:50:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220518155551.GB3302100-robh@kernel.org>
References: <20220514115946.8858-1-linux@fw-web.de>
 <20220514115946.8858-2-linux@fw-web.de>
 <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
 <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
 <20220516173537.GA2942634-robh@kernel.org>
 <9496CAFB-6CB6-4BDA-A539-3A6E1B562299@public-files.de>
 <20220518155551.GB3302100-robh@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:SD3Edrf+NaJ//x8ye3V+dsdMGeWh8sRcrH6vyLezIFMvvRfi2kD/w+du5767L1pt7TB3A
 9diq3JRpFJSmaDntiITaiJm2eZhpyfFCpjcf93y/5BMa+mMkKuIkHOmuN6fjAMElAvyjrbt9h18s
 Amtj5SSaEGyHSUtMkNjocxpSMH1INw1kDjl/7AAAPbCPR0mgoLp+E63LMkBfCG09Z4O0eh1HeXkl
 47XVC40CdkXePpbMILRd5yP3FSHED6RQrQaoKM95aJmTccxHuQRmMjL4SS33OZ+NxgGLSUqzUKr4
 KE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ldW5S2z+XIU=:UXxS08Sj+aFSCv9KzQQTl2
 1XnLZLY0FknaXahW1slqvCuFzb2THKkDUdph5QOpPyccApSaQNyeQNhYPecZryHHRWDOx8uga
 QIgdI3TCF3BNeFm047mDBshfAQ8psCtAMxAKCxojFBNNP9lLT9+nbg6LjUdWukSQCPPDbYpjD
 hot81cTZ7C3snYY/gUT9GE7zCEPV+M7OZMLBjktjReL4t32VaHwn/du6LM9G22CigWHx27jAq
 6L16V9eeFWFRy8/rAxw3p+Wa8jCMFdcRuUPGSrEZgML3oRmkOK2KFrREdnOvg4I+knqORYl1k
 pxjxw+AKFkrZiSgX+2pGV3bwCi9iudf70ZU+lpIsPDPX3pYezIyfYHlzxLKmf2v1kiyfM1hiC
 a3EtG1Y0sIPo1sTnWDWBkmcby0riINfmxzTAqZytZ6RUIlHpmxebFsyxFxXskq+GGz63GDjmz
 ZLHoeoRMb5EwAJCf1W1/o7GCSSi8HGqkOEFoFvxY4RDU3Gj9jILxOJfxNiF3A1cuukwBfhum6
 C6wWfevuyyn7z3AgZdiIed+IgAVCYQRdPkz3JJ9zu/n6l+KFbhzebzwbcoLoOqW5twRWa4vw8
 BXsNil/j02qVXJm5RaYlhMsjbHBAvnU8X7LnCCuv9FS4C5NaXy4zKI+FA/gAWXMn4bLErlz69
 RtPNKV8cf+qA4/tQYbR2TZ+gI34nUo2dSlpvDbaIYN08WxG+AGf+qkZAqRS2wJGZPCL6zcgxy
 GI5EFSSu3thLB62bHwpa/wmuTpY5N8hblFje+N0jkUQL7fexaX5FgO8DamSspHAIWKCAESzvO
 jMNrQLd
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

fixed reg-error by using 32bit-address in example, in my test output is clean.

+++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
@@ -68,7 +68,7 @@ examples:
     #include <dt-bindings/clock/rk3568-cru.h>
     pcie30phy: phy@fe8c0000 {
       compatible = "rockchip,rk3568-pcie3-phy";
-      reg = <0x0 0xfe8c0000 0x0 0x20000>;
+      reg = <0xfe8c0000 0x20000>;


i hope yours is clean too


regarding data-lanes instead of own lane-map, Peter and me only find this in special
bindings outside the phy-"namespace" like this.

https://elixir.bootlin.com/linux/v5.18-rc7/source/Documentation/devicetree/bindings/media/video-interfaces.yaml#L157

do you mean converting this binding and add it there and base out binding on it?

https://elixir.bootlin.com/linux/v5.18-rc7/source/Documentation/devicetree/bindings/phy/phy-bindings.txt

regards Frank
