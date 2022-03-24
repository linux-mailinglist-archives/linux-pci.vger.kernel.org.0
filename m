Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C674E6784
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiCXROc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiCXROb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03CB1889;
        Thu, 24 Mar 2022 10:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3545E6198C;
        Thu, 24 Mar 2022 17:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30762C340EC;
        Thu, 24 Mar 2022 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648141978;
        bh=tjBA4TpVMWUci3qwG39vCc+WacEs0bnKcqEXkAKHzvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EwfSKjQRK47UJiLv8QWb6GjAWCsRGsYLeL5M655cgAm3vkBH4Q+okaFDI03fCwFzI
         qvUS0GdrTISyj7HZdptQOc3tKnMeaDbph7+CHOF7Sdgr4d23x3rjir5qwSAb6xlO2x
         kvBLneIFcZMZD/MSpLD5ZqaMxPjMYys2Jntp+/xvNQRji6RrYSZGzwI1EAhWEW4NQ+
         Uq31ABBc92Wzbrqx7xLRVaRgNJG5fQNeTxntYlIl2o/Rq3z8ffbgDE+33TxtUeg9PG
         cYWUQ0B5pz2A6KwJ2DlTL5XnJtv4cQAIcVzmUM62YHVvZm8F4f9pImo8r/vmUwB3nO
         Ys5uxfgHfu30A==
Date:   Thu, 24 Mar 2022 12:12:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: mvebu: Slot support
Message-ID: <20220324171256.GA1459996@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220321182908.3q4s2ramvhfdpgab@pali>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 07:29:08PM +0100, Pali Rohár wrote:
> PING?

Sorry, my fault.  I reviewed v1 of this patch, so obviously Lorenzo
would wait for me to chime in here.

> On Tuesday 08 March 2022 12:38:31 Pali Rohár wrote:
> > Hello Bjorn! Could you look if v2 changes are now fine?
> > 
> > On Wednesday 02 March 2022 15:57:29 Pali Rohár wrote:
> > > This patch series add slot support to pci-mvebu.c driver.
> > > 
> > > It is based on branch pci/mvebu of git repository:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > > 
> > > Changes in v2:
> > > * Dropped patch with PCI_EXP_SLTCAP_*_SHIFT macros as it is not needed anymore
> > > * Dropped patch "ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties" which was applied
> > > * Added support for PCIe 6.0 slot power limit encodings
> > > * Round down slot power limit value
> > > * Fix handling of slot power limit with scale x1.0 (0x00 value)
> > > * Use FIELD_PREP instead of _SHIFT macros
> > > * Changed commit message to Bjorn's suggestion
> > > * Changed comments in the code to match PCIe spec
> > > * Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
> > > 
> > > Pali Rohár (4):
> > >   PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
> > >   dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
> > >   PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
> > >   PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
> > > 
> > >  Documentation/devicetree/bindings/pci/pci.txt |  6 ++
> > >  drivers/pci/controller/pci-mvebu.c            | 96 ++++++++++++++++++-
> > >  drivers/pci/of.c                              | 64 +++++++++++++
> > >  drivers/pci/pci.h                             | 15 +++
> > >  include/uapi/linux/pci_regs.h                 |  1 +
> > >  5 files changed, 177 insertions(+), 5 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
