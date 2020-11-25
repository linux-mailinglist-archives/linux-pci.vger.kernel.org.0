Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7262C4082
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgKYMtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 07:49:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:33353 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKYMtY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 07:49:24 -0500
IronPort-SDR: qOW7RAAlj0jLBfbthCbI003M9yXBxyy/zqb3wBB7eH8UjFc4Okc2RZ9wW3Uy+sFJbXW6Cdq4j4
 2sgQdNCUUUuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151962510"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="151962510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 04:49:23 -0800
IronPort-SDR: 6hZ35s4rjiOEGh+W1c99saRoDD+kLVgCfLEmD9bpNrNuoI7dUnIuQv1IsM+YC1UF9dck/BzpDo
 bzX30BQShAUw==
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="536902709"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 04:49:21 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khuFb-009cUu-0u; Wed, 25 Nov 2020 14:50:23 +0200
Date:   Wed, 25 Nov 2020 14:50:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v2 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201125125023.GS4077@smile.fi.intel.com>
References: <20201125101152.5326-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201125101152.5326-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125101152.5326-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 06:11:52PM +0800, Wan Ahmad Zainie wrote:
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
> 
> In root complex mode, only internal reference clock is possible for
> Keem Bay A0. For Keem Bay B0, external reference clock can be used
> and will be the default configuration. Currently, keembay_pcie_of_data
> structure has one member. It will be expanded later to handle this
> difference.
> 
> Endpoint mode link initialization is handled by the boot firmware.

...

> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> +			return -ENODEV;
> +

> +		ret = keembay_pcie_add_pcie_port(pcie, pdev);
> +		if (ret < 0)
> +			return ret;
> +		break;

		return keembay_pcie_add_pcie_port(pcie, pdev);

> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> +			return -ENODEV;
> +
> +		pci->ep.ops = &keembay_pcie_ep_ops;
> +		return dw_pcie_ep_init(&pci->ep);
> +	default:
> +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> +		return -ENODEV;
> +	}

> +	return 0;

...and drop this one.

> +}

-- 
With Best Regards,
Andy Shevchenko


