Return-Path: <linux-pci+bounces-17545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861499E06B5
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 16:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D1283954
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF1204F9B;
	Mon,  2 Dec 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDmVS80Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5ED20C001;
	Mon,  2 Dec 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152350; cv=none; b=VnS8j6ew6FwN5xHRYKbC+/8EWXj+Lh0CKxIdJkF6N3PK7o9hFNKKCchw1vuU+Iqxefu4w3bTle9YnIE2nSi9uALYIpJwCTGDmqXo/1uWMvfOEpp1umJLFJWh4fwYRg7CFEM3xV7hAMo9ZsnTogIEXDVNl+kPjYsZhgPsmxq2IA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152350; c=relaxed/simple;
	bh=5TRmdjaRKkU3cQw2wdH+BT1y6ZhhlwxgglF0P2Me4uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhCwx62pag42SV81NyUtg3tZulVV7RcX0r0hvuBcg8yGXsuc1TN9N8OvNKFbZFZ25ZCGcT7mvY69YCcvqAZq0omzhJA4JjkhbPfKjgagpIMaUej/L/kThGG7lNQbRdaKfnRm69C7YnAQ3wA87Eu7PagACtF4C3EyvKlZfhbFF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDmVS80Z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251abe0e69so3720193b3a.0;
        Mon, 02 Dec 2024 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152346; x=1733757146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvFldH2UE7l++lKguJ5UKXHzEK7JVjP2Z1XY9Om0QMI=;
        b=NDmVS80ZdL0tIW9omYTUwLkI3Kvq3dyDCxbOSI6lvKKpyxnuGcQVjbOEiypBfWm11E
         tG/GZdNrsDq31EiVYzASUOJK0uUWPOjMxpL2YgRzISLgYDdbZXhhyhKQxvPBQJ+v+xfY
         WUuzelYgfTE+IwTtuo6SmOImuDi5912QwtKze3f5Oqdo9Qvno8KCNwPXuNKrRktFHYx4
         hQupBq7B4xuL1BZ8PwF5aohCXyZOmfRKWw5lmc/REFs+HJw6sbka9sn+1z8hz41GlTTX
         xCLmdyKB5arZNqwxA94a3sP/D8ywhPrifc+hO5cW7NuheuF5aczQD9jG22qStK0vZBzG
         cc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152346; x=1733757146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvFldH2UE7l++lKguJ5UKXHzEK7JVjP2Z1XY9Om0QMI=;
        b=XSJ5pfiY8W4uwR+dwmlRjijgIo7IGPTcNsoekCxteSn5ZnZfU2yJ346JZIl12jEa08
         FMN8Jax046uoK2B/j+ixZ9avG7BmMlr9ADYilu8xIrvNp8RWGixWi8QToAw9kfRfIojO
         zgxN72cPCjC7QkTdNcqugV29dPzQZRb2QMh6LKfQXiXxQdNQIIO3bWJE1sOMyzFDVc1e
         kT1c7dzpbK7qh2oA6Pl9W/qy2aL+C3iRw4WJ5D0gT+WKcCh1ISnGnw+W4h4MfR3zdFo9
         c1IXpsyFzWJpoNkeyGmC9H2yo6K6hBtLE3SB1ci/wdWj/ZdLu9oqJ+/hajfDpAEGznVY
         i7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3zYrAWIOpZc6mUdhBbjCymOAmJ1LcdFuS9cuGKcZTNrfO6O2MQFKcBxdlPHwcD/q/z+MRaRHYHEA4@vger.kernel.org, AJvYcCXmqlFdrBv1s447s/hgcNQo4UKjdnBSrNavTMF2EVkI74kphK5DnopeDY/aNoxXkDbgG4NRv3+1SqJzFwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR3m54xSprj01fJ9B9VM0sWpEaaXV2dhj3quFdWiNm70gKKOT
	9fTC5xRm6xWw6wWui6WGUQfYodkWJcIvNEaElbW1FwS3Mvz4V73H
X-Gm-Gg: ASbGncvl/7R+GeN9fUp2JTKLbpEwgrMbvNiI+tpQB33eYLC6fXPZ5i1mMyqmYt7S5v3
	7U/q9dwMoZwZOuh2jfPOjBye3R5Pk6RA/81RDf4MzwVEYQlSu1wVxPo4Gb/3khB1bxN15IQHsu5
	J/43WzHrGyAO4on1ATuU5SqXkS4gnOeu+AtAsG3K1T+NWkvqHcBa9HtPzOXYJXd6nPrpw9PGGm+
	F4Pml5Jwmj+TDE1g1oHqcDE/aa+fKEmnmr3mS+Twwah8AZGRd3fmcFFdbCNbt+pCA==
X-Google-Smtp-Source: AGHT+IHTR2hBzTrmzTq4eocYsWa/4g+gtB/KL9P+ADubc0lgHB1LE2z0JA3Lf2Omsp9qmYl7/gxbIw==
X-Received: by 2002:a17:903:1c9:b0:215:8af7:eff8 with SMTP id d9443c01a7336-2158af7f30bmr61814845ad.52.1733152344118;
        Mon, 02 Dec 2024 07:12:24 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f1da4sm78524955ad.12.2024.12.02.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:12:23 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
Date: Mon,  2 Dec 2024 20:41:44 +0530
Message-ID: <20241202151150.7393-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202151150.7393-1-linux.amoon@gmail.com>
References: <20241202151150.7393-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the rockchip_pcie_disable_clocks() function to accept a
struct rockchip_pcie pointer instead of a void pointer. This change
improves type safety and code readability by explicitly specifying
the expected data type.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v11: None
v10: None
v9: None
v8: add add the missing () in the function name.
v7: None
v6: Fix the subject, add the missing () in the function name.
v5: Fix the commit message and add r-b Manivannan.
v4: None
v3: None
v2: No
---
---
 drivers/pci/controller/pcie-rockchip.c | 3 +--
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 693aadc99d6c..fea867c24f75 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -267,9 +267,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
-void rockchip_pcie_disable_clocks(void *data)
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip)
 {
-	struct rockchip_pcie *rockchip = data;
 
 	clk_bulk_disable_unprepare(rockchip->num_clks, rockchip->clks);
 }
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 87041ed88b38..11def598534b 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -369,7 +369,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-void rockchip_pcie_disable_clocks(void *data);
+void rockchip_pcie_disable_clocks(struct rockchip_pcie *rockchip);
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type);
 
-- 
2.47.0


