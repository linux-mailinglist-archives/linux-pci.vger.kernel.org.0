Return-Path: <linux-pci+bounces-41444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 737CDC65AD8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F84EBDEE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA62D6E6A;
	Mon, 17 Nov 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBFytu/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC276314A67
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403057; cv=none; b=X2bKbePpbZFWL77xZtnxQDx/eBY2X2qc1dSL473/k+/tohtMFtjwnS0/sL3LI2FWwClAkypHwY8VYcD6RDb5EGeFEvNA1dfTLza5SIAbQscK4sswoLUh+TthMm+Zca896sEsXGyu5lPwTO7wBE+GGNgyQqHGSEvt5xFS4wp1HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403057; c=relaxed/simple;
	bh=qq+FPtm/d1QsehqCCXel+Z953y6JYcKkrKX8vLhpquA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1OFE8N85W7YVyLTLYLZiqZPqBG3tmFofits5J1FQC0YyWWsKf3cVN5fPj3RhWhAXLm+gkfMm20VQ0iJG/CRvGmePxEyIsMtb+WE9254kk/xcCUt6tgEwZr5V+ERnrxYrIHcnCXGWim0bRdT1fquRYEjit9XAAv4VS/rtvvc4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBFytu/F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dd95ffe4so41677025ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403054; x=1764007854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec1PASGse1c+caWp4ium+eJ62vTRL+jpVdDXW6vSJlU=;
        b=DBFytu/FgqUtYwrvYYQ01/6bSh+OeOoltP1QBTYbh04ltVqGhQLG1Afv0Qv9KJXRJZ
         CIFovhcIEEbSiJkTFD6U4xFjV0j2E4N9ehDhO75a0DEuAVVUYfbM3PQ6EmFidlZDCjWx
         KKTSh5OtTwLcbEp3koMTlmPsyEpVp9VJbGcSw+0hYWaJRq46nXdPFS8oM9UcX8OaA8FI
         7XaHnKQZeKwLmp7XB2rXzYeKNrJf6pFpplDErfmX5D9/bcsiTY3jA9tTynaa52XDeYew
         dGLAS6ZV22TSnphKAYvipSOxsJ2/mNZkxsZiHJwz+JKoxcg8i0BnRXRGp+RRsD11qpfE
         Ch3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403054; x=1764007854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ec1PASGse1c+caWp4ium+eJ62vTRL+jpVdDXW6vSJlU=;
        b=HY7NwfL4pdEkloFyTX7W08ZHGWTOB1FFfGwCqDCpR/7I2W8xzVjlpCloz9YZ9jJo2J
         YEKnQGWg7M8O5b4FlKSmsb5B+tel5FKFYif1fwf4PaJx9afgFRLszDQOB6i1a4fScGQW
         qeNzs980qmT1RsKGRBBvS6BjabNx0JuRD+SglCs9i3qaMqbwvUz/wVEpyBdNrH4/96iM
         4rMeckrqQQNfMwWwViPi0lgimYVgBIT5t1Fb9DoMK+3tml+9Xtuzc1jkBti4pLQbdBUH
         0UZycKDUe6woaQCyHyiNsS5zdpZvBza0yKiyQ6aJeDa5JZPXtBT/9qiW2HACsy4v9S2M
         4cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYIzFmRm/PE3JS910SH29dpDxaNA0thzRNLeP0LIJ2OVBzBi3Lsr/va539j7K/avOv3V3EPqFzNQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmVcsUNyVgEOGt5f+17zCl2XZmxFDrfdBbGoT6Zc43HdGtUz+
	RkfquTP06Tl/elRn/5xEzjBP07Ddv8Kql+IWl/v9laANUm4jvh37R6xP
X-Gm-Gg: ASbGncvY2UBhdY3yZjgSLw/pmH6Hm3HCe5FWcd4s9FJfTTqNXimIRFdwgmgcQmqgr5K
	h7HL3XriEjnKXL4IpiqzR9GE2tnJwi6VhqrFU/yhSPhHamMZ7vG/pmcxJsRtKnNxp/5aKntMvLk
	sNrr7fse0GyAqdAuShP9YWALaRPgagQtoTa6ej/hvWuHCXGldrs25QUyFUnqeE4NtxhcaDS6Dem
	2mIjxJk9IFeL5U2n70Y4TpUpzAOs3cI8pUOmu2LBi2p6dmLkSrznHNn7E64jG/OGbt6wMRrV1to
	Yf6HmiInEzr6Q8G2VY+SmmZH1E+cHeic/DaExCXydtRt1hvBCofdteuweGwkM+Lk9m1nSs2/1IK
	7y1LOyloWy/k3MYsjLUNWbMqPCHgxDrGVVAC9WqAhrXEHAeK+e0WIHg8gvOAfXxjwSK/c5RkM4h
	y65nofn/hgAoU2iuzq1mQ=
X-Google-Smtp-Source: AGHT+IEUX7gdiNGyBxK7nkjr4GlpB56cu5CyrGhTV6Ssy/ycoKGnwri45m/PO64RRMTu5afoMBqkIg==
X-Received: by 2002:a17:902:f792:b0:299:e041:ecf6 with SMTP id d9443c01a7336-299e041f532mr74992515ad.40.1763403054096;
        Mon, 17 Nov 2025 10:10:54 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:53 -0800 (PST)
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
Subject: [RFC v1 4/5] PCI: rockchip: Fix Link Control and Status Register 2 for target link speed
Date: Mon, 17 Nov 2025 23:40:12 +0530
Message-ID: <20251117181023.482138-5-linux.amoon@gmail.com>
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

As per 17.6.4.5.11 Link Control and Status Register 2 (PCIE_RC_CONFIG_LC2)
reside at offset 0xf0 within the Root Complex (RC) configuration space, not
at the offset of the PCI Express Capability List (0xc0). Following changes
corrects the register offset to use PCIE_RC_CONFIG_LC2 (0xf0) to configure
target like speed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 drivers/pci/controller/pcie-rockchip.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d77403bbb81d..b3c9b9cbeb8d 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -334,10 +334,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKCTL2);
 		status &= ~PCI_EXP_LNKCTL2_TLS;
 		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKCTL2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 4ba07ff3a3cf..a83ce7787466 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -160,6 +160,7 @@
 #define PCIE_RC_CONFIG_DC		(PCIE_RC_CONFIG_BASE + 0xc8)
 #define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_SR		(PCIE_RC_CONFIG_BASE + 0xd4)
+#define PCIE_RC_CONFIG_LC2		(PCIE_RC_CONFIG_BASE + 0xf0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.50.1


