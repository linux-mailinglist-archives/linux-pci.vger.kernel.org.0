Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7345381603
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEOFZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:58 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43655 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhEOFZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:58 -0400
Received: by mail-ed1-f46.google.com with SMTP id s6so830313edu.10
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gp2LJL1lW12f9o9B/z7t/PXSY/mDvHIuRVwQfasUic=;
        b=uhDq1yDKpt08bswdcWli0d7GN/fXd5kPr9OVYqF0tDeShSJ/n42nY1GiQnJCFZ6oUe
         gQScMu+8/4FwcpWcI3LZOcwg9RvCW8DVmv+QJLwShCZaTKYyHYTfwN8wkN/ABx/p+5T1
         GHAYoVg1pd0hi7llsFOLlwMB1qQ0dzy6/695Fo3qbwkCDGzGgJLdIvv5Du0gNi9JUxNT
         BAwBjSySN5eM6VYi+ZkrFJR7tSJSt6yOA2AR1/OWLRwtZ3zE8LwnuQK+mOjtXQ3sCzG0
         7dcetYbtDkyaKMBQd902ZIJgj4AUg5d0yHsgbau6M/GUvW6Fxsnssr5zq6aMpnWv6itO
         /w0w==
X-Gm-Message-State: AOAM533FnqyDMYVjQZOsitXC0f8Q+H/TIEifgU5toEbe5rUfnp8bjlzW
        k9vEvV7SZBZrNncbi80pbM8=
X-Google-Smtp-Source: ABdhPJygjYsZin7lnJ61Xk7tN8Ajfd+LkXB3aIY5KrQ/tbUiVN1ghVgMxSTrTAGQmmN8ZvQkot3ULQ==
X-Received: by 2002:a50:ec89:: with SMTP id e9mr59801846edr.347.1621056283909;
        Fri, 14 May 2021 22:24:43 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:43 -0700 (PDT)
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
Subject: [PATCH v2 08/14] PCI: switchtec: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:28 +0000
Message-Id: <20210515052434.1413236-8-kw@linux.com>
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
 drivers/pci/switch/switchtec.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index ba52459928f7..0b301f8be9ed 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -280,7 +280,7 @@ static ssize_t device_version_show(struct device *dev,
 
 	ver = ioread32(&stdev->mmio_sys_info->device_version);
 
-	return sprintf(buf, "%x\n", ver);
+	return sysfs_emit(buf, "%x\n", ver);
 }
 static DEVICE_ATTR_RO(device_version);
 
@@ -292,7 +292,7 @@ static ssize_t fw_version_show(struct device *dev,
 
 	ver = ioread32(&stdev->mmio_sys_info->firmware_version);
 
-	return sprintf(buf, "%08x\n", ver);
+	return sysfs_emit(buf, "%08x\n", ver);
 }
 static DEVICE_ATTR_RO(fw_version);
 
@@ -344,7 +344,7 @@ static ssize_t component_vendor_show(struct device *dev,
 
 	/* component_vendor field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 
 	return io_string_show(buf, &si->gen3.component_vendor,
 			      sizeof(si->gen3.component_vendor));
@@ -359,9 +359,9 @@ static ssize_t component_id_show(struct device *dev,
 
 	/* component_id field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 
-	return sprintf(buf, "PM%04X\n", id);
+	return sysfs_emit(buf, "PM%04X\n", id);
 }
 static DEVICE_ATTR_RO(component_id);
 
@@ -373,9 +373,9 @@ static ssize_t component_revision_show(struct device *dev,
 
 	/* component_revision field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
-		return sprintf(buf, "255\n");
+		return sysfs_emit(buf, "255\n");
 
-	return sprintf(buf, "%d\n", rev);
+	return sysfs_emit(buf, "%d\n", rev);
 }
 static DEVICE_ATTR_RO(component_revision);
 
@@ -384,7 +384,7 @@ static ssize_t partition_show(struct device *dev,
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	return sprintf(buf, "%d\n", stdev->partition);
+	return sysfs_emit(buf, "%d\n", stdev->partition);
 }
 static DEVICE_ATTR_RO(partition);
 
@@ -393,7 +393,7 @@ static ssize_t partition_count_show(struct device *dev,
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	return sprintf(buf, "%d\n", stdev->partition_count);
+	return sysfs_emit(buf, "%d\n", stdev->partition_count);
 }
 static DEVICE_ATTR_RO(partition_count);
 
-- 
2.31.1

