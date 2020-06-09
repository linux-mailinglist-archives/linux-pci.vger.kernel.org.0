Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978681F4123
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgFIQj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbgFIQj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D66C05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d15so4403971edm.10
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sJgZ26pjbMZilbcKLqWWwX96iXERKkWruu1Viz6Y6lo=;
        b=fRjX4oo0D5HgH+EjyIFmy76jq8erdG7f4aNcTq0izcVH0gCtQAbR8uzZdKd15ozFjL
         ciyuBW6NahnGUzh3oOtQQ3yqWXixGla4S15GNBf1O5/fs8i+IWj3SBfAwiO+jZgxOGY3
         tdz5OkurD89pl+PCRv3VlNWVl/T3EZ51us66FZvr+Iqfc98w4P87Ffj85JB46859F1ar
         53+lUxrIEpzXVDUKG1bI3Hso/hqG0QcAfS4aLYmK6grEEFXr1DVtwPZkEbt2RCpSvC2q
         CzIg1fOKaGXJLjYqW8ImL+8ilnsbrucRBcDpF9xO1AM/KW3tNGZ0yu5i5gY5KpYS+/uM
         /D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sJgZ26pjbMZilbcKLqWWwX96iXERKkWruu1Viz6Y6lo=;
        b=hpOiHH/38J7dL44ZWmr/5TyQQEQ3rOEaJmZwuc6Hmyy0yrCMsTOBAZUvLdOEc5FqIT
         CkIQOlax+4+JcQXBYCPCmI/GIkyGDMIIcH2lcyc1DgsaB0RXwX3uHovDbWxkST2hGiLE
         qjQ6EGs3TR4WHum1wqD3uqyu/ZVYjRTnKfj9uQ/0ryOnVx0GW96EiWWE07DYPtBUNnH2
         eZtvy5j/g7IUzFDaBjclrWjyQrjulDQAxR+jMk1csJ87kr+OVP9lYYHYyBUemmMl2Xor
         9hW+tshck9kzqPy2LXPJ/QzkRptXsqv5f3wC4I40H/ctqiZKYbc0HhuT0yAdfbqmoj1w
         EeCw==
X-Gm-Message-State: AOAM533nl+SV3jFOQ0mfBqAoCzksh+FSLvGQ9zRST/gZAiFRSWpUM52l
        pWZsRDxcl6411EO4ZO4wBTI=
X-Google-Smtp-Source: ABdhPJw44GQF9xS8wFMa0kEdTebZ/qDRDYYKKeK40F1Ieqw7MIefDNiaF4z5d8p4n3E5QxkdkxmRrw==
X-Received: by 2002:a50:b2a1:: with SMTP id p30mr28485817edd.199.1591720796067;
        Tue, 09 Jun 2020 09:39:56 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:55 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 6/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:48 +0200
Message-Id: <20200609153950.8346-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pci_enable_pcie_error_reporting() return PCIBIOS_ error codes which were
passed on down the call heirarchy pcie capability accessors.

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
index f4274d301235..95d480a52078 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -349,13 +349,17 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int rc;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
 	if (!dev->aer_cap)
 		return -EIO;
 
-	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
-- 
2.18.2

