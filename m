Return-Path: <linux-pci+bounces-12900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147C496F978
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D431C22065
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E411CFEA7;
	Fri,  6 Sep 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENRA7gF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1B322A;
	Fri,  6 Sep 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640915; cv=none; b=imNH/0VvyGU8sYmKEmjL0ke5XEi3f/TtvWsLpbqQWApcHKVWVYNWVNmkRETuPc4DTuA8erPwTI9jA3yob0hv6X90Y67BqyDYwo+gqEH/52ifL5CpVaKTZZ+eO7wrYkZSjqyij4++tPMxOuJkrLeEdYi8fnqr+RAJhDuNNB3RoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640915; c=relaxed/simple;
	bh=ma3hnzxa60ztBbJIoW3rnqm6FX0ewdR4paMGrgqonas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AYqPcG41AkfONUScq68YmKh8t1m7MfFp3vn1n+NWxndlNo962o9w42QRxCEbL+Zbh2fzwuE71TMy5g/mg59Q02IM3DjwrmJRRkvPflzIhiub5NKDMzNrWCg/ZPphvj64Qfk/oiu51fSZ9y3V36dkIS3rm74GuzN18COHPteZ1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENRA7gF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE58C4CEC4;
	Fri,  6 Sep 2024 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640914;
	bh=ma3hnzxa60ztBbJIoW3rnqm6FX0ewdR4paMGrgqonas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ENRA7gF3iYhhBcPiaQM50RMPcPrZbL+u5rjS/9moRZS9JDMlF2K6Z68NrN+AQe+MP
	 5L2PihgEim+8rK/VfTQqSx6OgbvnY5kYzX7c+73Lw+FRqRlOgeaB4DQNJzD0UXPT0i
	 Wy7SdLiUsHw/1IEEOTUUNcWigaH+RtvhPncDY67YjPfFCAlap0n2oK2l5sUnEGe3QR
	 i+pMmyg4F458sYxRSjKF3XW+egfn3GcgtM8YjKnfZYDxIgsOuz+fx9RsRNb6hfuACS
	 M58+7v2k3SUA1kUXS2quyHJwotJFfYRT+kzlLupFIU0BJVpuRgAX0TPBKsgWJlGwAQ
	 PxiUyMPtcBzaA==
Date: Fri, 6 Sep 2024 11:41:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: corbet@lwn.net, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
Message-ID: <20240906164152.GA424952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906124518.10308-1-abdul.rahim@myyahoo.com>

On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
> Fixed spelling and edited for clarity.
> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>  Documentation/PCI/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index dd7b1c0c21da..344c2c2d94f9 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
>    - Enable DMA/processing engines
>  
>  When done using the device, and perhaps the module needs to be unloaded,
> -the driver needs to take the follow steps:
> +the driver needs to perform the following steps:

I don't see a spelling fix here, and personally I wouldn't bother with
changing "take" to "perform" unless we have other more significant
changes to make at the same time.

>    - Disable the device from generating IRQs
>    - Release the IRQ (free_irq())
> -- 
> 2.46.0
> 

