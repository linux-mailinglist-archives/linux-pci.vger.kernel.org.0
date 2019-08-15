Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6A8EF7B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHOPhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:37:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33029 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfHOPhR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:37:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so6013842otl.0;
        Thu, 15 Aug 2019 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUsN0QwHDmbEHHRKk4pco8mBmCePwPfyNjCuipsrWdc=;
        b=lSWKA0zwap+NdGEaQzseRqkIS32OAqT+2HmP3Ydx50pwvDUIi4VuiRO99gyIDUiJZf
         w2xGFdIGzBzHLPl4GgyrofcF1dYQchpyLjvxevAd9xOQwPZ/hRupbu+Npb1pdKgk1QYq
         RfUzm+XU1ZPZuaBMNCfM5jve172cD+Js1lZMvpj3dahr5NOepGjNlZSNscZSRXgvII7W
         4cQMQCuz/3vGDl6ZjEUlDkletuR02fm/rz3VuT7FI96EQC9wNRbVkTbyTE2IT/oQ1EQM
         fHhs3pHYaSaGhEHLHqQdwGvyCiwcrxqaHmfX9+RB1n7weHBOJixep33moTFqE8OG6PEt
         AO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUsN0QwHDmbEHHRKk4pco8mBmCePwPfyNjCuipsrWdc=;
        b=RiX29YECkfmJP6c1bR73JVc6/gXJRxUvQdGudpXexvnP7xxDVnsJLrlC0KtJy5yn/b
         Kuro8zR6dBEKiQPg1CUHtuOgLmqa3sxXB9O7k/g3c7eNn6MbZ9t0KgRj3GPTmG9mHp4b
         AZ2/y7rPfy89JBwFTPc0Y9gMFIfN+nnsDk7CGHUSaJ07/hwGu1gp1uFZ0tEpg5MFrL+d
         HH3eouhpOOg+E6UHVJryUAEyEMcj6aR+KyBqsH4zPLmQtkDYMq58WlcjlN1aFYt28+SQ
         U91A7auCJAXC6Ujcfz+4CgduSFpFl/avVn+ix7++VmznVEF+xILPPzoMzznk3Yq1RqsD
         XneA==
X-Gm-Message-State: APjAAAWaAFB67h5sCQVSyfgyanKCHNyoZwAxw8iaCRWyP3JpcdjWvSwo
        /1CV1XKeOHSKn30HKq4v1Zw=
X-Google-Smtp-Source: APXvYqxFXh8Sa1R3TgWpaLQFVGiQiN+KNZIBtgoaVYyT43L0UX3Iozm7X9rMdPSk72w3wFZhXTsHmQ==
X-Received: by 2002:a5e:c802:: with SMTP id y2mr6161245iol.134.1565883436769;
        Thu, 15 Aug 2019 08:37:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c18sm1491856iod.19.2019.08.15.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:37:16 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        gregkh@linuxfoundation.org, skunberg.kelsey@gmail.com
Subject: [PATCH v3 4/4] PCI/IOV: Move sysfs SR-IOV functions to iov.c
Date:   Thu, 15 Aug 2019 09:33:53 -0600
Message-Id: <20190815153352.86143-5-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs SR-IOV functions are for an optional feature and will be better
organized to keep with the feature's code. Move the sysfs SR-IOV functions
to /pci/iov.c.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/iov.c       | 168 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c | 173 ----------------------------------------
 drivers/pci/pci.h       |   2 +-
 3 files changed, 169 insertions(+), 174 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9b48818ced01..b335db21c85e 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -240,6 +240,174 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	pci_dev_put(dev);
 }
 
