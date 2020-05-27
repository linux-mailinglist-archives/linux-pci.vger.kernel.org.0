Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218DB1E362E
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 05:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgE0DGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 23:06:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:29330 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbgE0DGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 23:06:02 -0400
IronPort-SDR: QNB2Hc1LbhEqd06LcAQinYI7mj9YDKju6B8oPphCkTPQQ5V3gNw3jAed3Iv1BxTElJ7P4H2m7l
 A6Vr2ShiRq6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 20:06:02 -0700
IronPort-SDR: udG/k5eKyhqnYaLObyUiCt5BjJmK5ygdvlGvYHJTa9RB/w+qpuZOdmfgFJauU/Rfkbpbl98rSy
 ENEKzTgE9ulw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="270305926"
Received: from zalvear-mobl.amr.corp.intel.com (HELO [10.254.67.58]) ([10.254.67.58])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2020 20:06:01 -0700
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ashok.raj@intel.com
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
 <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
 <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com>
 <d59e5312-9f0b-f6b2-042a-363022989b8f@linux.intel.com>
 <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com>
 <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
 <CAOSf1CHTUyQ5o_ThkaPUkGjtTSK1UOkxSmKAWY3n3bdrVcjacA@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <55b3a469-c306-acf1-f97e-f07f40054974@linux.intel.com>
Date:   Tue, 26 May 2020 20:06:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CHTUyQ5o_ThkaPUkGjtTSK1UOkxSmKAWY3n3bdrVcjacA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/26/20 8:00 PM, Oliver O'Halloran wrote:
> On Wed, May 27, 2020 at 12:00 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 5/21/20 7:56 PM, Yicong Yang wrote:
>>>
>>>
>>> On 2020/5/22 3:31, Kuppuswamy, Sathyanarayanan wrote:
>>>>
>>> Not exactly. In pci_bus_error_reset(), we call pci_slot_reset() only if it's
>>> hotpluggable. But we always call pci_bus_reset() to perform a secondary bus
>>> reset for the bridge. That's what I think is unnecessary for a normal link,
>>> and that's what reset link indicates us to do. The slot reset is introduced
>>> in the process only to solve side effects. (c4eed62a2143, PCI/ERR: Use slot reset if available)
>>
>> IIUC, pci_bus_reset() will do slot reset if its supported (hot-plug
>> capable slots). If its not supported then it will attempt secondary
>> bus reset. So secondary bus reset will be attempted only if slot
>> reset is not supported.
>>
>> Since reported_error_detected() requests us to do reset, we will have
>> to attempt some kind of reset before we call ->slot_reset() right?
> 
> Yes, the driver returns PCI_ERS_RESULT_NEED_RESET from
> ->error_detected() to indicate that it doesn't know how to recover
> from the error. How that reset is performed doesn't really matter, but
> it does need to happen.
> 
> 
>>> PCI_ERS_RESULT_NEED_RESET indicates that the driver
>>> wants a platform-dependent slot reset and its ->slot_reset() method to be called then.
>>> I don't think it's same as slot reset mentioned above, which is only for hotpluggable
>>> ones.
>> What you think is the correct reset implementation ? Is it something
>> like this?
>>
>> if (hotplug capable)
>>      try_slot_reset()
>> else
>>      do_nothing()
> 
> Looks broken to me, but all the reset handling is a rat's nest so
> maybe I'm missing something. In the case of a DPC trip the link is
> disabled which has the side-effect of hot-resetting the downstream
> device. Maybe it's fine?
Yes, in case of DPC (Fatal errors) link is already reset. So we
don't need any special handling. This reset logic is mainly for
non-fatal errors.
> 
> As an aside, why do we have both ->slot_reset() and ->reset_done() in
> the error handling callbacks? Seems like their roles are almost
> identical.
Not sure.I think reset_done() is final cleanup.
> 
> Oliver
> 
