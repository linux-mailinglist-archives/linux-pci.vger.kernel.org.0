Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA16692D7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 10:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjAMJ07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAMJ0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 04:26:00 -0500
X-Greylist: delayed 541 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 01:19:54 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991F13F67
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 01:19:52 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B1B7528088D6F;
        Fri, 13 Jan 2023 10:10:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 93E2B77A3E; Fri, 13 Jan 2023 10:10:23 +0100 (CET)
Date:   Fri, 13 Jan 2023 10:10:23 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
Message-ID: <20230113091023.GA29495@wunner.de>
References: <a2ff8481c3f08458dcd2b4028a838730e965c72f.1672511017.git.lukas@wunner.de>
 <20230112223533.GA1798809@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112223533.GA1798809@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 04:35:33PM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 31, 2022 at 07:33:39PM +0100, Lukas Wunner wrote:
> > We're calling pci_bridge_wait_for_secondary_bus() after performing a
> > Secondary Bus Reset, but neglect to do the same after coming out of a
> > DPC-induced Hot Reset.  As a result, we're not observing the delays
> > prescribed by PCIe r6.0 sec 6.6.1 and may access devices on the
> > secondary bus before they're ready.  Fix it.
> > 
> > Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
> 
> I assume this patch is the one that makes the difference for the
> Intel Ponte Vecchio HPC GPU?

Right.


> Is there a URL to a problem report, or
> at least a sentence or two we can include here to connect the patch
> with the problem users may see?

There's no public problem report.  My understanding is that Ponte Vecchio
was formally launched this Tuesday and mass distribution starts only now:

https://www.tomshardware.com/news/intel-launches-sapphire-rapids-fourth-gen-xeon-cpus-and-ponte-vecchio-max-gpu-series

The idea is to get the issue in the kernel fixed early so that users will
never even see it.


> Most people won't know how to
> recognize accesses to devices on the secondary bus before they're
> ready.

With Ponte Vecchio, the GPU is located below a PCIe switch and the
Downstream Port Containment happens at the Root Port.  So the Root
Port needs to wait for the Switch Upstream Port to re-appear.

Because config space is currently restored too early on the Switch
Upstream Port, it remains in D0uninitialized once it comes out of
reset, so all its registers, in particular the bridge windows,
are in power-on reset state.  As a result, anything downstream of it
(including the GPU) remains inaccessible and the user-visible
error messages look like this:

i915 0000:8c:00.0: can't change power state from D3cold to D0 (config space inaccessible)
intel_vsec 0000:8e:00.1: can't change power state from D3cold to D0 (config space inaccessible)

Where intel_vsec is a sibling of the GPU which is used for
telemetry I believe.

I'll be sure to include that additional information in the commit
message when respinning.

Thanks,

Lukas
