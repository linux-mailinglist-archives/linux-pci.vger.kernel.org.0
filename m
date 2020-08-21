Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5824CBC7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHUDyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33959 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHUDyp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:45 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so486048iod.1;
        Thu, 20 Aug 2020 20:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLOKJsM36RdxJqf/bYT4HXd1cPeYX0IkkHL5f7qh/3s=;
        b=Hr7x8bSrLCW70qMrrETHvx+C51eeSbcy4m8/FkUzrDVHvuQz5dCHzPfSdPfrP1QQNn
         pscL5qdahFwYTtp/qTWvq3gqyjbSN9XKHJ1nM9rXE9INItnR30F5Ajx2CxKG3+49Iy+y
         fGCjgs8+9RX+sabNqjBB91MfKxlrgmZL4oUHjQ8YbVj8SjVU+B+Cinbjgul2o0eHHQww
         IyBMOxdYuSk55B3gCxX8Ahk+yXvhBxWEwb/c5K88DNxC7zKz3BS4FZD46Thl19PV+sn6
         3ErMP27ISiGBjvYAV6SPsLjBfIrCY5k0No9dTeuOk7m24T1kmG0ru8dMFP6r2x7F+5i3
         cmHQ==
X-Gm-Message-State: AOAM531D12DL2/mIuDQrTwGp8cST5uUX8k36XPxg+RRo2mKOYLn+qWh3
        4kFIogOq74NMT6SC4iMTjA==
X-Google-Smtp-Source: ABdhPJyq7iI4neXMHfp35dYxnHywQ9YGqTs7MIdd7KldjmqdJZ+ojUjvq0arWrzNuO2oF13NV46Vpw==
X-Received: by 2002:a02:7f0f:: with SMTP id r15mr940737jac.46.1597982084039;
        Thu, 20 Aug 2020 20:54:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:43 -0700 (PDT)
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
Subject: [PATCH v2 04/40] PCI: dwc: Add a default pci_ops.map_bus for root port
Date:   Thu, 20 Aug 2020 21:53:44 -0600
Message-Id: <20200821035420.380495-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Designware root port config space is memory mapped accesses via the
DBI space by default. Add a common implementation
dw_pcie_own_conf_map_bus() for platforms to use.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b626cc7cd43a..e87edce9b8da 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -602,6 +602,17 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 
+void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
+{
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (PCI_SLOT(devfn) > 0)
+		return NULL;
+
+	return pci->dbi_base + where;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.read = dw_pcie_rd_conf,
 	.write = dw_pcie_wr_conf,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 8b8ea5f3e7af..a9d805b28c2a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -377,6 +377,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 void dw_pcie_host_deinit(struct pcie_port *pp);
 int dw_pcie_allocate_domains(struct pcie_port *pp);
+void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
+				       int where);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
-- 
2.25.1

