Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB66575D83
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiGOI3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGOI3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:29:51 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0625885E;
        Fri, 15 Jul 2022 01:29:47 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id CC63B40A71; Fri, 15 Jul 2022 09:29:45 +0100 (BST)
Date:   Fri, 15 Jul 2022 09:29:45 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Manyi Li <limanyi@uniontech.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>, rafael@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220715082945.GA10661@srcf.ucam.org>
References: <20220713112612.6935-1-limanyi@uniontech.com>
 <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
 <7305201c-eaf2-cb36-80fe-15174d3e33c7@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7305201c-eaf2-cb36-80fe-15174d3e33c7@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 03:40:36PM +0800, Manyi Li wrote:

> Please see the details of this issus:
> https://bugzilla.kernel.org/show_bug.cgi?id=216245

Hmm. The only case where changing aspm_support_enabled to false should 
matter is in pcie_aspm_init_link_state(), where it looks like we'll 
potentially rewrite some registers even if aspm_disabled is true. I 
think in theory we shouldn't actually modify anything as a result, and 
the lspcis from the bug don't show any ASPM values having changed, but I 
don't trust Realtek hardware in the general case so maybe it gets upset 
here? If the proposed patch is to just set aspm_support_enabled to false 
when we see the FADT bit set then I think this is fine.
