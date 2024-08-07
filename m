Return-Path: <linux-pci+bounces-11457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BA694B116
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3531F21EE1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5D145B16;
	Wed,  7 Aug 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6vNrSRw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CB14535E;
	Wed,  7 Aug 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061769; cv=none; b=l8ELbI6jHKJ+39ZfPuQBiWXpV36HMnBZXNfRUwzR1TGXhqsFKP6I1onTRpCOK/3b5TkETJRlvcOo6Hko9CBWvcwPeBjUf9a6GhBlwBFqOdDTsUaGX1izuDR9q5T+9gilxjeHOpyImBE9wnYOjbw+vnDSAfkeBeFzGNfKxLXZsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061769; c=relaxed/simple;
	bh=7/OqWItGPKI+OQj8DnkDipK910zUpsiUMnfkGAvKhj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jkaHk+lBS5W1SKr2px6+ki75AL8tCCFij9HEpB17rhwX+AfitJerX5VYPBaMJFjoDMuNs1dzYjIV8/2XVDaiGaczc9zo7de8C4j1qQNkQI8XcUaZhVf6WSB8Uj913RT9rLTOLY55kqlSAQ5fJAnNNHpkJCUNgTActucNZLdgTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6vNrSRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E5AC32781;
	Wed,  7 Aug 2024 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723061769;
	bh=7/OqWItGPKI+OQj8DnkDipK910zUpsiUMnfkGAvKhj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D6vNrSRwJ6aMsuhPmuTj0mg2dUCuk21SY8Y7L+p2LHXcXlBlkljr3ej8+yJo3tdzb
	 P5fXJ9T4rlXO4SGEoB3dUtoi6Dv5PzxEXRP8rIV8PdDYdO3glZfn+LMdgWAOA2e86N
	 gN0gnxfBuoG6vDEM0mHBO0yuzUMm1iLReXBShkCDoOTQBUgOch2ZmFPSuoJph9oIFh
	 hquq65b7AYTAQg3FG+OoqXhhJh2UWXop9tR9S/ILGogkP2IgbzgghvU0UJoV30wAP3
	 iVNezflE2DmH4LnqVZW980UvFhf3aEj9JKVXO2/EDQZYB/5dVa66CRWVd/0aRc5QIf
	 0XBx+VfHdogbA==
Date: Wed, 7 Aug 2024 15:16:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ian <4dark@outlook.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Adjust pci_sysfs_init() to device_initcall
Message-ID: <20240807201606.GA109435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM>

[+cc Krzysztof]

On Wed, Aug 07, 2024 at 06:34:34PM +0800, Ian wrote:
> From: Ian Ding <4dark@outlook.com>
> 
> When the controller driver uses async probe
> (.probe_type = PROBE_PREFER_ASYNCHRONOUS), pci_host_probe() is not
> guaranteed to run before pci_sysfs_init(), kernel may call
> pci_create_sysfs_dev_files() twice in pci_sysfs_init() and
> pci_host_probe() -> pci_bus_add_device(), and dump stack:
> 
>     sysfs: cannot create duplicate filename
> 
> Signed-off-by: Ian Ding <4dark@outlook.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc..bef25fecb 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1534,7 +1534,7 @@ static int __init pci_sysfs_init(void)
>  
>  	return 0;
>  }
> -late_initcall(pci_sysfs_init);
> +device_initcall(pci_sysfs_init);

This is certainly a problem that needs to be solved, but I don't think
this approach is necessarily safe.

There's a long discussion about some of the issues at
https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/t/#u

The goal is to remove pci_sysfs_init() completely, but we haven't
quite got there yet.

Since that thread, Krzysztof has made great progress by converting
most sysfs files to static attributes, e.g.,

  506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
  d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
  f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
  527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
  e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")

but there are still a couple things left.

>  static struct attribute *pci_dev_dev_attrs[] = {
>  	&dev_attr_boot_vga.attr,
> -- 
> 2.25.1
> 

