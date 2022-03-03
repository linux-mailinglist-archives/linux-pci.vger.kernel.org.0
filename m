Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DB4CBA87
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiCCJoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 04:44:24 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF140172889
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 01:43:38 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220303094336epoutp044527e68367f2da3f4d57e0b49b7f77a0~Y1bAiWCCv0468804688epoutp04c
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 09:43:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220303094336epoutp044527e68367f2da3f4d57e0b49b7f77a0~Y1bAiWCCv0468804688epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646300616;
        bh=JGt2SUFXN47lwLD6/OHx/URaET0Jb/5ljVf5ZET/LrU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=awxpXq59SJiHvSLQdwKJ1TPT1BuLWGyVp+GRhxCkctHzWUKZpyezBX8hHN22q8rTv
         OpZteJesIaym3T5WOdADApJX4b7iuHP7FjLhOhuAYOBq22FMQEgunAclp7pB815Ouv
         J/RoD7a3i3ZcrOAzLfE44MViBph4f9blFyIc15l0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220303094335epcas1p2305ca1dc3507e47c1035e838144dc1b1~Y1bAFFo3q2074320743epcas1p2B;
        Thu,  3 Mar 2022 09:43:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.224]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K8QzB3GqZz4x9Q5; Thu,  3 Mar
        2022 09:43:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.3A.64085.6CD80226; Thu,  3 Mar 2022 18:43:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220303094334epcas1p256f56793abe1984803caf11ef76bfc0f~Y1a_cf1e81681416814epcas1p2J;
        Thu,  3 Mar 2022 09:43:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220303094334epsmtrp23ace0099c009a1b00d372eee173dce0f~Y1a_bhwdQ1563115631epsmtrp2_;
        Thu,  3 Mar 2022 09:43:34 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-e3-62208dc63715
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.C3.29871.5CD80226; Thu,  3 Mar 2022 18:43:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.97.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220303094333epsmtip253dde6a648aadc01426a5f5bdf5d9f17~Y1a_QUQHN0753207532epsmtip2Y;
        Thu,  3 Mar 2022 09:43:33 +0000 (GMT)
From:   Youngjin Jang <yj84.jang@samsung.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     "Youngjin Jang" <yj84.jang@samsung.com>, js07.lee@samsung.com
Subject: [PATCH v2] PM: Add device name to suspend_report_result()
Date:   Thu,  3 Mar 2022 18:39:07 +0900
Message-Id: <20220303093907.515129-1-yj84.jang@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmge6xXoUkg90LRCyWNGVYNC9ez2bx
        6OZvVotZU/YyWSzf189ocXnXHDaLs/OOs1l87j3CaLFoWSuzxd1TR9ks5n6ZymzRdWgxqwOP
        x4JNpR6L97xk8ti0qpPNY//cNewefVtWMXqsWP2d3ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
        qQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkamQIUJ2Rk39l9hKnhjUdG4TbWBcbF+
        FyMnh4SAicTXI4eYQGwhgR2MEldvS3UxcgHZnxglNp/Zww7hfGOU+L6qnx2m49vHp1CJvYwS
        azbfYYFr2bf1MNgsNgFtiVVb5oFViQhcZpJ4+30CM0iCWcBR4sPBPawgtrCAk8T0vdvBxrII
        qEr0vDoCFucVsJY4sf8bE8Q6eYmZl76zQ8QFJU7OfMICMUdeonnrbGaQBRICrRwSl7duhbrP
        RWL57kWsELawxKvjW6DiUhKf3+1lg7DTJSY+fgsVL5D4+3gJM4RtLPHu7VogmwNogabE+l3Q
        QFKU2Pl7LiPEXj6Jd197WEFKJAR4JTrahCBKlCUen18NNV1SYv3v/VDne0hsW7KLGRK+sRIX
        fjUxTmCUn4Xkm1lIvpmFsHgBI/MqRrHUguLc9NRiwwJDeKQm5+duYgQnVS3THYwT337QO8TI
        xMF4iFGCg1lJhNdSUyFJiDclsbIqtSg/vqg0J7X4EKMpMHwnMkuJJucD03peSbyhiaWBiZmR
        iYWxpbGZkjjvqmmnE4UE0hNLUrNTUwtSi2D6mDg4pRqYDlzL3OO89Lri/Kt8gjzbpZp8p/Oc
        LT/6f3K1x+/+5N5LqnXPNdwdv+69uiUsWKdbequrak7qox1FJq0TZhsYzLj374JMzt3w6ZX8
        Nnv7QxauWd5856CTIbfvL5X4iY+T+yvPzg0+yv3jXM22n0o/I2w+efd03Eif+fCwQ1G3l7JO
        79dkl50X9wv9nVdk56cqpW++Sk3ykt6ML0ny/N2t0y79iRTJ/t58wJHzZHLg50VmTlP/rJfd
        U8ZX5Hs+3WLxq5W8ytEHl3O/DpzS9oZ11pS4yw0Nz67c4mv7dPaGdtwc3VT+0wevFq69VcSw
        rig9sOjRZ7tdm7xfl8yqU/3x3Kvz+I/nGSlfVKWmFvruVmIpzkg01GIuKk4EAA4AizQzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvO7RXoUkg8PbLC2WNGVYNC9ez2bx
        6OZvVotZU/YyWSzf189ocXnXHDaLs/OOs1l87j3CaLFoWSuzxd1TR9ks5n6ZymzRdWgxqwOP
        x4JNpR6L97xk8ti0qpPNY//cNewefVtWMXqsWP2d3ePzJrkA9igum5TUnMyy1CJ9uwSujBv7
        rzAVvLGoaNym2sC4WL+LkZNDQsBE4tvHp+xdjFwcQgK7GSWmzvrBCJGQlPj66TNbFyMHkC0s
        cfhwMUTNB0aJh9s+sIDUsAloS6zaMg+sWUTgNpNEz4NvTCAJZgFniXU7FoEVCQs4SUzfu50d
        xGYRUJXoeXWEFcTmFbCWOLEfol5CQF5i5qXv7BBxQYmTM5+wQMyRl2jeOpt5AiPfLCSpWUhS
        CxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIe5luYOxu2rPugdYmTiYDzEKMHB
        rCTCa6mpkCTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD
        09WDYWrHVoZuNd2/43vN66++PHsea+wX+MyUEnRd6uPK4uOsl38+fqXV1z1/vuy7ksh7lVWd
        y2ZWpoR9mmnhFBc/OenAoxkyJqxaF64HPe1aYZdkyct6qfJg6bTIPf9rfz42WffxqKpK/Foe
        BTFNs/syWy+d2Xzu2AvDa9m/tlwO+8pxaf7x5m7W3km7DsfrvCjrXnVtYemlE02iXO9LJIOv
        fJ23SCv55Ibaex7SikmRRp4Xo1J1quUPRMr3MDxbPK9xS4HHfOYVM1aH5fgZbNh2X0NW/d1n
        Lyelv5M7My4efvl+Rl2V946pV+btfjA3bxu7u1ZE997qzVydDw2TZV7E6t/hSazJ8baf+9dy
        Wr4SS3FGoqEWc1FxIgBM58VS4gIAAA==
