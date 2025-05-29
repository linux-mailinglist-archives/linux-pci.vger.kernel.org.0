Return-Path: <linux-pci+bounces-28633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C989AC7DF1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAFEA26E34
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA922B5AC;
	Thu, 29 May 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXoLPF06"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90682225387
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522564; cv=none; b=DrazroQc/CjR4+5bDOrveg1F+gVpuz9tsiU+auVWzVCtk+jaKTfWIud4jtr/Mi66K7+pWLFUwOB1zxSVtXMHJv0h01CldbrZFmEIsgqZVqLZJ7xAotXLBSMZihU0J+892NrDmvsInZ6Mxs1eKBfpJpTTR4kfLcjUs9d+kX4PvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522564; c=relaxed/simple;
	bh=VtQ1ljfmYtyXEA61aEiaZEeKdDz/H5SMisehIOwJ9No=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjeufiI+jhvWqEPn3ggsOehOdH5y4rcnbYcb6iPUg2WtH5uwFE3RkMtSFZp2xb/0oHeRtj2r9Q/oS0WAkgt+ZNSIf8gkl2ilgFcY+rpFRRFNCRWOAW4an/vv0Tj3Z9V/9619H8Cs/eRXOZ0oQIT0EzBgPc32ipe8pK88DjCF3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXoLPF06; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604e299b5b6so3794819a12.0
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748522560; x=1749127360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=IXoLPF06Wtm1mnRmNiZ2E7CTph3qpAYt7GTealiijdfLvygXpdrTf3j3tDZSy4ncJV
         ZPmWXCGat8spdaQNQIaGo28iw6s3YuryGuJVrtdxX9mlaso24PPiXVWjCourLn91X157
         FuAe/c7HV2CAkB/AxNNYyGDl7TUJspRTw34oWtXaceEW5EJfqrj8l6STbcq0mQHH8cub
         BY3H4G84Y8wtnO1qXZdhfeXkp7TCFjUrQtH/LircMTpoI610A4GGz1y9tu5kRzg3y76l
         vX9A/AL87HwNk7R1vmdH1A2NMmwi1t2B00u2N66qGsLOI8cjn0x+ztXknwyLOEuU0EET
         99bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522560; x=1749127360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=KFsw/vJtRRVskYgFsZz2dwLLbCnGNK3cdzomaTUlup2+xttctCiAdKV3YUdmIL6b8z
         GJgo/HmcXn44odE/1/PyG9QkfoTOQzhbZjAORm0gORKoN7CWRFR4nO6ekCDYrb4mG8rV
         zKY8uYVAmox2WOXxCpEX1lGIPhTm232rthZhKsoYEcCsCmZQWSmkHTk3J32nNSbDM1vB
         lHhnTRsPytx70JfXIFYTXa98/TLPLmbXJGTsKWFIxiVrNtgDjwSs5l4RxWIc3zGz7TlR
         QG72gsTqy9V2OXFGWvsYFfO6TMypSweGH4QQrYqwPFr8kCxkCmCRROkh9VgkIe4/WPYS
         ifQA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbmMx7PR85piUU7i/JvVf6hdGP2t0BChGy3tJKzVzowfhWSXQGwIHdthxK4YiltKipAQ3EfOYVn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXjjjk7EN3jpZ3sLpBBGbV35voeNrSTPfc4A0cwhOP+9boGCz
	N8TPQoy/n+6DtEtWiaKo6ZbqFSegTQ3RTvJJUpdgxaC+WUrsFyplh9pSFSalcJpllBk=
X-Gm-Gg: ASbGnctaWzB1tnIHEKagAXhM3paYEOjYhI9CizO73Or3kSrkM5yaXW6hj5RYyQ+0AZ7
	QK79Zo9gn1EXeD/cpulo8iv+epTwjohzAtxhluk54OI1+TdJiVsA7PSeZgYwbbxw5TpTpe4yhm3
	flxL3o4oH2JpiPk6qGdtnXnIhm72AFiBjKJeqa2CHMec4y+8lG/BorSVegtdIkG0TdiAAODLHQq
	RXgm3Pa4T9mCXXVGe8VYMklQM3a3eI6/i5oeDK4stutpGqClY33S3II2tySARoxTtOQtGKnLNXo
	YJo5D2VRBZf7tF0NLIsjquIZAzX3fjGavqviyejLetVt66Xs4EGq86ZrZVRNCWSt4WpfXJ2YFSF
	QJu/FpkDeBPRuXElLk8Y5nynURLqTlh53
X-Google-Smtp-Source: AGHT+IGmBWL+ssQiDerV1S1/XxydSfAjqd0NvxPIChK+RKZPzFhr3ejbEm+LE6gwooRX73fUz2rmnA==
X-Received: by 2002:a17:907:3d88:b0:ad2:27b1:7214 with SMTP id a640c23a62f3a-ad8b0e63c34mr325370166b.17.1748522559741;
        Thu, 29 May 2025 05:42:39 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecebsm138373466b.1.2025.05.29.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:42:39 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v11 08/13] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Thu, 29 May 2025 14:43:57 +0200
Message-ID: <20250529124412.26311-3-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748522349.git.andrea.porta@suse.com>
References: <cover.1748522349.git.andrea.porta@suse.com>
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


