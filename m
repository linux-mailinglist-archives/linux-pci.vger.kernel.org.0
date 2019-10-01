Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B089C315E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJAK3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:29:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:12065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbfJAK3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="191418908"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 03:29:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C12A234; Tue,  1 Oct 2019 13:29:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/3] thunderbolt: Drop unnecessary read when writing LC command in Ice Lake
Date:   Tue,  1 Oct 2019 13:29:05 +0300
Message-Id: <20191001102905.21680-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
References: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The read is not needed as we overwrite the returned value in the next
line anyway so drop it.

Fixes: 3cdb9446a117 ("thunderbolt: Add support for Intel Ice Lake")
Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi_ops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi_ops.c b/drivers/thunderbolt/nhi_ops.c
index 61cd09cef943..6795851aac95 100644
--- a/drivers/thunderbolt/nhi_ops.c
+++ b/drivers/thunderbolt/nhi_ops.c
@@ -80,7 +80,6 @@ static void icl_nhi_lc_mailbox_cmd(struct tb_nhi *nhi, enum icl_lc_mailbox_cmd c
 {
 	u32 data;
 
-	pci_read_config_dword(nhi->pdev, VS_CAP_19, &data);
 	data = (cmd << VS_CAP_19_CMD_SHIFT) & VS_CAP_19_CMD_MASK;
 	pci_write_config_dword(nhi->pdev, VS_CAP_19, data | VS_CAP_19_VALID);
 }
-- 
2.23.0

