Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3C7606ED
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 05:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGYD6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 23:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYD6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 23:58:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB312E;
        Mon, 24 Jul 2023 20:58:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so3610414a12.0;
        Mon, 24 Jul 2023 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690257484; x=1690862284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZPlW/yT7XrQQ9jeV1pXKAYRgltUH+1XO+QAfr9/oKk=;
        b=ahG22hpFlFmdEGBSNYkZ8huJUDKVqXeZkO1TS/eJ49ngeyh2bcDcFQZxL60PvtfTkN
         hSA0RqJSKLL2bF/RTFx0Dxqh19vw86pwRIxc0agEE6jw3yH5JPYbDm7RuQHTqEb4Qj6r
         kqwwnBmRljwDjSz4f4RSzWQEyJ9zrZ3U5gqYgieFBSJ/KT5MWz7qNig7X7ykk2NxnloL
         SH32MP3iv0hVWYM+sxtjer4ctpiVwChM0IYvMwM81zJIH9VG/iIVe5UepPScZyNAgnAv
         raSRcAXfFXAGmqSfAYDiGh9Lr+bFXaCo9rL4xLgcOiBRS5efUHiUvedMetfzTRcFn8np
         dbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690257484; x=1690862284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZPlW/yT7XrQQ9jeV1pXKAYRgltUH+1XO+QAfr9/oKk=;
        b=Yp5l7WIuTFpMDBpIA8W8Cm46bUvrsVkbGb6uwGl3bPxCJU9gv4lyXZ4fmfoXV1aA3s
         gupM4Q6CmItxlZ0xlSo1LC3t+9It1ZAjYiUNuY0na0UkWMoBd2CbgwPBqMCuOPkSUE+Y
         mcYC/eFPi/krd0X+eQMhcieJkQauKudr58ADqiavu+M1iCd2qFhmYbOuft8msaYQRX0j
         iF8ZabizJ9Eu+9xsCMt3UlCHSwwrmwnHKzZracmQbGYjOgYXdAWiNPLPh5hwA1/iFiGO
         tM1Bwg/Vs0go7TwoKpV2Vi8FBDcfZAV8ztAJwBXuzg90DpzaZ4frBD7JdmcumGa8AJKJ
         Qyig==
X-Gm-Message-State: ABy/qLYhsn92E46qd+7yUacYju96vBg72WV0/MhZ2Ijnmf0955WxXKxy
        4VCCp/9+bqGWZ5m1HSMyCgk=
X-Google-Smtp-Source: APBJJlFf5SC6XHB8VospMFdJHIALEGD7CLGEx7o4X28KE6zvw5D2jBko+drzD8F/kv+s8j33FWeUOg==
X-Received: by 2002:a17:90a:5907:b0:262:ed49:ffe7 with SMTP id k7-20020a17090a590700b00262ed49ffe7mr12760787pji.25.1690257483920;
        Mon, 24 Jul 2023 20:58:03 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id s30-20020a17090a69a100b00262e5449dbcsm1139016pjj.24.2023.07.24.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 20:58:03 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
Date:   Tue, 25 Jul 2023 13:57:55 +1000
Message-Id: <20230725035755.2621507-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/pci/doe.c       | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c | 27 +++++++++++++++++++++++++++
 include/linux/pci-doe.h |  2 ++
 3 files changed, 57 insertions(+)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..cc1c23c78ac1 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -563,6 +563,34 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
 	return false;
 }
 
+/**
+ * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
+ *			     to a sysfs buffer
+ * @doe_mb: DOE mailbox capability to query
+ * @buf: buffer to store the sysfs strings
+ * @offset: offset in buffer to store the sysfs strings
+ *
+ * RETURNS: The number of bytes written, 0 means an error occured
+ */
+unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
+					   char *buf, ssize_t offset)
+{
+	unsigned long index;
+	ssize_t ret = offset, r;
+	void *entry;
+
+	xa_for_each(&doe_mb->prots, index, entry) {
+		r = sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(entry));
+
+		if (r == 0)
+			return 0;
+
+		ret += r;
+	}
+
+	return ret;
+}
+
 /**
  * pci_doe_submit_task() - Submit a task to be processed by the state machine
  *
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..df93051e65bf 100644
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
@@ -290,6 +291,29 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#ifdef CONFIG_PCI_DOE
+static ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	unsigned long index;
+	ssize_t ret = 0, r;
+	struct pci_doe_mb *doe_mb;
+
+	xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
+		r = pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
+
+		if (r == 0)
+			return 0;
+
+		ret += r;
+	}
+
+	return ret;
+}
+static DEVICE_ATTR_RO(doe_proto);
+#endif
+
 static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
@@ -603,6 +627,9 @@ static struct attribute *pci_dev_attrs[] = {
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
index 1f14aed4354b..066494a4dba3 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -21,5 +21,7 @@ struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
 	    void *response, size_t response_sz);
+unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
+					   char *buf, ssize_t offset);
 
 #endif
-- 
2.40.1

