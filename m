Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66C612A83
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 13:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ3MKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 08:10:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCEFC772;
        Sun, 30 Oct 2022 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667131823;
        bh=jYKHdFM//CoplzP+MAaQQIKGifnnpHY6F2VAGllHOYc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ScZoQITzgWswo3rkAR/F6fj/7vEnvxc4/0cN4zb2FgrW/CONIZmI+wTrDy8ZldSqA
         9MWDdT6gvfM4FJC/KUIrL80dnyFVeahrc5Aj0Neq7i0UvajQhs82G2MVxJXgwHEeTt
         iLhTgigxi5jv8hFemxiP6p+LrZ0/iZZu9qdyNk5tFlGo2ndFzX+InnULTW/qT31pry
         JgLYYDRPQa67eUEUj3jgQYRTWEYl1aRn/YyLKxzzwwymSLHWCJrf9UHj4BWdCEGBmE
         aEv089OfJoEM94/+RL1B1X01cUEZaJvEwFMyuzKwzW27TA/HJIf/lRrWHPQtMkbH/j
         QqSwOl804Ef0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.74.95] ([80.245.74.95]) by web-mail.gmx.net
 (3c-app-gmx-bap19.server.lan [172.19.172.89]) (via HTTP); Sun, 30 Oct 2022
 13:10:23 +0100
MIME-Version: 1.0
Message-ID: <trinity-f841c7eb-f228-4056-9d04-fd79b49b23dc-1667131823778@3c-app-gmx-bap19>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Aw: [PATCH v3 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 30 Oct 2022 13:10:23 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221029175806.14899-3-frank-w@public-files.de>
References: <20221029175806.14899-1-frank-w@public-files.de>
 <20221029175806.14899-3-frank-w@public-files.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:U1xs1lPpFVVoC9XGOOvCRggbEUpzED+LtWFYBjROwPMvcHLzpncsqe68I29hKPi6Ds8v1
 e3ZwZ75IY96yLg0hWDeCc6jIVLZi/Cd2VSdrmbs6MQl1zskz25TE4tSyB4MtlLWwYjfiLQw5gI1G
 7ymr7j09/C9lxuzxk2g9f0DiDXk6XsRpSM7vRjBs4d/ElGBguErvEwnvnlFz798NIrhPs+d8pH5O
 PGCMmeOyanyVyXDgyHX942W5t8GTEoEJsx/c1DZKyca19l8pvFeEK/bnTz/3B6SEga/w8jDPxFs9
 Yo=
UI-OutboundReport: notjunk:1;M01:P0:CvSn2UOjMJo=;9PYRb0TSHf7FX0WCiZ3RpJWdfgf
 Qo7202cC11UqG2ED7DpMWwIUdv3Nhmx+ONHdoxAFI1kzBembJ/UYTQ/w4oQeW2cP7FQry7YsD
 OitR0/jU9+AmSFwxiP7ZvgNx6uiTQMsIpD6gC+1X5NGOBg2giqcHPKN14Hrn3cipHoTV4F6U0
 L5qf4rDaRjFYzmxZKSr/+cdJ4fDFW48sdDxrRAHpculFgxwMZRFe66xFd5sEBEJmBxgx/YXyg
 LErjF1azPzllBRBeBuqTYYtPzNRi41CA8y4TMeulZJQhCBO2NL6AjifpkL3BbOPOZlI83AhnF
 EH6rXJBVsgdJ7nryU8N2tr7F6hqC/XZHduOBvCdQQgmQWEfvVcWBYIrOS9KVKK9skTn/5vivY
 GPn1zxyxCQD8/wEy1nwvoS9pd2Hz2KSiqcxdhVMrRu2IcPmFcFTVN1Qrv15YUN06YJf8jH2at
 RWooTYLat7r4p8IXieEh1fe1kbapJsBtSOf/BuFpv/8sTST8oRLzk0yVO8hAP7k7iiHldvquJ
 RGbgolHDQQPXr+0YtHuMRffzo0Cw//hG/zuMAYtwl686/qDVsp6dwu+xO/ZCpZYAMyNRhOh0u
 zL6Z4rr+zPnz3KymXT/6qCskjlKi/sMLGLkyHhwWXkrGhOBxHwraWgjfSV23Wo0eNGOmzx7tT
 2bHtxiEyLvNgm2H2EAP5IfRilJnQqBP+CpJXX3AKV5dETYsauSomQZDooVjmZnsp9yF8mGti8
 qQg76zoHEGRI0kcGMrFCW52/8qyviJPVILPsHvVGbSfokussiKODTkF3d5FfARZdy7kf/cTU9
 MLydXkfeVaEzSx/55z0o7+Yw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

sorry missed Reviewed-By from Rob i got for v2 [1] (this patch has not changed, only part 1)

Reviewed-by: Rob Herring <robh@kernel.org>

regards Frank

https://patchwork.kernel.org/project/linux-mediatek/patch/20221025072837.16591-3-linux@fw-web.de/
