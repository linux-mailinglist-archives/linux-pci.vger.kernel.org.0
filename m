Return-Path: <linux-pci+bounces-40620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F8C42CE3
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 13:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09A26349AB8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7954654;
	Sat,  8 Nov 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAe1C6aB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C3170A11;
	Sat,  8 Nov 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605272; cv=none; b=S0NUA1doN4Hb2tOtSH4ZahXp7D2ZxBl1qqAfQ+1VN1a087aIRzcTJ3JvrPqgIwJEagrMJydMgVi0Yb5hi8lSS3o7iauR6KZgihVuam2mYBtcyw0xxNJ9i/Xbuyzp6lG2jdvy0uyG2ZJZAk3I/B2wTjxblWMgx2ONUYnWCs1taBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605272; c=relaxed/simple;
	bh=45EdQFA6NEw7zfaldijyvwunk1IEh60CWkYy3zjQTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfLEdpS9PA3O/phyn+r8muAoDGH2USvdi0UDgycsjdtXjwgOlB7r05AuszRKlaJHwm3YYCXLlKtO7ra+HL/6g7RZf8CKj0c3i7TmsueZxkFgFifOuXMIJPr67J/3C8yTkqALK7QJWtDz1qnRjLvhs1WdQLZuaDf6Xr40i9Bv6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAe1C6aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A579C116C6;
	Sat,  8 Nov 2025 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762605272;
	bh=45EdQFA6NEw7zfaldijyvwunk1IEh60CWkYy3zjQTj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAe1C6aBQOu9ufMPYHKXtgVkRMFWTkasSqsDrHkF2pcnXXL2tKM478Rl/JOtw1fuA
	 bD0mol7BLa/ILSTZ5qVjy6diwgDi24ZKHJyysi3Pl5wz4IzIy0Uraf3VwDMLdaRgpr
	 AWFZCkK0vdShLRvi2D8ey+7byiPq9+7NaXIlNkITumuldt2OcQXRNyedOpLm9lBHrg
	 P7bITn3re31Mn5YZ6PGiwnoBGL/jeNK1YeK2+0lMuOIvQ0Qu8Mxs3ThqN3blG22LJ+
	 2wCof2QQuNkXYclObVKA0Mu34jcLNBvldL7On6QA5fE0MaWJAwAseZZHR3Ks29JLiX
	 8O1QW3z1i8/kQ==
Date: Sat, 8 Nov 2025 13:34:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <aQ840q5BxNS1eIai@ryzen>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>

Hello Shawn,

On Tue, Oct 21, 2025 at 03:10:13PM +0800, Shawn Lin wrote:
> 在 2025/10/21 星期二 12:26, FUKAUMI Naoki 写道:
> > Hi Niklas, Bjorn,
> > 
> > I noticed an issue on the Rockchip RK3588S SoC using the ASMedia ASM2806
> > PCIe bridge where devices behind the bridge fail to probe since v6.14.
> > Specifically, this started happening after commit
> > 647d69605c70368d54fc012fce8a43e8e5955b04.
> > dmesg logs from before and after this commit are available at:
> >   https://gist.github.com/RadxaNaoki/fca2bfca2ee80fefee7b00c7967d2e3d
> > 
> > I have confirmed that reverting the following commits fixes the issue:
> >   commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we
> > can detect Link Up")
> >   commit 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on
> > dll_link_up IRQ")
> > 
> 
> Then these two commits would like to reply on link up irq instead of
> fixed delay in dwc framework. Here is a not very precise timeline
> description.
> 
> time(ms) |  dw_pcie_wait_for_link（）     | sys irq_thread() | Hot reset
> -------------------------------------------------------------------------
> 0:       |  dw_pcie_link_up return false  |  link up irq     |
> 1x       |  Physical link up happend      |                  |
> 90:      |  dw_pcie_link_up return true   |                  |
> 100:     |                                |  msleep(100) done|
> 10x:     |                                |  pci_rescan_bus  |
> 1xx:     |                                |                  | <==occur
> 190:     |  msleep(90) done               |                  |
> 19x:     |  pci_host_probe                |                  |
> 
> What if the hot reset happens when pci_rescan_bus() starts. I think
> scan devices possible fail when seeing 0xffffffff from cfg read. But
> a 90ms delay perfectly avoids this event in dw_pcie_wait_for_link(), and by
> the time the 90ms delay is completed, the link is actually in an
> accessible state.

The pcie-dw-rockchip.c driver is modelled after the qcom driver.
So if this is a problem when a ASM2806 switch is connected, I would
expect qcom platforms to have the same problem.


Do we have a PCI trace that can tell us exactly what goes wrong?

FUKAUMI-san tells us that the enumeration does not detect any devices,
but also that there is no crash.

If we assume the scenario from your timeline above, that a hot reset
happens just after pci_rescan_bus(), after a hot reset, LTSSM should
re-enter link training.

I verified this:
# bc=$(setpci -s 0000:00:00.0 BRIDGE_CONTROL)
# setpci -s 0000:00:00.0 BRIDGE_CONTROL=$(printf "%04x" $((0x$bc | 0x40))) && sl eep 0.01 && setpci -s 0000:00:00.0 BRIDGE_CONTROL=$bc
[   65.723990] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x7
[   65.724701] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x30011
[   65.825787] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!

So we get another link up IRQ after the hot reset.

The IRQ handler for this IRQ will once again call pci_rescan_bus().
So I would expect that this second pci_rescan_bus() call would actually
be able to find the device behind the switch.


Mani, Bjorn, thoughts?



Kind regards,
Niklas

