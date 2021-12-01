Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D94655C0
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhLASuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:50:07 -0500
Received: from ale.deltatee.com ([204.191.154.188]:39346 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhLASuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 13:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=r30vrxFCP6SncVineLSUUmIOIpLd8fSftlOXik2T9FE=; b=s//uUFgW5DLJypW1apS0KnBoYo
        WGUWICT2KeHBp5Tyzdm5fZIsuWxpT5DrzZNRfavLesfW/y9G2HUc3evCIgkF2+8OpnLrmYD4lwY9E
        1uCJBzMki4KoUJSgly8pHW8OxeHz8yHWClQ5g6vKUc/JvX0gt0rld0DaRHia1B2dFOYEmeRDM0tMO
        RfLq4nm/o/fnQkE7XZiD/3XeV8+Dm9dQlPph7m90/r98jATCJvQw78rRjz/pZXvZTASKOCFc1dHCD
        FWEkCkWJIQ04ItTjDrLwY2D9SJsAE45J17+0VOUWx3I7uBnD6vxAP9Gjtc0e/LrEVSy9OV3GjkH8c
        8f6N58KQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1msUci-00Byjo-Gf; Wed, 01 Dec 2021 11:46:33 -0700
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4d4550a-022e-4574-3937-248518dae763@deltatee.com>
Date:   Wed, 1 Dec 2021 11:46:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201181406.GM4670@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, jroedel@suse.de, x86@kernel.org, borntraeger@de.ibm.com, hca@linux.ibm.com, linux-s390@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, ashok.raj@intel.com, megha.dey@intel.com, kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org, helgaas@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-12-01 11:14 a.m., 'Jason Gunthorpe' via linux-ntb wrote:
> On Wed, Dec 01, 2021 at 06:35:35PM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
>>> On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
>>>> Looking at the device slices as subdevices with their own struct device
>>>> makes a lot of sense from the conceptual level.
>>>
>>> Except IMS is not just for subdevices, it should be usable for any
>>> driver in any case as a general interrupt mechiansm, as you alluded to
>>> below about ethernet queues. ntb seems to be the current example of
>>> this need..
>>
>> But NTB is operating through an abstraction layer and is not a direct
>> PCIe device driver.
> 
> I'm not sure exactly how NTB seems to be split between switchtec and
> the ntb code, but since the ntbd code seems to be doing MMIO touches,
> it feels like part of a PCIe driver?

Eh, sort of. NTB has lots of layers. At the top you'll find ntb_netdev
which is an network interface. Below that is ntb_transport() which is a
generic queue pair. Below that is the hardware driver itself (ie
switchtec) through the abstraction layer. The switchtec driver is split
in two: the main driver which just allows for information and
administration of the switch itself and switchtec_ntb which is the
module that provides the NTB abstractions to twiddle its registers.

ntb_transport() doesn't directly do MMIO touches (as it doesn't know
what the underlying hardware registers are). Except for the memory
windows which are usually setup to be a specific BAR (or parts of a
BAR). ntb_transport will do MMIO writes to those specific BAR address
which correspond to writing into buffers on the peer.

Logan
