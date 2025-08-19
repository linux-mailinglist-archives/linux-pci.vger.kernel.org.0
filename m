Return-Path: <linux-pci+bounces-34250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1821CB2BA5E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057231BA7E6C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE129D27A;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyLYw/DZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515928489D;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587700; cv=none; b=BmcqA4Ut218YcxxN086Z1FZ6/PYLviZX0VTLuSeRVnW+zhmJvJkDJ7RcLV+ZCrBcXBHqZl+fT/waWA9AINruUikL7NAyOUQmBW6ODr6k7nSrKnBIB5KIAg/5lzupDQmjSpRz4+2iZtZqFG5m55qaxURcmlMHj54c9p4HLbx/F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587700; c=relaxed/simple;
	bh=9VnS628XWoWDku/mnJavyc49OZQtgUxoFbZsbhcS1iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdI54hg9J0wKqzzDrgsUbOfggIwZdyrKpa0Xp5MOWM/J6tPPLxefd1bZd0GwdxOVU+03qapSJ/nnYguBFNyHo4MZWo2CEu1xczKXU5BYH4tbJjTE2XUYSVm238dvE1CFv1wE4vmfqf7Jbo5iKcv3k/azmnQ1GeOqucp9VP1z1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyLYw/DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F09BEC19424;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587700;
	bh=9VnS628XWoWDku/mnJavyc49OZQtgUxoFbZsbhcS1iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GyLYw/DZxjxIkWAW+wKbSFqCLGOoSWmBtdz9ipfInPZzS/Hd622TLtb3x8bgC17Qn
	 dYEQKu8Nxg3D1rrAyYWQjq6lsSJeXXkGconZlFO3zbgb9UNTLhTb0Vnpoa2oO4fJKO
	 b9iJe57NumqDT8rWJ8SkxyY/tWfGrPhsgZIYYiiTHJTkcO2VKEqKpjUdpTozq9sfKx
	 n+LdEFUKMFhAPIWRMd+g3VTRKe1DtBj3WVDmqGSym/t505vyC2l/MEA4ZXcJBIyfxD
	 BFY1AsH2GsKjb/ytya/DJJ6PYcykxTVkqfa7BP+HZs52+i8hURfUGZcGv+7RPyrMCw
	 w4DSbu4PtXu/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20AFCA0EED;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 Aug 2025 12:44:53 +0530
Subject: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lJHwEOfLqtgwNWXWNyx+rOwSYNWAA15NNEAf91PmREE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBopCRwaIMwBz8tCj4PzD3876H5Bz2hSyktqZcTT
 IfMJNmljQWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKQkcAAKCRBVnxHm/pHO
 9XL3B/9vn8nh6ovIeTV39DChlRj/smMt2t3vYSwSv23YtOBzrhXKOHIKcIUaLOzwPEn11ePfjgG
 r788CJqL9Jw+sSbutI6itc2N859DqFT+RPUqliN2Ow6KBwRugmPoujFXrhv2MTpY6aE1Dd8oVa3
 BBTDCGHjzjRwts2w9yJ4LdI2X/y+7LkgjwMNBckqo7VvBRoG5voujF+htZRIuxLtt6G96BhQ9Xp
 dbFlf/iUa3rqps5klEP9mSdzBMv/0fDjjCp3hG90cJefsSOw1bfkuXlwbL3rJ8bLe38cetXvPHW
 658yQDDTdMwKK99rGyWpZZBIghuVReZyVguWi85+uBBVRKt7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bus:Device:Function (BDF) numbers are used to uniquely identify a
device/function on a PCI bus. Hence, add an API to get the BDF from the
devicetree node of a device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/of.c       | 21 +++++++++++++++++++++
 include/linux/of_pci.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f119845637e163d9051437c89662762f8..5e584d25434291430145e510b1d49a371dce9165 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -183,6 +183,27 @@ int of_pci_get_devfn(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_pci_get_devfn);
 
+/**
+ * of_pci_get_bdf() - Get Bus:Device:Function (BDF) numbers for a device node
+ * @np: device node
+ *
+ * Parses a standard 5-cell PCI resource and returns an 16-bit value that
+ * corresponds to the BDF of the node. On error, a negative error code is
+ * returned.
+ */
+int of_pci_get_bdf(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_bdf);
+
 /**
  * of_pci_parse_bus_range() - parse the bus-range property of a PCI device
  * @node: device node
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29658c0ee71ff10122760214d04ee2bab01709fd..b36ac10653c82f4efdbb57cea56d2ec9d581212f 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -12,6 +12,7 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+int of_pci_get_bdf(struct device_node *np);
 void of_pci_check_probe_only(void);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
@@ -25,6 +26,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
+static inline int of_pci_get_bdf(struct device_node *np)
+{
+	return -EINVAL;
+}
+
 static inline void of_pci_check_probe_only(void) { }
 #endif
 

-- 
2.45.2



