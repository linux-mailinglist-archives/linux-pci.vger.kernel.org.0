Return-Path: <linux-pci+bounces-30283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B0AE26E8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 03:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B331884A48
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484B78F4E;
	Sat, 21 Jun 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULR5Oqg8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0342AAF;
	Sat, 21 Jun 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750470533; cv=none; b=MQ6nk6ljIP0E+ZFSxKYNa8+Hho/3Bx4BTFR+sWI+t0FiJZL1YtICfBPJrQU6rD7OuFFXvGXYS573aCQZpG4lpkyIIXiamMl/JBDmHF8bRWPTZu/8Qa0Qhan7edEeiCboD/MgguBjgBXPneKOqE4FCWgJhLMhWjP198w1LncD8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750470533; c=relaxed/simple;
	bh=ICTpLVM2M7G18zzAFC+A0bTSgAg31tSJVTdM/HqBFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdv9pPwifTZYXWC7nihPhT9oyglIo8OvbulI4UydwyUSI+oG566kLVu4WtJLZoix1LM3hVnTxnCxXZY5D479GgeWyH+8IHnVw7EEChBoU1sUUVzCjcCq6AY19rm5Y9PisXoxvK9n1VIWO+htM6LbSNB8GGX32qCpgQN4VQXt4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULR5Oqg8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748ece799bdso1661307b3a.1;
        Fri, 20 Jun 2025 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750470531; x=1751075331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yie4J6/XsAs1Q8lv5qOjqiXHg7FYWZHizYmDgi4UuNs=;
        b=ULR5Oqg8VvOjerzNnZmbEfmB0NwjRDF9OIvklPPGVMuF4jez7mTqOIP/v4RH8VLrnb
         nEAc7Ht1vhfKn/PwUiHPyIBbtVhy6VKggvBwGgExZ2qSXNTdAQhrvYsJ79AAhmghZihc
         7hYYyAhJcr7b3915yzvar3AUkmB+nxVgAqUKKPFK0hpOU6BEo2YHbQSIwLRmJdWoziIQ
         gYMw6WHQd8lFud7Vd0SGAgjJW6ru4VnnPy73oBnrZn5hEhQ58shbiGeQcHbDIwvOD1lg
         n40sFc5+aoxsd7wMY1c//Fw9EgpDNDUIwTeNidPY+MVn9YsuzLWLNzWqnW2yAPd8npkE
         ZImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750470531; x=1751075331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yie4J6/XsAs1Q8lv5qOjqiXHg7FYWZHizYmDgi4UuNs=;
        b=oSsU3c6nKh9tgjoIbgAxnqSN9SkaKD1eS53GPc2pqSPQXBrd7RuAiX6PNuovzKO9L7
         +YO9v2AWmv6TMqMxNK8b+/qwCrXY1iq7gcUVcqrfcFzVMUNPRsEu3zR+nwYWraUAuBXN
         OGUgbvoGk1q4YadRaaHscZLQpiIDgOGU+AITYzjiolQ/Y/K8dcD21gj6GW6abjYYsyo8
         f6LqOfqp7b7m2riwDqC4dNRylQEBW1YYBukFLteIyhCLV4x1RGbKswpGlTPCU2HM3WPI
         0LmzEPG+cZlyAxjf9qZ8DKggYELabBJb0zeo4Jp/EBPVqArAyJNlUG4DMwOXYwLt2yip
         wDcw==
X-Forwarded-Encrypted: i=1; AJvYcCVYSCrgT/FmlU4A7o9nZzWD4E+Mw71+1oQaNu1TcXA77fUQT7Uuwj9WN3X3yqDaC5+SoUwFIzWylAj1/iM=@vger.kernel.org, AJvYcCXosiv297lCzrkDF8ykZLbGGnpOYR2uSLhfm8k34VYjnKm4/BAjUU8s4K0CAFc5Tk0yJy3j9fOpFm/G@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqGmM1nXL/MmudnAXSoxMPiCEjTNalqRb5oU7/ZyIDKpm5fn4
	Ou9kZnwYL+NGNM/vm3sR3UBLaA1mWfHtAcfepm46PqW5l4e7qcLpTxYNzoRunzbi
X-Gm-Gg: ASbGnctehAFcMNWcfK8DL0MQ+s/tqXdFE7ZluJzkPbodthS863Bn3l5Bp8DtmrsBmne
	6YU/keRJQH9CAT0OWnNxqZgQzSdh5vh8uEyRDJ3S6SDeUIG8PV+t2rDOcH0UtsolyyaJ9DSt3xK
	aupWyu+2OKDQg5xy4P32lLlIsW4LYAdOAax2XIsGmtX96xu/W+XKOS0UrDHff0wMV6wqckfZbUe
	M1BSMJCUSdXou28jGyst7sHCeh0Q7j6bwQeWQiF5qb9CBOxZt9oJOQw0ldmJSvwX+ScItrxkwox
	QG+L1U7boRWz2O9gR3F3a9mp1S73+K2EAHz35NgRx9xJ889J9A==
X-Google-Smtp-Source: AGHT+IE6jUjT6swykmz/FymvMeohJed+3m7NKFOTEFnfs7/VIrYSlH3zczi5Z7eYucTtW8YKTwW8BQ==
X-Received: by 2002:a17:903:2302:b0:235:7c6:ebbf with SMTP id d9443c01a7336-237d9967be8mr83535185ad.35.1750470531451;
        Fri, 20 Jun 2025 18:48:51 -0700 (PDT)
Received: from geday ([2804:7f2:800b:d1c8::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a24c3f0sm5236869a91.22.2025.06.20.18.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 18:48:51 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:48:45 -0300
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
Subject: [RFC PATCH v6 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
Message-ID: <b203b067e369411b029039f96cfeae300874b4c7.1750470187.git.geraldogabriel@gmail.com>
References: <cover.1750470187.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750470187.git.geraldogabriel@gmail.com>

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


