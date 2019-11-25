Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2C10947A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 20:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfKYTxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 14:53:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44884 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYTxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 14:53:16 -0500
Received: by mail-io1-f68.google.com with SMTP id j20so17608632ioo.11;
        Mon, 25 Nov 2019 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXMmnNGKg3tJmhKWEmPdoHChgPHviIbMLnoiK6ldKks=;
        b=QAAwkktQYdWygF1R1Q3uQWunWjPhpxYZhDa8YRgeG70ns8iW2AVpnR2iGxFSPzbitl
         UINQ5tH+0nI+qA0UE0ciK2ysXrQ32EokusD7QZ9a+OmlcAFjMyqETZut4vAC15PusUbG
         Q83UBbBCJVRKQatLjTq1+wfevur4OE7oRSo6dyvUhGy9TBFwX6lSPypi6IImJUSWUBiS
         32umWRVKK/yasZBqrprx3gwueLUl3bTpeknlNfrmV9ctDVPjyElK17sMVFHPAtBvWKaG
         GyR/qQcdCl7duAhpFcJY4035RoUBN3QERsWK/go6etbJCPUL0SGQkatXl6OJ6UGs5XyN
         Vw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXMmnNGKg3tJmhKWEmPdoHChgPHviIbMLnoiK6ldKks=;
        b=mufJorw4f6fDu8aG/XbL9t1yifQ8pHFw1ZXLB5l4Z7WE2DmBmoUY248MDaAJkvW8kB
         7wZ3/bzZK1J9mUEC3/ODgjs+gtT4pKzEPdQ/8Ua/y7aa6SjQeAUMNzztDCIOCb1xFF0n
         INTUflCAOBhLNJ4T6sh41ozRrCukAaPmitgPelXkTHZ0Mk/qth4wAcq3pK3UBPrZjK7w
         eNWpe19V42aX0nTs+OjVguNw81LQWKHzNJwrV5PK6tRWdYa0RncXwCXnDeMZFYvgDAPB
         E8/BctklUwJUmO/EkMifa/Zhn7CMJub9hflhKKuMFoUnwkMBLniObitr+g0dkay72Lhv
         5Row==
X-Gm-Message-State: APjAAAWJO51m8IAC7nwaieQtYvm0y0/uz7twtzFY/GAu/RfNuB4OeI8f
        EWHgXh2Yyw5iOccUGjG8Acg=
X-Google-Smtp-Source: APXvYqyy0ilWoKpOrcui9VMq7fW1Fh6EUG5Qm1LlyaX3qGMklKi+z0De+set8EPCL2Q1qPZjTt5nmA==
X-Received: by 2002:a02:55c3:: with SMTP id e186mr29522881jab.143.1574711595706;
        Mon, 25 Nov 2019 11:53:15 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t4sm2456592ilh.29.2019.11.25.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 11:53:14 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     natechancellor@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v2] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Mon, 25 Nov 2019 13:52:52 -0600
Message-Id: <20191125195255.23740-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125180448.GA39139@ubuntu-x2-xlarge-x86>
References: <20191125180448.GA39139@ubuntu-x2-xlarge-x86>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the implementation of pci_iov_add_virtfn() the allocated virtfn is
leaked if pci_setup_device() fails. The error handling is not calling
pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	- rename the labels for error paths
---
 drivers/pci/iov.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b3f972e8cfed..deec9f9e0b61 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -187,10 +187,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
-		goto failed2;
+		goto failed1;
 	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
 	if (rc)
-		goto failed3;
+		goto failed2;
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
@@ -198,11 +198,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 
 	return 0;
 
-failed3:
-	sysfs_remove_link(&dev->dev.kobj, buf);
 failed2:
-	pci_stop_and_remove_bus_device(virtfn);
+	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
+	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
 failed0:
 	virtfn_remove_bus(dev->bus, bus);
-- 
2.17.1

