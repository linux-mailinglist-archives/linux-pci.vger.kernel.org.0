Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030B8377AE5
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEJEPf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:35 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:46030 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhEJEPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:34 -0400
Received: by mail-ej1-f42.google.com with SMTP id u3so22359265eja.12
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaBjjWzOw5dvTDC+qJZK86V8BlRmiuqHS5dgLumUkUo=;
        b=iXmcqW0HEdmyYlu225A66jdg5vVSUtEFTRKd6aEYkZFVE4MfGw2KWidDwyzC6qf7DN
         HDWADDsEALpcfEyCKZdTqjafgT9MlLPKYlXrvusUhJZXRrJ8xkrHs9TTEAunNWhAkGYs
         5hg1hwMxT0GaopKnpZyAxcczABnXZi0o8aPVUZA4SJSvmhBINY7Zz+7/u1DmjqjZjkuC
         yeEm3vzIrVi3VRdpiKQ4mFWiMPvfOmtYOwQMl6I4S5ML0m+wRLRGxWum42fuU+sCoiyO
         tdNXRlXAsRtWWxlaofG/q8b/WW8Ei8PS0+gZHzuKpblKwtmJK/vptap+j4WdBo6yF7xg
         TAvA==
X-Gm-Message-State: AOAM530394KvNWSNVThKuTR8KG1cjO2ehRMpwHqcD4ZiZv06QW7MSu5Q
        1JRhc3U6vF1zCYY7LZmI9KBrvt6QUcTfVQ==
X-Google-Smtp-Source: ABdhPJyVN7OmrxmLXunnm+i/g7DrV7L4eUJP8vMwGRDaV0dhHNlOxv65JKYxSA9NZu4UydDdD9JbhQ==
X-Received: by 2002:a17:906:5791:: with SMTP id k17mr23090058ejq.296.1620620069892;
        Sun, 09 May 2021 21:14:29 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:29 -0700 (PDT)
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
Subject: [PATCH 05/11] PCI/IOV: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:18 +0000
Message-Id: <20210510041424.233565-5-kw@linux.com>
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

