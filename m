Return-Path: <linux-pci+bounces-28292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B19AC17BA
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777CF3B9345
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF822D29DF;
	Thu, 22 May 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtQWdQBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785E2D29DB;
	Thu, 22 May 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956233; cv=none; b=RsQ45v7xU3wbKpiHiTFuEg4lPChVSL0ulU15/9EtLw0EWLtzZzo/hvZotRtU8Yyv0FVomef4epWSpELlB1y8cfU3Z9xNtkJkN6YnIH93igqH7rIOgq6I2v9xsxUbMahuJy3J9ydG8IWY+6GHMeEUChE55CZQcbX8ejN60xP7HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956233; c=relaxed/simple;
	bh=FL/KoyjRpNb5esqwvcFXhgF2SuWjbLGgWfm72WGlhjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HujI1yKiQ8/tagqDDYAcTzUYCTRalItXmpoD7/4aqr3ZGLmBU4EuxrcOAalApVMQeVYZ2KxVCsUPxg+qaYP8ZJo0Xe2fwzAOIP6GS7PgSTqryf1uFUyrhII5WrYMW65RjeNahOSgKuOUTRW32ZbyQSLoazTbBJZvs7O+l4PVdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtQWdQBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE8FC4CEEB;
	Thu, 22 May 2025 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956233;
	bh=FL/KoyjRpNb5esqwvcFXhgF2SuWjbLGgWfm72WGlhjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtQWdQBREu/7Qb1dXiqg7Cha3wrc7XLxQ/sWKAxs0q2yKPJKwOMqPoqRkeGWeshfH
	 zbuCA7wVgg0NZdpw6RaTSM5aRYXU0AC7SLwwIW+CYNVbsamO7CHlhcnFutU+vqj9IU
	 Q4JrWGpUbDuiVxiBCBMZ60D9lbJ1UWARQE8Nm9GyvVnSlldHFNonRTjYUzs8rp0vPq
	 X2jVFs8YOZd185Z+lfYM5Wd5tWHIB+jpsWUebXTlfPCuGRnl9x+mxZjjULhE/pNcb8
	 +uO8iIlxWyOFnuIIDb2uw394lVt84jA4xFeS4KMRAB4S/VvKkOB+ScirlU5tNI/1Uz
	 rtlk4rkED5DuQ==
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
Subject: [PATCH v8 05/20] PCI/AER: Extract bus/dev/fn in aer_print_port_info() with PCI_BUS_NUM(), etc
Date: Thu, 22 May 2025 18:21:11 -0500
Message-ID: <20250522232339.1525671-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250520215047.1350603-6-helgaas@kernel.org
---
 drivers/pci/pcie/aer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index fe6d323306a0..18005615d376 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -736,14 +736,14 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
 				bool found)
 {
-	u8 bus = info->id >> 8;
-	u8 devfn = info->id & 0xff;
+	u16 source = info->id;
 
 	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn), found ? "" : " (no details found");
+		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
+		 PCI_SLOT(source), PCI_FUNC(source),
+		 found ? "" : " (no details found");
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.43.0


