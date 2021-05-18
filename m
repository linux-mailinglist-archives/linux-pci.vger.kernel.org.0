Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACC387047
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbhERDmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:36 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:36823 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbhERDmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:35 -0400
Received: by mail-lj1-f170.google.com with SMTP id 131so9785552ljj.3
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqYmqxNMbxWuoyLabOZEnnEKr6vIaWZ62QE5jmH/JUM=;
        b=RAC7NNnf56dkQiZ9bRUIhR9vwQ3j0FMvuUxHhufmC+e7Oxpci4mQ0Yb1lur8/Fhyhl
         7OPtsJDmJf9AOJ20R4iBUVJPzELTfewGnfibCSN6WVeLLpzZbOASTL8mv7RV6Kbwh+mZ
         Lwkwx0whdx7GAqPMqkPLAOPCO7uCoVraKymmE4YNMoo+aOe/6O/oauQ6T5Vai+a9K0ST
         gI21amA0n+I27y2eHjzOOwLykiymcffFkifnEqzADGkUG/jOgzZGMDw2MEHlyQ0Yi9mG
         bug0uJuXF+0DFPMo75Z1Fh3djfnYNccSwp5oyS4+aCTnKR8PUPID++p/9Jro8yeHQkSD
         SMzg==
X-Gm-Message-State: AOAM533CIFMlLYrWC8mxQV69bYqDOq7X5AIx08OIwyjNr4sFCYC31OUo
        ZkfmjuHJCb0QGe9jTecxRUw=
X-Google-Smtp-Source: ABdhPJz8XgRWh/DrspKBxOpq2nJ7zjRh2KnIBQpCElACsjTDH6tI9p05DH5yC8t5D444aBcTaGo8rg==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr2366447lji.16.1621309276652;
        Mon, 17 May 2021 20:41:16 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:16 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 06/14] PCI/P2PDMA: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:41:01 +0000
Message-Id: <20210518034109.158450-6-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

 drivers/pci/p2pdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..a1351b3e2c4c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -53,7 +53,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		size = gen_pool_size(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
+	return sysfs_emit(buf, "%zd\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -66,7 +66,7 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		avail = gen_pool_avail(pdev->p2pdma->pool);
 
-	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
+	return sysfs_emit(buf, "%zd\n", avail);
 }
 static DEVICE_ATTR_RO(available);
 
@@ -75,8 +75,7 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 pdev->p2pdma->p2pmem_published);
+	return sysfs_emit(buf, "%d\n", pdev->p2pdma->p2pmem_published);
 }
 static DEVICE_ATTR_RO(published);
 
-- 
2.31.1

