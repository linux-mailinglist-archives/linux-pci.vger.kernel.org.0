Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF82A667E6F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjALSyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 13:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbjALSxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 13:53:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660085C93;
        Thu, 12 Jan 2023 10:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C281B81FB0;
        Thu, 12 Jan 2023 18:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2664C433EF;
        Thu, 12 Jan 2023 18:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673547829;
        bh=Ay2RHNSirNXT1GRYS649GDJxRxbYFyfkrxZhR76Dcdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t6GRHU5n/jOOlQVw5AFv3Vy11HGk01Af1l9tE4nx9BqMXZ+cT1RXa74QtWz4jAx6Q
         xYiHTKDWPMBJCF2GOOzwEwsWjDSxYs3Rc8+CVOHIt53NAAgM+tXG3LdV3MtPCR46cu
         +qw7+PID8uRVIdpVfl7V4KLjTVOwdocGNkZCaA1cWoIipmKACW0QMhrJ9mi7vxP+Lb
         u1P2+accYtP0VlTWq8Ct7k3m1P43iVrwSNdmdf+lUM5gFVFBMj6DMHv84y9FZ7bV9O
         NdSgrh2jC20ftj6e4dA8aZ3TLXcHe2Yd3bhxrtb4PwiV3Zt5Oja7HVGASJW3S3kZgq
         g6ptCYbczlG8w==
Date:   Thu, 12 Jan 2023 12:23:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     mmaddireddy@nvidia.com, kthota@nvidia.com,
        linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        vsethi@nvidia.com, oohall@gmail.com, bhelgaas@google.com,
        treding@nvidia.com, linuxppc-dev@lists.ozlabs.org,
        sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Message-ID: <20230112182348.GA1777363@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880c4d3c-86d2-082c-bb58-8212adc67ff3@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 03:27:51PM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 1/11/23 3:10 PM, Bjorn Helgaas wrote:
> > On Wed, Jan 11, 2023 at 01:42:21PM -0800, Sathyanarayanan Kuppuswamy wrote:
> >> On 1/11/23 12:31 PM, Vidya Sagar wrote:
> >>> As the ECRC configuration bits are part of AER registers, configure
> >>> ECRC only if AER is natively owned by the kernel.
> >>
> >> ecrc command line option takes "bios/on/off" as possible options. It
> >> does not clarify whether "on/off" choices can only be used if AER is
> >> owned by OS or it can override the ownership of ECRC configuration 
> >> similar to pcie_ports=native option. Maybe that needs to be clarified.
> > 
> > Good point, what do you think of an update like this:
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6cfa6e3996cf..f7b40a439194 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4296,7 +4296,9 @@
> >  				specified, e.g., 12@pci:8086:9c22:103c:198f
> >  				for 4096-byte alignment.
> >  		ecrc=		Enable/disable PCIe ECRC (transaction layer
> > -				end-to-end CRC checking).
> > +				end-to-end CRC checking).  Only effective
> > +				if OS has native AER control (either granted by
> > +				ACPI _OSC or forced via "pcie_ports=native").
> >  				bios: Use BIOS/firmware settings. This is the
> >  				the default.
> >  				off: Turn ECRC off
> 
> Looks fine. But do we even need "bios" option? Since it is the default
> value, I am not sure why we need to list that as an option again. IMO
> this could be removed.

I agree, it seems pointless.

> > I don't know whether the "ecrc=" parameter is really needed.  If we
> > were adding it today, I would ask "why not enable ECRC wherever it is
> > supported?"  If there are devices where it's broken, we could always
> > add quirks to disable it on a case-by-case basis.
> 
> Checking the original patch which added it, it looks like the intention
> is to give option to boost performance over integrity.
> 
> commit 43c16408842b0eeb367c23a6fa540ce69f99e347
> Author: Andrew Patterson <andrew.patterson@hp.com>
> Date:   Wed Apr 22 16:52:09 2009 -0600
> 
>     PCI: Add support for turning PCIe ECRC on or off
>     
>     Adds support for PCI Express transaction layer end-to-end CRC checking
>     (ECRC).  This patch will enable/disable ECRC checking by setting/clearing
>     the ECRC Check Enable and/or ECRC Generation Enable bits for devices that
>     support ECRC.
>     
>     The ECRC setting is controlled by the "pci=ecrc=<policy>" command-line
>     option. If this option is not set or is set to 'bios", the enable and
>     generation bits are left in whatever state that firmware/BIOS set them to.
>     The "off" setting turns them off, and the "on" option turns them on (if the
>     device supports it).
>     
>     Turning ECRC on or off can be a data integrity versus performance
>     tradeoff.  In theory, turning it on will catch more data errors, turning
>     it off means possibly better performance since CRC does not need to be
>     calculated by the PCIe hardware and packet sizes are reduced.

Ah, right, and I think I was even part of the conversation when this
was added :)

I'm not sure I would make the same choice today, though.  IMHO it's
kind of hard to defend choosing performance over data integrity.

If a platform really wants to sacrifice integrity for performance, it
could retain control of AER, and after Vidya's patch, Linux will leave
the ECRC configuration alone.

Straw-man: If Linux owns AER and ECRC is supported, enable ECRC by
default.  Retain "ecrc=off" to turn it off, but drop a note in dmesg
and taint the kernel.

Bjorn
