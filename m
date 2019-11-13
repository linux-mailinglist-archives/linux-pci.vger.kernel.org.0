Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E55FA6A9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 03:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKMCjr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 21:39:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:43956 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfKMCjr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 21:39:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 18:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,298,1569308400"; 
   d="scan'208";a="216241266"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 12 Nov 2019 18:39:46 -0800
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 3CF1E580372;
        Tue, 12 Nov 2019 18:39:43 -0800 (PST)
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <73655e49e80ac08826ad2d470e1387ba1b662d83.1572950559.git.eswara.kota@linux.intel.com>
 <20191112191727.GA31422@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <29a5797b-f65c-ba87-0a45-ff5815bf9fd3@linux.intel.com>
Date:   Wed, 13 Nov 2019 10:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112191727.GA31422@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/13/2019 3:17 AM, Rob Herring wrote:
> On Wed, Nov 06, 2019 at 11:44:01AM +0800, Dilip Kota wrote:
>> Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
>> which is Synopsys DesignWare based PCIe core.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>> ---
>> Changes on v5:
>> 	Add Reviewed-by Andrew Murray.
>> 	Add possible values and default value for max-link-speed.
>> 	Remove $ref and add maximum and default for reset-assert-ms.
>> 	Set true flag for linux,pci-domain.
>> 	Define maxItems for ranges and clock.
>> 	Define maximum for num-lanes.
>> 	Update required list:
>> 	  Add #address-cells, #size-cells, #interrupt-cells.
>> 	  Remove num-lanes and linux,pci-domain.
>> 	Add required header files in example.
>> 	Remove status entry in example.
>>
>> changes on v4:
>> 	Add "snps,dw-pcie" compatible.
>> 	Rename phy-names property value to pcie.
>> 	And maximum and minimum values to num-lanes.
>> 	Add ref for reset-assert-ms entry and update the
>> 	 description for easy understanding.
>> 	Remove PCIe core interrupt entry.
>>
>> changes on v3:
>>          Add the appropriate License-Identifier
>>          Rename intel,rst-interval to 'reset-assert-us'
>>          Add additionalProperties: false
>>          Rename phy-names to 'pciephy'
>>          Remove the dtsi node split of SoC and board in the example
>>          Add #interrupt-cells = <1>; or else interrupt parsing will fail
>>          Name yaml file with compatible name
>>
>>   .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 +++++++++++++++++++++
>>   1 file changed, 138 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> I'm working on a common PCI schema which will shrink this, but in the
> meantime:
>
> Reviewed-by: Rob Herring <robh@kernel.org>
Sure, Thanks for reviewing the patch.

Regards,
Dilip
