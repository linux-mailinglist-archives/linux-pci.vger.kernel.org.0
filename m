Return-Path: <linux-pci+bounces-44518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC88D140A8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5BA30B960E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C9368271;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4nQZ1S7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75492365A0C;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=JWcSMDpuaM8AaFa233P7up1Ov1dUkkdNB0RHmMHVE96QXQwakeTHp0OdgFx1cwEdmECsLUp/Ecde5rTmi4KYA/Qk7zw6T9dRw0DmnoMLvGmeYm6wxoj1frJX9oYIh7Zuu8LIJu7WNL9NEdkCNb0jPjuszsA7O/pj7yZNNQf0t7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=phbllhBeNk7oBieBbdMZ19g98Tr+ZxNyuZaevxor5S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5PHELz/CYG+KFhiBzxNjyNtMIlfvWst3ovq6CpSuwu6AhO05/99YN5WKhbl0hC4WmNIfphc421ZrTZJsowfs0mcmYLBFjIET2YenetvojVgswwY4vupWsV36Sv3ZqfGoic9+9FRUhlQ82QeugTwxcUvrFY8Np0v/v/vTN//aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4nQZ1S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B553C2BCB2;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=phbllhBeNk7oBieBbdMZ19g98Tr+ZxNyuZaevxor5S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F4nQZ1S78CcMZWdW1XgLQGl1teVUKpAnABs9/uUWl8FS/su+2V/Un2fforQvWfTmp
	 YIjDhF79H+ThwzIu4IzuDcLu+9eLlKM76n4HYP5Uh6LCwawyfVFfIPbBrgDuOJMQds
	 fbPBdlytTcyrOWBfesgw2LBrxa+qQoWQbmYqBf2S1mAzxmB3Rd9+le6ITiyXHE+N8V
	 9tb7YVVp5LrUSobxjIi/vDulZAQtTSOOi/XumU/eHmdt2kWd++646HMidlojuF0C4q
	 lf/dALibwLNezGpjo5Cl9gORvSb0zEWUBHOu/xC/3LHIkfFYoOEfWao7mFMxs5hhOL
	 0PNDYYB3IN7Vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B88D26D97;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:02 +0530
Subject: [PATCH v4 3/9] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-3-eff84d2c6d26@oss.qualcomm.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=70A6WG9+LyiVcQGDZXLPxALHM/UGaFUvvsHfTehdZzg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtRw78QNqqJdo870z1l/BYbYj/u0Xo8r9YZ
 n37jmcGrM+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9XR+B/0VHC0628+hDHpd19trCYGlXPgy6Z8cGBNjn01kj0yUXk6jb/+LeCFJ2G9lQb/kax+79eM
 AXWKVqINoOT5dQbYrlX+VTPS9X6V6SDDJ8txyXwch2RDN01oFF9zNYRj2XFiweXK4TLvcTeEBoj
 lvvN0KMMMNvn2na1hauUv9k6EJhLjvY0R8OMW5h1fElKq7CbQkWWYppz6RjOV+PCcEI0dk/Bf/q
 JY0Gyn0ro6S7fq+GL39z27cRhl7DlIjVZBLMlj76Fdue8Apoh7ZUpZd0gU6rqRJNDrNcrm1izz6
 MrZl4F4astYmm88mZceGrs9P9ar2MV8krQPH3LbL7pvBZLCp
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If an external connector like M.2 is connected to the serdev controller
in DT, then the serdev devices may be created dynamically by the connector
driver. So do not return -ENODEV from of_serdev_register_devices() if the
static nodes are not found and the graph node is used.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 25382c2d63e6..f8093b606dda 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -548,7 +549,13 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		} else
 			found = true;
 	}
-	if (!found)
+
+	/*
+	 * When the serdev controller is connected to an external connector like
+	 * M.2 in DT, then the serdev devices may be created dynamically by the
+	 * connector driver.
+	 */
+	if (!found && !of_graph_is_present(ctrl->dev.of_node))
 		return -ENODEV;
 
 	return 0;

-- 
2.48.1



