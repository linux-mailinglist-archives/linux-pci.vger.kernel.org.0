Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C141A2F27D7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbhALF1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 00:27:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:57448 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbhALF1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 00:27:08 -0500
IronPort-SDR: 800DPH8MeGXzTE3pDEhYgCM63lWAVqUBLigHxaxnf8OBj3nwTJ+mDPZxSnNvrJ7Dy+RR7Cv0fl
 mE2/zX8+wmbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165665509"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="165665509"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 21:25:22 -0800
IronPort-SDR: K+Po9YhVEEvS3vIMEnPHNo6eOJJ0eHQkpCK/TheO9bgoFzo1w6F7RQ/G+viZ1QtF5egjChfGup
 rnYl4bjJ+bdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="464398320"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 21:25:15 -0800
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "Hossain, Mona" <mona.hossain@intel.com>,
        "netanelg@mellanox.com" <netanelg@mellanox.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Ortiz, Samuel" <samuel.ortiz@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "shahafs@mellanox.com" <shahafs@mellanox.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "yan.y.zhao@linux.intel.com" <yan.y.zhao@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC PATCH v2 1/1] platform-msi: Add platform check for subdevice
 irq domain
To:     Leon Romanovsky <leon@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20210106022749.2769057-1-baolu.lu@linux.intel.com>
 <20210106060613.GU31158@unreal>
 <3d2620f9-bbd4-3dd0-8e29-0cfe492a109f@linux.intel.com>
 <20210106104017.GV31158@unreal> <20210106152339.GA552508@nvidia.com>
 <20210106160158.GX31158@unreal>
 <MWHPR11MB18867EE2F4FA0382DCFEEE2B8CAF0@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210107060916.GY31158@unreal>
 <MWHPR11MB188629E36439F80AD60900788CAF0@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210107071616.GA31158@unreal>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dfda8933-566c-1ec7-4ed4-427f094cb7c9@linux.intel.com>
Date:   Tue, 12 Jan 2021 13:17:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107071616.GA31158@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/7/21 3:16 PM, Leon Romanovsky wrote:
> On Thu, Jan 07, 2021 at 06:55:16AM +0000, Tian, Kevin wrote:
>>> From: Leon Romanovsky <leon@kernel.org>
>>> Sent: Thursday, January 7, 2021 2:09 PM
>>>
>>> On Thu, Jan 07, 2021 at 02:04:29AM +0000, Tian, Kevin wrote:
>>>>> From: Leon Romanovsky <leon@kernel.org>
>>>>> Sent: Thursday, January 7, 2021 12:02 AM
>>>>>
>>>>> On Wed, Jan 06, 2021 at 11:23:39AM -0400, Jason Gunthorpe wrote:
>>>>>> On Wed, Jan 06, 2021 at 12:40:17PM +0200, Leon Romanovsky wrote:
>>>>>>
>>>>>>> I asked what will you do when QEMU will gain needed functionality?
>>>>>>> Will you remove QEMU from this list? If yes, how such "new" kernel
>>> will
>>>>>>> work on old QEMU versions?
>>>>>>
>>>>>> The needed functionality is some VMM hypercall, so presumably new
>>>>>> kernels that support calling this hypercall will be able to discover
>>>>>> if the VMM hypercall exists and if so superceed this entire check.
>>>>>
>>>>> Let's not speculate, do we have well-known path?
>>>>> Will such patch be taken to stable@/distros?
>>>>>
>>>>
>>>> There are two functions introduced in this patch. One is to detect whether
>>>> running on bare metal or in a virtual machine. The other is for deciding
>>>> whether the platform supports ims. Currently the two are identical because
>>>> ims is supported only on bare metal at current stage. In the future it will
>>> look
>>>> like below when ims can be enabled in a VM:
>>>>
>>>> bool arch_support_pci_device_ims(struct pci_dev *pdev)
>>>> {
>>>> 	return on_bare_metal() || hypercall_irq_domain_supported();
>>>> }
>>>>
>>>> The VMM vendor list is for on_bare_metal, and suppose a vendor will
>>>> never be removed once being added to the list since the fact of running
>>>> in a VM never changes, regardless of whether this hypervisor supports
>>>> extra VMM hypercalls.
>>>
>>> This is what I imagined, this list will be forever, and this worries me.
>>>
>>> I don't know if it is true or not, but guess that at least Oracle and
>>> Microsoft bare metal devices and VMs will have same DMI_SYS_VENDOR.
>>
>> It's true. David Woodhouse also said it's the case for Amazon EC2 instances.
>>
>>>
>>> It means that this on_bare_metal() function won't work reliably in many
>>> cases. Also being part of include/linux/msi.h, at some point of time,
>>> this function will be picked by the users outside for the non-IMS cases.
>>>
>>> I didn't even mention custom forks of QEMU which are prohibited to change
>>> DMI_SYS_VENDOR and private clouds with custom solutions.
>>
>> In this case the private QEMU forks are encouraged to set CPUID (X86_
>> FEATURE_HYPERVISOR) if they do plan to adopt a different vendor name.
> 
> Does QEMU set this bit when it runs in host-passthrough CPU model?
> 
>>
>>>
>>> The current array makes DMI_SYS_VENDOR interface as some sort of ABI. If
>>> in the future,
>>> the QEMU will decide to use more hipster name, for example "qEmU", this
>>> function
>>> won't work.
>>>
>>> I'm aware that DMI_SYS_VENDOR is used heavily in the kernel code and
>>> various names for the same company are good example how not reliable it.
>>>
>>> The most hilarious example is "Dell/Dell Inc./Dell Inc/Dell Computer
>>> Corporation/Dell Computer",
>>> but other companies are not far from them.
>>>
>>> Luckily enough, this identification is used for hardware product that
>>> was released to the market and their name will be stable for that
>>> specific model. It is not the case here where we need to ensure future
>>> compatibility too (old kernel on new VM emulator).
>>>
>>> I'm not in position to say yes or no to this patch and don't have plans to do it.
>>> Just expressing my feeling that this solution is too hacky for my taste.
>>>
>>
>> I agree with your worries and solely relying on DMI_SYS_VENDOR is
>> definitely too hacky. In previous discussions with Thomas there is no
>> elegant way to handle this situation. It has to be a heuristic approach.
>> First we hope the CPUID bit is set properly in most cases thus is checked
>> first. Then other heuristics can be made for the remaining cases. DMI_
>> SYS_VENDOR is the first hint and more can be added later. For example,
>> when IOMMU is present there is vendor specific way to detect whether
>> it's real or virtual. Dave also mentioned some BIOS flag to indicate a
>> virtual machine. Now probably the real question here is whether people
>> are OK with CPUID+DMI_SYS_VENDOR combo check for now (and grow
>> it later) or prefer to having all identified heuristics so far in-place together...
> 
> IMHO, it should be as much as possible close to the end result.

Okay! This seems to be a right way to go.

The SMBIOS defines a 'virtual machine' bit in the BIOS characteristics
extension byte. It could be used as a possible way.

In order to support emulated IOMMU for fully virtualized guest, the
iommu vendors defined methods to distinguish between bare metal and VMM
(caching mode in VT-d for example).

I will go ahead with adding above two methods before checking the block
list.

Best regards,
baolu
