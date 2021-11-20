Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96F4579DF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKTAGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhKTAGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542398"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088348"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
Date:   Fri, 19 Nov 2021 16:02:32 -0800
Message-Id: <20211120000250.1663391-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The expectation is that the mailbox interface ready bit is the first
step in access through the mailbox interface. Therefore, waiting for the
doorbell busy bit to be clear would imply that the mailbox interface is
ready. The original driver implementation used the doorbell timeout for
the Mailbox Interface Ready bit to piggyback off of, since the latter
doesn't have a defined timeout (introduced in 8adaf747c9f0 ("cxl/mem:
Find device capabilities"), a timeout has since been defined with an ECN
to the 2.0 spec). With the current driver waiting for mailbox interface
ready as a part of probe() it's no longer necessary to use the
piggyback.

With the piggybacking no longer necessary it doesn't make sense to check
doorbell status when acquiring the mailbox. It will be checked during
the normal mailbox exchange protocol.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This patch did not exist in RFCv2
---
 drivers/cxl/pci.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2cef9fec8599..869b4fc18e27 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -221,27 +221,14 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
 
 	/*
 	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
-	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
+	 * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
 	 * bit is to allow firmware running on the device to notify the driver
-	 * that it's ready to receive commands. It is unclear if the bit needs
-	 * to be read for each transaction mailbox, ie. the firmware can switch
-	 * it on and off as needed. Second, there is no defined timeout for
-	 * mailbox ready, like there is for the doorbell interface.
-	 *
-	 * Assumptions:
-	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
-	 *    it for every command.
-	 *
-	 * 2. If the doorbell is clear, the firmware should have first set the
-	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
-	 *    to be ready is sufficient.
+	 * that it's ready to receive commands. The spec does not clearly define
+	 * under what conditions the bit may get set or cleared. As of the 2.0
+	 * base specification there was no defined timeout for mailbox ready,
+	 * like there is for the doorbell interface. This was fixed with an ECN,
+	 * but it's possible early devices implemented this before the ECN.
 	 */
-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
-	if (rc) {
-		dev_warn(dev, "Mailbox interface not ready\n");
-		goto out;
-	}
-
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
 		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
-- 
2.34.0

