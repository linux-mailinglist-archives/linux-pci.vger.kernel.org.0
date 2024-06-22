Return-Path: <linux-pci+bounces-9112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FF913258
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5493F28400D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BBA14C586;
	Sat, 22 Jun 2024 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0rJ3Z5K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2D14B078;
	Sat, 22 Jun 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719037158; cv=none; b=Y55mfJLKFYpfJh/DJop1304txpNULkSK23BGjrG1T3zERnOVUzR/rMXopIJfyokvtBjNJEYc1/DcLCkBJSxvBIIVU03w6JHL7CO/yqd09HhoJ5J2sQeuHsyOuo3AGfsoHIU1tIS2lbmGounDojgPYEAIAnJfngjjl/s9KRLmgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719037158; c=relaxed/simple;
	bh=VBz5/yQBD7J+HuI9LmNFQ1r/JcHYBt/AtMtq7zxIhEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3Rjyv+8vJNWIrG5p5LERTjYbEFh7EjgZjgNQ9wF93MYaWBQBXQ+pAL5xWZwcaOQXVeIaB8t2sALFWDz9PCplT38z09zJT7wPTqCddOF6F5dtX2cbL/xaeRbsIpGgixlwe2Aiepc6/zNKazJC483/GmIgxZuhSUhPddF96MOVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0rJ3Z5K; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7a6da20f2so2261984a91.0;
        Fri, 21 Jun 2024 23:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719037156; x=1719641956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntwi3HL2K5aymeEm1Qz35sLbHMAl5G1vzWWeac6e7E0=;
        b=h0rJ3Z5KGpVZMIjJL2VVKlD4KAQX62v0ap9jcpIu2eZnsK7QELcdAcJ/a/5lJ5beMS
         dG2Ubpqw524edCcoqGx8GfAyTniJ1l13lxuPgPWhdPkC/yUXjvkAhFhtnIwlIHT2i9IW
         c6eTaXSq65sgylohgLWNSZqVeOxCRvsBX5yD6EfFJ9oZ9sSJkMEmTWeOrPXmBk+GdEA4
         mGzDbGgLL5VYnFWaXgm3ZSgh28dXrsu9ibSD2SGzrXq1afqe8n23KyPZK4yyOHRzWrVE
         VbMsxdwpZ9p744vkT9WVGK/zNuypObt79gpurssEw4szOCiAEHW4OkdKN79+IYmFtTiQ
         sALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719037156; x=1719641956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ntwi3HL2K5aymeEm1Qz35sLbHMAl5G1vzWWeac6e7E0=;
        b=gn79PZK+/aPqb5c/IFMm7yYQamSraIfBk0YKIHPxXofx5rfNwr7i6g+kvkhuyjIbmC
         zM0bCb5yeaQ5x7ypb6shZw/EgBoicxua2ENevfY6zALiv/XHNayar9e31jLKG6qmIfxz
         2t8Ttci2h37uCQdGad6LQIx1jO6WV3A/4ExGmfKnEbJlb2wvLZX9sU2CS1X6e2MavnuN
         /3egc06Y0m8GawAWle7aNfkc2K60QyBpER4rlqCYw+XDyLj+3hfBj5KVnln0m8UTAQHs
         jKVJHxMurUcVFrkPt6TDDUOedj45BZZeqYVs4v45ZDku9++pFIL6oPCRLM7MZn9/mQMZ
         W7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVvZSEd70uS1WOLOCSgI8vNdZF/Dc40BM2uOoGEU32hnfD5lfJ0OY+WIGaqq2Rn3UsGnj1EDc9NqGCpM7AmA9bc9Y/2VKTSUc6GwNccMwmVbEeYt7RwKBHJ7IDAuAAAHD06heAmZLUl
X-Gm-Message-State: AOJu0Yz4zk3umlUnPJ35IhaMfCcqUNyorjO9UKptkw3evDI3qcNKJ1qO
	XVMULCuee2QPac++Mmi68j6GQVCPHlVGun/lffUluToseA5WQ0TZqdPWZg==
X-Google-Smtp-Source: AGHT+IE078jZ03UdYebN/k5h4osUfnzBl8WDffYTEdCg2kBOJHT73FdNJJuuUWpAkRO1OggjBayIKQ==
X-Received: by 2002:a17:90a:a017:b0:2c6:edb4:1c96 with SMTP id 98e67ed59e1d1-2c8505195f8mr161149a91.23.1719037156523;
        Fri, 21 Jun 2024 23:19:16 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e7bf0sm4692240a91.19.2024.06.21.23.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 23:19:16 -0700 (PDT)
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
Subject: [PATCH v3 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks function signature
Date: Sat, 22 Jun 2024 11:48:40 +0530
Message-ID: <20240622061845.3678-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240622061845.3678-1-linux.amoon@gmail.com>
References: <20240622061845.3678-1-linux.amoon@gmail.com>
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
v3: None
v2: None
---
 drivers/pci/controller/pcie-rockchip.c | 4 +---
 drivers/pci/controller/pcie-rockchip.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index f79e2b0a965b..da210cd96d98 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -284,10 +284,8 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
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


