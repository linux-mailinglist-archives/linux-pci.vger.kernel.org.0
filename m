Return-Path: <linux-pci+bounces-16423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969249C3824
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEB21C21594
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38501EA80;
	Mon, 11 Nov 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibDVik6b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CBF9D9;
	Mon, 11 Nov 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304864; cv=none; b=LbwGwSqEt5ReFEasr2H5ksQki/1MZ0SKdokyDlitKebB52fKuIMb2A14TIlwLMTDCmtYp9HPPnh/OspisnjoAE5k1QaTW7zhB0sDUKJJhAigqYwMxvA6E/361uwI/dT/ujr7NdSGuYSVm+BweqNBw0qAMQJCp7HPscvfAQMhBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304864; c=relaxed/simple;
	bh=NV+9hUlYUAg8ndimwT6PttWD1B2CP4DjjpTGNK+b/fU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lw9FXUAhvxwii2FGl+BCK6obg2NmxT8SM1rffXtwQVTaddNiISDVecg43m0+8MMV/REm1yf7s0kzasob7PiJF8FSGqt0WT0NXo/Ofaaa57KAdXfb+c4CqPcTCX7YldmlmRB8xrBq71v4xVGsm9n9Gk0oAuRbpyuBuTWTJteyTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibDVik6b; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-718119fc061so2101598a34.2;
        Sun, 10 Nov 2024 22:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304862; x=1731909662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln/YvogurAeDd4PXMTsxwRi+ScCPO8pDH1rSa6dd7is=;
        b=ibDVik6bLlwNymCSnPQP5AjZm05yGoJ3AXkMwVw7B8MP8YpxE6YIPfcM1ACnGNsnnq
         u4LH0M4xoOhfnFmhAVfd9W9xV2utIzAjzGqR823N3wUCdEtXze+y99TB6hiF5Nj8VGyD
         efsaIXTCcW1DaJ6MbS5r4wzIZV0kgoHcnPkqV1HjTGHKr1vqVDH9GfaPguYm8jCPu3Dz
         xWjMLtgxcvZ5FjmKZLLOqAv7IylpQNqV8uCjAWvjL/2uP0jSM3AfbiWM4g7jSQOm12OA
         dbZI9lDNi9Hrf9quNGoxhwlMjNOK2TkJaYROwS2YAQjd+ijSrnJ26ECPkaBw31Nkrnbn
         Rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304862; x=1731909662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln/YvogurAeDd4PXMTsxwRi+ScCPO8pDH1rSa6dd7is=;
        b=Qn0rNGRt+fVLrgyeXjrTHjvAZQPFGXg+r2eY+Iyv6FgnRZTpZZnohLztPR15mVST4t
         Bat//H56C1D36Dc0FPC31rlghw5aMhlgby75EaIvhNm07nDPpHEqZKIeqPSGzOUUOron
         2qKJ5VmhWh7sVuvBRDQh82TqTU10YgSlQeAPIAsrukWKz2BGGwixW7vjKMAC1qLRD/89
         3eYO+IIACjNBUoN1bAnlioyyelzWOnfaG9eF0XcYGaxGVjerbJF5MvZ94k9XwK87DzZ8
         O9dothwBxN30x6L1dOmqGRRVuMiFMj9tR2TTw1XDkBhB3ZHqthC49fAgSutMMs7OBUr5
         0qeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnma/u3oLJl7dMcS1L8CpKW5hxBDLz/WrMaujoVRZKjW6tU3o67Cc7y9wdMtRnXA0MPLNF1Oafvd+v@vger.kernel.org, AJvYcCVOs+PRyIMeX3j1VfK53Skla3aExbarVkBlKLjRD6PHPA0pRgJhecDNuwSvVt3xj7FFlKv/BByUl3cEN8cS@vger.kernel.org, AJvYcCXcL4LG0tfKsVieslbPx/PG3cPbNQ4s2yunOmlZZiVv075o/WzE6goPGwSHWQGMu5mmI/oM0TAGwseN@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzle5cAECDNngEhFRhdDe3qE8tUCfQ2L5GStIm/2A7NHyMGHQ
	bhIxAayMArWawunmGGBwzFgyXRmECO+DZTOOU3uYFJCbbPmusRK6
X-Google-Smtp-Source: AGHT+IFBlx2VElOixlZusR/Vn6fS6PXbSuh9gX6z0Dkf7b72H47WFUGg6sJXSpzTddWCr+wvW2+BFA==
X-Received: by 2002:a05:6830:4cd:b0:71a:21c9:cd5c with SMTP id 46e09a7af769-71a21c9ce57mr6154495a34.22.1731304862305;
        Sun, 10 Nov 2024 22:01:02 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107ebea1sm2125973a34.14.2024.11.10.22.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:01:01 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 5/5] riscv: sophgo: dts: enable pcie for PioneerBox
Date: Mon, 11 Nov 2024 14:00:53 +0800
Message-Id: <bbb573658f02c5a373eca1fe3f55ef40b09c7a57.1731303328.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731303328.git.unicorn_wang@outlook.com>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Enable pcie controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index a3f9d6f22566..746b9c3d254c 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -45,6 +45,18 @@ mcu: syscon@17 {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc1 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
 &sd {
 	bus-width = <4>;
 	no-sdio;
-- 
2.34.1


