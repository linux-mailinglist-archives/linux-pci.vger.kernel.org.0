Return-Path: <linux-pci+bounces-11072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C709F9436D0
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869CC282660
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297841C77;
	Wed, 31 Jul 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqKkrrHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A1381AD;
	Wed, 31 Jul 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456129; cv=none; b=eMlXUJMPsLCQG7TLr5xhjbZ2Y3SQ4t3zafCUDkGbPBeB06fQ/IJd4Z0rj72AHMB8OPObLRjzFcNBtVDXcHSr7Zr8KDiDmlCgtBiBQo6xXTEuGEqIN8ifvHboVN0nQpo/JcnzgzCE2VyK+eydLw563XFsDww5i8syuUrqb+mLNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456129; c=relaxed/simple;
	bh=QFiLxSsKfiwzKnzdvA9UzCQ3GD7o2VslezEJoqA4HVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XI0ckh+5nVnwFabssXwEuzEEE0Ayn3tYbMi09FM/MI0ImG2l+3eGIU8WKtbj3USzBiq8kNsZ6vnCBkmsROdUV5GPvyQ1TTDEYTHfzR+81R3mBn/BdFv/XiEOnSCzOPiKtvet1KrWrJ9cW+NYNVEFxkyw7oqD2I93BqGPGv+QLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqKkrrHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0809EC4AF0E;
	Wed, 31 Jul 2024 20:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456129;
	bh=QFiLxSsKfiwzKnzdvA9UzCQ3GD7o2VslezEJoqA4HVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uqKkrrHtsuA7xZEi7vhRur/0faE0uJd2OvFgdmLOxw0jwyAeOyvOUWTPUupxnO+Rf
	 O8IKY2jfQ1bmISQrBjHJoAx6wy+C+z1/BEAbVPhnC62H/Gc0xUQyt/wihcu73mlQ+w
	 ANtaA+10Zd0/PGOU+B/DohQFrl6F/bE9hyq+xkvvIqs9VurmzXRqR6oiPKdi+/YugE
	 ObyNHYMpgN23K+C0g5wzyO6Q+uo9nBhruXxoGgwGQWq8kI3+OiNuwhgoPnhhXIuEuc
	 uq0lS0izmC9X14OgV+3Zyx6qizU86xXQd3Gq3V7HhfzOOcKOyg3PBvNiJ1U6WGITNi
	 4DjJif0hLTJSg==
Date: Wed, 31 Jul 2024 15:02:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Make pcim_request_all_regions() a public
 function
Message-ID: <20240731200207.GA78649@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731123454.22780-2-pstanner@redhat.com>

On Wed, Jul 31, 2024 at 02:34:54PM +0200, Philipp Stanner wrote:
> In order to remove the deprecated function
> pcim_iomap_regions_request_all(), a few drivers need an interface to
> request all BARs a PCI-Device offers.
> 
> Make pcim_request_all_regions() a public interface.

pcim_iomap_regions_request_all() is only used by a dozen or so
drivers.  Can we convert them all at once to consolidate reviewing
them?  Or are the others harder so we have to do this piece-meal?

> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 3 ++-
>  include/linux/pci.h  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3780a9f9ec00..0ec2b23e6cac 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
>   * desired, release individual regions with pcim_release_region() or all of
>   * them at once with pcim_release_all_regions().
>   */
> -static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
> +int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
>  {
>  	int ret;
>  	int bar;
> @@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(pcim_request_all_regions);
>  
>  /**
>   * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4cf89a4b4cbc..5b5856ba63e1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
>  				    struct pci_dev *dev) { }
>  #endif
>  
> +int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
>  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
>  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
>  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> -- 
> 2.45.2
> 

