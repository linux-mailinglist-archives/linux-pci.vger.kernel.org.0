Return-Path: <linux-pci+bounces-36219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85030B58C14
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 04:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8597B2BE0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89422128B;
	Tue, 16 Sep 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FDOXaZ+c"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC686353
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991481; cv=none; b=NGu2rpB1VPBFCVJkUeiVXNkMfaq4cKU+iFz5kZIhO/FJf7FfEDGII+k+XmaImFrltBgZpYnFVtEPVGP5BC8aFnuH+Wz+NTu6x9vREgGUriVGi0PSdjE4dppeZBvn6M7lRDjL2V14JchC2y8TFgNeXbO5BYTPGW8ckhcCDG/o0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991481; c=relaxed/simple;
	bh=tlyicy+hNYXUsv+LdMHJX/RDV+aIDWVBrI/l9sCo1go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1wld1gwvpyTvnyb9KkizklE34c+Q4j/sd02Sxza1Dh8O4OLztdJCr1qpirgpB652L5iZCZw5QEoIDFT7XsiZdTay3HWlfq7EtBCqkGWBsct4dLNQi3y/XVPaZU1i3H73ZqX5zhGXwdoKQh5yf6TJxGeZ+dcvTb2bSTb+bkgrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FDOXaZ+c; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757991479; x=1789527479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tlyicy+hNYXUsv+LdMHJX/RDV+aIDWVBrI/l9sCo1go=;
  b=FDOXaZ+cBJD/M/AVxB05LSY9LMUIi+EcPziH2PUQZgi1ZeYGncQbZsOf
   HuGNB61zigkKlRjnJ0cLpQWPfsuBZ/sia258OQ3XXTtgb8t3lEGhxdqlk
   GJJ/7TXh5jSQqVVqy/te1RnvHllChiAAsflKCrV3xa7+Qx0jnVwNC/9Yu
   k9oBgsC1Se6NBDkYoTZrUNfGlQ5JoKVEOuwt/OHjREhS9DKLA29e5td1t
   m6snTw/1Pk8Fops2Wtz8Qlt5w0hOMg5pJ4IcwzKcMg0/G1mILAT2s4TSd
   /SP8jfuOo3tpR3SvuD72TttUwthGGjVQ+RBosG5VqzYrhl3YI+pYjuZT7
   g==;
X-CSE-ConnectionGUID: vz28lrZiT9yUsHzfKElZ7w==
X-CSE-MsgGUID: GggUdG2ETbGcVtbaLkqLXA==
X-IronPort-AV: E=Sophos;i="6.18,267,1751212800"; 
   d="scan'208";a="120923480"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 10:57:58 +0800
IronPort-SDR: 68c8d237_KKXbVe3XSv7mi0C5ek2/TQTmjvj9qDJPHfrRLX2lTRLT8oJ
 KR72E//YV96v59Jfztnx0FFQwUboXfg425+btrw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 19:57:59 -0700
WDCIronportException: Internal
Received: from 5cg2075dxy.ad.shared (HELO shinmob.wdc.com) ([10.224.163.24])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2025 19:57:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] PCI: endpoint: pci-epf-test: NULL check dma channels before release
Date: Tue, 16 Sep 2025 11:57:56 +0900
Message-ID: <20250916025756.34807-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fields dma_chan_tx and dma_chan_rx of the struct pci_epf_test can be
NULL even after epf initialization. Then it is prudent to check that
they have non-NULL values before releasing the channels. Add the checks
in pci_epf_test_clean_dma_chan().

Without the checks, NULL pointer dereferences happen and they can lead
to a kernel panic in some cases:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  user pgtable: 4k pages, 48-bit VAs, pgdp=000000011ab86000
  [0000000000000050] pgd=0000000000000000, p4d=0000000000000000
  Internal error: Oops: 0000000096000004 [#1]  SMP
  Modules linked in: pci_epf_test zram zsmalloc lzo_compress ramoops reed_solomon nvme_fabrics bridge stp llc usb_f_acm u_serial usb_f_rndis u_ether libcomposite snd_soc_tegra210_admaif snd_soc_tegra186_asrc snd_soc_tegra210_mvc snd_soc_tegra_pcm snd_soc_tegra210_sfc snd_soc_tegra210_ope snd_soc_tegra210_amx snd_soc_tegra210_mixer snd_soc_tegra210_i2s snd_soc_tegra210_adx snd_soc_simple_card_utils tegra_drm snd_soc_tegra210_ahub drm_dp_aux_bus cec snd_hda_codec_hdmi drm_display_helper snd_hda_tegra tegra_xudc drm_client_lib at24 snd_hda_codec drm_kms_helper tegra_se crypto_engine snd_hda_core pwm_tegra tegra_bpmp_thermal tpm_ftpm_tee ina3221 pwm_fan drm fuse ip_tables x_tables ipv6 r8169
  CPU: 2 UID: 0 PID: 127 Comm: irq/165-tegra_p Not tainted 6.16.3-tegra+ #156 PREEMPT
  Hardware name: NVIDIA NVIDIA Jetson Orin Nano Developer Kit/Jetson, BIOS 36.4.4-gcid-41062509 06/16/2025
  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : dma_release_channel+0x2c/0x120
  lr : dma_release_channel+0x2c/0x120
  sp : ffff80008197bc90
  x29: ffff80008197bc90 x28: ffffc80c867353d0 x27: ffffc80c867320b0
  x26: ffff000089598680 x25: ffff000092bbca00 x24: ffff0000896075a0
  x23: ffff000089547308 x22: ffff000089547000 x21: ffff00009e14f800
  x20: ffffc80c88d18f50 x19: 0000000000000000 x18: 0000000000000000
  x17: ffff00008082bba0 x16: ffffc80c86fa1da8 x15: 0000000000000022
  x14: 0000000000000002 x13: 0000029f4ce9442c x12: 00000000000a8cc1
  x11: 0000000000000040 x10: ffffc80c88a06c60 x9 : ffffc80c86fa1dd4
  x8 : ffff0000804036e8 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : ffff0000804036c0 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : ffff000092bbca00 x1 : 0000000000000000 x0 : ffffc80c88d18f50
  Call trace:
   dma_release_channel+0x2c/0x120 (P)
   pci_epf_test_epc_deinit+0x94/0xc0 [pci_epf_test]
   pci_epc_deinit_notify+0x74/0xc0
   tegra_pcie_ep_pex_rst_irq+0x250/0x5d8
   irq_thread_fn+0x34/0xb8
   irq_thread+0x18c/0x2e8
   kthread+0x14c/0x210
   ret_from_fork+0x10/0x20
  Code: f000ebb4 913d4294 aa1403e0 942ac552 (b9405261)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Oops: Fatal exception

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Fixes: 5ebf3fc59bd2 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
Changes from v2:
* Improved the commit message per comment by Krzysztof
* Added Reviewed-by tag

Changes from v1:
* Added kernel panic log, Fixes tags, CC stable tag and Reviewed-by tag

 drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8..1c29d5dd4382 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan_tx);
-	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+	if (epf_test->dma_chan_tx) {
+		dma_release_channel(epf_test->dma_chan_tx);
+		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+			epf_test->dma_chan_tx = NULL;
+			epf_test->dma_chan_rx = NULL;
+			return;
+		}
 		epf_test->dma_chan_tx = NULL;
-		epf_test->dma_chan_rx = NULL;
-		return;
 	}
 
-	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_rx = NULL;
+	if (epf_test->dma_chan_rx) {
+		dma_release_channel(epf_test->dma_chan_rx);
+		epf_test->dma_chan_rx = NULL;
+	}
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.51.0


