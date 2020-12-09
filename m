Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525542D38F2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLICqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgLICqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 21:46:47 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD4C061793
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 18:46:07 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y10so157687plr.10
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6CXkt7XQRmTS6IAY9O5gfocreD0xWeDQV3rSfuBX9s=;
        b=ZmQLEKebxKoEzpOQ5dtdNbqyYMje7zhUcl4A10rmbCj9PLztJjRVGh1NCkZCEkgTUr
         5oNf4qFvCFAu7IIyLLNE3a90NlHM8l1HLqSo0pnPLzxKYqj9PxJQ6P41mruqRcVP1HTe
         kz2enxAdoqoOS3YG3EMdqlh1YwcjjbUqPDRmlKr6bFSkKhGBgHSPfqjWR2N17JliKQkz
         Bd+gzgzXUQl1rkJRpry3GU/pD9rsBfVCsN1B4hzlxF3k0JHmt1iSRNXgAbQ1+ZVdKAuR
         uoY7ifPnoawTWlmTn+obZqxsexwBpqVA4qrLOVDv101gD67qBEoIdSvlFPD7QUJ/OZR+
         pcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6CXkt7XQRmTS6IAY9O5gfocreD0xWeDQV3rSfuBX9s=;
        b=b/R4Q9ItsJ98GflPWH1vdmRjVF97wEXdQeiSzSuh6rVGQjvBRXKlGa0NnZrT0q/sem
         PmON0lw+J0LOztE8/6btaTxc+62gsz7p643IeINrH+Q978bBcFXngtjtrgJjf0NZC0qm
         KrEJhHmipeJop72Kqah+yGzoHeWvJYy86WNoW8v+xVXvKB+cPewy2m4I2JxsSwE7EHt0
         oO8FzZcFSpuVFsw7u6QwRrC6kCt8iGLFv8FG73gyXRDeJCy6xuEhfjGyb7DmORJ54Qbl
         4r0wsY/X5oSqNRp9K6HS/bJNDucPGmHqjvouUEBxRRQ/XmpK4QSmUmdbsFbzCZXcrulV
         7J0A==
X-Gm-Message-State: AOAM532RHcOGZbD5mwVGsnkgN3rXrjPtOORUKd0/i0UpLk/ehg1m3JvW
        cJB0upTHLfLc1aSp4AUMPpIy
X-Google-Smtp-Source: ABdhPJzy1SqEGEEhxTxwxsIHKQ3i0BzmQlinwG3xVRlxXN43akFhhVqe3xY9+CTUv3oRrfcwqy3Zrw==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr196846pjr.231.1607481966568;
        Tue, 08 Dec 2020 18:46:06 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id g34sm155678pgb.33.2020.12.08.18.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 18:46:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH] PCI: qcom: Fix using uninitialized smmu_sid_base variable
Date:   Wed,  9 Dec 2020 08:15:55 +0530
Message-Id: <20201209024555.14116-1-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

smmu_sid_base should hold the base of SMMU SID extracted from the first
entry of iommu-map. This value will be used to extract the successive SMMU
SID values. Fix it by assigning the first SMMU SID base before for loop.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8ba3e6b29196..affa2713bf80 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1297,6 +1297,9 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 	/* Registers need to be zero out first */
 	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
 
+	/* Extract the SMMU SID base from the first entry of iommu-map */
+	smmu_sid_base = map[0].smmu_sid;
+
 	/* Look for an available entry to hold the mapping */
 	for (i = 0; i < nr_map; i++) {
 		u16 bdf_be = cpu_to_be16(map[i].bdf);
-- 
2.25.1

