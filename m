Return-Path: <linux-pci+bounces-42496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A247C9BE94
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D44FD34847B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED8255248;
	Tue,  2 Dec 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y/0d0f+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52554774
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688468; cv=none; b=T/bZaX5p/DhplMkUbukj38NTDga8pMB/g/6RGNj3j/0LUUI22TrYxUfkm0exUEBTRfXBYeOCnL8/t47sZWQXf6RpxUFEZAAR7CI6ArgxtwyU1vxYC6OfKZnkFS+fj34sVOFBSEwNcgikBjkJ5rKPL+GVjlx/Hp4ufKGYAM3h/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688468; c=relaxed/simple;
	bh=DZYyOpRJef/nN1aVe5pP6xd9FqhdAHwhTH0OuaeAOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfqAjYO//tet67akqxkLx8RNfBC1VW7RpQj6/ir2vYZTFBKv4OqcgPfyhJrXnXDEzrBo77+lyT493m5ywgsV5j46OGnYjLu7tTVSObeLgA++cqu8PiMmV70KHwGWRM61UNkVh5txDZg5sAfQJBmWP4LgQIT9xhrwCDqHZD1GrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y/0d0f+T; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73161849e1so1402025266b.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688465; x=1765293265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAa6IMAXkSEmb8Y1z/EsbTUOota9V+mO129gBZNJl+o=;
        b=Y/0d0f+TfqVi2MuzN+O9O2oe/OR/EqVqeD9CuofXc++PIb9JM2Gd5yvQzwjm1KVVZ7
         xwvoiYbAgbsWYQdzg3kATudiLavsFQ+U3vzFEeYB/qQNP+qxWzMqcjAGKTpWNAzCKTBK
         foNzhcRtC6mek2wnyAb3Rsf/hDKGQRSCAGvdex24qYDn+haxhEGxsakVA/afX1GOJ4Dx
         uUCsm8JoyI0SLt6r/bUc+1tllB/KKt4JrjHnBsc37RUuekHuyqRmPnaC8XLlTxRP6/lK
         5dZSrJXxp6YxuQWOUUihx+ZAaO9UBihfgLKQMhjLRV0h58lizUkkZBJ22vlYmzDfHlh3
         f+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688465; x=1765293265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAa6IMAXkSEmb8Y1z/EsbTUOota9V+mO129gBZNJl+o=;
        b=qAZJfMd+aHFRYuHFKkpC+N3LRJjxb6IOFWt4gaYsQGe/r2cdPpa+yVa5rMGiEqBfwL
         RF8NtEjAgQSEJboyZlmSbPN0kf02PZdFTOsmPUEk50w9jZ8FO+6dJdbSkK+Hwh8bNVy+
         4E9Y02u1usotjBV6iB0DQ3nLtwruz49Qun60CsHqpEwwHgR4q62BhlgoswCgzLKoPfzF
         BPTwrq7skivPKB7CaIhxZxFDjUpyveRed+at+XFLFuaqtqONJHqUQvRaRfFgvp6MjYmd
         jZF76bOFKXke6GEk8jFp20qnvZRBuOryla4riWISJOTIKxJBePMQTl/mUhbf9Wob2gip
         vQkA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4M7B9+B8uEuPIPfKRM03KLL0MFH4a0Z1/05oexxMbCidFE4BO3B7K/TU9SI0Cn2489z8NXx964g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3s+agv8w4bgowa8oB5JgSlti8Kl59uzuNQ0NJFawdEm+PDCK+
	+Q0rFH/4ukwtWnVA4HlCQsRf7sgVT9hLU9tJO0c8zN7+iV4kArvSSaHw58K+5dW6C9A=
X-Gm-Gg: ASbGnctdBxM4srUhRkZbcNiPzORJ1+ZHAcbvCMbzVFOITO+OSsA3thOIhfRiVvOzJdn
	aCJn/ewVEbsXdaqQ4xUcATUo3A+1/20/jubZNKlWRnuw2LuzXpYzsy1SpkfxQyJmCEow1u81A9V
	LmrzgeTUtf51d5Ggf5sHK1SdBoSLiO5wfKVCmvEwp8Ns9LrqWsVX5fJ9+9L4rSswk4TzVxYIXxt
	rmj7u0cfQLoO0TLYGjAV2DrGdEXibXiwsQT2U5xaXSSurtEU7/te/K8CwKGJw5dpdKcy3FUdikR
	xHmq2jgvP8dkQQnPi7sn4A4j5+kZi3EjEEtsTxQ+0R+VFnPDwWwPeIRBOC/ZtcMIm8JUZ/pEwq1
	bXGPdQsfhpQTnYGZwCuIyIHWeHoWzeSe/O/ofwswicz2umrZYfdMLPHvjiWzF1GYPqHFQoKcu2j
	O4GZlClSvZFb0v5suwzHsGOyQHIUVhzt/yFM7g4R+EKPUTg8TXOv2Pf3r57b1372wp7ikNgdkRH
	Zc=
