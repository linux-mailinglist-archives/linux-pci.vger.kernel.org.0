Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2689C24CBF1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHUDzT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34897 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHUDzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:18 -0400
Received: by mail-io1-f67.google.com with SMTP id s2so491255ioo.2;
        Thu, 20 Aug 2020 20:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oe9LLB2O2qB8amIUwgNF8kLMAkuXQasFfOXSkrgGMU=;
        b=Tz3OSwL3MutyOeaDS5jjqhxsItjjK7VjPfqvjYiMEBrHFUfsH65aQb1GbF0nW3uGx/
         QEVQxoYLPKqxOM6Y4SUuAtrNU76JbBo211MiIXzTSeDL9dFyIruRJoub+EUn+/qwR7jr
         W7+mcyv+0NysWotQhvGCuV2zgI116IPio38PgzAo9TzkD/eDWXgPDl60lg+BGpCwDf9U
         QpTCFiZBwYUzSmAOMMb3Zf4dMo/W5rv1KRLTBsgo6y+g6irpxcoSH0xSkdHMbPnDsU/I
         JEybpAFu/fF5OXlGoWhj6cu3pZRrf4JivDj/vz5LxRy9N0Y0b2ML6j27Name98cmwn35
         4R4A==
X-Gm-Message-State: AOAM5304nu5A+i2zg2h+Hje+DWBdjJHp9vBgcp+9phVE0zEFKdiKyU/f
        +bUf7taWlcpJFQzp7h46uA==
X-Google-Smtp-Source: ABdhPJygnWxXYKbB1eQHu7GGV718XGpKfRlbYVFwHsWaFGJAWtGyZHG0umEXXUD8qfphr3hVV6FIrA==
X-Received: by 2002:a02:454:: with SMTP id 81mr965925jab.142.1597982116863;
        Thu, 20 Aug 2020 20:55:16 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:16 -0700 (PDT)
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
Subject: [PATCH v2 12/40] PCI: dwc: Remove dwc specific config accessor ops
Date:   Thu, 20 Aug 2020 21:53:52 -0600
Message-Id: <20200821035420.380495-13-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all the drivers needing custom config accessors have been
converted to define their own pci_ops, we can remove the DWC specific
function callbacks {rd,wr}_{own,other}_conf.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 --------------
 drivers/pci/controller/dwc/pcie-designware.h      |  6 ------
 2 files changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e87edce9b8da..33e632a24466 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -26,9 +26,6 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 {
 	struct dw_pcie *pci;
 
-	if (pp->ops->rd_own_conf)
-		return pp->ops->rd_own_conf(pp, where, size, val);
-
 	pci = to_dw_pcie_from_pp(pp);
 	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
@@ -38,9 +35,6 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 {
 	struct dw_pcie *pci;
 
-	if (pp->ops->wr_own_conf)
-		return pp->ops->wr_own_conf(pp, where, size, val);
-
 	pci = to_dw_pcie_from_pp(pp);
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
@@ -537,10 +531,6 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 *val)
 {
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where,
-					      size, val);
-
 	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
 					 false);
 }
@@ -548,10 +538,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 val)
 {
-	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where,
-					      size, val);
-
 	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
 					 true);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a9d805b28c2a..4ed59b051b2b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -160,12 +160,6 @@ enum dw_pcie_device_mode {
 };
 
 struct dw_pcie_host_ops {
-	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
-	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 *val);
-	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 val);
 	int (*host_init)(struct pcie_port *pp);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
-- 
2.25.1

