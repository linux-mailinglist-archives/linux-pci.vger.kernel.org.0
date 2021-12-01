Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA88B4655A8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352509AbhLASlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352340AbhLASlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 13:41:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B779C061574;
        Wed,  1 Dec 2021 10:37:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638383853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7J5pGHISXVsNZNvGx6mpaYhl7xzevUiJitTR5UpWPA=;
        b=nXMiRjaWR5qkGWVkLcb7JzMSEc8jFnVTBJBxs5BAr/rzjwg1mxDd18AHnquIhO1Bbktgss
        00SW2eHGQ7XOjLz8/YhAOAEKbkbCiXnqUxUq3GPVUXc0C5pa6p2BV0dBrrGD/WRdMLfxgU
        ME5xdmJBt+5DnQVpwjh5Y2lLKsiFvK5cNvbr20h6fnz0Jur2aA6cr6xbKPMIExqPKe4m0J
        6r+x3TnQtFs8pzBkUYRRh92e78xrnuYFrvel/ek1kdk3dADK/4rzq/2bvnM97RCiG+yZtP
        FjCjCMQ/RjiK7Zyx68MV0PY1T7qxJmW7foQLiSEStMiB4Ol116bPT7Vt52qxZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638383853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7J5pGHISXVsNZNvGx6mpaYhl7xzevUiJitTR5UpWPA=;
        b=7qU/ADXX07JjghqsbjrGWWs0xyLEPsvwVOtt8SXjTg1yrPSBq2+9pCwcJeLgaVEbrn7j/7
        LjN3RVxOZ5B+MvAw==
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
In-Reply-To: <20211201151121.GL4670@nvidia.com>
References: <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <871r2w9y3x.ffs@tglx> <20211201151121.GL4670@nvidia.com>
Date:   Wed, 01 Dec 2021 19:37:32 +0100
Message-ID: <87sfvc893n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 11:11, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 03:52:02PM +0100, Thomas Gleixner wrote:
>> So we really can go and create a MSI irqdomain and stick the pointer
>> into stdev->dev.irqdomain. The parent domain of this irqdomain is
>> 
>>      stdev->pdev.dev.irqdomain->parent
>
> It can work (pending some solution to the iommu stuff), but IMHO it is
> strange/hacky to put HW objects like irqdomain on what is a character
> struct device with a set major/minor in dev->devt and associated
> struct cdev.
>
> Conceptually it makes no sense to me, cdevs are software constructs,
> they should never go into HW areas..

I picked that because it _is_ already used to establish the connection
to the switchtec_class NTB driver which is beyond the usual cdev muck.

Thanks,

        tglx
