Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B440D649
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhIPJfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 05:35:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235614AbhIPJfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 05:35:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18G7Z4c2011403;
        Thu, 16 Sep 2021 05:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zy2I/gNRH3NcbiGn1a7YaNlOpuCH3uQPIQkOlz6m0CY=;
 b=TpYcePbYp2nks7RIMVrK0sZkc7egI2T46xvRjpALe15u30hkNYcHpZS8/xWZWyuHXuJQ
 f+Uv+beKMo97Eq0tw+TvIC5P1lSHfcgtHEiKf4zFz9FYJuoUnNelph93OTJeirEuF1P6
 YfaO09/iGaf4Hr4ENfjMf6ujqX3vGG4tA1FfFZuGrIDOHHIQjQQ9ihJ8Dx+2gI/Cjlnq
 emJmnsUpGsW/EFBKNdewqLpyEDiiWVGtPu6KvRFapVCkI/ekwTW00Y9pp//zMh9XFYgI
 MkBSpPVxJDm5StY25hI3cwjJp9XID/A7/MW9xzaO9mhOIAt0Pn7j7k/0M7ohBTzfnPq8 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b41nptfar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:45 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18G9GU60025366;
        Thu, 16 Sep 2021 05:33:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b41nptfa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18G9WtTg031201;
        Thu, 16 Sep 2021 09:33:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3b0m3ag499-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 09:33:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18G9XdBP42664228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 09:33:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D31E42041;
        Thu, 16 Sep 2021 09:33:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B66CF4204B;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 4/4] s390/pci: implement minimal PCI error recovery
Date:   Thu, 16 Sep 2021 11:33:36 +0200
Message-Id: <20210916093336.2895602-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916093336.2895602-1-schnelle@linux.ibm.com>
References: <20210916093336.2895602-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRi3p_kPJFmoL_9RzZwMGiBLmdpNignq
X-Proofpoint-ORIG-GUID: Yy0BXDbOt4Orc88C74YEwI67COhVZ13I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109160046
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the platform detects an error on a PCI function or a service action
has been performed it is put in the error state and an error event
notification is provided to the OS.

Currently we treat all error event notifications the same and simply set
pdev->error_state = pci_channel_io_perm_failure requiring user
intervention such as use of the recover attribute to get the device
usable again. Despite requiring a manual step this also has the
disadvantage that the device is completely torn down and recreated
resulting in higher level devices such as a block or network device
being recreated. In case of a block device this also means that it may
need to be removed and added to a software raid even if that could
otherwise survive with a temporary degradation.

This is of course not ideal more so since an error notification with PEC
0x3A indicates that the platform already performed error recovery
successfully or that the error state was caused by a service action that
is now finished.

At least in this case we can assume that the error state can be reset
and the function made usable again. So as not to have the disadvantage
of a full tear down and recreation we need to coordinate this recovery
with the driver. Thankfully there is already a well defined recovery
flow for this described in Documentation/PCI/pci-error-recovery.rst.

The implementation of this is somewhat straight forward and simplified
by the fact that our recovery flow is defined per PCI function. As
a reset we use the newly introduced zpci_hot_reset_device() which also
takes the PCI function out of the error state.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v1 -> v2:
- Dropped use of pci_dev_is_added(), pdev->driver check is enough
- Improved some comments and messages

 arch/s390/include/asm/pci.h |   4 +-
 arch/s390/pci/pci.c         |  49 ++++++++++
 arch/s390/pci/pci_event.c   | 182 +++++++++++++++++++++++++++++++++++-
 3 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 2a2ed165a270..558877aff2e5 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -294,8 +294,10 @@ void zpci_debug_exit(void);
 void zpci_debug_init_device(struct zpci_dev *, const char *);
 void zpci_debug_exit_device(struct zpci_dev *);
 
-/* Error reporting */
+/* Error handling */
 int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
