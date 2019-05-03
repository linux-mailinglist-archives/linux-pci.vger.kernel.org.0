Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30EE126A0
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfECEAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40213 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfECEAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so4153474otl.7
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dEuYGj0O58tspSnt+ZpOw9dKatfC4l7Bo34N+ze4Knk=;
        b=V87dHIKzVmPP/S0N0PyA7zHPHu0mXweFGmROyi7cgyoDDCiEgvvPCV1HYDxGPuTgqY
         Fd0xLFcmafP2TOblvOznWvEiq8HGfuM8kpfMV30SO+9XOjgWLgzOX7UkmZPhrK6QdMWb
         JsTKAZT5PVeh3jytdlz9OXYKFhHxSpUIMiHE3iHwGdQp6MyfvQz2W74HXZVPMSGLGtd9
         elAW+vDgI8ucFakopyD18+qJH3mIxBmJnhFe7Xkcyrk3K3IwUUATHj9KrfNe4tDqC+Yb
         WN3GhwaDYl4h7nJ2VZfGLeBaT7CZXew5/WDttJw4x5R1q/buXnq04zYNfj5wNG0jAlKG
         C4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dEuYGj0O58tspSnt+ZpOw9dKatfC4l7Bo34N+ze4Knk=;
        b=BE/VMniYBIfoYL58rd2gF9hyGvd5hyXx+tY2ZGup1om2twzQ8mQytiNveLJsFUBeuk
         nWlT6K+4bBYNkJa6ZyOc5rnoj99lWJoEJlc3K5aJWY4llPw9/PViI1+jb5hWx33y3MNV
         Hho+RENPNlqPWya/yUKMMftGZT79Lg46zykQvottWBd9uq/nU30w5PJtH5JT4Aa3GHJi
         tOPp7Svlp/A8qdTltQn0xORSRzv10xjK6bLPnA0Q8Hnj6X+S2kdPvY2wrLBmoZ30BCTM
         1Ok6yWw9q8WsG1/ZAb8fSi42cWIG3WTm8m9V5UIsmogGj47n7nlo8H4VcALKmkHxcH8X
         9rWw==
X-Gm-Message-State: APjAAAUN5NyiOyxxmVJnkurKrRMEPKcnkxrEyvF8HVUUUWjYRVpJS2C5
        hAzM1+DRQmRsCjLxHPuJWZT8ow==
X-Google-Smtp-Source: APXvYqyBqDNVdOgBq9t2LsPo/+tMkFG2FU+eo+9lqaRWS7Ru1tZs8aXOCtkYVJOKUbsZm7r5P4ZaIQ==
X-Received: by 2002:a9d:609e:: with SMTP id m30mr4650287otj.337.1556856035626;
        Thu, 02 May 2019 21:00:35 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id d78sm543523oib.15.2019.05.02.21.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:34 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 8/9] PCI: hotplug: Remove unnecessary dbg/err/info/warn() printk() wrappers
Date:   Thu,  2 May 2019 22:59:45 -0500
Message-Id: <20190503035946.23608-9-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary deb/err/info/warn() printk() wrappers.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp.h      | 9 ---------
 drivers/pci/hotplug/pciehp_core.c | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e852aa478802..06ff9d31405e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -31,15 +31,6 @@ extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
 
-#define dbg(format, arg...)						\
-	pr_debug(format, ## arg);
-#define err(format, arg...)						\
-	pr_err(format, ## arg)
-#define info(format, arg...)						\
-	pr_info(format, ## arg)
-#define warn(format, arg...)						\
-	pr_warn(format, ## arg)
-
 #define ctrl_dbg(ctrl, format, arg...)					\
 	pci_dbg(ctrl->pcie->port, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 7e06a0f9e644..67d024b7f476 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -331,9 +331,9 @@ int __init pcie_hp_init(void)
 	int retval = 0;
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
-	dbg("pcie_port_service_register = %d\n", retval);
+	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
-		dbg("Failure to register service\n");
+		pr_debug("Failure to register service\n");
 
 	return retval;
 }
-- 
2.17.1

