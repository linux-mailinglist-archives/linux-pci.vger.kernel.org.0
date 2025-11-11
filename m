Return-Path: <linux-pci+bounces-40869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032CC4CE6E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022461882C57
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C863451CA;
	Tue, 11 Nov 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGUA9Lae"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340D337B9E;
	Tue, 11 Nov 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855592; cv=none; b=TS8DXVLcEjjOeDcoYDZEEYm/CBp7OIhV7kYyQE31MU43u3o/eQOwrNZUtH4loL3I7DjRsEV3MkM8QxTmptjNOh3+4G3o2e+bnb5i4NVyqGO6KqLOJ1aKu+Utjq3OFt6QiynX0pijqW7UjD5XTzvheeda10mDA9TGX90c/gafUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855592; c=relaxed/simple;
	bh=OY34vNpbkB90bvmZi6ZLRQPxWPTqZjrwENr3EL+QS+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQCMwrG5JfVgIXiiUXsSM6ZfFB1iQK9EJGwICR0xae1/0IOFcvAkrHZ3tgXJQ+0+0JaBeO71LZNSA/WjDtB/mWtdmsenDaPb0zQ/sglIFryE9DW2hbs1RVW+F7JAnJ0oNtv+TZ9H7taGR6KBw6eChPQS3toXvQrUeI9J0lvXcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGUA9Lae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815D1C2BC86;
	Tue, 11 Nov 2025 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855591;
	bh=OY34vNpbkB90bvmZi6ZLRQPxWPTqZjrwENr3EL+QS+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGUA9Lae/nM+WYOO639bnUndKZjaReRZ17N2gmglCvDAnKfjMPd8+IRq7ikMcr5gM
	 cEynxUxC+R5cArbYc9A6XStEecWwkukBlnDqgEGmgC1oCwVziI8Z62ERZyK0Z/5VAd
	 9V7OaLmnqKoWNw7DFPe5n9hMtsNJ0sPn2SIPY1JXeLUMRHFpOoaBPLNkHhyMJjLRVi
	 FGgwC54GTnKx/qIe+kf6nVOyYYoyoxTaIcOMInGjEl16cZrzGDbRT4NGPhkYCwxI6a
	 ZvZAhvORakzUT9kSp4ldyZoPETZf0pM3g2c6thyMvfCOsDIC/tWnulN1Hdc+lgZhnB
	 B20E6eip4LfcA==
Date: Tue, 11 Nov 2025 15:36:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Vignesh Raman <vignesh.raman@collabora.com>, Valentine Burley <valentine.burley@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Message-ID: <twn5ryedkpv76ph3i7xbovktz3abqszthl6cxhtv6uczbv4ap7@4wrmlczxzjll>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
 <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
 <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>
 <qy4cnuj2dfpfsorpke6vg3skjyj2hgts5hhrrn5c5rzlt6l6uv@b4npmattvfcm>
 <c27b5514-1691-448a-9823-8b35955b0fc6@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c27b5514-1691-448a-9823-8b35955b0fc6@packett.cool>

On Tue, Nov 11, 2025 at 04:40:01AM -0300, Val Packett wrote:
> 
> On 11/11/25 4:19 AM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 11, 2025 at 03:51:03AM -0300, Val Packett wrote:
> > > On 11/8/25 1:18 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > Hi,
> > > > > 
> > > > > This series is one of the 'let's bite the bullet' kind, where we have decided to
> > > > > enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
> > > > > reason why devicetree platforms were chosen because, it will be of minimal
> > > > > impact compared to the ACPI platforms. So seemed ideal to test the waters.
> > > > > 
> > > > > This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
> > > > > supported ASPM states are getting enabled for both the NVMe and WLAN devices by
> > > > > default.
> > > > > [..]
> > > > The series breaks the DRM CI on DB820C board (apq8096, PCIe network
> > > > card, NFS root). The board resets randomly after some time ([1]).
> > > Is that reset.. due to the watchdog resetting a hard-frozen system?
> > > 
> > > Me and a bunch of other people in the #aarch64-laptops irc/matrix room have
> > > been experiencing these random hard freezes with ASPM enabled for the NVMe
> > > SSD, on Hamoa (and Purwa too I think) devices.
> > > 
> > Interesting! ASPM is tested and found to be working on Hamoa and other Qcom
> > chipsets also, except Makena based chipsets that doesn't support L0s due to
> > incorrect PHY settings. APQ8096 might be an exception since it is a really old
> > target and I'm digging up internally regarding the ASPM support.
> > 
> > > Totally unpredictable, could be after 4 minutes or 4 days of uptime.
> > > Panic-indicator LED not blinking, no reaction to magic SysRq, display image
> > > frozen, just a complete hang until the watchdog does the reset.
> > > 
> > I have KIOXIA SSD on my T14s. I do see some random hang, but I thought those
> > predate the ASPM enablement as I saw them earlier as well. But even before this
> > series, we had ASPM enabled for SSDs on Qcom targets (or devices that gets
> > enumerated during initial bus scan), so it might be that the SSD doesn't support
> > ASPM well enough.
> 
> I certainly remember that ASPM *was* enabled by default when I first got
> this laptop, via the custom way that predates this series.
> 
> Actually that custom enablement code getting removed was how I discovered it
> was ASPM related!
> 
> I pulled linux-next once and suddenly the system became stable!.. and then I
> noticed +2W of battery drain..
> 

