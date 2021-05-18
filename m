Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB89E387046
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhERDmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:36 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44997 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbhERDmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:33 -0400
Received: by mail-lf1-f51.google.com with SMTP id j6so9271044lfr.11
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hL2jDaypxg6i6aaRUuht27oQUPjguMBMeKYJncYE6k=;
        b=QM7ZrVqz2kgve3HMM/BiYwLdgRIiqwoiXBPGLkMFHXAA2FSITo3BBBEsEIi1Ngcawu
         zIS8jhAabOl4DNC5cjKIa7kGts4n0fYHNSX5kskdijlx62QsDZnrMLWsQhn2yLI/4fjY
         tvD/aiLNbAM45Crr+xUFGhhP2YcfEKHglGzO5gyccrhs4Cv/AjoeA9b341+AruqHxPg6
         Nw+15Mnh6MNCsbmL0N75zLstehAj70NIyJhGnEUuaeBLwvqnNKpJLBQg8NduTLoz17hx
         IaJDg1vX1jTLchuWft28gdC1WswqzqvmKTax4yc4S3clP9Z7xZix5Hk8p64W5U9Ai0r+
         QMLg==
X-Gm-Message-State: AOAM533FznZawNBxRF0EjQtyIsV836QlCsXee2XY6N63nLo3SYqeIR0P
        QvhKB827KKNPHZhogOdnfW4=
X-Google-Smtp-Source: ABdhPJwCW8uApyZg8BIkmXjJc8Nwhz2kbUupfsx8l5aSWwJrrWH6KQWkSU6hufwrlqwFfJ/+UPNwog==
X-Received: by 2002:ac2:5a47:: with SMTP id r7mr2688265lfn.138.1621309274663;
        Mon, 17 May 2021 20:41:14 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:14 -0700 (PDT)
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
Subject: [PATCH v3 04/14] PCI/MSI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:40:59 +0000
Message-Id: <20210518034109.158450-4-kw@linux.com>
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
  Change style to preferred one as per Joe Perches' suggestion.

 drivers/pci/msi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 217dc9f0231f..9232255c8515 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -464,11 +464,11 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 		return retval;
 
 	entry = irq_get_msi_desc(irq);
-	if (entry)
-		return sprintf(buf, "%s\n",
-				entry->msi_attrib.is_msix ? "msix" : "msi");
+	if (!entry)
+		return -ENODEV;
 
-	return -ENODEV;
+	return sysfs_emit(buf, "%s\n",
+			  entry->msi_attrib.is_msix ? "msix" : "msi");
 }
 
 static int populate_msi_sysfs(struct pci_dev *pdev)
-- 
2.31.1

