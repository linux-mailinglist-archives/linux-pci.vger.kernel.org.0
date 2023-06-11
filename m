Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAE72B3A3
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jun 2023 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjFKTUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jun 2023 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjFKTUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2023 15:20:15 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 774D5E42;
        Sun, 11 Jun 2023 12:20:14 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A05E8E0EAC;
        Sun, 11 Jun 2023 22:20:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xBKnmCKV/JuLxNwqyBckmnwSC2qdJbgeSMtcOIlFtcY=; b=ShanXOWOH6KH
        utd9gdFpUkazobHg4iTnepMCdWZPfdb6nlWJcxeEdPen3xDMZcj/lEtfn9FJjqs2
        tGtnrje1uEeLvPolykj0eFYWuO/Kw5OTZv/nGxa5PtIzAglUjoWfeuHhVmYZ5xbi
        UIrhM78K3ksPvYrUrAKSUHioJgOOw6Q=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6B43AE0DE3;
        Sun, 11 Jun 2023 22:20:13 +0300 (MSK)
Received: from localhost (10.8.30.10) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Sun, 11 Jun 2023 22:20:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v7 08/11] MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
Date:   Sun, 11 Jun 2023 22:20:02 +0300
Message-ID: <20230611192005.25636-9-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
References: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recently the DT-schema of the DW PCIe Root Port and End-point controllers
has been refactored by detaching the common bindings into a separate
schema. The provided modification must be reflected in the MAINTAINERS
list so the patch submitters would be aware of the new files maintainers.
Let's do that by adding the maintained files wildcard pattern like
snps,dw-pcie*.yaml, which is applicable for all the old DW PCIe DT-schema
files and the new one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea14e0f57e19..132d0aa646bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16171,8 +16171,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
-F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.40.0


