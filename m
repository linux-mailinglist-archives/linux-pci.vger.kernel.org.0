Return-Path: <linux-pci+bounces-44425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B220D0D125
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A0A2302FBD8
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8434B661;
	Sat, 10 Jan 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCo3yUZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0D34886A;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=QHmZ8XQeLMfeDBbqy3Zd0J5dyDviPPWfqpwqmVCo8Q9aleSHTJQBrcxwzVq3LkwJxcSFSfa+M6MkeF2/l3DmZlZSxqGm6BpQS1J2NMfXgzb42gcZnWucFsTBwjx9103OOLliiUPI+dxmQ99J06EVBkCYe6YRjzNKiWte0JOaLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=phbllhBeNk7oBieBbdMZ19g98Tr+ZxNyuZaevxor5S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZi+/8Kh7fY1QvxcNi3p7ZH/2CQ/TaTXgo+FqATesgLPGmrSccezKeMayv4cSYS4uNQdLElxs+sHkj+pBjOoHeqzwC2l1ngGwxlQ2VC4wkISrvlYBm8LJeSiIAl9QcbIcI81wIfI0HnthQUd6OQTQlrZj28hFPe/i5zVc8OE03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCo3yUZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD7FFC19424;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=phbllhBeNk7oBieBbdMZ19g98Tr+ZxNyuZaevxor5S0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rCo3yUZbliZxFJjCLNnr3ao/3eKdXJRjdxNCKL1dgAuVR25PrtYUQa++eg4jQk3UG
	 D5cRpH6hfMNavb9G0YSqoVJF+jZguX5F3VVS9S3UbeBEcV1syrJGHPzy1dXpHfv5LF
	 R8jEyANwfouvfvJl++ql4oqJtd5WuVD7wrfOmxOKW4/1B1HGCqa19bFmX0A5GKyFfm
	 G1rU+TaDVbgzDNXZKbEnIaIoGDj6BEj1yQ7SCYG/P53GEOpv2nTKmrQOSZbvq+v0G7
	 6BwmvUWYRA0zYGYLzKqxcOuW7RrytZ0jl7VKiNkZKOoQX5nwTPgivITAtSez3MlFKz
	 KBd8zizqlYUMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46ACD277D3;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:25 +0530
Subject: [PATCH v3 07/14] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-7-4faee7d0d5ae@oss.qualcomm.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
In-Reply-To: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
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
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
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
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9Khi7o7bjNURNbJHChi9Xs/IzE+Q745IFg
 DPzM3xXfTSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9eknB/95WTOtPz5HLwNUgBkyhmw8DmzD+WDdce0vJG/uQuv0n1DteeIGEGWfk3J+AwD4yw5Qvf3
 MBgUN+vYR9nPgUps3USOkcAQY7k2zB0DD+lG740F/O9HMn1QgJVZwJB3z6jZJYX0RYN5E0G+0Ja
 5tUIYLvLIkBrA5v+F6zttdaSct+cV61re7lcrHQ3RvQv2/ubaQ7CFBfzH3Y3mTjlmYtswk2vyHL
 s5FyAXMRn8ufKtq1GigdLpBVZQLrXTOO7AJjbBXHKbCWfyS7O7SevC48eb1xZX+Brv2hCxAqm/0
 74flSptHZ9lX9lzSnAWH6QnuQ05WR5/1235YG1Ps0YbVkw4u
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



