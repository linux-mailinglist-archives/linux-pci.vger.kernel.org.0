Return-Path: <linux-pci+bounces-40083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15BC2A52A
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 651664E3955
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B329B20A;
	Mon,  3 Nov 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="koK5E6k3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409C1E8836
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154926; cv=none; b=m6l2KsDXs7cL2txo1l6D/N2J+pmy2pBlYXfGyNW9miB9oWdnMyMcCSF2cT3ss5gHmy9co2eIiLqTLLSrGGn1QOtEO+kp3ZaJVFli5dfARlsLIzAygl62gkLl5UmIu9G1hUQQxHkIQkzIyUMmsLEOIEnPafu/ZfGWZayD9E/4sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154926; c=relaxed/simple;
	bh=iiSmqBqZEjWrhMASO/DIZ7jn0XsxbybKLsoTvoB2su0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQere4jpOxVmbBmWKwVGlLzXEdIVYtkrFw4+IQ6C0XJy/rigg3Aowm3v7mcaK7FSNTrSZSxRLm7pNREZBXPbDrVr/w0f9L+W5Kfx1DzTkdWmBs7M/yrS8sDalYjImbr+Tix9P0Kf5F8/l1rN9N2VOSA6ZsSf60xuOQXc2xazASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=koK5E6k3; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id D59FF440F3C;
	Mon,  3 Nov 2025 09:27:04 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762154825;
	bh=iiSmqBqZEjWrhMASO/DIZ7jn0XsxbybKLsoTvoB2su0=;
	h=From:To:Cc:Subject:Date:From;
	b=koK5E6k3tyxvv8b5rPLILhx+Zz1+ETxN1/ChrvFQaIKwXVrJ11yE+l/TXr35HFnAH
	 UrbRvoPIiHyAa1N1xg8lCNTYv6CZXn3OQpDm0RxXsqs9j4UW8AC4GWdAo2zzW5j6GG
	 SxhPgP9tWv/yvR3XkUXUQ77WcCQp2MDxi2L3iPKVR1GsMTiWMYcymjxcH7kntw/W1G
	 jS/uQ+OYEH/YcB4H8w1hn84jYa8XtqPIk22Lri0K1z1vMl0gv5a61NPHZYSntoeyjY
	 zMIAHCAeJeqOxz7YTh29kyJQk4lPOhN4AfOz1U8jGXk6IT4hTSiO3CBLfYzs+kMG6N
	 3sNgfeHGOLsYw==
From: Baruch Siach <baruch@tkos.co.il>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 1/2] Documentation: PCI: endpoint: fix vNTB bind command
Date: Mon,  3 Nov 2025 09:28:30 +0200
Message-ID: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EP function directory is named pci_epf_vntb as mentioned throughout this
document.

Fixes: 4ac8c8e52cd9 ("Documentation: PCI: Add specification for the PCI vNTB function device")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 9a7a2f0a6849..72b7a71b2e64 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -117,7 +117,7 @@ Binding pci-epf-ntb Device to EP Controller
 NTB function device should be attached to PCI endpoint controllers
 connected to the host.
 
-	# ln -s controllers/5f010000.pcie_ep functions/pci-epf-ntb/func1/primary
+	# ln -s controllers/5f010000.pcie_ep functions/pci_epf_vntb/func1/primary
 
 Once the above step is completed, the PCI endpoint controllers are ready to
 establish a link with the host.
-- 
2.51.0


