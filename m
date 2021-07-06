Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5263BC47F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGFBJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 21:09:08 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33694 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGFBJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 21:09:07 -0400
Received: by mail-wr1-f53.google.com with SMTP id d2so356898wrn.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 18:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5l5HS8HtMP4QvlUzB+iBOyLd9yEm79Z8nrFxj2kFU4=;
        b=Ukd/ir6OOcsidttaRcavIpKBc0CNwIRD+owDnCUWbYRuXZVEix2mngSzC2KF2If5Rd
         TNuOvbxlHDD6JTCGhA0BPdKIBm4nOQ9yuU6hSBwTstwBiUlvuBAyldrySuOYsXPYjcHs
         oXbaIWK5yq7Vz8B9LRY8X4wGKRJ7t6SGaj6Viv69QJqa7wduwQ0O286L0EcK36u0EZ3O
         2FeoB1Dq2O5v2fx3x6bN4ozdYPfrtXE5u18p7PMk9Oow3+sYZ8tD4cLZcMugsOj3cPdh
         Pt+jJz5e6axfs5jRVxAGzRA8+t9GsaRmBcW35xV2ttVKsx9yw1gWsXxv++epjUG/P63M
         TVxw==
X-Gm-Message-State: AOAM532wu9dMVHjJElQduaZGYBZIFS0pRqc7xRamYFwzLJFUv62DPHTs
        llBPGtPjonK5QKWayeptolc=
X-Google-Smtp-Source: ABdhPJx3FFxbFtI9nA8A2lslQNhRQkYIyPM2LYSde7h/vG1w6nhu/BnMbCK3YtnxTlVP5RYLq4LSmQ==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr18617401wrh.388.1625533585712;
        Mon, 05 Jul 2021 18:06:25 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m12sm13379418wms.24.2021.07.05.18.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 18:06:25 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/4] PCI/sysfs: Return -EINVAL consistently from "store" functions
Date:   Tue,  6 Jul 2021 01:06:21 +0000
Message-Id: <20210706010622.3058968-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706010622.3058968-1-kw@linux.com>
References: <20210706010622.3058968-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, most of the "store" functions that handle input from the
userspace via the sysfs objects commonly returns the -EINVAL error code
should the value provided fail validation and/or type conversion.  This
error code is a clear message to the userspace that the provided value
is not a valid input.

However, some of the "show" functions return the error code as-is as
returned from the helper functions used to parse the input value, and in
which case the error code can be either -EINVAL or -ERANGE.  The former
would often be a return from the kstrtobool() function and the latter
will most likely be originating from other kstr*() functions family such
as e.g., kstrtou8(), kstrtou32(), etc.

The -EINVAL is commonly returned as the error code to indicate that the
value provided is invalid, and the -ERANGE code is not very useful in
the userspace, thus normalize the return error code to be -EINVAL for
when the validation and/or type conversion fails.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v2:
  Make sure that "ret" variables are correctly initialised in functions
  sriov_vf_msix_count_store() and sriov_numvfs_store().

 drivers/pci/endpoint/functions/pci-epf-ntb.c | 18 ++++------
 drivers/pci/endpoint/pci-ep-cfs.c            | 35 +++++++-------------
 drivers/pci/iov.c                            | 14 ++++----
 3 files changed, 24 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index bce274d02dcf..c5a9cfa4c4a4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1928,11 +1928,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	u32 val;							\
-	int ret;							\
 									\
-	ret = kstrtou32(page, 0, &val);					\
-	if (ret)							\
-		return ret;						\
+	if (kstrtou32(page, 0, &val) < 0)				\
+		return -EINVAL;						\
 									\
 	ntb->_name = val;						\
 									\
@@ -1961,11 +1959,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct device *dev = &ntb->epf->dev;				\
 	int win_no;							\
 	u64 val;							\
-	int ret;							\
 									\
-	ret = kstrtou64(page, 0, &val);					\
-	if (ret)							\
-		return ret;						\
+	if (kstrtou64(page, 0, &val) < 0)				\
+		return -EINVAL;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
@@ -1986,11 +1982,9 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	struct config_group *group = to_config_group(item);
 	struct epf_ntb *ntb = to_epf_ntb(group);
 	u32 val;
-	int ret;
 
-	ret = kstrtou32(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou32(page, 0, &val) < 0)
+		return -EINVAL;
 
 	if (val > MAX_MW)
 		return -EINVAL;
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index f3a8b833b479..c77459048ef7 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -175,9 +175,8 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 	epc = epc_group->epc;
 
-	ret = kstrtobool(page, &start);
-	if (ret)
-		return ret;
+	if (kstrtobool(page, &start) < 0)
+		return -EINVAL;
 
 	if (!start) {
 		pci_epc_stop(epc);
@@ -329,13 +328,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u32 val;							       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou32(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou32(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -345,13 +342,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u16 val;							       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou16(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou16(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -361,13 +356,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u8 val;								       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou8(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou8(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -376,11 +369,9 @@ static ssize_t pci_epf_msi_interrupts_store(struct config_item *item,
 					    const char *page, size_t len)
 {
 	u8 val;
-	int ret;
 
-	ret = kstrtou8(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou8(page, 0, &val) < 0)
+		return -EINVAL;
 
 	to_pci_epf_group(item)->epf->msi_interrupts = val;
 
@@ -398,11 +389,9 @@ static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
 					     const char *page, size_t len)
 {
 	u16 val;
-	int ret;
 
-	ret = kstrtou16(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou16(page, 0, &val) < 0)
+		return -EINVAL;
 
 	to_pci_epf_group(item)->epf->msix_interrupts = val;
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index afc06e6ce115..b4b5e66be92d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -183,11 +183,10 @@ static ssize_t sriov_vf_msix_count_store(struct device *dev,
 {
 	struct pci_dev *vf_dev = to_pci_dev(dev);
 	struct pci_dev *pdev = pci_physfn(vf_dev);
-	int val, ret;
+	int val, ret = 0;
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtoint(buf, 0, &val) < 0)
+		return -EINVAL;
 
 	if (val < 0)
 		return -EINVAL;
@@ -376,12 +375,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
+	int ret = 0;
 	u16 num_vfs;
 
-	ret = kstrtou16(buf, 0, &num_vfs);
-	if (ret < 0)
-		return ret;
+	if (kstrtou16(buf, 0, &num_vfs) < 0)
+		return -EINVAL;
 
 	if (num_vfs > pci_sriov_get_totalvfs(pdev))
 		return -ERANGE;
-- 
2.32.0

