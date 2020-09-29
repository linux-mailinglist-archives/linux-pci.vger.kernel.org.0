Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E427D737
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgI2TsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 15:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgI2TsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 15:48:07 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34190207F7;
        Tue, 29 Sep 2020 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601408886;
        bh=02SCmbrZzEz/BYdC6v14UYCu4DbhDrAGSML6aC8bEDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBuBq5z8RkdpPZJBHS9gHBtLY98T/VjBGRedpDeXR3Ts8J9KYsLBXLytZKg8fJ8z3
         TrOCuI0PwY10RUFfebyNys2l9ZwsctxbU3IZowY/jojbOsE8I/sc9btErfI4Hwr2Q4
         BZkVq8fwwgIquMRw+K0Z6OY+rGWDLddcRxgCOcHE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/PM: Remove unused PCI_PM_BUS_WAIT
Date:   Tue, 29 Sep 2020 14:47:47 -0500
Message-Id: <20200929194748.2566828-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929194748.2566828-1-helgaas@kernel.org>
References: <20200929194748.2566828-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

476e7faefc43 ("PCI PM: Do not wait for buses in B2 or B3 during resume")
removed the last use of PCI_PM_BUS_WAIT.  Remove the definition as well.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8d492669ecfd..f0a9cbe01bc7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -46,7 +46,6 @@ int pci_bus_error_reset(struct pci_dev *dev);
 #define PCI_PM_D2_DELAY         200
 #define PCI_PM_D3HOT_WAIT       10
 #define PCI_PM_D3COLD_WAIT      100
-#define PCI_PM_BUS_WAIT         50
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
-- 
2.25.1

