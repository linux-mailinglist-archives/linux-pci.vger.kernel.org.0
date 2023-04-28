Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065CD6F20D7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 00:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbjD1WfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbjD1WfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 18:35:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655D1BDA;
        Fri, 28 Apr 2023 15:35:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51f597c975fso307529a12.0;
        Fri, 28 Apr 2023 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682721310; x=1685313310;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9wGE8lEckhtyHamfE+Si7Tf+FLdP4R/QrNZ2YYLB78=;
        b=LI/HpU3bqYqcgk2yc4XDsCLqOVxkrLPD5Pkhnv2x1LYPgqioxl6C5Qn5gN3TgfXZjR
         9XXkIUrl5d8LfQlZopOs3AALUvRiB5x7v5pSef/xfe/rcvl4TKT4vmVs2NXv1ebM7cbq
         gygXPmzFqT33qaYYzRzX3QGCgHGghC34yVRLvpc3scIRkBSSGJ+ZJRolXAui6fxwvAtB
         f5tvvzqeto780Vr92cbOKacRwzCC8NquZEbzs3IjjV9ois4v+Tm89ErdK9X7zP9hZg5R
         7esj4Vw1MXnR+Jm5bY0fcVNfcNunb8ecvLH1qkED+GEZJv9H7b21XTh3QtB8w4vjcVrE
         QttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721310; x=1685313310;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9wGE8lEckhtyHamfE+Si7Tf+FLdP4R/QrNZ2YYLB78=;
        b=GAeXDs17PrlGVz19RwoXQj4+zzYrfHYUl/cWR7ufXoRtvhOdggYUHl60R7IbpUSQ8l
         AAFRU2UcUF9D+vRnxJ0+EnVYb8HtH73GEPSKivZLr97F/PqMPnEsSWosVdlZE2JoLp2I
         qBLXCtpMG9b+2dI7VgG+wva8VKDnyV5XSRbD2omwCJV2rzirumk4sRbzRQ1do2POIyIu
         /4SUDCFcHN/0hnK7sj4fZerOUI4h5N2o7ZTKQ4Arg/WDh/Vt2EHOARW4W0vi1llSJbd5
         j5439K/LV9lOCs3R2SkaIETzngMMog286v6bf+IPYeLuTAfLKoVp3vmonjSOfa3sgLs6
         JaKg==
X-Gm-Message-State: AC+VfDwL98wtqawIWqJmlyigcZvUUYZkvViFFv5rHCe6X1Cpc/lzqoZA
        b8mKVoEaDXMZEsJvNIN/mf3oVBKqr/c=
X-Google-Smtp-Source: ACHHUZ55F9CSNezNW/MWfvmvq/nt+l7GWDbpbZmg2w+R0j60UqA/yPhdGbb90HXYMl/rEYcTXlGx+A==
X-Received: by 2002:a17:902:6b86:b0:1a2:6257:36b9 with SMTP id p6-20020a1709026b8600b001a2625736b9mr6058610plk.31.1682721310308;
        Fri, 28 Apr 2023 15:35:10 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm13657847plk.62.2023.04.28.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:35:09 -0700 (PDT)
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
Subject: [PATCH v4 1/5] dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us} props
Date:   Fri, 28 Apr 2023 18:34:55 -0400
Message-Id: <20230428223500.23337-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230428223500.23337-1-jim2101024@gmail.com>
References: <20230428223500.23337-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit introduces two new properties:

brcm,enable-l1ss (bool):

  The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
  requires the driver probe() to deliberately place the HW one of three
  CLKREQ# modes:

  (a) CLKREQ# driven by the RC unconditionally
  (b) CLKREQ# driven by the EP for ASPM L0s, L1
  (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).

  The HW+driver can tell the difference between downstream devices that
  need (a) and (b), but does not know when to configure (c).  All devices
  should work fine when the driver chooses (a) or (b), but (c) may be
  desired to realize the extra power savings that L1SS offers.  So we
  introduce the boolean "brcm,enable-l1ss" property to inform the driver
  that (c) is desired.  Setting this property only makes sense when the
  downstream device is L1SS-capable and the OS is configured to activate
  this mode (e.g. policy==superpowersave).

  This property is already present in the Raspian version of Linux, but the
  upstream driver implementaion that follows adds more details and discerns
  between (a) and (b).

brcm,completion-timeout-us (u32):

  Our HW will cause a CPU abort on any PCI transaction completion abort
  error.  It makes sense then to increase the timeout value for this type
  of error in hopes that the response is merely delayed.  Further,
  L1SS-capable devices may have a long L1SS exit time and may require a
  custom timeout value: we've been asked by our customers to make this
  configurable for just this reason.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7e15aae7d69e..239cc95545bd 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -64,6 +64,22 @@ properties:
 
   aspm-no-l0s: true
 
+  brcm,enable-l1ss:
+    description: Indicates that PCIe L1SS power savings
+      are desired, the downstream device is L1SS-capable, and the
+      OS has been configured to enable this mode.  For boards
+      using a mini-card connector, this mode may not meet the
+      TCRLon maximum time of 400ns, as specified in 3.2.5.2.5
+      of the PCI Express Mini CEM 2.0 specification.
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

