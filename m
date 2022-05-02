Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C8516AA6
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357858AbiEBGKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357945AbiEBGJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 02:09:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7B4E3A5
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 23:06:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso6582375pjb.5
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhwiSz4nUEKxyVPxPgnud7ZLMUjJ9Xi44F8SQGqayAg=;
        b=iLxrj/+HHvqwp534r7ex2+ODCsXS4sjzqe6oSlMHEPI5j7BJ0SgUCZ2YqSjT8+Y6LL
         dGy71rI2xipA03Dgt7LqaR0sxzqCq+Ld/k7q1aX7AoCA2zY/kFr0iBjXGyfnlJ7BhHPy
         kmbHhCkFOiFkpVa/sjLPi1RyKF9uFwrrltT4nonpOXnYyqXuxj+e0R+SD8SglSoE72bJ
         kGalj/TjjopC0cL0UXLfZ+6nedHm4Z7jKHk4yWMXxqHQfjxZ0GDToprso+80r3mN8ZNA
         GSf+qKjsr72rDkWOeTQhQFx/pDSITjbIuPi0q7C5LV7SuCF7rqO7xg1KNgAQxrdL4Yi/
         rhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhwiSz4nUEKxyVPxPgnud7ZLMUjJ9Xi44F8SQGqayAg=;
        b=RXPD+GP8sSlMj/8OYFJYUvBFe51Las8P8GpD4rdoVPN6NhyPqQBNpE/WKEolt+gJdk
         aH2t9oQe7gDxpXneeX1EndH5XZiEenlYnSyvn4Ph+5NNLnU57amJYkgH9RY3XVzs8yBe
         tCYVkldEgAmwl3MMhK43UIYvd3J2ngZKMu0k8qxUxwrGQ7OqkVS7gZx+J86cDom9rY5F
         WgpPzZQk+qKwaDLmJ2ncLV9/g8o3v3lAK4HCGQTBhmL2PbVjkI+kl9puCcdgC5DE7zWF
         EJNeM9VXW8QTUYCPdnWe/MIyotEf1RNDQUvIGgRTh74QY52phVKfPrYDkkA6BN0izetF
         LAGg==
X-Gm-Message-State: AOAM532QQIF0hHr3S1FcKArum+mWi6F7Wf4hO6BlOuDbLY0RKNIsbbST
        udTf3NESrlW789unHD0SM3m6QooC3KmF
X-Google-Smtp-Source: ABdhPJxG6HMx0DWdiaCr+PhNjaS2SLQj3j4gb1NoZlCahr2ddBju081kXD1bYo3hD052lZVaZwue5Q==
X-Received: by 2002:a17:90b:4a02:b0:1dc:4710:c1fe with SMTP id kk2-20020a17090b4a0200b001dc4710c1femr6729696pjb.208.1651471585900;
        Sun, 01 May 2022 23:06:25 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/8] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Mon,  2 May 2022 11:36:04 +0530
Message-Id: <20220502060611.58987-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/pci-epf-core.c           | 8 +++++---
 include/linux/pci-epf.h                       | 4 +++-
 4 files changed, 11 insertions(+), 6 deletions(-)

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
index 5b833f00e980..f82b52e07621 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -901,7 +901,7 @@ static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{},
 };
 
-static int pci_epf_test_probe(struct pci_epf *epf)
+static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..0882ac829e95 100644
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
index 009a07147c61..0c94cc1513bc 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -84,7 +84,7 @@ struct pci_epf_ops {
  * @id_table: identifies EPF devices for probing
  */
 struct pci_epf_driver {
-	int	(*probe)(struct pci_epf *epf);
+	int	(*probe)(struct pci_epf *epf, const struct pci_epf_device_id *id);
 	void	(*remove)(struct pci_epf *epf);
 
 	struct device_driver	driver;
@@ -126,6 +126,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @epf_pf: the physical EPF device to which this virtual EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
+ * @id: Pointer to the EPF device ID
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
@@ -153,6 +154,7 @@ struct pci_epf {
 	struct pci_epc		*epc;
 	struct pci_epf		*epf_pf;
 	struct pci_epf_driver	*driver;
+	const struct pci_epf_device_id *id;
 	struct list_head	list;
 	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
-- 
2.25.1

