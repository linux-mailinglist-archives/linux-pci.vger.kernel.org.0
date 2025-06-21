Return-Path: <linux-pci+bounces-30287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A1AE285E
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA017BF3A
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D818C00B;
	Sat, 21 Jun 2025 09:40:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2D1459F6
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498836; cv=none; b=D8gBFBP3tHol572Tpjdt5yLeBYFthQ/dOkVHNyYxE/aJGVTxziPYqoMvwic6Nk0Al5oe0NY/nv2eA1AJAhuFtR5R11EmK0E3yh/7+3un7DvAa+ux6J9SzcdhzO/8upzN5R6SfhkUAUlWaiCFAJmcOAp9FeI4wUMMuC6yuECVNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498836; c=relaxed/simple;
	bh=3oFUE314c8LR6x/bGKxcKKEAmi6Y9IpyoJK4xPzcOso=;
	h=Message-Id:From:Date:Subject:To:Cc; b=NTzhfR+1B5AOEx+WIMzR9gQIYHuA8OS258xjKMveMFDw8L5N0AXstbeREsNKjbXmMRs4F84hnlnLpF8GM51F1vMSxs0mgjalLnqnPgBoJGYbgadCDlbZHyS6n640CJHL37NXUghZsS9++qhAjcH1l4Pd5wCN70QrLKmrC0UF9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3C6B02C06849;
	Sat, 21 Jun 2025 11:40:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1DA393A19EA; Sat, 21 Jun 2025 11:40:24 +0200 (CEST)
Message-Id: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 21 Jun 2025 11:40:23 +0200
Subject: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is present
To: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 by
default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
to any PCI device.

On modern CPUs exposing an AMD IOMMU, this results in a message with
KERN_CRIT severity:

  pci 0000:00:00.2: Resources present before probing

The driver used to bind only to devices exposing the AGP Capability, but
that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
unknown AGP devices the right way").

Reinstate checking for AGP presence to avoid the message.

Fixes: 3be5fa236649 (Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices")
Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
Closes: https://lore.kernel.org/r/wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Compile tested only, I do not have a machine with AMD IOMMU at my disposal.

Reporter is not cc'ed because ispras.ru is an OFAC sanctioned entity,
which prohibits me from two-way engagement with the reporter:
https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890
https://www.linuxfoundation.org/blog/navigating-global-regulations-and-open-source-us-ofac-sanctions

 drivers/char/agp/amd64-agp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index bf49096..4bf508b 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -735,6 +735,18 @@ static int agp_amd64_resume(struct device *dev)
 	.driver.pm  = &agp_amd64_pm_ops,
 };
 
+static bool __init agp_dev_present(void)
+{
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev)
+		if (pci_find_capability(pdev, PCI_CAP_ID_AGP)) {
+			pci_dev_put(pdev);
+			return true;
+		}
+
+	return false;
+}
 
 /* Not static due to IOMMU code calling it early. */
 int __init agp_amd64_init(void)
@@ -761,7 +773,7 @@ int __init agp_amd64_init(void)
 		}
 
 		/* First check that we have at least one AMD64 NB */
-		if (!amd_nb_num()) {
+		if (!amd_nb_num() || !agp_dev_present()) {
 			pci_unregister_driver(&agp_amd64_pci_driver);
 			return -ENODEV;
 		}
-- 
2.47.2


