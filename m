Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490357A9020
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjIUAVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 20:21:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F19DC
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695255661; x=1726791661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9i3e8wy+vOuBmUCugWXqfgECjzaVxa2azzSOh2LvW5k=;
  b=ZviFjsB2JDgdmnySRtK9UUx5R7CyPyY+UWOIz/fuVqFKlm3vQdx59yhN
   hvheRWbJntrRzR8cgYKmjTGKTByGptYqSHCrvVW0vdwrJjQG8VqLpvrdx
   5iWXrvDILcGw/e5JJF4hLvN7HgTLWcV7CXLmz3ZNOKkp+4nruWCWftCin
   GeeBvdQHJQlhWLEAv71gZ9HW6f/UDWl8kMQjZUoRhH+cXWJ/+UcyRZGHb
   nfWNmW7GCJPrJH0VYVEPZN1Z9QIBsMUR5IwGmnziFkdE7/Occ7E+v/Dye
   nggjPdCHvC32bFR1R4WWd/ojFOczL6wUdzq0L+uDIWQJTNF73pXgC2Bv3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365442044"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365442044"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="750156443"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="750156443"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.160.43]) ([10.213.160.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:21:00 -0700
Message-ID: <1a6ad83f-3757-4503-93db-c3597132b020@linux.intel.com>
Date:   Wed, 20 Sep 2023 17:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        samruddh.dhope@intel.com
References: <CAJZ5v0hDm-B9zAMcf0aYXDjTaOnvgGNsaPYX=yc5kVy9YR1cdQ@mail.gmail.com>
 <20230919200907.GA241545@bhelgaas>
 <CAJZ5v0jjj+0sasfMd5Vd9oPV6uD2nP3Zo34h0fBR02GcWMYJ_Q@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAJZ5v0jjj+0sasfMd5Vd9oPV6uD2nP3Zo34h0fBR02GcWMYJ_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/2023 3:08 AM, Rafael J. Wysocki wrote:
> On Tue, Sep 19, 2023 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Tue, Sep 19, 2023 at 08:32:22PM +0200, Rafael J. Wysocki wrote:
>>> On Tue, Sep 19, 2023 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Tue, Sep 19, 2023 at 05:52:33PM +0200, Rafael J. Wysocki wrote:
>>>>> On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>> On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
>>>>>>> On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> [snipped]
>>>>>>>> Hmm.  In some ways the VMD device acts as a Root Port, since it
>>>>>>>> originates a new hierarchy in a separate domain, but on the upstream
>>>>>>>> side, it's just a normal endpoint.
>>>>>>>>
>>>>>>>> How does AER for the new hierarchy work?  A device below the VMD can
>>>>>>>> generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
>>>>>>>> assuming those messages would terminate at the VMD, and the VMD could
>>>>>>>> generate an AER interrupt just like a Root Port.  But that can't be
>>>>>>>> right because I don't think VMD would have the Root Error Command
>>>>>>>> register needed to manage that interrupt.
>>>>>>> VMD itself doesn't seem to manage AER, the rootport that "moved" from
>>>>>>> 0000 domain does:
>>>>>>> [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
>>>>>>> 10000:e1:00.0
>>>>>>> [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
>>>>>>> type=Physical Layer, (Receiver ID)
>>>>>>> [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
>>>>>>> status/mask=00000001/0000e000
>>>>>>> [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
>>>>>> Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
>>>>>> that is logically below the VMD, e.g., (from
>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215027):
>>>>>>
>>>>>>   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
>>>>>>   acpi PNP0A08:00: _OSC: platform does not support [AER]
>>>>>>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
>>>>>>   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
>>>>>>   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
>>>>>>   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
>>>>>>   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
>>>>>>
>>>>>> So ERR_* messages from the e1:00.0 Samsung device would terminate at
>>>>>> the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
>>>>>> Error Command/Status/Error Source registers.
>>>>>>
>>>>>>>> But if VMD just passes those messages up to the Root Port, the source
>>>>>>>> of the messages (the Requester ID) won't make any sense because
>>>>>>>> they're in a hierarchy the Root Port doesn't know anything about.
>>>>>>> Not sure what's current status is but I think Nirmal's patch is valid
>>>>>>> for both our cases.
>>>>>> So I think the question is whether that PNP0A08:00 _OSC applies to
>>>>>> domain 10000.  I think the answer is "no" because the platform doesn't
>>>>>> know about the existence of domain 10000, and it can't access config
>>>>>> space in that domain.
>>>>> Well, the VMD device itself is there in domain 0000, however, and sure
>>>>> enough, the platform firmware can access its config space.
>>>>>
>>>>>> E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
>>>>>> don't think it would make sense for that to mean the platform *also*
>>>>>> owned AER in domain 10000, because the platform doesn't know how to
>>>>>> configure AER or handle AER interrupts in that domain.
>>>>> I'm not sure about this.
>>>>>
>>>>> AFAICS, domain 10000 is not physically independent of domain 0000, so
>>>>> I'm not sure to what extent the above applies.
>>>> Domain 10000 definitely isn't physically independent of domain 0000
>>>> since all TLPs to/from 10000 traverse the domain 0000 link to the VMD
>>>> at 0000:00:0e.0.
>>>>
>>>> The platform can access the VMD endpoint (0000:00:0e.0) config space.
>>>> But I don't think the platform can access config space of anything in
>>>> domain 10000, which in my mind makes it *logically* independent.
>>>>
>>>> IIUC, config access to anything below the VMD (e.g., domain 10000) is
>>>> done by the vmd driver itself using BAR 0 of the VMD device
>>>> (vmd_cfg_addr(), vmd_pci_read(), vmd_pci_write(), see [1]).
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/vmd.c?id=v6.5#n378
>>> I know, but the platform firmware may not need to go through the VMD
>>> BAR in order to change the configuration of the devices in the "VMD
>>> segment".
>> I'm assuming that firmware can only access "VMD segment" config space
>> if it has its own VMD driver.  It sounds like there might be another
>> way that I don't know about?  Is there some way to do things via AML
>> and _REG?
> I would need to ask the VMD people about this TBH.

Sorry for the previous message!

Once VMD is enabled from the BIOS, entire PCI tree behind VMD is owned
and managed by UEFI VMD driver. So 10000 domain is owned by VMD Linux
driver after boot up.

The entire PCI topology behind VMD is mapped into a memory whose
address is programmed in BAR0/1 of VMD endpoint. Any config access to
rootports or NVMe behind VMD is an MMIO access.

>
>>> The question is whether or not the OS should attempt to control the
>>> _OSC features on the VMD segment if the firmware has not allowed it to
>>> control those features on the primary "parent" segment and the way the
>>> config space on the VMD segment is accessed may not be entirely
>>> relevant in that respect.
I agree. The way the config space on VMD segment is accessed may
not be important. Since we have the question of ownership of VMD
domain.

When firmware disables native_aer support, the VMD driver doesn't
know about it. We can verify this by looking at difference in
values of native_aer for VMD host_bridge and VMD root_bridge.
(i.e. vmd_copy_host_bridge_flags)
OS needs to make VMD driver aware if AER is enabled or disabled by
the firmware.

We should also consider the case of VM.
VM firmware is not aware of VMD or VMD Hotplug support. Host firmware
needs to provide a way to pass the Hotplug settings to VM firmware
but it is not possible at the moment as VM firmware doesn't know
about VMD.

Also another impact of _OSC ownership of VMD domain for all the
settings is that the VMD Hotplug setting from BIOS becomes irrelevant.
BIOS allows enabling and disabling of Hotplug on VMD's rootports from
BIOS menu but it doesn't allow enabling or disabling of AER, PM, DPC,
etc.
>> All these features are managed via config space.
> As far as the OS is concerned.
>
>> I don't know how to
>> interpret "firmware has no way to read the AER Capability of a Root
>> Port in the VMD segment, but firmware still owns AER".  That sounds to
>> me like "nobody can do anything with AER".
> This assumes that the config space access method used by Linux is the
> only one available, but I'm not sure that this is the case.  It would
> be nice if someone could confirm or deny this.  Nirmal?
>
> Also, I know for a fact that the firmware running on certain tiny
> cores included in the SoC may talk to the PCI devices on it via I2C or
> similar (at least on servers).  This communication channel can be used
> to control the features in question AFAICS.
>
>>> Note that VMD may want to impose additional restrictions on the OS
>>> control of those features, but it is not clear to me whether or not it
>>> should attempt to override the refusal to grant control of them on the
>>> primary host bridge.
>> In practical terms, I think you're saying vmd_copy_host_bridge_flags()
>> could CLEAR vmd_bridge->native_* flags (i.e., restrict the OS from
>> using features even if the platform has granted control of them), but
>> it's not clear that it should SET them (i.e., override platform's
>> refusal to grant control)?  Is that right?
> Yes, it is.
That may be true for host but in case of VM where VM BIOS is
disabling everything and setting them to default power off state.

Since VMD driver doesn't know if native_aer is enabled or disabled on
the platform by the firmware, we should keep using
vmd_copy_host_bridge_flags to get native_aer settings.

I can think of two approaches at the moment that can solve our issue.

Option #1: Keep the proposed changes.

Option #2: Keep the patch 04b12ef163d1 and find a way to set Hotplug
for VMD in VM. One way to do is to read Hotplug capable bit in SltCap
as defined in PCI specs and enable or disable native_hotplug based on
that value.

For more information.
Since VMD Linux driver doesn't have independent AER handling, it
should honor the platform or _OSC AER settings. Before the patch
04b12ef163d1, AER was getting enabled on its VMD rootports when VMD
driver makes call to pci_create_root_bus -> pci_alloc_host_bridge
-> pci_init_host_bridge. see [1]

[1] https://elixir.bootlin.com/linux/latest/C/ident/pci_init_host_bridge

>
>> I've been assuming config space access is the critical piece, but it
>> sounds like maybe it's not?
> It may not be in principle, so it would be good to have more
> information regarding this.  I would like the VMD people to tell us
> what exactly the expectations are.


