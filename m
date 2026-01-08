Return-Path: <linux-pci+bounces-44290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641DD04BD2
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BDD2300BDA8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E076248F6F;
	Thu,  8 Jan 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwQrtVcU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3D225A35
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891922; cv=none; b=Eth8WUrwyOBtBFJ5yZ+0fVsSAAUPu+4a7+XiKrcNuMUlW+pmylqebTqnuNtYShfIv/TGjulp+24r7F4m6IvIIkngs3iXd+RxziwOQevouUpmnBON9nOwC8pAd25+w03kygHPTupsyjhn88+wseDnLSxrG8iAXV9x7dAaqKjBqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891922; c=relaxed/simple;
	bh=W9EI4lwWgFH3ZRQXYjHd1qk8c3nYDntHmab2DuzB4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2249EX7OgbFJ8GgZhmTUaOt6jXsHSd7H7xWUaZmNS9e0FF90hgum/dyh1wfrx9W5jeWXQnxIPMilkxNdoCg4XeQ0Y6+5F+SKrWLPKD9yHazLN+UbXyx3S5/VO6sa5WomF51YnnGU3LPos4sSWHDqda+CONrpX3eSghc7tCaXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwQrtVcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5701C116C6;
	Thu,  8 Jan 2026 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891922;
	bh=W9EI4lwWgFH3ZRQXYjHd1qk8c3nYDntHmab2DuzB4qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwQrtVcURzGnyMsAlhfouXp/qB2AN7dH4fqnsbAn+p7gcJAXMQygp7j3LH+PHQSqI
	 aUpeciEq24+9Bd6LDFUmLEfyKlxwInDIveXjmOeMmOwcN+NLoauzLpJtdEuHAOKnAF
	 cYki8bc6Kd7O1PWxEptCSFjWzOp9AXNvLUabLtqRxbmbHvO5C1NYs8hsJ/1gv9WKmB
	 LzBvrtbdrXgYYyWJ8G4JEKSKyu5NKfm6fnQzZlcvbPwAugV5vj/z/+ktbUiGdNPrXW
	 t/ALyfLTuBwcILYONJLNdExutGUHnClePHNH+bohqQNbdBCc1FnxACr76dYnmJaE+/
	 mLIEM4yaYjxDA==
Date: Thu, 8 Jan 2026 22:35:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
Message-ID: <ym435w3ltwc7vln7g6j3ijswsarubwjazux65ttcqtrbr3i5fu@gig3qlzdkopf>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <cudy2lfd7q7tujfivampgciziuho7izkpvmabj3qa2udvzkvfh@lw5vasqcrs6c>
 <2e1a3eff-5d4d-4e3a-a076-ef8a76e08d4c@rock-chips.com>
 <lhshuxj4aztwbernypwgaxkdtxzonzydzipu63mspbqfygyrvy@nggpj7vwsw7n>
 <70b6e8c9-8dbe-484a-b8a8-aeb7380b6ca2@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b6e8c9-8dbe-484a-b8a8-aeb7380b6ca2@rock-chips.com>

On Thu, Jan 08, 2026 at 12:58:28PM +0800, Shawn Lin wrote:
> 在 2026/01/08 星期四 12:49, Manivannan Sadhasivam 写道:
> > On Thu, Jan 08, 2026 at 09:01:43AM +0800, Shawn Lin wrote:
> > > 在 2026/01/07 星期三 20:41, Manivannan Sadhasivam 写道:
> > > > On Tue, Jan 06, 2026 at 05:18:38PM +0800, Shawn Lin wrote:
> > > > > Some platforms may provide LTSSM trace functionality, recording historical
> > > > > LTSSM state transition information. This is very useful for debugging, such
> > > > > as when certain devices cannot be recognized. Add an ltssm_trace operation
> > > > > node in debugfs for platform which could provide these information to show
> > > > > the LTSSM history.
> > > > > 
> > > > 
> > > > Why don't you implement it as a tracepoint since you want to expose traces?
> > > > 
> > > 
> > > I evaluated this option but didn't choose to do it just as I didn't
> > > want to select CONFIG_TRACING_SUPPORT for dwc driver because of this
> > > cheap function. But I'm fine to implement it as a tracepoint. Just to
> > > make it clear, if a tracepoint is preferred, should I need to create a new
> > > file like pcie-designware-trace?
> > > 
> > 
> > I would prefer that, because that will allow us to add more tracepoints in the
> > future and not muddle pcie-designware.h. General convention is to define
> > trace events in a separate header.
> > 
> 
> I did a quick convention by adding it to the existing
> include/trace/events/pci.h

Is this an existing file? I couldn't see it. But anyway, I think it would be
better to create a separate file for controller drivers. PCI core may end up
having its own tracepoint in the future and mixing both will lead to confusion.

> 
> The TRACE_EVENT is called pcie_ltssm_state_change, making it not just
> for dwc-based but for all possible coming host drivers and the output
> looks like below. Is that the way you expected?
> 
> root@debian:/#echo 1 >
> /sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_change/enable

/sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable

> root@debian:/# cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 572/572   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
> 
> ...
>      kworker/1:1-109     [001] .....     4.719968: ltssm_state_change: dev:
> a40000000.pcie state: 0x0d rate: 8.0 GT/s PCIe

Can you print the state name using dw_pcie_ltssm_status_string() with:
https://lore.kernel.org/linux-pci/20260107-pci-dwc-suspend-rework-v4-2-9b5f3c72df0a@oss.qualcomm.com/

Also you can remove 'PCIe' at the end.

Rest LGTM, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

