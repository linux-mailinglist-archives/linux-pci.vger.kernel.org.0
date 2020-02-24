Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3116AC79
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBXQ7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38409 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgBXQ7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so11253427wrm.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HIxi7ZL1ytSixldA0X7x1yzZ6pxdx7GHOJTgPsbD+w=;
        b=h5rEfPIuduIQsDpoF+aKzWlaxFkIu7NDgF+GUcFIIt/VEnEoT0L5HPk9fkl7MEJle/
         Ud2/GAlx627mLkL/h0OM7o+RKQDlXhqbE11lN9bmjiCsn4DNjmUERD/jrlTqzVJWNjj4
         GKsFp79swWzlVETvQ6zeOwXBwvIXoqOkTvFEc5iELSunxPmlJa3C9IoktYgPNSri85j6
         dOsjcm5aopJ5Wg/HN4EeLpWdLgJf2/AhAp5ryL71MVMahP0aLdvn5AtDO+E46a0UO5F/
         xsZMf+Gj1g+5qy4Nt1bFFOG67DXu65lwChW+sVk7kYxBwmSFM94vz6m+bs8D32j8JX1B
         kE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HIxi7ZL1ytSixldA0X7x1yzZ6pxdx7GHOJTgPsbD+w=;
        b=Mdox3KLuyPzbazIjH2ATvkH/0sFLCu0x2LHlDfyxdtzA0VmGKxSrqO6NIaP2ZMZiew
         DsL+hP8TLlkkpAI7fcyDD4SZwP3HBHblkxsUg/fuKVj2huAMfzirM1s1A4QyqEu7nge5
         s++rPYTSfvNwpsZEG5IWrW9i5fHfOwbXKd+clFiD0umMi5Gw2W3YvKFMtEzN1kQ/S5Dg
         yB33wJhrNrPFgBOGDE0C7UGgiB0NlJj+fkneu9eUu+BUbZvwgSpigcPIIXHpYYJdiNdp
         7jRgvE8MVs21aOV7Vm8cEOgj+rzBKIv0IwOUbi36gCxNFLi5q05bH4a0bxexFfwR7Fcv
         QOag==
X-Gm-Message-State: APjAAAW9T2CNV7d8sCecF/QXrKjm/O6nk9hD/UcXQ9DZn3ZtTTQhc0IV
        jmfEBU0bHemW0Ql/gXVFpGPKe6TYr/0=
X-Google-Smtp-Source: APXvYqzKuk1DCPA9bZvrQ+EiIsobd8Fn/PAZ2IzLOJ9Fytea0eB2ueRowKL1GRPNmrrjY6GtmuesjA==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr14316725wrm.270.1582563545042;
        Mon, 24 Feb 2020 08:59:05 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:04 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 3/6] iommu/arm-smmu-v3: Write level-1 descriptors atomically
Date:   Mon, 24 Feb 2020 17:58:43 +0100
Message-Id: <20200224165846.345993-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use WRITE_ONCE() to make sure that the SMMU doesn't read incomplete
stream table descriptors. Refer to the comment about 64-bit accesses,
and add the comment to the equivalent context descriptor code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6b76df37025e..068a16d0eabe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1531,6 +1531,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
 		  CTXDESC_L1_DESC_V;
 
+	/* See comment in arm_smmu_write_ctx_desc() */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
@@ -1726,7 +1727,8 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, desc->span);
 	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
-	*dst = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
 static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
-- 
2.25.0

