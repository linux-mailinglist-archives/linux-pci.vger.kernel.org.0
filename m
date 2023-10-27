Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF97D9C46
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjJ0Ozt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0Ozs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 10:55:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FD116;
        Fri, 27 Oct 2023 07:55:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507cd62472dso3759189e87.0;
        Fri, 27 Oct 2023 07:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418544; x=1699023344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fk2PnC+TBXg3FG5uJDTBRvnx6bVdktN6rmeNod/FIs=;
        b=QzCYuv2TwkxM7clcglCr4DRUFkEwAxK+CZFBpquoYlAXzCiI+kPgfHZXN7mJ9S2mUb
         eBZBWOF/zBQzsCHNakk16/htkAkJg+UbJK3tAX0dxeX0568aB7KJ5amDZSXzCPXxtw5a
         UVvc2NIm58T9ahdRQIA9s8gpDAZJWWJqJtrCmRbAxxXkJS84zyup6beQc+s7wKd61FvS
         hUyx352CAHsfB+ljrzWnC0+W/+J8N4+WnexdhvnxQyffFqNuRxSsR/lzYXjNqsPnEF+W
         WiT4h5AtfNysCZMFRaYuQ/LvCLcc6PjURD8cALqzCVLbCEUDhaGICvaODc86KEtBXqnj
         GzOA==
X-Gm-Message-State: AOJu0Yw0ZU7bgPe1AB442eeGyKRu+W9f+8zHsn+R/XD6LNUzF7AfpK2k
        x367HQ0znf43WIVsRXc/Zou0bTxuM8kDsw==
X-Google-Smtp-Source: AGHT+IEzYYjoPF/6u4zI82c8ko/ojtz2kNpjhMJso4ftmQSSFtWDbmIVYrjwdVIHeaM3qjUdCwaFuQ==
X-Received: by 2002:ac2:55a3:0:b0:4fe:8ba8:1a8b with SMTP id y3-20020ac255a3000000b004fe8ba81a8bmr1052313lfg.7.1698418543885;
        Fri, 27 Oct 2023 07:55:43 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id o6-20020ac24bc6000000b004fe333128c0sm300212lfq.242.2023.10.27.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:55:43 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id B5F3C1C26; Fri, 27 Oct 2023 16:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418542; bh=g4psYLhd5gjSDxalQeXnhs04zLy+rcfPqBl/V56L60w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEx2iwkNn8j4yjDgWg5PEk9I4OQ62OlL3McQ3iPK8ucrtcyVaCZA++BBuxS241afk
         +tvmgLjXUWJ6OXYbF3gyIB/rIj84bQQSzOj4CVgtZ7aBBzPkBjc4ETDYQ+6EPVzKGQ
         bPalcZx0e6voSp0n05nQrxDHN2jkjA1h+WlXXTRg=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id B8F4819B4;
        Fri, 27 Oct 2023 16:54:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418483; bh=g4psYLhd5gjSDxalQeXnhs04zLy+rcfPqBl/V56L60w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJK2mPL3V6sdIvNI/8DzoQ280DicAiz1ybel49xaOYVGgm6vBjEdDOWnRjbKka3nz
         EkDfVMmAR3cmtD7f5jPiP57R+PNU1yz622gZcqfvf+va0GyrCfeXMUAAGC1GVh8gqx
         1aG4v1d+RsD45OVZG8fOitBzKkLetiJaLXncEfm0=
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
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory atu reg
Date:   Fri, 27 Oct 2023 16:54:13 +0200
Message-ID: <20231027145422.40265-2-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027145422.40265-1-nks@flawful.org>
References: <20231027145422.40265-1-nks@flawful.org>
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

and snps,dw-pcie.yaml does have the atu reg defined, in order to be
able to use this reg, while still making sure 'make CHECK_DTBS=y'
pass, we need to add this reg to rockchip-dw-pcie.yaml.

All compatible strings (rockchip,rk3568-pcie and rockchip,rk3588-pcie)
should have this reg.

The regs in the example are updated to actually match pcie3x2 on rk3568.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml     | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 1ae8dcfa072c..6ca87ff4ae20 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -33,12 +33,14 @@ properties:
       - description: Data Bus Interface (DBI) registers
       - description: Rockchip designed configuration registers
       - description: Config registers
+      - description: iATU/eDMA registers
 
   reg-names:
     items:
       - const: dbi
       - const: apb
       - const: config
+      - const: atu
 
   clocks:
     minItems: 5
@@ -171,10 +173,11 @@ examples:
 
         pcie3x2: pcie@fe280000 {
             compatible = "rockchip,rk3568-pcie";
-            reg = <0x3 0xc0800000 0x0 0x390000>,
-                  <0x0 0xfe280000 0x0 0x10000>,
-                  <0x3 0x80000000 0x0 0x100000>;
-            reg-names = "dbi", "apb", "config";
+            reg = <0x3 0xc0800000 0x0 0x00300000>,
+                  <0x0 0xfe280000 0x0 0x00010000>,
+                  <0x0 0xf0000000 0x0 0x00100000>,
+                  <0x3 0xc0b00000 0x0 0x00100000>;
+            reg-names = "dbi", "apb", "config", "atu";
             bus-range = <0x20 0x2f>;
             clocks = <&cru 143>, <&cru 144>,
                      <&cru 145>, <&cru 146>,
-- 
2.41.0

