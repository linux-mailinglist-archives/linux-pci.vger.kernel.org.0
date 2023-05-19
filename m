Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF963709A29
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjESOmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjESOma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774CD192
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d341bdedcso513331b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507346; x=1687099346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VHdXC3BlPGtz1yDleZn4OSOvKYhYQjZWZyy2WyNcmY=;
        b=zDhnY1tZ6F9eXaHyhGYxvDZLfChRGmXrhdXtVfYjbG0UfBFL3DlRbFP9V/HoilVJg9
         sxYH8U/+3hErmnXXskurIeJIQjnxgsy9uM/YwLM6qjvM8FCU0RLfrhBHq43ushk7PU7F
         PxLrhl/nq4mzv5Vso6V/C1Hbn/UjJi+BsYbrDKit8jvuC79lSy3gd1PMhc2+dJSZ5IqJ
         4oicYzfmGLLcswR7kLmmRBjl7mF0c57KKu7gtdip0VtOgUNe9uGqvU6Lj7n8WmNsIYQh
         7DK4zTiXafzMIZ8usDA93JlXL0LckIoBG9rzWU/N6rLVtpl7B84lzjKhjmlB1vsjzQEP
         6W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507346; x=1687099346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VHdXC3BlPGtz1yDleZn4OSOvKYhYQjZWZyy2WyNcmY=;
        b=YLv+5Wmmc3XU1rTewbrwR/vtQkQktTddAkb966YOrFvf4TqtP6HQErZ7VwFbD4Asb4
         9HPhR9btyYHjxB7ibrP7V0tDc+mp9cuuvu8fD3bIciPmBfXfHwa0TFVQqU3nCBZo+NyD
         Yrn0pAIZQyj4IwK+VINSDo4zDXTRoJWgrKLr6SY5IS7rtWTNKYYcsYb3YXN7Ukamw3Fl
         4qrIKQABNFcaWJiaH0s+A+YFnRaQszoZ4U52OI45gHJWHkQ6G4mKPP417ioyJZDStGZJ
         V4G0B3aQ28BuJEvlaCPIkzojmbvfgk5zFUPxuTHQIuORb4EkMVcJbaTYIYA09XZAARf8
         6F1A==
X-Gm-Message-State: AC+VfDwIKOMR/GokFbYmsBK9u6Y9zXWvdaqCP+DrGxh6id9LsXqDxgxg
        iBS5XBIeyUdxyl95ZlVGKJAE
X-Google-Smtp-Source: ACHHUZ6aRSSnpCSFwwLO/70wt9OUwLz/936pvgjhQf6pEika0CH2yBC45Sv1DXm9OBmj2qA+9A41cg==
X-Received: by 2002:a05:6a00:15c7:b0:63b:8f08:9af3 with SMTP id o7-20020a056a0015c700b0063b8f089af3mr3833208pfu.7.1684507345892;
        Fri, 19 May 2023 07:42:25 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/7] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Fri, 19 May 2023 20:12:09 +0530
Message-Id: <20230519144215.25167-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the EPF probe function doesn't get the device ID argument needed
to correctly identify the device table ID of the EPF device.

When multiple entries are added to the "struct pci_epf_device_id" table,
the probe function needs to identify the correct one. And the only way to
do so is by storing the correct device ID in "struct pci_epf" during
"pci_epf_match_id()" and passing that to probe().

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 drivers/pci/endpoint/pci-epf-core.c           | 8 +++++---
 include/linux/pci-epf.h                       | 4 +++-
 5 files changed, 12 insertions(+), 7 deletions(-)

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
index 2036e38be093..924564288c9a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -494,11 +494,13 @@ static const struct device_type pci_epf_type = {
 };
 
 static int
-pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
+pci_epf_match_id(const struct pci_epf_device_id *id, struct pci_epf *epf)
 {
 	while (id->name[0]) {
-		if (strcmp(epf->name, id->name) == 0)
+		if (strcmp(epf->name, id->name) == 0) {
+			epf->id = id;
 			return true;
+		}
 		id++;
 	}
 
@@ -526,7 +528,7 @@ static int pci_epf_device_probe(struct device *dev)
 
 	epf->driver = driver;
 
-	return driver->probe(epf);
+	return driver->probe(epf, epf->id);
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

