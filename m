Return-Path: <linux-pci+bounces-19328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0AA02418
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF20418856B3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAE1D5CE5;
	Mon,  6 Jan 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkoWukeZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA831D9A56;
	Mon,  6 Jan 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162278; cv=none; b=AKiuXznFUCMUdb6tub2Yxg9aeV/GHN5qeJ4UbfPxUUww2gPuU2RW8AVH5fuE36iZTJS9/qNOxc++EdfuaPWzT0lwShds6bp3/Z/EwLvP+/QNXnV1bjYSkpSw0Z+UZTwW/k0rTSUM6/Y8oFF6ImlZ7P9/RT/stQR9brZVlhVqjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162278; c=relaxed/simple;
	bh=Bq/pnYFsE3I0zcZZpfR6gK1mHvcQk7XJiDVsVg9HHp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXSCwq/EftSU581qVkCOrBb8wRqsqguWG69Em50r09t3sIA8XFThR22ifTnK68PIm3TR/3tymUOGFXMc8yNZQMjld67xlshyLC5GPM/bwjuvLiH5qM6le/vi9cSwlPSr/mRu+N9yK5Ny2tO6JmNq+2q4L4a2HLgk9yPqXWvq58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkoWukeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD17EC4CED2;
	Mon,  6 Jan 2025 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736162278;
	bh=Bq/pnYFsE3I0zcZZpfR6gK1mHvcQk7XJiDVsVg9HHp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkoWukeZLZpW6My59uxEtxmpR/C2wLXqnd1z45Hh1LA2mF4lvSpFmt5B5ksd5T9k2
	 w58W5Rjb/0f7p8WhfxOspSAFj51pbAzF2DJY3LGovSAfOzbsMsuyk9IiGiA8U8E72R
	 cslPFw98C1KUF4tnGeg7G5XztgDx5k9rjZC70dZJ797YWKOANrKCxp9qhqhZfNMEdr
	 PXEQ6NYfBxkhjxP2xuWL45f93uF8FA01OJBelznH0Irbq8mEk/vHGR5gKJMJR3Ijcu
	 ZSqc9LM4fcxzh+mHHUQPwMMIJNYpsCcZlvpfafLQD46Hi3jA+RjqJCYUHuiWDwjHNY
	 bY4iEJcBXckNg==
Date: Mon, 6 Jan 2025 11:17:52 +0000
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bhelgaas@google.com, pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com, Gerhard Engleder <eg@keba.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [PATCH iwl-next v4] e1000e: Fix real-time violations on link up
Message-ID: <20250106111752.GC4068@kernel.org>
References: <20241219192743.4499-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219192743.4499-1-gerhard@engleder-embedded.com>

On Thu, Dec 19, 2024 at 08:27:43PM +0100, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all
> writes are flushed. As a result, DMA transfers of other targets suffer
> from delay in the range of 50us. This results in timing violations on
> real-time systems during link down and up of e1000e in combination with
> an Intel i3-2310E Sandy Bridge CPU.
> 
> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
> robot controller. The exact root cause of the problem is unclear and
> this situation won't change as Intel support for this CPU has ended
> years ago. Our experience is that the number of posted PCIe writes needs
> to be limited at least for real-time systems. With posted PCIe writes a
> much higher throughput can be generated than with PCIe reads which
> cannot be posted. Thus, the load on the interconnect is much higher.
> Additionally, a PCIe read waits until all posted PCIe writes are done.
> Therefore, the PCIe read can block the CPU for much more than 10us if a
> lot of PCIe writes were posted before. Both issues are the reason why we
> are limiting the number of posted PCIe writes in row in general for our
> real-time systems, not only for this driver.
> 
> A flush after a low enough number of posted PCIe writes eliminates the
> delay but also increases the time needed for MTA table update. The
> following measurements were done on i3-2310E with e1000e for 128 MTA
> table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> ---
> v4:
> - add PREEMPT_RT dependency again (Vitaly Lifshits)
> - fix comment styple (Alexander Lobakin)
> - add to comment each 8th and explain why (Alexander Lobakin)
> - simplify check for every 8th write (Alexander Lobakin)
> 
> v3:
> - mention problematic platform explicitly (Bjorn Helgaas)
> - improve comment (Paul Menzel)
> 
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)

Reviewed-by: Simon Horman <horms@kernel.org>


