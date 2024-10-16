Return-Path: <linux-pci+bounces-14638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133479A08AE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2822E1C22DB4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF2208233;
	Wed, 16 Oct 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqBWbymE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C96204F9E;
	Wed, 16 Oct 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079396; cv=none; b=hhowVNO5/a0mJgPolWAoW8s8LZ8R4Y3HFbESzHQEcz/HhIe+7z3z/m5oP3jn/tibIgAwizQ/3oBKkO1HIOTwq3bB/RGSOiG4ZDb4IvvHcOmdemDGiSiZXmIy7yDbil+9LAs5X7ppdGqzP2gXpcQ/ihZYtPuAnZnIjwVEyZw+vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079396; c=relaxed/simple;
	bh=T6kVIqn4l6ZI22gpd3eyYpQuLyr9qqEjqV8Svt579JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5FsGk6nICVfwH0wqcAWdXRaIRURgAWbGkTBzjgCfegpmXr3oxwAmJuaqFMgiK4L6WTq4EOX51RW/c1Hm6stEifNKfWT3ShYlTZGKNf98mxQWfhAwC5wEEn1C6BKgSl3AmvuVlIMZDst8ywQwZ3K+S+3tBm7mRKdP4CNcEpurec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqBWbymE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1034284b3a.3;
        Wed, 16 Oct 2024 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079394; x=1729684194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IKPNbzzOzACLwecoRTNKGUBWVTmnx/6aags3CaPxhw=;
        b=mqBWbymE+1OBzDOqSteCind91r8dICjDA/29cS0PBQxPnq7uZOxj7mv+wR6UD2uaS+
         4uRTKf9CyjnxklFP/vQ4Wn/hSbOt9rPHG/IWVGGyovEULGzQi9ewA40K8ysaU4zUPdog
         tg4L0WehixR+16/ZzmjbZNcnSLnIo26Vdh39fSWrDvbb1WolMp+z2gn/Yz65sg5oRbdm
         SeY7TLzrY6glw2QKPu0H76QH1S4CAUyLzLae+AGuafRl5EPnWgGCs92pAdJ1s2lykHkO
         jrYTOFb8cahMbAhL8pcE/4KasdNRp4W/Iu7tY+j3HggRvykvuVwPY2ZjP75GdFy11/kO
         UmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079394; x=1729684194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IKPNbzzOzACLwecoRTNKGUBWVTmnx/6aags3CaPxhw=;
        b=r4tMtk1i9QhRyJuWnx8BpvOv4U/hnMvon+u56gZ9xdbcbAQyYJjihvsnNycYcisZfa
         B6N59R2l4NoOkB0rHJP64BIiY02odIvLT8oIB8eAQuaavq72mVgJF1RlYOqkQAXlEJj+
         qHCiC/s1geEdX85zSSsDpSYaudhkmZ+xfF6rlZ69bGRQZd9QrUoYB1Ey9XV4XWIcQIM7
         D9QNLGNS05f8gemVAUiMxKkJISI2jdqePkAdSXyvP81vrOEqxARobo3nUg1hBVk5tTrT
         DHT2HAhcDRw0TQU2SaAalG+DeiCIHvUfo82D1Ot7/AW6dD3DqEvvg26k+V01psnpje+i
         f2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQgcdSdG1o+C3PnQ17h+asLXWp9d1Nq+cn4CswOEUPrWvFMZ3/K9JEf7SiyIiCpqpUaBwBOM3UcG2l@vger.kernel.org, AJvYcCXwoBLcSGwAPof4/N5UEkJCnPtOjmRdi0l7jTJtZqNo9dhCwXGBTjtKfu8OdIzLPngAY+85m3yqGEFyBlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc35gAQE29pgZOFQ3PzUBm6XoZtX70Qu+ZYRi8ZP3krnHSTGUD
	hCO9PUJWEl/Z6sLGDMy/EuHlKgV2XYNEP0JmsSkql0l5J1Q6IeAy
X-Google-Smtp-Source: AGHT+IE2qVMWnRPLQLqcOC6ylNqm3GYoppiBrMY+Prai1dF6sxCkqO1q2WQEqjwW+zdMIX0ac6ZO+w==
X-Received: by 2002:a05:6a00:91ce:b0:71e:55e2:2c54 with SMTP id d2e1a72fcca58-71e7da37396mr4891602b3a.12.1729079393982;
        Wed, 16 Oct 2024 04:49:53 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773ea9f2sm2968702b3a.95.2024.10.16.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:49:53 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Wed, 16 Oct 2024 17:19:08 +0530
Message-ID: <20241016114915.2823-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016114915.2823-1-linux.amoon@gmail.com>
References: <20241016114915.2823-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the rockchip_pcie_disable_clocks() function to accept a
struct rockchip_pcie pointer instead of a void pointer. This change
improves type safety and code readability by explicitly specifying
the expected data type.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v9: None
v8: add add the missing () in the function name.
v7: None
v6: Fix the subject, add the missing () in the function name.
v5: Fix the commit message and add r-b Manivannan.
v4: None
v3: None
v2: No
---
 drivers/pci/controller/pcie-rockchip.c | 3 +--
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index adf11208cc82..1699d49d24f2 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -264,9 +264,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
-void rockchip_pcie_disable_clocks(void *data)
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
 {
-	struct rockchip_pcie *rockchip = data;
 
 	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
 }
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index cc667c73d42f..3c63166fdc17 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -347,7 +347,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-void rockchip_pcie_disable_clocks(void *data);
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type);
 
-- 
2.44.0


