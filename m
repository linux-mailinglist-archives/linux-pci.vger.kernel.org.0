Return-Path: <linux-pci+bounces-29733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5502AD902D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AF4168701
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303AB1EC018;
	Fri, 13 Jun 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XR7sNpaF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02818EFD1;
	Fri, 13 Jun 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826328; cv=none; b=rqsJ7QeDiGVgrgDn45xcNwFkvxtDyKBsr85DQAKXLMX8LIbywDUr+46gOdSt2exH7TWnDReOYYO5cZXBfQ7GHQbnvN6iqTlpjs3/MPGosRwzhpBGvSkwgvJJYkuN7vl1e9R8vjVZoBGmjBCLWYZaKA5JBPCyGnoVNXvWkkwE9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826328; c=relaxed/simple;
	bh=z1QuJQTs2qeychSUYLbx3MrTtjKfzdWwsIGraIObLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSbPwmOoekhxDGpEzxlEFljsmUy35MbPfZ0K74I5l4oKbu6DXXuleqaS09CanLLy9LaIFpfO5MKNtY0pr3r+XSaCqmeqNA1BPEouwuT4BBD604CPAqdrmDFYGLtFgB5N7W4C9r+oaVqIvMe52pBtdUexWbyyfyHnH+XgJsVjqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XR7sNpaF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234bfe37cccso29593545ad.0;
        Fri, 13 Jun 2025 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826326; x=1750431126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=XR7sNpaFKzra+SCJF3yO6PYkT7tp45e4uzsPTkO7Ilk/Q77jrgU6OkRvsU/N1bRPPx
         vX6UwjsWCL1RXwDvqrsZ5A9/TJSQgl6kLR+ZFwsckuss8xhMhRk82v9Dj7hIHM5Eltyt
         tHZ16RdOGBxUdBAmjIx0P0yQ4QWa9MFDlpusB2sx0ZatNMIM0Hxq7c2kd4WXsrDPrpEy
         0SumaAEnl0LsSFeR/oZ969zHzcONBS+wOumTCq1CqXVVnhtnng4rIYkvSimN31/TU4al
         WJChW6OtHtnJNL3mw43D2gbufwh2GZx61Q7g6qDP8+1Spjo54epGusght7d3W/T/PEum
         lAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826326; x=1750431126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=D/YN9ARWahln4scEEcYDjQh14/bf5xu7uE67hT+SQDPyXHJaGgJQTEPlEcx2g1TQic
         xYf0BEQh5l8Zni+5NnMzImWeGCzSUsbejAvl+tF4iEHLBcAG8+E+Qe/t+D7sob2COybZ
         ITp5/jXLlGKByn/lk872O9O9v+KiWszEYTWNIpLz5Cxbwn8xoCHfV20tdeDKSsrkc4Ic
         L/gHSA+zImfgYIBHYfZP0VbcjQ+f90tNCOKznjfbpmNzlXAbbzAlxtyeMkXP9xX9iSLg
         fKK6ea2DhN5w447IuYU4vxDv7/eq7M/s+ZzYQ9LcGNYv9lLEuVHTlurMPCjgPnw75ZlR
         PQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zQk7AC56nK6UzJY9ON9khjOTF1s0bia83TwbWrZc3SUyBISfE2nSI/z0xRXvcTMtDnyZHtn7rNKH3Is=@vger.kernel.org, AJvYcCXTuSXlW5GVAkDUEztifm583jE3A45vLCPuXD7Yhl9BNXP/cRHAiSWX1NbL7oObrEUEnO18qz5CqP4a@vger.kernel.org
X-Gm-Message-State: AOJu0YzXm5QyQbciOYQB3ATszoRut5JfXAdrnos9v/iR06KdQ3H6yoIL
	xTr13kQ3Ui8Mr6Sg0CKFZDAl99O0KEmu1zd7rMQZVsINcQYPevJoHAe7
X-Gm-Gg: ASbGnct9WngnhvuAl71PBqa/6IFIUjH5Mg4F4zY44Z85ZLw+Jc6hZJNUdWJTT2x2YqZ
	BEiz0+2mwPBVOjdeJr4NYy31RsXzt9odxeC7/uY5qm4HmDJqPu7AAWC3laQFeFSSQ/36BrVHBTS
	dwHjD5pNeWvbA8kQkMGnVF82+nE82TLBs/IBiH54Sxjsfbcx3z7wWjZIoedmtYwz4+T63aTAJ2H
	xCo8+tbP9vrgXK2h5bSUW1LJHgCpoHizYAPILajCBG+wudhkSvjXnWsOWjdsuxO78of4cQ8ezPr
	lPfS7NdK0E+PEnreCwOvk0R15NCuO/Bh0DIfF80P92e6k+DMzg==
X-Google-Smtp-Source: AGHT+IH7fy+LrWUfYtwwK54dBPztMC4iel6TPI8DKfwXPH+wMki9Lp+koipKaCXmkiQ0YY3ZvpTDQg==
X-Received: by 2002:a17:903:2305:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-2365da06422mr50885305ad.25.1749826325896;
        Fri, 13 Jun 2025 07:52:05 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb8a73sm15173415ad.185.2025.06.13.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:52:05 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:51:59 -0300
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
Subject: [RFC PATCH v4 4/5] phy: rockchip-pcie: Enable all four lanes
Message-ID: <389fc093572f3124244c5f3e87dd084b89be88ba.1749826250.git.geraldogabriel@gmail.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749826250.git.geraldogabriel@gmail.com>

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


