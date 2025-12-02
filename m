Return-Path: <linux-pci+bounces-42492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B6C9BE88
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ECB3A6869
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5D255F2D;
	Tue,  2 Dec 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YCBs84Vr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD248245005
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688461; cv=none; b=R/hXusqfJZ+caXpXzs3ndni1FXnwcQ4SULyEy9E8N2S5UcFVhASQIDGoPh5x2h24kgH63kb3q1Lh3Lzfk70ovT/vmE27eBXbvYwAc3qnpHvN0KI4A4NPTkMoUNeRO0e6HAMZ+6mjQ0kR2pI8vsdyXMAVdJPBhwDH9htv6rdF+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688461; c=relaxed/simple;
	bh=egM5mTVCzCNzWFMCIhGAjywkHCVVLgrob3l7cgVET70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0PceDTyr9R0LObsnIwSPSuYk6JE+Hzub3eflF+KyOpqPbncA4bEuorA7lxVKOThp2UN7qj+ObHEyA+rIwhb1WD+8ZVI1HEB457OFx3KYo3jP8zZy6WUqzk1244B5c1qfg/54eKrDyKAucXnsNgihnSIo+bUZqKQtwUrFpnCX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YCBs84Vr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7697e8b01aso1069726466b.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688458; x=1765293258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQYc1abThlW89NXPQCjtMnrUlkY3tMSchtnxmpdPp10=;
        b=YCBs84Vra2i8PJ2/9b9P94OB5mKDe44Bja6cXPgEGaw+0gZH1qEm061p/LHGlEZNn2
         WrPGh0OZ97v1qXaFJgVAg+BZCEudswV0u0e31bg/FfT2/5KBLazpcdVBrC3qsd8FHpqW
         GsN2C52i6Ls6UY0Z9tnGgQmWxiI7oceU22JtyoRfGjx4KuhFdHE70mxfmptzoddJCpyE
         /SgNytocCIYhy1NFZm+GgcQq9o6fJ0jNNLR4deuwnNeHPQ2j+S/FHa+5CZUIzgZnQECD
         j+CL6mk5oMIxSKTM9nTupqXOTrGHueZTaJLU0fsHEzhVd9N+ftipf9X3b0rxTTvF+erD
         30xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688458; x=1765293258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQYc1abThlW89NXPQCjtMnrUlkY3tMSchtnxmpdPp10=;
        b=Y3WNa45dCPoo0z952FK1V/ztF9URydEbU+px8BH2T6o/dnMRBPq7aYCjz5d7wc6uoF
         Cnu+7jYpjs0N6NtdYVjBJODF6sFOem0wsCod7WVrMGEa6GwEPRDWTu42swjyyVLPeSd9
         TcYH69L4rtY2616QL9WTuphuvmTpewjqgNj+vS55MsA4JUgvUi/rjNyd46yRy9PLjl03
         d1Zk8oiwqg4givFdS8T2ZyIHU+ZQJbF8x9Y1ylzLV+Xt6jUP/SLPtFJbR7VfZnfMKXtJ
         FuYfus0sDH8xbDStAEiZIoAnbO5OC1a7rsJAvFzpr4rLUGDC+4uL6WjHaLb20G+SCbD3
         2v3A==
X-Forwarded-Encrypted: i=1; AJvYcCX7didD7D+mgDsRqeQv3AiR6BsNFwwY3LzK8S8gh+shU+t8LW1wabug09Dr4JJ0ABf4KZDyBI21Jhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2XbAgbnHALGgCjhezaZ5enwzFQeqtRK3PS4iBc8ul+wssqwL
	mz+lQAJbrf+7QOqnKZ0lgS0L4wWFNGxT8rC7lOGZpMg3khQwq+dYMnvwRqM5kfH3DDI=