+int zpci_clear_error_state(struct zpci_dev *zdev);
+int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
 
 #ifdef CONFIG_NUMA
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index dce60f16e94a..b987c9d76510 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -954,6 +954,55 @@ int zpci_report_error(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL(zpci_report_error);
 
+/**
+ * zpci_clear_error_state() - Clears the zPCI error state of the device
+ * @zdev: The zdev for which the zPCI error state should be reset
+ *
+ * Clear the zPCI error state of the device. If clearing the zPCI error state
+ * fails the device is left in the error state. In this case it may make sense
+ * to call zpci_io_perm_failure() on the associated pdev if it exists.
+ *
+ * Returns: 0 on success, -EIO otherwise
+ */
+int zpci_clear_error_state(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_ERROR);
+	struct zpci_fib fib = {0};
+	u8 status;
+	int rc;
+
+	rc = zpci_mod_fc(req, &fib, &status);
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * zpci_reset_load_store_blocked() - Re-enables L/S from error state
+ * @zdev: The zdev for which to unblock load/store access
+ *
+ * R-eenables load/store access for a PCI function in the error state while
+ * keeping DMA blocked. In this state drivers can poke MMIO space to determine
+ * if error recovery is possible while catching any rogue DMA access from the
+ * device.
+ *
+ * Returns: 0 on success, -EIO otherwise
+ */
+int zpci_reset_load_store_blocked(struct zpci_dev *zdev)
+{
+	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_BLOCK);
+	struct zpci_fib fib = {0};
+	u8 status;
+	int rc;
+
+	rc = zpci_mod_fc(req, &fib, &status);
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
 static int zpci_mem_init(void)
 {
 	BUILD_BUG_ON(!is_power_of_2(__alignof__(struct zpci_fmb)) ||
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index e868d996ec5b..73389e161872 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -47,15 +47,182 @@ struct zpci_ccdf_avail {
 	u16 pec;			/* PCI event code */
 } __packed;
 
+static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
+{
+	switch (ers_res) {
+	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_RECOVERED:
+	case PCI_ERS_RESULT_NEED_RESET:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev)
+{
+	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
+	struct pci_driver *driver = pdev->driver;
+
+	pr_debug("%s: asking driver to determine recoverability\n", pci_name(pdev));
+	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
+	if (ers_result_indicates_abort(ers_res))
+		pr_info("%s: driver can't recover\n", pci_name(pdev));
+	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
+		pr_debug("%s: driver needs reset to recover\n", pci_name(pdev));
+
+	return ers_res;
+}
+
+static pci_ers_result_t zpci_event_do_error_state_clear(struct pci_dev *pdev)
+{
+	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
+	struct pci_driver *driver = pdev->driver;
+	struct zpci_dev *zdev = to_zpci(pdev);
+	int rc;
+
+	pr_debug("%s: reset load/store blocked\n", pci_name(pdev));
+	rc = zpci_reset_load_store_blocked(zdev);
+	if (rc) {
+		pr_err("%s: reset load/store blocked failed\n", pci_name(pdev));
+		/* Let's try a full reset instead */
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	if (driver->err_handler->mmio_enabled) {
+		pr_debug("%s: calling mmio_enabled() callback\n", pci_name(pdev));
+		ers_res = driver->err_handler->mmio_enabled(pdev);
+		if (ers_result_indicates_abort(ers_res)) {
+			pr_info("%s: driver can't recover after enabling MMIO\n", pci_name(pdev));
+			return ers_res;
+		} else if (ers_res == PCI_ERS_RESULT_NEED_RESET) {
+			pr_debug("%s: driver needs reset to recover\n", pci_name(pdev));
+			return ers_res;
+		}
+	}
+
+	pr_debug("%s: clearing error state\n", pci_name(pdev));
+	rc = zpci_clear_error_state(zdev);
+	if (!rc) {
+		pdev->error_state = pci_channel_io_normal;
+	} else {
+		pr_err("%s: resetting error state failed\n", pci_name(pdev));
+		/* Let's try a full reset instead */
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return ers_res;
+}
+
+static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev)
+{
+	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
+	struct pci_driver *driver = pdev->driver;
+
+	pr_info("%s: initiating reset\n", pci_name(pdev));
+	if (zpci_hot_reset_device(to_zpci(pdev))) {
+		pr_err("%s: resetting function failed\n", pci_name(pdev));
+		return ers_res;
+	}
+	pdev->error_state = pci_channel_io_normal;
+	if (driver->err_handler->slot_reset) {
+		ers_res = driver->err_handler->slot_reset(pdev);
+		if (ers_result_indicates_abort(ers_res)) {
+			pr_info("%s: driver can't recover after slot reset\n", pci_name(pdev));
+			return ers_res;
+		}
+	}
+
+	return ers_res;
+}
+
+/* zpci_event_attempt_error_recovery - Try to recover the given PCI function
+ * @pdev: PCI function to recover currently in the error state
+ *
+ * We follow the scheme outlined in Documentation/PCI/pci-error-recovery.rst.
+ * With the simplification that recovery always happens per function
+ * and the platform determines which functions are affected for
+ * multi-function devices.
+ */
+static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
+{
+	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
+	struct pci_driver *driver;
+
+	/*
+	 * Ensure that the PCI function is not removed concurrently, no driver
+	 * is unbound or probed and that userspace can't access its
+	 * configuration space while we perform recovery.
+	 */
+	pci_dev_lock(pdev);
+	if (pdev->error_state == pci_channel_io_perm_failure) {
+		ers_res = PCI_ERS_RESULT_DISCONNECT;
+		goto out_unlock;
+	}
+	pdev->error_state = pci_channel_io_frozen;
+
+	driver = pdev->driver;
+	if (!driver || !driver->err_handler || !driver->err_handler->error_detected) {
+		pr_info("%s: driver does not support error recovery\n", pci_name(pdev));
+		goto out_unlock;
+	}
+
+	ers_res = zpci_event_notify_error_detected(pdev);
+	if (ers_result_indicates_abort(ers_res))
+		goto out_unlock;
+
+	if (ers_res == PCI_ERS_RESULT_CAN_RECOVER) {
+		ers_res = zpci_event_do_error_state_clear(pdev);
+		if (ers_result_indicates_abort(ers_res))
+			goto out_unlock;
+	}
+
+	if (ers_res == PCI_ERS_RESULT_NEED_RESET)
+		ers_res = zpci_event_do_reset(pdev);
+
+	if (ers_res != PCI_ERS_RESULT_RECOVERED) {
+		pr_err("%s: failed to recover\n", pci_name(pdev));
+		goto out_unlock;
+	}
+
+	pr_info("%s: driver may resume operations\n", pci_name(pdev));
+	if (driver->err_handler->resume)
+		driver->err_handler->resume(pdev);
+out_unlock:
+	pci_dev_unlock(pdev);
+
+	return ers_res;
+}
+
+/* zpci_event_io_failure - Report PCI channel failure state to driver
+ * @pdev: PCI function for which to report
+ * @es: PCI channel failure state to report
+ */
+static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
+{
+	struct pci_driver *driver;
+
+	pci_dev_lock(pdev);
+	pdev->error_state = es;
+	driver = pdev->driver;
+	if (driver && driver->err_handler && driver->err_handler->error_detected)
+		driver->err_handler->error_detected(pdev, pdev->error_state);
+	pci_dev_unlock(pdev);
+}
+
 static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 {
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
 	struct pci_dev *pdev = NULL;
+	pci_ers_result_t ers_res;
 
 	zpci_err("error CCDF:\n");
 	zpci_err_hex(ccdf, sizeof(*ccdf));
 
 	if (zdev)
+		zpci_update_fh(zdev, ccdf->fh);
+
+	if (zdev->zbus->bus)
 		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 
 	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
@@ -64,7 +231,20 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	if (!pdev)
 		return;
 
-	pdev->error_state = pci_channel_io_perm_failure;
+	switch (ccdf->pec) {
+	case 0x003a: /* Service Action or Error Recovery Successful */
+		ers_res = zpci_event_attempt_error_recovery(pdev);
+		if (ers_res != PCI_ERS_RESULT_RECOVERED)
+			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
+		break;
+	default:
+		/*
+		 * Mark as frozen not permanently failed because the device
+		 * could be subsequently recovered by the platform.
+		 */
+		zpci_event_io_failure(pdev, pci_channel_io_frozen);
+		break;
+	}
 	pci_dev_put(pdev);
 }
 
-- 
2.25.1

