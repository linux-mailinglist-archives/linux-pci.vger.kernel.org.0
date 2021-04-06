Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459DB35543E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbhDFMs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 08:48:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15613 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbhDFMsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 08:48:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FF6j21Fx9z19L2p;
        Tue,  6 Apr 2021 20:46:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:48:29 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 4/4] MAINTAINERS: Add maintainer for HiSilicon PTT driver
Date:   Tue, 6 Apr 2021 20:45:54 +0800
Message-ID: <1617713154-35533-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainer for driver and documentation of HiSilicon PTT device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d23b0e..61b793b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8078,6 +8078,13 @@ W:	http://www.hisilicon.com
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 F:	drivers/perf/hisilicon
 
+HISILICON PTT DRIVER
+M:	Yicong Yang <yangyicong@hisilicon.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/hisi-ptt.rst
+F:	drivers/hwtracing/hisilicon/
+
 HISILICON QM AND ZIP Controller DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.8.1

