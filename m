Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8383A536EBC
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiE1Woc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 18:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiE1Wob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 18:44:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1CFB36D6;
        Sat, 28 May 2022 15:44:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so7209587plh.2;
        Sat, 28 May 2022 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=92XKyxi0NzOHImwEaY7u1Ue336ZJHzFbI2q0mbjzPnY=;
        b=HU4T4ua91/qz2/rQFff1E1UI5JiHLClbkXnlpC8NqDiWAa84xo/g1fe07kZIfzFOo+
         /RsfCN69Q3au2zRKFcafl566xASs/UxE3n4FuJe3a80d7R+5HDBsQ5y7Eo7+OX9F9EB/
         p3Ni7F+EY9UzQSMR5GvIUVO/dhFVPmA85l6ZcjSnKjfS58E2J51kf5tabwdMkZ0w4Zgf
         Unv1/Pl+TkYZdekbDArWpecjxVXQw3LBazPJGksFHeprBRSfkMZqdnSlM6qMPzvmPQo0
         /8CuJF8FfmVw5+2hN0sR+YG7D3hTGBJ740YpTRU8pmB8NGzYig+EQ/XTL0r0Z6zGzx2u
         Lpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=92XKyxi0NzOHImwEaY7u1Ue336ZJHzFbI2q0mbjzPnY=;
        b=FOgM3Srj8r+6QHnj0/SCLNo3hv/63XP9Y9zWbhRhBnxdtQpMs66Q/mgS/DNF1DCInO
         llpN0WW6KF56GV+O2cFi4LePU9kAbdQSZlQvgtpGuAdvk3VEYydEmQa2WaUCZgxn6NQ/
         tT1gxv7WVYUbsTbllyAYBZDHfXTDmgHTFNrckk9OerQIxepcV+z/rnnkwgoVKjbJap3o
         lNsMcDAiscBKw/6boJ/ZIviWbqHUXr3OJ8yKFZnFsmRZA3dX9hgOe0bRzm1b9w8sAwoF
         eUih5ob0fAveeu95AyFpDFceGgr1esGJM1SDyiYX1HB2z7V9Sax1T4Vdl4iMEygX41ds
         MMng==
X-Gm-Message-State: AOAM533ZXHgzJuaFnVukxrzWk8bUp6+VwUaAuQCIUoz/5BBkbhSkvEoy
        K1/qTMfG9j+693tIPmL2Qz5w/Jn2JU7B9g==
X-Google-Smtp-Source: ABdhPJxNOCI6gSDXeX1bi05aN85XmFKr3fAXik7FqEDBRdq4LSNWh5XkwWUaDywR1aLePLvzOfjYwg==
X-Received: by 2002:a17:90b:3b89:b0:1e0:c079:9dd1 with SMTP id pc9-20020a17090b3b8900b001e0c0799dd1mr15313601pjb.230.1653777869095;
        Sat, 28 May 2022 15:44:29 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902b41600b001635a8f9dfdsm6159514plr.26.2022.05.28.15.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 15:44:28 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
Date:   Sat, 28 May 2022 18:44:22 -0400
Message-Id: <20220528224423.7017-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2 -- Replace using the condition "bus->number == 1" and instead
      use "pci_is_root_bus(bus->parent)".  Although I initially
      planned to get/enable regulators under and port device,
      this became more complicated for this regression fix.
   -- Corrected the commit message in v1 to say "Root Port DT
      node" rather than "Endpoint DT node".
   -- brcm_pcie_add_bus() now returns 0 if there is an error in
      error in calling pci_subdev_regulators_add_bus().  Instead,
      we dev_err() and turn on our refusal mode instead.
   -- The pci_subdev_regulators_remove_bus() function now calls
      regulator_bulk_free() in addtion to regulator_bulk_disable().
      I noticed that this call was missing after Bjorn had me detail
      the call graph for removing the bus when pcie link-up failed.
   -- Rewrote and added some comments.

v1 -- Original

Jim Quinlan (1):
  PCI: brcmstb: Fix regression regarding missing PCIe linkup

 drivers/pci/controller/pcie-brcmstb.c | 43 +++++++++++++++++++--------
 1 file changed, 30 insertions(+), 13 deletions(-)


base-commit: ef1302160bfb19f804451d0e919266703501c875
prerequisite-patch-id: 23a425390a4226bd70bbff459148c80f5e28379c
prerequisite-patch-id: e3f2875124b46b2b1cf9ea28883bf0c864b79479
prerequisite-patch-id: 9cdd706ee2038c7b393c4d65ff76a1873df1ca03
prerequisite-patch-id: 332ac90be6e4e4110e27bdd1caaff212c129f547
prerequisite-patch-id: 32a74f87cbfe9e8d52c34a4edeee6d271925665a
prerequisite-patch-id: f57cdf7ec7080bb8c95782bc7c3ec672db8ec1ce
prerequisite-patch-id: 18dc9236aed47f708f5c854afd832f3c80be5ea7
prerequisite-patch-id: dd147c6854c4ca12a9a8bd4f5714968a59d60e4e
prerequisite-patch-id: 0905430e81a95900a1366916fe2940b848317a7c
prerequisite-patch-id: 710896210c50354d87f6025fe0bd1b89981138eb
prerequisite-patch-id: 97d3886cb911cb12ef3d514fdfff2a0ab11e8570
prerequisite-patch-id: 241f1e1878fc177d941f4982ca12779a29feb62b
prerequisite-patch-id: d856608825e2294297db5d7f88f8c180f3e5a1f2
prerequisite-patch-id: 92bcbc9772fb4d248157bcf35e799ac37be8ee45
prerequisite-patch-id: 6f4b1aac459bb54523ade0e87c04e9d6c45bd9f5
prerequisite-patch-id: 090ee7a3112a4ecb03805b23ed10e2c96b3b34ed
-- 
2.17.1

