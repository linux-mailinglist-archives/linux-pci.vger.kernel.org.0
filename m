Return-Path: <linux-pci+bounces-42142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C24C8B8D2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 20:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FD4E1B30
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292133F381;
	Wed, 26 Nov 2025 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoNF69k6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A333C1A5;
	Wed, 26 Nov 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184782; cv=none; b=AFzpkhrbtwIolHKy9X1dYw7eVZBHapK5ySftWdFeiEYsS2dWqrFr2jXsM5+0nEXICx0YDlimMmeNgITSpd9Phb2rrPG+B+P4AelFaZD05PyzMrVlYUy6F3fcyEBnZLMhagxYEfXqwo5x3wtyIbUAjXppBHKFcC2ulhfpLQE/RbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184782; c=relaxed/simple;
	bh=VyhkBsbKgM8Jwl990qCjZDqmXJMpUaoQ7/jOnNEGodg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZnbpEdHVzoOzTxL5bigj3t1gK3aNswmtvne6DrOGwzqZG+E9P17oFilzNr9d6lhb4nV6sMrodgc6XmV3SSlB9vCXKlueBkn9xx70ndrd5BS8oIuWxMzDqnLdxRyOOns/s/Z1pYRr4XN5JNjtEVPixcHO1OGG9q06bsXA+K0uFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoNF69k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3DC4CEF7;
	Wed, 26 Nov 2025 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764184781;
	bh=VyhkBsbKgM8Jwl990qCjZDqmXJMpUaoQ7/jOnNEGodg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NoNF69k6CkbiXUp2YmUxdHHI7hDDF1yd6CBC3j3D4rh4fj5EOlHMsGNzDM7d/ndSC
	 tDLlyuNk5Yi15C+ok7bx9FkcyfRcWr+h9G3NdfwiHMaPioaZ9/MFhMpopnjMz30Nqy
	 skw/7CtiJ7BkOYaGEsUHB9vL0fodC30O7MiYmNTDBe0E+J8+tW1B4n+skoVIW9NI6h
	 Kc+Nqrd7HT3/fgc06RhHxcsmN0M5Q7q3ao/rc09L2GCW1hRVj/4ZFQseP4TX1P07iw
	 xSVdWfb4jUL+C80Sjf7UM+/Xw9NBV2vOgRfbz8WUB2w1keeeXXp+P6Jxnj/b8uEq+y
	 vzNN617zRP06g==
Date: Wed, 26 Nov 2025 13:19:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v8 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <20251126191940.GA2831320@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7ecbc0-6ce5-403a-b794-93aaff1ddf39@tuxon.dev>

On Wed, Nov 26, 2025 at 07:22:09PM +0200, Claudiu Beznea wrote:
> On 11/25/25 20:37, Bjorn Helgaas wrote:
> > On Wed, Nov 19, 2025 at 04:35:19PM +0200, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.
> > 
> >> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
> >> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> >> +				 int where, int size, u32 val)
> >> +{
> >> +	struct rzg3s_pcie_host *host = bus->sysdata;
> >> +	int ret;
> >> +
> >> +	/* Enable access control to the CFGU */
> >> +	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> >> +		       host->axi + RZG3S_PCI_PERM);
> > 
> > I suppose this has been asked and answered already, but it's curious
> > that you need this for config writes but not for reads.  Obviously it
> > must *work*, but it's unusual and might warrant a comment.  "Access
> > control" must be a hint, but only means something to experts.
> 
> After initialization, some PCI registers are read only. To enable write
> access to these registers after initialization, the access control need to
> be enabled.

rzg3s_pcie_root_write() is a config accessor.  All the users of this
expect the semantics documented by the PCI/PCIe spec.  Registers
documented as read-only *should* be read-only in those situations.

BIOS and native host bridge drivers like this one may need to
initialize registers that are read-only to the OS.  Some hardware
supports that initialization via device-specific addresses outside of
normal config space.

It looks like this hardware supports that initialization using the
PCI/PCIe-documented config addresses, but uses RZG3S_PCI_PERM to
control whether things are read-only or not.  It's used that way in
rzg3s_pcie_host_init_port(), rzg3s_pcie_config_init(), etc.

That's perfectly fine, as long as this all happens before the OS sees
the devices.  If writes to read-only registers happen *after* the OS
starts enumerating devices, then we have a problem because the OS may
cache the values of read-only registers.

Bottom line, I think:

  - rzg3s_pcie_root_write() should *not* use RZG3S_PCI_PERM at all.
    In fact, it should not exist, and rzg3s_pcie_root_ops.write should
    be pci_generic_config_write().

  - rzg3s_pcie_config_init() should use RZG3S_PCI_PERM to update
    RZG3S_PCI_CFG_BARMSK00, but should *not* need it to update the
    bus info because those registers are read/write per spec.

