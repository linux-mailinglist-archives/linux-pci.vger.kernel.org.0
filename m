Return-Path: <linux-pci+bounces-43275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAFCCB555
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D09EE30D08DB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784233D6E6;
	Thu, 18 Dec 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvxw4WEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E233D519;
	Thu, 18 Dec 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052914; cv=none; b=NvcUP2es6VqXCZfR8GW5rRvaTpeSpvhdJqyCI2S0luE7cBjZh48f6Mua/+AYXZ+QH3idCRTQWWXTZVrgHBRrABsC+ebn1Q/NhSxukDmxJt2uIBSljPkFVWLdumm00ikZ0Fb8s1gzU87QHtVNnbWAeUR3Mbv8YzLL5dFXHnUw3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052914; c=relaxed/simple;
	bh=O2IYaXBjmzGVATucF4s0OnNh/D79299lGX0XG+UCCJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4BcXac3ZzhrP6Dlz5t6TKE4twRBnqrf6KMmCipnnZ5sJ0vKALm0Tkf2HCQYZlzyEzBlOiwMkWLM5OgL6GLt1Cf7kpVuJ8eBIaGkXT2nlJLFOuGn6/01CGhKJUFyoM4WFCmfLxNGNAywjEmcmCzqwCaUIGNNbevuvfhAf4StO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvxw4WEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EC7C4CEFB;
	Thu, 18 Dec 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766052914;
	bh=O2IYaXBjmzGVATucF4s0OnNh/D79299lGX0XG+UCCJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fvxw4WEQaz44c9aV3tXuTMKcjMx3lwFdnz9x1vkVlLwafeGqA3hugyiaQRJxmz4W8
	 5GaGMLdA4+c7xEr6NX3I+MH4FH9/BxY1o5GTo+Q9ZkU4kK/+PH1nNDJ1ed4QEWfXkA
	 2aDbWC5tkknMLaFV9H1p1R1jvHaCtdWTRgS5hI6rw9Oz5supUkm9MHtlGgfxqFnOX/
	 l4JIQUxwJlrn2yg2iN76Kx6iqI4IyOWAMwrViTe6Ar6cvvfl3PPZ0F14ZALlCM9v8h
	 VIbqtKfWh/W0hwVuMuYYQmKONdcgj2BqklrBg9IW0hULUsbYmePPtHp+jblJRNmjC8
	 F/FDdN139IUDg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 18 Dec 2025 11:14:28 +0100
Subject: [PATCH v2 2/7] ACPICA: Add Arm IORT IWB node definitions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-gicv5-host-acpi-v2-2-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
In-Reply-To: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
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

The IORT IUWB node is defined in IORT issue E.g
See https://developer.arm.com/documentation/den0049/eg

Link: https://github.com/acpica/acpica/commit/a90dc2f5
Signed-off-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
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


