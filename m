Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198936D9737
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjDFMqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjDFMqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 08:46:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EB7EDD;
        Thu,  6 Apr 2023 05:46:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so39373607wrb.11;
        Thu, 06 Apr 2023 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680785194; x=1683377194;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3LUgCUJ3lXTo0RsvH/e7ul2FIIbwJbMNQXvMnaF6Gq4=;
        b=YEXNElF0x1G42w/wvyNTyJh0dveBWTtOv6zbgd/Bp4gcjiY9FExF23E6K50/sLYrf6
         c0WbSEUkbL1PSTW7P1umKVPPBnzICqaxE1ZNGV4xhal7onQBwSPOdBTKdiTlaN3hlDYf
         /aNNSmi07+DYGmJAGOePXcY/wc51pWc+jFxGvEvkcaPLApo6Re+4LqvKRP8+YTKvRxwk
         YAuIP/byNfMMmIEhal2lQNyFCEHoyBgYHesAjQY320EBMR9Z4u18WtD6hMLYoBLN72tv
         8gtbkPBezf8WrA4bSuFscLwvHA1xvq5wtetFmjY5gzs1y/jnhHVuePZOqSpAbQhnpJSw
         gOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785194; x=1683377194;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LUgCUJ3lXTo0RsvH/e7ul2FIIbwJbMNQXvMnaF6Gq4=;
        b=KCUMjpNQmuBQ369OZv86sAtOOWxQ7KUVs5LWgq5GiYVGdMAUsiahHmCIT+6XecUhIA
         VLNGH+NTLyMyfp2q2qBZeEsqEFw1++xWE/8lzxVb6r93PJqO0+i9h4/XtJRJzyEJML1j
         ehSbL9oO8Ez+PnXo30IHijeXKuQ3bJCeqzx0Rlg9mE17KGnESvZz+1toF/yBi2TJF4gW
         4mubH65AklvULKY9QA88xwZJ74BQ6ZxLLC8Vh4wRJ7F++NA+JNr0uSnq1L1Gg6+XQFSV
         kWVS2qro71jBDXOgi79vuJnl4lCt28ti5gitdp2nFr92Z5d2ewUU9mwk6CziKOm06+XP
         iljQ==
X-Gm-Message-State: AAQBX9c69VIDOhb7PMXYk9pIfspOAqYC/2WO4NfHdRRGmVkPVukwhOhF
        DoiSMeRg0IhhnBtCr6wXeg4SZNdFAEY=
X-Google-Smtp-Source: AKy350Y1VoC6dI1BR5IOebNUYDGa+b6oqfYVY3ZsWbCSAEklsLWdeoNxHjcKtSx8SrlQXe1Bf4F+GQ==
X-Received: by 2002:a5d:654e:0:b0:2cf:e3e3:5b01 with SMTP id z14-20020a5d654e000000b002cfe3e35b01mr5955177wrv.56.1680785194377;
        Thu, 06 Apr 2023 05:46:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002c5534db60bsm1686714wro.71.2023.04.06.05.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:46:33 -0700 (PDT)
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
Subject: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
Date:   Thu,  6 Apr 2023 08:46:22 -0400
Message-Id: <20230406124625.41325-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406124625.41325-1-jim2101024@gmail.com>
References: <20230406124625.41325-1-jim2101024@gmail.com>
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

  The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
  the driver probe to configure one of three clkreq# modes:

  (a) clkreq# driven by the RC
  (b) clkreq# driven by the EP for ASPM L0s, L1
  (c) bidirectional clkreq#, as used for L1 Substates (L1SS).

  The HW can tell the difference between (a) and (b), but does not know
  when to configure (c).  Further, the HW will cause a CPU abort on boot if
  guesses wrong regarding the need for (c).  So we introduce the boolean
  "brcm,enable-l1ss" property to indicate that (c) is desired.  This
  property is already present in the Raspian version of Linux, but the
  driver implementaion that will follow adds more details and discerns
  between (a) and (b).

Regarding "brcm,completion-timeout-msecs"

  Our HW will cause a CPU abort if the L1SS exit time is longer than the
  completion abort timeout.  We've been asked to make this configurable, so
  we are introducing "brcm,completion-abort-msecs".

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7e15aae7d69e..ef4ccc05b258 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -64,6 +64,18 @@ properties:
 
   aspm-no-l0s: true
 
+  brcm,enable-l1ss:
+    description: Indicates that the downstream device is L1SS
+      capable and L1SS is desired, e.g. by setting
+      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#
+      assertion to clock active must be within 400ns.
+    type: boolean
+
+  brcm,completion-timeout-msecs:
+    description: Number of msecs before completion timeout
+      abort occurs.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
-- 
2.17.1

