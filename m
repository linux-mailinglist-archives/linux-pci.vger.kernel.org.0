Return-Path: <linux-pci+bounces-42495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB332C9BE91
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43143348769
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB26245005;
	Tue,  2 Dec 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k7Fc95L+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299123C4F3
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688466; cv=none; b=laGp89FfX/We3nSGvE9mKM5PcAulJB6dk7UupuZVfJeJ/oArDE0/xeFKbT1XvwVpxU1BmeMK3MszgsHOTbsciiQsnDFCAUTVDqAxL6XZQFFo6k685N4iZbfsdMofKqNKX9mvNNXYRrBMC1m3+JkJp0A70jN6Okcp9aLtnrF5jmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688466; c=relaxed/simple;
	bh=+Sc22xZPHoOwyf1w2zCOlJ9zk78RtuBwvrPLtXFKyOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aI6RTNH3FrZ4vgM/YiEoLd1CLDvg4A+PIVht/ffH1DU6HRn6wuHv9n+/gaBB9WDJDMSQgFnYJOEEDqQJ+kT/9mEMqNuuBY2kXso0uHUMnIhevdhLkO2DTkxRCRJ7gunnSD5doaFOmUCGbRHTNQZrer5A2uupdwTY8B/qHpsIHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k7Fc95L+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2794193a12.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688463; x=1765293263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6vZIMHuTOcATwS6tV32jWDpVWJyRchBP/m9NzaqaxE=;
        b=k7Fc95L+ImxcIskRmSIJfOD2vjRWDztBlQo0V53SQHMU8DqFDGi5/7sjr5RQcSrkZ1
         RCAEYGINNaikq9t2yurks52ausOyQu6CPcZTjIDotzXXwxsl2OIpuaCRe4AVsKxxvLZu
         ttw9TTz+z6R3lCKcK2Zv2T4o/c79qwUU30oB4oIcuqMY6/KsxxLdadURpD++4aM0Yqm5
         nE9iHZ61GjaPiUdzliVqbp/UkU/pZF5gJ9mzOZe5nzyH220Tq8XDNNBeqr5C1fPWPHzy
         Z3eyCCwQ/gQZfboIkm8SAR8MuNwAEneV5RCNYe4MkV+nH/eSavbw+Ij9uGI53HK+IIIJ
         7UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688463; x=1765293263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6vZIMHuTOcATwS6tV32jWDpVWJyRchBP/m9NzaqaxE=;
        b=Kq1dN5IQddZhAUeU4oiuL0o9zgnHpkFelZPSDIyP5957q/YdE52OpATKD9cWQQjD1m
         YS9vJL3VqSxQvD5NH7E17cEa71nQ+S+39lyL4HwEAks/DP0/ZzZgYMf3ezfJ2sGcsgOA
         8+0HgrtgPEMXShi3SdtpymSMnQj9HO1jqoMEEykQTl4d39xUpNAhQzsIrtzu4KQmgAFe
         Ok34upcs53HPlBVF+sogWeWfDCtSIyJC/WnJYhGRI8Xi4sTFNFsy0sbILowwHhzbsJiR
         vZT1/2CoHTUpYR3Y7Tb7WSzHYRm6E3KV5/yEOlcOngfFlFM82VmHvSXbYzAa31WrGMhg
         coDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE42hplr9hRHxnb/BF0Y9jZ0J4pBkCY2nARRHgJOnO+1nsAgW60T/AtS5syf3TL8IMyiAetRhVls4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBm06chGa60yFFRcCxv+VZaJgVmmdDs07VcchBxof+6yOfIJo
	vIpNTZ05AocglpzRQwfljxs8YMnvTuCBRWXw7j8x7Zb8M7MhRQVgH5pNpmNK11LPnzc=
X-Gm-Gg: ASbGncudyqNubKAefek7mi1HuxuwHD873ZR0A+0L2Ggau224eIRfCH2ImxswNx6iq8X
	X0TixMquPk/CBEu1U3edgW7i+s75upQ2lujuLnJ3mlv5aPrL12sGg8OFJa5XuNR19opxaeTWVvd
	sVN7xtH/qtaPotgMVhu0ebZAUPSIe0LnJti90ubH7aCUaoi8qNkbTueVfyYerCxiZnn+M5e+Yge
	GQQJHTSxsSVmwt39hORkZEeQ6pc7ZCu8k3epY5cvjiUV7vjGEkvNLmbL3vs1q3LbNszpDeCJFmO
	b7rE4e79LNddHHbe8Z9UDIhz+uKX9vBTuSGZQ8uK9uyOG7J6X5SwX4rgVPc5xYPX2K8mkzxb5lR
	lCmd4oAvbqpk/55PiTpL90NaRkwjrWelM7iVMJq+GrtnZ3R9OIIG20XNxdmuPaVGXGzprenHd3L
	2DoYc5ka4Hw/aaUPl6xwBOEWPbniShpxubog6uW/hCXGTe+MUurNmnq09fhQARNsg6lb9RsF5Ib
	ns=
X-Google-Smtp-Source: AGHT+IEHajzjEgE3YB1G9ZzBrF3pl927iSNsuj0X9sq7zy5lqWIcs5hSVYgHaGvbfp6AdUT3U55bag==
X-Received: by 2002:a05:6402:2549:b0:647:6ec9:8d8b with SMTP id 4fb4d7f45d1cf-6476ec98dc4mr10375363a12.34.1764688463014;
        Tue, 02 Dec 2025 07:14:23 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6475104fd7asm15733362a12.23.2025.12.02.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:22 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/6] PCI/portdrv: Don't check for valid device and driver in bus callbacks
Date: Tue,  2 Dec 2025 16:13:53 +0100
Message-ID:  <2cc2e15e05318b9f0d7b6a2b69b3169d2a6f0bd3.1764688034.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=+Sc22xZPHoOwyf1w2zCOlJ9zk78RtuBwvrPLtXFKyOw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwI7izqcpFmaNcMfngtAxEGS04MYrB2N0FJ+r w66o4QL+BaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8COwAKCRCPgPtYfRL+ Tg61B/9yf2AUep1SP6EyDv82OLAjmV1aeeUvGFNH51OfrQ0ixAy0YMyVlBbNyOSVFyw9RcBAGs2 CIX5DJfY/0uNDuyIIKMyTPn/ppvMH93OmtA0Nra1dOquoYfcQA575XSHpdXheOJ4RuXUvfSZMqL mdCRSILNjM4VE9Xy/ggPSLpuafZw4h8HFn9nBS+BToNkcqYv4HuZlsDRr3izNErmhmDwM9fvcth /GH2gTiNx8NN9Y2ofKziubWhwdL0wsqIpazc8YT27zGUuCQhkoIQyBdhp/AxGhB09WDPaN5GIC0 qAX/2XFQOTXPfYRySjQwAiEjq8+y899BZ5U0Yy2jO8qXR/OS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver core ensures that in .probe() and .remove() both dev and
dev->driver are valid. So drop the respective check.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pci/pcie/portdrv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5cb0daf6781b..f164fbd0884c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -537,9 +537,6 @@ static int pcie_port_probe_service(struct device *dev)
 	struct pcie_port_service_driver *driver;
 	int status;
 
-	if (!dev || !dev->driver)
-		return -ENODEV;
-
 	driver = to_service_driver(dev->driver);
 	if (!driver || !driver->probe)
 		return -ENODEV;
@@ -567,9 +564,6 @@ static int pcie_port_remove_service(struct device *dev)
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
 
-	if (!dev || !dev->driver)
-		return 0;
-
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
 	if (driver && driver->remove)
-- 
2.47.3


