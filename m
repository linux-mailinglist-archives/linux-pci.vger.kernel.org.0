Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1E67D088
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjAZPoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjAZPoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:44:54 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708430C6;
        Thu, 26 Jan 2023 07:44:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C410030000D22;
        Thu, 26 Jan 2023 16:44:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A4E1D261AB3; Thu, 26 Jan 2023 16:44:49 +0100 (CET)
Date:   Thu, 26 Jan 2023 16:44:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Samuel Ortiz <sameo@rivosinc.com>
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
Message-ID: <20230126154449.GB4188@wunner.de>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 10:24:32AM +0100, Samuel Ortiz wrote:
> On Wed, Jan 25, 2023 at 11:03 PM Lukas Wunner <lukas@wunner.de> wrote:
> > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> >
> > https://github.com/l1k/linux/commits/doe
> > 
> > The device authentication service afforded here is generic.
> > It is up to users and vendors to decide how to employ it,
> > be it for "confidential computing" or something else.
> >
> > Trusted root certificates to validate device certificates can be
> > installed into a kernel keyring using the familiar keyctl(1) utility,
> > but platform-specific roots of trust (such as a HSM) could be
> > supported as well.
> 
> This may have been discussed at LPC, but are there any plans to also
> support confidential computing flows where the host kernel is not part
> of the TCB and would not be trusted for validating the device cert chain
> nor for running the SPDM challenge?

As long as a device is passed through to a guest, the guest owns
that device.  It is the guest's prerogative and duty to perform
CMA/SPDM authentication on its own behalf.  If the guest uses
memory encryption via TDX or SEV, key material established through
a Diffie-Hellman exchange between guest and device is invisible
to the host.  Consequently using that key material for IDE encryption
protects device accesses from the guest against snooping by the host.

SPDM authentication consists of a sequence of exchanges, the first
being GET_VERSION.  When a responder (=device) receives a GET_VERSION
request, it resets the connection and all internal state related to
that connection.  (SPDM 1.2.1 margin no 185: "a Requester can issue
a GET_VERSION to a Responder to reset a connection at any time";
see also SPDM 1.1.0 margin no 161 for details.)

Thus, even though the host may have authenticated the device,
once it's passed through to a guest and the guest performs
authentication again, SPDM state on the device is reset.

I'll amend the patches so that the host refrains from performing
reauthentication as long as a device is passed through.  The host
has no business mutating SPDM state on the device once ownership
has passed to the guest.

The first few SPDM exchanges are transmitted in the clear,
so the host can eavesdrop on the negotiated algorithms,
exchanged certificates and nonces.  However the host cannot
successfully modify the exchanged data due to the man in the middle
protection afforded by SPDM:  The challenge/response hash is
computed over the concatenation of the exchanged messages,
so modification of the messages by a man in the middle leads
to authentication failure.

Obviously the host can DoS guest access to the device by modifying
exchanged messages, but there are much simpler ways for it to
do that, say, by clearing Bus Master Enable or Memory Space Enable
bits in the Command Register.  DoS attacks from the host against
the guest cannot be part of the threat model at this point.

Thanks,

Lukas
