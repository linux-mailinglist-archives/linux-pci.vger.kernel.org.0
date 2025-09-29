Return-Path: <linux-pci+bounces-37192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B635BA90F3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338591C420D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0C30148A;
	Mon, 29 Sep 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtGMTRWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3335301032
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145899; cv=none; b=L7KFN3TdDzjAi7L/YsTCeYc3wTbzKoU3hp3aoq9hFCpTgION2FrgDOClH1/HWlgM49SbAxKg4lrRoQwZLTtF1U3rTfVIirLvvqrfD8HI45HyWpqqigjM5VsiHzpsBhsWuJ02I+IRPJYKbMk2YoNlwYUd3RWP4vtY5PwoOZGrg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145899; c=relaxed/simple;
	bh=6sa4dBlIVtXXSWxWD+PhcdWd6PIrRysSNnN6dDj8eWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K20guM76mKz6HoQVenF7QbmaLC+erLXc+2mJAFLkqzzJeWQ27Xqfg4RJ0yJ7qM3KqTuh3GUSv8/a4f/iuM6UZgp5GSD+OLvorYiaQKKkvb1j21WnsMZObzr56KtGWvz6Lrqr9TObnYFPVPBzVWMFn16jR7BCb/tdsAIP+dgJm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtGMTRWB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so44509125e9.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145896; x=1759750696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=OtGMTRWBLoZWsgoOH2w4rn5R/b597s/xtcZj6c6DbuZnLdYiFR0M444fuo1GX1qBRb
         rrkA7enF54EtmAhTV+uSOr9zk1dwOb+ANiM3VbRlfP7cct59JTMMprZ3eopPpiL6JHXk
         W0LccJcEnBOUQzkCF1xbSCfyz7yrne7u7qWwGvXg8Q8ztmzS2/9xURXG1bV8r4jsGKuR
         a/7rSXjKH5rJkvZsnz0n051bIOMW/giXSXWHl6mmHxkEJb2HOkEl0TL7D95xR3+MSffD
         wVWgPKc0qitw1c2jaX0QjZnaNcgmSGr7A7P9N8/FNwiedtfZP64Y9uKlbyWdnwGeZ1ZA
         II+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145896; x=1759750696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=WjmSIeaxTJWUI05xNlfYcqefQwiBjgMzERWXCLB4V06IRSCQLJBx7sNXUxr52eLYEU
         AiudMT3bYp5ivzZnLz+Xha801LJ8CECUv7l9t+QKPTLAGDbA6rGprSnMFZMDo4+iMT/S
         S5n+iWLVy08NWtx6GEnUYGRQ+MjJM4AWRFsVWArGtmEhCRatFPLJvkygR1DNH+ESxEzi
         49dPLcfTXimJKOXFB5KTlIrr0gL6LRqpgXG7SjWmFiEoCgyX01k8Td/d6IsPfWJSXou+
         d/VEGxXhdfuKZfeOE1UmIvie/pwHS4ks4lIPPkoX0ToaVaPaFVeT+bLI3CLZzi72ONfD
         UPQA==
X-Forwarded-Encrypted: i=1; AJvYcCVMM/tyOaXfnMb/baWX9SbRwWZFj9VEPXwkFYQG2mRIGT+nnzNnMx5nxKQa8CNAvOT7NcbFICGJX8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLts98E0kj5DktjMMNkm8FRU7Gbc7AUtKppFAWBmDLJNfM+1y
	bQLnjgsaIxYbtUDj9IyxQqBwHOFbDqr8gnzU9MhVnwoQnV04/atXQr3b
X-Gm-Gg: ASbGncsYk1SWwFP+ugiBLV6suKK+8vuqR14naoCvvBXf8Zuli3T1Nf14+7iaFD5N13z
	IfR9ii2F66LMAJIIqkFaxyg1mruU5KF6tjFi5bdiw1R3gspx78atgTRKz4/oBM9kdYO2gvO4QRP
	eQ4ZhxzB8ZyOHxOW0BNZdmbNEps5lSx0C+Rzcpf1BY/feejF96qJ/ItwIlMGohzr3P0sWUOHI/U
	09FMyBszhWCmk8JgzqVC9NVHJ5aFk6CklKt+n8dShTOEUU0qCqs42lUaliw17qd5gln9cnU0wvz
	aC/zmD/vwsSBSEKxDz+YRTRxmca2caeznyEPJGSPctqt0V9hhmq0WdwtxnN4JrXIxG5X2ZqfrpD
	WZbx2MEb5ur5P055MlqpY4X5PtrX11FyHndV5HQqEoKQkJ256kdcelIpWI1KGCICC1ZzQFbWXMH
	VmgjJtDg==
X-Google-Smtp-Source: AGHT+IFI4JCC0CS5i7fI/P2/bpr7mkkJzs2jB30grNUffEVDg+ZThDdiliKzuAgxVdMuS1kcxLiNLw==
X-Received: by 2002:a05:600c:3149:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-46e46c7b979mr68799125e9.2.1759145896077;
        Mon, 29 Sep 2025 04:38:16 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/5] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
Date: Mon, 29 Sep 2025 13:38:00 +0200
Message-ID: <20250929113806.2484-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
was wrongly added following the pattern of other clock node but it's
actually not needed as the register are not used by other device on the
SoC.

On top of this it's against the schema for hifsys YAML and causes a
dtbs_check warning.

Drop the "syscon" compatible to mute the warning and reflect the
compatible property described in the mediatek,mt2701-hifsys.yaml schema.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index ce6a4015fed5..128b87229f3d 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -597,7 +597,7 @@ larb1: larb@16010000 {
 	};
 
 	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt2701-hifsys", "syscon";
+		compatible = "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index fd7a89cc337d..4b1685b93989 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
+			     "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.51.0


