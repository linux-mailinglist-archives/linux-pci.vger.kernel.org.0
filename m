Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D031926BA3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 04:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIPCaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 22:30:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:25382 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgIPCaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 22:30:35 -0400
IronPort-SDR: EByuVlpv9TVeVrK29xIQDDCNQ3iKw4pJDaPnAiIQSV21iaoay9UCtHmRhb61OZG/dzaEjrffBh
 XPqpvwLY6gaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="223570704"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="223570704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 19:30:31 -0700
IronPort-SDR: BaG7cLyG1T1AMzKbSctEQkLrk668E+MXCHvYGBVJhdWIPZJY39IsAHwNjPW6rHN9lO13VWwCkU
 HaZDwmrPGIww==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="451663401"
Received: from gschatz-mobl2.amr.corp.intel.com (HELO [10.254.127.209]) ([10.254.127.209])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 19:30:31 -0700
Subject: Re: [PATCH v8 1/5] PCI: Conditionally initialize host bridge native_*
 members
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200915221721.GA1437311@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <388c59f7-4c47-ddea-b37e-9ca001c43723@linux.intel.com>
Date:   Tue, 15 Sep 2020 19:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915221721.GA1437311@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/15/20 3:17 PM, Bjorn Helgaas wrote:
> On Sun, Sep 13, 2020 at 01:49:26PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> On 9/10/20 2:00 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> On 9/10/20 12:49 PM, Bjorn Helgaas wrote:
>>>> On Fri, Jul 24, 2020 at 08:58:52PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>

>>
>> But I am wondering whether its correct to move LTR code under
>> CONFIG_PCIEPORTBUS?. As per PCIe spec v5.0 sec 7.8.2, LTR is a
>> optional PCIe extended capability. So why is not moved under
>> drivers/pci/pcie/*. What is the criteria for code to be placed under
>> drivers/pci/pcie/*
> 
> Some folks think drivers/pci/pcie/ should not exist, and I tend to
> agree, but it's a fair bit of churn to remove it.  We do have quite a
> bit of PCIe extended capability support in drivers/pci -- ats.c,
> iov.c, vc.c.
> 
> There's no need to move LTR under CONFIG_PCIEPORTBUS because
> CONFIG_PCIEPORTBUS enables portdrv, and AFAIK there's nothing
> LTR-related that relies on portdrv.
> 
> The stuff currently in drivers/pci/pcie is mostly just portdrv and
> services that depend on it.  aspm.c and ptm.c are exceptions and
> really should be in drivers/pci.
Thanks for the clarification. I will remove the CONFIG_PCIEPORTBUS
dependency.
> 

>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
