Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED6503580
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiDPJL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDPJL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:11:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A795641FBC;
        Sat, 16 Apr 2022 02:08:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i14so7807921qvk.13;
        Sat, 16 Apr 2022 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaIKipARCSUs8/GjcWOy2SmGh5J0TCwFLzQa/H9W+0o=;
        b=qBe2O2Un/tFZGSt7Z8LWul8/RlBmIx9qaLTv0cgWtS1ooREPKJYbAkwYW013/mvK0N
         xrEQWBBj7spv0blUwH2D32JbSfwe1fN01+ZHHEcraKWwKbeQcbZBT7RNwfXU7lz+fjB6
         cpuqcUhhjOkMe6i5JJCyNYmL2o78ITGo+tBsv/Gn/VzkHjnb/+vVcY1GO3KCCT/iKZBq
         lPFP/sWd5YOhwMPHPnFCTALZWAymn7fEWLhCpZA/sMzmXthy6CJZCqCGjLutdr4+Jb5F
         ADyRk26uzNfJQwVeOTelUnuAWO2r97oCPzr7h3mbwdISKVs9PbIu++6hddFM9CIi37v1
         8mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaIKipARCSUs8/GjcWOy2SmGh5J0TCwFLzQa/H9W+0o=;
        b=4deDqOSFGJ0UVO9S4WqsMrsC4m6rmLyXI2StuP3YPlcsSLLeNsVshxIV+uVCeWJzgr
         qDKIXRqRmgxJx3GJkYE0K2oPZs5+F75CeJ5LGEUr67zKn5fyJLGsYmVULdDB1+6mmaLt
         oUhoOHk1yJ/WXI9uOx0g8fMaKnkaHyi5OIViJ1m0+60AUxp4mjrC5aoIcEc/bho8oGBt
         84aHVSgnqb8AGB/lj+c8yhL6I/vUuLDG3JBR8rEpkmA+80r66AkWuJ2IFwzADWu003HJ
         wAOTe25eDQ1rQhYlf3aZO+uTdk9MgVaXVALkEkmonir4+rXDiwCQ5gy0G3ukuCr+Q75C
         07Pw==
X-Gm-Message-State: AOAM5335xbHYzFilGtb7xlG7KA0VYdnJZZb8ujNniiyT/s2/xZSO9uHk
        cEeuRmNSEqalwwtFl8iiGWM=
X-Google-Smtp-Source: ABdhPJzuSsb8XVHbYS5rSo2Rs2MSGoRGsrqQidGJ8cFtLkYS+7Gcu56sRUB1flXnMBpd8AR0HJSyTA==
X-Received: by 2002:a0c:ed46:0:b0:444:3e69:767b with SMTP id v6-20020a0ced46000000b004443e69767bmr1816176qvq.71.1650100134761;
        Sat, 16 Apr 2022 02:08:54 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm4630394qta.52.2022.04.16.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:08:54 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Enable rk356x PCIe controller
Date:   Sat, 16 Apr 2022 05:08:40 -0400
Message-Id: <20220416090844.597470-1-pgwipeout@gmail.com>
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

*** BLURB HERE ***

Peter Geis (4):
  dt-bindings: pci: remove fallback from Rockchip DesignWare binding
  PCI: dwc: rockchip: add legacy interrupt support
  arm64: dts: rockchip: add rk3568 pcie2x1 controller
  arm64: dts: rockchip: enable pcie controller on quartz64-a

 .../bindings/pci/rockchip-dw-pcie.yaml        |  12 +-
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  34 ++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  55 +++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
 4 files changed, 200 insertions(+), 13 deletions(-)

-- 
2.25.1

