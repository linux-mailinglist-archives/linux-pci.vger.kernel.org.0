Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECE93BC39A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGEVZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 17:25:51 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46716 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGEVZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 17:25:49 -0400
Received: by mail-lj1-f169.google.com with SMTP id q4so26240147ljp.13
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 14:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAt2/9fsX8msYKcUtaCFzrmkaM3hAZjJLNAanXNK3v4=;
        b=rkPoKjeeTxIjiUX4kPexVyZUy7T1gbIA4VMcqPMllaRYF/TwviJlJba0fnopotlMmO
         UrXMT6OhCXPPO66zDVbGLvaNCeyW8HhlW+D6O9w/h5GwaEUvgSLW0pG7jjJBaCboB+7z
         gpnCfm5pZ2sEumKVEfVES0XK6VAh9YUt+1K2APd0JRgifCqjryxjvFUATg/tQ6FicYwd
         Iw414ujHi9IYLQYi9nbs6Lxv5aSzoMaKYH61ZydZTGKnUaFcwj1+c7ll5/bMMmsEvpEl
         Hm1IhAOC0YJ47J1kAqzp9D6QOgJgchoctbNVtZcGydTIJnn9pUdSsN71uu9rNDQtf0eo
         BDKQ==
X-Gm-Message-State: AOAM530gKTt7DzStuOAFwMqqJoOqhhvYHrcge/poqUyY3NEIk1bLnx/I
        VGZgLhpoNBxI15ZAgM9CMmQ=
X-Google-Smtp-Source: ABdhPJwS99HCdL/nZ/BNVCOLSY0qOHFoOMbg3oUVtlqH9dVz8vG6ZPkc9Ux7gR7cfPBdQtQJ/jzgLg==
X-Received: by 2002:a05:651c:211f:: with SMTP id a31mr5572846ljq.216.1625520191265;
        Mon, 05 Jul 2021 14:23:11 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x1sm1191338lfa.21.2021.07.05.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 14:23:10 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI/sysfs: Check CAP_SYS_ADMIN before parsing user input
Date:   Mon,  5 Jul 2021 21:23:06 +0000
Message-Id: <20210705212308.3050976-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705212308.3050976-1-kw@linux.com>
References: <20210705212308.3050976-1-kw@linux.com>
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
 drivers/pci/pci-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0f98c4843764..bc4c141e4c1c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -275,13 +275,13 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	ssize_t result = 0;
 
-	if (kstrtobool(buf, &enable) < 0)
-		return -EINVAL;
-
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
 	device_lock(dev);
 	if (dev->driver)
 		result = -EBUSY;
@@ -377,12 +377,12 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *subordinate = pdev->subordinate;
 
-	if (kstrtobool(buf, &enable) < 0)
-		return -EINVAL;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
 	/*
 	 * "no_msi" and "bus_flags" only affect what happens when a driver
 	 * requests MSI or MSI-X.  They don't affect any drivers that have
-- 
2.32.0

