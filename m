Return-Path: <linux-pci+bounces-44001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D0CF351A
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B2D3003076
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F83195EF;
	Mon,  5 Jan 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVmSS2dV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009A3191C6;
	Mon,  5 Jan 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613311; cv=none; b=OJy/KP+OfCUGzgsk0uvonme9zwG/eg71GQOz8fm85nNEPgX95o2Xg5meWBbwoEYTe0zNZhZP8Wt4W7fTI/GC75tx4hIqn1kpXY04bZy+YFHK1Z8fpkT2H+mNZk1YxZm0n/JU/thtNddLqJEvYNbnwcAoZKoXCagaHGw8gqMxaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613311; c=relaxed/simple;
	bh=ZnWJRu5bMZyuao8+myPfH6g27n1qqOts89M3KQ+T/hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSj54qOhOv1turP+FSbr0XB1iS3WAwy1CbRlZvSQUV297e3/5GZWDC2Ucy8PJyiKtUIywheFt2R8J6NvjzUceuzjXaVI9XGs6hETZwI+umoPzNi3g00wyXJljP2FnMpee9g/d6baMg6rSUiw2GMehPGLvtCTs4pzY0qZvCGTAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVmSS2dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58510C19423;
	Mon,  5 Jan 2026 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767613310;
	bh=ZnWJRu5bMZyuao8+myPfH6g27n1qqOts89M3KQ+T/hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVmSS2dVEg4cHs0xzG2/iPZLPapp4xEE+da64O22p4c3lrXPoleulbcSQAt4mJ1Sv
	 K/7JtgwurlPOTUuE9rxAaMYkxXjXmY+/zxEmh6hNvziMLpDVC8mf2RVnSVxzeqNHli
	 GVSpTXpp+QPlhpTrZ1mW5BHqm+0A1DlsGH+0xMvWu9JT+J6cm7qYFUDIuG84cTc6tO
	 e0GZQbdYVdLnwPDUH8TL2z/sJ8aHEWO8BOv9XFJ8s8eOYxgUF1xLUN+hDSoDb3AvD3
	 PV9yC7kXLVhnXvdKBfnoSkNh9+LQAIdhCU9LNguWUdBKh0CpBQ/vA93xt8UvmUOmsP
	 TBRukzGHXuEWA==
Date: Mon, 5 Jan 2026 17:11:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVezfq-8bTKczYkp@ryzen>

On Fri, Jan 02, 2026 at 01:01:02PM +0100, Niklas Cassel wrote:
> On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> >
> > This series reworks the dw_pcie_wait_for_link() API to allow the callers to
> > detect the absence of the device on the bus and skip the failure.
> >
> > Compared to v2, I've reworked the patch 2 to improve the API further and
> > dropped the patch 1 that got applied (hence changed the subject). I've also
> > modified the error code based on the feedback in v2 to return -ENODEV if device
> > is not detected on the bus and -ETIMEDOUT otherwise. This allows the callers to
> > skip the failure if device is not detected and handle error for other failure.
> >
> > Testing
> > =======
> >
> > Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
> > dw_pcie_wait_for_link() API prints:
> >
> >	qcom-pcie 1c08000.pcie: Device not found
> >
> > Instead of the previous log:
> >
> >	qcom-pcie 1c08000.pcie: Phy link never came up
> 
> Hello Mani,
> 
> I really like this series.
> 
> However when testing my usual setup with 2 Rock 5B:s, one in EP mode, one
> in RC mode, where I usually power on both boards at the same time, but only
> after both boards are booted, do I do the configfs write to enable the link
> training on EP, and then do a rescan on the RC.
> 
> Even with this series, this workflow still works in 8 out of 10 boots.
> 
> 
> However, in 2 out of 10 boots I instead got:
> [    2.285827] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE
> [    2.286584] rockchip-dw-pcie a40000000.pcie: probe with driver rockchip-dw-pcie failed with error -110
> 
> In both cases LTSSM was in POLL_COMPLIANCE.
> 
> 
> Considering that things work in 8 out of 10 boots, means that the LTSSM state
> was in Detect.Quiet or Detect.Active.
> 
> I did comment out goto err_stop_link if dw_pcie_wait_for_link(), so I can dump
> LTSSM afterwards, when this happens.
> 
> [    2.293785] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_COMPLIANCE
> 
> Then I do:
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
> POLL_COMPLIANCE (0x03)
> 
> So LTSSM is still in Poll.Compliance.
> 
> However, as soon as I do the configfs writes on the EP board:
> 
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
> L0 (0x11)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status 
> L0 (0x11)
> 
> LTSSM transitions out of compliance, and rescan will find my device:
> 
> # echo 1 > /sys/bus/pci/devices/0000:00:00.0/rescan 
> [  246.777867] pci 0000:01:00.0: [1d87:3588] type 00 class 0xff0000 PCIe Endpoint
> [  246.778627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [  246.779151] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [  246.779672] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000fffff]
> [  246.780192] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x000fffff]
> [  246.780716] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [  246.781236] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> 
> 
> 
> I understand that in most normal situations, the endpoint is powered on
> before powering on the host side (or there is no EP connected at all).
> But somehow, for us PCIe endpoint developers, it would be nice if we
> could keep the behavior of being able to rescan the bus, even when the EP
> is not powered on before the host side.
> 

What could be happening here is that since the endpoint is physically connected
to the bus, the receiver gets detected during Detect.Active state and LTSSM
enters the Polling state. I think the reason why it ended up staying in
Poll.Compliance could be due to (as per the spec):

a. Not all Lanes from the predetermined set of Lanes from above have
detected an exit from Electrical Idle since entering Polling.Active.

b. Any Lane that detected a Receiver during Detect received eight consecutive
TS1 Ordered Sets (or their complement) with the Lane and Link numbers set to
PAD, the Compliance Receive bit (bit 4 of Symbol 5) is 1b, and the Loopback bit
(bit 2 of Symbol 5) is 0b that the Compliance Receive bit (bit 4 of Symbol 5) is
set.

So this is perfectly legal from endpoint perspective.

> Perhaps a Kconfig or module param? Suggestions?
> 

There is a DIRECT_POLCOMP_TO_DETECT bit (bit 9) in DBI SD_CONTROL2 register.
This bit will ensure that the LTSSM will not stuck in Poll.Compliance and will
return back to Detect state. Could you set it on the EP before starting LTSSM
and see if it helps?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

