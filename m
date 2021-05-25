Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC03900E6
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhEYMZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 08:25:54 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39603 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhEYMZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 08:25:54 -0400
Received: by mail-pf1-f178.google.com with SMTP id y202so119087pfc.6
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 05:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITXWenoYZWuip8MkTjQ9AZjx1eyORN/WT4yzP4rw0YU=;
        b=MPTOAQayHHBbbBtj1LNVI8sY9aI6oZf2OIVXTxs/1RsjTVRRz18E/Oz3kwqwbpguw6
         89SiJ5DJbqEZbYgql46m4Sf51EOqvqo7qL9ZDrR1qJuGjFu6klGzqT9d+vupvOIc8s6o
         GvKgBAZktRRDwil848pB8ao2Th4LUVmUNoEeB2AqhAaqlL/5Ji9CaoxfoxAF3DbwNJm0
         2aiRPnOHhuYq1KB2ek24EVDIltjTn8PHedvQBgilEAeIo+OnCCnVJMJBZZozt7zOxXV/
         CepHcW2L2S8GJxtX9+SOtW5qz4okORLu4IOFqgyROPgbgav665uaZcMiWoxeLuRvwnrK
         EV8g==
X-Gm-Message-State: AOAM530oCHe0jxeUKFg9gXljEZu2CQGzaul/iMfg+/yil7YcZNavdmGS
        /IXVJjMypoZ2gTD9wKo3/pw=
X-Google-Smtp-Source: ABdhPJwMdvGDg6HQPRHUsMWoLsNnU45tDID2NnxcJGvIhazLkA9+ppgL5GZZ5rGu5TUVLx5SOz9Rdw==
X-Received: by 2002:a63:f50:: with SMTP id 16mr10789615pgp.373.1621945463849;
        Tue, 25 May 2021 05:24:23 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u1sm14220258pfc.63.2021.05.25.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:24:23 -0700 (PDT)
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
Subject: [PATCH v4 2/5] PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
Date:   Tue, 25 May 2021 12:23:58 +0000
Message-Id: <20210525122401.206136-2-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525122401.206136-1-kw@linux.com>
References: <20210525122401.206136-1-kw@linux.com>
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
Changes in v2:
  None.
Changes in v3:
  None.
Changes in v4:
  Separated this patch from other trivial sysfs_emit()/sysfs_emit_at()
  patches into a separate patch as per Bjorn Helgaas' request.
  Added Logan Gunthorpe's "Reviewed-by".

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

