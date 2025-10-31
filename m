Return-Path: <linux-pci+bounces-39945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA30C26174
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAFB1B20CD0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B333081AD;
	Fri, 31 Oct 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzEgIL0D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939A2F3C1D;
	Fri, 31 Oct 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927205; cv=none; b=dxZQBakdSj2+0YyL9JWO1wf/3AG4pJb2fx6fpNNDvWPyaiItio4Z9eH//fnlvg8lxdr7oKhAFMMJwDDrr5MfqPiBP+7Ow5dL2EbYyPc6zc2gm/nhQY6eZAIkPjpdAWubp3v3i01ui4D39SNlYL9U3+3vUOjJKcNTkyA65Et7nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927205; c=relaxed/simple;
	bh=/DyHnjFO9lHU2x0F3J7nmIF9vc/TGc6bH8HE4QvBco0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PsjAdvCCLV9Zi/E/MTsCOVpEDCf+i7GUl5/5U9Urx47aDdTMZY7bzoQP2i/tZ6KwCHdngpirJgzlZ8j/inP9veRCygmVBKKhvKh3ty6vwrsGxNwD15dUTJ+TDGIQlTmisVwpghmaz+ZQN0PcATmDKdA5bVqijBgBjAb5zqaudTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzEgIL0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84075C4CEE7;
	Fri, 31 Oct 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761927204;
	bh=/DyHnjFO9lHU2x0F3J7nmIF9vc/TGc6bH8HE4QvBco0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IzEgIL0DtTQ3Ie8ZlKAIGVXVN/9B9IYEGSmtVewRUEC3Gfgn9ZW8NWbAVFUELIJua
	 rS5zlQCPYcZO+/D0+ReyENoV3+dBMPkyjr7sl/BMDVoh8pSkDRgwk+HQFFbVuIuTe0
	 iFMn5qDO9utK2QEbLfj7lqf5UFLc2QMtqx0vWTAJYEUQK7rvF1ZzbpBaOz3nu3Mi9U
	 POLMW5XbhTz5aZIIbH09LGh5FDXHXj2ta+p5nTZksWb8q0cJvvC3hRQl0JfmO2k3B1
	 plYk6Pfeh8IEFj+vTOhoUKJXXj8OUKW64bVUrtvwuV3zUihYYWQWyaRUfxoYjkjCOf
	 V8XF0n4qm/Q6w==
Date: Fri, 31 Oct 2025 11:13:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <20251031161323.GA1688975@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR05MB1027077E1F4CD8B1A7EDADF1DC7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>

On Fri, Oct 31, 2025 at 08:26:42PM +0800, Linnaea Lavia wrote:
> On 10/31/2025 4:50 PM, Neil Armstrong wrote:
> > On 10/31/25 06:34, Linnaea Lavia wrote:
> > > On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
> > > > On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
> > > > > On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
> > > > 
> > > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > > index 214ed060ca1b..9cd12924b5cb 100644
> > > > > > --- a/drivers/pci/quirks.c
> > > > > > +++ b/drivers/pci/quirks.c
> > > > > > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > > > >     * disable both L0s and L1 for now to be safe.
> > > > > >     */
> > > > > >    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> > > > > >    /*
> > > > > >     * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> > > > > 
> > > > > I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
> > > > 
> > > > Sorry, my fault, I should have made that fixup run earlier, so the
> > > > patch should be this instead:
> > > > 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 214ed060ca1b..4fc04015ca0c 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > >    * disable both L0s and L1 for now to be safe.
> > > >    */
> > > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> > > 
> > > L1 still got enabled

