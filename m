Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7345DA4E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbhKYMvq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244519AbhKYMtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:49:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBDA4610A7;
        Thu, 25 Nov 2021 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844393;
        bh=tPbNDMR/pO/XPt3w0yjPE5vVD9ywEbzQpey0qyJc5AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0DpSVTPYHPRgHrA99G17xbggKeFyLVfMnuzn8kj+rNnt5CWQALQNFFKWceLwK58c
         Gb83wxr+S8X1Ar5xy+KtkQ8hdsFB0az0BVvvl8zKebrj62fc+BUDJeXuJCK19mYDit
         SVkTxTg8N1WLOdt5knnj8v06L9kfvRKF1U3hirwZzyTP/zT3o9q7gQRWgJ2Or8Ypw5
         bZly5veqkkyW+5PC1I4EWp7GQ37dWuVhJZ2+YVFAkGPRBhPIFQhbi1hQWm/GNcz5mD
         9AAn9FXnEBARTxUkcczGc0LUXFt39imW0/DT+BSsl70/2Ue2s7HMv0QpXyJ8JaZkYk
         jdAgiB8YK4Hpw==
Received: by pali.im (Postfix)
        id 01C47EDE; Thu, 25 Nov 2021 13:46:30 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] PCI: mvebu: Check for valid ports
Date:   Thu, 25 Nov 2021 13:45:51 +0100
Message-Id: <20211125124605.25915-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some mvebu ports do not have to be initialized. So skip these uninitialized
mvebu ports in every port iteration function to prevent access to unmapped
memory or dereferencing NULL pointers. Uninitialized mvebu port has base
address set to NULL.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 06f06085beba..d655c887ba1b 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -625,6 +625,9 @@ static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
+		if (!port->base)
+			continue;
+
 		if (bus->number == 0 && port->devfn == devfn)
 			return port;
 		if (bus->number != 0 &&
@@ -800,6 +803,8 @@ static int mvebu_pcie_suspend(struct device *dev)
 	pcie = dev_get_drvdata(dev);
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = pcie->ports + i;
+		if (!port->base)
+			continue;
 		port->saved_pcie_stat = mvebu_readl(port, PCIE_STAT_OFF);
 	}
 
@@ -814,6 +819,8 @@ static int mvebu_pcie_resume(struct device *dev)
 	pcie = dev_get_drvdata(dev);
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = pcie->ports + i;
+		if (!port->base)
+			continue;
 		mvebu_writel(port, port->saved_pcie_stat, PCIE_STAT_OFF);
 		mvebu_pcie_setup_hw(port);
 	}
-- 
2.20.1

