Return-Path: <linux-pci+bounces-18333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0759EFBFA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF391888F22
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454F188736;
	Thu, 12 Dec 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE1MtNIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD961186607;
	Thu, 12 Dec 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030033; cv=none; b=u7iHx9S22LLBVXmttdla//vnCIE/L3ZMpWBOGkvYdhiq8T+iQbiiIl/RNpn9z/+AXCWLxT/uu6ZyM08frZQ94Cv7+zE95/+YEhpWCi0OEExgBsqTN98V/J6YlLGfCfAgXMTOy2oNgaediZNc+M0cE0329GLm81yBj5glfEiUE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030033; c=relaxed/simple;
	bh=nI3HeDyiaBOWdnA+gdK1JW4Xj2fk3KgJbK4ZlB//e7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JUfsTk0kIOCyVYO7MCEDHgE7S6qDeKrl6yd72i/YPhoeKXKVMlujn3jWBHnc3qhmaHx/VsO1jGbYkKTKcugo+Ba0A58y9LEnZsKR/HrfPyIq46VW06ue88dUre+jPt5po02+50Y9sRk3QJYxZ4hVWmUX8oe1a2Bjm1fHns6k4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE1MtNIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3898CC4CED0;
	Thu, 12 Dec 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030033;
	bh=nI3HeDyiaBOWdnA+gdK1JW4Xj2fk3KgJbK4ZlB//e7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eE1MtNIqt2FyWrnRA1VUOPfVzI11qZXATbOno4b0zzdn3PqjV8lGZj/isgBerEZpl
	 4hrZST77HqvuRczo6Ur5dk5ayDOmkna/fYiHfIVCmn1C1kcXOh8hSVY4IUv6d7wORR
	 TvfGdiNaW2YvSuu7LUGpbMuQ8+stmlnBAUW3uPkC96kUnnBzQrf8j88wlX2Y3AXiSX
	 yBVbvmFIXivzQ2Ghj+St6RojXVbwcGBL3g2pjgM3kV331zLiAwnNBMUlUEp+y7P2/k
	 LDRJLNawZnexaiFK4dsDUwIOWqET85+3yvw9wH0IWL2WtLcTlxt+bGJvVPM6obTUAX
	 YVHjvpmOmf18A==
Date: Thu, 12 Dec 2024 13:00:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Replace magic number "6" by
 PCI_STD_NUM_BARS
Message-ID: <20241212190032.GA3356901@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212162547.225880-1-rick.wertenbroek@gmail.com>

On Thu, Dec 12, 2024 at 05:25:47PM +0100, Rick Wertenbroek wrote:
> Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
> include/uapi/linux/pci_regs.h:
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Applied to pci/endpoint for v6.14, thanks!

> ---
>  include/linux/pci-epf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 18a3aeb62ae4..ee6156bcbbd0 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -157,7 +157,7 @@ struct pci_epf {
>  	struct device		dev;
>  	const char		*name;
>  	struct pci_epf_header	*header;
> -	struct pci_epf_bar	bar[6];
> +	struct pci_epf_bar	bar[PCI_STD_NUM_BARS];
>  	u8			msi_interrupts;
>  	u16			msix_interrupts;
>  	u8			func_no;
> @@ -174,7 +174,7 @@ struct pci_epf {
>  	/* Below members are to attach secondary EPC to an endpoint function */
>  	struct pci_epc		*sec_epc;
>  	struct list_head	sec_epc_list;
> -	struct pci_epf_bar	sec_epc_bar[6];
> +	struct pci_epf_bar	sec_epc_bar[PCI_STD_NUM_BARS];
>  	u8			sec_epc_func_no;
>  	struct config_group	*group;
>  	unsigned int		is_bound;
> -- 
> 2.25.1
> 

