Return-Path: <linux-pci+bounces-3259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53C84EAFB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C98E289971
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E94C3D0;
	Thu,  8 Feb 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGctrAou"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3E4F885;
	Thu,  8 Feb 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429457; cv=none; b=nhRC52xEhp5orzJfc/dBqv9fxCthgtAzrCxdLaXHSHGTRhNSolNT6TdgQ4TGLYQDd8S8un8tYzfp7wmpUyWiktl4F+1vF/wu5Ubv5e+/xsr7YuEqg+5j2Ey+HHdhPjU7uNLPq55RKyUHZzHDfHDuFmhDftz1XoMboYU1Nn1ARqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429457; c=relaxed/simple;
	bh=HftUjZe8zdQu5bvekNzog4DkTT2SHRvwYBgyzTRkxJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GoTGNByGWHWWKxsLvXnzMf3ulam9MUBnutTC5aHW+wT4pikdgC+ezWNrhb7yJuj3pYZ0FrBqudYngSZnucfsndHLP3x1HnhNXBPZPSnh8DvK9eqh6+GA6QNgSsSAOp//F8ioIdAomg0R+/okkCAc87pWpK2bzdNy6DG8gqgrQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGctrAou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B6AC433C7;
	Thu,  8 Feb 2024 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707429457;
	bh=HftUjZe8zdQu5bvekNzog4DkTT2SHRvwYBgyzTRkxJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZGctrAou9JG5M6V0CymnRb6LFCt+WhxzPzRqTPws3CNX7O+wxt+yiZjjeMbZ9ucRk
	 smf5RObRDnHLuE8IpypO9vYQ/zt+l+VLdFzSpJ0OvY8/juyydBFnZ/1AVS+ieSKTn3
	 AU7C3GrhKSu6d5pftC0Hqc7Fm5k8AslMIXS767+nH1CQ/JHje+Fq6lrwWkb6XJAIcS
	 IHH7toapd2SYFlD/I2QOZ+GYD6mCgCeY5N5c39i78cnhuHufYEtmMdkD5mLUyG1GFM
	 4yOnCnqPfcuOs7GJSz/nFVrLSfPEqXFhWp7m3UO1MPS6PS8Rjm6ALsYem/1ZJ7T25W
	 9lo3puM0VveVw==
Date: Thu, 8 Feb 2024 15:57:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH kernel 1/4] pci/doe: Define protocol types and make those
 public
Message-ID: <20240208215735.GA974931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060228.3070928-2-aik@amd.com>

On Thu, Feb 01, 2024 at 05:02:25PM +1100, Alexey Kardashevskiy wrote:
> Already public pci_doe() takes a protocol type argument.
> PCIe 6.0 defines three, define them in a header for use with pci_doe().
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  include/linux/pci-doe.h | 4 ++++
>  drivers/pci/doe.c       | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..5c33f7dc978b 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -13,6 +13,10 @@
>  #ifndef LINUX_PCI_DOE_H
>  #define LINUX_PCI_DOE_H
>  
> +#define PCI_DOE_PROTOCOL_DISCOVERY		0
> +#define PCI_DOE_PROTOCOL_CMA_SPDM		1
> +#define PCI_DOE_PROTOCOL_SECURED_CMA_SPDM	2

So far these are only needed inside drivers/pci/.  I don't want to
expose them to the rest of the kernel via include/linux/pci-doe.h
until they're needed elsewhere.

>  struct pci_doe_mb;
>  
>  struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e3aab5edaf70..61f0531d2b1d 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -22,8 +22,6 @@
>  
>  #include "pci.h"
>  
> -#define PCI_DOE_PROTOCOL_DISCOVERY 0
> -
>  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>  #define PCI_DOE_TIMEOUT HZ
>  #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> -- 
> 2.41.0
> 

