Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A47D54F5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjJXPM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjJXPM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 11:12:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45455122;
        Tue, 24 Oct 2023 08:12:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd19eac8so6733232e87.0;
        Tue, 24 Oct 2023 08:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160361; x=1698765161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N9/+NUa+wHK0HF99kAFQH1PWNyZJRmq/sRYP/HtkeM=;
        b=Qy7xbmmpprk7o68qbU5++IAXmaAxHn6rWI5+jLpZbFpTcDOE0HWEhpWuLilYMS/bnI
         +ygfVqNBG433lt9Qc8OBJA1u8VboGet55Q74e1HxuCj7nGd19uGBCAtHjd+hH5C+r4yn
         XvxXCG+oNHBJW7Zfc4YxDWyKcuO+b8R+OgLwC0cdBnTdI7pVeJgN4k6569BctaxNqiPG
         cafirZCT5CzwoBbR0Dd4CyteFQpp+ZvZGSpUQ/aS/hiCebGip2Eavjga1QmOiZnrI9od
         PhkSUtTJwkuhNen1E109v3rETtpwe3Cn8WLc7SN2qptdB2na86eaYw/B81KDA5zhptqO
         IPwA==
X-Gm-Message-State: AOJu0YwbuzxUmKGgD/CIV+W+GFIT/OVWNEX2fvDzbknpNjkBTrfFddeh
        tdTTUeJiQdQok0kvklldFIEA9+qKRuoypw==
X-Google-Smtp-Source: AGHT+IFQRbGqxwwWDNyZFLNmwC4u32DEGCwINoeL3rqL0ZmPtayQiSa4V+fMB7LtB04E5CROiWsV+g==
X-Received: by 2002:a19:5e1c:0:b0:507:a58f:79ac with SMTP id s28-20020a195e1c000000b00507a58f79acmr9328157lfb.33.1698160361182;
        Tue, 24 Oct 2023 08:12:41 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id l8-20020ac25548000000b005032ebff21asm2141126lfk.279.2023.10.24.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 08:12:40 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 109F414D4; Tue, 24 Oct 2023 17:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698160360; bh=nOWykBjoXapYzbbqt/B6vaxHD5OyGUKgl7kHm6hJUts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkGmnmIKbZXn3i3S+B4zJWjLs6YwRCYrx3zQ/0kyZg5Y/w8mpBDNGeqPTu8BDV5rq
         jje4lJWt71pDKMowQs/obwiXUj6H4WVqJM5KedZ6kxYcwgGYPQsDzHerbBd+qeK+no
         MTRI45wloCJpt/7K6zdx9SGVxsBfUempa1m/ENMw=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 57FF514E7;
        Tue, 24 Oct 2023 17:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698160246; bh=nOWykBjoXapYzbbqt/B6vaxHD5OyGUKgl7kHm6hJUts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAnZ5gtPK8mM3eEH4aTkJGHHxRvBNJtNK4kGrk0CYhTG4AEKnQKNIPRPCcuti4T1E
         7oJX1wj0eJ132vMInhvaOTYDmRkFXrouTOzfMVtn3QlFbek8AjJWbl+NL8vVFrDoIt
         IHHPQpg9jT9kIiC17HA5YFoWQQzPPZ0VnyYB0UAk=
From:   Niklas Cassel <nks@flawful.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma properties
Date:   Tue, 24 Oct 2023 17:10:10 +0200
Message-ID: <20231024151014.240695-4-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024151014.240695-1-nks@flawful.org>
References: <20231024151014.240695-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
using:

allOf:
  - $ref: /schemas/pci/snps,dw-pcie.yaml#

and snps,dw-pcie.yaml does have the dma properties defined, in order to be
able to use these properties, while still making sure 'make CHECK_DTBS=y'
pass, we need to add these properties to rockchip-dw-pcie.yaml.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 229f8608c535..633f8e0e884f 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Rockchip designed configuration registers
       - description: Config registers
       - description: iATU registers
+      - description: eDMA registers
 
   reg-names:
     minItems: 3
@@ -43,6 +44,7 @@ properties:
       - const: apb
       - const: config
       - const: atu
+      - const: dma
 
   clocks:
     minItems: 5
@@ -65,6 +67,7 @@ properties:
       - const: pipe
 
   interrupts:
+    minItems: 5
     items:
       - description:
           Combined system interrupt, which is used to signal the following
@@ -88,14 +91,31 @@ properties:
           interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
           tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
           nf_err_rx, f_err_rx, radm_qoverflow
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel.
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel.
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel.
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel.
 
   interrupt-names:
+    minItems: 5
     items:
       - const: sys
       - const: pmc
       - const: msg
       - const: legacy
       - const: err
+      - const: dma0
+      - const: dma1
+      - const: dma2
+      - const: dma3
 
   legacy-interrupt-controller:
     description: Interrupt controller node for handling legacy PCI interrupts.
-- 
2.41.0

