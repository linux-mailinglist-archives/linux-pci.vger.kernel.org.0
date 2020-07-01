Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D175210609
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGAIU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 04:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgGAIU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 04:20:58 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8370120722;
        Wed,  1 Jul 2020 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593591657;
        bh=mvYYmiZD0lRjkcahXyyE68VrSfxPw8nxlENouGT4zFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+kvMzaED0bKnFHQXu5Z+wC4wUKy/MUOj/uldXaRx3i0CNI7f7jy4bfVAgAZ5gk/0
         GTOBdWnhcO35n66pQL3FL1SnBRHNwv0zobP6wsJlT16PsQNvFNV6xWHS0aQkoPRxUm
         H8cKiVbzSmPeIY+RND3X6F5hpIkCr4VCjyJVtLEA=
Received: by pali.im (Postfix)
        id 8FA80102D; Wed,  1 Jul 2020 10:20:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: aardvark: Don't touch PCIe registers if no card connected
Date:   Wed,  1 Jul 2020 10:20:44 +0200
Message-Id: <20200701082044.4494-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200528143141.29956-1-pali@kernel.org>
References: <20200528143141.29956-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When there is no PCIe card connected and advk_pcie_rd_conf() or
advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
root bridge, the aardvark driver throws the following error message:

  advk-pcie d0070000.pcie: config read/write timed out

Obviously accessing PCIe registers of disconnected card is not possible.

Extend check in advk_pcie_valid_device() function for validating
availability of PCIe bus. If PCIe link is down, then the device is marked
as Not Found and the driver does not try to access these registers.

This is just an optimization to prevent accessing PCIe registers when card
is disconnected. Trying to access PCIe registers of disconnected card does
not cause any crash, kernel just needs to wait for a timeout. So if card
disappear immediately after checking for PCIe link (before accessing PCIe
registers), it does not cause any problems.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in V2:
* Update commit message, mention that this is optimization
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..53a4cfd7d377 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return false;
 
+	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
+		return false;
+
 	return true;
 }
 
-- 
2.20.1

