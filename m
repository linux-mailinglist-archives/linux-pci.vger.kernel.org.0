Return-Path: <linux-pci+bounces-42056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222EC8587A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 105DC4ECD17
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D00329383;
	Tue, 25 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBqllVfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E31C3BEB;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=TbmRSecwfXJ6mlU20lTKir+gLZV1IDZU4cmDJjBR9Rd8Wix72BMAT/bnL6Ius7CGmt7luvV+shVEtRYk116VlST5P5Ac+bfqruRPjr79N/jbbW3z3TAZqf8jdZdD7Kt8WERmeStkWvjxFB9R27LDxa7Y85SPXEwUyi4M++D/Seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=WVav3iC7Lmw6dUFRYUOqhq8J39HrOTGyqCxxOeDPZ5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IW022H0uNJGrHiB6Chi+OtQYTYi91RFTHuSX+ZVOFJPf3dKaL2fNtyg+bHCtzSoGF+11sS7brljIz0j0IyCh4Hhyc3k6/vbPin1Owxr3SZLw10LWP8NjwTmGacFmX7LUecScsnH2rQeugzpha8DObeV7HTB4RDYfqhtWUsC548c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBqllVfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575ECC4AF15;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=WVav3iC7Lmw6dUFRYUOqhq8J39HrOTGyqCxxOeDPZ5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fBqllVfVPCgalSP4iJFWfI2UyfIOHGXcSm2bhXWl0XQ0LVzX6wFLET9olLy/1RrNN
	 so08wbM8Iv5fCLbUV/CkOE3WPYOBhuFEnTLvKM6/rEfliPrNWD80HwkGxWk1k5ucav
	 tSFzsD0XTvb3rSOtLLpFtcvLnqUrF79jPjYJLn9QnU+R5uoLMEg9keRDAYk2OJQbb/
	 QA7w++K0Q+oEXdy9GXOCi1I+uI6KB7vBa3A+s9SSq5YPb40xRVlbhHuxDzxj6c4l/x
	 vlcFyUkLGjWFUhx+bNEzdYpikJh9QQxHTOCRIXXowvSftksjkXYbQd9rB88USvqNZV
	 9AH7mc6RG2EbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9FD0E6F4;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:09 +0530
Subject: [PATCH v2 05/10] serdev: Add modalias support for serdev client
 devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-5-32826de07cc5@oss.qualcomm.com>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=gjXZ4ODUA/MYLty4jJHXHkQmOHjsSMkGR4F70lFPVI4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDy90oxovtDgun6+KJ2wUFBov5MmV5lqLA75
 lX1QA8p9MuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9Yq6B/9ZJq7zIPVB1U+K1aQfSJS3FPRCu0EbLegBLWtdg2XDtd18EPvmO1ZCeEir7I9iXFdKlTD
 RFLoupiL5hK/8rEBMwh83WP50gunVpd2d/yKUKaJ356NyZEjDk7HuaH4DJCK+Ic5fM0mhMalCU2
 K+4rsDUA1pz2dNpv6qKRW/AzOT+Mmg1SFE7QQvnMVgvs8wlYz4rvDAYfQaIgnzNXCqd8qInGxdC
 MmWoorvY/lvAGLZPIcp1OZQlKFHtZcxbrBONSaGXitRxE0ZFf96bfzPvl3hCGMWpRpBNyzX7D/k
 UhZPI8MMDrDAZHp2zaFfo2NT3aG5cL3YyEHowXPcNV8f5nBP
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
index f90095cb778f..8c2a40a537d9 100644
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
index 70c54c4bedba..dad9637cf285 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -976,6 +976,7 @@ struct coreboot_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define SERDEV_DEVICE_MODALIAS_FMT "serdev:%s"
 #define SERDEV_NAME_SIZE 32
 
 struct serdev_device_id {
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b3333560b95e..27e9f7c718c4 100644
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



