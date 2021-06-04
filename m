Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598039B9EA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFDNem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:42 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:44640 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFDNek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:40 -0400
Received: by mail-qk1-f181.google.com with SMTP id h20so9244430qko.11
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esgfLavaw+XZk4GOeBas9K6OiHOa2qiDYxRXO/T0WrQ=;
        b=P6b9Dp/Ro2RCdKH90u1NBMkDTf61+V8I7aHVX7nY7pfERGgq8JTzRgiHg+NQWg80qC
         ZHyz7himEKxlwyemCLca7GjcYfLCsH12d0IOCk2kX3OfULQE0NVdN4KPvza8FiTRPaqm
         i3BBW0IYOETzB+R/EA2fkcx/hU233AnAvbd4Gn6Jkx8rMANYBh3GbvSavcSz7rQo9phy
         CjGi2jI/r78lkUasIOCVZao+/6l7BvLNAl+YnANDjkVurOvdykrO5haVV+MSeV3q5LuD
         lZYNOBSraqGjo4nqkWKfo5jeesA/6D2ms+j1Hczf5crG5BKWtoTCMFas1WFrMNAIyYv3
         AKpQ==
X-Gm-Message-State: AOAM530zNItnuYIogFNzuYQO2FMgbg/5EKpyJSO9t4wjVwpk+qg0JNBQ
        9cbtG6/TmbjEMo23KFPo4oc=
X-Google-Smtp-Source: ABdhPJwU2RdoBpkSdrGbnhs9zCceAH1czCQfN9u8j1DJSP50adacfc+gfL+KiSQGca2b6jPWMexdsA==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr4320273qke.350.1622813559447;
        Fri, 04 Jun 2021 06:32:39 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:38 -0700 (PDT)
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
Subject: [PATCH v7 2/6] PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
Date:   Fri,  4 Jun 2021 13:32:26 +0000
Message-Id: <20210604133230.983956-3-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604133230.983956-1-kw@linux.com>
References: <20210604133230.983956-1-kw@linux.com>
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

