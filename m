Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEB18DDE8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Mar 2020 05:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCUEzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Mar 2020 00:55:03 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:32886 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUEzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Mar 2020 00:55:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id o5so6333949pfp.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2020 21:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qappvw96EUepcQDh6rIB1HdJ+KdBA/yaiDSOL4qur/U=;
        b=vLSzIN02yZjlPwTzcU400/3gSovfu2ga7/eNWJIeBZzTVfaVsG950ptH+WJiESq+Fh
         nGeqeA3Al1dQKSlP8NBDdCNyOKDTUfiZc/QafzHmTsEZTe+6jNY4tKch/UQFkUxyfUi0
         u5vPufQvl5T/ITXwHMxxnZryYCvWvqrBeJAKwI3CD0xeuBlZVp4QnXMZxHVrGY6vmOxa
         MtDeqSzNtyyKcb0HkDkU0NpKk0ZpvifAqnZgdbHDq4hPeLoPY+lC4fEfRzovlFWhhFOj
         Kjxg4vKKszbmZGs4JPz4kHcu4kPmGNlCnJ55LRwbsL6rPNcTxNVdjjdntzTt4XqjvUs4
         JxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qappvw96EUepcQDh6rIB1HdJ+KdBA/yaiDSOL4qur/U=;
        b=Qa5/rea6Gy4GfEFs6ZrqC2KS0DkLY2C/jrj8dt6CZpHK76kZNb01BJoxYu2zS7B1YU
         4rdPcjlT3CUfXG1F6lSE6IkY+GrIi4JxabP4vPB6PuEvH9m1Uir6eYzlnRYHXjPbh1bI
         VXeJLHetogeCnhmqLPvCFjcaInKrdtyV0YzQWSGLY4Slv4mJ1IWnObwCQ/aArct423mV
         qYUoXbUJVcKyh7+OejAU1vIPhZWJwyyOE8pHUV824OBH5AjmR/yQNA/oD9B64vlnYhuV
         fKg38JibaVTGFFxStowTGGBflI0XdWvRtURPgAcy3Vw4YQllJ228x7GzZZQXzVWXExeL
         QFeQ==
X-Gm-Message-State: ANhLgQ0zvzUtA6tzuTkKe1qxX6OdE94MzK5be/I38NuOpVQg0RSxga1g
        tqoOEtmXm+PiFlZl6avmraoZuDrtPLANVx0=
X-Google-Smtp-Source: ADFU+vun9pvzN/AClZJ+4rDwIUBdbwrf+xnL/lNVKSDppW/XcQpJXplkwUGkMQ1IHdrPzOcLixdg9C1hrXqN4V8=
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr13526925pjb.21.1584766501664;
 Fri, 20 Mar 2020 21:55:01 -0700 (PDT)
Date:   Fri, 20 Mar 2020 21:54:48 -0700
Message-Id: <20200321045448.15192-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] driver core: Add device links from fwnode only for the
 primary device
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sometimes, more than one (generally two) device can point to the same
fwnode.  However, only one device is set as the fwnode's device
(fwnode->dev) and can be looked up from the fwnode.

Typically, only one of these devices actually have a driver and actually
probe. If we create device links for all these devices, then the
suppliers' of these devices (with the same fwnode) will never get a
sync_state() call because one of their consumer devices will never probe
(because they don't have a driver).

So, create device links only for the device that is considered as the
fwnode's device.

One such example of this is the PCI bridge platform_device and the
corresponding pci_bus device. Both these devices will have the same
fwnode. It's the platform_device that is registered first and is set as
the fwnode's device. Also the platform_device is the one that actually
probes. Without this patch none of the suppliers of a PCI bridge
platform_device would get a sync_state() callback.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fc6a60998cd6..5e3cc1651c78 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2404,6 +2404,7 @@ int device_add(struct device *dev)
 	struct class_interface *class_intf;
 	int error = -EINVAL, fw_ret;
 	struct kobject *glue_dir = NULL;
+	bool is_fwnode_dev = false;
 
 	dev = get_device(dev);
 	if (!dev)
@@ -2501,8 +2502,10 @@ int device_add(struct device *dev)
 
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 
-	if (dev->fwnode && !dev->fwnode->dev)
+	if (dev->fwnode && !dev->fwnode->dev) {
 		dev->fwnode->dev = dev;
+		is_fwnode_dev = true;
+	}
 
 	/*
 	 * Check if any of the other devices (consumers) have been waiting for
@@ -2518,7 +2521,8 @@ int device_add(struct device *dev)
 	 */
 	device_link_add_missing_supplier_links();
 
-	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
+	if (fw_devlink_flags && is_fwnode_dev &&
+	    fwnode_has_op(dev->fwnode, add_links)) {
 		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
 		if (fw_ret == -ENODEV)
 			device_link_wait_for_mandatory_supplier(dev);
-- 
2.25.1.696.g5e7596f4ac-goog

