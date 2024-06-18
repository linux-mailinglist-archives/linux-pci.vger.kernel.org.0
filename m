Return-Path: <linux-pci+bounces-8923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A074990D986
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68211C223AA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65013B5B8;
	Tue, 18 Jun 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG3fJhxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5413AD1C;
	Tue, 18 Jun 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728925; cv=none; b=GkaBggFc1c7fhzku/jN2y9xAGW5G7A642t0Md0Dk785UhRE63x9s/MP8MSrlhatndVaA9Is9J6DJU5HT4XAOULiOcmESNcAUshv96hC/7mDvkScXfocSSfU3IM8cCPKjRLjhaXCbUGMco11ZEiLlV9Bmm/aR3RgNcuZcUOA844s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728925; c=relaxed/simple;
	bh=J5ctAnBEyZX0rQvct5iBVH0lzQPlM1oUYGDjrfF6ims=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0SfYLtypZO6M0UvlzYuvDI73gdHp0XJE8T33GOD6+P3VYIZb6g+1Lws/PbkBIlRz7nkFlQFuMOXcslnbb8fcvRBaDvVqOnly9GpgA4/o2MO4eAJgDQVnwC5UGHjaEW4DjsKQafIZf40/okHB5swTMLV4GZgdHVr/4dmKBxvEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG3fJhxE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f7274a453bso49330345ad.2;
        Tue, 18 Jun 2024 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718728923; x=1719333723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iixnqsqkMZEErBkM0858HsMj9TA2R4apkp/+SZw2++E=;
        b=DG3fJhxEPM/LCJ1jqIglfuHf6l71l/ejf0lyrVNPmaz7YGwzXYG2FC7OIat3aczSwn
         7Li0ffWSwywcxMVR80+zS7QjImthCaz5utrVHp+qJm2ZPlmZnla3pBorS3PFj5VvjqJV
         3QzsxdX3jMWOkU/e775VIrlscYPHJKlpdfmdLUxb+0q1Q+Tz5QDpAfJvrDFkHqNvycQa
         A75/emcGE7xZ17UTOAHIwF9TsJ2nf/TuGjczJNzrKumX3PbzdSqnk9O7aReZ+y1M6LtW
         iVNqZtBo2GJYsiTIFeI2NsAfAfAsxC0CVRtmphN9yhSw3Qw1Qk3aSbkClV9TggdjJNBq
         71pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718728923; x=1719333723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iixnqsqkMZEErBkM0858HsMj9TA2R4apkp/+SZw2++E=;
        b=t4Pe3R4CaGQ85exxKZcoQR1hKGCaY/1Wuj4cJtjR8tfy0hKXbQoLf0aCSIzY9OC69n
         GUp/VVJKWZoZDlwmLPG9UuelmkPN4YcTjXcVS7qzESDBYk591j2yGjyXQB/R/rARV4mk
         7UYpjaj6anS2a2mGGfQopwg9ZtREmfZ9AgClgjMob22E3OrLw1/Gp3FPIQjsUKbG3izi
         C39CaU1ivSpTS6UV5j2FQs30EIeaj/QUVZeiLDeCHYXUXXEU2HlT4vsfzW+labVUjY4g
         F599ISMwPT/IdeMQaKy/TU/r9WMs6SHvdGf9CtIvqC9R2U12O7LkurkeTbJG8waWK9u8
         lq+g==
X-Forwarded-Encrypted: i=1; AJvYcCUNhgKeBsiV/LcecrS7ZsDqEYvJwLW969ZOvu1eLLvJm+2U+nQycnn6WslDWxsxRk3GqubQVv4p5a9THFsaBY1DB9tq3hNC7YGzAoUFhEF5f5cfgWSn6jaHoXar4s4e2scw/XqV9q3Q
X-Gm-Message-State: AOJu0Ywwv6bASeDZxSIePvvEr8oQydMURtmKlsk+Fyfkwv/I84Gb2CN8
	WU2qi7SL7jubcGjG3EgFPEIv8mzVtS/zU3Hzz1YSOtp7JKfA8Vtv
X-Google-Smtp-Source: AGHT+IHsT0VQzYxsZ9Jo6zIgcHs26CdlPuekBEpH3qo+y0uEIlpZiMjRBVcq7ZtZJ90pAsTC67dVlQ==
X-Received: by 2002:a17:903:41c6:b0:1f8:44f8:a384 with SMTP id d9443c01a7336-1f9aa42f5c2mr1651995ad.30.1718728923292;
        Tue, 18 Jun 2024 09:42:03 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f0175csm99081835ad.191.2024.06.18.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:42:03 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] PCI: rockchip: refactor rockchip_pcie_disable_clocks function signature
Date: Tue, 18 Jun 2024 22:11:28 +0530
Message-ID: <20240618164133.223194-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618164133.223194-1-linux.amoon@gmail.com>
References: <20240618164133.223194-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated rockchip_pcie_disable_clocks function to accept
a struct rockchip pointer instead of a void pointer.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.c | 4 +---
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 5154dfb1311b..79f625cba11c 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -282,10 +282,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
-void rockchip_pcie_disable_clocks(void *data)
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
 {
-	struct rockchip_pcie *rockchip = data;
-
 	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index fceb6f526b72..6fe5c32af0ee 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -352,7 +352,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-void rockchip_pcie_disable_clocks(void *data);
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type);
 
-- 
2.44.0


