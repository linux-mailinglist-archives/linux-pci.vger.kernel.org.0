Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1771E4D14F4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbiCHKlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 05:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345838AbiCHKlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 05:41:16 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31C424B7
        for <linux-pci@vger.kernel.org>; Tue,  8 Mar 2022 02:40:18 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220308104015epoutp0216e4cf3d80f54fc0e8959e4a8835e355~aYa6CEUm60922109221epoutp02F
        for <linux-pci@vger.kernel.org>; Tue,  8 Mar 2022 10:40:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220308104015epoutp0216e4cf3d80f54fc0e8959e4a8835e355~aYa6CEUm60922109221epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646736015;
        bh=znDm2AI5FslVsoBW4T9mXUXJAfpjj8kbAAxkSJOckrM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ehzfCTkmnmguZugqcadMmHOVhGp+j7wZtIYLNEXgt5v4Eek/DuLm+8lnpDg0MYit+
         A8AzsKuyd35dexGTZ4OLm/QRFH6QAISqPGL05xqw2JNHtCYQEX4rpmbl7YSgLrcFQA
         2Za4sgEuXyLfmrPCD01EWIKM6gQN73WkxC+ubBfw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220308104015epcas1p2bba22fb992b0ebd19b82f20a5a3a291b~aYa5lN5r_3112331123epcas1p25;
        Tue,  8 Mar 2022 10:40:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KCX0G0Ck3z4x9Pp; Tue,  8 Mar
        2022 10:40:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.E1.09592.D8237226; Tue,  8 Mar 2022 19:40:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220308104013epcas1p4c096ed0065700f2f1f8b5ea1ae4ed994~aYa326zlB1216412164epcas1p4j;
        Tue,  8 Mar 2022 10:40:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308104013epsmtrp12f9c60733c89b3ad4512ab7fb9616a3a~aYa32DBji1804118041epsmtrp1_;
        Tue,  8 Mar 2022 10:40:13 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-49-6227328d1fa3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.0C.03370.D8237226; Tue,  8 Mar 2022 19:40:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.97.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220308104013epsmtip1443265e8c6ee15eadead1c71415acd85~aYa3pjkCn2587225872epsmtip1h;
        Tue,  8 Mar 2022 10:40:13 +0000 (GMT)
From:   Youngjin Jang <yj84.jang@samsung.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        todd.e.brandt@linux.intel.com
Cc:     Youngjin Jang <yj84.jang@samsung.com>, js07.lee@samsung.com
Subject: [PATCH v3] PM: Add device name to suspend_report_result()
Date:   Tue,  8 Mar 2022 04:07:39 +0900
Message-Id: <20220307190739.659955-1-yj84.jang@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmrm6vkXqSweVVFhZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZbZ4u+UBq0XX
        ocWsDrweCzaVeize85LJY9OqTjaPeScDPfbPXcPu0bdlFaPHitXf2T0+b5IL4IjKtslITUxJ
        LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlhJoSwxpxQoFJBY
        XKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ2x8O421oKX
        FhVnL35lb2Ccrd/FyMEhIWAiseRRcRcjF4eQwA5Gif99H1ggnE+MEj1rz7BBOJ8ZJfo+TWTq
        YuQE69j5dRpUYhejxNOnfxnhWlr+rWQBqWIT0JZYtWUeO4gtIvCJSeLKKjkQm1nAXuL33Qlg
        cWEBJ4ntayYxg9zBIqAqselRKEiYV8BaYlHbCnaIZfISMy99Z4eIC0qcnPmEBWKMvETz1tnM
        IHslBCZySDy91ckK0eAicXHiUTYIW1ji1fEtUIOkJF72t0HZ6RITH7+Fsgsk/j5ewgxhG0u8
        e7sW7B5mAU2J9bv0IcKKEjt/z2WE2Msn8e5rDysk6HglOtqEIEqUJR6fXw21VVJi/e/90LDy
        kDi38SZYq5BArMTfzw8ZJzDKz0LyzSwk38xCWLyAkXkVo1hqQXFuemqxYYExPE6T83M3MYKT
        rJb5DsZpbz/oHWJk4mA8xCjBwawkwnv/vEqSEG9KYmVValF+fFFpTmrxIUZTYPBOZJYSTc4H
        pvm8knhDE0sDEzMjEwtjS2MzJXHeVdNOJwoJpCeWpGanphakFsH0MXFwSjUwPa62ufnY42Cs
        N5vOcYsz3TU7zHXjX5ZYbDvza4VQCN8E48h5nm85/Tcnugcub30e/SKywaRI5NdznY1cMdlP
        LjkL3GcP/met/XuvTs3d59Nt78obzNVaMyv7uuuiQJeNyXNFpxyUc343Tzy9f1dT1r7SjckN
        8U6LFHdvnGjOetT3l1flfZuWCZKabL0Tppxe+PXz0QX3RKsubq3Qmr39xJ0NL3s9L87Tmqfj
        /3d1ama5tW88t7j37Lx9cpYym0yU/wj3z5i3nDljh4gNy4ftbKnbz13U4XPaZPbfSUNVIjFw
        +jSXXo01B2u1th26Kl5z/o12avFslXyzxd/4Ly713PHyv1yHTWXbosZNKx+tU2Ipzkg01GIu
        Kk4EAKTAPx07BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnG6vkXqSwa/D0hZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZbZ4u+UBq0XX
        ocWsDrweCzaVeize85LJY9OqTjaPeScDPfbPXcPu0bdlFaPHitXf2T0+b5IL4IjisklJzcks
        Sy3St0vgylh4dxtrwUuLirMXv7I3MM7W72Lk5JAQMJHY+XUaG4gtJLCDUeJldzZEXFLi66fP
        QHEOIFtY4vDh4i5GLqCSD4wSF952MYHUsAloS6zaMo8dJCEi8IdJ4uPuh0wgDcwCjhJdH6tA
        aoQFnCS2r5nEDBJmEVCV2PQoFCTMK2AtsahtBTvEKnmJmZe+s0PEBSVOznzCAmIzA8Wbt85m
        nsDINwtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFBr6W1g3HPqg96
        hxiZOBgPMUpwMCuJ8N4/r5IkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTU
        gtQimCwTB6dUA5Nmr9oDfdusyyIf/9xrPHguf+tjHRUPv4JvTf//7rV4sMmrbtLSZPYW30Wn
        O8/J3m9kuPa/2Sb3/WtDoQrJ9n/M2Ucby4VPem7T83Zdn8p0WK2DZ8mrlRULw3hVOTNNH/1O
        FVx9yqd98ZSHWtc8PfTk9lx+eVz9/CGVNUdSGSWMrFQ/rPi8gmn+ygtRfsbTmNtl/91KfM17
        41jTx4t3ZHlM3ff+5L+wedn7vmUTnVTE220TbC/FJwZ/MFyZ9YP3j8bJ+y0fZrReC5vcdUt4
        t5NY6hx31+N3Qw2zrNbVuW9iO9zlfdgjrP52UcL+ZfP3nng2T2rSZI2HWvEnf3b6PlNMOJd5
        fJpH2FzfLY6cLB5KLMUZiYZazEXFiQA9zg3x6QIAAA==
