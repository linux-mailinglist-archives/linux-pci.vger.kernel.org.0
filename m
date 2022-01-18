Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC7491E70
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 05:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiARESN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 23:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiARESN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 23:18:13 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC4C061574;
        Mon, 17 Jan 2022 20:18:12 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 193so20883713qkh.13;
        Mon, 17 Jan 2022 20:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIw4lgCiOYTaWvypeX/l+WozvsAUYZfOGlKqOpcHN5Y=;
        b=HqcZxT1JAiZn1ZOVcnn6JPxSBmABORcNBANIrzpFBc0k6qXe2ps/EAfsfOYJuEZf+Z
         RZQQq4d1lKcOXWoWUyZAQ2SWOWbRtm4x5ArHYYJXEJYoletTW22sWc2Gz2Q0Edh5oLgB
         p9PSTUvSKCgHu4tKiUaSV72zEXVgww5GDT3nlsboo9Yho1qHZrOgkiXTHSULH8MvTO3S
         Zmu0K9UBFDyqNJ0bvCNOH4K13PhAraWvDbeUdr1iDcRaUzJ7Hqaa/8zjhxzqDORTFMQG
         Kf/PgTOOiayIqnqcpP2cSsLk2kWBV2Udgvhi9woTAQKwnl79RsdnFwOcC+nFfCGHd0DA
         hPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIw4lgCiOYTaWvypeX/l+WozvsAUYZfOGlKqOpcHN5Y=;
        b=mySYSKjUktVrbGo/GqUXrSkWNLtwgRJxiop5VUpSAk7QUfyNvOcKBFMK/2CIsEH06k
         hx87tBT2TSAEgf4A53o+M3FAwvgzGuAk2t/uRAkwNxT+fKRSTYBt1jucstA+M54Guei+
         8LBIitRIFgZUq3RRDLz0ghWHBkwD75IIF4Q8qMMzDy52kT0K/uiiCoaYNbqWkb9glTdZ
         mAZZniBDjB+GxR9eUyHA12XbU0Rwb1ZLlzKBsgxbQL4mM6hJ+yHi2X2Qc/VspVlRqZIB
         BtnjqM9e97E4MmN11rXXVJJgpXPkLIzaOO/pIhgd6FlW9fpTjXGi5KmcBmr7c/pBNbQd
         MLHg==
X-Gm-Message-State: AOAM533d19ghD7YvLxzEC4G2dR0KC0lcInQlcfvYGf4+ve2MzfBsPkUg
        ByPZnkZZsH2Vrh4C2pyWmzg=
X-Google-Smtp-Source: ABdhPJyvM3m+zhMaM4wyedO6DCooKNu0oj3SQgMjTHibTQ097/9KEtdAH5rrAm7jScXb+AVW+HqDdw==
X-Received: by 2002:a05:620a:17a5:: with SMTP id ay37mr8581756qkb.0.1642479492150;
        Mon, 17 Jan 2022 20:18:12 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d11sm10225479qkn.96.2022.01.17.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 20:18:11 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH 1/3] Add support for seven more indicators in enclosure driver
Date:   Mon, 17 Jan 2022 22:17:56 -0600
Message-Id: <de41441fa835af52ac53a08013534e0cdd448aa9.1642460765.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642460765.git.stuart.w.hayes@gmail.com>
References: <cover.1642460765.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for seven additional indicators (ok, rebuild,
prdfail, hotspare, ica, ifa, disabled) to the enclosure driver, which
currently only supports three (fault, active, locate). It also reduces
duplicated code for the set and show functions for the sysfs attributes
for all of the indicators, and allows users of the driver to provide
common get_led and set_led callbacks to control all indicators (though
it continues to support the existing callbacks for the three currently
supported indicators, so it does not require any changes to code that
already uses the enclosure driver).

