Return-Path: <linux-pci+bounces-30459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD32AE5294
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5AD7A6D34
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200A224882;
	Mon, 23 Jun 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rcj+I9n6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F36223316
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715095; cv=none; b=TWoxV9JFntVh3cAMXX461SRxCS+nzIG6zyH0fhZKbdPWqjU5N7R5l9awM3HHkLby6Y7oX74p/mSPxD4AzG4fXMb7mZ9JSqE6ggc0X3FZ1cZy7Gzr8QhRn/2NwYJaVh+QVnMOQqUqRJ1WV2qepTG8eZQT5ZDw/6r3FCh9XlbAUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715095; c=relaxed/simple;
	bh=HqA16LR6HAWvdlEy3wx9eZOBIMB7ZcD4My374Vzpq4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a2CPFIMg5fQnRhfOY1FWJriGM5DG7iji2IwunGnIShXHBasvBKJSwNCvY7KH8DOiN4Ct2u3Q8ptBRDs2N7PTdxweL6AOMpnH1nWmCO8/2Y2U6rdo2mdCWT63ckGwMUGLA2YGW6WAF3UD6OVZtLTc6L8S8Lit2syEPDpYFGPR2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rcj+I9n6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-609c6afade7so10489221a12.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750715092; x=1751319892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tECQ70x1JM1SCckuRST7a9aJYN9UOBuJJP77Z07Vo14=;
        b=Rcj+I9n6/EFsI+vmFncrrNcRdNIfIA7o5h7TRp/9WTye5ZWZApO66hmwdk2THD9tSw
         zV90QuwmYmyio1L1m/JvPHuzQYdwpRHUXVmwv85munbhL02OmDrjdj4dDb1HIbCgEc+T
         W4cwZKnLdaiOmJ1WVsDfFbEADG6msDZ+zGHHU8R2H8qj0Wh8vExF3j4Lvu+cErjGgDlb
         BfH/3S6/4JuYBszWG6ISV5JQPf9Zu7YkCySy9I80v/ih+KtN+oQDy2Mez+3BY1aJc8Ls
         xlIerZ3PVudz+L63s/J2AsUM0wgT8295jicFY2Kvid4Rse8NBY8ckObsENKtftBvBQWR
         4t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715092; x=1751319892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tECQ70x1JM1SCckuRST7a9aJYN9UOBuJJP77Z07Vo14=;
        b=gM5wj8xrNvzBFoLg+XyrRs+0AUDsEvxN5FLPCvAFsmN95CIt+bhgUFy3K4nVAAcZMq
         NbIpRFIiuFNMddm4aRQdL7OpNEhI+rCJjYS1kK4PejqRrQnsI19LQ0h/9s/r1LotITQA
         TOLGUMpapcSbfiVTmuhq3rPXcoI6ouSGS8tGts4nuDTTfO77k9JqWAypUELFSRJKURsT
         jvbAeFcuOTy0SRGXe4oSMfV5r3vF850i1DGq9Awealo93yf9/XGBrFjNMmcggu3I3oit
         hj+zSbhH97E+wr+dHHp7a0AySNJQv8FaRmTDgs+5pGZyQzbKx5oRC8rA5/wVdBvsCbfQ
         sw+A==
X-Forwarded-Encrypted: i=1; AJvYcCUO/iBQQUWmFUolfNp/mOOgyMgsh8KqRrqvTcG/rycMl4wYnOF3R40Tvxi2UDSLg3SSjtCzzlOToQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1CP6makVrM7MgLRpxTBXb1/bcg5lG4iMpRT2Yn+C2YCdbaBe
	nDBO1ChGtx0UdiZ4ylz4cLbY7qPKgK20RiGLqBmUPMZpq8B68rn+13rMhsJD2gC5hqY=
X-Gm-Gg: ASbGncuTPN/XV56Y+SVVQtUJYmT48c3xe7hlBF07XfE9m7+mD3Apw0+xYxo/ZFia2fw
	ge3ei4AZtuyLmBEHCt+Vx5dD6+351orNAezlIzi5h39kS3phzSb1QR1OmBbR3c535ZhZdRT2G+d
	7cqK7GLB8fain+E4ZvWaM3jEO948DASnF/Q9bffNtgt29AiwVmJZFFsTT4LgvUtNMvNH5qVRpRW
	ZNvs0GJDCqufzXFWWFbXtEbtx+6JLWFdQs2LLfQlwfQnL22uqN3IhO+EWAMb8BMPvoH+qOxfgLQ
	1AD8R2BJuYVEf78VlB538lUd53F+xf1ISUOV0wsE0OfaRhSXaS4hyH64EJlaPHFwEPaowAWN6bK
	xr4Up5U/xi3vccGAHSb7GoAo9h0e5Uovy2SRY0dP0UbU=
X-Google-Smtp-Source: AGHT+IFCBGEMw6diC/0MRBmRK+mfhHRRzOPyJ8RG9tL1So/53qQwBJoVq147ne0xzxnIzQxsdYUCdw==
X-Received: by 2002:a17:906:d7c6:b0:adf:3cb9:e3b9 with SMTP id a640c23a62f3a-ae0a71f4c6fmr113325866b.3.1750715091959;
        Mon, 23 Jun 2025 14:44:51 -0700 (PDT)
Received: from localhost (host-79-23-237-223.retail.telecomitalia.it. [79.23.237.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0540849a5sm778326766b.99.2025.06.23.14.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:44:51 -0700 (PDT)
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
Subject: [PATCH v2 stblinux/next 1/2] dt-bindings: clock: rp1: Add missing MIPI DSI defines
Date: Mon, 23 Jun 2025 23:46:27 +0200
Message-ID: <c20066500908db854aa4816b40e956296bab526a.1750714412.git.andrea.porta@suse.com>
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


