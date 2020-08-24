Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575CA250C77
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 01:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgHXXj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 19:39:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35348 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHXXjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 19:39:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id i10so11667210ljn.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 16:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCKxQD17GAAzTSoSv+x8QmabIow6dwbbbd4J4+NtspE=;
        b=ICs4TjQVg0WRDFM4N835Cm40II3Tq4Jyc1PlgE+gU8Z2DYBlZr5MrBVZrrUiNRNS0Y
         SRqCdJf5hsd05Mv+2LESZRmXM+hW5eABjqQlhIeGxMjivgN+34JaeYbxewypXV0dVkk4
         5nxSeMwmLP9GGMfwHMerjjljIIjnnsuvUcz9R1UL81Mu1sYiZ0SEDDLgSnajSaUg04yq
         K+15RFTMbc3Dywm/6hpyKtiH/irD/tdoTHbZsjSy0rTTnUTCE/FBBag9lsqa3jXZwSLI
         +t2R8FDZ4HCYO0nCinbax2yiOw2wU8q2B8RsmO1kPQhmMcvVQcRnku6Sz9ccLVAjFnG9
         Wwfw==
X-Gm-Message-State: AOAM53115eNQe+LhjTLl31rwltsN6lpCozLa7cp7cV7Tc1jIq8wjSbV7
        GmJuyVK1oJPntzMGMrHMce6T3rEng7BGVA==
X-Google-Smtp-Source: ABdhPJzZBai9/G1wrnGsLFOUV+rTCGeDNwJ/umvLV/FTZLKrAmgKvfF4CC72GMt5IQ7ulLG3VfW2gA==
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr3441755ljp.6.1598312363968;
        Mon, 24 Aug 2020 16:39:23 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r6sm2492682lji.117.2020.08.24.16.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:39:22 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI/P2PDMA: Replace use of snprintf() with scnprintf() in show() functions
Date:   Mon, 24 Aug 2020 23:39:18 +0000
Message-Id: <20200824233918.26306-4-kw@linux.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824233918.26306-1-kw@linux.com>
References: <20200824233918.26306-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace use of snprintf() with scnprintf() in the functions size_show(),
available_show() and published_show() in order to adhere to the rules in
Documentation/filesystems/sysfs.txt, as per:

  show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

Also resolve the following Coccinelle warnings:

  drivers/pci/p2pdma.c:69:8-16: WARNING: use scnprintf or sprintf
  drivers/pci/p2pdma.c:78:8-16: WARNING: use scnprintf or sprintf
  drivers/pci/p2pdma.c:56:8-16: WARNING: use scnprintf or sprintf

The Coccinelle warning was added in commit abfc19ff202d ("coccinelle:
api: add device_attr_show script").

There is no change to the functionality.

Related:
  https://patchwork.kernel.org/patch/9946759/#20969333
  https://lwn.net/Articles/69419

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/p2pdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index f357f9a32b3a..c4714438d39c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -53,7 +53,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		size = gen_pool_size(pdev->p2pdma->pool);
 
-	return snprintf(buf, PAGE_SIZE, "%zd\n", size);
+	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -66,7 +66,7 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 	if (pdev->p2pdma->pool)
 		avail = gen_pool_avail(pdev->p2pdma->pool);
 
-	return snprintf(buf, PAGE_SIZE, "%zd\n", avail);
+	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
 }
 static DEVICE_ATTR_RO(available);
 
@@ -75,8 +75,8 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			pdev->p2pdma->p2pmem_published);
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 pdev->p2pdma->p2pmem_published);
 }
 static DEVICE_ATTR_RO(published);
 
-- 
2.28.0

