Return-Path: <linux-pci+bounces-13897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB199206B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA41280C73
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C018A6C3;
	Sun,  6 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkO257Y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372D18A6BB;
	Sun,  6 Oct 2024 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728239122; cv=none; b=BIddDBwqWXGTMEDWZVA5UhLObfTvMBlbFh4HKhKkt4a3ifXQBbh0SlOban0RKThcfvwtNW0bdAbaJyVYqrQ/EWhWxmfy2MEHfzXYNQZhUk2F5SS/xzVY5SWgIrzkIVzj9+M4BjxID0aG91kRv9pdahqMAQHaQt+k3JHeYhJEkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728239122; c=relaxed/simple;
	bh=pYbxQaLMcZtpftUxh//oaazmdIZ5kBKpUWHBsDASlR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYxchh7RKTFXI1LBFWzIvIbGC4QVMRnYugyNrG/jEQep2w/H6CyNGdZ3Nsd/kTu5/28hvnejN8HiGhtAJJL1OKT0L2Bws4TfR3I7mGhFsUwuUo7lkBTmBP//1UtAKwk5N/xAjEpaB1VZmmYq8OnlqpUm0VMmPJsJ6a4kEKNnX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkO257Y7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e082f2a427so2690012a91.3;
        Sun, 06 Oct 2024 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728239120; x=1728843920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r5PI5Fsr/AroJKeUAO8bkOP6c9YME9rlzxUNbudK/0=;
        b=JkO257Y7PkLz4+VwY+peN1c03f3EjbhxGvqMH5Pc3GaY5CoGdtbqE6IoWThCdEymt5
         lo+CSrog4ByhRZfAEkBELFotT8lh9bKmVtsCxj3ztujItHHlP6ke1khx6URfEn+Bt9J9
         MwB3TSFd7XNzBnTqEccVq/0cov5LmMoHXQcky3sfWqLgqmewNOjuqehfbU9sVUK2dzvf
         ANMqZ8O5HKWitndLjSV+bwH21zkrSb3T9xE8R7TRxs6QcsuFCs8MzyocDod6vYl4GghW
         2IGvfA8Qc9JSKKRlQz4CGCHqeGm23uz+72sxeWAJxm1ToDJK0c3DV7x+5W9A38B9UbIV
         /bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728239120; x=1728843920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r5PI5Fsr/AroJKeUAO8bkOP6c9YME9rlzxUNbudK/0=;
        b=MyfoOFsfvCrv30Ae+YwMY2jeMjzAef9gylSQB8bFMTTsAMt5bqpSsCGIFuvaZoBbRf
         gM+XQDmuOwZ4RMHmTEE2O0Cujz6++VuhPUpVvXdr4uSSBN6f7j924hCof4KqxKwVAGHJ
         rd25V/2ky9aAgnEc7PfDtaSUpQ+4BQAaq8mKpppiiffeTwZgWC1YQqrDrSIy7v8H1QAt
         36Pzo39jrv8c5diLcIojHBGU48oQCU8ljM9VUSnbOY6gKkGn491Ce98OfkQdDOb9ruW0
         kJe2cCK76HwajnEzrAUkGZQFNzwZYWcK9wesWEgYSx8YzusKB9Obf5FtEgQ6SK5sIiFR
         Z/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvDwjurpuKnd8cfnbSg402jWWBR7hzPPeLyMU4VxjyU/En1K2UPANpvUxqzydC5dpnueV2c5lxLgZD@vger.kernel.org, AJvYcCX/w2u6h2KLwqCvYXBBXFiyh12Dj9BglmgbOE4/BynXRZ5h0tYzAulwGtlWJqCZuVS2VaDn812Fk95IQbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyN0phSh6CNcsGBASs8z0OvLS7O9oPHgryybyTclHtC3Z3IIJ
	FQJyo/0AUU2kSamvPKBQUeAdwKnUOYbA9M5AdjJs3nKNy3igOHWr
X-Google-Smtp-Source: AGHT+IFtOoTTIfseZL/AtxCGULgp8rsMErzM23/LafWsSPdU3aoQM3dDxgKn7TbBiyBWhpWUoSB38Q==
X-Received: by 2002:a17:90b:4ac7:b0:2e1:cda1:12c6 with SMTP id 98e67ed59e1d1-2e1e63c58c8mr9370758a91.40.1728239119736;
        Sun, 06 Oct 2024 11:25:19 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c905esm5458471a91.17.2024.10.06.11.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:25:19 -0700 (PDT)
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
Subject: [PATCH v6 RESET 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Sun,  6 Oct 2024 23:54:38 +0530
Message-ID: <20241006182445.3713-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241006182445.3713-1-linux.amoon@gmail.com>
References: <20241006182445.3713-1-linux.amoon@gmail.com>
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
v6: Fix the subject, add the missing () in the function name.
v5: Fix the commit message and add r-b Manivannan.
v4: None
v3: None
v2: None
---
 drivers/pci/controller/pcie-rockchip.c | 3 +--
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 87daa3288a01..b528d561b2de 100644
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


