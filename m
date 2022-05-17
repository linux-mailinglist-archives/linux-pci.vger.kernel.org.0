Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7F52ADD3
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 00:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiEQWIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiEQWIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 18:08:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE396377FF
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m136-20020a25268e000000b0064b233e03d1so300160ybm.14
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tf+qNQoI5qGFZ9RW7jx4HEPwOLh/TGpPIUH/6a1l9U4=;
        b=Vsd0rtAyuCX1ep9X8JPz0kVgE4qriTwFWX2119dzWimM6EjZ30AHxEw53p3qxrWdi5
         POmyjeHImwG4MqnpLGozKFxoNPL5EGmsOIPrfxbeifQQoCw61r9cF6yLgj9qaJudrBCn
         TjT2tZwfvaODmd0MssVVbrKjGeMSc6AW81dJLt5WkCPgCAdTmPdy1mskr6PlDa56AKta
         25rvMKsojCYOuGZa4hqfLIuJZnoUa0GnEMoN2rRTBJeMWGKQFe9SJr22yWJXSPsaCeoQ
         awSYMJYsMF7kP+naNxCLPkKZAodpvp94xIYrYzmJDzVjbz7xUvrsI31pwdAGhXQwJLv7
         LH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tf+qNQoI5qGFZ9RW7jx4HEPwOLh/TGpPIUH/6a1l9U4=;
        b=NNKuDmeA1H7jcIgBG7DEjQ8SfABU296VzvJwNjgGZzZxST6WjcxgHmVkxZeQl3kL1L
         2nOIz2/+Kw2FVqHK/HO5K3EuvLNCygvbuEwN3qGukgjn6RB2kmG/aGdOJMs1Gn0iLaXP
         qpXnvDN3F68HP89DY9V2cqJiOEjJkhcp4mWlWBxcnrA0SEF3fLsbUeoxi55DrTwkKN0p
         xCtwP/siHQSapal87dWtgyJn+E61tijOoUyrLeU4qLJoBgs4cilM49wsCDxs4adCZUVC
         4UwZAnVuUqo0jWZk71vRQGhsOk//qy/pt6aNr2QnlyCNVS5xwCqaF2WmbkrM+QIDAiol
         ZiKw==
X-Gm-Message-State: AOAM533+7xE2yV1qSKJ0EYrjOvOdXTy9HLpf3oS25WMpb1gsjccATmEx
        26cbBQPU1w4OxGoSSKwC+/Ay0bijwMwXTpU=
X-Google-Smtp-Source: ABdhPJwcmd7U+J0BbWux8Dql+fC0+EhIAotkoA14iXEPCqqLPyINCsjksq6MYJzDnCiD6Pwc0H4rOmOTjArLiFM=
X-Received: from tansuresh.svl.corp.google.com ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a25:9c08:0:b0:64b:c9f8:de84 with SMTP id
 c8-20020a259c08000000b0064bc9f8de84mr20468621ybo.391.1652825307082; Tue, 17
 May 2022 15:08:27 -0700 (PDT)
Date:   Tue, 17 May 2022 15:08:14 -0700
In-Reply-To: <20220517220816.1635044-1-tansuresh@google.com>
Message-Id: <20220517220816.1635044-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
From:   Tanjore Suresh <tansuresh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This changes the bus driver interface with additional entry points
to enable devices to implement asynchronous shutdown. The existing
synchronous interface to shutdown is unmodified and retained for
backward compatibility.

This changes the common device shutdown code to enable devices to
participate in asynchronous shutdown implementation.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 12 ++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..ba267ae70a22 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4523,7 +4524,13 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+		if (dev->bus && dev->bus->async_shutdown_start) {
+			if (initcall_debug)
+				dev_info(dev, "async_shutdown_start\n");
+			dev->bus->async_shutdown_start(dev);
+			list_add_tail(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4543,6 +4550,35 @@ void device_shutdown(void)
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	/*
+	 * Second pass spin for only devices, that have configured
+	 * Asynchronous shutdown.
+	 */
+	while (!list_empty(&async_shutdown_list)) {
+		dev = list_entry(async_shutdown_list.next, struct device,
+				kobj.entry);
+		parent = get_device(dev->parent);
+		get_device(dev);
+		/*
+		 * Make sure the device is off the  list
+		 */
+		list_del_init(&dev->kobj.entry);
+		if (parent)
+			device_lock(parent);
+		device_lock(dev);
+		if (dev->bus && dev->bus->async_shutdown_end) {
+			if (initcall_debug)
+				dev_info(dev,
+				"async_shutdown_end called\n");
+			dev->bus->async_shutdown_end(dev);
+		}
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+		put_device(dev);
+		put_device(parent);
+	}
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a039ab809753..f582c9d21515 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -49,6 +49,16 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @async_shutdown_start:	Called at the shutdown-time to start
+ *				the shutdown process on the device.
+ *				This entry point will be called only
+ *				when the bus driver has indicated it would
+ *				like to participate in asynchronous shutdown
+ *				completion.
+ * @async_shutdown_end:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -93,6 +103,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*async_shutdown_start)(struct device *dev);
+	void (*async_shutdown_end)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.36.0.550.gb090851708-goog

