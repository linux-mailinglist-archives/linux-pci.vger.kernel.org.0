Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A34D1BC6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIWbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbfJIWbA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:31:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D564A205F4;
        Wed,  9 Oct 2019 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570660258;
        bh=2+F9LpTg0Tr8IeH6cckJbC5ONwnNDN7TzKuRLtIizec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yhDcR1iAPVSzGTpAMaaSTHTmDv5j71HBhzmLqZau27FQH0hG6pyoZhq9mq63YFBsW
         gnQCkDdmRUR/54ZQDW00ZbxtLVGCIw1h6A6cYIYyT0hKOUh3r+BhRSKVk8cW3ZIcKA
         Ps/VIJSm53dhpFRMCZwoErodL2qxFZSzvkfMw2nw=
Date:   Wed, 9 Oct 2019 17:30:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v1 1/1] PCI/ATS: Optimize pci_prg_resp_pasid_required()
 function
Message-ID: <20191009223056.GA139157@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f594928de550e151d3537fdd64099de34ffa30da.1570490792.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 07, 2019 at 04:32:42PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, pci_prg_resp_pasid_required() function reads the
> PASID Required bit status from register every time we call
> the function. Since PASID Required bit is a read-only value,
> instead of reading it from register every time, read it once and
> cache it in struct pci_dev.
> 
> Also, since we are caching PASID Required bit in pci_pri_init()
> function, move the caching of PRI Capability check result to the same
> function. This will group all PRI related caching at one place.
> 
> Since "pasid_required" structure member is protected by CONFIG_PRI,
> its users should also be protected by same #ifdef. So correct the #ifdef
> dependency of pci_prg_resp_pasid_required() function.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/ats.c   | 50 ++++++++++++++++++++++++---------------------
>  include/linux/pci.h |  1 +
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index cb4f62da7b8a..2b5df5ea208f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -16,6 +16,24 @@
>  
>  #include "pci.h"
>  
> +static void pci_pri_init(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_PCI_PRI
> +	int pos;
> +	u16 status;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return;
> +
> +	pdev->pri_cap = pos;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +	if (status & PCI_PRI_STATUS_PASID)
> +		pdev->pasid_required = 1;
> +#endif
> +}

I like this patch a lot but:

1) You started out with a pci_pri_init(), and I screwed up when I
suggested that you remove it.  I think it makes a lot of sense to have
it and call it directly from pci_init_capabilities() just like we do
for other capabilities.

2) The PCI_PRI/PCI_PASID #ifdef thing is still a mess.  Despite the
fact that its name contains "pasid", pci_prg_resp_pasid_required()
only looks at the PRI capability, so I think it should be under #ifdef
CONFIG_PCI_PRI along with the other PRI stuff.

3) I'm not sure why pci_prg_resp_pasid_required() was under
CONFIG_PCI_PASID, but it might be related to the fact that it's called
from code in intel-iommu.c where CONFIG_PCI_PASID is always defined,
but CONFIG_PCI_PRI may not be.  I think this is an intel-iommu Kconfig
defect.  I'll post patches to change the Kconfig and to move
pci_prg_resp_pasid_required() under CONFIG_PCI_PRI.

So I fiddled with all this and updated my pci/virtualization branch
with the result.

The interdiff from the v8 series is below.  This includes the
intel-iommu Kconfig and pci_prg_resp_pasid_required() changes (which I
haven't posted yet), and the branch includes some unrelated follow-on
patches (which I also haven't posted yet).  Let me know what you
think.

Bjorn

>  void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> @@ -28,6 +46,8 @@ void pci_ats_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->ats_cap = pos;
> +
> +	pci_pri_init(dev);
>  }
>  
>  /**
> @@ -185,12 +205,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>  	if (WARN_ON(pdev->pri_enabled))
>  		return -EBUSY;
>  
> -	if (!pri) {
> -		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -		if (!pri)
> -			return -EINVAL;
> -		pdev->pri_cap = pri;
> -	}
> +	if (!pri)
> +		return -EINVAL;
>  
>  	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
>  	if (!(status & PCI_PRI_STATUS_STOPPED))
> @@ -425,6 +441,7 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> +#ifdef CONFIG_PCI_PRI
>  /**
>   * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
>   *				 status.
> @@ -432,31 +449,18 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
>   *
>   * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
>   *
> - * Even though the PRG response PASID status is read from PRI Status
> - * Register, since this API will mainly be used by PASID users, this
> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> - * CONFIG_PCI_PRI.
> + * Since this API has dependency on both PRI and PASID, protect it
> + * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
>   */
>  int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  {
> -	u16 status;
> -	int pri;
> -
>  	if (pdev->is_virtfn)
>  		pdev = pci_physfn(pdev);
>  
> -	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pri)
> -		return 0;
> -
> -	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
> -
> -	if (status & PCI_PRI_STATUS_PASID)
> -		return 1;
> -
> -	return 0;
> +	return pdev->pasid_required;
>  }
>  EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> +#endif /* CONFIG_PCI_PRI */
>  
>  #define PASID_NUMBER_SHIFT	8
>  #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6542100bd2dd..f1131fee7fcd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -456,6 +456,7 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_PRI
>  	u16		pri_cap;	/* PRI Capability offset */
>  	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
> +	unsigned int	pasid_required:1; /* PRG Response PASID Required bit status */
>  #endif
>  #ifdef CONFIG_PCI_PASID
>  	u16		pasid_cap;	/* PASID Capability offset */
> -- 
> 2.21.0
> 

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..b183c9f916b0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -207,6 +207,7 @@ config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
+	select PCI_PRI
 	select MMU_NOTIFIER
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index cb4f62da7b8a..76ae518d55f4 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -159,6 +159,20 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
 
 #ifdef CONFIG_PCI_PRI
