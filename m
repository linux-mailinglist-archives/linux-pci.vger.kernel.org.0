Return-Path: <linux-pci+bounces-24180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F071A69B62
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B354919C10E5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D522069E;
	Wed, 19 Mar 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMu62Dss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735221D018
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421102; cv=none; b=YY2jrR0nMNLBcMJuxdtFGkmYzPALHo94RAO7JyKWl04LqXwHU75jVbdvPJiUPfh78Qyk57JfEXBRVaFWXHJoxzq76F2fnpliDvgD15MLLGkGG+8fB97ZmmrCEJpHYySFSNgWudxAW04eSbbfYnZIe8+B64XdZFGXiRHtUyvpjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421102; c=relaxed/simple;
	bh=JzyPc2eVnFcS+iQ42poNnWKrz0ZGOrBKiISFuXs6lEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2d2uw2hqQpFz8rEJ4anQsDrKkiMrPh17fhRvYy1D2qh+c4HNRu2bMwwltwfB62o8glOb56z9icHe6AoP6SxtEAdK3Lj9WCT6ct4ZVmbJKOCgQkc/5rXRPY5n1FA3F/+R5M2nuzQAO0AdMZKBiArbxsY7nw2y+33oldwz3UeLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMu62Dss; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ac345bd8e13so32027866b.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421096; x=1743025896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zRknf0FjRBxpKbN0jDt6ZYvci9VpLgXRRZUvC1VBu0=;
        b=DMu62DssN865n7qN0w3agvOKzw4si7sKsGDgEcT1ZdPGwrsgmNu2JF4UuMXA05iKxK
         eNiiboihB4sUu/yVFcvqt4QlXmhqb2gNgeT1+pPem/AgfIw+iCuLiI0oHB1eK10LHLOe
         aC+EhYOJ6m2oivCgmCmw7akxeWulSCvkb/6HqSbSGxiWNlIogEck457tAUG6Hnajf66o
         ba+5YMak8xA01pXK5uOrdCZmY9ydq+NMvTC2w2o5iD7SngG4bABTuT/4Yf7MihSx85UT
         5Z1FV23ZdW2BpkE4+IW6iqgTnhaeUvKd0N5IddoY0Ju+ly+f62ZZqoti030UazZRzXIq
         Tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421096; x=1743025896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zRknf0FjRBxpKbN0jDt6ZYvci9VpLgXRRZUvC1VBu0=;
        b=ihHffNl41aixq3iHavHvQf4aZTdzIScbvf1wHh0M9RM03/FippEn1+LEZYxfXa/SEC
         /H8c+Hir7CFRr1Q2ctLe7x0nloCD2U0k4/NISNiEd8dTal1tVObWOfXTVKwV/6ZDpSVF
         k2qgNYB6xB2NTshI8GF29RnRwrrgMdp33PCOCYKU0cGVaQHNbsfUEEN++QPNeHm+46JH
         C1XWhI4ZBGKNgZmQI3gQNMXWSSylxYpwOiK3bGMgnoQd7kfvKhWSaKRiIXV8Is3Q3ut4
         r3nwf/ytddhlCsYe4x4aN2YRCZnpGoFiVOBL4ItIr9xf1K68NKkjr95+e5jbMdzD/mRQ
         NIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVANShaocnjSgtfsD+YawSDtSsm8KY1/ndGa3pPeLlC5c/hKaTmYjjJk6wz/mDkmLoJXs7L+8Mh8Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIiIetdm8RhoGg+o+AQ5v0t7O/SPxs/puwJQXVcenmTZ8WuwB
	QVgfZGykGvsqZ812F55cqsPsLCwjkwlmziujXtWCdbvw481j6l1BKV1vn0weUbM=
X-Gm-Gg: ASbGncuP3wgC83hWmaIIoIeOEcQUyQFbgKfIG+OypypAfhByY2TPXbTJQUzdjTE2ma2
	d8QxbfEYi6jiMNFyufZFcK6pkpUCHvq3KRTotN5FGoAIBr7g9NWkperDvTNHGg23EOw/rdNz0WX
	MrDF2v2PYT6SMnabSPkN+beQkAjoliNpm19UrM1SuT7AGzZ6Ovc5NrjEX1yfyWbr/I2OSi+Ahnt
	Neh1O4K8qecnsHaoeEXu8+zumDJlhya/GE43B+trJfpUvwdotAgr74vjWeodr4ZscZJqjouxHyt
	W9ORJgsXY+kS/sLPOxefxU44v5CFdNc7d2mXCVe3+HS7cXrP/qw3MQKq4poOg51k7Ces00Be9S6
	wrvDEsUg7wQ==
X-Google-Smtp-Source: AGHT+IGw/NXcD0AevUkNs1VSBpy8/11q8cX74Bk4rrh1yk8V0z4OkbmrlYn4A+xrU8r1pLSBvS/MMQ==
X-Received: by 2002:a17:907:ba0c:b0:ac0:b05:f0c0 with SMTP id a640c23a62f3a-ac3b7a9504cmr543431466b.1.1742421096325;
        Wed, 19 Mar 2025 14:51:36 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa5a46sm1057645266b.181.2025.03.19.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:35 -0700 (PDT)
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
	kernel-list@raspberrypi.com
Subject: [PATCH v8 10/13] arm64: dts: Add overlay for RP1 device
Date: Wed, 19 Mar 2025 22:52:31 +0100
Message-ID: <ab9ab3536baf5fdf6016f2a01044f00034189291.1742418429.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>
References: <cover.1742418429.git.andrea.porta@suse.com>
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
This patch can be considered optional, since it fills just the second
scenario as detailed in [1], which is the RP1 DT node loaded from a dtb
overlay by the FW at early boot stage.
This may be useful for debug purpose, but as such not strictly necessary.

[1] https://lore.kernel.org/all/CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com/#t
---
 arch/arm64/boot/dts/broadcom/Makefile |  3 ++-
 arch/arm64/boot/dts/broadcom/rp1.dtso | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 4836c6da5bee..58293f9c16ab 100644
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


