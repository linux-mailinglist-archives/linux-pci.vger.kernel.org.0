Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7ADE66D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJUIbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 04:31:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:5700 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfJUIbO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 04:31:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 01:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="scan'208";a="196047642"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 01:31:13 -0700
Received: from [10.226.39.21] (unknown [10.226.39.21])
        by linux.intel.com (Postfix) with ESMTP id AF97658029D;
        Mon, 21 Oct 2019 01:31:10 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <CH2PR12MB4007759DFE5F7F105A7D3363DA690@CH2PR12MB4007.namprd12.prod.outlook.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <cf1f6d9c-4145-ef12-4b88-737fe7a5de8c@linux.intel.com>
Date:   Mon, 21 Oct 2019 16:31:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB4007759DFE5F7F105A7D3363DA690@CH2PR12MB4007.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo Pimentel,

On 10/21/2019 4:08 PM, Gustavo Pimentel wrote:
> Hi,
>
>
> On Mon, Oct 21, 2019 at 7:39:17, Dilip Kota <eswara.kota@linux.intel.com>
> wrote:
>
>> Intel PCIe is synopsys based controller utilizes the Designware
> Please do this general replacement in all your patches.
>
> s/synopsys/Synopsys
>
> and
>
> s/Designware/DesignWare
Sure, i will update it in the next patch version.
(In the all other patches naming is proper, i got missed it here.)
I will ensure and take care of it.

Regards,
Dilip

>
>> framework for host initialization and intel application
>> specific register configurations.
>>
>> Changes on v4:
>> 	Add lane resizing API in PCIe DesignWare driver.
>> 	Intel PCIe driver uses it for lane resizing which
>> 	 is being exposed through sysfs attributes.
>> 	Add Intel PCIe sysfs attributes is in separate patch.
>> 	Address review comments given on v3.
>>
>> Changes on v3:
>> 	Compared to v2, map_irq() patch is removed as it is no longer
>> 	  required for Intel PCIe driver. Intel PCIe driver does platform
>> 	  specific interrupt configuration during core initialization. So
>> 	  changed the subject line too.
>> 	Address v2 review comments for DT binding and PCIe driver
>>
>> Dilip Kota (3):
>>    dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>>    dwc: PCI: intel: PCIe RC controller driver
>>    pci: intel: Add sysfs attributes to configure pcie link
>>
>>   .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 ++++
>>   drivers/pci/controller/dwc/Kconfig                 |  10 +
>>   drivers/pci/controller/dwc/Makefile                |   1 +
>>   drivers/pci/controller/dwc/pcie-designware.c       |  43 ++
>>   drivers/pci/controller/dwc/pcie-designware.h       |  15 +
>>   drivers/pci/controller/dwc/pcie-intel-gw.c         | 700 +++++++++++++++
>>   include/uapi/linux/pci_regs.h                      |   1 +
>>   7 files changed, 905 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>>   create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>>
>> -- 
>> 2.11.0
>
