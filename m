Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72186633C00
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKVMDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKVMDl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 07:03:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F00DFA0;
        Tue, 22 Nov 2022 04:03:40 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NGjZP5Vtpz15Mpl;
        Tue, 22 Nov 2022 20:03:09 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:03:39 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <jonathan.cameron@huawei.com>,
        <suzuki.poulose@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>
Subject: [PATCH 2/2] MAINTAINERS: Update the entries for HiSilicon PTT device driver
Date:   Tue, 22 Nov 2022 20:02:09 +0800
Message-ID: <20221122120209.25682-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221122120209.25682-1-yangyicong@huawei.com>
References: <20221122120209.25682-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2585e7edc335..de3d0a5d9cb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9263,11 +9263,15 @@ F:	drivers/perf/hisilicon/hns3_pmu.c
 
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

