Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3184268C809
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBFUvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E492B097;
        Mon,  6 Feb 2023 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716709; x=1707252709;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ANJK4WgXvZBb1RvzfDrGlJT/1Xf1pViUoSVpIMURtjI=;
  b=UFFYySA1LWF+9VBYxRHlZFKTA3MveMNcoufbCJvzRZcCekQUtFeIESsb
   S1yo7yBWVADFLTCFsTx749F9A8aCZSNYa0EFzJ8WVMNwHBW3rXnHvb3d6
   55scEKV4a4/VzxHsHIyium4w+Gcbf080f2zi/xBYWI9Q7826jBXeoOEKq
   uRqykxNH2mtPi9PERlIi7TkMy/6uU3fGh3CbDkB56n5UBBIpmOuQpJ7gY
   UpfUd6oQBSPRoeZfFfaTv/i0NrotkjnzSCHqTiK8u69/KyMchMmI9Q6OP
   198pnKk1dL4mQ4txGjntmF1ehuWH7iOpQY1qKH0pOQIvmHN90bY3rEoTH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327946637"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327946637"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790552372"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790552372"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:48 -0800
Subject: [PATCH 16/18] cxl: Move reading of CDAT data from device to after
 media is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:46 -0700
Message-ID: <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CDAT data is only valid after the hardware signals the media is ready.
Move the reading to after cxl_await_media_ready() has succeeded.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index b7a4a1be2945..6b2ad22487f5 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -91,9 +91,6 @@ static int cxl_port_probe(struct device *dev)
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-		/* Cache the data early to ensure is_visible() works */
-		read_cdat_data(port);
-
 		get_device(&cxlmd->dev);
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
 		if (rc)
@@ -109,6 +106,8 @@ static int cxl_port_probe(struct device *dev)
 			return rc;
 		}
 
+		/* Cache the data early to ensure is_visible() works */
+		read_cdat_data(port);
 		if (port->cdat.table) {
 			rc = cdat_table_parse_dsmas(port->cdat.table,
 						    cxl_dsmas_parse_entry,


