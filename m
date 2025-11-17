Return-Path: <linux-pci+bounces-41442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92EC65AE4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 19:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8834E18D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D330ACE8;
	Mon, 17 Nov 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLVHa+xl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF1309F09
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403044; cv=none; b=i0cv3Z6wsaHowhwdNUCVQLg11bz3Vvidd9bfSD+I26QqyS/p+g1giEizBg+ZgBjpPEM7Khfan0H/8OBqiZBvGjOycV29YNSc1HObql97Pw9Ysyo0hAocteuinNDmL9rNu0BWiFHWbLovLteC1vRis1ibm5P8HeERVso4jjsmUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403044; c=relaxed/simple;
	bh=8FLrRgdCqSoWhuh1HthXwgdAsewLqdyV4yFxFtG7lc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDMXUA+Ot2lzKBXCYGW1ML3/0Qi7JLuPnt4S/Bo5xLm72gnpYypB8ihXMQnWbMIwJ9rsCPNNvbxwGy0Ox/uff3cA68fEfjs5UpYe+mrbFFNh0NbeW+S4h5vOJN/2T4jPMgp5ZjcyWWNa/6tmlya/bw6k71+GQd7fmn3egIsn/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLVHa+xl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297d4ac44fbso41675915ad.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403042; x=1764007842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiyfD9o81mhFVe2IXX22fSEtB3j8hw+9RtRzlWaHF9U=;
        b=gLVHa+xlWhsUIdswBmEdOiCLbL5CNwN7DGLn38vbvn2+BggJgSaBhLRupxotYaXCpU
         M1xYnBsnDcVZ3riqbEDy6FwNAVYaLvjPW73zPsYR3N5SxBqROZ2/zpBVssQb+Zkf5hPQ
         vAeZUi3xxFmTJoO4SBBmm3Aw6F0UyTLkcXNWElh2TpISL5rcgeiF9lAPsjLUJy2MPgB7
         uYicwZVjVjH7FxfpWZ6/ZIWB1ND4jrPA2PFKv3RQ8JxcjJfyGNlP8OSxheVzs5V7Nk1p
         0DRcpPGmUbseXzjijLXTmv1VttL03sVMp2CB+smeQrEHXI41geSbdkTVDqXjnKUauGT8
         qxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403042; x=1764007842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiyfD9o81mhFVe2IXX22fSEtB3j8hw+9RtRzlWaHF9U=;
        b=vVLFoCT5ai3XdR9l0l8DIIq2CdTjswi6uVr4H62FVIN3ZFTFUVxfJlwDigXIN7rp4X
         5pmhjZKCNLTBClcGRck7hn3CpcYguOm4bOL3SbWXxb/AXZx41OF7oiswoyWLudz/RkC3
         fyBYQWPxqOdwij//oBPHiWem/woOeq+mYAKX2XxpTFSZzvWGq6u/G3nk1kQg4lQ9NOm0
         +qt445Xqk+n59tERz1PJQFFwS6jMZxglorQabOYtupRxSIXomsicLHNlvlYjsQZv93jo
         5bNZHLRrOaonaCiYu7+kc2Djc7ypn0bFQzcDMBx3xZYZkQfSMyAOvoR+9r5sqKYNh8EE
         wKsA==
X-Forwarded-Encrypted: i=1; AJvYcCVWltVZezsIisl/HVjYo5X0kxiAqRsMrps9Sbk2IwVmlvA3040pl0DQPgIYYHDbscAoBN8hzHmd1fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzxSM6amz0mEk7As9YA/9qdI3bK1y0yu57XWxt5z2nM5ADt9d
	X9yfE8jwgroLFst/8GjWUgmrj76B3NWi0BxaHRIe7UCAp/dNHRgncavZ
X-Gm-Gg: ASbGnctpt4zzytRQvPVBaDRRiYQTb8vo2XyFcY76PYbT3M492fzy3QTw6YD96nqLqYs
	LGHsleg243QTV6kpEQ70HBmiHqM3BJmyYIQwRb2gfE/GY8iZPW+biJzxaDMC6cwZAdudleRpe5B
	TOFmQyyGMsX4QbN4P4XPqChVMyjQSAWx+hebUctVXZip/Crclgt6lL4TOHwvrkblcFUiW9zyWdr
	8TVfhszafPxQAm3Cq7JbQYtAgHD2YJz14sSv/H/ABZFwHM6yCZdLUpT9SCbPDjqCfebCIvQK9YJ
	oSLZdOSbskWD/axffKDDN/ycvIS5tf84nDBOZLIdHFZhjvn5pMivD+gbChIquxfy4E4Cow/tvBU
	YvcaPmwiyOv5+S6wMzvP4XPw84zEC4wbcbuA9upNKpnoX/PTW/jUeXOe0daHLZzXbzL9/8Caw+c
	z6Q12h8L6h
X-Google-Smtp-Source: AGHT+IEuH/QkCta7rSFSTx6mLuh1Na7bJwzHG+M7fE+y1+6A8oUVr+VmAtfVcXC0t4C1FaCf1X60/g==
X-Received: by 2002:a17:903:4b30:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-299f5512becmr2969585ad.10.1763403042469;
        Mon, 17 Nov 2025 10:10:42 -0800 (PST)
Received: from rockpi-5b ([45.112.0.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm147237955ad.32.2025.11.17.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:41 -0800 (PST)
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
Subject: [RFC v1 2/5] PCI: rockchip: Fix Device Control register offset for Max payload size
Date: Mon, 17 Nov 2025 23:40:10 +0530
Message-ID: <20251117181023.482138-3-linux.amoon@gmail.com>
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

As per 17.6.6.1.29 PCI Express Device Capabilities Register
(PCIE_RC_CONFIG_DC) reside at offset 0xc8 within the Root Complex (RC)
configuration space, not at the offset of the PCI Express Capability
List (0xc0). Following changes corrects the register offset to use
PCIE_RC_CONFIG_DC (0xc8) to configure Max Payload Size.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 drivers/pci/controller/pcie-rockchip.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index f0de5b2590c4..d51780f4a254 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -382,10 +382,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
 	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
 	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 5d8a3ae38599..c0ec6c32ea16 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -157,6 +157,7 @@
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
+#define PCIE_RC_CONFIG_DC		(PCIE_RC_CONFIG_BASE + 0xc8)
 #define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
-- 
2.50.1


