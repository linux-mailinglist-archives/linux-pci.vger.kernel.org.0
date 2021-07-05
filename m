Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430903BC39B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGEVZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 17:25:51 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:34462 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGEVZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 17:25:50 -0400
Received: by mail-lj1-f169.google.com with SMTP id p24so26284784ljj.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 14:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHJbtumNP/QPZX7jFnSN5PQKCqcp2ZqNj7wI7rdpODc=;
        b=fZNQqcfL8wtJHhuuVsQ3O6HqJglRET5JbS3oj8zm6FSTJLfMYTjlXiTct8rupCb/sd
         UEAsJcaX4TmSnaBn/MeQ7W1OdOkZwPsxQDPBA5TAlFVNHp2tSDk6lj6G2LEUX0QvgDze
         KAUcybyfIyzBy/swIftzGqmFYFumivzOS3Y9cLG9hkfxGwFvXgHewcZubvJC2Z93UiVA
         zSMbRDClD28uDL1SCbMCNmYmV2zIT3OR3UHJVlUQ1oMJGTpPRdHMcsi/OrCaUiqW0ue3
         qikCtJL4tApMozXDvOGQyCwXFJacysgA1i3Pdof5oooimoCcnXI6vlKyyJZ519TlAnjp
         Pfzw==
X-Gm-Message-State: AOAM532EorrGfG8fWbt4eRQ5LDcETWBoVTmb2Zc7uFXBUSZE+S8KfhUf
        s3oS45qluoyJuM5LgEs/x50=
X-Google-Smtp-Source: ABdhPJym1xPQuhYEnzh6fV6EyKXJhZE4QpJj7XO7eF0Luy+gVpQnfTcHjyzdUnLyrpy42cAsR+aVPQ==
X-Received: by 2002:a2e:a495:: with SMTP id h21mr8531562lji.295.1625520192292;
        Mon, 05 Jul 2021 14:23:12 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x1sm1191338lfa.21.2021.07.05.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 14:23:11 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI/sysfs: Return -EINVAL consistently from "store" functions
Date:   Mon,  5 Jul 2021 21:23:07 +0000
Message-Id: <20210705212308.3050976-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705212308.3050976-1-kw@linux.com>
References: <20210705212308.3050976-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, most of the "store" functions that handle input from the
userspace via the sysfs objects commonly returns the -EINVAL error code
should the value provided fail validation and/or type conversion.  This
error code is a clear message to the userspace that the provided value
is not a valid input.

However, some of the "show" functions return the error code as-is as
returned from the helper functions used to parse the input value, and in
which case the error code can be either -EINVAL or -ERANGE.  The former
would often be a return from the kstrtobool() function and the latter
will most likely be originating from other kstr*() functions family such
as e.g., kstrtou8(), kstrtou32(), etc.

The -EINVAL is commonly returned as the error code to indicate that the
value provided is invalid, and the -ERANGE code is not very useful in
the userspace, thus normalize the return error code to be -EINVAL for
when the validation and/or type conversion fails.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 18 ++++------
 drivers/pci/endpoint/pci-ep-cfs.c            | 35 +++++++-------------
 drivers/pci/iov.c                            | 10 +++---
 3 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index bce274d02dcf..c5a9cfa4c4a4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1928,11 +1928,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	u32 val;							\
-	int ret;							\
 									\
-	ret = kstrtou32(page, 0, &val);					\
-	if (ret)							\
-		return ret;						\
+	if (kstrtou32(page, 0, &val) < 0)				\
+		return -EINVAL;						\
 									\
 	ntb->_name = val;						\
 									\
@@ -1961,11 +1959,9 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct device *dev = &ntb->epf->dev;				\
 	int win_no;							\
 	u64 val;							\
-	int ret;							\
 									\
-	ret = kstrtou64(page, 0, &val);					\
-	if (ret)							\
-		return ret;						\
+	if (kstrtou64(page, 0, &val) < 0)				\
+		return -EINVAL;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
@@ -1986,11 +1982,9 @@ static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 	struct config_group *group = to_config_group(item);
 	struct epf_ntb *ntb = to_epf_ntb(group);
 	u32 val;
-	int ret;
 
-	ret = kstrtou32(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou32(page, 0, &val) < 0)
+		return -EINVAL;
 
 	if (val > MAX_MW)
 		return -EINVAL;
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index f3a8b833b479..c77459048ef7 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -175,9 +175,8 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 	epc = epc_group->epc;
 
-	ret = kstrtobool(page, &start);
-	if (ret)
-		return ret;
+	if (kstrtobool(page, &start) < 0)
+		return -EINVAL;
 
 	if (!start) {
 		pci_epc_stop(epc);
@@ -329,13 +328,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u32 val;							       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou32(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou32(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -345,13 +342,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u16 val;							       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou16(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou16(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -361,13 +356,11 @@ static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
 				       const char *page, size_t len)	       \
 {									       \
 	u8 val;								       \
-	int ret;							       \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	ret = kstrtou8(page, 0, &val);					       \
-	if (ret)							       \
-		return ret;						       \
+	if (kstrtou8(page, 0, &val) < 0)				       \
+		return -EINVAL;						       \
 	epf->header->_name = val;					       \
 	return len;							       \
 }
@@ -376,11 +369,9 @@ static ssize_t pci_epf_msi_interrupts_store(struct config_item *item,
 					    const char *page, size_t len)
 {
 	u8 val;
-	int ret;
 
-	ret = kstrtou8(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou8(page, 0, &val) < 0)
+		return -EINVAL;
 
 	to_pci_epf_group(item)->epf->msi_interrupts = val;
 
@@ -398,11 +389,9 @@ static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
 					     const char *page, size_t len)
 {
 	u16 val;
-	int ret;
 
-	ret = kstrtou16(page, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtou16(page, 0, &val) < 0)
+		return -EINVAL;
 
 	to_pci_epf_group(item)->epf->msix_interrupts = val;
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index afc06e6ce115..aa775c7b46fd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -185,9 +185,8 @@ static ssize_t sriov_vf_msix_count_store(struct device *dev,
 	struct pci_dev *pdev = pci_physfn(vf_dev);
 	int val, ret;
 
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
+	if (kstrtoint(buf, 0, &val) < 0)
+		return -EINVAL;
 
 	if (val < 0)
 		return -EINVAL;
@@ -379,9 +378,8 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	int ret;
 	u16 num_vfs;
 
-	ret = kstrtou16(buf, 0, &num_vfs);
-	if (ret < 0)
-		return ret;
+	if (kstrtou16(buf, 0, &num_vfs) < 0)
+		return -EINVAL;
 
 	if (num_vfs > pci_sriov_get_totalvfs(pdev))
 		return -ERANGE;
-- 
2.32.0

