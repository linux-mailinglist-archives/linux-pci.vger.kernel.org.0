Return-Path: <linux-pci+bounces-41457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D2C6654F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEECE4EC206
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D52417D1;
	Mon, 17 Nov 2025 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yldp17kx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4E2FFFAE
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416037; cv=none; b=WDeejjZc5XpPvrjLkkfcbMVwRW6AEXB6Nwi9zuhwjGwLpFJ7pa61fFJNxoa3KoQtfvWGKEPJ//mPkfhX7uhfjpWJUjj9YNrfErtf65vkADKntm3siffz8+9j/EcPjHN7QkiKPUCKaj9UmLODDmlKA9Oxc2tEf7/wEbNZGvFKgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416037; c=relaxed/simple;
	bh=rEEQFx4zgxN0BT5dnIQoDnQ/Vyz8VB9bqZUOn4U6KIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWVcEyo0rAF5/kZAqP1pxV9igezTPZWWj5Yq+5rDHc0XdC7LNBAdm3CvO/ZWIhFH7ykCca+NprSTWlXPjfwYavYsNvjhZFS2ujX2rIGBb6oZ0pZUT+oLks4bCPE5usuRno/qH3dMddSNiP8XQuGkySUE5OmvVn2/Xj2bqrzfxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yldp17kx; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45034dbaaabso2099240b6e.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416034; x=1764020834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLE4Tj3ESr9ube8E0SxlookVVEHtTNDbpqvD6AIIcXk=;
        b=Yldp17kxOXENtiHOMPg54sBBh71vVWgrneO+gBkTvUbZ382fkOq7UlL2DKWJbsj2XI
         DqZDKYmf3xi0CxYS9+1RAGQbKzXr8ZqNkxSyF9IDfgkNbICtibaEp5S+YVoqW3XHcgkZ
         WMosEigYAFq5FHFFeZIXQdTRVc7JQ/iE8DsSFKx/maahSnICce+0c+XCDx2KIrvrk+X2
         uZu1oGeUjfl7YM/X+aaQQpE79l1T3Rrkw/QgKgiaOEjwmtK351hRZo6MS697dDRMw74s
         +iLEMdatCh4oUPoDpRSAbO47ZZJPBql86VkMIiJBWfvaXEDySKog71UbDFshlYixYWDS
         mgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416034; x=1764020834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLE4Tj3ESr9ube8E0SxlookVVEHtTNDbpqvD6AIIcXk=;
        b=gjaShroeHQs+fpjUb308eZnFq85E4NcZ7jB/9HCIGdVFXLsbqVX3Fy5e2PlJ/ML5CE
         e8okkSkFbw9OUP8BU/pYcakCQ3PPOmRTQEVVvQWIWbfA+17FFrlqCJ1tOmwDvWW21JYU
         T8366wZc+mtl7FmNiLrWLkJbsqu3+oWK6+Iq7i95ERzWz9lYjBJdH4R7LgEh+mcL3T17
         bD52vbJjHM9TiYPBWiZj1ZSDlZNYxGZugGF3trOB6pEd8vrHI2yaCa+dk2wXh/ttoixL
         HhxA3fDtr45qs18KWV74vYMwNkzWFtsoSKqj3u8oZjSqt4X3MWZEIOCJPyjbUBWFO7IQ
         nXAw==
X-Forwarded-Encrypted: i=1; AJvYcCXmhkzE1P1PNm8a1xnvbIXfZlFXS3TJ+svtFK70TE6nQ96jPuRDWh6CDGes++eydk8s2oHvUhn6WBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykGk5CCfLSO2oMlFEmuHDNIn5RTzZQD9NB7LQ+kyOEczEiXAq
	NXICohgeUSG6jUDnZ/4eSEnuuyfCU9iypj60/j8ss0OL/bjoIWnGCRUj
X-Gm-Gg: ASbGncva0Jw8QjWwWK7uOkqDxFYTdnuZ3gRBcwpUeqS7CQLT8QTN1O8VGA405WqAWLM
	QPZn3tIjMUbVLGC7TY0Vlj93UiARTprK4YzrOtFsj6LbsjMjo8r2r2NNy85fPTFz1LEQ1u0fnon
	n47TuKGfI90Fl8TwGr+pzEaseFHYYskixFmUMAYolXhOdO7f2iLTCYZFhlkLeIoIu5QaQq3pull
	2J/LzIDCEJTMo7bIJN/3Et6ePJ/UTDayL4jnG7H4bD8FpsAr8ujfJXlPOPytCAnPvom+t0xpxiH
	ZzJ/7jBYf4B7LX8yIxows+vOQ9R26OTv7cgS7Oef7yPWOXJI1/ex3FQZcAKg/MW3X4PgxIDZerc
	VV3VUALJuaYnH7Ak3e1R1D4WmkMjIF8COdpCFvUHKP9yizZvoQfg5LsqvfVCg7A7Z8b4O2iaS03
	p0VB56euXY
X-Google-Smtp-Source: AGHT+IFArlQ2cA5dLvmMgTWWlBYjPL1Kt7bZiu5SvNfPraKVrXfO2Bo2fAnkStrr+f9d2tNIoobFUg==
X-Received: by 2002:a05:6808:470b:b0:438:1c76:d40 with SMTP id 5614622812f47-450973e9467mr6858397b6e.4.1763416034208;
        Mon, 17 Nov 2025 13:47:14 -0800 (PST)
Received: from geday ([2804:7f2:800b:a807::dead:c001])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724cfa332sm4779211eaf.7.2025.11.17.13.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 13:47:12 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent
 damage
Message-ID: <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
References: <cover.1763415705.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763415705.git.geraldogabriel@gmail.com>

Shawn Lin from Rockchip has reiterated that there may be danger in using
their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT change
from the default and drive at 2.5 GT/s only, even if the DT
max-link-speed property is invalid or inexistent.

This change is corroborated by RK3399 official datasheet [1], which
says maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0f88da378805..992ccf4b139e 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,14 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen > 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
+	}
+	else if (rockchip->link_gen == 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "5.0 GT/s is dangerous, set to 2.5 GT/s\n");
+	}
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
-- 
2.49.0


