Return-Path: <linux-pci+bounces-39580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B7C16DF2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F50C3566BD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179C2DC321;
	Tue, 28 Oct 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="a8H9SFyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCF2D9EE2;
	Tue, 28 Oct 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685705; cv=none; b=nQ3Eeuzc+YZKD+LpVMFjA81mgpN4ioSIUAyXjPOtDA4N7c50uymcHblX21fBSZgknHDigC6SIjExeMCHTagAG76TKbdZxuAdyAfzn4JrXHbJ+yVfyGxT6BDR71X8JIrdN+yLIb16JBQoZdjemE6d5doVXBLXcVic6j1PJeqo07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685705; c=relaxed/simple;
	bh=vfWX6xdO0lgd0htodyN3AupyeO0O4lVMQdK6JWpJiX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2B0MLVPtEVBnjhfuCosmaOCqUp8UrCqX37byg0wFRycZaeWxyd/t+c3x3MjFpqWhfcIGc3DtBkre/vpiiBbwnVrJ/vO1IpGeYV443TVRUxkNgD+e7Sivr63nI2u3lEky9U56AVQAb8phHgrEmm9hu7dUgjE8qqN3j3PmzoWm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=a8H9SFyk; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=Ffm4KPkf/6W48UcMMTcsGbPQba3i9kiox/XnAfVk4T0=; b=a8H9SFykx3+YTrmg/MyciN/yNQ
	b6EzTBu3RKSDamjxTvQLU9Lm4Qs3uAokbJG9P+LDj/VXiwq3xCF8kII0+fyec40MW9kWmYbqh3E64
	z16xNMGTnw3Lb0y5OiMqLzDYFVUxIDGFAfmyliL/Lo+qVDfPIgnbbc2aignaq/nYFgsV91hqXKK9B
	anKmlPAZc6jKSvC6dIziURlZKn0mbv7CJhVlHbuv7Tsm2QX9rr7bN3E4+9NNzTIT3/KDAjJFkJOZJ
	Uri6IyjQHssbjeG75z2Wqko4MfRWBbqqyg2i3OoXHmPPqSIgT7n9KzdhuGJeIpmIOC/JMPlOg7ZYY
	8PjgYBKA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vDqvC-0000000047k-2puT;
	Tue, 28 Oct 2025 22:08:02 +0100
Date: Tue, 28 Oct 2025 22:08:01 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <aQEwsdvx8fvPyj5k@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>,
	Johannes Erdfelt <johannes@erdfelt.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
 <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-10-28 14:10, Alex Elder wrote:
