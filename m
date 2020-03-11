Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4B18188B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCKMrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55544 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgCKMrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so1931644wmi.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6OCZpMX/zgjbiuYOZTv/yFn5g+Ml1pLP7pmNaB6uOk=;
        b=MjFUpxHpBskH8AZCa8gyvEeUFGWD8nE+I7Ccpw5x/EXEZNlkDfyhMtLIM9pIzDpMVv
         yv0WXrEyAyadtJ8laExtvI33SAK/Yj/XjyQUF33QkNa3LaJWSWjjXypqpRKmE99YyjLb
         Kzy38i8AKYH4slxDJSkaJhQqvJ0EyrgpZHy986v4LgMtDJY23CAifDPwM90WBTpJll1C
         aCNKlrXt1hD1ylm12EIODmL0J+kS46opQN5Wu90Eqk0d9OEv7vwJtW1G2hoWdmN9jEBN
         PsbTfgKubpyqXHQuVx5zuV7EXMF/qnMdkHydeM2T9wWjSBiZg5D3b6eUELp4nBntbfqe
         BObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6OCZpMX/zgjbiuYOZTv/yFn5g+Ml1pLP7pmNaB6uOk=;
        b=iZXIY/PRER2Ym/rTLwxO4LFhPH69tGyWRvm7C2R0baxME90fO/NGB3neE3vAFgcxDP
         Kex01+52E+2xu5py8Ndy1sG5bMKxqK5ZlJk6xgfc8i4Hf8h1ih1TQZCHWreEfzVbeGK5
         U0ZqG706EGovkenepafwfNY7BqDEct8u/Xvh8Tqbsu8nMxu/xTVP0bgCMIn/QpBvz/q5
         giDcqwu0cLZTPAxnm69QRQnQ1W874PYi/qYFhAXhFJZ3EVnDUnTkpmIQEhk9+dOI9Jea
         AQ2CLMJsD8EC8Ao022ubevfPvxgo+vkiWKGE267OHuLqXrl8rgcqr0w/SCuwT6hi8bFn
         TLfw==
X-Gm-Message-State: ANhLgQ0oj4wTk3J7D4pF2oOlnUlfoBOW0zG0MY2wdtONGiCr8r36spjG
        h5p5UUYzI1Fwo9mFwFAqkuKyxQ==
X-Google-Smtp-Source: ADFU+vtkHVanNQvPFzQ2zU8Odytq9w4wgEuuvipDqHybssyuXsKZkeB4j+7vEMafMywcklgaRLR7SA==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr3677774wmi.119.1583930820944;
        Wed, 11 Mar 2020 05:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:47:00 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 05/11] PCI/ATS: Gather checks into pci_ats_supported()
Date:   Wed, 11 Mar 2020 13:45:00 +0100
Message-Id: <20200311124506.208376-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMU drivers need to perform several tests when checking if a device
supports ATS.  Move them all into a new function that returns true when
a device and its host bridge support ATS.

Since pci_enable_ats() now calls pci_ats_supported(), the following
new checks are now common:
* whether a device is trusted.  Devices plugged into external-facing
  ports such as thunderbolt are untrusted.
* whether the host bridge supports ATS, which defaults to true unless
  the firmware description states that ATS isn't supported by the host
  bridge.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c       | 30 +++++++++++++++++++++++++++++-
 include/linux/pci-ats.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f2d8d1..bbfd0d42b8b9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,34 @@ void pci_ats_init(struct pci_dev *dev)
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
+	struct pci_host_bridge *bridge;
+
+	if (!dev->ats_cap)
+		return false;
+
+	if (dev->untrusted)
+		return false;
+
+	bridge = pci_find_host_bridge(dev->bus);
+	if (!bridge)
+		return false;
+
+	if (!bridge->ats_supported)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_ats_supported);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -42,7 +70,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	if (!dev->ats_cap)
+	if (!pci_ats_supported(dev))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
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
-- 
2.25.1

