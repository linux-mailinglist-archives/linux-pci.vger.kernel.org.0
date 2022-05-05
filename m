Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC151C2EF
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiEEOxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 10:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiEEOxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 10:53:33 -0400
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 07:49:52 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCB5AEDE;
        Thu,  5 May 2022 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651761829;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cA4Wv8HRpqAKkPZZgC2h6accBFPuf3HpA1iKCo9ljzU=;
    b=RVxMgdleQOr5cAjDlHZbbScgheibVj5iqD725JDXSI1L3XjfaxNRFrc7Zrs2lqytb+
    ra/nN6qIDUYd8m7tfjLWTonQQCYnrc220DJRITqGNcrFRE40V+qiw+Wvy+dCNZlE/DcF
    laSUUPJ+4IqbPOKWqzudOk6wS9Qn74E5Qmo1kS1oVr7zfjXwbDkFFgaeKd/3ayI0TWHf
    Yqpiju5EqgPAXN6cIn8FDfSFvQyKdGbYlAEmWo8cfxHphwa5p0l0ntOOTP4RLYzhZFh9
    Nr+XeCpOzWC2D9jP/UYqpKuMpXV6Vg9tcuxCu0N/2L4wFQakEPaXo++wU2uahx5II1d+
    b5Gg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtcDbyXY4u81dhna3k4s="
X-RZG-CLASS-ID: mo00
Received: from JADEVM-DRA
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id j062fay45EhmS7T
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 5 May 2022 16:43:48 +0200 (CEST)
Date:   Thu, 5 May 2022 16:43:47 +0200
From:   Dominic Rath <dominic.rath@ibv-augsburg.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <20220505144347.GA19346@JADEVM-DRA>
References: <20220429105627.GA28438@lpieralisi>
 <20220429192825.GA82239@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429192825.GA82239@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 02:28:25PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 29, 2022 at 11:56:27AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Feb 22, 2022 at 07:40:54PM +0530, Kishon Vijay Abraham I wrote:
> > > On 18/02/22 6:50 pm, Bjorn Helgaas wrote:
> > > > On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> > > >> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > > >>> Update subject line to match previous conventions ("git log --oneline
> > > >>> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> > > >>>
> > > >>> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> > > >>>> This enables the Controller [RP] to automatically respond
> > > >>>> with Response/ResponseD messages.
> > > > 
> > > >>>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> > > >>>> +{
> > > >>>> +	u32 val;
> > > >>>> +
> > > >>>> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> > > >>>> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> > > >>>
> > > >>> I assume this is some device-specific enable bit that is effectively
> > > >>> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > > >>> Capability?
> > > >>
> > > >> That's correct. This bit enables Controller [RP] to respond to the
> > > >> received PTM Requests.
> > > > 
> > > > Great!  Christian, can you update the commit log to reflect that
> > > > both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> > > > respond to received PTM Requests?
> > > > 
> > > > When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> > > > and the PTM Responder Capable bit (for which we don't have a #define)
> > > > read as zero?
> > > 
> > > I see both PTM Responder Capable bit and PTM Root Capable is
> > > by-default set to '1'.
> > 
> > Without this patch applied and with no other SW setting
> > CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, correct ?
 
Yes. The capability bits default to '1', even if
CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared. Strictly speaking the current
behavior is wrong, and the capability bits should be cleared instead.

> > > root@am64xx-evm:~# devmem2 0xD000A24
> > > 
> > > /dev/mem opened.
> > > Memory mapped at address 0xffffa8980000.
> > > Read at address  0x0D000A24 (0xffffa8980a24): 0x00000406
> > > 
> > > And this bit can be programmed through the local management APB
> > > interface if required.
> > 
> > Which bit ? CDNS_PCIE_LM_TPM_CTRL_PTMRSEN ?

I believe "these bits" would have been more correct. Since these are
capability bits, the AM64* TRM lists them as read-only, but of course
they can be modified. To write them, you need to set bit [21], e.g.
you can write the PTM capability register at address 0xD200A24. At
the TRM address 0xD000A24 it is read-only.

> > 
> > > But with this patch which enables PTM by default for RC, it
> > > wouldn't be required to clear those bits.
> > 
> > Yes but that does not comply with the specifications as Bjorn
> > pointed out below.
> > 
> > We can merge this patch but it would be good to investigate on this
> > point.
> 
> I *think* this is OK.  Correct me if I'm wrong:
> 
>   - We're talking about a Root Port.
> 
>   - The Root Port's PTM Capability reads as 0x00000406 (PTM Responder
>     Capable and PTM Root Capable set).
> 
>   - Without this patch, setting PTM Enable does nothing, and the Root
>     Port does not send PTM Responses.
> 
>     This is the non-conforming situation because the Port claims that
>     it implements the PTM Responder role, but it can't actually be
>     enabled.
> 
>   - With this patch that sets CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
>     Enable bit still powers up as zero, so the Port does not send PTM
>     Responses, but setting PTM Enable enables PTM Responses from the
>     Root Port.

This is correct.

> 
> So I think that after setting CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, the PTM
> capability works as per spec.
> 
> I think the proposed subject of "Enable Controller to respond to
> received PTM Requests" is somewhat misleading, though, because PTM
> responses still aren't enabled until we set PTM Enable.  I suggest
> something like:
> 
>   PCI: cadence: Allow PTM Responder to be enabled

I'll ask Christian for permission to resend his patch with the subject
changed.

> > > > I think that would be the correct behavior per PCIe r6.0, sec
> > > > 7.9.15.2, and it would avoid the confusion of having the PTM
> > > > Capability register advertise functionality that cannot be enabled via
> > > > the PTM Control register.
