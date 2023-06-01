Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223171A144
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjFAO5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjFAO5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:57:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D45107
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:57:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b02497f4cfso4664915ad.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631466; x=1688223466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwXI2MDftw2Rb8IrxQ8Wa3XnLpiqiT4qkX9vMeeuaOg=;
        b=qCxSGlDhKuHPMocONEKYKTJVyvkw81O0E8n/J4bcpGCfvmcgsCGJ6K7dgziu6h/VRR
         kyaY/LxcFPfl8iJJ/kxBnHho5Ute1QpVMqpRXbvoqgWs+uShqv4UYIpunxQVORQ5sazl
         B+08nHBM6vSQH36UaUuScoPnWNhZHBHY0+1A5GtRwSkBEzJCw3O9eX08LG/86DwzVXrQ
         Cm9tl0gZYu7ek9j9TS/EdHLMNiwFJqb7NutuJl0om4Pfw56d9Whruvbf5CLwdFv/IVJ4
         6wAGGt9a6nfOtUPmXZWk/FZtoYhTeLtsYBx/qJGl475eWpm5N4a3AUeHmwKHZ4vWtvHb
         XxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631466; x=1688223466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwXI2MDftw2Rb8IrxQ8Wa3XnLpiqiT4qkX9vMeeuaOg=;
        b=GIcKthYQ85kwT1gGc6iu+7pgETUln0nPsC/lxFNnl5Xc1RsNu82eCnnmX99xBc5VmM
         K/mgZ55e62K6PoqC8gvC5oymwverL+VJe0F3anOtHjYsBYzlNJ1E9PmPNUJh545pgnCF
         Z/8wHAkMmTPDUd8rwxoll7bwJ8LElvsrqYnlH2F7h3q5X7QsZTTovPs7hXpJLJS31HcU
         6JknWBH3Ng4C1BFlTyctrzZK9qI09cDQ97MB4sogHTtGB8FXdURZE6qRvXtI/NKY4nYc
         NkAeAvKErAQ/2LBAjiv6qVK709vqb01DNbZxwFtLjrHqpRINGaFcbY3nJsWXu5i/vchF
         uUEQ==
X-Gm-Message-State: AC+VfDxgoVqaRpGNbE+qwPPYglahhDmFckvxcLMH4c2YvZmjbqQCvuRz
        FLdRqj0J4Y8NjZ1LZ/JYhvIq
X-Google-Smtp-Source: ACHHUZ53JkAFRZzMV27qvkJhUb0e/URcEsue7ujGAskjiLOCPZlMsJhxlykhjaU9lMmyEL+8deK+6g==
X-Received: by 2002:a17:902:a417:b0:1b0:6c3:e851 with SMTP id p23-20020a170902a41700b001b006c3e851mr5755992plq.18.1685631466681;
        Thu, 01 Jun 2023 07:57:46 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 3/9] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Thu,  1 Jun 2023 20:27:12 +0530
Message-Id: <20230601145718.12204-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the EPF probe function doesn't get the device ID argument needed
to correctly identify the device table ID of the EPF device.

When multiple entries are added to the "struct pci_epf_device_id" table,
the probe function needs to identify the correct one. This is achieved by
modifying the pci_epf_match_id() function to return the match ID pointer
and passing it to the driver's probe function.

pci_epf_device_match() function can return bool based on the return value
of pci_epf_match_id().

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
 drivers/pci/endpoint/pci-epf-core.c           | 20 ++++++++++++-------
 include/linux/pci-epf.h                       |  4 +++-
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9a00448c7e61..980b4ecf19a2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2075,11 +2075,12 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 /**
  * epf_ntb_probe() - Probe NTB function driver
  * @epf: NTB endpoint function device
+ * @id: NTB endpoint function device ID
  *
  * Probe NTB function driver when endpoint function bus detects a NTB
  * endpoint function.
  */
-static int epf_ntb_probe(struct pci_epf *epf)
+static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..d5fcc78a5b73 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -980,7 +980,7 @@ static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{},
 };
 
-static int pci_epf_test_probe(struct pci_epf *epf)
+static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b7c7a8af99f4..122eb7a12028 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1401,7 +1401,7 @@ static struct pci_epf_ops epf_ntb_ops = {
  *
  * Returns: Zero for success, or an error code in case of failure
  */
-static int epf_ntb_probe(struct pci_epf *epf)
+static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2036e38be093..7307e052136f 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -493,16 +493,16 @@ static const struct device_type pci_epf_type = {
 	.release	= pci_epf_dev_release,
 };
 
-static int
-pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
+static const struct pci_epf_device_id
+*pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
 {
 	while (id->name[0]) {
 		if (strcmp(epf->name, id->name) == 0)
-			return true;
+			return id;
 		id++;
 	}
 
-	return false;
+	return NULL;
 }
 
 static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
@@ -510,8 +510,12 @@ static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
 	struct pci_epf *epf = to_pci_epf(dev);
 	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
 
-	if (driver->id_table)
-		return pci_epf_match_id(driver->id_table, epf);
+	if (driver->id_table) {
+		if (pci_epf_match_id(driver->id_table, epf))
+			return true;
+		else
+			return false;
+	}
 
 	return !strcmp(epf->name, drv->name);
 }
@@ -520,13 +524,15 @@ static int pci_epf_device_probe(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
 	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
+	const struct pci_epf_device_id *id;
 
 	if (!driver->probe)
 		return -ENODEV;
 
 	epf->driver = driver;
+	id = pci_epf_match_id(driver->id_table, epf);
 
-	return driver->probe(epf);
+	return driver->probe(epf, id);
 }
 
 static void pci_epf_device_remove(struct device *dev)
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index a215dc8ce693..bc613f0df7e3 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -89,7 +89,7 @@ struct pci_epc_event_ops {
  * @id_table: identifies EPF devices for probing
  */
 struct pci_epf_driver {
-	int	(*probe)(struct pci_epf *epf);
+	int	(*probe)(struct pci_epf *epf, const struct pci_epf_device_id *id);
 	void	(*remove)(struct pci_epf *epf);
 
 	struct device_driver	driver;
@@ -131,6 +131,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @epf_pf: the physical EPF device to which this virtual EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
+ * @id: Pointer to the EPF device ID
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @lock: mutex to protect pci_epf_ops
  * @sec_epc: the secondary EPC device to which this EPF device is bound
@@ -158,6 +159,7 @@ struct pci_epf {
 	struct pci_epc		*epc;
 	struct pci_epf		*epf_pf;
 	struct pci_epf_driver	*driver;
+	const struct pci_epf_device_id *id;
 	struct list_head	list;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
-- 
2.25.1

