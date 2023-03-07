Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3116AE446
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjCGPRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCGPRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:17:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113809EC8
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 07:14:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so16824430pjb.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/dZg64ztv0KUh6No53X6WHHUMATIjQWN6mhKUx2HRs=;
        b=E2Y5I4zto5l5GEcCAxR00164MlKy5MTk6nbmkWw7Hc+1HAIiSRWGo//KKWSs1LCZ9W
         litr3y1JEEG8uC3d54SQUZ++FDzEPwxxVHf48wyBJaqwwwz8E/j/153OFpqT5WPfm/pR
         T45K3tqvr8NirR75ZAc3nun9MQEtGM7aoPHS2BYBYJ0k0app2h09oKvnse+BDpynhzat
         AFYYocF9f8/CnSfA+7iZ7fejBjTlSFgKRJGNE6oOt7blg1LluLHcjt6YTsZl2m3xuHA2
         iBy2JI/8gVIwfDNANzR3tC+5azpNPH6AfL1mfjm8gt23VGoXafoIQYDWn+18TxaDfitX
         H4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/dZg64ztv0KUh6No53X6WHHUMATIjQWN6mhKUx2HRs=;
        b=EJC5r4TRt6DyilmMoD86lEOz252WRQr8PE1wnvDeTXQR8cnsHBAW9FAJENGBxkj7AF
         mlWtEiQSbuCblMoDK4qab3OY8fJlqTJF/axOv6UQHAQkJZR6g+tvCOrqWpXmEaE3aBFH
         vOShVGodSgQA7okgSJ17eHmAYtMSq30kfA4Egj9nyUqkP2iWmvvb7rc49Xbw9Za9YwIt
         vWzNVfwDFzsAKsjnOCuowd4Z1VEP3EQFj+eHeE5asGUPwvhhGOxMD4arTDp5cUyPpTh0
         PdpWdt79t0B0KhDTXF09fu4FLdTAi24VJY/kQMv7m7QoqTk8RYch6Gx/GKGs7OVGcoho
         Gxsg==
X-Gm-Message-State: AO0yUKWzvjAk58un4ikcEBMMTjUL5/kh7JYBUDUsb5He0vvQKgJ6u3um
        xW/JKMCi60f4dFqUcCVyW0/g
X-Google-Smtp-Source: AK7set+X628LqgvzdmLNuC9bPwJphy++TKYaAaiUsTaSelhv0ND6G3yH+zsFpSeAaErnihUFa8Masw==
X-Received: by 2002:a17:902:6a8a:b0:19e:6185:10d6 with SMTP id n10-20020a1709026a8a00b0019e618510d6mr13900523plk.40.1678202068516;
        Tue, 07 Mar 2023 07:14:28 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:28 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] PCI: endpoint: Pass EPF device ID to the probe function
Date:   Tue,  7 Mar 2023 20:44:10 +0530
Message-Id: <20230307151416.176595-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
References: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

