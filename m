Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5F487F27
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiAGW7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 17:59:52 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43599 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiAGW7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 17:59:51 -0500
Received: by mail-pl1-f174.google.com with SMTP id j16so6060317pll.10
        for <linux-pci@vger.kernel.org>; Fri, 07 Jan 2022 14:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLcfWCXKjz3xMBYPC/DnYWgLMsmC0IqAE+5F6pOJn0o=;
        b=NWQjwhIStUQEpxe36+iP0JuGrVI43Uh6QXQjami3+v2ao9ECf4Q8snHM3xst+WfoDp
         FqlamajYHgeJxL7gi3myzUWXDRz6e+AJp/pFZF/Ox3jKm2lPi8VYf6NvyjsJ2cjj6rRY
         gXWNCdjd2MSlaRKL5xBNBB29zqSvDa9T8Ljy2jJTPtz8CyXmCMVNQkc3/lSjaxB0hb5L
         ykZb1w9L0TZZ2LrqSR+ScQK+78XXGYq+mpmVV9A4uXmSG8h2SAbAlr33cksPooV+1CNc
         xfRLDinCJyuwQfJZrVloXwJjCNM/G2JS2YrdL47ncuTPSd0q7iF1IXNUtBrfTQdUzl7s
         o2WA==
X-Gm-Message-State: AOAM530DUc9rBY43yKXwpyJdfBhdh26OmccT3yUjFV4nhZVSRms/VbdX
        4b3lAyF0/DqfT3Jxax9DVgA=
X-Google-Smtp-Source: ABdhPJypqZ1i92GyWdPK2GW7WhlIM3fab/bctseiuMrMUBm0YHE9du9rOj+aPwQxY72ROULPq0FqqQ==
X-Received: by 2002:a17:902:a408:b0:149:9055:98b1 with SMTP id p8-20020a170902a40800b00149905598b1mr47438021plq.2.1641596391163;
        Fri, 07 Jan 2022 14:59:51 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o10sm40302pjp.16.2022.01.07.14.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:59:50 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Correct misspelled words
Date:   Fri,  7 Jan 2022 22:59:42 +0000
Message-Id: <20220107225942.121484-1-kw@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix a number misspelled words, and while at it, correct two phrases used
to indicate a status of an operation where words used have been cleverly
truncated and thus always trigger a spellchecking error while performing
a static code analysis over the PCI tree.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 2 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
 drivers/pci/of.c                              | 2 +-
 drivers/pci/quirks.c                          | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 262421e5d917..c8a27b6290ce 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -310,7 +310,7 @@ struct cdns_pcie {
  *            single function at a time
  * @vendor_id: PCI vendor ID
  * @device_id: PCI device ID
- * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
+ * @avail_ib_bar: Status of RP_BAR0, RP_BAR1 and RP_NO_BAR if it's free or
  *                available
  * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 17c59b0d6978..7de82da0bd6d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -303,7 +303,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
 
 	/*
-	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
+	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
 	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
 	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
 	 * for the power and clock to become stable.
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5a03401f4571..9a00448c7e61 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1262,7 +1262,7 @@ static void epf_ntb_db_mw_bar_cleanup(struct epf_ntb *ntb,
 }
 
 /**
- * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
+ * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
  * @ntb: NTB device that facilitates communication between HOST1 and HOST2
  * @type: PRIMARY interface or SECONDARY interface
  *
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0b1237cff239..cb2e8351c2cc 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -247,7 +247,7 @@ void of_pci_check_probe_only(void)
 	else
 		pci_clear_flags(PCI_PROBE_ONLY);
 
-	pr_info("PROBE_ONLY %sabled\n", val ? "en" : "dis");
+	pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..e16bde66e735 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -980,8 +980,8 @@ static void quirk_via_ioapic(struct pci_dev *dev)
 	else
 		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
 
-	pci_info(dev, "%sbling VIA external APIC routing\n",
-	       tmp == 0 ? "Disa" : "Ena");
+	pci_info(dev, "%s VIA external APIC routing\n",
+	       tmp == 0 ? "Disabling" : "Enabling");
 
 	/* Offset 0x58: External APIC IRQ output control */
 	pci_write_config_byte(dev, 0x58, tmp);
-- 
2.34.1

