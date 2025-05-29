Return-Path: <linux-pci+bounces-28621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10AAC7CDC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB76165507
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323128EA4D;
	Thu, 29 May 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OLltV4hv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6328FFCF
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517754; cv=none; b=g/nLGKO84f/CjcqZ7pkRVTCaWnQarzKOx3Pis8Y33J+2tQZJ1/D92r1i1vCA8O7kkrtwacyVv/PxMND9gcKIQvge3t3g36TMHInt/nR5G8nasAPyJ1iup/yo6hbiJq647K3YWKORevEYyIg0v6EwIEIPGKDr3ikMz8ttxnROkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517754; c=relaxed/simple;
	bh=RRM404hdZVflbCbuZ7OBxFTgWWaneCmtEfkgg/Xp1Lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM4pZhlSIFkipFEDVEaBof+lXQ8MiYGoyYRhVJj6MRKh+PxRh6q3SmNbZT04plIeMIjDew4GY4HdIfpsLAO0KV9pyjIHGnQ8dYYEOo41FuIhmMri/5Vyr1xWfwQbhhdx9qvpn3NttjrdfxC0oLyEnNUmWnTlKODTUshLLJVnzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OLltV4hv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso1485715a12.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748517749; x=1749122549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=OLltV4hvknXuVnFrkc6OH76sfwxPheNSSKO9WAhv27oqOhYFwUZ0fcYM66jggE2qMb
         dhSXD3dUgnLcRpgTpYpFfB5ARgsWeO7ugUXeq4KRD8tYPpwiQo2mqjgsETUTGiCCTelo
         5Y36I2RBrVZlDsgMVsIqHPeACpL2yNrvJf4qjzjBtdTT8SZ7KMgHAhZiOx5qDGz/JO79
         hY9tqzJOeeUAqDHqmO7+TF3csmABHyZIlPFdiIwGV1PaTxcQsOw4FirU7rFZDDcMeYPn
         ascXf/f7bhNLfZgURyCuD8xjfMCdBeP47c/S8+6+ftGVf8uLjiu5knFrN0IEl+LsayBH
         DV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748517749; x=1749122549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=rZWBC0zgIR9Xp1iLUdqXLOL9Zx+TvqKlkMH7rMC/Sd1iI2H44wb3k+Ubif88gAUTYl
         VDtSi87rMEGmgppImGDXqV8GP855PbYg9gXWfok3dDLXHOK8yOaG0ZMEbbk0dZ+BWf24
         51F5na0ZsvPFY/42Q3i2dXqWHPSN2TGOin8uHTaH7aOoBv+ffTJRLkU6dNwlWXZHBl+3
         b7GWfzQPSejHwxSFRDqqPog6U7JOUo2Ubcw9tfelFyoKOXUCr2mAXDTfV+bCB0meJAzN
         NVDkDPEsHitNabdvMiEwO+byFOfCGzk0BxJFUxx/ur+j9SkCrV3/M91xAOSteB3HPHN/
         82Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW2qcKygRl8hFoJWPPj9ry95D1A2wEQUcIu/02MfNEZSSJrMSP5bEZFFph58vDR3hrBmd4F4mtqo80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCf8NjV48OA6inSdQ6PHMn3MD04SAfhGU/RzADVU8wZr6ff3U
	Lhg18NSMc8TX97zay/1iZuCH8G6ftcJshFQ3/0H7k0uvNIDt7+qufDJDPvKpgyS+uoY=
X-Gm-Gg: ASbGncvfIcIuGKK3LlABfx6UTasAD3C2jmEJ73igbWBKBhn+3TpDIHDRL3XUjv56o8l
	cdJ7MR7yR/t2oI/AQlPZ/G5jvTYjKlC2lcU+5wULrewwmK3DV90vZos90ODxP2ZwxuX9BQ0/Njs
	zAIBLqJW3h5uI4P6aev5UantXMNqFUo/fU5c8fmfd5o/34g5H8q4zOEeHzbW3ePLCWrcJWs8qIN
	fQh2G+Fbw1EhayXaii8+z4wMj3a8SlX09+NHq/WzEfzm5VgYj3bhY+5QtvkSiWX3ip9DWMliHDF
	AbtRGorYDiCHBGOeWpoBMNYsvcLy7/Zg8opymVa2XLDNMcKaRJOoDZlM/0DdktwqKgwGbXo5W76
	ABHQ7WTAmK/7235WCQXQ8Y9zzzvna3BI/
X-Google-Smtp-Source: AGHT+IGIHEB4AcuERSFwVfLZXlxZybEzRkofnOTwqfs80hqrEJ33hE4h3yIsIdTYmxCJoTKFbmQFHA==
X-Received: by 2002:a05:6402:90e:b0:601:9531:68b8 with SMTP id 4fb4d7f45d1cf-605460f42f1mr1154010a12.18.1748517749396;
        Thu, 29 May 2025 04:22:29 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d6091d9sm2291814a12.44.2025.05.29.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:22:29 -0700 (PDT)
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
Subject: [PATCH v10 12/13] arm64: defconfig: Enable OF_OVERLAY option
Date: Thu, 29 May 2025 13:23:47 +0200
Message-ID: <20250529112357.24182-7-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748516814.git.andrea.porta@suse.com>
References: <cover.1748516814.git.andrea.porta@suse.com>
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


