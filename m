Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693483936F2
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhE0USb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 16:18:31 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42903 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhE0USb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 16:18:31 -0400
Received: by mail-ed1-f51.google.com with SMTP id i13so2261207edb.9
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 13:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/st0sFmsXOpZGoSh9wD/JiyAC23weDhXwl9Pw3hHUTA=;
        b=T5Ng485s4jwzwDgi77aSQJBxaZyeOKpSPLEUrtcib2muw1k+MCanUfYppVpU3P/g86
         +gsMnXPHCdVyJIoNHt8ehvPdAVVix+H3EEZk28F/7EUyhO2Hdqvp6ni7b6OqmNnabzPK
         Cq/0XhVq7soO7RaXd1zcMmOsciWRsAN3WymA+qH6JDO6wsiqyiEuNJdbXh1qeSCjp/WP
         VKxypFFMF1T4GQdkXQEC78IOxC+DcFnRM2KcxqrN52/XoueJam9Co1zqzeFmn3K8Zo7s
         DjNpDwR2MKZplo/Ycqp2KnlW9VW+qSfQmu+7cWM+wv8E4tHLg79KvK5n17ohi7kZhJb7
         pu0Q==
X-Gm-Message-State: AOAM533pASNo+pwAT5tnYqJk0onszba2HTcfYhbZPXj9MuS6XnQX+YBb
        5gqRDVUQB3xMwZFak35rZ48=
X-Google-Smtp-Source: ABdhPJxG4aP0NsF0Uu38wa6xJMjIPm5Y+j6YOEsyTtVwRyVPlCqQ2YO4XR9VRFaktxaihUkVS40jKQ==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr6261462eds.310.1622146617099;
        Thu, 27 May 2021 13:16:57 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o64sm492739eda.83.2021.05.27.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:16:56 -0700 (PDT)
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
Subject: [PATCH v5 5/5] PCI/sysfs: Only show value when driver_override is not NULL
Date:   Thu, 27 May 2021 20:16:50 +0000
Message-Id: <20210527201650.221944-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201650.221944-1-kw@linux.com>
References: <20210527201650.221944-1-kw@linux.com>
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
Changes in v5:
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

