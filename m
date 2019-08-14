Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D485B8CE78
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 10:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHNIbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 04:31:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:41186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfHNIbR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 04:31:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="167322667"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2019 01:31:16 -0700
Received: from [10.226.39.52] (ekotax-mobl.gar.corp.intel.com [10.226.39.52])
        by linux.intel.com (Postfix) with ESMTP id 388D3580238;
        Wed, 14 Aug 2019 01:31:15 -0700 (PDT)
Subject: Re: [PATCH] PCI: dwc: Add map irq callback
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
References: <333e87c8ea92cd7442fbe874fc8c9eccabc62f58.1565763869.git.eswara.kota@linux.intel.com>
 <20190814073605.GA31526@infradead.org>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <fe722a89-37e7-9ef6-042b-a9584f234740@linux.intel.com>
Date:   Wed, 14 Aug 2019 16:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190814073605.GA31526@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph Hellwig,

On 8/14/2019 3:36 PM, Christoph Hellwig wrote:
> On Wed, Aug 14, 2019 at 02:56:49PM +0800, Dilip Kota wrote:
>> Certain platforms like Intel need to configure
>> registers to enable the interrupts.
>> Map Irq callback helps to perform platform specific
>> configurations while assigning or enabling the interrupts.
> This seems to miss the hunk that actually assigns the map_irq
> callback.
pp->map_irq() must assign the callback along with the platform specific 
configuration.
In Intel PCIe driver pp->map_irq() does the same. (Driver is not yet 
present in mainline, i will submit for review once this change is approved).
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index f93252d0da5b..5880d2b72ef8 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -470,7 +470,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   	bridge->sysdata = pp;
>>   	bridge->busnr = pp->root_bus_nr;
>>   	bridge->ops = &dw_pcie_ops;
>> -	bridge->map_irq = of_irq_parse_and_map_pci;
>> +	bridge->map_irq = pp->map_irq ? pp->map_irq : of_irq_parse_and_map_pci;
> Pleae just use a classic if / else to make the code a little easier
> to read.

Noted, will update it.

--Dilip

