Return-Path: <linux-pci+bounces-28638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDDAC7E06
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3FC7AC307
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FB22DFAB;
	Thu, 29 May 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ERBtpWvS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443D22CBED
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522568; cv=none; b=tjg0Xx3paqG0WKRsmVFapC2xVsn8ywQ3MKQIGjyz2dzMXOSRjG/F4pAUGqvq/GAidd5QUmyLVHSMvC82WK2wwXfIZ/YbmYwCjnEJnZIzTUWxOmiFfKyO61CQaEQyfCs/BKpjzIO8+j8RZYUXYjuRwAOjrRqnY96+h8quF0EP154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522568; c=relaxed/simple;
	bh=RRM404hdZVflbCbuZ7OBxFTgWWaneCmtEfkgg/Xp1Lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQVEjik4ZHpOJvtaE1XIIpvIudAnvbPp0OrJXTi9nKL/PmGvFvk9H0C92QybAYABWPA3u1GKwUgOel7eUrmONaHMZ76C1AD4pHcMeej7fPxbRFNHb+0u1VPk4iuqNHkw5XsRw3Wamww3dj5F7rv2RpYZ3OUP8Sl0df1CzajQ3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ERBtpWvS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d35dso1755716a12.0
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748522564; x=1749127364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=ERBtpWvS8RaK3IDnvbLxoGyt4ZJvpGUlaYT1QyeLhP3NJSw/kcd27AybBz19pQPXPm
         gBxFyO7qANgLs+8cBLhqXKWlYl8RE7jwiWKvWg1bLJRpv4GESZ+fdlm0ycar/chJ1kkS
         xlHL8r/b8D8k12l3zbVn4YaXEISZ2uQ3Ifsbdo5fn2yJmFxrSBiEcIKe9SisQgzm/sf+
         6MXVjvL3BgupsdQt8/aCWUnDiJuMAKD4hWMH/Bqj094ABNbFmmQG3Wbdhd5l39Fsn1fQ
         gC47kEU47CeOWjkRNOdMwRm3RfQqJ+UsJ2HjwhGJoIyU272vLlI8o/TbsBWxDyq2HwX+
         q1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522564; x=1749127364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=K7Brp76oiXwMVVzHhgFf59dl5YzC+avZmf3HhudRkUQIj0/2q7YcUIz61/ZpeFzi5e
         bU16ElqROb9mtR6MN++CG59cFguF2IbbIwPKHB78QPlEjaJiF2/s11sacK04kQtJ96Sx
         orlQm1hTsp9IToAA8IzfHhJvYWPSJj5NGE98qAlAPelkSIj/PNZA+zSrpW0QOGOXaQjw
         1HCYzh5nS18er3zUAtHRc9upq4JdHLtS1pjwSWRt0zb6R7VTo+UbMuM7ti+TyvGMje7k
         o1mwrDg6EJaDZG/eRbj48IPiLBvYcYn272Z8tEPzin4xF3hPlgourvF7DgolpQFkxO5Z
         mhvw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUeRf3zF8Xb/8NMUxP91qAV6L34OLRkAJgSv6JOouYU6ONhgcbH/my9TSu/YtQ0F9iyHlS8rNhdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFe3xGheZy7MEI7fxql/BEL8nB9+sgbHaSBMaCpcy31anobUsy
	rlOYAMHluZDjkSBrxeHOY6ObUZh4Na3W+7yf374dGXSL5NBfCKN0cWNxpnx5X+9byhM=
X-Gm-Gg: ASbGncucnzXZgVqjpJUOSz5DVDHulwUvJ75xDI8NgPlxfMqXvBBvef/uzg33CuW7lvI
	YilK/BVPKCi1BmwT4hZQMX5Ny7MoBI5xYzGWs2ToxwSbLNRzlrP7wxBSP+bI5RbmqgQiLdbzZry
	UKOM9CONjWPTaypI5hB16wbxPx2Qb10hjtNFxeNTisXeyjkrcaDPXZXfDuQUHYoL+rvqrI+uB3o
	AycJkVushAOB0ICys4lYKgiE3HqK410JWqN4rvIK27pXmMjMyLYtrAFcrwYVoa0t504XzPy26Zq
	KAyp5GZKUPoku2fRk6ZgdhFCwWLz81a2q3X6JqeQL1USferlEmi0/BUqeeuiV4gTi+8WonURDMX
	AyTanEWNyEUNn2J8wU3HLDuuqoDUiVEFA
X-Google-Smtp-Source: AGHT+IGU0cArmNGBE3alDxaSeS0c7kho0TQ3gbduZH4lCYtigEniaEd9Y5YqaiqYC9HAzb90Z71eXw==
X-Received: by 2002:a05:6402:510f:b0:604:dcba:dafd with SMTP id 4fb4d7f45d1cf-60536c20f82mr2597026a12.15.1748522563913;
        Thu, 29 May 2025 05:42:43 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d79e940sm2308553a12.67.2025.05.29.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:42:43 -0700 (PDT)
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
Subject: [PATCH v11 12/13] arm64: defconfig: Enable OF_OVERLAY option
Date: Thu, 29 May 2025 14:44:01 +0200
Message-ID: <20250529124412.26311-7-andrea.porta@suse.com>
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

The RP1 driver uses the infrastructure enabled by OF_OVERLAY config
option. Enable that option in defconfig in order to produce a kernel
usable on RaspberryPi5 avoiding to enable it separately.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f6e9bb2a3578..ccf2f50673a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1659,6 +1659,7 @@ CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
 CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
+CONFIG_OF_OVERLAY=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
-- 
2.35.3


