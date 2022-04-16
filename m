Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0267D5035D8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiDPKHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDPKHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:07:37 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E92559A;
        Sat, 16 Apr 2022 03:05:05 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id hu11so7881681qvb.7;
        Sat, 16 Apr 2022 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9inUHyr7AVny3gVU/R/BmEEniU0IUQKkRf4Taim41vo=;
        b=oz8yhF/l7j1i3yf68XRg4ud62SqOkn8htE+H9ziSk1rAhv5GyTKVc8pFmf4VYjx/AX
         Ji1o//6Rf/NldsfRT1M3o5Qmtpq0tLG3TOeNNKcvIj2kcm0ZRMcb1a+klWpJS3oAfs5c
         wRg/gTQorlnqoHo4u3eOgaFo6xmRJeqzxnYa4B+dD8Trsl8aL+fEoX/0Wq4Ie9CAvNxt
         8awKgxKKxc3aGknhg5V8UTdwwnqF8K+eu2BeWY8BYB8A2jGQ0YRfyvPgO936DPbAm8/s
         3y2VAfXIVtwfu2i3VmRsQSDvsW7EK+rVnHPK4N61ySy9I5+IqOFZwYCoudHUr7Mp1cGI
         hV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9inUHyr7AVny3gVU/R/BmEEniU0IUQKkRf4Taim41vo=;
        b=BuisHIDWLFA1lTCZNT7LfRuZsANVifiv7dASUSvTnVLax3N5mJqW7+ZHZuCaRlgxyz
         Txfn2xH26x6qDdmbxd+ufqMrspyt7jW+3x9aU8HnrF1ryLQwPcMKDlxDe5a3BpJOGdV+
         1XYbQUxyqRlCeZ03VHu2K7hVsBHDI76W3jEErlXL50DwqdW3KlrOMqMjxXRq9tyFJBeU
         hnef9GK68/zBW3JWvijtkTqP5lMvLSv2iou4W7JGKKNy/RQ2ruBM7zG8J0yy36AK5dpD
         dQNROiLqmXMADUJHl1y+v87wviVjGsP9iebuUHZJAnU4zqIfSj+HEHqTzc8ySGTryGEv
         8hCw==
X-Gm-Message-State: AOAM53368b/BKHhmkwaTipjS+4WmSIXusEyWoyvu6BD8CRyGdc739QeW
        HXDCgwSgWrwD3p4gKK1lNoZ27Zur6+bOAiQ8
X-Google-Smtp-Source: ABdhPJxyGGm3YWc8XeHJDwE2KHJ9f7JmSVfLYhpJc6jV3R5ze4PEDKB6ReplabXTD6qTJCjdkBfYgg==
X-Received: by 2002:ad4:5caa:0:b0:446:e39:a117 with SMTP id q10-20020ad45caa000000b004460e39a117mr2154748qvh.1.1650103504465;
        Sat, 16 Apr 2022 03:05:04 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm4263188qtw.67.2022.04.16.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 03:05:04 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Enable rk356x PCIe controller
Date:   Sat, 16 Apr 2022 06:04:58 -0400
Message-Id: <20220416100502.627289-1-pgwipeout@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  55 +++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 112 +++++++++++++++++-
 4 files changed, 200 insertions(+), 13 deletions(-)

-- 
2.25.1

