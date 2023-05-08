Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0506FBAB7
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjEHWCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjEHWBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE877D87;
        Mon,  8 May 2023 15:01:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f394fe5465so4127861cf.3;
        Mon, 08 May 2023 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583290; x=1686175290;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMcPX7+XH5SaqSZhnB/TBndNwmDuSe3GPgEuJujl4r8=;
        b=VdVNDZe3sBM86o4kgh7s/hG71/9NvX4vBEcRwSjXafvuy8kTj5uCwAKBNW0rPbZXhj
         3TJdQblny3mIevgZDOEOl6eiAwM2FfWWbQzyrCh2SVp9VPEJvniSty+muMR9doizTMni
         TDHr3M6l6KJtIdzOILw8beUbiReg50M4GaOtK342qRYhQSOEpmAYp2gjw1v5krXj3oEz
         oCr0L4OzueQ7MKOPv+H/crWucDhawcM1r+o5BguJ3VNCBYk+RaMi5rZTIIwk6JrGX8Jq
         YHsVCWABEWWpRE5FGig22JcNR3efG4V4x2UDsHsJaPrH4ycpXD/bXc1qMRS95PfdD55J
         9YqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583290; x=1686175290;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMcPX7+XH5SaqSZhnB/TBndNwmDuSe3GPgEuJujl4r8=;
        b=JL9pvdxSFMtGyRryj40LRrYyJBI5ZAyBZRkXtJW2YtKBZJFtxBJWId0+W7razc3h5P
         BlmhDUUuahG9HxlofFaZwopplJx336E4pUlqLMjlt3vNV6StB2c0TOvvjGU3KVczqwtD
         fZhiEbXJQXikf/AX/G7LfUNoUP2Vt5buUwiHSRLXEjrSYcOglXIq1QHO4HlVfkcdUBQf
         k6E3nJPPavjqCl5rba1eMO4NCnCMaPIAkqgiGBx7cfkbLPnUPjszRRJRiu78Sdkq1VUH
         6fFOhSMhZo1dADzjCpoh53L5j9Zk54VpOtyklTNXAdd7XjFCmX31WUrRGj2cVl7o5/lq
         Axaw==
X-Gm-Message-State: AC+VfDx9fVcCA24LFMWVUDoxBsGr/wwrCXvBoIemkcRSXwTOr4pYqvPv
        oxSOfrHH0mzJ8zs7fGMmyEcy3FHHFHc=
X-Google-Smtp-Source: ACHHUZ74X+AdPVZ7ThRjyNYy/SKDI899Z3VKFuulzxP9kSFMSkbPUpl6w4tWh9H/0/Kn2xVCRxUdaQ==
X-Received: by 2002:a05:622a:308:b0:3f3:633b:2888 with SMTP id q8-20020a05622a030800b003f3633b2888mr15816018qtw.54.1683583290242;
        Mon, 08 May 2023 15:01:30 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:29 -0700 (PDT)
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
        Conor Dooley <conor+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
Date:   Mon,  8 May 2023 18:01:21 -0400
Message-Id: <20230508220126.16241-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
References: <20230508220126.16241-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds the boolean "brcm,enable-l1ss" property:

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
  this mode (e.g. policy==powersupersave).

  This property is already present in the Raspian version of Linux, but the
  upstream driver implementation that follows adds more details and
  discerns between (a) and (b).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7e15aae7d69e..8b61c2179608 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -64,6 +64,15 @@ properties:
 
   aspm-no-l0s: true
 
+  brcm,enable-l1ss:
+    description: Indicates that PCIe L1SS power savings
+      are desired, the downstream device is L1SS-capable, and the
+      OS has been configured to enable this mode.  For boards
+      using a mini-card connector, this mode may not meet the
+      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
+      of the PCI Express Mini CEM 2.0 specification.
+    type: boolean
+
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
-- 
2.17.1

