Return-Path: <linux-pci+bounces-23432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195BA5C42B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B17816E77D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876212B9CD;
	Tue, 11 Mar 2025 14:46:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA6208A7
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704373; cv=none; b=K76hEfqoMC2JR/DZHZg7MG8tPA60GHXIIYp8gJYYnbnHp+5yxixTt5tgoJuyKKZGoaVRq1lM9Ouq5KMfHG7xEGOWkXe6pkwmX/ECqtgEQFi5L/LdELSTiYIx+/nCwRc+lHSaZ/BTLDbQ0ZOcFe3+lIok/RSCPWyZkUf5WSHh9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704373; c=relaxed/simple;
	bh=q+XrkpsMsaO/vSyV4vN1hLjqe4y2o4whjb6SUrxrivg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZWv8imLfc2lJ+GMBzVei0NnuGl2kbT3JE1s/xuN3KN98BNX46wK6eiNiffEjymXtfTXfBQzP4nk0FUqKyGEnOKl0prUF+Cl08Qp9w7QgC7Uhlnqv7lib0rMdWdOjpAd9SrYXg1st6g/5QFjFdUdbfa8abhdu9AkRsLMhf+Sqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6B01692;
	Tue, 11 Mar 2025 07:46:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E18F93F694;
	Tue, 11 Mar 2025 07:46:09 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: lpieralisi@kernel.org,
	robin.murphy@arm.com,
	aneesh.kumar@kernel.org,
	linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	lukas@wunner.de,
	sameo@rivosinc.com,
	aik@amd.com,
	yilun.xu@linux.intel.com,
	linux-pci@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RESEND RFC PATCH 1/3] pci: ide: Fix build failure
Date: Tue, 11 Mar 2025 14:45:59 +0000
Message-ID: <20250311144601.145736-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311141712.145625-1-suzuki.poulose@arm.com>
References: <20250311141712.145625-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/pci/ide.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 0c72985e6a65..f6f4cb71307d 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -318,15 +318,16 @@ static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide
 			return NULL;
 		}
 		return &ide->partner[PCI_IDE_EP];
-	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_ROOT_PORT: {
 		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
 
-		if (pdev != pcie_find_root_port(ide->pdev)) {
+		if (pdev != rp) {
 			pci_warn_once(pdev, "setup expected Root Port: %s\n",
 				      pci_name(rp));
 			return NULL;
 		}
 		return &ide->partner[PCI_IDE_RP];
+	}
 	default:
 		pci_warn_once(pdev, "invalid device type\n");
 		return NULL;
-- 
2.43.0


