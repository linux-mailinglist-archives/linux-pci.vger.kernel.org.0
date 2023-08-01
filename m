Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A33876B498
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjHAMSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAMSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 08:18:39 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE22410C7;
        Tue,  1 Aug 2023 05:18:38 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-444f9c0b2a4so1865303137.1;
        Tue, 01 Aug 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690892318; x=1691497118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pP1LQZ3EZd9ln0nwPnrXxZLJWSXcccxJAHuawahyw9Y=;
        b=IMeI38bIaEv93vufwerodgHrAB0qmaVcT/q4ti7xad1dAy7azu+8zkAH+VnbaWrj0W
         ZFr96Fupiqa/pxtfn9Gt4MyeZiIY8NCZ6GWMEIS71bU7dS0OAm202uac2MdKbJnlIbU0
         bP+58HRHpww4fG6dD2lFX3q5HN2cuybgWCjFBt1/4+7rAn2nZONAnNwJUHL/ubRkmQdd
         8awrDyEI6T9iCg3S9u3U0nZUB3DOsEE+6m1b1KozyFDhhrgbNuquItnnKlDmuD2ImQeo
         RalDOEScKVQBUPIZwrZI+ZKmsnSrhQPhr2PorHkc0/bLGPqCu2GitqTCBV2GpbSiN+QX
         gvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892318; x=1691497118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pP1LQZ3EZd9ln0nwPnrXxZLJWSXcccxJAHuawahyw9Y=;
        b=ZL22dhP/t6a60xNcLbJEWAn1DPj1YIWHGc4tLk0UO2fm7WmEQEtOYlHx0YmBdY6DQ7
         DwdW1IpOQLmI1N6eeBJ8Uo5OCf44WIeC0StlAiuSFtmjCZGtCBRrYD054Cf9qcDhExzX
         fVADjqMABit7+cCwqqN1S6af6Lk9+VYnBCnwdHzUMn+F4cbAjMY+HgZfpCfzAPuKpAWk
         PpAY0F8teVT0lOTW9yIklzf0YQdCKXvIjL/HsBfNfJo27UNePEWz8NdbfUb1999uoZRU
         qVFxww/GWPtK3l6JPJ48TRDUa5fYNjsfB+7RJO6ckZIovEMlljC4j72jmwQNyEtXgOsA
         NZZQ==
X-Gm-Message-State: ABy/qLbjccWTWK76f+epR3/+agl4r0cTcSaLVCZzDq0bVuD5cKhmrFZH
        ZZ9hIcaCiMbDAFSKargRRys=
X-Google-Smtp-Source: APBJJlEg8ehQI+BYse/H+1HW88RyPtyfO3dPeVJBwqPl6e/ceY+G+PazXKlb7zAfG2shTTZJs8fmMA==
X-Received: by 2002:a67:fc47:0:b0:446:a2f8:9fe4 with SMTP id p7-20020a67fc47000000b00446a2f89fe4mr1991178vsq.16.1690892317714;
        Tue, 01 Aug 2023 05:18:37 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id u20-20020a67d994000000b004476404490csm1755445vsj.16.2023.08.01.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:18:37 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Date:   Tue,  1 Aug 2023 08:18:24 -0400
Message-ID: <20230801121824.174556-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe 6 specification added support for the Data Object Exchange (DOE).
When DOE is supported the Discovery Data Object Protocol must be
implemented. The protocol allows a requester to obtain information about
the other DOE protocols supported by the device.

The kernel is already querying the DOE protocols supported and cacheing
the values. This patch exposes the values via sysfs. This will allow
userspace to determine which DOE protocols are supported by the PCIe
device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported protocols we can
allow userspace to parse and support the list, which might include
vendor specific protocols as well as yet to be supported protocols.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
 drivers/pci/doe.c                       | 52 +++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  8 ++++
 include/linux/pci-doe.h                 |  2 +
 4 files changed, 73 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..ae969bbfa631 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,14 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_proto
+Date:		July 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This file contains a list of the supported Data Object Exchange (DOE)
+		protocols. The protocols are seperated by newlines.
+		The value comes from the device and specifies the vendor and
+		protocol supported. The lower byte is the protocol and the next
+		two bytes are the vendor ID.
+		The file is read only.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..70900b79b239 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -563,6 +563,58 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 	return false;
 }
 
+#ifdef CONFIG_SYSFS
+/**
+ * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
+ *			     to a sysfs buffer
+ * @doe_mb: DOE mailbox capability to query
+ * @buf: buffer to store the sysfs strings
+ * @offset: offset in buffer to store the sysfs strings
+ *
+ * RETURNS: The number of bytes written, 0 means an error occured
+ */
+static unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
+						  char *buf, ssize_t offset)
+{
+	unsigned long index;
+	ssize_t ret = offset;
+	ssize_t r;
+	void *entry;
+
+	xa_for_each(&doe_mb->prots, index, entry) {
+		r = sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(entry));
+
+		if (r == 0)
+			return ret;
+
+		ret += r;
+	}
+
+	return ret;
+}
+
+ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	unsigned long index;
+	ssize_t ret = 0;
+	ssize_t r;
+	struct pci_doe_mb *doe_mb;
+
+	xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
+		r = pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
+
+		if (r == 0)
+			return ret;
+
+		ret += r;
+	}
+
+	return ret;
+}
+#endif
+
 /**
  * pci_doe_submit_task() - Submit a task to be processed by the state machine
  *
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..cdb6aea2d263 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/stat.h>
 #include <linux/export.h>
 #include <linux/topology.h>
@@ -290,6 +291,10 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#ifdef CONFIG_PCI_DOE
+static DEVICE_ATTR_RO(doe_proto);
+#endif
+
 static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
@@ -603,6 +608,9 @@ static struct attribute *pci_dev_attrs[] = {
 	&dev_attr_local_cpus.attr,
 	&dev_attr_local_cpulist.attr,
 	&dev_attr_modalias.attr,
+#ifdef CONFIG_PCI_DOE
+	&dev_attr_doe_proto.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&dev_attr_numa_node.attr,
 #endif
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..3033eb4bd17d 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -22,4 +22,6 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
 	    void *response, size_t response_sz);
 
+ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
+		       char *buf);
 #endif
-- 
2.41.0

