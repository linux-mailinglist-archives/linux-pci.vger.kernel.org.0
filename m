Return-Path: <linux-pci+bounces-37083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81048BA2C73
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CBB1C00862
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC813272803;
	Fri, 26 Sep 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D558smNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE47263F32
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871808; cv=none; b=hRLvH332YbXXO0wzEhB2I7OkBOfbRiDaubqtWSdLFwvKrZ8QO0mEvapdg4jo+bQqstLvTVVygYE86vlNBKaRxmyHK2S8QsyDuj2Byi7HQNP4niBS8OusGizGyNscy/XCsGXQue76wh6K1NQ9Im6iYblJOFG3/y6Om12BNeCf9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871808; c=relaxed/simple;
	bh=B9tSdkHs2Yg94R47L+fGUJTllZ1iYKjZrE7h+YiOBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neZEYMpvaRgEFWi528jjCNnR7wZ0T9pm4gcVQSLvoDie/cvyFGiUTVC0Fuu+ODqtcNi+izaJubkSzRgV2IUhBBXYuvVpHKpc/ek16icVRGN/rRzgT3YG+2TuBvk11zyuQyJWpFwvHTKhC9ZMuUep967AJ9RA8dWhhN1T4koq1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D558smNv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54dd647edcso1644048a12.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871806; x=1759476606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm7nBZJ8GEby0mK5cxdZtoEeYLLJ3ejp8euQ7RZMF2I=;
        b=D558smNvNnZiUCj6F+E7/mOoa3zWkUoorW5QTbSA525Sf+XOWpuDN6erMd44WHk+cy
         SFOxYmGn+PfldUeVEbSf61xf3/CJ5vNOn60j8OK0/mwe9rGBAsqxVsY7oHh0Gzg3uRZP
         CQBEGfv0fcm1I6C9OPdJh3ZbdZ5xMbPZLlpvuXTtPepvrRx9xHkyrFYDibQldAclGOuz
         kK7G1870DmlwPJWcfzFEagUymqQ8HgQ48yW/1zctSJYMMDB7O1KODPa/WA4/3Z67nNFA
         q2+plW98tOfzgm0Og6jupSVu7uFm+9h4100+rPPEofjXLmSBf/8diYZbApNt2wZp9HqH
         TBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871806; x=1759476606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm7nBZJ8GEby0mK5cxdZtoEeYLLJ3ejp8euQ7RZMF2I=;
        b=IhaefHTCdoZ+MYTBTvBCNZydWpYyzXV0geQ0j6SihBT76Md9XU7o0Gn9ppZDXF1Isd
         t6xI1vRWH2qJOOc+1VwRPpLadbug111z8hJyzopnjuFfl5jQnPjFPzEZr/g71qf1rgHo
         XkwR9JJZFxwZfc2zGsdpjlPhsnhrq5jidZAsnJoXK5reoC2lu6k+wN2jI9X4/zy2kHdd
         t2FK7p8lJ+MzvxOYdTMGdP0ssYb4jEpZX9YNKD99xMd0yQO4b/ItLk7zl7z76Ch2pJL3
         cDDBFdgGIGV9e/iMTAeCPfSOAqv2W1Ycelw2iMFZMQ98l1zEJLELQF8yky3UQmjdhwKy
         41jg==
X-Forwarded-Encrypted: i=1; AJvYcCVqVOxuqIOoywlmUMJpcpvJ0FtDn4BY+1C1NIkB3G8s2UPQLrC2n+pwT37XK18ZuZs7vbqcS8Ovu4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXKg/ONqigbNsGPqO4vACtw+Xx1gTDvl3tvinSEbwiD+XMBht
	Q/eXk9z51n0kNMmemcULevHkMtKRob4d0vw1+CDjk5bKzDtKWNpYOnxm
X-Gm-Gg: ASbGnctyxHIO5X78RNWO2qbfVImwV1dOnsaAY/wuDdv24xDKJhPr2o6/MJIMpq6nXlv
	o1w0rpjnbLdKidcN9TLop+Gg+aFY2KPbhf1rJu5A4dbQ2TSCwcJnNFXjddFYcR7StE3zxWrgHoL
	vaZzrCE8Yww4Lr6eC8K0kPn7wCT/PPcyFKl4lX0rLp5ZUUi5Ecu31KAuHBqCZtCkS7OlyfDDw9o
	BUKooIbh0k7A2V21ZEOTC9xC4pHlZJkkRHDPwy+9tTv6SD169YEnrN2P3AXf5MBkpwv24m8QNtv
	Yx4Lc+//7df5UKOi1U5LMOJox+Wz2W8uYwQHM61YJgty+7iEfpTtC/A5M/8kjTmscuMq7h3id9P
	IaP475Dee4chFMvqhm/qZ
X-Google-Smtp-Source: AGHT+IGI+U3QK7iLuAmmvXRmiYoOumdYgGGFoBVB3R//J+qy9voB0vaTp3PbDWtHrr0QJs4yRB3UPg==
X-Received: by 2002:a17:902:e54d:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-27ed4a67210mr74057675ad.58.1758871806190;
        Fri, 26 Sep 2025 00:30:06 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a98b9sm44083065ad.111.2025.09.26.00.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:30:04 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v1 3/5] PCI: tegra: Use readl_poll_timeout() for link status polling
Date: Fri, 26 Sep 2025 12:57:44 +0530
Message-ID: <20250926072905.126737-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926072905.126737-1-linux.amoon@gmail.com>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
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
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: dropped the include  <linux/iopoll.h> header file.
---
 drivers/pci/controller/pci-tegra.c | 37 +++++++++++-------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 07a61d902eae..b0056818a203 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2169,37 +2169,28 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
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


