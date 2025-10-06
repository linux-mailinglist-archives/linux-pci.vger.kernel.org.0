Return-Path: <linux-pci+bounces-37608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38570BBDF80
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B288B34B365
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8A27A935;
	Mon,  6 Oct 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="C+AQMfl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B21FF1BF;
	Mon,  6 Oct 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752601; cv=none; b=dVRyfMHrQu6FsZ61JJ5n7YlNpINlNWSHqjOI+bKAulqEz23bC/eMiiR/DMmNN9Zv9I2cm431zNbm5pHspezK3fuwekypDEM+eLv3sA9wN9VjBFbqc1anUv7Wuss4wGLHVjiF6o+azmc4m66wNPrilFCmwkCcGI03whjqcPBrfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752601; c=relaxed/simple;
	bh=DSYgXcHamOXVeBdcgtnClxPl3hrCqiebkarm5Ggia2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvM3zl5tseC80QXMgQ7XF1M0AF5OhPF9c7ya0yqmfJbMv6nkbjg8bbfXpVabaSgH/zgAfhM6BdrCxbvKka/Lbo4O0l1ab3bQxyYhouyssDbDDoGlN4r0WySSanyU7Kdy0gGERjd0M1sxDYLRCY9ZRpXjMz8ITtcNGFDyMu7FAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=C+AQMfl2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759752591; x=1760357391; i=spasswolf@web.de;
	bh=JLB8PIbw+N0LUkNlfemzeyl2cSVv1Y33puUJfyYXRrQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C+AQMfl24FpVECbRXpddNfjmKQohob1whjIudoW/HX2GBf04Gsig46lcd36lB0ia
	 GNVw5wIqwa4kOsPHBaNxK5J9obbjk7+PvqArJtw2UX2r3OzxPA+AwB6VPNAgfdTe7
	 1qSbTGrk8gwD1aerGOPKFpYszfUbch44SyGTp6L9wwJSvRFv+OF9l1m0VKqCiW52r
	 QIsQ8Po+i3JRTEoPM5a0qW4XDHkVyD8aE1jfijnRD6zR1IFDpnekcexzXBc8flgx0
	 k+NVGfCLB5js0bbHESvUTwDopWSec5/6z9d0aAXWw50OfZWN+R378zM2lcVFtlYXl
	 +TpIYELYZZkaeN7EvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MVrbl-1ugCqJ31Yz-00QPsx; Mon, 06 Oct 2025 14:09:50 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [REGRESSION 02/04] Crash during resume of pcie bridge
Date: Mon,  6 Oct 2025 14:09:41 +0200
Message-ID: <20251006120944.7880-3-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251006120944.7880-1-spasswolf@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mF1VfaeKK6Z0Q7Jw66XZvY88uyjqZSABj9lCKeKBY58OQ7X6jQG
 k9kJd9W1euWlNlEBez7Ihlq+cMHHA51z9aEudxhkrboMWDY3juh4QqhHYSWZ+ZGtEo2rU3K
 anlYwoWjTfPfappcP4Tzs5Lr37noUhKURXb+X9t842shwtjabkMaE4yLe6ScMJ8cSLCe95k
 cdLJdPzDTaplWN2zUWCVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oKa04mgs+9Q=;ZjuoQV5xeRtJtVfzqyMnZ09zO4P
 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

The next step is to monitor pm_runtime_get_sync(), rpm_resume() and __pm_r=
untime_resume().
Here we need to use conditional debugging output or else we get messages a=
t a
rate of about a million lines per minute.

These is the additional debugging used in
6.17.0-rc6-next-20250917-gpudebug-00024-g5c6b49b810db

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7420b9851fe0..895898c3cd56 100644
=2D-- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -787,12 +787,18 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	struct device *parent =3D NULL;
 	int retval =3D 0;
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	trace_rpm_resume(dev, rpmflags);
=20
  repeat:
 	if (dev->power.runtime_error) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		retval =3D -EINVAL;
 	} else if (dev->power.disable_depth > 0) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		if (dev->power.runtime_status =3D=3D RPM_ACTIVE &&
 		    dev->power.last_status =3D=3D RPM_ACTIVE)
 			retval =3D 1;
@@ -808,31 +814,45 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	 * rather than cancelling it now only to restart it again in the near
 	 * future.
 	 */
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	dev->power.request =3D RPM_REQ_NONE;
 	if (!dev->power.timer_autosuspends)
 		pm_runtime_deactivate_timer(dev);
=20
 	if (dev->power.runtime_status =3D=3D RPM_ACTIVE) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		retval =3D 1;
 		goto out;
 	}
