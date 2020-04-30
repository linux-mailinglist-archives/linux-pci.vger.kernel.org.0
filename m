Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2C1BFEAD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgD3Okc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728182AbgD3Okc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880BC035495
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so7247462wrq.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRLktX4Fv4UiegcQ1XKfrXB/TH8/LTOUgoi8xC3haZQ=;
        b=GdxqERSg6Wq+QjSLrDklObgdKsWyrI/p2A6U4BFEZlyPUG/0SIcCQinPURmpCcRIjv
         3f5gJe4XY/u6yERJf9AwN+ZPq2bItwT/fSCgvMu08smasfLjOjOJxGrn+O0ElEcXqAXt
         3mpjlsAkdnOtr7eBUEquFjghsowytMyHCnwJbMdBG1W0oE7FrywpRTw78nLWSLKbfC7S
         +MhVK+j71pwZaHQOdr2Gde0ZOYTVwaFzIBka+fFjE+PTE5NEpEV43oSc/LN4IXGD6VD0
         4/CBaxt0Jike33CwfczPG3OxP+5W0s6u1z+Du0kqJEI8+0UBC180s6/Oj/dEyXpErCLG
         4rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRLktX4Fv4UiegcQ1XKfrXB/TH8/LTOUgoi8xC3haZQ=;
        b=kB7qPm4CibDSEwSGTmRECKeafLwFL8r9CKdI3xEVW54aWjI89xDFOSF87vDCYM4W4W
         rbg1m87iJlrORECd3M1sUw8eZTMEHbv4HdQubbS5JAicXOnGMJH2gEHbBqQ36tntIEuU
         G431FCxB0PydsiCKdTxgkpnt0xGvtXaQCYUDnEsWi7uKswZPh4DDjIAvUKHxXLKFys/7
         +/q1B4WAXQciePwxHWXGBvs+8sJFIakXvdBUdeTGAfX5WhAdXtAvumExwYverZJ/iSNE
         bC7kv2O7R/OEmrS7KPtKjDh/BSjoaozMA1aJtBKJBFMieHhdJq/P3Mf/fqGRgMFYj0Sn
         WVYg==
X-Gm-Message-State: AGi0PuZoqXi3f21fyAif+PHvHt7JoZwcMyKI4gKpTLMsBnHoS5+/xlEt
        VvY3LvD5wktEQog5dsuin0JLzA==
X-Google-Smtp-Source: APiQypKGnRA3rC4LIOfEdPstuV2izIDoWxEDRt3yJJdFAFTW4qtuKV91hxDhmiqWADguGvwulI61dQ==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr4210723wrt.407.1588257630518;
        Thu, 30 Apr 2020 07:40:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:30 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 10/25] arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
Date:   Thu, 30 Apr 2020 16:34:09 +0200
Message-Id: <20200430143424.2787566-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
share CPU page tables with devices. Allow the driver to be built as
module by exporting the read_sanitized_ftr_reg() cpufeature symbol.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb2..5f6adbf4ae893 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -841,6 +841,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 	BUG_ON(!regp);
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.26.2

