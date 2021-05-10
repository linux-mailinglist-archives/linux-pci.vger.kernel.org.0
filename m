Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3287D377AE7
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhEJEPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:37 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38572 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEJEPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:36 -0400
Received: by mail-ed1-f41.google.com with SMTP id n25so17077380edr.5
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDGawuhAJJmz73B7uj32A5EHuzQVuuXCnB1idlmDenc=;
        b=QmFb4urJ6AS2jGPJ8x8tgE0wpvmwfgCZTDDQysixQ6kTyA25L3R5PU4IFMiukjFkPt
         oe8GvQbksJStUKun7NIadkD9JhiDju/l2DKVNTuCx+HV+/1QTY7UkOVrnXsVy1lxlnnX
         iXedOvCHW9v+xGegycpQNUBUD8YLQwIbjRqpCNJ9oxdhiXSw/BVJkF7mV17hYpfECGlW
         W4j7oOXf/RrAAGE+NbWe3KXWBGHf6066xVLZiy7IZkBU49UV56BTm2CfeRxnSNza2ZCV
         pZLnGENTWKMr6NINgRcMcG7x/xW5VX5zm78bxUtuLJ20JTeg7HqeL9ejPvGsT/+QDbNn
         F1RQ==
X-Gm-Message-State: AOAM531w4eAMka3b61xm8dFY00+lQcQpuoo6mezs+czE6jKlnvNq/cdy
        RcZ0lV0sl/RvVzI0Ni4VVmA=
X-Google-Smtp-Source: ABdhPJw8BjAeTOvXx1PzuicEvr2+9Hf6xbz/9p3ioUyMet+u4++O7hAY0Cmr1uZkz9NsrtS4fa+y9Q==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr12541384edx.85.1620620072032;
        Sun, 09 May 2021 21:14:32 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:31 -0700 (PDT)
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
Subject: [PATCH 07/11] PCI/ASPM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:20 +0000
Message-Id: <20210510041424.233565-7-kw@linux.com>
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

