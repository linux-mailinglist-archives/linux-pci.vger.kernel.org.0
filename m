Return-Path: <linux-pci+bounces-32955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F57B12522
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 22:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1A0AC80C0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFD254846;
	Fri, 25 Jul 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyelXsIA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7A25394C;
	Fri, 25 Jul 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473954; cv=none; b=ZG6gof6eLu9QwUQvB+/uBT8wYspmZckGK0yAac0ak1GkFEfB0gyFVy4nu+ROp3THExpb16CKoKCAtjfuXJmqSgY5a4WN7lfyuk0HrnOY6JAZK5pALNWoNtO94Lswx5d8562YN9TOCxk6y1Wqpk4C+uuKR73et0jQHXcn+W+ZFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473954; c=relaxed/simple;
	bh=g2WzQFr3XlSVhxYsYXEJidrp/xLBxEV9BriIPkl2wlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FbiwuRrPPAWX0o8h26XHqOtNXYDpdKz1ofIXs8KBNijxtfKaMBmEYjXnGfeEBgy7YPKbrLZ0MnkCkmtJF5vHjFQwOLtGpXAVvqyPgw4Wsa4SpL17JJBNU4wjT+rzIhBr6FSXU+DVpdPivOrj/j7/u2Xmaz/iZq0Bqo/8e+5AZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyelXsIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7625FC4CEE7;
	Fri, 25 Jul 2025 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473953;
	bh=g2WzQFr3XlSVhxYsYXEJidrp/xLBxEV9BriIPkl2wlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LyelXsIAUkSDgayHx5WlSCn2IBr/53eET/KOcNlrb5ifj0YBxd8gUiDNgCXfFiO6u
	 Tvcro6wVSNlw6hjmYXZncX+QdUwGMEJkGgkDlsbpMjOuJaxuwlHl71OKaKcUY/SfHI
	 cq8z9DDb8SDhmOnsWGsp960SJTuJH0LhLOKz4WGC4gjQ1PzKI3n8Ocm1ZuWf5X0Z9O
	 kr7J81Sje3Px4SZo/pELyDK3gOK0i+ifJhjE3tB31GNCEuyMH+Ne+2p2U9j6w5QUPd
	 2Vrpe6R6AjzQOm+CXPguxSTekXrpHQIJfxJuHlja3ZMR7bAJm7hX/s09J8z3+WyJH1
	 DOaFSsez2mxEg==
Date: Fri, 25 Jul 2025 15:05:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Hans Zhang <18255117159@163.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jiwei Sun <sunjw10@lenovo.com>, Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix out-of-bounds stack access
Message-ID: <20250725200552.GA3111469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725090633.2481650-1-arnd@kernel.org>

On Fri, Jul 25, 2025 at 11:06:28AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added PCI_FIND_NEXT_EXT_CAP function calls a helper that
> stores a result using a 32-bit pointer, but passes a shorter local
> variable into it. gcc-15 warns about this undefined behavior:
> 
> In function 'cdns_pcie_read_cfg',
>     inlined from 'cdns_pcie_find_capability' at drivers/pci/controller/cadence/pcie-cadence.c:31:9:
> drivers/pci/controller/cadence/pcie-cadence.c:22:22: error: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Werror=extra]
>    22 |                 *val = cdns_pcie_readb(pcie, where);
>       |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'dw_pcie_read_cfg',
>     inlined from 'dw_pcie_find_capability' at drivers/pci/controller/dwc/pcie-designware.c:234:9:
> drivers/pci/controller/dwc/pcie-designware.c:225:22: error: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Werror=extra]
>   225 |                 *val = dw_pcie_readb_dbi(pci, where);
>       |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change the macro to remove the invalid cast and extend the target
> variables as needed.
> 
> Fixes: 1b07388f32e1 ("PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Squashed into that commit, thanks, Arnd!

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2502a619108b

> ---
>  drivers/pci/pci.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index da5912c2017c..ac954584d991 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -109,17 +109,17 @@ int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>  ({									\
>  	int __ttl = PCI_FIND_CAP_TTL;					\
>  	u8 __id, __found_pos = 0;					\
> -	u8 __pos = (start);						\
> -	u16 __ent;							\
> +	u32 __pos = (start);						\
> +	u32 __ent;							\
>  									\
> -	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
> +	read_cfg(args, __pos, 1, &__pos);				\
>  									\
>  	while (__ttl--) {						\
>  		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>  			break;						\
>  									\
>  		__pos = ALIGN_DOWN(__pos, 4);				\
> -		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
> +		read_cfg(args, __pos, 2, &__ent);			\
>  									\
>  		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>  		if (__id == 0xff)					\
> -- 
> 2.39.5
> 

