Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78219574427
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiGNFG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGNFGD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 01:06:03 -0400
X-Greylist: delayed 329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 22:01:47 PDT
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9F1D0D6
        for <linux-pci@vger.kernel.org>; Wed, 13 Jul 2022 22:01:47 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0558340A56; Thu, 14 Jul 2022 05:56:13 +0100 (BST)
Date:   Thu, 14 Jul 2022 05:56:13 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Manyi Li <limanyi@uniontech.com>, bhelgaas@google.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220714045613.GA8720@srcf.ucam.org>
References: <20220713112612.6935-1-limanyi@uniontech.com>
 <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 11:20:26AM +0800, Kai-Heng Feng wrote:

> According to commit 387d37577fdd ("PCI: Don't clear ASPM bits when the
> FADT declares it's unsupported"), the bit means "just use the ASPM

Yes, the assumption is that if the BIOS set up ASPM but FADT indicates 
it's unsupported, just trust that the BIOS did the right thing and don't 
interfere. It's been a long time, but when we were clearing the ASPM 
bits in response to this FADT setting, a bunch of machines suddenly 
started consuming a lot more power than when running Windows.
