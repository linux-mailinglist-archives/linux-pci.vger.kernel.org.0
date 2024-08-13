Return-Path: <linux-pci+bounces-11642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B4950A89
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF20282279
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE311A2C0A;
	Tue, 13 Aug 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6vOcS1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F31A2C01;
	Tue, 13 Aug 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567201; cv=none; b=MPmjUJro8saJkXDMf5ky9MwIy7wFVQy4vNgda9oh2wxL6Q2HhCYqAKAWYVbWk2eRv7PCwJlzmzm3FMsvmnjseXCi32Fnr3b6be7Ex3Qyk9qvLJ4JySjzRBqzqKlI8ZSa6FIVSHih/x+r1m6X2RJ+NyyMnhigmhf9CL6V49jfpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567201; c=relaxed/simple;
	bh=A0pHQcaUTgIJgvkKHmrqqe+E15t+0uNbfWTqtChe/YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VA7pvjGA7ipgntWu+aZE1QrL42fl+uLuzF37RFS1bcSBt8/IEPtKSMJE/SQ1MhZz8nBWVVHv1tkDu50a2ua4LUPH/BBec9Vxt3kAT2/dKbux+W29DCoXpVjStHOtwA9f3XEaf7TNdv4b5BQdi4yJgCZ9CIV9+rvr2Z6i4/2rDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6vOcS1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D00BC4AF0F;
	Tue, 13 Aug 2024 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567201;
	bh=A0pHQcaUTgIJgvkKHmrqqe+E15t+0uNbfWTqtChe/YU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=i6vOcS1ynhpQi+D/3KV6unrl1yWtKKkMJjvkrKsSm5j6YGfiTl8pCMJKfYUKAgRS3
	 vbCzRP202QvHefj8vLd00Ys62fjCiam/PTYf200iy67LMigTRjxwIs5j3CE6xG3wjz
	 itsCi67YWm29dComuO3ZiMKpBCaQcbgbTUVT/uPhHo9iiPOyPYpPhseTAxOiu637wE
	 h2vKjbdGE7RUuPX1TPSYQT68FddyZFWvdlUSICIbx9ZyGbTgzQUdNP/LaeG1IQqKle
	 /uW34KgvCHQAwQItrdsEVOX7fn3178mjwRgJIEtIOm6DBx9i6pfYk2XP1+1LmixdAv
	 nYOxWALRPhKQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163BC52D7C;
	Tue, 13 Aug 2024 16:40:01 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 14 Aug 2024 00:39:56 +0800
Subject: [PATCH v2] ACPI: PCI: check if the io space is page aligned
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-check_pci_probe_res-v2-1-a03c8c9b498b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFuMu2YC/22NwQqDMBBEf0X23BSzSpWe+h8iIcZVl1YTkhJaJ
 P/eVOitzOkNzJsdAnmmANdiB0+RA9stA54KMIveZhI8ZgYssS5bWQmzkLkrZ1g5bwdSnoLAhiq
 6jFODA0JeOk8Tvw5r12deODytfx8nUX7bn6/+64tS5CASlU2LUg+3edX8OBu7Qp9S+gA+2jwqt
 gAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=0ZF6Ci0GjEHWbF0h9iTGy8xDpgABqmqlKbAHXnzVJoM=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmu4xelt/qz9EDOzhpIjWxWhbApkRhd5AgosWCm
 qkMnNroN+mJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZruMXgAKCRCwMePKe/7Z
 bvLJEADA9XNjIMty4vKg9m7BU2OcV9c2MdfE/u9irh9gmrO1sdmMHZgOX1MP6B/GU1CkT3D3f5H
 G4zlWQjEw2M/syzvDMUyPnrwPBX7JG+ucX1oNDhPFXa16N+Nw7KMn6MGO1Fcis3AgmwKCCXNaOL
 vvv5Fk5G4AcBhqbIqe4xSv0iiYA9q6XkoDb5ssXGbV9PTdKDouWSvIkgOe4K1wwq0C6mTjjTgQO
 HIxd9aL7DJmgeF74x+R3ODhCGOhNLJW0rWuta2dHCZIA6bzJj1jYHLZKwxZoXeWrwT5qxnKW9BB
 dDt3gHk83p1lBsERi9EdSV80qirzx6YzkquUr/abM3++b+OcSJQ7H/u/8HoFM9RAaOSVen1Yx26
 GxYl++Lm7wVn5P4q7L7ouzTxU5P+eXLjmIyzNiapQqFQ21yYOlD5JQFF7kp0T1aqhJe+4cwl9fu
 wkSot6h0vb2xntW3DcsmUzJe5iWoslmPK2T6yNz3uyqg/Tnbmx5wefFZptEjHcX0L5W0BRaBZmj
 JFn/Qv5yKU6xS7s+D/tmDKEusaDbqTW5keXjK7DxgsKfgHuXSZd/ixhF/zui91Ojd6fh+HdlyYp
 8EtrgvxqEWdGsonS0Oh3pS33cRlkFcPTR3C3Ao/ZPAjXeLHt3gavx+HDRdumtiDd8IVI4x93MfI
 PVbuMJY/P49rXUw==
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
Changes in v2:
- Sorry for posting out the draft version in V1, fixed a silly compiling issue.
- Link to v1: https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com
---
 drivers/acpi/pci_root.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d0bfb3706801..706449e5f29b 100644
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
+		dev_err(&device->dev,
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



