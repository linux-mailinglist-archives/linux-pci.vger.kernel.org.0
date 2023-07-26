Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D819763E79
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGZS3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGZS3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 14:29:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20817213A;
        Wed, 26 Jul 2023 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690396184; x=1721932184;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=2UugmXYB/i6kxbLyCIwBGxYk5WEtjViQvhva6LrKcZ8=;
  b=e6Hf/Ru1nrHvMkJdHviHRLU5D7Mx9xBWAPz+h9EGjCTF+SWu+hy96QZQ
   +ay7rvQU24+k8mrcli6C5C1pAf6Qk7oPtFW8IHbyDgxSnjXDZEjFZ0+xQ
   Hz72gvsE3LZzgnm4cQ/WpqA0dM1Jqj7Fn0Ird3yakkH1VIo6ZcQSU0TL9
   g7qn715nmFGlkcjAdF8txWF5r/EzQO7/nCA8lD6ahpH2asd/6DKOzcYDs
   U7CoU2fadAJK5Cy9HVb69mVQKgKAsmzo7/mKHlvRQtrWxxDSPYZI00dF8
   7jL/0DspqG/WcEtZGSFDpAyFGMOOUxpmdHlunB0W+HQ61QK74Ly7J7OlS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358097126"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="358097126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796685529"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="796685529"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.97.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:29:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 26 Jul 2023 11:29:42 -0700
Subject: [PATCH] PCI/DOE: Fix destroy_work_on_stack() race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
X-B4-Tracking: v=1; b=H4sIABVmwWQC/x3NwQqDQAyE4VeRnBuwa6u1ryI9RJ3VHLqWRKQgv
 nvXHn/mg9nJYQqnZ7GTYVPXJeW4XgoaZkkTWMfcFMpQlU2oeVzAUb8c7017q2ILeQTKuhcH9yZ
 pmE//Fl9h5/AxZP+/6F7H8QMFUKircgAAAA==
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690396182; l=2634;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=2UugmXYB/i6kxbLyCIwBGxYk5WEtjViQvhva6LrKcZ8=;
 b=GGm4zVVuZ0rQJCHxxpdw9IG6KWDuY6e3e3wvOSZ6PSc5nfExk5Q7aWs3zLf4MGtYts7Xbv17H
 MYyeMY9tSM0Cs1iGhibASlW/kJcu+sXF2+7Acokaoa16UwBkgpwIsI7
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following debug object splat was observed in testing.

  [   14.061937] ------------[ cut here ]------------
  [   14.063899] ODEBUG: free active (active state 0) object: 0000000097d23782 object type: work_struct hint: doe_statemachine_work+0x0/0x510
  [   14.067480] WARNING: CPU: 1 PID: 71 at lib/debugobjects.c:514 debug_print_object+0x7d/0xb0
  ...
  [   14.080951] Workqueue: pci 0000:36:00.0 DOE [1 doe_statemachine_work
  [   14.083485] RIP: 0010:debug_print_object+0x7d/0xb0
  ...
  [   14.116231] Call Trace:
  [   14.117652]  <TASK>
  [   14.118958]  ? debug_print_object+0x7d/0xb0
  [   14.120782]  ? __warn+0x7d/0x130
  [   14.122399]  ? debug_print_object+0x7d/0xb0
  [   14.123746]  ? report_bug+0x18d/0x1c0
  [   14.125025]  ? handle_bug+0x3c/0x80
  [   14.126506]  ? exc_invalid_op+0x13/0x60
  [   14.127796]  ? asm_exc_invalid_op+0x16/0x20
  [   14.129380]  ? debug_print_object+0x7d/0xb0
  [   14.130688]  ? debug_print_object+0x7d/0xb0
  [   14.131997]  ? __pfx_doe_statemachine_work+0x10/0x10
  [   14.133597]  debug_object_free.part.0+0x11b/0x150
  [   14.134940]  doe_statemachine_work+0x45e/0x510
  [   14.136348]  process_one_work+0x1d4/0x3c0
  ...
  [   14.161484]  </TASK>
  [   14.162434] ---[ end trace 0000000000000000 ]---

This occurs because destroy_work_on_stack() was called after signaling
the completion in the calling thread.  This creates a race between
destroy_work_on_stack() and the task->work struct going of scope in the
pci_doe().

Signal the work complete after destroying the work struct.  This is safe
because signal_task_complete() is the final thing the work item does and
the workqueue code is careful not to access the work struct after.

Fixes: abf04be0e707 ("PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y")
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/doe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..e3aab5edaf70 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -293,8 +293,8 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
 static void signal_task_complete(struct pci_doe_task *task, int rv)
 {
 	task->rv = rv;
-	task->complete(task);
 	destroy_work_on_stack(&task->work);
+	task->complete(task);
 }
 
 static void signal_task_abort(struct pci_doe_task *task, int rv)

---
base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
change-id: 20230726-doe-fix-f57943f9ea82

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

