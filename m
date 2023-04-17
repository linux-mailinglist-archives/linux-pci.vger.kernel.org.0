Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284E06E3F8F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDQGRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 02:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDQGRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 02:17:45 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBB30E8;
        Sun, 16 Apr 2023 23:17:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VgDPlH8_1681712258;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VgDPlH8_1681712258)
          by smtp.aliyun-inc.com;
          Mon, 17 Apr 2023 14:17:39 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com
Subject: [PATCH v3 3/3] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
Date:   Mon, 17 Apr 2023 14:17:29 +0800
Message-Id: <20230417061729.84422-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainers for Synopsys DesignWare PCIe PMU driver and driver
document.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6d96e5bb8174 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20279,6 +20279,12 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/dw_mmc*
 
+SYNOPSYS DESIGNWARE PCIE PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/dwc_pcie_pmu.rst
+F:	drivers/perf/dwc_pcie_pmu.c
+
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-- 
2.20.1.12.g72788fdb

