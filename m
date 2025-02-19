Return-Path: <linux-pci+bounces-21811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D3A3C5E6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A2E17A618
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBD1DE2CD;
	Wed, 19 Feb 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5KWwB+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250178F58
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985312; cv=none; b=W9yMztLYWjr5gvywLWRc/def9g4/HDbeIBR0lc+JjmKbSSOzsNXbdomLeR8+G35f+aYEqTdi61S9vcoJsp+WZflT7aZEmFha4dN83ynwfOQSi4fNyWXflOIlCzXYK9NHAwQqoWuWZTkWqw3G0GR+wkIz/c+YDL17XoRVFFpmRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985312; c=relaxed/simple;
	bh=mRoWMMoPAjJCc94ss0qgV2jbbINkYbrJhhtx2fnTvg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQY4Wgs1m5lb0ZPBiggHSqVGpGmbJJyoLKjFQqJn9Nzra/ScVNEc7yg9LqFC9MwH68HKzV9B1LtlLSy8IWcKD0seqWp2GHQEqakTMHEiOtf9uoUdtXM/HqIoDdesjLfvkv7p48kLWb6aSe5nwyad3x77Ex9dq/hmEL/KlK4sCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5KWwB+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35B0C4CED1;
	Wed, 19 Feb 2025 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985311;
	bh=mRoWMMoPAjJCc94ss0qgV2jbbINkYbrJhhtx2fnTvg8=;
	h=From:To:Cc:Subject:Date:From;
	b=h5KWwB+bSK3lgaZkLDE+y+YiUT1r+ii/waCnxUNzWRXoTjMLvOb86UPV+PDopKR0u
	 1smovYG3kIqAYGGJvvyMq4ene+BcF8r9AdsxksjwbnIMUL0t6Avh2E8nVGtDebPhHC
	 W6QF2+Msbt8xRgiMOudDPeu0ZLz5kwSn7x1f3hWRKfZWxtCPRkxK7HtygG3nefW7Bn
	 KSMpddxyDfkR7k+SdYl7xeBhcW18YoNdEksiR6Vv6THwDfzIPtlFK5kMKbshCS4rrt
	 cAxF7nKHwpIfbJfBfR2iplRPan4YAOMqV6J9gjmkbblm+2ng5YTb2tHwXxLO4p944w
	 jTzr8QgPbiujA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Improve reference in pci_epc_bar_size_to_rebar_cap() comment
Date: Wed, 19 Feb 2025 18:14:55 +0100
Message-ID: <20250219171454.2903059-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=cassel@kernel.org; h=from:subject; bh=mRoWMMoPAjJCc94ss0qgV2jbbINkYbrJhhtx2fnTvg8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNK3CfbNDvO9oZbjP68hwdaj8nrzsnspcm/OSXd7uu3Qd P50Jn11RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbSbMLIcKcq8KOLX5XWPp3d djzltVZP7n9j9dT+ciHRt2Jbnt3Cv4wMX45MV2yZyblTUueC+Pl/N6ccOqg5jydK47xh9XmD28v OsgEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Improve the reference pci_epc_bar_size_to_rebar_cap() comment to include
a specific PCIe spec version, and a specific section in that PCIe spec.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Feel free to squash with original commit.

 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5d6aef956b13..88cb426d3aec 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -649,7 +649,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_bar);
 int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
 {
 	/*
-	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
+	 * As per PCIe r6.0, sec 7.8.6.2, min size for a resizable BAR is 1 MB,
 	 * thus disallow a requested BAR size smaller than 1 MB.
 	 * Disallow a requested BAR size larger than 128 TB.
 	 */
-- 
2.48.1


