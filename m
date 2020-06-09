Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1288E1F411F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgFIQjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A0C05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so23148566ejc.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6UEOEm/EvDhHHYzuc2E1g3P+sP/EaHhjUwuf0sBpPMk=;
        b=eGpNatfg0JovbusoP5dUVK0AVY1O/HoTV3fAGotU3XwGFxr6v/6E9ebbsf9xD1c7BI
         m+YnH4hG1wj8vy57MiJJ7RlD60i5D3UoXAdcU84o3Gs3h7eiBQkfWh8zDOcEP130aZwH
         R+a445jsdG3dFjFxq5gzYSoZqc71qIIiIpiJlkrOuJbmU7O1QNjIgDNbYgmpe2t/wu7p
         fuNXsfhHgiyojyKR5pOLvpoanuTLa0HCegnkR3RT/R2uNVI7TvMoK6+KsKPYIuuvZh/q
         ReMVgD1mQtd5tW+/yJ2/zB/xV5tJ1cSO+MfQh26sdpeKiZO7rKg8KRB7EaAvT1d18Do7
         moGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6UEOEm/EvDhHHYzuc2E1g3P+sP/EaHhjUwuf0sBpPMk=;
        b=OmVoiyIHYvPrKSAP1EvsugcqKmKl40jCAffsMWFzSWhGU/bgMbMwIFj4zDARWaOs7a
         PonL6HKDUkx8htHKv3Myq7S3UIcbkhCZFbbLB37VZI2aOB5rRaUlv72oxk51y06AtnrJ
         n6E4TupasueBwNvU9Kxs8REHrgbqXGzJydv1UbEbG3yZQvNKxKMIOapgG7KexULf6LSm
         IiIZI6mhGWV5oUlAHVIiq3fajpndp8TeK+tYFASr4xuxDDiybUJp5z81LWSsvdp4JBiR
         8mtPxYGQsiSw+kCN8h/RinnNEnT4+CblFgjvPUcaHhBnGQkDNTbO8W3qEzJ576/l7LBz
         dLHg==
X-Gm-Message-State: AOAM532Pf3VVr2j11/effGFLC+2L+4C35f5bfoDEtRFjraDfBlvU40No
        6LjDAGlK1Bcs1DKZiUJoJ44=
X-Google-Smtp-Source: ABdhPJy2PpqvwfpsJIurcvXjXjS9Qi0CVSc/qGSUeMFWhbn9ZQKy8LJFiYbQ/afBS65n108VlOl4tA==
X-Received: by 2002:a17:906:e2d5:: with SMTP id gr21mr25418133ejb.219.1591720790485;
        Tue, 09 Jun 2020 09:39:50 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:49 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 3/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:45 +0200
Message-Id: <20200609153950.8346-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

restore_pci_variables() and save_pci_variables() return PCIBIOS_ error
codes from pcie capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index eb53781d0c6a..eb2790e9db36 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -334,7 +334,11 @@ int pcie_speeds(struct hfi1_devdata *dd)
 	return 0;
 }
 
-/* restore command and BARs after a reset has wiped them out */
+/**
+ * restore command and BARs after a reset has wiped them out
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
 int restore_pci_variables(struct hfi1_devdata *dd)
 {
 	int ret = 0;
@@ -386,10 +390,14 @@ int restore_pci_variables(struct hfi1_devdata *dd)
 
 error:
 	dd_dev_err(dd, "Unable to write to PCI config\n");
-	return ret;
+	return pcibios_err_to_errno(ret);
 }
 
-/* Save BARs and command to rewrite after device reset */
+/**
+ * Save BARs and command to rewrite after device reset
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
 int save_pci_variables(struct hfi1_devdata *dd)
 {
 	int ret = 0;
@@ -441,7 +449,7 @@ int save_pci_variables(struct hfi1_devdata *dd)
 
 error:
 	dd_dev_err(dd, "Unable to read from PCI config\n");
-	return ret;
+	return pcibios_err_to_errno(ret);
 }
 
 /*
-- 
2.18.2