X-Gm-Gg: ASbGnctye2x5kQmu8d4LBBQ/rjxRVhqr7bEhDl/BK9/lf4x0S9B6p5APiqA9vj9ohC2
	KHxt23vbrzNPz/drk3vLASMJ7cSUahd9RR6snxiQiKOBwNUuvCuqHDWt602r1PjGcEmqRZVIxYG
	3aT2hKYagoGadUEVrhzd7ZDJTTzPMRfirXHZ9plD989msHKm+8weK0qctso3XU9hHsNz9LsXA+p
	7+DbeG6xTkv088HG2KkCB6IXaW1u6dDZFV6+pyVp7hnESW1CV9KEi+RbggDFWuFUFuSAcOxS255
	a/okr5ZvSJZvrtCt20TO8nMrR9hvyLpouvN/Emcs7UDnRKpKJOw1dzXqf7jwSCSgn1/8PYn2fM8
	4y0jyy2oCDRw0BFj99wjc9Bl7hcbjtXj2UZuJJrJVQ8TtINOSpZCdasb4J4YZeyE3DnIPdGH1f9
	BuvpHrixu55F37Rs98TEdeXjyuFvoy4ZpUm3yoK63DECUtx4ZoqYrmIwvFiWCg4445J7xV+DMqn
	Jt0TAjA2BUbrg==
X-Google-Smtp-Source: AGHT+IGF1LEhdK6u0GTG7vkgqPzfWNzij92vmFzHRWF9D7+10hL0D9scLsVvwsImVjm45RUGeLFi1Q==
X-Received: by 2002:a17:906:ee8d:b0:b6d:505e:3da1 with SMTP id a640c23a62f3a-b76715161f1mr4924114666b.7.1764688458151;
        Tue, 02 Dec 2025 07:14:18 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f519e331sm1559799166b.24.2025.12.02.07.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:17 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 2/6] PCI/portdrv: Drop empty shutdown callback
Date: Tue,  2 Dec 2025 16:13:50 +0100
Message-ID:  <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=egM5mTVCzCNzWFMCIhGAjywkHCVVLgrob3l7cgVET70=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkx9JuP3wQtvrD0Xf335ignfu3R9mzmYbT+t2lChNWOZu 9cNyaI9nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMZHoBB0O7qoLxXclun1BW NX92uY6F3WucpaSDrlm3Ckw2cf+rmyM1R23Lt4iH71/ot/k/6PmjYJV39YRIzl6VpBin6WuCV64 /v8L+/LzWtknKFtfumXeGCL4yV1YQ7n5ZJBv8WlTFL/hESPyqLOPJZapFz9+wMB3dzMWzW7p4vX HOsa+KTH+PTRW0sp0ievVHdor1i47LexuPPDgTaLM74LehZlfUZNtd/xY5uzNvu/rKau+JJXzv/ PvEtddIGETm/3ubdf5g56wLZl/2B2+fWvcoOS0zv1R6v4LwBceJ7q3LFA8ZycqfFbZk3NuR5Nm7 /YDeHd4vsT/5QmKfMWxbMCVVbnplPEu6EXP0wbOeirIBAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

.shutdown() is an optional callback and the core only calls it if the
pointer in struct device_driver is non-NULL. So make nothing in a bit
shorter time and remove the empty function.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/pci/pcie/portdrv.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index f13039378908..63492c3d3565 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -564,17 +564,6 @@ static int pcie_port_remove_service(struct device *dev)
 	return 0;
 }
 
-/**
- * pcie_port_shutdown_service - shut down given PCI Express port service
- * @dev: PCI Express port service device to handle
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * when device_shutdown() is called for the port service device associated
- * with the driver.
- */
-static void pcie_port_shutdown_service(struct device *dev) {}
-
 /**
  * pcie_port_service_register - register PCI Express port service driver
  * @new: PCI Express port service driver to register
@@ -588,7 +577,6 @@ int pcie_port_service_register(struct pcie_port_service_driver *new)
 	new->driver.bus = &pcie_port_bus_type;
 	new->driver.probe = pcie_port_probe_service;
 	new->driver.remove = pcie_port_remove_service;
-	new->driver.shutdown = pcie_port_shutdown_service;
 
 	return driver_register(&new->driver);
 }
-- 
2.47.3


