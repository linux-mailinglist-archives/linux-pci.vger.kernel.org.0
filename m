Return-Path: <linux-pci+bounces-29923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C6ADCCD0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432341633DA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF562E3AEF;
	Tue, 17 Jun 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fxxssrhM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98A2E3AE4
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165741; cv=none; b=DleJzzFyZUDBESklSfP1RsNrek9R4FeCjP42oEzhLOHzZmc2tz1iNZWXXup/a4BNIt86JQNNkP1H76U8Du8BK+3wLWT60PXeObYZd5i9335OGMYpeCXWYd6JVOFpdD8cR7lDl6xDZdmJmMEfV+lUvpzQQm7vV3AR8Eyy458lYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165741; c=relaxed/simple;
	bh=HqA16LR6HAWvdlEy3wx9eZOBIMB7ZcD4My374Vzpq4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IzzZ6aEScYBzU3m1Zk+gZmgVU0ibRDN6DSLgp5WDYFJgN6D8RccOP/J71k5VW2PdE3NsZVD55rmSuEjyGlw6B/CtQO2pfZnx2yss7iVahWN4qiAOlCXTAVe3uVXctPEFPwVJZi9omELBD58FI+SepfCEI/WYiKscjei6Zw7PmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fxxssrhM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-adf34d5e698so783774766b.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750165736; x=1750770536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tECQ70x1JM1SCckuRST7a9aJYN9UOBuJJP77Z07Vo14=;
        b=fxxssrhMMMtloRbte8jFYgwZwRz0x9WPzcBCEeJJ3z9GSI5aNGJqiXao5fduiv9PYg
         jC/uw1LuR7xpPkJ9ZEz7H/ADFjwVHmOmsC+ptrRK17NEKpHjaNizduKxlgaUJNouXRmO
         E4MO1d4RoHbJgc/ZYNmiWjOJ/W65qLswLJqMdMVk8vNimZCaA7QcLDTPQoXf/XQdjQB0
         VvZ9j/Q8xVkV6ivNtdP7eBgc8QXhoBOWHElphbhAb8emde9eifCgH4cVFoJ20X1fmdi5
         AMtLR9R7uVhiCqk+QsMcrGoX5FonzVoAnXelBg2HZ4fgy7nDZvHHmkgevErR1dXEcJzr
         ItGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165736; x=1750770536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tECQ70x1JM1SCckuRST7a9aJYN9UOBuJJP77Z07Vo14=;
        b=MZGtMyLc2CIzBE6brm5/ZsWXL0Lu3JHQv7Y53mMn86l7SCJ5Luy8CHxXQTLDGLY3Xu
         N//bXPJ0dbVMe2X4q9kSZt7xviAL1IeLiY5HdhqqGbETwBu/G2EAlDrffAIpdst6lxZq
         lpTho4WvQWxy3hskn+9G7W74nIzXNeLXu2JFc+vh0qUGVV0s8zs5ts3eZeBQbhtfTpvj
         ca5209V/oB46mp7ABaiRF07aTdnoXDjQH5eQCM/HGUhEFq+adtgF7gFSI5YWn3Vgt2QF
         1cYBv3/ft/KneIiY430b09cQZ6Fp9uCm3D5W1GuXA1E3ZDIs1Ehbib71dCTDDMZPgrIN
         RTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOH6A0Qg3nLOVFMKoDusm5EoG3mS5kucDFqaHYg8AEd8QZeiUqgHnS5P37MM4WOOZskRz2zg2U2HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOhXp9YZgLYX+n44LwL+JldqzKi9RRBsH5bewXt3hDbKF+oP9
	TIfc3KUGuMTEotYt7DNFv8YVbVQlVzyD1pExMTlrmth/u8IE3Fqb2d7VCeevUoWd+1Y=
X-Gm-Gg: ASbGncu64x473SWvIi/LVjnO5cbXNUFI3muYG2KUJJzZMzhB3C+Pv9uz6nVagEyleb5
	4fbIjjLzX1W9TWHr+3s2OZ9ciC8eghwo0sDriKjyefYOyqXRqKS1cHvYuPIhHnQhFatSmirear0
	zyfbRjGSpdSyrUP108rIePS6CXFCeawJpw/+ssypAraEGucbOXRldmpaOrB3oNfAWHFBCjY2C+6
	sn7CSAjI5ieBfnLm94XiBJLFFjQof1dzGdWC3Gy/qMEboaNvIvmysmbVhBYoLtSDIuIgxd5Cnqu
	WBCDnACWN+ra7xbyDIcSom5DzlSY+EbKaB/Q5HRSyjFIZebVkl0EappSE3Wu+8XjL5wKQ8DjiGH
	fYu2P1TrEtFmPtSWaUs2kEkz+4lg7J1HD
X-Google-Smtp-Source: AGHT+IHZb/sVwRJgA/UO9fRUeHQ7VVUZbqfIWG3k9c+U7l75XFG3Nw9yzuD9XOU45EDledJ7H6W3zg==
X-Received: by 2002:a17:906:c143:b0:ad5:2d5d:2069 with SMTP id a640c23a62f3a-adf9c458189mr1334205766b.13.1750165736215;
        Tue, 17 Jun 2025 06:08:56 -0700 (PDT)
Received: from localhost (host-79-23-237-223.retail.telecomitalia.it. [79.23.237.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81be674sm873602666b.53.2025.06.17.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:08:55 -0700 (PDT)
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
Subject: [PATCH stblinux/next 1/2] dt-bindings: clock: rp1: Add missing MIPI DSI defines
Date: Tue, 17 Jun 2025 15:10:26 +0200
Message-ID: <b8a54f41f6393e3b3cae6dee561fcd040e3e5fd0.1750165398.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare the positional index for the RP1 MIPI clocks.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 include/dt-bindings/clock/raspberrypi,rp1-clocks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/raspberrypi,rp1-clocks.h b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
index 248efb895f35..7915fb8197bf 100644
--- a/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
+++ b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
@@ -58,4 +58,8 @@
 #define RP1_PLL_VIDEO_PRI_PH		43
 #define RP1_PLL_AUDIO_TERN		44
 
+/* MIPI clocks managed by the DSI driver */
+#define RP1_CLK_MIPI0_DSI_BYTECLOCK	45
+#define RP1_CLK_MIPI1_DSI_BYTECLOCK	46
+
 #endif
-- 
2.35.3


