Return-Path: <linux-pci+bounces-26054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0623A9138C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2174450C7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4321E0DE8;
	Thu, 17 Apr 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ8CNBrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F61DF246
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870079; cv=none; b=kL3/p/ISj4lG8wDBY/iauB88i9xxdW5XJbBdwcVIMf+ZnIGHBnPn4b8O5fL2KEA5pk+Ew/H/B2/djBRbEVQ14t/7IT5k2vljQIKLtYXkkYr6HdsmIPR3VF0nvNbss0F96I/c93UqfvLZPoAIS8vNXYsnVxt8MFAKLjuCSngQ3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870079; c=relaxed/simple;
	bh=OMu7tO35fvSf9J8kxaenGb0sj4L8jwiOy3D1lWxPt40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP2Xyd6lvs69BJ0sAf2I3f9V1dExA+gV9zjgijZ7Id4WbljAup4a0Sj5h+UBHbiSKY1yElMNNK0g3yVa5Mq6QnKT07alrqrtgL8SFuFpn28tp74W5SWbGuApwb7XKP7rvPC7mrhjL54yM+mw02wBRHIPNJTtSbEXsTs3DzAu3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ8CNBrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF15C4CEE4;
	Thu, 17 Apr 2025 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744870078;
	bh=OMu7tO35fvSf9J8kxaenGb0sj4L8jwiOy3D1lWxPt40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZ8CNBrGHNcho+tHZRAgQp07hL/utTImmqSoqG39q9fl/9EA2KRBmVAZHjsNR2v0m
	 NlgFZn0kHBD9IvP6cEuuloCUOZSpoZv8g2FJHF+ASGKUOhBFXDhMyu9oepD7NOGN2/
	 LZzx1AcFFTC8YrPjmMd+aZRUzZpuNj0REarTypEG+gz6ikZfQpJ8xigRYXnpmNLSRl
	 1rj9pZL07euG4eTFfas672ZXM83TmDFVCalxNsFrq7wTFoSqSWXamtQ0Yjl6Rn2tTw
	 beMdZU+IA52m6QyzTP2QhAua9RQcpmdEs9+4jgujQTEfxxjrPCYW5Eb2fbf1QiISMr
	 s1vP7vK5RIL2Q==
Date: Thu, 17 Apr 2025 08:07:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/3] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check
 from rockchip_pcie_link_up()
Message-ID: <aACaupQvmiiBE29l@ryzen>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

I just see patch 1/2 and 2/3.


Kind regards,
Niklas

