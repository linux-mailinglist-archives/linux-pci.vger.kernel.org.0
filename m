Return-Path: <linux-pci+bounces-38186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA6BDDD59
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F24074E5585
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE002314D3B;
	Wed, 15 Oct 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSVBijxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE32BCF7F;
	Wed, 15 Oct 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521403; cv=none; b=IQgt0gGTMQDerwUV2ja86WDjaDvIU/vQGrLBWfnBrJlBbYxjEjPTw8TngtBCgDxyW2E++rHh3RcFEaLHwBwhIGcHxcrjUSlIClvU+3/+8J1PaChPEqPRZsTGQkqDOY0xBlCiNrypPicmMLOM3XQo9NN9eGbbtasT+VBpObFYbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521403; c=relaxed/simple;
	bh=ohU9p2wj4W925yjMw6YOgURwMS4OKHFNYtatSsax8Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgArI9wufETc2D3lrGJWZiOIFJ65x9EzSuInoOkavISnzf/VI98RHITK1yzojzG62H5Yc5LAsSyNtwUl1Hw7j6zjGMOSqtNMgRAbSF/91rbjiSu3CXAzR3Sel4dpDgoXQzjTOjQUWA8qr8o6zxNVQ+LDcww170XAHJtOIT+dOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSVBijxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B427C4CEF8;
	Wed, 15 Oct 2025 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521403;
	bh=ohU9p2wj4W925yjMw6YOgURwMS4OKHFNYtatSsax8Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSVBijxENX5rGNw3FqGWtQjw84u1qLNtOFXu2j+AGJI7Cqh5Sr2ec3rzfmGIYfGGF
	 bg2eQ5kBAfmjbmjFxV8bMOx/dh2sZh2Bny2IGuh0HUusCBF2mfYYzrjzAu09mz+R8P
	 8dEnM9AR/Md1hWK2jPW3Pl2dSvSIjELA2jKS+gSq5vWQvQXOm5Wg1qnrDnMDH9cFAw
	 KtrZryZNPL5NJNyM8QE3b5jHa15rEjotRyWsGtUXqEBUzQYKeVIBKwNI1fSt6UJ+wH
	 /rHyTFTonsvVUouTuL2hIVB2d8Qv/QlCuhnMwo/7irr6uXEI1r0KLevfXPO+g4rQUl
	 rnoxSJcKjPc6Q==
Date: Wed, 15 Oct 2025 15:13:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, regressions@lists.linux.dev, 
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <armtyxe7yab6l3sqiu6tsnnnuhzhhv6k63x2w4vdpenvramgof@26cqfazuyfog>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
 <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>

On Wed, Oct 15, 2025 at 05:11:39PM +0800, Shawn Lin wrote:
> Hi Mani
> 
> 在 2025/10/15 星期三 15:50, Manivannan Sadhasivam 写道:
> > On Wed, Oct 15, 2025 at 04:13:41PM +0900, FUKAUMI Naoki wrote:
> > > Hi,
> > > 
> > > On 10/15/25 15:26, Manivannan Sadhasivam wrote:
> > > > On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
> > > > > [+cc regressions]
> > > > > 
> > > > > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > > > > > Hi Manivannan Sadhasivam,
> > > > > > 
> > > > > > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
> > > > > > Rockchip RK3588(S) SoC.
> > > > > > 
> > > > > > When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
> > > > > > freezes or fails to probe M.2 Wi-Fi modules. This happens with several
> > > > > > different modules I've tested, including the Realtek RTL8852BE, MediaTek
> > > > > > MT7921E, and Intel AX210.
> > > > > > 
> > > > > > I've found that reverting the following commit (i.e., the patch I'm replying
> > > > > > to) resolves the problem:
> > > > > > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> > > > > 
> > > > > Thanks for the report, and sorry for the regression.
> > > > > 
> > > > > Since this affects several devices from different manufacturers and (I
> > > > > assume) different drivers, it seems likely that there's some issue
> > > > > with the Rockchip end, since ASPM probably works on these devices in
> > > > > other systems.  So we should figure out if there's something wrong
> > > > > with the way we configure ASPM, which we could potentially fix, or if
> > > > > there's a hardware issue and we need some king of quirk to prevent
> > > > > usage of ASPM on the affected platforms.
> > > > > 
> > > > 
> > > > I believe it is the latter. The Root Port is having trouble with ASPM.
> > > > 
> > > > FUKAUMI Naoki, could you please share the 'sudo lspci -vv' output so that we
> > > > know what kind of Root Port we are dealing with? You can revert the offending
> > > > patch and share the output.
> > > 
> > > Here is dmesg/lspci output on ROCK 5A(RK3588S):
> > >   https://gist.github.com/RadxaNaoki/1355a0b4278b6e51a61d89df7a535a5d
> > > 
> > 
> > Thanks! Could you please try the below diff with f3ac2ff14834 applied?
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..0069d06c282d 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >    */
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > 
> > +
> > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > +}
> > +
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);
> 
> That's not true from my POV. Rockchip platform supports all ASPM policy
> after mass production verification. I also verified current upstream
> code this morning with RK3588-EVB and can check L0s/L1/L1ss work fine.
> 
> The log and lspci output could be found here:
> https://pastebin.com/qizeYED7
> 
> Moreover, I disscussed this issue with FUKAUMI today off-list and his
> board seems to work when only disable L1ss by patching:
> 
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -813,7 +813,7 @@ static void pcie_aspm_override_default_link_state(struct
> pcie_link_state *link)
> 
>         /* For devicetree platforms, enable all ASPM states by default */
>         if (of_have_populated_dt()) {
> -               link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> +               link->aspm_default = PCIE_LINK_STATE_L0S |
> PCIE_LINK_STATE_L1;
>                 override = link->aspm_default & ~link->aspm_enabled;
>                 if (override)
>                         pci_info(pdev, "ASPM: DT platform,
> 
> 

Thanks a lot for debugging the issue. Now it is clear that the board routing is
on play and ASPM works fine on Rockchip Root Ports.

> So, is there a proper way to just disable this feature for spec boards
> instead of this Soc?
> 

Below should work:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..9864b2c91399 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -29,6 +29,7 @@
 #include <linux/ktime.h>
 #include <linux/mm.h>
 #include <linux/nvme.h>
+#include <linux/of.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -2525,6 +2526,19 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);

+
+static void quirk_disable_aspm_radxa(struct pci_dev *dev)
+{
+       if (of_machine_is_compatible("radxa,rock-5a") ||
+          (of_machine_is_compatible("radxa,rock-5b"))) {
+               pci_info(dev, "Disabling ASPM L1ss\n");
+               pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 |
+                                      PCIE_LINK_STATE_L1_2);
+       }
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_radxa);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this


- Mani

-- 
மணிவண்ணன் சதாசிவம்

