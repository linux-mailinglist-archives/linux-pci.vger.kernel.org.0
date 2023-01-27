Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D590C67DE63
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 08:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjA0HR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 02:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjA0HRz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 02:17:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADBB113F8
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 23:17:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so4106587wrm.4
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 23:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu8F0YryLt/OgLyDbyT+COsXBWZJ+zCIx+ZWtC5IKkg=;
        b=WGY7E/PSjYEz982lSPv35cpucEGupEadtERlumDXtX8XKQL1ufwwK8jq1WeP0lRpj7
         yvTrhd3+v8b/ZVucRajffMcKWHm1L1k7Dats/WD17n4S1Dxx6Bb8JLxFajnEfHcRHaU7
         UPo/mJTsx7izz4mLpE95UWikJKc0ZFJijx1tfWVRJ/NrlFgoUEs2+qvEjq8HzgRc7tBA
         Tcq9KWlx08MRHTkwySZvNQ5X37m497rbR/NuBNYm6xZOo3JQdwdouGLRKA4dCcVP/qgG
         gBzOjNqThoUBnFSw0xHp0ddueyP9+5QEkONaBmxtJerDTpPI61wQnSLkXk7mZeE15jIW
         SG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu8F0YryLt/OgLyDbyT+COsXBWZJ+zCIx+ZWtC5IKkg=;
        b=HMb6uTtCF17oO30G9oRE8hKfuQvsf8jaagvpxsajK4Nzjq5aB5qvg89ez1iYiFiRXs
         9rwNKctQpsu7mOtrBw8kFB2vHbCmKMAuFS7nmBd0iG9n57eoQRcG9Ju+FiER/JlV0jWs
         hy0dcvDbu4I3YamfgfyFzGmp4a2ZnIZJdZEOnjIxagB+oomWbIWVBKyj/mIioV0uvxGF
         FNA53ca241GZ7HPk3TR8BCQQA16pK+OJGbu3fAhVwg42Nak/xhP/CKsJEL+tqkC0tDYY
         mqNvt7XCQVQw2FBqLKt0knL+nMA+8SvH7P6NQcoeB3Keer+gYp8y8+b0YsJgIJfcNLED
         v9/Q==
X-Gm-Message-State: AO0yUKXeQ4R2VxEijdxthVYae7ij3XFPJrbjRIDr9RUfJ52TUXFWU7aV
        OhZLg8gWeKTQYmalFeZmVBljFA==
X-Google-Smtp-Source: AK7set+B3n3giZrrrzvhrZe5kohk1pMxsQkkUJJDZp8hEVRVSrL+hCD+foHS8sR4KeguBUH965OCDw==
X-Received: by 2002:adf:f7cd:0:b0:2bf:d511:18a9 with SMTP id a13-20020adff7cd000000b002bfd51118a9mr858226wrq.29.1674803871740;
        Thu, 26 Jan 2023 23:17:51 -0800 (PST)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d43cd000000b0027cb20605e3sm3272136wrr.105.2023.01.26.23.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:17:51 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:17:48 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9N6nP+Z67TnEaMa@vermeer>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
 <20230126154449.GB4188@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126154449.GB4188@wunner.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 04:44:49PM +0100, Lukas Wunner wrote:
> On Thu, Jan 26, 2023 at 10:24:32AM +0100, Samuel Ortiz wrote:
> > On Wed, Jan 25, 2023 at 11:03 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> > >
> > > https://github.com/l1k/linux/commits/doe
> > > 
> > > The device authentication service afforded here is generic.
> > > It is up to users and vendors to decide how to employ it,
> > > be it for "confidential computing" or something else.
> > >
> > > Trusted root certificates to validate device certificates can be
> > > installed into a kernel keyring using the familiar keyctl(1) utility,
> > > but platform-specific roots of trust (such as a HSM) could be
> > > supported as well.
> > 
> > This may have been discussed at LPC, but are there any plans to also
> > support confidential computing flows where the host kernel is not part
> > of the TCB and would not be trusted for validating the device cert chain
> > nor for running the SPDM challenge?
> 
> As long as a device is passed through to a guest, the guest owns
> that device.  

I agree. On a SRIOV setup, the host typically owns the PF and assigns
VFs to the guests. Devices must be enlightened to guarantee that once
one of their VFs/interfaces is passed to a trusted VM, it can no longer
be modified by anything untrusted (e.g. the hypervisor).

> It is the guest's prerogative and duty to perform
> CMA/SPDM authentication on its own behalf.  If the guest uses
> memory encryption via TDX or SEV, key material established through
> a Diffie-Hellman exchange between guest and device is invisible
> to the host.  Consequently using that key material for IDE encryption
> protects device accesses from the guest against snooping by the host.

On confidential computing platforms where a security manager (e.g.
Intel TDX module) manages the confidential guests, the IDE key
management and stream settings would be handled by this manager. In
other words, the SPDM requester would not be a Linux kernel.
FWIW, Intel recently published an interesting description of TEE-IO
enabling with TDX [1].

> SPDM authentication consists of a sequence of exchanges, the first
> being GET_VERSION.  When a responder (=device) receives a GET_VERSION
> request, it resets the connection and all internal state related to
> that connection.  (SPDM 1.2.1 margin no 185: "a Requester can issue
> a GET_VERSION to a Responder to reset a connection at any time";
> see also SPDM 1.1.0 margin no 161 for details.)
> 
> Thus, even though the host may have authenticated the device,
> once it's passed through to a guest and the guest performs
> authentication again, SPDM state on the device is reset.
> 
> I'll amend the patches so that the host refrains from performing
> reauthentication as long as a device is passed through.  The host
> has no business mutating SPDM state on the device once ownership
> has passed to the guest.
> 
> The first few SPDM exchanges are transmitted in the clear,
> so the host can eavesdrop on the negotiated algorithms,
> exchanged certificates and nonces.  However the host cannot
> successfully modify the exchanged data due to the man in the middle
> protection afforded by SPDM:  The challenge/response hash is
> computed over the concatenation of the exchanged messages,
> so modification of the messages by a man in the middle leads
> to authentication failure.

Right, I was not concerned by the challenge messages integrity but by
trusting the host with verifying the response and validating the device
cert chains.

> Obviously the host can DoS guest access to the device by modifying
> exchanged messages, but there are much simpler ways for it to
> do that, say, by clearing Bus Master Enable or Memory Space Enable
> bits in the Command Register.  DoS attacks from the host against
> the guest cannot be part of the threat model at this point.

Yes, the host can DoS the guest at anytime it wants and in multiple
ways. It's definitely out of the confidential computing thread model at
least.

Cheers,
Samuel.

[1] https://cdrdv2-public.intel.com/742542/software-enabling-for-tdx-tee-io-fixed.pdf

