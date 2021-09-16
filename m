Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196E40D64B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhIPJfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 05:35:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235524AbhIPJfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 05:35:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18G91fR1024754;
        Thu, 16 Sep 2021 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Zp/hKbHxmVJIjen8PsqG35YaaJmd5NOaxBF0c/5Vh14=;
 b=sw/Xb4WWlreLpHXiNdb72AccP+2wIAq8b2k57Be/+T5gh3vs4ClDKKsYlJWdgLR4nM6j
 b3ou95zkM2mjvUSwYPYj1PTZBEk4cpeOgoI4+lRm/+/9+9U7RqDsLTGrB+NxPVCYNgbq
 6jvuDGMjvEu0wRANDCUkcIdLDIA6jGOP0cuDKR8gNjZBVcUdINFWc0q0wnv7EGJW2tRC
 Kc1yzRaNldjyLzBx0tCbdboMw9s+DG7HV2xQ78k2dgC0ova86iXVxafB7izmdZUGZIjI
 JCPmInX4CnYneojdoKM3XOsVhPPeRSGwxPuQ/GpMO+2O+3nZDV94Q3S4KhTS9rS0JuaB iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b3yf7nkxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18G9Cmu4016075;
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b3yf7nkww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18G9Ww9X031426;
        Thu, 16 Sep 2021 09:33:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m3ag48t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 09:33:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18G9Xbo757540950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 09:33:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77A44203F;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7036E4204C;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 1/4] s390/pci: refresh function handle in iomap
Date:   Thu, 16 Sep 2021 11:33:33 +0200
Message-Id: <20210916093336.2895602-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916093336.2895602-1-schnelle@linux.ibm.com>
References: <20210916093336.2895602-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V3xbwEeMYQF2UU8_0HExS_3c8uDceaJg
X-Proofpoint-ORIG-GUID: kuNqloOch8bbQne0Q3MpbXpaGM8iDHLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160029
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function handle of a PCI function is updated when disabling or
enabling it as well as when the function's availability changes or it
enters the error state.

Until now this only occurred either while there is no struct pci_dev
associated with the function yet or the function became unavailable.
This meant that leaving a stale function handle in the iomap either
didn't happen because there was no iomap yet or it lead to errors on PCI
access but so would the correct disabled function handle.

In the future a CLP Set PCI Function Disable/Enable cycle during PCI
device recovery may be done while the device is bound to a driver.  In
this case we must update the iomap associated with the now-stale
function handle to ensure that the resulting zPCI instruction references
an accurate function handle.

Since the function handle is accessed by the PCI accessor helpers
without locking use READ_ONCE()/WRITE_ONCE() to mark this access and
prevent compiler optimizations that would move the load/store.

With that infrastructure in place let's also properly update the
function handle in the existing cases. This makes sure that in the
future debugging of a zPCI function access through the handle will
show an up to date handle reducing the chance of confusion. Also it
makes sure we have one single place where a zPCI function handle is
updated after initialization.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 36 ++++++++++++++++++++++++++++++++----
 arch/s390/pci/pci_event.c   |  6 +++---
 arch/s390/pci/pci_insn.c    |  4 ++--
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index e4803ec51110..5e6cba22a801 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -211,6 +211,7 @@ int zpci_deconfigure_device(struct zpci_dev *zdev);
 int zpci_register_ioat(struct zpci_dev *, u8, u64, u64, u64);
 int zpci_unregister_ioat(struct zpci_dev *, u8);
 void zpci_remove_reserved_devices(void);
+void zpci_update_fh(struct zpci_dev *zdev, u32 fh);
 
 /* CLP */
 int clp_setup_writeback_mio(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index e7e6788d75a8..af22778551c1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -481,6 +481,34 @@ static void zpci_free_iomap(struct zpci_dev *zdev, int entry)
 	spin_unlock(&zpci_iomap_lock);
 }
 
