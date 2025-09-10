Return-Path: <linux-pci+bounces-35842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70130B51F1F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD5D1715C5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A674334376;
	Wed, 10 Sep 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrgNK5nm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22A327A12;
	Wed, 10 Sep 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525965; cv=none; b=Jqo7Q5Rk7OvJxOzwCMXVEjdplmVe1Q6BjWWkxjN2L0yQaWF1LYk46U9F59Mvb9jsPqxcO7mwhJRD9qomJZmA5D0EsMr7bxqueK60wqEZmki+0dHFaGKoJSdId8lUUur8l0hLs6I3I4D2B36fun0MmLT9hpKfl+DK0t5jzMwKWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525965; c=relaxed/simple;
	bh=suPO+5JTYQEo4LDSfjlfIJExBwCp9N3UqosjVAZBfYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClGTjEOTJO/r/U2junVAI9N5WOCq2vkpzTO5rtQfB+OYFAo7HG3uxuUuC2gk/dUv+ieD/ti/MezDdfv3ooorTXXQkEhJuxsjmvmf+h5ITjbTi9tFgwQkzpKTkp2n8xiuvj5kH1L4xMeyKRvX6IkL5OBAfKn1EwF3wJEEklsNhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrgNK5nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1AE7C4CEF0;
	Wed, 10 Sep 2025 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525964;
	bh=suPO+5JTYQEo4LDSfjlfIJExBwCp9N3UqosjVAZBfYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VrgNK5nmBoFy0slg+DVdiE48DDr4ahNcvj8aM9UsPrN44mm1DL43iwx+H5wrAWlHx
	 fuNYbEw+BtBCYNhQnIhD9nxTk7OJRHSaISnF6X+wjdPCI69WBQUwFS8HC6NCLeUoeQ
	 HRaESDCsL6CbJSvQtuW2oxdzSiAwH7zC2AHQkkojVNV4iG6R0ytEvFzWQ0xdiDH1h6
	 PcRmJ1KfIhKr6YpBPuDilLxZB5DIHcBwYsCoKl4JN5KBaFVPRa/tCfrHhukYH5aH8y
	 AApmCQnPZnbHR0bnaXr2aaTBFgmcmvsyJwIqp/2J7g5NLuKY1zyjUKypb06A+xR3Rr
	 vS4x8mw3IbwFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A27CA0FED;
	Wed, 10 Sep 2025 17:39:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 10 Sep 2025 23:09:20 +0530
Subject: [PATCH 1/2] PCI: Extend pci_idt_bus_quirk() for IDT switch with
 Device ID 0x8090
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-pci-acs-v1-1-fe9adb65ad7d@oss.qualcomm.com>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
 Xingang Wang <wangxingang5@huawei.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=F1zn/e3u//vrD8NT+S3b2bYGHBAjod1HSL73CfBCa2s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBowbfKIsbljvZZO1jxubZqxR2RwT326BD2EYLym
 lsxnouTuiOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMG3ygAKCRBVnxHm/pHO
 9eecCACj8Q14c0+RcOMVe1jcVdN2q2XiQtNonvov3RaMAGPhIpkrpyRFgd+MK1H1V4sT1X8oHQd
 9X+4cBk2lJ+K9CtrvCGiJXyfVqtGLkle3/YdUJ33o1lfFKnfeTk9O70ZjI3TQ1zYSwxR/PigPo2
 mHD98aR+g84BbtKLKH0LjkI8MsuWenkanDA5rDO1zWC1Dlk04C7bsSjLIaGCt3s7l7EqS2dc3Um
 b6eE/h921Jt6pHaDR6/D/5FGmJC15PrR5RfD/8LBEF6v7cdBN0k062rXJRzUUkQ/O45nvePw/MS
 13BFh/hPSF/czp8yt+DAcde8+fAAqn/bqZNnQfZ1ckxPFGdk
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If ACS is enabled, the IDT switch with Device ID 0x8090 found in ARM Juno
R2 development board incorrectly raises an ACS Source Validation error on
Completions for Config Read Requests, even though PCIe r6.0, sec 6.12.1.1,
says that Completions are never affected by ACS Source Validation.

This behavior is documented in non-public erratum 89H32H8G3-YC and there is
already a quirk available to workaround this issue.

Hence, extend the quirk for Device ID 0x8090 to make the switch functional
if ACS is enabled.

Note: The commit mentioned in the Fixes tag causes ACS to be enabled before
the enumeration of the switch downstream port. So it ended up breaking PCIe
on ARM Juno R2 board, which used to work before this commit until someone
forcefully enabled ACS with cmdline.

Cc: stable@vger.kernel.org # 6.15
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Closes: https://lists.linaro.org/archives/list/lkft-triage@lists.linaro.org/message/CBYO7V3C5TGYPKCMWEMNFFMRYALCUDTK
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca76ab014ad669ae84a53032c7c6b6b..2320818bc8e58c61d9ada312dfbd8c0fbfbadc0c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2500,7 +2500,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	 * ACS Source Validation errors on completions for config reads.
 	 */
 	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
-	    bridge->device == 0x80b5)
+	    (bridge->device == 0x80b5 || bridge->device == 0x8090))
 		return pci_idt_bus_quirk(bus, devfn, l, timeout);
 #endif
 

-- 
2.45.2



