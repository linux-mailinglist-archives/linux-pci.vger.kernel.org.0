Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567A395630
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 06:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTEk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 00:40:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39372 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHTEk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 00:40:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so2568624pfn.6
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2019 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sNb9kJtihg3GPKIHSK3FCQKq71eHM5E0DTQmxnSsAQY=;
        b=KN7S3X4/mEQpC3vQkoQGXCKJcRuB7LmuRbTXZrUXy3bEi4DvSJDQ+P7XIrGqjmfIwO
         dU3csSkd1ivai56Vj+T90aBKnUGUwp5bSZuF5yqULISq9dHtKUngwL6DOElL9u1o1ccT
         7aSVnxeWOILBkHrUR5ToD2B0krrR0gxqqqrok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sNb9kJtihg3GPKIHSK3FCQKq71eHM5E0DTQmxnSsAQY=;
        b=V0Ni1kbPSyr3vyaLeAnz9yLbx7D3N06CAetBwKcaExIhG5ElH0bQ/8W3TVZGfcG4J7
         /zf+icZQTpcgi1Y/bxq+a5PWHxjzHSXshd0daJNq2PBzo6gFkOiPoBCNklbNDlAJIIze
         YDzggeowubB7FQBxZepeMGevt8xpYIB0ZHxt/1Otu4ThyA9CpoLYgmb7TKgFexGvL1om
         5BL0HaQEMRbOiCjKE7d4jwP/Ow+30AT/so8KYFZSfPjKWQqeO3rDWTlQGevrEadhHsb5
         bZ43zhmpKITWnlvlNdhlAzxBAWFrZCN9OpVp4PUuoncuNsFtIzkRyLfMNZDMt5eA3cuN
         nvYQ==
X-Gm-Message-State: APjAAAXS3ToAFHJjBEpg8BkYv6X7JERWKL5QH8wQdr7R+FA3p/Ku5LI9
        WqSFDmpS6jkPjY3LDGmbJqCJkHvDKu9hXg==
X-Google-Smtp-Source: APXvYqzw5kNXvlE6fTaN/lYNgGjKQtyt0KFFW0K8ZukUC4NwoS8IxFhwq2Z7LaCHh5ZFOiKBrawDOA==
X-Received: by 2002:a17:90a:36ad:: with SMTP id t42mr23920561pjb.21.1566276025190;
        Mon, 19 Aug 2019 21:40:25 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g11sm22358957pfk.187.2019.08.19.21.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 21:40:24 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] PCI: Add PCIE ACS quirk for IPROC PAXB
Date:   Tue, 20 Aug 2019 10:09:45 +0530
Message-Id: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Abhinav Ratna <abhinav.ratna@broadcom.com>

IPROC PAXB RC doesn't support ACS capabilities and control registers.
Add quirk to have separate IOMMU groups for all EPs and functions connected
to root port, by masking RR/CR/SV/UF bits.

Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc..f9584c0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4466,6 +4466,21 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	return acs_flags ? 0 : 1;
 }
 
+static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * IPROC PAXB RC doesn't support ACS capabilities and control registers.
+	 * Add quirk to to have separate IOMMU groups for all EPs and functions
+	 * connected to root port, by masking RR/CR/SV/UF bits.
+	 */
+
+	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
+	int ret = acs_flags & ~flags ? 0 : 1;
+
+	return ret;
+}
+
+
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
@@ -4559,6 +4574,7 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
 	{ 0 }
 };
 
-- 
2.7.4