Is that based on the output below?

  [    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
  [    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1

If so, this doesn't necessarily mean L1 was enabled.  It means the
quirk marked the 00:00.0 Root Port so we shouldn't ever enable L0s or
L1, and when we enumerated 01:00.0, we set its default ASPM state to
L1.

But I don't *think* L1 should actually be enabled unless we can enable
it for both 00:00.0 and 01:00.0, and the quirk should mean that we
can't enable it for 00:00.0.

This muddle of "capable" (per Link Capabilities) vs "disabled" (either
the Link Control shows disabled, or software said "don't ever use L1")
is part of what makes aspm.c so confusing.

> > > The card works just fine. I'm thinking the ASPM issue is
> > > probably from the glue driver reporting the link to be down when
> > > it's really just in low power state.
> > 
> > You're probably right, the meson_pcie_link_up() not only checks
> > the LTSSM but also the speed, which is probably wrong.
> > 
> > Can you try removing the test for speed ?
> > 
> > -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
> > +                 if (smlh_up && rdlh_up && ltssm_up)
> > 
> > The other drivers just checks the link, and some only the smlh_up
> > && rdlh_up. So you can also probably drop ltssm_up aswell.
> 
> I can confirm that removing the check for ltssm_up and speed_okay
> made ASPM work.

I don't think meson_pcie_link_up() should have the loop in it, so the
ltssm_up and speed_okay checks, the loop, the delay, and the timeout
message should probably all be removed.  That method is supposed to be
a simple true/false check, and any waiting required should be done in
dw_pcie_wait_for_link().

The link was clearly up when we discovered 01:00.0, so the "wait
linkup timeout" messages from meson_pcie_link_up() after that must be
from dw_pcie_link_up() being called via the .map_bus() call in
pci_generic_config_read() or pci_generic_config_write().

When meson_pcie_link_up() returns false in those config accessors,
the config accesses will fail (they won't even be attempted), so we'll
see things like this:

  pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)

and "Unknown header type 7f" from lspci.

Can you drop the ASPM quirk patch and instead try the
meson_pcie_link_up() patch below on top of v6.18-rc3?

> We still need a solution to the original issue that's preventing the
> controller from being initialized.
> 
> My kernel has the following patch applied, but I think it's not
> suitable for upstream as this changes device tree bindings for PCIe
> controller on meson.

I assume the original issue is this:

  meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]

and you confirmed that it wasn't fixed by a1978b692a39 ("PCI: dwc: Use
custom pci_ops for root bus DBI vs ECAM config access"), which
appeared in v6.18-rc3?

If it's still broken in v6.18-rc3, and the dtsi and
meson_pcie_get_mems() patch below makes it work, we have more work to
do, and maybe Krishna has some ideas.

> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index dcc927a9da80..ca455f634834 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -138,7 +138,7 @@ pcie: pcie@fc000000 {
>  			reg = <0x0 0xfc000000 0x0 0x400000>,
>  			      <0x0 0xff648000 0x0 0x2000>,
>  			      <0x0 0xfc400000 0x0 0x200000>;
> -			reg-names = "elbi", "cfg", "config";
> +			reg-names = "dbi", "cfg", "config";
>  			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0>;
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 787469d1b396..404c4d9e1900 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -109,10 +109,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>  {
>  	struct dw_pcie *pci = &mp->pci;
> -	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);
> -
>  	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>  	if (IS_ERR(mp->cfg_base))
>  		return PTR_ERR(mp->cfg_base);

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396..13685d89227a 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -338,40 +338,10 @@ static struct pci_ops meson_pci_ops = {
 static bool meson_pcie_link_up(struct dw_pcie *pci)
 {
 	struct meson_pcie *mp = to_meson_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 speed_okay = 0;
-	u32 cnt = 0;
-	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
+	u32 state12;
 
-	do {
-		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
-		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
-		smlh_up = IS_SMLH_LINK_UP(state12);
-		rdlh_up = IS_RDLH_LINK_UP(state12);
-		ltssm_up = IS_LTSSM_UP(state12);
-
-		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
-			speed_okay = 1;
-
-		if (smlh_up)
-			dev_dbg(dev, "smlh_link_up is on\n");
-		if (rdlh_up)
-			dev_dbg(dev, "rdlh_link_up is on\n");
-		if (ltssm_up)
-			dev_dbg(dev, "ltssm_up is on\n");
-		if (speed_okay)
-			dev_dbg(dev, "speed_okay\n");
-
-		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
-			return true;
-
-		cnt++;
-
-		udelay(10);
-	} while (cnt < WAIT_LINKUP_TIMEOUT);
-
-	dev_err(dev, "error: wait linkup timeout\n");
-	return false;
+	state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
+	return IS_SMLH_LINK_UP(state12) && IS_RDLH_LINK_UP(state12);
 }
 
 static int meson_pcie_host_init(struct dw_pcie_rp *pp)

