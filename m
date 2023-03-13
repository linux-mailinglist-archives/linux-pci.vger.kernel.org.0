Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC646B7C1B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 16:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCMPkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCMPj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 11:39:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A15298FB;
        Mon, 13 Mar 2023 08:39:59 -0700 (PDT)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 414026602FEE;
        Mon, 13 Mar 2023 15:39:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678721997;
        bh=EBzQO1aDaZOCz1GihKXNPLk8JJ1NYG5yY+HuX+tadyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVtT14hXPtIfXLGpHQEs9llmrqOXokXC3GhdUfYOOYSrhegv2TynsZ7XE5RkI4Q/e
         NKu+3yGLhBAXm2BLVdBhfToTGIrR9e7ZlNFJzitz7LtVOJLpuOl2YBHKEMhWTDnZi6
         j84XQSanSgmQ7hsq7e5f1VfAbf/sK1fq9cOu0sgXOPPWPFl7/6aQW7Up79Atm8HiY8
         hbWC8N5GyKfgOpBl6VTKL5S97zQiv1yhfnCVYrYcDimMggd9cjwTPqUiwKYY306rNh
         Qg3DujqFUxSbWai2j9oZFjbou5Ut7r2Z/9uh1S3QoHFqpQ30lXJx99VPOkBDxnCwuJ
         KSMQf3z1e6WKw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 1/4] dt-bindings: PCI: dwc: Add rk3588 compatible line
Date:   Mon, 13 Mar 2023 15:39:50 +0000
Message-Id: <20230313153953.422375-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313153953.422375-1-lucas.tanure@collabora.com>
References: <20230313153953.422375-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RK3588 uses the same driver as RK3568

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 2be72ae1169f..91aa9070ee31 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     items:
       - const: rockchip,rk3568-pcie
+      - const: rockchip,rk3588-pcie
 
   reg:
     items:
-- 
2.39.2

