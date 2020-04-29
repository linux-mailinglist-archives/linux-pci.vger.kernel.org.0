Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F61BE4EC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD2RKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 13:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgD2RKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 13:10:35 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825DE2083B;
        Wed, 29 Apr 2020 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588180234;
        bh=2xgcMioH3CWsTJf+X/wvX2WrB+R7RzkvMl/X2y3wgaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i3/Vf9ubdb8TMxpehNHGGBNTu5jT80uie8MpBKJJKGqwjGAJpOpRtM9HlGRX9MgKJ
         +yChP6v6VYC73cG+BVGxSHvKVtE2WKj+CUZW9uFv9HVf4bfs9/+cEdFkyPMHFwek76
         WwgRcx8JRM3FGXCoAreRGtA3anRIhgQZXjgnneCs=
Date:   Wed, 29 Apr 2020 12:10:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Austin.Bolen@dell.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        jonathan.derrick@intel.com, mr.nuke.me@gmail.com, rjw@rjwysocki.net
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200429171032.GA30596@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3535fbc69604425b1e8f008348950ab@AUSX13MPC107.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 03:24:41PM +0000, Austin.Bolen@dell.com wrote:
> On 4/28/2020 3:37 PM, Bjorn Helgaas wrote:
> > [EXTERNAL EMAIL] 
> >
> > [+to Mario, Austin, Rafael; Dell folks, I suspect this commit will
> > break Dell servers but I'd like your opinion]
> >
> > <snip>
> Thanks Bjorn, for the heads up. I checked with our server BIOS team and
> they say that only checking _OSC for AER should work on our servers.  We
> always configure_OSC and the HEST FIRMWARE_FIRST flag to retain firmware
> control of AER so either could be checked.
> 
> > I *really* want the patch because the current mix of using both _OSC
> > and FIRMWARE_FIRST to determine AER capability ownership is a mess and
> > getting worse, but I'm more and more doubtful.
> >
> > My contention is that if firmware doesn't want the OS to use the AER
> > capability it should simply decline to grant control via _OSC.
>
> I agree per spec that _OSC should be used and this was confirmed by the
> ACPI working group. Alex had submitted a patch for us [2] to switch to
> using _OSC to determine AER ownership following the decision in the ACPI
> working group.

Perfect, thank you!  I had forgotten that Alex posted that.  We should
add credit to him and a link to that discussion.  Thanks again!

> [2] https://lkml.org/lkml/2018/11/16/202
> 
> > But things like 0584396157ad ("PCI: PCIe AER: honor ACPI HEST FIRMWARE
> > FIRST mode") [1] suggest that some machines grant AER control to the
> > OS via _OSC, but still expect the OS to leave AER alone for certain
> > devices.
>
> AFAIK, no Dell server, including the 11G servers mentioned in that
> patch, have granted control of AER via _OSC and set HEST FIRMWARE_FIRST
> for some devices. I don't think this model is even support by the
> ACPI/PCIe standards.  Yes, you can set the bits that way, but there is
> no text I've found that says how the OS/firmware should behave in that
> scenario. In order to be interoperable, I think someone would need to
> standardized how the OS/firmware would could co-ordinate in such a model.

I agree and I want to get Linux out of the current muddle where we
try to make sense out of it.

> > I think the FIRMWARE_FIRST language in the ACPI spec is really too
> > vague to tell the OS not to use the AER Capability, but it seems like
> > that's what commits like [1] rely on.
> >
> > The current _OSC definition (PCI Firmware r3.2) applies only to
> > PNP0A03/PNP0A08 devices, but it's conceivable that it could be
> > extended to other devices if we need per-device AER Capability
> > ownership.
> >
> > [1] https://git.kernel.org/linus/0584396157ad
<snip>
