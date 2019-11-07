Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24330F3AEE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 23:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKGWHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 17:07:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:26151 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKGWHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 17:07:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 14:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="scan'208";a="192966898"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2019 14:07:41 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id A117E580108;
        Thu,  7 Nov 2019 14:07:41 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     Olof Johansson <olof@lixom.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191025202004.GA147688@google.com>
 <1ade6a9f-9532-c400-9bb0-4e68ed5752ce@linux.intel.com>
 <CAOesGMhdAUKj9f0=sVwH7kffr=P-LqWWqKxKK3N3e0MpcjLExw@mail.gmail.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <43b431b6-f544-f9f0-d6f3-f383d7b882b9@linux.intel.com>
Date:   Thu, 7 Nov 2019 14:05:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMhdAUKj9f0=sVwH7kffr=P-LqWWqKxKK3N3e0MpcjLExw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/7/19 12:09 PM, Olof Johansson wrote:
> On Thu, Nov 7, 2019 at 12:02 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Hi,
>>
>> On 10/25/19 1:20 PM, Bjorn Helgaas wrote:
>>> On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
>>>> In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
>>>> the behavior was changed such that native (kernel) handling of DPC
>>>> got tied to whether the kernel also handled AER. While this is what
>>>> the standard recommends, there are BIOSes out there that lack the DPC
>>>> handling since it was never required in the past.
>>> Some systems do not grant OS control of AER via _OSC.  I guess the
>>> problem is that on those systems, the OS DPC driver used to work, but
>>> after eed85ff4c0da7, it does not.  Right?
>> I need some clarification on this issue. Do you mean in these systems,
>> firmware expects OS to handle DPC and AER, but it does not let OS know
>> about it via _OSC ?
> The OS and BIOS both assumed behavior as before eed85ff4c0da7 -- AER
> handled by firmware but DPC handled by kernel.
>
> I.e. a classic case of "Sure, the spec says this, but in reality
> implementations relied on actual behavior", and someone had a
> regression and need a way to restore previous behavior.

Got it. I don't know whether its good to add hacks to support products 
that does not follow spec.
But, do you think it would be useful to add some kind of warning message 
when this option is
enabled ? May be it could be useful in debugging.

>
> -Olof
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

