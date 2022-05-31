Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F195398D2
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348002AbiEaVcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiEaVcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 17:32:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EDBF46
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 14:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E2A7B810F5
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 21:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6ACC385A9;
        Tue, 31 May 2022 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032720;
        bh=EjQ2MMOCfUgTdAHVnNm3NAKg+uqyX2wEwjvyhWJepmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F3Jq000fpRUwmEsBGgylHRubhe23oqvBwwhEuqEeNFfO1K+2u2eAY4lCqQiGiZ+03
         eihnwMvePl8TRZi2CD2UgRKf8NUlZc1TfwJsXmk9EZmAqU8sqJPrhYDosswS6V7KTF
         AOYRLzgPXPzmB1u/TmSHAlCSRzZyI0LFcjVo9mvw4L/n7CS92yBFYEU0MTfAwU1zTm
         j7lUyeJvC15BG1eV/21fLPkCn7KT5KCSae3xV2NNPlV9SuG7GhLq9TCDWVIebz6+Jv
         /4UQD898dg4RL/8eKJVgurMPNuw0Cro411Zjup2bPNHQ1rJLdc34fBaVgVSWg2qxOJ
         Z5AAVlQl2lclQ==
Date:   Tue, 31 May 2022 16:31:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Message-ID: <20220531213158.GA780032@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530083206.nlsokp2hjivu53z5@pali>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 30, 2022 at 10:32:06AM +0200, Pali Rohár wrote:
> On Monday 30 May 2022 10:18:41 Stefan Roese wrote:
> > On 28.05.22 02:09, Bjorn Helgaas wrote:
> > > In subject line, I assume you mean "System Errors" instead of "Service
> > > Errors"?
> > 
> > Background: I took over submitting this patchset from Bharat. Here his
> > last revision:
> > https://www.spinics.net/lists/kernel/msg2960164.html

Here's the link to the more usable lore archive:
https://lore.kernel.org/all/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/

> > To answer your question I personally think too, that "System Errors" is
> > more appropriate than "Service Errors". But still this patchset replaces
> > or better enhances the already present pcie_init_service_irqs() by a
> > platform-specific version. I can only suspect, that this is the
> > reasoning for this "Service" naming.
> 
> Hello! Based on the below text "Here the quote from Bharat's original
> cover letter:" I think that the better naming should be: "Service
> interrupts". Because it adds support for interrupts from PCIe services
> like AER, PME or HP. Only AER are errors, other IRQs are just services.

The question I'm trying to answer is whether this series concerns the
"System Error" mechanism or the "Error Interrupt" mechanism.  We
should figure out which one this is and use the correct name.

The sec 6.2.4.1.2 cited below clearly refers to the AER Root Error
Command register, which controls interrupt generation via INTx, MSI,
or MSI-X, i.e., the standard "Error Interrupt" shown on the RIGHT side
of Figure 6-3 in sec 6.2.6.

The "System Error" signaling on the LEFT side of Figure 6-3 would be
controlled by the Root Control register in the PCIe capability.

It should be easy to use setpci to set/clear these two sets of enable
bits and figure out which path is of interest here.

> > > On Fri, Jan 14, 2022 at 08:58:33AM +0100, Stefan Roese wrote:
> > > > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>

> > > > As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
> > > > platform-specific System Errors like AER can be delivered via platform-
> > > > specific interrupt lines.

> > > ...
> > > 6.7.3.4 ("Software Notification of Hot-Plug Events") talks about PME
> > > and Hot-Plug Event interrupts, but these aren't errors, and I only see
> > > signaling via INTx, MSI, or MSI-X.  Is there provision for a different
> > > method?
> > 
> > Here the quote from Bharat's original cover letter:
> > "Some platforms have dedicated IRQ lines for PCIe services like AER/PME
> > etc. The root complex on these platform will use these seperate IRQ
> > lines to report AER/PME etc., interrupts and will not generate MSI/
> > MSI-X/INTx interrupts for these services.
> 
> This is the best explanation of this change.

As far as I can tell, "dedicated IRQ lines for services like AER/PME
etc" would violate the PCIe spec.  That's OK, we can work around that
sort of thing, but it needs to be clearly called out as some kind of
quirk and not mixed in with things like System Error signaling, which
is allowed to be platform-specific.

Bjorn
