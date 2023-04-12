Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8F6DFADC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDLQKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLQKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 12:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A441993;
        Wed, 12 Apr 2023 09:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5657636BC;
        Wed, 12 Apr 2023 16:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3076C433EF;
        Wed, 12 Apr 2023 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315814;
        bh=WC1VZgkI+XhbE3uqeewqBrMZi5G6zrtIVqJ6zC75R4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rpL0hOqQNTG3phxORdYz2c3JDVPXQH3sQLps2dbzqc4t1zogGwUSqmobJhAX9frBg
         VguY13XL8/4VQjnuTRNrsjZapr9L480vf0laakqaIU1AUgklkl71gTI78cmfIEVUjc
         ntb3l0O4xtyjM507o0ql0LlOEyXp16ZcBwdLHjnu1hgmY1V0u/EMSQXeyeHw2eOhJt
         LNjTUQ5EwY2e4H4URC7cHe+Aj4aSZQw2HvBw1Q87l/Mwx5JIzjuSCS8GVl4ZcKo99y
         PPAh67dmqrqkyc+cyWptIJxCAUg5szrlqGBe1EPgT4aMvToDoXaIcukDeKmKT998QF
         tNBIT+n1qGDRw==
Date:   Wed, 12 Apr 2023 11:10:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH v2 3/5] ACPI/PCI: Add AER bits #defines for PCIe to
 PCI/PCI-X Bridge
Message-ID: <20230412161012.GA48719@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c4f38c-d45b-cf68-33e5-2e73dd73213d@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 05:49:55PM +0800, LeoLiuoc wrote:

> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index 57b8e2ffb1dd..37f3baa336d7 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -799,6 +799,11 @@
> > >   #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
> > >   #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
> > > +/* PCIe advanced error reporting extended capabilities for PCIe to PCI/PCI-X Bridge */
> > > +#define PCI_ERR_UNCOR_MASK2		0x30	/* Secondary Uncorrectable Error Mask */
> > > +#define PCI_ERR_UNCOR_SEVER2	0x34	/* Secondary Uncorrectable Error Severit */
> > > +#define PCI_ERR_CAP2			0x38	/* Secondary Advanced Error Capabilities */
> > 
> > Please squash these right up next to the other PCI_ERR_* definitions
> > so it's obvious that they overlap PCI_ERR_ROOT_STATUS and
> > PCI_ERR_ROOT_ERR_SRC (which is fine since one device can't have both),
> > e.g.,
> > 
> >    #define PCI_ERR_ROOT_STATUS     0x30
> >    #define  PCI_ERR_ROOT_COR_RCV           0x00000001 /* ERR_COR Received */
> >    ...
> >    #define PCI_ERR_ROOT_ERR_SRC    0x34    /* Error Source Identification */
> >    #define PCI_ERR_UNCOR_MASK2     0x30    /* PCIe to PCI/PCI-X bridge */
> >    #define PCI_ERR_UNCOR_SEVER2    0x34    /* PCIe to PCI/PCI-X bridge */
> >    #define PCI_ERR_CAP2            0x38    /* PCIe to PCI/PCI-X bridge */
> 
> I don't seem to understand what you mean. PCI_ERR_UNCOR_MASK2,
> PCI_ERR_UNCOR_SEVER2, and PCI_ERR_CAP2 represent the control and handling of
> individual errors that occur on traditional PCI or PCI-x secondary bus
> interfaces, these registers are valid only for Bridge. Although
> PCI_ERR_ROOT_ERR_SRC and PCI_ERR_UNCOR_SEVER2 have the same value, they
> represent register definitions for different device types.

Right.  I just don't want the blank line in the middle because it
might be mistaken for items in a different capability.  All the other
AER capability registers are defined together in a block, with no
blank lines in the middle, so I think these new ones should be part of
that block.

Bjorn
