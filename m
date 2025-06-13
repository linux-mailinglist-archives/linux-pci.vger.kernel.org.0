Return-Path: <linux-pci+bounces-29642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AFAD8275
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B49218899FD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCD1E0DE8;
	Fri, 13 Jun 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbjv74RC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249191BEF8C;
	Fri, 13 Jun 2025 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792136; cv=none; b=PDzenEvbMRnzHgQGi/0MFWyDqOj4hZawkukxZqhc2nSQs7tTZJpalKsQPsRMuNNwj5QfX9GXEL69jdW64GilJDkHC/7KAfUtmA0dasFglAsG3HjyA69pk8ZX1kz+ffsqyd/zRBJHMIxBsdBTgRBWdR9qBoh6hpMLGadPKrcyuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792136; c=relaxed/simple;
	bh=z1QuJQTs2qeychSUYLbx3MrTtjKfzdWwsIGraIObLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZkn+PjcAS8kJRxyVFwsLPghVe3YYvz8D1HM1xc575BxRBqQQhmiXN7hRwXeOlB/vCOqjrr14qpqyJBfvtd3H36S9RsjCDOJDM9mRkuNCtzBDfWF7MzTudFJeYldZNsC6h6w6heQW9HqnmLWjVjGxtnMxLZgZA72axQlGAbQqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbjv74RC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c33677183so15185925ad.2;
        Thu, 12 Jun 2025 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792134; x=1750396934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=Dbjv74RCVYnfFE60BL7+Y/6BCvJRLkpY1w9ZC9IxLD+Dtg23pYzyUsT3RUkquXLtY7
         TSxZaHFOf/+mBk5sdjHN+2F3Xy+XGtjz0HkeFOQLtqBWZhWCjDCaPkgw2kbilEgkBSch
         DjH+8ISiaz40YhZHqfwU2YSfWNQkWHFmwxcKnA1yAaofl9DWglxi0roZt7bSUWUquUlj
         bl6T4g+xsFGNrHUxNIGJssYnWvrlNy0wH/4WAy+70rU1WsKAfIeWK6NZ9q+t2PxGDSmY
         0wRAFeV/w3aGhE1RFpV3XTsOa05bsd1GEsSvomxDtBWZkp+L1C079XhAAfGgCGWJy1s0
         hQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792134; x=1750396934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=YkdbDyxi/ycLmF9VIO80TmvzSpYsrGnaq4+e9bqc1bsc7Qm6x+vkuZmSsfNjOQ7eCC
         J0+3CvnojQuStLoFRJTs5nMhKKxeLijHE21sjUyYJtMxF1CrjOTzM/bampKT1pfjktC9
         qihPsCJyShrx6Kvni6BqO0vD9upVMpx7/ZNlwHyjc/jg2pqaAErZceChmrX5G2wjBLda
         C3Y+diFfuR9t1YDL3p7Tte7Y9O9DRy1pSDdwvbxDlGZfC4KNiJN4mIUH0Oi3Jl2uI1q/
         bV+9XChP2hxcoap0a7xLKdYYIeu/6otRVnm9CexxV8ZhuRlxVveGqragXkPvHzi1Dh9E
         kPwA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xUvPKZTveK/ifxJJFmyCm9EIo0IdHLWf2P9pa5rUxQxVzJs2mT/+4fLCpTSurrUG4nLFPDXznHjB@vger.kernel.org, AJvYcCW2qTJYwIFT/V6w4dSswKJtu0LLVvPAQzzon1L1iOSYM5Dz3AYAiw/VuP0CZbhfMr09VFQnje7wmyJdRCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0ugQosm0NO1rMwu9COtkc/A2FvMbjS/bq1KVH+3bphZWg9mK
	8pZPmic7tFjSbrTLE9v/Rbwtf86e79b5i4iQsdg+Zp1n5epFIwLWKtY5BjX5GmqW
X-Gm-Gg: ASbGnctyRSu/yFZuIW931KFoO805mpl1jciu3jxHOYEqdqGIb5tLrNPQ0PSPSzEr7uA
	Li+lrJx0GkW3xAI6pKIOxPLkV5ChE+2PnSfHjfNSjqmMm8oza+l7QD/Ke3/m4ZlhkDXVDLHtZcJ
	RlyqONqyN46UO0Y0Y+tVnQvEipFdv12MJfx7Rb9QaA/PN91TXcBjrPlH01PXHNkdFSISgGMgxjS
	e6W4ggdAU+bnFIGTtyou3MR3+zpkuF1uSYZ+TMbjY5YmZH0J5gqjbIP6jTgR23aXPj23EW5KYoD
	XsfjQD4wJwLgf96zPw1cIXZQWTnsmUOabpEuWVgm/BZzxouwCjFdZLYZHT8w
X-Google-Smtp-Source: AGHT+IEWyjq4xMg580lo8WQVDNAohT6B3E79VxSn35cTbl6axZCqyzY7pffkdHQBHNLWxSl9Z8GleQ==
X-Received: by 2002:a17:903:2ac4:b0:235:91a:4d with SMTP id d9443c01a7336-2365d8c24f4mr24732935ad.23.1749792134271;
        Thu, 12 Jun 2025 22:22:14 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea905fsm6220995ad.166.2025.06.12.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:22:13 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:22:08 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/5] phy: rockchip-pcie: Enable all four lanes
Message-ID: <490ca50c2e002df02f8eff5e2266a4a992ce5cec.1749791474.git.geraldogabriel@gmail.com>
References: <cover.1749791474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749791474.git.geraldogabriel@gmail.com>

Current code enables only Lane 0 because pwr_cnt will be incremented
on first call to the function. Use for-loop to enable all 4 lanes
through GRF.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index bd44af36c67a..48bcc7d2b33b 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -176,11 +176,13 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 				   PHY_CFG_ADDR_MASK,
 				   PHY_CFG_ADDR_SHIFT));
 
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->phy_data->pcie_laneoff,
-		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
-				   PHY_LANE_IDLE_MASK,
-				   PHY_LANE_IDLE_A_SHIFT + inst->index));
+	for (int i=0; i < PHY_MAX_LANE_NUM; i++) {
+		regmap_write(rk_phy->reg_base,
+			     rk_phy->phy_data->pcie_laneoff,
+			     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
+					   PHY_LANE_IDLE_MASK,
+					   PHY_LANE_IDLE_A_SHIFT + i));
+	}
 
 	/*
 	 * No documented timeout value for phy operation below,
-- 
2.49.0


