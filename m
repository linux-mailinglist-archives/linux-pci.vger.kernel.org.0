Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969AE377AE3
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEJEPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:33 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:38749 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhEJEPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:32 -0400
Received: by mail-ej1-f46.google.com with SMTP id b25so22385760eju.5
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VehsfxGHIqUkGXhHVF4getgAan5RIFGHUznH7GSNZdM=;
        b=dlIVrORfeW5Piiooh52un+OuYnnfCVeRMKLFGpfbzIAtZ0DWCS9KLby+84HFtGs2p9
         tyZa2ejow4nyoi8KRQY/8ij4/Z4YXxmsnZHNuGNJFg61jfH4/hD+aD5itf/XJN1+xGBF
         NFaukFg4UVMqyeXfpDDGb4Q+/2WjgMwe2JqNEzhoAnM8mCGAvpKzSEU9sKrppE1rBQ/R
         lZ8dwLkua3jT8bcpc3s4QrCaMwhWdOLmw33ieoA3SaWwJsaw3drJBMeadSmroQKMloUL
         O+wKC7If2QcZQesqUHiZDH8UEHuLUvPHm3pp3qyI4gEq6W+qEcNBPG4VI05uwNnKfp0L
         qA0g==
X-Gm-Message-State: AOAM533meI8Rm2Kw05FbiMObjHFMZ9MTgUVmjBMFzi3r31uwKMUD8dfM
        /etd0sYpRYmjHR37REzqJ+w=
X-Google-Smtp-Source: ABdhPJxleSdspNVQ8y2ENdrbrJ5cWXhTiVe1flX9dSGCtK92jx+fQZEfoQ4TV35uolx4Y171lHT6yg==
X-Received: by 2002:a17:906:5acd:: with SMTP id x13mr22871865ejs.243.1620620067931;
        Sun, 09 May 2021 21:14:27 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:27 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/11] PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:16 +0000
Message-Id: <20210510041424.233565-3-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

Modify the function dsm_label_utf16s_to_utf8s() to directly return the
number of bytes written into the buffer so that the strlen() used later
to calculate the length of the buffer can be removed as it would no
longer be needed.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-label.c | 18 ++++++++++--------
 drivers/pci/slot.c      | 16 ++++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index c32f3b7540e8..000e169c7197 100644
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
-			scnprintf(buf, PAGE_SIZE, "%llu\n", tmp->integer.value);
+			len = sysfs_emit(buf, "%llu\n", tmp->integer.value);
 		} else if (attr == ACPI_ATTR_LABEL_SHOW) {
 			if (tmp[1].type == ACPI_TYPE_STRING)
-				scnprintf(buf, PAGE_SIZE, "%s\n",
-					  tmp[1].string.pointer);
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
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d627dd9179b4..7487e8f8f13f 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -39,19 +39,19 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
 	if (slot->number == 0xff)
-		return sprintf(buf, "%04x:%02x\n",
-				pci_domain_nr(slot->bus),
-				slot->bus->number);
+		return sysfs_emit(buf, "%04x:%02x\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number);
 	else
-		return sprintf(buf, "%04x:%02x:%02x\n",
-				pci_domain_nr(slot->bus),
-				slot->bus->number,
-				slot->number);
+		return sysfs_emit(buf, "%04x:%02x:%02x\n",
+				  pci_domain_nr(slot->bus),
+				  slot->bus->number,
+				  slot->number);
 }
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
 {
-	return sprintf(buf, "%s\n", pci_speed_string(speed));
+	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
 
 static ssize_t max_speed_read_file(struct pci_slot *slot, char *buf)
-- 
2.31.1

