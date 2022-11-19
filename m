Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D9630C81
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 07:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKSGiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 01:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSGh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 01:37:58 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F560B4F1C;
        Fri, 18 Nov 2022 22:37:56 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-142612a5454so7803925fac.2;
        Fri, 18 Nov 2022 22:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLYrlsSUJ/3iV70MlNgEm3O6sI1BB8dOzm7Fo6KqsgM=;
        b=cNFOo+VqMgo+mnOiJFXxMwMeFQLoitwcWJzIOOFWlhDZn66wiP2M4eBUI7NktrM1uC
         yaoxkbPYDfgg1iDxd9fZ4xi9O867toY85OU0FO1wgrIcYtErgNqSkIaDFS1yLEWy06Ze
         Nw1/AIkSKmJKMc018JElW0dxYRL+GkqGyoV263phPIjoXOrycZ0f4UAzEZVysgHM2sCC
         u3DTAZg7k0XUYqkROhzjmjl20OPHdLpF2N4VWXL/gTSjK7lRgBotEJdsiOLa4wIH6cX7
         RdwHdpMT7MwsU0JqQ6wxuSX6BvrKyH1TcIs0CmWyKM61aIq78ZXPr1jlmFDGDcT3Hvct
         8DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLYrlsSUJ/3iV70MlNgEm3O6sI1BB8dOzm7Fo6KqsgM=;
        b=JNHys+KzBdTEcO+lu28uAqacEaqwIcH0i2GzKSxcghntUK/4R7o/SeDGb1I0oPJaSv
         NzPtsfL3SkUm8js6oLcoQs1/j97FJjIET5w0pWacBv44whuB3KozQQdDdXKFYhKMiVO/
         0VB1nKwlNgZLdRrAb/AQUHKEZIAUE7WyCpEj7/3NkDMDGktUBB535ET3umx2HWa346YC
         brAwTW67rpiC0RKIgsQLVgnGDh5AoApOXhNO5yKx1Idmh3TbE8g4SoaZJoxzLKcmI6tb
         rQ3S/vh84woLhkahSqJbZilb9S/j/RoYzgpV1U1/gHmqjMbI+NfIKvnCRMvzisGcEyjc
         91MA==
X-Gm-Message-State: ANoB5pkTMheAmDzaX7Zo7GdTJ5Px/iv+4+rRAv5RbpNS0zwCEuYcw1vj
        AA+t9Qr68koZ7h6vo1/JFzP7w4KsyilzC19Vfxw=
X-Google-Smtp-Source: AA0mqf4YHBgpQyRnlsR8IJwpaWfoiK6RVHKjHFNz8PNwpwXg9+N4cVuAs+273DwuP7yKjh9Nyq4wN2dl85vztU/s7dM=
X-Received: by 2002:a05:6870:9591:b0:13a:eee0:b499 with SMTP id
 k17-20020a056870959100b0013aeee0b499mr378364oao.83.1668839875548; Fri, 18 Nov
 2022 22:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20221118223728.1721589-1-robh@kernel.org>
In-Reply-To: <20221118223728.1721589-1-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 19 Nov 2022 07:37:43 +0100
Message-ID: <CAMhs-H99X9aV7cdotCPar6g50KXL+qNS+jM16Tveq9nxfUY4Rg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing start and/or end of line regex anchors
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Mack <zonque@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 11:38 PM Rob Herring <robh@kernel.org> wrote:
>
> json-schema patterns by default will match anywhere in a string, so
> typically we want at least the start or end anchored. Fix the obvious
> cases where the anchors were forgotten.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml         | 2 +-

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
