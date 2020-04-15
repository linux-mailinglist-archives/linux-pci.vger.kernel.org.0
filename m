Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298511A8F9F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634552AbgDOANs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392317AbgDOANX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:23 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC37E20784;
        Wed, 15 Apr 2020 00:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909601;
        bh=OPAkuVPnqnvqlTKWFRrfRQIoNILAj67FYlIfnD9ljx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Q1WJ+XBwh4aA0JmJXINSJFfZj6sE+71gFBMMVycbS9Z05J9vjBZLxw7yS6kl8zdu
         IS9tH5aj7PFjyc0YGOYmXodTXwE2FAxVbysa7WopSHczSoeN/YiL3qanrSeZkF0hPj
         AcU+uKBbupW/IO+d2L51XO+P3SxHw51zFJ15cb6I=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 3/4] PCI/AER: Don't select CONFIG_PCIEAER by default
Date:   Tue, 14 Apr 2020 19:12:43 -0500
Message-Id: <20200415001244.144623-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415001244.144623-1-helgaas@kernel.org>
References: <20200415001244.144623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCIe Advanced Error Reporting (AER) is optional and there's no need for it
to be selected by default.

Remove the "default y" for CONFIG_PCIEAER.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell Currey <ruscur@russell.cc>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 66386811cfde..9cd31331aee9 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -25,7 +25,6 @@ config PCIEAER
 	bool "PCI Express Advanced Error Reporting support"
 	depends on PCIEPORTBUS
 	select RAS
-	default y
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) driver support. Error reporting messages sent to Root
-- 
2.26.0.110.g2183baf09c-goog

