Return-Path: <linux-pci+bounces-28664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BDCAC7F31
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D89D4E49DF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E722FE0F;
	Thu, 29 May 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JGjzvJw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531B211706
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526572; cv=none; b=YImmLPiyY4I6l7ASdIIOPWE4ryZFfZuNizzGanGrWw19U3RidGll0qe+WoPzFSb/JY978ivDWcdHW1RRKGVO/oSBSEvPQSdfFgN/h0SnH4NRw0BUA+WAI3pr511elPErnP7dclPaLHFzluTCeZ6/Os1bS86p8XaXGzuBIZGgVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526572; c=relaxed/simple;
	bh=e7L18GWSgyaQx+VyeKnctdC1G5/fpSrazf2H4MTEiJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDdJq4BcGDqkX/b/AEDuN1uTmQBkuuMaZJdaS9bqsLwerYz5PSbv9soL4fPz7e8NlLxiSFH84ULI7P1AS9GWS/0KQVNLqTTcONHl8j5WQW4jMalzZieq0CnhvwVdWRncHhyhphRAq5nTcCaVyAcG38VMSx1bsKBgNunnQ7X3K9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JGjzvJw3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad89ee255easo158817466b.3
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748526568; x=1749131368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppscN5NV3cw5VQZVyMsIjJdGBSstz2S2TJqiSK9iSsw=;
        b=JGjzvJw3+nuRvpt2PfYG+hCuvGaJQpoUMQvBk8zQGAt5ZiRT6sQm/pbVGdcQVXaHQi
         hl9APZs7Hef6GfDgGRota/TXN+9Ew0QgJJ/0/NSKPZgWWYw5D6JGitDNogdcwn5GZtvN
         eLBEwfDOmdWAm5ZJUfZ7hQkGVIJLQfJXTs3dFbwYYssueJ5HsfISb6rfgbgshAN/6Q+x
         +FcvsmUYltKuO92HHX4J7PImES33JEiQTAXK8G27xaOBT6qnsWPW2YBFNPr+GEV0eoNW
         n636Rv4iPh5ipC7kjzMygqVk3FnrS/AZ1xbD2taU02kVvOZVP5eDEtgkAPsqyxbzWnSc
         NHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748526568; x=1749131368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppscN5NV3cw5VQZVyMsIjJdGBSstz2S2TJqiSK9iSsw=;
        b=FFBgqe6hm0l0gga2tE6PfJALmr+/sklvA7evLyjHjQ3a7qM2EjOLokDy5CVBE7DJE1
         ksgSYyoP2+72QBzY3mio5AagkJC8Vbx56gKyJOPaBgkgjH6+W9PoFFAHB80970atzYMO
         W2oZTtmks7dyZT4dC/v+7BMX7Lmm5cUx+Bt/Y3WEOZC8qEiDtIyymImOgmsHbmtmJsBu
         af7L9oCB9pEG04UGavdqnGqaQpRdickaFN4zT3eTvmpFql+tervzmbe8SOWgCIar6uv9
         WWP+RW9XRds+YXK037TXXH2epmzFHpzESUmwl/EN97uIgNC2HzwLnzfisPeGQnE+SXXn
         Q/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrAbaxv0oGTWwuwsInjhfIhi0u2znp0edXXj9/f8L5CYdwjqyEEuDsu6wTROGd8SWLieG+v54w9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KIoGsDcEJ7lgAnPco8orFzi7EwIUp0CkytYVRsLYf7mjaAK1
	EQyUkv3uCEu9UNWH64M5A5FnpAYYRRIWt0WYKyjoo+9K8N+UyWyvoUHn8B4BcgxvwXI=
X-Gm-Gg: ASbGncsPZV76/08gv5NPk28ZrEgU7mTtPGdHyzcolRPvznqW8f5RoMX4xkKPtL7nuWH
	mNVfoacrZIX/a/1KtcKirB0CwZL1vGob9x0Le/0dGN7jWvodBxXgL1q5/8+wz+g2XdzGnZJNCz3
	5KLbwVNDpJ0eRUnuPh0QrZTl0g2G7MwPWgV/xYb+L+Q+UgU1cDN9+s75sddzRQFPHe25Quog7fQ
	SlQxhR3I6t/9OTrjbIP3kfAKHVGzlLsHdufIdTYhYqA0Z69KyLHKmppE15o6Lf2c663iS1RK9RX
	5aPhKI8BvMYZ4ITy2vez+CO6WI5lvA94cxS2KR/SmlKPhJrSi3XWbWXkLn4VtLwJ8E3f4nEMzBG
	pE1n73FFfjVM62zECs1zTBA==
X-Google-Smtp-Source: AGHT+IHauMo4PO8x+p2QJnQMGgglReuXaviinUw97Q2Scu+s04RkVaYUYy8ri/br/b6wUWptGayevA==
X-Received: by 2002:a17:907:3f9f:b0:ad8:9c97:c2da with SMTP id a640c23a62f3a-ad89c97c73bmr736928566b.40.1748526567679;
        Thu, 29 May 2025 06:49:27 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e88csm149038466b.62.2025.05.29.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:49:27 -0700 (PDT)
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
Subject: [PATCH v12 10/13] arm64: dts: broadcom: Add overlay for RP1 device
Date: Thu, 29 May 2025 15:50:47 +0200
Message-ID: <20250529135052.28398-10-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748526284.git.andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/Makefile |  3 ++-
 arch/arm64/boot/dts/broadcom/rp1.dtso | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 031875a277d7..83d45afc6588 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -14,7 +14,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
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


