Return-Path: <linux-pci+bounces-9222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6272916569
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87951C213D7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4814A61E;
	Tue, 25 Jun 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrSiOsWv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA714AD0C;
	Tue, 25 Jun 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312068; cv=none; b=qbujJjYnO35hgKhQXNaD3qZzM0oX8Irul5boG+BApaLXfhlJ2w37XYREv0aF+BBQrAkroQ1wvVNwflK6TzF1HNhmFrPa0cNnCknsomJcKHOHO3iwi4TTCIYWyRnDvjLgdsjbAwCFH8IJ3bZ6urq92YRx3Mxj92h77qACmKa8QlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312068; c=relaxed/simple;
	bh=+3l1EDb9sJoLixksS4zGGZe4ffLwSNKoEZ69qIeFqxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibc/VQSh3UNIbrRH9HKmAs5ZXVc/9dRFxcYbrGzNS+VpxUO/EtFAAJVrUe9S6k0FefEOlIpo2gjH/rmH1Y5IgDSfMc0mi5UExbMfdrBBv/FKjyKwMdMbHlUrnH8dWw5+WCMAHO89z+FxI0gYiuz+wAVXWAshIysjP5Hh+johtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrSiOsWv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-71816f36d4dso2418281a12.2;
        Tue, 25 Jun 2024 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719312066; x=1719916866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLjqg6PN+pm75Wv6a0EOHeiThsk5WjokRwaAIzJCByg=;
        b=IrSiOsWvhAPw/WGCdjNLRFWEDzXO5L4rtHEEexV1lRfPZ8YIEgb/lj/ZXrwFuSbRtx
         bH7QmNcJd9jGJTbv5HFV+XRnTuxwzZwooDloRF0ikLSs9OZmlamCLT8mTZDfVuoj/xnX
         i9yLjX0GI9dypWxTEH8N1RuQU1TLyiOE9ctKOpX1naPgodETft5DsldHVTKmmfNcymAh
         RGxCGegpBb9ADybsa9s64NJU+esauA7EAsqAsoBWK/kRvOrnkx4LZzeWR3sPcCrTlxUO
         PgBd16f7HVmmOx9NtHMyHu0d4z8F6mX3tViuPPBoqY3WS9lx/lsdOhJfSQJfd+rqV8FO
         4pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719312066; x=1719916866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLjqg6PN+pm75Wv6a0EOHeiThsk5WjokRwaAIzJCByg=;
        b=jXcqYwex753DJ9FZSWuAvRIWUexwMrNTuT2utDskzqwseZOE5PZki9Vio43BSlhTvR
         mXK0HZHaPr7HYOJqOKV7InvExoSsYXXZcc7RwTohiJ4RdWuUH5YAt4eVcNKzBPjqjQ9e
         btGVurDEORxXw3w0L/KTN+0aURBBdLeJcwt6D9YKIGNSVjFhk5iq6C2bL2932mxDNTx3
         +Eex/ZIbxyb3XzaoPU0XDCDh6CpDptbSH9hhr8KU8519fN7QbhQtTV+9U/aKmESDtOYs
         CoE8Hn5Gjky3njBTm+e+Onv7SiWLGHbJN2NpOErZ/7U25XBOLYsb3rLvnyVl0amPi73s
         6WbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwuadlHGgiHQ0y8sygF10HJSnvAiPu1q/BtrkVVuLMNiCG2yNjHeNjRL/Wh2JmTnEUhskVdcMo9P87VLo+GL7EZC99DtPpiDbKxrooert94Fe528rUlH+m26D07dV53EunxTYk1wI8
X-Gm-Message-State: AOJu0YweEBAKo6vLQInOkY/mDMEsG/oD2e1NrSFqd+jXfdtOP3NInYAu
	GS9609lbmJaObj3zeLRRbjTeqJ4Ne3QmudxjNkEB6sUdbmKS3k+H
X-Google-Smtp-Source: AGHT+IFYqQAjhwv2qL8UMHq2EMQeLwd7dv1oCSDvlSzxNm5PLh3wAj2R2zDMEP7eB9VfYrxJy3yGBA==
X-Received: by 2002:a05:6a20:da90:b0:1b4:da55:e1be with SMTP id adf61e73a8af0-1bcf7e75050mr9502228637.14.1719312065906;
        Tue, 25 Jun 2024 03:41:05 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065e2c103bsm6943684b3a.92.2024.06.25.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:41:05 -0700 (PDT)
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
Subject: [PATCH v4 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks function signature
Date: Tue, 25 Jun 2024 16:10:34 +0530
Message-ID: <20240625104039.48311-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240625104039.48311-1-linux.amoon@gmail.com>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
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
v4: None
v3: None
v2: None
---
 drivers/pci/controller/pcie-rockchip.c | 4 +---
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 024308bb6ac8..81deb7fc6882 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -272,10 +272,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
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
index 27e951b41b80..3330b1e55dcd 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -354,7 +354,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-void rockchip_pcie_disable_clocks(void *data);
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type);
 
-- 
2.44.0


