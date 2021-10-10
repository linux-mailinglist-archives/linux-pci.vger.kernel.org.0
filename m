Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04198428107
	for <lists+linux-pci@lfdr.de>; Sun, 10 Oct 2021 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhJJMBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Oct 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhJJMBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Oct 2021 08:01:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEACC06161C
        for <linux-pci@vger.kernel.org>; Sun, 10 Oct 2021 04:59:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q19so11855304pfl.4
        for <linux-pci@vger.kernel.org>; Sun, 10 Oct 2021 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ODEs4Dag8ER9NsVAeIVmCJUF6iNzYSfT1e/j9njNDg=;
        b=mfSZb0Xy6jqQ6Qhb3UgeT/t2+5lrao1x3SqKw7TDNCeCd3rI+l+qi6iqOUtYiCmjRo
         JD0NiI1uglyLleKYFmcBgCpdI1B2/cSnv//qgaF25FGZiHGes2+RXw6Q0dOQDoxXv/LA
         Y/2nDbgBVH02SEBsDXOKBtUY3BxXdFycbzyWGDoxz5KsroqGrow6bUYfzHOx0JcQ1hhC
         9fuyHGrKPQtPFGUlZZdmyPhWHagIclPJYacOUOdoGoAjaH33kfWLrbErrdSZefhZZ2yK
         YW1XEZKh770fqjpzMecUDfyUyBQTglgCL7Q0ua0us8xnxQEOH7UmyQUJfVjudFzbclL+
         H6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ODEs4Dag8ER9NsVAeIVmCJUF6iNzYSfT1e/j9njNDg=;
        b=6VKwJMFs6nfT9D61hBcbg4U9HrUNgBiuoscyJ023CKKZwooZCPALwawCNndaQiecfc
         +ncxjOJFmKvX3Vy6f+mceEn8CC5lIWTWHPwPgnvzhkuJMxIKUWkuTytmMUEOfiQmh/18
         F8SrS0NJG6ogXfkP3cpQbhAJ8b+h5tHp1amDyCi7+lj5h75tRrhnuLp6t///qWVgr6wa
         JCZsXGLoU4u5OWjlJlvTwyxKNK/Clhpx0vsYsaMnWBiTNh4rXPS01vPqDvGHNfpZqiGG
         2W+d8yZi37z7pTOx6xxFNERF04d5G2ZdS23KW4E2SXZGq4WshUZhOZd7963GCuAMd9t9
         ssOA==
X-Gm-Message-State: AOAM532Y4IZ6VuNRWmVPtMZurShi+kWjZl3CqOgTnYdOKafOhCeCXIFI
        qodHumOAyWDJsEHSLh47uu4/
X-Google-Smtp-Source: ABdhPJyOFXzSYpHRvEB/uZUJpFqnwbDlVXJK88cvets5NG5muipfEHD61VQr1c2q5rhFzefB/Xl4/Q==
X-Received: by 2002:a62:27c7:0:b0:44d:b86:54f2 with SMTP id n190-20020a6227c7000000b0044d0b8654f2mr3095707pfn.68.1633867185517;
        Sun, 10 Oct 2021 04:59:45 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.21])
        by smtp.gmail.com with ESMTPSA id nn14sm4659235pjb.27.2021.10.10.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 04:59:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: endpoint: Export symbols for endpoint controller drivers
Date:   Sun, 10 Oct 2021 17:29:37 +0530
Message-Id: <20211010115937.15856-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use EXPORT_SYMBOL_GPL for functions such as dw_pcie_ep_reset_bar,
dw_pcie_ep_raise_legacy_irq and dw_pcie_ep_raise_msi_irq for using with
endpoint controller drivers built as modules.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 998b698f4085..0eda8236c125 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -83,6 +83,7 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	for (func_no = 0; func_no < funcs; func_no++)
 		__dw_pcie_ep_reset_bar(pci, func_no, bar, 0);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
@@ -485,6 +486,7 @@ int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
 
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
@@ -536,6 +538,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msi_irq);
 
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num)
-- 
2.25.1

