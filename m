Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3838EF7E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfHOPhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:37:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44102 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfHOPhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:37:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so6725909ote.11;
        Thu, 15 Aug 2019 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+IkMMasPgbhkkzG73LHf6NagXKIcCtT7qYIgxNt/0P4=;
        b=cO+YyaPfquz2auOroZrHmLZh3D0BL2zFBuNuTR14BmWdUO+UYMZdILhjrLABmkJy8o
         h5Te3CGEYa4Nb0gcQMg0u9fRzmFdUHTLdgXGd/wleaYfIkzOWxUW5FG16t3nu1yHvchU
         9K5tq2ih14H1O0+6NdXLB20MdR4+u6s9j7b0DRYFuPAWLKvdiZRE58GKUc0yMVQhLXzI
         SByMRba/PmYAr/UaoKyqkYM/zt5uwL9+leLJE1wimXFW3DnOcRxM6tmr6Y6/hqL+u5oK
         hau9c+dhkhbVs+y43jJxDLjNCsySAy90NcVeLS+xNTNRwikvNsDNsBXVRo7rVOVBqU1i
         y/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+IkMMasPgbhkkzG73LHf6NagXKIcCtT7qYIgxNt/0P4=;
        b=JJhd0wQYoQkI6RBvLiONc6epbnFIuhuovjRV6gIh42UkC4C8cL166YFiBdCRQSV237
         mgIF929EMkykuMO+9tVlGqimjV7bQzd0L/XkWH+9vEuLOkqJ8NwSoNk0yl3YIVoZTlDk
         SkjRE53QkFHzHAnMu3dziq6G3EKeezZruIBFwcGl/ZagB34/nB+Mk7d7365heg/lyi8m
         7NpC+PGdsK50fZHgyzaqrYlShiPVxqrIhkxfgw10IatfJyGqtv550aHwXR7pW8XBSTYW
         1zlYjVQsvDGxTWqBN33K5t4smck9E3pMhUjNave/Ye6+6C2oxfR7f66bciJ+dHQ1Mawa
         /zVA==
X-Gm-Message-State: APjAAAXw982+IQFOaZviJEpAt4oAhiw6pT1ZZ1O1/IAozGCprPPP8tpS
        Hwk3/DVZlscmdcGn5uSUv6Q=
X-Google-Smtp-Source: APXvYqxW1rBlF1opbXz5f5FTm4fsYxeyBmKiaAwCypA4W70NXRijwSz9yq/RTAfbCrj1YFGufljjJg==
X-Received: by 2002:a5e:d611:: with SMTP id w17mr5813759iom.34.1565883435315;
        Thu, 15 Aug 2019 08:37:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c18sm1491856iod.19.2019.08.15.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:37:14 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        gregkh@linuxfoundation.org, skunberg.kelsey@gmail.com
Subject: [PATCH v3 3/4] PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()
Date:   Thu, 15 Aug 2019 09:33:52 -0600
Message-Id: <20190815153352.86143-4-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DEVICE_ATTR() should only be used when files have unusual permissions.
Change DEVICE_ATTR() with '0220' permissions to DEVICE_ATTR_WO().

Example of old:

static DEVICE_ATTR(_name, 0220, NULL, _store);

Example of new:

static DEVICE_ATTR_WO(_name);

Since _store is no longer passed, make the _name passed by
DEVICE_ATTR_WO() and the related _name##_store() name match with each
other.

Example:

DEVICE_ATTR_WO(bus_rescan) must be able to call bus_rescan_store()

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 346193ca4826..5bb301efec98 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,7 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(rescan, 0220, NULL, dev_rescan_store);
+static DEVICE_ATTR_WO(dev_rescan);
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -481,9 +481,9 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
 				  remove_store);
 
-static ssize_t dev_bus_rescan_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t bus_rescan_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	unsigned long val;
 	struct pci_bus *bus = to_pci_bus(dev);
@@ -501,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(bus_rescan, 0220, NULL, dev_bus_rescan_store);
+static DEVICE_ATTR_WO(bus_rescan);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
@@ -1619,7 +1619,7 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 
 static struct attribute *pci_dev_hp_attrs[] = {
 	&dev_attr_remove.attr,
-	&dev_attr_rescan.attr,
+	&dev_attr_dev_rescan.attr,
 	NULL,
 };
 
-- 
2.20.1

