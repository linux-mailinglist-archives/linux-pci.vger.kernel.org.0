Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0E1E1425
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbgEYS0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 14:26:33 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34824 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389511AbgEYS01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 14:26:27 -0400
Received: by mail-ej1-f68.google.com with SMTP id s21so21369947ejd.2;
        Mon, 25 May 2020 11:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zC1sdnSC7gmB2OcNZjocITMtxNUn1YHh0qE5EhXuaW4=;
        b=MpSY1cc/FPX5YBNPF0FgTsnTnlU57Nm7fGXBFZ0xWSO4WsRSSWoigFB6+JfmR+lVSj
         DQ9smnAHvRDofwsamvPpsbayqmBv1FYFKEAumddLtnDS4CJh1y8AIBzX05KyqhzYshbx
         +B+GSdnt/VzM/7aqE5sgLdHJ+V/iOl5m54+e6jFP8bbODtRCsFL9KP5kM1jQ5o0XUqSK
         BWTmp2Gpr9csb7xzPjnjsYQ8LXGQlMNCaBzSIwcVwlFCC/LgcSLta2nQ4wfZYOZxJjl2
         E07By0u0wuPxp77Cc1d4R+zwykeQKFaowI6BP4UUW8e9HSQL0Y9NV7Gqyw2Xm6P7VVKm
         EG2Q==
X-Gm-Message-State: AOAM532BW7ubc4j5honvduSkVe3GSoHUQOzPZC5CXIur5FKSdOvhAoUk
        Dnp/6Fpmb5IDAdshJ37ZBRQ=
X-Google-Smtp-Source: ABdhPJwAZcGCs5OVpkzmitXxPnlCt0gtxwYqTDvcBpN73Kp+EmhxEze7qyyPuNofrda5TH25DnLshg==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr19232438ejw.355.1590431181904;
        Mon, 25 May 2020 11:26:21 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n15sm15555707ejs.10.2020.05.25.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 11:26:21 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 7/8] PM: Use the new device_to_pm() helper to access struct dev_pm_ops
Date:   Mon, 25 May 2020 18:26:07 +0000
Message-Id: <20200525182608.1823735-8-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525182608.1823735-1-kw@linux.com>
References: <20200525182608.1823735-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new device_to_pm() helper to access Power Management callbacs
(struct dev_pm_ops) for a particular device (struct device_driver).

No functional change intended.

This change builds on top of the previous commit 6da2f2ccfd2d ("PCI/PM:
Make power management op coding style consistent").

Links:
  https://lore.kernel.org/driverdev-devel/20191014230016.240912-6-helgaas@kernel.org/
  https://lore.kernel.org/driverdev-devel/8592302.r4xC6RIy69@kreacher/
  https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/base/power/domain.c      | 12 ++++--
 drivers/base/power/generic_ops.c | 65 ++++++++++++++------------------
 drivers/base/power/main.c        | 48 +++++++++++++++--------
 drivers/base/power/runtime.c     |  7 ++--
 4 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a01df608849..92a96fcb2717 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -703,6 +703,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 static int __genpd_runtime_suspend(struct device *dev)
 {
 	int (*cb)(struct device *__dev);
+	const struct dev_pm_ops *pm;
 
 	if (dev->type && dev->type->pm)
 		cb = dev->type->pm->runtime_suspend;
@@ -713,8 +714,9 @@ static int __genpd_runtime_suspend(struct device *dev)
 	else
 		cb = NULL;
 
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = dev->driver->pm->runtime_suspend;
+	pm = driver_to_pm(dev->driver);
+	if (!cb && pm)
+		cb = pm->runtime_suspend;
 
 	return cb ? cb(dev) : 0;
 }
@@ -726,6 +728,7 @@ static int __genpd_runtime_suspend(struct device *dev)
 static int __genpd_runtime_resume(struct device *dev)
 {
 	int (*cb)(struct device *__dev);
+	const struct dev_pm_ops *pm;
 
 	if (dev->type && dev->type->pm)
 		cb = dev->type->pm->runtime_resume;
@@ -736,8 +739,9 @@ static int __genpd_runtime_resume(struct device *dev)
 	else
 		cb = NULL;
 
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = dev->driver->pm->runtime_resume;
+	pm = driver_to_pm(dev->driver);
+	if (!cb && pm)
+		cb = pm->runtime_resume;
 
 	return cb ? cb(dev) : 0;
 }
diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 4fa525668cb7..fbd2edef0201 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -19,12 +19,9 @@
  */
 int pm_generic_runtime_suspend(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
-	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
-
-	return ret;
+	return pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
 }
 EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
 
@@ -38,12 +35,9 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_suspend);
  */
 int pm_generic_runtime_resume(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int ret;
-
-	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
-	return ret;
+	return pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
 }
 EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
 #endif /* CONFIG_PM */
