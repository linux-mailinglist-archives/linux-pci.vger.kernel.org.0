Return-Path: <linux-pci+bounces-43947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D904FCEEE21
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00C93014586
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226F27467F;
	Fri,  2 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvlZ9zgw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB1221F2F;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368105; cv=none; b=uoVyUuOAdUkEBIZiTnZq3n/St5oxdxAKeeWVj0vZtoQowsM+SMrGzaslGNkvTZuZv2MVVb0t+7P9SlRGPYe/Rd64AKzGst3q91Bfgat7SlevTXOHxCufYOgBRenNaEq+IAZYTqs59cOi8M8CXPfiQ2tPnHhdjP3iFAEzVETxgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368105; c=relaxed/simple;
	bh=iI8MHg2IeMDBBtZgnhLwd+NP1SuhIhsAX8XXf+mpz8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzQ4GgR61Hx0Arg7oJ2J0r/slFQcF3fdCm1X6vV+LaYsgD4VLB9FodP6jO/R0A/R15UgPaaOqdwN1xUO0tvlGRQvUk9B50NQRpteqbI8VfoK0g4L6Pv/NqinG95uPnmylydkwfOjB/xOJ00JBSaJdZ2FfjfDU6Y1WhiNLQmJsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvlZ9zgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF2DEC2BC86;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767368104;
	bh=iI8MHg2IeMDBBtZgnhLwd+NP1SuhIhsAX8XXf+mpz8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BvlZ9zgwmrhwd2lsGUl+WMMEQ0G9TiDKe6xwHGWqlb39cR6few6bz8ios4DqQAviA
	 /Kuy0EzQuLk5C1EX9pNA5K6xh7Q440BI497AOV2NFX4hdwBQ1dULifW+hdbf9mNfo8
	 4l3E8ceRaVYNdDI2kKtN/GiWtWgbugYjDK70CU8fDizi4UhJCuVCYeOIic2qbCezik
	 5MEoWmLdn5bdgqt/fvX2O8jedHhA9Aa8G5SuOm/ElLqKjgYOD7BNdAtq8aSJvFSXro
	 4uoZPy0/Kid2DHrctrTFha6/zx1w4A6rRu7URCC8wzuZipXXTYC8jguA/oXW2aJpjG
	 WvNW3hzT67pXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F43FA3753;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 02 Jan 2026 21:04:50 +0530
Subject: [PATCH v3 4/4] PCI: Extend the pci_disable_broken_acs_cap() quirk
 for one more IDT switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_acs-v3-4-72280b94d288@oss.qualcomm.com>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
In-Reply-To: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
 Xingang Wang <wangxingang5@huawei.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=GUu8Qg859a+VLOI/rgxng234DVNkgR6VO624aAuxydk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpV+Wm74o/HwnJ04fTQcCSyQO4vFATpeTyjSpAk
 8/dpTmAVm2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVflpgAKCRBVnxHm/pHO
 9RcLB/sEMvU90lbPoTRSvSEIII2sEIQZJK7DLRdmDPIZDhdb4/iHqsMWnXF4ZM/dwwFv5FJ8/HS
 K4Z710qqzXzZNXSQsXntZhoqwN9AmLhAwGMZbkA6vYX+VMdgNlAasGo5udyvHrn4QOOnbNbzBWn
 m99ZXef7u8oZXpybOnUctuyOQfBd5fRYxtshy5+1JdSDdir6S3pba9EGCm0nPXFPfQxvFjRTmF7
 YqcBYzDEFSwAozGsFlY42iwp01EEQUhrgoLr1qYaxbkfGUJI4UJzjSuR9ZU5YFjzKMHojrpk7oK
 PlermbNsTL+A9i4anveM1PyteOVhVAZ+oZ3QJyXXq0GsRxzI
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The IDT switch with Device ID 0x8090 used in the ARM Juno R2 development
board incorrectly raises an ACS Source Validation error on Completions for
Config Read Requests, even though PCIe r6.0, sec 6.12.1.1, says that
Completions are never affected by ACS Source Validation.

This is already handled by the pci_disable_broken_acs_cap() quirk for one
of the IDT switch 0x80b5. Hence, extend the quirk for this device too.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1571a2ef331e..11ecb9ba1594 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5793,7 +5793,8 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
  */
 void pci_disable_broken_acs_cap(struct pci_dev *pdev)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_IDT && pdev->device == 0x80b5) {
+	if (pdev->vendor == PCI_VENDOR_ID_IDT && (pdev->device == 0x80b5 ||
+	    pdev->device == 0x8090)) {
 		pci_info(pdev, "Disabling broken ACS SV\n");
 		pdev->acs_capabilities &= ~PCI_ACS_SV;
 	}

-- 
2.48.1



