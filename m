Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE71F95D3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFOMA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 08:00:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:4527 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFOMA4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jun 2020 08:00:56 -0400
IronPort-SDR: Qr38OtK4M26sUY6SS3kscwbcowEk4NMAX1hJX/8kzhqfAu+0Zz90K7m1HZ8wfpIVfMMOiEUW1g
 03tvGy43c/VQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 05:00:55 -0700
IronPort-SDR: eYLi5bV9Ncyhml927KcHlApGl4DBc1d8oJYSKsCOkxPAifk3KYl+Q5Hr88CbKJJVuPaiusdqo4
 B4fkKqG2vZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="316887372"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2020 05:00:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jknnJ-00DZ39-KG; Mon, 15 Jun 2020 15:00:53 +0300
Date:   Mon, 15 Jun 2020 15:00:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        wangkefeng.wang@huawei.com, jroedel@suse.de,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com
Subject: Re: [PATCH v9 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200615120053.GZ2428291@smile.fi.intel.com>
References: <20200615101552.802-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615101552.802-3-shiju.jose@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 11:15:52AM +0100, Shiju Jose wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The HiSilicon HIP PCIe controller is capable of handling errors
> on root port and perform port reset separately at each root port.
> 
> Add error handling driver for HIP PCIe controller to log
> and report recoverable errors. Perform root port reset and restore
> link status after the recovery.
> 
> Following are some of the PCIe controller's recoverable errors
> 1. completion transmission timeout error.
> 2. CRS retry counter over the threshold error.
> 3. ECC 2 bit errors
> 4. AXI bresponse/rresponse errors etc.
> 
> The driver placed in the drivers/pci/controller/ because the
> HIP PCIe controller does not use DWC ip.

...

> +#include <linux/acpi.h>
> +#include <acpi/ghes.h>

bits.h ?

> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/kfifo.h>
> +#include <linux/spinlock.h>

...

> +static guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
> +			0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);

Can we have it in more common pattern, i.e.

static guid_t hisi_pcie_sec_type =
	GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
		  0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
?

...

> +#define HISI_PCIE_CORE_PORT_ID(v)        (((v) % 8) << 1)

% -> & ?

...

> +struct hisi_pcie_error_private {
> +	struct notifier_block	nb;
> +	struct platform_device	*pdev;

Do you really need platform device? Isn't struct device * enough?

> +};

...

> +static char *hisi_pcie_sub_module_name(u8 id)
> +{
> +	switch (id) {
> +	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
> +	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
> +	}

match_string() ?

> +	return "unknown";

> +}
> +
> +static char *hisi_pcie_error_severity(u8 err_sev)
> +{
> +	switch (err_sev) {
> +	case HISI_ERR_SEV_RECOVERABLE: return "recoverable";
> +	case HISI_ERR_SEV_FATAL: return "fatal";
> +	case HISI_ERR_SEV_CORRECTED: return "corrected";
> +	case HISI_ERR_SEV_NONE: return "none";
> +	}

Ditto?

> +	return "unknown";
> +}

...

> +	pdev = pci_get_domain_bus_and_slot(domain, busnr, devfn);
> +	if (!pdev) {

> +		dev_info(device, "Fail to get root port %04x:%02x:%02x.%d device\n",
> +			 domain, busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));

pci_info() ?

> +		return -ENODEV;
> +	}

...

> +	/*
> +	 * The initialization time of subordinate devices after
> +	 * hot reset is no more than 1s, which is required by
> +	 * the PCI spec v5.0 sec 6.6.1. The time will shorten
> +	 * if Readiness Notifications mechanisms are used. But
> +	 * wait 1s here to adapt any conditions.
> +	 */
> +	ssleep(1UL);

It's a huge time out... Can we reduce it somehow?

...

> +	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
> +		if (edata->val_bits &
> +				BIT_ULL(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))

for_each_set_bit() ?

> +			dev_info(dev,
> +				 "ERR_MISC_%d = 0x%x\n", i, edata->err_misc[i]);
> +	}

> +
> +	/* Recovery for the PCIe controller errors */
> +	if (edata->err_severity == HISI_ERR_SEV_RECOVERABLE) {

Perhaps negative conditional?

> +		/* try reset PCI port for the error recovery */
> +		rc = hisi_pcie_port_do_recovery(pdev, edata->socket_id,
> +			HISI_PCIE_PORT_ID(edata->core_id, edata->port_id));
> +		if (rc) {
> +			dev_info(dev, "fail to do hisi pcie port reset\n");

> +			return;

redundant.

> +		}
> +	}

...

> +	const struct hisi_pcie_error_data *error_data =
> +				acpi_hest_get_payload(gdata);

One line is better to read.

> +	struct platform_device *pdev = priv->pdev;

> +	hisi_pcie_handle_error(pdev, error_data);

And how exactly _platform_ device pointer is being used?

...


> +		dev_err(&pdev->dev, "%s : ghes_register_event_notifier fail\n",
> +			__func__);

Make error message more descriptive that __func__ will not be needed.

...

> +	kfree(priv);

Double free?

...

> +static const struct acpi_device_id hisi_pcie_acpi_match[] = {
> +	{ "HISI0361", 0 },

', 0' part is not necessary to have.

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko


