Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F44625DC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhK2WoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhK2Wnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:43:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0624CC043AD8;
        Mon, 29 Nov 2021 12:51:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638219071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tz/JDx8g54Ok4OMBliMP1MHdAMZdu38KyT07rgK4kek=;
        b=EJHYdtcQ7CkIX5jk0EPaQKBNxB/I4Fmx4psc3dNfeVrvTFpfEeqts20BFVbt5PAcORMNHi
        YmEYN7qu9o9Nf+xrWi1DDTWj8DqHrD/TaMw5SFkbD9O9fYe/B4c4CovKJtoayoJFBLXFhN
        h1GDxLrYh/zoeCY8+4MzczVeqOnc/INyFI9/5AX3gUiOfVu22C1ifU4McFVa8VwqLko/cL
        R/kEgQCcjhyb30qp4KynvMsylSgqwoxDEXZFQey00qSiM47Wq3tkv0cLqJ0EqVtA/e+0Fv
        AngN+lIgcGkoPC0smzvCoXGvs5qyyndto5EVdLqns8n0Bo2OfZztMwHgnyLp/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638219071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tz/JDx8g54Ok4OMBliMP1MHdAMZdu38KyT07rgK4kek=;
        b=sVqzZBKzTnDKRGPDAdt0lfSw7znG5ecBJX8UUs+ZB5r69qdnSChYv4MKQc8kplV1rgOuob
        O5RAPkes0fGbEIBg==
To:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
Date:   Mon, 29 Nov 2021 21:51:10 +0100
Message-ID: <874k7ueldt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan,

On Mon, Nov 29 2021 at 11:21, Logan Gunthorpe wrote:
> On 2021-11-26 6:23 p.m., Thomas Gleixner wrote:
>> Replace the about to vanish iterators, make use of the filtering and take
>> the descriptor lock around the iteration.
>
> This patch looks good to me:
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

thanks for having a look at this. While I have your attention, I have a
question related to NTB.

The switchtec driver is the only one which uses PCI_IRQ_VIRTUAL in order
to allocate non-hardware backed MSI-X descriptors.

AFAIU these descriptors are not MSI-X descriptors in the regular sense
of PCI/MSI-X. They are allocated via the PCI/MSI mechanism but their
usage is somewhere in NTB which has nothing to do with the way how the
real MSI-X interrupts of a device work which explains why we have those
pci.msi_attrib.is_virtual checks all over the place.

I assume that there are other variants feeding into NTB which can handle
that without this PCI_IRQ_VIRTUAL quirk, but TBH, I got completely lost
in that code.

Could you please shed some light on the larger picture of this?

Thanks,

        tglx
