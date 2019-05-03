Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6250126A1
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfECEAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34946 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECEAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id w197so3493206oia.2
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1/+exJcDLfJMbpm+cistYabfcZnJTfblqaDhmOStGDc=;
        b=nvECSvThLrCazQlaGUsoBn+Ui6ihMBY7wWIM7KpRqGCHm3faImkNGEAOL4e0hphmqf
         Rtjac3o7G3pGAA3LCozC6SpisiJ1HdY3eONMMeKxwbwpIBT8T4GqX12NwX2yG4YbE6CZ
         fBPB4BJGzvtbZFMwOlAdOgwWli2RinSwCeqqxbwCMJ5ItvZWhtRCwGufz8Wn7KOaCyJT
         x58XK1qYNc+nuBqNe25MngzYJF34fGol1JOlNatFnGG/iZS3/BFOB94UjqWPu41UN/dD
         oCx1W6Kuf7/97ba3R5F0NPEOoYaRFCFEZl/lTvS9xXwTQgTam9YH4FgUIV3tR3cbSpyu
         xRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1/+exJcDLfJMbpm+cistYabfcZnJTfblqaDhmOStGDc=;
        b=YFcH1/2wqi48Km0lv/CI3GtAyJomgjoyGkxMy7klEumGnHw7N9XKqNyk+htXQGnJzT
         hLpqiXzFwh6+e+Eq4+Lk1nMezLj0v64q70/ltcPj2q+WXqjHW0vyvfDmIKpkREz83Vxb
         IbUL3KNJepOskirjP4PdA5hyC69nbLr2m1NPxO3h00USRxcOmSyH3WgVf3Ltq9e67hqg
         zWdh2YYnfGAwmhsiwnKPkcLLCXB90cjOJaZAvvyXw0WsAgg26fxSWviuaHUM71FIpMFh
         u8IepNdSWeTKRaabx0S2b1eGlIiyL7JKrWhi+CwQsocrGC+X3pwuE0cvVEXHqvw4+rMT
         V3yA==
X-Gm-Message-State: APjAAAV9PAwCxpirnw/0/z8lX1kcqPt6T2hJgBYIW9kdaIGBQ8fqYsHf
        mBm90sQ9oV/wr/T5aPcOIwAM2w==
X-Google-Smtp-Source: APXvYqzysSZUgZOYjxjq7yOGcMiYONz8+nQQcIn82iUWKC0XQTzAVNNXOmRBcrrUbGjGGTyRjiJsEA==
X-Received: by 2002:aca:cc90:: with SMTP id c138mr1851704oig.97.1556856033029;
        Thu, 02 May 2019 21:00:33 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id b23sm403696otl.55.2019.05.02.21.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:32 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 7/9] PCI: hotplug: Prefer CONFIG_DYNAMIC_DEBUG/DEBUG for dmesg logs
Date:   Thu,  2 May 2019 22:59:44 -0500
Message-Id: <20190503035946.23608-8-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dbg() and ctrl_dbg() requires pciehp_debug module parameter to be set
for debug log purposes. There are niche situations in pciehp_hpc.c where
pciehp_debug is used: dbg_ctrl(), and pci_bus_check_dev().

Enabling CONFIG_DYNAMIC_DEBUG/DEBUG is well known for logging debug
information. Therefore, prefer pr/pci_dbg() for debug information, and
reserve pciehp_debug for niche situations.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 78325c8d961e..e852aa478802 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -32,10 +32,7 @@ extern int pciehp_poll_time;
 extern bool pciehp_debug;
 
 #define dbg(format, arg...)						\
-do {									\
-	if (pciehp_debug)						\
-		pr_info(format, ## arg);				\
-} while (0)
+	pr_debug(format, ## arg);
 #define err(format, arg...)						\
 	pr_err(format, ## arg)
 #define info(format, arg...)						\
@@ -44,11 +41,7 @@ do {									\
 	pr_warn(format, ## arg)
 
 #define ctrl_dbg(ctrl, format, arg...)					\
-	do {								\
-		if (pciehp_debug)					\
-			pci_info(ctrl->pcie->port,			\
-				 format, ## arg);			\
-	} while (0)
+	pci_dbg(ctrl->pcie->port, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
 	pci_err(ctrl->pcie->port, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
-- 
2.17.1

