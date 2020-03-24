Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118DB191DA6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 00:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCXXsx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 19:48:53 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46474 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 19:48:52 -0400
Received: by mail-il1-f193.google.com with SMTP id e8so198381ilc.13;
        Tue, 24 Mar 2020 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKgozUjj14O/q7Sm3dF4aSRoq0XpT1MQsgLL9CSaZjM=;
        b=DeWPhXQpyJwtpV6zpVMes5lNf1MkFRym44/YBfzxv15qVQi+jyr1z925UoywmmoWZn
         BK2hjAVZWA0xhtg1lcHInT0Zj6PFZI2FVOk0bECySiz62MJh9u6tWdpoGUTz/6yec+NG
         iozgC5ILG9Y8zbh/eU/F1T6Jqkde8IMXxl0QSAjm8T5oD0xIVQ0xkkNTIyiBW3tqUmgm
         eT+t6PQMqj2ULofVyrSlXrf1IQqsoWHTiZx+Bmjyp79TX/SSsG3edhsk5y+tQpvpMrgy
         oS5CsHtpyLss0V6gC1ZI1XHfy/IABjtoN2mGcvFayiM05qXhbAJU9mScyxVmL9z+1ruA
         dDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKgozUjj14O/q7Sm3dF4aSRoq0XpT1MQsgLL9CSaZjM=;
        b=OHsm8WOwAf85LdwdQc/i7iKLEYGYIAEvGH5XEUfEq0GgNmAtx8H1IyHda+xlD+zD76
         hdQerDMqyPYAQqToMR7ls8z6x5fXJrtXnP8cY98nc+rezPW/V7uPamf3bqP8brAduZwS
         c5cRHDevVykgZ7Sx+ODXOqoKz0fPGVqe9BZvTozVV/aOdRjs5HFXsS3vU8y1WAsfdiCf
         5jN1jONb09rJAthbZz+z8C9bgsuAOIK/7FPt+lm9bE83fSviR7CUf4gftCcoIWOQfrxz
         QB3ytt5hu3z9duQchQMSk3Mh+LfWVgxb+fm28EAURIX6BK18k2C42bKqmk8Xi7CzxjDk
         hsSA==
X-Gm-Message-State: ANhLgQ2EvndU0crmzlQS897IeShJ7efPBN83kYZfXr7bkltBhRZZuJ6u
        TPIXz9BAbgPK5Mhm+D6AOY1O4RhnjvFzXw==
X-Google-Smtp-Source: ADFU+vsdM3mbTPQBMevcUkjAI+m/Vqp9UZy5xEiHOQ3XRZA7+etAQs3iMb0sTquEGpaZvcKIFHDPrQ==
X-Received: by 2002:a92:8151:: with SMTP id e78mr936348ild.227.1585093730380;
        Tue, 24 Mar 2020 16:48:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c12sm6804109ila.31.2020.03.24.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 16:48:50 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     rbilovol@cisco.com, ddutile@redhat.com, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ruslan.bilovol@gmail.com
Subject: [PATCH] PCI: sysfs: Change bus_rescan and dev_rescan to rescan
Date:   Tue, 24 Mar 2020 17:48:48 -0600
Message-Id: <20200324234848.8299-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelsey Skunberg <kelsey.skunberg@gmail.com>

rename device attribute name arguments 'bus_rescan' and 'dev_rescan' to 'rescan'
to avoid breaking userspace applications.

The attribute argument names were changed in the following commits:
8bdfa145f582 ("PCI: sysfs: Define device attributes with DEVICE_ATTR*()")
4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")

Revert the names used for attributes back to the names used before the above
patches were applied. This also requires to change DEVICE_ATTR_WO() to
DEVICE_ATTR() and __ATTR().

Note when using DEVICE_ATTR() the attribute is automatically named
dev_attr_<name>.attr. To avoid duplicated names between attributes, use
__ATTR() instead of DEVICE_ATTR() to a assign a custom attribute name for
dev_rescan.

change bus_rescan_store() to dev_bus_rescan_store() to complete matching the
names used before the mentioned patches were applied.

Signed-off-by: Kelsey Skunberg <kelsey.skunberg@gmail.com>
---
 drivers/pci/pci-sysfs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 13f766db0684..667e13d597ff 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,7 +464,10 @@ static ssize_t dev_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR_WO(dev_rescan);
+static struct device_attribute dev_rescan_attr = __ATTR(rescan,
+							0220, NULL,
+							dev_rescan_store);
+
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -481,9 +484,9 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
 				  remove_store);
 
-static ssize_t bus_rescan_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t dev_bus_rescan_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	unsigned long val;
 	struct pci_bus *bus = to_pci_bus(dev);
@@ -501,7 +504,7 @@ static ssize_t bus_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR_WO(bus_rescan);
+static DEVICE_ATTR(rescan, 0220, NULL, dev_bus_rescan_store);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
@@ -641,7 +644,7 @@ static struct attribute *pcie_dev_attrs[] = {
 };
 
 static struct attribute *pcibus_attrs[] = {
-	&dev_attr_bus_rescan.attr,
+	&dev_attr_rescan.attr,
 	&dev_attr_cpuaffinity.attr,
 	&dev_attr_cpulistaffinity.attr,
 	NULL,
@@ -1487,7 +1490,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 
 static struct attribute *pci_dev_hp_attrs[] = {
 	&dev_attr_remove.attr,
-	&dev_attr_dev_rescan.attr,
+	&dev_rescan_attr.attr,
 	NULL,
 };
 
-- 
2.20.1

