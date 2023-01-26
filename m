Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0067D0E8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAZQHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 11:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAZQHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 11:07:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBFB53B21;
        Thu, 26 Jan 2023 08:07:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2lvT46h3z6J9Tn;
        Fri, 27 Jan 2023 00:06:45 +0800 (CST)
Received: from localhost (10.81.202.191) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 16:07:30 +0000
Date:   Thu, 26 Jan 2023 16:07:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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
Message-ID: <20230126160729.00006843@Huawei.com>
In-Reply-To: <Y9J82eutqDkusRIq@vermeer>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
        <Y9EkCvAfNXnJ+ATo@kroah.com>
        <Y9Ex3ZUIFxwOBg1n@work-vm>
        <Y9E7PNmSTP5w2zuw@kroah.com>
        <Y9FDZPV7qENtNNyk@work-vm>
        <20230125215333.GA18160@wunner.de>
        <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
        <20230126105847.00001b97@Huawei.com>
        <Y9J82eutqDkusRIq@vermeer>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.191]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 26 Jan 2023 14:15:05 +0100
Samuel Ortiz <sameo@rivosinc.com> wrote:

> On Thu, Jan 26, 2023 at 10:58:47AM +0000, Jonathan Cameron wrote:
> > On Thu, 26 Jan 2023 10:24:32 +0100
> > Samuel Ortiz <sameo@rivosinc.com> wrote:
> >   
> > > Hi Lukas,
> > > 
> > > On Wed, Jan 25, 2023 at 11:03 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >   
> > > > [cc += Jonathan Cameron, linux-pci]
> > > >
> > > > On Wed, Jan 25, 2023 at 02:57:40PM +0000, Dr. David Alan Gilbert wrote:    
> > > > > Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:    
> > > > > > Great, so why not have hardware attestation also for your devices you
> > > > > > wish to talk to?  Why not use that as well?  Then you don't have to
> > > > > > worry about anything in the guest.    
> > > > >
> > > > > There were some talks at Plumbers where PCIe is working on adding that;
> > > > > it's not there yet though.  I think that's PCIe 'Integrity and Data
> > > > > Encryption' (IDE - sigh), and PCIe 'Security Prtocol and Data Model' -
> > > > > SPDM.   I don't know much of the detail of those, just that they're far
> > > > > enough off that people aren't depending on them yet.    
> > > >
> > > > CMA/SPDM (PCIe r6.0 sec 6.31) is in active development on this branch:
> > > >
> > > > https://github.com/l1k/linux/commits/doe    
> > > 
> > > Nice, thanks a lot for that.
> > > 
> > > 
> > >   
> > > > The device authentication service afforded here is generic.
> > > > It is up to users and vendors to decide how to employ it,
> > > > be it for "confidential computing" or something else.
> > > >
> > > > Trusted root certificates to validate device certificates can be
> > > > installed into a kernel keyring using the familiar keyctl(1) utility,
> > > > but platform-specific roots of trust (such as a HSM) could be
> > > > supported as well.
> > > >    
> > > 
> > > This may have been discussed at LPC, but are there any plans to also
> > > support confidential computing flows where the host kernel is not part
> > > of the TCB and would not be trusted for validating the device cert chain
> > > nor for running the SPDM challenge?  
> > 
> > There are lots of possible models for this. One simple option if the assigned
> > VF supports it is a CMA instance per VF. That will let the guest
> > do full attestation including measurement of whether the device is
> > appropriately locked down so the hypervisor can't mess with
> > configuration that affects the guest (without a reset anyway and that
> > is guest visible).   
> 
> So the VF would be directly assigned to the guest, and the guest kernel
> would create a CMA instance for the VF, and do the SPDM authentication
> (based on a guest provided trusted root certificate). I think one
> security concern with that approach is assigning the VF to the
> (potentially confidential) guest address space without the guest being
> able to attest of the device trustworthiness first. That's what TDISP is
> aiming at fixing (establish a secure SPDM between the confidential guest
> and the device, lock the device from the guest, attest and then enable
> DMA). 

Agreed, TDISP is more comprehensive, but also much more complex with
more moving parts that we don't really have yet.

Depending on your IOMMU design (+ related stuff) and interaction with
the secure guest, you might be able to block any rogue DMA until
after attestation / lock down checks even if the Hypervisor was letting
it through.

> 
> > Whether anyone builds that option isn't yet clear
> > though. If they do, Lukas' work should work there as well as for the
> > host OS. (Note I'm not a security expert so may be missing something!)
> > 
> > For extra fun, why should the device trust the host? Mutual authentication
> > fun (there are usecases where that matters)
> > 
> > There are way more complex options supported in PCIe TDISP (Tee Device
> > security interface protocols). Anyone have an visibility of open solutions
> > that make use of that? May be too new.  
> 
> It's still a PCI ECN, so quite new indeed.
> FWIW the rust spdm crate [1] implements the TDISP state machine.

Cool. thanks for the reference.
> 
> Cheers,
> Samuel.
> 
> [1] https://github.com/jyao1/rust-spdm
> >   

