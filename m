Return-Path: <linux-pci+bounces-41001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81AC52D62
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D39C341048
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA734CFAC;
	Wed, 12 Nov 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+eWFXLV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C485341642;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958731; cv=none; b=ZWQk9UWlNF3UOZTaGncnNR2O3VARQbaRZSacdFpLAk3JVfXTy+jJsravbEBuLECGCnj9ZxCIPYd0ganCGmHTq92RtvPeuji/0mZ5XZnlkrdHa8hKgO50JRmBYxU+kRzNrVXquxWOeCBXwGAuX1NArmgYZKRmyvrdVZn9mBkYQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958731; c=relaxed/simple;
	bh=ZTNyhNFf+p9S6BsXERBUufVxby0L/rriRpDnCjmebu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+HfB4367+6JE4M6txICxo34XPeUx+Bjo6QFObxj/pylCgURepi/rwq+WYC/gF4lMtGI8nyLzd3owH3ARxIqJdgYoAAFhl+h/SPha/g/T0ujmyHpB9aurNCE1ArQJTkSAVJRehyXJOk4Ahd7+xISlNIjq6Zdr86WZij4asE2Df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+eWFXLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C6DC4CEF1;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958731;
	bh=ZTNyhNFf+p9S6BsXERBUufVxby0L/rriRpDnCjmebu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c+eWFXLVVteOvv4fIzjsKblkThHYhc5ibkkgVCrxCYjAbRU9sZvC0W2NsRkPWDD7L
	 wuClsqH0O8DEEqHgFdIYFdlSUl8pHqEd304fkB9tzkRiyoAB3sB227XVjrFfmi+Qfc
	 W6BYl+TaXj5RSovSCewKJgS5/LMm2qCcM7+oVgBhmZMprkoCCcFiahsh7l3EsTaEh5
	 VILyCGIZl0HDu9lhuqQiv6fwfsI4uhB8L1aV02m+vxyXbd2nlqO9Gjk11WMHjA4kcL
	 64fIVPVSnsjRLCIoljDLNCShdloLJoEoCYX4DyXAC9QVKtTOC6gSiNl1vsCeeBB57k
	 JVQBrC2Wh7H8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEBCD13D3;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 12 Nov 2025 20:15:17 +0530
Subject: [PATCH 5/9] serdev: Add modalias support for serdev client devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-pci-m2-e-v1-5-97413d6bf824@oss.qualcomm.com>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3104;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=d3crWSGCGUGn4wtoYTdDJMgOBARJSAYtgVh6kQhItYQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFJ2HLBj0atRdQkoYoEtIlsRq/2nfEpNLLTmK8
 0Ee8SHCPp2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRSdhwAKCRBVnxHm/pHO
 9ccoB/9JulXVNBQpte5g04Zu3cGVEtybP7nbcJRotlJ106/5GvyjbUjrShqI832UjbWtjgtNtc3
 myVXAVbBbIRPoaVWY356o/T3owMpyRDkiLZk1NFJ0RVInasTwuDM+GXTT3URoLQkCYbusx7nlfn
 pP+eHsk+ZjcXWswcI+pRcm1d63s65LwpVHyeZlcxQv8r/cg/MbUp/PMEZiSHw/e4Ka3pprDytt7
 2Osv6Mynw2x9nJ5M+sb3n1u0NRLnqeM/D5s/sPFAwyMHsCHy2VVabnJSwo7BsY/opFJ4jUa1c/k
 ryGpgpPFOpTHT7cFdpd8gXslxG4YoRjCn7kZZjis3WqdlDMM
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add modlias support to serdev so that the serdev client driver can be
autoloaded by udev when the serdev client device gets created.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c       | 15 +++++++++++----
 include/linux/mod_devicetable.h |  1 +
 scripts/mod/file2alias.c        |  8 ++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index f90095cb778f2374303f98809d1639a000e0d9e0..8c2a40a537d93f4b9353a2f128cdf51b521929b1 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -34,7 +34,11 @@ static ssize_t modalias_show(struct device *dev,
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	return sysfs_emit(buf, SERDEV_DEVICE_MODALIAS_FMT "\n", dev_name(dev));
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -48,13 +52,16 @@ static int serdev_device_uevent(const struct device *dev, struct kobj_uevent_env
 {
 	int rc;
 
-	/* TODO: platform modalias */
-
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
 
-	return of_device_uevent_modalias(dev, env);
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	return add_uevent_var(env, "MODALIAS=" SERDEV_DEVICE_MODALIAS_FMT,
+					dev_name(dev));
 }
 
 static void serdev_device_release(struct device *dev)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 70c54c4bedba2fcb8f5eb37c2d9ede05d5d91188..dad9637cf28552c3423affc4eb249efa6ba05514 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -976,6 +976,7 @@ struct coreboot_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define SERDEV_DEVICE_MODALIAS_FMT "serdev:%s"
 #define SERDEV_NAME_SIZE 32
 
 struct serdev_device_id {
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b3333560b95ee998fbe5bdc9ed380847962d1bd1..27e9f7c718c4d48ca5dbd5538490529119df9509 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1371,6 +1371,13 @@ static void do_coreboot_entry(struct module *mod, void *symval)
 	module_alias_printf(mod, false, "coreboot:t%08X", tag);
 }
 
+/* Looks like: serdev:S */
+static void do_serdev_entry(struct module *mod, void *symval)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+	module_alias_printf(mod, false, SERDEV_DEVICE_MODALIAS_FMT, *name);
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1467,6 +1474,7 @@ static const struct devtable devtable[] = {
 	{"usb", SIZE_usb_device_id, do_usb_entry_multi},
 	{"pnp", SIZE_pnp_device_id, do_pnp_device_entry},
 	{"pnp_card", SIZE_pnp_card_device_id, do_pnp_card_entry},
+	{"serdev", SIZE_serdev_device_id, do_serdev_entry},
 };
 
 /* Create MODULE_ALIAS() statements.

-- 
2.48.1



