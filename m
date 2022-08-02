Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD158811E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiHBRgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHBRgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 13:36:42 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5F33E06;
        Tue,  2 Aug 2022 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fvM/g7yEmol5LB1hRTfh0dP3z5l+1DidjnEGxSNhVDA=; b=Udv7QKnmiAS3H9k5XfcUw89ka8
        6GvIX2sUR1RGU8wqdC+UaMMxTLcVcVkQtBso1YnE9zAOYcuDQmHRcNsp9yehY11VzgvT6Hjvmvpg8
        yHDSlM/g45n3GcV2Q31cv78fiILx2Dgv5itMZOZVDF1U32SgIXxpbfJ1ozxsjoqSbvhLPUrIZVYN5
        vXxEK1WM6YKHACA5j+jzkVU5dZ8I4nmTsNGGvz0bAHI0IEXP+ky7XoLa8iM2wNuwUDNyaZGTGnyAa
        hIlTLeIsQY/ILk7VtXPoTKeymCavyeckp9Oawa4E+4+8Xqg+biopdLXeOlkSYxT4TQ7m0CxEwL25o
        KYpc7mkQ==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:55983 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oIvop-008Ymy-4O; Tue, 02 Aug 2022 20:36:36 +0300
Received: by localhost (sSMTP sendmail emulation); Tue, 02 Aug 2022 20:36:33 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        Rob Herring <robh@kernel.org>
Date:   Tue,  2 Aug 2022 20:34:22 +0300
Message-Id: <20220802173423.47230-2-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802173423.47230-1-maukka@ext.kapsi.fi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 1/2] dt-bindings: PCI: mvebu: Add orion5x compatible
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a compatible string to bindings to indicate that orion5x PCIe is
supported too.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Acked-by: Rob Herring <robh@kernel.org>
---
v1->v2:
 - added ack by Rob
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 6d022a9d36ee..ced5d030fe55 100644
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
-- 
2.25.1

