Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58F34C9E03
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 07:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiCBGuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 01:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiCBGuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 01:50:11 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1478B2D46
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 22:49:25 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220302064923epoutp03cc398c4b1386cfa85f9e4554c69edbda~YfZncMnzZ1365013650epoutp03z
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 06:49:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220302064923epoutp03cc398c4b1386cfa85f9e4554c69edbda~YfZncMnzZ1365013650epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646203763;
        bh=B4qCxed/o28MJol5/DTq0OXPi3dHOnWB4DtbGBqPK/U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k6rFHSElMgccv8Q5i8QWvpZjZyAsNtRj+YU4iPHrRGmvcKXbR0s7QDkVCYH5wforS
         JePOKFL8PeKddBkvoAi6T3LeuO0QQ+FKV684TGv7OT8GFedvll2jzxkWaTkEETuKdi
         /MairelJ0niik0wYnGx37vlFdwO9OytKTxEPcrMY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220302064922epcas1p47e04aa7214f39e1d3f4dc71c164c9707~YfZm4KJlM0962309623epcas1p4b;
        Wed,  2 Mar 2022 06:49:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K7l8d4L7tz4x9QG; Wed,  2 Mar
        2022 06:49:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.68.09592.1731F126; Wed,  2 Mar 2022 15:49:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220302064921epcas1p19fbe8c017d776657caa696a3cef10093~YfZlFNHTf1722917229epcas1p1m;
        Wed,  2 Mar 2022 06:49:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220302064921epsmtrp1fe0c2a4dbec0e9c85405858322fdbb03~YfZlEUxdo1059310593epsmtrp1K;
        Wed,  2 Mar 2022 06:49:21 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-c7-621f13716cdb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.44.29871.0731F126; Wed,  2 Mar 2022 15:49:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.97.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220302064920epsmtip225f76cd105373c3ce58278d67451dd18~YfZk0C_vY2473324733epsmtip2A;
        Wed,  2 Mar 2022 06:49:20 +0000 (GMT)
