Return-Path: <linux-pci+bounces-24183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C3A69B70
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06A61737B6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B122157E;
	Wed, 19 Mar 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gxk1Bstp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108B21D3FD
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421104; cv=none; b=UDmAh6Y25nm/80GPqpyk7b+dJFpm0UPmCP+sKte4k/Tk9tFRMDijatmjkiWRoR1ekWJ+IeKwvRfaahpcHY3EGodXGPmBWr2roULL04eoh8UtvOJNmz6GmlQv4Ydmn+QqtHPs6XdywuY/vqKvsKPgZ22Xp3/ZkQFvTEeyknQuuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421104; c=relaxed/simple;
	bh=6A227ZHcLwmH34Uyd7dFlW31JXsgCCsAPJaGw3Nto3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo41uvg38SDVLPZTgArGyrHtEFpnNA3meePoC7xEVszeUF+/xYf4tTUzYpCb4DVUOon1YOAnxnvLuiYHHCrXJIhGZMAofJWoFvc1XoohPpU13zcy0hs+M648ZugcZ0WoQJ37Np4lfG2ODnfamGF3Gbcf9IW+EaQH0Fru50psNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gxk1Bstp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso248020a12.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421099; x=1743025899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FlX2bXYTfLPxWNvFOZ2OVVRCbqnN5Q4yt/8rIDVkFQ=;
        b=Gxk1BstpCZk9hfyHF4pDYDjsapZboYHtwMfp8iCpvwy8kN0x1g4Ik3Sa/shB4Itx3x
         OP6bHjfQVtnC3fDmPaFIKJ/bQSC/3dMI7U29v9d+90lWIIx+apzJy1MD1zjZ9b2oZZ6N
         SrYTpa/Fe0bjxbFo/nBsRZSKoHuzjq3/4Bd14e+wrse4mN7deqoWJ5Fgv6CCfEwQrG0l
         WsFu0bnTh3bgFIDqaWI3TOgZT2AkQmuVQQI8I1WN7xYICbdCSSd+hcCjAIb6QlGQsYdA
         O1o/1Eq8ccXPGtXFEe8DmyM8jDnErTXMBsIIC63CpJl9AJYO5OvDnDAQ+li4gCw+8Lqd
         RIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421099; x=1743025899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FlX2bXYTfLPxWNvFOZ2OVVRCbqnN5Q4yt/8rIDVkFQ=;
        b=HbpUdto9NkPv3V3SqUzDg+APi+mLa7fYIMWkliZJOAu/WY+eWfQ4EdN4JzZGEtvVT3
         J7DcSBJJ3UsRxiZcEGdGqIPtASATQS92UFE+LJoLIf22cG0dPw0PIreBlBPgg7ohSqEc
         e97xk8Y6jlfMmt3TBw91TFaePmMMvWH4qJDfLXAf1Rx8kKnEzgEpxxcdVipHxFbJORGP
         RS80nh/bnZjoqkaqD/oUDTWhrfI44hzQ59hV+vB0DYKhsdQ15FvjQ6/N6DfU0H75LeUl
         kCk2I0Iv0k/yRRR/mQrzcoaGWURHPG5kgHzfiT9KGCrob0ip6KCfzlJuLb9qWsgMhObc
         oWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXTV/kyp7CCw88gvaBHo/U4b3EnC1BrP2mNjV6jNhhDo67iy7GRMMWDC/yMjnKE/7+hOwDni8lHxHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqFIBpqosCV5FqUNfCslnmUV7tFHIWsh6r6uKqU9/gC8vK+UH
	Fm+wqwOlbkdsGCbT2p/IOrIkzOd2TgBIK+3SlQSXHe3RX1z/3Lu9kMsAfearv2g=
X-Gm-Gg: ASbGncvPTZ8EXpiJluepO7A3ECe+t6bJWbjfaVe7ovxdyWzfNxfnyR1d+gH9HJpWPwJ
	XC5ec29wqQhnWZ9lOXpZxQecpEAwpdE6eIx2YmkCMTpX652Lb3Ut2nwcz7+iMVeHW8XRibgr9qM
	pwXpUqgSpycdyFWS8GpVZ8sfQhT47eobX+LQUqK1H+q2O1lQ1J78wZykMzfuZbO90obv6EY5qGc
	rJdQxDUvCwC8piZAcZz47sRkk+/TXfqXizBzXvPxkGldhf0IHI11s45R91IxZ/aT4+2aeoyXsMu
	0oy3ivoRYdp2Na7w41lvfVln/GZKnqVCWUkECinoeMCwgH61amIOWtKtKQhHnzQUhI+tFhdQwHL
	R1QZ1EMGS9Q==
X-Google-Smtp-Source: AGHT+IHnjg8ip47n0umRwsuHPNgFyT6zs/YGRrSkkBMrSE2e0JyIORLF+LT96OI94/1opTBkG6cz+w==
X-Received: by 2002:a05:6402:d0d:b0:5e0:8ab6:65fa with SMTP id 4fb4d7f45d1cf-5eb80d4a3eemr4555608a12.19.1742421098973;
        Wed, 19 Mar 2025 14:51:38 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b1623sm9678655a12.39.2025.03.19.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:38 -0700 (PDT)
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
Subject: [PATCH v8 12/13] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Wed, 19 Mar 2025 22:52:33 +0100
Message-ID: <378f6ef859d7c23770b1532a370f4af97cc9a922.1742418429.git.andrea.porta@suse.com>
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

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da4415599..cc70793e97ef 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -618,6 +618,7 @@ CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QCS8300=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -700,6 +701,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1289,6 +1291,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


