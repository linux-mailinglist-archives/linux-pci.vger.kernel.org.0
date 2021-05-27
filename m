Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792073936EF
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhE0US2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 16:18:28 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:43576 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhE0US2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 16:18:28 -0400
Received: by mail-ej1-f42.google.com with SMTP id f18so1981321ejq.10
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 13:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSktK7xmva7Qa+bVz/3FMsgh0/OcR98/3N9+P2gYRT0=;
        b=RXN44iQKZ6D8RPRn1QSSU+DNGqfzOjVNsn7RaIg+sComq9i9u2AwtG9SR4DX9LoM7a
         lIhVwm1uanW0kMGuuGuKzB0Ygz38BBGp0AbgreRK9yzlwdi60M5dKWgw8oaj7QmT8G21
         smsjgwVIUGaLXJN0u49+RQglEXMpJktNXueUKHqnc7ssIEgcqw47ZBHfcboKEsepiUcg
         HPmOpRa1Zehm5ENnYsW9mIA8yDld1wiJqvTp4ztpdFkINMQL0DP285Bf6ElXWLY1sNWm
         x02zdBTxc9xVjjV83anc/NJKg/IQZB7wGf+iSaAtbWMCoAkW1PbW+nL7ZqY2np50Cti0
         z2AA==
X-Gm-Message-State: AOAM533FFPDvdldhFNY+fkSpJQJpF6+DQojH5PaZDxTEU/rV6Q0JUYS4
        alcX7HrOYW3Z9MiNe36hrf4=
X-Google-Smtp-Source: ABdhPJw2QixuJ3qnvVYo8lhC3M+vcrX/vBEnDzEe6uADrkpTFpFRLHMmuD5GKPZHCVQPFsv8LUda/Q==
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr5861784eja.242.1622146613695;
        Thu, 27 May 2021 13:16:53 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o64sm492739eda.83.2021.05.27.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:16:53 -0700 (PDT)
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
Subject: [PATCH v5 2/5] PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
Date:   Thu, 27 May 2021 20:16:47 +0000
Message-Id: <20210527201650.221944-2-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201650.221944-1-kw@linux.com>
References: <20210527201650.221944-1-kw@linux.com>
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
Changes in v5:
  None.

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

