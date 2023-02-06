Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569668C7F3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBFUuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBFUuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB22BF0A;
        Mon,  6 Feb 2023 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716609; x=1707252609;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hh2rH5Q/YssEi0TmAoW2giYHa8vKVnvNuJJXfa9pxWE=;
  b=XLWN+sOA0v2yGisZtuqQS7JHYu4dfYOX71Oi/WZsoQOx4MKBOIzdIjqK
   TGNjtPsb8tIXadj2HvbFf1mJR5AyhISAcwQNRu7GS1W3vx/T1ZbVQtjfM
   imiy4N4BtAEIYgB1l9Dlgn1y38EVHWKWZPwrvNLLGj50UL08PZicGcZxw
   /+4Zb16ZBP5asz+OJUdEeNcN5JcZVAfXKGiinPKcnbDmr6ZBgcyWienR9
   YQuvSOEnW52/bW1H28fWAWBFIylZ8FsBgVOPZFhNDw7sx8HRqstd14mYD
   C2FxlD51fWvcNLdlUCUCAlGfH6lJs4qEx5DjdQKf3YacPC4p71wK+eSP7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330604686"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330604686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995471751"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995471751"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:08 -0800
Subject: [PATCH 05/18] ACPICA: Fix 'struct acpi_cdat_dsmas' spelling mistake
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:06 -0700
Message-ID: <167571660543.587790.9945516736671124794.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'struct acpi_cadt_dsmas' => 'struct acpi_cdat_dsmas'

Fixes: 51aad1a6723b ("ACPICA: Finish support for the CDAT table")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/acpi/actbl1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4175dce3967c..e8297cefde09 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -344,7 +344,7 @@ enum acpi_cdat_type {
 
 /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
 
-struct acpi_cadt_dsmas {
+struct acpi_cdat_dsmas {
 	u8 dsmad_handle;
 	u8 flags;
 	u16 reserved;


