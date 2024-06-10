Return-Path: <linux-pci+bounces-8555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E214E9029A1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6509FB2379D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9E14D70A;
	Mon, 10 Jun 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVgK+WOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8336B65E;
	Mon, 10 Jun 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049788; cv=none; b=GCofUUNIhRPlKUDDl1cnYdgFaP19m+b9n+YxvVX7QaCIXag7nIFKZOr1RrNVe6nD2er+t8CfveoNhVcb8Guuxr7SckjD7rTP/knLjDgRQM7rNdy1VajfhggZP57jYXIoAqovWM/otePRLZPQvvnIsxt+r9M5i4E9juqyUmZLGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049788; c=relaxed/simple;
	bh=uKs48qqD0zG4ErGI0lxi3j4lZNqJDS9bqV+Q028LWsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AX23xZESYDkQZlepzGS2qIqTGs/LjTzywBdhapVwydqBh9z1lBMRYJ0q34BcFhB/smO2YzZr9Qb6RfGFrf6XMY1pIJfmHOt6XLM4Qm4haMiQ16va79UY1ymkQtvYGUA6iCm+CsUPCe9GRmQBEtz+7szYRJ+G3ihljPsS0RulK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVgK+WOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A8EC2BBFC;
	Mon, 10 Jun 2024 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718049788;
	bh=uKs48qqD0zG4ErGI0lxi3j4lZNqJDS9bqV+Q028LWsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KVgK+WOAjbFIy+XEK/2099I22db0C/rxcLGPKGg/U4gqdbTEYo3K9k30Y9gW0uiM2
	 S9RsUJ2VcG1fXI6rLO6KQ8eI58f9qvuWsS4S7+7y2aI80mWp0dGC8SxXfrzv1RjQZB
	 nwGmBJepwMZ8nS3ZE4nV8PvBi/reFWum6MQnl1CRkojQ3kcIrfkcF2oZa7rAyVJqDM
	 W8s+oK5ehpKF2fEiQahi1Gl8lwFqw1PHWW0OGppPNfG9pY21cX7qF5QErBvwWwFTvU
	 GC9LmLMQIyFq5WjU44uLDnC71Hz9+3sGMcLtCFmWpV+7YTg8QlHaCddKvqSon++D9j
	 1VD3ZVqc4kV4w==
Date: Mon, 10 Jun 2024 15:03:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan Synopsys DesignWare xData traffic
 generator
Message-ID: <20240610200306.GA957827@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610191848.955767-1-helgaas@kernel.org>

On Mon, Jun 10, 2024 at 02:18:48PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Gustavo Pimentel <gustavo.pimentel@synopsys.com> is listed as the
> maintainer of the Synopsys DesignWare xData traffic generator, but he's no
> longer at Synopsys, and nobody has stepped up to maintain it.
> 
> Mark Synopsys DesignWare xData traffic generator as orphaned and add it to
> Gustavo's entry in CREDITS.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/for-linus for v6.10.

> ---
>  CREDITS     | 1 +
>  MAINTAINERS | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 0107047f807b..7f26123146c5 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3149,6 +3149,7 @@ S: Germany
>  N: Gustavo Pimental
>  E: gustavo.pimentel@synopsys.com
>  D: PCI driver for Synopsys DesignWare
> +D: Synopsys DesignWare xData traffic generator
>  
>  N: Emanuel Pirker
>  E: epirker@edu.uni-klu.ac.at
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..6883761eb34f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6239,9 +6239,8 @@ S:	Maintained
>  F:	drivers/usb/dwc3/
>  
>  DESIGNWARE XDATA IP DRIVER
> -M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/misc-devices/dw-xdata-pcie.rst
>  F:	drivers/misc/dw-xdata-pcie.c
>  
> -- 
> 2.34.1
> 

