Return-Path: <linux-pci+bounces-9062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE6911C15
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D09E1F244F7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44035168C1D;
	Fri, 21 Jun 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI2ngVmU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AA1667F6;
	Fri, 21 Jun 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952314; cv=none; b=Wx+gZhhO4c/XUlH0pFyJLk1KOe4m14FBZwpy/TSJUmxQQlkFJLdpw+sJwHO1AAR3f9A81KV1KqZImo3Z3QQGFJXn7bvl7SsZKGkC/ovWbigLkStls+x9YD2XVM1UqbrnTlpd7eRLezSbqHR5jGeBhq8V5Eof7No2SfffFNdn3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952314; c=relaxed/simple;
	bh=qh8In50WwOdpu3xFyQ9ljLj2zMwSwJ5FJpD5RD6c2VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH/78CHyUmwvL08+jP8K2MJw+j7JGxxP13u7egoFMV/nhhu22+NKxNY6lmz3syuSy209BkJTzddJisxmO2BwLUW7qkSZJ4l/Xy2nB5COiPWTFOQHSkZBGovfp3BM3Jp0TRXvjJkDSqeLU4Wb16ku2yPzeKnXdoO0dLDpOidoaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI2ngVmU; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc66c649so780090b6e.1;
        Thu, 20 Jun 2024 23:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718952312; x=1719557112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c3IUUghQlxYHrHfw3/LC7ZyAugPVzJNu5s/S2BsRTI=;
        b=nI2ngVmUA5uEry5ZjlNpDJ5J5033f1VaxUH+Iv+wr6c9X6ZI2hLffvO3Qk2sFhy70H
         glmZE9llHg7tKnJYkwTMLxWql7gmwx/6E6rbgXYgJgrm1goGIOBKXa1Xb7+ixziDbLDn
         pbjCCot/G414y04Kx+aktVNo6EuqAophhC3FaR6NKsnbW59ZQSof8ETtGNrD61+grV38
         TpeA/PEwUG+l1tWD8un2zTCUOafIkiZPbsLrG/uxfm1ZLbthml9E47vN6nuagq9MGg8b
         ZO++TpwdLxwLM8k54YPvIX84Bm19tPRm2sRfs0WNJVLfCLDQvvMgMVGJfZqlkq9qU4/V
         REPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952312; x=1719557112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c3IUUghQlxYHrHfw3/LC7ZyAugPVzJNu5s/S2BsRTI=;
        b=Y1rbuQRZ6tujmHpTgEWpSD6MYZgm2vW8xq96PsCLvMYZqOU8DD5I947O6JsT0gJV+j
         MvL58epyTnJrnTPmlxhtiCO5Egzye7gclPfbJ1/1LckVYEaaH4vD5oIsp/A1J/+ioHmU
         5XvMU3Vb8kReSRoGlqHZ8ebJFxpnZJN0Dndzhsg9Oub3PXkenMOJxuJjQo28pAwxZmBp
         T9h17PJCpqKVFLsEUBV2JQTiClcN6d/PlgYs782r1oPVYrWEBXFmDYHQA2Z6QUpnDH5z
         bL3G/ED5Ei0BRWFgplQ3O+900A6wRxNE7+NBdAsuZ1yMJ3w0pXDe2kRfGcHB1vvYreSS
         61Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZneGtfwIoTc7XxF0a1EEHilECXMnScShDKEKm3ZEfXst0oMdsr+ilXzcZbRUgOhLb2I8AArXI2lEv25CV/Ny05x8ya57fpSRoEpwvIvgawvm1II6Tc8xxjy2hAkyGxkLLgRCOgKC
X-Gm-Message-State: AOJu0YzrWeidQM2yMTRd2tTgcBxYN4XDqVL5G0c1N5ucb4RWA1QiKiF7
	vq4Par5mMHKr0mNIWn+7BvYzPD8WkKkV59DT40mREySuj84tPm1A
X-Google-Smtp-Source: AGHT+IHfpgCmiN4yKZxh9cbTOz2of+YIvMIYN9KZ2/R2f4ckpehIvdm8HVeXkx9Mi7blW/ux8nM4Ow==
X-Received: by 2002:a05:6808:1784:b0:3d2:2512:5a5c with SMTP id 5614622812f47-3d51bb0f078mr8378774b6e.53.1718952311934;
        Thu, 20 Jun 2024 23:45:11 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651194776sm683117b3a.67.2024.06.20.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:45:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks function signature
Date: Fri, 21 Jun 2024 12:14:22 +0530
Message-ID: <20240621064426.282048-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240621064426.282048-1-linux.amoon@gmail.com>
References: <20240621064426.282048-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated rockchip_pcie_disable_clocks function to accept
a struct rockchip pointer instead of a void pointer.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 4 +---
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index f79e2b0a965b..da210cd96d98 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -284,10 +284,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
-void rockchip_pcie_disable_clocks(void *data)
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
 {
-	struct rockchip_pcie *rockchip = data;
-
 	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 27e951b41b80..3330b1e55dcd 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -354,7 +354,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-void rockchip_pcie_disable_clocks(void *data);
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type);
 
-- 
2.44.0


