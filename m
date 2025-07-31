Return-Path: <linux-pci+bounces-33255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D1B17623
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A80358127F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE312244683;
	Thu, 31 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAtUgPYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF0189F5C;
	Thu, 31 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987186; cv=none; b=qQ0whBruHjgFooXyp4a0kYBYqvP9fT3HngsIGCcadTuxmC8ZkJOqxZHspqQTiYR/PInZrARUfQERPC3bSXnNny1IDMTE9gX2zwn3DgsmHJXGrZl2Nk1T+1jAUYstuYHhU37NhqwMAVjWi4MaIa/SaUCslTvhNxeV8PUffOYUFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987186; c=relaxed/simple;
	bh=5fw3ei2yI3vTaXizsPz3XqYTiDEdgvZfCsRY6Bk+K2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nV368PxCuhJ5l9wsDt4Y9NQIs8q4Lp5tHQNvKcseGuvZZuSr/Fxx4SGxfjm3L6LCeD4L4VOgkgFQhmQ/9KGDaq4ZH2tIEmi/+EZ8t1MoLOnu5ezJQ5IOJjCYL/g1/lOM1bLG64uWpzP0g0yaV//I5/oKMcz0Z9Am9QAISuJd6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAtUgPYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B5CC4CEEF;
	Thu, 31 Jul 2025 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753987186;
	bh=5fw3ei2yI3vTaXizsPz3XqYTiDEdgvZfCsRY6Bk+K2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MAtUgPYsC7nckHguK5XMBl1TsjgtKdhivYob4fXL36qYn1R8ijruQOKV+zlG1/ESP
	 /Wxsca6F5NKVcJo5BcGg8S5ydVz2q0qfHCMNRetW4UDOP11Tr3H+ZHb7xHvPClOP/I
	 VL828sxH/jiIitooLtJrhRL5tE+RV9mKg/LKKBqfXxGvc0Tqos9Rqlecxhq+rLI7ks
	 DpX+oyKld+qkbcwHK32StJxTd8JM/y42lBOiyGp70bJef26FIVSpmdlfxxk5QrZ2cO
	 dfEMqDHq7JAuRH7N9kKDWnISadiEO9DP/wzTvln4QRClwF+LZkCSTkKKGF0haL7ifZ
	 mzPHluttlbGEw==
Date: Thu, 31 Jul 2025 13:39:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, schnelle@linux.ibm.com,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <20250731183944.GA3424583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731173858.1173442-1-gbayer@linux.ibm.com>

[+cc Arnd]

On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
> Simple pointer-casts to map byte and word reads from PCI config space
> into dwords (i.e. u32) produce unintended results on big-endian systems.
> Add the necessary adjustments under compile-time switch
> CONFIG_CPU_BIG_ENDIAN.
> 
> pci_bus_read_config() was just introduced with
> https://lore.kernel.org/all/20250716161203.83823-2-18255117159@163.com/
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> 
> Hi Hans, hi Bjorn,
> 
> Sorry to spill this endianness aware code into drivers/pci, feel free to
> suggest a cleaner approach. This has fixed the issues seen on s390 systems
> Otherwise it is just compile-tested for x86 and arm64.
> 
> Since this is still sitting in the a pull-request for upstream, I'm not sure if this
> warrants a Fixes: tag.
> 
> Thanks,
> Gerd
> ---
>  drivers/pci/access.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index ba66f55d2524..77a73b772a28 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -89,15 +89,24 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>  			u32 *val)
>  {
>  	struct pci_bus *bus = priv;
> +	int rc;
>  
> -	if (size == 1)
> -		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> -	else if (size == 2)
> -		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> -	else if (size == 4)
> -		return pci_bus_read_config_dword(bus, devfn, where, val);
> -	else
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	if (size == 1) {
> +		rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		*val = ((*val >> 24) & 0xff);
> +#endif

Yeah, this is all pretty ugly.  Obviously the previous code in
__pci_find_next_cap_ttl() didn't need this.  My guess is that was
because the destination for the read data was always the correct type
(u8/u16/u32), but here we always use a u32 and cast it to the
appropriate type.  Maybe we can use the correct types here instead of
the casts?

> +	} else if (size == 2) {
> +		rc = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		*val = ((*val >> 16) & 0xffff);
> +#endif
> +	} else if (size == 4) {
> +		rc = pci_bus_read_config_dword(bus, devfn, where, val);
> +	} else {
> +		rc =  PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	return rc;
>  }
>  
>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> -- 
> 2.48.1
> 

