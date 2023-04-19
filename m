Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085346E7FEF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjDSQ5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjDSQ5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 12:57:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E97A89;
        Wed, 19 Apr 2023 09:57:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b87d23729so98902b3a.0;
        Wed, 19 Apr 2023 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681923462; x=1684515462;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Mw/lDYFPiHA1u/ehv8REC3ysizEB/FCc0wvc8nJSI8=;
        b=auM5BcDmbwNVZAKCgqfU9qTBa0DnxHy8uM6XisJiCcrCHfHXxVPZ0K51eR0VI1osir
         uQFKoReanval4NDO6Qf/nKO8IuorbZwjh7zAtOjGElD64zXg62MMqooCSHChva19OyYO
         cdCpU04ia9883BWR9dDzX8docR8aAXXKMaEOD0gxT8oLp9Kf3K1kQyHjOuLMVlXzbC0W
         GCYmoTsthaHH+wjZybNXvzK6NoNcw/FvN8bvImrio3UfSztLIorL/LT58M7GjbaZ0tBW
         0L7cUHKvY3l+XHYXzMIBVUk7GW/brtUEd4YWZ0mk8CEcsJ0vYKeA317isIQf4cJpV9yE
         JdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923462; x=1684515462;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mw/lDYFPiHA1u/ehv8REC3ysizEB/FCc0wvc8nJSI8=;
        b=cMEOQBlCVEjLryHZHsy+4Z51CNWzEkCB8AViiArnlfKKS0QYUDIJmewcStH3L4V8xW
         D9k1NTShK5dbepHQ3HCUhDI6MRG1fWqqfc5A76CJ9da8BJ+Q7Wg8HeUf1jQKV5s4Jyo/
         pgaJvZtfmQKwFlmaILV84qBmaQmoQj2guatUIzqCyHg7vwxMXGmSxAEiCAxwbDhuQv1W
         d8erRAhEOrKNvzJPyQ5wgM5LbM4JPP+r+2PWzvUcyKPXQhoGw9totjcDjN3T7x1YN3TZ
         VMyB+B1MJscrLHrYEzNFsjBnHX4Z9LcPaYmhWBchYD3Du9MboLPcIHoVmNR4vbsUOm1D
         3bEA==
X-Gm-Message-State: AAQBX9dbCESv4MGzqMg4k78oQtTdTxRGxhql6VfvhpJ3GGMEOmNPxRLl
        ZCAAeTbMrmWuyIkyFQANYoGOQCLNRt0=
X-Google-Smtp-Source: AKy350ZYBKCGDhd1cY26gDxbN66Pg1rTaanb9zPQNkQznfkbuskiyk8zKOAlndFEZ6/Ge7NH8GL3cQ==
X-Received: by 2002:a05:6a00:21d3:b0:627:f85c:b7ee with SMTP id t19-20020a056a0021d300b00627f85cb7eemr4641542pfj.2.1681923462439;
        Wed, 19 Apr 2023 09:57:42 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b005abc30d9445sm11188135pfe.180.2023.04.19.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:57:42 -0700 (PDT)
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
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us} props
Date:   Wed, 19 Apr 2023 12:57:18 -0400
Message-Id: <20230419165721.29533-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419165721.29533-1-jim2101024@gmail.com>
References: <20230419165721.29533-1-jim2101024@gmail.com>
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

