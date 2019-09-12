Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84351B0917
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 09:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfILHBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 03:01:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:40181 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfILHBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 03:01:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 00:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="385948639"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2019 00:01:21 -0700
Received: from [10.226.39.17] (ekotax-mobl.gar.corp.intel.com [10.226.39.17])
        by linux.intel.com (Postfix) with ESMTP id C69F9580887;
        Thu, 12 Sep 2019 00:01:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
 <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
 <20190905114016.GF2680@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <fb258f36-1733-da02-bae3-6062163ba607@linux.intel.com>
Date:   Thu, 12 Sep 2019 15:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190905114016.GF2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On 9/5/2019 7:40 PM, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 11:45:18AM +0100, Andrew Murray wrote:
>> On Wed, Sep 04, 2019 at 06:10:31PM +0800, Dilip Kota wrote:
>>> Add support to PCIe RC controller on Intel Universal
>>> Gateway SoC. PCIe controller is based of Synopsys
>>> Designware pci core.
>>> +config PCIE_INTEL_AXI
> I think that name here is too generic. Classical x86 seems not using this.

This PCIe driver is for the Intel Gateway SoCs. So how about naming it is as
"pcie-intel-gw"; pcie-intel-gw.c and Kconfig as PCIE_INTEL_GW.

Andrew Murray is ok with this naming, please let me know your view.

>
>>> +        bool "Intel AHB/AXI PCIe host controller support"
>>> +        depends on PCI_MSI
>>> +        depends on PCI
>>> +        depends on OF
>>> +        select PCIE_DW_HOST
>>> +        help
>>> +          Say 'Y' here to enable support for Intel AHB/AXI PCIe Host
>>> +	  controller driver.
>>> +	  The Intel PCIe controller is based on the Synopsys Designware
>>> +	  pcie core and therefore uses the Designware core functions to
>>> +	  implement the driver.
