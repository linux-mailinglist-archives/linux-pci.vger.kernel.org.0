Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B512CF612
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgLDVWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 16:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgLDVWU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 16:22:20 -0500
Date:   Fri, 4 Dec 2020 15:21:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607116900;
        bh=+cQ20Aye7Du+rqn66yfaPs/eLsuRfR7chMfSPtXu/PU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=FoAtDBHKHkYM7LzgEQQ5yYzrQJubH4YhnSgvovhr02IWlTOhoCnhLYUT5o1aCAZtf
         TJWHU0ukWHMUoq2WB8pdcouMX8DvzA125TS9OBQ0TZoycYRuaQR+WzlMaC9Fa2hi3y
         ALvLpN+J61vmGc1heMrqi5EXC+MsD3eG50SMNZGn4M6UEiSbRiocLkCfejQYtNCYAM
         2QqgKrz+ewL958TiOeXxkdm3cpDWP8fse2U/2pe37ALZEVRXswGARY+P10VFbQCkwm
         9bvf9GskeDomHuym7aStRsYauHJbZhQSKPz2iXtkg/MYIRwpszoG3rklrDrGQR907e
         QGe+I/E/E8GGA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v1] PCI: Return u8 from pci_find_capability()
Message-ID: <20201204212138.GA1964378@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129164626.12887-1-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 29, 2020 at 10:16:26PM +0530, Puranjay Mohan wrote:
> PCI Capabilities are linked in a list that must appear in the first 256
> bytes of config space. The pointer to capabilities is of 8 bits.
> 
> Change the return type of pci_find_capability() and supporting
> functions from int to u8 to match the specification.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Applied to pci/enumeration for v5.11, thanks!

I added a few more related changes and some whitespace and typo fixes.
Interdiff from your posting below.

> ---
> v1 - change return types of supporting functions of pci_find_capability.
> ---
>  drivers/pci/pci.c   | 8 ++++----
>  include/linux/pci.h | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..5caae09e0d20 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -399,7 +399,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>  	return 1;
>  }
>  
> -static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  				   u8 pos, int cap, int *ttl)
>  {
>  	u8 id;
> @@ -438,7 +438,7 @@ int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_capability);
>  
> -static int __pci_bus_find_cap_start(struct pci_bus *bus,
> +static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
>  				    unsigned int devfn, u8 hdr_type)
>  {
>  	u16 status;
> @@ -477,9 +477,9 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
>   *  %PCI_CAP_ID_PCIX         PCI-X
>   *  %PCI_CAP_ID_EXP          PCI Express
>   */
> -int pci_find_capability(struct pci_dev *dev, int cap)
> +u8 pci_find_capability(struct pci_dev *dev, int cap)
>  {
> -	int pos;
> +	u8 pos;
>  
>  	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
>  	if (pos)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..19a817702ea9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1063,7 +1063,7 @@ void pci_sort_breadthfirst(void);
>  
>  /* Generic PCI functions exported to card drivers */
>  
> -int pci_find_capability(struct pci_dev *dev, int cap);
> +u8 pci_find_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
> @@ -1719,7 +1719,7 @@ static inline int __pci_register_driver(struct pci_driver *drv,
>  static inline int pci_register_driver(struct pci_driver *drv)
>  { return 0; }
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
> -static inline int pci_find_capability(struct pci_dev *dev, int cap)
> +static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
>  { return 0; }
>  static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
>  					   int cap)
> -- 
> 2.27.0


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5caae09e0d20..b3761e98377b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -400,7 +400,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 }
 
 static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
-				   u8 pos, int cap, int *ttl)
+				  u8 pos, int cap, int *ttl)
 {
 	u8 id;
 	u16 ent;
@@ -423,15 +423,15 @@ static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 	return 0;
 }
 
-static int __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
-			       u8 pos, int cap)
+static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
+			      u8 pos, int cap)
 {
 	int ttl = PCI_FIND_CAP_TTL;
 
 	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
 }
 
-int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
+u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
 {
 	return __pci_find_next_cap(dev->bus, dev->devfn,
 				   pos + PCI_CAP_LIST_NEXT, cap);
@@ -502,10 +502,9 @@ EXPORT_SYMBOL(pci_find_capability);
  * device's PCI configuration space or 0 in case the device does not
  * support it.
  */
-int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
+u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
 {
-	int pos;
-	u8 hdr_type;
+	u8 hdr_type, pos;
 
 	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type);
 
@@ -623,7 +622,7 @@ u64 pci_get_dsn(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_get_dsn);
 
-static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
+static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
 {
 	int rc, ttl = PCI_FIND_CAP_TTL;
 	u8 cap, mask;
@@ -650,11 +649,12 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
 
 	return 0;
 }
+
 /**
- * pci_find_next_ht_capability - query a device's Hypertransport capabilities
+ * pci_find_next_ht_capability - query a device's HyperTransport capabilities
  * @dev: PCI device to query
  * @pos: Position from which to continue searching
- * @ht_cap: Hypertransport capability code
+ * @ht_cap: HyperTransport capability code
  *
  * To be used in conjunction with pci_find_ht_capability() to search for
  * all capabilities matching @ht_cap. @pos should always be a value returned
@@ -663,26 +663,26 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
  * NB. To be 100% safe against broken PCI devices, the caller should take
  * steps to avoid an infinite loop.
  */
-int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap)
+u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap)
 {
 	return __pci_find_next_ht_cap(dev, pos + PCI_CAP_LIST_NEXT, ht_cap);
 }
 EXPORT_SYMBOL_GPL(pci_find_next_ht_capability);
 
 /**
- * pci_find_ht_capability - query a device's Hypertransport capabilities
+ * pci_find_ht_capability - query a device's HyperTransport capabilities
  * @dev: PCI device to query
- * @ht_cap: Hypertransport capability code
+ * @ht_cap: HyperTransport capability code
  *
- * Tell if a device supports a given Hypertransport capability.
+ * Tell if a device supports a given HyperTransport capability.
  * Returns an address within the device's PCI configuration space
  * or 0 in case the device does not support the request capability.
  * The address points to the PCI capability, of type PCI_CAP_ID_HT,
- * which has a Hypertransport capability matching @ht_cap.
+ * which has a HyperTransport capability matching @ht_cap.
  */
-int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
+u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 {
-	int pos;
+	u8 pos;
 
 	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
 	if (pos)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 19a817702ea9..7c5749ad37ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1063,12 +1063,13 @@ void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
+u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 u8 pci_find_capability(struct pci_dev *dev, int cap);
-int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
+u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
+u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
+u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
-int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
-int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 u64 pci_get_dsn(struct pci_dev *dev);
@@ -1279,7 +1280,6 @@ void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
-int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
