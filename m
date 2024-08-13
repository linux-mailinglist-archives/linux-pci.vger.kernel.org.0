Return-Path: <linux-pci+bounces-11640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D603950A0F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEAB2822C1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81558168C20;
	Tue, 13 Aug 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJuhP42r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785C61FCF;
	Tue, 13 Aug 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566276; cv=none; b=T3+5XeMVEivGS9jWzE5JNMIR1Ye8AZc4vAFuk59nhv8tSZFXhOaNMC1pRH3tE/G4DnlQYFPr6FDmwUKv6BN5pX6fK6U/RJ0MG0BmwT/Q/75FmbPXU6bgMu8nsQyjOvNO2XVCigGiuf3bM8F9Ce00EJ8EIHKjDE3UwUxCaX2er2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566276; c=relaxed/simple;
	bh=HupQmP8H2Hew13JPIhJg7yB7LdydKs96S/l0u/WlCTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qMJJ3w0Hs+OZO5r7RUaC9U+eGyCHprBN+1LikTrtbNKYdJPYZjfT0sD9Jl9s2tSvXZwrr08enbi+hcoX0hjRL94kom4+hpaOehIRYGdD04NE0//JVLggSIvYUeg6MMsSjAWJ+/+h/ZFWYIcdxrR3HiFgWhOMBGuOUnXi4TYZQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJuhP42r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6FE9C4AF0B;
	Tue, 13 Aug 2024 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723566276;
	bh=HupQmP8H2Hew13JPIhJg7yB7LdydKs96S/l0u/WlCTk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uJuhP42r7U+o7TqDdsdH+cmPeopEBOkq2bp+yvJedSLhmXr9wL1Uw/Y0PoBf703+V
	 4Zdt0t5GMn7Fpt81d4EAeqJdCraPuspSiwTowpnaWcecyNQSMROIyNmqY1kDznKNKG
	 MefOi4P5fSTP9u7qxGOZrVwHBLbPZTMbnZIsi1mYlJfa5++RCvArwIrF3Wubqmi5f9
	 aaPIwPqiLu264Hbr9izTn2ZDbSFPOs0DdJ3OHdmAD7s+0dh75YOm0xbaIx976CYMuW
	 guUWjPicqvefOpXb46ymIwLr6mjJmNuiXjrFu9dtuG8EC6Lcp5ZGJt1tIW5tFDWMQZ
	 /5DEuGL5P+qoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A3C52D7C;
	Tue, 13 Aug 2024 16:24:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 14 Aug 2024 00:24:20 +0800
Subject: [PATCH] ACPI: PCI: check if the io space is page aligned
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com>
X-B4-Tracking: v=1; b=H4sIALSIu2YC/x3M0QpAQBBG4VfRXNtiCHkVaWP9mBTbbElt3t3m8
 rs4J1KACgL1WSTFLUGuM6HMM3L7dG4wsiQTF1wXXVkZt8Md1juxXq8ZVhEMt6jQLGvLM1MqvWK
 V578O4/t+XtUqAGUAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=DWlqRiPe/fYjvNSchc34mMH7Q4Dr/qB1v12rnVJlSKs=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmu4jBfTWgmYDF3W+Yt0apBYRG6e7gwIu0EY6zA
 47PZgNAN+mJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZruIwQAKCRCwMePKe/7Z
 bhowEADDH2kpqzTz4n37l0QOBIHDygNvWr9UJFn3DVnUaEp9kxAJ/5p5rc347ZwF+qYvcCFty1Z
 yET9MdWuOHxgPoE+ujcPMqvANyfoSpD1ZmaMjmHr1kP7fi0iPraFWbwSkOBagx6Kj8xK8Cxd582
 ZuvP3DK2keZ78PF4HZE7lZkOr+MjxAZ8lSL1TdkIRe2UsdRu0WA0/s+QN0ZsfUIwnRFiME+JHOJ
 msH4Hqumm/rH0wt/jkiKa+LRuSHr4c+K9aB9LEvL3Pt832Yal/GYWWEuYjFGXqXuSGUgrKu+W32
 UW+Ld860zXGsScoHrZmrQykHmhZcWKlUbBzcMlT0ul1giWXiWYgTp4yDrBgfyfRhR0sLIWha9l5
 gN9fvEjPmoZCgnEp+8oc5ELNFGrFxFQOEiXUIb70IEfb1U5c0pB1I5sxkdj6e8mnmFblGgwcgJP
 Lis1rJvtIdWZKVyFD6yCWO9ZD6d7plMUTphSCMEqaRcDLOvxgWQF+SSQB8sI95WrcYHZ3YLgclS
 WlBszCfzc9bpJUxIYQR1jBLjKiIaDEnViBXYaU1+FKBf1DU+xdxWUzIFV3jpK3E6F9Dp4cO3vU5
 yZ0HWYizm4+i6wcK5ndOz/j0B7HTPF/0x9OQfY7divv8+ePl2g/1JweBpDfYHX8/uAiBrNIIW8u
 y8OJaxoNeu7CP0g==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Miao Wang <shankerwangmiao@gmail.com>

When the IO resource given by _CRS method is not page aligned, serious
problems will happen because the mis-aligend address is passed down to
pci_remap_iospace, then to vmap_page_range, and finally to
vmap_pte_range, where the length bewteen addr and end is expected to be
divisible by PAGE_SIZE, or the loop will overrun till the pfn_none check
fails.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 drivers/acpi/pci_root.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d0bfb3706801..58fc64757bde 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -858,7 +858,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+static void acpi_pci_root_remap_iospace(struct acpi_device *device,
 			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
@@ -868,7 +868,15 @@ static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(fwnode, cpu_addr, length))
+	if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
+		!PAGE_ALIGNED(pci_addr)) {
+		dev_err(device->dev,
+			FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
+			res, &entry->offset);
+		goto err;
+	}
+
+	if (pci_register_io_range(&device->fwnode, cpu_addr, length))
 		goto err;
 
 	port = pci_address_to_pio(cpu_addr);
@@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(&device->fwnode,
+				acpi_pci_root_remap_iospace(device,
 						entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240813-check_pci_probe_res-27e3e6df72b2

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



