Return-Path: <linux-pci+bounces-26431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8CA974DC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B77E440738
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23C29B22F;
	Tue, 22 Apr 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LendghkY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5202989B4
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347938; cv=none; b=GwfctDZmVQcEH9+wDBzI20UE7jx9ddvn8foe/LRA9aLArdeQlx/8XbUkjm7JLZRL2xw1MUaattZnOKobB2o9kg6ZW2HJTevS9TgekKbZpFdEaGjm02NVd7uHjm5LcMygFRB2xdAk6sUQGqP1mxmeZpTWGSFk5OmlJRBdFE3bCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347938; c=relaxed/simple;
	bh=0d0KA2JIWD01SkBHQ+kOHI1VXSE1uJ+d/H8RXibXQzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twP10yGfVu4N4CfQb9yh0a+Sim6GGsD6VbVabtI4XV/QNybzd8x2wzYxhpAxarryGxBFvEEk/OIxkzLfo+7dw+Yv5JMdNaaCQicf2weDRdeCuVhh2YpCqwsiElGA14ODKUV+wy+a8blw/fqVMjyOfDAOvQzJ/jsIMu5qL2bRdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LendghkY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso55166665e9.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347934; x=1745952734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5FlXTAP/GpzsHWsqpirXk/6wSg5qJznRRV+qS9c6do=;
        b=LendghkYGagvcvmHX5iiXGSDlaL8T2+7waq0rFS6Z6L3RK/GibhBYuAVtx+PTArNoN
         UYYI8NXuifFUZ8oo5QSpVGqNcbz02VuoXtXmjV6AOzCHE0XnXZPXx80UhgpRn2iRpGuU
         erQoyu8N7EkkzKU/J39LZNAZyqiv9c9R4ZDZGZVR1n9n4tTrrGz6/5g/DtC+73WZ7H+H
         aGoKsxqTtvVx8nXVMQvDwqlA71dOY9MvTmVsTnc1P5BaqupNwZU8BgQFvprMiNEW6iWO
         SJzh8drSkYPXQUe2Ef4TshUs0X+cDciY3EIuR51wL2hnnBynfw6jkVAoBy95A3HzqwZz
         VkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347934; x=1745952734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5FlXTAP/GpzsHWsqpirXk/6wSg5qJznRRV+qS9c6do=;
        b=BAlgE1nI+L4Exr1q/t62qGS1l9Cla/bMEkJR40qbvfCbA6fl4E+c0RUPOo6d5Z990l
         RcOai4PN26j18XIOhl4YSHBWuoq6oV3K9yGE3hUoHW/0eo2WJ0qozVkC4eLkfPuFsH/E
         fdeVM+Zo/Q9FrlFdHAKzwuTUz7Q+j/xz3iguLNuCVwBWjLsX4uALdErfptF7di8ayoRo
         q5CjoiDOXn8k/bSRVpuSKIsYdx7kePB95yUkcvP6D/zLUujlzbyBhB7l1zCGV7Mva1SL
         gPw3f8X2pwRsgmp3tuwLlcsUZQUJblNRh3Q5KQaspaADhAGmNjToKUCU2rrD67qnfpqO
         yPNA==
X-Forwarded-Encrypted: i=1; AJvYcCVZfmAeS6BVKM0CfsVEYE9AYCZC7b4L8jTWhRYt72GSG8l2/h0F5E4fPYvkQ5zHHpDAaC7w5VG+LuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ODlslIP5zvlpr30bvogiLT10fQseaCVlHGDtJBRVqJqtphNc
	rEg/NDKSp5syoUk22of4B769ojSrAnc0gWQHWUkHi0xVCutyTj1Ya8nCEGgtZ5c=
X-Gm-Gg: ASbGncvm+WYloVMLBnQJK9o23dTxempXZc4v6h2zPyGUaoIwAA125hoTOYiNMz0mcxC
	SkZC82oUHChvga/FAcXn3Jx2rv9whtmHuxelqAlSbJxibUY+AomSeNJaFYkY83JjlCwCrDyKylw
	nbo0VlkcUsA6YmRY9IChDlITcagifx1E4zZcbdJjHYlE2VhksZSLqx62iTpdeltG9zwoKsN20yy
	Zxpd0CNby7E/zIQr1kBeu8Moc1IXn6n7fChFwkV+uC33/sEGr2w8Xay0j1P/Vto7SlRTO5j9W7B
	asvPEf6jv57Tfgm88zcvzKNG0Qy4E8MRCy5+AxE/cR74gycIUFWdxiaFRT92kk/Mw0bqeV4=
X-Google-Smtp-Source: AGHT+IEVk3l0u74vuAp+CF5lDNrV556fT1PXsYCuMHNy3f4iRhiDQz8At/q2Af1Bf9oamgLCLia6EQ==
X-Received: by 2002:a05:600c:1c8e:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-4406ab6c278mr159813835e9.2.1745347933551;
        Tue, 22 Apr 2025 11:52:13 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcb6sm181216235e9.18.2025.04.22.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:13 -0700 (PDT)
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
Subject: [PATCH v9 -next 10/12] arm64: dts: broadcom: Add overlay for RP1 device
Date: Tue, 22 Apr 2025 20:53:19 +0200
Message-ID: <4bd8dbb374f15a01e3b3ea27f9e802cd702c1bab.1745347417.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1745347417.git.andrea.porta@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the RP1 node in an overlay. The inclusion tree is
as follow (the arrow points to the includer):

                      rp1.dtso
                          ^
                          |
rp1-common.dtsi ----> rp1-nexus.dtsi

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/Makefile |  3 ++-
 arch/arm64/boot/dts/broadcom/rp1.dtso | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 09563c41ea6b..2c6a717040b8 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -13,7 +13,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb \
-			      bcm2837-rpi-zero-2-w.dtb
+			      bcm2837-rpi-zero-2-w.dtb \
+			      rp1.dtbo
 
 subdir-y	+= bcmbca
 subdir-y	+= northstar2
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
new file mode 100644
index 000000000000..ab4f146d22c0
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+/plugin/;
+
+&pcie2 {
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	#include "rp1-nexus.dtsi"
+};
-- 
2.35.3


