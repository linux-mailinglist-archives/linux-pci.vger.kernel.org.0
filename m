Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F58103ABB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 14:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfKTNIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 08:08:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:50971 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbfKTNIb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 08:08:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 05:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="406803216"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2019 05:08:27 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iXPic-0005Ei-Tk; Wed, 20 Nov 2019 15:08:26 +0200
Date:   Wed, 20 Nov 2019 15:08:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v8 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191120130826.GM32742@smile.fi.intel.com>
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
 <71262d29ca564060331e7e2c1ceb41158109cb92.1574158309.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71262d29ca564060331e7e2c1ceb41158109cb92.1574158309.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:43:01PM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
> 
> Intel PCIe driver requires Upconfigure support, Fast Training
> Sequence and link speed configurations. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.

> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
> +			     u32 ofs, u32 mask, u32 val)

It seems your editor is misconfigured. First line should be

static void pcie_app_wr_mask(struct intel_pcie_port *lpp, u32 ofs,

in case you would like to split it logically.

> +static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
> +				u32 ofs, u32 mask, u32 val)

Ditto.

> +	pcie_app_wr(lpp,  PCIE_APP_IRNCR, PCIE_APP_IRN_INT);

Extra white space.

-- 
With Best Regards,
Andy Shevchenko


