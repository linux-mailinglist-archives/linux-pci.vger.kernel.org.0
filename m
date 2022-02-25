Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013204C493C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiBYPic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiBYPib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 10:38:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6898714F2A6;
        Fri, 25 Feb 2022 07:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6546618C5;
        Fri, 25 Feb 2022 15:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1DC340F0;
        Fri, 25 Feb 2022 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645803478;
        bh=g98zliAtM2Tc6v3mwYJ14NN8JaWLKdHFUA4VftrTn6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CCnRtCJaxgV9HmJFSyPj+jajT4/2v2E2/2sbiK+wTwgAkK9VYqaVVXruNGv6odZfw
         V+7GDK6lCMcPITFVfTKgSh/EC9a8wY25tVbdYm9L2THSX/lyca/vuOdwzwCDH2vl8z
         zRxEkbooPjGmdxd8HCgqhg+/8rHocpnmebG7Ewy3VTl3JzOkzpSCmWK2R+zRg1Du3U
         23w7MiJzog2ZfZlfjnzyyTLzfKKC3RVVO45SIVo6dnNiiuFXhbPdwVKX2vB1gbcZJE
         KpRniDbA6WjyWfbq788WReK252QrTmlFNqVY17ug/5j1DHmfi0t3nlOwvJ9XLhheeC
         klJHvkJTwC3+Q==
Date:   Fri, 25 Feb 2022 09:37:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220225153756.GA358517@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225122451.fa2fiyzohwme2d66@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 01:24:51PM +0100, Pali Rohár wrote:
> On Thursday 24 February 2022 14:28:43 Bjorn Helgaas wrote:
> > On Tue, Feb 22, 2022 at 05:31:54PM +0100, Pali Rohár wrote:
> > > These macros allows to easily compose and extract Slot Power Limit and
> > > Physical Slot Number values from Slot Capability Register.
> > >
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index 108f8523fa04..3fc9a4cac630 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -591,10 +591,13 @@
> > >  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
> > >  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
> > >  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
> > > +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
> > 
> > Is there a way to use FIELD_PREP() and FIELD_GET() instead?  It seems
> > like that's what the cool kids are doing now.
> 
> This is possible too.
> 
> I have proposed a patch with _SHIFT macros as this is the way how are
> other macros in this file defined and used.

Yes, it's a mix.  For some recent additions, I've resisted adding the
_SHIFT macros on the theory that they clutter the file, they never
change, and the main point of the #defines is readability and so
grep/tags/etc can find things.

There are a *few* users of FIELD_PREP() and FIELD_GET():

  git grep -E "FIELD_(GET|PREP)\(PCI_EXP"

and I'm inclined to go that direction in the future.  What do you
think?

Bjorn
