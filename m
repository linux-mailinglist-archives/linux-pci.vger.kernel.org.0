Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5621D70C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgGMNZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgGMNWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFCC061755;
        Mon, 13 Jul 2020 06:22:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so17167550eje.1;
        Mon, 13 Jul 2020 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9eSzPhspiWvGf9aT6n+u7h1JAatvbzNtxDm7qgPwQa4=;
        b=hLYogsErj4MxDifEjs2yaWms0NpgUVako6c8lR/I2R4HV9RllrJIdGqkMDp5APeeDE
         oWeJOdnNhg7Ug/j0KkKHuaUJSEqiFCugiXFDKBKD08Rf4UCqkHYGXXTk09tPPdekReMl
         f/Z3N9TMpWpw2xAQtgdR8/N+9F0vAhXDYUe0EU/xGTl4W5zeIioGJduOy6lClM+Y6oFA
         xnjejrZ8kSmDHyZVOhAaPrgokXgExqfS+EI7cvM+Df1dhlImeqOdm4/lVR+HRcx5xHku
         Igf8N+NUygg5XttWH+kIcV9FL4bX+s92wGGITkFUVhBz34HIbR1LCVyWtNYcj0CfHCge
         ox9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9eSzPhspiWvGf9aT6n+u7h1JAatvbzNtxDm7qgPwQa4=;
        b=d0Opt1Ze4zzLv7lJoBvqB0JH2e3ch+zf4WPcdYkMnv1dbg2UUESeF1IvZ8yumYkOWW
         kIkPu5wBB3EhRgwN6803JbOQq7ZyeV1Xx59p9R2bxiObObFm/xRWEEerbW12Xk9ReoyS
         +PrcncfcCpaX0FVYu7ye2oiU0c2steyMreeZgOPrrDd8+EDvHSZRVAvYf98usRPGo2+e
         aVwfaPlx9NzMd4J+Qx4uNei3hrDFlI6q50a2kGdGLkKM2dxPWvH2Sam8JsStXZiVI64K
         54DoHQCLCOVq7gNZnYgsBxLGM5ckfb/jYLNXqLWqtsbQebXxcfKqQ+7uCvthial2s2Vc
         0q7A==
X-Gm-Message-State: AOAM530nGAsI1MZvFhCevbWLKzMij+jJxA5o+AVAgYNuw/xTDyOSEWx0
        YCgmL4TAmUIvwbFwiS3wU/I=
X-Google-Smtp-Source: ABdhPJyNhtJJphGqXF4QW+aGFKHkMsFvQ0ZrswEHN2+kh5oK7be5K3ZFffA96ErJ6GVjCF52Di2gmA==
X-Received: by 2002:a17:906:d143:: with SMTP id br3mr71266443ejb.268.1594646565435;
        Mon, 13 Jul 2020 06:22:45 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:44 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Toan Le <toan@os.amperecomputing.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [RFC PATCH 06/35] PCI: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:18 +0200
Message-Id: <20200713122247.10985-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 05/35

 drivers/pci/controller/dwc/pci-meson.c            | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 drivers/pci/controller/pci-xgene.c                | 3 +--
 drivers/pci/controller/pcie-altera.c              | 4 ++--
 drivers/pci/controller/pcie-iproc.c               | 2 +-
 drivers/pci/controller/pcie-rcar-host.c           | 4 ++--
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 58142f03d300..8203d5f95d28 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -390,7 +390,7 @@ static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	ret = dw_pcie_read(pci->dbi_base + where, size, val);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7c97c54f787c..2dd3965365f6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -459,7 +459,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	ret = dw_pcie_rd_own_conf(pp, PCI_HEADER_TYPE, 1, &hdr_type);
-	if (ret != 0) {
+	if (ret) {
 		dev_err(pci->dev, "Failed reading PCI_HEADER_TYPE cfg space reg (ret: 0x%x)\n",
 			ret);
 		ret = pcibios_err_to_errno(ret);
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index bf74f0a8b451..8d55cfc4ff8a 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -167,8 +167,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 {
 	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
 
-	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
-	    0)
+	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 96f5bda32b58..9f7b12ad0c04 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -367,7 +367,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 						    value, false);
 
 	ret = pcie->pcie_data->ops->tlp_read_pkt(pcie, NULL);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	/*
@@ -453,7 +453,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 
 	ret = tlp_cfg_dword_read(pcie, busno, devfn,
 				 (where & ~DWORD_MASK), byte_en, &data);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	switch (size) {
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index dac9352c0cb2..d34c9457fbe4 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -584,7 +584,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	/* root complex access */
 	if (busno == 0) {
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
-		if (ret == 0)
+		if (!ret)
 			iproc_pcie_fix_cap(pcie, where, val);
 
 		return ret;
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 363a8630de28..2bb250c6f767 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -157,7 +157,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
-	if (ret != 0) {
+	if (ret) {
 		*val = 0xffffffff;
 		return ret;
 	}
@@ -184,7 +184,7 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
-- 
2.18.2

