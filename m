Return-Path: <linux-pci+bounces-11091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF8943D97
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 03:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D55A1F21F13
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A21CBE31;
	Thu,  1 Aug 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs8yuN9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655721CBE28;
	Thu,  1 Aug 2024 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471957; cv=none; b=fNsIrmR7jM4KVadCUmOVbTEAAn0Kz1YPUgj9qzi3L5Sm9RXpNyfXr9sqwSIT2Wia6K+yJCJfVhQS3NZNqVGvqtK7a+s9XGqZ23XiE/LgQNoeFfYww3E4K1YPPj//Ofuy3UZ+ZQ+H/Hla+2xwRSl+Sf+TozNNGTmENt+nm7Gng08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471957; c=relaxed/simple;
	bh=zG7zwTNzZpJGhl48N6vwkJx0GeMhonMcxgLMd8V2Fig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqkL6sW+iEd65rF3oPBMSjSIzgDKsHRJSaH581Qg+n+L3m4jOQtkPOSVmYu2TRqHM9OMb8TTvFhLXIM/RXIX8KGMhHZPXFfDxxNoIAL/WBy+5PbaYI8b33P96C3me3G9m6RtSwJxZlZjntEtDyHTrVSMTvVj6UScqTzwc8b2ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs8yuN9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BE8C32786;
	Thu,  1 Aug 2024 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471957;
	bh=zG7zwTNzZpJGhl48N6vwkJx0GeMhonMcxgLMd8V2Fig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cs8yuN9y5upZ+usjHqzizrbwxHtOzLjaH8qVa2bWhXiXDCF0ZZT++matuduM7v7Pd
	 DLYX0rGtJQ0wiV9LwcN7DTHrmksuDl78xoDyCRcMgpcdOFS+bxQI7IoxMg4BjHCeL8
	 o91QfnKvXu2GPKixHUX3ALi0v915bJiIIUbVBWVBak88gCVuWPogFKyMnv7YyVR1Cs
	 mlyz5Y3pjlBJoBYJwbPu+0jcWFgxf2CesIT/C4qfJeSFAVKhYz7UPLaafWlNa8omI8
	 yBRLjMW02yT0JXxKZTK055qBUCNa/DBE9H4Frgz7MjTPrAy2Jj4g7C33xDgIE7xeNd
	 UGE9kYlWEgntA==
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
Subject: [PATCH AUTOSEL 6.6 74/83] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Wed, 31 Jul 2024 20:18:29 -0400
Message-ID: <20240801002107.3934037-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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


