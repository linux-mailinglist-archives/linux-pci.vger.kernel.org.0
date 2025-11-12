Return-Path: <linux-pci+bounces-40997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5438C52D32
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DCB234F165
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E513446BB;
	Wed, 12 Nov 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+kgUaAP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9642342507;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958731; cv=none; b=A5oYOUt16cDvCPmlhZ+m64HQry+DSQJUZ3dHzaVyTsiBNDaAwdPFejfL1NmKg2LCbOFg9PYhRqD2+aIGho1UAxl5oAoBX/cfZ0T48cf09IK9hzP9+WxnLOpztGUeOuoLpua7UtVbwB9gGt8zWf1af8zAoiQHGiUvhcIdeWjHizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958731; c=relaxed/simple;
	bh=BSF6pgHwRJ8wKRNwr418rTD4ufEtxZ2p1Im79cwxzV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oApVg7ajpgxDNOQR1MvB6dRiK8kmQm1WO4gGtwKdHwK4b5jLwg/RmsTAqox+vELACiZhgH9pN4AnM4RgoYPh8w0n4sDd8YhkPr6G7oOhGWU/Ob1yinjGfHiYTrBLLeoWf9mM9bSSflmB7BXevs10/Lf6t/tLJGquaCAR9BsnqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+kgUaAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40F42C19421;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958731;
	bh=BSF6pgHwRJ8wKRNwr418rTD4ufEtxZ2p1Im79cwxzV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z+kgUaAPEnBSn83dE5sic6dzmfi26DDd05Jb/aMOfrFa02eXfQAaRBR8gJv7wwABK
	 NSeYUVhHujfgfPy65QPOy2aG2xmfxpYZ0mOsVgS2z9Bpb9zMtQZXbA7LQpwV+h1kMA
	 B/BaRARCqz78Wk9Q4+vTkp4wt9HS32wrNtVyTa7itnIfDpNzO8BIdeKYUkbxvlQzwg
	 HOxB8vI8EFMic++Gx08VLXQ6LDTNZfQh+98pYRTaTrHBUwWHP3RHyV55CJRwdSUyxW
	 m/kyRfpddntflRYGcoflMSaG/hf8VgdjM8QhTO6YY7CdG0XnpZGcZNKKO5JPhS5DH4
	 gkIhXtosM/s5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9DCD1297;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 12 Nov 2025 20:15:18 +0530
Subject: [PATCH 6/9] serdev: Skip registering serdev devices from DT is
 external connector is used
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-pci-m2-e-v1-6-97413d6bf824@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9l0vV6HXXlRQhGb6LPV2j9zLb+eL0Fpf0v/SXfsrOaY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFJ2HYIFtN5v5bNyD8H02BJPR+1uACNYqLJQdu
 pU9f/L5A+2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRSdhwAKCRBVnxHm/pHO
 9RwgB/47EH+jLOBR8bp8aP5M5wGWY4SysKJtZO4fkj97iCzy/SsK9prWiuuaBDNz/F5VfGuxdtE
 Kin9UH7qcWGK/P3pKH7xvC9p6Mm8NlJjS6oni2Z3zPLX6VllhharFcxCAoHHjXEvdbaw4EPGomr
 S7Bq9ooyzXH3s3+GqPs7RdiqKCh3HIEhlt1xa550XiX7bCQDgjrsNVHqLy4jWaCrdWhfQ74eZlV
 pJaVlLxPif2eLcTh562fAWZ2dA/Oknb7ywQKC0VSBcQyZqRuMwRMHr0eZOkcPwWg8i7QsB5jXun
 UbBPcW1fXEPr3OZDqWb5SWwrc8t+apPpHsnLxxflovrsrkqs
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If an external connector like M.2 is connected to the serdev controller
in DT, then the serdev devices will be created dynamically by the connector
driver. So skip registering devices from DT node as there will be no
statically defined devices.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 8c2a40a537d93f4b9353a2f128cdf51b521929b1..1378587d386356ca4415fa455b2ee722b5e44d3e 100644
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
@@ -560,6 +561,15 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	int err;
 	bool found = false;
 
+	/*
+	 * When the serdev controller is connected to an external connector like
+	 * M.2 in DT, then the serdev devices will be created dynamically by the
+	 * connector driver. So skip looking for devices in DT node as there will
+	 * be no statically defined devices.
+	 */
+	if (of_graph_is_present(ctrl->dev.of_node))
+		return 0;
+
 	for_each_available_child_of_node(ctrl->dev.of_node, node) {
 		if (!of_property_present(node, "compatible"))
 			continue;

-- 
2.48.1



