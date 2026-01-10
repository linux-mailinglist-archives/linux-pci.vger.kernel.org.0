Return-Path: <linux-pci+bounces-44423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46188D0D243
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 08:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6965E30CE4EC
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AE34AAFC;
	Sat, 10 Jan 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQRW4IOH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F328347BBE;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=Afvyu5jxc/tCTCj46Beq+K8FAoKdJbKL9nUOMJs9fM0aG3X8Q8S/HLc6FlarKWC8ZLTMhJBlLHcmza/YFxVZS7DBbOh/EgirH9uSqoKJgRLa+HHYiIGFZfZsVjHmkEl5v/5BE74IZh9XTnRcHCVd/4+J5QoI9iBddwam6K9YN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=GSgBsfmXVqxUIAIe+iFNAZRTMls5onoQDPmqVp33rg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lS2S2DM5I9swhql3NSm8vJX1Z3ME6OwriuBPkoERJKTCxuwmoE3zXEcDZ46UmBtv8n+OIEj/SEfHfBG4j4/0dvnayLDm7AvU4PcrtPNPnFfBSK+goaZ+ldJZIhYolFSCVZ5SIybLdSHp0sZKqPsmPE0uVLX+EPQCWZTwiWYCK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQRW4IOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C122BC4AF17;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=GSgBsfmXVqxUIAIe+iFNAZRTMls5onoQDPmqVp33rg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vQRW4IOHlxJGj3ZOQSrJGNJ6KPkjQPyYWq2UnPSRfPD6lw/4ZS4O/z6eaov7Hlszg
	 uCR5igMXDsBjf42heQGPQ2Co7MlZFcNIQQ/4WjczxqLCx9taNgvhq8YAH5ZBaWGzUZ
	 ixMf78z+aKZ5DNpHArt6krPUygtRo2PKXFgtD3UQ8QIgrXdYB4woFXgb5bC0I7WMzM
	 mlUNIgsuDuwic75Ptmh9QZWGWg0ncj4p/2AnOhB+OgkAAFGMmxjE4z7hjwVC7S7NPh
	 0Jr5wHuEhhud2aU3lXdRxRMOE8MndMzfSXr5QayzbN76h0QQaXj5X2E9yuxv5ZNAUQ
	 M1YVjmQxot6LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED55D277D7;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:23 +0530
Subject: [PATCH v3 05/14] software node: Add software_node_device_uevent()
 API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-pci-m2-e-v3-5-4faee7d0d5ae@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=sTMShVrVQCSRXm+EW6kXtFuYXE2DwqSFk2YRZJf4cuQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpYfg9PRR1H3uAQByiIMRu/XB1zyrz9OoHeUCNf
 4L6FFChmYqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWH4PQAKCRBVnxHm/pHO
 9XbCCACQfptQOyQpTiKUhc8vhSqZyCZasHVZYWlCas1Fbl7JQeB7Y9xLVrM9p7ww2gN0f5ke6rU
 HMNHCbyhG8i1RrkaTOXyPIPwEOa+WC7sDA12rKWniG7VO5Rlxd314tcUt8FCuDlYaM6QEwUn10d
 9isvFw3GqlHEV4Bk9UkZ+YT/ZYhMfKKeteJFF9fk5nMs3qWmjnQA0uUtD4WL6fE99ewKOYda+ll
 7VbubsEx58qxgQgqv36e9bV1EQ6YqVRPxJdSQQt/V0dWC8VDZdrrCXNRRujzNtbMJqW9Sr9mYke
 xclfAySJhKwjECtCGvkF+aNwM/MXE+C3hzNX7BXrm/xtLTgq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add software_node_device_uevent() API to return the uevent variable for
swnode using the DT compatible property. The uevent will have the DT prefix
of "of:N*T*C" to match the DT's module device table.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/base/swnode.c    | 13 +++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4a3b367dea02..c33e09300e5f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -388,6 +388,19 @@ bool software_node_match_device(struct device *dev, const struct device_driver *
 }
 EXPORT_SYMBOL_GPL(software_node_match_device);
 
+int software_node_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const char *compatible;
+	int ret;
+
+	ret = device_property_read_string(dev, "compatible", &compatible);
+	if (ret)
+		return ret;
+
+	return add_uevent_var(env, "MODALIAS=of:N*T*C%s", compatible);
+}
+EXPORT_SYMBOL_GPL(software_node_device_uevent);
+
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 7fe75ab732f6..14f85fd66bfc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -599,6 +599,7 @@ int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
 
 bool software_node_match_device(struct device *dev, const struct device_driver *drv);
+int software_node_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,

-- 
2.48.1



