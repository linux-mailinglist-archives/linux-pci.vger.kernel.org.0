Return-Path: <linux-pci+bounces-40080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02EFC2A2E3
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 07:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCEE188B36E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 06:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C01291C33;
	Mon,  3 Nov 2025 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpRKMnas"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B2288C08
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151234; cv=none; b=X5hDU0YeoneQ5gzJRm2bwUYeXpeO00D/nkcMwDwGI0LtlGsOrptEO6KqSmBoX8Hjc77DF7I2wXGXE4VKNNpAfPwN5YZawKvHNilWhQQs6DyHV3eacYqAo46Y7KeEx7Hyq9z8fegZJnDId7uCAtfrfYa9YDMMLyPZR9S7FQCoueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151234; c=relaxed/simple;
	bh=0rL5TGBY7q8nvzECU6bSXlUF+B8hh6WFBDcQ55vZL94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nciyv8rnnSau/L1OnqkunA+rsU3/zY4mDJpCa7L5ad9OCFMEZCitlSlU6ReX2PzmVBWrL4OUc0oRywm8Iqoz4Nu6ac7nyU5ku4vhTizRXLTxzrtV54Zqrg7bMmAw+G58Jhrq3HBbOg12sP7a58JzsHtsh4bgFG8kdgvQuS/HBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpRKMnas; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340e525487eso771617a91.3
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 22:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151232; x=1762756032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGKLj9IuGGzKXJR4eozTFqH7zWJUpUm6z/EiTyDGmsU=;
        b=KpRKMnas6jIAuyHC6odBnJM9Z+950EXimE4fz0tHvQ3Q/ic3XXf4gSgs6xwTjtmjgB
         Yrp/RCZjLJGkqZb+/E9uTJIa/H98YWEVmYVvT9J2i44hvEKnHras6BSwhLo2dzcw2JL2
         MH4bG54zWpEIoLZZVj3ZuHtqcv05Znr/P0yRfK2LhaGrXMeeNWOJ4GbGh4mouIKW8Jz1
         Htig0HLHLeXM8xtxmee0eG4ESrh4J9WdD7bS5fTMTbEseJTKLPF2OUSYtYi/PXZSsief
         3QvjffRSg92ZodtGCEkvilbxQKyA+XL9D7OK8XcKJWGJm7cvToqgBQtLrA570cY3HGxI
         dZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151232; x=1762756032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGKLj9IuGGzKXJR4eozTFqH7zWJUpUm6z/EiTyDGmsU=;
        b=QWxkYRWwguV6PJ5EfoeXlPGB5YQl7PUTYktDwMPYOJScir0tgncRpAFp+KAwLbj3JT
         IneLnFsVnOqATBiaNEtB3vJQoF9mvU6Xupj/D07MAD9hNFgJ2X5cVUnVMiNOO+/CQYlR
         faNQfWNv5clj2BAb7l4NpE2oXX5QAXeNCKeNjBDmPaL25VTbqOOS+RVgd+m5SgWGgcnT
         8H6VTKosUIv8LP02RuazhvNxQG1w5hGVbnlVccYtbEt+rklmOTD5ZEtXNu+MWQbgCBj3
         DG9zewwn1DxcZLCpUuabCQ5CiKOw6F+9Z1RKdRZUucTiS2DEKJI9t4YceC5HV+DXiVMa
         nZHg==
X-Forwarded-Encrypted: i=1; AJvYcCU95HNg9yEcJvqu3xTN7X6e+o6N9nt6ub2kVkwcQXt3W3naCzci3ixTGDlHJCzt8XIGWpjSe46QAws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIWtX8xpBRc1mPHhPXvq6XkNep2+H/k3XzHVTsYy6nyRKi7pC
	s0b+NYHrwL1S3KLwZDWlipWHeDqI7cAbn+SYH4aaRSFFOv+Ieu+0cYmd
X-Gm-Gg: ASbGncv54F0PN4U0pj/EkaMggAIi+McN7vLpoLIEaYIZV3vOUovhYfazLC/YqeHIcOM
	61jOrVQReJvaGKdK5eZF6kULQUSVn5EYLXis7E/mFcJvZ12mfIYFsF7aW1osvyNCO1nw9fVP8lM
	Akiv1eJM5VooMg2fubTSSdSyC8ncv7DW2TNZGAsqekLtEZXc18CguGS7YMmikYaLDjoGCLFT4e+
	ZlH7kareZaagko5lSqg0CyGP6HLfBp0Ekx4YcU9ra/DJqR55rwbpbkMCU+IiqDxnnJHgtatYU0L
	JXYqTSh+Dg7aP1AmQHROfAaD8BTvUMc9ki1C1yxrha/9iRWVyFkLVV4ZF4m1/l3ekk6PkZ6CrVQ
	qOwb9tPl+RLP6OFiXHpW/vyqbGbJMlJsadu0I/sTvt7nHI8YYrZGS50umbIPxDNQpcVmlEHWGNw
	==
X-Google-Smtp-Source: AGHT+IEEHJ5cKAo4s66Rvzv1t4feR0vnrItpNEwvY8alRc3/7dD6RTg/7i7hmvK6LD5XGWQ6H0YDoA==
X-Received: by 2002:a17:902:ce8c:b0:295:9d7f:9294 with SMTP id d9443c01a7336-2959d7f9455mr43290485ad.21.1762151232219;
        Sun, 02 Nov 2025 22:27:12 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef4c592sm4512294a91.1.2025.11.02.22.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:27:11 -0800 (PST)
Date: Mon, 3 Nov 2025 03:27:05 -0300
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
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [RFC PATCH 1/2] arm64: dts: rockchip: drop PCIe 3v3 always-on/boot-on
Message-ID: <1c1cb7f94cf41142c55561ce8f2a2579021d4818.1762150971.git.geraldogabriel@gmail.com>
References: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762150971.git.geraldogabriel@gmail.com>

Example commit of needed dropping of regulator always-on/boot-on
declarations to make sure quirky devices known to not be working on
RK3399 are able to enumerate on the PCI bus.

One example only, tested on my ROCK PI N10 board, to avoid patch-bomb

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index aa70776e898a..ad99a8558bf0 100644
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


