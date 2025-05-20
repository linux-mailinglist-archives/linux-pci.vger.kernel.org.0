Return-Path: <linux-pci+bounces-28152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3505ABE660
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E357A08BD
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E563261574;
	Tue, 20 May 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw5/D6ub"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D925D1E7;
	Tue, 20 May 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777859; cv=none; b=mOcreYSjw4HBXNZ1EWiGVU7BfnSw0w2DPt5vrDtb+QUbvjN0lGLwWLgnGfpqBVZaEYnskDbcLO4/niqKcqgrw41ZU6p/0b8X51TITTTei/Nn2HCMbdkWvgpu6JxuQjE7jA6LmdYN20663ghtvK0LE61YJhBZyjhSFSjARuaKAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777859; c=relaxed/simple;
	bh=DfCE1z+DZHtbk6T5lqYp3+U9vJDn8yI4U9HPklSWhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNk+rCv11nqMTVTZjKMAkcs2R1BwIKhhe8zL0/M6NRV02ed7+Es2NM4cU7YYjnm5QAxpsfYplgqbVBn3zmN53CHwMpp5Ffek2HHFCBQVwluQahTd9e1Gj/xS6sO7T4OEsZ2fHyuNF6A7ADaRm6VdTP90Ey1bd/sPS+0nJHhuFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw5/D6ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE572C4CEF2;
	Tue, 20 May 2025 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777858;
	bh=DfCE1z+DZHtbk6T5lqYp3+U9vJDn8yI4U9HPklSWhmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw5/D6ubNIrqLaHAs3MzfRNJY/HxA+EwVKOI8pbDQesm4RQ8k6c17u4gvZ4rYCpQv
	 vIRLpB9gMZFdKQ2+WaB6MR/xqcM3TQBHhFWurdmhHInLLr3g1R7C1SV6A7PsfZSc/h
	 TzufTNioQ06Nc09IzkKNYsLVeyvYsFpXl+KYeU494IMes4Uzd3xvfitPmDIrWDUjvx
	 hbieTgPM16HHrMwpnB7rVVfn7rIFfJ2r7SxsH6Rl/G4j/qzKyvS0Nxm/91DaMv1OQ+
	 apALITivu1K9218E+y67GsDszYZz/IRijjjPHO3hP4qEijAWcWHvrc9jHTcgN4fHpi
	 XMrV3DVjx58SQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v7 05/17] PCI/AER: Extract bus/dev/fn in aer_print_port_info() with PCI_BUS_NUM(), etc
Date: Tue, 20 May 2025 16:50:22 -0500
Message-ID: <20250520215047.1350603-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Use PCI_BUS_NUM(), PCI_SLOT(), PCI_FUNC() to extract the bus number,
device, and function number directly from the Error Source ID.  There's no
need to shift and mask it explicitly.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 488a6408c7a8..65f9277c822c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -736,14 +736,13 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
 				const char *details)
 {
-	u8 bus = info->id >> 8;
-	u8 devfn = info->id & 0xff;
+	u16 source = info->id;
 
 	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn), details);
+		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
+		 PCI_SLOT(source), PCI_FUNC(source), details);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.43.0