The other users look like they do need RZG3S_PCI_PERM to initialize
the Vendor and Device IDs (which are read-only per spec) and PHY
registers (which are not part of the programming model documented by
the PCIe spec).

rzg3s_pcie_config_init() looks like a problem because it's called from
rzg3s_pcie_resume_noirq(), which happens after the OS owns the PCI
hardware.  The OS may have updated the bus numbers, and
rzg3s_pcie_config_init() will overwrite them with whatever it got from
DT.  With a single Root Port, it's not *likely* that the OS would
change the secondary or subordinate bus numbers, but you can't assume
they are fixed.

I don't know if the hardware loses the bus numbers when it is
suspended.  If it does, I think you would need to capture them during
suspend, save them somewhere like rzg3s_pcie_port, and restore them
during resume.

You should be able to verify that this is a problem by booting the
kernel, decreasing the subordinate bus number via setpci, suspending
and resuming, and checking the subordinate bus number with lspci.  I
think you'll see that setpci update lost.

> >> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
> >> +{
> >> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> >> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
> >> +	struct rzg3s_pcie_host *host = data;
> >> +	struct rzg3s_pcie_msi *msi = &host->msi;
> >> +	unsigned long bit;
> >> +	u32 status;
> >> +
> >> +	status = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIS);
> >> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
> >> +		return IRQ_NONE;
> >> +
> >> +	/* Clear the MSI */
> >> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
> >> +			       RZG3S_PCI_PINTRCVIS_MSI,
> >> +			       RZG3S_PCI_PINTRCVIS_MSI);
> > 
> > Other writes to RZG3S_PCI_PINTRCVIS are guarded by host->hw_lock.  Is this
> > one safe without it?
> 
> It should be safe as RZG3S_PCI_PINTRCVIS is a R/W1C type of register.
> 
> HW manual describes R/W1C registers for PCIe as "Write-1-to-clear status
> . It can be cleared to 0b by writing 1b with a readable register.
>  Writing 0b does not change anything."
> 
> With this, it should be safe to drop the guard from rzg3s_pcie_intx_irq_ack().
> 
> > 
> >> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
> >> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
> >> +
> >> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
> >> +		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
> >> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
> >> +			     RZG3S_PCI_MSI_INT_PER_REG);
> >> +	}
> >> +
> >> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
> >> +		int ret;
> >> +
> >> +		ret = generic_handle_domain_irq(msi->domain, bit);
> >> +		if (ret) {
> >> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
> >> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
> >> +
> >> +			/* Unknown MSI, just clear it */
> >> +			writel_relaxed(BIT(reg_bit),
> >> +				       host->axi + RZG3S_PCI_MSIRS(reg_id));
> > 
> > Other writes to RZG3S_PCI_MSIRS are guarded by host->hw_lock.  Is this
> > one safe without it?
> 
> RZG3S_PCI_MSIRS is also a R/W1C type of register. With it, it should be
> safe to drop the guard from rzg3s_pcie_msi_irq_ack() as well.
> 
> I'm going to prepare a follow up patch to drop the guard on
> rzg3s_pcie_intx_irq_ack() and rzg3s_pcie_msi_irq_ack(). Please let me know
> if you have something against.

Sounds good.  Maybe add a comment at RZG3S_PCI_PINTRCVIS and
RZG3S_PCI_MSIRS about them being R/W1C as a hint that they don't need
locking.

> I can also prepare a patch to detail in a comment the "enable access
> control to the CFGU" operation in rzg3s_pcie_root_write(), if you prefer.

I think you should do the patch below.

And also investigate the question about resume and the bus numbers.
If it is an issue, you'll have to figure out how to fix that.

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 667e6d629474..547cbe676a25 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -439,28 +439,9 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
 	return host->pcie + where;
 }
 
-/* Serialized by 'pci_lock' */
-static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 val)
-{
-	struct rzg3s_pcie_host *host = bus->sysdata;
-	int ret;
-
-	/* Enable access control to the CFGU */
-	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
-		       host->axi + RZG3S_PCI_PERM);
-
-	ret = pci_generic_config_write(bus, devfn, where, size, val);
-
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
-	return ret;
-}
-
 static struct pci_ops rzg3s_pcie_root_ops = {
 	.read		= pci_generic_config_read,
-	.write		= rzg3s_pcie_root_write,
+	.write		= pci_generic_config_write,
 	.map_bus	= rzg3s_pcie_root_map_bus,
 };
 
@@ -1065,14 +1046,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
 
+	/* Disable access control to the CFGU */
+	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
+
 	/* Update bus info */
 	writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
 	writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
 	writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
 
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
 	return 0;
 }
 

