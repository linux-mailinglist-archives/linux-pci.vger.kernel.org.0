Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791257C634C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 05:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjJLD3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 23:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjJLD3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 23:29:20 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E8C0;
        Wed, 11 Oct 2023 20:29:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vtyvp58_1697081352;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vtyvp58_1697081352)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 11:29:13 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: [PATCH v7 4/4] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
Date:   Thu, 12 Oct 2023 11:28:56 +0800
Message-Id: <20231012032856.2640-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012032856.2640-1-xueshuai@linux.alibaba.com>
References: <20231012032856.2640-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainers for Synopsys DesignWare PCIe PMU driver and driver
document.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09d..71f363f836ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20866,6 +20866,13 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/dw_mmc*
 
+SYNOPSYS DESIGNWARE PCIE PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+M:	Jing Zhang <renyu.zj@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/dwc_pcie_pmu.rst
+F:	drivers/perf/dwc_pcie_pmu.c
+
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-- 
2.39.3

