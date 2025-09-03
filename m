Return-Path: <linux-pci+bounces-35385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1EB4227C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072AD16B8B3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962130EF64;
	Wed,  3 Sep 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBbP/PXl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE730E83D;
	Wed,  3 Sep 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907523; cv=none; b=GHeQSXS0PDuYgnxU4wVH+6z5sgZsQGFAmdHnUeOh5lcRuJ4nbiWMG8GPQquaqoaMP6wtEk9vjC/lObXLHbWGfXl+dO4axXG+sTM6wWIOw1nJ9g0hSbUqf0XeL+DcuXphKlpQeduQl3crYpt+u4xSPT48mJCz/9xGiHiHV7XG/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907523; c=relaxed/simple;
	bh=T/KSTrSwcf413M6648OAvY3x0y9kavIDZn2ShtBOwsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LjasHx301ScyBt9JzkKWydKlCwEUPslicQ39houftBN12ifcmKbmVbAqWj81AJoMZZMFd3DDGDJAE6ACKhezqehgt5U6nBP0Jm9jJkQG0hmGRjyGwLTifwLdLWzzlMDCm/c1xMQwD21pgwRwqNYF6rVc8Ojp5uWX0LEHAY1pLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBbP/PXl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24c89867a17so8836315ad.1;
        Wed, 03 Sep 2025 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756907520; x=1757512320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31pvuPyzmxy7Nu/xNQn3+yYnNi6oTH3Hxdcf+kkmhtw=;
        b=KBbP/PXl6FUAYyZqD+q2Z+ypSDdXz/9LPHFut40fgaOUxQzKVl+HaO8luSY27uCfL+
         PMgiN/WL6FQDIFMiEuGML5kjZUdswGt3KB8dDIMOpeBPaGvsUnLahqH+NWzuCcUnJ65y
         28nXzfMWBiqcQRUsTvP18Ut3+5P3UEFBsDXlNUQvA4xQoUSsmXybuI7/VKJIWfeYhEpc
         neLgpqeNZrFe+WcE2V3rUHh2r0YfgkVvRf7XB3YQP9PLH4Yf09BsIonVWSt5DQWPgwP0
         w0rEI55qJJZibmFRsJjwz4xao7tq+DPBArs93lHrBAPKxw/SV2Tmc4sB2xlfeM7mV8ss
         kXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756907520; x=1757512320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31pvuPyzmxy7Nu/xNQn3+yYnNi6oTH3Hxdcf+kkmhtw=;
        b=CY2ORhXpoJjmb3lbbrBcRyWOpiu0vFViQ/nENBN7E7hqs6zA3fApwkkGwiQUWGeHnq
         lBDe9iSVSaoEdFNcpVsRGAyoBPxYknQLoXBL7g5gUL3FS+uogaTODQra7RnsIIvzgN+b
         hzuQuy8QxWkIokW8NsmyF6l21ykBR4AB9FASG0qMOkeHPSylhkvt0fq5OFZSzbnBF0nv
         8vcZKWZCf+DjMMecwJ08c3WVQXzRYy8FV7fMYzSHRmwxmr2R4dGC9nPcoYAOrhvGvUuo
         lFvMHGTl8gP3opxdsi83jVH6RPagKMmHg5zy9u9/gZ8lRjhxp1Q54K1eUtRfdH1dWHWo
         u6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW9tio98wbUg9NjmV1XnaZB7Skzyo8myR8gEI8WDtuPDKE8iJ4Ve9pOVDODOmODFJFis9hP7nWHALyo@vger.kernel.org, AJvYcCXa/XhXM5Rcu7gat9hpP+yvQ+tWwAj4p6Y8fg21121MymHZpvCkpJyNzAKF2YzkCy+f+i4D5IximxTlcRQ=@vger.kernel.org, AJvYcCXs+ZlgkvSj5gDZksr9Lom1jL6rCDeHOZlkFET+n6tOpEcK4zZqIAYBcNmIFtM7i38YclsN7by/@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxcarDttghajvFAJcA/g1v33jvNVcEBb78uo5Z64w/AtPp2CI
	Mwl9I1BLcOTy2/XjyrobH+ALtC4r/KoUiIdAzK9xpDjWSHXSXgk1lI9a
X-Gm-Gg: ASbGncvKhWngz1PBQm4/jqhlbnadGPwe/1smZ0S/YpoRgRIBQDeklF+RFhwrjR1VQas
	vfgy4TReP9Fj271cg6hAbUpDRqPelLaM4Zgs47X2Xxp3Ro7P/sR7igNPjLwWVxSZedaODFnnZBB
	91s3vRPf12EaHC68oRH1x775rK4AnqDgf60XtipwOU5rdlwezlyIKOacIAjEOph8NfXrftcNO2D
	kT2ksev7qhH4Fxoj3UYNnKIu2yFWC7CILrQyJaJUZ70gF1HK9cQR+U79ytnTTFJk2Ji8CmyY1zT
	Br/hZ2rcWf0tTW1ZK3nw2RDoilviNgzCOXgHDlkAYT5yzyp7UBAavKCYjkqXRyEtiSZtckgHXtb
	mxe3JxHg62GQPS8le0ActYKHNKe6Vpes56h2a7rDYrsQn8FFesPS+HtEuFVSg8Zs8dtlhYC6yHd
	1fiixm/SAm65kz1/oJxRi5ZQn79jrd2jpfjtehq3/cb9ztyxxGEFLT+Jc=
X-Google-Smtp-Source: AGHT+IGPXxKq1vceqgwEfnjmmFK1BX/HaS7d7j+fXNMkyGVFiTc/r6Px77JsUZgpTvhRMqRYHCDxOg==
X-Received: by 2002:a17:903:350d:b0:24b:299a:a8c8 with SMTP id d9443c01a7336-24b299aab5fmr68322845ad.20.1756907519733;
        Wed, 03 Sep 2025 06:51:59 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.163])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24b2a5852a9sm40585005ad.150.2025.09.03.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:51:59 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Trent Piepho <tpiepho@impinj.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] PCI: imx: fix device node reference leak in imx_pcie_probe
Date: Wed,  3 Sep 2025 21:51:50 +0800
Message-Id: <20250903135150.2527259-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the doc of of_parse_phandle() states:
"The device_node pointer with refcount incremented.  Use
 * of_node_put() on it when done."
Add missing of_node_put() after of_parse_phandle() call to properly
release the device node reference.

Found via static analysis.

Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..618bc4b08a8b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1636,6 +1636,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		struct resource res;
 
 		ret = of_address_to_resource(np, 0, &res);
+		of_node_put(np);
 		if (ret) {
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return ret;
-- 
2.35.1


