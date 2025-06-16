Return-Path: <linux-pci+bounces-29875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3595ADB545
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE773AEFEB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81E28152A;
	Mon, 16 Jun 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gudnlrs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74B2586DA;
	Mon, 16 Jun 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087498; cv=none; b=qaHHcm6o/dY6U5ogCLbYJ60ByhxcRHYBQ6xs+/G03U3o5D03nA46iT+PH84QZL/CzkWFpi6rZyUNCYFmeI/uhP08bi6ZVFlEf8awvKx/QVEKyWHhHLYO4Kxv/4T7dcwOjJW2nEGL4lgBlE0PSfgXp5u0GABP5nu4tXh6s45SJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087498; c=relaxed/simple;
	bh=1zST8I1L47LsyprRInMB4W5wPxqsdKmiB6rSknrXSXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rtcWb8tV7fCUHn93hx+qNDh6WjQ+XbJGNAVXC05AXII5txry8LZ+k41kVrgWXL9E1xIADovvNmkTOtDM9V3vIFYuJVVlacjprWtJr1yMUB91CE9QLnScffI0Qtw2J2OILG/PUl0RGc1S8hqXRhiQCavPCAyo9J+QucXWyV2wo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gudnlrs9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CB
	PIeMxN4KZH1YUu5o5pO0fqGcObPWjxzDMlC6AruYg=; b=gudnlrs98kVynardqx
	g71pP51O2JOmdtivBBygr/KmdlHlKw9meXhxWKNZzLlDiCS5/Euz91hAqOkcc1vh
	92u/Lz4IQ4gg9JYTBfYgTRPgzf+eu+IhO6JiIS2SEXmweKPqchTK0joiEVk7NgCB
	rS+6r2atnM4ozhsVSo2WDAaZo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3lFUwN1Boy+x7Ig--.55574S2;
	Mon, 16 Jun 2025 23:24:32 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: Remove redundant TTL variable initialization
Date: Mon, 16 Jun 2025 23:24:14 +0800
Message-Id: <20250616152414.966218-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3lFUwN1Boy+x7Ig--.55574S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryUCw47tFyxuF4kuw1fCrg_yoW5WFy7pF
	W5uFn0kFWkJFy7tanrXF4UCF12va1kJ3yI9FykG3y2vF1DAF9YqFySkF1FqF1xJrZxur1x
	X3s0yr97GayYyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRzVb-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh5uo2hQMWGpLwAAsH

The local variables `ttl` were initialized to PCI_FIND_CAP_TTL but never
actually used. The loop termination condition is inherently controlled
by the TTL mechanism inside the PCI_FIND_NEXT_CAP_TTL macro, which already
ensures protection against infinite loops.

Remove these redundant operations to simplify the code and eliminate
potential logical ambiguities. This change does not affect functionality,
as the TTL safeguard is properly implemented within the macro.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
- Submissions based on the following patches:
https://patchwork.kernel.org/project/linux-pci/patch/20250607161405.808585-1-18255117159@163.com/

Recently, I checked the code and found that there are still some areas that can be further optimized.
The above series of patches has been around for a long time, so I'm sending this one out for review
as a separate patch.
---
 drivers/pci/quirks.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..50d0f193e4a3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2742,10 +2742,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
  */
 static int msi_ht_cap_enabled(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	int pos;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
+	while (pos) {
 		u8 flags;
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
@@ -2796,10 +2796,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 /* Force enable MSI mapping capability on HT bridges */
 static void ht_enable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	int pos;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
+	while (pos) {
 		u8 flags;
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
@@ -2935,12 +2935,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 
 static int ht_check_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
-	int found = 0;
+	int pos, found = 0;
 
 	/* Check if there is HT MSI cap or enabled on this device */
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
+	while (pos) {
 		u8 flags;
 
 		if (found < 1)
@@ -3060,10 +3059,10 @@ static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
 
 static void ht_disable_msi_mapping(struct pci_dev *dev)
 {
-	int pos, ttl = PCI_FIND_CAP_TTL;
+	int pos;
 
 	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
-	while (pos && ttl--) {
+	while (pos) {
 		u8 flags;
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


