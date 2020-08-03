Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE923AF0B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgHCVBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45714 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgHCVBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:45 -0400
Received: by mail-io1-f65.google.com with SMTP id u126so2717602iod.12;
        Mon, 03 Aug 2020 14:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgcVbPqzxoZQ8BD2LBqh5z0DmxU5aGMCc3S38te1hMk=;
        b=T1xN1SiG8Sv7G3fzMq84RCcYSYLkz39xYzkCcIZKo0JnYQk+HIjOoWES7b00a9wCuf
         Ok9Iu37SKtGYVe7OJcry4VkBKLmxY9f0zy/J10yIOPuiBTBlOtC2ndJQR/igPGIhahPl
         XvBVCekC2wlrYOSf5WZQMuuZSFV69IlEx5kuveC8NMMpT/GiAuC1KQkaHBVOEleasb5T
         GB7oxJmLdFMzI/E9vnfqTdJOT80m0f/riQiwtEIN7bWf07H4xkz+CmGEpynoKcve+Vo5
         z4q7/G5lNpX8ANjlsAUSJmdjC+4qNu4mSU6mZyoqtcaye4bfNWha3v4zREYM7nWa/CYx
         a1Dg==
X-Gm-Message-State: AOAM530/YJ5pKJ8/nchtXz0NI00U+/cKYPew8evKPfLZl3OfOymBQEHB
        K1rMVCVvnuCyk1wqM1iiDw==
X-Google-Smtp-Source: ABdhPJwZ2v3QRbVXEHElHg+0cQOqL+nUwqS+NoWUw+dR20bJGFNYxn6FK+LKQ0Ij90nYJuTJGr2nyQ==
X-Received: by 2002:a05:6638:1690:: with SMTP id f16mr1822826jat.91.1596488504104;
        Mon, 03 Aug 2020 14:01:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:43 -0700 (PDT)
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
        Yue Wang <yue.wang@Amlogic.com>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [RFC 11/27] PCI: dwc: histb: Use pci_ops for root config space accessors
Date:   Mon,  3 Aug 2020 15:01:00 -0600
Message-Id: <20200803210116.3132633-12-robh@kernel.org>
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
buses, convert the HiSilicon histb driver to use the standard pci_ops
for root bus config accesses.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-histb.c | 41 ++++++++++++++-----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 811b5c6d62ea..0d93088deea3 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -122,32 +122,37 @@ static void histb_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 	histb_pcie_dbi_w_mode(&pci->pp, false);
 }
 
-static int histb_pcie_rd_own_conf(struct pcie_port *pp, int where,
-				  int size, u32 *val)
+static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	histb_pcie_dbi_r_mode(pp, true);
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	histb_pcie_dbi_r_mode(pp, false);
+	if (PCI_SLOT(devfn)) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
-	return ret;
+	*val = dw_pcie_read_dbi(pci, where, size);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int histb_pcie_wr_own_conf(struct pcie_port *pp, int where,
-				  int size, u32 val)
+static int histb_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	histb_pcie_dbi_w_mode(pp, true);
-	ret = dw_pcie_write(pci->dbi_base + where, size, val);
-	histb_pcie_dbi_w_mode(pp, false);
+	if (PCI_SLOT(devfn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return ret;
+	dw_pcie_write_dbi(pci, where, size, val);
+	return PCIBIOS_SUCCESSFUL;
 }
 
+static struct pci_ops histb_pci_ops = {
+	.read = histb_pcie_rd_own_conf,
+	.write = histb_pcie_wr_own_conf,
+};
+
 static int histb_pcie_link_up(struct dw_pcie *pci)
 {
 	struct histb_pcie *hipcie = to_histb_pcie(pci);
@@ -194,6 +199,8 @@ static int histb_pcie_establish_link(struct pcie_port *pp)
 
 static int histb_pcie_host_init(struct pcie_port *pp)
 {
+	pp->bridge->ops = &histb_pci_ops;
+
 	histb_pcie_establish_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -203,8 +210,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops histb_pcie_host_ops = {
-	.rd_own_conf = histb_pcie_rd_own_conf,
-	.wr_own_conf = histb_pcie_wr_own_conf,
 	.host_init = histb_pcie_host_init,
 };
 
-- 
2.25.1

