Return-Path: <linux-pci+bounces-41443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F1C65AAF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F3A4028A58
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309C3093C8;
	Mon, 17 Nov 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxiFY47C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873130BB89
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403051; cv=none; b=R9rdU8tmOR881tOho2MuH297p1aOmDgW6ra+ii+sooCrgqygA6TZ6O3Qee4ImM1y8yGxq/zLMzjjenDWgRQQqXgCaVOgEOyb9o1zN3nzSvMGyqssa64L4sUUdCthpEm8lyZtBAHhbvaniDrZmq2dvCvACV8ZXsMu6y3wqMmicqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403051; c=relaxed/simple;
	bh=tg+W7M8VKqn8W0/lY9mb1alVFak+w1PTvw1bgrtSemY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEZjnQzRBWj9TIh1mE//ib5cL7Xd12AAJ2V62q4sWenp4BM5fciE6zPyjxZCywp7+GxNp7mrBwNNFtybBNwcAbghtB/qlqYAGmaddNMlQiy4JLNepSgJWYgVHLjvJ1spbFSCWPkBTNXXjywxmbkHDNqJFonsRVFhXkdKhIFOr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxiFY47C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d4ac44fbso41676825ad.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403048; x=1764007848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVLSWaWwsAp3+Eeor9R4CziFFyAk8nsobOp1lA8YjmQ=;
        b=HxiFY47ChLcM3AhJPpeRzYwjmGrNvOLLUmS9DyLlCgx5V00a5QE5AnDv/l5wffP/qn
         FWd1EwzNhoYyOfxxAyjQRFpXkusJX1Ka9J0CUbe3sOOkofnLitpW0peKFZ5u6DZDoY5o
         e5P3U8fWvbwmiM8yBjXYXW+bMdy5IOq/sRH4kG9hUm5rDFYfFgfqWwwEDPoVzKNkr/ce
         qIp2W6SY51RH8EwWRRXPA0f54D6cRIvg0ZkLNmnMbNpcMVdhBMj1fxO2v80TSGjoyAl7
         5peWWzfahS97ily2nYsOccoKtBgRf0Zp60C5sGMC3HT9povRZIPr4PTFW85TIXvp2eYr
         0XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403048; x=1764007848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVLSWaWwsAp3+Eeor9R4CziFFyAk8nsobOp1lA8YjmQ=;
        b=v5qveVOdZGYO/Iokpw0B4D3E2H9nv9YiUa/8cI6QU5/oJrBQWJFXAuK6rN65LUksQ0
         sAQ5HcvyavCcThO8dpTpS4ugegug0EnynlZzWidCFxpC8F/3l3tANeGopeTnyS7nDJe4
         hz9vuy2+swsoyAg8E5kTCY9jsKoZcM3qjd/1fws73tMdLOsDv3WXPoL+rpOvQVNV7M4z
         1ZN3k9ddniUQCp/YUa2I8qfZJ+byZD/wVR4mAXvFRRhgFXcb+H8h5ZCO3UrmdIwuE4r9
         8hdGnJcSHm9aAlEB9RkuG5sIgEbQ6Ud/ctZxRTCODAZiAUzs4O+dv6VZ5qIc4jr6zh88
         qIIA==
X-Forwarded-Encrypted: i=1; AJvYcCWvrI6p0n8uZDSFQ2Irutk0l8Amy4nWJe+HLOW/LQGvhFZsh2AYthISLYBKRpCpg5zhSsoeXybxD3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqlb3PUgPtnIeKEfuqo5baEC5gmldhnm83RGwDySSErE8IzwtC
	3SQSNoqENMT/axD395+cyJVsdDQLX6TFCDK+pS97OrGoNPY375h0TINr
X-Gm-Gg: ASbGnctgRXJtgdsVnnuH3LZp+HsH8SB9ZWHtQAJmQdSluLcJvmKiRCaKuEyArFyei8O
	Sm8dp2orO59ipzuHp/SFoV6t+mYK1Uuu9rmHhYyUIMtIu6LmZX2SBwDdrxpAyZqloJBMSaXPbb3
	q8LYbueVjGtbW0KGbLSNrJ7VgyClbEf3nZhgFqoPQisV4ejqZMdU5jnXU8tLTB9LA2dIKJI2Wgz
	IBQr/mLvu2LIgZgdIvP8FCYggUSPu876FtlLDeL/pXI/eyyB2aSwZwO3HNzurG8jc55u6aZeRJX
	wAewm0rmuyDORo1mB0EQGgCZW7sAHh14lanmXkwmxmMUTko7NVjg9IhWiRWYgkNqOlNp0vSkj+P
	v16+s/jJpTQCRAaCzjeQt2ZtBkHELD+BZjXY0RF/2hD9TmuD6Fv7RO3yCd9tuyQNGOrOdZ/qkzy
	2UcDBdynLBkZ+uo2kB/Hk=
X-Google-Smtp-Source: AGHT+IFUr6w+luRVnOQpM4WmiMJo7zQ/XIZfnSsFQLDG58hBrdFqWOCIG0FqA/4JweD+fOt7hbYKag==
X-Received: by 2002:a17:903:120a:b0:298:45e5:54a4 with SMTP id d9443c01a7336-299f54f8517mr2495885ad.1.1763403048271;
        Mon, 17 Nov 2025 10:10:48 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:47 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-rockchip@lists.infradead.org (open list:PCIE DRIVER FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 3/5] PCI: rockchip: Fix Slot Capability Register offset for slot power limit
Date: Mon, 17 Nov 2025 23:40:11 +0530
Message-ID: <20251117181023.482138-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117181023.482138-1-linux.amoon@gmail.com>
References: <20251117181023.482138-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per 17.6.6.1.32 Slot Capability Register (PCIE_RC_CONFIG_SR) reside
at offset 0xd4 within the Root Complex (RC) configuration space, not at
the offset of the PCI Express Capability List (0xc0). Following changes
corrects the register offset to use PCIE_RC_CONFIG_SR (0xd4) to configure
Slot Power Limit value.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 drivers/pci/controller/pcie-rockchip.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d51780f4a254..d77403bbb81d 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -271,10 +271,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_SR + PCI_EXP_DEVCAP);
 	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
 	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_SR + PCI_EXP_DEVCAP);
 }
 
 /**
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index c0ec6c32ea16..4ba07ff3a3cf 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -159,6 +159,7 @@
 #define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_RC_CONFIG_DC		(PCIE_RC_CONFIG_BASE + 0xc8)
 #define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_SR		(PCIE_RC_CONFIG_BASE + 0xd4)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.50.1


