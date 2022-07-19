Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E240A579664
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiGSJdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiGSJd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 05:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54254252A9;
        Tue, 19 Jul 2022 02:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9DD6187A;
        Tue, 19 Jul 2022 09:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBFBC341C6;
        Tue, 19 Jul 2022 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658223207;
        bh=yD/72a4MfYEcEssc7Q+aGbfPku8v9bwK26POLsVD7iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dl5p2+q6u4oepGFVGifbSabpfDZ1s06fgSNL6FRi67AEm5XvYsFdIKYaM4m7om62V
         ZDsSwYztj2n+VOqJxFhlu4Lsp4kyHNyj53jI4wnFwc6PeXRyAIVFXws5Pm/t5gn6pd
         5hqf7+mP7x6Y6iqVqUIJ33HAG11FOnIYRD5PzmexkvsvGwxQn1Q3pqNca4ugouVwSw
         m9wiYzIf3lpOIjHIuXGtJ/jGwNPhQaYHuuF+df9OkX9oUL8IKyoZdTEazCg9z9L+Qx
         K3sk2Y9n9WTPPP7e+ML/57HViYoGY4yXCY8KK9HqbnPWX2c8niAvMuzg0uNVeddiTf
         IUszQ9Dqiax1w==
Received: by pali.im (Postfix)
        id F24F8F3C; Tue, 19 Jul 2022 11:33:23 +0200 (CEST)
Date:   Tue, 19 Jul 2022 11:33:23 +0200
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
Message-ID: <20220719093323.nzkpe2kcibszzgzm@pali>
References: <20210723221710.wtztsrddudnxeoj3@pali>
 <20220216200940.fwdwk5rcb4zq6dyg@pali>
 <20220710112108.jegpz4khfsrb4ahd@pali>
 <BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Elad!

Thank you very much for your response! Together with Krzysztof we were
unable to get any response regarding this issue for more than year.

I would kindly ask if you/Marvell could publish description of this
errata to Linux kernel developers, so more kernel developers can look at
it and try to implement workarounds.

Together with Krzysztof we have really an issue to retrieve any kind of
documentation or user guide for Armada 3720 erratas/bugs.

Rest of my comments I'm putting inline below.

On Sunday 17 July 2022 09:47:14 Elad Nachman wrote:
> Hi Pali,
> 
> Can you please indicate what is the HW source (e.g. which register in the PCIe controller) bits is translated to the fatal abort?

I observed this fatal abort on CPU when endpoint PCIe card sent
interrupt to A3720 PCIe controller and interrupt handler in driver for
endpoint card did PCIe memory write to PCIe card memory space.

Writing to PCIe address range for PCIe MEM of endpoint card cause that
A3720 PCIe controller sends fatal unrecoverable error to CPU.

Here is the crashlog from mediatek wifi card which I captured year ago.

[   71.457007] Internal error: synchronous external abort: 96000210 [#1] SMP
[   71.464021] Modules linked in: xt_connlimit pppoe ppp_async nf_conncount iptable_nat ath9k xt_state xt_nat xt_helper xt_conntrack xt_connmark xt_connbytes xt_REDIREl
[   71.464187]  btintel br_netfilter bnep bluetooth ath9k_hw ath10k_pci ath10k_core ath sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_mg
[   71.629589] CPU: 0 PID: 1298 Comm: kworker/u5:3 Not tainted 5.4.114 #0
[   71.636319] Hardware name: CZ.NIC Turris Mox Board (DT)
[   71.641725] Workqueue: napi_workq napi_workfn
[   71.646221] pstate: 80400085 (Nzcv daIf +PAN -UAO)
[   71.651169] pc : mt76_set_irq_mask+0x118/0x150 [mt76]
[   71.656385] lr : mt7915_init_debugfs+0x358/0x368 [mt7915e]
[   71.662038] sp : ffffffc010003cd0
[   71.665451] x29: ffffffc010003cd0 x28: 0000000000000060 
[   71.670929] x27: ffffffc010a56f98 x26: ffffffc010c0fa9a 
[   71.676407] x25: ffffffc010ba8788 x24: ffffff803e01fe00 
[   71.681885] x23: 0000000000000030 x22: ffffffc010003dc4 
[   71.687361] x21: 0000000000000000 x20: ffffff803e01fea4 
[   71.692839] x19: ffffff803cb725c0 x18: 000000002d660780 
[   71.698317] x17: 0000000000000000 x16: 0000000000000001 
[   71.703795] x15: 0000000000005ee0 x14: ffffffc010d1d000 
[   71.709272] x13: 0000000000002f70 x12: 0000000000000000 
[   71.714749] x11: 0000000000000000 x10: 0000000000000040 
[   71.720226] x9 : ffffffc010bbe980 x8 : ffffffc010bbe978 
[   71.725704] x7 : ffffff803e4003f0 x6 : 0000000000000000 
[   71.731181] x5 : ffffffc02f240000 x4 : ffffffc010003e00 
[   71.736658] x3 : 0000000000000000 x2 : ffffffc008e3f230 
[   71.742135] x1 : 00000000000d7010 x0 : ffffffc0114d7010 
[   71.747613] Call trace:
[   71.750137]  mt76_set_irq_mask+0x118/0x150 [mt76]
[   71.754990]  mt7915_dual_hif_set_irq_mask+0x108/0xdc0 [mt7915e]
[   71.761098]  __handle_irq_event_percpu+0x6c/0x170
[   71.765950]  handle_irq_event_percpu+0x34/0x88
[   71.770531]  handle_irq_event+0x40/0xb0
[   71.774486]  handle_level_irq+0xe0/0x170
[   71.778530]  generic_handle_irq+0x24/0x38
[   71.782667]  advk_pcie_irq_handler+0x11c/0x238
[   71.787249]  __handle_irq_event_percpu+0x6c/0x170
[   71.792099]  handle_irq_event_percpu+0x34/0x88
[   71.796680]  handle_irq_event+0x40/0xb0
[   71.800633]  handle_fasteoi_irq+0xdc/0x190
[   71.804855]  generic_handle_irq+0x24/0x38
[   71.808988]  __handle_domain_irq+0x60/0xb8
[   71.813213]  gic_handle_irq+0x8c/0x198
[   71.817077]  el1_irq+0xf0/0x1c0
[   71.820314]  el1_da+0xc/0xc0
[   71.823288]  mt76_set_irq_mask+0x118/0x150 [mt76]
[   71.828141]  mt7915_mac_tx_free+0x4c4/0x828 [mt7915e]
[   71.833352]  mt7915_queue_rx_skb+0x5c/0xa8 [mt7915e]
[   71.838473]  mt76_dma_cleanup+0x89c/0x1248 [mt76]
[   71.843329]  __napi_poll+0x38/0xf8
[   71.846835]  napi_workfn+0x58/0xb0
[   71.850342]  process_one_work+0x1fc/0x390
[   71.854475]  worker_thread+0x48/0x4d0
[   71.858252]  kthread+0x120/0x128
[   71.861581]  ret_from_fork+0x10/0x1c
[   71.865273] Code: 52800000 d65f03c0 f9562c00 8b214000 (b9400000) 
[   71.871560] ---[ end trace 1d4e29987011411b ]---
[   71.876320] Kernel panic - not syncing: Fatal exception in interrupt
[   71.882875] SMP: stopping secondary CPUs
[   71.886923] Kernel Offset: disabled
[   71.890519] CPU features: 0x0002,00002008
[   71.894649] Memory Limit: none
[   71.897799] Rebooting in 3 seconds..

(in other SoC/systems, including Marvell, is this card working fine)

It is from older kernel, but issue is still there and happens also with
new kernels. Mediatek driver in its interrupt handler is masking some
interrupts in its interrupt handler, which is done by writing to PCIe
address space of endpoint card.

Anyway, I can reproduce same crash when I set PCIe link down or reset
link and trying to read from PCIe MEM or CFG space. Seems that PCIe
controller incorrectly reports errors to CPU, it should return all-ones
when PCIe device is not present (e.g. during link down) and not send
fatal abort to CPU. I.e. instead of AXI OK with 0xffffffff data, it
sends AXI SLVERR to CPU which cause that crash.

This is something which should be configurable but I'm not able to find
any A3720 documentation which would describe how to configure it.

> Regarding the Erratum, basically to the best of my understanding, if the End Point is posting a PCIe write to the host, and the host is trying to read the End Point registers via PCIe, Completion data is generated . With the strong ordered mode, one would expect that first the post write will finish, and only then the completion data will be processed. The Erratum means that this mode is not supported. The DIS_ORD_CHK must be set to disable this feature, which is not supported by HW.

Ok, thank you for explanation!

> Regarding Bjorn comment, not enabling this bit will not help as the strong-order feature is not implemented in HW.
> Leaving this bit disabled will not make the HW enforce strong-order. There is no detailed description of the HW behavior when the bit is disabled per the default, but as is clearly evident from the Erratum and from your own experience, leaving this bit disabled would not create the correct, expected behavior from the HW, which is why it must be enabled for correct functionality of the system (both hardware and software).

What does it mean that strong-order feature is not implemented in HW?
Strong-order model is requirement in PCIe. This is really strange if
PCIe core requirement does not work in A3720 HW.

Anyway, in Marvell original A3720 PCIe driver is explicitly turned off
Relaxed PCIe ordering (and same is in mainline pci-aardvark.c driver):
https://github.com/MarvellEmbeddedProcessors/linux-marvell/blob/f12b3557095ff1d9b7be78bef7a3237e27b7778e/drivers/pci/host/pci-advk-arm64.c#L397

So if both Relaxed and Strong ordering are going to be disabled, what
kind of ordering model is then used? This is something which I do not
understand here.

> Regarding the patch - I would also add a full memory barrier (if you use interrupts on the host to handle the write completion - then in the PCIe driver interrupt handler, otherwise this will require modifying the specific WIFI driver) in order to minimize the risk for the race condition documented in the Erratum between the DMA done status reading and the completion of writing to the host memory. This of course does not guarantee order, but it is better than leaving it the way it is.

I'm not sure if I understand you correctly. Do you mean to call ARM DSB
instruction for Data Synchronization Barrier in A3720 PCIe summary
interrupt handler in pci-aardvark.c prior chaining to wifi driver
interrupt handler?

> Hopefully this helps,
> 
> Elad.
> 
> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: Sunday, July 10, 2022 2:21 PM
> To: Elad Nachman <enachman@marvell.com>; Ratheesh Kannoth <rkannoth@marvell.com>; Tanmay Jagdale <tanmay@marvell.com>; Shijith Thotton <sthotton@marvell.com>; Arun Easi <aeasi@marvell.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Bjorn Helgaas <bhelgaas@google.com>; Marek Behún <kabel@kernel.org>; Remi Pommarel <repk@triplefau.lt>; Xogium <contact@xogium.me>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Bharat Bhushan <bbhushan2@marvell.com>; Veerasenareddy Burru <vburru@marvell.com>; Wojciech Bartczak <wbartczak@marvell.com>
> Subject: [EXT] Re: Issues with A3720 PCIe controller driver pci-aardvark.c
> 
> External Email
> 
> ----------------------------------------------------------------------
> + Other people from Marvell active on LKML.
> 
> Could you please look at this issue and give us some comment? It is really critical issue which needs to be solved.
> 
> On Wednesday 16 February 2022 21:09:40 Pali Rohár wrote:
> > + Bharat, Veerasenareddy and Wojciech from Marvell
> > 
> > Hello! Could you please look at this email and help us with this Marvell HW issue?
> > 
> > On Saturday 24 July 2021 00:17:10 Pali Rohár wrote:
> > > Hello Konstantin!
> > > 
> > > There are issues with Marvell Armada 3720 PCIe controller when high 
> > > performance PCIe card (e.g. WiFi AX) is connected to this SOC. Under 
> > > heavy load PCIe controller sends fatal abort to CPU and kernel crash.
> > > 
> > > In Marvell Armada 3700 Functional Errata, Guidelines, and 
> > > Restrictions document is described erratum 3.12 PCIe Completion 
> > > Timeout (Ref #: 251) which may be relevant. But neither Bjorn, 
> > > Thomas nor me were able to understood text of this erratum. And we 
> > > have already spent lot of time on this erratum. My guess that is 
> > > that in erratum itself are mistakes and there are missing some other important details.
> > > 
> > > Konstantin, are you able to understand this erratum? Or do you know 
> > > somebody in Marvell who understand this erratum and can explain 
> > > details to us? Or do you know some more details about this erratum?
> > > 
> > > Also it would be useful if you / Marvell could share text of this 
> > > erratum with linux-pci people as currently it is available only on 
> > > Marvell Customer Portal which requires registration with signed NDA.
> > > 
> > > In past Thomas wrote patch "according to this erratum" and I have 
> > > rebased, rewritten and resent it to linux-pci mailing list for review:
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org
> > > _linux-2Dpci_20210624222621.4776-2D6-2Dpali-40kernel.org_&d=DwIDaQ&c
> > > =nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrw
> > > Q&m=opYsQsv_sfSvTtA5oJwc1paZrPAWMHVhTx_9J1VWBVDksBETCXVsC3rRDb5ejgg-
> > > &s=AKbEBWOIxa4A0QSFXiq6HhKpByn0hPJuZvbxsu3m8oo&e=
> > > 
> > > Similar patch is available also in kernel which is part of Marvell SDK.
> > > 
> > > Bjorn has objections for this patch as he thinks that bit 
> > > DIS_ORD_CHK in that patch should be disabled. Seems that enabling 
> > > this bit effectively disables PCIe strong ordering model. PCIe 
> > > kernel drivers rely on PCIe strong ordering, so it would implicate 
> > > that that bit should not be enabled. Which is opposite of what is mentioned patch doing.
> > > 
> > > Konstantin, could you help us with this problem?
