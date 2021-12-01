Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA16C46584F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLAVYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:24:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:49413 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhLAVYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 16:24:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="297360609"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="297360609"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 13:21:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="602309136"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.64.69]) ([10.212.64.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 13:21:16 -0800
Message-ID: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
Date:   Wed, 1 Dec 2021 14:21:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87k0go8432.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/1/2021 1:25 PM, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 11:47, Dave Jiang wrote:
>> On 12/1/2021 11:41 AM, Thomas Gleixner wrote:
>>>> Hi Thomas. This is actually the IDXD usage for a mediated device passed
>>>> to a guest kernel when we plumb the pass through of IMS to the guest
>>>> rather than doing previous implementation of having a MSIX vector on
>>>> guest backed by IMS.
>>> Which makes a lot of sense.
>>>
>>>> The control block for the mediated device is emulated and therefore an
>>>> emulated MSIX vector will be surfaced as vector 0. However the queues
>>>> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
>>>> running on the guest kernel for the same device.
>>> Why? What's wrong with using straight MSI-X for all of them?
>> The hardware implementation does not have enough MSIX vectors for
>> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS
>> vectors. So if we are to do MSI-X for all of them, then we need to do
>> the IMS backed MSIX scheme rather than passthrough IMS to guests.
> Confused. Are you talking about passing a full IDXD device to the guest
> or about passing a carved out subdevice, aka. queue?

I'm talking about carving out a subdevice. I had the impression of you 
wanting IMS passed through for all variations. But it sounds like for a 
sub-device, you are ok with the implementation of MSIX backed by IMS?


>
> Thanks,
>
>          tglx
>
