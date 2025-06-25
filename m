Return-Path: <linux-pci+bounces-30637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8077AE8BB6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6611D1899189
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54891ADC69;
	Wed, 25 Jun 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ofc8PC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCFD2FF
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873615; cv=none; b=XH+lHbBiNB5BLda+0sL4igFvSWt0/0m9ZxWJduSPO3j62t8v9v5ENlFYK5UMVFG1dwxIJYTJ6NpKuM1FjMCQ6eVcMPMomTISkZLsnCZJILO/IS0jiF7pYmpu1Atvh2YGFuF6myKPRRvPzq0nSSdjpk8KC+Q2nSobl4i/cxUjxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873615; c=relaxed/simple;
	bh=ZnZ33kpvuLPsBLizLKj8Pp+UfvYEJedJi5LGYdrHrg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fQjizEjaXy9+DBFSTo4f7vCBsRAghoJKsZaXfZ2V+CF8TCRywlNGXdzsmq6adJjiy/rc3hzaZJ7h6Oxh9IKJWSJZVLqtQ8C8hDUNUjbWm6xfcnNEQjNnz+7AroKRPCzPpS/GAxGov8BP1C8o22oMJJUslyVeeK2CC7IWNWiCvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ofc8PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4725C4CEEA;
	Wed, 25 Jun 2025 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873615;
	bh=ZnZ33kpvuLPsBLizLKj8Pp+UfvYEJedJi5LGYdrHrg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O+ofc8PCvSXrNsMpwA5xxf/eVS9H4/YpO4IxBqXfhhIV70KERFo2wpJ/Y7ThJmWLT
	 TqcCKqWpnT/YbL3O2B1Y3TmlRlcrbgmRxmb+guyXqNDVnMS0tHQmz5zxZBYBxviQ7d
	 yJsarxVkiwLnGDg01C7pyFiDMq9dLPvMl64eSBIcegoGPqUSYtXDfLKjBvLgCZs5Sn
	 RlaL4+M0Y/VH9WXqJ9yUhjV6pmN/2umBdjSEvWxZAhTwgdoci6Vt4FqQNP4233qn6J
	 97aRGldB25tEQS/H05Rk/qvy7gziM91/BtL8VFtslD+uWcL0JPJlViyniS97Tl+izU
	 MT+mf+dzOR7ow==
Date: Wed, 25 Jun 2025 12:46:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: andreasx0 <andreasx0@protonmail.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
Message-ID: <20250625174652.GA1578845@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9GZ44D4l8VOon-B2Uc15vxasiaSrnTLkvk18qrogb08_K_aCKBPOep6JxmMQRK8UuxTnv0ZxgxIOFA8v8e3yJZuVtLLPzZsmmwRc7BODcVs=@protonmail.com>

On Wed, Jun 25, 2025 at 04:06:58PM +0000, andreasx0 wrote:
> Again. As said the patch from Lucas fixed the warning that was
> caused because the discrete nvidia gpu was disabled by bios.

The series I applied is at
https://lore.kernel.org/all/20250123055155.22648-1-sjiwei@163.com/.
The patches currently queued are at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=enumeration

I cc'd you on my response to that series, so if you think the commit
log needs a change, feel free to suggest something in that thread.
It's a generic problem, not anything specific to the GPU, so I just
included the log messages a user would see when the problem happens.

I added your Reported-by because I think the first patch [2] *should*
fix the problem you saw.  If it doesn't, please let me know.  If you
test it and it does fix the problem, I'd be happy to add your
Tested-by as well.

Thanks very much for reporting this issue and giving it a nudge to get
it fixed!

[2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=9989e0ca7462

> On Tuesday, June 24th, 2025 at 21:13, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
> > On 6/24/25 9:48 AM, Bjorn Helgaas wrote:
> > 
> 
> > > [+cc Sathy, Jiwei, Adrian]
> > > 
> 
> > > On Mon, Jun 23, 2025 at 03:22:14PM +0200, Lukas Wunner wrote:
> > > 
> 
> > > > When pcie_failed_link_retrain() fails to retrain, it tries to revert to
> > > > the previous link speed. However it calculates that speed from the Link
> > > > Control 2 register without masking out non-speed bits first.
> > > > 
> 
> > > > PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> > > > PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> > > > pcie_set_target_speed():
> > > > 
> 
> > > > pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
> > > > pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
> > > > pci 0000:00:01.1: retraining failed
> > > > WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
> > > > RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
> > > > pcie_failed_link_retrain
> > > > pci_device_add
> > > > pci_scan_single_device
> > > > pci_scan_slot
> > > > pci_scan_child_bus_extend
> > > > acpi_pci_root_create
> > > > pci_acpi_scan_root
> > > > acpi_pci_root_add
> > > > acpi_bus_attach
> > > > device_for_each_child
> > > > acpi_dev_for_each_child
> > > > acpi_bus_attach
> > > > device_for_each_child
> > > > acpi_dev_for_each_child
> > > > acpi_bus_attach
> > > > acpi_bus_scan
> > > > acpi_scan_init
> > > > acpi_init
> > > > 
> 
> > > > Per the calling convention of the System V AMD64 ABI, the arguments to
> > > > pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
> > > > stored in RDI, RSI, RDX. As visible above, RSI contains 0xff, i.e.
> > > > PCI_SPEED_UNKNOWN.
> > > > 
> 
> > > > Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed link retraining")
> > > > Reported-by: Andrew andreasx0@protonmail.com
> > > > Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
> > > > Signed-off-by: Lukas Wunner lukas@wunner.de
> > > > Cc: stable@vger.kernel.org # v6.12+
> > > > I like the brevity of this patch, but I do worry that if we ever have
> > > > other users of PCIE_LNKCTL2_TLS2SPEED(), we might have the same
> > > > problem again.
> > > 
> 
> > > Also, it looks like PCIE_LNKCAP_SLS2SPEED() has the same problem.
> > > 
> 
> > > f68dea13405c predates PCIE_LNKCTL2_TLS2SPEED(), and I don't think this
> > > problem existed as of f68dea13405c. I think the Fixes: tag should be
> > > for de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe
> > > Link Speed"), which added PCIE_LNKCTL2_TLS2SPEED() and
> > > PCIE_LNKCAP_SLS2SPEED() without masking out the other bits.
> > > 
> 
> > > I think I'll take Jiwei's patch [1], which fixes
> > > PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() without requiring
> > > changes in the users. I'll add the details of Andrew's report to the
> > > commit log.
> > 
> 
> > 
> 
> > Agree. It is better to fix it in the macro.
> > 
> 
> > > [1] https://lore.kernel.org/all/20250123055155.22648-2-sjiwei@163.com/
> > > 
> 
> > > > ---
> > > > drivers/pci/quirks.c | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index d7f4ee6..deaaf4f 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> > > > pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > > > pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > > > if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> > > > - u16 oldlnkctl2 = lnkctl2;
> > > > + u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> > > > 
> 
> > > > pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
> > > > 
> 
> > > > --
> > > > 2.47.2
> > 
> 
> > --
> > Sathyanarayanan Kuppuswamy
> > Linux Kernel Developer





