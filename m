Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE368FBC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfGOOQb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 10:16:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43953 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbfGOOQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 10:16:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so16377155ljv.10
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2019 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BYAFHd9zlAtd2xa3XOWV/zbnzstq1j4lmXv20sPh5gI=;
        b=LMQu+p91juO6CZOWACtq1a1WcxgHhNX7LYgPmvbjGCspegMU2wt9p7nF3vw5BosayV
         tI9PmUBUDq+lGUu/vyk7EEM7OZFBTHRUimWyyW59gvt4Hs9fBrMXeB5+4pWN1iUl+0CM
         8E/AauZkhnIExpCfk8ovMTPTS0hqZFOgqF9GyUM4Hwgeau4u8YS5KeamPZFFiTz+l9IS
         5EyuVEk0dMU/g5khI/cR1ubRiuUBwpa0IAYw150zoqDEz7B7Pyvbf+U7+iCyJAVjOKM9
         yqtS2Y7kdrYl7RL/J7xy/P4MbSo3GYPcrIrOlvvladmdchyj+rwS/qqrBgboOR/Yfmuj
         h8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYAFHd9zlAtd2xa3XOWV/zbnzstq1j4lmXv20sPh5gI=;
        b=mdN8L2nsw20gcvq7a2sPtt8XdI7KR2f8n+AWEKVbg59ICbWdESQjejTDmSRI1xRtal
         OA/dgOuiluXIFlw6L9aJt5RJInXln4I0Z4XU4dhbATHHNX4y1YiFjK0/gyxBPA6CJ15G
         +p0sSxrDr51BxGUqEtOsbvqATsnm29F4qdfnyeGa9butjmhEpeA5mFT/Vxs1JdPk8c/a
         xcHgirNrRgLgi8PIPe87mnUvw09jJgaK462wCDsyHXuMcT8LJM1iLV3BdND12iRDbbPu
         nh+T5+M4/FIsHsmOYUGn6Bk/4uaTsvTo9vCd0V4RIqPfly5ubtRFE4yBCqEImy4vwU0v
         Fjcg==
X-Gm-Message-State: APjAAAUbd3awYov0dojfuk7+gU/tpyAlxQR3Zt0tHOXWYhSmTSldYd4E
        95ZMY4uFrEjybiKfh7sb4EU=
X-Google-Smtp-Source: APXvYqy4dHpaZqJ4j++0qnAClEnt0wUAzLFJ4oyjt+DIoyObdoUl+ndR7VU8InxgTIe0wG1zSTJcWQ==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr14279928lji.139.1563200188039;
        Mon, 15 Jul 2019 07:16:28 -0700 (PDT)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id o17sm3190612ljg.71.2019.07.15.07.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jul 2019 07:16:27 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH] PCI: pci-bridge-emul: fix big-endian support
Date:   Mon, 15 Jul 2019 16:16:17 +0200
Message-Id: <1563200177-8380-1-git-send-email-jaz@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Perform conversion to little-endian before every write to configuration
space and converse back to cpu endianness during read. Additionally
initialise every not-byte wide fields of config space with proper
cpu_to_le* macro.

This is required since the structure describing config space of emulated
bridge assumes little-endian convention.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/pci/pci-bridge-emul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 83fb077..d1235d2 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -270,10 +270,10 @@ const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 			 unsigned int flags)
 {
-	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
+	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
-	bridge->conf.status = PCI_STATUS_CAP_LIST;
+	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
 	bridge->pci_regs_behavior = kmemdup(pci_regs_behavior,
 					    sizeof(pci_regs_behavior),
 					    GFP_KERNEL);
@@ -357,7 +357,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 		ret = PCI_BRIDGE_EMUL_NOT_HANDLED;
 
 	if (ret == PCI_BRIDGE_EMUL_NOT_HANDLED)
-		*value = cfgspace[reg / 4];
+		*value = le32_to_cpu(cfgspace[reg / 4]);
 
 	/*
 	 * Make sure we never return any reserved bit with a value
@@ -431,7 +431,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	/* Clear the W1C bits */
 	new &= ~((value << shift) & (behavior[reg / 4].w1c & mask));
 
-	cfgspace[reg / 4] = new;
+	cfgspace[reg / 4] = cpu_to_le32(new);
 
 	if (write_op)
 		write_op(bridge, reg, old, new, mask);
-- 
2.7.4

