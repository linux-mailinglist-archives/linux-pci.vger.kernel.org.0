Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5F7D9C52
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjJ0O4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346154AbjJ0O4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 10:56:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DC1B5;
        Fri, 27 Oct 2023 07:56:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c54c8934abso31446971fa.0;
        Fri, 27 Oct 2023 07:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418577; x=1699023377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRpY9tB/YHmhHYNiuOoGhQyG1gsbjy5tMgx6aLXKJMQ=;
        b=H7aH/SPkbMXLzkKFaIgBpB3ip4JjPl1ZfCWWlW8NtyhG/Viog0FL7VEZZP7px0vYBQ
         jvvh0zx5woKc8W12uUCuoznMuRtlTMmsT9O3NgvyrBkYv+fjC6OLd2sQDA9JVrdUNmro
         bpg9tfaWXa3NJ6IO4xzTy2PWlCztiA+EdQz5m9zqg+fYgSrXpjSWkBAvvRcpkfy8FBPV
         tNxSjMgPAwIk0EoXl6lMa5XA6cE+yTKhmM12xhU7UO7YNaClyBEJshXuueIPKE7t3FcH
         7gEsakp7StcZGg1/F370HBMVELHEqfSce1A9LxF4g+rvcDY2cxqDC7hK2467lhSYpFTC
         zauA==
X-Gm-Message-State: AOJu0Yy5qqvBM3CNfK+AYFQb6eq0GF52YCS4aA9Te3Gu7ihLw/rxdzUX
        W6wzhd+v/a2qxWTzQ7NMZ0mUyqgpIKimsg==
X-Google-Smtp-Source: AGHT+IH+AYq5sWryYTvJAd8fFBRhiXfPoQm82wi0Wt02s0YRK8TT8ZH88gTcTPvRL8eNUJD7MXAIkw==
X-Received: by 2002:ac2:4846:0:b0:507:aaa4:e3b3 with SMTP id 6-20020ac24846000000b00507aaa4e3b3mr2089747lfy.50.1698418577277;
        Fri, 27 Oct 2023 07:56:17 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id h25-20020a0565123c9900b00507ae0a5eb7sm298884lfv.164.2023.10.27.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:56:17 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 15F6A19B2; Fri, 27 Oct 2023 16:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418576; bh=6UnZvJRrh1AoUKtr6mVyn3oQj+djhtctUE/QsFPE5cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjhkqJFkEAeYtj6dNKo7hgRpMTgAv1vWAXJ/ds+l4ZA5ha9K8LK/MMI+afdep+590
         6NRBY59KuaeQhUPbJk+AttkO5tbnU67wunvxa6nN6Jn0Qv7WgQiuGayL6fRTMr+fXQ
         lOFzpO91s/h9EVr4H7aOvdGZVRZBFITceizAcrr8=
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
        by flawful.org (Postfix) with ESMTPSA id 92C0419D7;
        Fri, 27 Oct 2023 16:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1698418483; bh=6UnZvJRrh1AoUKtr6mVyn3oQj+djhtctUE/QsFPE5cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqrlxN5jVho1AeBHC/T1nbkQkcNtvX+lcvdQNu45g6aLSaNux2zCMnKfiq+aJbBT9
         gSl/XwR/ILy8unrb81ikiCPzcT86l0fpMe7eLIvniwTpVWDEhY9WyG7uT/VQevivwK
         6t/0jeg5rwt4jQ0FYOenYiIzvNDN07G+5W2tFla4=
From:   Niklas Cassel <nks@flawful.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v3 2/6] dt-bindings: PCI: dwc: rockchip: Add optional dma interrupts
Date:   Fri, 27 Oct 2023 16:54:14 +0200
Message-ID: <20231027145422.40265-3-nks@flawful.org>
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

and snps,dw-pcie.yaml does have the dma interrupts defined, in order to be
able to use these interrupts, while still making sure 'make CHECK_DTBS=y'
pass, we need to add these interrupts to rockchip-dw-pcie.yaml.

These dedicated interrupts for the eDMA are not always wired to all the
PCIe controllers on the same SoC. In other words, even for a specific
compatible, e.g. rockchip,rk3588-pcie, these dedicated eDMA interrupts
may or may not be wired.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 6ca87ff4ae20..7ad6e1283784 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -63,6 +63,7 @@ properties:
       - const: pipe
 
   interrupts:
+    minItems: 5
     items:
       - description:
           Combined system interrupt, which is used to signal the following
@@ -86,14 +87,31 @@ properties:
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

