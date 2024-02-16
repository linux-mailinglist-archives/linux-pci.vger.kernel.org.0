Return-Path: <linux-pci+bounces-3652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3F858915
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4608B1C22AD4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 22:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B413AA57;
	Fri, 16 Feb 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U94v4N+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D462CCBA;
	Fri, 16 Feb 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123494; cv=none; b=jDyUYtfkJ28VT3+BCNjNYpvQPHZ4VrCQetACOQ4QatFpRORsDOBetUBObMDB8Uj2IPZES1YUhVYpZZDYTHWIbPqVbFf+LSKrTM2wPDsRoLCpL6TzEgmoI+i4+I9IYsoKnV77wNbw7fy4WriBy2T3oVDsppeY8oua1mJv8sAyezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123494; c=relaxed/simple;
	bh=ebzWyA9KCvd4/2ym7L0ucxMuGnPyVAPrRAgYGleDQKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ak4RNPdEriWiSLY1FXSUOIJBlQ1AnotPbO2BU31vhHy6GYIDMViPJ+cp8/Wnj606AB50dLhluN1nqvcp9dUX6jUCNaCxgbrhT5M4ddBZiAFVtf0YF+oRae+KxbS2AArYJLBF6GtIh2AsqCWSvJ/KCyaDp7gE7rIqBuzSC4AF+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U94v4N+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA71C433C7;
	Fri, 16 Feb 2024 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123493;
	bh=ebzWyA9KCvd4/2ym7L0ucxMuGnPyVAPrRAgYGleDQKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U94v4N+13b+GRBqJO/Y6Q6BP2YWIAq+qa0hQ7B8gkMpOo3gMBdT8le4xdfvz10Qro
	 JLEm2nFvQYlNVtnuXx4uJmVjSl0T2hhokyUMi9dGMfhgN2Hpgps5eT3wOF+RM6x1NR
	 PtRQmshKnIWOqKQO8KsF0aa/uFj9CuRgXkiUAPlRq5tLI6cSrm7Ph+bBo6xGLtry/f
	 dCMcGMkG/1J2bo+l9Xr+Tr7vy6eEeIyJg5tInl89a96z3JAN7/1p6E5m8Sk6vhfirk
	 fpRRpmBW6lbZhc8OlM3HppaaRH/lSlTzQOgYCK29CP702grmIenwJhC8twqOFYytnt
	 8RDttmcghSrKQ==
Date: Fri, 16 Feb 2024 16:44:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, kishon@kernel.org, vigneshr@ti.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] MAINTAINERS: PCI: TI DRA7XX/J721E: Add Siddharth
 Vadapalli as a reviewer
Message-ID: <20240216224452.GA1360477@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216065926.473805-1-s-vadapalli@ti.com>

On Fri, Feb 16, 2024 at 12:29:26PM +0530, Siddharth Vadapalli wrote:
> Since I have been contributing to the driver for a while and wish to help
> with the review process, add myself as a reviewer.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Applied to for-linus, for v6.8, thanks, Siddharth!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7980e5b1ad..7d6a60002fc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16976,6 +16976,7 @@ F:	drivers/pci/controller/dwc/*designware*
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
>  L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.34.1
> 

