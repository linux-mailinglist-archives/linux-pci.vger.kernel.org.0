Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70280743C8E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3NUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjF3NTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 09:19:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB43C07;
        Fri, 30 Jun 2023 06:19:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3082676e87.1;
        Fri, 30 Jun 2023 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688131184; x=1690723184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XR5ShywBTsDhxqrqnPNPImYwgLwdolYpfqjtsu6y5c=;
        b=gbCKNNtsQLcsUQlFs7+FLhqKUlnLm6Slc2QEcI/BGBoYVuKCOskfPLDyj+GqU4SJ2P
         mYqPGSi1xo4kNoxm8HjFV13PS/gaMZd3xWUDAaPJk8OaOUc3XzNi6eFA/cPuSPO//FCq
         HUsUgy5PMTVNddYkKfRFCS+jG5yIYsbJaxjlvosLzQtlFF8omDptyqNAMRnQJ6+1VIVj
         T0A1zXu6ygfYwNJr7uCSaVhyy49JPcddqe8fOlnxqhCU97wDPNg1O6lcQgmurdU1zJoZ
         KVEzB8ny0xFnhn22u5Aa5UZZacpog6ysnqmWuSDSfGovQGjiL2k2CUJX3S5hikZOSjCp
         QTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688131184; x=1690723184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XR5ShywBTsDhxqrqnPNPImYwgLwdolYpfqjtsu6y5c=;
        b=EywyvrP3xBo3GaIcG8lJqfqahvE8sSimHNjtssuN+Qoncsh6j9qo5nr8x2wcvLg/fQ
         O8KYhtcGz6IYcPkDFtm6BGOTwcicW6METv5MvlYHWaviq2I3ExJI7UFCTNqI2HOSSdYP
         Eqf8E/nepBfMZu4On3egf4VWW3/sPKw9UZ1dZ1wa4SsuFgv+oUGVW4CMF1Ozeme3AMk9
         QeFEfry/fP6PnIvAsE2VgzQhzDpqwjCHN1QUNjB560hs2hUarkpG/OjkDo/NYzRQ7HaT
         2pPGH/igYuhV+cI4Rt8EMEAA8bPhJJqxh8F0ROC5uzrAKnsShS/O5rprkPfNKruQSMvN
         3sQA==
X-Gm-Message-State: ABy/qLZ8VKAVCI0QSMe0EJmA33YMOz8HrwL/vywFrkgw4CTzdnR7FKn2
        XyK2OKFIZ1NdhdlhX9Xx++leukrcAj6TaQ==
X-Google-Smtp-Source: APBJJlHbqV544RedYUwZYHpNe0Ten97YJSL9QE5S+bJRvvt/iFa6ErJQZ384JcSCGnOLJSySwE28mw==
X-Received: by 2002:a05:6512:3b8b:b0:4fb:774f:9a84 with SMTP id g11-20020a0565123b8b00b004fb774f9a84mr2822368lfv.13.1688131183984;
        Fri, 30 Jun 2023 06:19:43 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id bc23-20020a056402205700b0051d9dbf5edfsm4749059edb.55.2023.06.30.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 06:19:43 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig.vd.ch
Cc:     dlemoal@kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address
Date:   Fri, 30 Jun 2023 15:17:52 +0200
Message-Id: <20230630131753.1549685-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A 32-bit mask was used on the 64-bit PCI address used for mapping MSIs.
This would result in the upper 32 bits being unintentionally zeroed and
MSIs getting mapped to incorrect PCI addresses if the address had any
of the upper bits set.

Replace 32-bit mask by appropriate 64-bit mask and rename 32-bit mask
for clarity.

Fixes: dc73ed0f1b8b ("PCI: rockchip: Fix window mapping and address translation for endpoint")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pci/8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain/
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pcie-rockchip-ep.c | 12 ++++++------
 drivers/pci/controller/pcie-rockchip.h    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 0af0e965fb57..313face6a87f 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -354,7 +354,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 	u32 flags, mme, data, data_mask;
 	u8 msi_count;
-	u64 pci_addr;
+	u64 pci_addr, pci_addr_mask = GENMASK(63, 8);
 	u32 r;
 
 	/* Check MSI enable bit */
@@ -391,18 +391,18 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 				       PCI_MSI_ADDRESS_LO);
 
 	/* Set the outbound region if needed. */
-	if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
+	if (unlikely(ep->irq_pci_addr != (pci_addr & pci_addr_mask) ||
 		     ep->irq_pci_fn != fn)) {
 		r = rockchip_ob_region(ep->irq_phys_addr);
 		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
 					     ep->irq_phys_addr,
-					     pci_addr & PCIE_ADDR_MASK,
-					     ~PCIE_ADDR_MASK + 1);
-		ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
+					     pci_addr & pci_addr_mask,
+					     ~pci_addr_mask + 1);
+		ep->irq_pci_addr = (pci_addr & pci_addr_mask);
 		ep->irq_pci_fn = fn;
 	}
 
-	writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
+	writew(data, ep->irq_cpu_addr + (pci_addr & ~pci_addr_mask));
 	return 0;
 }
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index fe0333778fd9..2d7b05f07b7e 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -158,11 +158,11 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
-#define PCIE_ADDR_MASK			0xffffff00
+#define PCIE_LO_ADDR_MASK		GENMASK(31, 8)
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
+#define   PCIE_CORE_OB_REGION_ADDR0_LO_ADDR	PCIE_LO_ADDR_MASK
 #define PCIE_CORE_OB_REGION_ADDR1	(PCIE_CORE_AXI_CONF_BASE + 0x4)
 #define PCIE_CORE_OB_REGION_DESC0	(PCIE_CORE_AXI_CONF_BASE + 0x8)
 #define PCIE_CORE_OB_REGION_DESC1	(PCIE_CORE_AXI_CONF_BASE + 0xc)
@@ -170,7 +170,7 @@
 #define PCIE_CORE_AXI_INBOUND_BASE	0xc00800
 #define PCIE_RP_IB_ADDR0		(PCIE_CORE_AXI_INBOUND_BASE + 0x0)
 #define   PCIE_CORE_IB_REGION_ADDR0_NUM_BITS	0x3f
-#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_ADDR_MASK
+#define   PCIE_CORE_IB_REGION_ADDR0_LO_ADDR	PCIE_LO_ADDR_MASK
 #define PCIE_RP_IB_ADDR1		(PCIE_CORE_AXI_INBOUND_BASE + 0x4)
 
 /* Size of one AXI Region (not Region 0) */
-- 
2.25.1

