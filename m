Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081F5147A9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiD2K7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiD2K7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 06:59:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1425CB53C4;
        Fri, 29 Apr 2022 03:56:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18271063;
        Fri, 29 Apr 2022 03:56:34 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.10.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4899B3F73B;
        Fri, 29 Apr 2022 03:56:33 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:56:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
Message-ID: <20220429105627.GA28438@lpieralisi>
References: <20220218132037.GA345784@bhelgaas>
 <116138f6-8f44-66be-c6b9-ccfbab6b8ca2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116138f6-8f44-66be-c6b9-ccfbab6b8ca2@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 07:40:54PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On 18/02/22 6:50 pm, Bjorn Helgaas wrote:
> > On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Bjorn,
> >>
> >> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> >>> Update subject line to match previous conventions ("git log --oneline
> >>> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> >>>
> >>> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> >>>> This enables the Controller [RP] to automatically respond
> >>>> with Response/ResponseD messages.
> >>>
> > 
> >>>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> >>>> +{
> >>>> +	u32 val;
> >>>> +
> >>>> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> >>>> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> >>>
> >>> I assume this is some device-specific enable bit that is effectively
> >>> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> >>> Capability?
> >>
> >> That's correct. This bit enables Controller [RP] to respond to the
> >> received PTM Requests.
> > 
> > Great!  Christian, can you update the commit log to reflect that
> > both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> > respond to received PTM Requests?
> > 
> > When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> > and the PTM Responder Capable bit (for which we don't have a #define)
> > read as zero?
> 
> I see both PTM Responder Capable bit and PTM Root Capable is by-default set to '1'.

Without this patch applied and with no other SW setting
CDNS_PCIE_LM_TPM_CTRL_PTMRSEN, correct ?

> 
> root@am64xx-evm:~# devmem2 0xD000A24
> 
> 
> /dev/mem opened.
> Memory mapped at address 0xffffa8980000.
> Read at address  0x0D000A24 (0xffffa8980a24): 0x00000406
> 
> And this bit can be programmed through the local management APB
> interface if required.

Which bit ? CDNS_PCIE_LM_TPM_CTRL_PTMRSEN ?

> But with this patch which enables PTM by default for RC, it wouldn't be required
> to clear those bits.

Yes but that does not comply with the specifications as Bjorn pointed
out below.

We can merge this patch but it would be good to investigate on this
point.

Thanks,
Lorenzo

> Thanks,
> Kishon
> > 
> > I think that would be the correct behavior per PCIe r6.0, sec
> > 7.9.15.2, and it would avoid the confusion of having the PTM
> > Capability register advertise functionality that cannot be enabled via
> > the PTM Control register.
> > 
> >>>> +/* PTM Control Register */
> >>>> +#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)
> > 
> > Other #defines in this file use lower-case hex.
> > 
> > Bjorn
> > 
