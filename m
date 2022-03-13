Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C903C4D77F3
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiCMTaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiCMTay (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9124D604
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4700B80CF7
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4EC340E8;
        Sun, 13 Mar 2022 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199782;
        bh=lv9D7iOfXA5PjIaE9GIPweH1eI+y/6YiF76CcxBT0aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7nYBNsTx/xRrz0n6nuMuePrmNwICu/jUCHJ3GyjeLrZ79Bdfl29WEqXkvAGgY6m/
         VWRjmFxcJycOlyO+u1oxSib5yeJhe8weveGajt4ONFQsbxSWfXbgFJN7iMDUizogmx
         T3VBkuSXxm6u8G3U0xGt7fREvEnl4+xn+Na0+dIxOXL9x8oU24Wt1xG55Bz4tdQMFs
         XNcc+vyjAckB8H1j4ROvSOne5UJpi8EG2DncqLI+D9vc51rrMv4syxsOvd2f3mgMPM
         Pn6X3ScKaod/O+InbiH8UPHCC6Noo5klUXVsbZlHFBiCSqDGsTT+l0dzKHtGTco4R0
         W+OX+HtmJDOVQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] PCI: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:29 -0500
Message-Id: <20220313192933.434746-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313192933.434746-1-helgaas@kernel.org>
References: <20220313192933.434746-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove variables and assignments that are never used.

Found by Krzysztof Wilczyński <kw@linux.com> using cppcheck, e.g.,

  $ cppcheck --enable=all --force
  uselessAssignmentPtrArg drivers/pci/proc.c:102 Assignment of function parameter has no effect outside the function. Did you forget dereferencing it?
  unreadVariable drivers/pci/setup-bus.c:1528 Variable 'old_flags' is assigned a value that is never used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c | 7 +------
 drivers/pci/proc.c      | 4 ----
 drivers/pci/setup-bus.c | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..c263ffc5884a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -754,8 +754,6 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 		u8 val;
 		pci_user_read_config_byte(dev, off, &val);
 		data[off - init_off] = val;
-		off++;
-		--size;
 	}
 
 	pci_config_pm_runtime_put(dev);
@@ -818,11 +816,8 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 		size -= 2;
 	}
 
-	if (size) {
+	if (size)
 		pci_user_write_config_byte(dev, off, data[off - init_off]);
-		off++;
-		--size;
-	}
 
 	pci_config_pm_runtime_put(dev);
 
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 1a5b75399aa5..31b26d8ea6cc 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -99,9 +99,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 		unsigned char val;
 		pci_user_read_config_byte(dev, pos, &val);
 		__put_user(val, buf);
-		buf++;
 		pos++;
-		cnt--;
 	}
 
 	pci_config_pm_runtime_put(dev);
@@ -176,9 +174,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 		unsigned char val;
 		__get_user(val, buf);
 		pci_user_write_config_byte(dev, pos, val);
-		buf++;
 		pos++;
-		cnt--;
 	}
 
 	pci_config_pm_runtime_put(dev);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 547396ec50b5..3290b64ea9f0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1525,7 +1525,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 {
 	struct pci_dev *dev = bus->self;
 	struct resource *r;
-	unsigned int old_flags = 0;
+	unsigned int old_flags;
 	struct resource *b_res;
 	int idx = 1;
 
-- 
2.25.1

