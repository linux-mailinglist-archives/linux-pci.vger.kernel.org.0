Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC2469AF0
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348485AbhLFPLx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 10:11:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348028AbhLFPJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 10:09:51 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DFKQyDJzCq+mYQ4+RqEzYuEHbWxZbUzi+iE4nicGGk=;
        b=xjheNe0r00mefgEAfeh0NfIOC10o4cEVd0lHlR9g5sO1j/Am2HEeg1glaoSsDM0SpK/rUs
        jNV8s5Thc++G62jsHUxPPkA8QSc9+VxFPCl6lGcvt2hvrRGWXgsEko2DgLKFncSJplt2tX
        jA0W7IBgusGmSyd0A3OlWxVn21edi9lm5YSGfmI9yePehpHHli3nQi3riDWMwe9DA5ijJq
        TBL/d7RKGs2GJoDpug1MCqRUq17Rg3mUC9Kn9UkGWM3GWcFVGusxzdc4qa+IOxm7nwaenL
        zCAk/erK6Pz91WUHf4M584ulEQmKUpREQvllbElpUTC+IkWX/ZsnpLPdYMIUdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DFKQyDJzCq+mYQ4+RqEzYuEHbWxZbUzi+iE4nicGGk=;
        b=jx9TJD418UmzxHtiaJhWrn9vJKP8dB7Crk/q/a/U3wDTaJXTw+tAxd8JTUzTh5y8n3ri++
        AEyviiCwJ4Ahj4DA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206141922.GZ4670@nvidia.com>
References: <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com> <87v9044fkb.ffs@tglx>
 <20211206141922.GZ4670@nvidia.com>
Date:   Mon, 06 Dec 2021 16:06:20 +0100
Message-ID: <87lf0x4vtf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Mon, Dec 06 2021 at 10:19, Jason Gunthorpe wrote:
> On Sat, Dec 04, 2021 at 03:20:36PM +0100, Thomas Gleixner wrote:
>> even try to make the irqchip/domain code mangled into the other device
>> code. It should create the irqdomain with the associated chip and that
>> creation process returns a cookie which is passed to the actual device
>> specific code. Allocation then can use that cookie and not the irqdomain
>> pointer itself.
>
> Sounds like your cookie == my msi_table? Maybe we are all agreeing at
> this point then?

I think so. It's going to be something the driver can use as a
reference. Same for the actual interrupt allocated through this domain
reference.

>> So thanks for being patient in educating me here.
>
> I'm happy you got something out of all these words!

Definitely so. That's why we are having these discussions, right?

The shiny irq subsystem is not so shiny when the drivers cannot use
it. OTOH, it's often enough the case that driver folks want to use it
the wrong way just because.

> Yes, it is amazing how many patches this is at already.

Don't worry. You'll get a few more patch bombs in your inbox until IMS
is supported, unless you want to be "unsubscribed".

Thanks,

        tglx
