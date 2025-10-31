Return-Path: <linux-pci+bounces-39952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF41C2679A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 18:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2061892F85
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434E34F47A;
	Fri, 31 Oct 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR4Gjxom"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA454333433;
	Fri, 31 Oct 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932878; cv=none; b=eXhWJYuZvsaBnjHLEyKdzGUQAiqDuL3YoDkKh8pwIo1zYKOu5tRaawScdrVWQ0TX4kEU2c/JHUnyBYLzaTDAQ4QNwamep2VwOTazm+YNEcU6UYK7Xz6GgIxvNtJ+KtNJ0YgvT9RT1V5ilsN0ylwGyAG2DLHYmIBwVMdnlc0+zAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932878; c=relaxed/simple;
	bh=HeGe6c0YHevoJLq10In5ANfraZ5zF5UmASxtNszXF5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRZu5aUPUHmKUr3dzZsvNgD05XSxewSdao8ZGN+K4f0n6Bxs6FnqG28pxnlRUpnw3J2YZUphSmzY8sfGrE7E+LZCR60ulLsxGXlLjI1PjfRtvXyFryMR8TK2s9XXAwIuKut37LzqDnyEMtCxXig1kMO0iHba6E1cTIh+0I3dey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR4Gjxom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96452C4CEE7;
	Fri, 31 Oct 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761932877;
	bh=HeGe6c0YHevoJLq10In5ANfraZ5zF5UmASxtNszXF5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UR4GjxomLCe1weH7cYm/SksUjWQ0NbNfdOtM7qhSl0+vSrWaDmzwrg5BIN6JtLhf4
	 ZfkxV51n4rAn01rrmIl+lT85kJ2ap8IkgAR4O9kM2cyPYNeBkwgbVKapF97W8AJCdf
	 bY8dzJkqFog765dcq1VTBIy0ktsh/paS2aowvQ/pvDoGfuBeLRfaSb004qLUJkZZcx
	 Fsw0n/7k5i7WPTgM6mO/Wv2PuSo9A+oFFLtEGLbArtNC9lW7VIk6V/eoc8FCq2Dga9
	 MBkSBPzcOoLp3cybooM0OTaALkCsGM5lrvi7LuWWdTC0q0ERsxpylWN6JT65dUovAm
	 GCWDcAhALb06Q==
Date: Fri, 31 Oct 2025 23:17:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linnaea Lavia <linnaea-von-lavia@live.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>, 
	Kevin Hilman <khilman@baylibre.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <agqyqr7c6wwkr4fewt3szomd7c57eeujkal7modj46ssbngxf7@f7t56i723mvx>
References: <DM4PR05MB1027077E1F4CD8B1A7EDADF1DC7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
 <20251031161323.GA1688975@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031161323.GA1688975@bhelgaas>

