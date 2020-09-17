Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C626E48F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIQSuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 14:50:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:44123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbgIQQ0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:26:08 -0400
IronPort-SDR: 24kYRhgYuhRfLqyohE3rSM8+AZB96+IShqgCvcoYHmbezHzyuKmaDu1JSS2GbWQy69rIuPS2Ad
 KqFSYafoRDzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139236837"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="139236837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:56 -0700
IronPort-SDR: 1eMycD69EG6Z5h8/eRzY3Ne3dDxoX/t/jWNX958WBDT/wwectLmeeL57T28MqnXohJMJ7cr32d
 MZ8YWIdNV3XA==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="332220103"
Received: from mbair-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.181.111])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:25:56 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v4 09/10] PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
Date:   Thu, 17 Sep 2020 09:25:47 -0700
Message-Id: <20200917162548.2079894-10-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917162548.2079894-1-sean.v.kelley@intel.com>
References: <20200917162548.2079894-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Root Complex Event Collectors(RCEC) appear as peers of Root Ports
and also have the PME capability. As with AER, there is a need to be
able to walk the RCiEPs associated with their RCEC for purposes of
acting upon them with callbacks. So add RCEC support through the use
of pcie_walk_rcec() to the current PME service driver and attach the
PME service driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/pme.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 6a32970bb731..87799166c96a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
 static void pcie_pme_mark_devices(struct pci_dev *port)
 {
 	pcie_pme_can_wakeup(port, NULL);
-	if (port->subordinate)
+
+	if (pci_pcie_type(port) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
+	else if (port->subordinate)
 		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
 }
 
@@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev *port)
  */
 static int pcie_pme_probe(struct pcie_device *srv)
 {
-	struct pci_dev *port;
+	struct pci_dev *port = srv->port;
 	struct pcie_pme_service_data *data;
 	int ret;
 
+	/* Limit to Root Ports or Root Complex Event Collectors */
+	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
+	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	data->srv = srv;
 	set_service_data(srv, data);
 
-	port = srv->port;
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
 
@@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
 
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_PME,
 
 	.probe		= pcie_pme_probe,
-- 
2.28.0