This will be used by the pcie_em driver.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/misc/enclosure.c  | 189 ++++++++++++++++++++++----------------
 include/linux/enclosure.h |  22 +++++
 2 files changed, 133 insertions(+), 78 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 1b010d9267c9..e5a0bb9a719f 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -473,30 +473,6 @@ static const char *const enclosure_type[] = {
 	[ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
 };
 
-static ssize_t get_component_fault(struct device *cdev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-
-	if (edev->cb->get_fault)
-		edev->cb->get_fault(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->fault);
-}
-
-static ssize_t set_component_fault(struct device *cdev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-	int val = simple_strtoul(buf, NULL, 0);
-
-	if (edev->cb->set_fault)
-		edev->cb->set_fault(edev, ecomp, val);
-	return count;
-}
-
 static ssize_t get_component_status(struct device *cdev,
 				    struct device_attribute *attr,char *buf)
 {
@@ -531,54 +507,6 @@ static ssize_t set_component_status(struct device *cdev,
 		return -EINVAL;
 }
 
-static ssize_t get_component_active(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-
-	if (edev->cb->get_active)
-		edev->cb->get_active(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->active);
-}
-
-static ssize_t set_component_active(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-	int val = simple_strtoul(buf, NULL, 0);
-
-	if (edev->cb->set_active)
-		edev->cb->set_active(edev, ecomp, val);
-	return count;
-}
-
-static ssize_t get_component_locate(struct device *cdev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-
-	if (edev->cb->get_locate)
-		edev->cb->get_locate(edev, ecomp);
-	return sysfs_emit(buf, "%d\n", ecomp->locate);
-}
-
-static ssize_t set_component_locate(struct device *cdev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
-	struct enclosure_component *ecomp = to_enclosure_component(cdev);
-	int val = simple_strtoul(buf, NULL, 0);
-
-	if (edev->cb->set_locate)
-		edev->cb->set_locate(edev, ecomp, val);
-	return count;
-}
-
 static ssize_t get_component_power_status(struct device *cdev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -641,29 +569,134 @@ static ssize_t get_component_slot(struct device *cdev,
 	return sysfs_emit(buf, "%d\n", slot);
 }
 
-static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
-		    set_component_fault);
+/*
+ * callbacks for attrs using enum enclosure_component_setting (LEDs)
+ */
+static ssize_t led_show(struct device *cdev,
+			enum enclosure_component_led led,
+			char *buf)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+
+	if (edev->cb->get_led)
+		edev->cb->get_led(edev, ecomp, led);
+	else
+		/*
+		 * support old callbacks for fault/active/locate
+		 */
+		switch (led) {
+		case ENCLOSURE_LED_FAULT:
+			if (edev->cb->get_fault) {
+				edev->cb->get_fault(edev, ecomp);
+				ecomp->led[led] = ecomp->fault;
+			}
+			break;
+		case ENCLOSURE_LED_ACTIVE:
+			if (edev->cb->get_active) {
+				edev->cb->get_active(edev, ecomp);
+				ecomp->led[led] = ecomp->active;
+			}
+			break;
+		case ENCLOSURE_LED_LOCATE:
+			if (edev->cb->get_locate) {
+				edev->cb->get_locate(edev, ecomp);
+				ecomp->led[led] = ecomp->locate;
+			}
+			break;
+		default:
+		}
+
+	return sysfs_emit(buf, "%d\n", ecomp->led[led]);
+}
+
+static ssize_t led_set(struct device *cdev,
+		       enum enclosure_component_led led,
+		       const char *buf, size_t count)
+{
+	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
+	struct enclosure_component *ecomp = to_enclosure_component(cdev);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (edev->cb->set_led)
+		edev->cb->set_led(edev, ecomp, led, val);
+	else
+		/*
+		 * support old callbacks for fault/active/locate
+		 */
+		switch (led) {
+		case ENCLOSURE_LED_FAULT:
+			if (edev->cb->set_fault)
+				edev->cb->set_fault(edev, ecomp, val);
+			break;
+		case ENCLOSURE_LED_ACTIVE:
+			if (edev->cb->set_active)
+				edev->cb->set_active(edev, ecomp, val);
+			break;
+		case ENCLOSURE_LED_LOCATE:
+			if (edev->cb->set_locate)
+				edev->cb->set_locate(edev, ecomp, val);
+			break;
+		default:
+		}
+
+	return count;
+}
+
+#define LED_ATTR_RW(led_attr, led)					\
+static ssize_t led_attr##_show(struct device *cdev,			\
+			       struct device_attribute *attr,		\
+			       char *buf)				\
+{									\
+	return led_show(cdev, led, buf);				\
+}									\
+static ssize_t led_attr##_store(struct device *cdev,			\
+				struct device_attribute *attr,		\
+				const char *buf, size_t count)		\
+{									\
+	return led_set(cdev, led, buf, count);				\
+}									\
+static DEVICE_ATTR_RW(led_attr)
+
 static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
 		   set_component_status);
