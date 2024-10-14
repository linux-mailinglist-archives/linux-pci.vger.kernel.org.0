Return-Path: <linux-pci+bounces-14477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328799CBE7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA734B23DC6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627941AAE2B;
	Mon, 14 Oct 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjOwT941"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0E1AB50C;
	Mon, 14 Oct 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913966; cv=none; b=Cx2AzejTxJ8AB+2Sy+x0Wqh0KrkP2y6+SyJOlSpKRuTvWcyhfJnouPSf7dvfWa+or9R7qr903DEZvQi3H9BwLeSp3pD1JHaaEfc+dlB3WPtWf1vFury44OTmtCFW2CGPX3l0pFvaxFlUqVJDX8Gg8q1manfIELGfHacziIzW9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913966; c=relaxed/simple;
	bh=wfkeuJLiWPzjSBWvLMinxWrW3GXyGZcAVQ844MkCKxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdx4WhUxHGrdFnVgr3CSP2XCrqKANNqzknpuKatTyg5itjwjlkRcqnr0cFIpV7zkeLzVt/4bVLTptmFdCPC7Qx9GVamMhAydh3Vyh6qMASAKuMEBdo443+1FoCdavFkps8K1LmosbwKZn0o+HgKcrRhPOzBmLgbeNvLxEutPSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjOwT941; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so547555a12.3;
        Mon, 14 Oct 2024 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728913964; x=1729518764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fse7R+jyfvmxQ04/zP3d7oNQrkd2ejgxhVtOLTVYKFA=;
        b=NjOwT941zCFyNPYmzYpv10BUbDweT36cFb7xtuVw240eQCnc33f7cmA98Hpx5pfK6Z
         gPfYjsaTvqcAdwCB5UeMq15/q9WZ+UOh1TuWBwFVnHtUkqwKuFPziPu2iqQAF3Y2K2qd
         dSAPx+v2H9BSG6/UYKZJ92TKUHD+iyhtKzF1BWd2VhfrQ9eNaDvijSTddH6KT1el1B+l
         sKobUOzeHl+uWTZ6+/lpz2vq0ckvHES4Vx231PzfoQv8os4T/9FydVKLO+ep3+Z+K+Pa
         q9QTj+Mj2innagG1POprR5dmAp9UYQ3JedL5Ed/0NwznKkKlNAO0lEMHu3O4MBDqQc/1
         f17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728913964; x=1729518764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fse7R+jyfvmxQ04/zP3d7oNQrkd2ejgxhVtOLTVYKFA=;
        b=fptCQTXTrET1PMN7pSDDgfpON6NOKXUK7jRwBilIIHEtQpnyWzy+gExdu/FpMnyx6Y
         54VhZuaE7iT3S1P9cETGgv0nknbpnxXWNCZhhfZkggIbm7DsP6If+yZ3M6SBioWiAvxo
         eMH7QGGmEwf+Zo1EKRTrqZfVoZUNY7w/HQhGWjsisGQ1Fjlasqv9y93ZWJHJhlZ6q7bC
         QNGs1+AtsunY3FARLkQ0s8raB0SdeODAkb+QoKc1XW0T+pn1dQerG1KPYLWvJjMbxAqh
         IHaq2DgAGsllBUSoGuEKKR1Mk2pXUckhlbGDoNBHP/BfbENFujAuB2cfAzKlB9b7d6R+
         cs8A==
X-Forwarded-Encrypted: i=1; AJvYcCXW+oSvwxDEfvfs0fmnx2OMqO8ed8DiL7dArK2iw3JMQgPafn1ssPBPWs29X7F3N18EqZsm361pYXol@vger.kernel.org, AJvYcCXgEswEtJiHrx2p4gDCsDnqpZ+YrtAJr99JB5iExvEExoGKtZDlYMG5clN18AvOQm85h75wtzgOKfxBbx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tsQcXBTNn5FkAPXEwsUpmjaavHfT+iVyVmQG6r9NFAHME9bP
	9rsUfOZ+dmzIOvinUUYLqIWSqBtv2jAGdSDzPB/WZfAo26iQHt9Z
X-Google-Smtp-Source: AGHT+IEUPGagVMOC9KCLecIWnezdM5vWHBTxQuVtaECFWLCdoXEIbPVt9GIICdlpAXiKjEaDRjzGCA==
X-Received: by 2002:a05:6a20:2d22:b0:1cf:4fd9:61db with SMTP id adf61e73a8af0-1d8bcef1217mr20431553637.8.1728913964134;
        Mon, 14 Oct 2024 06:52:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e74d6sm66469135ad.166.2024.10.14.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:52:43 -0700 (PDT)
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
Subject: [PATCH v8 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Mon, 14 Oct 2024 19:22:04 +0530
Message-ID: <20241014135210.224913-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014135210.224913-1-linux.amoon@gmail.com>
References: <20241014135210.224913-1-linux.amoon@gmail.com>
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
index 43d83c1f3196..eaaab7c11323 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -265,9 +265,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
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


