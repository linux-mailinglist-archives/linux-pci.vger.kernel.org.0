Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7940CFC6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 01:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhIOXCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 19:02:50 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:35416 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhIOXCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 19:02:50 -0400
Received: by mail-lf1-f53.google.com with SMTP id m3so8870059lfu.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 16:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CEaTlQvNZpRF49/gdrsx+pw4YoE0fPAtiHHb2K0ZQps=;
        b=t/OvYzvEWgUlyOylROv1OlNj/KTKwKQS1pIe6Oo1gGDM5xWRSzz2iIBvB5qj3rkjB2
         SrDnd64jmDZYdti4rb0PM6TqQTieYP1fhdZ+DXUm/df2rfCaEXLi70APQ9cXRCj7gSa6
         H3L4/+uCqCRtG2942mHIQzkZaW6BsJhNNfgZQIEXjKUXTJwqCuCjsrhKS+SSSlYdTXZG
         kwojXqOagBJANrGdDWmABo5Yy6zF9sW8OiarirS80dTs8CNvUPSoAsBYQMarlMAY2MKN
         kDZm/FOFzFkTgC3c1Q8mltQUACEUY01Khlj49M2agvdsT93MMoZ2GZSAfhZaCw5Gn5Jy
         PCdQ==
X-Gm-Message-State: AOAM5300HoOkZLmQlr2Mb3vbe4xDwoNREo6TivDiI6naay0nGK//Bh/s
        wLzfVZ5eYi029sxMAHmQSrVhOcbtoC4=
X-Google-Smtp-Source: ABdhPJxlmpXlzlgfoQcXm+pgGKTknCtXHe8w8UaMsiACFebo1gaTl3sOgmSpaozdz89RjLJvIernwg==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr2158708ljp.257.1631746889685;
        Wed, 15 Sep 2021 16:01:29 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d15sm107386lfn.220.2021.09.15.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:29 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/3] PCI/sysfs: Check CAP_SYS_ADMIN before parsing user input
Date:   Wed, 15 Sep 2021 23:01:25 +0000
Message-Id: <20210915230127.2495723-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check if the "CAP_SYS_ADMIN" capability flag is set before parsing user
input as it makes more sense to first check whether the current user
actually has the right permissions before accepting any input from such
user.

This will also make order in which enable_store() and msi_bus_store()
perform the "CAP_SYS_ADMIN" capability check consistent with other
PCI-related sysfs objects that first verify whether user has this
capability set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7fb5cd17cc98..6832e161be1c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -273,15 +273,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
-	ssize_t result = kstrtoul(buf, 0, &val);
-
-	if (result < 0)
-		return result;
+	ssize_t result;
 
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	result = kstrtoul(buf, 0, &val);
+	if (result < 0)
+		return result;
+
 	device_lock(dev);
 	if (dev->driver)
 		result = -EBUSY;
@@ -378,12 +379,12 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	struct pci_bus *subordinate = pdev->subordinate;
 	unsigned long val;
 
-	if (kstrtoul(buf, 0, &val) < 0)
-		return -EINVAL;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
 	/*
 	 * "no_msi" and "bus_flags" only affect what happens when a driver
 	 * requests MSI or MSI-X.  They don't affect any drivers that have
-- 
2.33.0

