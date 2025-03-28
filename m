Return-Path: <linux-pci+bounces-24932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85EA748D6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27C93BE309
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36283214A7D;
	Fri, 28 Mar 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=friendlyarm-com.20230601.gappssmtp.com header.i=@friendlyarm-com.20230601.gappssmtp.com header.b="FWdzvTps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8F2135CE
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159576; cv=none; b=WziEt7811QKh1lrQlA7+OI0UhRlgXt9oGXo9k4hj/TgUjv0C0P5Z6Q4Zx72jSSLvFTIBxwybAVUMlh7tu1yiTNsCqnSw6kyxv3WxkyKlo/zJtiJIkFXKZXWJwrZmVn6v0V/vjHU1nslGi77Fk8kIqfN9Lpu8YF5R1+Pj1yqlvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159576; c=relaxed/simple;
	bh=wyvzx6aL7zIW8l9CT9CGKBFa3TtXPNgrV+U99H/B9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvapdY9B8aHimdq4E9ho+/U5dYwb8mrDkynUyIKKBcOYq2K/IhSkktQfqbpSE5wUNINSArSkdLa0nulF1dKJrFPe9B7JtDP15jtgmNgH2Zgh3vJbuqOhNBBRCtYalcDnBzamSy3JE/lyYaKLao7Qzs7pvB2Xe9oKOJpGVghYUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com; spf=none smtp.mailfrom=friendlyarm.com; dkim=pass (2048-bit key) header.d=friendlyarm-com.20230601.gappssmtp.com header.i=@friendlyarm-com.20230601.gappssmtp.com header.b=FWdzvTps; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=friendlyarm.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so3611519a91.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20230601.gappssmtp.com; s=20230601; t=1743159574; x=1743764374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHj6gQ1zeVt3QGQTw+FIAxu8YW4dxt5y3xOPYH0BIdw=;
        b=FWdzvTpsLLL8b5Qt/Ib9OrO9fa9OfOhm965fQ5sw1uB6zyeoZaIcMejwi4rxjt93EL
         awqGdHdwPl4X6oYdY60LIGSTqW7PgrR5U9ImrfoXqQ2uPs5YVQNV/Lb6U5/4acICa+Le
         if/No6fcS8nWUPLOoE1nAsBhb8ghyXcYaoyb3x3fbv5h5bel9I2m9iW4Bu1YcyXoih2S
         7SipkNaE2oRiRC5Hisn9JLAn3QHgiYjiOYPHgtAUT3cBD6dhPGUiGx/iTtbkbdiixUnb
         XiNzkHj4M6Uk0OiPggbfJvK7CkL17ZAlqntSkLr1gaREkB8wktOtElkXueO+FT/XyTj1
         MzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743159574; x=1743764374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHj6gQ1zeVt3QGQTw+FIAxu8YW4dxt5y3xOPYH0BIdw=;
        b=xUL/HB8QjP1o3BkOaa+W6m4HIJoIu1kx4KL/scMnVFkqK+kIeb5k95U5GWZswKk5XJ
         Tchk/1YGPk8JHHKSouLh5TBWB03XKKXHc5j+eSL6oz5zSeMDg1dLSTuHmzoihgDh2OX3
         +PhyuGKW1VK/KaYvVov2A2q0Otq6+ctKI54A+CDZGYuShv9wSMe4mRq56eMQTTtJ8NKe
         i9sDBhjX5iXpmuXd74DqykK3j/5WIPlEhr6puZmxGgGMUHv94d29XUMENBLkmrceNb9X
         gtaIawsxSDppz/7wLxhMpktBQdepzyQvr8pwM4evmMd3zdNDmQs1YC+PaPjUkwCf5Gaq
         YI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsFyW9E91mXfnuO6zublr2WHxRPw15vAgdj+hGh+UiDtEvnseKrBi1sWGllZiJDqIhBQCG7ELCUR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLE6tMdyUMvsv0ttzgBbMjpz5elhaldXwIlGjs77A8do+9sLPw
	idRAu5iaoH7x7NU4UUwS9CzMRBU1DgVc6hpaVP5SaU3bCl4PzsGSJlqx60OZYso=
X-Gm-Gg: ASbGncug0w8mYAVazFR3tZ8LFXyw2/O81/UsQH2X8Az8fh2zP1OujeTu1+8dE5aj6l4
	dE0wLFNawd8+6gBGqerN+uqTi0feARgDU/4W5e8rNF/VB3KuDsaMlnoePaPIkUUSllYmAGUcR9N
	Mu0e2396UzboC9goEllsxm+oxxtVWhHxxifFCa40DnGyVYIhil82kJN7lEQiFlhT6vmA2B7Ay85
	NhOBHKnACRe65UO3gLUFehVBUOMl5cisB4CmchjJjiOwW4lYxRGLRM7TNTX7RzmmJ8cLM1Sn/zp
	AFPqPh3/PodaseRusgfZ0Kn1VN25OWPqDwXATqLrbq3iwYbMKP6JIU7xubX8oNr3nkbe
X-Google-Smtp-Source: AGHT+IHCY/P45TjdQpykRBnac2GduXlszHbzvBxCFlitCRhl0UAFu8AkE4JL9IObg2JicXApsmQMBg==
X-Received: by 2002:a17:90b:2645:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-303a85c1c47mr11926254a91.24.1743159573765;
        Fri, 28 Mar 2025 03:59:33 -0700 (PDT)
Received: from localhost.localdomain ([113.119.38.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f1d4efdsm3844649a91.34.2025.03.28.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:59:33 -0700 (PDT)
From: Jensen Huang <jensenhuang@friendlyarm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Anand Moon <linux.amoon@gmail.com>
Cc: Jensen Huang <jensenhuang@friendlyarm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
Date: Fri, 28 Mar 2025 18:58:22 +0800
Message-ID: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
X-Mailer: git-send-email 2.49.0-1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of rockchip_pci_core_rsts follows the previous comments suggesting
to avoid reordering. However, reset_control_bulk_deassert() applies resets in
reverse, which may lead to the link downgrading to 2.5 GT/s.

This patch restores the deassert order and comments for core_rsts, introduced in
commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").

Tested on NanoPC-T4 with Samsung 970 Pro.

Fixes: 18715931a5c0 ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
---
 drivers/pci/controller/pcie-rockchip.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 11def598534b..4f63a03d535c 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -320,11 +320,15 @@ static const char * const rockchip_pci_pm_rsts[] = {
 	"aclk",
 };
 
+/*
+ * Please don't reorder the deassert sequence of the following
+ * four reset pins.
+ */
 static const char * const rockchip_pci_core_rsts[] = {
-	"mgmt-sticky",
-	"core",
-	"mgmt",
 	"pipe",
+	"mgmt",
+	"core",
+	"mgmt-sticky",
 };
 
 struct rockchip_pcie {
-- 
2.49.0-1


