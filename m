Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE463F5A90
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhHXJM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 05:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235674AbhHXJM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 05:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629796332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
        b=ciI55oT+4ry/YlJLlDbugRTfprdq8vmV8TxkKb01viiPuKkCGhO804W14LS76wuqUuE+pJ
        KfuZCRH8vytOEwSgN/ZVJOTN8ffYpvEEqlTWk9AnsTrzYcdsb0W9dwj/0mW756MhXE+X9y
        cur4x82RiyCts6/Ze32mfLqL6/9yMes=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-_JBNNhvzN6yo8pJqfKopHQ-1; Tue, 24 Aug 2021 05:12:11 -0400
X-MC-Unique: _JBNNhvzN6yo8pJqfKopHQ-1
Received: by mail-ed1-f70.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so10208203edu.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Aug 2021 02:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
        b=LzgWQI1BR6/8gH8/uuJuyW0MW2pPxXZhlejhFlAqtm0L+GobkoarqPPi3BAZo2CAiu
         uLzsZcQGWmM1CcCouQJ4euI8qxe0yS9/zs51vX6/ANU5Ss+5oZGghe2d1TuUeko34mKP
         Q8x3GjeCBCGoo8c362ATcybjNpxnsn6x5VEvH48MpFNxgldbwUItO9Bfjnm3zaWsjM13
         EWSpmoOhK0vsI1eAJA6UAf5Vs6gfkMZw1MUnx2oATU556zMQe7ygH8P4+5Hz6Lob9TAG
         5J5/DSV6W1swVQdAcZ36f6C0qFdESjGniMdT7H5/yp2RWQgEY7ZO4He6FF0EYw8kL0JH
         z5yA==
X-Gm-Message-State: AOAM5309GFFCDd/llLqjWrn8vZHEK+38vR3KH1+ygf4AppHoq24k2vic
        d3d+K3/SVLOl7Pwqcn1ngJpKnTf6/RCpF50P1Dw3kubmZ6dlMLU8ttL9doruPXMMw8x1O0G9fma
        k0JHykLqVO/v0Pljs4qjG
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr39905071ejp.520.1629796330482;
        Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3bMICaqu3WLm0C02mi3EAPqHyfBIAeSrxUN0aqhXmoBEhQ7Pz6k5PO9S6BLCHr/N7T4Bnvg==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr39905053ejp.520.1629796330344;
        Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id b18sm2737239ejl.90.2021.08.24.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:12:09 -0700 (PDT)
Date:   Tue, 24 Aug 2021 05:12:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210824050842-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> > > Add a new variant of pci_iomap for mapping all PCI resources
> > > of a devices as shared memory with a hypervisor in a confidential
> > > guest.
> > > 
> > > Signed-off-by: Andi Kleen<ak@linux.intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
> 
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

I can't say this answers the question at all. PCI devices are part of
the VMM and so un-trusted. In particular PCI devices do not have
the key to decrypt memory. Therefore as far as I can see PCI resources
should not be encrypted.  I conclude they all should be marked
shared.

If I'm wrong can you please give an example of a PCI resource
that is encrypted?

-- 
MST

