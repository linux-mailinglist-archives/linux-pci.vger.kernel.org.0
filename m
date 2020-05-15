Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407611D4B52
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEOKsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgEOKsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:48:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B25C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so2141969wmc.2
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MESJTjk++c2lj6OjtUD3TbcX3ekoiLAlqLoQdQYenvk=;
        b=d8QewLSvnJpTn6f8rKB+iC7zL5g4c4zD4gf9Y5c58fo+EWwMkk3YHySYd9hhSQj+R5
         FtRM7iGqWUoDtBI3d64vkhP3ewTf0dPfnHlNzG1spLfWpiC6bh53mz+VswdP4TIl6iK/
         IAy+POK20EjpGebSxDJFa8vAl12orzLTbfozqcFuR8eQDkbwT0Jw4Yjn4tVR+qDkqyh7
         F2xJxcunlRjjcDBXrBsRGayTerKPqgLZn9JGXj0rsSf/599MitB9ROn5P6u02Jw3P7DY
         klaJCMzuR+677XbhASvrvRdqWHRaKKiH9YxoXbqAtFlvxCeNXzudfnXqKjWk659I3pc4
         KUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MESJTjk++c2lj6OjtUD3TbcX3ekoiLAlqLoQdQYenvk=;
        b=gFvPzW1wf/EFz2hRO3vNMUMgrpmvVJkOuFC2KMJNt/qpC1JXILeskdyKHDSCbBVTZP
         spoUi9VRtvhW05p+yBy7E7EYJUKuYZDnUUYtfVXbu/EO//mBuWdLWs/uY5BHexrOVnCz
         x+X98iAxiAuSqN24ekZjOmeqHqvGY0dTTxBsrwCxa1g6DSU3C9JFRhPVIcPFX1NR5Pcg
         e3Feh/lRwt8uN2ijVUkf8UyOrmQCekrOiNAUaRVhyvi4YvTURxUkBJF3y+9ezu6k725H
         sv26t7vG8tqstggIs3pqhm9UGD85fFQBdzh8qPFp1lg7eL3+7XmXsLitOKcZbMa1wS8m
         OqEQ==
X-Gm-Message-State: AOAM532vvK2mGVqP6vZdWY6GkWS8u5kGLt/0el1tiF275ifJXV77XqD8
        hWQEx9rWxRcBK+5c+MphaiDHfjeuwb0=
X-Google-Smtp-Source: ABdhPJxoIQKh0Dl64xNJbAfP1xeyXsKEMQXWWN7NWj2VTSJfKf04HR+XDlR3TmJZkICfK6ATTtGKnA==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr3356941wml.128.1589539709090;
        Fri, 15 May 2020 03:48:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:48:28 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 1/4] PCI/ATS: Only enable ATS for trusted devices
Date:   Fri, 15 May 2020 12:43:59 +0200
Message-Id: <20200515104359.1178606-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_ats_supported(), which checks whether a device has an ATS
capability, and whether it is trusted.  A device is untrusted if it is
plugged into an external-facing port such as Thunderbolt and could be
spoof an existing device to exploit weaknesses in the IOMMU
configuration.  PCIe ATS is one such weaknesses since it allows
endpoints to cache IOMMU translations and emit transactions with
'Translated' Address Type (10b) that partially bypass the IOMMU
translation.

The SMMUv3 and VT-d IOMMU drivers already disallow ATS and transactions
with 'Translated' Address Type for untrusted devices.  Add the check to
pci_enable_ats() to let other drivers (AMD IOMMU for now) benefit from
it.

By checking ats_cap, the pci_ats_supported() helper also returns whether
ATS was globally disabled with pci=noats, and could later include more
things, for example whether the whole PCIe hierarchy down to the
endpoint supports ATS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h |  3 +++
 drivers/pci/ats.c       | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d08f0869f1213e..f75c307f346de9 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -6,11 +6,14 @@
 
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
+bool pci_ats_supported(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
+static inline bool pci_ats_supported(struct pci_dev *d)
+{ return false; }
 static inline int pci_enable_ats(struct pci_dev *d, int ps)
 { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f2d8d1fc..15fa0c37fd8e44 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,22 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 }
 
+/**
+ * pci_ats_supported - check if the device can use ATS
+ * @dev: the PCI device
+ *
+ * Returns true if the device supports ATS and is allowed to use it, false
+ * otherwise.
+ */
+bool pci_ats_supported(struct pci_dev *dev)
+{
+	if (!dev->ats_cap)
+		return false;
+
+	return !dev->untrusted;
+}
+EXPORT_SYMBOL_GPL(pci_ats_supported);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -42,7 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	if (!dev->ats_cap)
+	if (!pci_ats_supported(dev))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.26.2

