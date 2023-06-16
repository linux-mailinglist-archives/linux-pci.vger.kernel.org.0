Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F2733810
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFPSYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFPSYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 14:24:13 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F835AC;
        Fri, 16 Jun 2023 11:24:12 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D8190300002D5;
        Fri, 16 Jun 2023 20:24:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BEFB21E8240; Fri, 16 Jun 2023 20:24:09 +0200 (CEST)
Date:   Fri, 16 Jun 2023 20:24:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230616182409.GA8894@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230511111902.GA10720@wunner.de>
 <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Smita,

My apologies for the delay!

On Mon, May 22, 2023 at 03:23:31PM -0700, Smita Koralahalli wrote:
> On 5/11/2023 4:19 AM, Lukas Wunner wrote:
> > On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
> > > Clear all capabilities in Device Control 2 register as they are optional
> > > and it is not determined whether the next device inserted will support
> > > these capabilities. Moreover, Section 6.13 of the PCIe Base
> > > Specification [1], recommends clearing the ARI Forwarding Enable bit on
> > > a hot-plug event as its not guaranteed that the newly added component
> > > is in fact an ARI device.
> > 
> > Clearing ARI Forwarding Enable sounds reasonable, but I don't see
> > why all the other bits in the Device Control 2 register need to be
> > cleared.  If there isn't a reason to clear them, I'd be in favor of
> > leaving them alone.
> 
> I understand. The SPEC doesn't "clearly" state to clear the other bits
> except ARI on a hot-plug event.
> 
> But, we came across issues when a device with 10-bit tags was removed and
> replaced with a device that didn't support 10-bit tags. The device became
> inaccessible and the port was not able to be recovered without a system
> reset. So, we thought it would be better to cherry pick all bits that were
> negotiated between endpoint and root port and decided that we should clear
> them all on removal. Hence, my first revision of this patch series had aimed
> to clear only ARI, AtomicOp Requestor and 10 bit tags as these were the
> negotiated settings between endpoint and root port. Ideally, these settings
> should be re-negotiated and set up for optimal operation on a hot add.

Makes total sense.  I like the approach of clearing only these three
bits, as you did in v1 of the patch.  I also appreciate the detailed
explanation that you've provided.  Much of your e-mail can be copy-pasted
to the commit message, in my opinion it's valuable information to any
reviewer and future reader of the commit.


> We had some internal discussions to understand if SPEC has it documented
> somewhere. And we could see in Section 2.2.6.2, it implies that:
> [i] If a Requester sends a 10-Bit Tag Request to a Completer that lacks
> 10-Bit Completer capability, the returned Completion(s) will have Tags with
> Tag[9:8] equal to 00b. Since the Requester is forbidden to generate these
> Tag values for 10-Bit Tags, such Completions will be handled as Unexpected
> Completions, which by default are Advisory Non-Fatal Errors. The Requester
> must follow standard PCI Express error handling requirements.
> [ii] In configurations where a Requester with 10-Bit Tag Requester
> capability needs to target multiple Completers, one needs to ensure that the
> Requester sends 10-Bit Tag Requests only to Completers that have 10-Bit Tag
> Completer capability.
> 
> Now, we might wonder, why clear them (especially 10-bit tags and AtomicOps)
> if Linux hasn't enabled them at all as the "10-Bit Tag Requester Enable" bit
> is not defined in Linux currently. But, these features might be enabled by
> Platform FW for "performance reasons" if the endpoint supports and now it is
> the responsibility of the operating system to disable it on a hot remove
> event.

Again, makes total sense.


> According to implementation notes in 2.2.6.2: "For platforms where the RC
> supports 10-Bit Tag Completer capability, it is highly recommended for
> platform firmware or operating software that configures PCIe hierarchies to
> Set the 10-Bit Tag Requester Enable bit automatically in Endpoints with
> 10-Bit Tag Requester capability. This enables the important class of 10-Bit
> Tag capable adapters that send Memory Read Requests only to host memory." So
> if the endpoint and root port both support 10-bit tags BIOS is enabling it
> at boot time..
> 
> I ran a quick check to see how DEV_CTL2 registers for root port look on a
> 10-bit tag supported NVMe device.
> 
> pci 0000:80:05.1: DEVCTL2 0x1726 (Bit 12: 10-bit tag is enabled..)
> pci 0000:80:05.1: DEVCAP2 0x7f19ff
> 
> So, it seems like BIOS has enabled 10-bit tags at boot time even though
> Linux hasn't enabled it.
> 
> Some couple of ways we think could be:
> [1] Check if these bits are enabled by Platform at boot time, clear them
> only it is set during hotplug flow.
> [2] Clear them unconditionally as I did..
> [3] Enable 10-bits tags in Linux when a device is probed just like how we do
> for ARI..
> 
> Similarly call pci_enable_atomic_ops_to_root() during a hot add..

Personally I'm fine with option [2].  If you or Bjorn prefer option [3],
I'm fine with that as well.


> > As for clearing ARI Forwarding Enable, it seems commit b0cc6020e1cc
> > ("PCI: Enable ARI if dev and upstream bridge support it; disable
> > otherwise") already solved this problem.  Quoth its commit message:
[...]
> > My superficial understanding of that patch is that we do find function 0,
> > while enumerating it we clear the ARI Forwarding Enable bit and thus the
> > remaining functions become accessible and are subsequently enumerated.
> > 
> > Are you seeing issues when removing an ARI-capable endpoint from a
> > hotplug slot and replacing it with a non-ARI-capable device?
> > If you do, the question is why the above-quoted commit doesn't avoid them.
> 
> Yeah! Sorry I missed this. ARI is already checked and enabled during device
> initialization.

It doesn't hurt to additionally clear on hot-removal.

Thanks,

Lukas
