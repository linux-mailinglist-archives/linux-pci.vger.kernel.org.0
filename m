Return-Path: <linux-pci+bounces-19261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8BA00FE1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5574164ABC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE671C4A34;
	Fri,  3 Jan 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhAspUKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC21BD9FF;
	Fri,  3 Jan 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939902; cv=none; b=QoXUhaJ3oB7knaHH/3uMoTxljce7Zfjh/qGU71eIOBJDTBDFghnDMNXSQLSWNAcWEC0jEffnSnmQVVDjicsNyW8dOgK1LZpTKCn/mNYNIGQzN7mgU4cmaEupHWpo1mzJgrZafRt2nWdNVpcYM1rh8aqkYS7dVoDjU9xMyIQyCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939902; c=relaxed/simple;
	bh=EuCGkIFQhILIwI/BmPvzsrziE7WAnUsgkmw9+dkwRlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a69qsVYB6sOWFayv3+O1hxtFZ9ywfeELl73klfjZsSN1RI5tv0LoOqShIGDcvEFuA/AAvCBgF0fR7QVjZbqCoX42xJp4lK+/I7R1nHpRVwLYJJ5Vl/XuREO2yTGapKct773L1aESS4rLTQ6ogQL52l+41lFzmfe+ImwwHE74pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhAspUKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89680C4CECE;
	Fri,  3 Jan 2025 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735939901;
	bh=EuCGkIFQhILIwI/BmPvzsrziE7WAnUsgkmw9+dkwRlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhAspUKFtF39lRlM18VayT1QP+099ZCaZZ4nEhX+lax4q812ogmxjpOcMki7XHF7Z
	 1aA1DlJPoyRNkiaWY+ftbCTDFfKbWeZ9Kp36E4qLPdFAqxKNrCa5S8dX2h1gJx+zVB
	 QFkPMgGtfQIGamvs5U1epM4jE04jSOJyLG6qVxbGXo/CgQx4YSaQGuUHwaMVX7HgM+
	 uLlxCcCDP3MACJdapylvZdyeadGbYBm36pMWDXN54imLO55f4OICkaZjKy+iUp/pfv
	 e0HCmHGqhXG7xSYSgGo02Ej7AJlhZhwvD40+lotXybtfkMEx0CmxKj7NT/sSO+8Eml
	 dHnkHNK378XSQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()
Date: Fri,  3 Jan 2025 15:31:29 -0600
Message-Id: <20250103213129.5182-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103213129.5182-1-helgaas@kernel.org>
References: <20250103213129.5182-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

5bd51b35c7cb ("PCI: Rework of_pci_get_host_bridge_resources() to
devm_of_pci_get_host_bridge_resources()") converted and renamed
of_pci_get_host_bridge_resources().  Update the comment reference to match.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 5eeec9ad6845..2576f4f31309 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -361,7 +361,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	int i, saw_mem, saw_io;
 	int num_pbm_ranges;
 
-	/* Corresponding generic code in of_pci_get_host_bridge_resources() */
+	/* Corresponds to generic devm_of_pci_get_host_bridge_resources() */
 
 	saw_mem = saw_io = 0;
 	pbm_ranges = of_get_property(pbm->op->dev.of_node, "ranges", &i);
-- 
2.34.1


