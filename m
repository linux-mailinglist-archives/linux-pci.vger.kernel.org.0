Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C971160E0D0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiJZMgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiJZMgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 08:36:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67989AF0;
        Wed, 26 Oct 2022 05:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9DFFBCE2064;
        Wed, 26 Oct 2022 12:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60F2C433C1;
        Wed, 26 Oct 2022 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666787766;
        bh=YWJiKbTDo7BBU/+ElSXgovuFpGfSmV2ja7uG120+Lbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiS7cv7wKgfyH+uOcl5q3hWrTGqcIesy5/Zm0tfpkNzR7Ivw+lZ+t8G1GhpqFUJt8
         vHy7lV9WV/GADxmMwZwlMOtY1iqH0eLOO+4RgGG7Ju8YbQEXxuYenQczP0EyMlLJHj
         UGk/9mOQrZMcUIIRQkt5cxKrm5Tokbppxu7zcQrYAM8aDxnfqg8jjfiP5CgPloBI6U
         ErnnkcQG+SfrDCF0s1cLkAz6U/CCjCTG0yhNaswEttOLJ0HtOwtiGpikX0sl+7XGvB
         cByr6hjRLC0BUEivouXfgmJpcAoOK6vsjj8dXCT1bAWNxRbDIDfWqhAsnStp/PJPm/
         4UsGaYcwP03Hg==
Date:   Wed, 26 Oct 2022 14:36:01 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for
 PCIe Completion Timeout
Message-ID: <Y1kpsU9fflhF+24L@lpieralisi>
References: <20220802123816.21817-1-pali@kernel.org>
 <20220926123434.2tqx4t6u3cnlrcx3@pali>
 <BN9PR18MB425117376E64340DED894178DB549@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20221003211412.5pqfjvcxyszd4ai6@pali>
 <YzvomObCatuKMujz@lpieralisi>
 <20221004083957.qtfkn4eyi42lsd4j@pali>
 <BN9PR18MB4251C2684FD21D8A2DE5522FDB5C9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <Y1JXp8S76dRrX5bT@lpieralisi>
 <BN9PR18MB425103A4A6DEF6ACB9358908DB2F9@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB425103A4A6DEF6ACB9358908DB2F9@BN9PR18MB4251.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 23, 2022 at 09:21:42AM +0000, Elad Nachman wrote:
> Hi,
> 
> DIS_ORD_CHK - Disable Ordering Checks.
> Setting this bit to 1 disables the ordering check in the core
> between Completions and Posted requests received from the
> link
> 
> Testing - I think Pali has 3700 boards, I don't have any.
> 
> The memory barrier is delaying the ability of the host to access the memory before the update is completed. This is not a bullet proof fix, it is just meant as a way to reduce the probability of this happening.
> Hence it is optional; I think it is better to have it, but it is not part of the original workaround.
> Once again - if the above explanation is not satisfactory, the patch can be reposted without the memory barrier.

It is not satisfactory so it should be dropped from the patch.

Thanks,
Lorenzo

