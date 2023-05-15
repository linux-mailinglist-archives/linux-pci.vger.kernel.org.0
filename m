Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513197040CA
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbjEOWNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbjEOWNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 18:13:33 -0400
X-Greylist: delayed 129731 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 15:12:55 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A8E106DF;
        Mon, 15 May 2023 15:12:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 498732800B6CC;
        Tue, 16 May 2023 00:12:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3D6F34A830; Tue, 16 May 2023 00:12:53 +0200 (CEST)
Date:   Tue, 16 May 2023 00:12:53 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <20230515221253.GA28117@wunner.de>
References: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com>
 <ZF0P2hedTFXPv8IK@bhelgaas>
 <20230511202332.GD31598@wunner.de>
 <51577aaa-dc96-d588-2ecf-5bac4b59284@linux.intel.com>
 <20230514101041.GA1881@wunner.de>
 <2832e4a-8ef5-8695-3ca2-2b2f287a44d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2832e4a-8ef5-8695-3ca2-2b2f287a44d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 02:59:42PM +0300, Ilpo Järvinen wrote:
> While it does feel entirely unnecessary layer of complexity to me, it would 
> be possible to rename the original pcie_capability_clear_and_set_word() to 
> pcie_capability_clear_and_set_word_unlocked() and add this into 
> include/linux/pci.h:
> 
> static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
> 					int pos, u16 clear, u16 set)
> {
> 	if (pos == PCI_EXP_LNKCTL || pos == PCI_EXP_LNKCTL2 ||
> 	    pos == PCI_EXP_RTCTL)
> 		pcie_capability_clear_and_set_word_locked(...);
> 	else
> 		pcie_capability_clear_and_set_word_unlocked(...);
> }
> 
> It would keep the interface exactly the same but protect only a selectable 
> set of registers. As pos is always a constant, the compiler should be able 
> to optimize all the dead code away.

That's actually quite neat, I like it.  It documents clearly which
registers need protection because of concurrent RMWs and callers can't
do anything wrong.

Though I'd use a switch/case statement such that future additions
of registers that need protection are always just a clean, one-line
change.

Plus some kernel-doc or code comment to explain that certain
registers in the PCI Express Capability Structure are accessed
concurrently in a RMW fashion, hence require locking.

Since this protects specifically registers in the PCI Express
Capability, whose location is cached in struct pci_dev->pcie_cap,
I'm wondering if pcie_cap_lock is a clearer name.


> PCI_EXP_SLTCTL write is protected by a mutex, it doesn't look something 
> that matches your initial concern about "hot paths (e.g. interrupt 
> handlers)".

PCI_EXP_SLTCTL is definitely modified from the interrupt handler
pciehp_ist(), but one could argue that hotplug interrupts don't
usually occur *that* often.  (We've had interrupt storms though
from broken devices or ones with a shared interrupt etc.)

I guess I'm just generally worried about acquiring a lock that's
not necessary.  E.g. on boot, numerous config space accesses are
performed to enumerate and initialize devices and reducing concurrency
might slow down boot times.  It's just a risk that I'd recommend
to avoid if possible.

Thanks,

Lukas
