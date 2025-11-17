Return-Path: <linux-pci+bounces-41458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E534C6653D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 17BEE29A81
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE983203B0;
	Mon, 17 Nov 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrLZGxZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC642417D1
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416052; cv=none; b=PaaHCfKahwWG6wcUxR0r7cNIBIjI6M5kQmO3O7tM7mxszSQwOQ8FeO7IZRvSxJRHahOJwJVJFH8rBqGNNHovZOLuy1OeHZpsChhaY898ld2mvpdNvxBdStOF9fwzpj0ul3xI0ucc3AGSYl98pTidBc1FMgoodff/Z/L2JUvpsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416052; c=relaxed/simple;
	bh=02KrjkcVEGcP4+KgwEdLutAwHLpirxYLnBEVXSkC1SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUWH15okqpIJDE+OujWMy0jTCAk8ZeTLyTaL8yWRFERB7p/Mpu4oQhAq1LLQb5r/LpCl55q17+uYeVlLidl1mXzbPLxETy0TlIfb5F+FfS/g7WByc1G5Ahn4f3pwDj0Kj2rbCb4G9jvk/6CUKKb/6rJ3Rhk7aHrgQdECXKMP5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrLZGxZ5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-656b52c0f88so1697998eaf.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416049; x=1764020849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5/Mnk8IlwC7NVL0B0/CURaWGhjHy5jv43K5mCqYKF4=;
        b=KrLZGxZ57y0EfwLM7nhWWZAvoFQl/YP8+pu78/yV3TXSysHdHs2TUhNvpbV1O++qob
         w02s139adKBn6y/Wg87rjt5mg90Oiygrl3QbjGj7usc95quOrOp3dp5OZfWMBMFMnCQ3
         BXM6/wDD7l9dsWb+LABlojtCxQRysb7Npbk+zDq6xugwqIdBpxd46mSc/6PFJjWzjW80
         pnS1orCMmPILd21+ahAcZjQFRhsl/m0+2UU6ArFp0fu297CidJEa3NIh0zixxbGMYLDX
         mlMt5aVdRV/6f2xs1Gn3FL7euIqlAWR76Dcxv7VtDLexCVWwf0r6DME4foNmxUcdqbul
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416049; x=1764020849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5/Mnk8IlwC7NVL0B0/CURaWGhjHy5jv43K5mCqYKF4=;
        b=QNqxooEgLriPwwxChViZapE23tCGV3RqZEYL/lPEDeasHkyxvyotiAdSknrxFQpSoz
         P0Y9LwOMr1VNIwfY7dkI/zCfOyPKokimV0OQviVF3SNYEM3tdmf78lNNqBjG6aqe49eY
         DhGzqm+L6qeAxtVYMtnrfCVNEMhq2xxK71MMj8GzTEf8YbqI9r7nMl9mowoZX2RrJCiO
         ddjgi8+FJHSwHggjkcBCrtRQyCBp7imED25e9eTSLF6iJ+VC68d2C4NfbyhQy1Wle9Ca
         vwCeovVwFtdMeMoRQk84GZq0JAAxYyEuH1z9Nc/4oIzuGqSdALodEiwN+Ciwhtk4FIKP
         ZU4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkga/7xJww0N72IJ2fzmgMlMnHdCPKwtPi7dQ1rZgHiZG9nQ2U5SrU1FcSboZ08sL13yv1hbgLX8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIXy2dvd6TdeJITutD9gXR2i2+GvVDFWsbB0MrTxtA3RY4jYT
	2xq/Gmv0NJk1eSqgfBk/H1eKwXy7vUgiHA64aajJvcJWJT7wJ3BpsqqK
X-Gm-Gg: ASbGncscRu/OYTZqZ6ZSGsbG9O6P5ICl/U3IybhsymC1fnvR3l6DxTrbtAUD8y4Do1s
	1lFN+rqzWBS3d/Xx2xCBCagUiHqKBRpuc5CuB2ECOE9OY7qGVkx+3462Bccjy0VaGqNFO9xMn77
	YGKaV23LiW/ce/mRrqkefqOaW1X2w9reNabLXncb/rBaCcjgh3WFL3+Yk7T15qeVj6CDQw8wU8e
	WvBmXxL6lm6Q/GxolpUHnC3yIIW9FfYnu8Lpj0EqINVVgDGs7NGbmK+aKewh7wsNgX4SCtcbpIK
	ObPEnM/ta9isyH8fMMkCaUEG5Kmsyvern5zqFNCrV32vdU+SrdyzMSDx11KCQRkLHokz7jQUyhA
	T/YlZ+XOHoGaWU41WJK8W57nNx3BNes3n93B3E3BXKKNcvVTZ4u9qwQHaBaSJq0J6dWxKhJIZi9
	s9hMVOqylm
X-Google-Smtp-Source: AGHT+IFbFQICWh2gP02Uz3H7G+3A9sZE2Z07hnxBP+XT6lcLkkYORqspu5DTPztkG3lR2Z2E4DHMXA==
X-Received: by 2002:a05:6870:a711:b0:3ec:64d2:3fd6 with SMTP id 586e51a60fabf-3ec64d2691amr104353fac.41.1763416049047;
        Mon, 17 Nov 2025 13:47:29 -0800 (PST)
Received: from geday ([2804:7f2:800b:a807::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e851ffc62dsm6367892fac.5.2025.11.17.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 13:47:28 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:22 -0300
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
Subject: [PATCH v2 2/4] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <2f2825741e189f5d915560eede6ff7bf827546f4.1763415706.git.geraldogabriel@gmail.com>
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

According to Rockchip sources, there is grave danger in enabling 5.0
GT/s speed for this core. Add a comment documenting that danger and
discouraging end-users from forcing higher speed.

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..0af550277ee5 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -332,6 +332,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		/*
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
+		 *
+		 * Dangerous and may lead to catastrophic failure eventually!
+		 *
 		 */
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status &= ~PCI_EXP_LNKCTL2_TLS;
-- 
2.49.0


