Return-Path: <linux-pci+bounces-41289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8FC60233
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D225359DD1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309726E17F;
	Sat, 15 Nov 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+lsSIQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047725F98B
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197867; cv=none; b=dYSgEIJQqoTYF9SpyPGm9duF3DwBdrgN/JzPk4fF/+vF6i/l9hCjqWSh8Fg5cLUhy0K8VQucujtq9faLatilc9wXtO+yWRxmG10Yb4yV0URndvingFEbow4i0g25HBrpxi87bKCLXB4wdrXoPKoSeUGbpqiDr5LVPGLEPNs8JDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197867; c=relaxed/simple;
	bh=dlBNths3bjgJwIY82AdXxJk7nz28NGpPfCGP2ldQ+VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QojtH7otc5Quh1mDEvuxauAlvwpmC+ZQvFlWB8HRy+WAXRvEHobShyXVnnFF3Oc/cF3OTlTHsYCZeEHLJcuSDy3z7qI9wx+cMXEnFKX9L8ZRK8tuD25wuMxhvMr55pVMLv0nG9kZxSGNyLxdzEKo3T2bGU3KagdYp3peqLQziF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+lsSIQW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29812589890so35379985ad.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763197866; x=1763802666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq3fPnKASXQtpwph9wF/EfbRc92D/a+itaxLGojV4Lk=;
        b=Y+lsSIQWDzq5XlgkkHNYVdyUuDP91J2mTrc0+vCdVkzBwMD7g93NYl7tNzDeb7sdWp
         O94182UO9hA3u+wFfS3adetQo7KcWd5uIpzhE36nABBISP+j69Er6PMw1PJuXKde+Lrt
         JvcM6UjBHaY4iQwT2pYcpprzBswu38a2lAkUVubS8yMq+Onu2iHIK/bpB7KLFQ7U4YvQ
         7tmwJ6ay0WID1V7yNu9cFosYZfyIuTw71Kog0oGe9wdVkBgVw21faprYYjA2gQKFxlye
         d6MKk/dNOhD2Xw07D+ptcPIt6DP6gdHrhXBaE9+gzHVmaN/LI3I0pZOzjQnaw5qqUWIg
         FEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763197866; x=1763802666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq3fPnKASXQtpwph9wF/EfbRc92D/a+itaxLGojV4Lk=;
        b=NCOpHGaU2FesKVZmJKJu9RfJIREUujx4pQ80y8xy7d6gvAbkutvfRvHHMV632XUdKT
         YMwMas1uvwg7krQA1KnHyz4kD3gf7Jd4Jgl32a/DLTdO8FMxuuUbISKoXouqT2anwPqk
         ES6kdMAZJXZrCB4TvTUHbTvyaGJx4BfVYKPrsNrLf69hDpQvXT/hwweMGlyw4JGqsWPY
         5YEcguVFcTAw8GAAtiXqdxdvDxWr7AWbQ8aO6Mce2aZQDyTpXEPiUKnS8Gb0mQRNPnwg
         JIrKhycbNsdUA0NlDUFUNlV6ES3ApXseUwBktyTqBBUjAWsdfeMUZzm925xX+0LkD95v
         wLNw==
X-Forwarded-Encrypted: i=1; AJvYcCV7wKDMwxNbQpQ7Q+SjA1fxoJIc8KB7S0q8atufBSZANTsPGnmm135hgAi+cedEBeD49AhNJN0CqZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxowo3AAlNjxA2NgCimki4mLwV1nNyR0HdI4qQQHefWt2ZW5Kuo
	T0kVSwdsd5sqOy/gFOsxyCay5DPhWU49aaNSunX3Q2Y/eLLO7XVfYbKs
X-Gm-Gg: ASbGncuQo3VuTItDGvgCjT5V3Qbg9HNgQltDtK33EyMEc3SVjiXNFVQXh0WLaFNKwUE
	8cw+8dpeQFNT32B+28P8V9wAwHIIoNB5Ra4llojbyxkLWZomU/tsLenJrWlbxtctdnC7lEHjqUE
	BKLzBkqjByYA/EeDF8C7scyTl1iBnQcftor6Pmifc0Kwbdjw4kl93ezDQAZZFPEjW2Uk5grWY9D
	GME5FUj2+tDEWedVoZKm6Ju+n7sIXuQvoGo3aH5AKQr2TPsarkvq37pDuUrNQaE69D7+p++iRCH
	1LpbxeiUeIbd0NXS8U2YCqGGs6VQXZT6SepQTCLI8/6AMtApB+3jUOEooqcpfIPFO8sSdcypbMT
	Xjd9IQijmbFXQ7LjnyuW6PIYFDgRDUa23c8WYdoStqlqJ9HtT5ughPCA5KeQqrv8eCFR4udoMBz
	6cB/N9gI6p
X-Google-Smtp-Source: AGHT+IH9/crdAL/odtABr+5A97CdQPw4u3wDAvn6Sjfb7QYJpDPxj2xNfdzG8PUpaUTw8aHQvHD0Zg==
X-Received: by 2002:a05:7022:69a5:b0:11a:26dc:eb61 with SMTP id a92af1059eb24-11b40e7b696mr2640354c88.7.1763197865521;
        Sat, 15 Nov 2025 01:11:05 -0800 (PST)
Received: from geday ([2804:7f2:800b:a07a::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d695821sm22799663eec.0.2025.11.15.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:11:04 -0800 (PST)
Date: Sat, 15 Nov 2025 06:10:58 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: drop max-link-speed = <2> in
 helios64 PCIe
Message-ID: <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763197368.git.geraldogabriel@gmail.com>

Shawn Lin from Rockchip strongly discourages attempts to use their
RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophic
failures that may happen. Even if the odds are low, drop from last user
of this property for the RK3399 platform, helios64.

Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie completion to helios64")
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index e7d4a2f9a95e..78a7775c3b22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -424,7 +424,6 @@ &pcie_phy {
 
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
-	max-link-speed = <2>;
 	num-lanes = <2>;
 	pinctrl-names = "default";
 	status = "okay";
-- 
2.49.0


