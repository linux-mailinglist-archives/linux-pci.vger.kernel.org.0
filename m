Return-Path: <linux-pci+bounces-5505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577D8947A9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEA5B222A8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52B58210;
	Mon,  1 Apr 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/1EoP0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E85820C;
	Mon,  1 Apr 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013818; cv=none; b=IN8my6F4sBkiCUw6SbGDs8zwfcVfrhuWamhLuQXaa3mWV7nwMIq56+PrF2xg1Gmfidcc7BP5pZwnDlevzz9KSUm7cprQ6SOQecRKWXzj6tFtVbeY8BUXLvJLC5QbqiBPAreayCzFV+sqmVTs9QiKsSWiC7UvrtBDG4T/WWlh2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013818; c=relaxed/simple;
	bh=o97B29Ox7BgnEbRTW2Nrfwi00DuZ+IE+HV46X4xy7oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5vrTANZb2fbrapRHdMrjTCTYReCD9Y8ht7eRWWC/BFxWtKvDhEBmTRSLXRGCRh+j7OB9MUt/5Zm49jdCMV2N01YRxBJkDvrzvTRg5ieh4ymz2XiwAzJ9R9cASr52/TQLjcS++/CCrnq/PgE3s+9G7kEyr39gPuH7ORZ8yixPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/1EoP0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E762AC433F1;
	Mon,  1 Apr 2024 23:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712013818;
	bh=o97B29Ox7BgnEbRTW2Nrfwi00DuZ+IE+HV46X4xy7oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/1EoP0IXYDHv85d/3dbGXT5dxUHUgg31fFnH7AkV7ApWny81guVKC1FcX5S3nbdO
	 NvJlYZVNbjz9lr5pMuNjldbu1V2uvSdiKaOYESTCKGxyQ64gSoW4gE+ha0VKkUbXmL
	 0iU6f0QvziuudXdfraHRCKlb2pwSRmp8u4l8wXFxBfgX4dPurNWdl5gLzuhPkiMvcV
	 qX00aIzz8pnLVnpt/wbIjHfoZZu5uRmNbK8HDwEJCeSXGkHo7NeR6F4su0I3PdOxk+
	 ZFSmsYfkZF+dXC+jSUXni4UEepNoZ5Grz1JLxCXleBOMn+UDzJ7OXsvooSHIFdyagA
	 1nKybCSHkSEpg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
Date: Mon,  1 Apr 2024 18:23:26 -0500
Message-Id: <20240401232326.1794707-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401232326.1794707-1-helgaas@kernel.org>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 0194425af0c87acaad457989a2c6d90dba58e776.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.  If this is
re-added later, the relevant part of 41efa431244f ("PCI/MSI: Provide stubs
for IMS functions") should be squashed into it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c | 59 -------------------------------------
 include/linux/pci.h         |  5 ----
 2 files changed, 64 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index cfd84a899c82..03d2dd25790d 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -355,65 +355,6 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	return (supported & feature_mask) == feature_mask;
 }
 
-/**
- * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
- * @pdev:	The PCI device to operate on
- * @template:	The MSI info template which describes the domain
- * @hwsize:	The size of the hardware entry table or 0 if the domain
- *		is purely software managed
- * @data:	Optional pointer to domain specific data to be stored
- *		in msi_domain_info::data
- *
- * Return: True on success, false otherwise
- *
- * An IMS domain is expected to have the following constraints:
- *	- The index space is managed by the core code
- *
- *	- There is no requirement for consecutive index ranges
- *
- *	- The interrupt chip must provide the following callbacks:
- *		- irq_mask()
- *		- irq_unmask()
- *		- irq_write_msi_msg()
- *
- *	- The interrupt chip must provide the following optional callbacks
- *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
- *	  cannot operate directly on hardware, e.g. in the case that the
- *	  interrupt message store is in queue memory:
- *		- irq_bus_lock()
- *		- irq_bus_unlock()
- *
- *	  These callbacks are invoked from preemptible task context and are
- *	  allowed to sleep. In this case the mandatory callbacks above just
- *	  store the information. The irq_bus_unlock() callback is supposed
- *	  to make the change effective before returning.
- *
- *	- Interrupt affinity setting is handled by the underlying parent
- *	  interrupt domain and communicated to the IMS domain via
- *	  irq_write_msi_msg().
- *
- * The domain is automatically destroyed when the PCI device is removed.
- */
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data)
-{
-	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
-
-	if (!domain || !irq_domain_is_msi_parent(domain))
-		return false;
-
-	if (template->info.bus_token != DOMAIN_BUS_PCI_DEVICE_IMS ||
-	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
-	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
-	    !template->chip.irq_mask || !template->chip.irq_unmask ||
-	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
-		return false;
-
-	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, template,
-					    hwsize, data, NULL);
-}
-EXPORT_SYMBOL_GPL(pci_create_ims_domain);
-
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3deb3e42d990..98fb20bcd054 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2664,11 +2664,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
-struct msi_domain_template;
-
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data);
-
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
-- 
2.34.1