+static ssize_t sriov_totalvfs_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
+}
+
+static ssize_t sriov_numvfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
+}
+
+/*
+ * num_vfs > 0; number of VFs to enable
+ * num_vfs = 0; disable all VFs
+ *
+ * Note: SRIOV spec does not allow partial VF
+ *	 disable, so it's all or none.
+ */
+static ssize_t sriov_numvfs_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+	u16 num_vfs;
+
+	ret = kstrtou16(buf, 0, &num_vfs);
+	if (ret < 0)
+		return ret;
+
+	if (num_vfs > pci_sriov_get_totalvfs(pdev))
+		return -ERANGE;
+
+	device_lock(&pdev->dev);
+
+	if (num_vfs == pdev->sriov->num_VFs)
+		goto exit;
+
+	/* is PF driver loaded w/callback */
+	if (!pdev->driver || !pdev->driver->sriov_configure) {
+		pci_info(pdev, "Driver does not support SRIOV configuration via sysfs\n");
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (num_vfs == 0) {
+		/* disable VFs */
+		ret = pdev->driver->sriov_configure(pdev, 0);
+		goto exit;
+	}
+
+	/* enable VFs */
+	if (pdev->sriov->num_VFs) {
+		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
+			 pdev->sriov->num_VFs, num_vfs);
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	ret = pdev->driver->sriov_configure(pdev, num_vfs);
+	if (ret < 0)
+		goto exit;
+
+	if (ret != num_vfs)
+		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
+			 num_vfs, ret);
+
+exit:
+	device_unlock(&pdev->dev);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t sriov_offset_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->offset);
+}
+
+static ssize_t sriov_stride_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->stride);
+}
+
+static ssize_t sriov_vf_device_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+}
+
+static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+}
+
+static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool drivers_autoprobe;
+
+	if (kstrtobool(buf, &drivers_autoprobe) < 0)
+		return -EINVAL;
+
+	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(sriov_totalvfs);
+static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
+static DEVICE_ATTR_RO(sriov_offset);
+static DEVICE_ATTR_RO(sriov_stride);
+static DEVICE_ATTR_RO(sriov_vf_device);
+static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
+		   sriov_drivers_autoprobe_store);
+
+static struct attribute *sriov_dev_attrs[] = {
+	&dev_attr_sriov_totalvfs.attr,
+	&dev_attr_sriov_numvfs.attr,
+	&dev_attr_sriov_offset.attr,
+	&dev_attr_sriov_stride.attr,
+	&dev_attr_sriov_vf_device.attr,
+	&dev_attr_sriov_drivers_autoprobe.attr,
+	NULL,
+};
+
+static umode_t sriov_attrs_are_visible(struct kobject *kobj,
+				       struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	if (!dev_is_pf(dev))
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group sriov_dev_attr_group = {
+	.attrs = sriov_dev_attrs,
+	.is_visible = sriov_attrs_are_visible,
+};
+
 int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	return 0;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5bb301efec98..868e35109284 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -548,151 +548,6 @@ static ssize_t devspec_show(struct device *dev,
 static DEVICE_ATTR_RO(devspec);
 #endif
 
-#ifdef CONFIG_PCI_IOV
-static ssize_t sriov_totalvfs_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
-}
-
-
-static ssize_t sriov_numvfs_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
-}
-
-/*
- * num_vfs > 0; number of VFs to enable
- * num_vfs = 0; disable all VFs
- *
- * Note: SRIOV spec doesn't allow partial VF
- *       disable, so it's all or none.
- */
-static ssize_t sriov_numvfs_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-	u16 num_vfs;
-
-	ret = kstrtou16(buf, 0, &num_vfs);
-	if (ret < 0)
-		return ret;
-
-	if (num_vfs > pci_sriov_get_totalvfs(pdev))
-		return -ERANGE;
-
-	device_lock(&pdev->dev);
-
-	if (num_vfs == pdev->sriov->num_VFs)
-		goto exit;
-
-	/* is PF driver loaded w/callback */
-	if (!pdev->driver || !pdev->driver->sriov_configure) {
-		pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
-		ret = -ENOENT;
-		goto exit;
-	}
-
-	if (num_vfs == 0) {
-		/* disable VFs */
-		ret = pdev->driver->sriov_configure(pdev, 0);
-		goto exit;
-	}
-
-	/* enable VFs */
-	if (pdev->sriov->num_VFs) {
-		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
-			 pdev->sriov->num_VFs, num_vfs);
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	if (ret < 0)
-		goto exit;
-
-	if (ret != num_vfs)
-		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
-			 num_vfs, ret);
-
-exit:
-	device_unlock(&pdev->dev);
-
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-
-static ssize_t sriov_offset_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->offset);
-}
-
-static ssize_t sriov_stride_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->stride);
-}
-
-static ssize_t sriov_vf_device_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
-}
-
-static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
-}
-
-static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	bool drivers_autoprobe;
-
-	if (kstrtobool(buf, &drivers_autoprobe) < 0)
-		return -EINVAL;
-
-	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
-
-	return count;
-}
-
-static DEVICE_ATTR_RO(sriov_totalvfs);
-static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
-static DEVICE_ATTR_RO(sriov_offset);
-static DEVICE_ATTR_RO(sriov_stride);
-static DEVICE_ATTR_RO(sriov_vf_device);
-static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
-		   sriov_drivers_autoprobe_store);
-#endif /* CONFIG_PCI_IOV */
-
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
@@ -1691,34 +1546,6 @@ static const struct attribute_group pci_dev_hp_attr_group = {
 	.is_visible = pci_dev_hp_attrs_are_visible,
 };
 
-#ifdef CONFIG_PCI_IOV
-static struct attribute *sriov_dev_attrs[] = {
-	&dev_attr_sriov_totalvfs.attr,
-	&dev_attr_sriov_numvfs.attr,
-	&dev_attr_sriov_offset.attr,
-	&dev_attr_sriov_stride.attr,
-	&dev_attr_sriov_vf_device.attr,
-	&dev_attr_sriov_drivers_autoprobe.attr,
-	NULL,
-};
-
-static umode_t sriov_attrs_are_visible(struct kobject *kobj,
-				       struct attribute *a, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-
-	if (!dev_is_pf(dev))
-		return 0;
-
-	return a->mode;
-}
-
-static const struct attribute_group sriov_dev_attr_group = {
-	.attrs = sriov_dev_attrs,
-	.is_visible = sriov_attrs_are_visible,
-};
-#endif /* CONFIG_PCI_IOV */
-
 static const struct attribute_group pci_dev_attr_group = {
 	.attrs = pci_dev_dev_attrs,
 	.is_visible = pci_dev_attrs_are_visible,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 61bbfd611140..7e3c6c8ae6f9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -455,7 +455,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
-
+extern const struct attribute_group sriov_dev_attr_group;
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
 {
-- 
2.20.1

