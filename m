Return-Path: <linux-pci+bounces-31032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DBAED129
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790E13AC411
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A43220680;
	Sun, 29 Jun 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4u9sp6b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088E33985;
	Sun, 29 Jun 2025 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751230726; cv=none; b=LFLouDcmKk/q1V3P8yxdUvou66ESt89Vk4UxzhSicrzRqZI8f+KZWifYPz2gCwo07xpCrARMUxMc1k6YRLlykAfsdgtJenN1vyhZAPK3PgQ3uvrrXh7NSLYeV2Xm3QT1YOKdgJ3+kluc0m+7yiu2vMae25KBW0VVMyL38MqD/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751230726; c=relaxed/simple;
	bh=ICTpLVM2M7G18zzAFC+A0bTSgAg31tSJVTdM/HqBFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZLAfuVN0ubBjysYotqRsizrJMZyosRp2aDHFlpBg7v7kNIw5HhTP+34TY6dsFbvfg62G9RKz3FI9ju7SOneBDJH4XDWwzmRbnio0u92qMaXT6qU3prV2VmyXqIrr+Wm3+tz18P+rzIdnbc6/yl+NY/l5DMhYOSr1bXkoED83oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4u9sp6b; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so8988856d6.1;
        Sun, 29 Jun 2025 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751230724; x=1751835524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yie4J6/XsAs1Q8lv5qOjqiXHg7FYWZHizYmDgi4UuNs=;
        b=P4u9sp6bZKHA60nOlmRck8CjvWeIHe8SsPVt49NuhnvrM8KouMam8u49vLs1SKfshx
         PXQcYtJSl5VKJ4tci9vmxWbCMbecq2R/ZSt5ApsD2HChYwiuqQiKFdu8gX0MpuphvUZe
         BuTh6Kysyk14Bdib74lGqQiwYNKF/zV2fudVaQhHRXEEcqaGALptzAQkYcL1+Q47HjIU
         beyv+Pz9KdZwYxv4yWyz+Xc0PB1FqxuFDyUmPRASQ9HHqfND/tymjFiEFnIrVoObcI6Y
         0PMt9+uNL/YmJNfY2h3kFL7iH3fbthq2ZqcBxfXZjru2vRP8SdQQ5VyTDD8ngyIvZnYN
         RexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751230724; x=1751835524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yie4J6/XsAs1Q8lv5qOjqiXHg7FYWZHizYmDgi4UuNs=;
        b=dltEHn0Zi2oCaZZo0/OwfutDS02c3i3kgyZLkAcqHCwgRIR+k6GhSHc5USPs1imRM+
         QNDHA4Sx/3sYQkgdTDpoEShOxpM4y3PMgSknvBnJqTsFryQcTLdfCU5wS+YuGHsn0siZ
         ORVQPpS/KmNy5MASCXLOIIdIwriBKvr2GucSlgRgcLkZijWLLwL3BNODDhvmzpDRioNZ
         5sPb4/8ySWxN59r1hHquwNeoMvjxlz+jdR2xHHwi2J/4LjPVtRo7LZ+aubGC/5cn2Gzc
         DOkbpZzHOox+Nqb0fCDkQyXCtqfVoKpshiD5qxGByay3NcT2TA5CfI8pP3CtdE4IlNKY
         8MYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2oDVQzMASG4YfOAK95Rg6QQYa3v807KuNzpaDhHZY3iA91uVCKHXRVC6hGiAMUKxWwjz0XSuvqoDW@vger.kernel.org, AJvYcCXi7AvYbJglKUvGSAzbUsVZvRg05YQ7zN0ILxJWtjHDJMgqSM5L5+ANYEHs4pGEzzwaOAVHTHAq2+JLXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDjE8fYvFU7w+53J1pF/i7KK5FLlAMnD/hOx2UVfrPS8MAEWE
	qvn/9astsLd0opfi0D69TgiUFC8GonhGdIZ3+pY17qHbPk2Nfe/uXDTYfv6i7Z3q1BCUZQ==
X-Gm-Gg: ASbGnctrXUnN4GRnvDzLVyDXpkz81IpLj94t4yrwv6Lt6lJuq++OFi7BabLZ1wb3zOC
	uDM4rVV3W4UHyfgrfbMFij7B2uy06jiGeN/z0SyvvPoK8Y9StzPKpLPBULzstArsLLq8B723WFh
	z2/1aDESiUmJd3adUWtimmPnt6ntMbNxjnDzNbaOhiM8vUHuJDoFgTjwjFp+aUqmly4nL8+uv6L
	C1Blif0QHytmQn546zdQaxLgchZFiKmFZP0/ifGEO3rn0gt7PKoaiZjnRl66c9lG43R587MftXL
	bkQIkqQCRGf1mhgV12ZYiiPjCFeWegJ7ku5g15J27unZBKy71g==
X-Google-Smtp-Source: AGHT+IHV9zmUEfgqMrmNKPmx2kRTuxTdY/cY3aGuTYatCyaiuxMqaEx69QeCSt7OKPnppAGC83yv0w==
X-Received: by 2002:a05:6214:6201:b0:700:c7ef:ad26 with SMTP id 6a1803df08f44-700c7efaf90mr50674366d6.29.1751230724134;
        Sun, 29 Jun 2025 13:58:44 -0700 (PDT)
Received: from geday ([2804:7f2:800b:24f4::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443231da6sm484599585a.101.2025.06.29.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 13:58:43 -0700 (PDT)
Date: Sun, 29 Jun 2025 17:58:30 -0300
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
Subject: [PATCH v7 3/4] phy: rockchip-pcie: Enable all four lanes if required
Message-ID: <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
References: <cover.1751200382.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751200382.git.geraldogabriel@gmail.com>

Current code enables only Lane 0 because pwr_cnt will be incremented on
first call to the function. Let's reorder the enablement code to enable
all 4 lanes through GRF.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index bd44af36c67a..f22ffb41cdc2 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -160,6 +160,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 
 	guard(mutex)(&rk_phy->pcie_mutex);
 
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->phy_data->pcie_laneoff,
+		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
+				   PHY_LANE_IDLE_MASK,
+				   PHY_LANE_IDLE_A_SHIFT + inst->index));
+
 	if (rk_phy->pwr_cnt++) {
 		return 0;
 	}
@@ -176,12 +182,6 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 				   PHY_CFG_ADDR_MASK,
 				   PHY_CFG_ADDR_SHIFT));
 
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->phy_data->pcie_laneoff,
-		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
-				   PHY_LANE_IDLE_MASK,
-				   PHY_LANE_IDLE_A_SHIFT + inst->index));
-
 	/*
 	 * No documented timeout value for phy operation below,
 	 * so we make it large enough here. And we use loop-break
-- 
2.49.0


