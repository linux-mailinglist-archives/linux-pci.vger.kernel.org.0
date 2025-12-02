Return-Path: <linux-pci+bounces-42493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BADCC9BE8B
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA1A04E2027
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9746256C87;
	Tue,  2 Dec 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ExYgVmXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCB23C4F3
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688463; cv=none; b=nMHZha1pKgx1xQTzaMv9jAsPDI1QOiTr7/qpmvJTuqT+1ArjZwfZDR/T3GFmm9OJ5Y7RxzMYlrTs5ZeBk8C590Vi1mqAykaaH8KZYE5VV+c2vSKEW5M/MmoKwbepuq+fKhGGJdvk11SfyhYxK0//9PcyDnfzla94VUgE7wifQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688463; c=relaxed/simple;
	bh=MXUcCTcnbsGFwcl/0MN4W8guWQzM02Lw80uLg/PlsM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+t9CO6rUDG04CYOtB0F94+czL0KoCQ+dQCGrgqPgXd9eyr1tNvi88CKEcVr5prvdEX4eGAgO9zXt6Fw3TO+GGLcnQ2rVIIb2gozK7xk9xe+3rWPBmUfRnrXASP9/qW6QiwiWx9yPEzhHACAqSM/hRhRZqFd7ZTEF0yM5QO54ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ExYgVmXN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so10067799a12.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688460; x=1765293260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqF5zLU2Kpz0CYDxUmwawHYJJ6sQTQQTvFFz6oIaU0k=;
        b=ExYgVmXNHfKGRgqduIjWEWowP/WONi4eBD2fSOwYwgZKY4wEBe4X4hFnWFwU3IzWOF
         3FWJUfLY5lJsI8GpLlM+y+YkfSMoQXQz+EKVqhLepE74D8Y96itr3BNKkT11SZwFi8mz
         bvEZIFaNrKZMwtMaHBsg+o3R7F3wh8sODaVUYP4DJ/YKUifc1LT+22HOk8/eNNm/FouB
         W7A+rpbm+sBvH2YHyp63+SJLlnZ20suWxSo5x8LE/953K3dAOadV3spQjfSIpPV9EmzI
         aje0m9oA2HwtV7Hbh79Din94dM3HyuNQP8MxoOC3LVtwcvFAGyyWQ+eHH62+tFG2xPSn
         b9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688460; x=1765293260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqF5zLU2Kpz0CYDxUmwawHYJJ6sQTQQTvFFz6oIaU0k=;
        b=cImwWmPu/7UAYBOYLkwYpf6aTVgj6HSEETxtLJsnMEhDkrqTRTdSIHAClyWsn69wsM
         zZBz9wXAShzhJ/1Mjt7zPxOnx8RVYeWXPjJ3UXPF93zUjIORdco/Eyu8ApqADatvljIx
         bEMSRhu8hpZ8SgUmZWRXm4DFiEUKWPgDi+acx2eMOqM86dLbYZPIyoKGpcEu/NNTKwHs
         qEpmrt/uHRDlBGiaIWJqSzXIexOLfUgK90SphfkCTRiRFU2qXzD0Qzsrrv/USPRlBVRC
         skKt8baQ6a2qMHmXjYcfXTnkOYbR2HQpDhC4hdWgLdCcMt1WSAS4bmiOL8//Uo7tzr/I
         d9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVdsnyjmiZ/4MwqKlvBmABtyYte3I6wmDF7+6ynCY59BAi95dRj+5hl4//21/S9Ll/rKHhLaLs1h7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTh6RLJCjhhnaPa+VYKzLQntR+kD8CYFMLEOJYsbChYbtYNZ32
	+FZOq9gdYHqMKxs3HJP44thidQuiwXOwB0dLV62qMxD3vQjhHjTp7rKyYXZqV/o6lRQ=
