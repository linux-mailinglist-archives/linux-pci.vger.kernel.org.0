Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE305575E9E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGOJcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiGOJck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 05:32:40 -0400
X-Greylist: delayed 102981 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 02:32:37 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DEC11814;
        Fri, 15 Jul 2022 02:32:37 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 5F20F40A71; Fri, 15 Jul 2022 10:32:36 +0100 (BST)
Date:   Fri, 15 Jul 2022 10:32:36 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Manyi Li <limanyi@uniontech.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>, rafael@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220715093236.GA12020@srcf.ucam.org>
References: <20220713112612.6935-1-limanyi@uniontech.com>
 <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
 <7305201c-eaf2-cb36-80fe-15174d3e33c7@uniontech.com>
 <20220715082945.GA10661@srcf.ucam.org>
 <c8498fc1-854f-efdc-bbc8-3de67dcf6430@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8498fc1-854f-efdc-bbc8-3de67dcf6430@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 05:19:25PM +0800, Manyi Li wrote:
> 
> 
> On 2022/7/15 16:29, Matthew Garrett wrote:
> > On Fri, Jul 15, 2022 at 03:40:36PM +0800, Manyi Li wrote:
> > 
> > > Please see the details of this issus:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216245
> > 
> > Hmm. The only case where changing aspm_support_enabled to false should
> > matter is in pcie_aspm_init_link_state(), where it looks like we'll
> > potentially rewrite some registers even if aspm_disabled is true. I
> > think in theory we shouldn't actually modify anything as a result, and
> > the lspcis from the bug don't show any ASPM values having changed, but I
> > don't trust Realtek hardware in the general case so maybe it gets upset
> > here? If the proposed patch is to just set aspm_support_enabled to false
> > when we see the FADT bit set then I think this is fine.
> > 
> 
> "aspm_support_enabled" alse be used in calculate_support():
> if (pcie_aspm_support_enabled())
>     support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> When set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT, cause this AER
> issue. I want don't set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT when
> we see the FADT bit set.

Oh hm. Are you sure it's the OSC call that breaks it? I have some 
recollection that I verified the behaviour of Windows here, but it's 
been over 10 years since I touched this so I could well be wrong. I can 
try to set up a test env to verify the behaviour of Windows when it 
comes to _OSC if the FADT says ASPM is unsupported.
