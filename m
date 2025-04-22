Return-Path: <linux-pci+bounces-26427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439DCA974D0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A6C3AAC4C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C229AB13;
	Tue, 22 Apr 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYAQ/QPR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327D29A3C7
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347936; cv=none; b=GEASf11I3mG2RV8wdrtV5alITAj14tZ2eUz7JehzTmB69Nkmwuml/Zv88eYlqp+kaaHTyHIWEadtIL0BxNJhzIi1TJwJ1ZioiTU+Jw2hdsosscbVulKmVy1sh1gBayBnQyjif1Ufv5rhGXv9d5DQEvV9fd93LfJUERF0AsdvRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347936; c=relaxed/simple;
	bh=4UuDq6ua8nbqeX181InX6ImqDlH4wlcFW4NHgXndXWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avtXKBlupguxuQhAREVWmyNrjAwbwN2SY89S61Ns5UQEQNjmfKhb6Y/cqBlUBSudhTvmiEaLacnh/Emxb+IPRvA3Cx9VZc16lYau/3+3sytUHB/HBL+OsLXDfUCYFYCkkd4CTAxdZXeB3B60pgX6HtDYJ9beMnqaMHSjWuuVn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OYAQ/QPR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1efc4577so2952941f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347931; x=1745952731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vicY9L19iJtQaI2QNF37hlfrrbiq8Z/BEy6LDnCcWlY=;
        b=OYAQ/QPRvUcIMS+LlVcnn/giGSzz48dlKJ4ZVlyW2EZDWv9iJsHvCnmyiKsQy1Ux2+
         gg2ah3GruJbEH+8Gb2NhDnvde+QdyXaH3VBlYlqtKxS+7cZL4NvMtFrNYHzJB6yQaeOq
         K7py+2H+DT+W5nS5KUtMAqsniAd0lL1rrJx5EoRO+XCGcybu4i0HFac/m7lt1QNR0Cci
         HJ+DAK4SEjU2I2w9k9pR+iU0ye7yCfjtdh42FFKycHbCK7hRkCB5mFzg3bS9yM0pVY1y
         X5Zlicd4Zn5Ud9y2/bCGVToMiOE9VHCiRAUtDX2mmYGAElXbLk0g0nAPNkUEHtp9una4
         2n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347931; x=1745952731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vicY9L19iJtQaI2QNF37hlfrrbiq8Z/BEy6LDnCcWlY=;
        b=FoLZmTLSQLU4UITHotNcdLCOtlwCmDz4WqfCdeL8thmaS36LOhifFRL2HRfH5hrsSk
         Lf6GvIw6VNyCcOXc0h8+vs/96mcanpuAxgYcGXMkjOaDKuBSRFz7ToGZp9mzTNrLNFxO
         ykHYUVPUVn9lVVLySaDVQTbPiQGXSXin28Fo2UYh6dIAXJbTHWBZbjRHEhNCYC0KM7KJ
         zJRfCuNSp61PXhDqrbPA7BG8034akqKcalgosNp0nVGFr0k4WmqKj7PyU1EeCcHaWa7X
         VTYydI2H+rRKlQcF4/Kh07tao6UHXxjbWoYmVuCs13qZ9BrAFZLD50PFdZzqPAOVFM12
         7egw==
X-Forwarded-Encrypted: i=1; AJvYcCWVWq23y1yK+JRf+KRXOSsoY4hzNoxdjY4whufy5OxzP5ZTMcTDEnhbSeRWB4cnFbrmhS0nPpCUHME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsJpMKg+g6ZABwVtltascAXg3soIf0iePETaO6VIXqklWXZsI
	vWz9L26RqPPpw2sATtsCkWEoivruxzRx832BxHJ8c1f6NRpbg0b1EepA0EJc90k=
X-Gm-Gg: ASbGncuTpNcTyJmil+n0G0wAVIsB7iHaAVJZFJI0inaIcYmvMUR73EaRcXhjq2QCwwG
	XtV6mFw8/aRVvGWEreMfdMW+Cis9GLweI6IScFl9wpb0UkeI5rk9046G9VYglYAETdOFeHqGGip
	8ykAp6/dGSYZjEKQKpbAOQOZZA/2iyLGYE8O42EHnCKCPhP0bgGIVWyGvaQDj20TFS0c/8rqhpo
	j9HszqmIDFVWbixpPFtgwiQFvWGVMmWvT8DxKHMhG8wnedaA4kedLFJtK4xKl94tRelhwePuNJz
	qpR5claWMqiqu5MXiIJxEjoe7FPQfdBqwq+iLzjzEp9Xh5SJbFdsBjOT2ZDT8PdJAGIoKJg=
X-Google-Smtp-Source: AGHT+IG0zP44yiBEiM6Mgs05Kqo6u8c7BaNE+GEuZ+mESJXY73ChZjIdgSppFK2ryjzO5qAlx8Pdsg==
X-Received: by 2002:a05:6000:ac3:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-39f0efbc32emr3882747f8f.33.1745347931291;
        Tue, 22 Apr 2025 11:52:11 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207d0sm16336036f8f.11.2025.04.22.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:10 -0700 (PDT)
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
Subject: [PATCH v9 -next 08/12] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Tue, 22 Apr 2025 20:53:17 +0200
Message-ID: <38514415df9c174be49e72b88410d56c8de586c5.1745347417.git.andrea.porta@suse.com>
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

The RP1 found on Raspberry Pi 5 board needs an external crystal at 50MHz.
Add clk_rp1_xosc node to provide that.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 34470e3d7171..6ea3c102e0d6 100644
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


