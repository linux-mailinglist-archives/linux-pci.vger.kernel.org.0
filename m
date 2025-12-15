Return-Path: <linux-pci+bounces-43057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB954CBEAB4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8463630439EF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106433BBD0;
	Mon, 15 Dec 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im2rH2CJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BB33BBA5
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808207; cv=none; b=KklVgDdIaBi0ZGgfvaUbLqjEW5jb47lKWJlqimuqPhkyCshUx4sUDoEAMnxOYmgwjdNSTz1V1SYiiGO98GaOZbfjUmGDJcU8xJb/kewoBXoci7etL3o8FriGYmuCS7qUjw3nzKoS3SgryFQvvWkAj8XKOa9PuBP2Q8ena7aEOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808207; c=relaxed/simple;
	bh=JtFZo/uyQAWSjmMOB6k1d/9548yEmgKRfxSDFklyJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWC06qdEi6YvYKOgWoUtXW9v+vrCnwvlxCxdoGeGm9Sp9B2FqB1aHi7kLFkSbbJxPfnexJmSZDvyTprPTTOfb4mSqJePHXz9kAUSWXRnRayJwjHZ6ZdkzOCiCeBH3qx4RwqXzb+TvvUUxtf0qsM56EW6gO+49j2Izjon8xok9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im2rH2CJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so2829417b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808201; x=1766413001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/TuzCGlQTRhxK78zbbN56sGpgmiksawHrsvuWBiDTI=;
        b=im2rH2CJL4Svgrj2vpz4+2lj01/mtn21cXDnimM3EXByPnGxl0S6Cq4eFr67sH/FLM
         VOUJ6mesbF/q/eBKB7ICwtxHJdJbAiSuvSYjJSY81thTp4Kaf9aIM1HFR56MIIPiChDL
         pC8dAUB7vKbedsN0JwO05BeUUjG+FSpBx46yCZtEUa5XYPQXgPzQJ0sUfIG9MSOQMSnG
         JlZu7jITE0Ivdzx02qYvK92ZQFsKsP/8s/2AZpOST66K/jOgY5RrV4u7AmCtdHRapjk3
         ltec1OxzLtDaREZfBGyPrNRvpBtRWJuzNUjzZ6RqYB/ZDc1AzqCahv58REeQNiSGrHxB
         OBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808201; x=1766413001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/TuzCGlQTRhxK78zbbN56sGpgmiksawHrsvuWBiDTI=;
        b=EqL8bOKSKQmc944pORpKzRTXfUQt6eWC5cVZNXWE6CEZI51npEqklj47cZG0u4/nOJ
         z0LO9sUw7MWwjQ408UXjC2MP28eNqqohI5z4i3lc489fSAPj0DsPCCaRJtJp2ilm/SMb
         CpJWBOM/PJyFbgu/XLX++5lSHdrPgV8BhSblwrJg3jacvMQdFI9ISowjBymmJ5k5q88e
         NhIxzdlOnzNQP9JG8Z1+YmiwoKvfnkanxptFxCaT+e7G5TbYl5QsIRdiajCgQ+oHylbb
         IbMHQLVUTH0mAFyuYQdnpJ/Z13bHjg8k2+rRflUmq9+dzNaus0zaYCUgii4DcGIr6BEn
         cVTA==
X-Forwarded-Encrypted: i=1; AJvYcCWcoL2k8aApY32cBb26iL5KQyB3JM/7m3RdEPYr2vAkqY72U3gF7xPa5I7G6vFwZW6uyBKqWsaFUac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1L4DWw4DszqtjoPkIqwmylBnWfKNGJoFfIE4qJbLAS5H/mFj
	nIrDcQI6ELXFBJ693UWfHuNQsFyiP96JpJ9vFpUcX6sfAaaGqCisYkxf
X-Gm-Gg: AY/fxX5YHiD6GJ5uFbykFi5hSAfXOm6DJyVnA46Bc2Doi1o2PDARBKjR9cyPsXNYJll
	PhYQkOfj1KKgE8fbsw0UMQ5KnhzxaTLw4l6S5CBUcaxusf7ithdSNJOEJBs9gueyTzGMhYc/0Ug
	u0zUqfXvGI+OHDYaPRMctB63qvZVBh7BbLaGFD2YvvNehn0rcy4yW1/ahF42XnIIh57PMAIQyok
	Z+kB3KTwgmadGWH7VXkdQpMz/DJGPbwDTXuAPQs1WdqIXeYoGJ/DM2rzIL1smzaFQH73jGZHiTM
	ayC/GPnB6tVaTVkOtDil33vdJh4sEFso8woMgqNTrDVC2EG8klu5xpzoklR0N6bnhYYXyaJvpRY
	flnjCFm7qheWKXM/iNhTzASu+wMt8CH68PIFnFjwSPFw3jbMXWfHJHc05aXLtSGLhZAH2ZPg/BS
	N4PjYLXA==
X-Google-Smtp-Source: AGHT+IHofev4tgipZDGPnuJ3GMiH1rsQTbZ29334XG9Ue8yjcy1ZxYa5orNEikBSTFF67OplRvrkjw==
X-Received: by 2002:a05:6a00:450d:b0:7bf:1a4b:1670 with SMTP id d2e1a72fcca58-7f66763cda0mr9290540b3a.6.1765808200740;
        Mon, 15 Dec 2025 06:16:40 -0800 (PST)
Received: from rockpi-5b ([45.112.0.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2772a51sm12938189b3a.17.2025.12.15.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:16:40 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 3/4] PCI: tegra: Use readl_poll_timeout() for link status polling
Date: Mon, 15 Dec 2025 19:45:36 +0530
Message-ID: <20251215141603.6749-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215141603.6749-1-linux.amoon@gmail.com>
References: <20251215141603.6749-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual `do-while` polling loops with the readl_poll_timeout()
helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
during link bring-up. This simplifies the code by removing the open-coded
timeout logic in favor of the standard, more robust iopoll framework.
The change improves readability and reduces code duplication.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: None
v1: dropped the include  <linux/iopoll.h> header file.
---
 drivers/pci/controller/pci-tegra.c | 37 +++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 275d9295789a..336d2cf4d828 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2156,37 +2156,28 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 	value |= RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
 	writel(value, port->base + RP_PRIV_MISC);
 
-	do {
-		unsigned int timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
+	while (retries--) {
+		int err;
 
-		do {
-			value = readl(port->base + RP_VEND_XP);
-
-			if (value & RP_VEND_XP_DL_UP)
-				break;
-
-			usleep_range(1000, 2000);
-		} while (--timeout);
-
-		if (!timeout) {
+		err = readl_poll_timeout(port->base + RP_VEND_XP, value,
+					 value & RP_VEND_XP_DL_UP,
+					 1000,
+					 TEGRA_PCIE_LINKUP_TIMEOUT * 1000);
+		if (err) {
 			dev_dbg(dev, "link %u down, retrying\n", port->index);
 			goto retry;
 		}
 
-		timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
-
-		do {
-			value = readl(port->base + RP_LINK_CONTROL_STATUS);
-
-			if (value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE)
-				return true;
-
-			usleep_range(1000, 2000);
-		} while (--timeout);
+		err = readl_poll_timeout(port->base + RP_LINK_CONTROL_STATUS,
+					 value,
+					 value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE,
+					 1000, TEGRA_PCIE_LINKUP_TIMEOUT * 1000);
+		if (!err)
+			return true;
 
 retry:
 		tegra_pcie_port_reset(port);
-	} while (--retries);
+	}
 
 	return false;
 }
-- 
2.50.1


