Return-Path: <linux-pci+bounces-11095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A525C943EFE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A36B1F212FC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89391DE0E0;
	Thu,  1 Aug 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYQx16om"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88F1DE0DB;
	Thu,  1 Aug 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472530; cv=none; b=aGvcyACA2LZHeN4pZ2v+eWmJK94CSeL/KmK8tY3Mc8L6duPP4vrn5cMY1yb6viEzabTF5oZP3mZKJB338tohQJBPNpuj6MySMeSGY2sFs+aUGjKAX3DCaR40kFZ2dS3LFqzlCPVM8WBrWoq2nitiAZB0voArIpLj4kSzGyPDKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472530; c=relaxed/simple;
	bh=Lp/CkH9sWC8WcDgHAMzi3z91a5u20XsSX+ogEhcdnHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX23Nnwn9lMIUd3VFHHYEqz0zp7AM09COKpgNtxVImc3EJXR3mI0qvCO+OQ4wjVDniI1KpPHXSOK1HFxrZw88Niqxo4aXCboeTWSm5rdFBx/hmHcVG30RS5ZfC3a23GfV77cn+773V4NraZeD7Ip5Ey50HHSlC/X6r3FQYj8E+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYQx16om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963FC4AF0E;
	Thu,  1 Aug 2024 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472530;
	bh=Lp/CkH9sWC8WcDgHAMzi3z91a5u20XsSX+ogEhcdnHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYQx16omu0xWhRkPSGksPfM8jtB2E8IUFsZE2b++hn7UMuiHis4yCUWuYbIsyeCPm
	 5477vrmXqTwCnW+p14amOx45OMfkcamNJBnNOEHRcdnb221g4VDVbcSLNA/Y4i7qyX
	 sh5SuYQCT7RtSIhsmn8Pjp5kHyRiJ3piBT2ZvtDZPbrgQVPJYF1ebC6qbK1oFg31J3
	 YFrK+/uhxnitfqhamf0UoQPDvveEg0EoVXZDRXo5mpe0fjCWYF/u+XQAbd6LadckmK
	 Y0q85Aw7drHNvEZQ8pSFpX+wsko6M7HX43LWLwhDJZlQJ4RDPXj+kyhLSsgKZAG8gu
	 1m3MDC2F+xAHQ==
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
Subject: [PATCH AUTOSEL 5.15 42/47] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Wed, 31 Jul 2024 20:31:32 -0400
Message-ID: <20240801003256.3937416-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index f4c2e6e01be04..e233f8402e8cc 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -38,7 +38,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -57,7 +56,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
-- 
2.43.0


