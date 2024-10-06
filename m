Return-Path: <linux-pci+bounces-13891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFD99204F
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07BE1F2149B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E931189B9B;
	Sun,  6 Oct 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNFLGWBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85514AD17;
	Sun,  6 Oct 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238493; cv=none; b=smYhgoGKPvfuVWsdNUwSPPwUJiIk2ExdnECqtc1YJKHXwWWNGkeEZAMURlfa4+iFybxnSyj6szIvOAAL07smaV8Qvq2BlTLwgoTINDqv+/a0DxdbWDamM95lB09jYjSsnuUW/wdcWBEs+iVWadp0+hoOhP47idYeDVDyaWto4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238493; c=relaxed/simple;
	bh=wuN0CAdpo9z6pUfyGlarVdLD8QRA7SSxW71W7N83XeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1P9/4vMEyIOgcbsbFy3zHJFhcx/5/Wucuvb9Ar/K5Ao/daHYX9AIkP2OBJFEe71QzC+9Ygl0hcd8+Rm2xlRuaUaZU4W+J3LxyV4jZttislqxPI0Hmehhe6IuupEEmqW+/sbhPlY9B+xjO2QcvWK4GBZQoPY6yvD8F30QZD1Dik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNFLGWBv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so3102987a91.2;
        Sun, 06 Oct 2024 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238491; x=1728843291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zDtd4VsB1QKwvGTFFxUQVnzIMbAkBrYOLGaEaZYNSI=;
        b=FNFLGWBvvV4cvtaYYm+tuHUBOG7G96goX+YcNIg7NOj+MzXeQUhr8RHFbYI2pvF938
         voaCA/bm5eNWDvpm/vx0Wie+XySfFdQNfGeYm0XkdSOLeGpRNboMWFzVLo3GiGUwDVmT
         al0o2qv8BCpYN+ghhLGxkWzq8Rk6PkQWa+53hmvmcUeLx95d2yOnpKWzUbv5tsqDJdQI
         5XQBx2/XpT6BG7fFLTyb4uHh8pnGQJ5SZ6CJ7cl2yMUffTfuzO1tlFYW7orqYhwAt9ho
         +VWGp9wxgqrVBKqIWbYEGi5YZfhqGZBGMaBVG8Rl2F6VenV+H14UhkZjSny2XM2W+JjH
         SE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238491; x=1728843291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zDtd4VsB1QKwvGTFFxUQVnzIMbAkBrYOLGaEaZYNSI=;
        b=xIcO6SHoF6KYBaajljK2hSQdBlSy5Y/N+F+ErFwoH1ELfhJ/FyRwCt3DTnBizuX3gY
         QM/5dvUytOWt+gwDkN8yrSTb47KdjJ2TKJZbaPe44ZlHOkkQoBV9Cumc0GRsaDaYHmNU
         RPHUDwJ6VDO6iftm8Q37hBkJigehiYPZ2vSFX8LjoRpSGAu3p3X40GpAhJkfuBFaKgCx
         u/gGOr1Z3yL87LXBHOKSc6SQ3I4xyl3aPn4d/bGyD9FShtm74AHhz7tH9FShQqtZKWde
         GVTkrTblXqYuFRgXDjqSKPqxJNATJ/SGgGLNIU3HROwIF1mZ57yjkZUgcy65DWQ+q1IG
         WAiA==
X-Forwarded-Encrypted: i=1; AJvYcCUI6IVvxLuVufYQOnoIooMdA/1Hkc18kQfWcZTk3hd5Z/TKb1S8tALA2DLmbzsDVi0akDwxaguaJ/nAgXI=@vger.kernel.org, AJvYcCVApkCxHHza4/s5u6vM16BefnCw+qyfrL07xPZKSRFF2KBE2izbEsgALt60qiCj1DQI4YExA1qqnPcn@vger.kernel.org
X-Gm-Message-State: AOJu0YxDolSecc7MW8AtQiIWIh/Y6aobH+KL1bPYlvgxbpZk4In/Xs3E
	9XaWQHYpzRL7OsZtb+xZCISs+ff4xUbe/cyVQIHlpYc7AiAPK7Db
X-Google-Smtp-Source: AGHT+IF2TMNWOK57NJYqFhiohYWDjeEwtqyjREKr7ARGPPU865LgGVMGCkUWKlmrHBilzXg0Gsbelw==
X-Received: by 2002:a17:90b:3803:b0:2d3:cd57:bd3 with SMTP id 98e67ed59e1d1-2e1e636f4admr10702335a91.29.1728238491439;
        Sun, 06 Oct 2024 11:14:51 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d9ab8sm5403095a91.29.2024.10.06.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:14:51 -0700 (PDT)
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
Subject: [PATCH v6 0/3] PCIe RK3399 clock and reset using new helper functions
Date: Sun,  6 Oct 2024 23:44:27 +0530
Message-ID: <20241006181436.3439-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following changes are used to reduce the code and used new
clk_bulk and reset_control_bulk helper functions.

Additional to the PCie core controller changes
added some new PHY changes to help improve and clean up
the code.

Previous changes.
v5:
https://lore.kernel.org/all/20240901183221.240361-2-linux.amoon@gmail.com/
V4:
 https://lore.kernel.org/all/20240625104039.48311-1-linux.amoon@gmail.com/
V3:
 https://lore.kernel.org/all/20240622061845.3678-1-linux.amoon@gmail.com/
V2:
 https://lore.kernel.org/all/20240621064426.282048-1-linux.amoon@gmail.com/
V1:
 https://lore.kernel.org/all/20240618164133.223194-2-linux.amoon@gmail.com/
Anand Moon (3):
  PCI: rockchip: Simplify clock handling by using clk_bulk*() function
  PCI: rockchip: Simplify reset control handling by using
    reset_control_bulk*() function
  PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function
    signature

 drivers/pci/controller/pcie-rockchip.c | 219 +++++--------------------
 drivers/pci/controller/pcie-rockchip.h |  35 ++--
 2 files changed, 61 insertions(+), 193 deletions(-)


base-commit: 8f602276d3902642fdc3429b548d73c745446601
-- 
2.44.0


