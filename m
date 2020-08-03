Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444ED23AF0E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgHCVBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40944 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgHCVBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:48 -0400
Received: by mail-il1-f193.google.com with SMTP id x1so12026731ilp.7;
        Mon, 03 Aug 2020 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/8WdlxIj2tgo5PZc1xxYI0moFux1woMX4shol7l+Cw=;
        b=e4jKaWMVUf/KIicAv42vpcJM1nODKB586c0ynZ8f0T5kQ/Jh6/mYFIo7nTNVKmyDEn
         phy46cmnEQxp5DqiT/ADNg6zpWscur9xHrp8jDxhEDfHvoQ9KuwQvlA/liMDf8CLmoFx
         jXXSkXAyuzqgtT6PPN3uyu8RzD5+TIxx/10gkREKqPm9TbrnEzkGtgZE1AZx+dd8SdGp
         T8pHVaKZLDN7gVJWolgIgLRdfMbh/bcxz6UqsefEjgZwBcoSJbcv2YcRMDDPyaq6yjtb
         ufUSrAdA8mMz+r6+uG88uwrIO6dBzSn3rfSYXV5SAXFzDAdSQztbU39HYVoYJEq1HJ48
         fUAw==
X-Gm-Message-State: AOAM531+j/pfLTtrAh550Il+mewhjaxAeIW5szJzW+hMCpvSt7zamcXh
        ui4SBEsPbnG417krILAUAg==
X-Google-Smtp-Source: ABdhPJzrmbAcmNdnEbm0tgBp/5AY07aPIAywXllP5h77tMmzndDaOvLh9Qs6NLwuucPoLn76/UlYDA==
X-Received: by 2002:a05:6e02:ee9:: with SMTP id j9mr1332603ilk.163.1596488507637;
        Mon, 03 Aug 2020 14:01:47 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:47 -0700 (PDT)
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
Subject: [RFC 12/27] PCI: dwc: Remove dwc specific config accessor ops
Date:   Mon,  3 Aug 2020 15:01:01 -0600
Message-Id: <20200803210116.3132633-13-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all the drivers needing custom config accessors have been
converted to define their own pci_ops, we can remove the DWC specific
function callbacks {rd,wr}_{own,other}_conf.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 14 --------------
 drivers/pci/controller/dwc/pcie-designware.h      |  6 ------
 2 files changed, 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e9d31c341881..6e9f106e8e05 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -26,9 +26,6 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 {
 	struct dw_pcie *pci;
 
-	if (pp->ops->rd_own_conf)
-		return pp->ops->rd_own_conf(pp, where, size, val);
-
 	pci = to_dw_pcie_from_pp(pp);
 	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
@@ -38,9 +35,6 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 {
 	struct dw_pcie *pci;
 
-	if (pp->ops->wr_own_conf)
-		return pp->ops->wr_own_conf(pp, where, size, val);
-
 	pci = to_dw_pcie_from_pp(pp);
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
@@ -548,10 +542,6 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 *val)
 {
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where,
-					      size, val);
-
 	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
 					 false);
 }
@@ -559,10 +549,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 val)
 {
-	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where,
-					      size, val);
-
 	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
 					 true);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index dbe53e464e11..28e7ad3eb89f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -160,12 +160,6 @@ enum dw_pcie_device_mode {
 };
 
 struct dw_pcie_host_ops {
-	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
-	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 *val);
-	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			     unsigned int devfn, int where, int size, u32 val);
 	int (*host_init)(struct pcie_port *pp);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
-- 
2.25.1

