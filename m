Return-Path: <linux-pci+bounces-28156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA6ABE66D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A081895D6F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D035263F5D;
	Tue, 20 May 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwW4ys92"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56070263F54;
	Tue, 20 May 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777865; cv=none; b=gkZTLOGrxFS1HvFnjEbCtIgcs8waL8yQqXOv1jHznoqT1bX9kR5JPjr0kSnDbwHueao/TFwh22A4KD+cSXrhkEKyArEc54WagOEHV0nMrFoQ+Y+8HfgTRdg60d3pD8TvP/pzBQXTdVfOzC5A16DcKi9xMJXshJpgFzyHUpqUM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777865; c=relaxed/simple;
	bh=5VjMn9MemK5CuWA+VSMlLX2voDa67B9awgcs/wm3zGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/WiN0KYMU9ePXdN6HD07rJLhZn2PfxkuxmUD5SoVL6C7CWZ+Zmn82qgkoetWyX5HXoKkcUi23fKVu2bxInkp3jhWIwpIpNvmaCTIljWX1gAaBSh+WvykPMntKQ2oct7XG18ILLFy3eTYbibyEfnY2/U/upZD2PksJUMjwoYRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwW4ys92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0002EC4CEE9;
	Tue, 20 May 2025 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777865;
	bh=5VjMn9MemK5CuWA+VSMlLX2voDa67B9awgcs/wm3zGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwW4ys92nvOL57+VhbA9Ug2/N5KtMZdnGxt51qHKcwGXmt0ALtu7Hx9Ca2ECRSBWz
	 31dvnw48UEEoFOuPjGt2ZViCO0P7oDZADTcD5eR9U18DkHsfuPofKYu3oM0Vp5T8Up
	 /FfrhislQUyCjrJXe0vPDRH9+N1QrtK61XFgqUYvH9Qq+LbGyBl/vYUSEPB0zJ8Cn8
	 7WbeB4IzbVv6/JV38S8BJG1ScKgu5maJZqrTsRBuMTfTM8Wg3uspSvCDQk56kYeiYi
	 +JTrEtiN3XodVOlyH4Mu6y5ct+MaMO68/Q2cKmekjDMScz+qit2mv5PpQJ8Wx75jMk
	 DSSJXTxQfTj3Q==
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
Subject: [PATCH v7 09/17] PCI/AER: Simplify pci_print_aer()
Date: Tue, 20 May 2025 16:50:26 -0500
Message-ID: <20250520215047.1350603-10-helgaas@kernel.org>
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

Simplify pci_print_aer() by initializing the struct aer_err_info "info"
with a designated initializer list (it was previously initialized with
memset()) and using pci_name().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e6693f910a23..d845079429f0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
-	struct aer_err_info info;
+	struct aer_err_info info = {
+		.severity = aer_severity,
+		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
+	};
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
@@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
-	memset(&info, 0, sizeof(info));
-	info.severity = aer_severity;
 	info.status = status;
 	info.mask = mask;
-	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+
+	layer = AER_GET_LAYER_ERROR(aer_severity, status);
+	agent = AER_GET_AGENT(aer_severity, status);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
-- 
2.43.0


