Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E371A86A8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbgDNREh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391339AbgDNREe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E945C061A0E
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so14958652wmh.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOn2/ivBf+XmB6Al4WmdsHcps0QyIiLuo8qefeV2C0s=;
        b=Z0Yp2WFwHT70u0R7Wr7R5AhtdbVQPNTMNufdFuXd+ENpRenI7zcZxRtj1eDH/8DVxK
         w7N9nOpW7sEG9K/u3l1KC6rScagAtd4Om9U5KNXAa5xEBG0aKQFAomBQj49jMwAx80bm
         VnyWFWc4Yzp3RbBcbzqkmhqjzSXUGlBrfV9Kgixw0dzjGUnOx/ApPNVuQ8gPPBhxSY5/
         4wGrHj0nf+rS03Agdvzb84edls0jQzbEhQ/0sOzl94i50gjL44IGJs4I98eE/dCmXuXl
         D4QQcRCEFAxwwKcohtYfh0JlVaKZdefOyxLVJTOa7V2u0lkZCvT24PKYz706K9mF45p0
         UpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOn2/ivBf+XmB6Al4WmdsHcps0QyIiLuo8qefeV2C0s=;
        b=TREwsMZpNyFnEHpVq1JPzlC10rs4z+3b1TsS8MMRCQSeI5RkrF6iFSL4kgO8DTaQv7
         hyE9+4txVPWZveo7wqd3prLFxp2bQkVliG9RAJsHprHLRJ0NYCO3t/XCfLcyrt7LTcmr
         g+tI1B759oP5Pir4FpetA2BCbV5Pg3GNOfx+pnLpXPv68mTs59kQsdWtwcPwduOBuKKH
         CAO6nzyesZljGv5C6HJDuJPgBikLDJtMYHeczqqLdAk7vbO7ZrRy8l6z9pcsQ3adiTNG
         EOztH/9qpVW012JeIPDoeca8ATWy+Uw+UZsx8auVBPFSND81Rxmd2HYncVZbV8C9/9ve
         f1Vw==
X-Gm-Message-State: AGi0Pub8abErxr30L0OmEC1ARPiEyHo3a7Rd7m19ZNSlmqwAhvvPJ0M1
        XD/XhGxIGN1T4yNgQJ5XSLlBlw==
X-Google-Smtp-Source: APiQypJHABOUo0l69p8cEPC/4JaEesvnVVdt7c8KNCFhOJxICd+3rtd3OwSved0AadUjHTnKij1dPw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr776151wmc.62.1586883872984;
        Tue, 14 Apr 2020 10:04:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:32 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 11/25] arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
Date:   Tue, 14 Apr 2020 19:02:39 +0200
Message-Id: <20200414170252.714402-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
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
2.26.0