+void pci_pri_init(struct pci_dev *pdev)
+{
+	u16 status;
+
+	pdev->pri_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+
+	if (!pdev->pri_cap)
+		return;
+
+	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
+	if (status & PCI_PRI_STATUS_PASID)
+		pdev->pasid_required = 1;
+}
+
 /**
  * pci_enable_pri - Enable PRI capability
  * @ pdev: PCI device structure
@@ -185,12 +199,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	if (!pri) {
-		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-		if (!pri)
-			return -EINVAL;
-		pdev->pri_cap = pri;
-	}
+	if (!pri)
+		return -EINVAL;
 
 	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
 	if (!(status & PCI_PRI_STATUS_STOPPED))
@@ -290,9 +300,30 @@ int pci_reset_pri(struct pci_dev *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_pri);
+
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	return pdev->pasid_required;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
+void pci_pasid_init(struct pci_dev *pdev)
+{
+	pdev->pasid_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
+}
+
 /**
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
@@ -323,12 +354,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pdev->eetlp_prefix_path)
 		return -EINVAL;
 
-	if (!pasid) {
-		pasid = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-		if (!pasid)
-			return -EINVAL;
-		pdev->pasid_cap = pasid;
-	}
+	if (!pasid)
+		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
@@ -425,39 +452,6 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
-/**
- * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
- *				 status.
- * @pdev: PCI device structure
- *
- * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
- *
- * Even though the PRG response PASID status is read from PRI Status
- * Register, since this API will mainly be used by PASID users, this
- * function is defined within #ifdef CONFIG_PCI_PASID instead of
- * CONFIG_PCI_PRI.
- */
-int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pri;
-
-	if (pdev->is_virtfn)
-		pdev = pci_physfn(pdev);
-
-	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pri)
-		return 0;
-
-	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
-
-	if (status & PCI_PRI_STATUS_PASID)
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
-
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947ee3324..ae84d28ba03a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -456,6 +456,18 @@ static inline void pci_ats_init(struct pci_dev *d) { }
 static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #endif /* CONFIG_PCI_ATS */
 
+#ifdef CONFIG_PCI_PRI
+void pci_pri_init(struct pci_dev *dev);
+#else
+static inline void pci_pri_init(struct pci_dev *dev) { }
+#endif
+
+#ifdef CONFIG_PCI_PASID
+void pci_pasid_init(struct pci_dev *dev);
+#else
+static inline void pci_pasid_init(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCI_IOV
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d5271a7a849..df2b77866f3b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2324,6 +2324,12 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Address Translation Services */
 	pci_ats_init(dev);
 
+	/* Page Request Interface */
+	pci_pri_init(dev);
+
+	/* Process Address Space ID */
+	pci_pasid_init(dev);
+
 	/* Enable ACS P2P upstream forwarding */
 	pci_enable_acs(dev);
 
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 1ebb88e7c184..a7a2b3d94fcc 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI_PRI */
 
@@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
 	return -ENODEV;
 }
 
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
-int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 {
 	return -EINVAL;
 }
-
-static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	return 0;
-}
 #endif /* CONFIG_PCI_PASID */
 
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6542100bd2dd..64d35e730fab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -456,6 +456,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
+	unsigned int	pasid_required:1; /* PRG Response PASID Required */
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_cap;	/* PASID Capability offset */