-static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
-		   set_component_active);
-static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
-		   set_component_locate);
 static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
 		   set_component_power_status);
 static DEVICE_ATTR(type, S_IRUGO, get_component_type, NULL);
 static DEVICE_ATTR(slot, S_IRUGO, get_component_slot, NULL);
+LED_ATTR_RW(fault, ENCLOSURE_LED_FAULT);
+LED_ATTR_RW(active, ENCLOSURE_LED_ACTIVE);
+LED_ATTR_RW(locate, ENCLOSURE_LED_LOCATE);
+LED_ATTR_RW(ok, ENCLOSURE_LED_OK);
+LED_ATTR_RW(rebuild, ENCLOSURE_LED_REBUILD);
+LED_ATTR_RW(prdfail, ENCLOSURE_LED_PRDFAIL);
+LED_ATTR_RW(hotspare, ENCLOSURE_LED_HOTSPARE);
+LED_ATTR_RW(ica, ENCLOSURE_LED_ICA);
+LED_ATTR_RW(ifa, ENCLOSURE_LED_IFA);
+LED_ATTR_RW(disabled, ENCLOSURE_LED_DISABLED);
 
 static struct attribute *enclosure_component_attrs[] = {
 	&dev_attr_fault.attr,
 	&dev_attr_status.attr,
 	&dev_attr_active.attr,
 	&dev_attr_locate.attr,
+	&dev_attr_ok.attr,
+	&dev_attr_rebuild.attr,
+	&dev_attr_prdfail.attr,
+	&dev_attr_hotspare.attr,
+	&dev_attr_ica.attr,
+	&dev_attr_ifa.attr,
+	&dev_attr_disabled.attr,
 	&dev_attr_power_status.attr,
 	&dev_attr_type.attr,
 	&dev_attr_slot.attr,
 	NULL
 };
+
 ATTRIBUTE_GROUPS(enclosure_component);
 
 static int __init enclosure_init(void)
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 1c630e2c2756..98dd0f05efb7 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -49,6 +49,20 @@ enum enclosure_component_setting {
 	ENCLOSURE_SETTING_BLINK_B_OFF_ON = 7,
 };
 
+enum enclosure_component_led {
+	ENCLOSURE_LED_FAULT,
+	ENCLOSURE_LED_ACTIVE,
+	ENCLOSURE_LED_LOCATE,
+	ENCLOSURE_LED_OK,
+	ENCLOSURE_LED_REBUILD,
+	ENCLOSURE_LED_PRDFAIL,
+	ENCLOSURE_LED_HOTSPARE,
+	ENCLOSURE_LED_ICA,
+	ENCLOSURE_LED_IFA,
+	ENCLOSURE_LED_DISABLED,
+	ENCLOSURE_LED_MAX,
+};
+
 struct enclosure_device;
 struct enclosure_component;
 struct enclosure_component_callbacks {
@@ -72,6 +86,13 @@ struct enclosure_component_callbacks {
 	int (*set_locate)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
+	void (*get_led)(struct enclosure_device *edev,
+			struct enclosure_component *ecomp,
+			enum enclosure_component_led);
+	int (*set_led)(struct enclosure_device *edev,
+		       struct enclosure_component *ecomp,
+		       enum enclosure_component_led,
+		       enum enclosure_component_setting);
 	void (*get_power_status)(struct enclosure_device *,
 				 struct enclosure_component *);
 	int (*set_power_status)(struct enclosure_device *,
@@ -90,6 +111,7 @@ struct enclosure_component {
 	int fault;
 	int active;
 	int locate;
+	int led[ENCLOSURE_LED_MAX];
 	int slot;
 	enum enclosure_status status;
 	int power_status;
-- 
2.31.1

