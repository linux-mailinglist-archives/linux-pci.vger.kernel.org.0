Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19FD2C7BEB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgK2XIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 18:08:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2XIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 18:08:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id g14so13027028wrm.13
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 15:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4ZAbgOviSl5kwTV38A0mgojnuMMJBX6cIDk0sTmaeo=;
        b=pdu6HEGFLTC9Oyku55Hw0/kqS2v42OW9q4gpNX1KD1K0/q6G6CXeNHX2q62rb9Am6j
         55Vrm2kC/NjxRtyMvzfcAsuIhczYBRhKfFJLGmrEF9SnUg6+AT8gtqfnuAs3uU85M/Zp
         LaWO/JISpvJeJapijCbD8X0IllbWhPHf9nseN5RZoWLDGWJ8lCGx15/+3m49saRdUvSb
         OetMzsu+fVS5C4hsIhBeycLLHQrmR+K9M+T46Po/FLY2ifNnRGH6o+LeQefiyl4Os6lo
         lfrQFwbOImhrkxP8TViP3G1z5U0eFithHXokXfnOoSTptGyvZl15eVfB31BnV2GBEWfN
         gElw==
X-Gm-Message-State: AOAM532C5YRCP4LWN2XF2Ar1r2OK3YwncohlwP8kZGVwY6pNcSDIlhB3
        LM9L+4kfbrOvtjuBTDvd2mA=
X-Google-Smtp-Source: ABdhPJyc10rS86sUCkCS7JwDecOpIFDWRywvD2p3TPef9gz9BjYexnZrT+fR1+MqL8LVO9fcgPl/QQ==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr24090769wrr.119.1606691269434;
        Sun, 29 Nov 2020 15:07:49 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d2sm24831005wrn.43.2020.11.29.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 15:07:48 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v6 2/5] PCI: thunder-pem: Add constant for custom ".bus_shit" initialiser
Date:   Sun, 29 Nov 2020 23:07:40 +0000
Message-Id: <20201129230743.3006978-3-kw@linux.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a custom constant for the ".bus_shit" initialiser to capture
a non-standard platform-specific ECAM bus shift value.

Standard values otherwise defined in the PCI Express Specification
are available in the include/linux/pci-ecam.h.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-thunder-pem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 3f847969143e..1a3f70ac61fc 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -19,6 +19,15 @@
 #define PEM_CFG_WR 0x28
 #define PEM_CFG_RD 0x30
 
+/*
+ * Enhanced Configuration Access Mechanism (ECAM)
+ *
+ * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
+ * standard values defined in the PCI Express Base Specification see
+ * include/linux/pci-ecam.h.
+ */
+#define THUNDER_PCIE_ECAM_BUS_SHIFT	24
+
 struct thunder_pem_pci {
 	u32		ea_entry[3];
 	void __iomem	*pem_reg_base;
@@ -404,7 +413,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops thunder_pem_ecam_ops = {
-	.bus_shift	= 24,
+	.bus_shift	= THUNDER_PCIE_ECAM_BUS_SHIFT,
 	.init		= thunder_pem_acpi_init,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
@@ -441,7 +450,7 @@ static int thunder_pem_platform_init(struct pci_config_window *cfg)
 }
 
 static const struct pci_ecam_ops pci_thunder_pem_ops = {
-	.bus_shift	= 24,
+	.bus_shift	= THUNDER_PCIE_ECAM_BUS_SHIFT,
 	.init		= thunder_pem_platform_init,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
-- 
2.29.2