X-Gm-Gg: ASbGncu3OSuK1VOdmGD0NJYgwvIo1FPHQnrHs3RcI3qjpNgQQfNtWnWSTpXVH67mGrR
	Fl1t8bNojZuu/YwGQJROsPpH9Uz3fR7dkKZe3jUoKtEiC7XAgKGGMok1ugbOznjz3p7/dj6Y6zS
	9qZD9B70cRrxiT2GobJ2eLoNeAHRW5wN0Qmb6PpJMD9XkEqqOk8gemIa3SpKLZqL0ddwEsAI1qK
	HiZD2oKWem+tKE54/JvAVzAnqZoRwSF5dYA2Eoo7pewuCdlRfyKFVrQ6mTDma7ZANiCGVL+i7jM
	N+HnDma5n247BEqE4LpC4EzlbiPj3MML/ecOoANXAGnoRGcRkC06pOur+o/z8lGu3XjbFY1q4f4
	GDScPsO1INC64lCv7mO/O23FqLyPW7GTjSwqD0H8PEtw8klsStbnDDvOp7Kmu7j2jnSHKmh0f1E
	4MS0jSJVu4BVlU/M801MZwHIsOXtc0iJJLEor0n8quQdL3i8AkGhsAexpCyRZ9kvnoU9dYU4qdv
	Pc=
X-Google-Smtp-Source: AGHT+IFZN8zI6bMrJaJPZquj31yH4jkTcESEFnCkkb2JOpuRnFXZyz0Re8ooWFKTQbMsDNQJrCzCmQ==
X-Received: by 2002:a05:6402:4385:b0:643:18db:1d82 with SMTP id 4fb4d7f45d1cf-64555b9ab06mr39167759a12.11.1764688459956;
        Tue, 02 Dec 2025 07:14:19 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64751035af1sm16116527a12.16.2025.12.02.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:19 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/6] PCI/portdrv: Don't check for the driver's and device's bus
Date: Tue,  2 Dec 2025 16:13:51 +0100
Message-ID:  <09ca261912a37d2b253f43359a5dfeec42c016dc.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=MXUcCTcnbsGFwcl/0MN4W8guWQzM02Lw80uLg/PlsM8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwI2zhAmRNeVm9Cl4CAuScQG0XsxX+orTKawk 6XoE7RfEhuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8CNgAKCRCPgPtYfRL+ TlXRCAC0yUgyyqizHDH0LgONMU06VO/5nyXhhiDxv03z4xvbDI/xHZzueCxbenbDkBSKshvWx/z M6DiskqyRbu1r5a7ioTk5NF+WxZvlQe2o6RUUyX00kcR5HHz/UlFSVaLESn8I7QuG4A243rKlQc o0Stnbmv/JCgxxzxfXFD3v3m0Qb10MnCA33paE+UaPv5O+kDdYIaq+E7GkvgmguPu2d+7IDaLve nEBWe79IPKOWJiN+OYr6OHSYeNS543PIfvYIqwX23f3vmbY4y7mAs7hWW87Y+CgGQIQD67lFz1V /jqu9iSmPunZjw17A+7PRFmXT6W96QM7GgWwc06w6Zn9y/3P
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver core ensures that the match function is only called for
drivers and devices of the right bus. So drop the useless check.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pci/pci-driver.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..2b6a628fc7d0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1702,14 +1702,8 @@ EXPORT_SYMBOL(pci_bus_type);
 #ifdef CONFIG_PCIEPORTBUS
 static int pcie_port_bus_match(struct device *dev, const struct device_driver *drv)
 {
-	struct pcie_device *pciedev;
-	const struct pcie_port_service_driver *driver;
-
-	if (drv->bus != &pcie_port_bus_type || dev->bus != &pcie_port_bus_type)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
-	driver = to_service_driver(drv);
+	struct pcie_device *pciedev = to_pcie_device(dev);
+	const struct pcie_port_service_driver *driver = to_service_driver(drv);
 
 	if (driver->service != pciedev->service)
 		return 0;
-- 
2.47.3


