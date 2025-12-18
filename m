Return-Path: <linux-pci+bounces-43324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D92CCD53E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 489763057A2A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D7339878;
	Thu, 18 Dec 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Es+3h0yc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE03203A9
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084809; cv=none; b=SU63jTKP6uMVd/oKOiGJ8oOfy0oo/xZ9PdJWdGqaSFwMapsaQIox2qDDDmjcYy7ar62rRac0Po7g9lpSRubkpWkXBoFuzlzJOIEynuKa3PYkJai/Wa786kbHUu5rX1ksGSdtFnWzqTmOrdRB58BMRdz5lG903OS1gAYbQcmpBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084809; c=relaxed/simple;
	bh=OVNeVNuy7RUrfIyqiyITRx55FEud23YjKrYSlgShm7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+L6eQ1BaVB3C0FwYynr739bbvZa4MjFckIl5WeEcDcSLhRP5vKr/69lH3epTHJtUg/kJQPLaNScjGzNGsBsxLmICTFaU0AOT3F1ywJoF0sIItHaS861cQ/kpJ8vq7fT+rzuXoLVx27Wr89AgBf+uLImXXszQeLRWrp91lIS2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Es+3h0yc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so782142a12.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766084804; x=1766689604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meIgiWUQ9De2m5wPFplm4vW4qbqL4VHogHh5hQm1yv8=;
        b=Es+3h0ycDlu1mQc9WkRGHiVB7T4ywkAa2W6jYDtRz05w7oAtYW1G7JTvVRot4klunr
         k/Qef8Kfgj05v+38DJ3kMiaO4Ur9TizRoQmk1pkuMZUsY6klwRt1lCLom/xAU2XmUwsF
         47V54R7AuBs0ADQuimL9oyYvkYJai5R1qXmgMU7D/TeLAKPmwk0OmPJnVRf6V4apDHuJ
         mqB+93pEp7D4vWFVjXOr9beNenke5amC9sMmpmJPtQOPoguLSGq51aWVtT1qRQYBK53D
         1rY4sk/I10rxgbT+heC99tOM0WwGKf/qfWI0ORbm2Vsh54WnXl3oLzxMRiwj/gnF+x7W
         yxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084804; x=1766689604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meIgiWUQ9De2m5wPFplm4vW4qbqL4VHogHh5hQm1yv8=;
        b=q8NvXD6H/3W9HbOcX0bQAsBgTojvV7k+aJDu90nhpCwy3WolZOBKJAL58/HhwihaPV
         jFlXyW1mxoUqdOXtVuXTwn+ozrR8EtvVDD7s5LFlUN8DWckFmiQpxhHQ5gnjVDzxb5A9
         pxVAt0Q76aZNgdzdmheNco9y2Ap2/cY7oNJlntB3hKEmkb9U19zQYf7vqlNvuDa50x67
         ugH002rkHlkuRAQr87s7k3vl6x7sm2bI12e0PPDUghwNvZqu8ut06vdeGRwcQekSRtMV
         JgC6jBNWx4Y+I1REkbmhNi2490srFtjrLT/FTX0noGQ1LGJYbmL3aXq25AQaT38N1AWv
         mQFg==
X-Forwarded-Encrypted: i=1; AJvYcCUPKtKc6O9M+w+VPB13E+S2Ish7TnpD1RMyfcZFV4Pq71IHxsecFm5uvtwrOpOCis2iuUbFIqHAVmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EZPZE1eHTavFLDBai6MyIhd5zXTtPDXkPdx3drZhKzie5v8B
	EW6zWY9Oo6urtn9tfIBM4WC7wWYTQ0otp7ew+k3Rwssy0tZY0+82cfeHGFUsTuu9C/k=
X-Gm-Gg: AY/fxX6Xp/F8tzkoXlYKe6HWERn4MVDnK+a1vRxSzEGVa1lsWyU2AdnGsIf3TkM20ES
	ouJMcceEBfpbI2geFUOEaIQVrhA6HRx4J1pI0eD1xbSGZ5kC998HgZwLg3Le/hCG2CygRk8RFxL
	7V5Fcv4sUDKm0r6sfHaWjPsx+U18Q9ZY4xJk2Iefd0AksuKDNkLrApDW+Nn4LDt0J/gKMSifm32
	04Xzq8vmixbcKRq0gp7ipWPWsZbjeMcMyvO1qNN+yBtdGA48Pjy0ggHQjQ84PNRwldoQ9Yl6YIr
	MuWzpY0JPunl+LKap7zhsGVR77jAwjFjH8ToklFVgX9VnM9PSxeLDEpAOfoizSnR/sP4e1Dr08o
	UzdyQNOtjkMkjq8Q1+OyrUCVgIYhBJ0hWUNhoiFa3/ECIOl4rS4nWsBQ2dRmBofR4NBbV+ox54W
	laOoceyIetjvGW2qKDX1l+lGbLwjuEw0BmAVjJUdMdAN33oAZVfTph8w==
X-Google-Smtp-Source: AGHT+IFzFfQNZh0mLNNy8P0sjbZrtvUKo4fA6WSa5t/h81X7jrCeW0CUo03UOo7LGxZQ3fjwMYJm8A==
X-Received: by 2002:a05:6402:2345:b0:640:9eb3:3673 with SMTP id 4fb4d7f45d1cf-64b8e93baa1mr437157a12.4.1766084804297;
        Thu, 18 Dec 2025 11:06:44 -0800 (PST)
Received: from localhost (host-79-37-15-246.retail.telecomitalia.it. [79.37.15.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c51sm173729a12.3.2025.12.18.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:06:43 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 4/4] arm64: dts: broadcom: rp1: drop RP1 overlay
Date: Thu, 18 Dec 2025 20:09:09 +0100
Message-ID: <85167b815d41ed9ed690ad239a19de5cd2e8be1c.1766077285.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RP1 support loaded from overlay has been dropped from the driver and
the DTB intended to be loaded with the overlay no longer exists.

Drop unused include file and overlay.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
Just a heads up: This patch removes rp1.dtbo from the Makefile, just like
this [1] proposed patch also does, but the merge is trivial.

[1] - https://lore.kernel.org/all/20251211193854.1778221-1-robh@kernel.org/
---
 arch/arm64/boot/dts/broadcom/Makefile       |  3 +--
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi | 14 --------------
 arch/arm64/boot/dts/broadcom/rp1.dtso       | 11 -----------
 3 files changed, 1 insertion(+), 27 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
 delete mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index d43901404c955..01ecfa3041845 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -13,8 +13,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb \
-			      bcm2837-rpi-zero-2-w.dtb \
-			      rp1.dtbo
+			      bcm2837-rpi-zero-2-w.dtb
 
 subdir-y	+= bcmbca
 subdir-y	+= northstar2
diff --git a/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi b/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
deleted file mode 100644
index 0ef30d7f1c352..0000000000000
--- a/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-
-rp1_nexus {
-	compatible = "pci1de4,1";
-	#address-cells = <3>;
-	#size-cells = <2>;
-	ranges = <0x01 0x00 0x00000000
-		  0x02000000 0x00 0x00000000
-		  0x0 0x400000>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	#include "rp1-common.dtsi"
-};
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
deleted file mode 100644
index ab4f146d22c06..0000000000000
--- a/arch/arm64/boot/dts/broadcom/rp1.dtso
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-
-/dts-v1/;
-/plugin/;
-
-&pcie2 {
-	#address-cells = <3>;
-	#size-cells = <2>;
-
-	#include "rp1-nexus.dtsi"
-};
-- 
2.35.3


