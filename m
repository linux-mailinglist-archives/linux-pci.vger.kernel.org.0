Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29A381600
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhEOFZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 01:25:56 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33715 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEOFZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 01:25:55 -0400
Received: by mail-ed1-f54.google.com with SMTP id b17so906632ede.0
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 22:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaBjjWzOw5dvTDC+qJZK86V8BlRmiuqHS5dgLumUkUo=;
        b=mGfyu4jrPv2viwCNu5P38hAx2GUqdLZM0A0DHJC43KtogkEGDXnzaSK9Bo3E6crFu4
         mGrdy9vOTAyoP2EXwxc1NYnyezJlPKVdfFigAjAaPa7TCmcB+NYn9bsslaPwEJYRL3uM
         ShlNlDAJ0JrSsZXlkYL5+pK5gFj6wkQSxmZUXilF9i0W+M8wA/hv3yghvcv9q2T6h+VE
         5Ck/kMzHHHryIU0UCU/GdPBz4EtwrYkANGfuGRpKF9n3T6wtOTyLsx7/LKWZlv96oTBa
         cGpVwUmYrnRxd8wS+/EwTPIcTTaTxjOo/ulPu3HEg9ehvurWiEbRld0MFf6FVFIEp9lO
         k0tA==
X-Gm-Message-State: AOAM533ygRM9QpGw2nvEBFPB0GkYqHrDBesbJmmkJp1Srr23JURfUbvz
        DT0R9meAVOHJgGEEPydFHDo=
X-Google-Smtp-Source: ABdhPJyAvW2Dm++VEmuqwcgqr9Jm9cUso1ruNLB2gDuMwnIl6aOLUg/209jLCyYGsCqG4kFGPH3syQ==
X-Received: by 2002:a05:6402:4392:: with SMTP id o18mr20003141edc.58.1621056280892;
        Fri, 14 May 2021 22:24:40 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id kt21sm4821487ejb.5.2021.05.14.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:24:40 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/14] PCI/IOV: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Sat, 15 May 2021 05:24:25 +0000
Message-Id: <20210515052434.1413236-5-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515052434.1413236-1-kw@linux.com>
References: <20210515052434.1413236-1-kw@linux.com>
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

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/iov.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index afc06e6ce115..a71258347323 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -346,7 +346,7 @@ static ssize_t sriov_totalvfs_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
+	return sysfs_emit(buf, "%u\n", pci_sriov_get_totalvfs(pdev));
 }
 
 static ssize_t sriov_numvfs_show(struct device *dev,
@@ -361,7 +361,7 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 	num_vfs = pdev->sriov->num_VFs;
 	device_unlock(&pdev->dev);
 
-	return sprintf(buf, "%u\n", num_vfs);
+	return sysfs_emit(buf, "%u\n", num_vfs);
 }
 
 /*
@@ -435,7 +435,7 @@ static ssize_t sriov_offset_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->offset);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->offset);
 }
 
 static ssize_t sriov_stride_show(struct device *dev,
@@ -444,7 +444,7 @@ static ssize_t sriov_stride_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->stride);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->stride);
 }
 
 static ssize_t sriov_vf_device_show(struct device *dev,
@@ -453,7 +453,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
 }
 
 static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
@@ -462,7 +462,7 @@ static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+	return sysfs_emit(buf, "%u\n", pdev->sriov->drivers_autoprobe);
 }
 
 static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
-- 
2.31.1

