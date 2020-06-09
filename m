Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5491F4124
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgFIQkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbgFIQj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515AC05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so23095978ejd.8
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6aOczayNfGEXaDTZxRmJje2jWJyimgY57ZW0JiHbas=;
        b=hxv07Nzce/gCZPhyb/n7XzzCX4LaR4u+l8bNVViKdCOFyi7Es4ZcLeYpEbAkLbLmje
         FBlVEj3bobpSkV4D0tyaX3r1+pKUTNtXu7s2siNmiWRnThC+3W/n4WNOp8dhOKjlI4cU
         1bkhYb19YaOrFhwWMlHslhOO0EAidxofVpprdluJRmmeRWhQbgo7m0fNeNNHjQs+X6id
         x6zV2wV6o4IMNoZc9Jzsz2UCozaKm7uY7FPi2lOD58IROH0Wc90M941U5izkyA7RGihw
         tTbl8KwZ/VB7M0oPVckD/gWykd7PnhsQR2nD69NEX/12Z/e8HhVJrknT6kLYSxlRveZc
         E08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6aOczayNfGEXaDTZxRmJje2jWJyimgY57ZW0JiHbas=;
        b=jxuuuwtBrsfveWwrGvQljA4hS0+LUUi85eaSfH+XTgE13bBuxEfXzh8w4BU8kh+5u5
         rfhh4UhWEW+VWOu/Qi/PzPPcHkZmXm0+yZlZvYiJeLcNDQWEVa8dlmr0M0WeOy517T3Y
         YixWlv4Gc29PSX7r4p7PQQJbIAm09Sr38tIkOdfi55ECkRijGuIs/kHCrHgWHzqZxjie
         /zcBe/e9tTtOcChqy9F8c+pnbLnOLhX+RKcew8Q1TttnJxMNOUibsnMtoc/8KWZUTfSL
         YddOZi/iMUEJEoHWwCW7FgB0c6JEZi4QD3UC0BIZTOCcFyIqcUvktwuFvPGAi11bM7sG
         z3yw==
X-Gm-Message-State: AOAM530+7KZzmwwC6572CGDPS88oIeELxita1eiKL6UPBy7LNXvgd662
        X/5I7YwQJoxe+FHt9bdynJ0=
X-Google-Smtp-Source: ABdhPJzlhaqqFBTZnIoy4e423oIZvbaSLlyyfEaA9kkUSIlObtqMbsWjkmbwi0k0TNJXL8wTRTUadw==
X-Received: by 2002:a17:906:e257:: with SMTP id gq23mr24967176ejb.398.1591720797792;
        Tue, 09 Jun 2020 09:39:57 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:57 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 7/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:49 +0200
Message-Id: <20200609153950.8346-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pci_disable_pcie_error_reporting() returns PCIBIOS_ error code which were
passed down the call heirarchy from pcie capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/pci/pcie/aer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 95d480a52078..53e2ecb64c72 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -365,11 +365,15 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int rc;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
-	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+	rc = pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
-- 
2.18.2

