Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7D33687E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhCKARm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:42 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:37308 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCKARa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:30 -0500
Received: by mail-lf1-f50.google.com with SMTP id n16so36746377lfb.4
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bbc+ydK9EZPctjxOlQsxWSvwLOSFn01mGILhtLZh9mI=;
        b=VVkv1mif9wBGKXZzbgnBrEud5/sk1YMoR5woXMIIhgBVJjfwDgMDIEE+amW3zE1fXd
         kJQUNxb7X4Dj9kx0/su8IP1rwXW6dhwn7JnqpXxNsY1ApcwKFFu68AqX1yhP47NTMyB+
         GHofOcZPD2uSE23+ILsVPJq8gDhFw+0pxcIXwfZAPXqpgUijuWuUf5+Oalp/00m1u/zM
         mfEcFYPT/xVQQswEZWN+Gi+9mfT02tKoK7BH2/7APQ7fXFIEl3lRsBOs0MbjkIhPaFIC
         0WPzlbVTSDYVUMGGGKxq4VrOA76APBCeRPJ3UyfXjxFZAFbm9PS+S3V5btAbjfan73KE
         xDDg==
X-Gm-Message-State: AOAM532aLi807lSTeu1HHVJOkqJshCF6bPXySPBYsquc8bJ+TuBTLDpY
        8c5LZEpkCfg3lWNsz0piyrA=
X-Google-Smtp-Source: ABdhPJzB1gI1w74Ik1n1aZ4AJjXkWt7Z6Annezky4amWi1L2AUpS3kYdPAAAZlEef7zPaZT3orPIKg==
X-Received: by 2002:a19:ee13:: with SMTP id g19mr623166lfb.657.1615421849534;
        Wed, 10 Mar 2021 16:17:29 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:29 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 4/8] PCI/ATS: Update function name in the kernel-doc
Date:   Thu, 11 Mar 2021 00:17:20 +0000
Message-Id: <20210311001724.423356-4-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update function name in the kernel-doc to match function prototype for
function pci_max_pasids(), and resolve build time warning related to
kernel-doc:

  drivers/pci/ats.c:490: warning: expecting prototype for
  pci_max_pasid(). Prototype was for pci_max_pasids() instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/ats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0d3719407b8b..6d7d64939f82 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -480,7 +480,7 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
- * pci_max_pasid - Get maximum number of PASIDs supported by device
+ * pci_max_pasids - Get maximum number of PASIDs supported by device
  * @pdev: PCI device structure
  *
  * Returns negative value when PASID capability is not present.
-- 
2.30.1