On Fri, Oct 31, 2025 at 11:13:23AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 08:26:42PM +0800, Linnaea Lavia wrote:
> > On 10/31/2025 4:50 PM, Neil Armstrong wrote:
> > > On 10/31/25 06:34, Linnaea Lavia wrote:
> > > > On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
> > > > > On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
> > > > > > On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
> > > > > 
> > > > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > > > index 214ed060ca1b..9cd12924b5cb 100644
> > > > > > > --- a/drivers/pci/quirks.c
> > > > > > > +++ b/drivers/pci/quirks.c
> > > > > > > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > > > > >     * disable both L0s and L1 for now to be safe.
> > > > > > >     */
> > > > > > >    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> > > > > > >    /*
> > > > > > >     * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> > > > > > 
> > > > > > I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
> > > > > 
> > > > > Sorry, my fault, I should have made that fixup run earlier, so the
> > > > > patch should be this instead:
> > > > > 
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index 214ed060ca1b..4fc04015ca0c 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > > >    * disable both L0s and L1 for now to be safe.
> > > > >    */
> > > > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> > > > 
> > > > L1 still got enabled
> 
> Is that based on the output below?
> 
>   [    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
>   [    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1
> 
> If so, this doesn't necessarily mean L1 was enabled.  It means the
> quirk marked the 00:00.0 Root Port so we shouldn't ever enable L0s or
> L1, and when we enumerated 01:00.0, we set its default ASPM state to
> L1.
> 
> But I don't *think* L1 should actually be enabled unless we can enable
> it for both 00:00.0 and 01:00.0, and the quirk should mean that we
> can't enable it for 00:00.0.
> 
> This muddle of "capable" (per Link Capabilities) vs "disabled" (either
> the Link Control shows disabled, or software said "don't ever use L1")
> is part of what makes aspm.c so confusing.
> 
> > > > The card works just fine. I'm thinking the ASPM issue is
> > > > probably from the glue driver reporting the link to be down when
> > > > it's really just in low power state.
> > > 
> > > You're probably right, the meson_pcie_link_up() not only checks
> > > the LTSSM but also the speed, which is probably wrong.
> > > 
> > > Can you try removing the test for speed ?
> > > 
> > > -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
> > > +                 if (smlh_up && rdlh_up && ltssm_up)
> > > 
> > > The other drivers just checks the link, and some only the smlh_up
> > > && rdlh_up. So you can also probably drop ltssm_up aswell.
> > 
> > I can confirm that removing the check for ltssm_up and speed_okay
> > made ASPM work.
> 
> I don't think meson_pcie_link_up() should have the loop in it, so the
> ltssm_up and speed_okay checks, the loop, the delay, and the timeout
> message should probably all be removed.  That method is supposed to be
> a simple true/false check, and any waiting required should be done in
> dw_pcie_wait_for_link().
> 
> The link was clearly up when we discovered 01:00.0, so the "wait
> linkup timeout" messages from meson_pcie_link_up() after that must be
> from dw_pcie_link_up() being called via the .map_bus() call in
> pci_generic_config_read() or pci_generic_config_write().
> 
> When meson_pcie_link_up() returns false in those config accessors,
> the config accesses will fail (they won't even be attempted), so we'll
> see things like this:
> 
>   pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
> 
> and "Unknown header type 7f" from lspci.
> 
> Can you drop the ASPM quirk patch and instead try the
> meson_pcie_link_up() patch below on top of v6.18-rc3?
> 
> > We still need a solution to the original issue that's preventing the
> > controller from being initialized.
> > 
> > My kernel has the following patch applied, but I think it's not
> > suitable for upstream as this changes device tree bindings for PCIe
> > controller on meson.
> 
> I assume the original issue is this:
> 
>   meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
> 
> and you confirmed that it wasn't fixed by a1978b692a39 ("PCI: dwc: Use
> custom pci_ops for root bus DBI vs ECAM config access"), which
> appeared in v6.18-rc3?
> 
> If it's still broken in v6.18-rc3, and the dtsi and
> meson_pcie_get_mems() patch below makes it work, we have more work to
> do, and maybe Krishna has some ideas.
> 

We have two issues on this platform:

1. DT represents 'dbi' region as 'elbi', which was wrong as both are different
address spaces. ELBI is an optional region, whereas DBI has Root Port and
controller configuration registers, which is mandatory.

2. Driver parses/maps the 'elbi' region and stores it in 'pci->dbi_base'. So
this made sure that the code depending on the 'pci->dbi_base' work as expected.

Commit c96992a24bec, moved the ELBI parsing logic to the core code, and it also
removed the custom parsing from glue drivers. But since this driver was using
'pci->dbi_base' instead of 'pci->elbi_base', it was not caught during the move.

I've submitted a series [1] that hopefully would fix this resource parsing
issue. Please test it out.

- Mani

[1] https://lore.kernel.org/linux-pci/20251031-pci-meson-fix-v1-0-ed29ee5b54f9@oss.qualcomm.com

-- 
மணிவண்ணன் சதாசிவம்

