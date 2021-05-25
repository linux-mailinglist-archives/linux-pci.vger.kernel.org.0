Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712A63900E9
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEYM0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 08:26:19 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41757 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhEYM0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 08:26:19 -0400
Received: by mail-pg1-f172.google.com with SMTP id r1so7751181pgk.8
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 05:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6bpNTp63J2JCwxOjLKFQTUbwufk/UzqLJ7gX6xEOkI=;
        b=tpkbywUqgcV1WCwhdg9KbYM+4TszPN4gBlmQN8xhnDS5M7t3Eu/DWrBr4J0P2VkVz6
         fYRXL6C/7iIFEFiFdJMDn5apUQwR2pEX5wi7dmVOADkLx764bQV6dVAIpcrcY+vStz9h
         wVTUhGsysX2hgL3y/6ZrSpxmgrz+dh0JzHyOfOCvJaht+j6NpR6NN/aBBZwhe71p67FI
         WOt/y1c0qDGTXNE8mJkw//fVPbQO/AXFR7Ne9s4jZUTRWs0feRZGr7nhxbqtTkhgUBpz
         d+Ui72xtZd4guvDKGmoil+SB5k99jjUQ9B54C55AjVlcNf3xFPN72Mu0R3iKL6CO71+D
         Dg4Q==
X-Gm-Message-State: AOAM532Aw70c3sPGIouOf++TiPjC4yujmfXDoztIzwIqh7tUIgvDGKTN
        39bmKYMDVbfTZ7skVz6vmO0ovHhBTGgT4g==
X-Google-Smtp-Source: ABdhPJyOgfBlKeuhzFjGqOxDN1Rj1C0L6TBW5Aojc3oqYI2dLxzJd9OxPjj+Rv5wRLA3mK3kKufosg==
X-Received: by 2002:a05:6a00:1992:b029:2df:b93b:49a with SMTP id d18-20020a056a001992b02902dfb93b049amr29793945pfl.11.1621945488345;
        Tue, 25 May 2021 05:24:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u1sm14220258pfc.63.2021.05.25.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:24:48 -0700 (PDT)
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
Subject: [PATCH v4 5/5] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Tue, 25 May 2021 12:24:01 +0000
Message-Id: <20210525122401.206136-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525122401.206136-1-kw@linux.com>
References: <20210525122401.206136-1-kw@linux.com>
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
Changes in v4:
  None.

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

