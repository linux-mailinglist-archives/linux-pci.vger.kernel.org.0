Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2743422F16
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhJERX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhJERXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:23:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A0C061749;
        Tue,  5 Oct 2021 10:21:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q201so7757707pgq.12;
        Tue, 05 Oct 2021 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KHMqaM1V3DuTRnE2HWYRtLECuoot+YO1EBfUwWqTQQ=;
        b=psgJCp6X1yB83VVSO7eBoBiGgR2hLAh9hXsh/pvHeYNpO9ILUMqx8zmygPefPR++LN
         37nY1zg6A1xjUPlJ4ST/RxSfmI6+pYI1rVL23SNpOWJ8ThgLh+AiKfCRzcmNb/5SEFMx
         nSe55aFdaSygqdPMdu6mDZHknajlF/MtETA9yH6qhuAcmxm36cLFcFxVIOjmAs9lKvkb
         XdzLP5cPIFdFqOdbM+QP4834U/fjH2M0vu9VcBmH/8OHg7Ut4gsuW9gxQrWE55B5C41D
         LeKDmyRn1H3w/vD45HFVJRREhj+Rjv1xDZuqXwzx9K8xKV8DvlIMt+PrL2yhw8rmApiH
         LqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KHMqaM1V3DuTRnE2HWYRtLECuoot+YO1EBfUwWqTQQ=;
        b=j/+7EcKKYus58UEz4DTWY4Ti/03pLGdwZW5EGZ+OmXOZcff11f+js5cmSxyXHKFE1a
         tFbh6Zc+agbvnV/qtHF8Elb4ATp1Y0fMxyR84KKMXyoU9zBvPtT+oXl9bbsjWNfKy4Od
         YaobIP36Isew6dbbcpPfh+xwjMUxZdFiTkWdi5Fao4IhYANIf/AFNQg2/GQFeA8KN32M
         GdQm2RFn+YrlporVcq7l34fIe6PagR7ApvRayZtcy1b2udUJIGd/CSDduK6ia9hUNoe2
         DXLiFjRGlJ1jLGYH0RpzeUBKdMmLjJ3+tBGm81S37djUsI65qvWLvjXnnx+I48wiuQzw
         crAQ==
X-Gm-Message-State: AOAM530GZDYzAtFcHS1a9rs55kRvLUoa0OgcbZUP8MOvfeuir/prDHTn
        JogOYja8injXuwuW97Ouv48=
X-Google-Smtp-Source: ABdhPJyXbn7O+swbM9D8yH4827BLXqU74mQatvY986DG0V0KKiyfLQiRw50GqimEA4wIGTeafWQ/3g==
X-Received: by 2002:aa7:9e9a:0:b0:447:a1be:ee48 with SMTP id p26-20020aa79e9a000000b00447a1beee48mr32003271pfq.48.1633454492516;
        Tue, 05 Oct 2021 10:21:32 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:21:32 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 8/8] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Tue,  5 Oct 2021 22:48:16 +0530
Message-Id: <18cad894ac3210af806104b3b4fa6a8cf1554ac8.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print the contents of Device Control Register of the device which
detected the error. This might help in faster error diagnosis.

Sample output from dummy error injected by aer-inject:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000, devctl=0x000f <-- devctl added to the error log
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eb88d8bfeaf7..48ed7f91113b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -437,6 +437,8 @@ struct aer_err_info {
 	u32 status;		/* COR/UNCOR Error Status */
 	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
+
+	u16 devctl;
 };
 
 /* Preliminary AER error information processed from Root port */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d3937f5384e4..fdeef9deb016 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -729,8 +729,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x, devctl=%#06x\n",
+		   dev->vendor, dev->device, info->status, info->mask, info->devctl);
 
 	__aer_print_error(dev, info);
 
@@ -1083,6 +1083,12 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	if (!aer)
 		return 0;
 
+	/*
+	 * Cache the value of Device Control Register now, because later the
+	 * device might not be available
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &info->devctl);
+
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 			&info->status);
-- 
2.25.1

