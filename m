Return-Path: <linux-pci+bounces-42049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE44C857B4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141354EA73B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C1326D48;
	Tue, 25 Nov 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEGxOm9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F032692D;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081911; cv=none; b=RnXyr+qflnVGOA3mFV7QxaaRtfC2F7PpWrLbyqKgZreG0qiCNvtWkzrdzEw7ShQLgaN0763He3zgyghqbuvVNbChWVSMwwpn8kpKEBRwxvp8NUkpXFsSoYky9ggp4rXGImaggWCVIrdLRSHeiDj6fhSb9sEG7oMOESHuRIAVhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081911; c=relaxed/simple;
	bh=XBDSzMYIFkCw09WI3jBNA9MTUk89wi4ZpjMVAgW3SWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvBW6IZxnQSyqTKYGOq9C+Xucx02OtGzLkMw2YGKeXmYQvysRSWu8Tlg06YwSQnGNU2iYT27i+7pXJOHzdzlz7l1QDGKwmkf9QzxAxJwcoGVi8adeCt0lX7QXMyjdi/SYtNd/RqobOpQywadlPewfm68KoE1aIJ2S//uiDTyjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEGxOm9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09090C116C6;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=XBDSzMYIFkCw09WI3jBNA9MTUk89wi4ZpjMVAgW3SWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YEGxOm9cg7W9Mou29C0GZ3AC7mXlMogFvHnZ4TfkrH9V8P7eTv9Zw3AXXwKiDEc6B
	 giSUc5nG7p9typxHoZ+iFFTE9+MygmewJqfOtCcLN98dNv84m+IgJOKEFv4HFFZHWe
	 nJd8FRnRxKQrYpy9Vm280kffEv1Ci9bB+YNRgBSNg20QpyN7G15tMQO4KfGvF/UwEX
	 A59DZnoX27mfbr26dlI/LzdAcZeDZzr4nkrh3SllLHYbH4FEqNyHVkVXrl2w0WlFV3
	 h9Fcgv3yUw09L8qaSVW+4xAfajIkhWwg2UVTu9u3GRDO9S7FDEj8MUC9Bp+B+SR+fy
	 XzL6QnxP/Nvcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF03D0E6F1;
	Tue, 25 Nov 2025 14:45:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:05 +0530
Subject: [PATCH v2 01/10] serdev: Convert to_serdev_*() helpers to macros
 and use container_of_const()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=gp2plOukmLsK8Wz0sYhXr+7v4Z6uCCCmxZxVG517B/M=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDyeFLCzWDU7DbBpggspqjnYeo3HN+5r50pB
 iGA2Xp8WLeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9RlvB/9CbifjQ3jZwZtMwC+hnrlvILHtu+kiJsXQ3WfhvHxz5q0Fcm0nkfdBBgSUwx/bFhMqidX
 /GyfwPv1MHx3GEX3AH41y1whdyQO02CzHOwLE+yu7n7gGnz5009PCzMinAD06jW9aZrHWzlx4Qa
 Voe1JgB5+FRVKs8ppyCu9GEiOdQ2mrnnd2PoWslfpd5KX7DbJvqkAFG2CdPXmWe2f/yJKQZ10S4
 KTR3UoQ1qHi3PQQHP35gajlhY+DXW6Ilc4F3HXG5ohmDGa3i8lJ0qsNb//RwdfdGbkGCgYDJg0Z
 IDLx/gjMjBJuZlTxmgbt6Ot3q3BBG4UnBbmWvKq5nbkoP8/Z
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If these helpers receive the 'const struct device' pointer, then the const
qualifier will get dropped, leading to below warning:

warning: passing argument 1 of ‘to_serdev_device_driver’ discards 'const'
qualifier from pointer target type [-Wdiscarded-qualifiers]

This is not an issue as of now, but with the future commits adding serdev
device based driver matching, this warning will get triggered. Hence,
convert these helpers to macros so that the qualifier get preserved and
also use container_of_const() as container_of() is deprecated.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 34562eb99931..ecde0ad3e248 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -49,10 +49,7 @@ struct serdev_device {
 	struct mutex write_lock;
 };
 
-static inline struct serdev_device *to_serdev_device(struct device *d)
-{
-	return container_of(d, struct serdev_device, dev);
-}
+#define to_serdev_device(d) container_of_const(d, struct serdev_device, dev)
 
 /**
  * struct serdev_device_driver - serdev slave device driver
@@ -67,10 +64,7 @@ struct serdev_device_driver {
 	void	(*remove)(struct serdev_device *);
 };
 
-static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-{
-	return container_of(d, struct serdev_device_driver, driver);
-}
+#define to_serdev_device_driver(d) container_of_const(d, struct serdev_device_driver, driver)
 
 enum serdev_parity {
 	SERDEV_PARITY_NONE,
@@ -111,10 +105,7 @@ struct serdev_controller {
 	const struct serdev_controller_ops *ops;
 };
 
-static inline struct serdev_controller *to_serdev_controller(struct device *d)
-{
-	return container_of(d, struct serdev_controller, dev);
-}
+#define to_serdev_controller(d) container_of_const(d, struct serdev_controller, dev)
 
 static inline void *serdev_device_get_drvdata(const struct serdev_device *serdev)
 {

-- 
2.48.1



