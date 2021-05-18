Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FE38704F
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbhERDmn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:43 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33549 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbhERDmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:42 -0400
Received: by mail-lj1-f181.google.com with SMTP id o8so9845822ljp.0
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1spWpjRWutJF00hdbYEaMffPbCAUG6R0mq8npz/96kI=;
        b=fGhD77hE3zJP7hV0Geq6eRApEYSSD96LO98qrvJq+8oc8wgGjoTJ+dlFany18tTeKo
         SFtABYAc+juiXxS1oWlveZk1I28jb6mvRii0IXefpWbm3ize31csJTLKOCnvLKVOd8Td
         SUTE/F4gSKUFkWAWXDZtfFIwyYk8qRDPfW4bF58mpV5FB+cJMIRHiik9s/Y0XbSTP5qQ
         9G+fhBX6+iDoU1DMsuCAY7e6y7y60B4tEaIVqCc+4t8k9rfjD4ZatHyVTlRG6w5OSs7U
         jktjDntr5ZNmO/BDxVLdqWkuaz8d9vPXthBO/JKJWgOXbHZfrWuOCFHgznWLJ38cWi9k
         08+w==
X-Gm-Message-State: AOAM530Dz91duFx+YbU6nkXeYj7PAcvuac+nzzpY2iV3BBZ5yvHOS9TM
        D4RohELfDUOeIRTmwAWRMIU=
X-Google-Smtp-Source: ABdhPJyrkgkyMrT192aKsBz4oMBf4c0Uhp47zRxsn2+8r17eCcuJjO48OxADQ9++6BEpOfEcMaBiSQ==
X-Received: by 2002:a05:651c:119c:: with SMTP id w28mr2308078ljo.164.1621309284703;
        Mon, 17 May 2021 20:41:24 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:24 -0700 (PDT)
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
Subject: [PATCH v3 14/14] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Tue, 18 May 2021 03:41:09 +0000
Message-Id: <20210518034109.158450-14-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only expose the value of the "driver_override" variable through the
corresponding sysfs object when a value is actually set.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

 drivers/pci/pci-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..4e9f582ca10f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	ssize_t len;
+	ssize_t len = 0;
 
 	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	if (pdev->driver_override)
+		len = sysfs_emit(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
-- 
2.31.1

