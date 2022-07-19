Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEBA579AC3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiGSMSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiGSMRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 08:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9A564DF;
        Tue, 19 Jul 2022 05:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25896175E;
        Tue, 19 Jul 2022 12:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6A4C341CB;
        Tue, 19 Jul 2022 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658232376;
        bh=uwACB1yuObS8U+E/T/PUesn+NshojJNg3KPoba6GifE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5nrzWujzDqIndV4XVXajZPIvbUcjqKAtF6FAI5FhVGpEn7ny8uokTaD5IBVi1Lht
         AOh0+8o1yyA7lmyryyYP23TFBDq5QYHiRH1d3jfkQdmk5KuVNbRwTfvSj6npmSejGk
         X+U2W57C4AwDaUUCnb4aZcTDlwBThQ0WjrlRepIyH/nNHVBjF01oLCs33iAl/m4WUP
         EW9nb/MI+C2MZUIGQ2sqE4YmJoAve+kBs6EKV3LQdjvBNTaeqX0t/9wXKzjZroeU/w
         mXK5EIUY8ly4aDHEJxZeuLcCy+0J1qwr2KBbcim/6QL036N6nrurrzScIWYVUVWPd5
         n5DAexrtujngg==
Received: by pali.im (Postfix)
        id D46B4F3C; Tue, 19 Jul 2022 14:06:12 +0200 (CEST)
Date:   Tue, 19 Jul 2022 14:06:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Arun Easi <aeasi@marvell.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Subject: Re: [EXT] Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20220719120612.eziy4magdznr6uek@pali>
References: <20210723221710.wtztsrddudnxeoj3@pali>
 <20220216200940.fwdwk5rcb4zq6dyg@pali>
 <20220710112108.jegpz4khfsrb4ahd@pali>
 <BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220719093323.nzkpe2kcibszzgzm@pali>
 <BN9PR18MB4251243341CBA5A66107F6ADDB8F9@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB4251243341CBA5A66107F6ADDB8F9@BN9PR18MB4251.namprd18.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Elad and thank you for information!

I have looked at register 0x40000408, but it cannot be accessed from
A3720 ARM A53 core, because that register is in address space of secure
ARM CM3 core, to which Linux kernel does not access.

I looked into my notes and bit 6 of register 0x40000408 controls AXI
SLVERR propagation just from BCM slave to CM3 core. BCM is Base
cryptographic module, which is used by the secure firmware running on
CM3 core. So it looks like it is irrelevant to ARM A53 cores on which is
running Linux kernel and which receive these crashes, and also does not
apply for PCIe AXI slave which is connected A3720 South Fabric.
I guess that register 0x40000408 controls only Fabric directly connected
to ARM CM3 core.

So it is needed to know what is equivalent register for A53 and A3720
South Fabric. Or register specific for A3720 PCIe block, so for
Unsupported Request, Completer Abort, Configuration request retry status
and Completion Timeout does not throw AXI SLVERR to A53 core.

Whole description of errata is important for kernel developers /
maintainers who will be reviewing code. We do not need whole document,
just that one errata. It would really help if Marvell could get
permission for sharing this errata for kernel developers. Because it is
really a pain if every kernel developer has to go throw NDA/LULA process
and wait for Sales team if they approve access or not.

In past documentation for Marvell SoCs was public and every developer
was able to download it from marvell.com website without registration.
But now all links to public documentation do not work anymore.
Thankfully web.archive.org created backup of some of them and they are
linked from Kernel documentation file:
https://www.kernel.org/doc/html/latest/arm/marvell.html
(see how many documents were lost...)

Anyway, I have access to Marvell portal and some A3720 documents, but
lot of parts in those documents to which I have access are incomplete
or registers undocumented.

So to recap, workaround should be to disable ordering checks via
DIS_ORD_CHK bit, adding DSB barrier when entering aardvark summary irq
handler and ideally also enable relaxed ordering bit, so initiated
transactions could use relaxed ordering when requested (as strong
ordering does not work).

