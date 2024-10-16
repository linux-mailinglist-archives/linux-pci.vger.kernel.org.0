Return-Path: <linux-pci+bounces-14692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3649A12C5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7797B1F24536
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160A2144B8;
	Wed, 16 Oct 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq8Ex3+o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E9212EF9;
	Wed, 16 Oct 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107743; cv=none; b=SkdMd/jUWyr8IHZSsgbL3tNQltkt4laxBiz54s88b1RjV2OnlcNdHxM5D989x4wdvN/uuZ+YIkWZaeMkRw8JGFn8054u5RCPGm/CKCaNJbAG2CEwMZDchL8lK19OKDJ8WQl7bI1VzlCXOWHrput4nzpoWhtYBdpJywKps+8vS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107743; c=relaxed/simple;
	bh=6kuARo6R+izUJawqtMLy82AYZrt2UknikmPasItjF6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mttfPJyiWCNgPMFtoblmGwnxi7SDnVd8Ww6h8XgXA1t+NWUgour2jOZJMMYDy/BtDYBcFFME2vknQM3RTkX6PUQ0wkRn00bvkAoHNKlwdC9fxqnhNDKeLqOxlXfHXBGkSkEdko8lK1nqXn/UaviKgNRzasAOE/jp9Blh9SDquw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq8Ex3+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEAEC4CEC5;
	Wed, 16 Oct 2024 19:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729107742;
	bh=6kuARo6R+izUJawqtMLy82AYZrt2UknikmPasItjF6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kq8Ex3+oNplSkp/j91IAnz7zUnun8iysvY9K/o/bsFIcA/eCGuprEaNUXTR7Fk94k
	 i8tpKIZOauSyBdcDNAOYwDXqi4c5NuL8xbG6j+KaT5Mu9WcTMbsnOkN6HUq7xKluKs
	 WNIiUm5rVLPRGnmfLIIM6YZhAHxWMgg6ws/CVrKEDjRMZeKrufeD7ORj45ER4/++dN
	 EcTgrrqHYodO9P+b4g5AN3vvCo+5Y6XIf44wBnS7oL1uxYuBZOrzjwkqXugcFknfna
	 MaYnw8k3oCKLXaKRw2eBQHEFldHPIrtEEFeod3NsyyDNvYOTzY0zoII5qNXI9APyeZ
	 6+40M0W8VizgQ==
Date: Wed, 16 Oct 2024 14:42:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpqphp: Remove an unused field in struct ctrl_dbg
Message-ID: <20241016194221.GA646374@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551d0cdaabcf69fcd09a565475c428e09c61e1a3.1728762751.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 12, 2024 at 09:53:42PM +0200, Christophe JAILLET wrote:
> 'ctrl' is unused, remove it to save a few bytes when the structure is
> allocated.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/hotplug for v6.13, thanks!

> ---
> Compile tested only
> ---
>  drivers/pci/hotplug/cpqphp_sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
> index fed1360ee9b1..6143ebf71f21 100644
> --- a/drivers/pci/hotplug/cpqphp_sysfs.c
> +++ b/drivers/pci/hotplug/cpqphp_sysfs.c
> @@ -123,7 +123,6 @@ static int spew_debug_info(struct controller *ctrl, char *data, int size)
>  struct ctrl_dbg {
>  	int size;
>  	char *data;
> -	struct controller *ctrl;
>  };
>  
>  #define MAX_OUTPUT	(4*PAGE_SIZE)
> -- 
> 2.47.0
> 

