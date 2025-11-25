Return-Path: <linux-pci+bounces-42053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B9BC85871
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921323B5763
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438D328B66;
	Tue, 25 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av2mepu3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827515853B;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=lkPI8k+U4YOPrcV8p/gQmBBH1bfXMd2MMW+Epxmh83qqGq5t1bgBiMPbP3jqbn9v3T9wWIVXUqTp7AFacq92O78gECdRxH/RCXVEAB+NOb2a4dumtOEIoKa2Ea6MdBuDEnkTOymIUjVbteWIPuOI+wxsCeCIrkq1EuMxrBGY16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=56s09BLbgnJ1DBqbUoCLxzruZZW7MAhobGQU7FBMcnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkdEGA+f/PblkJSRBkvs7+VGrMRZKW9p6vhjx3HXFGwdNgOiP4W/d4iG0ufOU3ppojZ0RLq5Qnr2D4CtGo1IzcOIRsFFjgEOmk//Wq/LykiqmR2SUZU0IfMbq3wJhw3eWjgPGlkn29a5+hWECt/xw/Y01dA1BPVRcgkTvvNPJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av2mepu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 803AEC2BCB2;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=56s09BLbgnJ1DBqbUoCLxzruZZW7MAhobGQU7FBMcnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Av2mepu3HVgGcH8yT6Hv70rvyq34rsGb/CyT9bCT+9AZWTxSRRSsid5rhSZN/5KoK
	 RQahI3Cf01DU5UyAt0wbs/g2IzP5kXD1lE5yQqWnZfotbxgiNf0cBjdmEGmZugrLjc
	 K/eOtVndULFopNmYP0bm+wufvWSJhCrlTN2CklgAvBMDIlqTP3WG20nP8qjjrd4lAN
	 8sG1rhBZW51A3eRudZ3/1HmpdZHVbPJgnWuWvUem5z3NjF5bSyntaMxGNprkWysBob
	 ZCw9U1JBa2lD4RcM7f3Hzy1sdNobcgJFgVDB5DlOmMm/tjVuFFaz2GBSUwh/AH26Js
	 1T90jdhs5ouvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB7DD0E6F6;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:11 +0530
Subject: [PATCH v2 07/10] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-7-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=QcEAYBjlJFUxHXU+Wo92JzR+zJXEhzi3DteqtBBgZqk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDyHTNmc+abBx0paWJMqzF+5yCxlIMn7lZAQ
 loKsu5yL3qJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9czQB/9PcdU/lszhQX1FDeJbUv8qeX3bQlytQfBLiNv2jwbnkmhEhmw42aN14SS2XNKboCv2RP1
 MDXleY3i0N1Y8AuuV+mo1Sb8+t9UBj752tJekDjqhlA4NyB94h1DuWjxhxiaYwstI/u7HjF2r5w
 bPq3EG2ovCurrGjzQb/KJgVpHw+NwIU2jyCTcR5yYCX4O0oIqOQmXS3gQ2o3yzrGoEHHSpukBKT
 6E3HNOoSTngB1rTr2O4+EqBbqT2VFKAD9hbtTF+N1RrdmhOWGx81oCaMKcYOGzHWnd5pq0g26yq
 F62zInTRAB1m+W65UO0GSTZ7gAK+ZrskcaPczJfmwnEdhp6B
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 8c2a40a537d9..fba7b98026bb 100644
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
@@ -581,7 +582,13 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
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



