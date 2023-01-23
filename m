Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F7677890
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjAWKKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWKKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:10:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F57E397
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k16so8552941wms.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEW/8zJog5ASK2qRbXljjSIfTx60QJ93vwtD14+LGbY=;
        b=Xi9NoL7ue+FLAFSSGnI/2XAjpQ+UTVRx5qe4KqcY34Z1YHDu82IcObWaJKWB8hLoU1
         CbkbOAozjA4dyfKE3PtQiBsJUsoxmASJdVGDkJhqajjCrBOk8L4VG974dtfoMtgXTWm8
         zzd+YAd8BBpcnr/qhqWr9ZVYkgJcT/TAKRuGqrXJFsvGrUIh3kTu/8O9gh25pMVy8QpD
         yYQ9x7PJAkayDMFdSJugqjSvv0yEZB1od1P+cFP5AA5UxYnN6opD+NNbpIMPCtMRljry
         T5kcX+TKSkpLdjGwLtapshYOVrknkUPVJsy1RF02C2ABfPDUmuqzb/lQboOi227gc7F7
         Up6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEW/8zJog5ASK2qRbXljjSIfTx60QJ93vwtD14+LGbY=;
        b=BfQJN8xpnABXNjiw5zE5msRe5oKW7/6P5RGul+6WdeqWVvo1qbywFxY4qzaNHOY9yt
         GioNc/r9jG/qEVJkhG4PN53kkJhqf3P2TwbhZ2fsd2bGGi8Q/B+ue+5VLu2LgJf4i6FL
         Ki5pCviTd+hG3A0pxlfE0qHWe2ZGhmo39/IeDF6N+5zdsjX+OlJvuVz26Nz4L2ValX0J
         5dwM3cIrm/VNKGTUIRCTNhI8DAApmq+Y/END9wuE8uPsiRPTgjDvEBYnM+j8JSm7Rr9N
         YqX/vwiJhs/7b193gBp3rrj47fcqyuUHafwyRlfytPKHxRLIr3QV2bgy4vGOOUKhm83K
         ipeg==
X-Gm-Message-State: AFqh2kqv1GYHfw29f4oVaPIM8n9x3EujmGbsTyxDiLlSZUGYzvM9opTn
        WJ774d1ACWnAeJchKvyypaJymQ==
X-Google-Smtp-Source: AMrXdXvOLzdEZ+5tsjlSq6NFgEVoE9bw28HxzSxeJSvTcruIKayc/Hq3oGuybhxXiJbtg0VDk9DhNQ==
X-Received: by 2002:a05:600c:1e21:b0:3d0:7fee:8a70 with SMTP id ay33-20020a05600c1e2100b003d07fee8a70mr23729461wmb.19.1674468600579;
        Mon, 23 Jan 2023 02:10:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:00 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/7] dt-bindings: first batch of dt-schema conversions
 for Amlogic Meson bindings
Date:   Mon, 23 Jan 2023 11:09:57 +0100
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVczmMC/5XNTQ7CIBQE4KsY1j4DtNDWlfcwLvgrfQlCApXEN
 L276M6driYzi282UlxGV8j5sJHsKhZMsZXueCBmUdE7QNs64ZRzxtgAugd1D8mjAY3RYvQFTIr
 V5RVGNzM7CNtzaUkTtCoOdFbRLM2IjxDauGBZU35+Hitrcf0NrwwodDPlQkyTnuR4CRhVTqeUP
 bk1uPI/MP7GpLJUUK0lF1/Yvu8vs7aotRkBAAA=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Batch conversion of the following bindings:
- amlogic-efuse.txt
- amlogic-meson-mx-efuse.txt
- meson-wdt.txt
- meson-ir.txt
- rtc-meson.txt
- amlogic,meson6-timer.txt
- amlogic,meson-gx.txt
- amlogic,meson-pcie.txt

Martin Blumenstingl was also added as bindings maintainer for Meson6/8/8b
related bindings.

Remaining conversions:
- meson,pinctrl.txt
- pwm-meson.txt
- amlogic,meson-gpio-intc.txt
- amlogic,meson-mx-sdio.txt
- rtc-meson-vrtc.txt
- amlogic,axg-sound-card.txt
- amlogic,axg-fifo.txt
- amlogic,axg-pdm.txt
- amlogic,axg-spdifout.txt
- amlogic,axg-tdm-formatters.txt
- amlogic,axg-spdifin.txt
- amlogic,axg-tdm-iface.txt
- amlogic,g12a-tohdmitx.txt
- amlogic,axg-audio-clkc.txt
- amlogic,gxbb-clkc.txt
- amlogic,gxbb-aoclkc.txt
- amlogic,meson8b-clkc.txt

---
Changes in v3:
- Dropped applied patches
- Added acked/reviewed-by tags
- patch 3: removed invalid secure-monitor property
- patch 4: added a note on the commit message about the meson8 compatible
- patch 9: fixed mmc compatible bindings
- patch 1-: unified PCIe instead on PCIE + PCIe
- Link to v2: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v2-0-36ad050bb625@linaro.org

Changes in v2:
- rebased on v6.2-rc1
- patch 1: fixed power-controller, added const: amlogic,meson-gx-sm
- patch 2: added const: amlogic,meson-gx-efuse, fixed secure-monitor type
- patch 3: updated example subnodes to match reality
- patch 4: added reviewed-by, added interrupts, added const: amlogic,meson8m2-wdt
- patch 5: added reviewed-by, added const: amlogic,meson-gx-ir
- patch 6: dropped applied
- patch 7: dropped patch, replaced with deprecated in the title of the TXt bindings
- patch 8: fixed title, added reviewed-by, added interrupt description
- patch 9: fixed example indent, added reviewed-by
- patch 10: fixed const: amlogic,meson-gx-mmc case, fixed indentation
- patch 11: added reviewed-by, fixed title, fixed bindings after rebase, added clocks/clock-names as required
- patch 12: added reviewed-by
- Link to v1: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org

---
Neil Armstrong (7):
      dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema
      dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to dt-schema
      dt-bindings: watchdog: convert meson-wdt.txt to dt-schema
      dt-bindings: media: convert meson-ir.txt to dt-schema
      dt-bindings: timer: convert timer/amlogic,meson6-timer.txt to dt-schema
      dt-bindings: mmc: convert amlogic,meson-gx.txt to dt-schema
      dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema

 .../bindings/media/amlogic,meson6-ir.yaml          |  47 ++++++++
 .../devicetree/bindings/media/meson-ir.txt         |  20 ---
 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |  73 +++++++++++
 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  39 ------
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |  57 +++++++++
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       |  57 +++++++++
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |  48 --------
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      |  22 ----
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  | 134 +++++++++++++++++++++
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 -----------
 .../bindings/timer/amlogic,meson6-timer.txt        |  22 ----
 .../bindings/timer/amlogic,meson6-timer.yaml       |  54 +++++++++
 .../bindings/watchdog/amlogic,meson6-wdt.yaml      |  50 ++++++++
 .../devicetree/bindings/watchdog/meson-wdt.txt     |  21 ----
 14 files changed, 472 insertions(+), 242 deletions(-)
---
base-commit: afb812b3dddfcc711bf2d8a1a8a61378b3af4f8b
change-id: 20221117-b4-amlogic-bindings-convert-8ef1d75d426d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

