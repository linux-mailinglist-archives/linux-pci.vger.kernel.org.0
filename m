Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6555198620
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgC3VMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 17:12:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59781 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 17:12:19 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJ1hb-0005xs-Tn; Mon, 30 Mar 2020 23:12:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 08337101175; Mon, 30 Mar 2020 23:12:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
In-Reply-To: <20200330162928.GA55054@google.com>
References: <20200330162928.GA55054@google.com>
Date:   Mon, 30 Mar 2020 23:12:10 +0200
Message-ID: <87zhbxv979.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Mar 27, 2020 at 03:24:34PM +0530, Vignesh Raghavendra wrote:
>> Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
>> needs to ensure that there are no pending MSI IRQ vector set (i.e
>> PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
>> Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
>> PCIE_MSI_INTR0_STATUS shows IRQs are pending.
>
> I'm not an IRQ guy (real IRQ guys CC'd), but I'm wondering if this is
> really a symptom of a problem in the generic DWC IRQ handling, not a
> problem in dra7xx itself.
>
> I thought it was sort of standard behavior that a device would not
> send a new MSI unless there was a transition from "no status bits set"
> to "at least one status bit set".  I'm looking at this text from the
> PCIe r5.0 spec, sec 6.7.3.4:

That's for the device side. But this is the host side and that consists
of two components:

     1) The actual PCIe host controller (DWC)

     2) Some hardware wrapper around #1 to glue the host controller IP
        into the TI SoC.

#1 contains a MSI message receiver unit. PCIE_MSI_INTR0_STATUS is part
that.

If there is a MSI message sent to the host then the bit which is
corresponding to the sent message (vector) is set in the status
register. If a bit is set in the status register then the host
controller raises an interrupt at its output.

Here, if I deciphered the above changelog correctly, comes the wrapper
glue #2 into play, which seems to be involved in forwarding the host
controller interrupt to the CPU's interrupt controller (GIC) and that
forwarding mechanism seems to have some issue.

The changelog is unspecific enough, so I can't explain for sure how the
wrapper hardware confuses itself.

My assumption is that after the host controller raised an interrupt at
the input of the wrapper logic the wrapper logic requires a transition
back to quiescent state before it can raise another interrupt in the
GIC. And that seems to require that all bits of PCIE_MSI_INTR0_STATUS
are cleared.

If my interpretation is correct, then the DWC side is not at fault and
it's soleley the TI specific hardware glue which makes this thing
misbehave.

Of course I might be completely wrong, but the TI folks should be able
to tell.

OTOH, what I do not understand in the patch is the reimplementation of
the interrupt chip. All functions are copies, except for the actual
register writes.

The drax version uses dw_pcie_writel_dbi() which invokes
dw_pcie_write_dbi() and that function does:

void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
{
	int ret;

	if (pci->ops->write_dbi) {
		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
		return;
	}

	ret = dw_pcie_write(pci->dbi_base + reg, size, val);
	if (ret)
		dev_err(pci->dev, "Write DBI address failed\n");
}

The dwc version uses dw_pcie_wr_own_conf() which does:

static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
			       u32 val)
{
	struct dw_pcie *pci;

	if (pp->ops->wr_own_conf)
		return pp->ops->wr_own_conf(pp, where, size, val);

	pci = to_dw_pcie_from_pp(pp);
	return dw_pcie_write(pci->dbi_base + where, size, val);
}

As dra7xx does neither implement pp->ops->wr_own_conf() nor
pci->ops->write_dbi. Ergo the interrupt chip is just a copy with some
obfuscation.

I might be missing some detail, but asided of the actual interrupt
service routine, this looks like a massive copy and paste orgy.

Thanks,

        tglx


