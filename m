Return-Path: <linux-pci+bounces-15551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB0D9B4F8E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5962875D5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A801206E9E;
	Tue, 29 Oct 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8cfdqn2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5D206E9C;
	Tue, 29 Oct 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219849; cv=none; b=QiQHa5Z5QBHzWqUW8RwnP2NceB2HbJE8Hvah9l37VtpCqqpTLwiqGVsp5S10tM7irHfKyqmbOAp9qUHaBNO9q4xM16Rc4ULNZTLWUMMnyLt7NbzrS95Y2USDBKxtcP08ZHiw5iVv7uR112MmGqAA06yUV9EbWDGhg0bxyPMaKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219849; c=relaxed/simple;
	bh=+c1Cdp2Qi900fZqjndS23O6mVIhc4meucV2B7f/buwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HVt+T2rGvqXR76qzpt0Rv1Tmb0SjJNmyzE9vo8XA5vKI2UYKBDKxnS7mSakpxTZCGa+EmpJfHmRgnYdHGgy3xkuSVxjcgEkRqWpKdoR9gU9PwNwGBdT3sPm6Vdy+F7DVLB7p75i1yFSZKOPK3OejfZ3H7gL6w+9GdmaCmER/V0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8cfdqn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA672C4CEE8;
	Tue, 29 Oct 2024 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219848;
	bh=+c1Cdp2Qi900fZqjndS23O6mVIhc4meucV2B7f/buwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i8cfdqn2aPe1m9ln2zYoVTErh0Kw1KHNfuZ5S/3hOB9UE2e0sa6BuKuKlmHMDtEzg
	 lWYwq8m7wXzjT1kXCezx5QOeUOjxMAOx0ESgSUZlJvWXldcBRl4IRD2Q6Rdxh5AKok
	 +9vQrTHKaTeaVdlUqyWdqDPXukJSl/l4tNFkl71346FolwrskJrKc8EHHDQwyb/R38
	 aIxvLKKxtxP+5b6Fptjb1/8UeOAHFSgwFec7fliBifBKu4flptcZiz3jD9akqLk1nY
	 dLXgqHFKDzCJjwN5Z8DmvJDW3HENU0yedaAAqhcGH9wFtw8WIcJPFxkD98HpfNcU1F
	 k6YukU7CDsjKw==
Date: Tue, 29 Oct 2024 11:37:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steffen Dirkwinkel <me@steffen.cc>, patches@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH rc] PCI: Fix pci_enable_acs() support for the ACS quirks
Message-ID: <20241029163727.GA1162043@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-f96b686c625b+124-pci_acs_quirk_fix_jgg@nvidia.com>

On Wed, Oct 16, 2024 at 08:52:33PM -0300, Jason Gunthorpe wrote:
> There are ACS quirks that hijack the normal ACS processing and deliver to
> to special quirk code. The enable path needs to call
> pci_dev_specific_enable_acs() and then pci_dev_specific_acs_enabled() will
> report the hidden ACS state controlled by the quirk.
> 
> The recent rework got this out of order and we should try to call
> pci_dev_specific_enable_acs() regardless of any actual ACS support in the
> device.
> 
> As before command line parameters that effect standard PCI ACS don't
> interact with the quirk versions, including the new config_acs= option.
> 
> Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229019
> Tested-by: Steffen Dirkwinkel <me@steffen.cc>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Applied to pci/for-linus for v6.12, thanks for the ping.

> ---
>  drivers/pci/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2ae..225a6cd2e9ca3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1067,8 +1067,15 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>  static void pci_enable_acs(struct pci_dev *dev)
>  {
>  	struct pci_acs caps;
> +	bool enable_acs = false;
>  	int pos;
>  
> +	/* If an iommu is present we start with kernel default caps */
> +	if (pci_acs_enable) {
> +		if (pci_dev_specific_enable_acs(dev))
> +			enable_acs = true;
> +	}
> +
>  	pos = dev->acs_cap;
>  	if (!pos)
>  		return;
> @@ -1077,11 +1084,8 @@ static void pci_enable_acs(struct pci_dev *dev)
>  	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
>  	caps.fw_ctrl = caps.ctrl;
>  
> -	/* If an iommu is present we start with kernel default caps */
> -	if (pci_acs_enable) {
> -		if (pci_dev_specific_enable_acs(dev))
> -			pci_std_enable_acs(dev, &caps);
> -	}
> +	if (enable_acs)
> +		pci_std_enable_acs(dev, &caps);
>  
>  	/*
>  	 * Always apply caps from the command line, even if there is no iommu.
> 
> base-commit: dc5006cfcf62bea88076a587344ba5e00e66d1c6
> -- 
> 2.46.2
> 

