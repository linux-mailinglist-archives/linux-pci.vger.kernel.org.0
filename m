Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25E2B5972
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 06:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQFo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 00:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQFoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 00:44:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD433C0613CF;
        Mon, 16 Nov 2020 21:44:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so12085875pgp.10;
        Mon, 16 Nov 2020 21:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aM+Nm6mpUW3MCGzLuyldKTZgaVA5NUmu8kqnaySSbTA=;
        b=jiHoeTH2eVzDH2nroMQlXXEfsqWUlT8XzPEP5m3GuE9cJMD7d+qaWujwIVrgYF0gI9
         /VyXhVAb+sduQ/t69Ze3j70EhmFxvhCQE2vAupTY2aFk6sDItUlGCr2ie8ti13GTfZj3
         QsVxhh+0q/helyaH0W802fEacqAlaTct5lir81NQkfdvzlXXPbKZeMCuXgaHB8vv4A71
         4gLMt4yIzMfPPHiM8cvCJwDmxyOtm4aBYcixN+5DB1bYbSp0FC0MUzB1xqlDmMKCYCLv
         R2n+OyOu9pnO4aI+w9PUsykVos8Ft+czGGakYfVS/8ClJn1ZIOwLvCYdUk8LxkmmCO2X
         ogDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aM+Nm6mpUW3MCGzLuyldKTZgaVA5NUmu8kqnaySSbTA=;
        b=NJaUmXXOv511wqVx0QnWUNeCj3d/iDccHAnzrsgVMQtvtMmaFJ/yyyngZCmc9+DKiy
         eBfTNnM1OoXjNieTDu1TdVO6s4W0tlmt6f6hOZJDutK1uPJ/U2SASVv7FFREYZNPiZ8F
         NciJ1QWXm0V7YfkiPAGUKaPnPJxYvzjii7Wsn8w5XSgrx/CS96qrHyF8hNfjvdJlySZB
         xn6vioAosGPC98NGxGgkvnRooqnCdEmvgFm7OBxsrWrJyO2KWBM1lW0/E0tGMCFFzUKx
         8Ne5L0z0flrPGpfvUxLvoNPBlhgkXtu91H2VomPNvsvsrXbqzLMsk7oDrxQB/1fAkFnw
         jaNQ==
X-Gm-Message-State: AOAM532MXsar4Bt7soJ8zTjmyAK9ZiL/FbxoEZIVyEMHUm8KVnXwxJw8
        NDNudIXiYbG3elIPR4oPMF9agevHEUc=
X-Google-Smtp-Source: ABdhPJwa+OrOSzwQxKXEOfmfS5BX/pQuhVXNnXY51685hG9SSZRcujXe79iUorqYOwh3EurcVdU1Nw==
X-Received: by 2002:a63:a57:: with SMTP id z23mr2161811pgk.404.1605591893124;
        Mon, 16 Nov 2020 21:44:53 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id m3sm20392462pfd.217.2020.11.16.21.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 21:44:52 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, hch@infradead.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v3 1/2] PCI: move pci_match_device() ahead of new_id_store()
Date:   Tue, 17 Nov 2020 13:44:08 +0800
Message-Id: <20201117054409.3428-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
References: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move pci_match_device() and it's dependencies (pci_match_id() and
pci_device_id_any) ahead of new_id_store().

