Return-Path: <linux-pci+bounces-14895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F699A4B78
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9007D1C22089
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE81DD86A;
	Sat, 19 Oct 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL6G05aR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149D1DC739;
	Sat, 19 Oct 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317741; cv=none; b=qm8r/omwInEDSyj/UC8TBlCRSFtH4OsH5kqFpaY8M+DfjTx66zpd8luSiKqbwi/STGh4QbksidoY7TA15FVwYh7lKoktHqwKaQ0Ucdkq5gXteUncN653v0/Yq6LoP/pHlHcyRx3xqzEI4d3D0Y7fSc3b8Jn0zQz/gT7XxqVEN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317741; c=relaxed/simple;
	bh=WQVXQCe/rti7fQndM2TENyqC+dpYUv1/DOpkJHHxHEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4gpL7FX3ofMgRXaRInDlaHSzYNG4I5aavbOdO8iuLCCRi0s3XIiUX/9E4fK1+Jmmi0deQcQKBT0n+L8AgB9JuAThBRdhq3UZkUKADPI7FTQP1wikFRTP2mrazIgH8Sos43cImW5VaggYHWayUHxjj3LEwYTspGBI9c4xwT6dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL6G05aR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso2269883b3a.1;
        Fri, 18 Oct 2024 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729317739; x=1729922539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUgasqhf2zFGDtxIVfIDzPQhIor0l5/59FEipaEvi24=;
        b=QL6G05aRqiyFXcUBzEHYUdPs/7nzprDh/QujayW5QinANYhh/aP+vVAr3MmzmFrjkS
         OPEBThKRL86lgjC7KtgDOYhJWkzaJD3M09yN80QbL6aSN31tb0XmeF2mqM+qRJgcUiJ6
         FVDNcUnQ2SqaLbu0+XLHg+hVKC/re4OtBVKWGo09g68g6N5hOnAV66MEU8Vz/sLIQiap
         kA1oPIpci6JJtGsZtPwZly6Pt1yjbk0qEMcZaopbr+e/O58tiM6WjB6N5h7hvpO1xLNm
         gVICsdwdqevBK6YEqXNRwC66dgFljXQuwgxLM2BKEQ0K5od97to7quitLPIDqXIJNHe1
         qfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729317739; x=1729922539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUgasqhf2zFGDtxIVfIDzPQhIor0l5/59FEipaEvi24=;
        b=T8yk/t8fQ+3QcOA+yxsu3eRrHGAvrOlLGYZ7PMoQGZvSFMZOA9IypDmbM2Ie0RjrWu
         vK6aEoCJQXbgqgS69yrQLL75isz8unP85HUmfgblL0S0U5RlWv1u3RPlmLCF5bDrxx/z
         D3hUIzXewzzs4YixDMQK3Otq7vrBVDBd0lCFZXPyiggBEntLAElDe+MOj9UsFN2VsMjt
         MbQEvlFeAls9FXXQcAKRK45/TvOB2X1cSeHUcenh6EMcbcO0WqrleQseJVKX0by60YBs
         +U8FiGC8II/lES+j3NkbEnnvfxq7swkRYPW8EK9Du9EN9dMdkKZ0UY86prTaR1CW6lAs
         x3pw==
X-Forwarded-Encrypted: i=1; AJvYcCVRWyVWvrfjWhKgeW59IVdVmmwR0fX5kfOZrmSI/PO11Q5ghSqIaVcbmllMMPtWkfcnSc8VM8Uw69WWDnU=@vger.kernel.org, AJvYcCXuKOTAsLIDfRKltZWE3k7WwqX/k2lQ6vv4WwQOsG+k2ekJqMsDhzKmtEfTx74NuikB4wVGdWKfOFe4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ocPg+XJjePNZDvTz6HoCdAdzbATr42GPeQ3gMxaEc+8u1ACo
	LixZzMeaxQFPj06eJgjGoOqrMxdtqQESrKUME8eZd6pHEOY/z7ir
X-Google-Smtp-Source: AGHT+IGVfgnsYh18kSoCdZXX5vsBdvGIHM3mWShe7WR09Ol3ANoB0giiTsc8CKRWY3yaCsEiDTV/AQ==
X-Received: by 2002:aa7:88ca:0:b0:71e:7636:3323 with SMTP id d2e1a72fcca58-71ea31f8512mr6636737b3a.7.1729317738873;
        Fri, 18 Oct 2024 23:02:18 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333e94fsm2424237b3a.69.2024.10.18.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 23:02:18 -0700 (PDT)
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
Subject: [PATCH v10 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Sat, 19 Oct 2024 11:31:35 +0530
Message-ID: <20241019060141.2489-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241019060141.2489-1-linux.amoon@gmail.com>
References: <20241019060141.2489-1-linux.amoon@gmail.com>
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
v10: None
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
index c17aa8ec80b9..4d487f79a6fb 100644
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


