Return-Path: <linux-pci+bounces-3261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B784EB12
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 23:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92C31F224E1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98364F5EF;
	Thu,  8 Feb 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCrHwv+l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913384F601;
	Thu,  8 Feb 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429723; cv=none; b=gowPVHVqHeVcLat4Qg3zjxOtNnMH0wOMPrq6lS+iZv6+S5CQ4QInVBbKJGVmjsLQT20CrOu8S8Kk9a1n2L/t1ntLHB7BmOtv2Mu0zTUSb2oahVgsYk+jovIWGIf8ciuvb8/S/ApULNrp5C4M6I+Z0QvCQJjQxbtzjMQsz2DuaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429723; c=relaxed/simple;
	bh=51zhCU+hWU/GXYJG/dlGZH1DFkMa0Z8FeHW08IHlo9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M/no5cDDV/zYWvvpjMYSyD3S5+KXVfLqvdRb1w79jKpRw+fvDnD33YwwzOIBTZlEsxKAFeq5TQRGTnMSRtjt4ZUR+WsGqiOQMYkqiZKtMCNbKE4Y6dCoBe23saPVDHYg3cvE+WQVGxFA2ALBe+dfoKP4AlhYgzvdxf0qcCy9sh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCrHwv+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52D4C43390;
	Thu,  8 Feb 2024 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707429723;
	bh=51zhCU+hWU/GXYJG/dlGZH1DFkMa0Z8FeHW08IHlo9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dCrHwv+lDZFL0m+4iWHQvgV9D7FWwuHtx9vKhwjSe70u+CqElDLO9SmX+FmkfGL+A
	 6TXKRwi+Zg7hnY6Df6vms9bKKJw6Gku7kuyMqTcl8GKsvoVdYjUuO4VxoJYH+5C9kd
	 JHu8z855NAymSwSbwRWcsM8Fd6F00+r3P9cvUYtHY0Mf1ypNJHTqElqs2grAMXyeYj
	 /BtRbrN44a+ny7V/3h/D5cYlkE4q0EiFLYE+conojF5jc7wrtYVuh4ZNPx77mHoum4
	 BRj5NNwCiWK5BbrNgcHonSxkRXBjLCIWzNHUb3hznX4R9ahxN7H6Z/KKQW2gyrO8Oz
	 tfTFxHr0VwhjA==
Date: Thu, 8 Feb 2024 16:02:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH kernel 4/4] pci: Define Integrity and Data Encryption
 (IDE) extended capability
Message-ID: <20240208220201.GA975089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060228.3070928-5-aik@amd.com>

On Thu, Feb 01, 2024 at 05:02:28PM +1100, Alexey Kardashevskiy wrote:
> PCIe 6.0 introduces the "Integrity & Data Encryption (IDE)" feature which
> adds a new capability with id=0x30.
> 
> Add the new id to the list of capabilities.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> 
> This only adds an id. The rest is here:
> https://github.com/aik/pciutils/commit/ide

We can add this #define when we have need for it in Linux, so let's
hold it until that need appears.

> Not sure how much of that we want in the Linux.
> ---
>  include/uapi/linux/pci_regs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e60b4df1f7d9..b8d447b2c793 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -743,7 +743,8 @@
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption (IDE) */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> -- 
> 2.41.0
> 

