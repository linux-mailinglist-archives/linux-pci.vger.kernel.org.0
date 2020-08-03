Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5925123AEF9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHCVBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:01:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45700 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgHCVBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:01:38 -0400
Received: by mail-io1-f65.google.com with SMTP id u126so2717262iod.12;
        Mon, 03 Aug 2020 14:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfEvf5H5JZ3RCT8OcWDqKEAE854FjnIcjQahQFy60ZU=;
        b=ERSly5GkwWXYFvfxneAsDkwNhQgKm/cv6Qa9KURKeQacv7ptH1yGplFUYjHsTfLjl+
         4EIBd34LkyV8Y2IcPZhsQYo+WRs7oNhY9u72xMhDrr8WNotB0XDDZXOODB7P1nMnMqhR
         Zdf1kqqp9UjcCtKDAQo37AacHl64/w/m7F+MPREjFXBMZwdzYsCB3JV+De3o/UTj+bIi
         +IQTgPzoEcbSlUdXCEJ/+R2Fqe5rf/OHNmNx66SGkPmomaHFWThW2Fi7o0SaConG/cai
         PuRJl2roJRdNK7abqq+P6f3l05JsLhfnym9vVigyEeftkvr38MQOfivvdZMmrwcK260W
         bNcA==
X-Gm-Message-State: AOAM5313zTPMxSYsr3hEAKJH5QEzzY0U8NvzEj717IpxM4dOH9/8UmKn
        zvA9jNS1CLl4L13sq+HWjA==
X-Google-Smtp-Source: ABdhPJxVu37JrAtNyU3mWLs6CsBaCHUNz0/4V4wrWC42BJDmf56FSirpVGwbFUOMHezq7H+x89bQUQ==
X-Received: by 2002:a6b:9008:: with SMTP id s8mr1803377iod.132.1596488497604;
        Mon, 03 Aug 2020 14:01:37 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:01:37 -0700 (PDT)
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
Subject: [RFC 08/27] PCI: dwc: meson: Use pci_ops for root config space accessors
Date:   Mon,  3 Aug 2020 15:00:57 -0600
Message-Id: <20200803210116.3132633-9-robh@kernel.org>
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
buses, convert the Amlogic meson driver to use the standard pci_ops for
root bus config accesses.

FIXME: child bus accessors

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index ca59ba9e0ecd..54ce3369d963 100644
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

