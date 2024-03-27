Return-Path: <linux-pci+bounces-5253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6719D88E2F4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985AA1C2830A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2235C1791E1;
	Wed, 27 Mar 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjWF3CSw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFD13E045;
	Wed, 27 Mar 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542232; cv=none; b=QjVyu9fwBWCydsAx/E5DZwKh0bCmoBc3UJU3yLwnGpBKCETPNSrqeKTlAiocGb668UpxPLU/02BS3WGIlC6slvH7RcPAowcSRAm+yRQC5O/ySz08czf8VGZ5I8/KaWFU+bczn2Q5IWBF7cze/up8gT58SonzlpMr8h/gLHuLf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542232; c=relaxed/simple;
	bh=7LsQtJB4z2+a3oJU3PiQpdmEENnD8QrniYyGYXqfMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWBA2qaw5xsuisJR4tcUir7IE/NC9a4IYfj383LIpIFLV4eKsrsXyMgrTlpDoiJQ17sn9vNUkg0nctmMmXGaf4ws3HbHndIHfbSc97HYMyPkDSSLweIqfPX7wyj8WjBWNTJsSzooWt1SsNbXKP+PkD2wgn+GSCAygHO1XiwAXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjWF3CSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DDCC433C7;
	Wed, 27 Mar 2024 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542231;
	bh=7LsQtJB4z2+a3oJU3PiQpdmEENnD8QrniYyGYXqfMn8=;
	h=From:To:Cc:Subject:Date:From;
	b=mjWF3CSwLdc7rqLpi5mxLtmlHWyArBg1n0IKMrG9/adB8mT498cTk6FK/mLuduuw/
	 2wZ7rg/VPxo+4o8QrdQzhwSdR3Q1p7Otb4+EV2X4ksZYZLSZgOKXNIg8YLOdGnwmsP
	 9gcPh4F8D/D/h9IXnrvbwXhvIGMzHnUKt0XU9t0aYaIsmY/Vu/Too/B4DcegT7Hxkw
	 P5xiDj/4ElOlX0/tR6H4IDie8n2UTMCxfPlTGlspwidtb8ZS9rc6R0fhwh59F786oA
	 RuhMXGuDoi1uJ+ms4N8WnuStuYMQ5zBLvzMx/RMKDj6Y2IxWwRHX1Aen2o6qtH9xrw
	 HGaTBFY1iLrcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "PCI: dwc: endpoint: Fix advertised resizable BAR size" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:49 -0400
Message-ID: <20240327122350.2838878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 72e34b8593e08a0ee759b7a038e0b178418ea6f8 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Thu, 7 Mar 2024 12:15:20 +0100
Subject: [PATCH] PCI: dwc: endpoint: Fix advertised resizable BAR size
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit message in commit fc9a77040b04 ("PCI: designware-ep: Configure
Resizable BAR cap to advertise the smallest size") claims that it modifies
the Resizable BAR capability to only advertise support for 1 MB size BARs.

However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
contains the possible BAR sizes that a BAR be resized to).

According to the spec, it is illegal to not have a bit set in
PCI_REBAR_CAP, and 1 MB is the smallest size allowed.

Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
1 MB BAR size.

Before:
        Capabilities: [2e8 v1] Physical Resizable BAR
                BAR 0: current size: 1MB
                BAR 1: current size: 1MB
                BAR 2: current size: 1MB
                BAR 3: current size: 1MB
                BAR 4: current size: 1MB
                BAR 5: current size: 1MB
After:
        Capabilities: [2e8 v1] Physical Resizable BAR
                BAR 0: current size: 1MB, supported: 1MB
                BAR 1: current size: 1MB, supported: 1MB
                BAR 2: current size: 1MB, supported: 1MB
                BAR 3: current size: 1MB, supported: 1MB
                BAR 4: current size: 1MB, supported: 1MB
                BAR 5: current size: 1MB, supported: 1MB

Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
Link: https://lore.kernel.org/linux-pci/20240307111520.3303774-1-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: <stable@vger.kernel.org> # 5.2
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..389daebc43161 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -627,8 +627,13 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
+		/*
+		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
+		 * size in the range from 1 MB to 512 GB. Advertise support
+		 * for 1 MB BAR size only.
+		 */
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
 	}
 
 	/*
-- 
2.43.0





