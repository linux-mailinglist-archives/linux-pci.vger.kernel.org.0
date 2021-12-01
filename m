Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DAD46571B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352991AbhLAUaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbhLAUaL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:30:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4F4C061574;
        Wed,  1 Dec 2021 12:26:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638390408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9iFHbC8vXSahbGhWk+99dygWsu4VzQjJs9HViZs2rMo=;
        b=X5oW6RyQIgtTBoLZDk5CfA+uzuP0ey6oo1pGzY+IscAXL89y3Sjn1bi4vAYyYBieiuY3/K
        F7gSwDAljg9nTH9ECOZ7nXkXA808XjF6H2Lm1eQoQuIlgihk6wx02ESNBx7zejI26w7a6l
        k3vutN8wnXUMFpKw2LaQGelQVhpSu3NgT3YFfXNluw/zMV1Dne3jpuZTe8NG2Mzyd5ma+F
        blVsCgHszhNnizFd4RppbXlmKaKwC7pNcO5LUG//limyix5YFu8k49V7wr3O9/cJ22AjeX
        Q+fjCsZDBvzyLrICxko0ABOcUIfPTLA2Iug2LwPnx7MxSr8X5v9NvEJy9kohtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638390408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9iFHbC8vXSahbGhWk+99dygWsu4VzQjJs9HViZs2rMo=;
        b=CRizFADOFzc1+eC64/quP0E3Wa3OCcWn3njB8JD9fmlAhMM4tDLFf9Es4vSez6+s+jf5e8
        M9i0vGWCFczFO5DA==
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
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211201184726.GN4670@nvidia.com>
References: <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <871r2w9y3x.ffs@tglx> <20211201151121.GL4670@nvidia.com>
 <87sfvc893n.ffs@tglx> <20211201184726.GN4670@nvidia.com>
Date:   Wed, 01 Dec 2021 21:26:47 +0100
Message-ID: <87h7bs841k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 14:47, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 07:37:32PM +0100, Thomas Gleixner wrote:
>> I picked that because it _is_ already used to establish the connection
>> to the switchtec_class NTB driver which is beyond the usual cdev muck.
>
> IMHO that is also a misuse. These days two drivers should be hooked
> together using an aux device, not a cdev and the obscure
> class_interface stuff. Aux device supports auto probing and module
> auto loading for instance.
>
> An interrupt on an aux device is at least somewhat conceptually
> parallel to an interrupt on a mdev as both are usually representing
> some slice of a device.

No argument about that.
