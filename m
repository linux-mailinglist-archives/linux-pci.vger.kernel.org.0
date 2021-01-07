Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251852EE7E4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbhAGVuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbhAGVt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 16:49:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9AC0612FF
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 13:49:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so7018403wrm.11
        for <linux-pci@vger.kernel.org>; Thu, 07 Jan 2021 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maLvzjwdRjUhT4+Mi5M/u/G3+yYkiL+pmLkeR0m0nPo=;
        b=l68RRtRZ9ujZwh5kUmD68Zx2+JYfdIOECjYsYHkkm5fgbMnjQUY7t5/CoaHLy4dVgd
         1AQRPdoeu+pvjnkcoovNauM6r7GKARQmUrXRU6vv0A1Z0voT4G6QdchjR7hxbbzFj2GH
         N9pnzYN4XckaBVe1RcP/Kwe0RFqQ2qputu4gz19xEFcF/JXbjPVoFamSDlLAyUO2p9Z5
         cY9hhsb4KoxXOxT5Ppny2mJ9+nyyOanFC8M2b4F9g3l//bybTbgWy3aEATpusbp5ueMo
         e81YqglMIdMMnlQgUuQka6+sGrfiNwpzWFShLAxFZAMJGqrphwyIwGdHu4tC4gto1bDY
         sQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maLvzjwdRjUhT4+Mi5M/u/G3+yYkiL+pmLkeR0m0nPo=;
        b=sSO1XSTm+vtPuba8CBFCWWHx+ruqpv8l2Alg1ktoejYTRIkQ6WUCu541JwHxWP9MWu
         q//ZjEtLXTZkVNWBLvh6NitF+RnTUS7/lDWiInhwbPhxf+yuc5xljgnLwX7rfs9VPYiP
         1pm9Noqha/fpx0YQotrY+LAFxj45/4OqRwnkMfipy+W2U/bPLTXjeqr4k92QLwt9fQ2o
         dteCkR7D2pk0ffycW9Xwttn3rjpzQNigkMtqZMoi/hI29Rv7XPHo4s3D8SSz9rtQlE3+
         PQ2MFTuCuVn0vHExQPIboEAtBiQXjeDPpsIpqmu6BUrwsTe2Lm86iIRTXFIC9MCnB+cB
         LGjw==
X-Gm-Message-State: AOAM531IAmYQxnG+VE15Ljde1wIE2jtujdLZKwKW7HWvNFhFdGt6mQe1
        H34mse1LYmolVmjPefPw/k/m18MPChs=
X-Google-Smtp-Source: ABdhPJzt2Pcu9xRfRn27AdZ/pTVpe3LElxFwDgrfWr/JglXqq3bfi19RBYF1AXTx2Os4JryK1HVj/Q==
X-Received: by 2002:a5d:570e:: with SMTP id a14mr599699wrv.126.1610056140926;
        Thu, 07 Jan 2021 13:49:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:bc23:c288:f1cf:8157? (p200300ea8f065500bc23c288f1cf8157.dip0.t-ipconnect.de. [2003:ea:8f06:5500:bc23:c288:f1cf:8157])
        by smtp.googlemail.com with ESMTPSA id o74sm10845332wme.36.2021.01.07.13.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:49:00 -0800 (PST)
Subject: [PATCH 2/2] PCI/VPD: Improve handling binary sysfs attribute
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dba8e8ad-5243-ee84-38bd-f2b131f4b86f@gmail.com>
Message-ID: <f527283c-3e4e-5574-e917-519a6cc0e8b9@gmail.com>
Date:   Thu, 7 Jan 2021 22:48:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <dba8e8ad-5243-ee84-38bd-f2b131f4b86f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
there's nothing that keeps us from using a static attribute.
This allows to significantly simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a3fd09105..9ef8f400e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -21,7 +21,6 @@ struct pci_vpd_ops {
 
 struct pci_vpd {
 	const struct pci_vpd_ops *ops;
-	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
 	struct mutex	lock;
 	unsigned int	len;
 	u16		flag;
@@ -397,57 +396,38 @@ void pci_vpd_release(struct pci_dev *dev)
 	kfree(dev->vpd);
 }
 
-static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t off, size_t count)
+static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
 	return pci_read_vpd(dev, off, count, buf);
 }
 
-static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
-			      loff_t off, size_t count)
+static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
 	return pci_write_vpd(dev, off, count, buf);
 }
 
+static const BIN_ATTR_RW(vpd, 0);
+
 void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
 {
-	int retval;
-	struct bin_attribute *attr;
-
 	if (!dev->vpd)
 		return;
 
-	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
-	if (!attr)
-		return;
-
-	sysfs_bin_attr_init(attr);
-	attr->size = 0;
-	attr->attr.name = "vpd";
-	attr->attr.mode = S_IRUSR | S_IWUSR;
-	attr->read = read_vpd_attr;
-	attr->write = write_vpd_attr;
-	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
-	if (retval) {
-		kfree(attr);
-		return;
-	}
-
-	dev->vpd->attr = attr;
+	if (sysfs_create_bin_file(&dev->dev.kobj, &bin_attr_vpd))
+		pci_warn(dev, "can't create VPD sysfs file\n");
 }
 
 void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
 {
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
+	sysfs_remove_bin_file(&dev->dev.kobj, &bin_attr_vpd);
 }
 
 int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
-- 
2.30.0


