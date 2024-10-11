Return-Path: <linux-pci+bounces-14329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235399A708
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10FA1F247BA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25567183CD5;
	Fri, 11 Oct 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIHEy4lp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45F405FB;
	Fri, 11 Oct 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658718; cv=none; b=ioxfcTahUuGYVZLK+S/FQ7nKgF1ljq4XmNlBa8X9gYcV25erIo7nUNwSGVmlOxjSDmQRC91bYMmpmA7EEkGDc7dhcNlLAZs9U8hxw/RyGd8wh9yNOHqYFK3IpZ4ClPxjF22O6VfxThiBYbWUSQm4YFRTXDijoS/WEG5IhuD28fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658718; c=relaxed/simple;
	bh=uAC1hsqraTaOFn/zr9dLVaQssrqC5CU+EZzISvIxio0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRqgmjpE7xx9Lj9J6WTRohoFBW7z/NinnXe00bwnaq4fWkHjn9wKq4KrO8LXhTvanu6pe2U8eTbv7mEoL/m9B7pM7OPuEk8CNy93Ww4YqqnWZnbRGPhistBaS+3wiDf4hGw7TAggg/Iyh8Pz63q+unrtLKxkvamWQhv0HCmkb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIHEy4lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE88C4CEC3;
	Fri, 11 Oct 2024 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728658717;
	bh=uAC1hsqraTaOFn/zr9dLVaQssrqC5CU+EZzISvIxio0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIHEy4lp246ggA2OYzvv+z9GX7D7xmeg948RSojVeXyWwNg5D33SKml5W5BNQcIOK
	 EMphgUffYqBHSKps4UB2VJ5tTb1eH/DDtjVjL1qtJWkDgcgInRraCXeUpej1VNtYlD
	 7CE3hdsF+3M+8d4bLoBC/hVh4KFcjC2rNr9yFgU2ls64I/I7keMNsKaMaBTH9+6WnY
	 KYHjnPCts0m7NhKOnH5q0kvhOdOR9kC54m2ZM4JBiFEXOj82ex/9Hm4U54KOjE3MWz
	 gpkqPnZSJU0Z4BrfF87E6zRRZL53zdSXuDcyKKDRhKppIN1ZWD6sHz1rZXTozpy+QX
	 yYemcmYg02ymA==
Date: Fri, 11 Oct 2024 16:58:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] PCI: Constify pci_register_io_range() fwnode_handle
Message-ID: <lvjupiwar2vy4v3ulracyi4jbyadj252odf7vhbdt2ij5fc7vh@rrsyabqsmci6>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
 <20241010-dt-const-v1-1-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-1-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:14AM -0500, Rob Herring (Arm) wrote:
> pci_register_io_range() does not modify the passed in fwnode_handle, so
> make it const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Please ack and I'll take with the rest of the series.
> ---
>  drivers/pci/pci.c   | 2 +-
>  include/linux/pci.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..4b102bd1cfea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4163,7 +4163,7 @@ EXPORT_SYMBOL(pci_request_regions_exclusive);
>   * Record the PCI IO range (expressed as CPU physical address + size).
>   * Return a negative value if an error has occurred, zero otherwise
>   */
> -int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
> +int pci_register_io_range(const struct fwnode_handle *fwnode, phys_addr_t addr,
>  			resource_size_t	size)

Either I look at wrong tree (next) or something is missing and this is
not bisectable. The fwnode is assigned to range->fwnode which is not
const.

Best regards,
Krzysztof


