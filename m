Return-Path: <linux-pci+bounces-22368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2CDA448A1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7F4188EEE5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993881A2642;
	Tue, 25 Feb 2025 17:35:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9716130C
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504944; cv=none; b=Gud7l27Cq0jHShLfZIwhDbKpkeNC2y2BEMw+GxbfSE6OKwBb3jJPBnU6Byya72FF7TDteuL+Ax3PdX0vj/pj3sxVYqoLi2ws9cMOn5OiqVpsIUft4y6rQds4n4ajpNYJFm8zktzJSK5D6jmAmXB0jpWgnYlOaPRy8f34t29gKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504944; c=relaxed/simple;
	bh=/4GUkjZyjx0w2OUJMGiBh1GGSWpFC7su/YzbE3lur9s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=SdqROT87BUJ50RI1QGD5B/GRfmkqAv9pAMfFkHYOSQafn4c3R4R/Oaz+oHG5ia4eOqtDMdZM94iYM3jtWdBYYRsy/yFB/PDP+S6yH/s+Fre+9jnA50HkwGPwfeC+n2sHRNTEgGJBb7tIZc/aPFnrBQPp+4UXKfTFlF/96A+8Ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3B438101917AC;
	Tue, 25 Feb 2025 18:27:40 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 0A35D6018168;
	Tue, 25 Feb 2025 18:27:40 +0100 (CET)
X-Mailbox-Line: From ed950fa2722967be4491146c7b867c1e7be11d37 Mon Sep 17 00:00:00 2001
Message-ID: <ed950fa2722967be4491146c7b867c1e7be11d37.1740501868.git.lukas@wunner.de>
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>
References: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:02 +0100
Subject: [PATCH 2/5] PCI: hotplug: Drop superfluous try_module_get() calls
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

In December 2002, historic commit

  https://git.kernel.org/tglx/history/c/bec7aa00ffe5
  ("[PATCH] more module warning fixes")

amended the PCI hotplug core to acquire a reference on the hotplug
driver module when a sysfs attribute is accessed.  That was necessary
because back in the day, sysfs code did not take any precautions to
prevent module unloading when an attribute was accessed.

Soon after in July 2003, historic commit

  https://git.kernel.org/tglx/history/c/1cf6d20f6078
  ("[PATCH] SYSFS: add module referencing to sysfs attribute files.")

addressed that deficiency.  But the commit neglected to remove the now
unnecessary reference acquisition from the PCI hotplug core.

The commit acquired a module reference for the entire duration between
open() and close() of a sysfs attribute.  This made it impossible to
unload a module while attributes were kept open by user space.
That's possible today:

When a hotplug driver module is unloaded, it removes sysfs attributes of
all its hotplug slots by calling pci_hp_del().  This will wait for any
concurrent user space operation to finish:

  pci_hp_del()
    fs_remove_slot()
      sysfs_remove_file()
        sysfs_remove_file_ns()
          kernfs_remove_by_name_ns()
            __kernfs_remove()
              kernfs_drain()

A user space operation such as read() briefly acquires a reference on
the attribute with kernfs_get_active().  kernfs_drain() waits until all
such references are released before allowing attribute removal.  Once
the attribute is removed, any subsequent user space operation on a still
open attribute file will return -ENODEV.

Thus, reference acquisition by the PCI hotplug core is still unnecessary
today.  So drop it at long last.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 9e3cde91c167..de5b501b40be 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -14,7 +14,7 @@
  *   Scott Murray <scottm@somanetworks.com>
  */
 
-#include <linux/module.h>	/* try_module_get & module_put */
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -46,11 +46,8 @@ static int get_##name(struct hotplug_slot *slot, type *value)		\
 {									\
 	const struct hotplug_slot_ops *ops = slot->ops;			\
 	int retval = 0;							\
-	if (!try_module_get(slot->owner))				\
-		return -ENODEV;						\
 	if (ops->get_##name)						\
 		retval = ops->get_##name(slot, value);			\
-	module_put(slot->owner);					\
 	return retval;							\
 }
 
@@ -83,10 +80,6 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 	power = (u8)(lpower & 0xff);
 	dbg("power = %d\n", power);
 
-	if (!try_module_get(slot->owner)) {
-		retval = -ENODEV;
-		goto exit;
-	}
 	switch (power) {
 	case 0:
 		if (slot->ops->disable_slot)
@@ -102,9 +95,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 		err("Illegal value specified for power\n");
 		retval = -EINVAL;
 	}
-	module_put(slot->owner);
 
-exit:
 	if (retval)
 		return retval;
 	return count;
@@ -141,15 +132,9 @@ static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
 	attention = (u8)(lattention & 0xff);
 	dbg(" - attention = %d\n", attention);
 
-	if (!try_module_get(slot->owner)) {
-		retval = -ENODEV;
-		goto exit;
-	}
 	if (ops->set_attention_status)
 		retval = ops->set_attention_status(slot, attention);
-	module_put(slot->owner);
 
-exit:
 	if (retval)
 		return retval;
 	return count;
@@ -207,15 +192,9 @@ static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 	test = (u32)(ltest & 0xffffffff);
 	dbg("test = %d\n", test);
 
-	if (!try_module_get(slot->owner)) {
-		retval = -ENODEV;
-		goto exit;
-	}
 	if (slot->ops->hardware_test)
 		retval = slot->ops->hardware_test(slot, test);
-	module_put(slot->owner);
 
-exit:
 	if (retval)
 		return retval;
 	return count;
-- 
2.43.0


