Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8A21C306
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGKHTf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGKHTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jul 2020 03:19:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FBC08C5DD;
        Sat, 11 Jul 2020 00:19:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so3530687pgb.6;
        Sat, 11 Jul 2020 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sbW3VeapkXBFXBROMSYLe02+5wxSAmivcwGBlvvNys=;
        b=QNzDaR01054tkyz/YJVqi/q9TFcxmfse+9weq2nlchNL13op2HWRPqDMSWwCkroAn3
         FD/DwkkfQAHAeqJIqKDP6/UnAjF7WpgYxNtjTPlMG38vmcMYd969ySf4saUQjpLc0hO+
         sp0BrkYLT7k6zkgb2dRqS4tYp9sbXBYN9E+6kdfhVG2IGDlS43BQqtrQks/pkMEv6zxc
         jMPP/hyIpjezO3GEWX9EHBq8T/8Z9xxz1QAkVz61sEvYNZA+5hWjSFPV3BnYr+EJZ1Mg
         7j7PPt1b1kPmPSzehKA54O3dv6hfd+RzHUqwa6rURaVkIpqitHJdxkTvbEadkrgKoIrs
         dwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sbW3VeapkXBFXBROMSYLe02+5wxSAmivcwGBlvvNys=;
        b=RVEnxRX1B9wPoGAH/7pmC9LYRgtpVxAqDZ2ZzEMZ9HW+Zfs+hUUpsh07IxcvOZV8r3
         MsDJuzjjJFqkTrjlSrC+s66iQPjI6tfIWntQx8jymUjM8zrLwxpNWNh5jYZKAirzb/nW
         0SiBPrZ03bPNb0wRtvo1NfArxLUzwR7+a/BkC/htnKWQMsJBg4j7slVlPCy/Z1PxZeRO
         ZDQ4zCDgWPqviYpa0bC4/AsGUzycyg7fbzAMe4AdV4fAWJ0O3CR9VENWaSiGbZNwJtIb
         MjSkYmrRy8hh/IcI7M/xgmAFimWFDwsf5fsnah1P9DA+iC3WE8lAqGjkUttZGcif9d+L
         ioiw==
X-Gm-Message-State: AOAM533Qb28BmKet3BTTc7yS4zTIje/aMVj1d45gW6UjssFC1N774EXl
        pHWVpHkkxhZN07hoIvUEfGY=
X-Google-Smtp-Source: ABdhPJyDPTLNEOM725IEvMGEGBOmqxXLlfjyzgmcNoEX0bcdL5ygp6VGfBDSyX0L4n5Q6P2EajYGqw==
X-Received: by 2002:aa7:8513:: with SMTP id v19mr57199394pfn.74.1594451974086;
        Sat, 11 Jul 2020 00:19:34 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id f3sm7574725pju.54.2020.07.11.00.19.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 00:19:33 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] PCI: Add more information when devm_request_mem_region() goes wrong
Date:   Sat, 11 Jul 2020 15:19:27 +0800
Message-Id: <20200711071927.3064-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add more information, the name of the resource will be printed when the
request memory region or remapping of configuration space fails in the
devm_request_mem_region() function.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b..81c1045a3fa8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4153,13 +4153,15 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 	name = res->name ?: dev_name(dev);
 
 	if (!devm_request_mem_region(dev, res->start, size, name)) {
-		dev_err(dev, "can't request region for resource %pR\n", res);
+		dev_err(dev, "can't request region for %s's resource %pR\n",
+			name, res);
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
 	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
 	if (!dest_ptr) {
-		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		dev_err(dev, "ioremap failed for %s's resource %pR\n",
+			name, res);
 		devm_release_mem_region(dev, res->start, size);
 		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
 	}
-- 
2.25.0

