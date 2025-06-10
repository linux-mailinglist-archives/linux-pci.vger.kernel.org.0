Return-Path: <linux-pci+bounces-29348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8043AD3F27
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44643A9C88
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7D2397B0;
	Tue, 10 Jun 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo0l9itf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EE24167E;
	Tue, 10 Jun 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573457; cv=none; b=PRBiG/ToEy+ovkV3SoV02Z6uVWpeV34VBixGrgmdW4iihU30+5F7w2S6yLfj0hfcHY7kFKPKLqv6PMFtYzRkHr4mRlLxxv0Hg7mILN8Pu9xA6sZEJhNuTjhN6Vq1TGoSdAFIee8dCfZnRqRpSPKxqrso6nfDZ1zvAslcGFr1ySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573457; c=relaxed/simple;
	bh=XIFaf4bEWALQrBBhUMLGiEsl+xvEuzIUbJHmGcT3v04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h836r40mercZtCjPBN3UTtq+0supog1VyYvb2grYr8l3EKrtMEQ0PKllo47DX0vGNMKf99+GKXhr/ZmrY3Bc/+OGj9xQ8ZFfvOYZdFI6+0oK24gK7QC4RXq8N5TFIoOl6PjOqWnehAmUD6EL4bNX8XuwmFBphScNEDuj4reaXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo0l9itf; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so6601241.1;
        Tue, 10 Jun 2025 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573455; x=1750178255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=Mo0l9itfV98uU2sBBVAcPkPd8n8anRlhpwcJLIT7rKWdq4BA15vL9uQBs4lfOk3p/W
         oyVh6+PzQsggJhoW8QQPfUhc3XTUj+MCbQFNmdqWGUAB3XijTSzLT9FOrlYs59VOK0B3
         lxpdlUgZkK9uVDv66ZVlU8gDzlYb8Acv+UjbH/Y94lGp2rc8UiNnJOADl3mcdi/xNmad
         WRUpYMtNb/jcJQN3Km8qg3sYPfKq/vM18cJViRlOZMj+izoXNMQiAaElxck42SRNkIsa
         R8kPx0zWGr3wEEr1uVAHarRFRN2sPtd8YA+XaRhcnsX52RyI9cajUmkFk8d9luBhtUhT
         Y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573455; x=1750178255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=lHxYfz0s5bV6e3drEJpuoih21A+pkUEek/T+or9ozkkyXbkck5N7vuYEbwsgYLb1eR
         AvMN+i1rqQZ9kZXJNMNEKYa3gqHvwWzbMKcfAv9xInpqx1zhR5s6s4G5kCX/RKqv+RZX
         eNXJzRpXhD0BUw38WngZmghI3okjuFpZKMYyFmPlpeRCv+F1pxFadYYMHfrmihmantEk
         vJYLlwv5l78DYAqnvDKtFdJ6rscRfjcpnkoQGmsLpj4IflFCeRGMh7lZegYzS9qp8Syk
         EQqmsECPsPGxHS1d64wUSIvhoc6Xpst8O4SVDsMYM/vBba0mcW5xSwy9BsnxRMHdc8jh
         xpbA==
X-Forwarded-Encrypted: i=1; AJvYcCULO+jV2ihRNDzpYRYTVo277NG6toN4QD0giA6UwEnCaC1yMMOdrn6Nohh/zV2tVM+fDEnJh/XkyZrL@vger.kernel.org, AJvYcCXQxXvPBLGg13kejpDeztDfB1l4Q5SOCErhQYjTymKeoQvDHB5EQWwTKR/JU1L3C9bUzGPj/wM1mKeUDS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5bmwvk3QENajNy3SzFPP14bQKsAQZ1Ra1S+Nb6qrEV6/5Xlx9
	vGj+Z9k8BQX/is3B6e3SuunNi9AN0RLbXm64nz3ha2f22zebNQ7jfjDK
X-Gm-Gg: ASbGncsbzqAtmjCfp17Vy9ot3GFlA/AdrU1Ct7W6ytvxLZCKd+TILTHdUY7MkCe3KtL
	DQiXZsilpgq0k3fI6WWxiZbenLLqLSzyseULtRJMcge/uhgfDUdu6XRmXBFSuYTTo08ngvznbZI
	k/zKKybDF3ynuUtLAIot2j078cP1tmCxuOsZlt1jKYx4MLH9xImy5Ix1La/sO7tm8Yr4xRjrvxc
	5xT+3HDZ/zkTcHKHCbxOULbr/EFYAu7gdz0z+Z3Od0EIr4nnuV7DinNJguSItSDzbJk4+ii7H0C
	2Kwwo9ZtJ47SOvAF455Lbw4/OKD/71Qa29h4BONxb5RrwbpIWA==
X-Google-Smtp-Source: AGHT+IE8Big/lftsM2jqr/dJ0fUdU/HQyEnl6k3nT8QeUNCa9mrBUfckol12Cv9K8cvwwPN75N28vA==
X-Received: by 2002:ac5:c5db:0:b0:531:188b:c1a0 with SMTP id 71dfb90a1353d-53121e4f7bbmr94264e0c.4.1749573455100;
        Tue, 10 Jun 2025 09:37:35 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113c0ee03sm1594059e0c.39.2025.06.10.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:37:34 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:37:29 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] arm64: dts: rockchip: drop PCIe 3v3 always-on and
 boot-on
Message-ID: <28fb85b76b3adba86995b187036f3eff8a68e10e.1749572238.git.geraldogabriel@gmail.com>
References: <cover.1749572238.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749572238.git.geraldogabriel@gmail.com>

Example commit of needed dropping of regulator always-on/boot-on
declarations to make sure quirky devices known to not be working
on RK3399 are able to enumerate on second try without
assertion/deassertion of PERST# in-band PCIe reset signal.

One example only, to avoid patch-bomb.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 8ce7cee92af0..d31fd3d34cda 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -25,8 +25,6 @@ vcc3v3_pcie: regulator-vcc-pcie {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_pwr>;
 		regulator-name = "vcc3v3_pcie";
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-- 
2.49.0