> On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> > On Tue, Oct 28, 2025, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > > Hi Alex,
> > > 
> > > On 2025-10-17 11:21, Alex Elder wrote:
> > > > On 10/16/25 11:47 AM, Aurelien Jarno wrote:
> > > > > Hi Alex,
> > > > > 
> > > > > On 2025-10-13 10:35, Alex Elder wrote:
> > > > > > This series introduces a PHY driver and a PCIe driver to support PCIe
> > > > > > on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> > > > > > Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> > > > > > PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> > > > > > one PCIe lane, and the other two ports each have two lanes.  All PCIe
> > > > > > ports operate at 5 GT/second.
> > > > > > 
> > > > > > The PCIe PHYs must be configured using a value that can only be
> > > > > > determined using the combo PHY, operating in PCIe mode.  To allow
> > > > > > that PHY to be used for USB, the calibration step is performed by
> > > > > > the PHY driver automatically at probe time.  Once this step is done,
> > > > > > the PHY can be used for either PCIe or USB.
> > > > > > 
> > > > > > Version 2 of this series incorporates suggestions made during the
> > > > > > review of version 1.  Specific highlights are detailed below.
> > > > > 
> > > > > With the issues mentioned in patch 4 fixed, this patchset works fine for
> > > > > me. That said I had to disable ASPM by passing pcie_aspm=off on the
> > > > > command line, as it is now enabled by default since 6.18-rc1 [1]. At
> > > > > this stage, I am not sure if it is an issue with my NVME drive or an
> > > > > issue with the controller.
> > > > 
> > > > Can you describe what symptoms you had that required you to pass
> > > > "pcie_aspm=off" on the kernel command line?
> > > > 
> > > > I see these lines in my boot log related to ASPM (and added by
> > > > the commit you link to), for both pcie1 and pcie2:
> > > > 
> > > >    pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 AS
> > > > PM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> > > >    pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> > > > 
> > > >    . . .
> > > > 
> > > >    nvme nvme0: pci function 0000:01:00.0
> > > >    nvme 0000:01:00.0: enabling device (0000 -> 0002)
> > > >    nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> > > >    nvme nvme0: 8/0/0 default/read/poll queues
> > > >     nvme0n1: p1
> > > > 
> > > > My NVMe drive on pcie1 works correctly.
> > > >    https://www.crucial.com/ssd/p3/CT1000P3SSD8
> > > > 
> > > >    root@bananapif3:~# df /a
> > > >    Filesystem     1K-blocks     Used Available Use% Mounted on
> > > >    /dev/nvme0n1p1 960302804 32063304 879385040   4% /a
> > > >    root@bananapif3:~#
> > > 
> > > Sorry for the delay, it took me time to test some more things and
> > > different SSDs. First of all I still see the issue with your v3 on top
> > > of v6.18-rc3, which includes some fixes for ASPM support [1].
> > > 
> > > I have tried 3 different SSDs, none of them are working, but the
> > > symptoms are different, although all related with ASPM (pcie_aspm=off
> > > workarounds the issue).
> > > 
> > > With a Fox Spirit PM18 SSD (Silicon Motion, Inc. SM2263EN/SM2263XT
> > > controller), I do not have more than this:
> > > [    5.196723] nvme nvme0: pci function 0000:01:00.0
> > > [    5.198843] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> > > 
> > > With a WD Blue SN570 SSD, I get this:
> > > [    5.199513] nvme nvme0: pci function 0000:01:00.0
> > > [    5.201653] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> > > [    5.270334] nvme nvme0: allocated 32 MiB host memory buffer (8 segments).
> > > [    5.277624] nvme nvme0: 8/0/0 default/read/poll queues
> > > [   19.192350] nvme nvme0: using unchecked data buffer
> > > [   48.108400] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > > [   48.113885] nvme nvme0: Does your device have a faulty power saving mode enabled?
> > > [   48.121346] nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
> > > [   48.176878] nvme0n1: I/O Cmd(0x2) @ LBA 0, 8 blocks, I/O Error (sct 0x3 / sc 0x71)
> > > [   48.181926] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
> > > [   48.243670] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> > > [   48.246914] nvme nvme0: Disabling device after reset failure: -19
> > > [   48.280495] Buffer I/O error on dev nvme0n1, logical block 0, async page read
> > > 
> > > 
> > > Finally with a PNY CS1030 SSD (Phison PS5015-E15 controller), I get this:
> > > [    5.215631] nvme nvme0: pci function 0000:01:00.0
> > > [    5.220435] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> > > [    5.329565] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> > > [   66.540485] nvme nvme0: I/O tag 28 (401c) QID 0 timeout, disable controller
> > > [   66.585245] nvme 0000:01:00.0: probe with driver nvme failed with error -4
> > > 
> > > Note that I also tested this latest SSD on a VisionFive 2 board with exactly
> > > the same kernel (I just moved the SSD and booted), and it works fine with ASPM
> > > enabled (confirmed with lspci).
> > 
> > I have been testing this patchset recently as well, but on an Orange Pi
> > RV2 board instead (and an extra RV2 specific patch to enable power to
> > the M.2 slot).
> > 
> > I ran into the same symptoms you had ("QID 0 timeout" after about 60
> > seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> > seems to work fine with the "pcie_aspm=off" workaround as well.
> 
> I don't see this problem, and haven't tried to reproduce it yet.
> 
> Mani told me I needed to add these lines to ensure the "runtime
> PM hierarchy of PCIe chain" won't be "broken":
> 
> 	pm_runtime_set_active()
> 	pm_runtime_no_callbacks()
> 	devm_pm_runtime_enable()
> 
> Just out of curiosity, could you try with those lines added
> just before these assignments in k1_pcie_probe()?
> 
> 	k1->pci.dev = dev;
> 	k1->pci.ops = &k1_pcie_ops;
> 	dw_pcie_cap_set(&k1->pci, REQ_RES);
> 
> I doubt it will fix what you're seeing, but at the moment I'm
> working on something else.
> 

Thanks for your fast answer. I have just tried this patch:

--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -271,6 +271,16 @@ static int k1_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(k1->phy),
 				     "failed to get PHY\n");
 
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+
+	pm_runtime_no_callbacks(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
 	k1->pci.dev = dev;
 	k1->pci.ops = &k1_pcie_ops;
 	dw_pcie_cap_set(&k1->pci, REQ_RES);

Unfortunately this doesn't fix the issue. On the positive side, things 
still work with it and pcie_aspm=off.

Regards
AUrelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

