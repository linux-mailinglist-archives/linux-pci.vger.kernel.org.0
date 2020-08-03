Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8E23AF1C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHCVCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45747 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgHCVCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:00 -0400
Received: by mail-io1-f66.google.com with SMTP id u126so2718395iod.12;
        Mon, 03 Aug 2020 14:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+G09sVWmLiEk+qlmhnIPsi/B/n4JiVilLbMwDzTJ8Fc=;
        b=PaoWVWjJPXhqL4kgjd3GLb0n3DyC2PeyL+cfvdOJEGt8nunuxRHj2H5NQ9PSdaxTnM
         oHEeOiK1lAtlgw6N+pXTQhsFucGqIo5dC1ab+c7oyD+IIuyk96GMq4ohyLSI+YE+E5+N
         EyjUO165ow6j8kEUf+ZAaGTwwzkNmIOTdmzyX9cjlibmB6iSMj1ezTVwQd5lMYN1xxA9
         i57z+MDAtmdkmOyFt2MYO5+A1+AokobryHc89++mOOFuajqBZIMU7jPgoj+NEZ6sg/Ql
         5b03x00Gk8/Q5MhR83hg5b/IzROudK5Y0fNuIEcdJXpmlpu0s3SA51cCp8tUyE0wWJTV
         q6kQ==
X-Gm-Message-State: AOAM530l8j86JMGgWWVQ1mB5HyjTi6Dwzga5Z8VGxyLlZdGkB8FHfvaW
        82hSUIwIq+E0JBITbt6P4g==
X-Google-Smtp-Source: ABdhPJwMMkdyajQxcuVfgyMatvkAGgozf6l/jhIrQdnBe0B3HLM8TfQxbxa+NUmVrm7WcBb9dbLq7Q==
X-Received: by 2002:a5e:c311:: with SMTP id a17mr1821353iok.12.1596488518872;
        Mon, 03 Aug 2020 14:01:58 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:58 -0700 (PDT)
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
Subject: [RFC 15/27] PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus
Date:   Mon,  3 Aug 2020 15:01:04 -0600
Message-Id: <20200803210116.3132633-16-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index df1194d186bc..17271b21fb7d 100644
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

