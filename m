Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F5381605
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhEOF0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:26:00 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39715 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhEOFZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:59 -0400
Received: by mail-ed1-f43.google.com with SMTP id h16so852817edr.6
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdJ+gi3kfx5UscQD8MEmkjatX64t7LAuyBsCWTQVyR4=;
        b=cSgh5F92aHHKIFOEmUMXybJkrQs83g4lAlR43AtZhaXt+7cNw5ys6DLZPV00LF1Zhg
         neA16UI8oMD88WiZuZVfRQQWj719dy3kfmYq3IA3oJfe6qO48Frvi6s6kUgcFmi+gnnu
         zdlHVBmL4gLA3VIilMCNqFvg+cZ4iNT68I7fh1nh5qWMeUyIUofW4aTObVMynqW3tdCs
         ZF/zMGJZZ8tAiNDygFIZ7KFSIfgYXYLcjwxNlnKWjZCujkjJ1nYgVc0IJuPBInpqiV5P
         b/xRRzuu2fmDZRCJyipZ8K/7b+BBwRftqon4NZLShiab4hsb/m1bzT75a6g+SWITwDis
         uTlw==
X-Gm-Message-State: AOAM530Z3dPpLT2cmgtKkST9Z7w+e4UqCF+Kky0Rq74mfBYksLusrVrj
        B4bcH5/Ol+LDGT3XdTfhwgk=
X-Google-Smtp-Source: ABdhPJwUFEaurmP9EKuuMm+T/D2jN40L9mLA9g5wzTrmHUIny74d+EPyB5vutIYIvhUmd0UAv1N90w==
X-Received: by 2002:a50:ab06:: with SMTP id s6mr50742980edc.100.1621056285971;
        Fri, 14 May 2021 22:24:45 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:45 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/14] PCI: hotplug: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:30 +0000
Message-Id: <20210515052434.1413236-10-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 5ac31f683b85..058d5937d8a9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t power_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -130,7 +130,7 @@ static ssize_t attention_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -175,7 +175,7 @@ static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_latch = {
@@ -192,7 +192,7 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
-- 
2.31.1

