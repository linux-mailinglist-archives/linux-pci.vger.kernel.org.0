Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2DF461879
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 15:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377952AbhK2Obu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 09:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348983AbhK2O3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 09:29:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEEC0048D8;
        Mon, 29 Nov 2021 05:04:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638191084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrMx0EikLor0m9R8RMLCsVyJFUvZ7DWG9Nt3FfGUjHw=;
        b=Z5w7/WyffNWkPpVy2OwqkWVdnch2IT/5obz3VzycGQuRvXEK+12h3jDmVBGCq36Z9VreAI
        JkirRTFU2cf9EKwPVMGPoO6yKJO0iKAi3l0aAJfgQXDjIypVGvr8EQsZyWoPztdjN3AWR2
        JEhcakuIYe/1waQNlHLU5WkmdTtbVrIPo0U5bcLxCa5QHza++5ccIYlzf/i1crGIC56f2a
        vxfdI6Q3oY8ziLmra6HLeBWIemaiUiSSnje2qAYh0n1/IJu573hE55d3ZXxhfVQoXelytq
        DV7UDSkDtPhOgMXRXxvGyPfBqqoEix6Na23ZzxT136Ay7DPkAiwi0eaLHmPA+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638191084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrMx0EikLor0m9R8RMLCsVyJFUvZ7DWG9Nt3FfGUjHw=;
        b=uFEsq4VQIKwpP4IPvBxJj7CH5oO01savZVSv+qKxq28D2EkgSK+FTImT6+XanOuO6wpsZf
        XOQtUeHRkXGYnuBQ==
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 14/32] s390/pci: Rework MSI descriptor walk
In-Reply-To: <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.130164978@linutronix.de>
 <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
Date:   Mon, 29 Nov 2021 14:04:43 +0100
Message-ID: <87fsrfdses.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Niklas,

On Mon, Nov 29 2021 at 11:31, Niklas Schnelle wrote:
> On Sat, 2021-11-27 at 02:23 +0100, Thomas Gleixner wrote:
>
> while the change looks good to me I ran into some trouble trying to
> test it. I tried with the git repository you linked in the cover
> letter:
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-3
>
> But with that I get the following linker error on s390:
>
> s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_setup_msi_irqs':
> /home/nschnelle/mainline/drivers/pci/msi/legacy.c:72: undefined reference to `msi_device_populate_sysfs'
> s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_teardown_msi_irqs':
> /home/nschnelle/mainline/drivers/pci/msi/legacy.c:78: undefined reference to `msi_device_destroy_sysfs'
> make: *** [Makefile:1161: vmlinux] Error 1

Yes, that got reported before and I fixed it locally already.

> This is caused by a misspelling of CONFIG_PCI_MSI_ARCH_FALLBACKS
> (missing the final S) in kernel/irq/msi.c. With that fixed everything
> builds and MSI IRQs work fine. So with that fixed you have my
>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for testing and dealing with my ineptness.

       tglx
