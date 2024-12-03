Return-Path: <linux-pci+bounces-17602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABC9E2E2C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5011A163EA6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19431AF0AA;
	Tue,  3 Dec 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpA20+yC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA1188A0E;
	Tue,  3 Dec 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261880; cv=none; b=MquaOKIJQ9ImOsVzUUPuIlRnwcHDOmz1AD0vNFnmr0DcBw6RisbtLoGPOUlxwJTNq9bWD1er4BZyFqqL9Tkxkr6ppjrtoGbDCoJ0gBHiICYQ9vdutuBFLqxnAFId9mAmai0p+uL+NGY2U4QvBcprJreHN+gG7T/G3TB9Toe+yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261880; c=relaxed/simple;
	bh=XBFQaREFd3Owz08VmeH9jFOt9uapxgHKrHwCVeQ3Iyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RK4DTf3Z9nrOdEKxFwSQP+U6AjJYcPNG0atnYXDgHmQUSF4gZ/kg5uZO3nxeNTk4W5tzg4LKoAA8XvWEXIiRsQj5mcn8wwYZJ5IkqWXYjvnPpwvvIi0VcFYtxIZkASR915H6jsKdCEhNURkI/y4VpgLwBm70i8ISeFQ5hYw6+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpA20+yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF1FC4CEDA;
	Tue,  3 Dec 2024 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733261880;
	bh=XBFQaREFd3Owz08VmeH9jFOt9uapxgHKrHwCVeQ3Iyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jpA20+yCupFH+by9DQN+HNaL2VFilCKVpwdeB0zxXDkArNlJO0SH4m1tIWCL8UjLP
	 +DMRAxJVdd1RcmQbIdMRLrzRtZsKNya4xCGuDhBQUA3DXEDwoSakX20cCLMoW6lGIP
	 owq8Ey8hdgvyErzQlfHfObnjOjIKQXuIk2oft1Fbtv5pCmLE9aUdbRVuw6LFtPeV0r
	 sm0zfW/Kz/M7Wv677/uqHVvXuI2G+iaOEA63apxrE1X1/cR628gW3EL55Vm5YGDfyP
	 PKVjt2Z2/KPZK/QN32QlH0MmRx1iCxmTXwC0iJ2fJ7MS98EwgoL5voytPlvgwndP/4
	 HTA/GKnUgg4iw==
Date: Tue, 3 Dec 2024 15:37:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Improve parameter docu for request APIs
Message-ID: <20241203213758.GA2966054@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203100023.31152-2-pstanner@redhat.com>

On Tue, Dec 03, 2024 at 11:00:24AM +0100, Philipp Stanner wrote:
> PCI region request functions have a @name parameter (sometimes called
> "res_name"). It is used in a log message to inform drivers about request
> collisions, i.e., when another driver has requested that region already.
> 
> This message is only useful when it contains the actual owner of the
> region, i.e., which driver requested it. So far, a great many drivers
> misuse the @name parameter and just pass pci_name(), which doesn't
> result in useful debug information.
> 
> Rename "res_name" to "name".
> 
> Detail @name's purpose in the docstrings.
> 
> Improve formatting a bit.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 12 ++++----
>  drivers/pci/pci.c    | 69 +++++++++++++++++++++-----------------------
>  2 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3b59a86a764b..ffaffa880b88 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -101,7 +101,7 @@ static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
>   * @bar: BAR the range is within
>   * @offset: offset from the BAR's start address
>   * @maxlen: length in bytes, beginning at @offset
> - * @name: name associated with the request
> + * @name: name of the resource requestor

What if we say plainly:

  @name: name of driver requesting the resource

I can tweak this locally if you agree.

