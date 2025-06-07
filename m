Return-Path: <linux-pci+bounces-29129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B12AAD0CF1
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 13:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6131892688
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2E219319;
	Sat,  7 Jun 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF8FCWSx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593954769;
	Sat,  7 Jun 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294105; cv=none; b=poBm2mcP1ezpf7g905Va6Qyto0K4wRzAkGVUDxYVwmLrxhqlUpT8t00T2VEGxSvRyLJVOSENs5XOF+YPWQCtKD4TPWhrBprlsCIPXZDW43QLfjwRauaaGL28qHVKVP/UxzI2D+QK1DSbj/4ogJjKsSIuVxKwQFdAmtjCffMMfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294105; c=relaxed/simple;
	bh=zOPTHm6uizkBP61BfOqG12krMiI1LexjfXuTxcaJzNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z7pnIMV5k5dTu1Nq9jqRlQ+JkMWkyz4mXZAox0gOu5HvbSbr6Lc4WqN3Ik51b1zqcC0xBZnsbvXGpM7BFakvsggbXvr21ulGPIYh2bgBAf94osciHkMD2FtiGBkPUMCJ4AKlyjptBi4LN/FEEHxFUaV+h+5fJuQHlioTWHETf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF8FCWSx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7481600130eso3004411b3a.3;
        Sat, 07 Jun 2025 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294103; x=1749898903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zSu1izb4tWJDTxLhqSImmpcJMMSBIL+shCUHw2Xsjs=;
        b=JF8FCWSxOODWUaLZksdtMQVDU3iMZYnWsdcFnC1kJzqRU5UAnLwQKBldy+PRLet0uN
         GnXXfP4qqEl58kAfH1yUx17WeyQaXcPbQhydbQMHxnwlWJlzBNObr7vgi2QmInv1HDes
         0g6cUiJWUmIDRWX5gWwbrjK/UJvvcOAhwXWJlmIuBg5miaBbeEsxAoTF/e6+ir7coaOm
         p4faE/PvYW4+xONv8jorpHIuDXy1/iDlpGK1O6i00ZVfEA4iiwoyqO0kRDB1apRWsboE
         dZwQH+CIiqyULIe5hebyQVMn7M+Ng6JA1ANmXuIJlPfPlS1qIKftCTNJJjZgbaqSRFyr
         9LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294103; x=1749898903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zSu1izb4tWJDTxLhqSImmpcJMMSBIL+shCUHw2Xsjs=;
        b=HZ150v5Cx0E2J+b/osrY+ZS469/iNhTNemzeRHnVAXlBnIXR4k+DqhyIOFI/sNbYyO
         disua2qX+NvE+kxnMIAmveuIXZGzJcMwWiN6cgU49ROcikSNrSBg2LmFDDnN8cYoaXa3
         yl0mYXYCbnZIvoF00DlnF+/4qM53rlqLS9bc1Sz6AgURJADApzP+AiiOMYlIKc8jK7Hs
         9W+6dnYPFhXv7wve3z56NX4YcixOlQuysC7YZrqDe5KQ9A1W/s14/+Ab/i3cP4JtQFwk
         lVZcaS03LQFHV0N/F1P2pIWL/53knleffgeDfnssl4XgmJBOFp1b+5KE7qVxOBkX7Cxk
         gShA==
X-Forwarded-Encrypted: i=1; AJvYcCV+lfJKm1X7K6wHaaSBSJ9kd58uxYSLYxMcfzyTb4Xt8IzwDaC6hFeFhvXTewOBtsSdJP5QrNfVRcC+@vger.kernel.org, AJvYcCVxau7XFKLm9q7kHMKomjeYDOjIIMHlvLkMz5M+bbKQtR4etQXboFapCpG+YnuEhRNsYJeP5zfhLsvV1q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOHqOvqE+O7kLYQ7cO8pueU8xkuEPyk+veXkw9XNlLkncwv+N
	74/uVjYCPaZmSPu6fxxha37wvV4+e6dwSyX+sCViCb688VDvlMhSnvS3
X-Gm-Gg: ASbGnctuzhFyQqNXz6fir4o4qvqhRru7Sl+77ZLFPoKuqV2YzltYgYqyqHVY2HxyeMT
	yzD5noGaBXSmj7/FmJigHwjogH7IQTocNGqrKEMH1N28yN90XMKbB7OouS1qgNYPbn1hHR+mPtn
	yemBDrg37+Qo7fGvhWCjVKOH3WmR8PhaRjhqAMXdAoWPLeYA/GcyF5GiH0vY4oBAfkqt8aW8jlK
	sDlQ6BReJR5zKpGPwhTS0L8WTTDM5W2IuR7XStlui+Jg1AQkNbbQyVx4Rk52tpm48L2gREqXFuX
	NEBsYK7HYaaMC4tyzkbGg769+psGvxXcNYAjv/UCHVLbxuBO5A==
X-Google-Smtp-Source: AGHT+IG92XPX/rE2LJZk4TUNKBW2ws8nFw7IMuK4bikAYNrgsCpmBPTBH5f+Tfm01lqMfPjIBc4FJg==
X-Received: by 2002:a05:6a00:4884:b0:748:3385:a4a with SMTP id d2e1a72fcca58-74833850decmr3053128b3a.23.1749294103248;
        Sat, 07 Jun 2025 04:01:43 -0700 (PDT)
Received: from geday ([2804:7f2:800b:2bc9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847aesm2611189b3a.105.2025.06.07.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:01:42 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:01:37 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] phy: rockchip-pcie: enable all four lanes
Message-ID: <aEQcEbfF05JwZVKs@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current code enables only Lane 0 because pwr_cnt will be incremented
on first access. Use for-loop to enable all 4 lanes through GRF
register.

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


