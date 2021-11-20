Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF83D4579E3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhKTAGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:5724 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhKTAGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542399"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088351"
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
Subject: [PATCH 06/23] cxl/pci: Don't check media status for mbox access
Date:   Fri, 19 Nov 2021 16:02:33 -0800
Message-Id: <20211120000250.1663391-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Media status is necessary for using HDM contained in a CXL device but is
not needed for mailbox accesses. Therefore remove this check. It will be
necessary to have this check (in a different place) when enabling HDM.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This patch did not exist in RFCv2
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 869b4fc18e27..711bf4514480 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -230,7 +230,7 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
 	 * but it's possible early devices implemented this before the ECN.
 	 */
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
+	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
 		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
 		rc = -EBUSY;
 		goto out;
-- 
2.34.0

