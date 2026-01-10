Return-Path: <linux-pci+bounces-44424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A4D0D11C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9F38302083F
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20934B198;
	Sat, 10 Jan 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM76aYIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E57347FC7;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=WbjjYBZrnaM+/PuDYRV/Nst2rwFRy6UEpFRcRAk895wrolEjZ6DIC4t3BQTa44+ZY2p9cBygu8SCHO9gBJab28gDvNFV4JkV2GRDx1GHn8Bt5vBn70bA5gKlnn1JpofSTOGP3DmQmOp7eiYPc/R6BzAh/3jdVJu+KI4BAn1Xptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=cfa1aF1gW0vt3JuTTI+jaUP6mzCPbxH1qoIF8G4DDy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFjNAqq6HNARP44AH+lR8iwM5ay/bYvzA0MmlSp/IyVTRWM5N27S6e/tLYFdbtNgwEGMvX6KrQ1Rc1U7IQZ1a5S1SPBou91rZqv3fz5ZfP27Viy9LTWHaZjmnHJMps8vw8Xr8QptF9W5qRlsCmzd82VO4XA7Zt3ajcq2A3MwOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM76aYIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC21BC2BCB0;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=cfa1aF1gW0vt3JuTTI+jaUP6mzCPbxH1qoIF8G4DDy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AM76aYIWs+gRDqQDIn1PHvbqXNy2/kRvoXZ/0HJaE1IrYXLNZD3+5ovrmdNasL1BQ
	 7gNGmBZEiDLTreu8rPjcpIZPW/y3aeoGCPThZe8NO/RcLsWfgqeALiv6rLpf6A8MfD
	 ee5WHDbRabXBkfZYNngnVWY4J5wpzIgCoMVTQFAGh7M4v4foIyw1K60d1wNwDcwODn
	 DTI1bYzzKLAynvTxW2nkwnLPtfNigAWTi0Rrp/Sp6lLpHGiV2SDncNs2GaH2/cjI4O
	 LJMjUFDBO3ih34B4PwPlaWC3EVvPHA9pLtChp2tBFzBtMOR9H94PkT1oLEGaqmQF2q
	 6GbPlVzblqqIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A6AD277D6;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:24 +0530
Subject: [PATCH v3 06/14] software node: Add
 software_node_device_modalias() API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-6-4faee7d0d5ae@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=hP/S8Z4ct7CcIRG39KVjpY1137sEbkCLhENN+ADZYvc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9uwIlLNwsjiWJEiqmMui2S6mjeDAmocoYD
 B3oBp/UHmOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9ca0B/9SLAMwWT9XvwylsIVN2bRjxI8FjRSwSkLnEt/XBOa61mhgkOFI/IrWMtdGPHN3qdU6Uhm
 FyudWgJPzcddwKwp3xY5Nf0NTofUzSrcI13Orctcjxc20nKl9mguMlbNmn3Q6kVicCWRFv6ujzY
 qWvrG1yNtQxEuY4/utH4HWxT2Ex/n1vQ6yYlLmWLPgWTgMoEVju6T4Mckan2+45Wlth/ZbnwMHg
 DyGfsZhr4dHiuKxmfEqtoy2KGbu+GL396UG2zue95hQuTFv1Mz56313B+GZxCeK5U3LAylTQTkI
 TqfqNO5gRmqg4kvrK5cEFRJqaM2dQIESVnyvUOaEEvKdqkNz
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add software_node_device_modalias() API to return the MODALIAS string for
swnode based on the swnode's compatible property.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/base/swnode.c    | 13 +++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index c33e09300e5f..a9fa19a27dc6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -401,6 +401,19 @@ int software_node_device_uevent(const struct device *dev, struct kobj_uevent_env
 }
 EXPORT_SYMBOL_GPL(software_node_device_uevent);
 
+ssize_t software_node_device_modalias(struct device *dev, char *str, ssize_t len)
+{
+	const char *compatible;
+	int ret;
+
+	ret = device_property_read_string(dev, "compatible", &compatible);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(str, "%s\n", compatible);
+}
+EXPORT_SYMBOL_GPL(software_node_device_modalias);
+
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 14f85fd66bfc..94ea02ae1675 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -600,6 +600,7 @@ void software_node_unregister(const struct software_node *node);
 
 bool software_node_match_device(struct device *dev, const struct device_driver *drv);
 int software_node_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
+ssize_t software_node_device_modalias(struct device *dev, char *str, ssize_t len);
 
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,

-- 
2.48.1



