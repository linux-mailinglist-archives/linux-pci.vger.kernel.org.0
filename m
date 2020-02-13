Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBA15BC6D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgBMKOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:14:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46146 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:14:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so5888876wrl.13
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75Ftdk1VkfsWCfyfd11tlv6ByY0EWRz2RXyuqWcTsCk=;
        b=MXBaowXsv5/KjGlJHGIVcJorZztVg4eKrM/0w4F0HaKMkhG7uZ2qpG0X5g06zIZ8KR
         JnvtB5DqxM5AgwN7+3b7Wzy/vFzqAreJ/+vi5VJzrqZ7NhUOdm/sjLs0apfmXzQOdYkf
         Os4dy5aCRHTv04//SmgM6n1wj/O42Jp8ACsQy+/eig82sByEXqlJhyFrDIIA/eGWwOXO
         1diY5LShRv4n2zK8u1QDFgf0OQ3NB/zGYXZyfr4uUbUEwvA7vOThvs8tguvgjdcGGU93
         ajPMjEjhiF4BL/q+Faw5CpisW0B6BCxtZnVvi+Ecuv97amlyxGaybdu2D6eh5DGwV4Lc
         GUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75Ftdk1VkfsWCfyfd11tlv6ByY0EWRz2RXyuqWcTsCk=;
        b=m6qpk9PC9fWJYNXJVUM5NynBM1tAkAWZNw+lynpXuYk16pLotzRCNUqiy41kbu7w9Z
         xG6tCpBDWjFk61HGFoinBc9fYfSmdRS1q721RCeA+EgKKD/lAaYzx0a1VcUO2YBEOkCZ
         6m/g1u0nC2ni7DwYdp1oaZZ//8dWS/2hExVaCvN2trv0kk1W5gbLxeYJxv66bsf4GeEh
         lV1XFgVHtfYHyWrv7hy8uaFtytbfS0dD4PyMdao0y/ZUmjpWSkjNYGO8wkATUCP9LA3j
         d4S0qQRiGx6Dhq5l1S3Cqw2yRMeWKRQIPpmkDJeTZQ8/CoCweAbn3k7i3pMOBYoH02VO
         SOIA==
X-Gm-Message-State: APjAAAW5oWC7XoIXSLM2I1Z9FaRWzK4gXTkAW6WwQ1ZD6TJSdAYdcxuc
        c6VxFcHTtOkrhPeEGoobJ557jVu7An4=
X-Google-Smtp-Source: APXvYqyaY1njF+rZBaq9zhF3XVnI+fBQ+a+gjM1pwH0+xif4vevn+377YjCqBR53sPA0jLv2qnJW8w==
X-Received: by 2002:a05:6000:1:: with SMTP id h1mr19408168wrx.380.1581588884202;
        Thu, 13 Feb 2020 02:14:44 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 02:14:43 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH 0/4] iommu: Finish off PASID support for Arm SMMUv3
Date:   Thu, 13 Feb 2020 11:14:31 +0100
Message-Id: <20200213101435.229932-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support for context descriptor tables was added to the SMMUv3 driver by
commit 87f42391f6a5 ("iommu/arm-smmu-v3: Add support for Substream
IDs"). The last patch enabling PASID in PCI devices couldn't be included
right away since it would have prevented from building SMMUv3 as a
module, another feature introduced in Linux v5.6. Export the relevant
symbols in patch 1 before using them in patch 2. Patches 3 and 4 address
the other remaining comments for the PASID series [1].

[1] https://lore.kernel.org/linux-iommu/20200114154007.GC2579@willie-the-truck/

Jean-Philippe Brucker (4):
  PCI/ATS: Export symbols of PASID functions
  iommu/arm-smmu-v3: Add support for PCI PASID
  iommu/arm-smmu-v3: Batch context descriptor invalidation
  iommu/arm-smmu-v3: Write level-1 descriptors atomically

 drivers/iommu/arm-smmu-v3.c | 78 +++++++++++++++++++++++++++++++++++--
 drivers/pci/ats.c           |  4 ++
 2 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.25.0

