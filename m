Return-Path: <linux-pci+bounces-21700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6CA396EB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FC01896170
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CB22FE0C;
	Tue, 18 Feb 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIf5j5Pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650223535A
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870498; cv=none; b=Wu+B6H99YgXzsspWAliuIwKcfHlRiigZTJXt6l/P9/abciVSrozTqDIqETE/vUenpI6/4Owm1Dx+nKRhUysa/RABlK3PS/q1B4lvCw9PfEgHAUud41bTikl6l1l10zGyEF/29Ybxys8LIbNSA4mJBNQ3V4zu992kAVeQ7LxeU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870498; c=relaxed/simple;
	bh=iQpMkFraUFasKXHj5G/LerAOvqvTRcGeS6d4L/XwPlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGLcj+8BDm+eA0uoDaVxDuLVxBFztOsXHd8AXAVpQc1ua5I2c8aITg2iAVOTECsnAxB1lVDAnKpknuVm9VH5xqK1wA5ZymlTaZDCoDqa++zG6xjTKiF8OYOQF4Evn+xbGv9ULvh01ssBiUEqRigrR43scAL2B1Rfkl02CFeYcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIf5j5Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D7BC4CEEE;
	Tue, 18 Feb 2025 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870498;
	bh=iQpMkFraUFasKXHj5G/LerAOvqvTRcGeS6d4L/XwPlo=;
	h=From:To:Cc:Subject:Date:From;
	b=XIf5j5PvJz1hhVWEuwOjSdBEUYkBDYm072yoESln2suBEzSrpe5+ZzKEITkvmvopM
	 dsiyoCBXdYHe0rmdQ2/ktJmPfzoNVhEzHFmDHyyxBJH2K7JN6xMCBdLF+zGClHUWQi
	 RmMOK4neSYh2ehJePQg7SBMxuIBxlp7nrM00KAWnVnwy2+pqB4YtJG7gUsaV2X5uQa
	 jx+MIsaSsHZjWv1M4tXWMZabxSPjUG8HPvlxHHc0iid3ghF+N8p6aQlSqnxlmIvk/d
	 DZVGQyTvjb3YIjf4lOtJn5iHEnL3X0WDnml3g9m9OsZSupaDdvn7JwpEU8JnJyu2dP
	 kzpDq+AaXowkA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	Shradha Todi <shradha.t@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] PCI: Add Rockchip vendor ID
Date: Tue, 18 Feb 2025 10:21:21 +0100
Message-ID: <20250218092120.2322784-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=cassel@kernel.org; h=from:subject; bh=9kbBLyummmBW/jvk4xXSxDX1JOHzGncPsVcs+LiI+6E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNK3BArccgjbe/HA3Y6Z6ZphqhVrexRfPImvcNDimLdIa 4Kzi9qyjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEwZDhDwf3PobY5j8RZp+F t+T+87c7/Otuv5KVeKrRVF8RxuyZ8gz/vTMZV8vcfbfr8Ik3v8LEJxe9eyR5X3Wz0ZH2jO8V6R5 r2AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

This patch moves PCI_VENDOR_ID_ROCKCHIP from pci_endpoint_test.c to
pci_ids.h. And reuse it in pcie-rockchip-host.c.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczynski <kw@linux.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello PCI maintainers,

This patch was previously part of of series that seems to have stagnated.
Bjorn did provide his Ack on this patch for that series, however, I suggest
that this patch is merged by the PCI tree.
(Shradha's series will be merged via PCI tree, so we will need this patch
in PCI tree anyway to enable Rockchip in the DWC specific debugfs file.)

 drivers/misc/pci_endpoint_test.c            | 1 -
 drivers/pci/controller/pcie-rockchip-host.c | 2 +-
 drivers/pci/controller/pcie-rockchip.h      | 1 -
 include/linux/pci_ids.h                     | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..b002740acf8d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -88,7 +88,6 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
 
-#define PCI_VENDOR_ID_ROCKCHIP			0x1d87
 #define PCI_DEVICE_ID_ROCKCHIP_RK3588		0x3588
 
 static DEFINE_IDA(pci_endpoint_test_ida);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5adac6adc046..6a46be17aa91 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -367,7 +367,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
-	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
+	rockchip_pcie_write(rockchip, PCI_VENDOR_ID_ROCKCHIP,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI_NORMAL << 8,
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 11def598534b..14954f43e5e9 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -200,7 +200,6 @@
 #define AXI_WRAPPER_NOR_MSG			0xc
 
 #define PCIE_RC_SEND_PME_OFF			0x11960
-#define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
 	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
 #define PCIE_LINK_TRAINING_DONE(x) \
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index de5deb1a0118..e1a270e7e0c5 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2609,6 +2609,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
-- 
2.48.1


