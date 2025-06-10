Return-Path: <linux-pci+bounces-29372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50381AD44B5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FB53A6716
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30C283CAA;
	Tue, 10 Jun 2025 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTW4nwga"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B285283CB8;
	Tue, 10 Jun 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590429; cv=none; b=WFEBhx5t2dXtlG0mI62YlJ0FcNTklaMyEjBSwe6uFJ2mc5WTvRAN6p9lJBNmHm929N4P2Drx4Ra0y14jpJjbzHT2PmJobpC1SKh3LPhnJUWJ9jkFxdj4ETcoPkJJWTHzBdVgXfG2D1J5cdDO4lGUTtG7y1nMgaHOasHdB3+3KC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590429; c=relaxed/simple;
	bh=RQyajJNgx/i4LD7NSbzA7d7o9iqhl4O7QAcY7mWNSDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBbN1tixdtmI1djR9qqAbiPlhG2/9EIcDKLrSF+cj6+rmmEqihXDqsLvqkiQBOTBKG6IB/3RLRKWwJEv7IdSLlmkeyoTVGZZoO6xRTyhOvjpGffrlwGeQrk265XsGIvfcP1fvoYspEK7Lz9rzxuALHS+c/Z2N6eVfUrTP6i/OtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTW4nwga; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87ecc02528aso733138241.2;
        Tue, 10 Jun 2025 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749590426; x=1750195226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWQhuuEyoK+JNH/BgqW9wn8WNRcWE8A0uz1Xnd+CF2o=;
        b=hTW4nwgaD/Xx8A84Iv8FEz4zcY1zhAIXAvsvi0Bzh0dpWKWxY9duQRcsNUO3gWkoRn
         XkE4IalUT1uyMzHiv4w/EtQbkasqehnxKPKamV0qqrwqxhD/IfpWVoKB2c+XCvIn5nL9
         XMIEvWiIFZnattjyp4JLUuw7spL9N7PRHEPlnh4jAXZ1L8Jc7E7eYi/dEe0e4t8jbyzf
         kjUih0YX2BRwKNFi98aHLUQZdjaWJ/vBIOTlTRzmfRLoD1kCic/TZPSbuDwGUfUHGlTd
         cupee2Weyqbb/GrMWBD+F/eIjwbamEqm7MxTNNHXm9rrXvnNzU8rmQOAg9rLFQQNCqfM
         LBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749590426; x=1750195226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWQhuuEyoK+JNH/BgqW9wn8WNRcWE8A0uz1Xnd+CF2o=;
        b=dwHp4qKSc/EmRZgMC1N/cOJfm3aNIFsfh+xliE48yusE6jZI9VspT8G+heD5Pr3Ydg
         6IcZfGjxppInJ1Mk2wZMX7mB4sfBXbxV8ucwcmEKN/GNEaW2pgQ51tsJZ0d2pDHLORM2
         UMrqiHvFmY6tuke6vuocSJi7/OUbucBe+abeXYj4fKt3hBRybdbecC6DqAuqrGJN1h+G
         xR88jiI/0TdC0vCMmSn71n6REhizBlgvuHRkBI/2FdRICmLy20U9pl4WEHBEx17I4NyV
         V1nEDd29Te/3fugl5qGTVfRfQpzqa9HjqW9dV7Mc52+ridfl94QwfR7XzCnycIoNWXhv
         KyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU12vrtqLv1wcFr3u1Gs7OvOqoMt5Se3/3mi6PAnOSIkWb5GsoWELtj3ohYgO3DitGZYDhLr3aFo5JDdpk=@vger.kernel.org, AJvYcCUyMzLHoK87fVvdcTbrQgQKmcGHqQl6av/ayS/7Lw/2imUyw1jyVoUHyDJUwwDX+eyYMR7SJT6inoag@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVFNNyMtOhd9A2gJG7MWadvzMRxrOlKqsEXJe5vBBSIZnuDuN
	Nxv+uZFX4Cq90nJYJjawjYFYkmQk+VIugM3TFPtuqfcUJWL3G1XG6DIZ
X-Gm-Gg: ASbGncvgfyBqnVQ4m5sGznYd256RaHZebx/sUqhOs/GoqqwTjJhKZPLCwFiDjOu338j
	DxsOKFHaNdUYetV8Rk6Rc31fhcM08nf3grsOAsD+tv8WjqKjKbOhbP30aOROJb7WZumTZZ/n4Az
	fNi9lGsvDv2PJCLrFrqSjK3JyI1sin3sG6m2oZYAbIfEPWhXhx7EXrqzhvDvyMJS/GEYKU8/ncL
	nt1pbC227udR/LK2M4oTYBgz63zHB2fn+j9GA4eIKcIz8EnTozz0Jc5HyYtCO+FEz0W5WmJ1ONe
	1281lOevEOosXvGFtnowtNomlkh4dv7e2se/NI5coaVTR1S3WJlgGPR/k86o
X-Google-Smtp-Source: AGHT+IGDXgBG6y7zW2MpyVdaqKpbTNDnRjbJRi3u91tn+U7IB/Trv1jeMCyTLcrjlDOUe09bWYO7Dw==
X-Received: by 2002:a05:6102:4a95:b0:4e7:596e:ec10 with SMTP id ada2fe7eead31-4e7bba330c4mr800465137.1.1749590426276;
        Tue, 10 Jun 2025 14:20:26 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ce9::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae777a0sm1882453241.11.2025.06.10.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:20:25 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:20:20 -0300
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
Subject: [RFC PATCH v2 3/4] phy: rockchip-pcie: enable all four lanes
Message-ID: <1dd7e551a9f6c7f6e9c3764e61261388d2bedaeb.1749588810.git.geraldogabriel@gmail.com>
References: <cover.1749588810.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749588810.git.geraldogabriel@gmail.com>

Current code enables only Lane 0 because pwr_cnt will be incremented
on first call to the function. Use for-loop to enable all 4 lanes
through GRF register.

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


