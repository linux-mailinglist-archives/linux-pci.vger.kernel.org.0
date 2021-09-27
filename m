Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7C41914E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhI0JJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 05:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233598AbhI0JJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 05:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632733673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVP7Xe4ufaNCXcd20wpSSrMBsG9usYiBh4tpjUVxTUI=;
        b=A87jVk+oepUAxtpitt31u+xGVoIIAZhHvRG1ytMIxJ+Evgb5oKfi/FAAY/t0EhtGY2B8lu
        GsmusM22kaoZRJikJg9TYi0PoN98zEYTRM/R/2H1BcIJJCkx8JRF3r39x/pYwXMPCOrKZ5
        1Co2wrNmMfgPWkUPO8PgrqhlcK68OmY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-nCMG6VPTMoit4_ByYFTPng-1; Mon, 27 Sep 2021 05:07:52 -0400
X-MC-Unique: nCMG6VPTMoit4_ByYFTPng-1
Received: by mail-wr1-f71.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so13773468wrd.11
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVP7Xe4ufaNCXcd20wpSSrMBsG9usYiBh4tpjUVxTUI=;
        b=NrID/OF3PH5Rt2oBGkSvES5t9DdmaP5EUvn4GkT1wxDm0QE8bvIC8MMQNxY53dIR7+
         7I7JjFS6q11CNJxYDIkTQORs1PcZqRhwQx4wwf4P1UpYyrjn4ilPkNSQEJsaTUCG7ehd
         JShjokFx6ZaLyiHhmU8YS4jSE0xRW81hEhNRQqSOCEMUpikje47EJy8K6JiiCnzRSSnS
         qLGMyYjDTi8/MbjMO6+6AheWOK8dEFLn++EcNNan4McuTveeDcEaR0wq9ihbi10+88/5
         8y6mKorsNEwVvj0MA4h9Pnvmoo0DLddIzLhAwqG94Y8eB8QTz6RWenudZ1yvfIo0FJBq
         Usbg==
X-Gm-Message-State: AOAM53253rFp6NcXQYeXvfgmNZXhlPT9lbicBlVOe/hGvmJTF4mawmAU
        tqnV8aakUBo7AV0M7A9leoF2CD9/bTegnd/D/Q/8iTporRryDi4+NuhEWyX+9IxGltiAsOSgWpP
        z6VRUd1oL0d6dPuZ6JOig
X-Received: by 2002:a5d:608e:: with SMTP id w14mr26547271wrt.18.1632733670881;
        Mon, 27 Sep 2021 02:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC5dYp72FkeZBf/nNTyOGuT0oOk/w7Q1ed5WCCglQAPy4Z5zq+YWXxX5Bel6h9RljJshmxpg==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr26547249wrt.18.1632733670649;
        Mon, 27 Sep 2021 02:07:50 -0700 (PDT)
Received: from redhat.com ([2.55.16.138])
        by smtp.gmail.com with ESMTPSA id i203sm20492120wma.7.2021.09.27.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:07:49 -0700 (PDT)
Date:   Mon, 27 Sep 2021 05:07:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210927044738-mutt-send-email-mst@kernel.org>
References: <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
 <20210911195006-mutt-send-email-mst@kernel.org>
 <ad1e41d1-3f4e-8982-16ea-18a3b2c04019@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1e41d1-3f4e-8982-16ea-18a3b2c04019@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 03:43:40PM -0700, Andi Kleen wrote:
> 
> > > Hmm, yes that's true. I guess we can make it default to opt-in for
> > > pci_iomap.
> > > 
> > > It only really matters for device less ioremaps.
> > OK. And same thing for other things with device, such as
> > devm_platform_ioremap_resource.
> > If we agree on all that, this will basically remove virtio
> > changes from the picture ;)
> 
> Hi we revisited this now. One problem with removing the ioremap opt-in is
> that it's still possible for drivers to get at devices without going through
> probe. For example they can walk the PCI device list. Some drivers do that
> for various reasons. So if we remove the opt-in we would need to audit and
> possibly fix all that, which would be potentially a lot of churn. That's why
> I think it's better to keep the opt-in.
> 
> 
> -Andi
> 

I've been thinking about why this still feels wrong to me.

Here's what I came up with: at some point someone will want one of these
modules (poking at devices in the initcall) in the encrypted
environment, and will change ioremap to ioremap_shared.
At that point the allowlist will be broken again, and
by that time it will be set in stone and too late to fix.

Isn't the problem that what is actually audited is modules,
but you are trying to add devices to allow list?
So why not have modules/initcalls in the allowlist then?
For built-in modules, we already have initcall_blacklisted, right?
This could be an extension ... no?

-- 
MST

