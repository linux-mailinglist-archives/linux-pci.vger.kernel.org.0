Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455275399DA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiEaW5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346457AbiEaW5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 18:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E423969C
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 15:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E76FB81742
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 22:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE92C385A9;
        Tue, 31 May 2022 22:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654037826;
        bh=fho5FyTdALRElPkfr6HKPaNvRlrod6bzk6quxLPIhc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUgrBvPLnAEL6q6aWOJzPqVeKsM5at+4FG66Xp7rt/H2E9C4cDwlZsVDATq0I6PPB
         EEiF9FtL47ItX4wyhgV6MpXvrrT//MQPAU+BgSdbJNZngzKWwhTPgUjR9fAUSqfRFU
         Dm7mVzY6M1mWF/9s2hzea/m30U2FDLDtBVGnVzyhdfLNL0zAl1pbv1K3o47RSZ28PE
         1alCKJw9ePJhOaEGpNkZNXv468H5Epk5TGYSkZW2YQHBAs8pZ0hZVqyu+dEjktMdsO
         ThKAowrq9BZ+yD3U8O+8tn2DfOR9yZo4BIoRK0YFuW+y8CdaxQa1pXWRdyC+W1ej/x
         W5TmsygafRhug==
Received: by pali.im (Postfix)
        id C791580E; Wed,  1 Jun 2022 00:57:02 +0200 (CEST)
Date:   Wed, 1 Jun 2022 00:57:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Message-ID: <20220531225702.iy4fqsdaecb7ubct@pali>
References: <20220530083206.nlsokp2hjivu53z5@pali>
 <20220531213158.GA780032@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531213158.GA780032@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 31 May 2022 16:31:58 Bjorn Helgaas wrote:
> On Mon, May 30, 2022 at 10:32:06AM +0200, Pali Rohár wrote:
> > On Monday 30 May 2022 10:18:41 Stefan Roese wrote:
> > > On 28.05.22 02:09, Bjorn Helgaas wrote:
> > > > In subject line, I assume you mean "System Errors" instead of "Service
> > > > Errors"?
> > > 
> > > Background: I took over submitting this patchset from Bharat. Here his
> > > last revision:
> > > https://www.spinics.net/lists/kernel/msg2960164.html
> 
> Here's the link to the more usable lore archive:
> https://lore.kernel.org/all/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/
> 
> > > To answer your question I personally think too, that "System Errors" is
> > > more appropriate than "Service Errors". But still this patchset replaces
> > > or better enhances the already present pcie_init_service_irqs() by a
> > > platform-specific version. I can only suspect, that this is the
> > > reasoning for this "Service" naming.
> > 
> > Hello! Based on the below text "Here the quote from Bharat's original
> > cover letter:" I think that the better naming should be: "Service
> > interrupts". Because it adds support for interrupts from PCIe services
> > like AER, PME or HP. Only AER are errors, other IRQs are just services.
> 
> The question I'm trying to answer is whether this series concerns the
> "System Error" mechanism or the "Error Interrupt" mechanism.  We
> should figure out which one this is and use the correct name.

My understanding is that neither "System Error", nor "Error Interrupt".
But patch series is about "dedicated IRQ lines for services". One of
PCIe service is AER, which is one of the mostly used PCIe service in
kernel and therefore it is the root of confusions with keyword "error".

> The sec 6.2.4.1.2 cited below clearly refers to the AER Root Error
> Command register, which controls interrupt generation via INTx, MSI,
> or MSI-X, i.e., the standard "Error Interrupt" shown on the RIGHT side
> of Figure 6-3 in sec 6.2.6.
> 
> The "System Error" signaling on the LEFT side of Figure 6-3 would be
> controlled by the Root Control register in the PCIe capability.
> 
> It should be easy to use setpci to set/clear these two sets of enable
> bits and figure out which path is of interest here.
> 
> > > > On Fri, Jan 14, 2022 at 08:58:33AM +0100, Stefan Roese wrote:
> > > > > From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> > > > > As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
> > > > > platform-specific System Errors like AER can be delivered via platform-
> > > > > specific interrupt lines.
> 
> > > > ...
> > > > 6.7.3.4 ("Software Notification of Hot-Plug Events") talks about PME
> > > > and Hot-Plug Event interrupts, but these aren't errors, and I only see
> > > > signaling via INTx, MSI, or MSI-X.  Is there provision for a different
> > > > method?
> > > 
> > > Here the quote from Bharat's original cover letter:
> > > "Some platforms have dedicated IRQ lines for PCIe services like AER/PME
> > > etc. The root complex on these platform will use these seperate IRQ
> > > lines to report AER/PME etc., interrupts and will not generate MSI/
> > > MSI-X/INTx interrupts for these services.
> > 
> > This is the best explanation of this change.
> 
> As far as I can tell, "dedicated IRQ lines for services like AER/PME
> etc" would violate the PCIe spec.

I think too, that this does not conform to PCIe spec.

> That's OK, we can work around that
> sort of thing, but it needs to be clearly called out as some kind of
> quirk and not mixed in with things like System Error signaling, which
> is allowed to be platform-specific.
> 
> Bjorn

I agree.
