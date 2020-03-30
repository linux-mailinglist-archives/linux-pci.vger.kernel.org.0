Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3119815C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgC3QhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 12:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgC3QhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 12:37:06 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2418B20578;
        Mon, 30 Mar 2020 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585586225;
        bh=llEQFda8awh91fzZWz92fuxXNdTFtQUxGdYEEsQmRGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iSu17BlPfG4uHlDvLg1NO9kwJ6+Gxtjr8BKiqZL9y9tIiDKwnsKDznVJvdheCUI/m
         ag+N5hm0i/k/i/1GiF91sXHO0PMNui8mUwzCTNwfjW7g8ihIpSp69tnsi3ZIMOHbPy
         TRBVtCLmMld/SDPCG+BbFRiM8pRpVCytiuXi5GNE=
Date:   Mon, 30 Mar 2020 11:37:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
Message-ID: <20200330163703.GA60578@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330162928.GA55054@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 11:29:52AM -0500, Bjorn Helgaas wrote:
> [+cc Marc, Thomas]
> 
> On Fri, Mar 27, 2020 at 03:24:34PM +0530, Vignesh Raghavendra wrote:
> > Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
> > needs to ensure that there are no pending MSI IRQ vector set (i.e
> > PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
> > Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
> > PCIE_MSI_INTR0_STATUS shows IRQs are pending.
> 
> I'm not an IRQ guy (real IRQ guys CC'd), but I'm wondering if this is
> really a symptom of a problem in the generic DWC IRQ handling, not a
> problem in dra7xx itself.
> 
> I thought it was sort of standard behavior that a device would not
> send a new MSI unless there was a transition from "no status bits set"
> to "at least one status bit set".  I'm looking at this text from the
> PCIe r5.0 spec, sec 6.7.3.4:
> 
>   If the Port is enabled for edge-triggered interrupt signaling using
>   MSI or MSI-X, an interrupt message must be sent every time the
>   logical AND of the following conditions transitions from FALSE to
>   TRUE:
> 
>     - The associated vector is unmasked (not applicable if MSI does
>       not support PVM).
> 
>     - The Hot-Plug Interrupt Enable bit in the Slot Control register
>       is set to 1b.
> 
>     - At least one hot-plug event status bit in the Slot Status
>       register and its associated enable bit in the Slot Control
>       register are both set to 1b.
> 
> and this related commit: https://git.kernel.org/linus/fad214b0aa72

and this one: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=87d94ad41bd2
