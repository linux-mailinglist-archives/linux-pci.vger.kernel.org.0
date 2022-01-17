Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68979490366
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiAQID5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 03:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiAQID4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 03:03:56 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E85C06161C
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 00:03:56 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Jckty6tZ4zQl4q;
        Mon, 17 Jan 2022 09:03:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH v2 2/2] PCI/AER: Enable AER on Endpoints as well
Date:   Mon, 17 Jan 2022 09:03:48 +0100
Message-Id: <20220117080348.2757180-3-sr@denx.de>
In-Reply-To: <20220117080348.2757180-1-sr@denx.de>
References: <20220117080348.2757180-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the PCIe AER subsystem does not enable AER in the PCIe
Endpoints via the Device Control register. It's only done for the
Root Port and all PCIe Ports in between the Root Port and the
Endpoint(s). Some device drivers enable AER in their PCIe device by
directly calling pci_enable_pcie_error_reporting(). But in most
cases, AER is currently disabled in the PCIe Endpoints.

This patch enables AER on PCIe Endpoints now as well in
set_device_error_reporting(). This will make the ad-hoc calls to
pci_enable_pcie_error_reporting() superfluous.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>
---
v2:
- New patch

 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..385e2033d7b5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1216,7 +1216,8 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
 	    (type == PCI_EXP_TYPE_RC_EC) ||
 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
-	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
+	    (type == PCI_EXP_TYPE_DOWNSTREAM) ||
+	    (type == PCI_EXP_TYPE_ENDPOINT)) {
 		if (enable)
 			pci_enable_pcie_error_reporting(dev);
 		else
-- 
2.34.1