On Tuesday 19 July 2022 10:50:59 Elad Nachman wrote:
> Hi Pali,
> 
> Regarding your request - while I understand the need, I am bound by the internal regulation set forth by my employer.
> Passing of any document must by done via the Marvell Support site following account creation with the proper NDA and LULA (Limited Use License Agreement) in place.
> Unfortunately I do not have the power to bypass this internal, hard requirement.
> Anyone needing these documents should apply for a Marvell support site account.
> I can try to expedite request internally or if an account is set in place, request on your behalf access to Aramda 37xx documents.
> The final decision is of the Marvell Support and sales.
> 
> Regarding AXI SLVERR, this is the propagation of the following PCIe errors: Unsupported Request, Completer Abort, Configuration request retry status and Completion Timeout.
> 
> To prevent SLVERR generated for out-of-range errors, clear bit 6 (0x40) of register 0x40000408 (physical address).
> 
> Regarding ordering model, Erratum is a description of the final HW behavior which deviates from the design.
> The design was meant to support strong ordering, unfortunately due to some kind of mis-implementation, this feature does not work as designed. The erratum is designed to provide a workaround, which perhaps is not perfect (which why you are confused as to what ordering model is supported), but is the best available with the actual physical HW behavior.
> 
> Regarding the Relaxed ordering bit you have described, this bit only controls whether the relaxed ordering bit can be set in the attribute fields of the transactions initiated by it. 
> I agree, however, that to be fully coherent in the driver software design with the workaround implementation, I would set this bit, although it is not required by the Erratum workaround.
> 
> Regarding the memory barrier, you understood me perfectly. I think DSB should be executed by the Aardvark IRQ handler before invoking the PCI EP IRQ driver handler.
> 
> Elad.
> 
> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: Tuesday, July 19, 2022 12:33 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Ratheesh Kannoth <rkannoth@marvell.com>; Tanmay Jagdale <tanmay@marvell.com>; Shijith Thotton <sthotton@marvell.com>; Arun Easi <aeasi@marvell.com>; Krzysztof Wilczyński <kw@linux.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Bjorn Helgaas <bhelgaas@google.com>; Marek Behún <kabel@kernel.org>; Remi Pommarel <repk@triplefau.lt>; Xogium <contact@xogium.me>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Bharat Bhushan <bbhushan2@marvell.com>; Veerasenareddy Burru <vburru@marvell.com>; Wojciech Bartczak <wbartczak@marvell.com>
> Subject: Re: [EXT] Re: Issues with A3720 PCIe controller driver pci-aardvark.c
> 
> Hello Elad!
> 
> Thank you very much for your response! Together with Krzysztof we were unable to get any response regarding this issue for more than year.
> 
> I would kindly ask if you/Marvell could publish description of this errata to Linux kernel developers, so more kernel developers can look at it and try to implement workarounds.
> 
> Together with Krzysztof we have really an issue to retrieve any kind of documentation or user guide for Armada 3720 erratas/bugs.
> 
> Rest of my comments I'm putting inline below.
> 
> On Sunday 17 July 2022 09:47:14 Elad Nachman wrote:
> > Hi Pali,
> > 
> > Can you please indicate what is the HW source (e.g. which register in the PCIe controller) bits is translated to the fatal abort?
> 
> I observed this fatal abort on CPU when endpoint PCIe card sent interrupt to A3720 PCIe controller and interrupt handler in driver for endpoint card did PCIe memory write to PCIe card memory space.
> 
> Writing to PCIe address range for PCIe MEM of endpoint card cause that
> A3720 PCIe controller sends fatal unrecoverable error to CPU.
> 
> Here is the crashlog from mediatek wifi card which I captured year ago.
> 
> [   71.457007] Internal error: synchronous external abort: 96000210 [#1] SMP
> [   71.464021] Modules linked in: xt_connlimit pppoe ppp_async nf_conncount iptable_nat ath9k xt_state xt_nat xt_helper xt_conntrack xt_connmark xt_connbytes xt_REDIREl
> [   71.464187]  btintel br_netfilter bnep bluetooth ath9k_hw ath10k_pci ath10k_core ath sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_mg
> [   71.629589] CPU: 0 PID: 1298 Comm: kworker/u5:3 Not tainted 5.4.114 #0
> [   71.636319] Hardware name: CZ.NIC Turris Mox Board (DT)
> [   71.641725] Workqueue: napi_workq napi_workfn
> [   71.646221] pstate: 80400085 (Nzcv daIf +PAN -UAO)
> [   71.651169] pc : mt76_set_irq_mask+0x118/0x150 [mt76]
> [   71.656385] lr : mt7915_init_debugfs+0x358/0x368 [mt7915e]
> [   71.662038] sp : ffffffc010003cd0
> [   71.665451] x29: ffffffc010003cd0 x28: 0000000000000060 
> [   71.670929] x27: ffffffc010a56f98 x26: ffffffc010c0fa9a 
> [   71.676407] x25: ffffffc010ba8788 x24: ffffff803e01fe00 
> [   71.681885] x23: 0000000000000030 x22: ffffffc010003dc4 
> [   71.687361] x21: 0000000000000000 x20: ffffff803e01fea4 
> [   71.692839] x19: ffffff803cb725c0 x18: 000000002d660780 
> [   71.698317] x17: 0000000000000000 x16: 0000000000000001 
> [   71.703795] x15: 0000000000005ee0 x14: ffffffc010d1d000 
> [   71.709272] x13: 0000000000002f70 x12: 0000000000000000 
> [   71.714749] x11: 0000000000000000 x10: 0000000000000040 
> [   71.720226] x9 : ffffffc010bbe980 x8 : ffffffc010bbe978 
> [   71.725704] x7 : ffffff803e4003f0 x6 : 0000000000000000 
> [   71.731181] x5 : ffffffc02f240000 x4 : ffffffc010003e00 
> [   71.736658] x3 : 0000000000000000 x2 : ffffffc008e3f230 
> [   71.742135] x1 : 00000000000d7010 x0 : ffffffc0114d7010 
> [   71.747613] Call trace:
> [   71.750137]  mt76_set_irq_mask+0x118/0x150 [mt76]
> [   71.754990]  mt7915_dual_hif_set_irq_mask+0x108/0xdc0 [mt7915e]
> [   71.761098]  __handle_irq_event_percpu+0x6c/0x170
> [   71.765950]  handle_irq_event_percpu+0x34/0x88
> [   71.770531]  handle_irq_event+0x40/0xb0
> [   71.774486]  handle_level_irq+0xe0/0x170
> [   71.778530]  generic_handle_irq+0x24/0x38
> [   71.782667]  advk_pcie_irq_handler+0x11c/0x238
> [   71.787249]  __handle_irq_event_percpu+0x6c/0x170
> [   71.792099]  handle_irq_event_percpu+0x34/0x88
> [   71.796680]  handle_irq_event+0x40/0xb0
> [   71.800633]  handle_fasteoi_irq+0xdc/0x190
> [   71.804855]  generic_handle_irq+0x24/0x38
> [   71.808988]  __handle_domain_irq+0x60/0xb8
> [   71.813213]  gic_handle_irq+0x8c/0x198
> [   71.817077]  el1_irq+0xf0/0x1c0
> [   71.820314]  el1_da+0xc/0xc0
> [   71.823288]  mt76_set_irq_mask+0x118/0x150 [mt76]
> [   71.828141]  mt7915_mac_tx_free+0x4c4/0x828 [mt7915e]
> [   71.833352]  mt7915_queue_rx_skb+0x5c/0xa8 [mt7915e]
> [   71.838473]  mt76_dma_cleanup+0x89c/0x1248 [mt76]
> [   71.843329]  __napi_poll+0x38/0xf8
> [   71.846835]  napi_workfn+0x58/0xb0
> [   71.850342]  process_one_work+0x1fc/0x390
> [   71.854475]  worker_thread+0x48/0x4d0
> [   71.858252]  kthread+0x120/0x128
> [   71.861581]  ret_from_fork+0x10/0x1c
> [   71.865273] Code: 52800000 d65f03c0 f9562c00 8b214000 (b9400000) 
> [   71.871560] ---[ end trace 1d4e29987011411b ]---
> [   71.876320] Kernel panic - not syncing: Fatal exception in interrupt
> [   71.882875] SMP: stopping secondary CPUs
> [   71.886923] Kernel Offset: disabled
> [   71.890519] CPU features: 0x0002,00002008
> [   71.894649] Memory Limit: none
> [   71.897799] Rebooting in 3 seconds..
> 
> (in other SoC/systems, including Marvell, is this card working fine)
> 
> It is from older kernel, but issue is still there and happens also with new kernels. Mediatek driver in its interrupt handler is masking some interrupts in its interrupt handler, which is done by writing to PCIe address space of endpoint card.
> 
> Anyway, I can reproduce same crash when I set PCIe link down or reset link and trying to read from PCIe MEM or CFG space. Seems that PCIe controller incorrectly reports errors to CPU, it should return all-ones when PCIe device is not present (e.g. during link down) and not send fatal abort to CPU. I.e. instead of AXI OK with 0xffffffff data, it sends AXI SLVERR to CPU which cause that crash.
> 
> This is something which should be configurable but I'm not able to find any A3720 documentation which would describe how to configure it.
> 
> > Regarding the Erratum, basically to the best of my understanding, if the End Point is posting a PCIe write to the host, and the host is trying to read the End Point registers via PCIe, Completion data is generated . With the strong ordered mode, one would expect that first the post write will finish, and only then the completion data will be processed. The Erratum means that this mode is not supported. The DIS_ORD_CHK must be set to disable this feature, which is not supported by HW.
> 
> Ok, thank you for explanation!
> 
> > Regarding Bjorn comment, not enabling this bit will not help as the strong-order feature is not implemented in HW.
> > Leaving this bit disabled will not make the HW enforce strong-order. There is no detailed description of the HW behavior when the bit is disabled per the default, but as is clearly evident from the Erratum and from your own experience, leaving this bit disabled would not create the correct, expected behavior from the HW, which is why it must be enabled for correct functionality of the system (both hardware and software).
> 
> What does it mean that strong-order feature is not implemented in HW?
> Strong-order model is requirement in PCIe. This is really strange if PCIe core requirement does not work in A3720 HW.
> 
> Anyway, in Marvell original A3720 PCIe driver is explicitly turned off Relaxed PCIe ordering (and same is in mainline pci-aardvark.c driver):
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_MarvellEmbeddedProcessors_linux-2Dmarvell_blob_f12b3557095ff1d9b7be78bef7a3237e27b7778e_drivers_pci_host_pci-2Dadvk-2Darm64.c-23L397&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=QoWBVtlmK8dcnqfqPuLlrYZW9dLkLAXjQsXnSTsyLXtAG5xwVrUj34pscwdHn0qv&s=dJOx9jStTL77pFhd5KB7ZjA-QJr1hryKyBaO8iykKQI&e= 
> 
> So if both Relaxed and Strong ordering are going to be disabled, what kind of ordering model is then used? This is something which I do not understand here.
> 
> > Regarding the patch - I would also add a full memory barrier (if you use interrupts on the host to handle the write completion - then in the PCIe driver interrupt handler, otherwise this will require modifying the specific WIFI driver) in order to minimize the risk for the race condition documented in the Erratum between the DMA done status reading and the completion of writing to the host memory. This of course does not guarantee order, but it is better than leaving it the way it is.
> 
> I'm not sure if I understand you correctly. Do you mean to call ARM DSB instruction for Data Synchronization Barrier in A3720 PCIe summary interrupt handler in pci-aardvark.c prior chaining to wifi driver interrupt handler?
> 
> > Hopefully this helps,
> > 
> > Elad.
> > 
> > -----Original Message-----
> > From: Pali Rohár <pali@kernel.org>
> > Sent: Sunday, July 10, 2022 2:21 PM
> > To: Elad Nachman <enachman@marvell.com>; Ratheesh Kannoth 
> > <rkannoth@marvell.com>; Tanmay Jagdale <tanmay@marvell.com>; Shijith 
> > Thotton <sthotton@marvell.com>; Arun Easi <aeasi@marvell.com>
> > Cc: Krzysztof Wilczyński <kw@linux.com>; Lorenzo Pieralisi 
> > <lorenzo.pieralisi@arm.com>; Thomas Petazzoni 
> > <thomas.petazzoni@bootlin.com>; Bjorn Helgaas <bhelgaas@google.com>; 
> > Marek Behún <kabel@kernel.org>; Remi Pommarel <repk@triplefau.lt>; 
> > Xogium <contact@xogium.me>; linux-pci@vger.kernel.org; 
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; 
> > Bharat Bhushan <bbhushan2@marvell.com>; Veerasenareddy Burru 
> > <vburru@marvell.com>; Wojciech Bartczak <wbartczak@marvell.com>
> > Subject: [EXT] Re: Issues with A3720 PCIe controller driver 
> > pci-aardvark.c
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > + Other people from Marvell active on LKML.
> > 
> > Could you please look at this issue and give us some comment? It is really critical issue which needs to be solved.
> > 
> > On Wednesday 16 February 2022 21:09:40 Pali Rohár wrote:
> > > + Bharat, Veerasenareddy and Wojciech from Marvell
> > > 
> > > Hello! Could you please look at this email and help us with this Marvell HW issue?
> > > 
> > > On Saturday 24 July 2021 00:17:10 Pali Rohár wrote:
> > > > Hello Konstantin!
> > > > 
> > > > There are issues with Marvell Armada 3720 PCIe controller when 
> > > > high performance PCIe card (e.g. WiFi AX) is connected to this 
> > > > SOC. Under heavy load PCIe controller sends fatal abort to CPU and kernel crash.
> > > > 
> > > > In Marvell Armada 3700 Functional Errata, Guidelines, and 
> > > > Restrictions document is described erratum 3.12 PCIe Completion 
> > > > Timeout (Ref #: 251) which may be relevant. But neither Bjorn, 
> > > > Thomas nor me were able to understood text of this erratum. And we 
> > > > have already spent lot of time on this erratum. My guess that is 
> > > > that in erratum itself are mistakes and there are missing some other important details.
> > > > 
> > > > Konstantin, are you able to understand this erratum? Or do you 
> > > > know somebody in Marvell who understand this erratum and can 
> > > > explain details to us? Or do you know some more details about this erratum?
> > > > 
> > > > Also it would be useful if you / Marvell could share text of this 
> > > > erratum with linux-pci people as currently it is available only on 
> > > > Marvell Customer Portal which requires registration with signed NDA.
> > > > 
> > > > In past Thomas wrote patch "according to this erratum" and I have 
> > > > rebased, rewritten and resent it to linux-pci mailing list for review:
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.o
> > > > rg 
> > > > _linux-2Dpci_20210624222621.4776-2D6-2Dpali-40kernel.org_&d=DwIDaQ
> > > > &c 
> > > > =nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlF
> > > > rw
> > > > Q&m=opYsQsv_sfSvTtA5oJwc1paZrPAWMHVhTx_9J1VWBVDksBETCXVsC3rRDb5ejg
> > > > g- &s=AKbEBWOIxa4A0QSFXiq6HhKpByn0hPJuZvbxsu3m8oo&e=
> > > > 
> > > > Similar patch is available also in kernel which is part of Marvell SDK.
> > > > 
> > > > Bjorn has objections for this patch as he thinks that bit 
> > > > DIS_ORD_CHK in that patch should be disabled. Seems that enabling 
> > > > this bit effectively disables PCIe strong ordering model. PCIe 
> > > > kernel drivers rely on PCIe strong ordering, so it would implicate 
> > > > that that bit should not be enabled. Which is opposite of what is mentioned patch doing.
> > > > 
> > > > Konstantin, could you help us with this problem?
