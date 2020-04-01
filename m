Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E4119B928
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 01:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgDAX6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 19:58:40 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35414 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbgDAX6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 19:58:40 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so781659pjp.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2020 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6HaOIWdsOvizBvUG72A610lipCbSG/hDyB8c4hgjxM4=;
        b=TIDyu6sFaiElP3YA0sQ8+IyF0Dbte0xNsHwxCQVD2RygK+ekQ1sy1up8ezowMNa53O
         BDFkGog/4C6cuAplYC1JQ+4p0ceAKuuCVgKqIXhBGw6UXB6Jk7/TphmATJnp8tl9sZaD
         YeDYTenE0xhy511z4M3NoTSs6Pydy3mHwoEMXAg29WNYU+0WnnyuVWRK26gFAXtXuq3/
         H4GRC4rV7VhnqZB73GB8BamTWtO7aWlPJPdo/qE6lv8/JhV8n8xMz9RXZ6Dp6G7dmDt4
         y0d/kbespU0DOgH/PU+GhNoPWZAIzUdx8SraS1wMIuF4oOPY7O6fO6oV8PbObSV/nyn+
         /vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6HaOIWdsOvizBvUG72A610lipCbSG/hDyB8c4hgjxM4=;
        b=oTMi6XSL97QD7M2qkYnS507Z0/jONy/NNeDD/JErxJLQGOiUMw0xWYJtv4vp64Hfku
         MrBqfY1eud9eZlTuy46ZxAL+Tur8DW7I2ECHyaUXhdb13POgMS/ozcqjtVWmfT9m4uHi
         jNlF47LMm8YXu8z2G4JOoLn0cfgIuYSJkay2j1lsLe1KegEWjsslcCt6Ehp12MvS0+6I
         nnnQmBdjiQr49SgoOfORJ01Nqy76+/voyI6L9MOxP8J3WUTIaWlw3LD7qjEEsi6FwZ+0
         LAXeLyLIW9iicvYc+SWUEdzOVhRMoHXReFR9LAnsIKkhBliW2SyS6Jd+Cqc8qct4FeRW
         PV/w==
X-Gm-Message-State: AGi0PuYq8jAcUrXWxdMJUyWiBHwniBewD1SiUtJu+lLhr+pspWhoMwtw
        QRfO7oSRrAWJTapn5fUJYwc3kA==
X-Google-Smtp-Source: APiQypLpGOrbF/srm2g4dqFOnyAzBHe5EYC1anmwa1xXj4psO2w9BNnq2XCMc/1WpyjHjShJ9LnCtw==
X-Received: by 2002:a17:90a:71c5:: with SMTP id m5mr592961pjs.193.1585785519306;
        Wed, 01 Apr 2020 16:58:39 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id o29sm2405893pfp.208.2020.04.01.16.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Apr 2020 16:58:38 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, kishon@ti.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Date:   Wed,  1 Apr 2020 16:58:13 -0700
Message-Id: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Function dw_pcie_prog_outbound_atu_unroll() does not program the upper
32-bit ATU limit register. Since ATU programming functions limit the
size of the translated region to 4GB by using a u32 size parameter,
these issues may combine into undefined behavior for resource sizes
with non-zero upper 32-bits.

For example, a 128GB address space starting at physical CPU address of
0x2000000000 with size of 0x2000000000 needs the following values
programmed into the lower and upper 32-bit limit registers:
 0x3fffffff in the upper 32-bit limit register
 0xffffffff in the lower 32-bit limit register

Currently, only the lower 32-bit limit register is programmed with a
value of 0xffffffff but the upper 32-bit limit register is not being
programmed. As a result, the upper 32-bit limit register remains at its
default value after reset of 0x0.

These issues may combine to produce undefined behavior since the ATU
limit address may be lower than the ATU base address. Programming the
upper ATU limit address register prevents such undefined behavior despite
the region size getting truncated due to the 32-bit size limit.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
 drivers/pci/controller/dwc/pcie-designware.h | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 681548c88282..c92496e36fd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -244,13 +244,16 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 					     u64 pci_addr, u32 size)
 {
 	u32 retries, val;
+	u64 limit_addr = cpu_addr + size - 1;
 
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
 				 lower_32_bits(cpu_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
 				 upper_32_bits(cpu_addr));
-	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
-				 lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_LIMIT,
+				 lower_32_bits(limit_addr));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
+				 upper_32_bits(limit_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
 				 lower_32_bits(pci_addr));
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a22ea5982817..5ce1aef706c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -112,9 +112,10 @@
 #define PCIE_ATU_UNR_REGION_CTRL2	0x04
 #define PCIE_ATU_UNR_LOWER_BASE		0x08
 #define PCIE_ATU_UNR_UPPER_BASE		0x0C
-#define PCIE_ATU_UNR_LIMIT		0x10
+#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
 #define PCIE_ATU_UNR_LOWER_TARGET	0x14
 #define PCIE_ATU_UNR_UPPER_TARGET	0x18
+#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
 
 /*
  * The default address offset between dbi_base and atu_base. Root controller
-- 
2.7.4

