Return-Path: <linux-pci+bounces-6360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC598A87DA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7881F2290F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBFC15CD6C;
	Wed, 17 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZd8tV9A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D57148835;
	Wed, 17 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368199; cv=none; b=djc9hBbFDl+YrY1fvGeaqunUYgeInD4xSWs+DgkFvvv+yyjE3lufKzs0QCtsBDQ61XOci0NI+SNHQXojq6zrNdf43Vn5HDSZVm08xMA6CbdhuGCSAeH9uosmx0AAPC1in1MZXa30KzmGz17ZG8t5OB55Mkca8tt4YjxjTP+3Gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368199; c=relaxed/simple;
	bh=qxR8jusU4mHNUpoOFxqYhMZwDa711H7HwzT9JTySflU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K6iiwG20rU8rDLKUw1fNbfSpN5wlGYCfzcVM9Q/i8SYzlD9Kv2TyujTs5JP1ZaQu6KP8oxbRgtmU04Ng4a+bdxeWeKGYpuk/R3XK+CNccBJ0fCWRj+Sjapy6zNpjNzV5SSfjYS9fhmaCkyDPCv1Zn+JBgE9ESSY4qNm2nolc+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZd8tV9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06718C072AA;
	Wed, 17 Apr 2024 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368199;
	bh=qxR8jusU4mHNUpoOFxqYhMZwDa711H7HwzT9JTySflU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CZd8tV9ALGZxqh/MNfiq4/qelCfLFRO0yvGlCdCtpKqgQ5xSxeVs0HxbXfLbrowGu
	 /6vazQf+wR+RVZ3odbDTxvF8YIil/DM8au6C2ZWpAFkcSEsOU5BzBepSmzRYceO6hN
	 4Ip2oUX+N43mwXiIdArMicU07CS6KYKRfpkti+0yl4M6oHnzSbc62pj6qsnFT/KLLM
	 AiKfxP92njrJjgsQ7h315M9KzACeheUmVG4Mm8+Y8XB98v7HUyp/tISFB8/AI/Q1JW
	 GDgQMg+Rb5gDQrqu08b0n1MDprYpQL6UFYcLSOjO4yZSyaFFs1mMS+ovtm2D1mnBxa
	 uhkuxpSseLFzA==
Date: Wed, 17 Apr 2024 10:36:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v1] PCI/AER: Update aer-inject tool source URL
Message-ID: <20240417153636.GA203294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416055035.200085-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Tue, Apr 16, 2024 at 05:50:35AM +0000, Kuppuswamy Sathyanarayanan wrote:
> The aer-inject tool is no longer maintained in the original repository
> and is missing a fix related to the musl library. So, with the author's
> (Huang Ying) consent, it has been moved to a new repository [1]. All
> references to the repository link have been updated.
> 
> Link: https://github.com/intel/aer-inject.git [1]
> CC: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Applied to pci/aer for v6.10, thanks!

> ---
>  Documentation/PCI/pcieaer-howto.rst | 2 +-
>  drivers/pci/pcie/Kconfig            | 2 +-
>  drivers/pci/pcie/aer_inject.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index e00d63971695..f013f3b27c82 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -241,7 +241,7 @@ After reboot with new kernel or insert the module, a device file named
>  Then, you need a user space tool named aer-inject, which can be gotten
>  from:
>  
> -    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +    https://github.com/intel/aer-inject.git
>  
>  More information about aer-inject can be found in the document in
>  its source code.
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 8999fcebde6a..17919b99fa66 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -47,7 +47,7 @@ config PCIEAER_INJECT
>  	  error injection can fake almost all kinds of errors with the
>  	  help of a user space helper tool aer-inject, which can be
>  	  gotten from:
> -	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +	     https://github.com/intel/aer-inject.git
>  
>  config PCIEAER_CXL
>  	bool "PCI Express CXL RAS support"
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 2dab275d252f..f81b2303bf6a 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -6,7 +6,7 @@
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> - *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> + *   https://github.com/intel/aer-inject.git
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>
> -- 
> 2.25.1
> 

