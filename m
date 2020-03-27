Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F36195854
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0NsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 09:48:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 09:48:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jHpJ6-0004sp-Mo; Fri, 27 Mar 2020 13:45:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: altera: clean up indentation issue on a return statement
Date:   Fri, 27 Mar 2020 13:45:56 +0000
Message-Id: <20200327134556.265411-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A return statment is indented incorrectly, remove extraneous space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/controller/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index b447c3e4abad..24cb1c331058 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -193,7 +193,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 	if (bus->number == pcie->root_bus_nr && dev > 0)
 		return false;
 
-	 return true;
+	return true;
 }
 
 static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
-- 
2.25.1