Because, we only enable L0s and L1 by default and not L1ss.

> > But I'm clueless on why it results in a hang. What I know on ARM platforms is
> > that we get SError aborts and other crazy bus/NOC issues if the device doesn't
> > respond to the PCIe read request. So the hang could be due to one of those
> > issues.
> 
> Could the kernel be making requests before the device fully resumed from a
> sleep state?
> 

Kernel has no visibility on the PCIe link ASPM states as it happens autonomously
in hardware once enabled. So once kernel issues a PCIe read TLP, the link is
supposed to transition L0 and the device should respond. But if the link doesn't
come up for any reason, it will result in a completion timeout and weird things
happen on the host.

> > > I have confirmed with a modified (to accept args) enable-aspm.sh script[1]
> > > that disabling ASPM *only* for the SSD, while keeping it *on* for the WiFi
> > > adapter, is enough to keep the system stable (got to about a month of uptime
> > > in that state).
> > > 
> > So this confirms that the controller supports it, and the device (SSD) might be
> > of fault here.
> > 
> > > If you have reproduced the same issue on an entirely different SoC, it's
> > > probably a general driver issue.
> > > 
> > > Please, please help us debug this using your internal secret debug equipment
> > > :)
> > > 
> > Starting from v6.18-rc3, we only enable L0s and L1 by default on all devicetree
> > platforms. Are you seeing the hangs post -rc3 also? If so, could you please
> > share the SSD model by doing 'lspci -nn'?
> 
> Yes, still seeing them on 6.18.0-rc4-next-20251107. At least with
> pcie_aspm=force (have been using that recently, so likely all my testing
> "post -rc3" was with force on.. but others have been testing without it)
> 

pcie_aspm=force will forcefully enable all the ASPM states. So it will result in
the same crash if L1ss is not supported properly by the endpoint.

> I'm currently using the stock drive: Sandisk Corp PC SN740 NVMe SSD
> (DRAM-less) [15b7:5015] (rev 01)
> 

I'm suspecting the L1ss issue with this SSD since you said above that
next/master works fine until you pass 'pcie_aspm=force'. Could you try the below
diff with that cmdline option?

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44e780718953..ba48f8184b68 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,16 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+static void quirk_disable_aspm_l1ss(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM L1ss\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 |
+                               PCIE_LINK_STATE_L1_2 |
+                               PCIE_LINK_STATE_L1_1_PCIPM |
+                               PCIE_LINK_STATE_L1_2_PCIPM);
+}
+DECLARE_PCI_FIXUP_FINAL(0x15b7, 0x5015, quirk_disable_aspm_l1ss);
+
 /*
  * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
  * aspm.c won't try to enable them.

> Though for a couple months I've used a 3rd party one, an SK Hynix BC901
> [1c5c:1d59]
> 
> And other users have different other models and still have the same issue.
> 
> // Every time something PCIe related is posted to the mailing lists I've
> been wondering if it could solve this :D
> "Program correct T_POWER_ON value for L1.2 exit timing" didn't help. Testing
> "Remove DPC Extended Capability" now..
>

You could've reported this issue to linux-pci list.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

