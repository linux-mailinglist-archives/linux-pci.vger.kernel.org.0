Return-Path: <linux-pci+bounces-5975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A3189E4AF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829961C20F93
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194D158861;
	Tue,  9 Apr 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCmXK9w8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1B15885E;
	Tue,  9 Apr 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695905; cv=none; b=PiNDIQYZ8fJpUhJ++eQ9/AxiL8Ndw1Vk5YwfUGo/jl3M7M+vFn8zsFHebT5rQkBC+mmCzmDRNYDvYbp+8E6xWetIwUYXI5THIaWEsGm7GTY1xmGniqTywmoF5wCE88EJFsr8Kpns5+k/UOLd4Yzjdjl+IeIBMppiP5GSXcqurfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695905; c=relaxed/simple;
	bh=DFYamkTUiKJCDN84G+HDkI8zC4pAoOFajfa9annO4DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncymG8f1k0scUjacedfiHBSc7LrV7uGXF63LaSRhVHUV6xh2pJ0MpFsjo/4VfzTmlvjOCSYzE6WrpiHr96se6zaOZco+2egA4QJRfKZDgyiGH1vBo5A6L6Gy7x03FFTbba6twV5x0301L4/sGrfo7IdiJWYW8cX9kwQlQ4kmC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCmXK9w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D842BC433C7;
	Tue,  9 Apr 2024 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712695904;
	bh=DFYamkTUiKJCDN84G+HDkI8zC4pAoOFajfa9annO4DE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GCmXK9w8u7fnZDGqoG6kdvjEGSmoWw+dPpoo+VGoeFKGAPXM6ZwOIisdcG2x37tqb
	 lefuEnMWDMsfmi+FapR4StYZFjwJ1tIun7Mf6qwGoG4a/KQjcoHGhWUJx1FC2BJIMi
	 P7ABxhC/g6hTleIV32zBPb/qMdx+f6dHrPP37wZ3dDHbhzCpd7KcmuxbUWQLBzQLmY
	 T3c737m6fMFWjVSkKKRzOmt2bFSEFylV4yKohMqOy8yOjSiuzFrFTIQ8K46FoJ89mB
	 u5C/yMH3ssMLHRJiBdNYefuUxD0kAjOhNn3FnzpS9EQtL3QV+KRXocgVfsa35paawP
	 JSbcygcAp5PDA==
Date: Tue, 9 Apr 2024 13:51:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann
 <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409135142.692ed5d9@kernel.org>
In-Reply-To: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
> This patch set includes the necessary patches to enable basic Tx and Rx
> over the Meta Platforms Host Network Interface. To do this we introduce a
> new driver and driver and directories in the form of
> "drivers/net/ethernet/meta/fbnic".

Let me try to restate some takeaways and ask for further clarification
on the main question...

First, I think there's broad support for merging the driver itself.

IIUC there is also broad support to raise the expectations from
maintainers of drivers for private devices, specifically that they will:
 - receive weaker "no regression" guarantees
 - help with refactoring / adapting their drivers more actively
 - not get upset when we delete those drivers if they stop participating

If you think that the drivers should be merged *without* setting these
expectations, please speak up.

Nobody picked me up on the suggestion to use the CI as a proactive
check whether the maintainer / owner is still paying attention, 
but okay :(


What is less clear to me is what do we do about uAPI / core changes.
Of those who touched on the subject - few people seem to be curious /
welcoming to any reasonable features coming out for private devices
(John, Olek, Florian)? Others are more cautious focusing on blast
radius and referring to the "two driver rule" (Daniel, Paolo)?
Whether that means outright ban on touching common code or uAPI
in ways which aren't exercised by commercial NICs, is unclear. 
Andrew and Ed did not address the question directly AFAICT.

Is my reading correct? Does anyone have an opinion on whether we should
try to dig more into this question prior to merging the driver, and
set some ground rules? Or proceed and learn by doing?

