Return-Path: <linux-pci+bounces-12582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14E967BC4
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 20:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9179A1F20EF0
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2467502B1;
	Sun,  1 Sep 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM6wdo/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6561FE1;
	Sun,  1 Sep 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215641; cv=none; b=dKUfvEK8bq5mggZ5qPomRzjHFbHm+DRtkoslBpFWg3zeH2KTKcft+SN0AcYg+hwtE1lQ9rkTVd6DPfM8M2WTMkIIvzFegB+b2F8cbSOzBYamRpXRaySVpgqLYOEVg5eW6hDjO+jfGPDorhsgy5e9SWgriN5PXz+ZyIkA089CLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215641; c=relaxed/simple;
	bh=RnCdEXTrN2MmmxjJ2LOaan+zTEpA3ugJOQUc0LK5cyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOVraZwpM9DwcvGMj/rqokc8tBvilHk7XqxGetxvRDEg4s3/UcnoryyHkqoTlChWfvlJPuseBwLwyiLARETGhkR6wrG+S6OftkQf2KjYk6B9CgWojhDe4wz+2cYHVr8dceb4wKQzZAK69jzUczubbxAVQs8z8eehpm0T8d/sUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM6wdo/C; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so2310062a12.0;
        Sun, 01 Sep 2024 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725215639; x=1725820439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzzz5BgFwRDVkmJ8r3yaq+E3D+dJOH3xQYUobHOj2zE=;
        b=dM6wdo/CTzGnW1BepKTa/yG9gufMIJqtxLn7yNSnaSQynfM+r0/yJX5lXpaIlYRKVi
         BqEEF22ouJNXZ19UllSQFaV72urCS8lhv6B1/A1+QVmcPE/KG6aU8SCzjhGDLLrVK8Uw
         i5KThG5SXs+MKPnXfOzPKwnALFe5nPCu5rdqjUA4yqqMLjOAJB/R2Q5i1BifUhb93d9j
         uXqUiI+Z6Y74EC5qWkJ/IBfjXzpKGYCMnyDVkpNt6zTvfJBD/wJPuQ8fc/p54aZlzCnx
         aucqOQVWpYhWIG9zWaSvUAjeEFva7iSXHJ2cWhmgCgvdz9KYHzWvo6vbmtSiGieasCKf
         KQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215639; x=1725820439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzzz5BgFwRDVkmJ8r3yaq+E3D+dJOH3xQYUobHOj2zE=;
        b=TESjtgxBL66K4JWw+QP88bw2+zGzr0ps19ODl8+uNcAsVnEJ5MP5WK6rCBbRp+2asR
         6/jagz7S8RrELcQ+Bh1x/cI7rY4IDLff0/vincEaGqRcWbLqeCYzeqwGyO4U3eOR9NI+
         +tO/ba9FScQs3fHzKtdIjrpItxgHdeF1Txid0/yDOgHIqQsfPfxaAPO3gnbGfGib9WVr
         dNpQYTWdp6NQIwYHu6OyLwaA58gt6tIQYid2W0qBLCYj0p0bb8yGLcBToB31KDpCYzBj
         NCWwXl2ayQvDNwkzCRWaDBmxVObgvG4bGciZf3/Njs+DL4u06iSOUCzGQ4mMBhEf/wRq
         KLTg==
X-Forwarded-Encrypted: i=1; AJvYcCWwICcwi2R+QVT9XG9AsGimRfeOxcj8QdKmJCAX0ot1z3o15nXgpIXemTaJ2prjaslfcF+ZxqoNMfs34n8=@vger.kernel.org, AJvYcCXqe3qiRuC982bo+Ia+7aX+uVDsr3z+IIOOFFnXzY/aQq2eAu22/vT9dntzRsNvMXNqNoqQbiwMctSL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWd++GJQpa7JWb3ripdhqqR9AK69jbV/uWXeT9PA/Xpaw3kBF
	+uiPG6qQ4atHzIKFWAGaOr7RB2CzzCUCcJCdfiTuN6XgM9++DQQL
X-Google-Smtp-Source: AGHT+IFDgqjSW1rL9/PXo6YlVWAy0MyWhSsve1VDtotr74xSvztHnzFkJDyDmzxaqwHh3b/9TiVGQw==
X-Received: by 2002:a05:6a21:78c:b0:1cc:eba0:e7dc with SMTP id adf61e73a8af0-1ced053bc3bmr5198514637.34.1725215639483;
        Sun, 01 Sep 2024 11:33:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559b793f8sm16262405ad.15.2024.09.01.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:33:59 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] PCI: rockchip: Refactor rockchip_pcie_disable_clocks function signature
Date: Mon,  2 Sep 2024 00:02:10 +0530
Message-ID: <20240901183221.240361-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240901183221.240361-1-linux.amoon@gmail.com>
References: <20240901183221.240361-1-linux.amoon@gmail.com>
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


