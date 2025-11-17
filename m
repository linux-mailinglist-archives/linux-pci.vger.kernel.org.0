Return-Path: <linux-pci+bounces-41459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E56C66543
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DA807298D9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0C2417D1;
	Mon, 17 Nov 2025 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCQStyD1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E802D47E8
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416073; cv=none; b=K8xWdM5Xef5ka8/Z5PcbycKPAFtBjLAvUWXxiqSKrjgy0g4+7FY8XlabkPg3+2asRWKRfhEIdmv3lubdaDRN/T0WqBh9/7aXazw3/eKX6vqbVUWJto/ub9TvrI4oWBKheUEKRl2fT0045ddM7k6mnJO6wmg+BVhiL78EbYStyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416073; c=relaxed/simple;
	bh=T3dxPbQ2jaoVjzwoPbkSmnChj+7Q9Kt8EGPLYj9Ei+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4vTpftFEPZGwCV5E6Kkr8EwWgC2tvLQ3RT+Ywq5VM4rw3UEAz6dBTFkpSoYjcXOOfya5FAf45kFKO3U7y7LQf4tvMKvDr5rqZezSEXDis34phkexaRndPxeb0erxv6IvxxyVgBGf5s0Y5nrslKqy8UhSlZtXLwjT/UAGHISdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCQStyD1; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c75d0bda4aso1688756a34.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763416071; x=1764020871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FztTc2k5M11TsDtaJ8wrSSkPXnje8lRDmvN72GDsbxs=;
        b=VCQStyD1JBDl6SzsW8TSHGEgKb+bFUaNyA5e7YQ4q293jgZKXnaFa/QXLfUtZhzVMa
         +2sio2PJx5F27ycF17mTTIpX7S+5SPskK2+v6ZUF6a1Y4z/qSBUgDh0xwcAlZwdp5TPg
         kjJj1o+Ax2cqrNZIA5arAXD/q6I/JD3hW3U0l8d2FX4L2/Hpieb0AVCtksGmikIBBm38
         n12mtB93bq2aD7CTWE+y8XVSzznxlE1G0C1jnV2v33D5s+IwymusCKYVZ2vbEov9gcoE
         ZaGW/8p8pPP7WljXgTmAj66/g166oVTGoF+KELTVR1qz2+ZYKAzuj+O7YL03BOdhoJnK
         uegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763416071; x=1764020871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FztTc2k5M11TsDtaJ8wrSSkPXnje8lRDmvN72GDsbxs=;
        b=MaLfcl6oCw9aPClxQ5c018l2mo6hmCNJjPfPWfOT2hUMzNlmF682Nul8aF07BjzxyK
         mJ8z7R1oSHE1DKENu+YnKHWbB5NHH2H6fjbmtvTAH5rxCxxN5D0tfQ5GMmxQ+baWoByP
         JJ72Nc2SbFr563XD4Tx9pZrOHw+LRM09PVycG8K6oxS3mrYXWUcYDH5ASELLlWlD4Hw0
         Cf/Rhsja2ag/bPK7TN/s2ewStYt32pwB7GUW6G3qRNX7ZjIoWOEDBuhj2ej9Ov9LuVCZ
         bYznqWLIIRFJ/J9oA/W1FzI/Tc3Cv3TI7AbALC5ihiPgAqX9NLWYoeNImx8VnNPlKOa1
         iOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+S0O69L5njYLxNCpdtMyhZj1RsQaXJKwO7IRyfqKrShG0LY0P8V9zmOcxy9yHVcYxyUjUd+M0tr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5axWvT1zSIgrQ6BeYaLN0Khd6SUH/uI7WJWkga6XxnuKbE1W
	HJsNcjFMpq5jbSl9OyKQRtpQx3szUDUK5Q05Xsg3+urnSte3zGN1Z+CH
X-Gm-Gg: ASbGncsI0/tvWPPqdKrXx+YzXrudMhbPXJZLo5QHWtRXtE7vQgO+uReksmjMUvyOL8D
	r+AbDs3uNG1Gf0E0n3HfDtZVyNxP7DDjH9x/f+BHLn9B8biOGPJMwzIoH5nt7V++p8MDyM+pQxx
	1fqFa5V7rhSf4UvICFKg4x6Yxn2LbKMaAuZz+CPsaJh/5xDjYtkpa1usiq4nM8Pl/irrVgMQhaT
	2mmgzu2EYnNsdzV8wrYpEJd83Z7Tn5WXE8bFkgGwJfrbOinkZS8N+gDLxEfBbXu9AMG6h2JePTJ
	MJ2RjMLUTdi5i5AX7esPF6Jdta/c1DaIw4U/Aek7Pz4JMlAIWke2W4eRWvX9WQ7+Ap8fjnypKmE
	3LF91zGI7B4BxuLe+NKn53vLo2fJl4LXkI4FtOyncW3SPB4Uvos7L9gP560yrrEM5Nr8AwsbQrQ
	==
X-Google-Smtp-Source: AGHT+IGMYVYdHBolX/z6M9K3TLoZVSU9KkaoXZJ5KYuYSaivd49NkYuXdvP0LyKiiZfq9uKzciAXCQ==
X-Received: by 2002:a05:6808:3a18:b0:44f:6d70:45af with SMTP id 5614622812f47-4509738e814mr6476179b6e.9.1763416071337;
        Mon, 17 Nov 2025 13:47:51 -0800 (PST)
Received: from geday ([2804:7f2:800b:a807::dead:c001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e8522b268fsm6350105fac.18.2025.11.17.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 13:47:50 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:43 -0300
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
Subject: [PATCH v2 3/4] arm64: dts: rockchip: remove dangerous max-link-speed
 from helios64
Message-ID: <43bb639c120f599106fca2deee6c6599b2692c5c.1763415706.git.geraldogabriel@gmail.com>
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

Shawn Lin from Rockchip strongly discourages attempts to use their
RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophic
failures that may happen. Even if the odds are low, drop from last user
of this non-default property for the RK3399 platform, helios64 board
dts.

Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie completion to helios64")
Link: https://lore.kernel.org/all/e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com/
Cc: stable@vger.kernel.org
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
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


