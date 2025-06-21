Return-Path: <linux-pci+bounces-30284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B6AE26E9
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 03:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF941883ED6
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E021F5E6;
	Sat, 21 Jun 2025 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcswBvEr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965D101EE;
	Sat, 21 Jun 2025 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750470549; cv=none; b=XgvYPrWCNWG/s9QBJ4OqVO0Czrgh8LEoBJ2BDUPUQIAQKfUyLiDzQCry49noKT52SPQszXg9gE5I7+50a8pKz49W1S1V+qE6dIRvwCYNowAlde+v3e5ySWDmco/KIzKWfBtyxpj0uNSzj4lnCWOzO1iloY4B+Z+UYPAoLcm5OzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750470549; c=relaxed/simple;
	bh=ZHiuNjkysUslUmsJxg+pQGZzasofUlWvOElEMSh7s+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV9J0fWYmUWSCM4aTxHdQ9aYHprIX639pX2HuilKCjKlIQa8mGE8UMZGddfZqPw/jQ4vZnzKH9lg8b+fgm2HfLRxXUsmj01JCReo1ZpJ85QqLRnn+IyW3fG/sBK5O/bPzZNLKL6tTPkJkSjK1H/inwsygyWB6yhpHlj+Bux1DbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcswBvEr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b440afa7so25723105ad.0;
        Fri, 20 Jun 2025 18:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750470548; x=1751075348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvjviZOYrIKurfYh7ExfJUlmx0DJYashywHEqMq8QKk=;
        b=lcswBvErmzX73QhbnW0/6nQhvNCbwLN1JcZQS6aqicHPk0YZjHH5wO9zAPJWybKIy8
         N0j/U4ncv/R5Qwk9MHFMrfDkTHdoYivgFS682nUIHc9nryst229QuBqUGduQtW9SfWFL
         0bSizdwO2u5VPZ0Hk4UB4ljFN/geXoF6npMliHzMNstvKivYDSN0RlfFNmW+HZ7NH8Bq
         WwDz/u4N0YAVRt1VHE0lGENy4uq/Gsi52si+bHfQtiUXcKlDVlZGWxf9PAEVrildCFAy
         dGdo/cns9o6ABWCicQ22XIsjdFPZKNNvDYGC6e36btWKSUNsXYdV4KysTlZ6WVFtqC1G
         smDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750470548; x=1751075348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvjviZOYrIKurfYh7ExfJUlmx0DJYashywHEqMq8QKk=;
        b=di30E1OI977qHPkZFD7iZbSnD3OZGJmWi3ld78+hgA0tloNBDYqCGS6mjr7D7sqPEH
         rpj9j8gRunoZhHVQLyY2voz2fyFO+kIb9Xa58XWg04JZBgyHzgPfDBbuhBqC0Vmtvf2W
         vqceQ06Loa1GFVF0kvoFjvSZq26P+/gVlS6UxjDkrE9lqgwJyUhanQ5bbonoVMvDUY7B
         RRnGn1lOKdkmlYPSua5EkQApz5c4tEOAx8cd6nsil6hjiMwMtFEfw1zRamrExI/aJ+fV
         YWxH06GZOOPMCwGdJR7M9Uy3+IEPcj6t9IFO1oFjIOsUQA+MKdLB0zrH3ixbQO6cXo0X
         teNw==
X-Forwarded-Encrypted: i=1; AJvYcCUS8+cEuwxB8xuAaskszPflLwfMCN1oacrx84eCN5dw7FsHS/V/jN1U7fgouAu2I79ctLFvNTEQlY2/fkI=@vger.kernel.org, AJvYcCWh+kZT1S1O6O55BVvNuV13nyL4or7mzHoIO+kMVZszOe/LJljGoACPRm2nzFL9KShVuaxm5UvYjVGy@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2hkEXaLpmlXY/u3jGdxNeYCS99MDQDiV+PUvETvhW83VfGJw
	E9U4Ub+IG95sDxe/w6QsDW4BibXvndU61zRzjJvujqeI4ZO71Dq1zAN4
X-Gm-Gg: ASbGnctCwrnqJB7NhsBvT/LBALoNSxg0D8/ESR+Povg1CU4r/wqnYdeS/8F0IuYJmqu
	v0hm9krPy0D5UpvvjmsT1fT2j7VOiyXoVXd7vIrTjnr4WIrbi03W9I49gBu5QsAitbiY+Ocvfyz
	6h1B8wVR5O9OMneO8NXSiqtMUg9OkEtYdPYSDouoNDN5E7TlRZy7WBGwlUnFkYfpU29vyTq+OIo
	Vlbiw4goiWWtUC3CIOTIeMUW468iuthHqaJ7XKLt51JER9jJZ6VOIQrcHwgVEQrF404BXGDG+q5
	XNaAy7vIK/SrZq8joNiIANUhK3eUu61AqeNgP9C30CLW9VrkXw==
X-Google-Smtp-Source: AGHT+IFUK+7UlH5yN/+V0QdO1GZAV34EYzEeJ0R6CtK3UbXVMrL12gPTfahF9bU36fRJMkeuEcy8rQ==
X-Received: by 2002:a17:903:4b27:b0:236:937e:633a with SMTP id d9443c01a7336-237d94c1854mr72427915ad.0.1750470547692;
        Fri, 20 Jun 2025 18:49:07 -0700 (PDT)
Received: from geday ([2804:7f2:800b:d1c8::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860b496sm28183235ad.91.2025.06.20.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 18:49:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:49:01 -0300
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
Subject: [RFC PATCH v6 4/4] phy: rockchip-pcie: Properly disable TEST_WRITE
 strobe signal
Message-ID: <60ad1985a0de0a6b47044ea9c0acefe6ff865aad.1750470187.git.geraldogabriel@gmail.com>
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

pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
be enabled, a little time waited, and then disabled. Current code clearly
was copy-pasted and never disables the strobe signal. Adjust the define.
While at it, remove PHY_CFG_RD_MASK which has been unused since
64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").

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


