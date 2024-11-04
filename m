Return-Path: <linux-pci+bounces-15990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCD9BBDBA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E0C1C21EF7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7911D0944;
	Mon,  4 Nov 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLF06kRE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F111CF296;
	Mon,  4 Nov 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747237; cv=none; b=hjpDdQyMq8ceT3K0+dyoRQ890Jlc6SS4riLYPIekDeYlS1WREArNQ336Mj4otJZ3qxZblJxY5lpTcV2kdTzhKdMG7mb9hB75sDeif7UriVctfoKk1W8VO21kCeSNrdlEa7nWuidwfCNiPUNntUQB0/aI8+ZVSRaXIAluibIXUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747237; c=relaxed/simple;
	bh=HMpcHdTgNyxjOcX+7+u9IM4pPnNl7eacK/bkdyriNjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1NLc6JmD/ih93ccAr1YuLu3ol0uJw2dBnrRgmWujFRB0GmnSLRTZ3ZFvTutposfMgUVWBUmWoe3XyqRGZ8u+2MbXYPT+2132FUXuIm7HhsekuvMp4vWoUQtaY6mVrZyPVsG1mNq9lAI5ou8+pr1qq5KF86Iuqew4FZVbq+6+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLF06kRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF812C4CECE;
	Mon,  4 Nov 2024 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747236;
	bh=HMpcHdTgNyxjOcX+7+u9IM4pPnNl7eacK/bkdyriNjA=;
	h=From:To:Cc:Subject:Date:From;
	b=mLF06kRE3r0kk9oLvfJPPrsVzlTd1NMxZtFxqpJVV/n+EWhXnumt9+bnLKuf1GMDg
	 HxcfcbK2UQScBHcOFoznWjiU/O2X3bxNzavmm+jmg7/os/xl+kxfWzjfq2pNc8jiR1
	 ErKnKB9U6ThywDjH6hp2Q0ZU7gTBnXsO2tbk3VCIdMLCDOxPfPyYhY+R8LAUDPwqhf
	 ezJCvrb9kOLkINlge6KzQU202T7ei4NnLFFC+fngt+8HYfq/eJg/mntg+ArR2oW+pE
	 E3TWfkBZst899M2mdpkNPnlzBmr607Yju2JCwVftJHoN2mRPugTKMtepVwMXaM+4Lx
	 QNzo4GgSLYOig==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:07:13 -0600
Message-ID: <20241104190714.275977-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..d2291c3ceb8b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -474,8 +474,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	if (pci_msi_enabled()) {
 		pp->has_msi_ctrl = !(pp->ops->msi_init ||
-				     of_property_read_bool(np, "msi-parent") ||
-				     of_property_read_bool(np, "msi-map"));
+				     of_property_present(np, "msi-parent") ||
+				     of_property_present(np, "msi-map"));
 
 		/*
 		 * For the has_msi_ctrl case the default assignment is handled
-- 
2.45.2


