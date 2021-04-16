Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A433629D8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbhDPU7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:36 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41687 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbhDPU7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:36 -0400
Received: by mail-ed1-f41.google.com with SMTP id z1so33832404edb.8
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVmWMVb6qko8ecvNCz9h65V4X7tSNjC2VksULNu6kzQ=;
        b=Q31QO6a0reOkrHfp/M0XTLuVyhBSQeCS76Y9RzITmaxhALUZ4GalFEjHSricoVuoSR
         9U1bZI2Pdzeu2JJfJHvF6pvILEBPhR6YEJaDwhOevOGlarCGk3xo+vu9VS5UPQ+ImGCZ
         dEIpirnx/1cru6IsBPaO3wwlaGwD7rSRhh9kNcVUffZyZO4uV5WH+ixfoKMv/W7re2zW
         iZ1mYsg6Wx6sx5BvPleWFETuhAitsNT1ezUy2fptCPdwgRih3otNi1Z/ujwdi59+W2pE
         iHDOXB9khOjBv3kxGC8yIwP6zzY4QAiM4+H4OA2zAsmXfdjPHY6amzzGvy9TKuRyhjbf
         cQIw==
X-Gm-Message-State: AOAM531/nJoDyprxFpKVO/LBtd9pH5JUzwUuKuJ5WT/OKVrtY8zQtCzT
        oGOTuxLnr9Wcmqw8vdcwnzI=
X-Google-Smtp-Source: ABdhPJw8/3g+FUFbqjQOKdKJpIFFWKqGOdi+8SHbsmuggqq0meRiUek9aNNf20UsYfB804xJ3tjSKw==
X-Received: by 2002:a05:6402:438f:: with SMTP id o15mr12206150edc.123.1618606750090;
        Fri, 16 Apr 2021 13:59:10 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:59:09 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 12/20] PCI: Rearrange attributes from the pci_dev_config_attr_group
Date:   Fri, 16 Apr 2021 20:58:48 +0000
Message-Id: <20210416205856.3234481-13-kw@linux.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416205856.3234481-1-kw@linux.com>
References: <20210416205856.3234481-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When new sysfs objects were added to the PCI device over time, the code
that implemented new attributes has been added in many different places
in the pci-sysfs.c file.  This makes it hard to read and also hard to
find relevant code.

Thus, move attributes that are part of the "pci_dev_config_attr_group"
attribute group to the top of the file.

No functional change intended.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 336 ++++++++++++++++++++--------------------
 1 file changed, 168 insertions(+), 168 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5f83ff087f2c..513e19154a93 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -483,6 +483,174 @@ static const struct attribute_group pci_dev_group = {
 	.attrs = pci_dev_attrs,
 };
 
+static ssize_t config_read(struct file *filp, struct kobject *kobj,
+			   struct bin_attribute *bin_attr, char *buf,
+			   loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	unsigned int size = 64;
+	loff_t init_off = off;
+	u8 *data = (u8 *)buf;
+
+	/* Several chips lock up trying to read undefined config space */
+	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
+		size = pdev->cfg_size;
+	else if (pdev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+		size = 128;
+
+	if (off > size)
+		return 0;
+
+	if (off + count > size) {
+		size -= off;
+		count = size;
+	} else {
+		size = count;
+	}
+
+	pci_config_pm_runtime_get(pdev);
+
+	if ((off & 1) && size) {
+		u8 val;
+		pci_user_read_config_byte(pdev, off, &val);
+		data[off - init_off] = val;
+		off++;
+		size--;
+	}
+
+	if ((off & 3) && size > 2) {
+		u16 val;
+		pci_user_read_config_word(pdev, off, &val);
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		off += 2;
+		size -= 2;
+	}
+
+	while (size > 3) {
+		u32 val;
+		pci_user_read_config_dword(pdev, off, &val);
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		data[off - init_off + 2] = (val >> 16) & 0xff;
+		data[off - init_off + 3] = (val >> 24) & 0xff;
+		off += 4;
+		size -= 4;
+		cond_resched();
+	}
+
+	if (size >= 2) {
+		u16 val;
+		pci_user_read_config_word(pdev, off, &val);
+		data[off - init_off] = val & 0xff;
+		data[off - init_off + 1] = (val >> 8) & 0xff;
+		off += 2;
+		size -= 2;
+	}
+
+	if (size > 0) {
+		u8 val;
+		pci_user_read_config_byte(pdev, off, &val);
+		data[off - init_off] = val;
+		off++;
+		--size;
+	}
+
+	pci_config_pm_runtime_put(pdev);
+
+	return count;
+}
+
+static ssize_t config_write(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *bin_attr, char *buf,
+			    loff_t off, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	unsigned int size = count;
+	loff_t init_off = off;
+	u8 *data = (u8 *)buf;
+	size_t ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
+
+	if (off > pdev->cfg_size)
+		return 0;
+
+	if (off + count > pdev->cfg_size) {
+		size = pdev->cfg_size - off;
+		count = size;
+	}
+
+	pci_config_pm_runtime_get(pdev);
+
+	if ((off & 1) && size) {
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
+		off++;
+		size--;
+	}
+
+	if ((off & 3) && size > 2) {
+		u16 val = data[off - init_off];
+		val |= (u16) data[off - init_off + 1] << 8;
+		pci_user_write_config_word(pdev, off, val);
+		off += 2;
+		size -= 2;
+	}
+
+	while (size > 3) {
+		u32 val = data[off - init_off];
+		val |= (u32) data[off - init_off + 1] << 8;
+		val |= (u32) data[off - init_off + 2] << 16;
+		val |= (u32) data[off - init_off + 3] << 24;
+		pci_user_write_config_dword(pdev, off, val);
+		off += 4;
+		size -= 4;
+	}
+
+	if (size >= 2) {
+		u16 val = data[off - init_off];
+		val |= (u16) data[off - init_off + 1] << 8;
+		pci_user_write_config_word(pdev, off, val);
+		off += 2;
+		size -= 2;
+	}
+
+	if (size) {
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
+		off++;
+		--size;
+	}
+
+	pci_config_pm_runtime_put(pdev);
+
+	return count;
+}
+static BIN_ATTR_RW(config, 0);
+
+static struct bin_attribute *pci_dev_config_attrs[] = {
+	&bin_attr_config,
+	NULL,
+};
+
+static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	a->size = PCI_CFG_SPACE_SIZE;
+	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
+		a->size = PCI_CFG_SPACE_EXP_SIZE;
+
+	return a->attr.mode;
+}
+
+static const struct attribute_group pci_dev_config_attr_group = {
+	.bin_attrs = pci_dev_config_attrs,
+	.is_bin_visible = pci_dev_config_attr_is_visible,
+};
+
 /*
  * PCI Bus Class Devices
  */
