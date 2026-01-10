Return-Path: <linux-pci+bounces-44428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B29D0D1C2
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFA7F300BFAA
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC234D3A5;
	Sat, 10 Jan 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+46ZSUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB03491E8;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=hQAb5zW6KER7r9ulwYp70ijgUSJ7uuR6Lhz7fycciKGY6fpWmqMmRS3Ub7SMq6RW80o7hJluxTgfgqe9ALh2soiqewgLAdn7rYfpiGXdNq7E0y7esY5GC6nFws7RFP90cY1ux71X4PT0GFdu9nGIG0cLo7i8hDSSMzx5xjEAfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=grrBzUog12+WE5FP8RC1t7J6n4Xk4iWQti4S7q8UyIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MhXbq+QqEvWb7qZkADR+1IS2E4AhpBl1cccA9R3VF4Y5nxQAKIf4QoBbKGTIS9B7G1EBjM9nwjmJdMzM3sOxBZ/nu7sJox2n2p8KmSLx/cY6FpMjjTsIKsMP/RdiL6ag49FNiLjhfc8huWihkUDlNlp4VhNTJGs1B57Bc/rWe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+46ZSUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41874C4DDED;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028226;
	bh=grrBzUog12+WE5FP8RC1t7J6n4Xk4iWQti4S7q8UyIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y+46ZSUVPRG8or10IEAc5K4WnTRcjNLX1zKfpPK/FbnQbt4hkGqutU5/SREEtU2eg
	 sacUr999eMhZJAHDgIo5FDnW2bHvV45IkuVjsvk/RwMK0+oFo5HwhrhdKINBmRQDTx
	 TfQ2kMfParQ1668io3+FOmn/gRU9wAVT3BqDzoJuZRM3PkJtG7UnwizPgYXGhysU5S
	 TiB/URbjNyYYrX5KpylNLT9pkpBM9tMWcGAVUrgw/plNTP1lLW6J+cwMzmNgu3zu3A
	 lYQcY5rWMX0Vb1hJfHFwfp2Ujf76LjQ6vEMAG67CqEnZOfMTmeEhcXRGNbHoFwrjeg
	 rMX+V/clzP7EA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37621D277D8;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:30 +0530
Subject: [PATCH v3 12/14] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-12-4faee7d0d5ae@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=0KqheeXO4Oi8QyG11TDbNEO023eYG3+bTSLkuoPEKb8=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGlh+D6gx1X1RntZ/K3yScUSxWdo5j4RadVoAdU1StMEGJj+n
 YkBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJpYfg+AAoJEFWfEeb+kc71mzUIAJKD
 LOTvAaJoMZCbAEBRXhX0J+Cz3taMSKs4B7qN/TsxqpJVRl+LWaQOw+E9j1hqK3hQYAyWZDV48j5
 NG9BdtI0REUp0PVJgnEZuOc37ZTr97/2ybJGi+qgPbpdMp7v7a+JfY7G3sT1p5CKlD5e0YTZpBo
 X4QzA0Lry9bTVIZJMkbvxdTiUaUhDJONrzt/xZlidYiZ+6wOzzGAVgWmrbb00cEDP4FcqYexCHb
 Q79eFCjTiTh+mNfyJTtyVtU8nb3sfkdPRjiU3Uxk9oMDoxVp0MLPqVj4CJlfxaogiGv0uonuVxj
 EsRsjo86nq1xDPs0QI2omQWzootWm2f9IOEOoh8=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0faa9..4d562596ebf9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2384,6 +2385,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 	case QCA_WCN6750:
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.48.1



