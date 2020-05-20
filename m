Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22B1DB83E
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETPcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETPcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 11:32:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11FC061A0E
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so3647930wru.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMxSMp60RacutPPMRaTffGs/D3V+C6gcqSQh+60H4IM=;
        b=s4chTh4JDFjbN2gqTRyrB+FE+s9+8i/0fB88Bt2AOPHvQMpAM3GB80MGZAQGL2ZCJv
         wVV9P/kDEfZ4WBc+8nhHBecNu9A29ZysYDr+A6Y4pCFeSlbZnFi0Y9/Uya6DGUhNzXBb
         fj7Gj+i+ysvDh8pI+MeuBS7P/a031XQyCRHuY4E1U5BP/sKHh5sNVhl62x7S/n4YjnRp
         NNNnHpXJFlTghwMx0xG/JTXZ7fLa2Xt+eCqlfBrECBYpl0V8/pRRiWI/uy8q/MDWyT/i
         ylLzb/aNWYL0HaNX4GsQS6tqKBmhcqfE6HQ1vdqMPCLpXXMkFHWc/475lw5KY1I9m+tW
         T72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMxSMp60RacutPPMRaTffGs/D3V+C6gcqSQh+60H4IM=;
        b=ISfY/wGNeKXKEZ70hIr4q6fMhep4De7v2QDME3D/DK1+mdmXhDCveDPqJK46nS59Q6
         mI8E/8krwBfRDdx8OqdCBkkAhNNY3eRhuLuKjoV759L58oOeCPcUqmzhtoW1bblsn5JV
         1SfYCwVNkUYa06QQILdUhnAd9Yj7FWg34oNg6hPwDkUgwUAB94miHa+kLZ+Yr+iPJDTa
         qlnhZSfCJzpklahX0e5FU4I5agoqrTuWSW/g93tpNaiv4qGr5XDXzcqhNWuHb2Yldwgq
         wuX8ACn45UHam4mLlh3IVSLXnThl9uw7i9aJSMf/tr+Z8zszO1cO0sORtFwT4OYwF2Rp
         eF3g==
X-Gm-Message-State: AOAM533edqOnLStxip8MNB8wp3A3pL/oMA4UbiyVYMDhuAaUtmfd1p8u
        4VZ7N8dOdhQuWhoyt1yh7dpPmwcmgAI=
X-Google-Smtp-Source: ABdhPJwJ12nN9Fkxr6qovPQcMT+RAZ4bBWm0IKZ4hW0qiE5gXWSsj2Yy/ihMe7U9E4fOI73l+IQpXw==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr4535997wrp.82.1589988767748;
        Wed, 20 May 2020 08:32:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:32:47 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 1/4] PCI/ATS: Only enable ATS for trusted devices
Date:   Wed, 20 May 2020 17:22:00 +0200
Message-Id: <20200520152201.3309416-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_ats_supported(), which checks whether a device has an ATS
capability, and whether it is trusted.  A device is untrusted if it is
plugged into an external-facing port such as Thunderbolt and could be
spoofing an existing device to exploit weaknesses in the IOMMU
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h |  3 +++
 drivers/pci/ats.c       | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d08f0869f121..f75c307f346d 100644
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
index 390e92f2d8d1..b761c1f72f67 100644
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
+	return (dev->untrusted == 0);
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