@@ -721,174 +889,6 @@ static ssize_t boot_vga_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(boot_vga);
 
-static ssize_t config_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr, char *buf,
-			   loff_t off, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	unsigned int size = 64;
-	loff_t init_off = off;
-	u8 *data = (u8 *)buf;
-
-	/* Several chips lock up trying to read undefined config space */
-	if (file_ns_capable(filp, &init_user_ns, CAP_SYS_ADMIN))
-		size = pdev->cfg_size;
-	else if (pdev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-		size = 128;
-
-	if (off > size)
-		return 0;
-
-	if (off + count > size) {
-		size -= off;
-		count = size;
-	} else {
-		size = count;
-	}
-
-	pci_config_pm_runtime_get(pdev);
-
-	if ((off & 1) && size) {
-		u8 val;
-		pci_user_read_config_byte(pdev, off, &val);
-		data[off - init_off] = val;
-		off++;
-		size--;
-	}
-
-	if ((off & 3) && size > 2) {
-		u16 val;
-		pci_user_read_config_word(pdev, off, &val);
-		data[off - init_off] = val & 0xff;
-		data[off - init_off + 1] = (val >> 8) & 0xff;
-		off += 2;
-		size -= 2;
-	}
-
-	while (size > 3) {
-		u32 val;
-		pci_user_read_config_dword(pdev, off, &val);
-		data[off - init_off] = val & 0xff;
-		data[off - init_off + 1] = (val >> 8) & 0xff;
-		data[off - init_off + 2] = (val >> 16) & 0xff;
-		data[off - init_off + 3] = (val >> 24) & 0xff;
-		off += 4;
-		size -= 4;
-		cond_resched();
-	}
-
-	if (size >= 2) {
-		u16 val;
-		pci_user_read_config_word(pdev, off, &val);
-		data[off - init_off] = val & 0xff;
-		data[off - init_off + 1] = (val >> 8) & 0xff;
-		off += 2;
-		size -= 2;
-	}
-
-	if (size > 0) {
-		u8 val;
-		pci_user_read_config_byte(pdev, off, &val);
-		data[off - init_off] = val;
-		off++;
-		--size;
-	}
-
-	pci_config_pm_runtime_put(pdev);
-
-	return count;
-}
-
-static ssize_t config_write(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *bin_attr, char *buf,
-			    loff_t off, size_t count)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	unsigned int size = count;
-	loff_t init_off = off;
-	u8 *data = (u8 *)buf;
-	size_t ret;
-
-	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
-	if (ret)
-		return ret;
-
-	if (off > pdev->cfg_size)
-		return 0;
-
-	if (off + count > pdev->cfg_size) {
-		size = pdev->cfg_size - off;
-		count = size;
-	}
-
-	pci_config_pm_runtime_get(pdev);
-
-	if ((off & 1) && size) {
-		pci_user_write_config_byte(pdev, off, data[off - init_off]);
-		off++;
-		size--;
-	}
-
-	if ((off & 3) && size > 2) {
-		u16 val = data[off - init_off];
-		val |= (u16) data[off - init_off + 1] << 8;
-		pci_user_write_config_word(pdev, off, val);
-		off += 2;
-		size -= 2;
-	}
-
-	while (size > 3) {
-		u32 val = data[off - init_off];
-		val |= (u32) data[off - init_off + 1] << 8;
-		val |= (u32) data[off - init_off + 2] << 16;
-		val |= (u32) data[off - init_off + 3] << 24;
-		pci_user_write_config_dword(pdev, off, val);
-		off += 4;
-		size -= 4;
-	}
-
-	if (size >= 2) {
-		u16 val = data[off - init_off];
-		val |= (u16) data[off - init_off + 1] << 8;
-		pci_user_write_config_word(pdev, off, val);
-		off += 2;
-		size -= 2;
-	}
-
-	if (size) {
-		pci_user_write_config_byte(pdev, off, data[off - init_off]);
-		off++;
-		--size;
-	}
-
-	pci_config_pm_runtime_put(pdev);
-
-	return count;
-}
-static BIN_ATTR_RW(config, 0);
-
-static struct bin_attribute *pci_dev_config_attrs[] = {
-	&bin_attr_config,
-	NULL,
-};
-
-static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
-					      struct bin_attribute *a, int n)
-{
-	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-
-	a->size = PCI_CFG_SPACE_SIZE;
-	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		a->size = PCI_CFG_SPACE_EXP_SIZE;
-
-	return a->attr.mode;
-}
-
-static const struct attribute_group pci_dev_config_attr_group = {
-	.bin_attrs = pci_dev_config_attrs,
-	.is_bin_visible = pci_dev_config_attr_is_visible,
-};
-
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
-- 
2.31.0

