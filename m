Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9A24CC0B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHUDzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:37 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35122 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgHUDzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:25 -0400
Received: by mail-il1-f195.google.com with SMTP id q14so348596ilm.2;
        Thu, 20 Aug 2020 20:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qdov0F91JWjBX0RDvms+7RoXkdqALpZh74Eq1hAWng=;
        b=MURMi4WvW1yjixnVPs3ndqs9KksVRtp/OhdtbZLIY2qvXBLrnW8HGY0AG3JrjTwJF8
         DfmkPf67X9UnHaYQSU5Rq6mpkNOHBTPkF+loAbupfVq9W5Sa1gYfxoNY3vxUPw5ekT6w
         r9eegYr4aXRQsSEHzWvXbCdkWxkpw9m86QgGQevObnG57bQ0fBrd6WZMYDSL+gEGFQP2
         Y2tdpYc4YTawZLXm6o+3+2BvM9/CQdaniGHq06b3KrJz2692wp0oRD+rX3sMhqE0g0xe
         7+q0Xlq11tTxxhR0Dzm1BGZ1IjgoVCLghHiuoZ5pAwlQ2VJz+2t/ki1Pw7BsvMDR/h2I
         CX3Q==
X-Gm-Message-State: AOAM532+lQcgOath9TB/RD93FWHzVl5bcqfoDEXP7xpjzGUOoz2qxZDc
        W1XOHmgEazspz6Au6LMHtA==
X-Google-Smtp-Source: ABdhPJxWfa3WQm5y8iByx2YiSDizCP8lwHMdCpOAAyhD1GwWnlqkAP+HsAEkjue1fkD8tbEL/F4XFg==
X-Received: by 2002:a92:dd85:: with SMTP id g5mr1026111iln.210.1597982124146;
        Thu, 20 Aug 2020 20:55:24 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:23 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 15/40] PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
Date:   Thu, 20 Aug 2020 21:53:55 -0600
Message-Id: <20200821035420.380495-16-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TI keystone is the only Designware driver using .scan_bus(). This
function pointer is the only thing preventing the Designware driver from
using pci_host_probe(). Let's use the pci_ops.add_bus hook instead.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2b0906e1e0d3..fd000384fd2a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -454,15 +454,19 @@ static struct pci_ops ks_child_pcie_ops = {
 };
 
 /**
- * ks_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
+ * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
  *
  * This sets BAR0 to enable inbound access for MSI_IRQ register
  */
-static void ks_pcie_v3_65_scan_bus(struct pcie_port *pp)
+static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
 {
+	struct pcie_port *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
+	if (!pci_is_root_bus(bus))
+		return 0;
+
 	/* Configure and set up BAR0 */
 	ks_pcie_set_dbi_mode(ks_pcie);
 
@@ -477,12 +481,15 @@ static void ks_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+
+	return 0;
 }
 
 static struct pci_ops ks_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = ks_pcie_v3_65_add_bus,
 };
 
 /**
@@ -842,7 +849,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.host_init = ks_pcie_host_init,
 	.msi_host_init = ks_pcie_msi_host_init,
-	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
 static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
-- 
2.25.1

