Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE3B33A7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 05:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfIPDDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 23:03:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:1061 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfIPDDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Sep 2019 23:03:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 20:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,510,1559545200"; 
   d="scan'208";a="201512321"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2019 20:03:44 -0700
Received: from [10.226.39.42] (ekotax-mobl.gar.corp.intel.com [10.226.39.42])
        by linux.intel.com (Postfix) with ESMTP id EE50A580258;
        Sun, 15 Sep 2019 20:03:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <20190906112044.GF9720@e119886-lin.cambridge.arm.com>
 <959a5f9b-2646-96e3-6a0f-0af1051ae1cb@linux.intel.com>
 <20190909083117.GH9720@e119886-lin.cambridge.arm.com>
 <22857835-1f98-b251-c94b-16b4b0a6dba2@linux.intel.com>
 <20190911103058.GP9720@e119886-lin.cambridge.arm.com>
 <aefd143c-66d2-b303-d992-a55f75a91b2e@linux.intel.com>
 <20190912082517.GA9720@e119886-lin.cambridge.arm.com>
 <cd73e351-5633-bfa8-a4dc-77357d917a0b@linux.intel.com>
 <DM6PR12MB4010AEA876F20E25FFFE06BDDAB00@DM6PR12MB4010.namprd12.prod.outlook.com>
 <b7a1b955-4c3e-6ffe-ec6a-04afe33e70cd@linux.intel.com>
 <20190913101203.GE2680@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <52ef93fd-d705-4163-d194-a1b749b2e7df@linux.intel.com>
Date:   Mon, 16 Sep 2019 11:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190913101203.GE2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/13/2019 6:12 PM, andriy.shevchenko@intel.com wrote:
> On Fri, Sep 13, 2019 at 05:20:26PM +0800, Dilip Kota wrote:
>> On 9/12/2019 6:49 PM, Gustavo Pimentel wrote:
>>> On Thu, Sep 12, 2019 at 10:23:31, Dilip Kota
>>> <eswara.kota@linux.intel.com> wrote:
>>> Hi, I just return from parental leave, therefore I still trying to get
>>> the pace in mailing list discussion.
>>>
>>> However your suggestion looks good, I agree that can go into DesignWare
>>> driver to be available to all.
>> Thanks Gustavo for the confirmation, i will add it in the next patch version
>>> Just a small request, please do in general:
>>> s/designware/DesignWare
>> Sorry, i didnt understand this.
> It means the reviewer asks you to name DesignWare in this form,
> i.o.w. designware -> DesignWare.
>
> `man 1 sed` gives you more about it :-)
Thanks Andy for clarifying it.
Could you please also comment let me know your opinion on the driver 
naming. Below is the mail snippet.

======
 >>> Add support to PCIe RC controller on Intel Universal
 >>> Gateway SoC. PCIe controller is based of Synopsys
 >>> Designware pci core.
 >>> +config PCIE_INTEL_AXI
 > [Andy]: I think that name here is too generic. Classical x86 seems 
not using this.

[Dilip Kota]:
This PCIe driver is for the Intel Gateway SoCs. So how about naming it is as
"pcie-intel-gw"; pcie-intel-gw.c and Kconfig as PCIE_INTEL_GW.

Andrew Murray is ok with this naming, please let me know your view.
=======

Regards,
Dilip

>
