Return-Path: <linux-pci+bounces-44419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD79D0D170
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 07:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526B23066291
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4B347FF4;
	Sat, 10 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPK5FJyN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5507340274;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768028226; cv=none; b=rdRKHLq4pr9/Dim+oESFlC+VuXE9IChiXinBXPLJPbpigqF19fOpWO8shCcajYNQI/5lgmlsUvw0eHnJm+HJxEg6oiE1owyinYWqrR9cXzWTvAZqD8C7Rv++SOocWNXXtenS8xoHnwCp9v48/WUkcNZjwvlAJXpF9KNvpN5z0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768028226; c=relaxed/simple;
	bh=GlJ71tujJcltgFnDfKrfK0RHu+muqUMEqgwXCraygEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E53USvAkhyoJXiwwH8pU/iiOpB0GxDXlX0SwZFFSZaFwM3DB9pkAMNFeYCvCf7oNE8Y+W4Lt0dY9erUGQFoNGNa1xUJeEjVfL9Kep7GRClUp9MOHkB5MbiLkT+iqlGD7gFFgD85xiPVvXd2kQTBZi3OoG6dtpu/kYPEhzUcV3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPK5FJyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76E14C116D0;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768028225;
	bh=GlJ71tujJcltgFnDfKrfK0RHu+muqUMEqgwXCraygEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qPK5FJyNyNLOdyFBO1fPmuCs1oOgPLjMQFYe8nXlyuGXL53XShBPW+PahnOSiSMuv
	 qrtOM72eHZPbp8B8u0/5p7UvfFzk11YlV3ZChP9QZyRHqMyO/Il6SYaqei19ylqf9R
	 ZxkkDSbG76bf15nP7ChIFPhRsdBC95jUjDzGE/iixUAtQp11UW0JZcePIzOpjhDl2E
	 YH9uuxpFNldJsn6J+X3wuuCV1t7iaQwB9CxBQ6f9D9LUKXAUncGiOlp7HAC5Up6kAr
	 FwJOcU77FXUbIYVHiN/tNp4afgHIvnBfeskThoeozIV3napWa6tX+Y950AJZx6oHLo
	 /SwrgIOuzdcrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BCD277CB;
	Sat, 10 Jan 2026 06:57:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Sat, 10 Jan 2026 12:26:19 +0530
Subject: [PATCH v3 01/14] serdev: Convert to_serdev_*() helpers to macros
 and use container_of_const()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260110-pci-m2-e-v3-1-4faee7d0d5ae@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=07vK9ciXXRPSn3N/nNhnkZAEN4PO5YKuZEczKGyjzQ4=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYshM/GEjYzNRJORqXULiQXedtd3npnI4eaX526fXqrgKb
 Ej/WVzfyWjMwsDIxSArpsiSvtRZq9Hj9I0lEerTYQaxMoFMYeDiFICJiG9m/2fC+zD5btbTF48C
 Gd1ZCqdmB4jYNhm8fJwgqDhjxYeqwr28Gyy3aO8KvR54Opv59yLxmPLWqi8b93UIGuWluTFdcV+
 c5dljYuG4NNxQ+1OoSH+68jetqKZdgvZhCaXMGYlCITHHDR+5V5fsbbztvdtBcHd5t8rLaYHSG5
 bbO/NpPE58sWfJo0LRxub2xkt/f67/t7NXokjpjZHk9MMxl9vvHOfcH/1xPt+R92/fz7oi3V33a
 T9bmJ+5AwfrYslFLrlvBb7qc0jq2fLOWXqxVelRjJm8+6S+vTu3szAsqeKfNWWKcuD/xb+dDZ4y
 2i9+VVIiJ9y5Ufz/kVU7bed89fy5oGVloPsGL4MkVdeJAA==
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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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



