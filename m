Return-Path: <linux-pci+bounces-26055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C6A913DC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915CA444E73
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AA1E834B;
	Thu, 17 Apr 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OXDAedLj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A61A2554
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870701; cv=none; b=Ki0NpVWq9j9K8sOAeWQqZREPCajmCpKdgdbMxNZVyCZSdDw17Yx9UATRVvyKBHl4x5ot1uPbPxrAvC8fXVd3l6cX68CrHKQVnPYnVs9NtEkxG/k9RY5W7uKnTHYgWc+Vf+faFQVtMrDUMM9VEmZbZgWSUiFocPShNpvVJOnJkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870701; c=relaxed/simple;
	bh=illQQOeOEVGTjqjIqlrysskfdCsy8ZchpRLwgyjITaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YfN8gh4jUm14KJulUW1dAd511hYJ0rZR720LUUxH/vPT6++/5v4jLxKTAkGjuGWxYRn1H4XnlMlwi6hgKdLcADAXr4MfMH/a7BSg5o8lovMaL30VEOzdfMZK1fi2P48hsbSVo5jCm29RM/Pi9NfPC3t3FJOGb12j+LfTr+Vj5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OXDAedLj; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1224c9fd2;
	Thu, 17 Apr 2025 08:35:24 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 3/3] PCI: dw-rockchip: Move rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
Date: Thu, 17 Apr 2025 08:35:11 +0800
Message-Id: <1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5OQlZCTRpKSE9NSUkfSRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96412bfef009cckunm1224c9fd2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6MBw6NzJNEhILCUoNSRI6
	Gg8aCQ5VSlVKTE9PQ05LSklOT0tIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLS003Bg++
DKIM-Signature:a=rsa-sha256;
	b=OXDAedLjWKEbZeQ+UyBkCJ8RP4tRq83/0lDfSrt756kpoj+DYKaaLzY9hYWyjFz8YhbG+Uz+I5tvVCqUPB7Yt4YQie8vvX9PcjHG3ePj+Avo+FmL7QI8U+37H9OkxBibyzEZI3bE0pVRNWlZQkQnE9syOMQCSd+K/hrBkWIuTGA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5zSHlWHLiEmdxc+sCW6tUdXwMlspj2a4pKO9Z8NdMAk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

There is no reason to call rockchip_pcie_ep_hide_broken_ats_cap_rk3588()
from the pre_init() callback, instead of the normal init() callback.

Thus, move the rockchip_pcie_ep_hide_broken_ats_cap_rk3588() call from
the pre_init() callback to the init() callback, as:
1) init() will still be called before link training is enabled, so the
   quirk will still be applied before the host has can see our device.
2) This allows us to remove the pre_init() callback, as it is now unused.
3) It is a more robust design, as the init() callback is called by
   dw_pcie_ep_init_registers(), which will always be called after a core
   reset. The pre_init() callback is only called once, at probe time.

No functional changes.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4:
- rewrite commit message

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index e4519c0..7790a9f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -278,17 +278,13 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
 		dev_err(dev, "failed to hide ATS capability\n");
 }
 
-static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
-{
-	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
-}
-
 static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
 	rockchip_pcie_enable_l0s(pci);
+	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
@@ -359,7 +355,6 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
 
 static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
 	.init = rockchip_pcie_ep_init,
-	.pre_init = rockchip_pcie_ep_pre_init,
 	.raise_irq = rockchip_pcie_raise_irq,
 	.get_features = rockchip_pcie_get_features,
 };
-- 
2.7.4


