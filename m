Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73E664149
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjAJNJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjAJNJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 08:09:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514C6F94B;
        Tue, 10 Jan 2023 05:09:23 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nrrh53jjqzRqtw;
        Tue, 10 Jan 2023 21:07:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 21:09:14 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Update the entries for HiSilicon PTT device driver
Date:   Tue, 10 Jan 2023 21:08:33 +0800
Message-ID: <20230110130833.53474-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230110130833.53474-1-yangyicong@huawei.com>
References: <20230110130833.53474-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Add missing entries for the perf userspace part of this driver.
Also add Jonathan as the maintainer for his expertise on this
driver and PCIe stuffs.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Change since v1:
- Add tag from Jonathan
Link: https://lore.kernel.org/linux-pci/20221122120209.25682-2-yangyicong@huawei.com/

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a36df9ed283d..0cfd358da378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9375,11 +9375,15 @@ F:	drivers/perf/hisilicon/hns3_pmu.c
 
 HISILICON PTT DRIVER
 M:	Yicong Yang <yangyicong@hisilicon.com>
+M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-devices-hisi_ptt
 F:	Documentation/trace/hisi-ptt.rst
 F:	drivers/hwtracing/ptt/
+F:	tools/perf/arch/arm64/util/hisi-ptt.c
+F:	tools/perf/util/hisi-ptt*
+F:	tools/perf/util/hisi-ptt-decoder/*
 
 HISILICON QM DRIVER
 M:	Weili Qian <qianweili@huawei.com>
-- 
2.24.0

