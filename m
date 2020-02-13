Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3202915BC6E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgBMKOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:14:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37875 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgBMKOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:14:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so5921065wru.4
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
        b=VOc/AgqCKj2uTb+3PxiP+vBussxkp9Xnkbwfwzzx43saT/PGOSRy1wb3R9u4IgsK4H
         QgtZXTOA8HRdd+QcPOE+4QaCBUzelwLymRIyf4YS4nbzZy999MRyw3Gmdb9+lqXo9o+x
         cSvl76aBS1KTII8O9Sjj1wtfsi3eqx84csvK9F4ALVE3r1MwmAJ7UnQYUyo+qXg44Ck7
         Rzm3M0YkppAGyWJDQjiKghiJpi3EopMafcdcxQQf7qBr5Su45pBtfRQMKyfT/Y3eL+ox
         drtFFFENjIz5kvdy+A9naZ5w8nxw6A1hFcgvMhUgOOBUMShrobEgffwcpxdcOXCLIE+l
         rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
        b=NEBPuBASjAC60252fK3Wwu+ZIrddCan9yZIgsssmQ4C60MQz4VlTCggZKf16+onLF9
         P45fR8hUcnIovO6f4/ypmSVnpO6N97EuBxFuMZuyTiFe7LnjgXaZnlCOZz6KY/bR7fjz
         1ATadOeaLWl8qhr+jHpmqP8tEWEIGabW2cIqKaeMDamAZagsurfArHGhYx7nEWvWUvNi
         p0Irg/2RAOH2tLNMJ9rVVJ6wRQUMMRGWppMErP+thOJP2caT+oGx4HAS/brZwW1bWBv5
         AmSqaDhd2Mx81gMnLIJmjVQXdr4YS2Kg+8wK57eorgbAgMjzx75HY+YHItNZ52/LF6x8
         SvXg==
X-Gm-Message-State: APjAAAXslyNNvgilgqQf50R2xwW2ZEgdrEQru8rZ31xVZ8YoU+tPMufy
        bNmnt3HSyDfKhmgJhGj/8BGet2eG6yA=
X-Google-Smtp-Source: APXvYqyGI8je5B1PaESIUTiNN6WwNtME2/884yAwDWfvmieJ+C+jPQfGseYc8+Y0Ju3V7vGv/sHu1Q==
X-Received: by 2002:adf:b193:: with SMTP id q19mr20678957wra.78.1581588885058;
        Thu, 13 Feb 2020 02:14:45 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:14:44 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH 1/4] PCI/ATS: Export symbols of PASID functions
Date:   Thu, 13 Feb 2020 11:14:32 +0100
Message-Id: <20200213101435.229932-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Arm SMMUv3 driver uses pci_{enable,disable}_pasid() and related
functions.  Export them to allow the driver to be built as a module.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 3ef0bb281e7c..390e92f2d8d1 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -366,6 +366,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pasid);
 
 /**
  * pci_disable_pasid - Disable the PASID capability
@@ -390,6 +391,7 @@ void pci_disable_pasid(struct pci_dev *pdev)
 
 	pdev->pasid_enabled = 0;
 }
+EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
 /**
  * pci_restore_pasid_state - Restore PASID capabilities
@@ -441,6 +443,7 @@ int pci_pasid_features(struct pci_dev *pdev)
 
 	return supported;
 }
+EXPORT_SYMBOL_GPL(pci_pasid_features);
 
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
@@ -469,4 +472,5 @@ int pci_max_pasids(struct pci_dev *pdev)
 
 	return (1 << supported);
 }
+EXPORT_SYMBOL_GPL(pci_max_pasids);
 #endif /* CONFIG_PCI_PASID */
-- 
2.25.0

