Return-Path: <linux-pci+bounces-596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D15807B96
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 23:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF79E1F21A0A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D551C38;
	Wed,  6 Dec 2023 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr6tDrjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896B2DF67
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 22:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D98C433C8;
	Wed,  6 Dec 2023 22:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902562;
	bh=C/z2J4QPXebp5y/KZX3b+//X9l7x7jrXFPy9z32q6dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sr6tDrjVNEGXBrIduHYruCE+26Os5jBYxrBIYnZAcYvDRtFDMObUCXJJLzMUiCw7N
	 xChDFP4dnQByUNM2/9AyMINDb1Vomrc7EhfOeGD2bM4wqUrc+hhuYlwKunZE96eJkg
	 G+g2dZ/la0NQ90ncYg3505KmeqhbhUQ/Si+BzUaflfPMPdSZO/raSwCsdtAVQ30vrl
	 zRlsZmwaCZva4DJ9GndQ1gNnQm55/qaRW60CcvTD+BxbS/ZpmExY0DNPWSKO7cNl/6
	 86Z5jo9swQunULx2h2jUinrNNC1rLTrUPa3Vci2CxSo+rTAtgIUph4s/Y9dyPHI3SN
	 wCN/Tr12lMFjQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI/AER: Decode Requester ID when no error info found
Date: Wed,  6 Dec 2023 16:42:30 -0600
Message-Id: <20231206224231.732765-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

When a device with AER detects an error, it logs error information in its
own AER Error Status registers.  It may send an Error Message to the Root
Port (RCEC in the case of an RCiEP), which logs the fact that an Error
Message was received (Root Error Status) and the Requester ID of the
message source (Error Source Identification).

aer_print_port_info() prints the Requester ID from the Root Port Error
Source in the usual Linux "bb:dd.f" format, but when find_source_device()
finds no error details in the hierarchy below the Root Port, it printed the
raw Requester ID without decoding it.

Decode the Requester ID in the usual Linux format so it matches other
messages.

Sample message changes:

  - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
  - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
  + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
  + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 20db80018b5d..2ff6bac9979f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -740,7 +740,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -929,7 +929,12 @@ static bool find_source_device(struct pci_dev *parent,
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
+		u8 bus = e_info->id >> 8;
+		u8 devfn = e_info->id & 0xff;
+
+		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
+			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 		return false;
 	}
 	return true;
-- 
2.34.1


