Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B76AAE72
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfIEW0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 18:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIEW0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 18:26:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5F12070C;
        Thu,  5 Sep 2019 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567722411;
        bh=E+LbLUkOPDuZw8Ahapl/LSZPxW0inipop6mc4+zfRR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nB7d4jdItk6J6oz8Y3EuRM4SeY4p/Vs7+/jFTsBfIFqNpRsyeZ6Tey69rrdYofkwb
         eH7917jOOL2lqRt33JS53CRkWpkQwo7+g8aIHkUsdFV5+eYneZjb7Nq6bqZYsPUVB4
         cNu/drAZe3fbfIqTPF8pIGVFbVV5y3xjhOtEVTys=
Date:   Thu, 5 Sep 2019 17:26:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add PCIE ACS quirk for IPROC PAXB
Message-ID: <20190905222649.GK103977@google.com>
References: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Tue, Aug 20, 2019 at 10:09:45AM +0530, Srinath Mannam wrote:
> From: Abhinav Ratna <abhinav.ratna@broadcom.com>
> 
> IPROC PAXB RC doesn't support ACS capabilities and control registers.
> Add quirk to have separate IOMMU groups for all EPs and functions connected
> to root port, by masking RR/CR/SV/UF bits.
> 
> Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>

I tentatively applied this to pci/misc with Scott's ack for v5.4.

I tweaked the patch itself to follow the style of similar quirks
(interdiff is below, plus a diff of the commit log).  Please make sure
I didn't break it.

I also went out on a limb and reworded the comment to give what I
*think* is the justification for this patch, as opposed to merely a
description of the code.  I'm making a lot of assumptions there, so
please confirm that they're correct, or supply alternate justification
if they're not.

> ---
>  drivers/pci/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc..f9584c0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4466,6 +4466,21 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  	return acs_flags ? 0 : 1;
>  }
>  
> +static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * IPROC PAXB RC doesn't support ACS capabilities and control registers.
> +	 * Add quirk to to have separate IOMMU groups for all EPs and functions
> +	 * connected to root port, by masking RR/CR/SV/UF bits.
> +	 */
> +
> +	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
> +	int ret = acs_flags & ~flags ? 0 : 1;
> +
> +	return ret;
> +}
> +
> +
>  static const struct pci_dev_acs_enabled {
>  	u16 vendor;
>  	u16 device;
> @@ -4559,6 +4574,7 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
>  	{ 0 }
>  };

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 77c0330ac922..2edbce35e8c5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4466,21 +4466,19 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	return acs_flags ? 0 : 1;
 }
 
-static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
-	 * IPROC PAXB RC doesn't support ACS capabilities and control registers.
-	 * Add quirk to to have separate IOMMU groups for all EPs and functions
-	 * connected to root port, by masking RR/CR/SV/UF bits.
+	 * iProc PAXB Root Ports don't advertise an ACS capability, but
+	 * they do not allow peer-to-peer transactions between Root Ports.
+	 * Allow each Root Port to be in a separate IOMMU group by masking
+	 * SV/RR/CR/UF bits.
 	 */
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 
-	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
-	int ret = acs_flags & ~flags ? 0 : 1;
-
-	return ret;
+	return acs_flags ? 0 : 1;
 }
 
-
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
@@ -4574,7 +4572,7 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
 	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
-	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	{ 0 }
 };
 



@@ -1,49 +1,49 @@
-commit b50ae502eff0
+commit 46b2c32df7a4
 Author: Abhinav Ratna <abhinav.ratna@broadcom.com>
 Date:   Tue Aug 20 10:09:45 2019 +0530
 
-    PCI: Add PCIE ACS quirk for IPROC PAXB
+    PCI: Add ACS quirk for iProc PAXB
     
-    IPROC PAXB RC doesn't support ACS capabilities and control registers.
-    Add quirk to have separate IOMMU groups for all EPs and functions connected
-    to root port, by masking RR/CR/SV/UF bits.
+    iProc PAXB Root Ports don't advertise an ACS capability, but they do not
+    allow peer-to-peer transactions between Root Ports.  Add an ACS quirk so
+    each Root Port can be in a separate IOMMU group.
     
+    [bhelgaas: commit log, comment, use common implementation style]
     Link: https://lore.kernel.org/r/1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com
     Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
     Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Acked-by: Scott Branden <scott.branden@broadcom.com>
 
