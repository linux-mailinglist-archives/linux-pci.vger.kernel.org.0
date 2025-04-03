Return-Path: <linux-pci+bounces-25221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1CA79D6C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5D2169CF3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF51E9907;
	Thu,  3 Apr 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+mLFcXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF531A23B9;
	Thu,  3 Apr 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743666696; cv=none; b=fpai96uLkJfbEcmL/dvWFRsuVMf16HXC1Sf8AvrfEaJTSloxNmjgEWLbb+9YPD1t9AA0qWtLSLdCMhkY0TljhiA2AhjnJm9Pma6CUBDiw7wDTvz1af7aGVFhplQvHhf2pvtATV2ucuCiN/nBFfNdFkzNAPwWeOva/ORgMAlGL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743666696; c=relaxed/simple;
	bh=HgREi2TEwo6N2+hYXWlTaI98UuKWyJ62RZLvA9oS6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaUeZedYtW0EejsfwkpH5Ns/djBEhTOVOgosdwNUoJPVtpZpBSxn+IxyyiiPn3al7CXd4ZXEB43lUI1UbNpugJ9fgbe/rWu4o/dyw2cPgAMIUOXdZpOB8LgJgCY05tVQ/RUQINexLBHp+U/vZOSIxaxZ8jL1lksMTzOp0nLldeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+mLFcXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2EAC4CEE8;
	Thu,  3 Apr 2025 07:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743666696;
	bh=HgREi2TEwo6N2+hYXWlTaI98UuKWyJ62RZLvA9oS6nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+mLFcXGiS0krmDPDIt3U/rcqzp19bD4yRsgaVMJN2Aj8/NUCGyM0CEv9oaB3/wCu
	 WXg/VBCBr4hNzNGMC0S7utiqtnkJSwL0pjp7hV8OyRQS2dr5Gcug/Y52DF4OiAd++V
	 L1GEAHOI5+6lE2lgDfVv+NEkKBn8xlnIf1LmdgNpAXJv05ZbM06Q2IXYeUlLsMKoz1
	 IyO4dNHKJBlwwE1R0bf3uPPpsca2VuVFWHmAVOqpurC47SKkfi1KODHKV2HMlsFkUS
	 q+Vj/wwtJVeXouFLu7kuLvKF91C58Q3+Tf7fm6y2DuFyJiGE5oMPNJDM4bnYu3POyg
	 H+2o9lx7QpQjA==
Date: Thu, 3 Apr 2025 09:51:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_vpernami@quicinc.com
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback
Message-ID: <Z-4-A29UddizBUPz@ryzen>
References: <20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com>
 <Z-0xJpBrO4wN9UzN@ryzen>
 <798f9a15-f3de-18fa-1b8f-2c9973e8be61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798f9a15-f3de-18fa-1b8f-2c9973e8be61@oss.qualcomm.com>

Hello Krishna,

On Thu, Apr 03, 2025 at 09:26:08AM +0530, Krishna Chaitanya Chundru wrote:
> On 4/2/2025 6:14 PM, Niklas Cassel wrote:
> > 
> > Out of curiosity, I tried something similar to on pcie-dw-rockchip.c
> > 
> > Simply having a ->shutdown() callback that only calls dw_pcie_host_deinit()
> > was enough for me to produce:
> > 
> > [   40.209887] r8169 0004:41:00.0 eth0: Link is Down
> > [   40.216572] ------------[ cut here ]------------
> > [   40.216986] called from state HALTED
> > [   40.217317] WARNING: CPU: 7 PID: 265 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0
> > [   40.218024] Modules linked in: rk805_pwrkey hantro_vpu v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem videobuf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_common vidf
> > [   40.220267] CPU: 7 UID: 0 PID: 265 Comm: init Not tainted 6.14.0+ #134 PREEMPT
> > [   40.220908] Hardware name: Radxa ROCK 5B (DT)
> > [   40.221289] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   40.221899] pc : phy_stop+0x134/0x1a0
> > [   40.222222] lr : phy_stop+0x134/0x1a0
> > [   40.222546] sp : ffff800082213820
> > [   40.222836] x29: ffff800082213820 x28: ffff45ec84b30000 x27: 0000000000000000
> > [   40.223463] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbe8df7fde030
> > [   40.224088] x23: ffff800082213990 x22: 0000000000000001 x21: ffff45ec80e10000
> > [   40.224714] x20: ffff45ec82cb40c8 x19: ffff45ec82ccc000 x18: 0000000000000006
> > [   40.225340] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0720072007200720
> > [   40.225966] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> > [   40.226592] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffbe8df556469c
> > [   40.227217] x8 : 0000000000000268 x7 : ffffbe8df7a48648 x6 : ffffbe8df7a48648
> > [   40.227842] x5 : 0000000000017fe8 x4 : 0000000000000000 x3 : 0000000000000000
> > [   40.228468] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff45ec84b30000
> > [   40.229093] Call trace:
> > [   40.229308]  phy_stop+0x134/0x1a0 (P)
> > [   40.229634]  rtl8169_down+0x34/0x280
> > [   40.229952]  rtl8169_close+0x64/0x100
> > [   40.230275]  __dev_close_many+0xbc/0x1f0
> > [   40.230621]  dev_close_many+0x94/0x160
> > [   40.230951]  unregister_netdevice_many_notify+0x14c/0x9c0
> > [   40.231426]  unregister_netdevice_queue+0xe4/0x100
> > [   40.231848]  unregister_netdev+0x2c/0x60
> > [   40.232193]  rtl_remove_one+0xa0/0xe0
> > [   40.232517]  pci_device_remove+0x4c/0xf8
> > [   40.232864]  device_remove+0x54/0x90
> > [   40.233182]  device_release_driver_internal+0x1d4/0x238
> > [   40.233643]  device_release_driver+0x20/0x38
> > [   40.234019]  pci_stop_bus_device+0x84/0xe0
> > [   40.234381]  pci_stop_bus_device+0x40/0xe0
> > [   40.234741]  pci_stop_root_bus+0x48/0x80
> > [   40.235087]  dw_pcie_host_deinit+0x34/0xe0
> > [   40.235452]  rockchip_pcie_shutdown+0x24/0x48
> > [   40.235839]  platform_shutdown+0x2c/0x48
> > [   40.236187]  device_shutdown+0x150/0x278
> > [   40.236533]  kernel_restart+0x4c/0xb8
> > [   40.236859]  __do_sys_reboot+0x178/0x280
> > [   40.237206]  __arm64_sys_reboot+0x2c/0x40
> > [   40.237561]  invoke_syscall+0x50/0x120
> > [   40.237891]  el0_svc_common.constprop.0+0x48/0xf0
> > [   40.238305]  do_el0_svc+0x24/0x38
> > [   40.238597]  el0_svc+0x30/0xd0
> > [   40.238868]  el0t_64_sync_handler+0x10c/0x138
> > [   40.239251]  el0t_64_sync+0x198/0x1a0
> > [   40.239575] ---[ end trace 0000000000000000 ]---
> > 
> Hi Niklas,
> 
> The issue which you are seeing with specific to the RealTek ethernet
> driver and should be fixed by RealTek driver nothing to do with the host
> controller.

The warning comes from:
drivers/net/phy/phy.c:phy_stop()
so from the networking phylib.

Doing a simple:
$ git grep -p phy_stop

shows that practially all Ethernet drivers call phy_stop() from the
.ndo_stop() callback.

So after your suggested patch, you should see this warning appear with
any NIC, if connected to your PCIe controller.

You might not care, which is fine, I simply wanted to inform you about it,
since it is not only realtek, it is any NIC.


Kind regards,
Niklas

