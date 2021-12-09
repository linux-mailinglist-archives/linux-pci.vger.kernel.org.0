Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84C846F609
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhLIVkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:40:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B0C061746;
        Thu,  9 Dec 2021 13:36:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k26so6590847pfp.10;
        Thu, 09 Dec 2021 13:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1f5T8aJYiDFkPJGm5beIMpQSieyUomju95E5CcKuz4=;
        b=ZBlxHwH+aqEQxGw2i5VvMNtWuSPGovMDhxOUuZH1P9ObzPxOxbSRA4fNP+nuC65R0L
         rpZ7woeTeFz8B8vhe8uJu6lCDE7ueal3Qgg6Y2YhzgGtfRvoqqt9oI4417bdl0r1WUVv
         JV/XCpzSfC+j5OnY/VABwVObGXoXCxIPCByl+vsCGlPYxoCT7anX0ckGXz7QdPTwoL1y
         VmAVNv6INCQMJxFInU/U2D98VzosuUWYpzqcRPSr/Rjag46e1qblE1sPD5tIEmN+Ciic
         rPh8CppMxCCwnSisRnacwHTQHWnyAhLmJYKHy0MNr6VSLCSb8nsXP+LTA8iUf+Q+uE/D
         mVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o1f5T8aJYiDFkPJGm5beIMpQSieyUomju95E5CcKuz4=;
        b=PucN/As35/VPaTe19sDGZbNRwgxhug7zPyFCkVPs8ecWuci4lnFHs7Vjd9qbekjksr
         tFo5i/fDF07BA/N9JgVAFWD1sQFSMdapWVsAqStpLXDETZR0grsjvAppHfoqr6qmXk0J
         Yr8CJkfV97r1rYKSh1CWanPALStRIr2IVAnl5JSYvbEhKlT0IVB37lQV5jcNWY8dX/Hq
         mwL6pXwwk4aHalp3z9paZp+0iY48x7lTQK8Tp49f+BiOLtQYYZrTn0M5eXzzN1aw/28y
         QE9mNJ35sQ6TNaz6Wo70f+dHIK+YsWsscnLcaNJ+SkL7s1hb0AVt5/Hp3bahIpWAQEbC
         tzhQ==
X-Gm-Message-State: AOAM531x1y7ZV9dnGAtyfHv0SH/ObhipSmsutbuWh/PuPphe21Db5YDg
        jdqjiuZMOGc/i53MSpo6D7A=
X-Google-Smtp-Source: ABdhPJyy+D33tn5Oxeg6fJbQgVTZifb2VrNtJGQeZ+6RV4lN+LN/z1nHVEmtP97rkY+fTQbKa5V0lg==
X-Received: by 2002:a63:a0b:: with SMTP id 11mr37431492pgk.282.1639085787613;
        Thu, 09 Dec 2021 13:36:27 -0800 (PST)
Received: from localhost.localdomain ([103.238.105.137])
        by smtp.gmail.com with ESMTPSA id ot18sm574453pjb.14.2021.12.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:36:27 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     bhelgaas@google.com, lukas@wunner.de
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vihas Mak <makvihas@gmail.com>
Subject: [PATCH] pci: ibmphp: removed the commented-out functions
Date:   Fri, 10 Dec 2021 03:06:18 +0530
Message-Id: <20211209213618.20522-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The functions get_max_adapter_speed() and get_bus_name() in
ibmphp_core.c are commented-out and the fields .get_max_adapter_speed
and .get_bus_name_status are removed from struct hotplug_slot_ops in
pci_hotplug.h. Remove the commented-out functions.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/pci/hotplug/TODO          |  5 ---
 drivers/pci/hotplug/ibmphp_core.c | 74 -------------------------------
 2 files changed, 79 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index cc6194aa2..88f217c82 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -30,11 +30,6 @@ ibmphp:
   or ibmphp should store a pointer to its bus in struct slot.  Probably the
   former.
 
-* The functions get_max_adapter_speed() and get_bus_name() are commented out.
-  Can they be deleted?  There are also forward declarations at the top of
-  ibmphp_core.c as well as pointers in ibmphp_hotplug_slot_ops, likewise
-  commented out.
-
 * ibmphp_init_devno() takes a struct slot **, it could instead take a
   struct slot *.
 
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 17124254d..197997e26 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -50,14 +50,6 @@ static int irqs[16];    /* PIC mode IRQs we're using so far (in case MPS
 
 static int init_flag;
 
-/*
-static int get_max_adapter_speed_1 (struct hotplug_slot *, u8 *, u8);
-
-static inline int get_max_adapter_speed (struct hotplug_slot *hs, u8 *value)
-{
-	return get_max_adapter_speed_1 (hs, value, 1);
-}
-*/
 static inline int get_cur_bus_info(struct slot **sl)
 {
 	int rc = 1;
@@ -401,69 +393,6 @@ static int get_max_bus_speed(struct slot *slot)
 	return rc;
 }
 
-/*
-static int get_max_adapter_speed_1(struct hotplug_slot *hotplug_slot, u8 *value, u8 flag)
-{
-	int rc = -ENODEV;
-	struct slot *pslot;
-	struct slot myslot;
-
-	debug("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n",
-						(ulong)hotplug_slot, (ulong) value);
-
-	if (flag)
-		ibmphp_lock_operations();
-
-	if (hotplug_slot && value) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			memcpy(&myslot, pslot, sizeof(struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-						&(myslot.status));
-
-			if (!(SLOT_LATCH (myslot.status)) &&
-					(SLOT_PRESENT (myslot.status))) {
-				rc = ibmphp_hpc_readslot(pslot,
-						READ_EXTSLOTSTATUS,
-						&(myslot.ext_status));
-				if (!rc)
-					*value = SLOT_SPEED(myslot.ext_status);
-			} else
-				*value = MAX_ADAPTER_NONE;
-		}
-	}
-
-	if (flag)
-		ibmphp_unlock_operations();
-
-	debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
-	return rc;
-}
-
-static int get_bus_name(struct hotplug_slot *hotplug_slot, char *value)
-{
-	int rc = -ENODEV;
-	struct slot *pslot = NULL;
-
-	debug("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
-
-	ibmphp_lock_operations();
-
-	if (hotplug_slot) {
-		pslot = hotplug_slot->private;
-		if (pslot) {
-			rc = 0;
-			snprintf(value, 100, "Bus %x", pslot->bus);
-		}
-	} else
-		rc = -ENODEV;
-
-	ibmphp_unlock_operations();
-	debug("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
-	return rc;
-}
-*/
-
 /****************************************************************************
  * This routine will initialize the ops data structure used in the validate
  * function. It will also power off empty slots that are powered on since BIOS
@@ -1231,9 +1160,6 @@ const struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
 	.get_attention_status =		get_attention_status,
 	.get_latch_status =		get_latch_status,
 	.get_adapter_status =		get_adapter_present,
-/*	.get_max_adapter_speed =	get_max_adapter_speed,
-	.get_bus_name_status =		get_bus_name,
-*/
 };
 
 static void ibmphp_unload(void)
-- 
2.30.2

