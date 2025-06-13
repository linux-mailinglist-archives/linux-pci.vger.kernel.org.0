Return-Path: <linux-pci+bounces-29762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0DAAD936D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C61E2FF7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB4215179;
	Fri, 13 Jun 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTHzAuY5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE888472;
	Fri, 13 Jun 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834247; cv=none; b=TqMoj1vkEDWyz8PZVvlTahyjl10jzb2AV+31AuPu2cX6yzXZqe0We+MwbU4+1edOodaoXgIg/GDaET3zvL9rqqhWx88T5nBOWlf1dOQ2xsHB+hsX2m9X8G/wauaoIPtatAW4UiDofsIfmx96O5NA3l6bLIiYwdu+Gvc+T855Vww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834247; c=relaxed/simple;
	bh=z1QuJQTs2qeychSUYLbx3MrTtjKfzdWwsIGraIObLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az6oda09aoP7iKzmM3hEYur8HsdnchpQ+wJTCZYJppCe7CvXtmcXLLxTBZkkTyyhcGP9A1+ZfcWpVOnPkr1bdI6xzmbdeLonZvUVrm5VX39oE/2T4FPEHSDl2+JLUtPwz13nQTNtbC8dY13lQpWiHMBhkmsW6qhOhVr707kL46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTHzAuY5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234bfe37cccso31857705ad.0;
        Fri, 13 Jun 2025 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834245; x=1750439045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=BTHzAuY5wjofoUjx7WOSte6Z76LHN8K/fmsd07vjfA0iYXMEV0YFHN3dWbMtzC28Ax
         Y6+VYoloXjbLsms6edHHAjJVbceye4gige9l/Kf2xSTp8Er54DkQ0GMDHnHXfVOmYOdh
         W63C6Ow35X2ThH4TiBfq+n7aBnYu2s7gN4eEZMLKeU0wUQA7ddKITIFUQWGKmS/3KD7k
         0SI9nfE/9Rlzh+A3UjvoqYcOa8wEdZ8dtlxOh8I47nLBQXPXESLVippKGzpWGyR7/VzN
         oVmSAQMovA+wi8Jevb9qWBbE36KW2W6oOCvOVQ0QkMNUv/t53gwlkB2xKtv2MCAYC/VU
         1hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834245; x=1750439045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=ULVbhipoRFs5bKXJm0bvxUrvvODppGHopmNNyALQwYR6Na97AWHdJffl3I4Qg41es/
         5qJTo2gwGw/PsGsUhkjfEdjA8QYnb1QpoCCt5eFUP0A2JXcwbGAuyQFhD2f4buSe4L1g
         AgPCNOiywYVUi9UukEuThIucfvJlGso3YcZlQDYpcPKBY3mt3aQqqpy6iC2dzwfEqW0S
         rEfAEmS0DKhav5kGl5BttdPbNKd6qjr8zIQhjl/elAT+q8Uz4TAO5roeaOTfPLfYvsfn
         X50TfSagTugJw8Vph0QtuYNL4XTURoZ/XSDiBztuNN4JLrkSeSZEoGzhkeMW0HHXIm87
         0brQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqAALiJ0/ZXuApkHqa3xUM+zfpA8NRQi9nrITMfak/RzdDlUYgNgwqA86+TuHPxhOuLOp8/+qzR+S+@vger.kernel.org, AJvYcCXepUMSjAqdVBXgg3kaj3SNXbWJeyJadLlxe8z+Z+3DA8JXWvrJ87KFnPPKb9VJgPJQKLb0rV/eZ9GOOYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos+SidnxXG8xd9iQzyhNJ9je4ub5KscYJf1ZbeC/Xmw4lFkvA
	XS2tA47TY9HFZC5jWAhnnjAE2niZgRg7u4NPpONsRNxqdvnmf/giFpYd
X-Gm-Gg: ASbGnctCWd9xmKO1Zf9f11LGqOv7ztVrtFq1UGigIAR96I9GFIpJww0zkAwyxk8uHg7
	aJi4GLv7omCg+MtXBkRgTIRigk6bPioYms1oAUsYXRY41Z4iecAzJhHaPOxjvu6+EQihXiU2aBU
	6cYUxoc3HOrMsu2c1jJMLA5Qx40fVnA3I4NAGF/LpFm5NdFUcmJr3/UrS7eTIChcxx6lXDmDzJZ
	7HSh1U3Cfw+obuqYcYTa7OrMs2HOg4eODxEDGdxuDzJc5gE1jH1U06uNmLuyKGpMBg+H1PTa84B
	cKO9l3JvilmSg0AE/88XqzHMnqrVVDrOtJ2aQAJVl0Pu0r2JWw==
X-Google-Smtp-Source: AGHT+IEake4Oyk+3VD3p5nQZUX+vQxvPT/Si+3TYxp0PC+ZuZKAfc9NiCG381NhK0913uRvKjkWB7Q==
X-Received: by 2002:a17:902:f90f:b0:234:ed31:fcb4 with SMTP id d9443c01a7336-2366b17b65cmr3388205ad.41.1749834245130;
        Fri, 13 Jun 2025 10:04:05 -0700 (PDT)
Received: from geday ([2804:7f2:800b:8497::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb0484sm16748655ad.142.2025.06.13.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:04:04 -0700 (PDT)
Date: Fri, 13 Jun 2025 14:03:58 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
Message-ID: <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749833986.git.geraldogabriel@gmail.com>

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


