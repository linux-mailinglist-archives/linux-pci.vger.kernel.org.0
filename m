Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE74B387048
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 05:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbhERDmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 23:42:37 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43522 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbhERDmg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 23:42:36 -0400
Received: by mail-lj1-f178.google.com with SMTP id w15so9765677ljo.10
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 20:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjB3rHV3Gs9lLrvtOrxv7pRKv1N16KnxMCWrz2+cCtE=;
        b=NBbd+kCrnEMvx8VHOxZ0KFk8YzV1AYOgkaJhSjH4SUjQiF06kLHv/Q1WYfNr6KD8v6
         Q1Yt1nhbx56IzfUaY5uXTSXucYFeGyHXRtXoZSzVoETI1bcf/LOFWHmVXEX3KlbQoM/F
         uT1gQZ6w1I0eYjbheWUwstfnYmCj/dfFK0EJjTqRkaE5hxJxcYhvFGOv3eAU5+erQJAs
         8uNWcGo1lI8TWAKVEcE+0QCUvVO327imSAKZzusnbOX1bFoBWH1dlogPeW0Y671oHPmc
         oxpl2GcWbUDemkkgY934Hfa0OlPrbGOIetXsSOuxKN+j1SOXgvW8wjHTMHQ9oqX6fncN
         oIHw==
X-Gm-Message-State: AOAM530tpetPOnzh9hj7CVhGk3OQpOXe+sGBuxd0sFetTfOfqhIIrFeD
        LUOCwRwt0QiDEcb+eK/S710=
X-Google-Smtp-Source: ABdhPJxpe/XC7QxjGb2CyJjnubIAt+mNpUZwGzlu6CR1lOvtQUVF44rrJ88kui34Efp/yizHoFQEpQ==
X-Received: by 2002:a2e:bc23:: with SMTP id b35mr2358933ljf.378.1621309277631;
        Mon, 17 May 2021 20:41:17 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j23sm419112lfm.276.2021.05.17.20.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:41:17 -0700 (PDT)
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
Subject: [PATCH v3 07/14] PCI/ASPM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Tue, 18 May 2021 03:41:02 +0000
Message-Id: <20210518034109.158450-7-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518034109.158450-1-kw@linux.com>
References: <20210518034109.158450-1-kw@linux.com>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes in v2:
  None.
Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

 drivers/pci/pcie/aspm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..013a47f587ce 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1208,7 +1208,7 @@ static ssize_t aspm_attr_show_common(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sprintf(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
 }
 
 static ssize_t aspm_attr_store_common(struct device *dev,
@@ -1265,7 +1265,7 @@ static ssize_t clkpm_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sprintf(buf, "%d\n", link->clkpm_enabled);
+	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
 }
 
 static ssize_t clkpm_store(struct device *dev,
-- 
2.31.1

