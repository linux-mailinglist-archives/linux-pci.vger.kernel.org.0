Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F62DE505
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgLROjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 09:39:49 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44410 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgLROjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 09:39:49 -0500
Received: by mail-ot1-f47.google.com with SMTP id f16so2043498otl.11;
        Fri, 18 Dec 2020 06:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b+Yxg5K4pjcyqb9mUr5ZJkZSkAF5jCPUW7erl2SMXrs=;
        b=lQVC/BaeT1IpWbsNi4ajBBK0/Mc55F29rbPYVnzMsIB+85BmKJkQEPncY6MeV0hkhH
         0Av6O5socSmrOGZTkXHzZQNSIrvXRIwP8+L8imTNF8RQ9i+pigj84zXO5HZDVh4f7jHI
         VM7zzOBX2TdJlF2B7qn4+lHdkqdMObHD4FQcEYvOqllJIiRXdXI982dGzTvabdrhNTu9
         fPcxNE60RXO4ToG3rb7hBUWTzFq5L5CbPRzPgGH/HtRTVN8x2PFRrIGEHGmE/oRQ7dDu
         VKtgBi3ZyDpLBIw8tfZXKXTpcSYkGDTOdZFQORUSowv1t79PT96AvNozGw39o4oBVVMP
         zRtw==
X-Gm-Message-State: AOAM533j+q5V2QEZdIPivgOPFhZTUfx8IsKOR0j+DvNdp8le0DTKyEus
        CsUQemgu6Q5sj99psfwbjG+a2UmIdg==
X-Google-Smtp-Source: ABdhPJx9p8C9Mr4OHm+uXjACie64rnOQiNEhUjbyodywTyhK/o61oHU8Km+9DuBYaBXJwzIPZQx2bA==
X-Received: by 2002:a05:6830:1e41:: with SMTP id e1mr3068106otj.143.1608302347641;
        Fri, 18 Dec 2020 06:39:07 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t24sm720685oij.7.2020.12.18.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:39:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Mian Yousaf Kaukab <ykaukab@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: dwc/tegra: Fix host link initialization
Date:   Fri, 18 Dec 2020 08:39:05 -0600
Message-Id: <20201218143905.1614098-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common
code") broke enumeration of downstream devices on Tegra:

In non working case (next-20201211):
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
0005:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1)

In working case (v5.10-rc7):
0001:00:00.0 PCI bridge: Molex Incorporated Device 1ad2 (rev a1)
0001:01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9171 (rev 13)
0005:00:00.0 PCI bridge: Molex Incorporated Device 1ad0 (rev a1)
0005:01:00.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
0005:02:02.0 PCI bridge: PLX Technology, Inc. Device 3380 (rev ab)
0005:03:00.0 USB controller: PLX Technology, Inc. Device 3380 (rev ab)

The problem seems to be dw_pcie_setup_rc() is now called twice before
and after the link up handling. The fix is to move Tegra's link up
handling to .start_link() function like other DWC drivers. Tegra is a
bit more complicated than others as it re-inits the whole DWC controller
to retry the link. With this, the initialization ordering is restored to
match the prior sequence.

Fixes: b9ac0f9dc8ea ("PCI: dwc: Move dw_pcie_setup_rc() to DWC common code")
Reported-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Tested-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Mian, One addition to what you tested. The resume hook also needs to
call start_link and that part was moved out of host_init.

Also, I noticed it looks like suspend/resume is broken for endpoint mode
as the hooks are for host mode only.

Bjorn, please apply this for v5.11.

---
 drivers/pci/controller/dwc/pcie-tegra194.c | 55 ++++++++++++----------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5597b2a49598..6fa216e52d14 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -853,12 +853,14 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 }
 
-static void tegra_pcie_prepare_host(struct pcie_port *pp)
+static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
+	pp->bridge->ops = &tegra_pci_ops;
+
 	if (!pcie->pcie_cap_base)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
@@ -907,10 +909,24 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
-	dw_pcie_setup_rc(pp);
-
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
+	return 0;
+}
+
+static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
+{
+	u32 val, offset, speed, tmp;
+	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
+	struct pcie_port *pp = &pci->pp;
+	bool retry = true;
+
+	if (pcie->mode == DW_PCIE_EP_TYPE) {
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
+	}
+
+retry_link:
 	/* Assert RST */
 	val = appl_readl(pcie, APPL_PINMUX);
 	val &= ~APPL_PINMUX_PEX_RST;
@@ -929,19 +945,10 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	appl_writel(pcie, val, APPL_PINMUX);
 
 	msleep(100);
-}
-
-static int tegra_pcie_dw_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-	u32 val, tmp, offset, speed;
-
-	pp->bridge->ops = &tegra_pci_ops;
-
-	tegra_pcie_prepare_host(pp);
 
 	if (dw_pcie_wait_for_link(pci)) {
+		if (!retry)
+			return 0;
 		/*
 		 * There are some endpoints which can't get the link up if
 		 * root port has Data Link Feature (DLF) enabled.
@@ -975,10 +982,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset, val);
 
-		tegra_pcie_prepare_host(pp);
+		tegra_pcie_dw_host_init(pp);
+		dw_pcie_setup_rc(pp);
 
-		if (dw_pcie_wait_for_link(pci))
-			return 0;
+		retry = false;
+		goto retry_link;
 	}
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
@@ -998,15 +1006,6 @@ static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
-{
-	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-
-	enable_irq(pcie->pex_rst_irq);
-
-	return 0;
-}
-
 static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
@@ -2215,6 +2214,10 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 		goto fail_host_init;
 	}
 
+	ret = tegra_pcie_dw_start_link(&pcie->pci);
+	if (ret < 0)
+		goto fail_host_init;
+
 	/* Restore MSI interrupt vector */
 	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
 			   pcie->msi_ctrl_int);
-- 
2.25.1