X-CMS-MailID: 20220308104013epcas1p4c096ed0065700f2f1f8b5ea1ae4ed994
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308104013epcas1p4c096ed0065700f2f1f8b5ea1ae4ed994
References: <CGME20220308104013epcas1p4c096ed0065700f2f1f8b5ea1ae4ed994@epcas1p4.samsung.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

currently, suspend_report_result() prints only function information.
If any driver uses common pm function, nobody knows who called
failed function exactly.

So, device is needed to recognize specific wrong driver.

e.g.)
PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 0
PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns 0
after patch,
serial 00:05: PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 0
pci 0000:00:01.3: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns 0

Signed-off-by: Youngjin Jang <yj84.jang@samsung.com>
---
Changes since v2:
 - Update commit message, example logs
Changes since v1:
 - Use dev_err() to print out device name
 - Use real name on email sender
 
 drivers/base/power/main.c  | 10 +++++-----
 drivers/pci/pci-driver.c   | 14 +++++++-------
 drivers/pnp/driver.c       |  2 +-
 drivers/usb/core/hcd-pci.c |  4 ++--
 include/linux/pm.h         |  8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 04ea92cbd9cf..41e17b8c2c20 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -485,7 +485,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	trace_device_pm_callback_start(dev, info, state.event);
 	error = cb(dev);
 	trace_device_pm_callback_end(dev, error);
-	suspend_report_result(cb, error);
+	suspend_report_result(dev, cb, error);
 
 	initcall_debug_report(dev, calltime, cb, error);
 
@@ -1568,7 +1568,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	trace_device_pm_callback_start(dev, info, state.event);
 	error = cb(dev, state);
 	trace_device_pm_callback_end(dev, error);
-	suspend_report_result(cb, error);
+	suspend_report_result(dev, cb, error);
 
 	initcall_debug_report(dev, calltime, cb, error);
 
@@ -1855,7 +1855,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	device_unlock(dev);
 
 	if (ret < 0) {
-		suspend_report_result(callback, ret);
+		suspend_report_result(dev, callback, ret);
 		pm_runtime_put(dev);
 		return ret;
 	}
@@ -1960,10 +1960,10 @@ int dpm_suspend_start(pm_message_t state)
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
 