X-CMS-MailID: 20220303094334epcas1p256f56793abe1984803caf11ef76bfc0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220303094334epcas1p256f56793abe1984803caf11ef76bfc0f
References: <CGME20220303094334epcas1p256f56793abe1984803caf11ef76bfc0f@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Youngjin Jang" <yj84.jang@samsung.com>

currently, suspend_report_result() prints only function information.
If any driver uses common pm function, nobody knows who called
failed function exactly.

So, device is needed to recognize specific wrong driver.

e.g.)
PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0
after patch,
amba 1740000.etm: dpm_run_callback(): pm_generic_suspend+0x0/0x48
returns 0
armv7-pmu soc:pmu: dpm_run_callback(): platform_pm_suspend+0x0/0x68
returns 0

Signed-off-by: Youngjin Jang <yj84.jang@samsung.com>
---
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
index 588588cfda48..415f7664b010 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -596,7 +596,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 		int error;
 
 		error = drv->suspend(pci_dev, state);
-		suspend_report_result(drv->suspend, error);
+		suspend_report_result(dev, drv->suspend, error);
 		if (error)
 			return error;
 
@@ -775,7 +775,7 @@ static int pci_pm_suspend(struct device *dev)
 		int error;
 
 		error = pm->suspend(dev);
-		suspend_report_result(pm->suspend, error);
+		suspend_report_result(dev, pm->suspend, error);
 		if (error)
 			return error;
 
@@ -821,7 +821,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		int error;
 
 		error = pm->suspend_noirq(dev);
-		suspend_report_result(pm->suspend_noirq, error);
+		suspend_report_result(dev, pm->suspend_noirq, error);
 		if (error)
 			return error;
 
@@ -1010,7 +1010,7 @@ static int pci_pm_freeze(struct device *dev)
 		int error;
 
 		error = pm->freeze(dev);
-		suspend_report_result(pm->freeze, error);
+		suspend_report_result(dev, pm->freeze, error);
 		if (error)
 			return error;
 	}
@@ -1030,7 +1030,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
 		int error;
 
 		error = pm->freeze_noirq(dev);
-		suspend_report_result(pm->freeze_noirq, error);
+		suspend_report_result(dev, pm->freeze_noirq, error);
 		if (error)
 			return error;
 	}
@@ -1116,7 +1116,7 @@ static int pci_pm_poweroff(struct device *dev)
 		int error;
 
 		error = pm->poweroff(dev);
-		suspend_report_result(pm->poweroff, error);
+		suspend_report_result(dev, pm->poweroff, error);
 		if (error)
 			return error;
 	}
@@ -1154,7 +1154,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
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
index d630cccd2e6e..dd44e37a454a 100644
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
index e1e9402180b9..cdccbb9cef2c 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -745,11 +745,11 @@ extern int dpm_suspend_late(pm_message_t state);
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
@@ -789,7 +789,7 @@ static inline int dpm_suspend_start(pm_message_t state)
 	return 0;
 }
 
-#define suspend_report_result(fn, ret)		do {} while (0)
+#define suspend_report_result(dev, fn, ret)	do {} while (0)
 
 static inline int device_pm_wait_for_dev(struct device *a, struct device *b)
 {
-- 
2.25.1

