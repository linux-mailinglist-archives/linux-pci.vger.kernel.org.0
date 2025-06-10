Return-Path: <linux-pci+bounces-29361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C2AAD427C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A05189ED77
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3325FA05;
	Tue, 10 Jun 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIgM4AVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5725FA34;
	Tue, 10 Jun 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582362; cv=none; b=Gf2idKJZbvmq756Tb8/j/HggW7y5ASV5CQyE4cpQziRkg/9v5BSOleTxRfcal0u3KG4LQIraxAuuXhtAGkuaKUO8PhptjRvLTI+5KUS7dNJFevFZShfpi+B5jomICl7J1GmaypBB0aqV/g6ihzM+s9qN7ABQw/QuVx1/HUaifHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582362; c=relaxed/simple;
	bh=XIFaf4bEWALQrBBhUMLGiEsl+xvEuzIUbJHmGcT3v04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFFh+zx+rgkT1WwtmKcFSNU7im/BFTi5UrSH2Bk54AmS9EbBu0DRKxkEBu8Tp2qlp0SChVGqupX6UmkeAkDA6IbAJfx9Fpz+PNRFb2nvf9NmAwn+WwNDOT3vMicd187SG316D7XHdI5Pl6MsLZhPSHKuPOS12MDTtaDzqz2RAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIgM4AVl; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so94407241.1;
        Tue, 10 Jun 2025 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582359; x=1750187159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=OIgM4AVlWDiX/oVPSZWt2223vmd5WG4eJdD+2yFhQf9V9A0MYBHWZN+nuC0BAniSQk
         i38xZeqERGJ7rzKqgEcI7wYuk0Uj4WvOzujCkJdcqh2zOcHsU4aXM2iTrXdE2B5OfmOR
         4Jq/1tcvoHdp013sGDUj2vMgsQE2h4aJOhFGUJclBX06N68hRocX6yJ7PiFcazL0YIKb
         51U46kPKeEVUTEzRQiK3KE0DW7Jyv1isc+2cocpl0tn74eB6sE7rhz5zbTawQepBcjo8
         DGM+NOuuSDzySxFCHuifc9C2DnzcR7fX2T94uIy86FRJ2Zx5YfmRPxC+uTgtnZrcaqMB
         YVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582359; x=1750187159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=j4S+7rJHX4qR+pG2b1mRu8tO7dwEAgiaVRk4QpPymqhgSGTRi9FbjgQsK1kab6m+H/
         2zJxHuzynP2wR1jknQt5UGW//Z+t6KhlhC8eB1huCkqk1YZMy/5pwlrLUqPYpeX2kp3V
         MMuERAVbSCMx4Uw4HB8KUuOLZMxqvgnQZtdNYPR0VLzndVRPmbzWsD/1s4UXY6JpiwJ7
         ljpZY9cxd69Ka81RnhChr/s7FkFcB+JnR5BtanSOt63fBq1Qxp6IddrdvfkZVArw3GS4
         n1/U5xKKlW61+tmPrZ3QXnUS6F4Ww3LIJUYS9RgfEUjSFBwqBo0/mQtAaOlq3x/H7pdM
         waKg==
X-Forwarded-Encrypted: i=1; AJvYcCU73HpAtRn1ZSPGPBelWxAjMdndLy5Ug4RZPxAWG5WbhOVuCcdjS+AdxuZTjCImVCGzqohZ2fL/cNp2@vger.kernel.org, AJvYcCUKeSWVMRNi2i2nS5UPucMEZaJHiQJUJ6ise7ysu+JpLOmeOgFcFC7ZJUzOL7RE5HNI8ae16AgP3nOPYDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74R+8oTH2An1FBOCcA7qvgOgImtDupe9rOFpTsKkq9Tq0rZzu
	V9zVD4kDmxRhuxdGJ6iarTQkO61mz+YvDObvIwy89MFtM2F69xYRQ3vn
X-Gm-Gg: ASbGncsiac4jGC/cQNJQo10bVzu93+0EEgjnpY+reulfW9wweeWQ3IYm2XHB6NfSlPl
	sByJqOPQdyeMQ49obUL9L+Xgkxr26sxGjPlG5O5lEnwbFwm17qG+fexni17/gDbXhnBGqxMArl/
	/S2LHEV1WY0LJs/nNhzxWCdD39ptjN5RC3njTQVGRR+YZPvqAQXRd3vT5F5QOgfuV441Q1eR56Q
	DvCNbH41v5NN1Uf1NEt/dQu3fSdOFNpi+lKZSZjpTZvkY0aYIDNOo92G2JsQ3w4ciTRao0jGowT
	pSV5iUM1UspP478PeZpKVozuKvHRTPEX3ZixCQhEti0e132XYA==
X-Google-Smtp-Source: AGHT+IH2IvnJ2xHYlgG47unoTFtLmp+tlD5s81mKKw/vojOHwwvxSAlVW6+jhlxIIXwUuHLnOOd9YQ==
X-Received: by 2002:a05:6122:4598:b0:530:2c65:5bb8 with SMTP id 71dfb90a1353d-53121d524f0mr1060751e0c.1.1749582359532;
        Tue, 10 Jun 2025 12:05:59 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53113bf5a61sm1854439e0c.25.2025.06.10.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:05:59 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:05:53 -0300
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
Subject: [RFC PATCH v3 3/3] arm64: dts: rockchip: drop PCIe 3v3 always-on and
 boot-on
Message-ID: <da144ba62607c87bf89a71ecb12fa5055f1e6fde.1749582046.git.geraldogabriel@gmail.com>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749582046.git.geraldogabriel@gmail.com>

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


