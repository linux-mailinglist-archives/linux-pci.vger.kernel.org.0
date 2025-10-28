Return-Path: <linux-pci+bounces-39569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E73BEC16893
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF6AE4E45D4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8334E769;
	Tue, 28 Oct 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="pqT92oBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from out.bound.email (out.bound.email [141.193.244.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D87158857
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.244.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677317; cv=none; b=l4/f0dm7qDmKTVjmwOZuN3aAnyP5ANe0s3/wOpXdMGsA5biYz22w0j1Fkkia/jDiqXY2elhH5Xf+LPCngoC3Nyqd45VZK3eS4uxyObi/n3QYJb03cHWhjJP6kWkYEIsouSJTdQvm/DknWasdUENurgDkTLhBXU9PgtDaz0tNuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677317; c=relaxed/simple;
	bh=dfNimiinFQclKYj4feEPupDHw68CMdwrQXYVRrbk6Bo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW0ooa1JOI3w2WjmtOXnGXl9L13goG4bjEGvngj/gWiPy1hEeWBmcwMKPDh/I3KioDWKyXHXgUOofBLvMaCx92Nd4QhC/IEFd64Pj40Rowy9Ndg8mrCtcu6oONiRPLc/4ngpLOfWIgqGpSRx+gE14o197Io28hoZOfwzxAuAKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com; spf=pass smtp.mailfrom=erdfelt.com; dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b=pqT92oBb; arc=none smtp.client-ip=141.193.244.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdfelt.com
Received: from mail.sventech.com (localhost [127.0.0.1])
	by out.bound.email (Postfix) with ESMTP id 1A45D8A0A03;
	Tue, 28 Oct 2025 11:42:51 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
	id 007C7160036F; Tue, 28 Oct 2025 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
	s=default; t=1761676971;
	bh=6rT9Bd+Td5JykeAZTnRyALXkxex5lLcHHU1OfQThIbg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=pqT92oBbEj3UfuLDud7lIJ5J8fNzJgmn13zs0aX8HqKUlM8j/9yq46QKtJTFmFRha
	 3LpAdhe7CrQ5pk3V5gVfPRE7d6EVhxiBdHYoP9rA0lIHDB+3/01zFqILlzrfzxJUDD
	 9Bk+r6H+U6oBKc2Lc+gBRKVj557hkZ9VR2Cal6tc=
