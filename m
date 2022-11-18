Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DE62EA06
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 01:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiKRAFb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 19:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKRAFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 19:05:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C7ABC0;
        Thu, 17 Nov 2022 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668729929; x=1700265929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hWL8ZNgUOuvv1B4SV56p3dDMPMbvsjEleV962v2qcqc=;
  b=RjVMaBgDDUqIB3RA8JHiiYYKXgzaF/Dm8V9C71i0jLSP8h8khC+XCr+n
   T8gZwQ5yv36gaA+29UvaxC8ndzzzEHGg+OyaIiTOJH1py68nvwhsjT+HT
   tmJiJs9e91MFG2uajznUD+JGZ2BqrLXOu1BId21OpDnrxvMQBwXWKonyH
   u6gdWwt9IP4FCdLrk9163NVysTjheBROnmnNKXNkzxJiQJxQssU2xuoNg
   gohLESHOCwNM7lY0twhvbxmr2Q/4K7t+5eJadzxijGBW3hndfrKnmD2xB
   8DbXMV4wZi0zgvf87ErURkvO3wPzbzLCcSJ/yZ08y+duU2MYr23Zj7F4r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300546400"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="300546400"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:05:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="590814123"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="590814123"
Received: from jmartin2-mobl.amr.corp.intel.com (HELO localhost) ([10.209.2.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:05:27 -0800
From:   ira.weiny@intel.com
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Date:   Thu, 17 Nov 2022 16:05:24 -0800
Message-Id: <20221118000524.1477383-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Work item initialization needs to be done with either
INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
allocated.

The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
stack and pci_doe_submit_task() incorrectly used INIT_WORK().

Jonathan suggested creating doe task allocation macros such as
DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
function is not known to the callers and must be initialized correctly.

A follow up suggestion was to have an internal 'pci_doe_work' item
allocated by pci_doe_submit_task().[2]  This requires an allocation which
could restrict the context where tasks are used.

Another idea was to have an intermediate step to initialize the task
struct with a new call.[3]  This added a lot of complexity.

Lukas pointed out that object_is_on_stack() is available to detect this
automatically.

Use object_is_on_stack() to determine the correct init work function to
call.

[1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
[2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
[3] https://lore.kernel.org/all/20221115011943.1051039-1-ira.weiny@intel.com/

Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1
	Update oneliner
	Use object_is_on_stack() to make this a simple fix
---
 drivers/pci/doe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index e402f05068a5..42de517022d9 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/workqueue.h>
+#include <linux/sched/task_stack.h>
 
 #define PCI_DOE_PROTOCOL_DISCOVERY 0
 
@@ -529,7 +530,10 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
 		return -EIO;
 
 	task->doe_mb = doe_mb;
-	INIT_WORK(&task->work, doe_statemachine_work);
+	if (object_is_on_stack(&task->work))
+		INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);
+	else
+		INIT_WORK(&task->work, doe_statemachine_work);
 	queue_work(doe_mb->work_queue, &task->work);
 	return 0;
 }

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
prerequisite-patch-id: dfea657e07f37aa9d7c3d477d68b07f64fe78721
prerequisite-patch-id: e27264e76e637214ee50cdab0e5854b223d44b4e
-- 
2.37.2

