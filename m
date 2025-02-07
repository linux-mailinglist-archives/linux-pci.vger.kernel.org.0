Return-Path: <linux-pci+bounces-20983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A28A2CFAD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 22:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9611882BB0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073322DF93;
	Fri,  7 Feb 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XkxFHFuK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B222E404
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963873; cv=none; b=BbUveHgoBY4shUM8GdAtg8te6pglzLOO4cJVQm33NzFkwRt8F3dK7JS/G6AVpV1mPYRrDQ62bf3W9cdt3BGE8b1tJLLoTxCr3TEpmJ6Am5l6IO/NkhfzvAp3JZsz10u/PWrdk0BtFRCI6fZ6C4pCni9sx8V0zUnrtemER61Uw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963873; c=relaxed/simple;
	bh=VtQ1ljfmYtyXEA61aEiaZEeKdDz/H5SMisehIOwJ9No=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYWBxkJ1ZJ0waxv2EWOaJPRw/PJZijhydoqAeCT0ogwYKz0zWH/mipmcx/PXqi+gt8jmSY8471FZGFSEq9GWFT7WgE9DyWYZSZi87ToIpfP+rWT3JArcfS+K2+XXuSfNmUWYX4p5Z3YGDMQx2btM8Rh4JTO1Du4piJPTxMSftn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XkxFHFuK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaec111762bso608614066b.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738963868; x=1739568668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=XkxFHFuK/l9LvD5agP4n1Phkw4F9H+705BDsnlnkkZ/uslBVQPQtOxSDJbvlUEHlaU
         6AX5slyctm5J8ss92Qf2Puw427wTeAbihj4rFscP5I13rwsPLuv4iNakQQ0yXoY/Zog2
         PIHkQc/CUCILKbdma5Tfrb62k4qEbFtacTJqGrIlYWULrShf0dxZiMWaWebfGOK1CRsA
         x2SePYs6LyaYxlGm7JlcYGT2Auf/sTMck9amecpWg1t2a9P0FKD3NtGF0Jzv6KH7lzA3
         Qn7mPufNVBBB1ES2zaNgM8PCXFU3IK4yEGEfs7BVNsHVr0iXBiqCoH2G8E6bGidwwt6f
         fwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963868; x=1739568668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=DFb6nhwLUYsVVWlM9nBToUdTaESQlPcI7Fp5Afh6SViYuXWoWdE3+EHMu2pSlId9VM
         c7BjIXhijegpk4sAB1V+gQoE+ulQSQqdKhGr6jPhYtqsgM7Ed+MLVyZ9+lBWXd1hw3xJ
         tKy70n5PWVSt4qig0vDXDMRtk4NsQRGVh6OkZ9XiwsaIs4RTzVEjnCmaxUmmTzFvTrCh
         1HSXLCr8hNRiI4sp5dirdDqLwwfFY8aev02q20JxK6NOcdccvRY9h/rCboqY/WkOew46
         27vxqbvDnRb3Jnz3rEwG5fu7QQDeLaw/B1piUI4aV1bZol7Ql7SmVMZBH7HtTr/35rxf
         xWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3r0g2mLw2PyOyenlXImURjPPQ1OKthEz7AFrYSGroO3pHtJih0urknfzgsmM2U/btHB3Xg+WJD9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7smdRdy6DdX3uvTYwr2niO90OeluSyzlizW/Ok9TR/K4eVdH
	uVb3vOWT+Kpldn+3gLqit7rtrSpRg22u+RCGaXxwAJI+p3KdZJaARW9TvaK/tGA=
X-Gm-Gg: ASbGncuReZVX7KFNiyoQbS/4RrQjENCVqtgHt/NuN0UaernOnGCrptxuyfRulLA+Y48
	cg8u/KgmAgLymyUciJG72KlIyVe+6IUbv3z+jzKLb7+6vqYZu8Hdaw3VKTCDuYHy9lMqTEVUoi5
	rqmB2CPsq6Gb3yw9FHD+xSOedtG0xQ9RIaDANnjYXuUw3h+hg+xYhx+t3fYW7nKNAeY/irQ7PY1
	hIgMaqzEYrPOS5eJJLU/ghOho/pTm7vJ+yjAmrV6mmXozw1xeWsnyVtOQ+jgqruGpahd7tRlp6Q
	UgxLy1puiKvb06WN4a76l9RAkEW0LtWacVCtTJsWjAh7jNBRQMZ096Oso5g=
X-Google-Smtp-Source: AGHT+IFnue8aM5uMyuzX6JhUGUVfjNquFfLUAy682QmcZWe7J/NUbnpi5Rbddmy7cdrZqcN/Fq3qvA==
X-Received: by 2002:a17:906:f5a4:b0:ab7:b08:dab2 with SMTP id a640c23a62f3a-ab789b39591mr578677566b.22.1738963868593;
        Fri, 07 Feb 2025 13:31:08 -0800 (PST)
Received: from localhost (host-79-41-239-37.retail.telecomitalia.it. [79.41.239.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f485dfsm333069866b.28.2025.02.07.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:31:07 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v7 09/11] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Fri,  7 Feb 2025 22:31:49 +0100
Message-ID: <d77f34885b21a1953a5a498d397432ef377bd6e6.1738963156.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1738963156.git.andrea.porta@suse.com>
References: <cover.1738963156.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 found on Raspberry Pi 5 board needs an external crystal at 50MHz.
Add clk_rp1_xosc node to provide that.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index fbc56309660f..1850a575e708 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -16,6 +16,13 @@ chosen: chosen {
 		stdout-path = "serial10:115200n8";
 	};
 
+	clk_rp1_xosc: clock-50000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "rp1-xosc";
+		clock-frequency = <50000000>;
+	};
+
 	/* Will be filled by the bootloader */
 	memory@0 {
 		device_type = "memory";
-- 
2.35.3


