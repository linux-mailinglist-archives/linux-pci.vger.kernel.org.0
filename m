Return-Path: <linux-pci+bounces-19339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464BCA02A4C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E923A1CA5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304EE1DDC2C;
	Mon,  6 Jan 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrN7pk/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067EA1DB37B;
	Mon,  6 Jan 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177467; cv=none; b=Lfc75huku9MB1gsG1ZxcjljYNFq9oRyVipPuyI0EoRwH0DAJ0XFt4UiBo+nEEEnJviWhU1XD6msemsmObnp2fa39tXE9GwWXNpg20ByBWfJNqBdDJWPvH8rd8IQsYKz0vOF8Bk/PNz7tCTCL8cYtlVVmDKNgm6NzVquJmefeI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177467; c=relaxed/simple;
	bh=EDybw/NZMpbe1a4UHHQbeoN/ea6ocWXiTwcs+qHc394=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCAEmigQBpz1AvqftUr3sUe5Ou5FbeZD0W5AjRjKIrTm2D+TmlKOsOVf4GQRhCZUCenih7ymFaO/AlWEy3yRhU/WEZPxtZ48utgTlHmKwfz1MrVkOfidjX8iWKpYoEWefJXnUEIw31GDeNE+Tf2TFLlLfHGZZXAaiFFEPpOrpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrN7pk/a; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f44353649aso17061006a91.0;
        Mon, 06 Jan 2025 07:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177464; x=1736782264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBQxKezogj3hUsBA+RD7NmdY71lrTIzCVtlr8uBqDlc=;
        b=KrN7pk/aFYrg5hNGKu7hIKYxiakFAuN7mbvgaL0VpMwum4Cux2QWTIUh2hklc67Nm7
         IDETAtAEtrCGz6aI96RkZY2dHTSv8pEsU0+Kvcx6WHf0Gpnfj53BQTjmj1uTMHq/mI5n
         GRllcr6QPSjFTUnZN7v51rX2anAqgzdT/99vXoK3OZQqT4OgjTs86r/s7/XgGevhAlcv
         TW587dO41LniShPnmo+rFk1jwrivXoIlqMCPokauFMdTi1kaqALh6rN4lAfMPKGKFxTQ
         0HXlH+PYJxH6rYuiGvvr+CF+kCaZzcO6m5kB3WpGS+uT5g8snCsNo+5zRmZ1TrvPSf1c
         b4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177464; x=1736782264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBQxKezogj3hUsBA+RD7NmdY71lrTIzCVtlr8uBqDlc=;
        b=CNDj6Rgtl1GGtoxW5K0sxiQ4Wle1HqPFYFtdRPF6s+LFs4BVMXXFxwLuRNwkquCqBe
         gykwSt8m33o+iwLnFXnaQksRcd3ABBufJyM/DnP4q4rj2oDKkgkEYJKYe9/wcnR0/7At
         82pzCqkm8GUntlS2OEF4CvykbB/ZT9FT59i7nDEsj0PAbJd6YTq5RF8HKwF9MbCGc6v3
         Qi2X93FWKK6j+UF2ZPu75aye5aOQ1ayZe7sQ49xEtnr0cJI6LMrjtiD+sFCKvzvHMRyo
         79pDZdGXwzXwHc+dI+BshCYyG4L3ecFwcaRo78Tbf+ITBWqof1yR3jme3uT0ULleEqWr
         50yg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgWENlZ3unEXbgJmQTHsnXZ8l0GLxCCgPJicLGxBknVDKPYpxLqPGOm+vvPsoO1PbkHejxa+UE/56@vger.kernel.org, AJvYcCWJXyJ/PupAysMuziITjOUtrX/B0lyfoXi3rpddRhaxv6uwFsBzxgapr6/Q3fQF20XsvzB0STdXZTjE6LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLq4AXz5h2Zyhyj8qlGD/WjJh929FBq29n/R8jofO7pzVEltmx
	73yaYAkmtZeWKq+VKhKvUEpfwGpAdyMVGX2uoK0sl08Zeq3jegrL
X-Gm-Gg: ASbGnctC+nN/UO6WiJ0puUstZP354l1S0tkWggizgj3T334O3A1zqJhS2b2HrWGyPR1
	OWFv7lfcMwsiRqVPv+izvOJwalr6n6FzopOMA4wdY3/BMvoWtxeA1lwXbPFg9lyX/zAVkkmvO4P
	k8UXkXs3lA7GB8r2O3yIy07vyiL1DIFqAoXEoBdkoW0SqBE7ARzr7RX8G/uJ0AdLpmFw5PWXaRJ
	wadq7tUXv+idB6eXzMyMrSSC3tVcfjqt+DPchlwTL6KCzeZaVVG7oNord26u9s6ZNkSzfU=
X-Google-Smtp-Source: AGHT+IEpVXnpRJ3PoY57i1hGVLCcefGFkHNI6W7R1t5bdQbjKEwI0vc1uSmphBZQdLUQ9V1lS1z2Ew==
X-Received: by 2002:a17:90a:d00f:b0:2f4:465d:5c94 with SMTP id 98e67ed59e1d1-2f452e2e490mr84455334a91.11.1736177464159;
        Mon, 06 Jan 2025 07:31:04 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2d9dd2e0dsm8507976a91.0.2025.01.06.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:31:03 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v1] PCI: rockchip: Improve error handling in clock return value
Date: Mon,  6 Jan 2025 21:00:38 +0530
Message-ID: <20250106153041.55267-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates the error message to include the actual return value of
devm_clk_bulk_get_all, which provides more context for debugging
and troubleshooting the root cause of clock retrieval failures.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202501040409.SUV09R80-lkp@intel.com/
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index fea867c24f75..ca6163f9d2dd 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -99,7 +99,8 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
 	if (rockchip->num_clks < 0)
-		return dev_err_probe(dev, err, "failed to get clocks\n");
+		return dev_err_probe(dev, rockchip->num_clks,
+				     "failed to get clocks\n");
 
 	return 0;
 }
-- 
2.47.1


