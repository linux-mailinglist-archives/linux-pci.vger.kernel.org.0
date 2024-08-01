Return-Path: <linux-pci+bounces-11093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22181943E62
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 03:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E06CB25CCA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A91B9953;
	Thu,  1 Aug 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElWT6Nge"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9491B994E;
	Thu,  1 Aug 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472283; cv=none; b=mSLyznUr5hiMPQRtfygSqEsBVbAMHtPIABLHl5YRWDAFTwTbzaImWqjHGs16Ljk1+1ZY6OK/tjZFrqp7bxDgDM4RA5b3YTP1da1vBwVp9X9P2XNlFKimjzY4NuzMmPbg98xcx51cpMOGULuhGyd4FMr9xIDi1pDv9OnY/nAua0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472283; c=relaxed/simple;
	bh=zG7zwTNzZpJGhl48N6vwkJx0GeMhonMcxgLMd8V2Fig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcipahvYeRO3aIBNMN/A1xb7612YTd9saAEiC3Y+rYdQB+0cMh+RaONtyC2RdaY6g1fCk1APNth8MYu5g9c4fjFA9clxdZTqALdfBkKSStRjowUEJXEYh4whnBDuO8kLh1Ayw2eV0eedwp+s7XcMxeahL9j/ngj+UoC5UTQPQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElWT6Nge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0AEC32786;
	Thu,  1 Aug 2024 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472282;
	bh=zG7zwTNzZpJGhl48N6vwkJx0GeMhonMcxgLMd8V2Fig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElWT6NgebivVlDGLueM3Bq6D1y2Dt7QGFEU/78tGfdYyjwPc2XpN1J2pgr3kLbr3U
	 t3H7mFbUZr5PZdchAzzl82rTCPHDiOe0OkeexvuKthpHI28prApjbBr7kmhQm6Snc6
	 Fn84DnjMnkIXSy+Xel4W+BIaoVYGQJcVekPkrLvL1zGYyvKoySqCw5gluyRdH+ymT4
	 6QtbtBFpbq86WweYpDkrAJigUSgBicRDnLi8M8BhDzS7V2OpWo7dyx/VBwG5sQMKBh
	 4E1EaBJQzr6LWahfjhyEDYSmQ5syRVYmjrWiq1gRVyDIlO9AdRxipWKJLL8NZw6BR8
	 9+pjmeBbYFuTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krishna Kumar <krishnak@linux.ibm.com>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 55/61] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Wed, 31 Jul 2024 20:26:13 -0400
Message-ID: <20240801002803.3935985-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Krishna Kumar <krishnak@linux.ibm.com>

[ Upstream commit 335e35b748527f0c06ded9eebb65387f60647fda ]

The hotplug driver for powerpc (pci/hotplug/pnv_php.c) causes a kernel
crash when we try to hot-unplug/disable the PCIe switch/bridge from
the PHB.

The crash occurs because although the MSI data structure has been
released during disable/hot-unplug path and it has been assigned
with NULL, still during unregistration the code was again trying to
explicitly disable the MSI which causes the NULL pointer dereference and
kernel crash.

The patch fixes the check during unregistration path to prevent invoking
pci_disable_msi/msix() since its data structure is already freed.

Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/all/1981605666.2142272.1703742465927.JavaMail.zimbra@raptorengineeringinc.com/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240701074513.94873-2-krishnak@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pnv_php.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 881d420637bf1..092c9ac0d26d2 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -39,7 +39,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -58,7 +57,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
-- 
2.43.0


