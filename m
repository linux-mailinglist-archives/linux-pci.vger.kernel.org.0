Return-Path: <linux-pci+bounces-11099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0B943FB8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 03:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B97280BFF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E71EA6DB;
	Thu,  1 Aug 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcHTVqZ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB61EA6D6;
	Thu,  1 Aug 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472863; cv=none; b=sb84O/rms+GsLAM1+Wz0kFcpVX7Vwq/3qGo9pnIvuRjGaV0bx1C2xA/1Zg3Avzq+gniGOW2bym5qGwklybAF313iZIrzxhQKZ4rUNSGGad/QteVig+mH12vEfdRmHalnxTnsmjpW2iEHjnS1y1JtsP8fUjYNDIXQfVdXY50JFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472863; c=relaxed/simple;
	bh=Mp2sw1LQUd1PlFbiZXp+5j9tsCiFZFCrcD9eCjtn1hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovnqMZeBSDdXJZx1q2vJ1eaWlpj4vBz2kNRvU2E10ZaSgDZuDZx9240JOW+oz4WFs8ardTYxFemfK3IgC7JmKHLigY6rydVLx5Gjm25J/Izfqkyujh6isTkeV/hOetgMAsvOUZYph8yJtEblF5Uhz0sxT6nuCmq9qboTzKdxEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcHTVqZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40E1C32786;
	Thu,  1 Aug 2024 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472863;
	bh=Mp2sw1LQUd1PlFbiZXp+5j9tsCiFZFCrcD9eCjtn1hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcHTVqZ0GEaTK538edZ24kdcW56fRmz3Yttnx3h1DHrZQs67YcmxC3tZbkE/sOW9c
	 88g/PAi0VTfmzeuo2hTjOsl2FiCPYdmKOEyz4znqzeNCQlEat1iUjLw0yB4XKj5zyp
	 s3M5KWuoGHYB/w4R7z4jbR1B7wmD9MODeO0JZlICvhmRSVYUDi5ZKYU8GZk9HIDJYO
	 EibyZ8r5/lpCrTDzO0rnpZEBPDd8+8iY8AOcfAkTmV2n4Grz+nelSrKsRMLNaC43y1
	 3JDjGlfIjQcTohDefvxd6oNl+xQVampFx9xFLsY+/SaW1V6fNEB+JX2gUz/IMhLW2n
	 Vo5xfDBYEG0TQ==
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
Subject: [PATCH AUTOSEL 4.19 11/14] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Wed, 31 Jul 2024 20:40:19 -0400
Message-ID: <20240801004037.3939932-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 3276a5e4c430b..486fad4309584 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -35,7 +35,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -54,7 +53,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
-- 
2.43.0


