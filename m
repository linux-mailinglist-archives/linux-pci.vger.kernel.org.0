Return-Path: <linux-pci+bounces-41984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADDC8279C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EAB3AE0DD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D312ECEA3;
	Mon, 24 Nov 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpXzxBYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547F2EB873;
	Mon, 24 Nov 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018407; cv=none; b=W4TS3msXWGHO8c3V1mk7XQJjaJHeFn1THS1LQQguhzKHOw/BhLclnQZ6Jwx0bhSv19hyyvRYZMgNOcOWP0lsqsQlAKG2kNE7N7hTLy6LpbFewMpDXdvGGdfuCobnVOyA16ZvrDe/vRO5H7Ni4wsMqms8zyEvJfrHq+1Mf6v5gyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018407; c=relaxed/simple;
	bh=pJPhapjssGLiSd4/PSx3IRUr1Qir6/i4+CoYtzwCQmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZM9NsaqWtzJGl7rk3Ci1yvHKCSn6xC/cIoAD4XqGsOyz3Vf7PrIBFalrUjNbcjWVx9i0KqxGmXaNlzdowZ8qf4/t6vnMXkNuQ3LPwjOc1YYyfvB+4ck6PsRcGPD1uRxcaczKIZbohHuUNx+AHogYYhxQO3ln1LcuLoB6O1a8jA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpXzxBYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32279C4CEF1;
	Mon, 24 Nov 2025 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764018406;
	bh=pJPhapjssGLiSd4/PSx3IRUr1Qir6/i4+CoYtzwCQmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HpXzxBYI8R3FSDzJPlQ3yOzopI4btY2BEanI48/8wfYvCZYl9F+wJUrijXZjcQqyC
	 TkjpgnMTSDB7h0pvEcYO9xtJfXeEeheX8PbGeAPHOo4DhRRECWo+dblA4J6AKYeS0K
	 RKcCXJUsI5hgJNkeJOCRvduSvw4H1lR4CGO59Sj+EKdh+xt8CcJBPMr8p1qQAojgDe
	 jS7Sj7iT9shjfEglSZ3mY5a6OxJaUcZdf25qm+CW78MSk1BqQB4TfKyt5Q5DSkAd6e
	 VU7+mWbCj/ZlI+NMNy6ObwrULwFCxhueI/JuF9GfafvKDEd8dueM+rkM7PoDXm95hh
	 PPTifFxa+yVqQ==
Date: Mon, 24 Nov 2025 15:06:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add Manivannan Sadhasivam as maintainer of
 PCI/pwrctl
Message-ID: <20251124210645.GA2712285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120082747.10541-1-brgl@bgdev.pl>

On Thu, Nov 20, 2025 at 09:27:47AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Manivannan is doing a lot of work on the PCI power control. Add him as
> maintainer.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied with Mani's ack to pci/misc for v6.19, thanks!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59b145dde215f..549e51e57c4cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20100,6 +20100,7 @@ F:	include/linux/pci-p2pdma.h
>  
>  PCI POWER CONTROL
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> -- 
> 2.51.0
> 

