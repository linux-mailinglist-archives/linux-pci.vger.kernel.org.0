Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069451DC46A
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 03:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgEUBFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 21:05:42 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:33740 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgEUBFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 21:05:42 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 475CEB7F27;
        Thu, 21 May 2020 09:05:40 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14523T139720957146880S1590023137801405_;
        Thu, 21 May 2020 09:05:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0da65a9be77c1661a7923a420a656514>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: lorenzo.pieralisi@arm.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: rockchip: Add 100ms delay before enabling training
Date:   Thu, 21 May 2020 09:05:30 +0800
Message-Id: <1590023130-137406-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
References: <1590023130-137406-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCI Express Card Electromechanical Specification
Revision 3.0, Table 2-4, power stable and reference clk stable
before PERST# inactive should be at least 100ms and 100us
respectively. Otherwise we do see some failures for link training.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/pcie-rockchip-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 94af6f5..2f4d909 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -331,6 +331,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	/*
+	 * According to PCI Express Card Electromechanical Specification
+	 * Revision 3.0, Table 2-4, power stable and reference clk stable
+	 * before PERST# inactive should be at least 100ms and 100us
+	 * respectively. Otherwise we do see some failures for link training.
+	 */
+	msleep(100);
+
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
-- 
2.7.4



