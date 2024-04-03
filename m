Return-Path: <linux-pci+bounces-5622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228C8972F5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742E9B22E84
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688713AA52;
	Wed,  3 Apr 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dggfug2I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E85433A8;
	Wed,  3 Apr 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155534; cv=none; b=B6AQ/6EpmNIoDyyIw0z0c3EkLUxaCM8eqnflcuR1d7hIQ4c1yaJaTfB5w1Yl4BTWTZrrxSXjULHDCe7n1x6ZgAQIlV1idVnAP5uztfBFVhOAt8+YH11U4b8Gxjv2EESpYxetxioje2G4JMhTuW+t5Zz6LZF2KyXVcyNG20dyb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155534; c=relaxed/simple;
	bh=j4lapdM/IHpzoQhUS5ceN/z7x1vBh5mHgZ9hkb7uiJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hg2Oe8yPZElRz1MNU1q+y5jVaRoiLeA4beW1s8q1Q0aopPZQoaUSWBa8NA6Ov3/cGWerwjwX0xWdFCeZO9+vRktqCJaaOq9BGOQzOhGCWN3fQ2cx3Oq78WVa2ASez4MCZHpBWE1sYSvDBNftvDjXk6PEeii168YrIu53X9g1nK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dggfug2I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e0acaf69aso917951a12.1;
        Wed, 03 Apr 2024 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712155531; x=1712760331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3Pkic51g7rrTopzQNi+VbYIAqH2ghyU0XlcWsnfQ8s=;
        b=Dggfug2IF4SKtplkij0+WztWAyBnqf1OR+GNYx2KhpFA6IQZlJw9X+g6tD9lcj47N1
         jkmQ1jV2hruRU1WGhk1zJGjRs4wCmPaQf4ISreloxaaoJ4FabdBYUxlO/hliaIzLidNN
         NVhYDw/93vPIDjrgWTseuCdh0H7Zgg0so/yY5PixbhQoS39QD36nGVGgKudDWpOk6I2Y
         pqzL6P4cRZFbgPi4+KpomMGz3OHr7EMOXtuctmXywLV18//ncvMvUHw1xsGxgZugd5Gy
         /iUi1OEEvnjFKrZGC5/bj4hItJEX75otOJIBm7xorAd3GvHOpLo1M1X7yA73Dq8EHfdg
         bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712155531; x=1712760331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3Pkic51g7rrTopzQNi+VbYIAqH2ghyU0XlcWsnfQ8s=;
        b=QZMkY3IMUCZb5T90rcSmz/PeyCNNxyp85jcpkFnt7fUu7RL+xkZH5jeDUHE7IYUa8n
         Z8IcgDKUz1OCtXjrjDUXCWH07woTL0rIrlgu25QTR8U0XXrG1v3bF0b3lfngNRiFjFCh
         sXQDUF36xatN1P70fNh1IzLIMRYXWMqcYb0++Y8EpZOfmTMK9wUUgVHeluQzIqKT8j/Y
         u0F5UR5aJVknbEziX18M+ufQXa+nxBohDMwrq/USBqWpBanh2Zjzn0FsxSZzXgKreqQw
         bOoDAnhCEq0t3lErR6cbIxsp3MjPOOGrsJHWYlpR0zsE5Hn6+Kl7txHC00iN7S0vmRWD
         SrSA==
X-Forwarded-Encrypted: i=1; AJvYcCXKGsG9iiRQpGWlXVXYA+33Xr9MdvLlPkFLDfrWgyx/TZVwm6MReYsdaSU3m0koYr5ewFf9AzFlLn1u4Yva3EULp4jusjgymR1fjO186EQ1JgzOHci+CpRvoDCq95LcObIHTclNEZsQIHeGY8JkA5LBcvqu1VN39C5MiOy8Jx7I
X-Gm-Message-State: AOJu0Yyp9WUCGNHPNgdVhv0AGYs/d+hpEKvOGOP2lKHerP/+ckkVylLX
	lb/8mNdjE4oOG6SIoPqPerqrxE4xXLL2sQbbbh2rDotS4mKX/Ro9
X-Google-Smtp-Source: AGHT+IGUKnmalWHmdHqzQg31S41xmoGwv8cZpjceJSBvGia7muB7V+oQVkfF70cW8QCJGV1MPIMf1A==
X-Received: by 2002:a17:906:da8e:b0:a4e:379b:753f with SMTP id xh14-20020a170906da8e00b00a4e379b753fmr11844116ejb.23.1712155530775;
        Wed, 03 Apr 2024 07:45:30 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id s26-20020a1709066c9a00b00a46e92e583bsm7921536ejr.149.2024.04.03.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:45:30 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: dlemoal@kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
Date: Wed,  3 Apr 2024 16:45:08 +0200
Message-Id: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
Vendor ID are u16 variables and are written to a u32 register of the
controller. The Subsystem Vendor ID was always 0 because the u16 value
was masked incorrectly with GENMASK(31,16) resulting in all lower 16
bits being set to 0 prior to the shift.

Remove both masks as they are unnecessary and set the register correctly
i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
Subsystem Vendor ID.

This is documented in the RK3399 TRM section 17.6.7.1.17

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pcie-rockchip-ep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c9046e97a1d2..37d4bcb8bd5b 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -98,10 +98,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* All functions share the same vendor ID with function 0 */
 	if (fn == 0) {
-		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
-			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
-
-		rockchip_pcie_write(rockchip, vid_regs,
+		rockchip_pcie_write(rockchip,
+				    hdr->vendorid |
+				    hdr->subsys_vendor_id << 16,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-- 
2.25.1


