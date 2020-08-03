Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660AD23AF02
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgHCVBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38507 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgHCVBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:43 -0400
Received: by mail-il1-f194.google.com with SMTP id 77so3879440ilc.5;
        Mon, 03 Aug 2020 14:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w74e1Ztc1qAn6gEbliDEy8D1xkphK6dVWVgtaNcLV4w=;
        b=q1kAxFAcUcChwZzscN/BtqszSs41IJB+QrwM+exX6dedGv3CStCdg/RVz2KB+JVNTd
         4IzBPkm0KWUVoQ4ol9qkscOv5vrBQudfo1+NfI9m0Ie9QPrCbL1FWFvWGIoHbsrrhZ7o
         Ag1BMDk25H9rYpGDvjxrHwK5Q1JAiPIeymUp/zuRaZisSurn+DxHc1OdJVwfvyMS5LTj
         emC/ivP3X7FimUFw7DQL9RBvzs7V66EsWDpqY/6jAfE+5Gr+AjZr8iDaNI/egBBWDGJh
         ZpJSCfRz4Q8V8LarXXLf8Q3BIMjaaxvwFWHCAOIN0zRX4W3u+nA95bg1XdzlcJ8PsIFF
         FWvw==
X-Gm-Message-State: AOAM531GjW4M+HLPRoK3DZq9YUI5T4TS4b27JHPhELLBJo/mJY7g9u+i
        nC2l1dGg0OPiwySPF6Ii8A==
X-Google-Smtp-Source: ABdhPJxfAjXpg9S6OMpw6Nsv1iLQNUvPbf7BO8gLdDkl8+aUBf9YmuX7VSlCNgb+o/i5Ag3SVp1l9g==
X-Received: by 2002:a92:1b42:: with SMTP id b63mr1415959ilb.76.1596488501865;
        Mon, 03 Aug 2020 14:01:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:41 -0700 (PDT)
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
Subject: [RFC 10/27] PCI: dwc: exynos: Use pci_ops for root config space accessors
Date:   Mon,  3 Aug 2020 15:00:59 -0600
Message-Id: <20200803210116.3132633-11-robh@kernel.org>
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
buses, convert the Samsung Exynos driver to use the standard pci_ops for
root bus config accesses.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-exynos.c | 45 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c5043d951e80..d5d37cffa441 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -338,32 +338,37 @@ static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 	exynos_pcie_sideband_dbi_w_mode(ep, false);
 }
 
-static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				u32 *val)
+static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	exynos_pcie_sideband_dbi_r_mode(ep, true);
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_r_mode(ep, false);
-	return ret;
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
-				u32 val)
+static int exynos_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	exynos_pcie_sideband_dbi_w_mode(ep, true);
-	ret = dw_pcie_write(pci->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_w_mode(ep, false);
-	return ret;
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops exynos_pci_ops = {
+	.read = exynos_pcie_rd_own_conf,
+	.write = exynos_pcie_wr_own_conf,
+};
+
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
@@ -381,6 +386,8 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 
+	pp->bridge->ops = &exynos_pci_ops;
+
 	exynos_pcie_establish_link(ep);
 	exynos_pcie_enable_interrupts(ep);
 
@@ -388,8 +395,6 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
-	.rd_own_conf = exynos_pcie_rd_own_conf,
-	.wr_own_conf = exynos_pcie_wr_own_conf,
 	.host_init = exynos_pcie_host_init,
 };
 
-- 
2.25.1

