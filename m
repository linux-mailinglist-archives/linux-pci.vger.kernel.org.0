Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE06B89C8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 05:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCNEqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 00:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCNEqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 00:46:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2575AB67
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k2so7451509pll.8
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmBMpLwO4qRSgpNN2zu2wmSlV0dO5yPKMRqsInWvopM=;
        b=cpsSqBecUtfR1YL08VzHXQKb+5jn+ts3gGNqf9sEp9Rf5VGxRyOXC4Ol/rGAWvxEp7
         /zoNai5d3a+ptbhU5WJaTefpNmC+dOd1hF4WinSIoYbHUcU8AuSlflHuZbgkP4IbdM7m
         hV1Lo0CYP5maFSPBjqpIJmhUuTuz7Lj77/beCz1Ayn5sIuKhIV706ouoDUgmRUL1UXJD
         APLp0ZYjmD0vj3BxneLS7t1xISFq2dikx3/VSZLJaTyGtNSp2M23YBDIfMpokj4lc3RS
         Qoi9yvC782Y/rTo0k0RSJzml+kMvcnum3NoJmYZfr3FQ6W/fSFc0lGeF1OjOafkN4GkP
         lrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmBMpLwO4qRSgpNN2zu2wmSlV0dO5yPKMRqsInWvopM=;
        b=Ej6vkaXv5zb7GWolgqxpyduMR77/og9ENffVaHPpXPGjtYK/Rcl7pSHZ3ChB5Pi65M
         92iwEpxClJm68sDO8BXdp/aBf9xMAf89R4zkcS7Hk6Emjfu2ZF165syri8mPXLOrDNFM
         /qGg64YCo2SrUyYmjn3JasfoDnu1GaK7lghYRWTCQZ/Z5+OjZ3+9xepcikOW87Zom91I
         lE5w5HVOv3RbKlFIJ+T1qTO4l4+yUTuKue1zOPwrT/l3/6MNaiIfeUCHTNzNAob3vlmy
         +5TSO7z9xFWXjf1Avxs+MbnaYWiyb/VeFHJzmTRCjIHj2MRIG2zrSvutgHmJ8PFgGkPo
         GevQ==
X-Gm-Message-State: AO0yUKXkbvb9stJZNaUyJ4cg8m8DIR2W9Vr9LBeviAFv7yWi/BXOC3Fn
        Dsdmm9Ms0jmAciEJxwqpdCIY
X-Google-Smtp-Source: AK7set/oOtVKUX5G+g1F0lo2DANPM8LZueP8THFKLIt60oJY3hCXKh7XKtD1XH7xNVwbZ12h7bN4Sg==
X-Received: by 2002:a17:902:c404:b0:19f:e9e7:4cb with SMTP id k4-20020a170902c40400b0019fe9e704cbmr8615091plk.45.1678769196675;
        Mon, 13 Mar 2023 21:46:36 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/7] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Tue, 14 Mar 2023 10:16:17 +0530
Message-Id: <20230314044623.10254-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

