Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F626066CD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJTRMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 13:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJTRMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 13:12:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560C1A9109;
        Thu, 20 Oct 2022 10:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3AC3B826AE;
        Thu, 20 Oct 2022 17:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF1CC433C1;
        Thu, 20 Oct 2022 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666285934;
        bh=JAbklPdWA2kNdSMvOQRBF6Ch5NifGjOncSXTOt9A7WA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YBU+i3Rc69OnfayDbsDVf6+t8E46fzm125M6mX9NwPHQ3cKl4b97FDk86RC+wM4RA
         Mh3HPnilZs66oyCdtApQnm12b20T7bAdSPngYTU/D9Y80e6AbetSqF9cdFH4xTD0PI
         x4iCZ2gvczPrXiOX7L8lKbSoOaqIwg3+sATUtcbhtbIJttHz8devZSK+gAUZEwu2VE
         kVWhREi3ZkyS+2L32w9RD5hAC/17hvMsdMl/hGhCobBAZkmCVunL/Gw/cEck1Q7kPz
         A8nrKmZcajXQT3OaHB2pX1bNHrtwMfgffPVPvYLaEptMd7t3poN2D70CL2HFQUOKdT
         jBkEEaFDkN82w==
Date:   Thu, 20 Oct 2022 12:12:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for
 PCIe Completion Timeout
Message-ID: <20221020171212.GA132958@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB4251C2684FD21D8A2DE5522FDB5C9@BN9PR18MB4251.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 08:14:48AM +0000, Elad Nachman wrote:
> Hi,
> 
> Regarding number #1 :
> The H/W erratum means strong ordering mode is not properly
> implemented in the H/W.  The workaround is to set DIS_ORD_CHK to
> disable the ordered check, to prevent the issues Pali mentioned.
>
> Leaving it without the workaround means encountering the crashes
> Pali mentioned.  The H/W was originally designed to have the strong
> ordering mode, per what is expected of PCI Express, but due to this
> erratum, it cannot be supported by the taped-out H/W.  There is
> nothing to do about it now in the H/W, as this is a years old SOC.
> Software wise the only option is the workaround above, or to accept
> sporadic crashes of the kernel.
> 
> Regarding number #2 :
> The impact of the workaround is that the DMA done status could be
> set before the last data is written to the host memory, causing the
> host to read incomplete data. This is the reason why I recommended
> to add a memory barrier. If this is bothering, the memory barrier
> can be removed from the patch, although I suggest to thoroughly test
> the data integrity if implementing the patch without the memory
> barrier.

Thank you very much for these details, Elad.

If I understand correctly, this patch avoids many issues (or at least
makes them much less likely), but there is still a small possibility
of corner cases where a correctly-written driver would work on other
platforms but not on this hardware.

Since this definitely improves things dramatically, I think it's worth
doing even if it's not absolutely 100%.  The commit log and code
comments should be enough of a hint.

> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: Tuesday, October 4, 2022 11:40 AM
> To: Elad Nachman <enachman@marvell.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Krzysztof Wilczyński <kw@linux.com>; linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for PCIe Completion Timeout
> 
> + Elad
> 
> Could you please look at Lorenzo's comments and help with this fix?
> 
> On Tuesday 04 October 2022 10:02:32 Lorenzo Pieralisi wrote:
> > On Mon, Oct 03, 2022 at 11:14:12PM +0200, Pali Rohár wrote:
> > > Lorenzo, is something more needed for this patch? As it workarounds 
> > > crashing it is really needed to have it in mainline and backports.
> > 
> > Yes, a clear explanation from Marvell about what this is actually 
> > fixing - it took me a while to go through the whole thread but I still 
> > don't understand what this patch actually does and why.
> > 
> > An Erratum workaround (if there is any) should define and explain a SW 
> > workaround.
> > 
> > (1) Bjorn's concerns in relation to PCI memory model weren't addressed
> > (2) We don't add undocumented memory barriers to the kernel to "minimize
> >     risks". Either we fix a bug or we don't. If we do, write that down
> >     and document why the barrier is there and the issue it solves.
> > 
> > I understand that basically you are reverse engineering a HW bug but I 
> > am afraid we can't fix the kernel this way - more so with patches 
> > going to be backported to stable kernels.
> > 
> > Lorenzo
> > 
> > > On Wednesday 28 September 2022 14:05:10 Elad Nachman wrote:
> > > > Reviewed-by: Elad Nachman <enachman@marvell.com>
> > > > 
> > > > Thanks,
> > > > 
> > > > Elad.
> > > > 
> > > > -----Original Message-----
> > > > From: Pali Rohár <pali@kernel.org>
> > > > Sent: Monday, September 26, 2022 3:35 PM
> > > > To: Elad Nachman <enachman@marvell.com>
> > > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Lorenzo 
> > > > Pieralisi <lpieralisi@kernel.org>; Bjorn Helgaas 
> > > > <bhelgaas@google.com>; Krzysztof Wilczyński <kw@linux.com>; Rob 
> > > > Herring <robh@kernel.org>; linux-pci@vger.kernel.org; 
> > > > linux-arm-kernel@lists.infradead.org; 
> > > > linux-kernel@vger.kernel.org; Gregory Clement 
> > > > <gregory.clement@bootlin.com>; Marek Behún <kabel@kernel.org>; 
> > > > Remi Pommarel <repk@triplefau.lt>; Xogium <contact@xogium.me>; 
> > > > Tomasz Maciej Nowak <tmn505@gmail.com>
> > > > Subject: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround 
> > > > for PCIe Completion Timeout
> > > > 
> > > > External Email
> > > > 
> > > > ------------------------------------------------------------------
> > > > ---- Hello Elad, could you please review this patch? I have 
> > > > implemented it according your instructions, including that full memory barrier as you described.
> > > > 
> > > > On Tuesday 02 August 2022 14:38:16 Pali Rohár wrote:
> > > > > Marvell Armada 3700 Functional Errata, Guidelines, and 
> > > > > Restrictions document describes in erratum 3.12 PCIe Completion Timeout (Ref #:
> > > > > 251), that PCIe IP does not support a strong-ordered model for inbound posted vs.
> > > > > outbound completion.
> > > > > 
> > > > > As a workaround for this erratum, DIS_ORD_CHK flag in Debug Mux 
> > > > > Control register must be set. It disables the ordering check in 
> > > > > the core between Completions and Posted requests received from the link.
> > > > > 
> > > > > Marvell also suggests to do full memory barrier at the beginning 
> > > > > of aardvark summary interrupt handler before calling interrupt 
> > > > > handlers of endpoint drivers in order to minimize the risk for 
> > > > > the race condition documented in the Erratum between the DMA 
> > > > > done status reading and the completion of writing to the host memory.
> > > > > 
> > > > > More details about this issue and suggested workarounds are in discussion:
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel
> > > > > .org_l 
> > > > > inux-2Dpci_BN9PR18MB425154FE5019DCAF2028A1D5DB8D9-40BN9PR18MB425
> > > > > 1.namp 
> > > > > rd18.prod.outlook.com_t_-23u&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r
> > > > > =eTeNT
> > > > > LEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=bjgkhgPgOjqCEsbHYHONCZM
> > > > > iFDX72 
> > > > > MztWaE0AvWBktQVn3zKEDtUdn02Kx_KJ14B&s=SToGsDGEObwbZGilVtVZPyME8j
> > > > > NiRgrq
> > > > > 4SDYvqqT0TA&e=
> > > > > 
> > > > > It was reported that enabling this workaround fixes instability 
> > > > > issues and "Unhandled fault" errors when using 60 GHz WiFi 
> > > > > 802.11ad card with Qualcomm
> > > > > QCA6335 chip under significant load which were caused by 
> > > > > interrupt status stuck in the outbound CMPLT queue traced back to this erratum.
> > > > > 
> > > > > This workaround fixes also kernel panic triggered after some 
> > > > > minutes of usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:
> > > > > 
> > > > >     Internal error: synchronous external abort: 96000210 [#1] SMP
> > > > >     Kernel panic - not syncing: Fatal exception in interrupt
> > > > > 
> > > > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host 
> > > > > controller
> > > > > driver")
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c
> > > > > b/drivers/pci/controller/pci-aardvark.c
> > > > > index 060936ef01fe..3ae8a85ec72e 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -210,6 +210,8 @@ enum {
> > > > >  };
> > > > >  
> > > > >  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
> > > > > +#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
> > > > > +#define     DIS_ORD_CHK				BIT(30)
> > > > >  
> > > > >  /* PCIe core controller registers */
> > > > >  #define CTRL_CORE_BASE_ADDR			0x18000
> > > > > @@ -558,6 +560,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > > > >  		PCIE_CORE_CTRL2_TD_ENABLE;
> > > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> > > > >  
> > > > > +	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
> > > > > +	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
> > > > > +	reg |= DIS_ORD_CHK;
> > > > > +	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
> > > > > +
> > > > >  	/* Set lane X1 */
> > > > >  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > > > >  	reg &= ~LANE_CNT_MSK;
> > > > > @@ -1581,6 +1588,9 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
> > > > >  	struct advk_pcie *pcie = arg;
> > > > >  	u32 status;
> > > > >  
> > > > > +	/* Full memory barrier (ARM dsb sy), workaround for erratum 3.12 "PCIe completion timeout" */
> > > > > +	mb();
> > > > > +
> > > > >  	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
> > > > >  	if (!(status & PCIE_IRQ_CORE_INT))
> > > > >  		return IRQ_NONE;
> > > > > --
> > > > > 2.20.1
> > > > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.
> > > org_mailman_listinfo_linux-2Darm-2Dkernel&d=DwIDaQ&c=nKjWec2b6R0mOyP
> > > az7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=2NzkT9KLO26k
> > > efUOw2nIeSeRnJVZLxEiBXqEoRvDQ0ueww6n4YaXWgAN1uCJX20o&s=nczACS_2jERbA
> > > -c4Gfar0-HTA4PtvZdJmsBv8jhW8G0&e=
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
