Return-Path: <linux-pci+bounces-28594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75BAC7C34
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A007AC824
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3D28FFD4;
	Thu, 29 May 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aptyvc0j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0828F941
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515697; cv=none; b=mC6XatrviFGjhPi/zcjHdt2ED4lqM7andkVNK3pv5ASakV/ZeqVMXDUYan6VCZ/aE2x7kAJVmpqLcquBV5Ms28PbWl2j5gglXVYsdU1hQCvik45ecSlZm6UTTR3pjIqIofE6LRWz0sV00Y90Im6trtF6dt63SkenPKMeCczmv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515697; c=relaxed/simple;
	bh=RRM404hdZVflbCbuZ7OBxFTgWWaneCmtEfkgg/Xp1Lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYSWm/s1Excc+PIFf3yTFmWKc6Xm+NLKlCLvul5FFtx9tojpN4HO2ZMbkFw2tPI/7DsUfkrF74c0UkOiT37VFTra42pydJSgmoOCrXEF/P53zgzCxljd7ROygVgWxplreLW6hRBBlTmkF/fVB5wvq2fb9+yf0sFd8sMY3usdxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aptyvc0j; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604e745b6fbso1435226a12.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748515693; x=1749120493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=aptyvc0jIAKCaTd0t/ly60+cWkgqGHqrIKbdEvjAedG2fLvKmcpPc9NsmTXEODizKJ
         GePKiTPjZL+XT9KxUqxZQGXM0+K/44/hIWB/HSlt3RoSOlhp1AWfz4gWVbXOGnxisDr4
         yP6/nl57zjLZaEJ4O+Diz+460Dt7rmEHI+M3FAPF6vy7095lnCEIXXTJdJ1q+cf5dGz1
         yJZ0rOl8dOSpdMaU7jPZ4Vq0q4bA9hbqeHBGw/2H29LJqUH/5bZNiBhKISNXbFHsEPPY
         UQ2lTHq6Ya3J87ByzJmsKP2cUaN7grgMiDYetBSCd0xcyjEEQs+EdHBmNPcUSY21DI63
         peFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515693; x=1749120493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=gUgtGM/tSGks8a+hDwMXVyuGd7EypXn3gecAnmjHFK5ZcF+9n3qOKldn3L2y0nAPKA
         p853XRWri08R6EAlDyD+dwJX/4mNJbxdpilnuXaPhFXxCjzKrNDNzYO1ULKOOvkkSUsi
         qCe9DSr5dosWy/Rm1PWuBUKY0iNwf7Ag+S7ZV3Znmg2mqygjgNxaSyWeVo/egUfkxnKM
         CQ0k2nbV4lQ5PwYgezH7m45dwKiSre+fboDf/UJWuUcxL2GbaSYtoVPV/g57nP2fhL1Y
         r3DmW4ea0bh5WxZqKJHq70QyxTJ5eja+5SsrwpwthbBcrc+SP//BS5iWn0CWURGVQxoT
         SR1w==
X-Forwarded-Encrypted: i=1; AJvYcCXa9hprkJUjRl5ui7LDN62zbdyqbsEJztwOvKJhYkcAnm6RUzXGjI1N6kX1mU5fK0rXMBGHKlEefTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuh0lyV9y5Qlxg78q+SYZTSQMwadI0zdw4Bjix3BJX5N7WvDLE
	3fsmNi4fzBtxaMZKi90k8JVUUPCYbXRVQ29/DOenHYeaLrpJkpcLKoCphxEZU43zGGU=
X-Gm-Gg: ASbGncvXoBjdNxgEVgdtdN7lIx3ZZAZiHwW5uowjKh6zzSBU0z0ktpvO4EYeDS7tDAe
	ghDols3BVf2YkIoJxpcUbgkGkKCYnIA9vxWRl587iPBsZ3BLulaIVTjvawGJZVdhYIbr1U0fnQv
	dkYa36CyTBxdcdAUm3cgFOFpjCY6Gcpw2whgZMaWp56BJbAzAC0l6q2QqmQEo8LxHKZoDtYNJZZ
	SiT6kESc049f0DjBXX02n2yMGvIcrIoQTekTfgZnBXuFexM+rgSK4zNm73NjaUxtipQOwuP4jKS
	uTAt/OrpwejQ1vbxefhRTUA7rwvQ5a77V6gdbnWjFVN2qmbbo5pKgvpy1JsFbChARGbiB+0JB6w
	t+b5sGayNFyWVWWJpLqYCFg==
X-Google-Smtp-Source: AGHT+IGcndJR5WSb66PATrzUwaAKdyGw+iAxbtsrtdyFNRYpJH+6sC62/Ji0kCEJoq4+a4yiL897iA==
X-Received: by 2002:a17:907:2d28:b0:ad8:8835:f794 with SMTP id a640c23a62f3a-ad8a1f31b97mr453973866b.32.1748515692908;
        Thu, 29 May 2025 03:48:12 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de76sm121072866b.65.2025.05.29.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:48:12 -0700 (PDT)
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
Subject: [PATCH v10 12/12] arm64: defconfig: Enable OF_OVERLAY option
Date: Thu, 29 May 2025 12:49:29 +0200
Message-ID: <20250529104940.23053-7-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748514765.git.andrea.porta@suse.com>
References: <cover.1748514765.git.andrea.porta@suse.com>
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


