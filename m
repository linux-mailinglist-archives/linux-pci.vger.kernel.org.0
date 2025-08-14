Return-Path: <linux-pci+bounces-34055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87518B26AE1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FE49E5A61
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6621B9CF;
	Thu, 14 Aug 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USqy1CFu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64EE555
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184931; cv=none; b=Wb076E4O93QG2yflrsDDk103j0DhWfixiz/nHkpnT1UA7QjS3QxsnKFWjI568AMJVTy67C53PbmQqnq9n5YpOfJsyOMqEBlh5Dq5kDaao92KbCq3iN8D5nYUYrBJ9RpTuARQ6LL1iJ+D8uLvSqoIFV4j+8UdlL44+eS9Ie/BY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184931; c=relaxed/simple;
	bh=A3t5rHcs+Ov9JvE0Ix3i5THugA1R7fu24/On7d788js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsHHFzH+VtVnYMN13gZs6hUYB0razNhimCC77lxIIkrm8IS3ZpsmGbyWwRBSa7qL/jFwKdHSs54Sd7z+zfq5NbSj3bjutbig5NJEUiOgzcWjhBGWHtTMOH/eqS6mDfK2Sr2wcip7rfi07IYL0fx+g3f1KEv3KMVniDCrQ4SROOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USqy1CFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C3C4CEED;
	Thu, 14 Aug 2025 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184931;
	bh=A3t5rHcs+Ov9JvE0Ix3i5THugA1R7fu24/On7d788js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USqy1CFu9b9+aMtyNdIxMMrFDeR7xLNuIcKsbqOgFAhJgn8vzqV+SU8qGM2TDdMyz
	 y1O68UnKZMvgo8D7D1eGpElvM3j5HY03jWCpfQ61vmwAzTegGQNfbWAXE3UOY1J8U2
	 Ro4XoKzj1c/WhiwMZKzuuULBIeyF9tBFLZ/vtNQ+OoVQB44ldFsDs39ctgBBS8fXmD
	 3f806TZK7dVMXnDreNDR2RFSVHXRtiijBFhv6xtRqWmJZWdUN7q0vhCzgyL7MAmrR3
	 7aO6E+4b1OP/mZlypgJ8VIURPOHOCNPljzgjiXuqUJkNL4BCKjrLIoZ6vDLlkKJD0N
	 mlRavZD7ZlUAw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 08/13] PCI: designware-plat: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:27 +0200
Message-ID: <20250814152119.1562063-23-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=cassel@kernel.org; h=from:subject; bh=A3t5rHcs+Ov9JvE0Ix3i5THugA1R7fu24/On7d788js=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vuekPk9KX37Hkbh/rkuV35u57PX+te4c7ZlQn3X0 tBgn4r1HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiINjsjw06Nxkf7K2a+SE2Z 0nzxt+QSRrkH868ofP35dc214LnLP9cz/M+/3Gusu/HV2fbIlZkJC/Nmds8OsDnwwIdPY0aBrvE lY24A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 771b9d9be077..12f41886c65d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -61,7 +61,6 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features dw_plat_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
 };
-- 
2.50.1


