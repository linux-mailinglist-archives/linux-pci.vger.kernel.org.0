Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D694B104E6E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 09:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUIwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 03:52:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:29461 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKUIwW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 03:52:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 00:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="259310679"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2019 00:52:20 -0800
Received: from [10.226.38.254] (unknown [10.226.38.254])
        by linux.intel.com (Postfix) with ESMTP id C5D1D5802C4;
        Thu, 21 Nov 2019 00:52:17 -0800 (PST)
Subject: Re: [PATCH v8 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
 <71262d29ca564060331e7e2c1ceb41158109cb92.1574158309.git.eswara.kota@linux.intel.com>
 <20191120130826.GM32742@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <8545714b-9393-3272-9d58-35a91d1681cf@linux.intel.com>
Date:   Thu, 21 Nov 2019 16:52:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120130826.GM32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/20/2019 9:08 PM, Andy Shevchenko wrote:
> On Wed, Nov 20, 2019 at 03:43:01PM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>
>> Intel PCIe driver requires Upconfigure support, Fast Training
>> Sequence and link speed configurations. So adding the respective
>> helper functions in the PCIe DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
>> +			     u32 ofs, u32 mask, u32 val)
> It seems your editor is misconfigured. First line should be
>
> static void pcie_app_wr_mask(struct intel_pcie_port *lpp, u32 ofs,
>
> in case you would like to split it logically.
>
>> +static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
>> +				u32 ofs, u32 mask, u32 val)
> Ditto.
>
>> +	pcie_app_wr(lpp,  PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
> Extra white space.
My bad, typo error. Will fix them all in the next patch version.

Regards,
Dilip

>
