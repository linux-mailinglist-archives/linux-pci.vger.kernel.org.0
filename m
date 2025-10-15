Return-Path: <linux-pci+bounces-38162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A231BDD32D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8EA4ECF59
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D083148A2;
	Wed, 15 Oct 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFq4PluN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9F313E2E;
	Wed, 15 Oct 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514634; cv=none; b=n8OcsIVp2e4fXs/QFoeQbpilD3n2+Hb0KNz3p/q61cw/2P3C45O/qjKH42MZdkNoHAuXQn62JE+P+RFett5VZ8OCz9p4mbqdEItV4LDbkCsg6la+W9zDMdmKpi9OagTpwSJTtJDxJcnXbF+MJrpIxtFviD5XhWsXdQJMrEn0AeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514634; c=relaxed/simple;
	bh=N+KdJSmTL8JhpieQRxlnbC6Rxa5LC8KfPeDrItfVC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQw6ioCUXX2wQeQAUPRF+waqm75zuH+/Q6zmnj+rlMilQShA6bMsjn4j8GQoj01a+0CQUZjBBW6BfWVCTkCco+PGUNFL/bn9F0KVAq/eJOXhuq/PpFgQpwU4vnoIsJHl+5NTMQbE0CFhHuzLozcZ7ZMZ1JD9AZp5yt35ia+vcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFq4PluN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3CDC4CEF8;
	Wed, 15 Oct 2025 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760514633;
	bh=N+KdJSmTL8JhpieQRxlnbC6Rxa5LC8KfPeDrItfVC1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFq4PluNMb3ZTq1LSh3igXo6xNp00Fu9larjvGLpNnmxT0zX80tUE7p0BQc2oonmg
	 u+7REggKqKVjKJDAecTZYIMF7Xjq8SkHUwHmSUnyTDMHI3FREcrYMtESr9l3kiJnQi
	 y3FXKtVzboRvHpvEqKOfHN337IO+djyYCmcQ34qP67FK5J6VlEYMIXHL/kDe2jUuf0
	 Nu5GCbaARvK3xRfsIMmweCuilsHJ/6nQ4TNeDtYFZWP9ypiFOxEpQ8brXEV9NBvlIB
	 KJVqsWzD1PHI7QvPve9VKFGKcL/kSy2IGc3GNA0xXeXyFlb6vby6bpQ0wYpnvqk5DP
	 2lZDyc5Em93Zw==
Date: Wed, 15 Oct 2025 13:20:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>

On Wed, Oct 15, 2025 at 04:13:41PM +0900, FUKAUMI Naoki wrote:
> Hi,
> 
> On 10/15/25 15:26, Manivannan Sadhasivam wrote:
> > On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
> > > [+cc regressions]
> > > 
> > > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > > > Hi Manivannan Sadhasivam,
> > > > 
> > > > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
> > > > Rockchip RK3588(S) SoC.
> > > > 
> > > > When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
> > > > freezes or fails to probe M.2 Wi-Fi modules. This happens with several
> > > > different modules I've tested, including the Realtek RTL8852BE, MediaTek
> > > > MT7921E, and Intel AX210.
> > > > 
> > > > I've found that reverting the following commit (i.e., the patch I'm replying
> > > > to) resolves the problem:
> > > > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> > > 
> > > Thanks for the report, and sorry for the regression.
> > > 
> > > Since this affects several devices from different manufacturers and (I
> > > assume) different drivers, it seems likely that there's some issue
> > > with the Rockchip end, since ASPM probably works on these devices in
> > > other systems.  So we should figure out if there's something wrong
> > > with the way we configure ASPM, which we could potentially fix, or if
> > > there's a hardware issue and we need some king of quirk to prevent
> > > usage of ASPM on the affected platforms.
> > > 
> > 
> > I believe it is the latter. The Root Port is having trouble with ASPM.
> > 
> > FUKAUMI Naoki, could you please share the 'sudo lspci -vv' output so that we
> > know what kind of Root Port we are dealing with? You can revert the offending
> > patch and share the output.
> 
> Here is dmesg/lspci output on ROCK 5A(RK3588S):
>  https://gist.github.com/RadxaNaoki/1355a0b4278b6e51a61d89df7a535a5d
> 

Thanks! Could you please try the below diff with f3ac2ff14834 applied?

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..0069d06c282d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);

+
+static void quirk_disable_aspm_all(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this


From your previous comment, I believe the Root Port is having the issues with
ASPM as you seem to have tried connecting different devices to the slot. So I
disabled ASPM for the Root Port with the above diff.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

