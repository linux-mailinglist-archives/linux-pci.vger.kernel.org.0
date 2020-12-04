Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89672CF614
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 22:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLDVXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 16:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgLDVXl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 16:23:41 -0500
Date:   Fri, 4 Dec 2020 15:22:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607116980;
        bh=PkJF33JVKECCkm4TMuSlA11u1wCMOpDxOVCEtMn7/uY=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=XCFYmQEhPZ/IoUVxofjWjhQQNe+Jiu3eTDE/rzyEsUDncdabkVFgHsyA0WBNLg9Mi
         FHcCwOVEQB+772rLWBl3ih3eQ48Ci6KyBsfxB+ZRCYqVRNXubCuDpzE+pmg7dwOlW9
         oCkvaPR6ubc5TvscuRD64786yuvJOH/+jrLtc9JpDGrsagu+iMi/bBHZ4VdcTERa25
         9YFLStzgAFnuhw9JiMSFlvNFR2Ga259sKD3ODNZqzcGHNRRAeyvf9M0f8j5nIIFn6O
         WVbFPU0jyqdwrNwl6bhqjIJJqV7/yYLSfCPMEVqHd3zRQT5bpjr9/7P0w1mgiK2orB
         5dYZtzTjignvg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v1] PCI: Return u8 from pci_find_capability()
Message-ID: <20201204212258.GA1965139@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129164626.12887-1-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I also propose this follow-on patch to do the same for the extended
capabilities:

commit ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and similar")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 4 15:14:07 2020 -0600

    PCI: Return u16 from pci_find_ext_capability() and similar
    
    PCI Express Extended Capabilities are in config space between offsets 256
    and 4K.  These offsets all fit in 16 bits.
    
    Change the return type of pci_find_ext_capability() and supporting
    functions from int to u16 to match the specification.  Many callers use
    "int", which is fine, but there's no need to store more than a u16.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b3761e98377b..85cb873266d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -527,11 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
  * not support it.  Some capabilities can occur several times, e.g., the
  * vendor-specific capability, and this provides a way to find them all.
  */
-int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
+u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
 {
 	u32 header;
 	int ttl;
-	int pos = PCI_CFG_SPACE_SIZE;
+	u16 pos = PCI_CFG_SPACE_SIZE;
 
 	/* minimum 8 bytes per capability */
 	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
  *  %PCI_EXT_CAP_ID_DSN		Device Serial Number
  *  %PCI_EXT_CAP_ID_PWR		Power Budgeting
  */
-int pci_find_ext_capability(struct pci_dev *dev, int cap)
+u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 {
 	return pci_find_next_ext_capability(dev, 0, cap);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e615f8abdd79..441e5753da0c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -381,7 +381,7 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
-	int		l1ss;		/* L1SS Capability pointer */
+	u16		l1ss;		/* L1SS Capability pointer */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
@@ -1069,8 +1069,8 @@ u8 pci_find_capability(struct pci_dev *dev, int cap);
 u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
-int pci_find_ext_capability(struct pci_dev *dev, int cap);
-int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
+u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
+u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 u64 pci_get_dsn(struct pci_dev *dev);