+static void zpci_do_update_iomap_fh(struct zpci_dev *zdev, u32 fh)
+{
+	int bar, idx;
+
+	spin_lock(&zpci_iomap_lock);
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!zdev->bars[bar].size)
+			continue;
+		idx = zdev->bars[bar].map_idx;
+		if (!zpci_iomap_start[idx].count)
+			continue;
+		WRITE_ONCE(zpci_iomap_start[idx].fh, zdev->fh);
+	}
+	spin_unlock(&zpci_iomap_lock);
+}
+
+void zpci_update_fh(struct zpci_dev *zdev, u32 fh)
+{
+	if (!fh || zdev->fh == fh)
+		return;
+
+	zdev->fh = fh;
+	if (zpci_use_mio(zdev))
+		return;
+	if (zdev->has_resources && zdev_enabled(zdev))
+		zpci_do_update_iomap_fh(zdev, fh);
+}
+
 static struct resource *__alloc_res(struct zpci_dev *zdev, unsigned long start,
 				    unsigned long size, unsigned long flags)
 {
@@ -668,7 +696,7 @@ int zpci_enable_device(struct zpci_dev *zdev)
 	if (clp_enable_fh(zdev, &fh, ZPCI_NR_DMA_SPACES))
 		rc = -EIO;
 	else
-		zdev->fh = fh;
+		zpci_update_fh(zdev, fh);
 	return rc;
 }
 
@@ -679,14 +707,14 @@ int zpci_disable_device(struct zpci_dev *zdev)
 
 	cc = clp_disable_fh(zdev, &fh);
 	if (!cc) {
-		zdev->fh = fh;
+		zpci_update_fh(zdev, fh);
 	} else if (cc == CLP_RC_SETPCIFN_ALRDY) {
 		pr_info("Disabling PCI function %08x had no effect as it was already disabled\n",
 			zdev->fid);
 		/* Function is already disabled - update handle */
 		rc = clp_refresh_fh(zdev->fid, &fh);
 		if (!rc) {
-			zdev->fh = fh;
+			zpci_update_fh(zdev, fh);
 			rc = -EINVAL;
 		}
 	} else {
@@ -768,7 +796,7 @@ int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh)
 {
 	int rc;
 
-	zdev->fh = fh;
+	zpci_update_fh(zdev, fh);
 	/* the PCI function will be scanned once function 0 appears */
 	if (!zdev->zbus->bus)
 		return 0;
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index c856f80cb21b..e868d996ec5b 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -76,7 +76,7 @@ void zpci_event_error(void *data)
 
 static void zpci_event_hard_deconfigured(struct zpci_dev *zdev, u32 fh)
 {
-	zdev->fh = fh;
+	zpci_update_fh(zdev, fh);
 	/* Give the driver a hint that the function is
 	 * already unusable.
 	 */
@@ -117,7 +117,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 		if (!zdev)
 			zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
 		else
-			zdev->fh = ccdf->fh;
+			zpci_update_fh(zdev, ccdf->fh);
 		break;
 	case 0x0303: /* Deconfiguration requested */
 		if (zdev) {
@@ -126,7 +126,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			 */
 			if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
 				break;
-			zdev->fh = ccdf->fh;
+			zpci_update_fh(zdev, ccdf->fh);
 			zpci_deconfigure_device(zdev);
 		}
 		break;
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 2e43996159f0..28d863aaafea 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -163,7 +163,7 @@ static inline int zpci_load_fh(u64 *data, const volatile void __iomem *addr,
 			       unsigned long len)
 {
 	struct zpci_iomap_entry *entry = &zpci_iomap_start[ZPCI_IDX(addr)];
-	u64 req = ZPCI_CREATE_REQ(entry->fh, entry->bar, len);
+	u64 req = ZPCI_CREATE_REQ(READ_ONCE(entry->fh), entry->bar, len);
 
 	return __zpci_load(data, req, ZPCI_OFFSET(addr));
 }
@@ -244,7 +244,7 @@ static inline int zpci_store_fh(const volatile void __iomem *addr, u64 data,
 				unsigned long len)
 {
 	struct zpci_iomap_entry *entry = &zpci_iomap_start[ZPCI_IDX(addr)];
-	u64 req = ZPCI_CREATE_REQ(entry->fh, entry->bar, len);
+	u64 req = ZPCI_CREATE_REQ(READ_ONCE(entry->fh), entry->bar, len);
 
 	return __zpci_store(data, req, ZPCI_OFFSET(addr));
 }
-- 
2.25.1

