Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA67D24CBDE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHUDzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42979 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgHUDzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:05 -0400
Received: by mail-io1-f68.google.com with SMTP id g13so464340ioo.9;
        Thu, 20 Aug 2020 20:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rh6G+pSUvMo/kfJhXJbE4GkdnlNpr7WklVnmm/bzwU=;
        b=Gj30bUdrufJJLPp9UXrdObScmNkj5FLWa3ok32GWNYh/4ojOl1pwcKrivpBrK8wNpE
         gG9GYJXrIT1EL+sM2Om0qLWTsAza0fvtOCjKalrpqEJNkIqtHqZVzOXW/sL0fI6ZXQKE
         g1fB0QTCffp1EYHx0ygoukNJzv8u/t+ukEymVwrObkmadk0PgC08x5LuwSVY6q0NLS4S
         +R+sP1u4pBFYxfxdEEvdi7dDJE/8igC0536fz5OR9SRBn+Jpu61nTB71q/p2Ce0IgMt+
         KbqX1Cvi7CUl/2QXTgpJZ1D9FLA/4Wbh+i7Y6Y/QIHiu4ZBxJDP1Ztnvc8N1//cQFPxc
         rsXw==
X-Gm-Message-State: AOAM533fFJQB1LywjrA37OMZKguUzOW6p36rV8Rp8WgbhIMfGbdtqJQd
        DGOGw8lnfHSD3dhy/lc1CA==
X-Google-Smtp-Source: ABdhPJxFNP+9p3GGDQpm7EPUPc+wX9H2iPB71LxQvc3q85Wa7WNWwtlDpQjSXqCEbwssrGemQZMHVQ==
X-Received: by 2002:a05:6638:1a7:: with SMTP id b7mr917900jaq.1.1597982103862;
        Thu, 20 Aug 2020 20:55:03 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:03 -0700 (PDT)
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
Subject: [PATCH v2 08/40] PCI: dwc: meson: Use pci_ops for root config space accessors
Date:   Thu, 20 Aug 2020 21:53:48 -0600
Message-Id: <20200821035420.380495-9-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that DWC drivers can setup their own pci_ops for the root and child
buses, convert the Amlogic meson driver to use the standard pci_ops for
root bus config accesses.

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 4f183b96afbb..f4d822190359 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -383,13 +383,12 @@ static void meson_pcie_enable_interrupts(struct meson_pcie *mp)
 		dw_pcie_msi_init(&mp->pci.pp);
 }
 
-static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				  u32 *val)
+static int meson_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn,
+				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	int ret;
 
-	ret = dw_pcie_read(pci->dbi_base + where, size, val);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
@@ -410,13 +409,11 @@ static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int meson_pcie_wr_own_conf(struct pcie_port *pp, int where,
-				  int size, u32 val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	return dw_pcie_write(pci->dbi_base + where, size, val);
-}
+static struct pci_ops meson_pci_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = meson_pcie_rd_own_conf,
+	.write = pci_generic_config_write,
+};
 
 static int meson_pcie_link_up(struct dw_pcie *pci)
 {
@@ -463,6 +460,8 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 	struct meson_pcie *mp = to_meson_pcie(pci);
 	int ret;
 
+	pp->bridge->ops = &meson_pci_ops;
+
 	ret = meson_pcie_establish_link(mp);
 	if (ret)
 		return ret;
@@ -473,8 +472,6 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 }
 
 static const struct dw_pcie_host_ops meson_pcie_host_ops = {
-	.rd_own_conf = meson_pcie_rd_own_conf,
-	.wr_own_conf = meson_pcie_wr_own_conf,
 	.host_init = meson_pcie_host_init,
 };
 
-- 
2.25.1

