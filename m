Return-Path: <linux-pci+bounces-29051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B635CACF4BD
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2553AC793
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460021FCFEF;
	Thu,  5 Jun 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLzfAC5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00F274FFE;
	Thu,  5 Jun 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142256; cv=none; b=e+HRpa3S+yq6XyKEsQicdjbz1N/yUyRquueTRp4FBqwsYK1IqxhkRF7YrfVmKlYY9iC+86crCuhwKyegN6sFLyuyuUARwjMSHx5psb1dte+53yZ78/fqk0L9UTZ3fwLwF7sFz8sWV92Iqx5OP5/j+ARk8/QPIl8vOlwBW4EYIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142256; c=relaxed/simple;
	bh=XIFaf4bEWALQrBBhUMLGiEsl+xvEuzIUbJHmGcT3v04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WdWN+P8vYEvvNBnTEVvHWJS0RFkUHWYBgl7wc5DPZ4TSuKY5NwhQTu/Duo38/4CWPAOqgiQC+yStEcbiG3CJ8lpwFHqH/fAeRKkcCe/c9+naQfRJiwM5LrMKpv0AYsHk5I3RulqsXorGwpmr98m41r8Sk1QGhqESfuhcR66PZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLzfAC5q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso1515213b3a.0;
        Thu, 05 Jun 2025 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142254; x=1749747054; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=ZLzfAC5q0IhhVmYaqs3bEG8FPIU43omk7OC9MZ7YN4mhnOXMQUT8yE+ZrBpw0U8BNP
         ErPh9TpvhKjIuS60XVgDawyUKt/i+YCwfZ5muOI2QAHA/mUJ96jd+qEa7JoSM6P+fuzR
         v0NjrgSo/vE+h+pCj26LrizLPii0kpVoD4SFZdSOsSWZHD1qCjH4aB3MoFEXgPe01jeB
         yGQMimDLJ1BkNenZGlNY/QpFuVy2M7U359Wtkf3/wrg7aSgtpYDQA5w8n449UpvSViOt
         DnqdvIXcMeQlMgwTBvsk0Pw9/y7nSPrb/bDRiLbyJXawH1ol1fohPjYE0VlIs/DGSg9b
         wAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142254; x=1749747054;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr1AjOf8uNWev/Vso1mJTfg4siB3r6WSL8vizNNJAl0=;
        b=dYeLKZVzeagyvH2CxqF54kZ/US8Dfvy1fVnWRmSjnm6Dkuk0WfAgnivvbxXoJf56UA
         PzLr4fgoICcL5I7f5VToryrCrC85uv4bFsxYgvygrAlVUaEROUGXLPVCWJpmqpWKLGk0
         0JaEqgbXyLGYGr7EsbB5G7/FiIbMD0a6AmBGG1pILmDvI0r8No3WKMRha4FLYZBD0BDL
         axRoUxb6FMjpyUHj+Y4bctrZ25BBTz0LiFrKTHk+x33LSu9dhsmmaoUE+U9P4FAopZUU
         SCPC07z6Uzh+8LR8Xt8JxU2OATSpdmZYwVpJ4RtazyXCXZlrpBJtPG02kcG25zJ8SIRt
         HT+w==
X-Forwarded-Encrypted: i=1; AJvYcCUsWvYdeWm+cJ4AgBmy3WF0HESOLFJN8Vv+Od2dhPFFYZgnjGCQZwoA/YWXbCsBvAHqLi20pCZ1hwdLlYY=@vger.kernel.org, AJvYcCWugIHAS01BSedz1ukNJSwClzJ13FqS49nhmdIGb962YKmIGJ9mx0GTO5rjDFftDjXmvENezQQMINEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOK+R0C8Hi45dSEAwezjSL+mIb6mVvHcdkEltf1+U0zu+ryf4
	bpGTZ/ehLKArzUCMUs0muDQiqzTcAyNiu8eFwxFWLJfBSatKRakYJrgN
X-Gm-Gg: ASbGncuSKJmmdH+IPWM2dTZ5Xx3oakUxhxbbZNBplKhy6pK2AhXIOoKtF61mhvalldV
	Bq4L5rpV8wAlk+WrkCuEvNVeLaKGqbh81P0xUyIq+KAXQFufbAhbNEpvvDVdUX1UXrIb/50vkqg
	LIwKMLD9LNEn4JwcFD0a0af75VJ2kkzSnEW/wplLKA1b24liF6jWUb+g2Gfz/OnfOsESrp2fEva
	vGj7sBei2Ms8tLNDO3RPcKVTa34B7DqNwEj7Hy4s3fZXAtorByLEKO2Ze4TrIW4Jm2Gz33zc7w4
	4oxoBs9k7TIAPCTdXeTfKAh9Wl/2fKalDcR1VHc=
X-Google-Smtp-Source: AGHT+IF2YLBAw2b9nyArKYI1W0OrOBCWggspyFjLKv1f0P5D1GAck9jyxFdfQ/L9pHNfflmpDzKqAg==
X-Received: by 2002:a05:6a00:1956:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74827f09cd8mr531718b3a.15.1749142254029;
        Thu, 05 Jun 2025 09:50:54 -0700 (PDT)
Received: from geday ([2804:7f2:800b:110a::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96825sm13061717b3a.36.2025.06.05.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:50:53 -0700 (PDT)
Date: Thu, 5 Jun 2025 13:50:47 -0300
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
Subject: [RESEND RFC PATCH 2/2] arm64: dts: rockchip: drop PCIe 3v3 always-on
 and boot-on
Message-ID: <aEHK5zQbjQuCR1ui@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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


