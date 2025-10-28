Return-Path: <linux-pci+bounces-39510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CFC14129
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64E3B5630E3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5030506D;
	Tue, 28 Oct 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPuh0EB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96D1D31B9;
	Tue, 28 Oct 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646761; cv=none; b=ayBO9Xf6kUpurbEg/ti8LO7gzHCZ3dsdVKL6a20wtXvUVaOoUdGJ870uVW/fHcH0VncXX9CDXZAvDSw8i09/AIDk68wQFn7ndEPJQcqqwH9lw5WxIWDUtTP+D9YISuKsv4jfXiFiyoG3QiGks1utGlcW8BYyU6jisXxAnFD3JXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646761; c=relaxed/simple;
	bh=KkOSLYci++vNRNEQTXDYGgJqFXUhVXvlHo6io3wLa/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIMRY3I62vxW58TrfwiVUX0EQdmS074PL9W4SMKqCYFdZueTk+rA3hcXysqhf609XBbWIjMYW2YK40pnMhWp467HRXVPp/JeiD+SuLkNq+dW9VOMWU6jlRkTEJTh+7+k1ivi+st7V+vnG5b7897xBworFutNUGAgkog0/s+1Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPuh0EB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ED4C4CEF7;
	Tue, 28 Oct 2025 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646760;
	bh=KkOSLYci++vNRNEQTXDYGgJqFXUhVXvlHo6io3wLa/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cPuh0EB0azQbYctGin8hqnUkPiYwN2MTm0rtBoagUm5KGBcfPOxcUIRMkkiPWhlbg
	 9nXKlDYoqPaGGRTLqqNsUiJ7EV4vHI/7s1ImXFl3lDsy/nJ/VQtjxgtLdmMdPPjbzC
	 /IO6krhU/I6Qh91mifyLsmQxD00sHLn0t3iJZn7yU42/4d8T+ed6pM89Gfaf00CNpx
	 x4Wr4gV1N3YR+euOSAdoxcOZ7+qf+6unzfRiHWVLYoUM0eIHbaC1DIgoEccjxTRRD2
	 AmoUtju3D2HfCFAbTnFSKM9+XRKKsa1MSBqb8WK/4LpHZC8NC2p7nFMjpjHolOny9H
	 TjjoTaXS5vC/w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 28 Oct 2025 11:19:00 +0100
Subject: [PATCH not for merging 2/7] ACPICA: Add Arm IORT IWB node
 definitions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-gicv5-host-acpi-v1-2-01a862feb5ca@kernel.org>
References: <20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org>
In-Reply-To: <20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jose Marinho <jose.marinho@arm.com>
X-Mailer: b4 0.14.3

From: Jose Marinho <jose.marinho@arm.com>

ACPICA commit d68693b24e5235a7da4d57e690d3c13380c14c16

The IORT IUWB node is defined in IORT issue E.g
See https://developer.arm.com/documentation/den0049/eg

Link: https://github.com/acpica/acpica/commit/d68693b2
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index fdabc6c64a9c..ba1a36d23e32 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -680,6 +680,7 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_SMMU_V3 = 0x04,
 	ACPI_IORT_NODE_PMCG = 0x05,
 	ACPI_IORT_NODE_RMR = 0x06,
+	ACPI_IORT_NODE_IWB = 0x07,
 };
 
 struct acpi_iort_id_mapping {
@@ -858,6 +859,12 @@ struct acpi_iort_rmr_desc {
 	u32 reserved;
 };
 
+struct acpi_iort_iwb {
+	u64 base_address;
+	u16 iwb_index;		/* Unique IWB identifier matching with the IWB GSI namespace. */
+	char device_name[];	/* Path of the IWB namespace object */
+};
+
 /*******************************************************************************
  *
  * IVRS - I/O Virtualization Reporting Structure

-- 
2.50.1


