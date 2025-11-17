Return-Path: <linux-pci+bounces-41441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FAC65AA0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B645A4E4C82
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013830C633;
	Mon, 17 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRil7mw/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FBC30BBA3
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403038; cv=none; b=sI30dj6bH+MR8mirn+8jOdfPf60vjZcVecKUM5KU4AgmKbJQ4kIjkaWH0Y6WzwwInNrg639KhsS1XAFxOHFaDV/yqDb5cTtLpiyF9GnzAA8SsP2LHTrK9niMg3mK+Vd2+fq2/YSClGR/Q75Xq8rqy6eniUkqT83rcEjZmAAuXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403038; c=relaxed/simple;
	bh=IzvkkeXUMnzdOPJSEkSZkUMgi7ndHyTg0pFhz11lKlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppfdb0v3xcL3AR8Bx2W65oyc6KvO+Txz4MdFU5UaRwGHIVy5HKiJFrvGuoM5uGr1mAd/vJMAl5ls413r5SeGdyWtaZcvuF4lZoDtKCmwAW7JUbX4uhXA04qhGh0zpKWkwVzOwi21+9OxHnDIsWAVJyyACV4dHPaTL4NiM1PBE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRil7mw/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29808a9a96aso47540265ad.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403036; x=1764007836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+EKY9tXpDqbosng82pC4u0rmGAubkf6qXRrqvdwmlY=;
        b=VRil7mw/ss8XBJzYm9vffq0xhU7BHjJOKxYQh00u9+lBlPTQ+Atyk+iOK7pujbcoiS
         7wV1iQTJmJnwhTrBJMWgklOMWohez0CDmyVQagBX60THoUPUn0rwyGZcseyZNMFd3/G7
         Emib+AVaiBU57gVAzt38+phF2b8P67jgkL1kEtyG9gu23ydyqGdAAnCjyjN41KZKIUzR
         eGaQLPYEzhx/+vqdk6FDiopAe+WDrY1pEewnljdb43XMLACPb3fN2kqgI0bKby6PwvRp
         /o0QsVcST3Nw5mRx62UyQHS5WFJEizZqbW8lhuXYVB7lo8mpIjfEGndUPrsQCY6oNUtw
         KE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403036; x=1764007836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+EKY9tXpDqbosng82pC4u0rmGAubkf6qXRrqvdwmlY=;
        b=iFMKRPqeZVhFKCrTjwONUnqoEcgnnz6qpwp0Mcy0bAjtM+5IgIV9NruOI21AqMe0QG
         vbFC8zfMVBGBTT6Lras5E2jPoxliL/1HLFHfQBeDYdUjFkr5zTIbgzkSkm/Gtw7pwWs8
         TeBnYy0UAMM3IdYjwe/EZSae5oijtoyOJ0zSrjTqEu84dPzQaoRNKmcPWZqQIzLZ7umq
         qsCizT18hSFHXQ33ZXi4jzeyKTJdtcDFkodGb9FIu3tj09z5mF/McWXm3s55hFuL6q0G
         OzulAUoZxRJz38//FO28HhnFpE6AS/aY8dw4mDOMQhiMNglokgE2c5+iArT5++O0EUkT
         cgwA==
X-Forwarded-Encrypted: i=1; AJvYcCXozr/E8El6OeuOCll+AdAbYAhUnTP0jzcxdIuJ0zC6qF5khEc/YupqRjWl8VH2IKrXiHZ8Lt35vDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymoCuMQWxtM2lrmNiDuKjB9p/2hY4BCjyt5XUyNRsGsPbgNLrv
	9KQFfRK3bp5IhT6beVRPN9f0fHwnotoBo3NAQ5iJk8bRF1JuR/kQFoCx
X-Gm-Gg: ASbGncufxvuGTPAWiT5pvpWV+QW8nT9sH/gwPPI1eZfG6ZpEzBVJyK+ikeZUXi/4bma
	ElhMsLbhGi5hbzQHrwfOfmIrOdMB1HyCnyljqCTecnUdZCSyBLZZk2ToyHYm9SODHrqWQcf3+Bi
	vz6Mu6ERxBnyAyU7agpzp+VxjPAh2NlAamHOIyZC8yMOoIatiVaAdKXJTkOkqTjek+EMKP8M2YK
	s9dK2TyFH/D4xiLXvCI8p5iQ23UFMo2OVhN4itRyHBK6r7hr5EdXD3JYV0xrJR4eumzqL/QJq+R
	R487yDd2RDhGpkVmM0WMYFVDr3O9jVUgYIlhWTxG88830EyLh96ZEZ7pfiGYt11OYs9S7NfDze2
	T2WQl8xHH2QEhylhORsFGlqMBV9r1FJjVFr8s4xA6v6bfmLrE2GkRxprdDkhyDdGsxWYwgeZsug
	YbEEWSYdFm
X-Google-Smtp-Source: AGHT+IGeyCwjL8jXeUnUvtXTHW7ITleNa0lMicopabeVmB9BMPeOlb78pEgF+ubGgNHai/Yz0yRVgQ==
X-Received: by 2002:a17:902:cf0e:b0:27e:ef96:c153 with SMTP id d9443c01a7336-2986a6d5195mr152554635ad.19.1763403036292;
        Mon, 17 Nov 2025 10:10:36 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:35 -0800 (PST)
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
Subject: [RFC v1 1/5] PCI: rockchip: Fix Link Control register offset and enable ASPM/CLKREQ
Date: Mon, 17 Nov 2025 23:40:09 +0530
Message-ID: <20251117181023.482138-2-linux.amoon@gmail.com>
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

As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control register
(RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex (RC)
configuration space, not at the offset of the PCI Express Capability List
(0xc0). Following changes correct the register offset to use
PCIE_RC_CONFIG_LC (0xd0) to configure link control.

Additionally, this commit explicitly enables ASPM (Active State Power
Management) control and the CLKREQ# (Clock Request) mechanism as part of
the Link Control register programming when enabling bandwidth
notifications.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 15 ++++++++-------
 drivers/pci/controller/pcie-rockchip.h      |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..f0de5b2590c4 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -32,18 +32,19 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
+	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE |
+		   PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -306,9 +307,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 3e82a69b9c00..5d8a3ae38599 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -157,6 +157,7 @@
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
+#define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.50.1


