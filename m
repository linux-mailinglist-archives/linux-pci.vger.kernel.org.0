Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE881D9E77
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgESSBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgESSBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D2C08C5C1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so372522wrx.10
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tdr2nbJDVREjEd6opf3N1PUExNDbBuhp6Y6q/Aa2PEk=;
        b=HkelvqOK2ASLLh8prk/cDS5hZTdQU9xrr2V3ZxvDu0Sq7ohsTnzBnIMz0gnehYydrd
         QbNe0r28o6KsNU4c8jG6/OECzBTt1dgbKqKBO3Hy9R096LEbCLBtm5fJCXyPcoLUqC7z
         nJYdYMckvaByveD0Pss3OR0UJ2rAqvk1aa9NiHwQWgUQzWYyPlH/WdC5rnr0FA7nXTHT
         wUy4E18JFZwuckNo0n2C9EJ91f2GqeXNIr2Vo1ubIjolcQVPov+bsWVCo6uVm3u+gguw
         ifDXz+1XuUSPfCuU2aV4GnReJ1qkGO0jRWJcKZ8SusFCa4UK2engyDtkMxBFLorw/oqX
         3ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tdr2nbJDVREjEd6opf3N1PUExNDbBuhp6Y6q/Aa2PEk=;
        b=IMekpfbs0b5rXoF+x1dDSmBlyLcajXWhnpj+K0E0ZiQfFGixD8DIiJnzY+GnS0hZq6
         prcfe6Ob2jIBziAUOaoM832Wl9yO1FaVTW5/jfOOt3LXseEsYoffClWoCDg7XBOyGsb1
         WisrBiXBkLM/VS5+c3U5AAaqXzvu8aoIFYCO3aKxXsx/sfNQwhQRz6dOz3rJbu6OrklL
         ohJ2BhjMFoHxjrH/cO32Kdmp50SabZgwZjdU3P2TwbGjKMq8ZJptDS4ZsnKMAEQo2aF1
         VTTFtpOWE6EU1qm3D+uqRcUUul6/fnhCQ70zr+2KdXGaqWEwzeZHCWIFwEDzfWppfbx8
         uavw==
X-Gm-Message-State: AOAM531PFzT4aIEF6slIKmY/s5pg9mmPtHM5+87vmxf3vnHsTLBLyU0L
        k7fQe2C5KbpboiD2/DKue04B4g==
X-Google-Smtp-Source: ABdhPJynWLyIUGdI5MUqsN8GOzUd3ADLnVQan+95nD7CN0va9fcQVLO9UHUTvmOnyfYBlYSmz6uVWQ==
X-Received: by 2002:adf:c508:: with SMTP id q8mr125580wrf.4.1589911312245;
        Tue, 19 May 2020 11:01:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:51 -0700 (PDT)
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
Subject: [PATCH v7 09/24] arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
Date:   Tue, 19 May 2020 19:54:47 +0200
Message-Id: <20200519175502.2504091-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
share CPU page tables with devices. Allow the driver to be built as
module by exporting the read_sanitized_ftr_reg() cpufeature symbol.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb..5f6adbf4ae89 100644
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

