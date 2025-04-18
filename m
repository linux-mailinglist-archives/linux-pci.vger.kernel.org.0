Return-Path: <linux-pci+bounces-26161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6EA93150
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 06:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E585466695
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FC253B55;
	Fri, 18 Apr 2025 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwfNZg+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48221DA21
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744951973; cv=none; b=qi4ZGzSsoh9mjs88x3VZmOCRHrILMNfzeExF+RfneBZFEYSYR7D8mqa8OWgzN25SYhl8CABdYjeUc01z1GmT7Fc2d9cuBnl3luSszV8AY7dzl8aX8MO8xZXD5r54Wo/WjHAuEcAsv8DSZqnFSlh6vVng68Rvyp5KoXyEAN1+TEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744951973; c=relaxed/simple;
	bh=Niv/e2ULeqXuF0ruDrF7IxbZRP0058yoi5gAvaeq2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CUAtwbWrjL6vMdKSlGEg4HkXyTiYsorkJlrlT1Wv3dnMb0IFLE+JIxCK55ZhsqTGlXCKFgrFUkqCuH73XSMvwtwBfxNbHN+Y0GHVniBQAfR+Pkt/YlfRV2awkpkUWA9q03c2xe2qFCezosgb7gD48t6L0cx5EmUBnR0kuGvQRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwfNZg+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B612AC4CEE2;
	Fri, 18 Apr 2025 04:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744951973;
	bh=Niv/e2ULeqXuF0ruDrF7IxbZRP0058yoi5gAvaeq2yo=;
	h=From:To:Cc:Subject:Date:From;
	b=JwfNZg+PvCvCj9mZK6l7Y5OONpSKrKojrWuNkcXBMcgRsT36v+QQCgNnyHSC9PAPM
	 XPgRhMPC4JD9lMfOA8ion40iBZWCY+UpmTa+FDSuYd4mqpGYJPRZK8Gz9zhb24v+je
	 VUb2ScAVlTxLycMT6MeCW79hjZkI/vPFdyHvLlJ4VT40dISshjg52pZ6nScFMY30xv
	 2TdGl2Jb16Ng6CgsqSw3/wDeDWBtEp4Lvt8WZW7kPqvd/knva0DPSnCVh8tPjGYBve
	 FUNp/f1UA1q8yyL87tEj7qJyAjTACzeMmpZslbm9wVoY4o0ktWi+BVbUIDnf7YGWGg
	 Nii2o4Iw6d9nA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Step down from the PCI maintainer role
Date: Fri, 18 Apr 2025 04:52:51 +0000
Message-ID: <20250418045251.7434-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Moving myself back to a reviewer role where I will be able to offer
support with patch reviews and testing on a more ad hoc basis.

While at it, update my e-mail address and add relevant entries to
the .mailmap file.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 .mailmap    | 2 ++
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4f7cd8e23177..5224f3cc2d34 100644
--- a/.mailmap
+++ b/.mailmap
@@ -413,6 +413,8 @@ Krishna Manikandan <quic_mkrishn@quicinc.com> <mkrishn@codeaurora.org>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@canonical.com>
+Krzysztof Wilczyński <kwilczynski@kernel.org> <krzysztof.wilczynski@linux.com>
+Krzysztof Wilczyński <kwilczynski@kernel.org> <kw@linux.com>
 Kshitiz Godara <quic_kgodara@quicinc.com> <kgodara@codeaurora.org>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..2215a80930c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18581,7 +18581,7 @@ F:	drivers/pci/controller/pcie-xilinx-cpm.c
 
 PCI ENDPOINT SUBSYSTEM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-M:	Krzysztof Wilczyński <kw@linux.com>
+R:	Krzysztof Wilczyński <kwilczynski@kernel.org>
 R:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
@@ -18632,7 +18632,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
-M:	Krzysztof Wilczyński <kw@linux.com>
+R:	Krzysztof Wilczyński <kwilczynski@kernel.org>
 R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
-- 
2.49.0