@@ -57,13 +51,12 @@ EXPORT_SYMBOL_GPL(pm_generic_runtime_resume);
  */
 int pm_generic_prepare(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
-	if (drv && drv->pm && drv->pm->prepare)
-		ret = drv->pm->prepare(dev);
+	if (pm && pm->prepare)
+		return pm->prepare(dev);
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -72,7 +65,7 @@ int pm_generic_prepare(struct device *dev)
  */
 int pm_generic_suspend_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->suspend_noirq ? pm->suspend_noirq(dev) : 0;
 }
@@ -84,7 +77,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_noirq);
  */
 int pm_generic_suspend_late(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->suspend_late ? pm->suspend_late(dev) : 0;
 }
@@ -96,7 +89,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
  */
 int pm_generic_suspend(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->suspend ? pm->suspend(dev) : 0;
 }
@@ -108,7 +101,7 @@ EXPORT_SYMBOL_GPL(pm_generic_suspend);
  */
 int pm_generic_freeze_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->freeze_noirq ? pm->freeze_noirq(dev) : 0;
 }
@@ -120,7 +113,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze_noirq);
  */
 int pm_generic_freeze_late(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->freeze_late ? pm->freeze_late(dev) : 0;
 }
@@ -132,7 +125,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze_late);
  */
 int pm_generic_freeze(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->freeze ? pm->freeze(dev) : 0;
 }
@@ -144,7 +137,7 @@ EXPORT_SYMBOL_GPL(pm_generic_freeze);
  */
 int pm_generic_poweroff_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->poweroff_noirq ? pm->poweroff_noirq(dev) : 0;
 }
@@ -156,7 +149,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_noirq);
  */
 int pm_generic_poweroff_late(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->poweroff_late ? pm->poweroff_late(dev) : 0;
 }
@@ -168,7 +161,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff_late);
  */
 int pm_generic_poweroff(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->poweroff ? pm->poweroff(dev) : 0;
 }
@@ -180,7 +173,7 @@ EXPORT_SYMBOL_GPL(pm_generic_poweroff);
  */
 int pm_generic_thaw_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->thaw_noirq ? pm->thaw_noirq(dev) : 0;
 }
@@ -192,7 +185,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw_noirq);
  */
 int pm_generic_thaw_early(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->thaw_early ? pm->thaw_early(dev) : 0;
 }
@@ -204,7 +197,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw_early);
  */
 int pm_generic_thaw(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->thaw ? pm->thaw(dev) : 0;
 }
@@ -216,7 +209,7 @@ EXPORT_SYMBOL_GPL(pm_generic_thaw);
  */
 int pm_generic_resume_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->resume_noirq ? pm->resume_noirq(dev) : 0;
 }
@@ -228,7 +221,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_noirq);
  */
 int pm_generic_resume_early(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->resume_early ? pm->resume_early(dev) : 0;
 }
@@ -240,7 +233,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume_early);
  */
 int pm_generic_resume(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->resume ? pm->resume(dev) : 0;
 }
@@ -252,7 +245,7 @@ EXPORT_SYMBOL_GPL(pm_generic_resume);
  */
 int pm_generic_restore_noirq(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->restore_noirq ? pm->restore_noirq(dev) : 0;
 }
@@ -264,7 +257,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_noirq);
  */
 int pm_generic_restore_early(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->restore_early ? pm->restore_early(dev) : 0;
 }
@@ -276,7 +269,7 @@ EXPORT_SYMBOL_GPL(pm_generic_restore_early);
  */
 int pm_generic_restore(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 	return pm && pm->restore ? pm->restore(dev) : 0;
 }
@@ -290,9 +283,9 @@ EXPORT_SYMBOL_GPL(pm_generic_restore);
  */
 void pm_generic_complete(struct device *dev)
 {
-	struct device_driver *drv = dev->driver;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
-	if (drv && drv->pm && drv->pm->complete)
-		drv->pm->complete(dev);
+	if (pm && pm->complete)
+		pm->complete(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0e07e17c2def..6c41da0bebb0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -640,6 +640,7 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
 static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback;
+	const struct dev_pm_ops *pm;
 	const char *info;
 	bool skip_resume;
 	int error = 0;
@@ -687,9 +688,10 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 		}
 	}
 
