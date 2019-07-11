Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C266199
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfGKW0W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42813 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfGKW0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:21 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so16098946ior.9;
        Thu, 11 Jul 2019 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs/77Ks02ouzvxcSMVSV/vw4rnOl+hQ1vPq1Vy99eWE=;
        b=DgShit4pGId1J6NNp887ww+CAb0MlNaHTKs9Qmd/u5xt7RHXX4GbCU60yPh7gdqSlR
         ZQ7XqbShLg0HOqqT/iK97Lm0csRmuBLAi58g8MlHVshloyN3ZkdgFa6R63Y4l1l6YAWZ
         GcUfKBmWWVsF/B27AanLMHk99sUkDjCqOu6JAAByKcUfkUUziwlA5T8SQFL5bjD1Myt/
         jPKd0ajhwbx8XsHeq1HHBtCA1v5L/nyjaplYE4KkDMVbcpSkxIN0EkG1gqy7QVo5n5um
         rR/ZhoZilK+XaaOfTUyuPoux85nlunv/y8vj5KcMFNTuTkmQJTw9YXFyZwq0XifkW/u1
         Iubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rs/77Ks02ouzvxcSMVSV/vw4rnOl+hQ1vPq1Vy99eWE=;
        b=JvWMIvt4qW0sj6fxBBlMP5xpiClOdFwsoaCHrkp9/witAVLgdMaQvM19iNCg0mQQnj
         gkW4G+aP4wgujQc0dHGwkvpcBbj3JlP8VMGHRTECBGnCI8GIzuqp9+TzgzZo3Y9Fh4eH
         c9h3rLxsjwLP2DFVG4kXkuLf4dXNeFWFJ0of4pD3LkPVHko2TduTIOZyJY5jaMlo6SqX
         pRfSOw/ueYl2pgBWQ6/jFllpePBOCMBI7vTLaEhRe8Z1MH6GF/mdEYW5mVYjw2tCk4pt
         kqX7OZ6s4q+WAa7JSSq4tyGgN72d9vorR18bd0hdjs0NiBK85c1FNEjfiKbfez/GrEYu
         ymcg==
X-Gm-Message-State: APjAAAWSlmRAn4En9wt4zqMIApFN8Y4V5y+h6ZchmADnnkdAgDWm2rNN
        IHxtt3NO7DbMfsOqbQtYUeMwDls9K57anA==
X-Google-Smtp-Source: APXvYqwwFxZ4u7zTAnZJyMBxsUUa2L1OhTVEdQawNb4k3T4pRBNZ9TOoN9I4ZK3WZgjS/I1u595VyA==
X-Received: by 2002:a6b:6611:: with SMTP id a17mr6719902ioc.179.1562883980447;
        Thu, 11 Jul 2019 15:26:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:19 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 07/11] PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:37 -0600
Message-Id: <20190711222341.111556-8-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_update_line_speed() is only called within drivers/pci/. Since
declaration does not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 1 +
 include/linux/pci.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9b87309f5c12..59321488da03 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -295,6 +295,7 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
+void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 54946423d901..3221d9f61ab4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -938,7 +938,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
-void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
-- 
2.20.1

