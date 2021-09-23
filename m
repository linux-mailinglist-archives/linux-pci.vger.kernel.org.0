Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0313416792
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhIWVjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 17:39:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:32667 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243363AbhIWVi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 17:38:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="287616970"
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="287616970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 14:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="514273504"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2021 14:37:25 -0700
Received: from [10.212.150.227] (kliang2-MOBL.ccr.corp.intel.com [10.212.150.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BED9D580AD6;
        Thu, 23 Sep 2021 14:37:23 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] PCI: Add pci_find_dvsec_capability to find
 designated VSEC
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     "David E . Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-7-ben.widawsky@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8dbea1cb-acf8-d77e-aafd-537331cf0588@linux.intel.com>
Date:   Thu, 23 Sep 2021 17:37:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923172647.72738-7-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/2021 1:26 PM, Ben Widawsky wrote:
> Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
> Extended Capability with the specified DVSEC ID.
> 
> The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
> more vendor specific capabilities that aren't tied to the vendor ID of
> the PCI component.
> 
> DVSEC is critical for both the Compute Express Link (CXL) driver as well
> as the driver for OpenCAPI coherent accelerator (OCXL).
> 
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Applied the interface for the perf uncore driver as below. The interface 
works properly.

Tested-by: Kan Liang <kan.liang@linux.intel.com>


 From ebb69ba386dca91fb372522b13af9feb84adcbc0 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Thu, 23 Sep 2021 13:59:24 -0700
Subject: [PATCH] perf/x86/intel/uncore: Use pci core's DVSEC functionality

Apply standard interface pci_find_dvsec_capability for perf uncore
driver and remove unused macros.

Reduce maintenance burden of DVSEC query implementation.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/events/intel/uncore_discovery.c | 41 
+++++++++++++++-----------------
  arch/x86/events/intel/uncore_discovery.h |  6 -----
  2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c 
b/arch/x86/events/intel/uncore_discovery.c
index 3049c64..f8ea092 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -21,7 +21,7 @@ static bool has_generic_discovery_table(void)
  		return false;

  	/* A discovery table device has the unique capability ID. */
-	dvsec = pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
+	dvsec = pci_find_next_ext_capability(dev, 0, PCI_EXT_CAP_ID_DVSEC);
  	pci_dev_put(dev);
  	if (dvsec)
  		return true;
@@ -260,7 +260,7 @@ static int parse_discovery_table(struct pci_dev 
*dev, int die,

  bool intel_uncore_has_discovery_tables(void)
  {
-	u32 device, val, entry_id, bar_offset;
+	u32 device, val, bar_offset;
  	int die, dvsec = 0, ret = true;
  	struct pci_dev *dev = NULL;
  	bool parsed = false;
@@ -275,27 +275,24 @@ bool intel_uncore_has_discovery_tables(void)
  	 * the discovery table devices.
  	 */
  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != 
NULL) {
-		while ((dvsec = pci_find_next_ext_capability(dev, dvsec, 
UNCORE_EXT_CAP_ID_DISCOVERY))) {
-			pci_read_config_dword(dev, dvsec + UNCORE_DISCOVERY_DVSEC_OFFSET, &val);
-			entry_id = val & UNCORE_DISCOVERY_DVSEC_ID_MASK;
-			if (entry_id != UNCORE_DISCOVERY_DVSEC_ID_PMON)
-				continue;
-
-			pci_read_config_dword(dev, dvsec + UNCORE_DISCOVERY_DVSEC2_OFFSET, 
&val);
-
-			if (val & ~UNCORE_DISCOVERY_DVSEC2_BIR_MASK) {
-				ret = false;
-				goto err;
-			}
-			bar_offset = UNCORE_DISCOVERY_BIR_BASE +
-				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * 
UNCORE_DISCOVERY_BIR_STEP;
-
-			die = get_device_die_id(dev);
-			if (die < 0)
-				continue;
-
-			parse_discovery_table(dev, die, bar_offset, &parsed);
+		dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_INTEL, 
UNCORE_DISCOVERY_DVSEC_ID_PMON);
+		if (!dvsec)
+			continue;
+
+		pci_read_config_dword(dev, dvsec + UNCORE_DISCOVERY_DVSEC2_OFFSET, &val);
+
+		if (val & ~UNCORE_DISCOVERY_DVSEC2_BIR_MASK) {
+			ret = false;
+			goto err;
  		}
+		bar_offset = UNCORE_DISCOVERY_BIR_BASE +
+			     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * 
UNCORE_DISCOVERY_BIR_STEP;
+
+		die = get_device_die_id(dev);
+		if (die < 0)
+			continue;
+
+		parse_discovery_table(dev, die, bar_offset, &parsed);
  	}

  	/* None of the discovery tables are available */
diff --git a/arch/x86/events/intel/uncore_discovery.h 
b/arch/x86/events/intel/uncore_discovery.h
index 6d735611..84d56e5 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -2,12 +2,6 @@

  /* Generic device ID of a discovery table device */
  #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
-/* Capability ID for a discovery table device */
-#define UNCORE_EXT_CAP_ID_DISCOVERY		0x23
-/* First DVSEC offset */
-#define UNCORE_DISCOVERY_DVSEC_OFFSET		0x8
-/* Mask of the supported discovery entry type */
-#define UNCORE_DISCOVERY_DVSEC_ID_MASK		0xffff
  /* PMON discovery entry type ID */
  #define UNCORE_DISCOVERY_DVSEC_ID_PMON		0x1
  /* Second DVSEC offset */
-- 
2.7.4

Thanks,
Kan

> ---
>   drivers/pci/pci.c   | 32 ++++++++++++++++++++++++++++++++
>   include/linux/pci.h |  1 +
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..94ac86ff28b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -732,6 +732,38 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
>   }
>   EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
>   
> +/**
> + * pci_find_dvsec_capability - Find DVSEC for vendor
> + * @dev: PCI device to query
> + * @vendor: Vendor ID to match for the DVSEC
> + * @dvsec: Designated Vendor-specific capability ID
> + *
> + * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
> + * offset in config space; otherwise return 0.
> + */
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 v, id;
> +
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
> +		if (vendor == v && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> +
>   /**
>    * pci_find_parent_resource - return resource region of parent bus of given
>    *			      region
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..c93ccfa4571b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1130,6 +1130,7 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
>   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
>   struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>   u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
>   
>   u64 pci_get_dsn(struct pci_dev *dev);
>   
> 