From:   Youngjin Jang <yj84.jang@samsung.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     "yj84.jang" <yj84.jang@samsung.com>, js07.lee@samsung.com
Subject: [PATCH] PM: Add device name to suspend_report_result()
Date:   Wed,  2 Mar 2022 15:49:17 +0900
Message-Id: <20220302064917.64073-1-yj84.jang@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmrm6hsHySwewJMhZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZbboOrSY1YHH
        Y8GmUo/Fe14yeWxa1cnmsX/uGnaPvi2rGD1WrP7O7vF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScArMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxjL64wFTw1r7jYydrAuEOv
        i5GTQ0LAROLZhWaWLkYuDiGBHYwS1xdfYwVJCAl8YpR43ZsOkfjGKPFn53OgKg6wjt7NQRDx
        vYwSc9v2ITTMb6sDsdkEtCVWbZnHDlIkInCZSeLt9wnMIAlmAVuJHxe2sYIMEhawl3jSKAsS
        ZhFQlfj6Yy3YHF4BK4mbnT3MENfJS8y89J0dIi4ocXLmExaIMfISzVtnM4PMlxBo5JD4f+A8
        G0SDi8TpjrVQtrDEq+Nb2CFsKYmX/W1QdrrExMdvoewCib+Pl0AtM5Z493YtM8htzAKaEut3
        6UOEFSV2/p7LCLGXT+Ld1x5WSDjwSnS0CUGUKEs8Pr8aaqukxPrf+5kgbA+JExO+s0CCJ1bi
        4K15TBMY5Wch+WYWkm9mISxewMi8ilEstaA4Nz212LDAGB6jyfm5mxjB6VTLfAfjtLcf9A4x
        MnEwHmKU4GBWEuG9+FMmSYg3JbGyKrUoP76oNCe1+BCjKTB8JzJLiSbnAxN6Xkm8oYmlgYmZ
        kYmFsaWxmZI476pppxOFBNITS1KzU1MLUotg+pg4OKUamPadmOJykaNMTsh3b1wa/z+5rKC9
        rx/UuN382KmzyeG9yE3zsqeb5odvVSjZF2YbKsf/98RUNzMXO9NYkUXrljH5feAJSvvoc1JY
        85DK7jSJgtiEvLWKiZrfb4T03Ek7IR9888E0r7wItbyXi0NVX9lKBrpZ9AX4ay3005eN4fK5
        cacoyOa5073s0680DGX4lNsmLfgyJ+tKTP5023pn8SRZgSuzcta2Jy2sSzn7durOyYFfu1d7
        RLxgcU7IFOLjizkzUyGiO+r0/ZXl0/9/1au4OmXv0YkXn15ZZJjRlGHzvGbumaUG3B8bBSYH
        O6Wd1Ojm1J+Q/G7/rO/s3HNq2291/41V75zN3nP3/NRzSizFGYmGWsxFxYkAPzMOXTAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG6BsHySwcsTZhZLmjIsmhevZ7N4
        dPM3q8WsKXuZLJbv62e0uLxrDpvF2XnH2Sw+9x5htFi0rJXZ4u6po2wWc79MZbboOrSY1YHH
        Y8GmUo/Fe14yeWxa1cnmsX/uGnaPvi2rGD1WrP7O7vF5k1wAexSXTUpqTmZZapG+XQJXxrEX
        V5gKnppXXOxkbWDcodfFyMEhIWAi0bs5qIuRi0NIYDejxKmbL1m6GDmB4pISXz99ZoOoEZY4
        fLgYJCwk8IFR4uQcaRCbTUBbYtWWeewgvSICt5kkeh58YwJJMAvYS9ydPI0VpFcYyH7SKAsS
        ZhFQlfj6Yy0riM0rYCVxs7OHGWKVvMTMS9/ZIeKCEidnPmGBGCMv0bx1NvMERr5ZSFKzkKQW
        MDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDnAtzR2M21d90DvEyMTBeIhRgoNZ
        SYT34k+ZJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY
        +i/Mqko/KKtcUvkzM/rMwhWP8v6EsvDlB1utXSUfMpHxO8OTvC/bZLbPzpO8Zcp7VnTfixUV
        L9anRP1rXjfj7VR/l1iN+U6vxVYtFxbu/vKQtcX+y9zACUZ5FUx/92+Rubr2qlqVcEmA+cGj
        crtUDFT2+/XX+teeuO764A2HU6GSk6/lMi+rnt8/bb5EW9n+SH43mbE8d8fK/fnuDvtio0/v
        bP3y2vWRcPwsya8soj4aW3p/al9jnKnNqn1Kf/fKJrfXljGzTms9sf3jXb37svWVT0qzWqpf
        22xUU4w8172lwPbkxWzJ2cXMTRy6u/zme2xe4ZrZNPlC3oSOmztZBO6cnLos7XXQusmVvx6E
        KbEUZyQaajEXFScCAIcQY1PfAgAA
X-CMS-MailID: 20220302064921epcas1p19fbe8c017d776657caa696a3cef10093
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220302064921epcas1p19fbe8c017d776657caa696a3cef10093
References: <CGME20220302064921epcas1p19fbe8c017d776657caa696a3cef10093@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "yj84.jang" <yj84.jang@samsung.com>

currently, suspend_report_result() prints only function information.
If any driver uses common pm function, nobody knows who called
failed function exactly.

So, device information is needed to recognize specific wrong driver.

e.g.)
PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns 0
PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 returns 0
after patch,
PM: dpm_run_callback(): pm_generic_suspend+0x0/0x48 (amba) returns 0
PM: dpm_run_callback(): platform_pm_suspend+0x0/0x68 (armv7-pmu) returns 0

Signed-off-by: yj84.jang <yj84.jang@samsung.com>
---
 drivers/base/power/main.c  | 10 +++++-----
 drivers/pci/pci-driver.c   | 14 +++++++-------
 drivers/pnp/driver.c       |  2 +-
 drivers/usb/core/hcd-pci.c |  4 ++--
 include/linux/pm.h         |  8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 04ea92c..a762fe8 100644
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
+		pr_err("%s(): %pS (%s) returns %d\n", function, fn, dev_driver_string(dev), ret);
 }
 EXPORT_SYMBOL_GPL(__suspend_report_result);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588c..415f766 100644
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
index cc6757d..c02e7bf 100644
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
index d630ccc..dd44e37 100644
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
index e1e9402..cdccbb9 100644
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
2.7.4

