Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583951546F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiD2Tbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiD2Tbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 15:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88FCE48A;
        Fri, 29 Apr 2022 12:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3519362456;
        Fri, 29 Apr 2022 19:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4D0C385A7;
        Fri, 29 Apr 2022 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651260508;
        bh=QMmBWhBX8CuK9uzgkZSoFMSRG4Ul5UEIPvLyrJvtXKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UM2gWZkEn4zYP2H2JMS/7K6Vf0e7hbq5oYEdhK6LKzvj2iBjZtOzN82kkTH1/O9lr
         9L7GMuDu6qyzwCSF9YNtqsaaSQInVrYFrANKD6YL5X8wvLMidgZlbnQLsYpo/YcbPI
         OJUITJLeU56I9hN9QZsor94AD/+n6ol2LqxBgtsuDKC8LAnvoJhx0hVy162mXaB9gk
         /hPJLw1KOoFoPf6X81f7XFHPgNzb36Q0l9cv26hMMIPnSQTyLsgu6+OKx71aBHRguG
         mo5Flhn219Q4KS/uTpo8j1/RgFdpfA8+4+NJXM5tioFHITGecCN6FWI5kIef098rP9
         Di29AjpNO5XHQ==
Date:   Fri, 29 Apr 2022 14:28:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <20220429192825.GA82239@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429105627.GA28438@lpieralisi>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56:27AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Feb 22, 2022 at 07:40:54PM +0530, Kishon Vijay Abraham I wrote:
> > On 18/02/22 6:50 pm, Bjorn Helgaas wrote:
> > > On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> > >> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > >>> Update subject line to match previous conventions ("git log --oneline
> > >>> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> > >>>
> > >>> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> > >>>> This enables the Controller [RP] to automatically respond
> > >>>> with Response/ResponseD messages.
> > > 
> > >>>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > >>>> +{
> > >>>> +	u32 val;
> > >>>> +
> > >>>> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > >>>> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> > >>>
> > >>> I assume this is some device-specific enable bit that is effectively
> > >>> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > >>> Capability?
> > >>
> > >> That's correct. This bit enables Controller [RP] to respond to the
> > >> received PTM Requests.
> > > 
> > > Great!  Christian, can you update the commit log to reflect that
> > > both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> > > respond to received PTM Requests?
> > > 
> > > When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> > > and the PTM Responder Capable bit (for which we don't have a #define)
> > > read as zero?
> > 
> > I see both PTM Responder Capable bit and PTM Root Capable is
> > by-default set to '1'.
> 
> Without this patch applied and with no other SW setting
> CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, correct ?
> 
> > root@am64xx-evm:~# devmem2 0xD000A24
> > 
> > /dev/mem opened.
> > Memory mapped at address 0xffffa8980000.
> > Read at address  0x0D000A24 (0xffffa8980a24): 0x00000406
> > 
> > And this bit can be programmed through the local management APB
> > interface if required.
> 
> Which bit ? CDNS_PCIE_LM_TPM_CTRL_PTMRSEN ?
> 
> > But with this patch which enables PTM by default for RC, it
> > wouldn't be required to clear those bits.
> 
> Yes but that does not comply with the specifications as Bjorn
> pointed out below.
> 
> We can merge this patch but it would be good to investigate on this
> point.

I *think* this is OK.  Correct me if I'm wrong:

  - We're talking about a Root Port.

  - The Root Port's PTM Capability reads as 0x00000406 (PTM Responder
    Capable and PTM Root Capable set).

  - Without this patch, setting PTM Enable does nothing, and the Root
    Port does not send PTM Responses.

    This is the non-conforming situation because the Port claims that
    it implements the PTM Responder role, but it can't actually be
    enabled.

  - With this patch that sets CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
    Enable bit still powers up as zero, so the Port does not send PTM
    Responses, but setting PTM Enable enables PTM Responses from the
    Root Port.

So I think that after setting CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
capability works as per spec.

I think the proposed subject of "Enable Controller to respond to
received PTM Requests" is somewhat misleading, though, because PTM
responses still aren't enabled until we set PTM Enable.  I suggest
something like:

  PCI: cadence: Allow PTM Responder to be enabled

> > > I think that would be the correct behavior per PCIe r6.0, sec
> > > 7.9.15.2, and it would avoid the confusion of having the PTM
> > > Capability register advertise functionality that cannot be enabled via
> > > the PTM Control register.
