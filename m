Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EC29E130
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgJ2ByI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:54:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36621 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgJ1V5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:57:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id y186so1173243oia.3;
        Wed, 28 Oct 2020 14:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL29XNIWkQpzNWyeVNn88/4OaIX3OCW0yaXdyYkNuo0=;
        b=r7JCFs0kyEJoyA2q9VA96bO2BOjWhy/BzrrEb+WIw0HYSdfSYi4G8HuvEwRO31vyiG
         h+aCRtbLoB/1N19eeeYXbJNMswuEYOhQsxZha9PkBYNG3BTmeFvtBDR1PEkFTzQ4eBSf
         bZZXrxyHCXWZ1VLXmQIye2iD8f2sTVKpEIFcwqt1RCcEV9YmHLiQn3H3wE7sNEw+1h0U
         3GXDNqPGci92ck0I7fcAdGgP7m0eZFrWHQz+uXcgtpHSOVroHButq0BfnbeTKC40N8Q4
         flMTzxh1rKfSU8asfg+3BEFkv+kiW6jXc8rZiNeRyPOzwjdEgPfOnt+/ywd5RX2NphCA
         Tx+Q==
X-Gm-Message-State: AOAM530Pk+0b22PAJxeNnRv6eBLtH54n/GGQ8yREZH/lLadWMDCYPc/F
        UBYe3S4XJHhS9ZtCVh41+ndqRfp72w==
X-Google-Smtp-Source: ABdhPJzWQKewEzrujtGvqB3VBlyo68Oonm1AIwSq3hCnepRvY1VGBxkJqbAEBgM3kZQckSIDnyed7g==
X-Received: by 2002:aca:f0c:: with SMTP id 12mr636990oip.9.1603918022402;
        Wed, 28 Oct 2020 13:47:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:47:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 05/13] PCI: dwc: Ensure all outbound ATU windows are reset
Date:   Wed, 28 Oct 2020 15:46:38 -0500
Message-Id: <20201028204646.356535-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Layerscape driver clears the ATU registers which may have been
configured by the bootloader. Any driver could have the same issue
and doing it for all drivers doesn't hurt, so let's move it into the
common DWC code.

Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape.c       | 14 --------------
 drivers/pci/controller/dwc/pcie-designware-host.c |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..53e56d54c482 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -83,14 +83,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
-{
-	int i;
-
-	for (i = 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
-}
-
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 state;
@@ -136,12 +128,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	/*
-	 * Disable outbound windows configured by the bootloader to avoid
-	 * one transaction hitting multiple outbound windows.
-	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
-	 */
-	ls_pcie_disable_outbound_atus(pcie);
 	ls_pcie_fix_error_response(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cde45b2076ee..265a48f1a0ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -534,6 +534,7 @@ static struct pci_ops dw_pcie_ops = {
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
+	int i;
 	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
@@ -583,6 +584,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	/* Ensure all outbound windows are disabled so there are multiple matches */
+	for (i = 0; i < pci->num_viewport; i++)
+		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-- 
2.25.1

