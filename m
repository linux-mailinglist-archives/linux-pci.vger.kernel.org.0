Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7165A6E32
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiH3UOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3UOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 16:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C16E57203;
        Tue, 30 Aug 2022 13:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FFA617AB;
        Tue, 30 Aug 2022 20:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D7CC433D6;
        Tue, 30 Aug 2022 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661890475;
        bh=pWKzamfJyKPw2dxL9g9cP/ZEfKDskn5zPibQQz6Byb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T32CpdMu/+sLFOl6BkC1NU/ggKMUaEcWguE3Y1XnoHPMYUSbLSzfY2bjPooVBr9iQ
         C2Im91AvWFOgNuQeCLRHa5RCTjE0GBEnPFW8/MwY7e4yUnxXE4RixB9xkhbk15+txS
         s8hI7mujODWX3Bj3DzrvB4a0uKdp9evv3htSm4mg113DTqRSDA2TlzUDLd8nfUiDLa
         WHRL3So/5yqWmkz5nrnpRuvrYjSU68TEDn3iAhC2DKZGx4VXjhJ5DM9MF40OcjFMvt
         c1Zk06eIw6hTTR3hcUgiPBTUXUygdGpb3buW/eSEtlh421OQQXEOqMsxE9hC6AVI5w
         BODvMMvH7xiSQ==
Date:   Tue, 30 Aug 2022 15:14:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND^2][PATCH v3] x86/PCI: Add support for the Intel
 82378ZB/82379AB (SIO/SIO.A) PIRQ router
Message-ID: <20220830201433.GA123876@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2208291916390.61470@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 07:23:32PM +0100, Maciej W. Rozycki wrote:
> The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A) 
> ISA bridges implement PCI interrupt steering with a PIRQ router[1][2] 
> that is exactly the same as that of the PIIX and ICH southbridges (or 
> actually the other way round, given that the SIO ASIC was there first).
> 
> An earlier version of the SIO, the 82378IB[3][4], does not implement PCI 
> interrupt steering however, so we need to exclude it by checking the low 
> nibble of the PCI Revision Identification Register[5][6] for being at 
> least 3.
> 
> There is a note in the 82379AB specification update[7] saying that the 
> device ID for that chip is 0x7, rather than 0x484 as stated in the 
> datasheet[8].  It looks like a red herring however, for no report has 
> been ever seen with that value quoted and it matches the documented 
> default value of the PCI Command Register, which comes next after the 
> PCI Device Identification Register, so it looks like a copy-&-paste 
> editorial mistake.
> 
> NB the 82378ZB has been commonly used with smaller DEC Alpha systems 
> with the contents of the Revision Identification Register reported as 
> one of 0x3, 0x43, or 0x84, so the masking of the high nibble seems 
> indeed right by empirical observation.  The value in the high nibble 
> might be either random, or depend on the batch, or correspond to some 
> other state such as reset straps.
> 
> References:
> 
> [1] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
>     290473-004, December 1994, Section 4.1.26 "PIRQ[3:0]#--PIRQ Route 
>     Control Registers"
> 
> [2] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.25. "PIRQ[3:0]#--PIRQ Route Control Registers", p. 48
> 
> [3] "82378IB System I/O (SIO)", Intel Corporation, Order Number:
>     290473-002, April 1993, Section 5.8.7.7 "Edge and Level Triggered
>     Modes"
> 
> [4] "82378IB to 82378ZB Errata Fix and Feature Enhancement Conversion
>     FOL933002-01",
>     <https://web.archive.org/web/19990421045433/http://support.intel.com/support/chipsets/420/8511.htm>
> 
> [5] "82378 System I/O (SIO)", Intel Corporation, Order Number: 
>     290473-004, December 1994, Section 4.1.5. "RID--Revision 
>     Identification Register"
> 
> [6] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.5. "RID--Revision Identification Register", p. 34
> 
> [7] "Intel 82379AB (SIO.A) System I/O Component Specification Update", 
>     Intel Corporation, Order Number: 297734-001, May, 1996, "Component 
>     Identification via Programming Interface", p. 5
> 
> [8] "82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO.A)",
>     Intel Corporation, Order Number: 290571-001, March 1996, Section 
>     3.1.2. "DID--Device Identification Register", p. 33
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Hi,
> 
>  This patch was dropped from x86/irq due to a bug in a follow-up patch and 
> when resent it was not re-picked up along with the other patches for some 
> reason, so resending verbatim again after another re-verification, against 
> 6.0-rc2 as at yesterday (just before Linus's version bump).

I don't know anything about these IRQ routers, and Thomas has applied 
recent similar patches, so I assume he'll handle this.
