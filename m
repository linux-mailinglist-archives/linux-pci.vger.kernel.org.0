Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11EC5AD982
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIETZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIETZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F11D300;
        Mon,  5 Sep 2022 12:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C9861464;
        Mon,  5 Sep 2022 19:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B9FC4347C;
        Mon,  5 Sep 2022 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405914;
        bh=falzg4hl4/KX290uSBifmOXJSnweYuOhtmxMd5uXnF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ6TFJjGpyTfdZvcTp12RgL9G1yzer1PD1IZ5Gn38LBgZps/0giuJ84MPEt84qtrL
         JOpSvLLKOhsrCp7oJ1ocUIaraBEhOpX/A7K9DdFo6Onif/lZuKEt6JO6Xms2YnlHK/
         tIeYL4Eotsl7RWTxPhmwXA/a6nWLAJayyCiveNO03jFT8GyjeZ9cGgOgXf1vnQ+Kqg
         F8sdcEg9IPcIjiQxsVAYRxIMg7yANuzQqt80hLX86IPYZJksLVi+LGvjF6u6xOrQn/
         vJN0fSQlqsdA0hLvALLDN7lXlcYVV6M3Bq5QH/65+ft+QjyZqqVSRqgKFlYJtvGKJ1
         uf7ttbzqnGXmg==
Received: by pali.im (Postfix)
        id 0D0A42B22; Mon,  5 Sep 2022 21:25:14 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/7] dt-bindings: PCI: mvebu: Add orion5x compatible
Date:   Mon,  5 Sep 2022 21:23:06 +0200
Message-Id: <20220905192310.22786-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mauri Sandberg <maukka@ext.kapsi.fi>

Add a compatible string to bindings to indicate that orion5x PCIe is
supported too. Orion requires additional bindings for config space
registers.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* Add more detailed information about MMIO registers
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 8f0bca42113f..d8d6afc6376a 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -7,6 +7,7 @@ Mandatory properties:
     marvell,armada-xp-pcie
     marvell,dove-pcie
     marvell,kirkwood-pcie
+    marvell,orion5x-pcie
 - #address-cells, set to <3>
 - #size-cells, set to <2>
 - #interrupt-cells, set to <1>
@@ -60,7 +61,8 @@ PCIe interface, having the following mandatory properties:
 - reg: used only for interrupt mapping, so only the first four bytes
   are used to refer to the correct bus number and device number.
 - assigned-addresses: reference to the MMIO registers used to control
-  this PCIe interface.
+  this PCIe interface. first value controls internal registers and
+  second value (Orion-specific) controls config space registers.
 - clocks: the clock associated to this PCIe interface
 - marvell,pcie-port: the physical PCIe port number
 - status: either "disabled" or "okay"
-- 
2.20.1

