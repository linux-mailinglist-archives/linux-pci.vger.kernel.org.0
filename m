Return-Path: <linux-pci+bounces-28155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DCABE666
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7304C1F68
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526C263899;
	Tue, 20 May 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHlhu+Vg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69D262FFE;
	Tue, 20 May 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777863; cv=none; b=S4himtCTxcJYa3r0EU4RtQe/4Mf1UfeutJI9r0Aiob2gnE7ISBZ7go/JrtfCQrHQ/oQvK+2GCkoDcnvBnif0rhrA+4nBlHC1yJ3FQJP8NgPBqMpwUiBlVV3vBny7cITq68xxHrHIbNKLQPnlzNDuU75iTRCDIZnwMPFz7an6qwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777863; c=relaxed/simple;
	bh=OGnFxgoS/xlR9z606L+9Uk5m6brKQ9yyXV4/GIlhEb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP0QyBcAwn6fII3+qDpouXxpE2anIFRzUL/Fzb8P/T0JK25EAvh2VjQvEHKHBgGdS/v4ru/aBrMqFp5PN4IOjiI6Fxe28daSrthKw78I2xOCNXm7d5jZhZ+JHSWUG97VpvOEwkVVg5JWXqNQe19LuGCsWcKRcs6bb3rcsFP3GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHlhu+Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE0C4CEE9;
	Tue, 20 May 2025 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777863;
	bh=OGnFxgoS/xlR9z606L+9Uk5m6brKQ9yyXV4/GIlhEb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHlhu+VgdkhWru+M3UdnCA/T9xfGiWkxDCjqnYjJXhlvcD7JJuJSxp4HF7A8AkSnE
	 qZFiVluCOlh+SaGTRDTOxBRW2Ym1TENz/a7TVTcSX77hbkhLXWw748yxqS33S7FrFM
	 SBLTvV1AkDmjUHF/OM5D4WbrzfF2Bx4tWIme/RPguCxWpcNHGM+Gs2EhYQbEDmsrjw
	 ahRn4I1O8zUIQuT3J7/Z9aQQLFjtqP1R5H0IgPZ8b/LJ1oZtwuUiJQd+U6I62nO5hQ
	 L40H37s48Hbn7tpsp0wE/p+FNUhTDEgx8BIsm8p8qRxgjjw5UpCaKlxhbnaJK1u3js
	 ivKy4fe5z5FGg==
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
Subject: [PATCH v7 08/17] PCI/AER: Initialize aer_err_info before using it
Date: Tue, 20 May 2025 16:50:25 -0500
Message-ID: <20250520215047.1350603-9-helgaas@kernel.org>
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

Previously the struct aer_err_info "e_info" was allocated on the stack
without being initialized, so it contained junk except for the fields we
explicitly set later.

Initialize "e_info" at declaration with a designated initializer list,
which initializes the other members to zero.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 520c21ed4ba9..e6693f910a23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1289,9 +1289,9 @@ static void aer_isr_one_error_type(struct pci_dev *root,
  * @e_src: pointer to an error source
  */
 static void aer_isr_one_error(struct pci_dev *root,
-		struct aer_err_source *e_src)
+			      struct aer_err_source *e_src)
 {
-	struct aer_err_info e_info;
+	u32 status = e_src->status;
 
 	pci_rootport_aer_stats_incr(root, e_src);
 
@@ -1299,30 +1299,25 @@ static void aer_isr_one_error(struct pci_dev *root,
 	 * There is a possibility that both correctable error and
 	 * uncorrectable error being logged. Report correctable error first.
 	 */
-	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
-		e_info.id = ERR_COR_ID(e_src->id);
-		e_info.severity = AER_CORRECTABLE;
-
-		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
-			e_info.multi_error_valid = 1;
-		else
-			e_info.multi_error_valid = 0;
+	if (status & PCI_ERR_ROOT_COR_RCV) {
+		int multi = status & PCI_ERR_ROOT_MULTI_COR_RCV;
+		struct aer_err_info e_info = {
+			.id = ERR_COR_ID(e_src->id),
+			.severity = AER_CORRECTABLE,
+			.multi_error_valid = multi ? 1 : 0,
+		};
 
 		aer_isr_one_error_type(root, &e_info);
 	}
 
-	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
-		e_info.id = ERR_UNCOR_ID(e_src->id);
-
-		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			e_info.severity = AER_FATAL;
-		else
-			e_info.severity = AER_NONFATAL;
-
-		if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
-			e_info.multi_error_valid = 1;
-		else
-			e_info.multi_error_valid = 0;
+	if (status & PCI_ERR_ROOT_UNCOR_RCV) {
+		int fatal = status & PCI_ERR_ROOT_FATAL_RCV;
+		int multi = status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
+		struct aer_err_info e_info = {
+			.id = ERR_UNCOR_ID(e_src->id),
+			.severity = fatal ? AER_FATAL : AER_NONFATAL,
+			.multi_error_valid = multi ? 1 : 0,
+		};
 
 		aer_isr_one_error_type(root, &e_info);
 	}
-- 
2.43.0


