Return-Path: <linux-pci+bounces-29744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DDBAD90C3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACDE188B5C0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E241C84CF;
	Fri, 13 Jun 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imNINOwj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A016F265;
	Fri, 13 Jun 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827183; cv=none; b=A1l0rt9iA7idExxLKnlvyndcCSwtjpZgd3PMJAQKNlLWz6kDYDRE7FYRcCt2/Dxc1O75NfgdZF0KVPHM7jI8AloraCGA47i6oXARr9yv4iA1/VoaYcHIJnwRE1ExOegcGrT/KWvzvQ9MbPQVs49X06kwKI3rGECKkKvzR27cH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827183; c=relaxed/simple;
	bh=z1QuJQTs2qeychSUYLbx3MrTtjKfzdWwsIGraIObLLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYMHZsohvDxLCt794iKfONNxERIJ8vgxzLjOsee+fkK6VqE7pfeEoe/Rsgimw09+IXGROJAv1AGgJpDjndxii5ejfQQOtdpwvS+1b0zkC22mw+SCHhqYtd/oVOOyrgGdR4+c3U978TuQ+C2te39j1E+Z2mIzRaKksB8wg7fVKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imNINOwj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso2523427a91.3;
        Fri, 13 Jun 2025 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827181; x=1750431981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=imNINOwjTZEgX3khIhI0b4CGPIRGartVei50VcTocpluIkHQ164ijxQsdu71T04z7t
         EU42Sj9eijX1EkjJOSIfLeVZhNxaeMyRaT/HhPxd051iN6m6vp9IDm+9UyHd3B0UnwBv
         KTMarPxXkZrGsLHGRSGbJl5j1apAXU14jhzwkzNMG4wxFuVfPYRSrAyrXnuLX1dMEhTG
         3NbqeSmw6mbxopgmAllcodPgNjykE7Fym8ziH946V0X6HSTnEBhB3mlwlBqVtPk9+w2X
         gCFwA/8QWlG/MGE8Yoh0o3iVZW8To6nt/ovQIyDPs1ZiCkFEt2h+85Y5rj7/BSS7MJ9F
         w1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827181; x=1750431981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcgFdGvrxzEgL0jd0jS7Kyu6UO50T4AXfHFozAP4vvw=;
        b=hwl6YDyqCLK5bhAUWVUxgCsozwmM3jHHJ8WKwUgRLsmwzVOMNrrhe8K26WBrbIyZzL
         WicwZ9cyfBSBBZ08kuH54PftxPnXsim1bLRi4iEiIRAqdHTGG7E7hb/2MX6T86UQqD89
         EA9qb+pKqOWfHjyUacSgRmlEi/0Lzd733oFKO6GrcYEcbPs5pYd5TI3zBEKjW1bQ6b+9
         ntnj7QsBP096pJ28Fqrdt088eEE6KfdCY4MlUCTS+nJDpgiI60mzFmH2nw9a6uvZrKV3
         kaglvs/O3YrTjw8CUjxwhIIgzlC9DS1QBLWH4W8Wq5eBGef9XxK1wcLg4QWTf/JGUmqB
         pklw==
X-Forwarded-Encrypted: i=1; AJvYcCVCfGAFw7QIguI9qGjDgssg/tVZGvAMRyr9DvNR6U6pMabVAob7EQY4QJAQs1xaY7VOGdJQA9TnsMU7@vger.kernel.org, AJvYcCXwtBOEPx+QWagj2mmin92iLqxa8feiNQtuDzNuadKSxd3EzRCxtV54wZAtuVCJBoaMTIoOjA59t8bnkdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEw10x5cxiYXCjAXqB585aTJj4ecrcqju4rBBAGBzFU9BYro1E
	kJ48Br4Ai1FEcg1WtVWFhbfWaNdZZQWbMP82v+3u6q84vM/Wm3hxtNAz
X-Gm-Gg: ASbGnctzn5lUgd8j/eoG/WvTTJE8ZOY8EUadHcsDkHgZTyklzP1r0qmkvLmBBXxQihM
	ISVxv0Ty/pgDKYyPdjCTUiVSC0uhOtEXuLtki1w7UL1JIR61R12J7LuLZpJ6Vof6mpqRjhiSa19
	NM4lz6vuWDWizqsJ5lDzE92yPnKI46/g7hrlx8vdUFTqAIdD6IVkRu6oPVrq3Qhxs1G0H5D7qhM
	H/wLpbUCRXFCA3oiPy3SPJ1XVSsLfq+9118fTuTMzV3yl4wcmqQamHOOwjoaZ9NEHhxMxPRtp02
	otsWsmVlSb2xz1EtfHaHt1SHw8eWyVAq5iTm504+l5+LqrI7Bw==
X-Google-Smtp-Source: AGHT+IECaGBjuizwlffuDig1L0laDWaQFszoeJrsrY+zyJrlRqn3sGWZs1z2EMQ8zZxgMRnvK+ky9Q==
X-Received: by 2002:a17:90a:ec88:b0:311:cc4e:516b with SMTP id 98e67ed59e1d1-313f1e4a36bmr31111a91.32.1749827181384;
        Fri, 13 Jun 2025 08:06:21 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaaa15sm15322535ad.173.2025.06.13.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:06:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:06:14 -0300
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
Subject: [RESEND RFC PATCH v4 4/5] phy: rockchip-pcie: Enable all four lanes
Message-ID: <389fc093572f3124244c5f3e87dd084b89be88ba.1749827015.git.geraldogabriel@gmail.com>
References: <cover.1749827015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749827015.git.geraldogabriel@gmail.com>

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


