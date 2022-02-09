Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE954AF6A5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiBIQ2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiBIQ2G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:28:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240AAC0612BE;
        Wed,  9 Feb 2022 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644424090; x=1675960090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xDllACrM1jkRg5OdsD/bQKn/k5Fz/vMeCzLCNSjfcbY=;
  b=BHYGN/opR4zHYyEa/LkIuZZHbxR2SnHUyPoWTUa9ApKqwBsM1nxEvcbK
   ipwm4xBG83bjROkK8fO8rKXXDhBfrjsYKHsv7eYfsAdvZtk4jtM03kPET
   QvFSxHFBlravIvsVijY2+wNKORQ7YJTDfiB8oYAKN291gZzXWO3TGeSSS
   q1n/KmXy+oawEBGSjj8aYSB4bQ4wBLe0gWn00b+RHdZ++80+SVNjR6HEx
   CqkzFZpeeUcyGeOwgUj1Of6jXJKt+FbFfuNDRcOS9HRP5h8bETGn4vCFo
   4pMDu6K05Yj6/e6P3dS/GODy+cA5RISWGbHOyNmOqDRz5T/VCbR0PymZj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229888931"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229888931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:28:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="771392145"
Received: from awvttdev-05.aw.intel.com ([10.228.212.156])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:28:09 -0800
From:   "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, logang@deltatee.com, michael.j.ruhl@intel.com
Cc:     dan.j.williams@intel.com
Subject: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon platform information
Date:   Wed,  9 Feb 2022 11:28:01 -0500
Message-Id: <20220209162801.7647-1-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to do P2P communication the bridge ID of the platform
must be in the P2P device table.

Update the P2P device table with a device id for the 3rd Gen
Intel Xeon Scalable Processors.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/pci/p2pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1015274bd2fe..30b1df3c9d2f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -321,6 +321,7 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
+	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
 	{}
 };
 
-- 
2.31.1

