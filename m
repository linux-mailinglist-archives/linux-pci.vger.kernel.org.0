Return-Path: <linux-pci+bounces-17521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAF9E0080
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A68164429
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE802010F5;
	Mon,  2 Dec 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NCFyGBHm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6892040AA
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138361; cv=none; b=EmuLiWafLX4AlfVAqZk82oNpJBkuBUl2fx7jKA/CrmK/h5yxBfq9KkWXrrvi9E8LLA8eHpNny4mQgldXL1qJyJGJdTgPZjoSrK6Q/iZ2kVfWd+L0c89+6FldbE/IBxnu2FjpmKhc2mfo6EgHDe3Z1TsSUrHvgAWf+sAvS27z9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138361; c=relaxed/simple;
	bh=5wKv3990qTqArMWxDC8JoNsA96O0HLgsLUAOsCHU91I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvziJQgBbSNjcwTjDOl9L6gPo3fVupse8hJArBddtNJGJJ28phBJiMkbF6vqQx0dOHqh+YVu7p4CCRYlcmasAtnEE38JgUYNbDbOOnusVAXQtPijUxs+VmBUTsdk+oHkQPQSZ45piAbpxustKbtgtouErFlsvIrWd0ERETEtlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NCFyGBHm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so4896155a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733138354; x=1733743154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/DXYP0gmkoHCujxUnsFn55701rZVWVknkTyMB7ADmU=;
        b=NCFyGBHmPbQC4JUKeBrMhZOaLAN/tRkmQEf4rq9AA0EF05KaaLWXSJA5PNxHJGfzMZ
         oM7omQU6QTQ4yBVY+t3BXoO6Xeb2/HyTV6tIFBwuPX7LyZdjYBfTBMMgTcYffpBmLW1Y
         bdsKZm+f5kmiqZx9zR2ws2rnoDDRQlsut4UD54zNmnYrN4ZnYIxwUyuvEg4/ph4L1kyp
         LFFGo6LdYu2ihJFSYeGLmprgVyIlBOcQPVbaPsRdS9dMAmltZ32VGjLPVg9+e4pnUFFK
         XEv0jGt4Ou99JJWeJfp1a4F47uP6FuHwXzqD+gkEDtEciLESka60XQ46nhpuADsFqjDC
         df8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138354; x=1733743154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/DXYP0gmkoHCujxUnsFn55701rZVWVknkTyMB7ADmU=;
        b=YfKWCJqzxUIEH+u+1mHYmCH73qxYkjhfHhJdMlg18De1BZlNPnAkYG6gEpk+lhCvgL
         ZMQ74fV0VjfjQmzIulciWwkDJamzATU58Wb8Yx+49/iosSta8BPuE2Il9oGCZme+zceK
         +TJ/UUbFSR/kAwVUzdyVQFfieccpmdRmzh99pROE63bvPTXmNQUB4XrFXtOA9wo35QfN
         PPvH6Sm67UydX6Wh0r4GQeRS+SF6c34oRcKWSss7FQtYP44cKVCPQWdBKKHiKk6iNnAS
         63D3yrsvr2rMZBR0qIEIvmqQm+3dSj49gIVS2VxhHSkFMJ4hM3RnJ8frPXQu74bA5AEZ
         J8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWLkzgsFh4w7iH8MniHpFXRxYeRTw+b0GLRnwydSTvhqm1C7DxU4bXkN0AwQPGPJ32Uk9X7pk7/I0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbC6s4Z1x/QwHLC84IoWwxXbtExwHZoRwZ6cC1yYcUi0zIBSPx
	U5B1CcnRdFisoZRZ0hbSQi2WnSvvk2DSAqjRtRUYLMsmhUuNkHOhufrFBC4l2Ik=
X-Gm-Gg: ASbGncv0GHi9AeCH/pR4vkdrWpUFW5w69At/NuVR2+mKxHZUF6nFK5rj9NUfoqhlbkZ
	Fa03gBDPGh5Usz8kojQIfPKPcPhFE/Cb8ykDzr6h/tlfjUFAhFNFdsl69dBMiJZa1wCThBcqJl7
	/VBr1/QM/wpiwKsZjYCi65qxGtLvWGVqevoxCijAp2R40xUUnlb5rqE2Q3uD8Rfl2mkmyRwKeCq
	FMuFNZrTcfNR0vNI5urh24aPndMsWXdSIulq4scQvMMpLr6I4XGFOYlX1sn2MZP0DsOaVaSTfq0
	RQERvWlCn7W6Y38pezIi
X-Google-Smtp-Source: AGHT+IHeFnhQVvvNV6Unz5SbIu5RmIoxGk3I5zBFBtPc8jG8aJ1mwarpKQV7x9LB7y94ybUWdyYebQ==
X-Received: by 2002:a05:6402:5206:b0:5d0:f088:c675 with SMTP id 4fb4d7f45d1cf-5d0f088cc59mr2379116a12.21.1733138353742;
        Mon, 02 Dec 2024 03:19:13 -0800 (PST)
Received: from localhost (host-87-20-211-251.retail.telecomitalia.it. [87.20.211.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0e1b6903esm1763679a12.19.2024.12.02.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:19:13 -0800 (PST)
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
Subject: [PATCH v5 09/10] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Mon,  2 Dec 2024 12:19:33 +0100
Message-ID: <8b4dda91fae156a7f28f2807cd6d64ac2ec07dd7.1733136811.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1733136811.git.andrea.porta@suse.com>
References: <cover.1733136811.git.andrea.porta@suse.com>
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
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 2bdbb6780242..ae3c0c153cea 100644
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


