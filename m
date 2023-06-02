Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CF7200A5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjFBLsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjFBLsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:48:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BFE61
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:48:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96ff9c0a103so279036766b.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706501; x=1688298501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCx8u4FTb25tGY9h6NAZAUxoZ2VzPZMZvjUb+LK7v5c=;
        b=z2vZ9AKOUwQXT2SJ6K59kZRJVsU3LZbdZ1a/XNf2CD52Q8Jlp5hSJbpYNQVVOY6je8
         CSJA1CkKoMT1zKoFoE82k9EtWlXFHB33Fos/dn/fW64MdpPvl3U14OF2954OKP/Nvfkb
         ozAU43feiq9Wk4YYq1mU1m05XmPSJlRn9gOy1lYyqkcV6WtYPqUh76S0lWAlQS+sAePJ
         S1Okq9fVeKjUuio0bG4egO2Hf/hSXe1ppEBPcq/pb8H89kx5QyOztybMbXPx1kh99I6B
         XahuTmT7MzX30zo3HjoB9eyGEF2ahWXzWQhB5Cmp2fxrr6sY3ej14GLQ2+/B9ipU5vop
         nMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706501; x=1688298501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCx8u4FTb25tGY9h6NAZAUxoZ2VzPZMZvjUb+LK7v5c=;
        b=bbXEKrBIWCN8tOkbMnAJRY61lMWNKXc0ohhCTFMDgTzIcNggmZirt5wA72ZoId7Otc
         FF4Vbj3waht3XwPA3BgRctCztoh74dh9Fo3G4HWlePR8qsJ3ngfPtYkCSiRYGR07LE5h
         N/BnUmxJS8tjYeiwpkVJivcAUiEA0QwxOo64K7ZJdZoNbFgaofO9v3XwOMAQCLyZ5ivd
         3wCTKoBQZ74srNFivjhYEZxN7si9F/JYUZuK4Nmcdsy218tNjByUAI5JqwmBxPKsNTnH
         Zv1zu1h34JWWrUCDol8N0rGgWrkvXHuovQRftTxlyhA2SPUYfoDORwKMhehSJFKZtCVS
         EhMw==
X-Gm-Message-State: AC+VfDzrkk2+Ggo8/3SrC6oZ+STahAtMQKTm/Uw7Yds2GHmVp9VOl2fw
        w/C9VVBd2i9ZMqjGRI/coVw9
X-Google-Smtp-Source: ACHHUZ66/kJwyHFhPEDcDLWj8uLtfOp1E/9Jr1Xei3FBqsO73Tywri9GYr64d7S9hSNAHHIne3q7+w==
X-Received: by 2002:a17:907:9455:b0:96f:e2c4:a063 with SMTP id dl21-20020a170907945500b0096fe2c4a063mr10755841ejc.33.1685706501247;
        Fri, 02 Jun 2023 04:48:21 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Fri,  2 Jun 2023 17:17:49 +0530
Message-Id: <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/pci-epf-core.c           | 18 +++++++++++-------
 include/linux/pci-epf.h                       |  4 +++-
 5 files changed, 18 insertions(+), 11 deletions(-)

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
index 2036e38be093..ea6e0aef0bb3 100644
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
@@ -526,7 +530,7 @@ static int pci_epf_device_probe(struct device *dev)
 
 	epf->driver = driver;
 
-	return driver->probe(epf);
+	return driver->probe(epf, pci_epf_match_id(driver->id_table, epf));
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

