Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF3228E0B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgGVCZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40965 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbgGVCZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:43 -0400
Received: by mail-io1-f67.google.com with SMTP id p205so858791iod.8;
        Tue, 21 Jul 2020 19:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWoYf9yKrwwSCKBsmrxvNwRUkfwXcjhBMBaR+mTZurc=;
        b=e6ay/F6cD1uACQkDYm27W7AddpDouNGIhz8Sn87JLwnoxv9oqXtnp80hR8DjhvKoiA
         YdwhkhSdcgTIIJpblug9Q7Nsq7ISouGs116po5J0T6BuNqrHGsNluh5Ggbn9wS93Qzwd
         H/G/NbRlYeAwfcRZEZp6HNkI43SgwtmdGBqlTpB3ZyRNotCmFF4yP6I9b0KlnjF47Wfi
         FhTa1jsSfhFwijuCarqk/8pMLBq5rOtb9U9Ttu3MS1Io1/JyN9iyfcA/rwUPBsyaDgaW
         BOkUbn5R0pIDmlb1VEKYbEmLWitEiEVmxF1kmrgel8v/HR2xYebqe16IzZ2GH34Fh0fx
         uk1A==
X-Gm-Message-State: AOAM530tMddpcfMGz3+BlRyu0yXM+B0CcM4MOuSVmt4IRSdCA/l13rIa
        jMjjFRv9lufa1Ni8q6asNA==
X-Google-Smtp-Source: ABdhPJwAvhDYvgyKhTqQn/Tiiu6xiBcvCLsNbo3tptKdVnpJdfPGiAGrxhD9aQiTmr7GmGloXhv20w==
X-Received: by 2002:a6b:1449:: with SMTP id 70mr30849393iou.153.1595384742266;
        Tue, 21 Jul 2020 19:25:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 07/19] PCI: xilinx-nwl: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:02 -0600
Message-Id: <20200722022514.1283916-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_is_root_bus() rather than tracking the root bus number to
determine if the bus is the root bus or not. This removes storing
duplicated data as well as the need for the host bridge driver to have
to care about the bus numbers in most cases.

There was also a bug that the pci_host_bridge.busnr is set from
root_busno, but root_busno is never set which means the root bus number
is always 0 even if the DT said something else.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 3c747aa4b6d1..566165c18fad 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -166,7 +166,6 @@ struct nwl_pcie {
 	int irq_misc;
 	u32 ecam_value;
 	u8 last_busno;
-	u8 root_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 	raw_spinlock_t leg_mask_lock;
@@ -217,13 +216,11 @@ static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	struct nwl_pcie *pcie = bus->sysdata;
 
 	/* Check link before accessing downstream ports */
-	if (bus->number != pcie->root_busno) {
+	if (!pci_is_root_bus(bus)) {
 		if (!nwl_pcie_link_up(pcie))
 			return false;
-	}
-
-	/* Only one device down on each root port */
-	if (bus->number == pcie->root_busno && devfn > 0)
+	} else if (devfn > 0)
+		/* Only one device down on each root port */
 		return false;
 
 	return true;
@@ -855,7 +852,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = pcie;
-	bridge->busnr = pcie->root_busno;
 	bridge->ops = &nwl_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-- 
2.25.1

