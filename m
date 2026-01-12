Return-Path: <linux-pci+bounces-44515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAFD13FA0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CE3430039D8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D783659F8;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaUH/J9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A6306B12;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=F8hVcokTJEAUK/f6jIHpq/Arsz6SEON0car4aAZ1N88GOsieVUGsyOcWoDeTMkBvGekAd3uIwqwYVOpj/YCAKzZ6cIF/uzBb4Rs7IuzWs4fMmJY1FUfBI3aL6PHsemLCCnhAnJb0gcQCbpV/LwNSeYojAON+6jY9exX+mHqAP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=GlJ71tujJcltgFnDfKrfK0RHu+muqUMEqgwXCraygEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPe0jGXBjEqXepV8yV59nLelKQPqUA97ya2SQ+hSXPF1Q1UvX03M3LFvd51SrZzII4C/pglEmjV7fJkQTBTIdIHTdQcXYRPOHh+GMmdH8HWe2ZbHH7HHjAs1T/7Wv2uXk5pSXv1O2YlqstUajXP/VVPjRTKN2nOOnmy7JZw/rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaUH/J9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07FE9C16AAE;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=GlJ71tujJcltgFnDfKrfK0RHu+muqUMEqgwXCraygEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PaUH/J9RPZmbIvHp2Fn+kT5AYtWmn23AwVRzXo0vhaxyzQifOAi0+znz4sLkMxQBa
	 J6Pwj+gwDTJM5TxkiOEdSus301MZUeGZrvvS/joQgoGBPtPGmOBxTrGyspe+UCXmKf
	 yXmFHxTXh1dRZWSfBcSvHeDvRkaewgB1o9hWxuI7SJTFfMkj2Mv87QBVPAKgosUJGR
	 wVt2XxGpd/twxXNR51uvuqK9/kUYRwVlocXpd7IAtq1/t0BkJI0K/GdzBf8l5b0oRE
	 fBLp1A9+rjuVWxEsbB7mi3G8yXVMLDXO3ah01prMR0DpYlJA1BTFQZq9UR7XwBFesV
	 nirHgWt74kmgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3306D25041;
	Mon, 12 Jan 2026 16:28:32 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:00 +0530
Subject: [PATCH v4 1/9] serdev: Convert to_serdev_*() helpers to macros and
 use container_of_const()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-pci-m2-e-v4-1-eff84d2c6d26@oss.qualcomm.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtLU1+T/SQ8muTj88PMLYAc1JIDUMVESqYm
 PJvutm3t5WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9ZvgCACOa5aYDJDQeVpU6yq+fCGtKV9Xz1BGEatNRuENRILo7sSUAPtGbyGfxzQ/0vcy4Gb+3tW
 jcnVrjZLjEZ+dCXlNXAFyy6VwIckMC8ZO8GOlS67JL5iOmWHfQ/aFzmBY9Uz79eiPwI6BCQTliK
 1hhKWLBCLzlvHxyooeqQs1gksE36iewETbO1uczvYdH5m2JtG9K6jY89FC7YE756kTcdmskU6B4
 CKcv2Zojofh08iFJ1rz0zid+PoQTNbqCffd6F7xPEkCRAl31mzXhHRzRKNItT5fgOdkhPKgCVC7
 YRafq06sSCerUESzjyX7I3cqm12BXILp3NiBAcA8WQ3w/Pxo
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



