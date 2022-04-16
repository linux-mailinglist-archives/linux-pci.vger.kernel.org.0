Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B6503623
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiDPLHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 07:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiDPLHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 07:07:46 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0F1CB31;
        Sat, 16 Apr 2022 04:05:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c1so8138335qkf.13;
        Sat, 16 Apr 2022 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tjCwNy7RZXxZJdAC+JulQOtn63QPnfqne4iR8XvOSk=;
        b=RdMsiYZGszmO70+SYVt/9mW6om6WqD0ZV7uWYpPn3gGsfFI63jaPf6RCdNw/f/jvjg
         3qhkMt4kTZMe7ywHDHXZswZ2xD8whO/GfewTQ1BTq5cJ4bgpwdcs+jkcrQbSE1S2hGon
         tRCVryOJBfyWG0PGihc6Lcar7qkoy/Mt8iNBCDJ2GLguCwyZ2wHFgX9xGN4YNphT87Pn
         tNkLl3qjYKDoMiLAYCObN9aSnNQewvUFt8AhEpvvORl/BsPvVb0crBjI/jDsBVZlg+rj
         a5cwsEIdu6AIbGj7NW/Z+k78O45+s+O5pj04iSZ6i1vP4gxClWgV83BmFAlip4G1nnjO
         hqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tjCwNy7RZXxZJdAC+JulQOtn63QPnfqne4iR8XvOSk=;
        b=yycY1I4/JLgp7npk/UOzAERMT0DWJNkYiSRWgVYoYNEGbgu0xrtMgeno+kUUtoJjXi
         T5ojmUy/U5jX6JoE3JjsNq76pHUj6IM3B45P3qD/x7KzdvbM1ltXmBSG0Sn/Ii2LLUDl
         0PzCL+PurO5q2diHjxK1TOrQukzCKHRl2/qXaZKtG73dWzx1secNx8URjxeZHnv4bF5X
         FHp62oAMAEq9njYj4fSeheYCFuuzsZTneYVv4Enb39/8sGHZDeib4ZvKoMZu0y+b+eTw
         m/T5CWBDKaWs2z4Em+EWxhAIAHhbJQHWaZik/A5YWEZCSwQx69UYM+xNJy6RQrf6FF2Y
         aJdQ==
X-Gm-Message-State: AOAM532UGY++5qXwVfmdLHUVMYqHO9muMDXgJCUFbWfSSlzKrysFAzLJ
        vhdX/TZfkiHQDOYYSefYB0PvvyBZpPZpJ3cm
X-Google-Smtp-Source: ABdhPJxiWNWboafGa0pm1NGh8x4nUNaJD2LAsJm7xIzh/1IZ+EQ4YfbsRqfNqrrSOyeg+yWb0nYNvg==
X-Received: by 2002:a37:ad14:0:b0:69c:8c86:7d9 with SMTP id f20-20020a37ad14000000b0069c8c8607d9mr1665388qkm.383.1650107111107;
        Sat, 16 Apr 2022 04:05:11 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm97026qtc.22.2022.04.16.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:05:10 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Enable rk356x PCIe controller
Date:   Sat, 16 Apr 2022 07:05:02 -0400
Message-Id: <20220416110507.642398-1-pgwipeout@gmail.com>
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
v7:
- drop assigned-clocks

v6:
- fix a ranges issue
- point to gic instead of its

v5:
- fix incorrect series (apologies for the v4 spam)

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

Peter Geis (4):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller
  arm64: dts: rockchip: enable pcie controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 ++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  52 ++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
 4 files changed, 197 insertions(+), 13 deletions(-)

-- 
2.25.1

