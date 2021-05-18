Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C531E38704A
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbhERDmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:38 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:46874 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbhERDmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:38 -0400
Received: by mail-lf1-f47.google.com with SMTP id i9so11908906lfe.13
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uA1RWHjwHfxS7RqMsPnvAHkBLZgV1XkLD2dXTAoz6Eo=;
        b=QdzwbA7J+7jL2wmKZb009Gg64l7cwarcPCsNuHpsFe948D0f/Bbgs2gnMU3FYcZerz
         +Nr6TQD/wmLszVu/9TZVr8S4IeeZh5psE+SnjDPU6CQw9/VK+GzBUVLvGHnkqW0D86xJ
         lZBHggim4xJ3hO39bnDzr6aI0iSLmGl0rI55PTYvZ07AQlu+bnKu4IRwIU+P4W/o1e7b
         0W1LIHKVaLh2nHhHA+ldYKx56KNMl22cAb56PUnKM+Ik7SltjfXvq556wufy/HPt1S/G
         FnvtLOm7A8WrLAAzpyqTjzPDBtvnxR1NZk4Skt56pMS8CIpn+1aKeJoYhY6mUQPZbTl3
         Iy8A==
X-Gm-Message-State: AOAM533/1SKpX1IWCLrpfs2GnvzLvkufxMZhZY6G3wNnZESsVpc2DRq+
        fx45rcMCohy4iso6ttCBw+I=
X-Google-Smtp-Source: ABdhPJzFHGyQqyCizXNU0SRBAx+tLKCu8KjtzMw1iBmwxAMWiD2SzqaqTXvxsqWeKxo9N7W6rH5Lzw==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr2514089lfl.330.1621309279756;
        Mon, 17 May 2021 20:41:19 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:19 -0700 (PDT)
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
        linux-pci@vger.kernel.org
Subject: [PATCH v3 09/14] PCI: rpadlpar: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:41:04 +0000
Message-Id: <20210518034109.158450-9-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

 drivers/pci/hotplug/rpadlpar_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index dbfa0b55d31a..068b7810a574 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -50,7 +50,7 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t add_slot_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t remove_slot_store(struct kobject *kobj,
@@ -80,7 +80,7 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 static ssize_t remove_slot_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static struct kobj_attribute add_slot_attr =
-- 
2.31.1

