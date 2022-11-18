Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7562FF7F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKRVok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKRVoj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 16:44:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AA65E58;
        Fri, 18 Nov 2022 13:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419BA625DE;
        Fri, 18 Nov 2022 21:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CACC433D6;
        Fri, 18 Nov 2022 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668807877;
        bh=Ro6AsXlXIrKhb60zReRlANZHKUr4qOa9kHx7oYfaRrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TeOmRVfobV7yYb1UQSCU9V8jYLTo8QS4T+Bb0vu3a5KzzrRxwll6C87rA4yOd9/sa
         4H6F62uXVusVVxyHOVrmJOuwTf/BQv70I+IPq77odKuRhBuuPZz7OfjHs1KKg7ydZn
         femEKyZfbkZBiNd40NM7I6x0izwr1RJ8Yjh2CmUxInvAnfMpnTtSkGiFQFL5+dc9O2
         JZbWlcegU3y/NK25ZCKw3BPhWLH7am1fymrn6a1sQ9wfJpVVbMZ+wZbvE+qtxK4dH6
         CwfP6wx1HOFqLNkeBkFiRvwXHruOsbhLBgH9tY9Fw+MyPrYLL3lHxUubOsRTn7BVX3
         Pv7eWp5YGuUsw==
Received: by mail-lf1-f48.google.com with SMTP id g7so10323850lfv.5;
        Fri, 18 Nov 2022 13:44:37 -0800 (PST)
X-Gm-Message-State: ANoB5pmL3dy/UQ+q8FNq0CAje3wGmoEMTL5soKD6nC20X9TN+jpeZ+IN
        WRATqkw+Koqf7Qd+yCV5hQEW8BM4g+PyAgtKtA==
X-Google-Smtp-Source: AA0mqf5Bn9XdvTzEAk8cfU7PcXIdAzaVCDQ4++OuMxbWnF5OZcAMFxIc1mQBZI4fKU1avrBB58hKEt1CGiPeef4tFLk=
X-Received: by 2002:a05:6512:32cb:b0:4ab:5a19:3455 with SMTP id
 f11-20020a05651232cb00b004ab5a193455mr2857438lfg.462.1668807875715; Fri, 18
 Nov 2022 13:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20221112091923.9562-1-frank-w@public-files.de>
 <Y3QMMKGc6uNFyfWb@makrotopia.org> <46481C3B-3B46-440F-B923-02934E0445F1@public-files.de>
In-Reply-To: <46481C3B-3B46-440F-B923-02934E0445F1@public-files.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Nov 2022 15:44:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrgj97gCSvN7_WbHck5zpJECfVicUhV1P2cw0GONO_Sw@mail.gmail.com>
Message-ID: <CAL_JsqLrgj97gCSvN7_WbHck5zpJECfVicUhV1P2cw0GONO_Sw@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] arm64: dts: mt7986: add Bananapi R3
To:     frank-w@public-files.de
Cc:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 3:07 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 15. November 2022 23:01:20 MEZ schrieb Daniel Golle <daniel@makrotopia.org>:
>
>
> >The device can boot from all 4 storage options. Both, SPI and MMC, can
> >be switched using hardware switches on the board, see
> >https://wiki.banana-pi.org/Banana_Pi_BPI-R3#Jumper_setting
> >
> >So why do the SPI-NAND vs. SPI-NOR switching with device tree overlays
> >and the SD card vs. eMMC switching with dtsi + 2x dts? To me this looks
> >inconsitent. Use either one or the other method.
>
> Hi Daniel
>
> It is still in discussion,if mainline-kernel will support devicetree-overlays [1].

No it's not. We're just in the middle of renaming overlay .dts files
to .dtso. Overlays have been supported for the last 1.5 years.

Rob
