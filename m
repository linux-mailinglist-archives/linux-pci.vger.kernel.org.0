Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DEA23AEF7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgHCVBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43661 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgHCVBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:36 -0400
Received: by mail-io1-f66.google.com with SMTP id k23so39948561iom.10;
        Mon, 03 Aug 2020 14:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhVIHy/Rw3yhAfrDggAhIwfl4PW3KaTrEVn3uFz3dc8=;
        b=mGfvjJ46N/FQjo19ot0o+xbJClOAX2J9x0YQjYvXVvPwJV8D5RmMUofnnr7uHaStkh
         kDQ7urSLtBiGS1DH3Ofr3wOegJqXTuppubHEkHMJyY/LQFiNYU0ay8kkB9yrvKNvvU6I
         xPpatg7EMzvGs/sJTPt58eQP1gyF0ltwdPkFfE9e8ARF7KD1ApyVahq9BfNFxVg3ln2b
         oavXhc37HD4G9Br2ORYxiQdz22laYVX2iQk/UX6Oc1uyeQXj4qstsE2/VIa26Ba09/pN
         5DFxBKcscwnYNdPHzVGhPNF2WCwLQZLy1vSamdRwvkVmf57G7kBHcMGezvq8YhPtYx+l
         XHQA==
X-Gm-Message-State: AOAM5311jcXP1s+/hOiG7CXGwpyPb5ci/TY/t4D9FuGXB2xAjPfqTwZG
        mlefQCtiQJd3MCWK0kxbZg==
X-Google-Smtp-Source: ABdhPJyjX1+wO5hyGV3g2v/BQHcjESE2gsWA9W9Ke9+7b6wyQJsyc0STPcQ+YQyGpmdVfbKRm8sSqg==
X-Received: by 2002:a5e:d519:: with SMTP id e25mr1841622iom.36.1596488495414;
        Mon, 03 Aug 2020 14:01:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 07/27] PCI: dwc: tegra: Use pci_ops for root config space accessors
Date:   Mon,  3 Aug 2020 15:00:56 -0600
Message-Id: <20200803210116.3132633-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that DWC drivers can setup their own pci_ops for the root and child
buses, convert the Tegra driver to use the standard pci_ops for root
bus config accesses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 30 ++++++++++++----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 92b77f7d8354..52bb145c42d1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -568,42 +568,44 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
-				     u32 *val)
+static int tegra_pcie_dw_rd_own_conf(struct pci_bus *bus, u32 devfn, int where,
+				     int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (where == PORT_LOGIC_MSIX_DOORBELL) {
+	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL) {
 		*val = 0x00000000;
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	return dw_pcie_read(pci->dbi_base + where, size, val);
+	return pci_generic_config_read(bus, devfn, where, size, val);
 }
 
-static int tegra_pcie_dw_wr_own_conf(struct pcie_port *pp, int where, int size,
-				     u32 val)
+static int tegra_pcie_dw_wr_own_conf(struct pci_bus *bus, u32 devfn, int where,
+				     int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	/*
 	 * This is an endpoint mode specific register happen to appear even
 	 * when controller is operating in root port mode and system hangs
 	 * when it is accessed with link being in ASPM-L1 state.
 	 * So skip accessing it altogether
 	 */
-	if (where == PORT_LOGIC_MSIX_DOORBELL)
+	if (!PCI_SLOT(devfn) && where == PORT_LOGIC_MSIX_DOORBELL)
 		return PCIBIOS_SUCCESSFUL;
 
-	return dw_pcie_write(pci->dbi_base + where, size, val);
+	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+static struct pci_ops tegra_pci_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = tegra_pcie_dw_rd_own_conf,
+	.write = tegra_pcie_dw_wr_own_conf,
+};
+
 #if defined(CONFIG_PCIEASPM)
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
@@ -970,6 +972,8 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val, tmp, offset, speed;
 
+	pp->bridge->ops = &tegra_pci_ops;
+
 	tegra_pcie_prepare_host(pp);
 
 	if (dw_pcie_wait_for_link(pci)) {
@@ -1057,8 +1061,6 @@ static const struct dw_pcie_ops tegra_dw_pcie_ops = {
 };
 
 static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
-	.rd_own_conf = tegra_pcie_dw_rd_own_conf,
-	.wr_own_conf = tegra_pcie_dw_wr_own_conf,
 	.host_init = tegra_pcie_dw_host_init,
 	.set_num_vectors = tegra_pcie_set_msi_vec_num,
 };
-- 
2.25.1

