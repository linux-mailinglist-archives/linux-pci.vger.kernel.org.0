Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6C24CC4F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHUD4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44971 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgHUD4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:35 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so321479ilc.11;
        Thu, 20 Aug 2020 20:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfxIdt959NXaODT/XtFkfeDPzE0A42F3V0bVD6SSbnw=;
        b=YrmrDkgN653KaL3Wk5MUMYzKkdOJ/Vb/BbehmwWv5x4r7mW0JWGQcsvUKgzGEh0TeF
         ow8wFOsv3178gZ4Kypd5DB96BKLJdKQmcyKDYaIURKS3r+A/QHbqglFj18U8kPSRYZ7n
         DTOmQR3X4fRuSWABLm36aXJe9Y0VAoug5WwaYLG7rNUi7Ve7Oo7hAGUq40ZRCnRveHjZ
         Ddk9Hhgw6n3NpNTrROD49lH1penUkYPY2YWrBKBzErwsh5A7JDIESlbKhZ7eYInPNi+L
         tM8R15ZtqiScU5GVFHxurLhHI1Gu8/l4WRjiMCpstZCumWhg2VWQ2jwE+ApZN43OsqOP
         Byhg==
X-Gm-Message-State: AOAM5327T/EOXiVupWDxS9/8/53cyxkiXQxy2+2rFB65uURdAluuptZC
        hTlMHiMgXJ2ydrH8WNTrwg==
X-Google-Smtp-Source: ABdhPJwIZRy5y8U2oZCmoEan4JCLiYFHYKY7Mdb+uGDu2bXq6IpofYkmhrk+pIkkQsc8nrWPFFtHUQ==
X-Received: by 2002:a05:6e02:14c2:: with SMTP id o2mr1030464ilk.54.1597982193525;
        Thu, 20 Aug 2020 20:56:33 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:32 -0700 (PDT)
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
Subject: [PATCH v2 32/40] PCI: dwc: Remove read_dbi2 code
Date:   Thu, 20 Aug 2020 21:54:12 -0600
Message-Id: <20200821035420.380495-33-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DBI2 appears to be write-only and there's no read accesses in the code
anyways, so let's remove all the read_dbi2 related code.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c    | 13 -------------
 drivers/pci/controller/dwc/pcie-designware.c | 15 ---------------
 drivers/pci/controller/dwc/pcie-designware.h |  8 --------
 3 files changed, 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 39a5a72de340..5fe36da0b7c6 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -881,18 +881,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	return 0;
 }
 
-static u32 ks_pcie_am654_read_dbi2(struct dw_pcie *pci, void __iomem *base,
-				   u32 reg, size_t size)
-{
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	u32 val;
-
-	ks_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_read(base + reg, size, &val);
-	ks_pcie_clear_dbi_mode(ks_pcie);
-	return val;
-}
-
 static void ks_pcie_am654_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 				     u32 reg, size_t size, u32 val)
 {
@@ -907,7 +895,6 @@ static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.start_link = ks_pcie_start_link,
 	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_pcie_link_up,
-	.read_dbi2 = ks_pcie_am654_read_dbi2,
 	.write_dbi2 = ks_pcie_am654_write_dbi2,
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ed5dadcbcb45..b2739b96659f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -166,21 +166,6 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_write_dbi);
 
-u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size)
-{
-	int ret;
-	u32 val;
-
-	if (pci->ops->read_dbi2)
-		return pci->ops->read_dbi2(pci, pci->dbi_base2, reg, size);
-
-	ret = dw_pcie_read(pci->dbi_base2 + reg, size, &val);
-	if (ret)
-		dev_err(pci->dev, "read DBI address failed\n");
-
-	return val;
-}
-
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 73c119437fee..c3178c8694eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -232,8 +232,6 @@ struct dw_pcie_ops {
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			     size_t size, u32 val);
-	u32     (*read_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-			     size_t size);
 	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
@@ -269,7 +267,6 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
-u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
@@ -322,11 +319,6 @@ static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 	dw_pcie_write_dbi2(pci, reg, 0x4, val);
 }
 
-static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
-{
-	return dw_pcie_read_dbi2(pci, reg, 0x4);
-}
-
 static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_atu(pci, reg, 0x4, val);
-- 
2.25.1

