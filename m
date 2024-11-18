Return-Path: <linux-pci+bounces-17053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795BE9D18F1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 20:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AB281960
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7551E6DE1;
	Mon, 18 Nov 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJS4Cxqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E81E573A
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958238; cv=none; b=ZOeMtbksN0RMJyyo+RKH03Tp9VxKqTEThP+9H/mSxHPArXgs7yVWXbxdzQQBT++Ef2Ed5MEFhkqgxQGZZlxRHLTLwBebCnRdu2PsT1yUSb8M+PGEsD+5bhKWaWgiSw6o54zpKA0p0VAwhtxiG0AgZVVxn6BD1dnoQwPC5uiIhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958238; c=relaxed/simple;
	bh=S913wGvuB7JeIYgreY9ZXOD/DdRPiIb0Qi9yeUdOcbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KoyMS6S/K1Ukdr0Unr0dR2EiTJzLXMe+Y7q5SwgrtKFa8UayMNU5AetCzXZePVIcRFrHIhimNom5xR6BltCnv5QmXs/Em7jGz9c82WUSkHAqlN46YCnkxLnqr4C3LscafNGVYhuqsgC/6Y60D5DFIkp7YvLc85KNQ4ADzpKb4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJS4Cxqs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea33140094so58175247b3.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 11:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958234; x=1732563034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wr6P/ZNWs+UG6LNRih5t0AFP5XwPY2VvUHgua8CJ9U=;
        b=GJS4Cxqs1FjFxIFwOYiS6xPKhyNDSWWTdJBRt3kuhddkXWryBkxSDmnFnov0yvnYb9
         FDxeZY+DFFA1DB9WOQ9asVqJG8O4BVEvLv0Vs0p2XpzO12Jcob+15xnj7rzZVEQ/c98h
         ZS9Rh9GqNAS3sgeV8BYtOFtM+8qg0unNDXDoCI2K7Pv/LR0MZx2zS8+DfNxtTfl4iIPh
         2zSWiYkA3bdabPCDbmrf7dYxAoBJRsEHBVlW/X3r54CRaSxndjsAxFQz8lMveEl17443
         szkFg0mkhgvcwE3FJBB5FePOQs2fXlNLpc5b46b4oRk/aUd4/iBwMB2MYPtn12UPGHjU
         FgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958234; x=1732563034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wr6P/ZNWs+UG6LNRih5t0AFP5XwPY2VvUHgua8CJ9U=;
        b=HFfGqfsxlZqBMTvK+zaCrKgoEdC0npMkPywD05wo+kMoOu9HGV9XUINHW1r7jKqs2L
         O5HRVKpnA/gZOZ9GWRi8MyYrUFzsNmZ0ZnVunoZE4ORLz2Dqo+86dtTzjBDDQThVKtq2
         X+2Ba6xwdqO3nkmw4QcLhkFqnveNRF3hnE/vW6elO9OV8N1r6EE1wjVUy3po12hr1VVD
         VeREJ6j+bz/3lKR3WZGePJyLMn9DitxzvwIlwQsZ0/wBWq4SYiodV9T5ovUpItoxlmTj
         2s+EIl1X5JPoBgGXxLMq9PYOs0G78hLKSEYM1wvL7Uknb83R9AunT76KleCbhti5w2yK
         HG1A==
X-Forwarded-Encrypted: i=1; AJvYcCU+3VnOiui4fvQ2dcqQWdmFNSOoWetCJtyEV+fYBpk4lV20RrDJYTu6i07o7G6ZHkAyBpv5Els61mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXetgeKhGSSszzfOjTFXdOZB9CZel3u5xVBc0Jm+zGpT068Tvy
	p8F4bBHx8OfDhAq0kScJu+28Z26JKA3O4n6gDYL/kx92zKqWs7Ue8cq72xjIMkGD8R4BMg4fDTI
	sH+7qHA==
X-Google-Smtp-Source: AGHT+IHknQT/NkDmOr9j/PNk7G5Hvs0xMYQ4OkavikoXUQVZD+pjo7ZhfWwBfTDW00t0BAqaLLAnRDiIMb+G
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a05:690c:3081:b0:6ee:8453:f427 with SMTP
 id 00721157ae682-6ee8453f5b5mr551517b3.7.1731958234567; Mon, 18 Nov 2024
 11:30:34 -0800 (PST)
Date: Mon, 18 Nov 2024 19:30:23 +0000
In-Reply-To: <20241118193024.2695876-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118193024.2695876-1-jperaza@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118193024.2695876-2-jperaza@google.com>
Subject: [PATCH 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Rajat Jain <rajatja@google.com>

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joshua Peraza <jperaza@google.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 80a52a4e66dd..139e042ad2cb 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -56,6 +56,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID [1]: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..a457ae3e811a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1438,12 +1438,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property used by Microsoft Windows to enforce IOMMU DMA
+	 * protection from any device, that the system may not fully trust;
+	 * we'll honour it the same way.
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.47.0.338.g60cca15819-goog


