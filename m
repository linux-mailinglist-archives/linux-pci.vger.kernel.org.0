Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91C41F5D6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJATre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 15:47:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:41519 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhJATrd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 15:47:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="222351649"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="222351649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 12:45:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565235176"
Received: from mgelhass-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.119.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 12:45:39 -0700
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d9870c16-4a61-c1f0-89d4-79931ed3594e@linux.intel.com>
Date:   Fri, 1 Oct 2021 12:45:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001190048.GA512418@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/1/21 12:00 PM, Alan Stern wrote:
> On Fri, Oct 01, 2021 at 11:09:52AM -0700, Dan Williams wrote:
>> On Fri, Oct 1, 2021 at 9:47 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>>>
>>> On Fri, Oct 01, 2021 at 09:13:54AM -0700, Dan Williams wrote:
>>>> Bear with me, and perhaps it's a lack of imagination on my part, but I
>>>> don't see how to get to a globally generic "authorized" sysfs ABI
>>>> given that USB and Thunderbolt want to do bus specific actions on
>>>> authorization toggle events. Certainly a default generic authorized
>>>> attribute can be defined for all the other buses that don't have
>>>> legacy here, but Thunderbolt will still require support for '2' as an
>>>> authorized value, and USB will still want to base probe decisions on
>>>> the authorization state of both the usb_device and the usb_interface.
>>>
>>> The USB part isn't really accurate (I can't speak for Thunderbolt).
>>> When a usb_device is deauthorized, the device will be unconfigured,
>>> deleting all its interfaces and removing the need for any probe
>>> decisions about them.  In other words, the probe decision for a
>>> usb_device or usb_interface depends only on the device's/interface's
>>> own authorization state.
>>>
>>> True, the interface binding code does contain a test of the device's
>>> authorization setting.  That test is redundant and can be removed.
>>>
>>> The actions that USB wants to take on authorization toggle events for
>>> usb_devices are: for authorize, select and install a configuration;
>>> for deauthorize, unconfigure the device.  Each of these could be
>>> handled simply enough just by binding/unbinding the device.  (There
>>> is some special code for handling wireless USB devices, but wireless
>>> USB is now defunct.)
>>
>> Ah, so are you saying that it would be sufficient for USB if the
>> generic authorized implementation did something like:
>>
>> dev->authorized = 1;
>> device_attach(dev);
>>
>> ...for the authorize case, and:
>>
>> dev->authorize = 0;
>> device_release_driver(dev);
>>
>> ...for the deauthorize case?
> 
> Yes, I think so.  But I haven't tried making this change to test and
> see what really happens.
> 

For thunderbolt driver, it looks much more complicated. Unless you
define some callbacks in struct bus_type, we cannot easily generalize
it (but such callbacks are not recommended because it brings bus specific
operations to core layer).

sysfs_read()
-> simple read

sysfs_write()
-> tb_switch_set_authorized()
   -> disapprove_switch()
      -> tb_domain_disapprove_switch()
         -> tb->cm_ops->disapprove_switch() (product specific call)
   -> tb_domain_approve_switch_key()
      -> tb->cm_ops->add_switch_key
      -> tb->cm_ops->approve_switch() (product specific call)
   -> tb_domain_approve_switch()
      -> tb->cm_ops->approve_switch() (product specific call)
   -> tb_domain_challenge_switch_key()
      -> tb->cm_ops->challenge_switch_key()
      -> crypto_alloc_shash()
      -> crypto_shash_setkey()
      -> crypto_shash_digest()
      -> tb->cm_ops->approve_switch() (product specific call)


> Alan Stern
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
