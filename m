Return-Path: <linux-pci+bounces-31117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F70AEE9C5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B2F7ADF22
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F3241671;
	Mon, 30 Jun 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2+PmzzP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0123F41D;
	Mon, 30 Jun 2025 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320560; cv=none; b=Dv5KaZZavPdDEMfipoRKAcuYPlbAWwKCiHkBE9DJn0XqxcFZcZ+tHEiJpG5RRUUrkW/q7bPo7YIPkSnels3nYb54+OAxXphCh9pIDkQ/VBWzrIEt7To/LEu+BSBZl51eRKrnUcDJnKIlrPMstPHegzpgwAwdqQsBmyCAKtHDXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320560; c=relaxed/simple;
	bh=oAZISEWKYtSLKKLeFTIvOInH3R5sB+cLBcS8i1Z7lWU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBAhpVT6jmVO3pBoD1Q+2Vh0rQdoSe93hjStWlkHZbaDDadAPBk/eunl2u3exhuTvBr/1YLVLqeGxLSLIhAunUAs9jYyIMqlA1NjJDmiO46J0IUYM+sgM25AgyseTGm5cNYY17ZSkKTTvmdehxIdMe4gkKWYMy3maSuL4H0wbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2+PmzzP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d098f7bd77so561104785a.0;
        Mon, 30 Jun 2025 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751320558; x=1751925358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXeS77/kGdjI+bypW2RtRvB0CsC580lSSASyDeC37uE=;
        b=C2+PmzzPapJeb7k+C5dmpHs/j6yI1jI1UnBnfEHJhKMVaXhMVJXwxUoQjrTB8pUhTt
         TRCV5PRi7T7rHym5TSlzbci2EqRDgeXLTx7Ivz8wKGoRc3k1BQCmcPealCKGvmpHhzI3
         1iH9WyB4ZGPgd2nnTjptZmoaICMHnUCjZQdoGLxtVoVAUBZY//RKycBZrHKxaVVMqb4d
         zceRpvNMx0ljWujFWlf9KAutdf3C6pJe1lnIhWYLSp5LWDi9vHLNfPGq4BRYpJMqOp8l
         8GapWJSSJ5mTnZ2kXMQJMhDSAHcNeXJfIziimyifI8wRSRCQk8IM8mBN7nwiTfgG+joN
         jgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751320558; x=1751925358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXeS77/kGdjI+bypW2RtRvB0CsC580lSSASyDeC37uE=;
        b=la9RLrL9gqRjaozfjotEYX6Zy+4qitmsws+PpuZOW3esPYdxz8j/tOqg76iWqJ/WvW
         qMu/Z3e0oPtRwyG7MkcXz0FF/HnoKinS8XE3hSHWtGwdJwHn/aarh7ZVWjzeX01jeCIu
         kUsIwcRd4ajUa1+NaNazTny0adQjEkk6+qXG6STYmyFON2/87byOrBVe/AnzWE1uD0eU
         iUjFOJ99IARtq8QBUWjQQO9h54tLBUUjswRfkcntHVcgg1/DNy4RwKJnnAUrnv/bG2js
         sm7YrSATeojaCRDmL20XYbbTIQ5zDSNIo+NmWjqANnyjZmUl59EFutPNjBhQFxYtdUtN
         6oaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0QgWEEVzTBWsM7gJIrRjCMPBh6ASvpG2ofJM9IKf8jqJl5JpZdFAa6hyi2rl0WMEKh7H60ddoHwu@vger.kernel.org, AJvYcCVLIGrVIqUNYPzqHUTwTzayM0RIRA9hhCLV25XY2vLuIOODF4GJ2T9nLrjV/Qlq6xG5cQyk5x7Iiz/Ip0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4I2Ibk7QBDZN5X3XWkAb7WhB/kB4Db3Od2MId1JF/7MAHtzyW
	vgG1CDHF79/mtbs4VOKAxrBUvDbzeiyfqOmgma43fcbYd3M+gLjGPvoj
X-Gm-Gg: ASbGncuiwQbxuwKsjwkLZdI/ccmqtp14RIWxyva5HEZbSq6uQt7CuxmZ9iOUE/A0q+T
	ChlDJVGIbFYLJLfqDZjSJRNBCAQG+I6p63Dyf4ScMV4Ga+qpzXQLdMSedX8SUGFgfb8WDyQ1An9
	r88KXd3ojp82Vwq2cY9zeD/5EBkUS1rio6005SIaC2Jtp+mUchZdityZ6up3V52ZGczoFACDeyz
	4jchRwJ5pA2UUhUa5WDNYLtvDTuvZd7vlb9NEjgBHmUbLRnc5kFn1Ycbed0twbyCHvsA7OUasct
	lTDsvJ3083Gh3LPX+X6Uj5VRWPGS2RLihVfF6Fg=
X-Google-Smtp-Source: AGHT+IGQ/AcloVa3UhaN0HEbry7ak0F/WAQV4L++1fEImPAFM7BWCGo24P62etG1Kv2fRrqUymIgtg==
X-Received: by 2002:a05:620a:4054:b0:7d4:3c38:7da5 with SMTP id af79cd13be357-7d466de06b0mr169684185a.14.1751320557720;
        Mon, 30 Jun 2025 14:55:57 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730ad9asm74574936d6.107.2025.06.30.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:55:57 -0700 (PDT)
From: Valmantas Paliksa <geraldogabriel@gmail.com>
X-Google-Original-From: Valmantas Paliksa <walmis@gmail.com>
Date: Mon, 30 Jun 2025 18:55:50 -0300
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
Subject: [PATCH v9 3/4] phy: rockchip-pcie: Enable all four lanes if required
Message-ID: <16b610aab34e069fd31d9f57260c10df2a968f80.1751320056.git.geraldogabriel@gmail.com>
References: <cover.1751320056.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751320056.git.geraldogabriel@gmail.com>

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


