Return-Path: <linux-pci+bounces-29401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F747AD4C7C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA41787CD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08822CBE6;
	Wed, 11 Jun 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7eosn5/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7F229B1E;
	Wed, 11 Jun 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626598; cv=none; b=AeEkZkIYBaXBO4a4mFUi+TjV7GNgVRX+LrMXVht/FX2AeMBTPmGXfOlW8O20lYNeXmTgEGiq7q4xpCTvHTJtOUs9H+mZJTtDF07NivTMtbbIUtn89CNz+HiNqxmkdmQkp6vOmOC1Vr9ERVgnjtjXA4xk7l6prJSDcGbyQZOiBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626598; c=relaxed/simple;
	bh=74M2tcWIFJj6OJpIn4VhfvKz9T8+zkrsc6KVAk+I+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRlwcHgnekn3V1M12D/Sr9wg6EKAs89fqHNjjdvd+nsnozepjKZSQCe8FOF08zpPMkK4QAdU9920lgihqGR11ZBtYatl/wj/Eh8qsi9QbaiE2wg0wLPAGoNv8xKucXuXZuejctxmBRCXEFPt03HztYV9DQYx8A9tLMH8NV32whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7eosn5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E90C4CEEE;
	Wed, 11 Jun 2025 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749626597;
	bh=74M2tcWIFJj6OJpIn4VhfvKz9T8+zkrsc6KVAk+I+2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7eosn5/wYZir4ySnZUPAM4Gi7DH32U9MKNp29Fj5kk14aioa7bpUEvIKdDiMtr79
	 lYxzflphvY0XSxA4HUemT/g4WK5vvj/n0Dng9DaDf9J4d3spVm0FTtxFU9zeRQxTPr
	 Vn2K4EFu6or5Vx/81d80Tt6yVk3hWZQsrpIJaCfzeakLU0Vs896t7YwH/GTaOiUtVY
	 FcVypMqP1VO8odzSt5CKja43xXfxrqpp7nSb+azoOoQsQv8n1zLsEpzaWu/eehTlh7
	 TRyEZahx1NSXMvVAN+R6/DaI5a0nWtXFbpLe3qw8uxKuIlz1z0sktQ6Twq3cnlGbIj
	 hw0haTulRwVDw==
Date: Wed, 11 Jun 2025 09:23:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: grwhyte@linux.microsoft.com, linux-pci@vger.kernel.org,
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <aEku4RTXT-uitUSi@ryzen>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <aEj3kAy5bOXPA_1O@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEj3kAy5bOXPA_1O@infradead.org>

On Tue, Jun 10, 2025 at 08:27:12PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
> > From: Graham Whyte <grwhyte@linux.microsoft.com>
> > 
> > Add a new flr_delay member of the pci_dev struct to allow customization of
> > the delay after FLR for devices that do not support immediate readiness
> > or readiness time reporting. The main scenario this addresses is VF
> > removal and rescan during runtime repairs and driver updates, which,
> > if fixed to 100ms, introduces significant delays across multiple VFs.
> > These delays are unnecessary for devices that complete the FLR well
> > within this timeframe.
> 
> Please work with the PCIe SIG to have a standard capability for this
> instead of piling up hacks like this quirk.

There is already some support in PCIe for this.

For Conventional Reset, see PCIe 6.0, section 6.6.1, there is the
"Readiness Time Reporting Extended Capability":
"For a Device that implements the Readiness Time Reporting Extended Capability,
and has reported a Reset Time shorter than 100ms, software is permitted to send
a Configuration Request to the Device after waiting the reported Reset Time
from Conventional Reset."


For FLR, see PCIe 6.0, section 6.6.2, there is the "Function Readiness Status":
"After an FLR has been initiated by writing a 1b to the Initiate Function Level
Reset bit, the Function must complete the FLR within 100 ms. [...] If Function
Readiness Status (FRS - see § Section 6.22.2 ) is implemented, then system
software is permitted to issue Configuration Requests to the Function
immediately following receipt of an FRS Message indicating Configuration-Ready,
however, this does not necessarily indicate that outstanding Requests initiated
by the Function have completed."


Kind regards,
Niklas

