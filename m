Return-Path: <linux-pci+bounces-16689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D59C7CDC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A01D2843E7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1215209681;
	Wed, 13 Nov 2024 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Dd8XyYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04834208208
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529342; cv=none; b=MK53xMMYhu3hvzK+dsR439trluxeF47f8m+p40zENlyFgr4nhz/YvkyOSqeAm9HJHbUdbZGsf/wi3ewQAIUxdoCeJ5D0P5+9Xz/EzvT1/a84Xn+LPm+8DVGJZh9rjDAEWNm6ARQGW8q9M4Esj/4+Mj2fB7A6aMdwFJCYBgecvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529342; c=relaxed/simple;
	bh=36UDIJFEtl8dI9uWjyjPxbwUnwsyY+Q/Xb1gKSZkPyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HGZK1cJOdqipW+lZ47zCtImkS01YyruJyww1YpLw3dOQX8BttgfCaZVvrq4Tp5rAUbwYs0kAuwdErMsoEG04/hyiaKezAvHCHiQb7AgQX+iL8OLPbqXkCuffmTNLp6RZckKxAUZ+MCgF21hkjA2iOQwR3wsMRuXoKOo5Q01Ttgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Dd8XyYX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eaa08a6fdbso132435797b3.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731529340; x=1732134140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOD5CgsBv5t1tl/Irzq4wc0q+ucmZgxcGN9rsSwagCM=;
        b=2Dd8XyYXTj486IlUvjdSAAddc2wXXa9bGdVFLV1RCxj4+c27ikfoTR/PxVgMfo+1/t
         +MlOUaGsRPJlelRqGZu7ASSyHNjkWBqa0tIS1SSSQg18isnwqzqE07yjURoJ4JVm5Wjf
         3ofaaRbOkDKqwGVhg/tcSUY9whN7g1C14SxZfiAa7A0o5I5mWHssEdX8pxh7W+FH2qM1
         +Dlc5G3FUfVtirBEnhDDO2EENPD5DMH8f+G1QNvIXHlB48IXbYRSTWAMHsfVsg4abZLq
         lT0eh3fzkEgfLIE/FrGXIskOCzWz51GpWPI+s+oNX29uoYpSuuqppasPhkwTGwYbMByU
         ensA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529340; x=1732134140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOD5CgsBv5t1tl/Irzq4wc0q+ucmZgxcGN9rsSwagCM=;
        b=eorb2xZMh91e6vRBjLwJ6s4xjgxaUYyrEnOCGCKnBdzNvzSQEr0UuntLd5jPOOSQ+X
         AXaAKEINxodBlgrM1QmLWkC4XOdwskqdPv4X1f+r8EHwi6S5uc0hkoru3gKEvaHi01Sc
         j48tR9yXDdvm5AB9LzX2c3dorXQTCe5qNKQKhwEBY2kAq0jz8QrO7oyAcs3j8wmEC3G5
         KroN9NlY1HciBsB4/vM71s0kKypJ6HTj8IZyMAJO1IEr3zlwK4mcUmONHcznCq3yTIOC
         8YM9gUlym8iaR2SWpNpveOIVmmvEHNFvTD6k3o5JqEkn5Lqq7QmZPJAUb/3rKQZ7olnE
         7tVA==
X-Forwarded-Encrypted: i=1; AJvYcCVK0DM+QKSqehsFe64XPzlp4T5o/JFO5uY7zqWF6ds76ToRAT5wM5jjm7tyVPLv0T1jjYk3dNsNjA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLgr6IlYp/oonMbQRbRE81tvEOhe8m/3+WW9Ny2ALaKCRopK8
	5oJ2zmn1Mc+lENMgpvjwI0CLMPtzNS7sqxicP/ueOOh1lxS34oM+OrBX4tjxv2srqjfFvTIba1h
	wZa7CLQ==
X-Google-Smtp-Source: AGHT+IGct1AMLUzk0LVs3zMWt4t9KvflGEFbP2gZ3I7+ryVQ0uGBIkPYx72xsys5OE4o4f4iV5S+bzbUp/LG
X-Received: from jperaza.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:f86])
 (user=jperaza job=sendgmr) by 2002:a81:b512:0:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6eca4bc5c13mr937467b3.4.1731529340188; Wed, 13 Nov 2024
 12:22:20 -0800 (PST)
Date: Wed, 13 Nov 2024 20:22:13 +0000
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com> <20241113202214.1421739-1-jperaza@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113202214.1421739-2-jperaza@google.com>
Subject: [PATCH 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: rajatja@google.com
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org, Joshua Peraza <jperaza@google.com>
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
2.47.0.277.g8800431eea-goog


