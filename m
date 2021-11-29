Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A225D461D6F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbhK2SUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349599AbhK2SSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 13:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95423C0698FC;
        Mon, 29 Nov 2021 06:46:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638197160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moCVXIgDd3WnVTqImBDpITWvvySrFpXIFP1kWeQJHKU=;
        b=3S6nmBadZg5tSz0rZHXEDZM40jhTHe/7y2CLs37JoDJvOsqgG2cw7AFkhZmO3IdHZkuU9R
        pVQt9YCIdmL3mqxv0ggmb01VmoCUbHZRd64fJZOBgy3p6qf0yt+N3IeVkNZOmjc2ffHdBW
        Fe3cKz/hyz3coikXPRJojbmAf8pnQXCKIifn18l8SAPBIAtd++qZL7lcd2GUQ43ReBZSSb
        YEaX4dZnsyMGt030d1oeJE78U9xH9MpjyOlXGXYTOBLeSTyHK/p9iuz/Yv3815hL8aqm+X
        NprgrTl+hvQHD/9Rby3+aV+xzNqCHnMwOelYZ23ZX4e7euce2B93n/AvKumo8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638197160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moCVXIgDd3WnVTqImBDpITWvvySrFpXIFP1kWeQJHKU=;
        b=vkhx9Uk6Dv9aGqVVDjVmHZWJ3IWDihE7siFS7bF7kSJaV33N0jk920aDAUwoTwmfFwotsF
        Cg8b0iVzhVwufjCA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
In-Reply-To: <20211129140112.GX4670@nvidia.com>
References: <877dcsf5l5.ffs@tglx> <87o863e2j0.ffs@tglx>
 <20211129140112.GX4670@nvidia.com>
Date:   Mon, 29 Nov 2021 15:46:00 +0100
Message-ID: <87a6hndnpz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Mon, Nov 29 2021 at 10:01, Jason Gunthorpe wrote:
> On Mon, Nov 29, 2021 at 10:26:11AM +0100, Thomas Gleixner wrote:
>> After looking at all the call sites again, there is no real usage for
>> this local index variable.
>> 
>> If anything needs the index of a descriptor then it's available in the
>> descriptor itself. That won't change because the low level message write
>> code needs the index too and the only accessible storage there is
>> msi_desc.
>
> Oh, that makes it simpler, just use the current desc->index as the
> input to the xa_for_each_start() and then there should be no need of
> hidden state?

That works for alloc, but on free that's going to end up badly.

>> What for? The usage sites should not have to care about the storage
>> details of a facility they are using.
>
> Generally for_each things shouldn't have hidden state that prevents
> them from being nested. It is just an unexpected design pattern..

I'm not seeing any sensible use case for:

     msi_for_each_desc(dev)
        msi_for_each_desc(dev)

If that ever comes forth, I'm happy to debate this further :)

Thanks,

        tglx
