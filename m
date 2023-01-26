Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267267C9CC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjAZLYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAZLYV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 06:24:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24DD62250;
        Thu, 26 Jan 2023 03:24:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2dcc6zs0z67PMg;
        Thu, 26 Jan 2023 19:23:28 +0800 (CST)
Received: from localhost (10.81.202.191) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 11:24:13 +0000
Date:   Thu, 26 Jan 2023 11:24:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "Cfir Cohen" <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "James Morris" <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230126112412.000006d9@Huawei.com>
In-Reply-To: <Y9Jakvab14K61b2t@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
        <Y9EkCvAfNXnJ+ATo@kroah.com>
        <Y9Ex3ZUIFxwOBg1n@work-vm>
        <Y9E7PNmSTP5w2zuw@kroah.com>
        <Y9FDZPV7qENtNNyk@work-vm>
        <20230125215333.GA18160@wunner.de>
        <Y9Jakvab14K61b2t@work-vm>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.191]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 Jan 2023 10:48:50 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Wunner (lukas@wunner.de) wrote:
> > [cc += Jonathan Cameron, linux-pci]
> > 
> > On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:  
> > > Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:  
> > > > Great, so why not have hardware attestation also for your devices you
> > > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > > worry about anything in the guest.  
> > > 
> > > There were some talks at Plumbers where PCIe is working on adding that;
> > > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > > SPDM.   I don't know much of the detail of those, just that they're far
> > > enough off that people aren't depending on them yet.  
> > 
> > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> >
> > https://github.com/l1k/linux/commits/doe  
> 
> Thanks for the pointer - I'll go and hunt down that spec.
> 
> > It will allow for authentication of PCIe devices.  Goal is to submit
> > this quarter (Q1).  Afterwards we'll look into retrieving measurements
> > via CMA/SPDM and bringing up IDE encryption.
> > 
> > It's a kernel-native implementation which uses the existing crypto and
> > keys infrastructure and is wired into the appropriate places in the
> > PCI core to authenticate devices on enumeration and reauthenticate
> > when CMA/SPDM state is lost (after resume from D3cold, after a
> > Secondary Bus Reset and after a DPC-induced Hot Reset).
> > 
> > The device authentication service afforded here is generic.
> > It is up to users and vendors to decide how to employ it,
> > be it for "confidential computing" or something else.  
> 
> As Samuel asks about who is doing the challenge; but I guess there are
> also things like what happens when the host controls intermediate
> switches and BAR access and when only VFs are passed to guests.

Hmm.  Bringing switches into the TCB came up at Plumbers.
You can get partly around that using selective IDE (end to end encryption)
but it has some disadvantages.

You can attest the switches if you don't mind bringing them into TCB
(one particularly cloud vendor person was very strongly against doing so!)
but they don't have nice VF type abstractions so the switch attestation
needs to go through someone who isn't the guest.

> 
> > Trusted root certificates to validate device certificates can be
> > installed into a kernel keyring using the familiar keyctl(1) utility,
> > but platform-specific roots of trust (such as a HSM) could be
> > supported as well.
> > 
> > I would like to stress that this particular effort is a collaboration
> > of multiple vendors.  It is decidedly not a single vendor trying to
> > shoehorn something into upstream, so the criticism that has been
> > leveled upthread against other things does not apply here.
> > 
> > The Plumbers BoF you're referring to was co-authored by Jonathan Cameron
> > and me and its purpose was precisely to have an open discussion and
> > align on an approach that works for everyone:
> > 
> > https://lpc.events/event/16/contributions/1304/
> > 
> >   
> > >    a) there's no good way to authenticate a PCI device yet
> > >      - any nasty device can claim to have a given PCI ID.  
> > 
> > CMA/SPDM prescribes that the Subject Alternative Name of the device
> > certificate contains the Vendor ID, Device ID, Subsystem Vendor ID,
> > Subsystem ID, Class Code, Revision and Serial Number (PCIe r6.0
> > sec 6.31.3).
> > 
> > Thus a forged Device ID in the Configuration Space Header will result
> > in authentication failure.  
> 
> Good!  It'll be nice when people figure out the CoCo integration for
> that; I'm still guessing it's a little way off until we get hardware
> for that.

FYI: We have QEMU using the DMTF reference implementation (libspdm/spdm-emu)
if anyone wants to play with it.  Avery Design folk did the qemu bridging to that
a while back. Not upstream yet*, but I'm carrying it on my staging CXL qemu tree.

https://gitlab.com/jic23/qemu/-/commit/8d0ad6bc84a5d96039aaf8f929c60b9f7ba02832

In combination with Lucas' tree mentioned earlier you can get all the handshaking
to happen to attest against certs. Don't think we are yet actually checking the
IDs but trivial to add (mainly a case of generating right certs with the
Subject Alternative Name set).

Jonathan

* It's a hack using the socket interface of spdm-emu tools - at some point I need
to start a discussion on QEMU list / with dmtf tools group on whether to fix
libspdm to actually work as a shared library, or cope with the current approach
(crossing fingers the socket interface remains stable in spdm-emu).

> 
> Dave
> 
> > Thanks,
> > 
> > Lukas
> >   

