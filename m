Return-Path: <linux-pci+bounces-44320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40ED070FC
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 05:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AAF5301D0F1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F029AB1A;
	Fri,  9 Jan 2026 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkX3oPX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB52561A7
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931717; cv=none; b=PPKq/JMGmWgVNdDVFrP218QRRIMGnurd42RXCGBZTZVnZTolsywWuE1T+KhukMYsv1glSZ6KpgGS2rVarNSOwrvXDaTDvZgsT+46rj9PDf2E7KrHe8uIORyF+i7LfsB5Xc0d+NyBA7MPKRv5tit0AbQzY/P739bg4K3v676oC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931717; c=relaxed/simple;
	bh=2tYLI3DtcMtwJfXC7qmJCxoPosq9HZpwIEFx8dJfMfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUsAxFD7NZhRbKXa4XtR14TIVwEycABYMEA+SqOqVHGyDjdAEzxl4cBJnBF7zhOeoS/UGfOXqW+aBs04iWungsA8F7BIXm0L6ZbqCSLthWfqaI/IhCHBCCV7SS7LOPKzKpfs5xw9ouq5yb6oJ9gCRPW6mZw8ErBiglS+k6Y07g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkX3oPX2; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11f36012fb2so4761315c88.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 20:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767931715; x=1768536515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpsfmbhFZbFRk+U3zFKuBinShH1SdcIYL6u6kQf4p+I=;
        b=HkX3oPX2xvHyHu7ya2hpIUNEetbtpDrY7LImfrFNkEntiLDnQuMma2mOhmKM93E0fv
         XCKbpZqREQbfBYmOMa9D7Mx6ykY7soctKOLUtSoMl2Lql03DwbIl+skBytCno85tWdzL
         XNksWL0NSAQhkT54arkHbFelw4Qu0VM+FSme3vUdBM9Z6/cKn/QyLTC75ktm1l3ctrjE
         +1QPBcsivaTTkCf5IcdOsF1oU8S7BMF1WyLhjNPuF/e3u9oA53MyyHjCp71ZU+X/fIyk
         zjFOOd5N4lQq/4lVEbXjXe+82kDMQ70UgRKgZMCA0uB8sDnDdVehkiDtluDwYa7KuLm6
         yCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767931715; x=1768536515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpsfmbhFZbFRk+U3zFKuBinShH1SdcIYL6u6kQf4p+I=;
        b=XuYWRwUUX4z7+RXJZNvDFYOtHQbbROfQXzm0JSh7AYzd/mBnbfsaVVK3tA/r78XwQR
         BJLZinROa41ApRGkeAbXqHWQyAoP3+p+T69esaN3ILF3Odo4mdLEp/dCzNzcbS0mvVqh
         fErcvMtZuxq67W6wNVEWsWrU58g/Rjij/Nap92vrnoSg8TO9PfdJhLactKpuGhJhPB/j
         aaYlsgm6Zpu+Trk2W8AHpgseAf3h0GP7pZdK4KiyT8RzETZUEH6qtHVyQQBEyQyQh5Z3
         CkYSydajoUgqNqgwGCYhhLSOkjx82L96NpIdR4f9sD9n8aKTa46P9BqNcRmr9UTYbvXr
         xwbg==
X-Gm-Message-State: AOJu0Yy/h7ry0hKFhNu6Q+oPHXSJFcN25GJX9zIB4V0/XptjBnTc69tM
	lzgeTiKUkSL7Zje28G4oYAHmba+NnP8ovRZTb6WhWZWEU4PlKbmuVBkj
X-Gm-Gg: AY/fxX5rQw49Nyq4NtqHHjCia/S6rOZJZI3T6N9k1dhDHMK70q57uDY/v11P3McRViF
	JeRZqhDdw+l8xUfGEx/UDUf03K3CuKVCKQ1xKR+6IAKTkgzg//e2UyBezJWtKQtgk9iSzK6YK/B
	oWmPeUFgtCfgZdfUfhkUccr8SLwCmiwnYL1FVDDgA6vqAJm4wSO2NOdduLxgBuHEwkIY4IiXKTk
	Bfmb2E6g+b8dlDG6yDxY7ntwqIJ7+LXszYqRwsWFAcoiwajUq5BtTuUIkFdL5XYP3/n7lRDDJpZ
	vsTHiXV2wF2XvRLaqDIMD+kdxEr5F7UM5iCT1t3Bu/7EuBBE8Stir8H6b0LVYClhxQ1iJ31yUGf
	vEIL7vFLIlccf/X9hIwN2pURDaMWr1gCC+weR+JMFtwQLN8eScggBAYPNgMK9BAuB33etkTKvHn
	Izlo1lgVk0Ew==
X-Google-Smtp-Source: AGHT+IEKYs98PW8+vR31wL6KNDRAcc+uPt8+GLwK2+xUR3vV4NDSXNJ8DtjrqbGEI9BElil9CxwgPQ==
X-Received: by 2002:a05:7022:4a2:b0:11b:e21e:5653 with SMTP id a92af1059eb24-121f8ade973mr6239197c88.19.1767931715082;
        Thu, 08 Jan 2026 20:08:35 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm16668383c88.5.2026.01.08.20.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 20:08:34 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
Date: Fri,  9 Jan 2026 12:07:54 +0800
Message-ID: <20260109040756.731169-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2042 root port breaks as it advertises L0s and L1
capabilities without supporting it.

Override the L0s and L1 Support advertised in Link Capabilities in
the LINKCTL register of SG2042 Root Ports, so it doesn't try to enable
those states.

Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
---
Change from original patch:
1. use driver to mask the ASPM advertisement

Separate from the folloing patch
- https://lore.kernel.org/all/20251225100530.1301625-1-inochiama@gmail.com
---
 drivers/pci/controller/cadence/pcie-sg2042.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
index 0c50c74d03ee..9c42e05d3c46 100644
--- a/drivers/pci/controller/cadence/pcie-sg2042.c
+++ b/drivers/pci/controller/cadence/pcie-sg2042.c
@@ -32,6 +32,15 @@ static struct pci_ops sg2042_pcie_child_ops = {
 	.write		= pci_generic_config_write,
 };

+static void sg2042_pcie_disable_l0s_l1(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL);
+	val &= ~PCI_EXP_LNKCTL_ASPMC;
+	cdns_pcie_rp_writew(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCTL, val);
+}
+
 static int sg2042_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -68,6 +77,8 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}

+	sg2042_pcie_disable_l0s_l1(pcie);
+
 	return 0;
 }

--
2.52.0


