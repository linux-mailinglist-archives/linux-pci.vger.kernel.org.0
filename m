Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4C1D5C63
	for <lists+linux-pci@lfdr.de>; Sat, 16 May 2020 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOW2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 18:28:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:48349 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgEOW2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 18:28:18 -0400
IronPort-SDR: uyzgEvSHXpWmhmMiruhGtvG5t21v36jwwuG/m/OUG0pAli2ba9knnlFNBqPwjHGn72CrmnlCO8
 oCE0Ecdi7jPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 15:28:18 -0700
IronPort-SDR: IhVOBDmjxlDK9Sd8+sJGPG+B4+FkqFiJ1cAgWab3U9jtR3iv4eNAqfxXRYeZUF8b1LxiPs5Z1P
 Rqps0i5b8W/A==
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="410611473"
Received: from pyontay-mobl.amr.corp.intel.com (HELO [10.212.179.171]) ([10.212.179.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 15:28:18 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: Add basic Compute eXpress Link DVSEC decode
Date:   Fri, 15 May 2020 15:28:17 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <55BAB3D3-5C7F-455A-96E6-7C5672510021@linux.intel.com>
In-Reply-To: <20200515210435.GA544190@bjorn-Precision-5520>
References: <20200515210435.GA544190@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 15 May 2020, at 14:04, Bjorn Helgaas wrote:

> On Fri, May 15, 2020 at 10:55:28AM -0700, Sean V Kelley wrote:
>> Compute eXpress Link is a new CPU interconnect created with
>> workload accelerators in mind. The interconnect relies on PCIe 
>> Electrical
>> and Physical interconnect for communication. CXL devices enumerate to 
>> the
>> OS as an ACPI-described PCIe Root Complex Integrated Endpoint.
>>
>> This patch introduces the bare minimum support by simply looking for 
>> and
>> caching the DVSEC CXL Extended Capability. Currently, only CXL.io 
>> (which
>> is mandatory to be configured by BIOS) is enabled. In future, we will
>> also add support for CXL.cache and CXL.mem.
>
> This looks fine, but AFAICT, it doesn't *do* anything yet (except
> print a few things to dmesg).  We don't normally merge code until it
> adds some new functionality.  So just FYI that I'll wait until that
> new functionality comes along and then merge this as part of that
> series.  But let me know if I'm missing something.
>

Correct.  Understood. I’ve additional changes for CXL.mem/.cache.  
I’ll queue those up.

>> +	dev_info(&dev->dev, "CXL: Cache%c IO%c Mem%c Viral%c HDMCount 
>> %d\n",
>> +		 (cap & PCI_CXL_CACHE) ? '+' : '-',
>> +		 (cap & PCI_CXL_IO) ? '+' : '-',
>> +		 (cap & PCI_CXL_MEM) ? '+' : '-',
>> +		 (cap & PCI_CXL_VIRAL) ? '+' : '-',
>> +		 PCI_CXL_HDM_COUNT(cap));
>
> These could use pci_info() and FLAG(), as in pcie_init().

Will do.

>
>> +	dev_info(&dev->dev, "CXL: cap ctrl status ctrl2 status2 lock\n");
>> +	dev_info(&dev->dev, "CXL: %04x %04x %04x %04x %04x %04x\n",
>> +		 cap, ctrl, status, ctrl2, status2, lock);
>> +}
>
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -315,6 +315,7 @@ struct pci_dev {
>>  	u16		aer_cap;	/* AER capability offset */
>>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>>  #endif
>> +	u16		cxl_cap;	/* CXL capability offset */
>
> Wrap in #ifdef PCI_CXL.

Will do.

Thanks,

Sean
