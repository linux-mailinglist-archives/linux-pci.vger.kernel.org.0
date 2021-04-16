Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2C3629DA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbhDPU7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:38 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46993 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbhDPU7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:38 -0400
Received: by mail-ed1-f50.google.com with SMTP id h10so33797363edt.13
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG9PYVKkM4vrPvILHcpTFnJdF4PMSdFWokhECO6VD/s=;
        b=XKwvUiezLeO7fhqJamC3n5KMYqpshbKI/ix1dCFNi2wrLhyNvEn6ErkdJnWcSWto6f
         hFhjgTXqQDSbIR2gyWiN8jD1jLFGjrnTWMC8AxV06SSRyELKG6RJfqf7j4Yqi61PI2VP
         AbnjhgXtCO5fdhDz0n3Hkuv7d0By8oI8IeQMachGiyP2qtzg95uzU5d1tJK/35SmK2Dk
         k+DoIbi8LEWVxkcwq9FziqA/ZVJnGVytmP3SHlRLmyWcdlNmWkAiR59eziIbeREu/pwh
         leKNBSs/CmYCrYRcRkLa2D5cd2dgK6mfTtYGRUS3bp//fXHmw3eWlqD8JK4YFls14/Ey
         aQpw==
X-Gm-Message-State: AOAM531IwQdW6SYD2tRE4qsZLrpVDqSFBbE7eyMOMTimbN6EMYjNulGC
        4VUyDXv4XUQh/pjY8zuDBPU=
X-Google-Smtp-Source: ABdhPJwWWkOHsFvao3fgkHVFIwf4xBPY7JUbBSbKFP4MC35OQACrhvW8O78Vu16lblXG0oxcQtYXwg==
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr12258449edd.349.1618606752062;
        Fri, 16 Apr 2021 13:59:12 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:11 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 14/20] PCI: Rearrange attributes from the pci_dev_reset_attr_group
Date:   Fri, 16 Apr 2021 20:58:50 +0000
Message-Id: <20210416205856.3234481-15-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When new sysfs objects were added to the PCI device over time, the code
that implemented new attributes has been added in many different places
in the pci-sysfs.c file.  This makes it hard to read and also hard to
find relevant code.

Thus, move attributes that are part of the "pci_dev_reset_attr_group"
attribute group to the top of the file.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 90 ++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 794c97424456..f18b1728aefa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -744,6 +744,51 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 };
 
+static ssize_t reset_store(struct device *dev,
+			   struct device_attribute *attr, const char *buf,
+			   size_t count)
+{
+	bool reset;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	if (kstrtobool(buf, &reset) < 0)
+		return -EINVAL;
+
+	if (!reset)
+		return -EINVAL;
+
+	pm_runtime_get_sync(dev);
+	ret = pci_reset_function(pdev);
+	pm_runtime_put(dev);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *pci_dev_reset_attrs[] = {
+	&dev_attr_reset.attr,
+	NULL,
+};
+
+static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pdev->reset_fn)
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_dev_reset_attr_group = {
+	.attrs = pci_dev_reset_attrs,
+	.is_visible = pci_dev_reset_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -1406,51 +1451,6 @@ int __weak pci_create_resource_files(struct pci_dev *pdev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *pdev) { return; }
 #endif
 
-static ssize_t reset_store(struct device *dev,
-			   struct device_attribute *attr, const char *buf,
-			   size_t count)
-{
-	bool reset;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t ret;
-
-	if (kstrtobool(buf, &reset) < 0)
-		return -EINVAL;
-
-	if (!reset)
-		return -EINVAL;
-
-	pm_runtime_get_sync(dev);
-	ret = pci_reset_function(pdev);
-	pm_runtime_put(dev);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_WO(reset);
-
-static struct attribute *pci_dev_reset_attrs[] = {
-	&dev_attr_reset.attr,
-	NULL,
-};
-
-static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
-					     struct attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (!pdev->reset_fn)
-		return 0;
-
-	return a->mode;
-}
-
-static const struct attribute_group pci_dev_reset_attr_group = {
-	.attrs = pci_dev_reset_attrs,
-	.is_visible = pci_dev_reset_attr_is_visible,
-};
-
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
-- 
2.31.0

