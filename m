Return-Path: <linux-pci+bounces-40084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F23C2A51E
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4CC1884486
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957D1E8836;
	Mon,  3 Nov 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="vq53pz0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541042505A5
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154927; cv=none; b=SXWwJnCe3jr84tL6Ig+m/X6SfM4+BKOI4ytHiLcXcIJ7ky3cqtKUMavwokkI/P6GGBgTj3bUfrUccSruxSjXSRZZeL3T4fZxkJPWLIr86KLGtmZLkLAya1kH3HSmUemTV8hLv0BBOi36qXW1kU7TSIaIBcTlD6alujz3fPzIkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154927; c=relaxed/simple;
	bh=aWP/1DnmAt6yZotpsPuloZKtxkeL5p9NcK/wJv2hS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwWT01yuzqboS8/LVvg990rDD8PWPOmE0yGbEmwEQzTiNkuw0+SHyy8vszBktND1xtQKH620biqcwFXHonpxTNyMD5Qy5CUjppKwY9Ke4qlRKVZylT85yEoQi572EXJov6SoXW2iQ72iF9uQRqrfpBLEf1b3PRi48dO9zTJUnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=vq53pz0H; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 124D8440F4B;
	Mon,  3 Nov 2025 09:27:05 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762154825;
	bh=aWP/1DnmAt6yZotpsPuloZKtxkeL5p9NcK/wJv2hS/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vq53pz0HLW69oxk63SLB01mYpEDA8iu7yLb3bTLLdVWNVwyE6qD6NqZuFMu+uAlA2
	 4kywb82rFTxY9Jf7zTMHj7Sa0DrpzADlnEwJkGn0/i38l88O79L2rEDA/28CEblxUR
	 NcLFWrQcRN8rupVd+6FpB0aEiGSFeXx1CsevYQAdGkF3LzML3rZcH7zxBb/JW7sg+K
	 evNpiZMacbpcvWx7Br0UNsQjdmnbRfLFMlTTbhYPijsuGZ8nS0Cfutgm89kOhRmpV5
	 EWEIN834F17+nW/xE9xtbrq/FQDozpYy93kOq5hSSQewb0W4UAfC7OH1M/u4Fvgxie
	 qScA0+dAqzdIw==
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
Subject: [PATCH 2/2] Documentation: PCI: endpoint: fix section cross reference name
Date: Mon,  3 Nov 2025 09:28:31 +0200
Message-ID: <f53830741db9d0351d1290fdf8f250bc685620c1.1762154911.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
References: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refer to the correct name on section in this document.

Fixes: 4ac8c8e52cd9 ("Documentation: PCI: Add specification for the PCI vNTB function device")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 72b7a71b2e64..18146155c350 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -139,7 +139,7 @@ lspci Output at Host side
 -------------------------
 
 Note that the devices listed here correspond to the values populated in
-"Creating pci-epf-ntb Device" section above::
+"Creating pci-epf-vntb Device" section above::
 
 	# lspci
         00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
@@ -152,7 +152,7 @@ lspci Output at EP Side / Virtual PCI bus
 -----------------------------------------
 
 Note that the devices listed here correspond to the values populated in
-"Creating pci-epf-ntb Device" section above::
+"Creating pci-epf-vntb Device" section above::
 
         # lspci
         10:00.0 Unassigned class [ffff]: Dawicontrol Computersysteme GmbH Device 1234 (rev ff)
-- 
2.51.0