X-Google-Smtp-Source: AGHT+IFZPQSTMbWrnuWDEncrJ1Im0ly8XIoo/2OKgAQEHQ6b/fpLUyp5sQy/+khC2W61b/iV7uP6lA==
X-Received: by 2002:a17:906:eec1:b0:b72:70e7:5b62 with SMTP id a640c23a62f3a-b7671549c62mr4489708466b.23.1764688464717;
        Tue, 02 Dec 2025 07:14:24 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b79cbc1f1d5sm61546166b.63.2025.12.02.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:24 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/6] PCI/portdrv: Use bus-type functions
Date: Tue,  2 Dec 2025 16:13:54 +0100
Message-ID:  <83d1edc7d619423331fa6802f0e7da3919a308a9.1764688034.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=DZYyOpRJef/nN1aVe5pP6xd9FqhdAHwhTH0OuaeAOa8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwI+xlQl39Mj3ETPW+do7ZBpBIov+rpp7Vufv 1zt01nyMj+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8CPgAKCRCPgPtYfRL+ TsSiB/sGlTn1NKa5QfS78b0Ve+RH6UvnEM14qHoNRt0xwO/3uvLLZw1xhzzFjlv3dmLKHm7NMyU tLScCkyq/iS7C3zJIn7V95Lzy5E20Os7Mn+RBmCUpgDxHillOekAn/YN3C6tku7NLQYolzi2oz+ Sv1f2z228ie33qyZMAH+fm1WlHczKVcSPiz2XRz18f4U69zhzgA/RcZVULgO255pr2ohv6nkni7 DezuFBXuA2d/waMeV1+h9tRrN8uVQNhHDL3LI3q1nvR7FT9LP25l0hr4l0pZZBOWJrbfNYPdkfq EGuZUgT2N469QklBR1peSUP78652TAbZlDJ2gvewef34H9Yf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of assigning the probe function for each driver individually,
use .probe and .remove from the pci_express bus. Rename the functions
for consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pci/pcie/portdrv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index f164fbd0884c..87149075bc5a 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -524,14 +524,14 @@ static int pcie_port_bus_match(struct device *dev, const struct device_driver *d
 }
 
 /**
- * pcie_port_probe_service - probe driver for given PCI Express port service
+ * pcie_port_bus_probe - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
  *
  * If PCI Express port service driver is registered with
  * pcie_port_service_register(), this function will be called by the driver core
  * whenever match is found between the driver and a port service device.
  */
-static int pcie_port_probe_service(struct device *dev)
+static int pcie_port_bus_probe(struct device *dev)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -551,7 +551,7 @@ static int pcie_port_probe_service(struct device *dev)
 }
 
 /**
- * pcie_port_remove_service - detach driver from given PCI Express port service
+ * pcie_port_bus_remove - detach driver from given PCI Express port service
  * @dev: PCI Express port service device to handle
  *
  * If PCI Express port service driver is registered with
@@ -559,7 +559,7 @@ static int pcie_port_probe_service(struct device *dev)
  * when device_unregister() is called for the port service device associated
  * with the driver.
  */
-static int pcie_port_remove_service(struct device *dev)
+static void pcie_port_bus_remove(struct device *dev)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -570,12 +570,13 @@ static int pcie_port_remove_service(struct device *dev)
 		driver->remove(pciedev);
 
 	put_device(dev);
-	return 0;
 }
 
 const struct bus_type pcie_port_bus_type = {
 	.name = "pci_express",
 	.match = pcie_port_bus_match,
+	.probe = pcie_port_bus_probe,
+	.remove = pcie_port_bus_remove,
 };
 
 /**
@@ -589,8 +590,6 @@ int pcie_port_service_register(struct pcie_port_service_driver *new)
 
 	new->driver.name = new->name;
 	new->driver.bus = &pcie_port_bus_type;
-	new->driver.probe = pcie_port_probe_service;
-	new->driver.remove = pcie_port_remove_service;
 
 	return driver_register(&new->driver);
 }
-- 
2.47.3


