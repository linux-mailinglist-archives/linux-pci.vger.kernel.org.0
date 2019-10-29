Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C19FE83AA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 09:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfJ2I7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 04:59:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:20767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730295AbfJ2I7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 04:59:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 01:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="202780671"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 01:59:23 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 14985580372;
        Tue, 29 Oct 2019 01:59:17 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
 <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
 <20191025090926.GX47056@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <6f8b2e72-caa3-30b8-4c76-8ad7bb321ce2@linux.intel.com>
Date:   Tue, 29 Oct 2019 16:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025090926.GX47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/25/2019 5:09 PM, Andrew Murray wrote:
> On Tue, Oct 22, 2019 at 05:04:21PM +0800, Dilip Kota wrote:
>> Hi Andrew Murray,
>>
>> On 10/21/2019 9:03 PM, Andrew Murray wrote:
>>> On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
>>>> +
>>>> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
>>>> +{
>>>> +	u32 val;
>>>> +
>>>> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>>> +	val &= ~PORT_LOGIC_N_FTS;
>>>> +	val |= n_fts;
>>>> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>>>> +}
>>> I notice that pcie-artpec6.c (artpec6_pcie_set_nfts) also writes the FTS
>>> and defines a bunch of macros to support this. It doesn't make sense to
>>> duplicate this there. Therefore I think we need to update pcie-artpec6.c
>>> to use this new function.
>> I think we can do in a separate patch after these changes get merged and
>> keep this patch series for intel PCIe driver and required changes in PCIe
>> DesignWare framework.
> The pcie-artpec6.c is a DWC driver as well. So I think we can do all this
> together. This helps reduce the technical debt that will otherwise build up
> in duplicated code.
I agree with you to remove duplicated code, but at this point not sure 
what all drivers has defined FTS configuration.
Reviewing all other DWC drivers and removing them can be done in one 
single separate patch.

Regards,
Dilip
