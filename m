Return-Path: <linux-pci+bounces-6806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6308B61D5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D747DB21B3C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E813AA48;
	Mon, 29 Apr 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP8DH5Ap"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471B13AA45;
	Mon, 29 Apr 2024 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418311; cv=none; b=qzrOk+dA9yWyTtSmwqug0roWRu6Js+a1VXS8CaIROfG71OmkM0YHibWNDiBvMREIw84/ArsaFcA2eaV/HR/Pn5yVo7J894MKP7Z+Khp8RW3NSnzpfxRauaB1bPkplO0ucCCgN5mndkFDVwyAv/evuTx1Y4Zz0gUv7XEQFkknB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418311; c=relaxed/simple;
	bh=AhghYKrrM38h4mEYYi+e56vFeWtbc58kF0yKtXHD/ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XgaarvWKqWUbypchYhMjmH1ePSNYAikokNpp72I9pHhunAw62WtXea1Ks9tqUaCPLiiiWSEimgf61HbI7SJQ+sFViAG2eh1I1WHLHKIT2TcO1pXcFIR0P9dsAj7zMCGvWqMcSjxHMnwzP+XOLgb0/eCHs0aHzZsPGAiXOPP65I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP8DH5Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06907C113CD;
	Mon, 29 Apr 2024 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714418310;
	bh=AhghYKrrM38h4mEYYi+e56vFeWtbc58kF0yKtXHD/ds=;
	h=From:To:Cc:Subject:Date:From;
	b=vP8DH5Ap0xqqbMYT+95FrpoJBZrUXrgMUmjEqkFa+xmeOEvFKc9Cz8fOIOyTBjxsY
	 ZK+TsMqnA4cXYz1JuoYM95bEwk51KUgnNsKJlOwsBG2gHjV5X13wjkpXY+btTzGbY3
	 7m5gsfuMXHf85566atJi4POPgx8Hc+UaAFps8OCsGNT9A9Bf7Wrfi1UCKX5JerEM4k
	 GPw1HJmqjaWq/wcRXKRwM7Wv4ulAVZU3DDEI0hjnyPIMRkJJV8t7f8bAYgWURBtj8U
	 juN3ZOjc02ewfhy82I5rYGJnSH6OR9rn/BHGVH3451OdcemmjsWcXGA5qImaXUNDhw
	 oJ1/H+M0ydoDg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ASPM: Clarify that pcie_aspm=off means leave ASPM untouched
Date: Mon, 29 Apr 2024 14:18:21 -0500
Message-Id: <20240429191821.691726-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we claimed "pcie_aspm=off" meant that ASPM would be disabled,
which is wrong.

Correct this to say that with "pcie_aspm=off", Linux doesn't touch any ASPM
configuration at all.  ASPM may have been enabled by firmware, and that
will be left unchanged.  See "aspm_support_enabled".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c14b2f6..4bc281d6e8d3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4590,9 +4590,10 @@
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
 
-	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
+	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
-		off	Disable ASPM.
+		off	Don't touch ASPM configuration at all.  Leave any
+			configuration done by firmware unchanged.
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
-- 
2.34.1


