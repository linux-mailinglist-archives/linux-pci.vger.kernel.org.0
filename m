Return-Path: <linux-pci+bounces-31102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C06AEE6B6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9478E3BE930
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFD28CF5D;
	Mon, 30 Jun 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFrMObeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3E1C8631;
	Mon, 30 Jun 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307746; cv=none; b=WUC/h+vyYb5s208SdKivZEPQ8XLYFRNekI63OtVxflFChjqSgM4nIkpFXlvrPQomHP4ifVPH4dGoNPwDCkqaOjwLvvhwu1sQnYn6iHe85+pzPbakctdTpTHaZnneqly38c2v7CpLo39iqwB6XqdywQeUgj9sAlJMzegnFadh4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307746; c=relaxed/simple;
	bh=CNxK0279ukfbz74d9Orf//2RsynVo3ZY3ta36YHi0ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad2YfdfTXlrHGDK7pih/4w76LTX0luC7w4PAukgew2gG//6+pcjRS3Sx5XJtsRttVMZf704rhT70GT2+W/U+7RYZs0jaS4B3BTSG9OdUJ+9FlYcdFjJoERu8JpBDmAVDKVpjgsEiCZAQMIL96edl+401BF8i7lNCXxk3FwlHY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFrMObeK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad3400ea3so43584496d6.0;
        Mon, 30 Jun 2025 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307744; x=1751912544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=IFrMObeKHEOahR/xRmcWFg2dH1j+o7EVj9V2mFrqswyS35GNkkQtXYZENywKbvLviN
         13qYjHsO++JaZm3R6KTgQ0H8X6Svq+TFssyWt2+KMqwdYKgwCFSIgRw7xaAyrQImIDU1
         OxX4WEtpZdL2Obq3pVm10s6hgwkCgNLGU8xHgvO3GPbhTMpQvaP4vtPYmBY9MzAICjmT
         VCgJZxgx6JP+oEXOf4cPGwhuQ/p9pbVwOzdyhopoa/t3AB5mPl0LvrznpVpO7/WrBCVi
         PUEdx17K7W9TVG+NyeIWQ37nvDNtnJkNzQ0091O47Z8a6X+gXGdeZv/1UuysMmqTdOOU
         +xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307744; x=1751912544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMkTHKD3jio2hpq8BtE0DToF1CwksemxWLN6Z8dMYEk=;
        b=GvOf/1OreHzgrVxOx61TDTsoOryxh5bHtjTGVc7Tnz1oSM/4m+hzSjz7g2W//njjFp
         v/h4T3g7k4heNwrNpNFnr/7PxYLdWOXLYV7r3x+a9ZQqKAx1QfOCCn6NpaeaNJi9tOqX
         JcGnW0wT/UjW9wE/YOeVFfwbwtElF8cr90KFnm5DOVz+ai5wG19CmC4R85vXVJn+0E08
         HKa1erXk04mXcypgKkkypcQ7LBJbsvzzUklYg9Wi0VWld77Y92ywIsXeJ3s0Q7yBnACP
         h5KR5JnmLrevYTO28MY/U1w039ZLkiWzeXzbQciQpFZ2PKMuYtY7noFgOMIzf6FU/AqY
         tcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QjsN8P0Aam+uXDPJFxlKeItHP6ZOGM2FVve/fhqeRqstb360gtRUE2/CxXVa92yfd1z8EDnrzi3g@vger.kernel.org, AJvYcCVuKsZk45KZuXhEYxPkK7ZDY6zVj4wvZR9MJM+X5pOSwOPlikEQ9vbEyH9zX8DoJt9TBuVjwaAdFUzqsXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtnrxMdCgaM8kwT5hRqBnUUaQatD9BP4zwEPDB6hJcUFn6h3/
	2RHh9QuDS1sAzPGN2voQRq+Fm12qCjZOVuLBItq12Rm+SqHDxvIjz+SD
X-Gm-Gg: ASbGncudOiyorxG21v8h+teIMN384DpGmPt6pJWYGVNL/3t61k1wz9rYsZV1/0KgXo4
	w6kIHN9WOF0XSzphuiJC++TcR0CYpb5yU7bcckThWcVP1xm64oYdGwBQK96QdpNZH5cvAJmt1wS
	Bi2BHO0LQoa5iaYMuasf4F5fWE4GyjaTQu8uAYkiQ8oCuQbmfkQPbvgApolkAkjVOsrqbviZA1I
	L4K+UT28jQCU+AElG232GUtKFCZU4uyi9a4LMW7JV1z5nZfGVTrrAxFEpcXiy4Lb200RlMCXnxV
	rArSy5rLwqzXT0HwBBrpHrdRvzuiCUaRm/IQnqxDQS/DyuQ17CM3r6+caOLp
X-Google-Smtp-Source: AGHT+IGiwj5LxtClCIDG815VfHCCgo1NQzaiahcgS1gasNLfX8v0zIb2JwxXV6ze0QIzIZrdOwwtAQ==
X-Received: by 2002:a05:6214:468b:b0:6fc:ff41:8eb7 with SMTP id 6a1803df08f44-700035b783bmr287653906d6.31.1751307744228;
        Mon, 30 Jun 2025 11:22:24 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771bc01bsm70953466d6.40.2025.06.30.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:22:23 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:22:17 -0300
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
Subject: [PATCH v8 4/4] phy: rockchip-pcie: Properly disable TEST_WRITE
 strobe signal
Message-ID: <ec6557ed50171594de5297d46dd5e2c96c2459a4.1751307390.git.geraldogabriel@gmail.com>
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

pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
be enabled, a little time waited, and then disabled. Current code clearly
was copy-pasted and never disables the strobe signal. Adjust the define.
While at it, remove PHY_CFG_RD_MASK which has been unused since
64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index f22ffb41cdc2..4e2dfd01adf2 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -30,9 +30,8 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.49.0


