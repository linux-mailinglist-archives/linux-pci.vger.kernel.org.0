Return-Path: <linux-pci+bounces-40993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65450C52F8F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5264C501342
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5831342175;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCcCNGel"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681233D6E7;
	Wed, 12 Nov 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958731; cv=none; b=ObUYfZSTr6DPLceOwF761JtoCXzGS9akIZ8x2N7ncl7zObSGftWdWF3ew2gicrtVB4gZPid8B99t9fm8uef0GoSrQ/hvn9UncY8Ms+v5n1oXZZycsOVm9Myuq2Adr2ilmXVeyi2UZidmys5KgkWLKhmAI7sjmb5yOMRQY6cPLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958731; c=relaxed/simple;
	bh=novVq7mIcfdWOjqb22DZyGsxIxWmlqMMB5fYxdyzH+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMJx9LHWhG98KJRX2TsT6eWkFclKZG0Bb9f1WiDslgohmBEjXdMaEEfGzGNMOievAjMeGgzYB1wAaxTOFCZBxsOJecoWyHdcLJCUUS3xA1ZmktX//Qq4SbaRRRHaIADuWCgTyVdfQDGjHnxpGfCafIXc2jcoCopGmvelV+aAfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCcCNGel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9589C4CEF8;
	Wed, 12 Nov 2025 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958731;
	bh=novVq7mIcfdWOjqb22DZyGsxIxWmlqMMB5fYxdyzH+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uCcCNGel5JAONTbXSmFZv6s6lUS26zOUZ3JsOH2/MgdhJMXRv4N/23RDaC93ct6uv
	 nNgk1LWvMPFj+h0pu5JLgjTccyysBKhD6AuCv2I+mqEJ+xaLK6V2y4Zbp816vBJ1HE
	 GPll3jHNbz63klkJ6xVxkPdWB+C1NZPhDQudARm41tgkNk4GWmf323udVHMlh305b8
	 tuwvBfGl/fHZoIpAJcicf6IPF5g7YPbo1YYyW3bb2EzcfzlOb/yz/Ce3FzkGqTYY9P
	 NDGHjDOqejSsfQyUSxWObhFz+L55Cjl3SdAyP5Rhiow/vWPKq8nE1gL79BMEssSn2k
	 cDzpgmN694QBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA26CCFA1A;
	Wed, 12 Nov 2025 14:45:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 12 Nov 2025 20:15:13 +0530
Subject: [PATCH 1/9] serdev: Convert to_serdev_device() and
 to_serdev_controller() helpers to macros
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251112-pci-m2-e-v1-1-97413d6bf824@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=pMjdMDUJJFdzXcs8r8heXhJAvEfUn5voSIPUccUCX28=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFJ2GiS7ttFmSpXLyf6Ebs4G+J1tZeIesPjGyO
 Io4W/4qnFSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRSdhgAKCRBVnxHm/pHO
 9S3zCACcJTT8QNObEZKWOhlVOpP+8Sdq43NqiYJbUBYuIUI/938PeuVe+p/Eu9tWu4Jx4ld9WLq
 x7upQxEUF/78BXiJeB/5FQ9S0XNY1qRnZR2IndyMu0EquXXda9XQDoMxY6Xgeo3svQu9oDqZQ46
 YaqnVYA2mfopwwCVjTkh4JNy2FGCmSChULV8E3JwBHN5v0UGXSVXfrHodrLB7u/4ySWqn51vWAz
 wCF2daTzCAZTwT1Je0wMfLvgHK9msYEDJj7Kp/dqojqqcVsIMpkTzCBZHBzv5utYP7EsWD+E+l2
 00eA4GYX1ZWoyEYciBFQ6tATdVp8Ogfyl4maX1KkQroPRRTs
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
convert these helpers to macros so that the qualifier get preserved.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 34562eb99931d808e885ce5022b8aa4577566885..ab185cac556380dfa3cdf94b7af6ee168b677587 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -49,10 +49,7 @@ struct serdev_device {
 	struct mutex write_lock;
 };
 
-static inline struct serdev_device *to_serdev_device(struct device *d)
-{
-	return container_of(d, struct serdev_device, dev);
-}
+#define to_serdev_device(d) container_of(d, struct serdev_device, dev)
 
 /**
  * struct serdev_device_driver - serdev slave device driver
@@ -67,10 +64,7 @@ struct serdev_device_driver {
 	void	(*remove)(struct serdev_device *);
 };
 
-static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-{
-	return container_of(d, struct serdev_device_driver, driver);
-}
+#define to_serdev_device_driver(d) container_of(d, struct serdev_device_driver, driver)
 
 enum serdev_parity {
 	SERDEV_PARITY_NONE,

-- 
2.48.1



