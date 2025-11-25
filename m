Return-Path: <linux-pci+bounces-42051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A7C85817
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22D854EBEBB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E83271F4;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMri3jMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0B3246F0;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081911; cv=none; b=O9UNZ5Xy0SHOuMSA4XPhUM+djfVRT6PegYyKnNqWfgfqsx8EOvk0UK1FxqxTdqlZqqd2sqykKdbt9i4pgsXl20d/FuAHSRCQWXKJtEZ3lt/LNMOpd06F2kNC1ISBCJlD8Xaj/pFpBv2t0ILjJNU6VmueMGp8zNmTAR20OEUt1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081911; c=relaxed/simple;
	bh=rR3gz3yzpBRkBDHXSaogJdTENZ1CLw1h0jHGgJLehB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sk8wsfTDGL/ogDhkbm1iQJOuc67o8PZbFMKKIZxFt28TZOz432SsB94G/74afK003WGhUeyEJkLTgwF8oqXUtOd4Ab8wyZyv5kuyjHysGyvdoaMIKIWgcyav31nWC6PF4npzv2DMJIjxZfNH6IgUc8vNimBkI0+cthXwyZwMe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMri3jMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2336BC19424;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=rR3gz3yzpBRkBDHXSaogJdTENZ1CLw1h0jHGgJLehB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uMri3jMCRqfuHCVaOSWbll6PTnM0TnPMc8C5vzQM6fRxFtJqOpoWHy6UTPZAPAUb+
	 6lJsHRQ7hcKLNwptFIw5YoE042O1OKnxh08s+JrKDRlpelBzsRbyWImmg2tXPjrVQQ
	 wfYjZ6ItFg8MEkyTEsN6ynsLjtrrT2YGIuxdvuD2iK5A2Gst9d1xRiribI7VsjktD/
	 m9xEHnnWbVq6b357/ogRElVLXHR9tz1/1Xi2d00IGoIx658dqchqSh5OWHiW0LsWjm
	 Wxha7qFSKPfqp7mzm1ZsFLKKnSvnkr3pbZTKqt7s+gV8eOdpokLkXNBzc7yihSzSAI
	 gA/8S9EuIrZNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFDD0E6F4;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:06 +0530
Subject: [PATCH v2 02/10] serdev: Add serdev device based driver match
 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-2-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3979;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=l5Ts3o61IXqTXA6cCJVPncMY06Qk0XS4grwShZ7YiiY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDy5aNQTrm4PBQrFGYoE/mpmzlHS14l3KcAg
 f67d/Vs8WOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9WM0B/9vOuD1CGvFWE0LFie5T37/3Dlph915pP3GTxIx3fy/Ux553oVeUV7W9wQX2Mpi83Hb/F+
 ny6kHH7fV0no6NuuQHmyjyVEGvbG+Qw6zG2FOmkzIBBzVezUph+MvIBNwyrs76QAwW2uAHGQiDY
 Xdy1FAov0YL439699RHC7LXcD6sg4AvYgXLrIf0yHknev1pnXNtNUHtoMvmHcvFOidBpYuJTF9u
 LGvizzdk6qCPZj8HpGXD+2UCVGIDRpsK1ei3Qni3oSx4yPHm2zPUFFRwA7SsHjTZEhE9hSI/EEs
 LXHONCdvpTB80Hzk786sXqWYmP7FXNcojvZDERXUlhPN0hhE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add support to match serdev devices with serdev drivers based on the serdev
ID table defined in serdev_device_driver::id_table.

The matching function, serdev_driver_match_device() uses the serdev device
name to match against the entries in serdev_device_driver::id_table.

If there is no serdev id_table for the driver, then serdev_device_match()
will fallback to ACPI and DT based matching.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c         | 23 ++++++++++++++++++++++-
 include/linux/mod_devicetable.h   |  7 +++++++
 include/linux/serdev.h            |  4 ++++
 scripts/mod/devicetable-offsets.c |  3 +++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b33e708cb245..2b5582cd5063 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -85,12 +85,33 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
+static int serdev_driver_match_device(struct device *dev, const struct device_driver *drv)
+{
+	const struct serdev_device_driver *serdev_drv = to_serdev_device_driver(drv);
+	struct serdev_device *serdev = to_serdev_device(dev);
+	const struct serdev_device_id *id;
+
+	if (!serdev_drv->id_table)
+		return 0;
+
+	for (id = serdev_drv->id_table; id->name[0]; id++) {
+		if (!strcmp(dev_name(dev), id->name)) {
+			serdev->id = id;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static int serdev_device_match(struct device *dev, const struct device_driver *drv)
 {
 	if (!is_serdev_device(dev))
 		return 0;
 
-	/* TODO: platform matching */
+	if (serdev_driver_match_device(dev, drv))
+		return 1;
+
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 6077972e8b45..70c54c4bedba 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -976,4 +976,11 @@ struct coreboot_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define SERDEV_NAME_SIZE 32
+
+struct serdev_device_id {
+	const char name[SERDEV_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ecde0ad3e248..aca92e0ee6e7 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -39,6 +39,7 @@ struct serdev_device_ops {
  * @ops:	Device operations.
  * @write_comp	Completion used by serdev_device_write() internally
  * @write_lock	Lock to serialize access when writing data
+ * @id:		serdev device ID entry
  */
 struct serdev_device {
 	struct device dev;
@@ -47,6 +48,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	const struct serdev_device_id *id;
 };
 
 #define to_serdev_device(d) container_of_const(d, struct serdev_device, dev)
@@ -55,11 +57,13 @@ struct serdev_device {
  * struct serdev_device_driver - serdev slave device driver
  * @driver:	serdev device drivers should initialize name field of this
  *		structure.
+ * @id_table:	serdev device ID table
  * @probe:	binds this driver to a serdev device.
  * @remove:	unbinds this driver from the serdev device.
  */
 struct serdev_device_driver {
 	struct device_driver driver;
+	const struct serdev_device_id *id_table;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
 };
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index d3d00e85edf7..c1bfa8eddc4d 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -280,5 +280,8 @@ int main(void)
 	DEVID(coreboot_device_id);
 	DEVID_FIELD(coreboot_device_id, tag);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	return 0;
 }

-- 
2.48.1