=20
 	if (dev->power.runtime_status =3D=3D RPM_RESUMING ||
 	    dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		DEFINE_WAIT(wait);
=20
 		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			if (dev->power.runtime_status =3D=3D RPM_SUSPENDING) {
+				if (!strcmp(dev_name(dev), "0000:00:01.1"))
+					dev_info(dev, "%s %d\n", __func__, __LINE__);
 				dev->power.deferred_resume =3D true;
 				if (rpmflags & RPM_NOWAIT)
 					retval =3D -EINPROGRESS;
 			} else {
+				if (!strcmp(dev_name(dev), "0000:00:01.1"))
+					dev_info(dev, "%s %d\n", __func__, __LINE__);
 				retval =3D -EINPROGRESS;
 			}
 			goto out;
 		}
=20
 		if (dev->power.irq_safe) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			spin_unlock(&dev->power.lock);
=20
 			cpu_relax();
@@ -856,6 +876,8 @@ static int rpm_resume(struct device *dev, int rpmflags=
)
 			spin_lock_irq(&dev->power.lock);
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		goto repeat;
 	}
=20
@@ -865,22 +887,32 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	 * the resume will actually succeed.
 	 */
 	if (dev->power.no_callbacks && !parent && dev->parent) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		spin_lock_nested(&dev->parent->power.lock, SINGLE_DEPTH_NESTING);
 		if (dev->parent->power.disable_depth > 0 ||
 		    dev->parent->power.ignore_children ||
 		    dev->parent->power.runtime_status =3D=3D RPM_ACTIVE) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			atomic_inc(&dev->parent->power.child_count);
 			spin_unlock(&dev->parent->power.lock);
 			retval =3D 1;
 			goto no_callback;	/* Assume success. */
 		}
 		spin_unlock(&dev->parent->power.lock);
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 	}
=20
 	/* Carry out an asynchronous or a synchronous resume. */
 	if (rpmflags & RPM_ASYNC) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		dev->power.request =3D RPM_REQ_RESUME;
 		if (!dev->power.request_pending) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			dev->power.request_pending =3D true;
 			queue_work(pm_wq, &dev->power.work);
 		}
@@ -894,6 +926,8 @@ static int rpm_resume(struct device *dev, int rpmflags=
)
 		 * necessary.  Not needed if dev is irq-safe; then the
 		 * parent is permanently resumed.
 		 */
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		parent =3D dev->parent;
 		if (dev->power.irq_safe)
 			goto skip_parent;
@@ -909,6 +943,8 @@ static int rpm_resume(struct device *dev, int rpmflags=
)
 		 */
 		if (!parent->power.disable_depth &&
 		    !parent->power.ignore_children) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			rpm_resume(parent, 0);
 			if (parent->power.runtime_status !=3D RPM_ACTIVE)
 				retval =3D -EBUSY;
@@ -919,10 +955,14 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 		if (retval)
 			goto out;
=20
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		goto repeat;
 	}
  skip_parent:
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (dev->power.no_callbacks)
 		goto no_callback;	/* Assume success. */
=20
@@ -933,11 +973,15 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	dev_pm_disable_wake_irq_check(dev, false);
 	retval =3D rpm_callback(callback, dev);
 	if (retval) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		__update_runtime_status(dev, RPM_SUSPENDED);
 		pm_runtime_cancel_pending(dev);
 		dev_pm_enable_wake_irq_check(dev, false);
 	} else {
  no_callback:
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		__update_runtime_status(dev, RPM_ACTIVE);
 		pm_runtime_mark_last_busy(dev);
 		if (parent)
@@ -949,7 +993,11 @@ static int rpm_resume(struct device *dev, int rpmflag=
s)
 		rpm_idle(dev, RPM_ASYNC);
=20
  out:
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (parent && !dev->power.irq_safe) {
+		if (!strcmp(dev_name(dev), "0000:00:01.1"))
+			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		spin_unlock_irq(&dev->power.lock);
=20
 		pm_runtime_put(parent);
@@ -959,6 +1007,8 @@ static int rpm_resume(struct device *dev, int rpmflag=
s)
=20
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	return retval;
 }
=20
@@ -1181,17 +1231,27 @@ int __pm_runtime_resume(struct device *dev, int rp=
mflags)
 {
 	unsigned long flags;
 	int retval;
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
=20
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
 			dev->power.runtime_status !=3D RPM_ACTIVE);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (rpmflags & RPM_GET_PUT)
 		atomic_inc(&dev->power.usage_count);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	spin_lock_irqsave(&dev->power.lock, flags);
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	retval =3D rpm_resume(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d88d6b6ccf5b..0888b0d5ec73 100644
=2D-- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -508,6 +508,8 @@ static inline int pm_runtime_get(struct device *dev)
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s\n", __func__);
 	return __pm_runtime_resume(dev, RPM_GET_PUT);
 }
=20
With this there is no crash after 60h uptime with ~3093 GPP0 notifies, pro=
bably the
printk()s are mitigating the crash in some way (i.e. there's a race and th=
e printk()s
are slowing down only one side ...).

It would be nice if we could get a crash while all the printk()s are in pl=
ace,
but I'm not sure if we can ...

Stopped 6.17.0-rc6-next-20250917-gpudebug-00024-g5c6b49b810db after 60h an=
d 3093 GPP0 notifies without crash.

Bert Karwatzki



