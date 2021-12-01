Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5313C465990
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353715AbhLAW5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 17:57:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:51076 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343872AbhLAW5K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 17:57:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236389778"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="236389778"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 14:53:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="602370697"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.64.69]) ([10.212.64.69])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 14:53:47 -0800
Message-ID: <0eab4c0e-c672-1138-2d95-3c9bee9ecdb1@intel.com>
Date:   Wed, 1 Dec 2021 15:53:46 -0700
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
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <45302c9d-f7a0-5a47-d0be-127d0dea45fb@intel.com> <875ys87zl5.ffs@tglx>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <875ys87zl5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/1/2021 3:03 PM, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 14:49, Dave Jiang wrote:
>> On 12/1/2021 2:44 PM, Thomas Gleixner wrote:
>>> How that is backed on the host does not really matter. You can expose
>>> MSI-X to the guest with a INTx backing as well.
>>>
>>> I'm still failing to see the connection between the 9 MSIX vectors and
>>> the 2048 IMS vectors which I assume that this is the limitation of the
>>> physical device, right?
>> I think I was confused with what you were asking and was thinking you
>> are saying why can't we just have MSIX on guest backed by the MSIX on
>> the physical device and thought there would not be enough vectors to
>> service the many guests. I think I understand what your position is now
>> with the clarification above.
> This still depends on how this overall discussion about representation
> of all of this stuff is resolved.
>
>>> What needs a subdevice to expose?
> Can you answer that too please?

Sorry. So initial version of the IDXD sub-device is represented with a 
single queue. It needs a command irq (emulated) and a completion irq 
that is backed by a device vector (currently IMS).


>
> Thanks,
>
>          tglx
