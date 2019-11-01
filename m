Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4EEC9CE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfKAUq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 16:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfKAUq2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:46:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64153217D9;
        Fri,  1 Nov 2019 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641187;
        bh=gBtBxUPX0z0dr/96PZO7T5LUfDsyS3pS2T9fKmfigx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5GePef3mZHVsWfixm6pT0lp9b+3EXpxI+IeheoSd6Rox+c0CPhnRowItQi5+8uOk
         bShJdg1uDunvD69b+lR9SHlMBqfL9h6ZPqXLIOk1KDiO28bXa2cD8EAvlhvuTH0sjv
         WlFeVltFWmAL1xMV1cCmYHR1Rbw6KRBmwr9zQtDg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/6] PCI/PM: Apply D2 delay as milliseconds, not microseconds
Date:   Fri,  1 Nov 2019 15:45:53 -0500
Message-Id: <20191101204558.210235-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
References: <20191101204558.210235-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI_PM_D2_DELAY is defined as 200, which is milliseconds, but previously we
used udelay(), which only waited for 200 microseconds.  Use msleep()
instead so we wait the correct amount of time.  See PCIe r5.0, sec 5.9.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7982af9a5d8..cd96874ae76d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -886,7 +886,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
-		udelay(PCI_PM_D2_DELAY);
+		msleep(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