-	if (dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (pm) {
 		info = "noirq driver ";
-		callback = pm_noirq_op(dev->driver->pm, state);
+		callback = pm_noirq_op(pm, state);
 	}
 
 Run:
@@ -850,6 +852,7 @@ static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
 static int device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback;
+	const struct dev_pm_ops *pm;
 	const char *info;
 	int error = 0;
 
@@ -867,9 +870,10 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 
 	callback = dpm_subsys_resume_early_cb(dev, state, &info);
 
-	if (!callback && dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (!callback && pm) {
 		info = "early driver ";
-		callback = pm_late_early_op(dev->driver->pm, state);
+		callback = pm_late_early_op(pm, state);
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
@@ -963,6 +967,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
+	const struct dev_pm_ops *pm = NULL;
 	int error = 0;
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
@@ -1023,9 +1028,10 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	}
 
  Driver:
-	if (!callback && dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (!callback && pm) {
 		info = "driver ";
-		callback = pm_op(dev->driver->pm, state);
+		callback = pm_op(pm, state);
 	}
 
  End:
@@ -1116,6 +1122,7 @@ void dpm_resume(pm_message_t state)
 static void device_complete(struct device *dev, pm_message_t state)
 {
 	void (*callback)(struct device *) = NULL;
+	const struct dev_pm_ops *pm = NULL;
 	const char *info = NULL;
 
 	if (dev->power.syscore)
@@ -1137,9 +1144,10 @@ static void device_complete(struct device *dev, pm_message_t state)
 		callback = dev->bus->pm->complete;
 	}
 
-	if (!callback && dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (!callback && pm) {
 		info = "completing driver ";
-		callback = dev->driver->pm->complete;
+		callback = pm->complete;
 	}
 
 	if (callback) {
@@ -1312,6 +1320,7 @@ static bool device_must_resume(struct device *dev, pm_message_t state,
 static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback;
+	const struct dev_pm_ops *pm;
 	const char *info;
 	bool no_subsys_cb = false;
 	int error = 0;
@@ -1336,9 +1345,10 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (dev_pm_smart_suspend_and_suspended(dev) && no_subsys_cb)
 		goto Skip;
 
-	if (dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (pm) {
 		info = "noirq driver ";
-		callback = pm_noirq_op(dev->driver->pm, state);
+		callback = pm_noirq_op(pm, state);
 	}
 
 Run:
@@ -1514,6 +1524,7 @@ static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
 static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback;
+	const struct dev_pm_ops *pm;
 	const char *info;
 	int error = 0;
 
@@ -1543,9 +1554,10 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	    !dpm_subsys_suspend_noirq_cb(dev, state, NULL))
 		goto Skip;
 
-	if (dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (pm) {
 		info = "late driver ";
-		callback = pm_late_early_op(dev->driver->pm, state);
+		callback = pm_late_early_op(pm, state);
 	}
 
 Run:
@@ -1717,6 +1729,7 @@ static void dpm_clear_superiors_direct_complete(struct device *dev)
 static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
+	const struct dev_pm_ops *pm = NULL;
 	const char *info = NULL;
 	int error = 0;
 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
@@ -1803,9 +1816,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
  Run:
-	if (!callback && dev->driver && dev->driver->pm) {
+	pm = driver_to_pm(dev->driver);
+	if (!callback && pm) {
 		info = "driver ";
-		callback = pm_op(dev->driver->pm, state);
+		callback = pm_op(pm, state);
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
@@ -1917,6 +1931,7 @@ int dpm_suspend(pm_message_t state)
 static int device_prepare(struct device *dev, pm_message_t state)
 {
 	int (*callback)(struct device *) = NULL;
+	const struct dev_pm_ops *pm = NULL;
 	int ret = 0;
 
 	if (dev->power.syscore)
@@ -1946,8 +1961,9 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	else if (dev->bus && dev->bus->pm)
 		callback = dev->bus->pm->prepare;
 
-	if (!callback && dev->driver && dev->driver->pm)
-		callback = dev->driver->pm->prepare;
+	pm = driver_to_pm(dev->driver);
+	if (!callback && pm)
+		callback = pm->prepare;
 
 	if (callback)
 		ret = callback(dev);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 99c7da112c95..c142824c7541 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -21,7 +21,7 @@ typedef int (*pm_callback_t)(struct device *);
 static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 {
 	pm_callback_t cb;
-	const struct dev_pm_ops *ops;
+	const struct dev_pm_ops *ops, *pm;
 
 	if (dev->pm_domain)
 		ops = &dev->pm_domain->ops;
@@ -39,8 +39,9 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 	else
 		cb = NULL;
 
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
+	pm = driver_to_pm(dev->driver);
+	if (!cb && pm)
+		cb = *(pm_callback_t *)((void *)pm + cb_offset);
 
 	return cb;
 }
-- 
2.26.2

