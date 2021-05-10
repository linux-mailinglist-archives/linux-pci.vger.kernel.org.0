Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47B4377AE8
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEJEPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:38 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:35361 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEJEPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:37 -0400
Received: by mail-ej1-f45.google.com with SMTP id m12so22437887eja.2
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gp2LJL1lW12f9o9B/z7t/PXSY/mDvHIuRVwQfasUic=;
        b=rhVvNpjd3P6oZPbLZwDazW09vHo+SfZo7nlKBKDk8tZS4VxwcDhlzVCNbX/+8/4StA
         Ymfud/0cVFhOar76hx/cvHBY1me3ohEUoD5hFLtQ+6k98bRDIGEr3hNKs9PrpZ0kkJQI
         lqbgD5hCOxNAeH+MRUf+jwOjb8O6z3oU6wmYxK6lt4iYbLPaBn3ESqlKGtSpuDX3xZPU
         dUMoLUkZ+q8lVFveV8rvHICaGaNSYQZ91YROzRmtVU99PHxDkd2NY2yQSGt09quYHTri
         wYHm+p2JP1TtDQag1oPkK47oHxP8o50QCeetwwmJBdZcr30UGYHiGVwdrows5yzVJgQX
         qqcw==
X-Gm-Message-State: AOAM533JAwTdbJvGECFyPFyzekdSc3euq3D0L/aqXsCBqo9ClhIev9NL
        GVpTjLfIq/aHDk+UV/SgLCk=
X-Google-Smtp-Source: ABdhPJwJ4Rea4lOE0vfRhtwPMTbWS+QEFGyHMU8cb9HK5mSiaGWryeJuMSKKk+UKs8vqI0wORAaRSA==
X-Received: by 2002:a17:907:11db:: with SMTP id va27mr23200346ejb.174.1620620073083;
        Sun, 09 May 2021 21:14:33 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:32 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/11] PCI: switchtec: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:21 +0000
Message-Id: <20210510041424.233565-8-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
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

