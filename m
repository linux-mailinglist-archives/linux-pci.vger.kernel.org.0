Return-Path: <linux-pci+bounces-16476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A789F9C46FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83E6B2C114
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E21A3A8F;
	Mon, 11 Nov 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl0vNOy7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00881ACDE8
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357390; cv=none; b=AXhmqQNPKiQFjiJlSDBQrvUyC4kiH34VYpN7ZryD089taoM6dBIXtKQ4MmVbAPn6SXu3aLs40hxP1/Z8ggHGCQX0gHsUC4t/vrBlcSRNATxBQ7eGQfQ4lLCNRJOXotM88o5WxdwG78kiP4og1l99nmb7g5lFP2BJGRe+ScuJrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357390; c=relaxed/simple;
	bh=sIbIUb+XpRlVLBrK85IovBCpVy0Ula3HZ6wm+Ol75kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5k9PJPTzirjQ1RZ4WF730Lmsk8MW0yrWwoPQlkffNrYLdnI25wLQuqeRpUSXO/uRP4N+o3xHIK+sjA7SFRp4eKCI01uaTPLBnhS1Uyezrds0o0ok1sXceMFUuGzuW1yNEf07EYaNPFHN3zB9DfHsiynu9doa8dSUma7lEoGng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl0vNOy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CF8C4CED4;
	Mon, 11 Nov 2024 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357389;
	bh=sIbIUb+XpRlVLBrK85IovBCpVy0Ula3HZ6wm+Ol75kg=;
	h=From:To:Cc:Subject:Date:From;
	b=Pl0vNOy7D2reo/YCuoTFgP0cS1sHfogzlvi7Og1cgnHX5iD047McZGXp/JyPPunrt
	 2niZVvA8LJp1hChvF38ZScr95wV9vsBABjXSId0CNmhvhPY3gCUVqzs7CFbiJOdvH2
	 GcPY8cFlr8LXPjUA5FROKfCloWqxLaY9KRnEFxP2VYg+CxOObW4OLV55qwdSMQE2qn
	 1w6X8k6bkv+nhHRtv9FKkdJ147p1fhd06OjNWGRs3KuonUXjBUT70hIIGD4Ckgqyyv
	 ubHoMx/OwuVVrdRjynmaP+q0CQDkdPrtmd/acHjOPHUsBDxgO98oEwRu5sZC/A2EBU
	 ck47Cuq2cFOLg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Tal Gilboa <talgi@mellanox.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Drop duplicate pcie_get_speed_cap(), pcie_get_width_cap() declarations
Date: Mon, 11 Nov 2024 14:36:24 -0600
Message-Id: <20241111203624.1817328-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link
speed") and c70b65fb7f12 ("PCI: Add pcie_get_width_cap() to find max
supported link width") added declarations to drivers/pci/pci.h.

576c7218a154 ("PCI: Export pcie_get_speed_cap and pcie_get_width_cap")
subsequently added duplicates to include/linux/pci.h.

Remove the originals from drivers/pci/pci.h.  Both interfaces are used by
amdgpu, so they must be in include/linux/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7573f81f58c4..1d5c519e19b1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -395,8 +395,6 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 
 u8 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
-enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
-enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
 
-- 
2.34.1


