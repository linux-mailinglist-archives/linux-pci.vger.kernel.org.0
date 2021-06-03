Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1988399693
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCADT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45646 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFCADP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:15 -0400
Received: by mail-wr1-f50.google.com with SMTP id z8so3927112wrp.12
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esgfLavaw+XZk4GOeBas9K6OiHOa2qiDYxRXO/T0WrQ=;
        b=WxZK/FEZxmU/N0hsdXd7NoaMhLxusxbnv1OBoFZGqo/9bzE9shrkJdOBxE0amSQZ9J
         2Co/61IpR13hMX+FCyViGoFKmn5Dmxp73f+ZQ/r1h5GsqE8muP9bA3vyiDEPDKehnkkt
         RPcEB5+/L1MrBtlpiYYDxbGV1GZFTwhFA1WqWLpQnnLgT3rovha1Rpx+qGocdjxBHxkV
         /GTZ7nBXEV31JLRVANvGKVCKIS7UKfuAC1vX49TfVRCq5kuz3sqqtW3q36A4AMSPDXtw
         tomAIbuyHE37ZWqMngCkpNc+58G2Lzz2G65PkIFq7UlV3lZdlE8px1PTiAl9JhF5aOw4
         Kacw==
X-Gm-Message-State: AOAM533m0uqp2Of/WB6hc32+da1yzCiwKJa7dIeXagHocQBpPq3VEI5w
        lQVBnQsqbqiPS6dBwDMbw8g=
X-Google-Smtp-Source: ABdhPJywH89u4hTgpvy8bgcTQ9jKbZlDpgsTJohIA74AUwbwr74jCkmZArm9uV+0jXCXo4j0n9b5zg==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr22258644wrp.416.1622678478029;
        Wed, 02 Jun 2021 17:01:18 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:17 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 2/6] PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
Date:   Thu,  3 Jun 2021 00:01:08 +0000
Message-Id: <20210603000112.703037-3-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
References: <20210603000112.703037-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Modify the function dsm_label_utf16s_to_utf8s() to directly return the
number of bytes written into the buffer so that the strlen() used later
to calculate the length of the buffer can be removed as it would no
longer be needed.

No functional change intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/pci-label.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 311dd48e2881..000e169c7197 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -139,14 +139,17 @@ enum acpi_attr_enum {
 	ACPI_ATTR_INDEX_SHOW,
 };
 
-static void dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
+static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
 {
 	int len;
+
 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
 			      obj->buffer.length,
 			      UTF16_LITTLE_ENDIAN,
 			      buf, PAGE_SIZE);
 	buf[len] = '\n';
+
+	return len;
 }
 
 static int dsm_get_label(struct device *dev, char *buf,
@@ -154,7 +157,7 @@ static int dsm_get_label(struct device *dev, char *buf,
 {
 	acpi_handle handle = ACPI_HANDLE(dev);
 	union acpi_object *obj, *tmp;
-	int len = -1;
+	int len = 0;
 
 	if (!handle)
 		return -1;
@@ -175,20 +178,19 @@ static int dsm_get_label(struct device *dev, char *buf,
 		 * this entry must return a null string.
 		 */
 		if (attr == ACPI_ATTR_INDEX_SHOW) {
-			sysfs_emit(buf, "%llu\n", tmp->integer.value);
+			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
 		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
 			if (tmp[1].type == ACPI_TYPE_STRING)
-				sysfs_emit(buf, "%s\n",
-					   tmp[1].string.pointer);
+				len = sysfs_emit(buf, "%s\n",
+						 tmp[1].string.pointer);
 			else if (tmp[1].type == ACPI_TYPE_BUFFER)
-				dsm_label_utf16s_to_utf8s(tmp + 1, buf);
+				len = dsm_label_utf16s_to_utf8s(tmp + 1, buf);
 		}
-		len = strlen(buf) > 0 ? strlen(buf) : -1;
 	}
 
 	ACPI_FREE(obj);
 
-	return len;
+	return len > 0 ? len : -1;
 }
 
 static ssize_t label_show(struct device *dev, struct device_attribute *attr,
-- 
2.31.1

