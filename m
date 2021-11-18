Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21940455D73
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhKROKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhKROKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:10:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E371C061570;
        Thu, 18 Nov 2021 06:07:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so5792817pjb.4;
        Thu, 18 Nov 2021 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=BvRkTG9QWh/nDql0vdChRnHccpwZ0VM4CIM6EBHq/1BgkYqp8nyvYg5knfbTMtAm9S
         ONlfHuNPSw+chm+zhOREpoCqOzSkBHPKq75nMzMfYfiZlXJxO1UzO+C4gtA3QmzLKDht
         5Bh9Bb28TGsINdTlHnoi5ncLJOJaSg/5E0PcUP9CNVvwPbL1vmYQSvju02y+it/aKDyo
         bHC7GrlUfpx1NQeiTbAYZCf2+wSQkkFEQBQnTN0Oj1LnMZ4GV0qjtQiwT0flkCu+B/VH
         bQ/E1ZigUq2WIZaIk1/PHMG9CyxkEykKLu6Udtb8QqjOAh1HqyDy+b9+qLN6PKFCLy2B
         JMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6PFmrQZfsZKbN43caoyPHUp+nOh1/rI/bPUZ2uC0hc=;
        b=7vZzS6Ej42orbFfZrrFKLd3ifYQsJ3HHzakG4x17HHQ7bhVyGk4k4MrNsJdbpTxri2
         Yimtn2Xc9NWHraGlYmJHf4KXbt+DAATfACUzxGn/aBAnvvaF9YsVoyZTVrTGrJ7W9D89
         9+9IngD4LskIfRNRzbvbnwlmMS0yAfIy1oO9fCDryMKDeEW5yeH5w0aMzRBbBbfOPdWJ
         iRfEwrfD2hjpXbE8LcV965FeT1zYYp8nFlKGdHFMVjKdNUXR5TQYA7LVckH2WLU7CsND
         bT8cYGqhi/v6MCKR6MxqMEk6+L9ByZdWRG+cwyX4KNqlCbb8Xa6u+D57p3fDMnm9NG4v
         40GA==
X-Gm-Message-State: AOAM533xUDHaRTM4o79zkTLEkMw6+4rhmCmJqRHxdv9WOfqSJZgdVz7F
        aCzBmgcIClFkZC+j6KdoiS0=
X-Google-Smtp-Source: ABdhPJyvJjeiaFKSgytjId5brKyWz+xbwXrqFdhy7A6dGUOrftB/u/RY89uvHrTE/ZR0106/YqLWVA==
X-Received: by 2002:a17:90b:3b81:: with SMTP id pc1mr10785668pjb.67.1637244462074;
        Thu, 18 Nov 2021 06:07:42 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:07:41 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 12/25] PCI: mvebu: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:22 +0530
Message-Id: <f30264b137b1282ffda34d336e8060bb13d60b98.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index ed13e81cd691..70a96af8cd2f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -653,20 +653,16 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
-	if (!port) {
-		*val = 0xffffffff;
+	if (!port)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the emulated PCI-to-PCI bridge */
 	if (bus->number == 0)
 		return pci_bridge_emul_conf_read(&port->bridge, where,
 						 size, val);
 
-	if (!mvebu_pcie_link_up(port)) {
-		*val = 0xffffffff;
+	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/* Access the real PCIe interface */
 	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
-- 
2.25.1

