Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ABC16AC7B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBXQ7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51751 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgBXQ7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so55275wmi.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
        b=RRx8U11vMPRTlGnIGn4sCB8SnlGdKWqavfSqD6SR8YQbgWxZkfH48PSJ+5CDfsbk5S
         Ze+3wOWEkqnI8YBqOFSDJz5FBNrpacYvYZgTsDkmdA5n4wlRZVjddXIXMc1Swc0FusDG
         ID0exI27uMOdvgwnrKyEkHPZhPAkCE5/JcqFqErWtxLy03ZXcHvBaYquM+8n9pZzbnmf
         JF5yKMQAnnlPwCUdQ417vEY8sBmXYM2Du+VPCiVVgh3ewo9JEWYEU99AdEfFfMi7eRqo
         Nb3D2kPURsTnpbcyeQ1NnVKVHrxjKbWjHpk2O3LengMczoRsjyCdMZXBKdW27vABPch/
         uALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffFCJH69MWS3gu5TdGiWJyiqlV+lu2ttPiLstT+myYY=;
        b=AYVDyYZErg4M2W/NOsSm8zJ3JSAbaoseVqAueRgx+iI4iBAYrOXREwldOFDHJ2earK
         392Hb+GGLCcuD7CafoDJUb6/ow0hOyGIXloVOtMNs/YALe/fz4MBxhIPLJ2Tsf/ide6q
         c5r8vmm7txocR1EdKJZWKfSv3RbIgkKHZhCy0DxdNipJQwT7iCNjcN6ooujjUCNNt1kB
         TcQUHFmnmXW2yz1khsDJVMFk5cljeBFUXwcHW1CuJD29rZ7KE7pmfDA8APEcC2hKsKJt
         Oid4XUdq11K1ueqGlLh0kJxZX/ptGD8YzMdC9O0VRXMZYhOtVeqn+uc+fkTJJLbpyn6V
         USGw==
X-Gm-Message-State: APjAAAVqwqejFhMDp+76PBPl+fop81FDgdUGMIWaHq5PnC945DUPBlgd
        wgUUiAqMg2CP4BAyEpxD00bOdB1R0tg=
X-Google-Smtp-Source: APXvYqzuI5JL7DJSxxC2MA8748RGx58CDQkzuT+eunhF/IfX/BLY+BsUCaKxLYTvlGXreVTEpIeERg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr23887005wmi.51.1582563543020;
        Mon, 24 Feb 2020 08:59:03 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:02 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 1/6] PCI/ATS: Export symbols of PASID functions
Date:   Mon, 24 Feb 2020 17:58:41 +0100
Message-Id: <20200224165846.345993-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
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

