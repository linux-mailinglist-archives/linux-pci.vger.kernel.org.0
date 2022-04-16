Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8843350356F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiDPJEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiDPJEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:04:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA941066D9;
        Sat, 16 Apr 2022 02:02:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r25so7218558qtp.8;
        Sat, 16 Apr 2022 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1UfUXhPrPxMteCJHhzwzwmpGBQkHn9blBEyoIzeJK0=;
        b=jKEejKUggWKkDysTid4LHWwVCt73jIBp6T7U3fQzJ4tFuW3MQMsv/ri+jfDKomqMQq
         laAN2GlIClZRq1l/QuwlPY+EHLm3ezoeISbE2z+iN01JHhn5aWC6LJRuOeNkTfdn9sCN
         ChwEiYQkIejhqaW8qG/1PcD5WumV7x0UrdMXDLTlB8GEvnY45N0G1xQaywveqdqWBjVI
         z9/pOr0oOWzlpqUXN85+Lll/cvA3zz4m3L0I9Y+Zit8cggh8ZRbwE2J2jdonR2me0nZm
         Tft7JqzY6XcsYVzK/mlL61L6YQOgCWL22UuEQhpi9ZPM9sg3LlqL5hPuJ1pNLUCZb9Fh
         RSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1UfUXhPrPxMteCJHhzwzwmpGBQkHn9blBEyoIzeJK0=;
        b=o8eKefPxpybzKrD7gh8l5+kz9at7ASz7ChiU1GYxgd8GmWOb3l7zTbjyCZ9/vMToa6
         XbgyM9U9lAGCVJd9nTOtUJ+jf6jFjRsz1fTiHWvIhbTeK/V18fLiGPZAv0/XMzXGl3Vq
         cTqdK34NWs3XsfZF2dRtHgd9VcolZ4+qC+Ap0psv+OhWDy+J3lPzuPMlQ1EhqqrE1HiR
         IdNvfR/Uw8T0JlLmsHoG8R4WXw3Vi5uktU5FI7bZ7qRni8qCVyjTXHAmYIfZYir+MBUz
         bcM5f99EDlHxppWvsiro6IgkdZapABUT7kStxVqnpitA2mJI00nPj4id4dBBJ4nPwMAE
         ec/A==
X-Gm-Message-State: AOAM531r8GQdXHH1z2fvXmvLZhQMwrGsI6Ue9r+zBy+cBCIeB6JYDayM
        33HFAlW1M8I4ksxbHjFW6oM=
X-Google-Smtp-Source: ABdhPJwyVMhIkaZ3RLVGBQpjhDuOBQJVaJlxNYNpMMOJuxN74a1MwpFwVxAwN4i9c47vDKvxBm5Zug==
X-Received: by 2002:a05:622a:4083:b0:2ec:e9e3:1656 with SMTP id cg3-20020a05622a408300b002ece9e31656mr1695558qtb.529.1650099722999;
        Sat, 16 Apr 2022 02:02:02 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm4258085qtx.36.2022.04.16.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:02:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Enable rk356x PCIe controller
Date:   Sat, 16 Apr 2022 05:01:55 -0400
Message-Id: <20220416090159.596930-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series enables the DesignWare based PCIe controller on the rk356x
series of chips.
We drop the fallback to the core driver due to compatibility issues.
We add support for legacy interrupts for cards that lack MSI support
(which is partially broken currently).
We then add the device tree nodes to enable PCIe on the Quartz64 Model
A.

Patch 1 drops the snps,dw,pcie fallback from the dt-binding
Patch 2 adds legacy interrupt support to the driver
Patch 3 adds the device tree binding to the rk356x.dtsi
Patch 4 enables the PCIe controller on the Quartz64-A

Changelog:
v4:
- drop the ITS modification, poor compatibility is better than
  completely broken

v3:
- drop select node from dt-binding
- convert to for_each_set_bit
- convert to generic_handle_domain_irq
- drop unncessary dev_err
- reorder irq_chip items
- change to level_irq
- install the handler after initializing the domain

v2:
- Define PCIE_CLIENT_INTR_STATUS_LEGACY
- Fix PCIE_LEGACY_INT_ENABLE to only enable the RC interrupts
- Add legacy interrupt enable/disable support


Michael Riesch (1):
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

Peter Geis (3):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller

 .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     |  46 +++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  55 +++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
 4 files changed, 212 insertions(+), 13 deletions(-)

-- 
2.25.1

