Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F330C3327E5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCIN44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 08:56:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13078 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhCIN4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 08:56:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DvxXJ3HKvzNkQv;
        Tue,  9 Mar 2021 21:54:24 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 21:56:35 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>, <helgaas@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH V2 2/2] lspci: Update tests files with VF 10-Bit Tag Requester
Date:   Tue, 9 Mar 2021 21:35:19 +0800
Message-ID: <1615296919-76476-3-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
References: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the tests files with the new field 10BitTagReq
in SR-IOV Capabilities Register.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 tests/cap-dvsec-cxl | 4 ++--
 tests/cap-ea-1      | 4 ++--
 tests/cap-pcie-2    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/cap-dvsec-cxl b/tests/cap-dvsec-cxl
index c499d0e..a24e3fb 100644
--- a/tests/cap-dvsec-cxl
+++ b/tests/cap-dvsec-cxl
@@ -79,8 +79,8 @@
                 PTMControl: Enabled:- RootSelected:-
                 PTMEffectiveGranularity: Unknown
         Capabilities: [b80 v1] Single Root I/O Virtualization (SR-IOV)
-                IOVCap: Migration-, Interrupt Message Number: 000
-                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
+                IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
+                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy- 10BitTagReq-
                 IOVSta: Migration-
                 Initial VFs: 6, Total VFs: 6, Number of VFs: 0, Function Dependency Link: 00
                 VF offset: 16, stride: 2, Device ID: 0d52
diff --git a/tests/cap-ea-1 b/tests/cap-ea-1
index df88ba9..776839d 100644
--- a/tests/cap-ea-1
+++ b/tests/cap-ea-1
@@ -57,8 +57,8 @@
 		ARICtl:	MFVC- ACS-, Function Group: 0
 	Capabilities: [108 v1] Vendor Specific Information: ID=00a0 Rev=1 Len=040 <?>
 	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
-		IOVCap:	Migration-, Interrupt Message Number: 000
-		IOVCtl:	Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
+		IOVCap:	Migration- 10BitTagReq- Interrupt Message Number: 000
+		IOVCtl:	Enable+ Migration- Interrupt- MSE+ ARIHierarchy+ 10BitTagReq-
 		IOVSta:	Migration-
 		Initial VFs: 128, Total VFs: 128, Number of VFs: 128, Function Dependency Link: 00
 		VF offset: 1, stride: 1, Device ID: a034
diff --git a/tests/cap-pcie-2 b/tests/cap-pcie-2
index 47c8953..9bde139 100644
--- a/tests/cap-pcie-2
+++ b/tests/cap-pcie-2
@@ -48,8 +48,8 @@
 		ARICap:	MFVC- ACS-, Next Function: 1
 		ARICtl:	MFVC- ACS-, Function Group: 0
 	Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
-		IOVCap:	Migration-, Interrupt Message Number: 000
-		IOVCtl:	Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
+		IOVCap:	Migration- 10BitTagReq- Interrupt Message Number: 000
+		IOVCtl:	Enable+ Migration- Interrupt- MSE+ ARIHierarchy- 10BitTagReq-
 		IOVSta:	Migration-
 		Initial VFs: 8, Total VFs: 8, Number of VFs: 1, Function Dependency Link: 00
 		VF offset: 384, stride: 2, Device ID: 10ca
-- 
1.9.1

