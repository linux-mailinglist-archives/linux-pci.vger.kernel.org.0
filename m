Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126826B08BA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCHN3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCHN2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:28:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB082521EB
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 05:27:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1163320wmo.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678282054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdwwU4SZN57jLYc65t0m5q4ozMpywaQn61AKlSTUX90=;
        b=IclhcuJS4r1Wj2ehrUiQszZVBZTK9pO+Jzz3ws3adJeDGl9owEEGIiGcVUW13/SMxq
         LbouAPpbFGidcW3e55BFNSbWPG/Dqd/Ax3JiNEdSHzOZx3W2/8Cpnu7hApu9W/YmYlv2
         oCF7VvOGQXSmcAnxFI0hv07Utk4sy4minVn62OUM8YGlovGBi+B+3uPn3NCBVznwBiYX
         OVEsTdXyXtu8tDSzoa8dnDfCp9kxs+2XxY9UmYHCvFuMIYe8QaQOBqJml1LqL6C/DDBw
         +qHs3BWrtNrutM/e9SZDIyKsi33nVgzO65wAkLrlLvQ8t/ADACMb1wFu3EU90cCovQ6Q
         AxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdwwU4SZN57jLYc65t0m5q4ozMpywaQn61AKlSTUX90=;
        b=E+O2MvhLqr1CDxjMl90fAvXp9MLmvR9YUTl0Xbr//FCT30PkuZeRpleAQLuxMP7C6+
         bW6fro3nSX474k6/xnSZwaLNeQnXJ6LBcvZsjkOLOKrJufKnA/p7wHKMaq11azEm3Ch5
         xIRhqvdmnOd9d3OwcGNvEOnYxAW7rQ+5od8ZspfKqdM6A2c5jmuFwncPN4zf2hDFrKAX
         uuQ5M4OQMcWXoLqy/qBhCHKVuvWaLgKJzris7BJZYTkjEh8f56Ti5fxSqRBEhJOef2Qn
         xwWkCjVzAh3crYTTuHtuycEzPn6s+ag6emIRih3d+QcFJCueICXRWBV6AVonngvwjewx
         3H8w==
X-Gm-Message-State: AO0yUKXKvgxpWppGFnn86T4PVpZjoQG2mjhHiOmNy2KfO9eI2JSv0mn4
        lAiRGWLAjWLGKDa5TOdTvIFkcg==
X-Google-Smtp-Source: AK7set/Soq1Fvcc7qflRPe93eB2KPEmH/FcDQNhIB1coy2br5SfxGWWl32ofzfkJtiUodMwJmk65YA==
X-Received: by 2002:a05:600c:4509:b0:3eb:32ff:da8 with SMTP id t9-20020a05600c450900b003eb32ff0da8mr17310245wmo.16.1678282054125;
        Wed, 08 Mar 2023 05:27:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003daffc2ecdesm20631491wmo.13.2023.03.08.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:27:33 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/5] dt-bindings: first batch of dt-schema conversions
 for Amlogic Meson bindings
Date:   Wed, 08 Mar 2023 14:27:28 +0100
Message-Id: <20221117-b4-amlogic-bindings-convert-v4-0-34e623dbf789@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECNCGQC/5XNwWrDMBAE0F8JOneDtLIcO6f8R+hB8m7sBVcCy
 RGE4H+v2lvpJTkNM4c3T1U4Cxd1PjxV5ipFUmyl+zioafFxZhBqXaFGNMacIHTgv9Y0ywRBIkm
 cC0wpVs4bDHwzdHLUYU+qCcEXhpB9nJZmxPu6tnGRsqX8+H2spsX1Nbwa0GBvGp0bxzD2w2WV6
 HM6pjyrzwZXfAPDH6z3pJ0OoUf3D7NvYLZhjAORNWwD0x9s3/dvD0BBOWYBAAA=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Changes in v4:
- Rebased on v6.3-rc1
- Added Reviewed-by
- Removed applied patch
- Link to v3: https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org

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
Neil Armstrong (5):
      dt-bindings: nvmem: convert amlogic-efuse.txt to dt-schema
      dt-bindings: nvmem: convert amlogic-meson-mx-efuse.txt to dt-schema
      dt-bindings: media: convert meson-ir.txt to dt-schema
      dt-bindings: timer: convert timer/amlogic,meson6-timer.txt to dt-schema
      dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema

 .../bindings/media/amlogic,meson6-ir.yaml          |  47 ++++++++
 .../devicetree/bindings/media/meson-ir.txt         |  20 ---
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |  57 +++++++++
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       |  57 +++++++++
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |  48 --------
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      |  22 ----
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  | 134 +++++++++++++++++++++
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 -----------
 .../bindings/timer/amlogic,meson6-timer.txt        |  22 ----
 .../bindings/timer/amlogic,meson6-timer.yaml       |  54 +++++++++
 10 files changed, 349 insertions(+), 182 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20221117-b4-amlogic-bindings-convert-8ef1d75d426d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

