Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09440CFC7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 01:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhIOXCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 19:02:52 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37742 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhIOXCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 19:02:51 -0400
Received: by mail-lf1-f46.google.com with SMTP id i4so10716019lfv.4
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 16:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1wd9u9NtMuNJTtZ+hxyzrxw9BDui1QkYVbkYr2sajc=;
        b=Zk6bKRZzPJmZeWR5I0rw1UPPNHkLA/66fgiimoj64+yh8i+Ga9WjNVV1rc/UAxbKNj
         w7SyEvX3x3TCUESyCLr5jAwIZVSAotbd0NTEJN1kYUTxJRNBQIwEOaTzXq2ke//GxX9S
         n5kChGsBAf/spG2GwANxbL2J26NyzSKF3nZCXEmKwFvFfKhvz3en9wjqh6yZ1hssSXLX
         ULRFXqjTPgSG2cKw+97VThtebKI8j67Txy0Iy9qzxXR4cSiaCcFNZqPHl45e+v8sFUwn
         DFRfSIjQJl5jifcZzXVF6sHIpOCb58eH2NvPhZjbji3/u01Odxafk1telewH4eeZ/oi/
         iRWw==
X-Gm-Message-State: AOAM531g+FZNNwjQ/NpX6FuUDxfmmmRZADqu/ja9S2ZICSHo57fmqqBE
        BJ3iBHGJF7rmvmeP4ILD6a2k7RBft/8=
X-Google-Smtp-Source: ABdhPJzRw10gVH+ce31L58lNXqCQ8tYveVMgak9tjzjHWh1SO5NYFZNM2HQGY9jvb1MTLm7u8hInAg==
X-Received: by 2002:a2e:9bc7:: with SMTP id w7mr2148673ljj.379.1631746891089;
        Wed, 15 Sep 2021 16:01:31 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d15sm107386lfn.220.2021.09.15.16.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:30 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/3] PCI/sysfs: Return -EINVAL consistently from "store" functions
Date:   Wed, 15 Sep 2021 23:01:26 +0000
Message-Id: <20210915230127.2495723-2-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915230127.2495723-1-kw@linux.com>
References: <20210915230127.2495723-1-kw@linux.com>
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
as e.g., kstrtou8(), kstrtou32(), kstrtoint(), etc.

The -EINVAL is commonly returned as the error code to indicate that the
value provided is invalid, and the -ERANGE code is not very useful in
the userspace, thus normalize the return error code to be -EINVAL for
when the validation and/or type conversion fails.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 18 ++++------
 drivers/pci/endpoint/pci-ep-cfs.c            | 35 +++++++-------------
 drivers/pci/iov.c                            | 14 ++++----
 drivers/pci/pci-sysfs.c                      | 20 +++++------
 4 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 8b4756159f15..e67489144349 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1947,11 +1947,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
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
@@ -1980,11 +1978,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
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
@@ -2005,11 +2001,9 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
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
index 999911801877..19bc0e828c0c 100644
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
index dafdc652fcd0..0267977c9f17 100644
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
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6832e161be1c..a092fc0c665d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -273,15 +273,14 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
-	ssize_t result;
+	ssize_t result = 0;
 
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	result = kstrtoul(buf, 0, &val);
-	if (result < 0)
-		return result;
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
 
 	device_lock(dev);
 	if (dev->driver)
@@ -313,14 +312,13 @@ static ssize_t numa_node_store(struct device *dev,
 			       size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int node, ret;
+	int node;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = kstrtoint(buf, 0, &node);
-	if (ret)
-		return ret;
+	if (kstrtoint(buf, 0, &node) < 0)
+		return -EINVAL;
 
 	if ((node < 0 && node != NUMA_NO_NODE) || node >= MAX_NUMNODES)
 		return -EINVAL;
@@ -1340,10 +1338,10 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
+	ssize_t result;
 
-	if (result < 0)
-		return result;
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
 
 	if (val != 1)
 		return -EINVAL;
-- 
2.33.0

