Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D3228BD2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 00:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgGUWIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 18:08:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:8291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgGUWIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 18:08:15 -0400
IronPort-SDR: b1rHpTzjtaNA9iNNlWVvRZMsRo/2aILSIkPygmMrAqPJHeda9roj7kqhp1PQ8YW1N0AKWA2m77
 Jfe85oj8QETA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="211781276"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="211781276"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 15:08:15 -0700
IronPort-SDR: uj2yYoVxorhGFaeamyL6zsUBOj4bVz4+ChtifXaOWEEueCu5iXgJpZ5PDH4s/fqmhKOOt7yLOH
 OQeS4rBO61cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="392490938"
Received: from ddperry-mobl.amr.corp.intel.com (HELO [10.254.78.60]) ([10.254.78.60])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2020 15:08:14 -0700
Subject: Re: [PATCH] PCI/ERR: Rename pci_aer_clear_device_status() to
 pcie_clear_device_status()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20200721215348.GA1160927@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2633439e-4017-8efb-5bde-a5e9148971d6@linux.intel.com>
Date:   Tue, 21 Jul 2020 15:08:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721215348.GA1160927@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/21/20 2:53 PM, Bjorn Helgaas wrote:
> On Fri, Jul 17, 2020 at 01:20:22PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Hi Bjorn,
>>
>> On 7/17/20 12:56 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> pci_aer_clear_device_status() clears the error bits in the PCIe Device
>>> Status Register (PCI_EXP_DEVSTA).  Every PCIe device has this register,
>>> regardless of whether it supports AER.
>>
>> Since its not related to AER, can we move it out of AER driver ? May be
>> to pci.c ?
> 
> OK.  pci.c is really a grab bag of random stuff, but it *is* true that
> this doesn't really seem to belong in aer.c.
> 
> So I don't mind moving it to pci.c (does just before
> pcie_clear_root_pme_status() seem like a reasonable spot?)
> 
> But looking at this again makes me wonder whether putting the
> pcie_aer_is_native() test inside pcie_clear_device_status() is the
> right thing.  It seems like that test fits better with the AER code,
> i.e., in the *callers* of pcie_clear_device_status().
Yes. pcie_aer_is_native() should be left in AER driver.
> 
> It would mean repeating the test, since we call it twice, but it seems
> like it might match up with the spec better.  And I have a slight
> aversion to functions that can silently return without doing what it
> looks like they're supposed to do.
> 
> I can fix this all up if that seems right.  Or let me know if you have
> alternate ideas.
Agree with your approach. Its ok to add separate check for
pcie_aer_is_native().
> 
> Bjorn
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
