Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648AB1E2138
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgEZLtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbgEZLts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 07:49:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15943C08C5C1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 04:49:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so9988010pgm.0
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aQLHuck/H6hUhxdEpWbnpYG+y4hFu1KRyBN1f+7zkW8=;
        b=XirmZKzM+LLXAtNZtlVmQwpy7SRWcMC0TYlRFk6EZGxsqxO252W3y8Nbx4uWD13qJw
         t6QjUR70f+5VrzW+sLYKnb8N8Jp5p/D00A51Ue/rxj4SAEosbp4CeVDJsJSIvPSWRds6
         /mk9A2jA56M7p0pSDTmMSNjOjPAWeCn/FACm5/I5azIw1lC3WMp2WR3XnbKbz9xqsl2/
         ulTm4r8T6NUFIzbvPYU2rllFJGPgCXxuSK2bWEK8Oovu2ZNsAUny/uwETLINLVVqPbNh
         AC58/ztbWIjpzc0KrCChbcnxAr9RxwVmBX0Q6vVr6ifmh4olUxNMQiOLvWnSfEcQiZg/
         3Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aQLHuck/H6hUhxdEpWbnpYG+y4hFu1KRyBN1f+7zkW8=;
        b=Mr+07gMe7i2CgoFhq1RpnXOErWFSdy8SKbEjx8eOm30na318wH5rqge1RZ4O1oYlC4
         pPGfvaHyyW+gNTJaz0qFskSAouUqf+JHVTKsEKxVk71SCTNokJKnfWt0WA8y+ZqUS1/q
         5snfzlCp9Pfok4R5zf3+kr4wz+9+bCAoKL6F7ArFr5+NLg+LbuvATgNFEVnnt8cod8dz
         mSgoV0S7fEQzu2YHL7oAkggWy1mgpP7VhrPrRN2QdYi35BnIW1HbqzN5aTVzEAchRQad
         eUogh5qzQUEZ+ST4+HZxPFN8kvL1NUnhe11cUblvwAZl6AO83j6bF1yWqEp/477N7nQM
         wsaw==
X-Gm-Message-State: AOAM533R3wnEJA4DWJExBmo2nBBAEBbbCFDxTQ/0K+L3q3sMhxhyHVl5
        dpL5nqUOCftpRiNNWqbzsCBuxQ==
X-Google-Smtp-Source: ABdhPJwWqcev50wczjJKTLuB5KeWjX6Xh40o0PZ2aKsrj0RnXDD5TWs804Gl6GBeG4uho5hk5LIVkg==
X-Received: by 2002:a63:33c6:: with SMTP id z189mr714101pgz.426.1590493787584;
        Tue, 26 May 2020 04:49:47 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
        by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.49.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 04:49:46 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Date:   Tue, 26 May 2020 19:49:07 +0800
Message-Id: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platform devices appear as PCI but are actually on the AMBA bus,
and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
down iommu probing as all devices in fixup final list will be
reprocessed, suggested by Joerg, [1]

For example:
Hisilicon platform device need fixup in
drivers/pci/quirks.c handling fwspec->can_stall, which is introduced in [2]

+static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
+{
+    struct iommu_fwspec *fwspec;
+
+    pdev->eetlp_prefix_path = 1;
+    fwspec = dev_iommu_fwspec_get(&pdev->dev);
+    if (fwspec)
+        fwspec->can_stall = 1;
+}
+
+DECLARE_PCI_FIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_iFIXUP_IOMMU(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva); 

[1] https://www.spinics.net/lists/iommu/msg44591.html
[2] https://www.spinics.net/lists/linux-pci/msg94559.html

Zhangfei Gao (2):
  PCI: Introduce PCI_FIXUP_IOMMU
  iommu: calling pci_fixup_iommu in iommu_fwspec_init

 drivers/iommu/iommu.c             | 4 ++++
 drivers/pci/quirks.c              | 7 +++++++
 include/asm-generic/vmlinux.lds.h | 3 +++
 include/linux/pci.h               | 8 ++++++++
 4 files changed, 22 insertions(+)

-- 
2.7.4

