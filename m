Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBF16AECA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBXSYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgBXSYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so11536712wrs.12
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiWmOcLAVe+tVXhcsvVE1DFO1O4ryIgAcLdwqW0ca+M=;
        b=pDRHKweDnlBKRULwy0ik0zwEBtEv1j2cgrRKvimaQC6F87phqKiS6hoWHYe79Woxaq
         dvU2Y+udalR1IWc9MZSMY0Zs5f9NdIHxKJhYe9t+iiuM18v5G9IPkB7YyVsl1xvn6G0k
         Lyx8J36rm2ynK9P22EeAO7k6RYA6roW1f6WRVmaqmmlmQjHQxIyE4MBbDQS/EJmu3I3p
         Qd3S4xWYoA2d1rHcA8AWP0OW4En+tWRi+9rXYw9g503nUnZih/bJ/n2/yoE090xj2LJU
         H5r4hDx2HFNGusqI0S9/YfyB+pnbzKC6Jhc3+KlEeOqTYu+SoSFgOQm1PAsvdd7NVhoF
         WL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiWmOcLAVe+tVXhcsvVE1DFO1O4ryIgAcLdwqW0ca+M=;
        b=ku0bDosAzN47CyaEDPFaEeQX1FXLvlrHG1heCT+9WJk2RbZ/Dsm+skySYqvRoSY9rZ
         9AYJ4shPihR6Nq1hQG0q7vSMAUyZe+fClhZjqdBuWr80cJtjGUHfYALKg1nGqMEg08kO
         fD0CNa8A88bmxv48rOhuyQRZUACLSIv61ylMwJ/GC6PQhXtgsaM4chdrPKAlzNtes3fX
         wdwN51m0Cm1iGmiDI3aJVCIpCYf++IlgBp/zregUKy1sA8Fd6MnjZX5gnWQ/2ppN973j
         OkfufQUB6JFzEVBfHeyeog3E/yfNfAu1BTyz8AyiVpcw0XLvrfXAHUVMOkYUWCXPgvNc
         8vBQ==
X-Gm-Message-State: APjAAAUgcTbYxEXjxZfWDKTM8HVytMkr4yQFoJxM+qtZXdVATrwWAhIW
        iybQNApjBStenbAgYk19C6is6Q==
X-Google-Smtp-Source: APXvYqz8CuJxubqS6SRPcAebK5WrAwOgc3vNvNYTHpZ8VXVrF/jAhnwu+rN8D9EGJiHbmYtTOasOQA==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr65031300wru.87.1582568680476;
        Mon, 24 Feb 2020 10:24:40 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:40 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 10/26] arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
Date:   Mon, 24 Feb 2020 19:23:45 +0100
Message-Id: <20200224182401.353359-11-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver would like to read the MMFR0 PARANGE field in order to
share CPU page tables with devices. Allow the driver to be built as
module by exporting the read_sanitized_ftr_reg() cpufeature symbol.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b6715625cf6..a96d2fb12e4d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -838,6 +838,7 @@ u64 read_sanitised_ftr_reg(u32 id)
 	BUG_ON(!regp);
 	return regp->sys_val;
 }
+EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
 
 #define read_sysreg_case(r)	\
 	case r:		return read_sysreg_s(r)
-- 
2.25.0

