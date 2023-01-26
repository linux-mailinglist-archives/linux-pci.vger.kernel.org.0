Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9167CBDF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjAZNQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 08:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjAZNQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 08:16:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8DD6950C
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 05:15:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k16so1096792wms.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7tibHebF6ZauGL5pfstUMzuHlaHPTu6BQgaBx8ckrc=;
        b=7EfVrdzyUspfb7vVyyBAIkHsRcwRioUW6hvNJhTFw+pj7ajI+ASFXNW7RTL3FJnrc/
         RYr3E6qyaDFb5gIaThccYaLM4KGlodrhgGatkOfSgx62QxyQPbSOghDigThO9eu7ldNx
         OGuTlaK7u9lvPBlH1ao66j7degN6N001qwl0B14+JeFT29Odx2qRjCxC+I924GYTsFV2
         DRpWqGuhoH4y8CYhknpvZ8tIank3hbOsB0DNA69N18FMeDARHaD+6/OGjnVruJkwv+ea
         OCz0Cp/7ryhpZ1aC13ekOHhk23frigljtXco03D16e/7RpXmF+L+s5M5+gfiqiDwbuP3
         gPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7tibHebF6ZauGL5pfstUMzuHlaHPTu6BQgaBx8ckrc=;
        b=zUpzn5NKMtRCVeQ/teREFzY1H5kcwhWvMr/whcZY4k1S6PryQOJz2ApFeX+vPRz0KM
         FvLZ0/rwP+rA0JMS4WfrNVIJWKTJYdMjOm1M+7Ad9VRmHE0AS+CThbg63rgkqxa9VbSb
         GF//1RnIowAcB6+2QKJx2PblPDfOHT7jl+vwftd9hselisQJvnk5Qw0DDqlym6+xa7Z/
         VPE5BXfeCWmEBAXjpV6Biw3GmghGP9KYHm++Zq+Xi5CWvLvEALU+VMZXGY9MCqb5l6NS
         64XAYeL8qN3XZ40PDfQoCvIAc3ncmFz30EyZaYXFeSHQF3dweIl2R3erpfEpM9L7ui/n
         PE7g==
X-Gm-Message-State: AFqh2kp/uE4A32TREprvVkiVils3xSGImJIb5z5CODBMIO3VANKBYeXK
        qO1NWJKO8u74mQYQMKmBpsETWw==
X-Google-Smtp-Source: AMrXdXtgdC+Ay80q6NvcJ2uYQ2vES6hU8gFLX3kKKlouDa/dgw3eksiChbWAlIFeWjhZmLn2/VwZ/g==
X-Received: by 2002:a05:600c:c05:b0:3db:3476:6f02 with SMTP id fm5-20020a05600c0c0500b003db34766f02mr22503172wmb.41.1674738908116;
        Thu, 26 Jan 2023 05:15:08 -0800 (PST)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm5300210wmn.11.2023.01.26.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:15:07 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:15:05 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9J82eutqDkusRIq@vermeer>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
 <20230126105847.00001b97@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126105847.00001b97@Huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 10:58:47AM +0000, Jonathan Cameron wrote:
> On Thu, 26 Jan 2023 10:24:32 +0100
> Samuel Ortiz <sameo@rivosinc.com> wrote:
> 
> > Hi Lukas,
> > 
> > On Wed, Jan 25, 2023 at 11:03 PM Lukas Wunner <lukas@wunner.de> wrote:
> > 
> > > [cc += Jonathan Cameron, linux-pci]
> > >
> > > On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:  
> > > > Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:  
> > > > > Great, so why not have hardware attestation also for your devices you
> > > > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > > > worry about anything in the guest.  
> > > >
> > > > There were some talks at Plumbers where PCIe is working on adding that;
> > > > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > > > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > > > SPDM.   I don't know much of the detail of those, just that they're far
> > > > enough off that people aren't depending on them yet.  
> > >
> > > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> > >
> > > https://github.com/l1k/linux/commits/doe  
> > 
> > Nice, thanks a lot for that.
> > 
> > 
> > 
> > > The device authentication service afforded here is generic.
> > > It is up to users and vendors to decide how to employ it,
> > > be it for "confidential computing" or something else.
> > >
> > > Trusted root certificates to validate device certificates can be
> > > installed into a kernel keyring using the familiar keyctl(1) utility,
> > > but platform-specific roots of trust (such as a HSM) could be
> > > supported as well.
> > >  
> > 
> > This may have been discussed at LPC, but are there any plans to also
> > support confidential computing flows where the host kernel is not part
> > of the TCB and would not be trusted for validating the device cert chain
> > nor for running the SPDM challenge?
> 
> There are lots of possible models for this. One simple option if the assigned
> VF supports it is a CMA instance per VF. That will let the guest
> do full attestation including measurement of whether the device is
> appropriately locked down so the hypervisor can't mess with
> configuration that affects the guest (without a reset anyway and that
> is guest visible). 

So the VF would be directly assigned to the guest, and the guest kernel
would create a CMA instance for the VF, and do the SPDM authentication
(based on a guest provided trusted root certificate). I think one
security concern with that approach is assigning the VF to the
(potentially confidential) guest address space without the guest being
able to attest of the device trustworthiness first. That's what TDISP is
aiming at fixing (establish a secure SPDM between the confidential guest
and the device, lock the device from the guest, attest and then enable
DMA). 

> Whether anyone builds that option isn't yet clear
> though. If they do, Lukas' work should work there as well as for the
> host OS. (Note I'm not a security expert so may be missing something!)
> 
> For extra fun, why should the device trust the host? Mutual authentication
> fun (there are usecases where that matters)
> 
> There are way more complex options supported in PCIe TDISP (Tee Device
> security interface protocols). Anyone have an visibility of open solutions
> that make use of that? May be too new.

It's still a PCI ECN, so quite new indeed.
FWIW the rust spdm crate [1] implements the TDISP state machine.

Cheers,
Samuel.

[1] https://github.com/jyao1/rust-spdm
> 
