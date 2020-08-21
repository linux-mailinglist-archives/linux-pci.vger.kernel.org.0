Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4133E24CBC4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHUDys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:54:48 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41723 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHUDyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:54:43 -0400
Received: by mail-il1-f193.google.com with SMTP id q14so328826ilj.8;
        Thu, 20 Aug 2020 20:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/IvjYa5DXUibjLWw7waxronaC1wa8EQJH9Sk/FD8us=;
        b=PlOEuIziNkdw3SR44D8iX2+14wYhq0LvFesDMKmnRH+SCkVa5C26l+wOc8w9W+OgGA
         QSr9goqpKxEJanImmggM3CdrwF6xySIAOx1xQkhmnTBh3r1aPRzWeEyfPyqtVTPeCW+k
         +fivQMeq9W8sLQXAriIEdCXxNSTGrXnRRGj7GcWI8BxHh8+gvbMY3ahsIWzjGx5pJEAw
         VY7wBFudCk5GF7fPCBvRM0uAX1SNPdqB/nBme33lOfad3GCK/lxDt23DEcyKXWqvjcK+
         3kt3gXaHO2e+3SR3SvCA/9Vrp7mAoDcjIkEc2FD6oie11XwWxhlm6FY9okvmKo3Tls5i
         A+Lg==
X-Gm-Message-State: AOAM530jeUfHZPD9952/nMVn1WRK5sbKdXXqiB0qxBg7l73Fv9F6lMVA
        YggeeK3vmaQ8HzECJmmVnw==
X-Google-Smtp-Source: ABdhPJzx1XUyo1pUb5w9dpeKbEN5h9j21HHKo9Ua9s8saE1f+uVstVEcWcw/FzmtX5xjumcHr7w9jg==
X-Received: by 2002:a92:ab0e:: with SMTP id v14mr921076ilh.35.1597982080411;
        Thu, 20 Aug 2020 20:54:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:54:39 -0700 (PDT)
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
Subject: [PATCH v2 03/40] PCI: dwc: Allow overriding bridge pci_ops
Date:   Thu, 20 Aug 2020 21:53:43 -0600
Message-Id: <20200821035420.380495-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to allow drivers to set their own root and child pci_ops
instead of using the DWC specific config space ops, we need to make
the pci_host_bridge pointer available and move setting the bridge->ops
and bridge->child_ops pointer to before the .host_init() hook.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1d98554db009..b626cc7cd43a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -344,6 +344,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
+	pp->bridge = bridge;
+
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &bridge->windows) {
 		switch (resource_type(win->res)) {
@@ -445,6 +447,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	/* Set default bus ops */
+	bridge->ops = &dw_pcie_ops;
+	bridge->child_ops = &dw_pcie_ops;
+
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
 		if (ret)
@@ -452,7 +458,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	bridge->sysdata = pp;
-	bridge->ops = &dw_pcie_ops;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
@@ -654,11 +659,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
 	/*
-	 * If the platform provides ->rd_other_conf, it means the platform
-	 * uses its own address translation component rather than ATU, so
-	 * we should not program the ATU here.
+	 * If the platform provides its own child bus config accesses, it means
+	 * the platform uses its own address translation component rather than
+	 * ATU, so we should not program the ATU here.
 	 */
-	if (!pp->ops->rd_other_conf) {
+	if (pp->bridge->child_ops == &dw_pcie_ops && !pp->ops->rd_other_conf) {
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f911760dcc69..8b8ea5f3e7af 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -200,6 +200,7 @@ struct pcie_port {
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
 	struct pci_bus		*root_bus;
+	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
-- 
2.25.1