Date: Tue, 28 Oct 2025 11:42:50 -0700
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <20251028184250.GM15521@sventech.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQEElhSCRNqaPf8m@aurel32.net>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Tue, Oct 28, 2025, Aurelien Jarno <aurelien@aurel32.net> wrote:
> Hi Alex,
> 
> On 2025-10-17 11:21, Alex Elder wrote:
> > On 10/16/25 11:47 AM, Aurelien Jarno wrote:
> > > Hi Alex,
> > > 
> > > On 2025-10-13 10:35, Alex Elder wrote:
> > > > This series introduces a PHY driver and a PCIe driver to support PCIe
> > > > on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> > > > Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> > > > PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> > > > one PCIe lane, and the other two ports each have two lanes.  All PCIe
> > > > ports operate at 5 GT/second.
> > > > 
> > > > The PCIe PHYs must be configured using a value that can only be
> > > > determined using the combo PHY, operating in PCIe mode.  To allow
> > > > that PHY to be used for USB, the calibration step is performed by
> > > > the PHY driver automatically at probe time.  Once this step is done,
> > > > the PHY can be used for either PCIe or USB.
> > > > 
> > > > Version 2 of this series incorporates suggestions made during the
> > > > review of version 1.  Specific highlights are detailed below.
> > > 
> > > With the issues mentioned in patch 4 fixed, this patchset works fine for
> > > me. That said I had to disable ASPM by passing pcie_aspm=off on the
> > > command line, as it is now enabled by default since 6.18-rc1 [1]. At
> > > this stage, I am not sure if it is an issue with my NVME drive or an
> > > issue with the controller.
> > 
> > Can you describe what symptoms you had that required you to pass
> > "pcie_aspm=off" on the kernel command line?
> > 
> > I see these lines in my boot log related to ASPM (and added by
> > the commit you link to), for both pcie1 and pcie2:
> > 
> >   pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 AS
> > PM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> >   pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> > 
> >   . . .
> > 
> >   nvme nvme0: pci function 0000:01:00.0
> >   nvme 0000:01:00.0: enabling device (0000 -> 0002)
> >   nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> >   nvme nvme0: 8/0/0 default/read/poll queues
> >    nvme0n1: p1
> > 
> > My NVMe drive on pcie1 works correctly.
> >   https://www.crucial.com/ssd/p3/CT1000P3SSD8
> > 
> >   root@bananapif3:~# df /a
> >   Filesystem     1K-blocks     Used Available Use% Mounted on
> >   /dev/nvme0n1p1 960302804 32063304 879385040   4% /a
> >   root@bananapif3:~#
> 
> Sorry for the delay, it took me time to test some more things and 
> different SSDs. First of all I still see the issue with your v3 on top 
> of v6.18-rc3, which includes some fixes for ASPM support [1].
> 
> I have tried 3 different SSDs, none of them are working, but the 
> symptoms are different, although all related with ASPM (pcie_aspm=off 
> workarounds the issue).
> 
> With a Fox Spirit PM18 SSD (Silicon Motion, Inc. SM2263EN/SM2263XT 
> controller), I do not have more than this:
> [    5.196723] nvme nvme0: pci function 0000:01:00.0
> [    5.198843] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> 
> With a WD Blue SN570 SSD, I get this:
> [    5.199513] nvme nvme0: pci function 0000:01:00.0
> [    5.201653] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.270334] nvme nvme0: allocated 32 MiB host memory buffer (8 segments).
> [    5.277624] nvme nvme0: 8/0/0 default/read/poll queues
> [   19.192350] nvme nvme0: using unchecked data buffer
> [   48.108400] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> [   48.113885] nvme nvme0: Does your device have a faulty power saving mode enabled?
> [   48.121346] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
> [   48.176878] nvme0n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct 0x3 / sc 0x71) 
> [   48.181926] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
> [   48.243670] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [   48.246914] nvme nvme0: Disabling device after reset failure: -19
> [   48.280495] Buffer I/O error on dev nvme0n1, logical block 0, async page read
> 
> 
> Finally with a PNY CS1030 SSD (Phison PS5015-E15 controller), I get this:
> [    5.215631] nvme nvme0: pci function 0000:01:00.0
> [    5.220435] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.329565] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> [   66.540485] nvme nvme0: I/O tag 28 (401c) QID 0 timeout, disable controller
> [   66.585245] nvme 0000:01:00.0: probe with driver nvme failed with error -4
> 
> Note that I also tested this latest SSD on a VisionFive 2 board with exactly
> the same kernel (I just moved the SSD and booted), and it works fine with ASPM
> enabled (confirmed with lspci).

I have been testing this patchset recently as well, but on an Orange Pi
RV2 board instead (and an extra RV2 specific patch to enable power to
the M.2 slot).

I ran into the same symptoms you had ("QID 0 timeout" after about 60
seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
seems to work fine with the "pcie_aspm=off" workaround as well.

Of note, I don't have this problem with the vendor 6.6.63 kernel.

> > I basically want to know if there's something I should do with this
> > driver to address this.  (Mani, can you explain?)
> 
> I am not sure on my side how to debug that. What I know is that it is 
> linked to ASPM L1, L0 works fine. In other words the SSDs work fine with 
> this patch:
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 79b9651584737..1a134ec68b591 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -801,8 +801,8 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>  	if (of_have_populated_dt()) {
>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>  			link->aspm_default |= PCIE_LINK_STATE_L0S;
> -		if (link->aspm_support & PCIE_LINK_STATE_L1)
> -			link->aspm_default |= PCIE_LINK_STATE_L1;
> +//		if (link->aspm_support & PCIE_LINK_STATE_L1)
> +//			link->aspm_default |= PCIE_LINK_STATE_L1;
>  		override = link->aspm_default & ~link->aspm_enabled;
>  		if (override)
>  			pci_info(pdev, "ASPM: default states%s%s\n",
> 
> I can test more things if needed, but I don't know where to start.

I'm not a PCIe expert, but I'm more than happy to test as well.

JE


