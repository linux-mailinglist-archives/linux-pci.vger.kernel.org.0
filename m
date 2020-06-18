Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792231FF848
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFRP4b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 11:56:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:12775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgFRP4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 11:56:31 -0400
IronPort-SDR: tIqx63aBsskYBCZSLeGvdVA2Zxt6B9DVA+UUr89YAF8BtO1AdPvABm5UIx55vtPdLmDyu/bH41
 +2WUiW5KveqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="142577081"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="142577081"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:56:30 -0700
IronPort-SDR: KOUJtvzaBQlF2Y9Xljs6cWf1KQno+1AyTVBY+RVGwEz7MfWI73+oswkK1IQUyOuxD8vbEIW4i7
 B4Zsk11lsqnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="477291931"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 08:56:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jlwtv-00EIOa-Vr; Thu, 18 Jun 2020 18:56:27 +0300
Date:   Thu, 18 Jun 2020 18:56:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, bp@alien8.de, james.morse@arm.com,
        lenb@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        zhangliguang@linux.alibaba.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v10 2/2] PCI: hip: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200618155627.GX2428291@smile.fi.intel.com>
References: <20200618154051.639-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618154051.639-3-shiju.jose@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 04:40:51PM +0100, Shiju Jose wrote:
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

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Hmm... Did I give a tag?

...

> +static guid_t hisi_pcie_sec_guid =
> +		GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D,
> +			0xA8, 0x67, 0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);

Drop one TAB in each line and add two spaces before 0xA8 on the last.


...

> +	idx = HISI_PCIE_LOCAL_VALID_ERR_MISC;

> +	for_each_set_bit_from(idx, (const unsigned long *)&edata->val_bits,

Can't you make val_bits unsigned long? Because this casting is incorrect.
Otherwise, make a local copy into unsigned long variable.

> +			      HISI_PCIE_LOCAL_VALID_ERR_MISC + HISI_PCIE_ERR_MISC_REGS)
> +		dev_info(dev, "ERR_MISC_%d = 0x%x\n", idx - HISI_PCIE_LOCAL_VALID_ERR_MISC,
> +			 edata->err_misc[idx]);

...

> +static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
> +{
> +	struct hisi_pcie_error_private *priv;
> +	int ret;
> +

> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

(1)

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->nb.notifier_call = hisi_pcie_notify_error;
> +	priv->dev = &pdev->dev;
> +	ret = ghes_register_event_notifier(&priv->nb);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to register hisi_pcie_notify_error function\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_error_handler_remove(struct platform_device *pdev)
> +{
> +	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
> +
> +	ghes_unregister_event_notifier(&priv->nb);

> +	kfree(priv);

See (1), as I told you, this is double free.
Have you tested this?

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


