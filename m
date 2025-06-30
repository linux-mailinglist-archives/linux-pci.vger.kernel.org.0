Return-Path: <linux-pci+bounces-31101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D0FAEE6B4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC59F1BC1DAC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A01E570D;
	Mon, 30 Jun 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlfNXbtS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974219994F;
	Mon, 30 Jun 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307731; cv=none; b=Ur6b0bagglpokkulcLSduyuqOEtwfEpt666ZhBz6c2RI2UHOozI0P8pQM3GyN790qiHEO4qY9zUL3GGb1ATGW7v7lmAIbPBH/pSHZSo3ARF5rEyUmsrqoZKrb/l1raWXyFKtEfko/abUZie8xCAyyAOnDf4FAwBaYZMch+7esZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307731; c=relaxed/simple;
	bh=oAZISEWKYtSLKKLeFTIvOInH3R5sB+cLBcS8i1Z7lWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3kGEwxN3jScGrD0PeLuIpr15t8Uubizu/5OTu4oS3uMqyiKqDHDZ6zTlLIbcAnK2QZa3Z5LjM1OeDKFce9o+qART+S43hQuJK8GblDhpL2fAF1CrW6cTLonz1irOEHrASmlYU94ZBiLMO/TLyEHGNgpr8oq3eyIjuYE+F9FHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlfNXbtS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d467a1d9e4so1473885a.0;
        Mon, 30 Jun 2025 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307729; x=1751912529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXeS77/kGdjI+bypW2RtRvB0CsC580lSSASyDeC37uE=;
        b=dlfNXbtS7iEZrQUOS3RcnTm575ikmxZQoaaCXaYwRLat591T5uPRegd9CGPl3jmVWX
         GLA6YPhTf8RQP8p8Hr+TRViO37eamQjB9Vh9sCTTEYdqYEsqI4++XhUnrLEczaPMkrNa
         SCM2eX8eaYN4AM5mSJv9fXpHvPNfNjNr1NE5HzP9NVHAmcJ6pZ4Pt+ZE4Id5QHxjAhDV
         f6bFQDoVrHWy6DE0nzD5sNVlXG8cz2eNuP02X3nVst+NgP991U6RXZZBYwFTFoamRKnA
         cPUdZ8ri6oc/9a3NOU/cLU1T/YIKD8kr2MapTpHbuJFQ4fhYmDNb7PeYRVB7Ouk4Xw+G
         +ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307729; x=1751912529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXeS77/kGdjI+bypW2RtRvB0CsC580lSSASyDeC37uE=;
        b=ZtmrW6yJ/7kg0gxRDxI9Be65go/Gj+1DD2lD7HFm9G0dW2TRjxGLxjCh76nrFLCwYA
         imFj5UVuJSW0BLXf7DqkHWdDfvVbqjmlqI9ywekE0k/V4y9uJ1PnhQZKvFhUaV8pbwdj
         o9iURMT/1ccG1x+bYnAzYz76XtaxIvL0r5uG7KwBmMg07dyD+lY7zLVeXEKx5Njg1o2m
         xBkG125B4cJsZ7KJzOza0IiXd0QZiEomNHV/ahfKUpbC25kb6bAy+aE1Z8gDJ9riiwl6
         SpBhRVu8mAH04aguw457bUbKO0xvEhpwSpxShgPGyzVf1/MVpPkdc31z6hP35PPu2FyY
         8hRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFiZtv4pG1OiGXqYNkutz5BsgVyZDe6Q2w5xQHz2QPWEAZx1/5qzwiVX16UjAhwIq9l4lt+oyTo5zOP50=@vger.kernel.org, AJvYcCX16hP4ktnTpKS5BdprQqfXjWVSUG5G4BcgvVT/coV0Pzw1Au3C8ICQA64Me0Qx3MbbzgNeE4/W1pgl@vger.kernel.org
X-Gm-Message-State: AOJu0YyOK0Hyjmotk8fJfu9oBqZQsFSmi+nsJjpjqWyYws37OdOYDZrR
	spXqpjdjI0BEeVZcfV1WPuzsg+ckgKFjn+UQhqaiiSbJuS/toZau9Fb9
X-Gm-Gg: ASbGnctlada6NkHTAEdw7LySar+DZlRdSvQYYZbrUm/U59Yq0P4uAOHGbSRVVkqjwsY
	cgHYEiaMJCPFZJ37sWkB0FDQIzyGmeC30jPDRRHpgH6BQP3AqUnTYDyHp5LuTzge95QYwzBrMJX
	JH6E3D9Y061EB3za8yfYLKkBwKxn/pB6EKHsisyw8aiwVWwiUjT2aHjn8oL1r7uKijwE3W8mvr3
	uJWtgNHNZp+pjAUQqksDdcUE5ry2Td9/jWVag+HWb1IfoGYS7Gwa1isXjclQoi0MMMQsNDWrjpW
	Q2TFrwfDMzjEmr8UnS9WpIGYrshUAaN4oiF3LVbQ6+FeBNR4uA==
X-Google-Smtp-Source: AGHT+IEnm8oFpdWAiHPxW8hDpcLXgQQ87NpyPWpQOIa8k1ocotGVAZeJxuGqw1MnkmYiEaJ1w2Cfrg==
X-Received: by 2002:a05:620a:290f:b0:7d4:4484:751d with SMTP id af79cd13be357-7d466de3918mr75448485a.18.1751307728715;
        Mon, 30 Jun 2025 11:22:08 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d4431346absm642198185a.23.2025.06.30.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:22:08 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:22:01 -0300
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] phy: rockchip-pcie: Enable all four lanes if required
Message-ID: <d3e7dc38bd287aa93a5d6bba87bf3c428ae92ca4.1751307390.git.geraldogabriel@gmail.com>
References: <cover.1751307390.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751307390.git.geraldogabriel@gmail.com>

Current code enables only Lane 0 because pwr_cnt will be incremented on
first call to the function. Let's reorder the enablement code to enable
all 4 lanes through GRF.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Signed-off-by: Valmantas Paliksa <walmis@gmail.com>
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


