Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316D9462CF4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhK3Gpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 01:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhK3Gpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 01:45:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33225C061748
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 22:42:33 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r5so18673608pgi.6
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvByH85k2GhB0gfAkNHfHQT5cnwP0kCymtjlqEmdVEg=;
        b=rP2XIR3SzL0k9UD5LzqH+maIwpmypopDDn1/s7o6aJmnQ37C5OcSmZtlLBvGgWJcCd
         vFhOzv1iDCXGhscwnSqOV2e9LNuFCYmeveIEHJbCB/Sh04hzCHkrQ9I3LZFX6Gjl4NPG
         zV5SZuBx/pIo+vA4NzXYw0VrVyBJOAjZu8iAfj2BbU0/K4vL4e+P91LjeT3gfS5PrsPk
         uoQy1BPdSB2b3Dz9tCzOIn6dq03GYyorwPk3fzKzokhve5HtVOMmP9Wp8agZ42O6br8d
         ACWNPFQBDN4pabVExFzoi+uDIZrKzDHDETW5lkCkLhEewJ7f/9C8oUOX1oWy/zszSNRW
         c8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvByH85k2GhB0gfAkNHfHQT5cnwP0kCymtjlqEmdVEg=;
        b=fqAlWzOrAZo9sMAae3kXw1jdsPY3tPrreNOlIwBCLyCbKFPppChAnQTd9VIaE6zLZj
         fuW752r3MojyTucGbsa72odAVfHr6Zs1ELAUHoDY9VjCLhJogVhRerDnSU4C8LUGHsTA
         pkcKpmwqKxpzNfh6Z8ztyLpS27YGqJP6jaZTYVk1GNU0/NoJeoPErLmYxpklSSHw10aG
         go1l00a7CIrWfSwZsXo3TVLsD8vfQwpGnTNVw0KFJ9SQPRXEmXEDHXTKTVmPoOHnS2e+
         TvVgIDkn2by4bKhejNiGWrTGgVy2tSAKBKr/V3seoOLSNHj3va1u9tnQv3L5il9OydZi
         +r2w==
X-Gm-Message-State: AOAM532W5FJZLMbOmSQF8WO8kjBxUGVnxFSM9NVodo85v8HZaJdPwpB8
        OAqS7UdEmAryFh0JKc8Sd2t2
X-Google-Smtp-Source: ABdhPJzyr8nxGH+zQ/RuB47Y7mPcsgB7bQfz8SJ2nSbYjceTWZnsTbpIwiJmSvc4z146UCWg4sW00w==
X-Received: by 2002:a65:5b41:: with SMTP id y1mr38857743pgr.481.1638254552633;
        Mon, 29 Nov 2021 22:42:32 -0800 (PST)
Received: from localhost.localdomain ([202.21.42.3])
        by smtp.gmail.com with ESMTPSA id d19sm19683993pfv.199.2021.11.29.22.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:42:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16() return instead of u16
Date:   Tue, 30 Nov 2021 12:12:15 +0530
Message-Id: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

cpu_to_be16() returns __be16 value but the driver uses u16 and that's
incorrect. Fix it by using __be16 as the datatype of bdf_be variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Modified the commit message and subject to describe the actual issue
as per comments from Bjorn.

 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c3d1116bb60..ddecd7f341c5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1343,7 +1343,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 
 	/* Look for an available entry to hold the mapping */
 	for (i = 0; i < nr_map; i++) {
-		u16 bdf_be = cpu_to_be16(map[i].bdf);
+		__be16 bdf_be = cpu_to_be16(map[i].bdf);
 		u32 val;
 		u8 hash;
 
-- 
2.25.1

