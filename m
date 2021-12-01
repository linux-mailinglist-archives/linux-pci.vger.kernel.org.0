Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC07B465718
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352897AbhLAU31 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbhLAU3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:29:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3703C061756;
        Wed,  1 Dec 2021 12:25:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638390353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rILGDyAzrwQH4d0Fd/HHcQkOPeMa8khVt+2HdznW01Q=;
        b=gHLqUfYbZnA4M1RpNzxIMRcbkgK5IMmNM8uQqmKzOfgp4DBmqvlXrIHX/uMUjRoGgklvBs
        Ccc1Q+tKJH5hVLgasozL7uM/VkBxUtsvlhuoTbhleUwQEmgnq8gUijVpoorS+asFBo0txm
        yaQjBnTeOceLiedB1hF1agP53a24ebpiW3EftC34gpyb3ZzepzpNJ98kUWWrcoYZfiLn0x
        lKv0D0U5hyiOoyj6HX5i0JhsuPyjNWxIoU6XZjR+M0I00vgUGzz4K3cq6GBphvylaALi8e
        Q5WAV24XNr/XOLbR+Mr2UD42PUbzF4/vNz1XMr17gAy34SAM1sTRYv6x5BoQtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638390353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rILGDyAzrwQH4d0Fd/HHcQkOPeMa8khVt+2HdznW01Q=;
        b=N3a4nzZm8n5f6SdviSlZVeASD7pY4RVO8YgJHgB0BA+d0FshDK2md2qto/rRPHoVVkqQQI
        bL4r3PvuYgYKnwCA==
To:     Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
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
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
Date:   Wed, 01 Dec 2021 21:25:53 +0100
Message-ID: <87k0go8432.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 11:47, Dave Jiang wrote:
> On 12/1/2021 11:41 AM, Thomas Gleixner wrote:
>>> Hi Thomas. This is actually the IDXD usage for a mediated device passed
>>> to a guest kernel when we plumb the pass through of IMS to the guest
>>> rather than doing previous implementation of having a MSIX vector on
>>> guest backed by IMS.
>> Which makes a lot of sense.
>>
>>> The control block for the mediated device is emulated and therefore an
>>> emulated MSIX vector will be surfaced as vector 0. However the queues
>>> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
>>> running on the guest kernel for the same device.
>> Why? What's wrong with using straight MSI-X for all of them?
>
> The hardware implementation does not have enough MSIX vectors for 
> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS 
> vectors. So if we are to do MSI-X for all of them, then we need to do 
> the IMS backed MSIX scheme rather than passthrough IMS to guests.

Confused. Are you talking about passing a full IDXD device to the guest
or about passing a carved out subdevice, aka. queue?

Thanks,

        tglx
