Return-Path: <linux-pci+bounces-40430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435BC37FFD
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35CB44F8787
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBE2C11D1;
	Wed,  5 Nov 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9e+3DCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE52E1730
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377735; cv=none; b=SO7Ud4XECzmlps4Qz0Q/hH3tXObFhQANhOwO6Z52Mk1x8cjeCVRu4eN2EZjI2RcKu2Gzwp5dyjWEvj9WHAlP+YHq05SE/bqVuZEpoRSVlxDUr5W2YXy6R+O7SjipzZBfVNyKKJBvfiHyc6y7a19qaYOtOO1IfWTcoBtLRL5HsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377735; c=relaxed/simple;
	bh=Lafdol5XjqXTtVc0qIPRZEgOnZ0fzaAxiat2QX2gQzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLsPkl2U5/nBxMjbBN34rt7N2lPAJCLj40Wtcdywn5u8H/FujkI3GtZNozJ99Q/YZCJKyBiNOHq66jNXjtbu7/Rb0WT+9Np68xtr2dG6KstSiwz8Z5QBOsV06g7h0ASdrYAIbj4BMPIMS+DluhPJHQOc4ktl7ptiW3YlwYCEmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9e+3DCJ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3c9c379af8aso252696fac.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377733; x=1762982533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/FBmebtO0Vkrgh/mrFAUBv/BWvq5VVY9yGcMnDDP8s=;
        b=E9e+3DCJ0j5sfxz499Vg7oEXRwgD6fQAAyNuumlwkbVIkJk6WLW4evKbElH+pG+Z9x
         OTsXGP1EVRQKemKgVfTCOla+zxG/thdtf1Rh1rqxRgMyqRlrew6tr2oOFHM+o3CDik5+
         rk+sc2XcwQ4YapCE7NC9ZcbR347xZHaSMijpxotGPvid3RZwgqvyx44djkMHOTP7TXA/
         YZNMiUBmxSwDvupSrRxnFGwSvrhj7bc1KUKah7ZIW+rEGLhaH1ZsaixodVu/3eNZOznA
         phq4xuWAbpzIH+Ac+HBvFubaj2BXYYAystNgPfYd8YU9muNWgzo3a5dGfx/ptDWM70o3
         Y8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377733; x=1762982533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/FBmebtO0Vkrgh/mrFAUBv/BWvq5VVY9yGcMnDDP8s=;
        b=UKnYoZu6lxkuOf/TCUwcMJARziNaDptsXLC4KGnx2YiPxkv3kEYcbL7L0XB2p3bulO
         oj5iHY7QrH0RBs5MVCTFPD2cyR+7vRIOU/b8V+YJWAhubtMzSdEx0M4aG8r/wBqbIg5L
         U/QR+umWzOgia98E1678tre3PDdB5TZdL/FMbJjRJCSynVAnQt2j8epnw49UauApeVuO
         kFivL7h0tMYh5rNWZ3i8kJz1v1AL0gTOLPDjD+yO9qlSwt9SnERioQxZhKVzG4n8++uz
         yiIX4LB6aRu2LmAoHONnwahoArar4VDh61lbWT0AwhZeRUAB1b+O3uRlpBo0ofKKvqoL
         uqJw==
X-Forwarded-Encrypted: i=1; AJvYcCXM2G3ZXZDHjH3VacdKnCoyGUfC+Yy9PcchNeQtOdzyTOAP/GB00M4RzgQ6jDfNAcpCNLUb6ASxjxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLBaUwlwBI3Qj0CILg55/vyRirYPgMb9zKAX0+Shqx6fyzYlq
	8lcCqCjTEWNQWa4bEzdOt1NbsK8UQ6iKLK3VxzMwBWlTaiqC0XfC8woe
X-Gm-Gg: ASbGnctKz6t1v2LZHoFNXuDNB0PKNu4lGof4fyYwzhvRc72EfM3mDQG+mdXZYwmUxjW
	xGybDuRXVfl5ImSsBprpHXdVfRdcd1o9/wMah5RVfa/njqJ/4HRSroNaCAcX5msQHx8PNOqwkTb
	sfaieD7KDg2UXqaYDg35b2NrA2yTWCZaZwxv8pMgiprB+ct2x5Jbq3B/vxuEfSL3j7ZNkkUZ2ol
	u6AQU9YuHbSIMrXRLMmD/RvCFDRzKUJ2NCfWmNW00O4tFAM8aISAaygSJCWLk2GzN7obWLmGx/j
	Zvj4wlgMOmq002eoUjZfBD6UVPmvAD9cQswg0He5xu8Edi2E/I+Jcc+pXJselCJIC8VEgUJunsw
	q+OjxY0mS87UTW9IJXOhpye2uC9S8T9uk4nVJwlMiyN89+30DYuRxM2iwLp+lMNC9/iYlwuxs88
	iHQF8t0QzC
X-Google-Smtp-Source: AGHT+IH6bmLILBlZkClZJKGGVOQMJ8uDofSrhNGHs3xLSaav5plph/1k0YKtCJFMX/UFHGhYB7B7Sg==
X-Received: by 2002:a05:6870:1484:b0:3d2:e6a7:e938 with SMTP id 586e51a60fabf-3e2e3d8c98amr572130fac.15.1762377732693;
        Wed, 05 Nov 2025 13:22:12 -0800 (PST)
Received: from geday ([2804:7f2:800b:2ebb::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e30847fe83sm153392fac.6.2025.11.05.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:22:12 -0800 (PST)
Date: Wed, 5 Nov 2025 18:22:00 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <aQu_-JDy7qqeviUm@geday>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas>
 <aQrKtFT0ldc70gKj@geday>
 <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com>

On Wed, Nov 05, 2025 at 10:06:53AM +0100, Diederik de Haas wrote:
> I have a Samsung PM981 (without the 'a') and AFAICT it works fine.
> I had noticed that the PERST# (pinctrl) was missing, but 'ep-gpios'
> was/is new to me and I hadn't had time to research that properly yet.
> Good to see you already found it yourself :-)
> 
> Cheers,
>   Diederik

Hello Diederik,

Thanks for the heads up!

Would you mind testing the following DT change to make sure your PM981
continues to work fine?

Thank you,
Geraldo Nascimento

---

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..b3d19dce539f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -383,7 +383,7 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_SINGLE_ENDED)>;
 	num-lanes = <4>;
 	pinctrl-0 = <&pcie_clkreqnb_cpm>;
 	pinctrl-names = "default";