> FYI,
> 
> Elad.
> 
> -----Original Message-----
> From: Lorenzo Pieralisi <lpieralisi@kernel.org> 
> Sent: Friday, October 21, 2022 11:26 AM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Pali Rohár <pali@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Krzysztof Wilczyński <kw@linux.com>; linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround for PCIe Completion Timeout
> 
> On Thu, Oct 06, 2022 at 08:14:48AM +0000, Elad Nachman wrote:
> > Hi,
> > 
> > Regarding number #1 :
> > The H/W erratum means strong ordering mode is not properly implemented 
> > in the H/W.  The workaround is to set DIS_ORD_CHK to disable the 
> > ordered check, to prevent the issues Pali mentioned.  Leaving it 
> > without the workaround means encountering the crashes Pali mentioned.
> > The H/W was originally designed to have the strong ordering mode, per 
> > what is expected of PCI Express, but due to this erratum, it cannot be 
> > supported by the taped-out H/W.  There is nothing to do about it now 
> > in the H/W, as this is a years old SOC.  Software wise the only option 
> > is the workaround above, or to accept sporadic crashes of the kernel.
> 
> It can fix a driver, it can break another one - the PCI ordering model is broken one way or another.
> 
> I have no way to determine what setting DIS_ORD_CHK does and what it implies.
> 
> What I know is that we are sending this patch to stable kernels and I want to make sure a) it was thoroughly tested on several PCI endpoints and b) it is properly documented.
> 
> > The impact of the workaround is that the DMA done status could be set 
> > before the last data is written to the host memory, causing the host 
> > to read incomplete data. This is the reason why I recommended to add a 
> > memory barrier. If this is bothering, the memory barrier can be 
> > removed from the patch, although I suggest to thoroughly test the data 
> > integrity if implementing the patch without the memory barrier.
> 
> It is not bothering, it is that every mb() must be explained in depth.
> 
> We are adding an mb() in the *controller* interrupt handler.
> 
> I assume this is because that's where the DMA completion IRQ is raised and there we issue an mb() to make sure that endpoint writes into memory completed.
> 
> If that's correct, I have no idea how the barrier plays together with DIS_ORD_CHK above. The mb() has no effect on PCI writes queued in the PCI bus, so it may be a plaster but not a fix.
> 
> I would like to have a full description of what that mb() is supposed to fix - in details.
> 
> When we agree it is fixing something we can add a descriptive comment with the mb() and merge the code.
> 
> Thanks,
> Lorenzo
> 
> > FYI,
> > 
> > Elad.
> > 
> > -----Original Message-----
> > From: Pali Rohár <pali@kernel.org>
> > Sent: Tuesday, October 4, 2022 11:40 AM
> > To: Elad Nachman <enachman@marvell.com>; Lorenzo Pieralisi 
> > <lpieralisi@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Krzysztof Wilczyński 
> > <kw@linux.com>; linux-pci@vger.kernel.org; 
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH v2] PCI: aardvark: Implement workaround 
> > for PCIe Completion Timeout
> > 
> > + Elad
> > 
> > Could you please look at Lorenzo's comments and help with this fix?
> > 
> > On Tuesday 04 October 2022 10:02:32 Lorenzo Pieralisi wrote:
> > > On Mon, Oct 03, 2022 at 11:14:12PM +0200, Pali Rohár wrote:
> > > > Lorenzo, is something more needed for this patch? As it 
> > > > workarounds crashing it is really needed to have it in mainline and backports.
> > > 
> > > Yes, a clear explanation from Marvell about what this is actually 
> > > fixing - it took me a while to go through the whole thread but I 
> > > still don't understand what this patch actually does and why.
> > > 
> > > An Erratum workaround (if there is any) should define and explain a 
> > > SW workaround.
> > > 
> > > (1) Bjorn's concerns in relation to PCI memory model weren't 
> > > addressed
> > > (2) We don't add undocumented memory barriers to the kernel to "minimize
> > >     risks". Either we fix a bug or we don't. If we do, write that down
> > >     and document why the barrier is there and the issue it solves.
> > > 
> > > I understand that basically you are reverse engineering a HW bug but 
> > > I am afraid we can't fix the kernel this way - more so with patches 
> > > going to be backported to stable kernels.
> > > 
> > > Lorenzo
> > > 
> > > > On Wednesday 28 September 2022 14:05:10 Elad Nachman wrote:
> > > > > Reviewed-by: Elad Nachman <enachman@marvell.com>
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Elad.
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Pali Rohár <pali@kernel.org>
> > > > > Sent: Monday, September 26, 2022 3:35 PM
> > > > > To: Elad Nachman <enachman@marvell.com>
> > > > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Lorenzo 
> > > > > Pieralisi <lpieralisi@kernel.org>; Bjorn Helgaas 
> > > > > <bhelgaas@google.com>; Krzysztof Wilczyński <kw@linux.com>; Rob 
> > > > > Herring <robh@kernel.org>; linux-pci@vger.kernel.org; 
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org; Gregory Clement 
> > > > > <gregory.clement@bootlin.com>; Marek Behún <kabel@kernel.org>; 
> > > > > Remi Pommarel <repk@triplefau.lt>; Xogium <contact@xogium.me>; 
> > > > > Tomasz Maciej Nowak <tmn505@gmail.com>
> > > > > Subject: [EXT] Re: [PATCH v2] PCI: aardvark: Implement 
> > > > > workaround for PCIe Completion Timeout
> > > > > 
> > > > > External Email
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > --
> > > > > ---- Hello Elad, could you please review this patch? I have 
> > > > > implemented it according your instructions, including that full memory barrier as you described.
> > > > > 
> > > > > On Tuesday 02 August 2022 14:38:16 Pali Rohár wrote:
> > > > > > Marvell Armada 3700 Functional Errata, Guidelines, and 
> > > > > > Restrictions document describes in erratum 3.12 PCIe Completion Timeout (Ref #:
> > > > > > 251), that PCIe IP does not support a strong-ordered model for inbound posted vs.
> > > > > > outbound completion.
> > > > > > 
> > > > > > As a workaround for this erratum, DIS_ORD_CHK flag in Debug 
> > > > > > Mux Control register must be set. It disables the ordering 
> > > > > > check in the core between Completions and Posted requests received from the link.
> > > > > > 
> > > > > > Marvell also suggests to do full memory barrier at the 
> > > > > > beginning of aardvark summary interrupt handler before calling 
> > > > > > interrupt handlers of endpoint drivers in order to minimize 
> > > > > > the risk for the race condition documented in the Erratum 
> > > > > > between the DMA done status reading and the completion of writing to the host memory.
> > > > > > 
> > > > > > More details about this issue and suggested workarounds are in discussion:
> > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kern
> > > > > > el
> > > > > > .org_l
> > > > > > inux-2Dpci_BN9PR18MB425154FE5019DCAF2028A1D5DB8D9-40BN9PR18MB4
> > > > > > 25
> > > > > > 1.namp
> > > > > > rd18.prod.outlook.com_t_-23u&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ
> > > > > > &r
> > > > > > =eTeNT
> > > > > > LEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=bjgkhgPgOjqCEsbHYHONC
> > > > > > ZM
> > > > > > iFDX72
> > > > > > MztWaE0AvWBktQVn3zKEDtUdn02Kx_KJ14B&s=SToGsDGEObwbZGilVtVZPyME
> > > > > > 8j
> > > > > > NiRgrq
> > > > > > 4SDYvqqT0TA&e=
> > > > > > 
> > > > > > It was reported that enabling this workaround fixes 
> > > > > > instability issues and "Unhandled fault" errors when using 60 
> > > > > > GHz WiFi 802.11ad card with Qualcomm
> > > > > > QCA6335 chip under significant load which were caused by 
> > > > > > interrupt status stuck in the outbound CMPLT queue traced back to this erratum.
> > > > > > 
> > > > > > This workaround fixes also kernel panic triggered after some 
> > > > > > minutes of usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:
> > > > > > 
> > > > > >     Internal error: synchronous external abort: 96000210 [#1] SMP
> > > > > >     Kernel panic - not syncing: Fatal exception in interrupt
> > > > > > 
> > > > > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host 
> > > > > > controller
> > > > > > driver")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > ---
> > > > > >  drivers/pci/controller/pci-aardvark.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c
> > > > > > b/drivers/pci/controller/pci-aardvark.c
> > > > > > index 060936ef01fe..3ae8a85ec72e 100644
> > > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > > @@ -210,6 +210,8 @@ enum {
> > > > > >  };
> > > > > >  
> > > > > >  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
> > > > > > +#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
> > > > > > +#define     DIS_ORD_CHK				BIT(30)
> > > > > >  
> > > > > >  /* PCIe core controller registers */
> > > > > >  #define CTRL_CORE_BASE_ADDR			0x18000
> > > > > > @@ -558,6 +560,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > > > > >  		PCIE_CORE_CTRL2_TD_ENABLE;
> > > > > >  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> > > > > >  
> > > > > > +	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
> > > > > > +	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
> > > > > > +	reg |= DIS_ORD_CHK;
> > > > > > +	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
> > > > > > +
> > > > > >  	/* Set lane X1 */
> > > > > >  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> > > > > >  	reg &= ~LANE_CNT_MSK;
> > > > > > @@ -1581,6 +1588,9 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
> > > > > >  	struct advk_pcie *pcie = arg;
> > > > > >  	u32 status;
> > > > > >  
> > > > > > +	/* Full memory barrier (ARM dsb sy), workaround for erratum 3.12 "PCIe completion timeout" */
> > > > > > +	mb();
> > > > > > +
> > > > > >  	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
> > > > > >  	if (!(status & PCIE_IRQ_CORE_INT))
> > > > > >  		return IRQ_NONE;
> > > > > > --
> > > > > > 2.20.1
> > > > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.
> > > > org_mailman_listinfo_linux-2Darm-2Dkernel&d=DwIDaQ&c=nKjWec2b6R0mO
> > > > yP 
> > > > az7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=2NzkT9KLO2
> > > > 6k 
> > > > efUOw2nIeSeRnJVZLxEiBXqEoRvDQ0ueww6n4YaXWgAN1uCJX20o&s=nczACS_2jER
> > > > bA
> > > > -c4Gfar0-HTA4PtvZdJmsBv8jhW8G0&e=
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.or
> > g_mailman_listinfo_linux-2Darm-2Dkernel&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=-FeSXS0gjIWGU0Oxsu2v1CLdlQI6QC3Egv2XQPD76Ng-wAeAtBrOnqEsHp9dmmko&s=OEUpcIK-9uWHm2WsP02xlH1AXc90FoSVzklrfHhQgPY&e=
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
