Return-Path: <linux-pci+bounces-14358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAD99B10A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914CA1F22F6D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852D13774B;
	Sat, 12 Oct 2024 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwEeW8NH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92012F588;
	Sat, 12 Oct 2024 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728709607; cv=none; b=cMdIP/3mgYEc7b27wfAcOBfTDVeUJ9rA0lEuqLnDzY0jYqSy8UvJGSekdWdnP1YXD5gbgl2Swi4S6NpqGm7/y4jt6DdbS3PZSBS+x6ZtEuHh6dRDn2+fuFAb6OTUugAlGG2CGGLPhTXKMBE2DqzqbizgG8a40oEO6E94FU0IOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728709607; c=relaxed/simple;
	bh=TvbJoRWmZ3IE3J8cwVIHQKM4m47ajNC1mqy4uVaJVCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEdqX9H1K64TRPWle9Hv0CGQHMbOX+p+3gt8DsjzHb4i0fuH9TOZdU4IACbhCGTnf10vvr2+tu/p7UbJyngY1YBTtoz6wM9W3xYEAbgi+boANsM1akS/Rdr9aZ3wkEB42jB/9ztRqQXnXgYeIHU2fl+V/ec3wLN4OBHRvilov98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwEeW8NH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e053cf1f3so2436214b3a.2;
        Fri, 11 Oct 2024 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728709605; x=1729314405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myoEO0ww2czFo+NDaKnAm+OqHSFtr4LH3EKBGNBM3z4=;
        b=SwEeW8NHNTnNijyAM4AAjG+rDWMq83Deim7EHgyN9NdYVfoRXUca8VzQOoI6cUjkhb
         IE8dzsfRZbO1aMKPJlVeITfZ63z91AtKtLkcNaf18/roOfYU6zcVVFqvgCwfMb3T9rGo
         /cyXEQOHf2r6i+msU4hf/qF+ksKF4AqJGTaAnPjsgubREzqvL/F6SnOE9G+MZQ0i3yWX
         nJVUQEL0IsoXgOXG0suU/4KBHW9yIQ4Lp1d2LGljcOGin9Qgc3PmaCjIbsMFA6LKxXjn
         h8lJqoENIel/49cLfcd0k3jsYge0f4vhVfUM3PEya4jbWPiFpinpycWGNqqgwuVpHIiT
         Hmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728709605; x=1729314405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myoEO0ww2czFo+NDaKnAm+OqHSFtr4LH3EKBGNBM3z4=;
        b=ANkjzWEnZ4BTJ/JdO5oMMPIEDq5Rqxccn8H/nl6qMDCbjSxQhEMSJMMiuTnOTiIooG
         0+aJI98tUDnnRfy6FE/oq9KH8+FP9P0Ktr3Aa6EXsPQ/77hsdQMAbqxMO/dzpFM84Mys
         hGPxTG0tyUKb6oK/XK8mdensyDrGrxIEI4+HeL5kXQOO1pvhE9ChyfZsfwsaHsq5VarX
         BO6eVzDTLm54ZUZ7psVk6jduJCMrLvRydd72Z5+aSUoAERKobJ5jCok0XWus6KofMq99
         AVlNI7exFN9gqfGDTW/PgOiCX/Ur9LzFY1+vHLdxl1A93Wx6obEc5wAHuJtD/yRqCKNZ
         nLbw==
X-Forwarded-Encrypted: i=1; AJvYcCW2HP1v2FoxLsyuXwHOYjsygEd/6GE/rQOT7P/zotNE2Oc8FEXwxJHqw5NrMruvGE4VM23PPNlA/3FOkEw=@vger.kernel.org, AJvYcCWMEZ5SNTVTvPiIzJxwsfKg21QNYgEoIgic57oN47Z29Sv2H+cvo7JHyqUbOcoz3tOMYvNfcUmI1ZgZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjyn6NsDm7tYT3/Py4sUVjsNSavQVCAgaPH9DrhaFLxZkEzePK
	W/i8dXD1324FbULzNhmZsUS0gBrPAB128z7lTG61cvgpB8gQhICL
X-Google-Smtp-Source: AGHT+IHbWnSJOFSlNgJF4OYXyX8KdfVCrRAO9/1mq47VYfOabgDCcVZ58F7Tw4bhokGiBoTcmX26tg==
X-Received: by 2002:a05:6a20:c997:b0:1d7:1277:8d22 with SMTP id adf61e73a8af0-1d8bcfb296dmr8295467637.43.1728709605470;
        Fri, 11 Oct 2024 22:06:45 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b9f7sm859809b3a.190.2024.10.11.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 22:06:45 -0700 (PDT)
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
Subject: [PATCH v7 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Sat, 12 Oct 2024 10:36:05 +0530
Message-ID: <20241012050611.1908-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241012050611.1908-1-linux.amoon@gmail.com>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the rockchip_pcie_disable_clocks function to accept a
struct rockchip_pcie pointer instead of a void pointer. This change
improves type safety and code readability by explicitly specifying
the expected data type.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
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
index 9a118e2b8cbd..c3147111f1a7 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -269,9 +269,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
-void rockchip_pcie_disable_clocks(void *data)
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
 {
-	struct rockchip_pcie *rockchip = data;
 
 	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
 }
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 2761699f670b..7f0f938e9195 100644
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


