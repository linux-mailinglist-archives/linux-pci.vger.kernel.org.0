Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED52EE8B6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbhAGWb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 17:31:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:51397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbhAGWb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 17:31:28 -0500
IronPort-SDR: TY9dNrQApMWFsFIZtRk4oQ5g+b4Cg/PXRBZFVNNXwRtiiNVwtFip41edv0E5lzxJRVuWvz4et4
 ABA0A1ebhoPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="165197263"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="165197263"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 14:30:48 -0800
IronPort-SDR: GRIvykcqsFsBX5IUkApi96iKuddlVKRVnnMhUnbMfPHK2unGfa49J40ttknUjaGooGnXWT+ZhX
 FJUJXhfUgZVw==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="497664854"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.209.22.194]) ([10.209.22.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 14:30:47 -0800
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X vectors
 by group
To:     Thomas Gleixner <tglx@linutronix.de>,
        Megha Dey <megha.dey@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
 <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
 <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <eabe50a6-efa8-ea96-d8ed-701a0564a13e@intel.com>
Date:   Thu, 7 Jan 2021 14:30:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 6/29/2019 12:59 AM, Thomas Gleixner wrote:
> As already pointed out, that's overengineered.
> 
> First of all this patch is doing too many things at once. These changes
> need to be split up in reviewable bits and pieces.
> 

I am looking into this work as I want to implement ability to do grouped
partial allocations of MSI-X vectors over time in the ice Linux NIC driver.

> But I consider this approach as a POC and not something which can be meant
> as a maintainable solution. It just duct tapes this new functionality into
> the existing code thereby breaking things left and right. And even if you
> can 'fix' these issues with more duct tape it won't be maintainable at all.
> 
> If you want to support group based allocations, then the PCI/MSI facility
> has to be refactored from ground up.
> 

I agree that this is the right direction to go, but I am having some
trouble with following these steps when I started trying to implement
this stuff.

>   1) Introduce the concept of groups by adding a group list head to struct
>      pci_dev. Ideally you create a new struct pci_dev_msi or whatever where
>      all this muck goes into.
> 

So my big problem I keep running into is that struct msi_desc is used by
several code paths that aren't PCI. It looks a bit odd trying to
refactor things to support groups for the non-PCI bus code that uses
struct msi_desc...

I'd appreciate any further thoughts you have on the right way to go
forward here. I think that treated vector allocations as groups is a
huge improvement, as it will make it easier to manage allocating MSI-X
vectors without running into exhaustion issues due to over allocating.

But does this need to be introduced as part of the generic linux/msi.h
stuff? Doing this means refactoring a bunch of code paths which don't
seem to care about grouping. But I can't find a good way to handle this
grouping in just the PCI layer.

>   2) Change the existing code to treat the current allocation mode as a
>      group allocation. Keep the entries in a new struct msi_entry_group and
>      have a group id, list head and the entries in there.
> 
>      Take care of protecting the group list.
> 
>      Assign group id 0 and add the entry_group to the list in the pci device.
> 
>      Rework the related functions so they are group aware.
> 
>      This can be split into preparatory and functional pieces, i.e. multiple
>      patches.
> 

The locking issue here also seems somewhat problematic. A lot of paths
that access the msi list don't seem to take a lock today. So any change
that affects these users would force adding locks on all these flows.

I guess for PCI code we could just stop using dev->msi_list altogether,
and instead use a PCI specific struct pci_msi_group or something? This
would mean that any flow that the PCI layer needs would have to take the
group structure instead of or in addition to the device pointer... It's
not clear how much code actually crosses between the PCI and non-PCI
usages of struct msi_desc...

>   3) Split out the 'first time' enablement code into separate functions and
>      store the relevant state in struct pci_dev_msi
> 
>   4) Rename pci_alloc_irq_vectors_affinity() to
>      pci_alloc_irq_vectors_affinity_group() and add a group_id pointer
>      argument.
> 
>      Make pci_alloc_irq_vectors_affinity() a wrapper function which hands
>      in a NULL group id pointer and does proper sanity checking.
> 
>   5) Create similar constructs for related functionality
> 
>   6) Enable the group allocation mode for subsequent allocations
> 

The rest of the flow makes sense, but I have been struggling with
finding the right abstraction for handling the msi_desc groups.

Does my idea of separating the PCI layer code to using its own structure
 (and iterators I guess?) instead of relying on msi_list make sense? I
guess other code could be converted to groups as well, but I have been
trying to find a good path forward that has minimal chance of breaking
other users...

I'd appreciate any insight here.

Thanks,
Jake

> Thanks,
> 
> 	tglx
> 
> 
>   
> 
> 
