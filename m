Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93394463ECF
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhK3Tv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 14:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhK3Tv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 14:51:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1CC061574;
        Tue, 30 Nov 2021 11:48:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638301684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PGGF31MvMk64+aUTPz1Do+PDXuwrIRZVKdbxPEpPtA=;
        b=ImCfCdMo1PZpLtuIcF6Rj5ARB8ef5RpenBUExBPbXPPr+8bN9WMYe4oyt1V4pCd0eCwN6e
        yHAt2OGCqmdRALT7Rt5mVmF534yWoBhld2/cUnq8cIxN0bBcStG5lHwFuq5h6eB5gCO9mg
        kFhn2MyDRC1yvdkmtfzSZqJNOndrH/kwWAdO0jQjUzP/oyzIUxxzJI53RK8fASv+Swd7+/
        J2Qd7JWTh3Sh2KH0q5ntBjnDt1ZXTv2XZyf/XZWHuMjwM48GVfslEfWoDb3MDwQB2EHQrz
        ifVBxZe85gLpvLrRPyyUORzxQV+aO2d8xqChM+3OXVrAPpvkkot7mRcYqZAo6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638301684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PGGF31MvMk64+aUTPz1Do+PDXuwrIRZVKdbxPEpPtA=;
        b=d9drm8P01nreGyeEJWDqg3F3BtYVO2MXSzMAs0qxXvVlrbJwPISqszjuUxq9r0HtVKZ/dN
        0rB0UDfOIfUbDyDQ==
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
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
Date:   Tue, 30 Nov 2021 20:48:03 +0100
Message-ID: <87v909bf2k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan,

On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
> On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>> I'm way too tired to come up with a proper solution for that, but that
>> PCI_IRQ_VIRTUAL has to die ASAP.
>
> I'm willing to volunteer a bit of my time to clean this up, but I'd need
> a bit more direction on what a proper solution would look like. The MSI
> domain code is far from well documented nor is it easy to understand.

Fair enough. I'm struggling with finding time to document that properly.

I've not yet made my mind up what the best way forward for this is, but
I have a few ideas which I want to explore deeper.

But the most important question is right now on which architectures
these switchtec virtual interrupt things are used.

If it's used on any architecture which does not use hierarchical
irqdomains for MSI (x86, arm, arm64, power64), then using irqdomains is
obviously a non-starter unless falling back to a single interrupt would
not be considered a regression :)

Thanks,

        tglx
