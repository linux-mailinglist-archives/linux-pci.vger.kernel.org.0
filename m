Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2467D7DC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAZVlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 16:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZVlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 16:41:50 -0500
X-Greylist: delayed 21416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 13:41:48 PST
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB42197B;
        Thu, 26 Jan 2023 13:41:47 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5F23930000CFD;
        Thu, 26 Jan 2023 22:41:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 42A8D2B0CE5; Thu, 26 Jan 2023 22:41:46 +0100 (CET)
Date:   Thu, 26 Jan 2023 22:41:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
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
Message-ID: <20230126214146.GA28774@wunner.de>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
 <20230126154449.GB4188@wunner.de>
 <20230126112058-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126112058-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 11:25:21AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 26, 2023 at 04:44:49PM +0100, Lukas Wunner wrote:
> > Obviously the host can DoS guest access to the device by modifying
> > exchanged messages, but there are much simpler ways for it to
> > do that, say, by clearing Bus Master Enable or Memory Space Enable
> > bits in the Command Register.
> 
> There's a single key per guest though, isn't it? Also used
> for regular memory?

The current design is to have a global keyring (per kernel, i.e. per
guest).  A device presents a certificate chain and the first certificate
in that chain needs to be signed by one of the certificates on the keyring.

This is completely independent from the key used for memory encryption.

A device can have up to 8 certificate chains (called "slots" in the
SPDM spec) and I've implemented it such that all slots are iterated
and validation is considered to be successful as soon as a slot with
a valid signature is found.

We can discuss having a per-device keyring if anyone thinks it makes
sense.

The PCISIG's idea seems to be that each vendor of PCIe cards publishes
a trusted root certificate and users would then have to keep all those
vendor certificates in their global keyring.  This follows from the
last paragraph of PCIe r6.0.1 sec 6.31.3, which says "it is strongly
recommended that authentication requesters [i.e. the kernel] confirm
that the information provided in the Subject Alternative Name entry
[of the device's leaf certificate] is signed by the vendor indicated
by the Vendor ID."

The astute reader will notice that for this to work, the Vendor ID
must be included in the trusted root certificate in a machine-readable
way.  Unfortunately the PCIe Base Spec fails to specify that.
So I don't know how to associate a trusted root certificate with a
Vendor ID.

I'll report this and several other gaps I've found in the spec to the
editor at the PCISIG so that they can be filled in a future revision.

Thanks,

Lukas
