Return-Path: <linux-pci+bounces-7250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7088C01DF
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC376B22951
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B61292E9;
	Wed,  8 May 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGAB3kMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80837128801;
	Wed,  8 May 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185321; cv=none; b=RrGh8bvIkbaFdRKbW0rcbKyjgJw+ZI4MML56AR3m3tdGK/lVBji2tDuUwTq5u5aOCHix0LIhdYm0tTMg07AOjyWxuErP7sA5HbX63a+sMWTLuQ+R0mN5JHvm0jaAgqlnR3tvK2KSmvUAcl0me3N/ri+lSIQE0T3qXhP3QZG/+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185321; c=relaxed/simple;
	bh=IPjypEyMF7w+4uwKDEkSvt83JFezjeRn0o6vAzqV3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dDjZVoY/n5s/7s4glquoqrPgIpTe9TWWsuDucCZPPYjc3SOg8ZkUCBguD9ZpeUfxZIkoUQEsLvNs68Z6bNLtrHVgEGXbkvnnfxPhmzx/A13i2AZh4kcg1H5TKmDYYuL7G3UMZF1PxVjQIDTdZQY0veq08yYHL/SPrMIg/W3wJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGAB3kMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89BFC113CC;
	Wed,  8 May 2024 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715185321;
	bh=IPjypEyMF7w+4uwKDEkSvt83JFezjeRn0o6vAzqV3ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kGAB3kMvDmYyuyDaT9XRqZMjch9CKO4IMFzWBNCDEzNj9Ox3clK2m9d4UjETQeUJj
	 3A2Bw0/bCVf0VTWINo+PdezJvyN8XIxdeV735h4GeMa8M1mtMfMX3MY3QvqYtAnk1o
	 jwDi4vRiufXXNVIz9sYbgFIhgk+IJGFANwOPCAgBbg527LumeGIuQeVUbsqXuOfdqi
	 xeXSSDggklcIisApSoZJfvchy2bl4g7NpP0diMWSUaGDEM46TEdi596fZQczdGnh2d
	 jJR8uqPC7dUssmARO5c0rfa8XQwjWJ6Lv8xJvIekiP3xP7WRY6E0sX7SQfelpBcYWF
	 Ts3HUJPdfiEAQ==
Date: Wed, 8 May 2024 11:21:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Make pcie_bandwidth_capable() static
Message-ID: <20240508162159.GA1769860@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507121758.13849-1-ilpo.jarvinen@linux.intel.com>

On Tue, May 07, 2024 at 03:17:58PM +0300, Ilpo Järvinen wrote:
> pcie_bandwidth_capable() is only used within pci.c, make it static.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/misc for v6.10, thanks!

> ---
>  drivers/pci/pci.c | 4 ++--
>  drivers/pci/pci.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..23fb5d6c25b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6065,8 +6065,8 @@ EXPORT_SYMBOL(pcie_get_width_cap);
>   * and width, multiplying them, and applying encoding overhead.  The result
>   * is in Mb/s, i.e., megabits/second of raw bandwidth.
>   */
> -u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> -			   enum pcie_link_width *width)
> +static u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +				  enum pcie_link_width *width)
>  {
>  	*speed = pcie_get_speed_cap(dev);
>  	*width = pcie_get_width_cap(dev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..fd44565c4756 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -293,8 +293,6 @@ void pci_bus_put(struct pci_bus *bus);
>  const char *pci_speed_string(enum pci_bus_speed speed);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> -u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> -			   enum pcie_link_width *width);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>  void pcie_report_downtraining(struct pci_dev *dev);
>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
> -- 
> 2.39.2
> 

