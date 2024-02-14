Return-Path: <linux-pci+bounces-3425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42A85426C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 06:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F89B21FBE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB41C147;
	Wed, 14 Feb 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDFlpHty"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F210A01
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888864; cv=none; b=Y5Th1PqRJ4whv93ZAZ36OXQGCFXQpfnRgH3zD/I2cranIhBB0gHn0kezB4j3H9IQq0Ch2Gq1YcYY2zPxpGqd7OeHJDhSmPuCaYuis3tNDsECWve2PFup+aUp1d778EgYal/nu3b4If2aK5JpED+DdtGrY7gWwCVpTHUe5m4UBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888864; c=relaxed/simple;
	bh=QvNhXevnsYLYqhSc4x/m93Wh/CJ+53ykTBU4bA5HKvU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RJcLArGFli1MYQhxgoUdyr6HoicYpNPdEr87dVn5YUPaObYT97LpqO+kQqRXxLhLgHW9KuyoU62UMjdrstM2GFSyTD+FPnm0tNfP+UYoLTj2XeNAcZLsi7pGfOQpOFCbyU4Ei39NVAF3H829plfnz6lAZvsJcHAvg6a9h6zFACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDFlpHty; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so6238271276.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 21:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707888862; x=1708493662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCnacIYl08RIQ41EwyyjjTmpEuM5p3yKr0bpiQ9jAhI=;
        b=eDFlpHtyKk4R7WeTlpLwjZG5WUK8gN1xVUgJYU/qvT4RvE/NvUJIF1g2WjEN82Ez4n
         oEzovnnEB1jUYJufy7q04gD0Oi4NUHyBPwc18W8klYRR+IqG8BRXYdOWczFI1XHDrY1v
         640UWSKqQBmozH+YSlHkH8rHD2ODyY3IDynUvG9u7+KOidRl+dZwZlojfny4LHgL0+tg
         Nu8CliKaX5aT5RZWDww6ncMqhTrDRBXg0zURFPbtPuzzOhBptvukonZIv0LtzCT78n1N
         lXjHZiBsCXLroXXttXcKBvQdnF9qZYxkHPvlTzXtCZML3VsYLgPS4KO3rroXa/nndpOZ
         V7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707888862; x=1708493662;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCnacIYl08RIQ41EwyyjjTmpEuM5p3yKr0bpiQ9jAhI=;
        b=hKsvYt+78ylkKrjbAm2HeiNkOYwlpTrh8S3+mYpD8862bMcShtg//sRyX0MA7c5v7N
         YO7qIjSW7JOOSpxR4dxx6oInu8IEh52lhjJCyEo03hxJ0Lkm0r684CkUpfDNtDAoKnTC
         Yln7F619UtikvmE2lsVSUTDfVs8bFKwDMNKrwiIXvrBOx9KqmtDoRIH9lANlyXmJ0J0q
         87TlQY5yG1L4uAELPjphvos0FkDjOvGeCvRAMU7iLSRDh93CT8p9+AeY3sZ60EHhiyWF
         CQ65zxjvABjoArtLwB6DjuX7uIiAKO4yh4uMgMDuI/tTXGsHpco958XmcGBvPoDhb07H
         c0pg==
X-Gm-Message-State: AOJu0YzUO2S25OBHVwbpKpCZdFXW0sN0bHbNmLLaSO5RzGXkxpGm3pD5
	nCP3I0aD7l6eZuNiBXdloXrfLQcZJVRwkJou2hXVv88KQ/FODVoatM5yFKSelAOAe3wPqXk3PUz
	cqJ4FcKUNPY8Ah2J+BHrh7w==
X-Google-Smtp-Source: AGHT+IHKjTg8F+ZH0TpEUPoA4+mjiRXp1iD2feDOGD03QyvlQwc9qSV0yEQVFtfS1QELGP2GsVSUAcNcyNbxVQaUrw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:b28d:0:b0:dcc:8927:7496 with SMTP
 id k13-20020a25b28d000000b00dcc89277496mr45936ybj.5.1707888862309; Tue, 13
 Feb 2024 21:34:22 -0800 (PST)
Date: Wed, 14 Feb 2024 11:04:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214053415.3360897-1-ajayagarwal@google.com>
Subject: [PATCH v4] PCI: dwc: Strengthen the MSI address allocation logic
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

There can be platforms that do not use/have 32-bit DMA addresses
but want to enumerate endpoints which support only 32-bit MSI
address. The current implementation of 32-bit IOVA allocation can
fail for such platforms, eventually leading to the probe failure.

If the vendor driver has already setup the MSI address using
some mechanism, use the same. This method can be used by the
platforms described above to support EPs they wish to. Such
drivers should set the DW_PCIE_CAP_MSI_DATA_SET flag.

Else, try to allocate a 32-bit IOVA. Additionally, if this
allocation also fails, attempt a 64-bit allocation for probe to
be successful. If the 64-bit MSI address is allocated, then the
EPs supporting 32-bit MSI address will not work.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v3:
 - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
 - Refactor the comments and print statements

Changelog since v2:
 - If the vendor driver has setup the msi_data, use the same

Changelog since v1:
 - Use reserved memory, if it exists, to setup the MSI data
 - Fallback to 64-bit IOVA allocation if 32-bit allocation fails

 .../pci/controller/dwc/pcie-designware-host.c  | 18 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h   |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..06ee2e5deebc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -373,11 +373,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * peripheral PCIe devices may lack 64-bit message support. In
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
+	 * Permit the platforms to override the MSI target address if they
+	 * have a free PCIe-bus memory specifically reserved for that. Such
+	 * platforms should set the 'DW_PCIE_CAP_MSI_DATA_SET' cap flag.
 	 *
 	 * Note until there is a better alternative found the reservation is
 	 * done by allocating from the artificially limited DMA-coherent
 	 * memory.
 	 */
+	if (dw_pcie_cap_is(pci, MSI_DATA_SET))
+		return 0;
+
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
@@ -385,9 +391,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
 	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to configure MSI address\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..feb19c5edd4a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -54,6 +54,7 @@
 #define DW_PCIE_CAP_EDMA_UNROLL		1
 #define DW_PCIE_CAP_IATU_UNROLL		2
 #define DW_PCIE_CAP_CDM_CHECK		3
+#define DW_PCIE_CAP_MSI_DATA_SET	4
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
-- 
2.43.0.687.g38aa6559b0-goog


