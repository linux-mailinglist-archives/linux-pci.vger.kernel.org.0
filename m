Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9876DE1AC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDKQ7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDKQ7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:59:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337071BC0;
        Tue, 11 Apr 2023 09:59:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63397c54c5aso1194882b3a.3;
        Tue, 11 Apr 2023 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232367; x=1683824367;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QLWqkwPyAaDungSe3XNUQGsoacGsQAY/ebZXfHlHpHM=;
        b=CxYeSnLq9uTKW6PNYtsC+srxJtyl2y98bsXC3HhdiZPMt0harzTTMRHdIeMmCY4pSv
         1IITqNIl7SYKjY1VWZaoF0G7FXkulptaLcfy7KeV5njuReLK98DOlk6OjYWyDYh0+7ri
         EN7wN+2LCrqvc78QddOeMMdVZ9QuVl5k4hSX398BtmgwvO4KHcbQsT9wNMJwaXyP2aa1
         fQcupS7JVZoYQJYkgnWgVww88CayYagM10O4YhfJeiKICRznxIxPWcIJvKgV0AwwC12i
         ifSkbf2YFR4p/yXb82xtVTlcbuEPyaUcZwPeZDuedNP01/qxSMyKOPu8Z7SptmSLL4T6
         +yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232367; x=1683824367;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLWqkwPyAaDungSe3XNUQGsoacGsQAY/ebZXfHlHpHM=;
        b=N6V31KMd8b8i2IU17r4onkQ1KKInrI1p3c9+VIeujgEk4vHySjUvJYlj+AYaR7Hoyd
         jDx8evlm/+FJSiTG78+jbKXbYsW++74LQmKOlKZSgv7g2x/S8nq+vT3aqDsMgbLIgEBv
         OTtDSdoVIkHQ82z3iv0FTm7SWBZIACU1AvT4a4aTUAVxJQtSB/X39jHATr+P7UZ7Lmfs
         tVUSvNoxCwk/hMp/tsol+AXE/1b+5CRQHanpvpY5hcDwtFeb+J1ZI2PuodVL7ZY3SxSw
         pl5QreYQEzUi4hJb8w0yrH6k5jfs0VmnmCui/GAD9aCmYWyw4oEH8i6vvfbIYowUFVbN
         7OUQ==
X-Gm-Message-State: AAQBX9dUtJxkWFCAYQhYB86rliFM4oq7S1eJp4WIbIRLCDlkaxu82gko
        7AByRvPI7DUWS74eCctaOaAbC9mTlTQ=
X-Google-Smtp-Source: AKy350Y1iWodMhWMKjTVKI+jACxjchJoEQj8AoSrxrW9+8KHznK4dlbBUoeYX+WelG/T8rVdmzN9Xw==
X-Received: by 2002:a62:4e83:0:b0:5a8:8535:18b with SMTP id c125-20020a624e83000000b005a88535018bmr12127787pfb.11.1681232367455;
        Tue, 11 Apr 2023 09:59:27 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b0063989aab89fsm3484519pfo.23.2023.04.11.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:59:27 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Date:   Tue, 11 Apr 2023 12:59:16 -0400
Message-Id: <20230411165919.23955-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411165919.23955-1-jim2101024@gmail.com>
References: <20230411165919.23955-1-jim2101024@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regarding "brcm,enable-l1ss":

  The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
  requires the driver probe() to deliberately place the HW one of three
  CLKREQ# modes:

  (a) CLKREQ# driven by the RC unconditionally
  (b) CLKREQ# driven by the EP for ASPM L0s, L1
  (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).

  The HW+driver can tell the difference between downstream devices that
  need (a) and (b), but does not know when to configure (c).  Further, the
  HW may cause a CPU abort on boot if guesses wrong regarding the need for
  (c).  So we introduce the boolean "brcm,enable-l1ss" property to indicate
  that (c) is desired.  Setting this property only makes sense when the
  downstream device is L1SS-capable and the OS is configured to activate
  this mode (e.g. policy==superpowersave).

  This property is already present in the Raspian version of Linux, but the
  upstream driver implementaion that will follow adds more details and
  discerns between (a) and (b).

Regarding "brcm,completion-timeout-us"

  Our HW will cause a CPU abort if the L1SS exit time is longer than the
  PCIe transaction completion abort timeout.  We've been asked to make this
  configurable, so we are introducing "brcm,completion-timeout-us".

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7e15aae7d69e..f7fc2f6561bb 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -64,6 +64,22 @@ properties:
 
   aspm-no-l0s: true
 
+  brcm,enable-l1ss:
+    description: Indicates that PCIe L1SS power savings
+      are desired, the downstream device is L1SS-capable, and the
+      OS has been configured to enable this mode.  Note that when
+      in this mode, this particular HW may not meet the requirement
+      that requires CLKREQ# assertion to clock active to be
+      within 400ns.
+    type: boolean
+
+  brcm,completion-timeout-us:
+    description: Number of microseconds before PCI transaction
+      completion timeout abort is signalled.
+    minimum: 16
+    default: 1000000
+    maximum: 19884107
+
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
-- 
2.17.1