This is preparation work for calling pci_match_device() in new_id_store().
No functional changes.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/pci/pci-driver.c | 144 +++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b587fc..e928cfa 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -90,6 +90,78 @@ static void pci_free_dynids(struct pci_driver *drv)
 }
 
 /**
+ * pci_match_id - See if a pci device matches a given pci_id table
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against.
+ *
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.  Returns the matching
+ * pci_device_id structure or %NULL if there is no match.
+ *
+ * Deprecated, don't use this as it will not catch any dynamic ids
+ * that a driver might want to check for.
+ */
+const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
+					 struct pci_dev *dev)
+{
+	if (ids) {
+		while (ids->vendor || ids->subvendor || ids->class_mask) {
+			if (pci_match_one_device(ids, dev))
+				return ids;
+			ids++;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(pci_match_id);
+
+static const struct pci_device_id pci_device_id_any = {
+	.vendor = PCI_ANY_ID,
+	.device = PCI_ANY_ID,
+	.subvendor = PCI_ANY_ID,
+	.subdevice = PCI_ANY_ID,
+};
+
+/**
+ * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * @drv: the PCI driver to match against
+ * @dev: the PCI device structure to match against
+ *
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.  Returns the matching
+ * pci_device_id structure or %NULL if there is no match.
+ */
+static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+						    struct pci_dev *dev)
+{
+	struct pci_dynid *dynid;
+	const struct pci_device_id *found_id = NULL;
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
+		return NULL;
+
+	/* Look at the dynamic ids first, before the static ones */
+	spin_lock(&drv->dynids.lock);
+	list_for_each_entry(dynid, &drv->dynids.list, node) {
+		if (pci_match_one_device(&dynid->id, dev)) {
+			found_id = &dynid->id;
+			break;
+		}
+	}
+	spin_unlock(&drv->dynids.lock);
+
+	if (!found_id)
+		found_id = pci_match_id(drv->id_table, dev);
+
+	/* driver_override will always match, send a dummy id */
+	if (!found_id && dev->driver_override)
+		found_id = &pci_device_id_any;
+
+	return found_id;
+}
+
+/**
  * store_new_id - sysfs frontend to pci_add_dynid()
  * @driver: target device driver
  * @buf: buffer for scanning device ID data
@@ -208,78 +280,6 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 };
 ATTRIBUTE_GROUPS(pci_drv);
 
-/**
- * pci_match_id - See if a pci device matches a given pci_id table
- * @ids: array of PCI device id structures to search in
- * @dev: the PCI device structure to match against.
- *
- * Used by a driver to check whether a PCI device present in the
- * system is in its list of supported devices.  Returns the matching
- * pci_device_id structure or %NULL if there is no match.
- *
- * Deprecated, don't use this as it will not catch any dynamic ids
- * that a driver might want to check for.
- */
-const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
-					 struct pci_dev *dev)
-{
-	if (ids) {
-		while (ids->vendor || ids->subvendor || ids->class_mask) {
-			if (pci_match_one_device(ids, dev))
-				return ids;
-			ids++;
-		}
-	}
-	return NULL;
-}
-EXPORT_SYMBOL(pci_match_id);
-
-static const struct pci_device_id pci_device_id_any = {
-	.vendor = PCI_ANY_ID,
-	.device = PCI_ANY_ID,
-	.subvendor = PCI_ANY_ID,
-	.subdevice = PCI_ANY_ID,
-};
-
-/**
- * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
- * @drv: the PCI driver to match against
- * @dev: the PCI device structure to match against
- *
- * Used by a driver to check whether a PCI device present in the
- * system is in its list of supported devices.  Returns the matching
- * pci_device_id structure or %NULL if there is no match.
- */
-static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
-						    struct pci_dev *dev)
-{
-	struct pci_dynid *dynid;
-	const struct pci_device_id *found_id = NULL;
-
-	/* When driver_override is set, only bind to the matching driver */
-	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
-		return NULL;
-
-	/* Look at the dynamic ids first, before the static ones */
-	spin_lock(&drv->dynids.lock);
-	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (pci_match_one_device(&dynid->id, dev)) {
-			found_id = &dynid->id;
-			break;
-		}
-	}
-	spin_unlock(&drv->dynids.lock);
-
-	if (!found_id)
-		found_id = pci_match_id(drv->id_table, dev);
-
-	/* driver_override will always match, send a dummy id */
-	if (!found_id && dev->driver_override)
-		found_id = &pci_device_id_any;
-
-	return found_id;
-}
-
 struct drv_dev_and_id {
 	struct pci_driver *drv;
 	struct pci_dev *dev;
-- 
1.8.3.1