-void __suspend_report_result(const char *function, void *fn, int ret)
+void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret)
 {
 	if (ret)
-		pr_err("%s(): %pS returns %d\n", function, fn, ret);
+		dev_err(dev, "%s(): %pS returns %d\n", function, fn, ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f61c40a47891..4ceeb75fc899 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -607,7 +607,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 		int error;
 
 		error = drv->suspend(pci_dev, state);
-		suspend_report_result(drv->suspend, error);
+		suspend_report_result(dev, drv->suspend, error);
 		if (error)
 			return error;
 
@@ -786,7 +786,7 @@ static int pci_pm_suspend(struct device *dev)
 		int error;
 
 		error = pm->suspend(dev);
-		suspend_report_result(pm->suspend, error);
+		suspend_report_result(dev, pm->suspend, error);
 		if (error)
 			return error;
 
@@ -832,7 +832,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		int error;
 
 		error = pm->suspend_noirq(dev);
-		suspend_report_result(pm->suspend_noirq, error);
+		suspend_report_result(dev, pm->suspend_noirq, error);
 		if (error)
 			return error;
 
@@ -1021,7 +1021,7 @@ static int pci_pm_freeze(struct device *dev)
 		int error;
 
 		error = pm->freeze(dev);
-		suspend_report_result(pm->freeze, error);
+		suspend_report_result(dev, pm->freeze, error);
 		if (error)
 			return error;
 	}
@@ -1041,7 +1041,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
 		int error;
 
 		error = pm->freeze_noirq(dev);
-		suspend_report_result(pm->freeze_noirq, error);
+		suspend_report_result(dev, pm->freeze_noirq, error);
 		if (error)
 			return error;
 	}
@@ -1127,7 +1127,7 @@ static int pci_pm_poweroff(struct device *dev)
 		int error;
 
 		error = pm->poweroff(dev);
-		suspend_report_result(pm->poweroff, error);
+		suspend_report_result(dev, pm->poweroff, error);
 		if (error)
 			return error;
 	}
@@ -1165,7 +1165,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 		int error;
 
 		error = pm->poweroff_noirq(dev);
-		suspend_report_result(pm->poweroff_noirq, error);
+		suspend_report_result(dev, pm->poweroff_noirq, error);
 		if (error)
 			return error;
 	}
diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index cc6757dfa3f1..c02e7bf643a6 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -171,7 +171,7 @@ static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
 
 	if (pnp_drv->driver.pm && pnp_drv->driver.pm->suspend) {
 		error = pnp_drv->driver.pm->suspend(dev);
-		suspend_report_result(pnp_drv->driver.pm->suspend, error);
+		suspend_report_result(dev, pnp_drv->driver.pm->suspend, error);
 		if (error)
 			return error;
 	}
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 784466117c92..8176bc81a635 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -446,7 +446,7 @@ static int suspend_common(struct device *dev, bool do_wakeup)
 				HCD_WAKEUP_PENDING(hcd->shared_hcd))
 			return -EBUSY;
 		retval = hcd->driver->pci_suspend(hcd, do_wakeup);
-		suspend_report_result(hcd->driver->pci_suspend, retval);
+		suspend_report_result(dev, hcd->driver->pci_suspend, retval);
 
 		/* Check again in case wakeup raced with pci_suspend */
 		if ((retval == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) ||
@@ -556,7 +556,7 @@ static int hcd_pci_suspend_noirq(struct device *dev)
 		dev_dbg(dev, "--> PCI %s\n",
 				pci_power_name(pci_dev->current_state));
 	} else {
-		suspend_report_result(pci_prepare_to_sleep, retval);
+		suspend_report_result(dev, pci_prepare_to_sleep, retval);
 		return retval;
 	}
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f7d2be686359..e65b3ab28377 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -770,11 +770,11 @@ extern int dpm_suspend_late(pm_message_t state);
 extern int dpm_suspend(pm_message_t state);
 extern int dpm_prepare(pm_message_t state);
 
-extern void __suspend_report_result(const char *function, void *fn, int ret);
+extern void __suspend_report_result(const char *function, struct device *dev, void *fn, int ret);
 
-#define suspend_report_result(fn, ret)					\
+#define suspend_report_result(dev, fn, ret)				\
 	do {								\
-		__suspend_report_result(__func__, fn, ret);		\
+		__suspend_report_result(__func__, dev, fn, ret);	\
 	} while (0)
 
 extern int device_pm_wait_for_dev(struct device *sub, struct device *dev);
@@ -814,7 +814,7 @@ static inline int dpm_suspend_start(pm_message_t state)
 	return 0;
 }
 
-#define suspend_report_result(fn, ret)		do {} while (0)
+#define suspend_report_result(dev, fn, ret)	do {} while (0)
 
 static inline int device_pm_wait_for_dev(struct device *a, struct device *b)
 {
-- 
2.25.1

