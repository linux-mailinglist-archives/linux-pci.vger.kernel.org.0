Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2587639B9E7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDNed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:33 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37792 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFDNed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:33 -0400
Received: by mail-qk1-f177.google.com with SMTP id i67so9280537qkc.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDZTRy60jf886VMZcN9phSvrkqPImnoVMsDLpQujQdY=;
        b=lHzCN7SMVb9LgTCjtq4aN9TXLRY0NeadKCx9FHcLgAnj6hQ4KPgr/Bek9SUqM6XUJ8
         8k03zGtMZCByIXQT7BJ4AP4ds+CaI6DaC0QiXkoK2O1xLl4oQv7o2KtYlKogMNO6n8wl
         6pCuyJNMTaEONYdG00ZMptPCzV1bPMcazDvtLu1wo1L+DPzrvaDmrrrOB7THCWrOoUXr
         LPXpwsUv2jqNdklp8DXCz/jVfn5O0U+m21lTBX8+Lsjyp69nZ5Fr1ikskyOh1wiqCAyf
         RV6p6a8jSme+EWIlzvAl0GFrd52H6K/aCG0Q1ywJRWYiCB2r+zLtmpszIl5ckIIPYsk8
         sh+Q==
X-Gm-Message-State: AOAM530khdovviyFVMR6nh3FKBi4SsLO8olz/t5Ry02dzICJVHh6ZQ4j
        V47vWqk1LlSVc46uQ7MzLL0=
X-Google-Smtp-Source: ABdhPJxWA4P8N/bNWAoB1x0gq19lP9ldu04shCHfVb5VehZL1zbiKEwQ7PTxFuJex88Wg8MCspCCMg==
X-Received: by 2002:a05:620a:10b5:: with SMTP id h21mr4395664qkk.261.1622813566628;
        Fri, 04 Jun 2021 06:32:46 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:46 -0700 (PDT)
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
Subject: [PATCH v7 5/6] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Fri,  4 Jun 2021 13:32:29 +0000
Message-Id: <20210604133230.983956-6-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604133230.983956-1-kw@linux.com>
References: <20210604133230.983956-1-kw@linux.com>
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

